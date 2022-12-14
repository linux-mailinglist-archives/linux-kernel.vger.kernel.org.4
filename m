Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B317B64D045
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 20:49:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239193AbiLNTtV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 14:49:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239138AbiLNTso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 14:48:44 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ABAD2BB17
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 11:48:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671047312; x=1702583312;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7RcX3PrZd2KCc9wvuxMowDpiOD3opcQjy/5Nc1YaucM=;
  b=kcRw0oB+AFeltlY0LWdsHWzXRIf+FQ78D6u4sESPoTFllEqhXi88sXUG
   Vp2kgNC0zJ61S4Y16RwlLC87sgbNr3Nya6TBJMCIJe+QWsco/HeK7koTI
   knZn1JU4BwcZp5NfQvHLabHFxEpUL4ZFcnbsjPM6dDWh5/snMdW4niLup
   MCjmB7i9XzYgPmH2tc2lkb/3aUbBvjoXfMeA/Mhs0ao/ODyG+eTEFsFWG
   6CtGbl+Ctx3sEvFweAJyMxrtnIJXDW43BsySMvQyUNqPByqscmx+dYVm6
   FgGs3nu1dscGkU/7iJlLx3NWrugNYFrKQ1I/foe94l/ty8RdJJGHiCTSO
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10561"; a="317206889"
X-IronPort-AV: E=Sophos;i="5.96,245,1665471600"; 
   d="scan'208";a="317206889"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2022 11:48:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10561"; a="681605757"
X-IronPort-AV: E=Sophos;i="5.96,245,1665471600"; 
   d="scan'208";a="681605757"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga001.jf.intel.com with ESMTP; 14 Dec 2022 11:48:16 -0800
Date:   Wed, 14 Dec 2022 11:56:29 -0800
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86: lib: Separate instruction decoder MMIO type from
 MMIO trace
Message-ID: <20221214195629.GA15255@ranerica-svr.sc.intel.com>
References: <20221212210254.2559995-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221212210254.2559995-1-Jason@zx2c4.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 12, 2022 at 02:02:55PM -0700, Jason A. Donenfeld wrote:
> Both mmiotrace.h and insn-eval.h define various MMIO_ enum constants.
> Rename the insn ones to have a INSN_ prefix, so that the headers can be
> used from the same source file.
> 
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
> This doesn't fix any existing compile error that I'm aware of, but if
> this makes it into 6.2, it would avoid me having to carry it in a series
> I'm working on, where the clash does result in a compile error.
> 
>  arch/x86/coco/tdx/tdx.c          | 26 +++++++++++++-------------
>  arch/x86/include/asm/insn-eval.h | 18 +++++++++---------
>  arch/x86/kernel/sev.c            | 18 +++++++++---------
>  arch/x86/lib/insn-eval.c         | 20 ++++++++++----------
>  4 files changed, 41 insertions(+), 41 deletions(-)
> 
> diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
> index b8998cf0508a..c05428668fbc 100644
> --- a/arch/x86/coco/tdx/tdx.c
> +++ b/arch/x86/coco/tdx/tdx.c
> @@ -347,7 +347,7 @@ static int handle_mmio(struct pt_regs *regs, struct ve_info *ve)
>  	unsigned long *reg, val, vaddr;
>  	char buffer[MAX_INSN_SIZE];
>  	struct insn insn = {};
> -	enum mmio_type mmio;
> +	enum insn_mmio_type mmio;

It would be good to preserve the reverse fir order in the variable
declarations.

