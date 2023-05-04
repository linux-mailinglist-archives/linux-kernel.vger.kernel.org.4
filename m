Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D239D6F6EF7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 17:35:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbjEDPfC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 11:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230310AbjEDPfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 11:35:00 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FC25E54
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 08:34:59 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id 98e67ed59e1d1-24e3e52228cso354339a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 08:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683214498; x=1685806498;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pQ9tDaHwuNjMEaIcEge2FkZR+GruLElSn+p2QqhZgdw=;
        b=lzEff1KQKCUWqah8wMan4YtymdhMXv2goOSxQeVT1Tc+G/I9KZn7PVilbar6Ibhu+l
         WUDTrRkT+iSklflz+d8+ux6Iec4EpbTfiCPCwRviUaBc5UryB8PgDKGb+I7O1Bdh/EW8
         yZaOil60zjIQn1IdFZRoJPlXZHCXE9ioihZS6YVrwaTn1ES+XECIaqq2u6Rwlj6j+icD
         9V2VsVNMHPuEZwabMOYC2J3zdwdMpjjdYBdOKkBBMtAYSWT5cbuVIm+0p3S55IoI4//l
         MLBeS79uqY6047S8jkkIIIcqQckIC2pDHqNxS0pBwiMfIwXts5aOIbaWPgJO4LVu1jzq
         Fd5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683214498; x=1685806498;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pQ9tDaHwuNjMEaIcEge2FkZR+GruLElSn+p2QqhZgdw=;
        b=ISwA+M2jILfx5tXN3zSqri5OK9gKWIkMwCAM6BL2WUTKFgKBs6tQWQSdbh40VB5CXj
         PRF4fBJkZqyNAIskOTUnSMma8v55zK7WaqutklOBYR3kpui5UMiGuOFMzgDb4NQ+O2vw
         EQ07lVr9fq97UHQqiiuSCA9zMc0eZkvtvXdNHBXcOwKCv4Dd0WAKjdx7wdqEVXgyAllP
         Smwz2B51YzqAMafwM3aPC1ZBvZFr9BBGZwDttnV+FEtXDZm7vPYss8eM0T6Az7npkz9k
         SstM008c143asRMNm9AOZ6vBgcKbN3iAy5+IKjBDuiBFXpw9ECq4ddV552pV9sVe8cmn
         mL5A==
X-Gm-Message-State: AC+VfDyrYQEn7F9ChzsIzAacKCd7lvPoX3E4GWtfvjLRvTE89OvEtviD
        3Xm1s5fzhtR91KPf924PCsTgejPeKyk=
X-Google-Smtp-Source: ACHHUZ5NFd7AM9dlhI6C/9eAeqToTuGykksiCoHvLDIY0QGbwAdwqx7xIMg6c3GGHzcU04fX/jWDBB7YjCw=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:9dc8:b0:24e:1b1d:edd3 with SMTP id
 x8-20020a17090a9dc800b0024e1b1dedd3mr716932pjv.1.1683214498595; Thu, 04 May
 2023 08:34:58 -0700 (PDT)
Date:   Thu, 4 May 2023 08:34:57 -0700
In-Reply-To: <06715227566b520d4a445466f091dc28a0b8cd95.camel@intel.com>
Mime-Version: 1.0
References: <20230503182852.3431281-1-seanjc@google.com> <20230503182852.3431281-3-seanjc@google.com>
 <06715227566b520d4a445466f091dc28a0b8cd95.camel@intel.com>
Message-ID: <ZFPQodNs0Cn9YDXT@google.com>
Subject: Re: [PATCH 2/5] KVM: SVM: Use kvm_pat_valid() directly instead of kvm_mtrr_valid()
From:   Sean Christopherson <seanjc@google.com>
To:     Kai Huang <kai.huang@intel.com>
Cc:     "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "guoke@uniontech.com" <guoke@uniontech.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "haiwenyao@uniontech.com" <haiwenyao@uniontech.com>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 03, 2023, Kai Huang wrote:
> > for better or worse, KVM doesn't apply the "zap
> > SPTEs" logic to guest PAT changes when the VM has a passthrough device
> > with non-coherent DMA.
> 
> Is it a bug?

No.  KVM's MTRR behavior is using a heuristic to try not to break the VM: if the
VM has non-coherent DMA, then honor UC mapping in the MTRRs as such mappings may
be coverage the non-coherent DMA.

From vmx_get_mt_mask():

	/* We wanted to honor guest CD/MTRR/PAT, but doing so could result in
	 * memory aliases with conflicting memory types and sometimes MCEs.
	 * We have to be careful as to what are honored and when.

The PAT is problematic because it is referenced via the guest PTEs, versus the
MTRRs being tied to the guest physical address, e.g. different virtual mappings
for the same physical address can yield different memtypes via the PAT.  My head
hurts just thinking about how that might interact with shadow paging :-)

Even the MTRRs are somewhat sketchy because they are technically per-CPU, i.e.
two vCPUs could have different memtypes for the same physical address.  But in
practice, sane software/firmware uses consistent MTRRs across all CPUs.
