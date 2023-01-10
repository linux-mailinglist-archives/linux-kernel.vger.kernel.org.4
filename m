Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 373B16636D0
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 02:41:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235832AbjAJBk6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 20:40:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233142AbjAJBke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 20:40:34 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4C62200E;
        Mon,  9 Jan 2023 17:40:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8EA02B810C3;
        Tue, 10 Jan 2023 01:40:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38BFAC433D2;
        Tue, 10 Jan 2023 01:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673314831;
        bh=ABYz4ZvvBdMvRbwp1IznTPG8KGEBT7V9tcgJKTQXuro=;
        h=Date:From:To:Cc:Subject:From;
        b=W3mYbBp9vkdjbVHF2zITSzwHSTgb2Sl9K6C43HXVbbn33c8I19QHvpySmLuybdyQC
         PNYA4wIpQ3paQHUK5SVTtZTcPRiN7mPxo8QRHVLHftxmpjeEF3XHbCGmtn9tjK1uMe
         v9kKOf+H1cuM6SUVkQFaffdHBut/81KhMo4Z2vuoxgXi7qrCwBQ9NkBDE1wbkszM3I
         AND/wO7BTJ7/7LnehbHLx6kZy3gbJHdIc2+u28Qs1Ka8q0oqiHOFUg82JFBdeOOJwG
         hSwz7Wu6vgUB4CCeMIQnUJwWqXkTr9XJPJs3dxbInq330EaCMRCfqd48gK/5OkcLqI
         kMcMY3rXesqPA==
Date:   Mon, 9 Jan 2023 19:40:38 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] x86/fpu: Replace zero-length array with flexible-array
 member
Message-ID: <Y7zCFpa2XNs/o9YQ@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zero-length arrays are deprecated[1] and we are moving towards
adopting C99 flexible-array members instead. So, replace zero-length
array declaration in struct xregs_state with flex-array member.

This helps with the ongoing efforts to tighten the FORTIFY_SOURCE
routines on memcpy() and help us make progress towards globally
enabling -fstrict-flex-arrays=3 [2].

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays [1]
Link: https://gcc.gnu.org/pipermail/gcc-patches/2022-October/602902.html [2]
Link: https://github.com/KSPP/linux/issues/78
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 arch/x86/include/asm/fpu/types.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/fpu/types.h b/arch/x86/include/asm/fpu/types.h
index eb7cd1139d97..7f6d858ff47a 100644
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
-- 
2.34.1

