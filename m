Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB60674407
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 22:10:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229488AbjASVKy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 16:10:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbjASVJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 16:09:38 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E1F130F8;
        Thu, 19 Jan 2023 13:03:02 -0800 (PST)
Date:   Thu, 19 Jan 2023 21:02:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1674162180;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xY+SzRBo17JQPxRpIt0Xv07Ckhs+cRTjf+iujupdH3Q=;
        b=JdNClVOVN7juiNVlv1BdgZTUI5ocscMjE1ceI8aFyc+YKF8jOq7DjbbvtORx99zIj6dUgN
        k4fY1KIX0X9AGuPYkRAu+ow/eLCxtCv92PWFpjSfxXjJ4EE1rUvB5JEv1B6KEvS5nzFmvN
        me1GUQQHQw8PNId1X/O2X3DQZfP7xiTr1rwv+ePumrIp2uGRTx0+FDvpChl2hxgAC9PmHH
        0eciBohNaOSUmzevgHnZn18Ty4uSwZFTCdy1cppopUGTnvDXHkfWshIGM/WHO5ESkqiwNz
        S9eMAgor8NVg3jz6GKTKCzVncBRnNZQ8g4dBBqVIKCqDJrD1nU1SBUZeUuh9dQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1674162180;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xY+SzRBo17JQPxRpIt0Xv07Ckhs+cRTjf+iujupdH3Q=;
        b=DB2zZ4Nd7aoqpqZ9B0qoCnuTHdNlear3ASzlWBeSKmlLshVJ+HX4gO1MecP+8BpnLSUfAE
        A3X0t0cHxY4IruCg==
From:   "tip-bot2 for Gustavo A. R. Silva" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu: Replace zero-length array in struct
 xregs_state with flexible-array member
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <o9YQ@work>
References: <o9YQ@work>
MIME-Version: 1.0
Message-ID: <167416217961.4906.13789346237944390735.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     aa81cb9d9723694bb18359adbef7964030758dba
Gitweb:        https://git.kernel.org/tip/aa81cb9d9723694bb18359adbef7964030758dba
Author:        Gustavo A. R. Silva <gustavoars@kernel.org>
AuthorDate:    Mon, 09 Jan 2023 19:40:38 -06:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 19 Jan 2023 21:59:35 +01:00

x86/fpu: Replace zero-length array in struct xregs_state with flexible-array member

Zero-length arrays are deprecated [1] and have to be replaced by C99
flexible-array members.

This helps with the ongoing efforts to tighten the FORTIFY_SOURCE routines
on memcpy() and help to make progress towards globally enabling
-fstrict-flex-arrays=3 [2]

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Kees Cook <keescook@chromium.org>
Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays [1]
Link: https://gcc.gnu.org/pipermail/gcc-patches/2022-October/602902.html [2]
Link: https://github.com/KSPP/linux/issues/78
Link: https://lore.kernel.org/r/Y7zCFpa2XNs/o9YQ@work
---
 arch/x86/include/asm/fpu/types.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/fpu/types.h b/arch/x86/include/asm/fpu/types.h
index eb7cd11..7f6d858 100644
--- a/arch/x86/include/asm/fpu/types.h
+++ b/arch/x86/include/asm/fpu/types.h
@@ -321,7 +321,7 @@ struct xstate_header {
 struct xregs_state {
 	struct fxregs_state		i387;
 	struct xstate_header		header;
-	u8				extended_state_area[0];
+	u8				extended_state_area[];
 } __attribute__ ((packed, aligned (64)));
 
 /*
