Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10F77711686
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 21:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242928AbjEYSwZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 14:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243240AbjEYSuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 14:50:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2DDD1B6;
        Thu, 25 May 2023 11:43:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 409A260FAF;
        Thu, 25 May 2023 18:42:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA06EC433EF;
        Thu, 25 May 2023 18:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685040153;
        bh=KANjrqYJmSTGBbeoFYsxCQuIsKve9gSzXDt17UfzbK0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m1/mJdAkiz4np/xu4pwA4WJXxnnY61kKFtAI24T3pZ8U4EISobqcYuU22n9iklG/d
         z6zkQiRcJ5NzDCxKfPY3yTwuGLYvWuGueD0+iOqte4JXQFijLLOjccVLSPRtNGkbRX
         fhPNeGFg3US3hqhopG6LmfPei1RHu1YdwpUIAdFTcj/jIijOx9+1DjvJhwDdkOr6t+
         ROQtJlwfdklv/ctAucsNedJmAnTmQQM734VrlMvUc7dPeQAWPGs0Hm0gaoJezONGOu
         rimZnCWefAEjaiqykpVc56iL8xh55Kdsd/I6/1xsvneizdCPP7wSdF/7ITjsQZh0eU
         mqmuQtwT5Wv/g==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>, davem@davemloft.net,
        edumazet@google.com, pabeni@redhat.com, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 30/31] atm: hide unused procfs functions
Date:   Thu, 25 May 2023 14:41:01 -0400
Message-Id: <20230525184105.1909399-30-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230525184105.1909399-1-sashal@kernel.org>
References: <20230525184105.1909399-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit fb1b7be9b16c1f4626969ba4e95a97da2a452b41 ]

When CONFIG_PROC_FS is disabled, the function declarations for some
procfs functions are hidden, but the definitions are still build,
as shown by this compiler warning:

net/atm/resources.c:403:7: error: no previous prototype for 'atm_dev_seq_start' [-Werror=missing-prototypes]
net/atm/resources.c:409:6: error: no previous prototype for 'atm_dev_seq_stop' [-Werror=missing-prototypes]
net/atm/resources.c:414:7: error: no previous prototype for 'atm_dev_seq_next' [-Werror=missing-prototypes]

Add another #ifdef to leave these out of the build.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Link: https://lore.kernel.org/r/20230516194625.549249-2-arnd@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/atm/resources.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/atm/resources.c b/net/atm/resources.c
index 53236986dfe09..3ad39ae971323 100644
--- a/net/atm/resources.c
+++ b/net/atm/resources.c
@@ -403,6 +403,7 @@ int atm_dev_ioctl(unsigned int cmd, void __user *buf, int __user *sioc_len,
 	return error;
 }
 
+#ifdef CONFIG_PROC_FS
 void *atm_dev_seq_start(struct seq_file *seq, loff_t *pos)
 {
 	mutex_lock(&atm_dev_mutex);
@@ -418,3 +419,4 @@ void *atm_dev_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 {
 	return seq_list_next(v, &atm_devs, pos);
 }
+#endif
-- 
2.39.2

