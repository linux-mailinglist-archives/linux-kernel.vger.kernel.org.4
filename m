Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D910C6F7F8F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 11:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231567AbjEEJHc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 05:07:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbjEEJHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 05:07:30 -0400
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 617BE19423;
        Fri,  5 May 2023 02:07:13 -0700 (PDT)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4QCPvL3lxxz5B15h;
        Fri,  5 May 2023 17:06:54 +0800 (CST)
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
        by mse-fl1.zte.com.cn with SMTP id 34596cX0093745;
        Fri, 5 May 2023 17:06:38 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp02[null])
        by mapi (Zmail) with MAPI id mid31;
        Fri, 5 May 2023 17:06:41 +0800 (CST)
Date:   Fri, 5 May 2023 17:06:41 +0800 (CST)
X-Zmail-TransId: 2afa6454c7210c6-ea699
X-Mailer: Zmail v1.0
Message-ID: <202305051706416319733@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <davem@davemloft.net>
Cc:     <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSBuZXQ6IHNvY2tldDogVXNlIGZkZ2V0KCkgYW5kIGZkcHV0KCk=?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 34596cX0093745
X-Fangmail-Gw-Spam-Type: 0
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6454C72E.002/4QCPvL3lxxz5B15h
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ye Xingchen <ye.xingchen@zte.com.cn>

By using the fdget function, the socket object, can be quickly obtained
from the process's file descriptor table without the need to obtain the
file descriptor first before passing it as a parameter to the fget
function.

Signed-off-by: Ye Xingchen <ye.xingchen@zte.com.cn>
---
 net/socket.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/net/socket.c b/net/socket.c
index a7b4b37d86df..84daba774432 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -528,19 +528,18 @@ EXPORT_SYMBOL(sock_from_file);

 struct socket *sockfd_lookup(int fd, int *err)
 {
-	struct file *file;
+	struct fd f = fdget(fd);
 	struct socket *sock;

-	file = fget(fd);
-	if (!file) {
+	if (!f.file) {
 		*err = -EBADF;
 		return NULL;
 	}

-	sock = sock_from_file(file);
+	sock = sock_from_file(f.file);
 	if (!sock) {
 		*err = -ENOTSOCK;
-		fput(file);
+		fdput(f);
 	}
 	return sock;
 }
-- 
2.25.1
