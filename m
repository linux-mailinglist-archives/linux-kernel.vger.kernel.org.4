Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42F7F637819
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 12:53:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbiKXLxr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 06:53:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbiKXLxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 06:53:45 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A509263AB;
        Thu, 24 Nov 2022 03:53:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1669290823; x=1700826823;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=L0VDwyYomy/w1eYQNlU5SlJ/2j8lPvsGDjWLiSBLex8=;
  b=Fr+KpIf4P3bAc5Nv5pl29prjI9tfRoIMFRMKGqCQUu0cwh85eKTRmLHz
   RsWU0yNFrxHksqwUJfOY3Nnf0gPH8ugTtWB1V2wYQoFVQ1IOGdST7rJ2r
   wvNLhnpSXD2nz09h5llLw5x6j/EgQl3aaff822MtMGAkjX1KquWPgyIP5
   CJAz5TBGpRBFWq8YE5xX7vRAR2Y2lwzhk+1h6wnCWmt5BnYYBdbGN7lw3
   2uC0s7GXxYJSPjiMwIm0fpUexoEA6zydE2CPEeAzT3cbuLKXbSHAObZRZ
   IFj/9E0aLOydSxwar82swvUMJfBvCzRRfU6MP1NxObCOY+8dwyg2FiLpY
   Q==;
X-IronPort-AV: E=Sophos;i="5.96,190,1665471600"; 
   d="scan'208";a="124940697"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Nov 2022 04:53:42 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Thu, 24 Nov 2022 04:53:40 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Thu, 24 Nov 2022 04:53:37 -0700
Date:   Thu, 24 Nov 2022 11:53:19 +0000
From:   Conor Dooley <conor.dooley@microchip.com>
To:     "Hongren (Zenithal) Zheng" <i@zenithal.me>
CC:     Palmer Dabbelt <palmer@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@rivosinc.com>,
        Anup Patel <anup@brainfault.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>, <linux-mm@kvack.org>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-api@vger.kernel.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        <linux-man@vger.kernel.org>, Jiatai He <jiatai2021@iscas.ac.cn>,
        Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH v3 1/3] RISC-V: add Bitmanip/Scalar Crypto parsing from DT
Message-ID: <Y39bL1Vp8Fx7ZD6g@wendy>
References: <YqYz+xDsXr/tNaNu@Sun>
 <YqY0aSngjI0Hc5d4@Sun>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YqY0aSngjI0Hc5d4@Sun>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Hongren,

On Mon, Jun 13, 2022 at 02:46:01AM +0800, Hongren (Zenithal) Zheng wrote:
> This patch parses Zb/Zk related string from DT and
> output them in cpuinfo

Could you please wrap changelogs at 72 character rather than 50?

> 
> One thing worth noting is that if DT provides zk,
> all zbkb, zbkc, zbkx and zkn, zkr, zkt would be enabled.
> 
> Note that zk is a valid extension name and the current
> DT binding spec allows this.

Where is the "DT binding spec" for this?
At the time, IIRC, putting any multiletter extensions in a DT was
a violation of the dt-binding, so I am interested in seeing what spec
had covered this.

> This patch also changes the logical id of
> existing multi-letter extensions and adds a statement
> that instead of logical id compatibility, the order
> is needed.
> 
> There currently lacks a mechanism to merge them when
> producing cpuinfo. Namely if you provide a riscv,isa
> "rv64imafdc_zk_zks", the cpuinfo output would be
> "rv64imafdc_zbkb_zbkc_zbkx_zknd_zkne_zknh_zkr_zksed
> _zksh_zkt"
> 
> Tested-by: Jiatai He <jiatai2021@iscas.ac.cn>
> Signed-off-by: Hongren (Zenithal) Zheng <i@zenithal.me>
> ---
>  arch/riscv/include/asm/hwcap.h | 20 +++++++++++++++++++-
>  arch/riscv/kernel/cpu.c        | 14 ++++++++++++++
>  arch/riscv/kernel/cpufeature.c | 33 +++++++++++++++++++++++++++++++++
>  3 files changed, 66 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
> index 4e2486881840..02c454a12683 100644
> --- a/arch/riscv/include/asm/hwcap.h
> +++ b/arch/riscv/include/asm/hwcap.h
> @@ -49,9 +49,27 @@ extern unsigned long elf_hwcap;
>   * RISCV_ISA_EXT_MAX. 0-25 range is reserved for single letter
>   * extensions while all the multi-letter extensions should define the next
>   * available logical extension id.
> + *
> + * The order of them should be maintained according to the riscv-isa-manual.
> + * As this is an internal API, changing the id of one extension does
> + * not affect compatibility.

