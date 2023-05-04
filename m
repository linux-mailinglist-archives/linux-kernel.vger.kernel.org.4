Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 220886F743E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 21:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231363AbjEDTtm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 15:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbjEDTtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 15:49:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 617B311636;
        Thu,  4 May 2023 12:45:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 40BAA63747;
        Thu,  4 May 2023 19:45:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2944EC433A0;
        Thu,  4 May 2023 19:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683229542;
        bh=1O3F3/9pYsjTL7/GnQJz4fXY0qr6PpzLAgIvLnj7u/Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m2ZsK1xEqlJ8PSiO1I5CXWyCd8sU6mVRNYGELZSJRo4Dk4xB88tSmYJo7QRoPp+jT
         FFSmFlMe03o61Fmz3UGpH0Q+oSJ3BRGfiM/+Ck4GSSr3Z3fmRxbzNHZHISraTsA5of
         uUBbcUUy6piw3JvaxQeZvq5o+dOPN+Bk1XDZXHx6k3jJpEQdbLTlTA48fDzXHgb85y
         rIW5JW9zIRzl1HhipoQL9EBT8y8TRNyTaLszIt+IsIed0bUEtHIha0rzeueCBfzRQ+
         u8/uf2F8eI6/VVp2VgCm8n1NZRMrcLDYd8zKjvK7zsmHYG62HNz8/nh1I3Jr9uGAY4
         vhutPeGPkbLdw==
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
Subject: [PATCH AUTOSEL 6.2 33/53] wifi: iwlwifi: pcie: Fix integer overflow in iwl_write_to_user_buf
Date:   Thu,  4 May 2023 15:43:53 -0400
Message-Id: <20230504194413.3806354-33-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230504194413.3806354-1-sashal@kernel.org>
References: <20230504194413.3806354-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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
index 0a9af1ad1f206..6d5d0d40477a6 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -2863,7 +2863,7 @@ static bool iwl_write_to_user_buf(char __user *user_buf, ssize_t count,
 				  void *buf, ssize_t *size,
 				  ssize_t *bytes_copied)
 {
-	int buf_size_left = count - *bytes_copied;
+	ssize_t buf_size_left = count - *bytes_copied;
 
 	buf_size_left = buf_size_left - (buf_size_left % sizeof(u32));
 	if (*size > buf_size_left)
-- 
2.39.2

