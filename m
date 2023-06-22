Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5D5173ACD7
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 01:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbjFVXC3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 19:02:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbjFVXC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 19:02:27 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D86611FE9
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 16:02:26 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id d2e1a72fcca58-666e5f0d639so3226003b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 16:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687474946; x=1690066946;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dwOZB2F2j/n3w311Ll4nWUCZookZM7sJQjs3o89OMeU=;
        b=LEzu3lyvLYv4Wqijg+5QDmA5P7hc8M+w/bm+sI4Bd3u9jFAU1Tcs7saSDd/dBD+V6x
         kj7/ylCCvAINF9YVTQWF9g2jkbOwmZMLsO/+uipgjnfXKNqm/HRerRuvcIbrJ4JyrlPR
         O5a+OUcKTUJ1uN4aRDXBHP27imJrvb4AcwxYTC2Q8cUtPX93ee/AzXLW+DN+cjBA5DZX
         vdNGDaec7c+0u+x5wDj9Pd3Ee7TxNrxIhnfHBVztDqAYjQ1jFmikQadxyBcrrLxxYjCG
         rKp/oKk1iCD18pLehI/fg/vCnyTckOMikBHegPc9QqEtXrrX/jqeshisfTjcm8y5Conj
         J56A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687474946; x=1690066946;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dwOZB2F2j/n3w311Ll4nWUCZookZM7sJQjs3o89OMeU=;
        b=DynkzKdcjYfLoMQng5A6nBsi/cVqg6JU0f9FUDLC5hLWubt/ZFVGj+MCsaRGwZnXz3
         ob+IpY/hsO71xqjmLlOuwlL1dYCdwI7g0aKJFtttdiZH/TMi6TD0h3VFimhdVwn+jYZN
         /8Z6sY/vB8nHDly5mUsUYzBj3wNzLZT4Jua8LMHvR5BMxP4Z2WcYORFVxq3feHW/IkBi
         suvTE9e/JFuju/gkt3uFbcEDOqPCtWCuvbU3Sqv22yXRhr5Y1ddIVgvuoWqPoYYMWD5F
         RVbObodgTq96GvfxlQcwiBO104kexCKXjTWjfbIGkKSPrLOb9EK9ewkDQ411wrvJH/nV
         Thiw==
X-Gm-Message-State: AC+VfDz2FCGWK5yyhULVCw8iikwMvEPTlXnjzuJZ+bKi4WT8GoGRUW3B
        9i0WRPu2tcJsPi7wnByOj6ezke1k70Q=
X-Google-Smtp-Source: ACHHUZ5/FMaaXbIH8exGlyiCILCKS3oq8tcYYgoPtaRsbJoXmqDCEjpatDN5N6bhIDuNI9eRHYK5m8n2bUY=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:2386:b0:668:70cd:5b37 with SMTP id
 f6-20020a056a00238600b0066870cd5b37mr4528176pfc.5.1687474946401; Thu, 22 Jun
 2023 16:02:26 -0700 (PDT)
Date:   Thu, 22 Jun 2023 16:02:24 -0700
In-Reply-To: <20230617034500.djk5nhmpxony3ngp@linux.intel.com>
Mime-Version: 1.0
References: <20230602011518.787006-1-seanjc@google.com> <20230602011518.787006-2-seanjc@google.com>
 <20230607073728.vggwcoylibj3cp6s@linux.intel.com> <ZICUbIF2+Cvbb9GM@google.com>
 <20230607172243.c2bkw43hcet4sfnb@linux.intel.com> <ZIDENf2vzwUjzcl2@google.com>
 <20230608070016.f3dz6dhvdkxsomdb@linux.intel.com> <ZIi+jWxYg/UhKpr1@google.com>
 <20230617034500.djk5nhmpxony3ngp@linux.intel.com>
Message-ID: <ZJTTAKFi36sGTX/M@google.com>
Subject: Re: [PATCH 1/3] KVM: VMX: Retry APIC-access page reload if
 invalidation is in-progress
From:   Sean Christopherson <seanjc@google.com>
To:     Yu Zhang <yu.c.zhang@linux.intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@nvidia.com>,
        Alistair Popple <apopple@nvidia.com>,
        Robin Murphy <robin.murphy@arm.com>
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

On Sat, Jun 17, 2023, Yu Zhang wrote:
> > 
> > > and the backing page is being reclaimed in L0? I saw
> > > nested_get_vmcs12_pages() will check vmcs12 and set the APIC access address
> > > in VMCS02, but not sure if this routine will be triggered by the mmu
> > > notifier...
> > 
> > Pages from vmcs12 that are referenced by physical address in the VMCS are pinned
> > (where "pinned" means KVM holds a reference to the page) by kvm_vcpu_map().  I.e.
> > the page will not be migrated, and if userspace unmaps the page, userspace might
> > break its VM, but that's true for any guest memory that userspace unexpectedly
> > unmaps, and there won't be any no use-after-free issues.
> > 
> Thanks, Sean. 
> 
> About the kvm_vcpu_map(), is it necessary for APIC access address?

No, not strictly necessary.

> L0 only needs to get its pfn, and does not care about the hva or struct page. Could
> we just use gfn_to_pfn() to retrieve the pfn, and kvm_release_pfn_clean() to
> unpin it later? 

Yep, that would suffice.  The main reason I converted the APIC access page to use
kvm_vcpu_map()[1] was that it was easiest way to play nice with struct page memory.

I don't think this is worth doing right now, as the practical downside is really
just that setups that hide memory from the kernel do an unnecessary memremap().
I'd much prefer to "fix" this wart when we (hopefully) overhaul all these APIs[2].

[1] fe1911aa443e ("KVM: nVMX: Use kvm_vcpu_map() to get/pin vmcs12's APIC-access page")
[2] https://lore.kernel.org/all/ZGvUsf7lMkrNDHuE@google.com
