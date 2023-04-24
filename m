Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E7DC6ED1BF
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 17:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231866AbjDXPvx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 11:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbjDXPvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 11:51:51 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55C41E1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 08:51:50 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id 98e67ed59e1d1-246819e2cdaso4562893a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 08:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682351510; x=1684943510;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jtSUeuCkwFR5o9I94yYcCoz20ACvzd68ye5sBnm4VyI=;
        b=H1ijR7UE/3KIVe/zpESfqf8ex9Yh+rK/GGtg6nGEheB0BmipgBSBTp7H6p2VnibeMd
         H0iWfBu7ZV24ETrjrSSNaNavlJOjqTR9RIx281EJZej6/mlOcy3Wmtz038RtymvYqmmw
         rZPl5BNouEtiW4Xq8kqyRr2HSeNV2IA286Rtta5JkRlDMHoeTyE8WynK8TaSs1wYMLPn
         fjO3wScNWdGBu6Yno8qNZPc9cWhDU+tJoGTAO7v6GCZYj+Aq7qA95KhqUcqSHLXidx4H
         IUs/RqX80xXkdkaqTd+vX0H3Q2MkhExajcheg9Nn2td+mUPlKpc/OezTlJK3tFY2tl+D
         zKhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682351510; x=1684943510;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jtSUeuCkwFR5o9I94yYcCoz20ACvzd68ye5sBnm4VyI=;
        b=ECOGwF3frk/mt23DZlIbYZAezkYhO8YvowSQPs0Fnu9ZWvLaC62azzDjwZYlP0Hs6L
         NCihSPywdRf2bh16xk7SHmM3z1lOKWXcgluXJHrRhqwlbFENhVdBvcClSTmzHnbxohqh
         24WvyA4303wZLVejF/BdYpHdxB+vfape9oHH/NlcWzI5mDuvm5RfqUnY+sLDsqsNt75V
         H0WNMPvGaB3h8q/L0GB0VNB/RkDxG90dHb0LtqAUTHHPjMr0cv7ZGILfUZGTqMJney2j
         X6xfQoIcQTBADN9gmdA9HQbLFglrHM9ah4hhpQleQ5J6MGtv88C300QUp/aqz4qUxbkV
         oNBw==
X-Gm-Message-State: AAQBX9cE26A1RY/Lu+Tw+dK1UMFCGhN+fdaqOsQ9UkJlSoDfV11IVMf7
        /nR9I4aGmngnWE3DT0ThRDU9UAFD4bA=
X-Google-Smtp-Source: AKy350bbdh+Ihp0N09viUjEVVR+Tbs0JLwUQngZeZz2fNHKtuBjHMV6nOn75eC0gw6MmjsvH87TBadNjEm4=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:410d:b0:246:a74f:fd73 with SMTP id
 u13-20020a17090a410d00b00246a74ffd73mr3408751pjf.6.1682351509797; Mon, 24 Apr
 2023 08:51:49 -0700 (PDT)
Date:   Mon, 24 Apr 2023 08:51:48 -0700
In-Reply-To: <20230422111834.00003689@gmail.com>
Mime-Version: 1.0
References: <cover.1678643051.git.isaku.yamahata@intel.com>
 <23cc6df6ec2ca776c3efe148e70ba290aa3de319.1678643052.git.isaku.yamahata@intel.com>
 <20230422111834.00003689@gmail.com>
Message-ID: <ZEallJHJnG9HJDNy@google.com>
Subject: Re: [PATCH v13 048/113] KVM: x86/mmu: Disallow dirty logging for x86 TDX
From:   Sean Christopherson <seanjc@google.com>
To:     Zhi Wang <zhi.wang.linux@gmail.com>
Cc:     isaku.yamahata@intel.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, isaku.yamahata@gmail.com,
        Paolo Bonzini <pbonzini@redhat.com>, erdemaktas@google.com,
        Sagi Shahar <sagis@google.com>,
        David Matlack <dmatlack@google.com>,
        Kai Huang <kai.huang@intel.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Michael Roth <michael.roth@amd.com>
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

On Sat, Apr 22, 2023, Zhi Wang wrote:
> On Sun, 12 Mar 2023 10:56:12 -0700
> isaku.yamahata@intel.com wrote:
> 
> > From: Isaku Yamahata <isaku.yamahata@intel.com>
> > 
> > TDX doesn't support dirty logging.  Report dirty logging isn't supported so
> > that device model, for example qemu, can properly handle it.  Silently
> > ignore on dirty logging on private GFNs of TDX.

...

> > +bool kvm_arch_dirty_log_supported(struct kvm *kvm)
> > +{
> > +	return kvm->arch.vm_type != KVM_X86_PROTECTED_VM;
> > +}
> > +
> 
> Maybe introduce a new x86 ops for SNP/TDX to check this separately as SNP
> might still support it? With the current approach, I think both SNP/TDX
> will be affected. So does the later patch about page-tracking.

This patch is unnecessary, the plan is to disallow dirty logging on memslots that
support private mapping, e.g. we'll end up with something like this:

static int check_memory_region_flags(struct kvm *kvm,
				     const struct kvm_userspace_memory_region2 *mem)
{
	u32 valid_flags = KVM_MEM_LOG_DIRTY_PAGES;

	if (kvm_arch_has_private_mem(kvm))
		valid_flags |= KVM_MEM_PRIVATE;

	/* Dirty logging private memory is not currently supported. */
	if (mem->flags & KVM_MEM_PRIVATE)
		valid_flags &= ~KVM_MEM_LOG_DIRTY_PAGES;

#ifdef __KVM_HAVE_READONLY_MEM
	valid_flags |= KVM_MEM_READONLY;
#endif

	if (mem->flags & ~valid_flags)
		return -EINVAL;

	return 0;
}

> Michael, can you confirm this?

No need to confirm (or deny) at this point, enabling dirty logging for private
memory is not something I want to merge in the initial TDX/SNP series, regardless
of whether or not it's supported by "hardware", a.k.a. trusted firmware.
