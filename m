Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C0B16F765A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 22:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232752AbjEDUG0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 16:06:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232509AbjEDUEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 16:04:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5579A23A09;
        Thu,  4 May 2023 12:52:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4B86263834;
        Thu,  4 May 2023 19:51:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09D4BC433EF;
        Thu,  4 May 2023 19:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683229883;
        bh=rzjeKeowCbGPllUR3q0na0HaHnncPDtdCVcd0//OS6U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FthwCjwkLc7Ye6P4nhDhD70FCrpo+ywrNqkcAh/PGqbn/J9Gb+prxEddijqzMbd/t
         MikiuB/N1y3qpKJdCEefEwKyg2nAIO57uuWFWz4iCbg8AP8LjE0rdw+irB7+4pn62C
         2d4DXvwX9nCk/h/JI7FVUeen/FxLzzYr2QLQ5gineYe7jW85w4MrAUpj0yMZ5sPW3d
         HAbd8Tyz6NRSBE97nOZpMgAoObIuFhOg6RQ1qkoFPlhJnLvD5KqnCmvpTkqMbgTijn
         //AoO5tJDxt3DH1f7o+bmYQ5svpLf3R3eps8YAOiMFp2OkmN40o6+QthrqTsOy4p70
         VNgg4Rh4TIuzA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Hyunwoo Kim <imv4bel@gmail.com>,
        Gregory Greenman <gregory.greenman@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>, kvalo@kernel.org,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, avraham.stern@intel.com,
        benjamin.berg@intel.com, emmanuel.grumbach@intel.com,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 16/18] wifi: iwlwifi: pcie: Fix integer overflow in iwl_write_to_user_buf
Date:   Thu,  4 May 2023 15:50:38 -0400
Message-Id: <20230504195042.3808716-16-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230504195042.3808716-1-sashal@kernel.org>
References: <20230504195042.3808716-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hyunwoo Kim <imv4bel@gmail.com>

[ Upstream commit 58d1b717879bfeabe09b35e41ad667c79933eb2e ]

An integer overflow occurs in the iwl_write_to_user_buf() function,
which is called by the iwl_dbgfs_monitor_data_read() function.

static bool iwl_write_to_user_buf(char __user *user_buf, ssize_t count,
				  void *buf, ssize_t *size,
				  ssize_t *bytes_copied)
{
	int buf_size_left = count - *bytes_copied;

	buf_size_left = buf_size_left - (buf_size_left % sizeof(u32));
	if (*size > buf_size_left)
		*size = buf_size_left;

If the user passes a SIZE_MAX value to the "ssize_t count" parameter,
the ssize_t count parameter is assigned to "int buf_size_left".
Then compare "*size" with "buf_size_left" . Here, "buf_size_left" is a
negative number, so "*size" is assigned "buf_size_left" and goes into
the third argument of the copy_to_user function, causing a heap overflow.

This is not a security vulnerability because iwl_dbgfs_monitor_data_read()
is a debugfs operation with 0400 privileges.

Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
Link: https://lore.kernel.org/r/20230414130637.2d80ace81532.Iecfba549e0e0be21bbb0324675392e42e75bd5ad@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index 8915030030c4c..2f6bcf5e5ac0c 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -2831,7 +2831,7 @@ static bool iwl_write_to_user_buf(char __user *user_buf, ssize_t count,
 				  void *buf, ssize_t *size,
 				  ssize_t *bytes_copied)
 {
-	int buf_size_left = count - *bytes_copied;
+	ssize_t buf_size_left = count - *bytes_copied;
 
 	buf_size_left = buf_size_left - (buf_size_left % sizeof(u32));
 	if (*size > buf_size_left)
-- 
2.39.2