>  	int size, extend_size;
>  	u8 extend_val = 0;
>  
> @@ -362,10 +362,10 @@ static int handle_mmio(struct pt_regs *regs, struct ve_info *ve)
>  		return -EINVAL;
>  
>  	mmio = insn_decode_mmio(&insn, &size);
> -	if (WARN_ON_ONCE(mmio == MMIO_DECODE_FAILED))
> +	if (WARN_ON_ONCE(mmio == INSN_MMIO_DECODE_FAILED))
>  		return -EINVAL;
>  
> -	if (mmio != MMIO_WRITE_IMM && mmio != MMIO_MOVS) {
> +	if (mmio != INSN_MMIO_WRITE_IMM && mmio != INSN_MMIO_MOVS) {
>  		reg = insn_get_modrm_reg_ptr(&insn, regs);
>  		if (!reg)
>  			return -EINVAL;
> @@ -386,23 +386,23 @@ static int handle_mmio(struct pt_regs *regs, struct ve_info *ve)
>  
>  	/* Handle writes first */
>  	switch (mmio) {
> -	case MMIO_WRITE:
> +	case INSN_MMIO_WRITE:
>  		memcpy(&val, reg, size);
>  		if (!mmio_write(size, ve->gpa, val))
>  			return -EIO;
>  		return insn.length;
> -	case MMIO_WRITE_IMM:
> +	case INSN_MMIO_WRITE_IMM:
>  		val = insn.immediate.value;
>  		if (!mmio_write(size, ve->gpa, val))
>  			return -EIO;
>  		return insn.length;
> -	case MMIO_READ:
> -	case MMIO_READ_ZERO_EXTEND:
> -	case MMIO_READ_SIGN_EXTEND:
> +	case INSN_MMIO_READ:
> +	case INSN_MMIO_READ_ZERO_EXTEND:
> +	case INSN_MMIO_READ_SIGN_EXTEND:
>  		/* Reads are handled below */
>  		break;
> -	case MMIO_MOVS:
> -	case MMIO_DECODE_FAILED:
> +	case INSN_MMIO_MOVS:
> +	case INSN_MMIO_DECODE_FAILED:
>  		/*
>  		 * MMIO was accessed with an instruction that could not be
>  		 * decoded or handled properly. It was likely not using io.h
> @@ -419,15 +419,15 @@ static int handle_mmio(struct pt_regs *regs, struct ve_info *ve)
>  		return -EIO;
>  
>  	switch (mmio) {
> -	case MMIO_READ:
> +	case INSN_MMIO_READ:
>  		/* Zero-extend for 32-bit operation */
>  		extend_size = size == 4 ? sizeof(*reg) : 0;
>  		break;
> -	case MMIO_READ_ZERO_EXTEND:
> +	case INSN_MMIO_READ_ZERO_EXTEND:
>  		/* Zero extend based on operand size */
>  		extend_size = insn.opnd_bytes;
>  		break;
> -	case MMIO_READ_SIGN_EXTEND:
> +	case INSN_MMIO_READ_SIGN_EXTEND:
>  		/* Sign extend based on operand size */
>  		extend_size = insn.opnd_bytes;
>  		if (size == 1 && val & BIT(7))
> diff --git a/arch/x86/include/asm/insn-eval.h b/arch/x86/include/asm/insn-eval.h
> index f07faa61c7f3..54368a43abf6 100644
> --- a/arch/x86/include/asm/insn-eval.h
> +++ b/arch/x86/include/asm/insn-eval.h
> @@ -32,16 +32,16 @@ int insn_fetch_from_user_inatomic(struct pt_regs *regs,
>  bool insn_decode_from_regs(struct insn *insn, struct pt_regs *regs,
>  			   unsigned char buf[MAX_INSN_SIZE], int buf_size);
>  
> -enum mmio_type {
> -	MMIO_DECODE_FAILED,
> -	MMIO_WRITE,
> -	MMIO_WRITE_IMM,
> -	MMIO_READ,
> -	MMIO_READ_ZERO_EXTEND,
> -	MMIO_READ_SIGN_EXTEND,
> -	MMIO_MOVS,
> +enum insn_mmio_type {
> +	INSN_MMIO_DECODE_FAILED,
> +	INSN_MMIO_WRITE,
> +	INSN_MMIO_WRITE_IMM,
> +	INSN_MMIO_READ,
> +	INSN_MMIO_READ_ZERO_EXTEND,
> +	INSN_MMIO_READ_SIGN_EXTEND,
> +	INSN_MMIO_MOVS,
>  };
>  
> -enum mmio_type insn_decode_mmio(struct insn *insn, int *bytes);
> +enum insn_mmio_type insn_decode_mmio(struct insn *insn, int *bytes);
>  
>  #endif /* _ASM_X86_INSN_EVAL_H */
> diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
> index a428c62330d3..ecd991ec1a98 100644
> --- a/arch/x86/kernel/sev.c
> +++ b/arch/x86/kernel/sev.c
> @@ -1537,31 +1537,31 @@ static enum es_result vc_handle_mmio(struct ghcb *ghcb, struct es_em_ctxt *ctxt)
>  {
>  	struct insn *insn = &ctxt->insn;
>  	unsigned int bytes = 0;
> -	enum mmio_type mmio;
> +	enum insn_mmio_type mmio;

Same here.

Thanks and BR,
Ricardo
