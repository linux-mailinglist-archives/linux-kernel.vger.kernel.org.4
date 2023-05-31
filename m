Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EAFE718E47
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 00:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbjEaWP1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 18:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230503AbjEaWOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 18:14:34 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42C2B13D;
        Wed, 31 May 2023 15:14:13 -0700 (PDT)
Date:   Wed, 31 May 2023 22:13:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1685571219;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=1pcpTxBqkRvq4f7Rr5CH8vPLuAphaJIJpXrzDaeWuWc=;
        b=Z/q6i98z5Tb0t/syH2GkMDkCkQcdKY7KLhvYnsNkzrVEjOdA6aVygSutZ6LBEHBAVogupU
        qC7ZSOamfOGAD/+jWTliYlmXXHeKm9e2dYE21lIth7ho2D4MJfYUoCHrlNVlG3Y9H2sqSX
        lTsqF2A5EADq/ASJLIF0vhq6+S4tumLO5Zu4uLznoHlvbyUoMQO1skD92Rw27Qxg612EEl
        8gcuR4s6sROtQQjSLw4XMYATjWjZx701uXeJpfMN+WJMuaVC8T48f0QLHl3c72a9vDcFoP
        jupHJ8fDW6DyhWp+sUId7Lb5otnRRrgOwhfM+fMYr13+9BfgrwhKseQH5Gyryw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1685571219;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=1pcpTxBqkRvq4f7Rr5CH8vPLuAphaJIJpXrzDaeWuWc=;
        b=jFG3R0xVyBsgW/WhU9J/rHea0PONCGBH9lotIS0WhbWS+DWro1hjWLvdKVhvEiqNb5lN21
        kowIKdlKr9kp4PCA==
From:   "tip-bot2 for Steve Wahl" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/platform] x86/platform/uv: Introduce helper function
 uv_pnode_to_socket.
Cc:     Steve Wahl <steve.wahl@hpe.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <168557121871.404.938275922115349330.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/platform branch of tip:

Commit-ID:     8c646cee0ae3c0a19a7d9fdb847c45c729cae945
Gitweb:        https://git.kernel.org/tip/8c646cee0ae3c0a19a7d9fdb847c45c729cae945
Author:        Steve Wahl <steve.wahl@hpe.com>
AuthorDate:    Fri, 19 May 2023 14:07:46 -05:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 31 May 2023 09:34:59 -07:00

x86/platform/uv: Introduce helper function uv_pnode_to_socket.

Add and use uv_pnode_to_socket() function, which parallels other
helper functions in here, and will enable avoiding duplicate code
in an upcoming patch.

Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/all/20230519190752.3297140-3-steve.wahl%40hpe.com
---
 arch/x86/include/asm/uv/uv_hub.h | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/uv/uv_hub.h b/arch/x86/include/asm/uv/uv_hub.h
index d3e3197..0acfd17 100644
--- a/arch/x86/include/asm/uv/uv_hub.h
+++ b/arch/x86/include/asm/uv/uv_hub.h
@@ -519,18 +519,24 @@ static inline int uv_socket_to_node(int socket)
 	return _uv_socket_to_node(socket, uv_hub_info->socket_to_node);
 }
 
+static inline int uv_pnode_to_socket(int pnode)
+{
+	unsigned short *p2s = uv_hub_info->pnode_to_socket;
+
+	return p2s ? p2s[pnode - uv_hub_info->min_pnode] : pnode;
+}
+
 /* pnode, offset --> socket virtual */
 static inline void *uv_pnode_offset_to_vaddr(int pnode, unsigned long offset)
 {
 	unsigned int m_val = uv_hub_info->m_val;
 	unsigned long base;
-	unsigned short sockid, node, *p2s;
+	unsigned short sockid, node;
 
 	if (m_val)
 		return __va(((unsigned long)pnode << m_val) | offset);
 
-	p2s = uv_hub_info->pnode_to_socket;
-	sockid = p2s ? p2s[pnode - uv_hub_info->min_pnode] : pnode;
+	sockid = uv_pnode_to_socket(pnode);
 	node = uv_socket_to_node(sockid);
 
 	/* limit address of previous socket is our base, except node 0 is 0 */
