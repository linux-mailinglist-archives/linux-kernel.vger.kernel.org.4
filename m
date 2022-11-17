Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E5F262D170
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 04:07:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234170AbiKQDHm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 22:07:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232921AbiKQDHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 22:07:39 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 586E161BB1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 19:07:39 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id w4-20020a17090ac98400b002186f5d7a4cso649913pjt.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 19:07:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pa5UqVHoKtSmMcTtq44P+OTbkS+eAwwWT8kOI+vqzfQ=;
        b=fGfwLJbYQdy/G/BDCUmvzEKCl86N3TtDPIxkdzCUUG5SxWXmkaqsjH4zxZjm+9EqQ3
         0DnbmWLdhVLD47jVGlDwt1Qi6cjG3CIXIHP5oC5CQ2zRR7QTACY9/Sb//2HfGoIVou2o
         lDypdJakoSkMG3OzQNBziXbuuQAqSMTXNI8tHZFEW3YYnLF489LAS1awa1C6y1UBWVUL
         2dEn1B0NeuQluzDRXry+DZBdotiZsXrloQg00i634wfHsCm6zZ+VSRzNBsejwHT7/IFV
         fuEAkUYy07DwH+JrjYGkN8EM7flnITG0xEK3F4svo31W7SWMBhULnsAp5qwRqfjTF03S
         Xx/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pa5UqVHoKtSmMcTtq44P+OTbkS+eAwwWT8kOI+vqzfQ=;
        b=5RQLyeL99rUgB5WPKSzt0eg9LAd1kyi0APt0Zg/S8blsfANbfae3gZddWcyksTWru9
         7R3O6gzqaUjYp7zR2nvbSU1Kj1jmX8J1nTp9CkuFt/PjIJ2kKK4m4eqfpnvR8FtFP1e0
         QOGGCPTP1GjNoG7KNCxfZup8G0krk6oPEEJN73lA4v0QLFUVKZV23AZjXNtXz7yRtY+f
         yruqiRMvtsu4Ik68rOlC7xjVGfNEferBt8jkh6cjF3+CsyDV31wzMvLbT5grV820Smr8
         bQqfPNzreeeiTMRr8FHVxKQzVuPBSPRisqw8SfIAyCtrs4Ulh/W5+rjXVlVoKOOPRNpU
         ARjw==
X-Gm-Message-State: ANoB5pmfweeZFKVOqz6FILy9xPGQ08kM4jj/S2TaWlfHa1IDhIj7lz4z
        zQT2hDYNYKTSjWqPnOAB12cpk5vIQ7Hc53MfC1cZ4w==
X-Google-Smtp-Source: AA0mqf5jM3My1EFwIt/TwMaZZNxkmVEVeIgETQ8NwxHMtyqxBMr0+Vx0ky5+Ys2cY70a/jv7ld+2MVmtsd4eI1eTa5I=
X-Received: by 2002:a17:90a:ab84:b0:213:343:9873 with SMTP id
 n4-20020a17090aab8400b0021303439873mr6754073pjq.102.1668654458703; Wed, 16
 Nov 2022 19:07:38 -0800 (PST)
MIME-Version: 1.0
References: <20221117002350.2178351-1-seanjc@google.com> <20221117002350.2178351-2-seanjc@google.com>
In-Reply-To: <20221117002350.2178351-2-seanjc@google.com>
From:   Reiji Watanabe <reijiw@google.com>
Date:   Wed, 16 Nov 2022 19:07:22 -0800
Message-ID: <CAAeT=Fx1u=H=5xvmaPxnv4osNwAqNT5c_K1XTfwT0HiPucn+gg@mail.gmail.com>
Subject: Re: [PATCH 1/2] KVM: arm64: selftests: Disable single-step with
 correct KVM define
To:     Sean Christopherson <seanjc@google.com>
Cc:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2022 at 4:24 PM Sean Christopherson <seanjc@google.com> wrote:
>
> Disable single-step by setting debug.control to KVM_GUESTDBG_ENABLE,
> not to SINGLE_STEP_DISABLE.  The latter is an arbitrary test enum that
> just happens to have the same value as KVM_GUESTDBG_ENABLE, and so
> effectively disables single-step debug.
>
> No functional change intended.
>
> Cc: Reiji Watanabe <reijiw@google.com>
> Fixes: b18e4d4aebdd ("KVM: arm64: selftests: Add a test case for KVM_GUESTDBG_SINGLESTEP")
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  tools/testing/selftests/kvm/aarch64/debug-exceptions.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/kvm/aarch64/debug-exceptions.c b/tools/testing/selftests/kvm/aarch64/debug-exceptions.c
> index 947bd201435c..91f55b45dfc7 100644
> --- a/tools/testing/selftests/kvm/aarch64/debug-exceptions.c
> +++ b/tools/testing/selftests/kvm/aarch64/debug-exceptions.c
> @@ -369,7 +369,7 @@ void test_single_step_from_userspace(int test_cnt)
>                                                 KVM_GUESTDBG_SINGLESTEP;
>                                 ss_enable = true;
>                         } else {
> -                               debug.control = SINGLE_STEP_DISABLE;
> +                               debug.control = KVM_GUESTDBG_ENABLE;

Reviewed-by: Reiji Watanabe <reijiw@google.com>

Maybe I originally wanted to set it to 0:)
There is no issue with KVM_GUESTDBG_ENABLE at all,
as KVM_GUESTDBG_SINGLESTEP is cleared with that.

Thank you for fixing this!

Thanks,
Reiji


>                                 ss_enable = false;
>                         }
>
> --
> 2.38.1.431.g37b22c650d-goog
>
