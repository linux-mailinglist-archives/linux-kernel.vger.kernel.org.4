Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2971686FC8
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 21:41:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbjBAUkb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 15:40:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjBAUk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 15:40:28 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C798F5CD26
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 12:40:27 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-4ff7c6679f2so103477b3.12
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 12:40:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=u+y1eUE75kzOF0FCyh3hyuMd042g4IapCMvhc5hehs4=;
        b=agdAeHdow69Gw2Qn3uQo4630v6WSjORE7FyxvWvBRcUTHPZq/8QSzRb2sXf8WlIh+I
         VwgTEE7C1cqrYXPrXM6yLFG4uLoRThrRVFNGmT8I8meWJAXTI0L441BOD1qLJkD9id1e
         rA06D5dD0aaJ14KaiCTq/Aa4mugxDLfNsrtU1FkqG/TfxU5JRpRapqe/7yfpzzo9yamM
         enCgzq3UOkxoQKmAlg8GmXE1KN/AdghVvKXS5TsvAtR8pBHRIGAlN2F4+QzZqk8rZ610
         uFxuNL/9x05uCM6wE165GIx+GmO9g7aj6Hw77U5KuHR86N74VoWvA2T0wVmK4k8EGyZP
         0byA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u+y1eUE75kzOF0FCyh3hyuMd042g4IapCMvhc5hehs4=;
        b=EjmhK4+h5RIKMos8xdMoN7T0fReVMEn6NqEOqKtOGgpUW26r8gqVxZPxM0IyG2pxsc
         FY5bmzrxBIYn03E4F6u0JWLisjifKk1Z96M30Vd0B1IxjCTyUlyal9NEXyx1oTnFyK7A
         GNSDVkml4T3PVKgra2GnpSsA4Ckpg5H8G+U7cjUleYWnACc/ETyzmroUoZbsGusaYRBY
         wU+Ue41KWotPvFanhYWKA0Io3a6C2bxD/l0voVLRXGA0wAcvttP1zpUe76VvJGwx2x5w
         873d8d6Ag4h8aePXY66iApPIwcVCVeW/ZCxRB3ojDzruHaS0H+0TfbmsI5wR6D7HMPy4
         J4kg==
X-Gm-Message-State: AO0yUKXCo2+elQkAzqVfWee6XQNCd8VyFChlMnA8nLd0cCOVeAn5znDw
        hq4vxM1f/xgfMNAFP0XfY63warXMfOE=
X-Google-Smtp-Source: AK7set8EB1ZfwIH8LMIOe/3Ky00wvNRaKKkfGdp8jDS4s6uPwhSjaXmg4z/QhkcSsz9s/VNEcxxeKN8vTQU=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:507:b0:855:fafc:5ea7 with SMTP id
 x7-20020a056902050700b00855fafc5ea7mr3ybs.7.1675284026684; Wed, 01 Feb 2023
 12:40:26 -0800 (PST)
Date:   Wed,  1 Feb 2023 19:13:24 +0000
In-Reply-To: <20221129193717.513824-1-mlevitsk@redhat.com>
Mime-Version: 1.0
References: <20221129193717.513824-1-mlevitsk@redhat.com>
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
Message-ID: <167527861236.717060.16272359261905713276.b4-ty@google.com>
Subject: Re: [PATCH v2 00/11] SVM: vNMI (with my fixes)
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org,
        Maxim Levitsky <mlevitsk@redhat.com>
Cc:     Sandipan Das <sandipan.das@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Daniel Sneddon <daniel.sneddon@linux.intel.com>,
        Jiaxi Chen <jiaxi.chen@linux.intel.com>,
        Babu Moger <babu.moger@amd.com>, linux-kernel@vger.kernel.org,
        Jing Liu <jing2.liu@intel.com>,
        Wyes Karny <wyes.karny@amd.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Nov 2022 21:37:06 +0200, Maxim Levitsky wrote:
> This is the vNMI patch series based on Santosh Shukla's vNMI patch series.
> 
> In this version of this patch series I addressed most of the review feedback
> added some more refactoring and also I think fixed the issue with migration.
> 
> I only tested this on a machine which doesn't have vNMI, so this does need
> some testing to ensure that nothing is broken.
> 
> [...]

Applied 1, 4, and 5 to kvm-x86 svm.  I split patch 4 as doing so made the
HF_GIF_MASK change super trivial.

vNMI support will get pushed beyond v6.3, but I will do my best to promptly
review future versions, while I still have all of this paged in...

[01/11] KVM: nSVM: Don't sync tlb_ctl back to vmcb12 on nested VM-Exit
        https://github.com/kvm-x86/linux/commit/8957cbcfed0a
[04/11] KVM: x86: Move HF_GIF_MASK into "struct vcpu_svm" as "guest_gif"
        https://github.com/kvm-x86/linux/commit/c760e86f27fe
[04/11] KVM: x86: Move HF_NMI_MASK and HF_IRET_MASK into "struct vcpu_svm"
        https://github.com/kvm-x86/linux/commit/916b54a7688b
[05/11] KVM: x86: Use emulator callbacks instead of duplicating "host flags"
        https://github.com/kvm-x86/linux/commit/32e69f232db4

--
https://github.com/kvm-x86/linux/tree/next
https://github.com/kvm-x86/linux/tree/fixes