Hmm, not too sure about this. See 61a41d16ad20 ("RISC-V: Print SSTC in
canonical order"), where Palmer re-sorted another one of these internal
APIs (isa_ext_arr) in a different order to what it would appear you're
proposing here.

I am really really bad when it comes to specs, manuals etc - is there a
link to the specific part of the riscv-isa-manual that we can use here
for reference? Otherwise I'd much rather stick with what I **thought**
was the "canonical order", _Sfoo_Zfoo_Xfoo.

Or are these slightly different - and fit in the "Additional Standard
Extension Names" category rather than "Machine-level Instruction-Set
Extensions"?

The only ones I see pointed out in the current table [0] are Ztso,
Zicsr, Zifencei & Zam which is what I (maybe wrongly!!) assumed to be
the exceptions to the S before Z rule.

I tried to have a look in the "bitmanip-1.0.0" pdf at [2], but I don't
see it use the word "Standard" anywhere. As I already said, this stuff
confuses me no end so some clarification would be really helpful :)

The same applies to the crypto stuff.

In other news, since Palmer did do a re-order, and its been several
months - you'll need to rebase & re-submit anyway.

Thanks,
Conor.

0 - https://github.com/riscv/riscv-isa-manual/blob/master/src/naming.tex#L132
1 - https://github.com/riscv/riscv-isa-manual/blob/master/src/naming.tex#L182
2 - https://github.com/riscv/riscv-bitmanip/releases/tag/1.0.0

