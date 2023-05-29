Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E4957148EE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 13:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231551AbjE2LxO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 07:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjE2LxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 07:53:13 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38EC9A7
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 04:53:10 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3f7024e66adso26065e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 04:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685361188; x=1687953188;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=F/MfaelNqtQBP6naWW/Q8FYG4SycXGz/is5hDp0qb9M=;
        b=scFJGwhlo9/wGvLt4pReEDL39IPenWEelL6T4PZyAvOC0Bm7leCEOpe7TawDzkzMWO
         tjyrnXh0FaSfoAWFLrGq+015BfySTxNjUZngLTz+vgpCccTEbwl+7MOjiuDXJbXPmI2g
         N4ndlIvwo2Avh0FsEzTj1QetwDOk71+1FlG/wdu+ZRkgv6dEdapW+2/i5G07Je967Vfl
         K1snB8YlNIwBnVmngJB5IUe4z2RlFwnsYKZId6FskW+N0DFmi0TrbAasks6rH/fzhOg5
         PEZmtEoO4LIzuGDViiV5fBQgfwuI0MZ77XbkzwX7Fr2rcifsyyq7s2AoyBZpRODDJHhp
         y7Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685361188; x=1687953188;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F/MfaelNqtQBP6naWW/Q8FYG4SycXGz/is5hDp0qb9M=;
        b=NStAA31gpiwY0/Gi309HJTXhJmeWedukNvGMAujlK7+V/H/SIPlEeEQWm3jJtlfTx2
         BDLdi2nCZz39K9PWBWmrC0rKFVG116Nxsu2F6hj07M3F5lbXkkDLkTkls1QFN9GBvn7M
         D2P0TzoqZNFfmP5U27W/Td7vBjY5ei9zbu7bC3qZruxNQvF5swqK/2RZILQKp82vyF1E
         8orL+iNd5GV10UlFICPV/YddrrMuW0DNfnK6n50bIeBnBNuMeGZVdy/LKPEfQsQUu5bR
         bv06G1Wdul/vwyudsQD+bPdcX1Vijka86+rPW6MnzpXCYGX3V1Sq5smWNqqdQQLDIRo5
         BHBQ==
X-Gm-Message-State: AC+VfDwjoZE/hwOOepuiMjr+svkHM+1Qavc3Sl7BAt0WTDECsyd70Jez
        K7TFBSpx/mxv/qoI+VddD4qmtg==
X-Google-Smtp-Source: ACHHUZ5Un8NV2EPkxSQnjL4CQAt0cHv7IZrd4pkQ7C7tugmbRZe6sVt+2deC4HhzwiuE/YEXfM3Ytw==
X-Received: by 2002:a05:600c:1ca9:b0:3f1:6839:74a1 with SMTP id k41-20020a05600c1ca900b003f1683974a1mr454287wms.6.1685361188544;
        Mon, 29 May 2023 04:53:08 -0700 (PDT)
Received: from google.com (44.232.78.34.bc.googleusercontent.com. [34.78.232.44])
        by smtp.gmail.com with ESMTPSA id r8-20020adfdc88000000b003077f3dfcc8sm13427072wrj.32.2023.05.29.04.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 May 2023 04:53:08 -0700 (PDT)
Date:   Mon, 29 May 2023 11:53:03 +0000
From:   Mostafa Saleh <smostafa@google.com>
To:     Oliver Upton <oliver.upton@linux.dev>
Cc:     maz@kernel.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org,
        tabba@google.com, qperret@google.com, will@kernel.org,
        catalin.marinas@arm.com, yuzenghui@huawei.com,
        suzuki.poulose@arm.com, james.morse@arm.com, bgardon@google.com,
        gshan@redhat.com
Subject: Re: [PATCH v2] KVM: arm64: Use BTI for nvhe
Message-ID: <ZHSSHwJ4EPAOuUC7@google.com>
References: <20230517173552.163711-1-smostafa@google.com>
 <ZHELoziooIyk0d+t@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZHELoziooIyk0d+t@linux.dev>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oliver,

