Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6C2A622E03
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 15:34:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231576AbiKIOeh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 09:34:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231329AbiKIOef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 09:34:35 -0500
Received: from out203-205-221-173.mail.qq.com (out203-205-221-173.mail.qq.com [203.205.221.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E1962E8
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 06:34:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1668004469;
        bh=5FPNvUDVnygnNIZLQn/nX4ESf6kHJO8O/PowCmiXrIo=;
        h=From:To:Cc:Subject:Date;
        b=QepxEicePqkiKr3ZGqAtObvLXLLRHf1yT+oBLCNzuhOyTNeL3e+0j7gcCA3flk6fz
         LD3x9/D+JupCumMuXoUl1RvGNrfHHKm/aoGJ7wWJCaoPFYb+C/hLsZGtbfZ2+d0B6N
         FLKx3EtposmY0WgCx6VKj9aKhZZL0A3ds3uUZpYA=
Received: from localhost.localdomain ([111.199.191.46])
        by newxmesmtplogicsvrsza2-0.qq.com (NewEsmtp) with SMTP
        id 89B3FE92; Wed, 09 Nov 2022 22:34:27 +0800
X-QQ-mid: xmsmtpt1668004467t6jr7zf75
Message-ID: <tencent_DF74099967595DCEA93CBDC28D062026180A@qq.com>
X-QQ-XMAILINFO: NH9s7OfyllRGoP/bX5ztaWlA46OR9F/isK6QAq11KSfp8LpRrHJuginpx9KjVr
         /xbZ0MELzderPjctl6Jt3kxFHEpG10/oG3Wn0WLTwZoVRyvU43kGw0QSAbwd6tLdGV88dMmdFIXV
         xmqnqGq+uLWvzDvYovuMzDOpiRUPjnTmwc6F5kaGlRTF43kKLljpQoDCNl/dg7gM3MjXcP6p0hio
         F/3/QXYakfkNtexG7aUbEfzfCNZLK7Mvd2qk66Z4yBo0f/EkeSXDd5WZjhRYHEbDR7JE/ynoqbs7
         /TnNnk8Py+dS1ylApoHZqdiHmrHEK9Ds/uqqx2d2fXK4WhUck+EoPDVkP7U0xPCZo4pOl1Elz8LP
         s4mWGZR4RPv730AZWZlOv65cXhLnS0bigBwP+jUA0ZGyttpeU0eMHlSGWcFZRobc2YrCkyAwKQ4f
         iC1Ky5PslDO/+Dlp7Ik5HajCO8I6yETnGdUWXZbyj2NXWmn6MIoMO5HGCRnBXzIyA4xHM3J8JJO2
         hY595VvM1YT6R1imTTXeqN64oh+gBaXDyL4iX2B+g4heCpwCvbK9ZqD3BWA7aEZQVQOlpdteXmyX
         WS+xzP+tlvEDXyPvNIfSY5oISY/l2EVWZZz96iVtA2aGeRe/tyzZr82GhLjsA+Iqokl2kjlwI7as
         EyzVqGe6DHG+rj20CmQsRmhLO1fcf5vqVdg30ACijPWFMCoqldA2qG8Nr/M/IFEjoUU5Jl5FvWEw
         aBRvFW4v6ZGWnlXd84/Ppas/8o5qxtJ/NfqJ1ezM6asQzzwzabHteWfhLEjex/ujHDJusOBJV0PA
         oXUh4KgG30kkfYh81vEvuaO330LyxotCx7BAtIfcR53/s6J4IwWgQ7xVCyRCZcjmO0cfXETrdHHk
         dlsbZb/SXE9Q9T/NYMkTYwHMVHxnJJ4H2PXB0cTOZgt/cN4UUu8AtYJGY40aODhQs4RwgoBASIL+
         2Q0yEt/gx8R8uEGF+eOwT1Nv3hFgPULFgdT7SUxZU=
From:   Rong Tao <rtoax@foxmail.com>
To:     akpm@linux-foundation.org
Cc:     Rong Tao <rongtao@cestc.cn>, wuchi <wuchi.zero@gmail.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] radix tree test suite: Fix uninitialized variable compilation warning
Date:   Wed,  9 Nov 2022 22:34:25 +0800
X-OQ-MSGID: <20221109143425.25732-1-rtoax@foxmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,RDNS_DYNAMIC,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rong Tao <rongtao@cestc.cn>

We need to set an initial value for offset to eliminate compilation
warning.

How to reproduce warning:

$ make -C tools/testing/radix-tree
radix-tree.c: In function ‘radix_tree_tag_clear’:
radix-tree.c:1046:17: warning: ‘offset’ may be used uninitialized in this function [-Wmaybe-uninitialized]
 1046 |                 node_tag_clear(root, parent, tag, offset);
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Rong Tao <rongtao@cestc.cn>
---
 lib/radix-tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/radix-tree.c b/lib/radix-tree.c
index 3c78e1e8b2ad..049ba132f7ef 100644
--- a/lib/radix-tree.c
+++ b/lib/radix-tree.c
@@ -1029,7 +1029,7 @@ void *radix_tree_tag_clear(struct radix_tree_root *root,
 {
 	struct radix_tree_node *node, *parent;
 	unsigned long maxindex;
-	int offset;
+	int offset = 0;
 
 	radix_tree_load_root(root, &node, &maxindex);
 	if (index > maxindex)
-- 
2.31.1

