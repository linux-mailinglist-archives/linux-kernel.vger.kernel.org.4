Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A048B601C52
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 00:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbiJQW0u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 18:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbiJQW0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 18:26:48 -0400
Received: from mail-ua1-x94a.google.com (mail-ua1-x94a.google.com [IPv6:2607:f8b0:4864:20::94a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E20F814D9
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 15:26:36 -0700 (PDT)
Received: by mail-ua1-x94a.google.com with SMTP id a15-20020ab0494f000000b003e052aec9b2so5278977uad.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 15:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dRicd/TKDtSX5fV7ZkBHSh0LxgTerLvjz+IosqKnncg=;
        b=nbbZgCLvSbeQnr9DFO2lGFN8HoAT1h71+nkYVU5gZmbaOLcGw4gmSj5tGOaO0r9Cb9
         fw0FKgCdqJZ9Yon01ODdpHRth5FVd8tLdjV+9Mg+XxP+Xama2h31sQMYarHIOvNwndOy
         XJkj3ETnpYIa2VgOgJbVmAKoE32Zlq1AKzxozeHF8JULsPCSalVAveBFS5YjjGojdJFB
         TKQM+UMgOchftcxegbqETwWfK7ba9q13nTTn3EcPEtwyr2R8g4wicI+aHVCEwd0zw34W
         GU+YFBdFEX6pb/1q0m7BJLirI+7f87/XnfAcKv2K1o2X+W5jwovymasUe4lvF35/oZ0P
         m7Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dRicd/TKDtSX5fV7ZkBHSh0LxgTerLvjz+IosqKnncg=;
        b=1tIIkZcgi8CM7Fblioz1hxi1x+tIb4NJunk+XEJyci43xOw0ll34h1rEUjB2ffOQ+r
         8sTZ7e7m9e0TIYMjSph7NtpR2KI5l/PsxlU4NVwEH4ldc3wXTelOj67Q7p+v1rvEHALD
         rl8+cik4DKOtLygOMoXJwhbAnSKExdEa55bsLkOz5O9fK89cmgP+LJFIzdx/x5zRzcw4
         81xTkvfV1k+It1EKo4CKVbeSP8dYH2DK5k4os+gjejku4OphOCKfMYYVqVZJLFYOveaK
         EEuB92JoGG4H555YsVDglezjbL9lsXwTxWibEAZoAf1w8bOtR/tNueW8rIEB8p9a3cP/
         onbQ==
X-Gm-Message-State: ACrzQf2wg+qRtUQ+vs0gL1KMwiXw1V0Y7WLpc2Ak7fJAK0ODGjUvk1d3
        Jg7R2fdv+PVQoQFVXuN1Qew7vpjFzQ==
X-Google-Smtp-Source: AMsMyM4gH43JTYwwxDkHG+XUs6CobCsKkbrcZ3sxBeU//UGVSxmNUJnRBye8LkmKPa0ZiD5wfZ9peAS2FQ==
X-Received: from nhuck.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:39cc])
 (user=nhuck job=sendgmr) by 2002:a05:6102:1c6:b0:3a9:6160:c467 with SMTP id
 s6-20020a05610201c600b003a96160c467mr18407vsq.49.1666045595002; Mon, 17 Oct
 2022 15:26:35 -0700 (PDT)
Date:   Mon, 17 Oct 2022 15:26:20 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.0.413.g74048e4d9e-goog
Message-ID: <20221017222620.715153-1-nhuck@google.com>
Subject: [PATCH] crypto: x86/polyval - Fix crashes when keys are not 16-byte aligned
From:   Nathan Huckleberry <nhuck@google.com>
Cc:     Nathan Huckleberry <nhuck@google.com>,
        Bruno Goncalves <bgoncalv@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Eric Biggers <ebiggers@google.com>,
        Ard Biesheuvel <ardb@kernel.org>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MISSING_HEADERS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The key_powers array is not guaranteed to be 16-byte aligned, so using
movaps to operate on key_powers is not allowed.

Switch movaps to movups.

Fixes: 34f7f6c30112 ("crypto: x86/polyval - Add PCLMULQDQ accelerated implementation of POLYVAL")
Reported-by: Bruno Goncalves <bgoncalv@redhat.com>
Signed-off-by: Nathan Huckleberry <nhuck@google.com>
---
 arch/x86/crypto/polyval-clmulni_asm.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/crypto/polyval-clmulni_asm.S b/arch/x86/crypto/polyval-clmulni_asm.S
index a6ebe4e7dd2b..32b98cb53ddf 100644
--- a/arch/x86/crypto/polyval-clmulni_asm.S
+++ b/arch/x86/crypto/polyval-clmulni_asm.S
@@ -234,7 +234,7 @@
 
 	movups (MSG), %xmm0
 	pxor SUM, %xmm0
-	movaps (KEY_POWERS), %xmm1
+	movups (KEY_POWERS), %xmm1
 	schoolbook1_noload
 	dec BLOCKS_LEFT
 	addq $16, MSG
-- 
2.38.0.413.g74048e4d9e-goog

