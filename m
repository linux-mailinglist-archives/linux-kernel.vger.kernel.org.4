Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A61473ACFC
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 01:14:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbjFVXO2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 19:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231486AbjFVXO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 19:14:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59BFA2955;
        Thu, 22 Jun 2023 16:13:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8E69E6192D;
        Thu, 22 Jun 2023 23:13:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A0E3C433C0;
        Thu, 22 Jun 2023 23:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687475636;
        bh=F5fKLwWsn2Ex3oJMKpK31v1vclgJv3wOl/KwcKpYG/M=;
        h=Date:From:To:Cc:Subject:From;
        b=ucx7W2ABWTBywvvU1AWEZ1mSnVbGErmem/s7WNHKglONcK+802866X9mZvB40h7+i
         CDuqaE6crrY8gdVxhdEthcYq2ZhQVG1CTqnzdjCcneLKgFVWVgQzTWYWF2j6REESPf
         Le0YlrKLx8VkZRn7H3KESPzkw+J1vSy1gv1dsW5Djdqiz8YMclYV5Lkeueem1TVhyA
         d/xYBfmgGsMVY8GxkjBmQGknX5CBNxu36mZDVghqhn0wY4SibTunxnV7/P00huAPxz
         Q1vFpaBHEI0EAYOoqC2/n90I6RedksmmZm8e+/P5am8elM7U0nBL2HSsXV7fQwgalK
         dIh56o1a/KMZg==
Date:   Thu, 22 Jun 2023 17:14:51 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] sparc: openpromio: Address -Warray-bounds warning
Message-ID: <ZJTV61z4+lsKlzQG@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One-element arrays are deprecated, and we are replacing them with flexible
array members instead. So, replace one-element array with flexible-array
member in struct openpromio.

Address the following warning found after building (with GCC-13) sparc
with sparc64_defconfig:
In function 'opromgetprop',
    inlined from 'openprom_sunos_ioctl.isra' at drivers/sbus/char/openprom.c:312:11:
drivers/sbus/char/openprom.c:141:24: warning: array subscript 1 is above array bounds of 'char[1]' [-Warray-bounds=]
  141 |         op->oprom_array[len] = '\0';
      |         ~~~~~~~~~~~~~~~^~~~~
In file included from drivers/sbus/char/openprom.c:31:
arch/sparc/include/uapi/asm/openpromio.h: In function 'openprom_sunos_ioctl.isra':
arch/sparc/include/uapi/asm/openpromio.h:16:17: note: while referencing 'oprom_array'
   16 |         char    oprom_array[1];         /* Holds property names and values. */
      |                 ^~~~~~~~~~~

This helps with the ongoing efforts to tighten the FORTIFY_SOURCE
routines on memcpy() and help us make progress towards globally
enabling -Warray-bounds.

This results in no differences in binary output.

Link: https://github.com/KSPP/linux/issues/79
Link: https://github.com/KSPP/linux/issues/322
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 arch/sparc/include/uapi/asm/openpromio.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/sparc/include/uapi/asm/openpromio.h b/arch/sparc/include/uapi/asm/openpromio.h
index d4494b679e99..2a73ec77aba6 100644
--- a/arch/sparc/include/uapi/asm/openpromio.h
+++ b/arch/sparc/include/uapi/asm/openpromio.h
@@ -10,10 +10,9 @@
  * were chosen to be exactly equal to the SunOS equivalents.
  */
 
-struct openpromio
-{
+struct openpromio {
 	unsigned int oprom_size;	/* Actual size of the oprom_array. */
-	char	oprom_array[1];		/* Holds property names and values. */
+	char	oprom_array[];		/* Holds property names and values. */
 };
 
 #define	OPROMMAXPARAM	4096		/* Maximum size of oprom_array. */
-- 
2.34.1

