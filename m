Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C98BE6C5BC1
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 02:14:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbjCWBOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 21:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbjCWBOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 21:14:47 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 091237ECF
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 18:14:46 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id l12-20020a170903120c00b001a1241a9bb1so11624098plh.11
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 18:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679534085;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BJykVyWZaPOMoDqRHQXOF5YkglH1GiNEZ9yGuzePcG8=;
        b=JedfSPutGU8QbZzEeo+YZQWnnPEiXoSM2cIiw1mDHU8Ck0gSujsuyVXvnLyntB1ezq
         bb4Oj08UfITgj0Cl3bKxUxlndRN+9o2r3maeSZb7V95LfG9mivfliQL4zeAs289rl+F5
         Ajt3SqVzBzewwzm2sZ4nPT++G4J9ZkQb1ABnfkWtWX8M/+Z2T5EiwC6TwCbwq4oTYZBq
         WkptjEjELnIYskJs4IvncS8Lg1huMLfIfpIywLCpSdoRWWdeZoWLWWwQ5A/ujoQfXhth
         Ql+Txx++A2/MWhtLDSzb41j1QnaH4kLlD57n02s/ZgewdK5OVVSktvylGRBlQbEOxt74
         T8oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679534085;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BJykVyWZaPOMoDqRHQXOF5YkglH1GiNEZ9yGuzePcG8=;
        b=jTypVP60/QpAXg+DqYJ7+ALVRzoxDqE8qz5HPOGqtV5Q3XqZQc+qvEKpZ7C0CfAAyA
         TuS5D+l5tiwlyKO3fBTjx94GA/VLTbJG4HH1/cM1DGYThX2YJYyXx2dzH1sAROkA9nKk
         MFOMuhKfLXswioe5ULJzFQa56WhemfuS/sKlso6H1cPQkXb6X10Y5zUh6T3fOybXungd
         lbZNoceMTRqZc7A0OKP1jlEIdvedjjK9HBr0yAhJuh9/LVGSTN+IzPsq2YZTxSjXkzbK
         U3VSFsRZHs2FYEF4EtNtI8cQeskkEnexqegQkleTgE7eSY3FvQBMn7EdDotmGClOeq69
         KhAQ==
X-Gm-Message-State: AO0yUKWqJHLfMMdFdJtNuphQGygKRuBU664jHJWARzqxqJhztBkQ2ewv
        CWbrnJdXHLtvrzuAIzOuiv9QsjMusBs=
X-Google-Smtp-Source: AK7set8fYsaQCbM2zCy5U4feulBO7zueWAAnuFpg0J2NWj52gUksGeJoaYooLflcdstLioF1BAP5PU4cM5I=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:864b:b0:1a0:527b:9189 with SMTP id
 y11-20020a170902864b00b001a0527b9189mr1783844plt.11.1679534085586; Wed, 22
 Mar 2023 18:14:45 -0700 (PDT)
Date:   Wed, 22 Mar 2023 18:14:44 -0700
In-Reply-To: <ZBuj5U29Pv2ak47u@google.com>
Mime-Version: 1.0
References: <20230227084016.3368-1-santosh.shukla@amd.com> <ZBuj5U29Pv2ak47u@google.com>
Message-ID: <ZBuoBOIcQhQ9ehTF@google.com>
Subject: Re: [PATCHv4 00/11] SVM: virtual NMI
From:   Sean Christopherson <seanjc@google.com>
To:     Santosh Shukla <santosh.shukla@amd.com>
Cc:     kvm@vger.kernel.org, pbonzini@redhat.com, jmattson@google.com,
        joro@8bytes.org, linux-kernel@vger.kernel.org,
        mail@maciej.szmigiero.name, mlevitsk@redhat.com,
        thomas.lendacky@amd.com, vkuznets@redhat.com
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 22, 2023, Sean Christopherson wrote:
> On Mon, Feb 27, 2023, Santosh Shukla wrote:
> > Maxim Levitsky (2):
> >   KVM: nSVM: Raise event on nested VM exit if L1 doesn't intercept IRQs
> >   KVM: SVM: add wrappers to enable/disable IRET interception
> > 
> > Santosh Shukla (6):
> >   KVM: nSVM: Don't sync vmcb02 V_IRQ back to vmcb12 if KVM (L0) is
> >     intercepting VINTR
> >   KVM: nSVM: Disable intercept of VINTR if saved RFLAG.IF is 0
> >   x86/cpu: Add CPUID feature bit for VNMI
> >   KVM: SVM: Add VNMI bit definition
> >   KVM: x86: add support for delayed virtual NMI injection interface
> >   KVM: nSVM: implement support for nested VNMI
> > 
> > Sean Christopherson (3):
> >   KVM: x86: Raise an event request when processing NMIs if an NMI is
> >     pending
> >   KVM: x86: Tweak the code and comment related to handling concurrent
> >     NMIs
> >   KVM: x86: Save/restore all NMIs when multiple NMIs are pending
> > 
> >  arch/x86/include/asm/cpufeatures.h |   1 +
> >  arch/x86/include/asm/kvm-x86-ops.h |   2 +
> >  arch/x86/include/asm/kvm_host.h    |  11 ++-
> >  arch/x86/include/asm/svm.h         |   9 ++
> >  arch/x86/kvm/svm/nested.c          |  94 +++++++++++++++---
> >  arch/x86/kvm/svm/svm.c             | 152 +++++++++++++++++++++++------
> >  arch/x86/kvm/svm/svm.h             |  28 ++++++
> >  arch/x86/kvm/x86.c                 |  46 +++++++--
> >  8 files changed, 289 insertions(+), 54 deletions(-)
> 
> Code looks good overall, I'll fixup the changelogs and comments myself.  I just
> need to run it through my usual test flow, which I should get done tomorrow.

Gah, saw something shiny and forgot to finish my thought.

My plan is to get this somewhat speculatively applied and soaking in linux-next asap,
even though the cpufeatures.h change needs more eyeballs.  I'll fixup and force push
if necessary; unless I'm missing something, this is the only SVM specific series
that's destined for 6.4.