>   */
>  enum riscv_isa_ext_id {
> -	RISCV_ISA_EXT_SSCOFPMF = RISCV_ISA_EXT_BASE,
> +	RISCV_ISA_EXT_ZBA = RISCV_ISA_EXT_BASE,
> +	RISCV_ISA_EXT_ZBB,
> +	RISCV_ISA_EXT_ZBC,
> +	RISCV_ISA_EXT_ZBKB,
> +	RISCV_ISA_EXT_ZBKC,
> +	RISCV_ISA_EXT_ZBKX,
> +	RISCV_ISA_EXT_ZBS,
> +	RISCV_ISA_EXT_ZKND,
> +	RISCV_ISA_EXT_ZKNE,
> +	RISCV_ISA_EXT_ZKNH,
> +	RISCV_ISA_EXT_ZKR,
> +	RISCV_ISA_EXT_ZKSED,
> +	RISCV_ISA_EXT_ZKSH,
> +	RISCV_ISA_EXT_ZKT,
> +	RISCV_ISA_EXT_SSCOFPMF,
>  	RISCV_ISA_EXT_SVPBMT,
>  	RISCV_ISA_EXT_ID_MAX = RISCV_ISA_EXT_MAX,
>  };
> diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
> index fba9e9f46a8c..d9ff9bff3d45 100644
> --- a/arch/riscv/kernel/cpu.c
> +++ b/arch/riscv/kernel/cpu.c
> @@ -87,6 +87,20 @@ int riscv_of_parent_hartid(struct device_node *node)
>   *    extensions by an underscore.
>   */
>  static struct riscv_isa_ext_data isa_ext_arr[] = {
> +	__RISCV_ISA_EXT_DATA(zba, RISCV_ISA_EXT_ZBA),
> +	__RISCV_ISA_EXT_DATA(zbb, RISCV_ISA_EXT_ZBB),
> +	__RISCV_ISA_EXT_DATA(zbc, RISCV_ISA_EXT_ZBC),
> +	__RISCV_ISA_EXT_DATA(zbkb, RISCV_ISA_EXT_ZBKB),
> +	__RISCV_ISA_EXT_DATA(zbkc, RISCV_ISA_EXT_ZBKC),
> +	__RISCV_ISA_EXT_DATA(zbkx, RISCV_ISA_EXT_ZBKX),
> +	__RISCV_ISA_EXT_DATA(zbs, RISCV_ISA_EXT_ZBS),
> +	__RISCV_ISA_EXT_DATA(zknd, RISCV_ISA_EXT_ZKND),
> +	__RISCV_ISA_EXT_DATA(zkne, RISCV_ISA_EXT_ZKNE),
> +	__RISCV_ISA_EXT_DATA(zknh, RISCV_ISA_EXT_ZKNH),
> +	__RISCV_ISA_EXT_DATA(zkr, RISCV_ISA_EXT_ZKR),
> +	__RISCV_ISA_EXT_DATA(zksed, RISCV_ISA_EXT_ZKSED),
> +	__RISCV_ISA_EXT_DATA(zksh, RISCV_ISA_EXT_ZKSH),
> +	__RISCV_ISA_EXT_DATA(zkt, RISCV_ISA_EXT_ZKT),
>  	__RISCV_ISA_EXT_DATA(sscofpmf, RISCV_ISA_EXT_SSCOFPMF),
>  	__RISCV_ISA_EXT_DATA(svpbmt, RISCV_ISA_EXT_SVPBMT),
>  	__RISCV_ISA_EXT_DATA("", RISCV_ISA_EXT_MAX),
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> index a6f62a6d1edd..0c2638365ec2 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -199,6 +199,39 @@ void __init riscv_fill_hwcap(void)
>  			} else {
>  				SET_ISA_EXT_MAP("sscofpmf", RISCV_ISA_EXT_SSCOFPMF);
>  				SET_ISA_EXT_MAP("svpbmt", RISCV_ISA_EXT_SVPBMT);
> +				SET_ISA_EXT_MAP("zba", RISCV_ISA_EXT_ZBA);
> +				SET_ISA_EXT_MAP("zbb", RISCV_ISA_EXT_ZBB);
> +				SET_ISA_EXT_MAP("zbc", RISCV_ISA_EXT_ZBC);
> +				SET_ISA_EXT_MAP("zbs", RISCV_ISA_EXT_ZBS);
> +				SET_ISA_EXT_MAP("zbkb", RISCV_ISA_EXT_ZBKB);
> +				SET_ISA_EXT_MAP("zbkc", RISCV_ISA_EXT_ZBKC);
> +				SET_ISA_EXT_MAP("zbks", RISCV_ISA_EXT_ZBKX);
> +				SET_ISA_EXT_MAP("zknd", RISCV_ISA_EXT_ZKND);
> +				SET_ISA_EXT_MAP("zkne", RISCV_ISA_EXT_ZKNE);
> +				SET_ISA_EXT_MAP("zknh", RISCV_ISA_EXT_ZKNH);
> +				SET_ISA_EXT_MAP("zksed", RISCV_ISA_EXT_ZKSED);
> +				SET_ISA_EXT_MAP("zksh", RISCV_ISA_EXT_ZKSH);
> +				SET_ISA_EXT_MAP("zkr", RISCV_ISA_EXT_ZKR);
> +				SET_ISA_EXT_MAP("zkt", RISCV_ISA_EXT_ZKT);
> +				SET_ISA_EXT_MAP("zkn", RISCV_ISA_EXT_ZBKB);
> +				SET_ISA_EXT_MAP("zkn", RISCV_ISA_EXT_ZBKC);
> +				SET_ISA_EXT_MAP("zkn", RISCV_ISA_EXT_ZBKX);
> +				SET_ISA_EXT_MAP("zkn", RISCV_ISA_EXT_ZKND);
> +				SET_ISA_EXT_MAP("zkn", RISCV_ISA_EXT_ZKNE);
> +				SET_ISA_EXT_MAP("zkn", RISCV_ISA_EXT_ZKNH);
> +				SET_ISA_EXT_MAP("zks", RISCV_ISA_EXT_ZBKB);
> +				SET_ISA_EXT_MAP("zks", RISCV_ISA_EXT_ZBKC);
> +				SET_ISA_EXT_MAP("zks", RISCV_ISA_EXT_ZBKX);
> +				SET_ISA_EXT_MAP("zks", RISCV_ISA_EXT_ZKSED);
> +				SET_ISA_EXT_MAP("zks", RISCV_ISA_EXT_ZKSH);
> +				SET_ISA_EXT_MAP("zk", RISCV_ISA_EXT_ZBKB);
> +				SET_ISA_EXT_MAP("zk", RISCV_ISA_EXT_ZBKC);
> +				SET_ISA_EXT_MAP("zk", RISCV_ISA_EXT_ZBKX);
> +				SET_ISA_EXT_MAP("zk", RISCV_ISA_EXT_ZKND);
> +				SET_ISA_EXT_MAP("zk", RISCV_ISA_EXT_ZKNE);
> +				SET_ISA_EXT_MAP("zk", RISCV_ISA_EXT_ZKNH);
> +				SET_ISA_EXT_MAP("zk", RISCV_ISA_EXT_ZKR);
> +				SET_ISA_EXT_MAP("zk", RISCV_ISA_EXT_ZKT);
>  			}
>  #undef SET_ISA_EXT_MAP
>  		}
> -- 
> 2.35.1
> 
