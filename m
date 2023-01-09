Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 467E16632C0
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 22:22:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238006AbjAIVWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 16:22:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232796AbjAIVVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 16:21:52 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B48C31B1C8
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 13:20:21 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id bp15so15063469lfb.13
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 13:20:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FNC2XSpBLRS3auEEG3PVbMVZdtlR6ps1ItMrpT1MBag=;
        b=D07B9HycUls6seaOKG+Dy6GfEllCheSXDZmORRHsJbzO4NPQGyfHgvWtSrc5KNgipL
         Ms0+9utOu08Ne/59DrU8PVnTQ55Jg8KHVUmlD0KTBj7spLLI+iOaekkNHWaezk/8sYNt
         Jqj7XfNUYmYuJhf7SAo3/eeCy/TWuAgJOi6QVmwZcc7eE/nJrwQa0fpVMczeMRfdi7Tu
         IPzg1vVyvJcnNFcH7XBsFn5Ndme7R9wMLZvjhHlxr7TpqVJxVcJBIxZ+WGWJgWnAz3oV
         WTVrCTqlxsuJcSRRL65s0SWN9QxjEA9OsY2ywoApCWvD/q8xxoR7kcejKu5cowq+tMFO
         kl2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FNC2XSpBLRS3auEEG3PVbMVZdtlR6ps1ItMrpT1MBag=;
        b=lfhjhxN0z6B/FY19CDHnHlKfRbvvrEEKPsdDLM/Nkr1MPAyTzI3uDmaENqdvdPHaST
         lWAiAm7dG62FHI9F+NlH6VsToQpEOo87T0chpvKlqgcxkbme+wtBjrhJW9NcGmMEv0oI
         Uei6x+HN99I0WThZ5eqbJ4hJu0hUx+nL2lJMmE9nkqgYenhXH+aBdHW+GA+LPT6laqZS
         2umgtoNJZvTO1MjzyWPwXc/nRcff4w5uoy0pqS25bx3vECVRtgRdUzX2j1qhGRSnOR9l
         g9E1BpzsPR2+2Xuyrq/laXQ8N2wDDomlhjXM1B/nv4ZRN5DhiEN6/IPz4MLkcpE2PiBH
         1gMA==
X-Gm-Message-State: AFqh2kqHkmS4RlIcUO+CBrOtdlybdPiGw7I5sgA4kS1R8ZSpSA9lk5LN
        9QyQCp6x8AiQwVMAvB7zOD7Q9so2a2mQVkhFrRGE1Q==
X-Google-Smtp-Source: AMrXdXtQTExd65/VakEAByPpVZZhe+N/UBYY4KOIABLMFWNhF3MDFAdQLeBqljHDyHGWhFLioRvQ1LsfQ3V1CDTxsWc=
X-Received: by 2002:ac2:58f4:0:b0:4cb:d9d:df5f with SMTP id
 v20-20020ac258f4000000b004cb0d9ddf5fmr4817329lfo.313.1673299219794; Mon, 09
 Jan 2023 13:20:19 -0800 (PST)
MIME-Version: 1.0
References: <20221018205845.770121-1-pgonda@google.com> <20221018205845.770121-6-pgonda@google.com>
 <CAGtprH8wfYk05+yfzngHJ99ESwjhDf-sRaLO3AT2x1VyFQ6pvw@mail.gmail.com>
In-Reply-To: <CAGtprH8wfYk05+yfzngHJ99ESwjhDf-sRaLO3AT2x1VyFQ6pvw@mail.gmail.com>
From:   Peter Gonda <pgonda@google.com>
Date:   Mon, 9 Jan 2023 14:20:07 -0700
Message-ID: <CAMkAt6pLFO0ZAnQ23ZUX3MdtFpcb69kwW79JDn=_5b7a48rtHg@mail.gmail.com>
Subject: Re: [PATCH V5 5/7] KVM: selftests: add library for
 creating/interacting with SEV guests
To:     Vishal Annapurve <vannapurve@google.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        marcorr@google.com, seanjc@google.com, michael.roth@amd.com,
        thomas.lendacky@amd.com, joro@8bytes.org, mizhang@google.com,
        pbonzini@redhat.com, andrew.jones@linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 22, 2022 at 3:19 PM Vishal Annapurve <vannapurve@google.com> wrote:
>
> On Tue, Oct 18, 2022 at 1:59 PM Peter Gonda <pgonda@google.com> wrote:
> >
> > ...
> > +
> > +static void configure_sev_pte_masks(struct kvm_vm *vm)
> > +{
> > +       uint32_t eax, ebx, ecx, edx, enc_bit;
> > +
> > +       cpuid(CPUID_MEM_ENC_LEAF, &eax, &ebx, &ecx, &edx);
> > +       enc_bit = ebx & CPUID_EBX_CBIT_MASK;
> > +
> > +       vm->arch.c_bit = 1 << enc_bit;
>
> This should be 1ULL << enc_bit as the overall result overflows 32 bits.
>
> > +       vm->arch.pte_me_mask = vm->arch.c_bit | vm->arch.s_bit;
>
> Maybe the role of pte_me_mask needs to be discussed in more detail. If
> pte_me_mask is to be used only for maintaining/manipulating encryption
> of page table memory then maybe it should be just set as
> vm->arch.c_bit or better yet replaced with vm->arch.c_bit.
>
> gpa_protected_mask also needs to be set here so that vm_untag_gpa
> works as expected.

Thanks for speaking with me offline about TDX. I have removed
pte_me_mask entirely and set gpa_protected_mask here in my V6.

>
> > +       vm->protected = true;
> > +}
> > +
> > ...
> > +}
>
> > --
> > 2.38.0.413.g74048e4d9e-goog
> >