On Fri, May 26, 2023 at 07:42:27PM +0000, Oliver Upton wrote:
> Hi Mostafa,
> 
> On Wed, May 17, 2023 at 05:35:52PM +0000, Mostafa Saleh wrote:
> > CONFIG_ARM64_BTI_KERNEL compiles the kernel to support ARMv8.5-BTI.
> > However, the nvhe code doesn't make use of it as it doesn't map any
> > pages with Guarded Page(GP) bit.
> > 
> > This patch maps nvhe(and pKVM recreated mapping of) .text section
> > with GP bit which matches the kernel handling for BTI.
> > 
> > A new flag is added to enum kvm_pgtable_prot: KVM_PGTABLE_PROT_GP_S1,
> > which represents BTI guarded page in hypervisor stage-1 page table.
> > 
> > At hyp init, SCTLR_EL2.BT is set to 1 to match EL1 configuration
> > (SCTLR_EL1.BT1) set in bti_enable().
> > 
> > hyp_init_valid_leaf_pte is added to avoid unnecessary considering GP
> > bit for stage-2.
> > 
> > Signed-off-by: Mostafa Saleh <smostafa@google.com>
> > ---
> > v1 -> v2:
> > - Enable BTI for nvhe also.
> > - Only set GP bit for executable pages from pgtable code.
> > - Set SCTLR_EL2.BT when BTI is used.
> > - use system_supports_bti() for consistency.
> > - Add hyp_init_valid_leaf_pte.
> > v1: https://lore.kernel.org/all/20230516141846.792193-1-smostafa@google.com/
> > ---
> >  arch/arm64/include/asm/kvm_pgtable.h |  3 +++
> >  arch/arm64/include/asm/sysreg.h      |  1 +
> >  arch/arm64/kvm/arm.c                 |  7 ++++++-
> >  arch/arm64/kvm/hyp/nvhe/hyp-init.S   |  7 +++++++
> >  arch/arm64/kvm/hyp/nvhe/setup.c      |  8 ++++++--
> >  arch/arm64/kvm/hyp/pgtable.c         | 11 ++++++++++-
> >  6 files changed, 33 insertions(+), 4 deletions(-)
> > 
> > diff --git a/arch/arm64/include/asm/kvm_pgtable.h b/arch/arm64/include/asm/kvm_pgtable.h
> > index 4cd6762bda80..5bcd06d664d3 100644
> > --- a/arch/arm64/include/asm/kvm_pgtable.h
> > +++ b/arch/arm64/include/asm/kvm_pgtable.h
> > @@ -151,6 +151,7 @@ enum kvm_pgtable_stage2_flags {
> >   * @KVM_PGTABLE_PROT_W:		Write permission.
> >   * @KVM_PGTABLE_PROT_R:		Read permission.
> >   * @KVM_PGTABLE_PROT_DEVICE:	Device attributes.
> > + * @KVM_PGTABLE_PROT_GP_S1:	GP(guarded page) used for BTI in stage-1 only
> >   * @KVM_PGTABLE_PROT_SW0:	Software bit 0.
> >   * @KVM_PGTABLE_PROT_SW1:	Software bit 1.
> >   * @KVM_PGTABLE_PROT_SW2:	Software bit 2.
> > @@ -163,6 +164,8 @@ enum kvm_pgtable_prot {
> >  
> >  	KVM_PGTABLE_PROT_DEVICE			= BIT(3),
> >  
> > +	KVM_PGTABLE_PROT_GP_S1			= BIT(50),
> > +
> 
> This enumeration is used to generically describe permissions that could
> be applied to either stage-1 or stage-2.
> 
> Can't we just have KVM_PGTABLE_PROT_X imply GP at hyp stage-1, assuming
> BTI is available and we're using it for the kernel?

I see it should be fine if we use GP for executable pages in EL2.
This was trying to follow the kernel in map_kernel(), where it checks
and passes the GP bit explicitly for the text section.
But nvhe use cases are much simpler and maybe we can imply that from
KVM_PGTABLE_PROT_X.

> >  	KVM_PGTABLE_PROT_SW0			= BIT(55),
> >  	KVM_PGTABLE_PROT_SW1			= BIT(56),
> >  	KVM_PGTABLE_PROT_SW2			= BIT(57),
> 
> [...]
> 
> > diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
> > index 3d61bd3e591d..9f68e4ce6d14 100644
> > --- a/arch/arm64/kvm/hyp/pgtable.c
> > +++ b/arch/arm64/kvm/hyp/pgtable.c
> > @@ -152,6 +152,13 @@ static kvm_pte_t kvm_init_valid_leaf_pte(u64 pa, kvm_pte_t attr, u32 level)
> >  	return pte;
> >  }
> >  
> > +static kvm_pte_t hyp_init_valid_leaf_pte(u64 pa, kvm_pte_t attr, u32 level)
> > +{
> > +	kvm_pte_t pte = kvm_init_valid_leaf_pte(pa, attr, level);
> > +
> > +	return pte | (attr & KVM_PGTABLE_PROT_GP_S1);
> 
> This is a bit of a hack to cram the GP bit back in. I'm guessing the
> fact that our ATTR_HI mask doesn't include bit 50 led you here.
> 
> My interpretation DDI0487J D8.3.2 is that the upper attribute field is
> 63:50 for both stages of translation, but bit 50 is RES0 for stage-2.
> 
> So, rather than going this route, I'd recommend tweaking the ATTR_HI
> mask to include bit 50.
Extending ATTR_HI would simplify the code, I will update it in v3.
I was a bit hesitant as it is shared with stage-2 and BIT(50) is not
used there, but I can't see any obvious problems with this.

> > +}
> > +
> >  static kvm_pte_t kvm_init_invalid_leaf_owner(u8 owner_id)
> >  {
> >  	return FIELD_PREP(KVM_INVALID_PTE_OWNER_MASK, owner_id);
> > @@ -371,6 +378,8 @@ static int hyp_set_prot_attr(enum kvm_pgtable_prot prot, kvm_pte_t *ptep)
> >  
> >  		if (device)
> >  			return -EINVAL;
> > +
> > +		attr |= prot & KVM_PGTABLE_PROT_GP_S1;
> 
> With the above suggestions, this would become:
> 
> 		if (IS_ENABLED(CONFIG_ARM64_BTI_KERNEL) && system_supports_bti())
> 			attr |= KVM_PTE_LEAF_ATTR_HI_S1_GP;
> 
> >  	} else {
> >  		attr |= KVM_PTE_LEAF_ATTR_HI_S1_XN;
> >  	}
> > @@ -414,7 +423,7 @@ static bool hyp_map_walker_try_leaf(const struct kvm_pgtable_visit_ctx *ctx,
> >  		return false;
> >  
> >  	data->phys += granule;
> > -	new = kvm_init_valid_leaf_pte(phys, data->attr, ctx->level);
> > +	new = hyp_init_valid_leaf_pte(phys, data->attr, ctx->level);
> >  	if (ctx->old == new)
> >  		return true;
> >  	if (!kvm_pte_valid(ctx->old))
> > -- 
> > 2.40.1.698.g37aff9b760-goog
> > 
> 
> -- 
> Thanks,
> Oliver
Thanks,
Mostafa
