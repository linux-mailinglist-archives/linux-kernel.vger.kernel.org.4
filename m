Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5D3564EF3E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 17:35:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231445AbiLPQfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 11:35:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231317AbiLPQfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 11:35:19 -0500
X-Greylist: delayed 395 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 16 Dec 2022 08:35:17 PST
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F469E2D;
        Fri, 16 Dec 2022 08:35:17 -0800 (PST)
Received: from frontend03.mail.m-online.net (unknown [192.168.6.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4NYZKj0Y1xz1qybn;
        Fri, 16 Dec 2022 17:28:41 +0100 (CET)
Received: from localhost (dynscan3.mnet-online.de [192.168.6.84])
        by mail.m-online.net (Postfix) with ESMTP id 4NYZKj0DcVz1qqlR;
        Fri, 16 Dec 2022 17:28:41 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan3.mail.m-online.net [192.168.6.84]) (amavisd-new, port 10024)
        with ESMTP id ETe0X5ahipdf; Fri, 16 Dec 2022 17:28:40 +0100 (CET)
X-Auth-Info: ja4DdYAVJ2M2oPTM5MSLnKMxqoXcKZ/J4uVZBXx+LTeNTf8jbSNfMX9wC25qzEU9
Received: from igel.home (aftr-62-216-205-197.dynamic.mnet-online.de [62.216.205.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Fri, 16 Dec 2022 17:28:40 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
        id F39D82C32FE; Fri, 16 Dec 2022 17:28:39 +0100 (CET)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     linux-m68k@vger.kernel.org
Subject: [PATCH] m68k: fix strcmp inline
CC:     linux-kernel@vger.kernel.org
X-Yow:  ..  If I had heart failure right now, I couldn't be a more fortunate
 man!!
Date:   Fri, 16 Dec 2022 17:28:39 +0100
Message-ID: <87bko3ia88.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The return value of strcmp needs to be computed from the ordering of the
unsigned characters.

Signed-off-by: Andreas Schwab <schwab@linux-m68k.org>
---
 arch/m68k/include/asm/string.h | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/m68k/include/asm/string.h b/arch/m68k/include/asm/string.h
index f759d944c449..cdafd67774e0 100644
--- a/arch/m68k/include/asm/string.h
+++ b/arch/m68k/include/asm/string.h
@@ -42,18 +42,19 @@ static inline char *strncpy(char *dest, const char *src, size_t n)
 #define __HAVE_ARCH_STRCMP
 static inline int strcmp(const char *cs, const char *ct)
 {
-	char res;
+	int res = 0, tmp = 0;
 
 	asm ("\n"
 		"1:	move.b	(%0)+,%2\n"	/* get *cs */
-		"	cmp.b	(%1)+,%2\n"	/* compare a byte */
+		"	move.b	(%1)+,%3\n"	/* get *ct */
+		"	cmp.b	%3,%2\n"	/* compare a byte */
 		"	jne	2f\n"		/* not equal, break out */
 		"	tst.b	%2\n"		/* at end of cs? */
 		"	jne	1b\n"		/* no, keep going */
 		"	jra	3f\n"		/* strings are equal */
-		"2:	sub.b	-(%1),%2\n"	/* *cs - *ct */
+		"2:	sub.l	%3,%2\n"	/* *cs - *ct */
 		"3:"
-		: "+a" (cs), "+a" (ct), "=d" (res));
+		: "+a" (cs), "+a" (ct), "+d" (res), "+d" (tmp));
 	return res;
 }
 #endif /* CONFIG_COLDFIRE */
-- 
2.39.0


-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
