Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8B5160B7BB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 21:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232940AbiJXTbP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 15:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233836AbiJXTaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 15:30:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74E401C77E1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 11:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666634411;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=phB/V5Y6/oBzz6XswfD29phsIzdRUAcXANgXmuPf+yM=;
        b=TInasE7hPCqdtavyfZHIGgQ4TgisEFPqzUIXh2jQI3QsFRiq1BRevUPPoi4pkL1z0BjfBZ
        vlx4qPkQrFmPhOLW3xZeMvNuy3NU6NINL9XDXTLHs85sC4p/k5X7YR1c51m/XqlZoU1QvY
        4ZX6QFj/u8eRlF9B2sxw1Jj5FEPsWEY=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-18-tu6HLUpJOim6ay4k1LdY7w-1; Mon, 24 Oct 2022 08:32:33 -0400
X-MC-Unique: tu6HLUpJOim6ay4k1LdY7w-1
Received: by mail-qt1-f200.google.com with SMTP id a19-20020a05622a02d300b0039a3711179dso6951810qtx.12
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 05:32:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=phB/V5Y6/oBzz6XswfD29phsIzdRUAcXANgXmuPf+yM=;
        b=W13QSIaCY4UNX2O2o8J6NcIRiXNY53F5sxxPk9uVDB9OMTiFl9WI2satQKmFnGggjj
         m8blPn1dNvf0748ty49H6ogF/u2rilFyERazO+pvyn2fnlvhx13zvtVdq3n+HWjoZX15
         Gb243nGb3ANBaGqJnr7d0OaFwhMtH+P62ms0DvMd9fk7j4Umkm+EX8+E19iofNnU3uXW
         /4hGdQHQzMb9a5ddy+76ZqJgE10r0iBfunCW0mytvxLe+HfuzF6q7lu2NHd1Kv8UXflZ
         Hb4VnJTsWkmLSzGfq3nZ61Xe7DaRVxUJbTIdex/uP4FboRWPW/ojy29P++smSoFqUbJh
         A8jg==
X-Gm-Message-State: ACrzQf32xHoyasALgMwHj4LllnLTCbGoWzeN8dSeE0De68K9SdNv9HqS
        /v4+Jx80viPWWjWs2RNbfZXWTF6kFUbI9grpj7QDjXOyesIQM1hsLpg+J6wqx6D+8xJLGMLJCl4
        naTXm++gYg004teaboXlfIfwZ
X-Received: by 2002:a05:622a:15cd:b0:39d:1b71:efc6 with SMTP id d13-20020a05622a15cd00b0039d1b71efc6mr15541496qty.225.1666614749968;
        Mon, 24 Oct 2022 05:32:29 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4xcfsuedgCI7adWCYVVmtxmkRDc0Uys9vABJ9766173g8so0xwwwY1i50fWSmi7cOfV2AYtA==
X-Received: by 2002:a05:622a:15cd:b0:39d:1b71:efc6 with SMTP id d13-20020a05622a15cd00b0039d1b71efc6mr15541464qty.225.1666614749552;
        Mon, 24 Oct 2022 05:32:29 -0700 (PDT)
Received: from [10.35.4.238] (bzq-82-81-161-50.red.bezeqint.net. [82.81.161.50])
        by smtp.gmail.com with ESMTPSA id f3-20020a05620a408300b006ce515196a7sm15072472qko.8.2022.10.24.05.32.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 05:32:29 -0700 (PDT)
Message-ID: <75f70eb0daa03553671925e2daa95cdc5b83963c.camel@redhat.com>
Subject: Re: [PATCH v2 4/8] KVM: x86: do not go through ctxt->ops when
 emulating rsm
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     seanjc@google.com, maciej.szmigiero@oracle.com
Date:   Mon, 24 Oct 2022 15:32:26 +0300
In-Reply-To: <20220929172016.319443-5-pbonzini@redhat.com>
References: <20220929172016.319443-1-pbonzini@redhat.com>
         <20220929172016.319443-5-pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-5.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-09-29 at 13:20 -0400, Paolo Bonzini wrote:
