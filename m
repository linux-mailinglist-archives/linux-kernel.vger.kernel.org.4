Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE01B7116AD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 21:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243423AbjEYS5B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 14:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243208AbjEYSy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 14:54:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6D7A3C3D;
        Thu, 25 May 2023 11:46:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 09FC26400A;
        Thu, 25 May 2023 18:43:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E13DC433D2;
        Thu, 25 May 2023 18:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685040231;
        bh=tsOJjx9ye5H/JgMqH0AWxKvBvRFygR5UUo7JVIXt4W8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H5FB3P+QHJgrXWWsS2b9WaX58xk0oAr0sWK5COGJdIAI8dlGQySfReTJ51JggJ3ZO
         9SC5swQELWNmd4e6yIF2SMSKWiF2jxTczHxBPpw9bXLa2omoMLTXeKeQB57L4bqh0g
         6derLWnuoD5gqLkzFZaABCdHu2xoJ6Kap2D372fkUhBmAZ6+x/JP4rTxK08uWyZaKu
         nR3G9EbRSrbEa4ubuNioT9feR3wJqdzi3T9FF73jbe66T8qD/zlIjmzQTH5H5KThuB
         hO1Ox4VSAR6ZHiClj/mPs+Gn+BcMxJgqbh4BOXRKhWKXj6wfLayZYX2q91jPHAX8N7
         f/etaoT6UhFVg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>, davem@davemloft.net,
        edumazet@google.com, pabeni@redhat.com, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 26/27] atm: hide unused procfs functions
Date:   Thu, 25 May 2023 14:42:35 -0400
Message-Id: <20230525184238.1943072-26-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230525184238.1943072-1-sashal@kernel.org>
References: <20230525184238.1943072-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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
index 889349c6d90db..04b2235c5c261 100644
--- a/net/atm/resources.c
+++ b/net/atm/resources.c
@@ -443,6 +443,7 @@ int atm_dev_ioctl(unsigned int cmd, void __user *arg, int compat)
 	return error;
 }
 
+#ifdef CONFIG_PROC_FS
 void *atm_dev_seq_start(struct seq_file *seq, loff_t *pos)
 {
 	mutex_lock(&atm_dev_mutex);
@@ -458,3 +459,4 @@ void *atm_dev_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 {
 	return seq_list_next(v, &atm_devs, pos);
 }
+#endif
-- 
2.39.2

