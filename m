Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC046712561
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 13:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243010AbjEZLVS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 07:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242696AbjEZLVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 07:21:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D007F7
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 04:21:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 981D264F0D
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 11:21:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F60DC433EF;
        Fri, 26 May 2023 11:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685100074;
        bh=Mc6kybC+fpWNxrxERzGm8WrYbllfE0lyvj4/M0yt5BU=;
        h=From:To:Cc:Subject:Date:From;
        b=NGWgDQqQj4R4JwJ0pvRCHFComHmA06zEQA9VvkLhLtvU3TPxp21UJuM4VbDsql/8+
         y2i705ve6zviaQ8L33HTJPbB0COZZM1pcrIe6H18EmzfIS6FupZ/fu+479B44MmlzM
         kfkQIJVZT7HcarV6K8SP/SDXig9+MgiviUUMy0sNM+TLS6XW1BmWtgxhOuQVqWqL2q
         Vv70WDo5+6BRhXjxiIbRQJ8k/ZDr1XIyCKanDE2HHuRxd5qn5oZCBjIG8+9mvXnmKW
         kkFAYxSAmIKFtln4udmFVo1xe5X/cWTgpcwpnUvmB/RO9bfih/fs21UgoGLI7nVK+S
         dzp1f6wQni7SQ==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     "David S . Miller" <davem@davemloft.net>
Cc:     Jarkko Sakkinen <jarkko@kernel.org>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH] net: use umd_cleanup_helper()
Date:   Fri, 26 May 2023 14:21:02 +0300
Message-Id: <20230526112104.1044686-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
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

bpfilter_umh_cleanup() is the same function as umd_cleanup_helper().
Drop the redundant function.

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 include/linux/bpfilter.h     |  1 -
 net/bpfilter/bpfilter_kern.c |  2 +-
 net/ipv4/bpfilter/sockopt.c  | 11 +----------
 3 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/include/linux/bpfilter.h b/include/linux/bpfilter.h
index 2ae3c8e1d83c..736ded4905e0 100644
--- a/include/linux/bpfilter.h
+++ b/include/linux/bpfilter.h
@@ -11,7 +11,6 @@ int bpfilter_ip_set_sockopt(struct sock *sk, int optname, sockptr_t optval,
 			    unsigned int optlen);
 int bpfilter_ip_get_sockopt(struct sock *sk, int optname, char __user *optval,
 			    int __user *optlen);
-void bpfilter_umh_cleanup(struct umd_info *info);
 
 struct bpfilter_umh_ops {
 	struct umd_info info;
diff --git a/net/bpfilter/bpfilter_kern.c b/net/bpfilter/bpfilter_kern.c
index 422ec6e7ccff..97e129e3f31c 100644
--- a/net/bpfilter/bpfilter_kern.c
+++ b/net/bpfilter/bpfilter_kern.c
@@ -21,7 +21,7 @@ static void shutdown_umh(void)
 	if (tgid) {
 		kill_pid(tgid, SIGKILL, 1);
 		wait_event(tgid->wait_pidfd, thread_group_exited(tgid));
-		bpfilter_umh_cleanup(info);
+		umd_cleanup_helper(info);
 	}
 }
 
diff --git a/net/ipv4/bpfilter/sockopt.c b/net/ipv4/bpfilter/sockopt.c
index 1b34cb9a7708..193bcc2acccc 100644
--- a/net/ipv4/bpfilter/sockopt.c
+++ b/net/ipv4/bpfilter/sockopt.c
@@ -12,15 +12,6 @@
 struct bpfilter_umh_ops bpfilter_ops;
 EXPORT_SYMBOL_GPL(bpfilter_ops);
 
-void bpfilter_umh_cleanup(struct umd_info *info)
-{
-	fput(info->pipe_to_umh);
-	fput(info->pipe_from_umh);
-	put_pid(info->tgid);
-	info->tgid = NULL;
-}
-EXPORT_SYMBOL_GPL(bpfilter_umh_cleanup);
-
 static int bpfilter_mbox_request(struct sock *sk, int optname, sockptr_t optval,
 				 unsigned int optlen, bool is_set)
 {
@@ -38,7 +29,7 @@ static int bpfilter_mbox_request(struct sock *sk, int optname, sockptr_t optval,
 	}
 	if (bpfilter_ops.info.tgid &&
 	    thread_group_exited(bpfilter_ops.info.tgid))
-		bpfilter_umh_cleanup(&bpfilter_ops.info);
+		umd_cleanup_helper(&bpfilter_ops.info);
 
 	if (!bpfilter_ops.info.tgid) {
 		err = bpfilter_ops.start();
-- 
2.39.2