> Now that RSM is implemented in a single emulator callback, there is no
> point in going through other callbacks for the sake of modifying
> processor state.  Just invoke KVM's own internal functions directly,
> and remove the callbacks that were only used by em_rsm; the only
> substantial difference is in the handling of the segment registers
> and descriptor cache, which have to be parsed into a struct kvm_segment
> instead of a struct desc_struct.
> 
> This also fixes a bug where emulator_set_segment was shifting the
> limit left by 12 if the G bit is set, but the limit had not been
> shifted right upon entry to SMM.
> 
> The emulator context is still used to restore EIP and the general
> purpose registers.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  arch/x86/kvm/kvm_emulate.h |  13 ---
>  arch/x86/kvm/smm.c         | 177 +++++++++++++++++--------------------
>  arch/x86/kvm/x86.c         |  33 -------
>  3 files changed, 81 insertions(+), 142 deletions(-)
> 
> diff --git a/arch/x86/kvm/kvm_emulate.h b/arch/x86/kvm/kvm_emulate.h
> index d7afbc448dd2..84b1f2661463 100644
> --- a/arch/x86/kvm/kvm_emulate.h
> +++ b/arch/x86/kvm/kvm_emulate.h
> @@ -116,16 +116,6 @@ struct x86_emulate_ops {
>  			unsigned int bytes,
>  			struct x86_exception *fault, bool system);
>  
> -	/*
> -	 * read_phys: Read bytes of standard (non-emulated/special) memory.
> -	 *            Used for descriptor reading.
> -	 *  @addr:  [IN ] Physical address from which to read.
> -	 *  @val:   [OUT] Value read from memory.
> -	 *  @bytes: [IN ] Number of bytes to read from memory.
> -	 */
> -	int (*read_phys)(struct x86_emulate_ctxt *ctxt, unsigned long addr,
> -			void *val, unsigned int bytes);
> -
>  	/*
>  	 * write_std: Write bytes of standard (non-emulated/special) memory.
>  	 *            Used for descriptor writing.
> @@ -209,11 +199,8 @@ struct x86_emulate_ops {
>  	int (*cpl)(struct x86_emulate_ctxt *ctxt);
>  	void (*get_dr)(struct x86_emulate_ctxt *ctxt, int dr, ulong *dest);
>  	int (*set_dr)(struct x86_emulate_ctxt *ctxt, int dr, ulong value);
> -	u64 (*get_smbase)(struct x86_emulate_ctxt *ctxt);
> -	void (*set_smbase)(struct x86_emulate_ctxt *ctxt, u64 smbase);
>  	int (*set_msr_with_filter)(struct x86_emulate_ctxt *ctxt, u32 msr_index, u64 data);
>  	int (*get_msr_with_filter)(struct x86_emulate_ctxt *ctxt, u32 msr_index, u64 *pdata);
> -	int (*set_msr)(struct x86_emulate_ctxt *ctxt, u32 msr_index, u64 data);
>  	int (*get_msr)(struct x86_emulate_ctxt *ctxt, u32 msr_index, u64 *pdata);
>  	int (*check_pmc)(struct x86_emulate_ctxt *ctxt, u32 pmc);
>  	int (*read_pmc)(struct x86_emulate_ctxt *ctxt, u32 pmc, u64 *pdata);
> diff --git a/arch/x86/kvm/smm.c b/arch/x86/kvm/smm.c
> index 773e07b6397d..41ca128478fc 100644
> --- a/arch/x86/kvm/smm.c
> +++ b/arch/x86/kvm/smm.c
> @@ -271,71 +271,59 @@ void enter_smm(struct kvm_vcpu *vcpu)
>  	kvm_mmu_reset_context(vcpu);
>  }
>  
> -static int emulator_has_longmode(struct x86_emulate_ctxt *ctxt)
> -{
> -#ifdef CONFIG_X86_64
> -	return ctxt->ops->guest_has_long_mode(ctxt);
> -#else
> -	return false;
> -#endif
> -}
> -
> -static void rsm_set_desc_flags(struct desc_struct *desc, u32 flags)
> +static void rsm_set_desc_flags(struct kvm_segment *desc, u32 flags)
>  {
>  	desc->g    = (flags >> 23) & 1;
> -	desc->d    = (flags >> 22) & 1;
> +	desc->db   = (flags >> 22) & 1;
>  	desc->l    = (flags >> 21) & 1;
>  	desc->avl  = (flags >> 20) & 1;
> -	desc->p    = (flags >> 15) & 1;
> +	desc->present = (flags >> 15) & 1;
>  	desc->dpl  = (flags >> 13) & 3;
>  	desc->s    = (flags >> 12) & 1;
>  	desc->type = (flags >>  8) & 15;
> +
> +	desc->unusable = !desc->present;
> +	desc->padding = 0;
>  }
>  
> -static int rsm_load_seg_32(struct x86_emulate_ctxt *ctxt, const char *smstate,
> +static int rsm_load_seg_32(struct kvm_vcpu *vcpu, const char *smstate,
>  			   int n)
>  {
> -	struct desc_struct desc;
> +	struct kvm_segment desc;
>  	int offset;
> -	u16 selector;
> -
> -	selector = GET_SMSTATE(u32, smstate, 0x7fa8 + n * 4);
>  
>  	if (n < 3)
>  		offset = 0x7f84 + n * 12;
>  	else
>  		offset = 0x7f2c + (n - 3) * 12;
>  
> -	set_desc_base(&desc,      GET_SMSTATE(u32, smstate, offset + 8));
> -	set_desc_limit(&desc,     GET_SMSTATE(u32, smstate, offset + 4));
> +	desc.selector =           GET_SMSTATE(u32, smstate, 0x7fa8 + n * 4);
> +	desc.base =               GET_SMSTATE(u32, smstate, offset + 8);
> +	desc.limit =              GET_SMSTATE(u32, smstate, offset + 4);
>  	rsm_set_desc_flags(&desc, GET_SMSTATE(u32, smstate, offset));
> -	ctxt->ops->set_segment(ctxt, selector, &desc, 0, n);
> +	kvm_set_segment(vcpu, &desc, n);
>  	return X86EMUL_CONTINUE;
>  }
>  
>  #ifdef CONFIG_X86_64
> -static int rsm_load_seg_64(struct x86_emulate_ctxt *ctxt, const char *smstate,
> +static int rsm_load_seg_64(struct kvm_vcpu *vcpu, const char *smstate,
>  			   int n)
>  {
> -	struct desc_struct desc;
> +	struct kvm_segment desc;
>  	int offset;
> -	u16 selector;
> -	u32 base3;
>  
>  	offset = 0x7e00 + n * 16;
>  
> -	selector =                GET_SMSTATE(u16, smstate, offset);
> +	desc.selector =           GET_SMSTATE(u16, smstate, offset);
>  	rsm_set_desc_flags(&desc, GET_SMSTATE(u16, smstate, offset + 2) << 8);
> -	set_desc_limit(&desc,     GET_SMSTATE(u32, smstate, offset + 4));
> -	set_desc_base(&desc,      GET_SMSTATE(u32, smstate, offset + 8));
> -	base3 =                   GET_SMSTATE(u32, smstate, offset + 12);
> -
> -	ctxt->ops->set_segment(ctxt, selector, &desc, base3, n);
> +	desc.limit =              GET_SMSTATE(u32, smstate, offset + 4);
> +	desc.base =               GET_SMSTATE(u64, smstate, offset + 8);
> +	kvm_set_segment(vcpu, &desc, n);
>  	return X86EMUL_CONTINUE;
>  }
>  #endif
>  
> -static int rsm_enter_protected_mode(struct x86_emulate_ctxt *ctxt,
> +static int rsm_enter_protected_mode(struct kvm_vcpu *vcpu,
>  				    u64 cr0, u64 cr3, u64 cr4)
>  {
>  	int bad;
> @@ -348,7 +336,7 @@ static int rsm_enter_protected_mode(struct x86_emulate_ctxt *ctxt,
>  		cr3 &= ~0xfff;
>  	}
>  
> -	bad = ctxt->ops->set_cr(ctxt, 3, cr3);
> +	bad = kvm_set_cr3(vcpu, cr3);
>  	if (bad)
>  		return X86EMUL_UNHANDLEABLE;
>  
> @@ -357,20 +345,20 @@ static int rsm_enter_protected_mode(struct x86_emulate_ctxt *ctxt,
>  	 * Then enable protected mode.	However, PCID cannot be enabled
>  	 * if EFER.LMA=0, so set it separately.
>  	 */
> -	bad = ctxt->ops->set_cr(ctxt, 4, cr4 & ~X86_CR4_PCIDE);
> +	bad = kvm_set_cr4(vcpu, cr4 & ~X86_CR4_PCIDE);
>  	if (bad)
>  		return X86EMUL_UNHANDLEABLE;
>  
> -	bad = ctxt->ops->set_cr(ctxt, 0, cr0);
> +	bad = kvm_set_cr0(vcpu, cr0);
>  	if (bad)
>  		return X86EMUL_UNHANDLEABLE;
>  
>  	if (cr4 & X86_CR4_PCIDE) {
> -		bad = ctxt->ops->set_cr(ctxt, 4, cr4);
> +		bad = kvm_set_cr4(vcpu, cr4);
>  		if (bad)
>  			return X86EMUL_UNHANDLEABLE;
>  		if (pcid) {
> -			bad = ctxt->ops->set_cr(ctxt, 3, cr3 | pcid);
> +			bad = kvm_set_cr3(vcpu, cr3 | pcid);
>  			if (bad)
>  				return X86EMUL_UNHANDLEABLE;
>  		}
> @@ -383,9 +371,9 @@ static int rsm_enter_protected_mode(struct x86_emulate_ctxt *ctxt,
>  static int rsm_load_state_32(struct x86_emulate_ctxt *ctxt,
>  			     const char *smstate)
>  {
> -	struct desc_struct desc;
> +	struct kvm_vcpu *vcpu = ctxt->vcpu;
> +	struct kvm_segment desc;
>  	struct desc_ptr dt;
> -	u16 selector;
>  	u32 val, cr0, cr3, cr4;
>  	int i;
>  
> @@ -399,56 +387,55 @@ static int rsm_load_state_32(struct x86_emulate_ctxt *ctxt,
>  
>  	val = GET_SMSTATE(u32, smstate, 0x7fcc);
>  
> -	if (ctxt->ops->set_dr(ctxt, 6, val))
> +	if (kvm_set_dr(vcpu, 6, val))
>  		return X86EMUL_UNHANDLEABLE;
>  
>  	val = GET_SMSTATE(u32, smstate, 0x7fc8);
>  
> -	if (ctxt->ops->set_dr(ctxt, 7, val))
> +	if (kvm_set_dr(vcpu, 7, val))
>  		return X86EMUL_UNHANDLEABLE;
>  
> -	selector =                 GET_SMSTATE(u32, smstate, 0x7fc4);
> -	set_desc_base(&desc,       GET_SMSTATE(u32, smstate, 0x7f64));
> -	set_desc_limit(&desc,      GET_SMSTATE(u32, smstate, 0x7f60));
> +	desc.selector =            GET_SMSTATE(u32, smstate, 0x7fc4);
> +	desc.base =                GET_SMSTATE(u32, smstate, 0x7f64);
> +	desc.limit =               GET_SMSTATE(u32, smstate, 0x7f60);
>  	rsm_set_desc_flags(&desc,  GET_SMSTATE(u32, smstate, 0x7f5c));
> -	ctxt->ops->set_segment(ctxt, selector, &desc, 0, VCPU_SREG_TR);
> +	kvm_set_segment(vcpu, &desc, VCPU_SREG_TR);
>  
> -	selector =                 GET_SMSTATE(u32, smstate, 0x7fc0);
> -	set_desc_base(&desc,       GET_SMSTATE(u32, smstate, 0x7f80));
> -	set_desc_limit(&desc,      GET_SMSTATE(u32, smstate, 0x7f7c));
> +	desc.selector =            GET_SMSTATE(u32, smstate, 0x7fc0);
> +	desc.base =                GET_SMSTATE(u32, smstate, 0x7f80);
> +	desc.limit =               GET_SMSTATE(u32, smstate, 0x7f7c);
>  	rsm_set_desc_flags(&desc,  GET_SMSTATE(u32, smstate, 0x7f78));
> -	ctxt->ops->set_segment(ctxt, selector, &desc, 0, VCPU_SREG_LDTR);
> +	kvm_set_segment(vcpu, &desc, VCPU_SREG_LDTR);
>  
>  	dt.address =               GET_SMSTATE(u32, smstate, 0x7f74);
>  	dt.size =                  GET_SMSTATE(u32, smstate, 0x7f70);
> -	ctxt->ops->set_gdt(ctxt, &dt);
> +	static_call(kvm_x86_set_gdt)(vcpu, &dt);
>  
>  	dt.address =               GET_SMSTATE(u32, smstate, 0x7f58);
>  	dt.size =                  GET_SMSTATE(u32, smstate, 0x7f54);
> -	ctxt->ops->set_idt(ctxt, &dt);
> +	static_call(kvm_x86_set_idt)(vcpu, &dt);
>  
>  	for (i = 0; i < 6; i++) {
> -		int r = rsm_load_seg_32(ctxt, smstate, i);
> +		int r = rsm_load_seg_32(vcpu, smstate, i);
>  		if (r != X86EMUL_CONTINUE)
>  			return r;
>  	}
>  
>  	cr4 = GET_SMSTATE(u32, smstate, 0x7f14);
>  
> -	ctxt->ops->set_smbase(ctxt, GET_SMSTATE(u32, smstate, 0x7ef8));
> +	vcpu->arch.smbase = GET_SMSTATE(u32, smstate, 0x7ef8);
>  
> -	return rsm_enter_protected_mode(ctxt, cr0, cr3, cr4);
> +	return rsm_enter_protected_mode(vcpu, cr0, cr3, cr4);
>  }
>  
>  #ifdef CONFIG_X86_64
>  static int rsm_load_state_64(struct x86_emulate_ctxt *ctxt,
>  			     const char *smstate)
>  {
> -	struct desc_struct desc;
> +	struct kvm_vcpu *vcpu = ctxt->vcpu;
> +	struct kvm_segment desc;
>  	struct desc_ptr dt;
>  	u64 val, cr0, cr3, cr4;
> -	u32 base3;
> -	u16 selector;
>  	int i, r;
>  
>  	for (i = 0; i < NR_EMULATOR_GPRS; i++)
> @@ -459,51 +446,49 @@ static int rsm_load_state_64(struct x86_emulate_ctxt *ctxt,
>  
>  	val = GET_SMSTATE(u64, smstate, 0x7f68);
>  
> -	if (ctxt->ops->set_dr(ctxt, 6, val))
> +	if (kvm_set_dr(vcpu, 6, val))
>  		return X86EMUL_UNHANDLEABLE;
>  
>  	val = GET_SMSTATE(u64, smstate, 0x7f60);
>  
> -	if (ctxt->ops->set_dr(ctxt, 7, val))
> +	if (kvm_set_dr(vcpu, 7, val))
>  		return X86EMUL_UNHANDLEABLE;
>  
>  	cr0 =                       GET_SMSTATE(u64, smstate, 0x7f58);
>  	cr3 =                       GET_SMSTATE(u64, smstate, 0x7f50);
>  	cr4 =                       GET_SMSTATE(u64, smstate, 0x7f48);
> -	ctxt->ops->set_smbase(ctxt, GET_SMSTATE(u32, smstate, 0x7f00));
> +	vcpu->arch.smbase =         GET_SMSTATE(u32, smstate, 0x7f00);
>  	val =                       GET_SMSTATE(u64, smstate, 0x7ed0);
>  
> -	if (ctxt->ops->set_msr(ctxt, MSR_EFER, val & ~EFER_LMA))
> +	if (kvm_set_msr(vcpu, MSR_EFER, val & ~EFER_LMA))
>  		return X86EMUL_UNHANDLEABLE;
>  
> -	selector =                  GET_SMSTATE(u32, smstate, 0x7e90);
> +	desc.selector =             GET_SMSTATE(u32, smstate, 0x7e90);
>  	rsm_set_desc_flags(&desc,   GET_SMSTATE(u32, smstate, 0x7e92) << 8);
> -	set_desc_limit(&desc,       GET_SMSTATE(u32, smstate, 0x7e94));
> -	set_desc_base(&desc,        GET_SMSTATE(u32, smstate, 0x7e98));
> -	base3 =                     GET_SMSTATE(u32, smstate, 0x7e9c);
> -	ctxt->ops->set_segment(ctxt, selector, &desc, base3, VCPU_SREG_TR);
> +	desc.limit =                GET_SMSTATE(u32, smstate, 0x7e94);
> +	desc.base =                 GET_SMSTATE(u64, smstate, 0x7e98);
> +	kvm_set_segment(vcpu, &desc, VCPU_SREG_TR);
>  
>  	dt.size =                   GET_SMSTATE(u32, smstate, 0x7e84);
>  	dt.address =                GET_SMSTATE(u64, smstate, 0x7e88);
> -	ctxt->ops->set_idt(ctxt, &dt);
> +	static_call(kvm_x86_set_idt)(vcpu, &dt);
>  
> -	selector =                  GET_SMSTATE(u32, smstate, 0x7e70);
> +	desc.selector =             GET_SMSTATE(u32, smstate, 0x7e70);
>  	rsm_set_desc_flags(&desc,   GET_SMSTATE(u32, smstate, 0x7e72) << 8);
> -	set_desc_limit(&desc,       GET_SMSTATE(u32, smstate, 0x7e74));
> -	set_desc_base(&desc,        GET_SMSTATE(u32, smstate, 0x7e78));
> -	base3 =                     GET_SMSTATE(u32, smstate, 0x7e7c);
> -	ctxt->ops->set_segment(ctxt, selector, &desc, base3, VCPU_SREG_LDTR);
> +	desc.limit =                GET_SMSTATE(u32, smstate, 0x7e74);
> +	desc.base =                 GET_SMSTATE(u64, smstate, 0x7e78);
> +	kvm_set_segment(vcpu, &desc, VCPU_SREG_LDTR);
>  
>  	dt.size =                   GET_SMSTATE(u32, smstate, 0x7e64);
>  	dt.address =                GET_SMSTATE(u64, smstate, 0x7e68);
> -	ctxt->ops->set_gdt(ctxt, &dt);
> +	static_call(kvm_x86_set_gdt)(vcpu, &dt);
>  
> -	r = rsm_enter_protected_mode(ctxt, cr0, cr3, cr4);
> +	r = rsm_enter_protected_mode(vcpu, cr0, cr3, cr4);
>  	if (r != X86EMUL_CONTINUE)
>  		return r;
>  
>  	for (i = 0; i < 6; i++) {
> -		r = rsm_load_seg_64(ctxt, smstate, i);
> +		r = rsm_load_seg_64(vcpu, smstate, i);
>  		if (r != X86EMUL_CONTINUE)
>  			return r;
>  	}
> @@ -520,14 +505,14 @@ int emulator_leave_smm(struct x86_emulate_ctxt *ctxt)
>  	u64 smbase;
>  	int ret;
>  
> -	smbase = ctxt->ops->get_smbase(ctxt);
> +	smbase = vcpu->arch.smbase;
>  
> -	ret = ctxt->ops->read_phys(ctxt, smbase + 0xfe00, buf, sizeof(buf));
> -	if (ret != X86EMUL_CONTINUE)
> +	ret = kvm_vcpu_read_guest(vcpu, smbase + 0xfe00, buf, sizeof(buf));
> +	if (ret < 0)
>  		return X86EMUL_UNHANDLEABLE;
>  
> -	if ((ctxt->ops->get_hflags(ctxt) & X86EMUL_SMM_INSIDE_NMI_MASK) == 0)
> -		ctxt->ops->set_nmi_mask(ctxt, false);
> +	if ((vcpu->arch.hflags & HF_SMM_INSIDE_NMI_MASK) == 0)
> +		static_call(kvm_x86_set_nmi_mask)(vcpu, false);
>  
>  	kvm_smm_changed(vcpu, false);
>  
> @@ -535,41 +520,41 @@ int emulator_leave_smm(struct x86_emulate_ctxt *ctxt)
>  	 * Get back to real mode, to prepare a safe state in which to load
>  	 * CR0/CR3/CR4/EFER.  It's all a bit more complicated if the vCPU
>  	 * supports long mode.
> -	 *
> -	 * The ctxt->ops callbacks will handle all side effects when writing
> -	 * writing MSRs and CRs, e.g. MMU context resets, CPUID
> -	 * runtime updates, etc.
>  	 */
> -	if (emulator_has_longmode(ctxt)) {
> -		struct desc_struct cs_desc;
> +#ifdef CONFIG_X86_64
> +	if (guest_cpuid_has(vcpu, X86_FEATURE_LM)) {
> +		struct kvm_segment cs_desc;
>  
>  		/* Zero CR4.PCIDE before CR0.PG.  */
> -		cr4 = ctxt->ops->get_cr(ctxt, 4);
> +		cr4 = kvm_read_cr4(vcpu);
>  		if (cr4 & X86_CR4_PCIDE)
> -			ctxt->ops->set_cr(ctxt, 4, cr4 & ~X86_CR4_PCIDE);
> +			kvm_set_cr4(vcpu, cr4 & ~X86_CR4_PCIDE);
>  
>  		/* A 32-bit code segment is required to clear EFER.LMA.  */
>  		memset(&cs_desc, 0, sizeof(cs_desc));
>  		cs_desc.type = 0xb;
> -		cs_desc.s = cs_desc.g = cs_desc.p = 1;
> -		ctxt->ops->set_segment(ctxt, 0, &cs_desc, 0, VCPU_SREG_CS);
> +		cs_desc.s = cs_desc.g = cs_desc.present = 1;
> +		kvm_set_segment(vcpu, &cs_desc, VCPU_SREG_CS);
>  	}
> +#endif
>  
>  	/* For the 64-bit case, this will clear EFER.LMA.  */
> -	cr0 = ctxt->ops->get_cr(ctxt, 0);
> +	cr0 = kvm_read_cr0(vcpu);
>  	if (cr0 & X86_CR0_PE)
> -		ctxt->ops->set_cr(ctxt, 0, cr0 & ~(X86_CR0_PG | X86_CR0_PE));
> +		kvm_set_cr0(vcpu, cr0 & ~(X86_CR0_PG | X86_CR0_PE));
>  
> -	if (emulator_has_longmode(ctxt)) {
> +#ifdef CONFIG_X86_64
> +	if (guest_cpuid_has(vcpu, X86_FEATURE_LM)) {
>  		/* Clear CR4.PAE before clearing EFER.LME. */
> -		cr4 = ctxt->ops->get_cr(ctxt, 4);
> +		cr4 = kvm_read_cr4(vcpu);
>  		if (cr4 & X86_CR4_PAE)
> -			ctxt->ops->set_cr(ctxt, 4, cr4 & ~X86_CR4_PAE);
> +			kvm_set_cr4(vcpu, cr4 & ~X86_CR4_PAE);
>  
>  		/* And finally go back to 32-bit mode.  */
>  		efer = 0;
> -		ctxt->ops->set_msr(ctxt, MSR_EFER, efer);
> +		kvm_set_msr(vcpu, MSR_EFER, efer);
>  	}
> +#endif
>  
>  	/*
>  	 * Give leave_smm() a chance to make ISA-specific changes to the vCPU
> @@ -580,7 +565,7 @@ int emulator_leave_smm(struct x86_emulate_ctxt *ctxt)
>  		return X86EMUL_UNHANDLEABLE;
>  
>  #ifdef CONFIG_X86_64
> -	if (emulator_has_longmode(ctxt))
> +	if (guest_cpuid_has(vcpu, X86_FEATURE_LM))
>  		return rsm_load_state_64(ctxt, buf);
>  	else
>  #endif
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 97d6ee179109..97a871635986 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -7201,15 +7201,6 @@ static int emulator_read_std(struct x86_emulate_ctxt *ctxt,
>  	return kvm_read_guest_virt_helper(addr, val, bytes, vcpu, access, exception);
>  }
>  
> -static int kvm_read_guest_phys_system(struct x86_emulate_ctxt *ctxt,
> -		unsigned long addr, void *val, unsigned int bytes)
> -{
> -	struct kvm_vcpu *vcpu = emul_to_vcpu(ctxt);
> -	int r = kvm_vcpu_read_guest(vcpu, addr, val, bytes);
> -
> -	return r < 0 ? X86EMUL_IO_NEEDED : X86EMUL_CONTINUE;
> -}
> -
>  static int kvm_write_guest_virt_helper(gva_t addr, void *val, unsigned int bytes,
>  				      struct kvm_vcpu *vcpu, u64 access,
>  				      struct x86_exception *exception)
> @@ -8001,26 +7992,6 @@ static int emulator_get_msr(struct x86_emulate_ctxt *ctxt,
>  	return kvm_get_msr(emul_to_vcpu(ctxt), msr_index, pdata);
>  }
>  
> -static int emulator_set_msr(struct x86_emulate_ctxt *ctxt,
> -			    u32 msr_index, u64 data)
> -{
> -	return kvm_set_msr(emul_to_vcpu(ctxt), msr_index, data);
> -}
> -
> -static u64 emulator_get_smbase(struct x86_emulate_ctxt *ctxt)
> -{
> -	struct kvm_vcpu *vcpu = emul_to_vcpu(ctxt);
> -
> -	return vcpu->arch.smbase;
> -}
> -
> -static void emulator_set_smbase(struct x86_emulate_ctxt *ctxt, u64 smbase)
> -{
> -	struct kvm_vcpu *vcpu = emul_to_vcpu(ctxt);
> -
> -	vcpu->arch.smbase = smbase;
> -}
> -
>  static int emulator_check_pmc(struct x86_emulate_ctxt *ctxt,
>  			      u32 pmc)
>  {
> @@ -8119,7 +8090,6 @@ static const struct x86_emulate_ops emulate_ops = {
>  	.write_gpr           = emulator_write_gpr,
>  	.read_std            = emulator_read_std,
>  	.write_std           = emulator_write_std,
> -	.read_phys           = kvm_read_guest_phys_system,
>  	.fetch               = kvm_fetch_guest_virt,
>  	.read_emulated       = emulator_read_emulated,
>  	.write_emulated      = emulator_write_emulated,
> @@ -8139,11 +8109,8 @@ static const struct x86_emulate_ops emulate_ops = {
>  	.cpl                 = emulator_get_cpl,
>  	.get_dr              = emulator_get_dr,
>  	.set_dr              = emulator_set_dr,
> -	.get_smbase          = emulator_get_smbase,
> -	.set_smbase          = emulator_set_smbase,
>  	.set_msr_with_filter = emulator_set_msr_with_filter,
>  	.get_msr_with_filter = emulator_get_msr_with_filter,
> -	.set_msr             = emulator_set_msr,
>  	.get_msr             = emulator_get_msr,
>  	.check_pmc	     = emulator_check_pmc,
>  	.read_pmc            = emulator_read_pmc,

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky



