Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B66F6337B2
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 09:58:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233001AbiKVI6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 03:58:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233008AbiKVI5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 03:57:55 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A132D13F8F
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 00:57:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1669107470; x=1700643470;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+SSTtDJKH/DT1imwO1wWLGEs22th08LxjRQLt0jLVxY=;
  b=RtpgOb2xeVbybvEW1m7nJLFEnLCJoklOwzZL+ZzFeZky/w9XOreW/Itu
   cpMwMkIbCeZyTGpkS8jeMPyWgo54mBK6gW+sw2NmhepS4x55Mw2e/GnGC
   ol8VeIT6nGZJXolb5fifmO6IwCQ0VNAHY4wZNIBMA3+2T5NR1THjUsb7S
   mO0BG0KZxCCFlJR08Qb7ojM70zRRzM5Fh1SbPu6sYfUQowqxcrxjp+czW
   bhVjetK/Bb4tm72fk0ogtTY3HOib1esZg9Oh8ghiBiImgknzp+ptwP8SH
   pvtJHVXSXMlrJEKmTFw6Sqwz3G6tkyCOl9OW6y/YD4TTM+xkYooYeNQ+e
   w==;
X-IronPort-AV: E=Sophos;i="5.96,183,1665471600"; 
   d="scan'208";a="124555764"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 22 Nov 2022 01:57:49 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 22 Nov 2022 01:57:49 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Tue, 22 Nov 2022 01:57:48 -0700
Date:   Tue, 22 Nov 2022 08:57:30 +0000
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Song Shuai <suagrfillet@gmail.com>
CC:     <guoren@kernel.org>, <rostedt@goodmis.org>, <mhiramat@kernel.org>,
        <mark.rutland@arm.com>, <paul.walmsley@sifive.com>,
        <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] riscv/ftrace: fix ftrace_modify_call bug
Message-ID: <Y3yO+ii+NEVPTYFo@wendy>
References: <20221122075440.1165172-1-suagrfillet@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221122075440.1165172-1-suagrfillet@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,T_SPF_TEMPERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2022 at 03:54:40PM +0800, Song Shuai wrote:
> With this commit (riscv: ftrace: Reduce the detour code size to half)

AFAICT the above patch has not been applied & this patch here should be
folded into the offending patch?
I've marked this one as "Not Applicable" in patchwork as a result, but
let me know if that is an incorrect assumption.

Thanks,
Conor.

> patched, ftrace bug occurred When hosting kprobe and function tracer
> at the same function.
> 
> Obviously, the variable caller in ftrace_modify_call was assigned by
> rec->ip with 4 offset failing the code replacing at function entry.
> And the caller should be assigned by rec->ip directly to indicate
> the function entry.
> 
> The following is the ftrace bug log.
> 
> ```
> [  419.632855] 00000000f8776803: expected (ffe00297 1a4282e7) but got (1a8282e7 f0227179)
> [  419.633390] ------------[ ftrace bug ]------------
> [  419.633553] ftrace failed to modify
> [  419.633569] [<ffffffff802091cc>] kernel_read+0x0/0x52
> [  419.633863]  actual:   97:02:e0:ff:e7:82:82:1a
> [  419.634087] Updating ftrace call site to call a different ftrace function
> [  419.634279] ftrace record flags: e0000002
> [  419.634487]  (2) R
> [  419.634487]  expected tramp: ffffffff800093cc
> [  419.634935] ------------[ cut here ]------------
> ```
> 
> Signed-off-by: Song Shuai <suagrfillet@gmail.com>
> ---
>  arch/riscv/kernel/ftrace.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/kernel/ftrace.c b/arch/riscv/kernel/ftrace.c
> index 8c77f236fc71..61b24d767e2e 100644
> --- a/arch/riscv/kernel/ftrace.c
> +++ b/arch/riscv/kernel/ftrace.c
> @@ -132,7 +132,7 @@ int ftrace_modify_call(struct dyn_ftrace *rec, unsigned long old_addr,
>  		       unsigned long addr)
>  {
>  	unsigned int call[2];
> -	unsigned long caller = rec->ip + 4;
> +	unsigned long caller = rec->ip;
>  	int ret;
>  
>  	make_call_t0(caller, old_addr, call);
> -- 
> 2.20.1
> 
