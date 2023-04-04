Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 700CC6D61A1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 14:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234795AbjDDMxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 08:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235076AbjDDMxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 08:53:11 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 67878269A;
        Tue,  4 Apr 2023 05:53:07 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4A431D75;
        Tue,  4 Apr 2023 05:53:51 -0700 (PDT)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.35.139])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2A4653F762;
        Tue,  4 Apr 2023 05:53:03 -0700 (PDT)
Date:   Tue, 4 Apr 2023 13:52:57 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Donglin Peng <pengdonglin@sangfor.com.cn>
Cc:     mhiramat@kernel.org, rostedt@goodmis.org, linux@armlinux.org.uk,
        will@kernel.org, catalin.marinas@arm.com,
        rmk+kernel@armlinux.org.uk, palmer@dabbelt.com,
        paul.walmsley@sifive.com, aou@eecs.berkeley.edu,
        tglx@linutronix.de, dave.hansen@linux.intel.com, x86@kernel.org,
        bp@alien8.de, hpa@zytor.com, chenhuacai@kernel.org,
        zhangqing@loongson.cn, kernel@xen0n.name, mingo@redhat.com,
        peterz@infradead.org, xiehuan09@gmail.com, dinghui@sangfor.com.cn,
        huangcun@sangfor.com.cn, dolinux.peng@gmail.com,
        linux-trace-kernel@vger.kernel.org, loongarch@lists.linux.dev,
        linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 2/8] tracing: Add documentation for funcgraph-retval
 and funcgraph-retval-hex
Message-ID: <ZCwdqTAUx+BwthQx@FVFF77S0Q05N.cambridge.arm.com>
References: <cover.1680265828.git.pengdonglin@sangfor.com.cn>
 <a3dcdd61b3ac07eefabc1b11fc18e9fae23d8cbe.1680265828.git.pengdonglin@sangfor.com.cn>
 <ZCqOl1TCHGhbf0hf@FVFF77S0Q05N>
 <d8b58492-e702-05b7-399e-054892ba6ded@sangfor.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d8b58492-e702-05b7-399e-054892ba6ded@sangfor.com.cn>
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 04, 2023 at 08:02:44PM +0800, Donglin Peng wrote:
> On 2023/4/3 16:30, Mark Rutland wrote:
> > On Fri, Mar 31, 2023 at 05:47:38AM -0700, Donglin Peng wrote:

> > > +At present, there are some limitations when using the funcgraph-retval
> > > +option, and these limitations will be eliminated in the future:
> > > +
> > > +- Even if the function return type is void, a return value will still
> > > +  be printed, and you can just ignore it.
> > > +
> > > +- Even if return values are stored in multiple registers, only the
> > > +  value contained in the first register will be recorded and printed.
> > > +  To illustrate, in the x86 architecture, eax and edx are used to store
> > > +  a 64-bit return value, with the lower 32 bits saved in eax and the
> > > +  upper 32 bits saved in edx. However, only the value stored in eax
> > > +  will be recorded and printed.
> > 
> > With some procedure call standards (e.g. arm64's AAPCS64), when a type is
> > smaller than a GPR it's up to the consumer to perform the narrowing, and the
> > upport bits may contain UNKNOWN values. For example, with a u8 in a 64-bit GPR,
> > bits [3:8] may contain arbitrary values.
> 
> Thank you. Just to clarify, Should it be that bits [63:8] may contain
> arbitrary values in such cases?

Yes; I meant to say bits [63:8].

> > It's probably worth noting that this means *some* manual processing will always
> > be necessary for such cases.
> > 
> > That's mostly visible around where largelr types get truncated (whether
> > explciitly or implicitly), e.g.
> > 
> > 	u8 narrow_to_u8(u64 val)
> > 	{
> > 		// implicitly truncated
> > 		return val;
> > 	}
> > 
> > ... could be compiled to:
> > 
> > 	narrow_to_u8:
> > 		< ... ftrace instrumentation ... >
> > 		RET
> > 
> > ... and so:
> > 	
> > 	narrow_to_u8(0x123456789abcdef);
> > 
> > ... might be recorded as returning 0x123456789abcdef rather than 0xef.
> > 
> > 
> > That can happen in surprising ways, e.g.
> > 
> > 	int error_if_not_4g_aligned(u64 val)
> > 	{
> > 		if (val & GENMASK(63, 32))
> 
> Should it be GENMASK(31, 0)?

Yes; whoops!

> > 			return -EINVAL;
> > 
> > 		return 0;
> > 	}
> > 
> > ... could be compiled to:
> > 
> > 	error_if_not_4g_aligned:
> > 		CBNZ	w0, .Lnot_aligned
> > 		RET				// bits [31:0] are zero, bits
> > 						// [63:32] are UNKNOWN
> > 	.Lnot_aligned:
> > 		MOV	x0, #-EINVAL
> > 		RET
> > 
> > .... and so:
> > 
> > 	error_if_not_4g_aligned(SZ_8G)
> > 
> > ... could return with bits [63:32] non-zero
> > 
> > Thanks,
> > Mark.
> 
> Thank you for sharing this note. I will append the following limitation.

That looks great; thanks!

> In certain procedure call standards, such as arm64's AAPCS64, when a
> type is smaller than a GPR, it is the responsibility of the consumer to
> perform the narrowing, and the upper bits may contain UNKNOWN values.
> Therefore, it is advisable to check the code for such cases. For
> instance,when using a u8 in a 64-bit GPR, bits [63:8] may contain
          ^
Minor nit: missing space here.

> arbitrary values, especially when larger types are truncated, whether
> explicitly or implicitly. Here are some specific cases to illustrate
> this point:
> 
>  - Case One:
> 
>   The function narrow_to_u8 is defined as follows:
> 
>  	u8 narrow_to_u8(u64 val)
> 	{
> 		// implicitly truncated
> 		return val;
> 	}
> 
>   It may be compiled to:
> 
> 	narrow_to_u8:
> 		< ... ftrace instrumentation ... >
> 		RET
> 
>   If you pass 0x123456789abcdef to this function and want to narrow it,
>   it may be recorded as 0x123456789abcdef instead of 0xef.
> 
>   - Case Two:
> 
>   The function error_if_not_4g_aligned is defined as follows:
> 
> 	int error_if_not_4g_aligned(u64 val)
> 	{
> 		if (val & GENMASK(31, 0))
> 			return -EINVAL;
> 
> 		return 0;
> 	}
> 
>   It could be compile to:
                ^^^^^^^

Minor nit: s/compile/compiled here.

Thanks,
Mark.

> 
> 	error_if_not_4g_aligned:
> 		CBNZ	w0, .Lnot_aligned
> 		RET				// bits [31:0] are zero, bits
> 						// [63:32] are UNKNOWN
> 	.Lnot_aligned:
> 		MOV	x0, #-EINVAL
> 		RET
> 
>   When passing 0x2_0000_0000 to it, the return value may be recorded as
>   0x2_0000_0000 instead of 0.
