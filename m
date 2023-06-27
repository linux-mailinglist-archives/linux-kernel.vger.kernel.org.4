Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DCCE740271
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 19:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231745AbjF0RnZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 13:43:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231815AbjF0RnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 13:43:20 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 738F32D7D
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 10:43:16 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-573d70da2afso65536597b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 10:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687887795; x=1690479795;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZFffcNfXphZcVXVYjmzKuM76MS8vddm5iG6/4tmKFXI=;
        b=Q3Yu058kYoSapd4q3xZuhDkkGUkCKLg0p3i6hK5SEkQXADqshsADvKmA25IH2kaAE0
         nBMlKCSzk7E7zudiLoecRRkJdAy0dBwOusKZi0jlkYjtfvWoBncVI2qg4hVCJ1TG4ZuR
         UpiL/r2dy74KFDDNpAg7WJjAhxPEPHHN8f2OjoOF+G/OcMWGsmq2AGTIs2kMKSuKlPxL
         8ifeA3DtLNR52XAQVbj13XWQTd/jqDjPI3n8U2zUGRHYEXV2c5xzZY1ONV9mh3ZvFiPD
         +KdZ9R9LCM2x1HcbnnqnR/QFqnF//MwWFcAgU7ESqvKSHjhZDjQcDIdJS7AMbbvl5rP5
         zx0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687887795; x=1690479795;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZFffcNfXphZcVXVYjmzKuM76MS8vddm5iG6/4tmKFXI=;
        b=jxMfrGdjSoMmjCjeCJuR9Kw2dMEyy0VT408wNxSd4BMFVfOzeQzF5I6K+yQTBw4L9K
         L9FSajdgdRW8SQF8VxTGmoEARFTWZW3dmURHPV7LXDsU0qsRRFRATD3+dLP7l4ZduQL1
         LN/cy20y5+LNtqglqYsjcieZ4Yc3R05bsDL2gIJhQbWnr7HthX5VilxyY1crltvWY1rb
         qZOL1xrvbsalaVNrIY6rlhyWrXalSBbEIW8brN2p+xheBVct8ce+K6FsuvvDtjPSe+sr
         U5K7McWsSPD68ghU2FBjmAgry4qKRH5feUV/vktLezWPOFp3tzMJ/mLSCDHZtxUOiOwh
         ghZA==
X-Gm-Message-State: AC+VfDwnwMb4+G/UL/YTvLESDFEwTBVJISGF5sYdUMSPyApCyoB4vQKi
        ZXeQ8jasONBRA3d7fWicg6xKR8U55Kg=
X-Google-Smtp-Source: ACHHUZ5Fke4uyoHtfR/7W1QuD+62saqrRJuufxphcpx9wbot76yINyy6sEDSMQTibZ/wPMD3j8pMlBViZ1g=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:aba9:0:b0:bc4:8939:e1f5 with SMTP id
 v38-20020a25aba9000000b00bc48939e1f5mr15087649ybi.4.1687887795734; Tue, 27
 Jun 2023 10:43:15 -0700 (PDT)
Date:   Tue, 27 Jun 2023 10:43:14 -0700
In-Reply-To: <20230601142309.6307-3-guang.zeng@intel.com>
Mime-Version: 1.0
References: <20230601142309.6307-1-guang.zeng@intel.com> <20230601142309.6307-3-guang.zeng@intel.com>
Message-ID: <ZJsfsjwug9PcQFLA@google.com>
Subject: Re: [PATCH v1 2/6] KVM: x86: Virtualize CR4.LASS
From:   Sean Christopherson <seanjc@google.com>
To:     Zeng Guang <guang.zeng@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        H Peter Anvin <hpa@zytor.com>, kvm@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 01, 2023, Zeng Guang wrote:
> Virtualize CR4.LASS[bit 27] under KVM control instead of being guest-owned
> as CR4.LASS generally set once for each vCPU at boot time and won't be
> toggled at runtime. Besides, only if VM has LASS capability enumerated with
> CPUID.(EAX=07H.ECX=1):EAX.LASS[bit 6], KVM allows guest software to be able
> to set CR4.LASS.
>
> Updating cr4_fixed1 to set CR4.LASS bit in the emulated IA32_VMX_CR4_FIXED1
> MSR for guests and allow guests to enable LASS in nested VMX operaion as well.

s/operaion/operation.
