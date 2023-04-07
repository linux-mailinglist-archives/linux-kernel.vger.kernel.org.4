Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB5A26DAC7A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 14:03:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240564AbjDGMDd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 08:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjDGMDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 08:03:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5370783CD;
        Fri,  7 Apr 2023 05:03:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9165360F90;
        Fri,  7 Apr 2023 12:03:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D7BDC4339B;
        Fri,  7 Apr 2023 12:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680869009;
        bh=MDs+MtGIXGFtAsm2rEE3JPZAgrsutam8x/+OyQ6U/5Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CdUYTX/0/+T9+z9T0OX02fulTzrK0zyn+hY+KU0Ur572LTK2I7rQcUfOgGaBnhPRo
         ambh4jV0pVIr3U4pU0iogCbVobAeEL28y+0+soqZjQmEOPVMv4bKzjW8TnJbNu6QeG
         NgTY3NkpLzztvLl5tfUsyR4E6nzurftFip1H4rEaJco8ZhdFUpmEWUK2UmnFg93Z2/
         TFvhvuZh/EwITPZfg8gYG/JDXQAAbMeABH072LcXVYuv6CfiYDeJr+mJx0BTxcbKOQ
         yGI7VxGsk78TZkWIkVuFCW40AaU5CLA9eRCADsYEiijPIEQGePzGSqqiv/dksnm2vT
         BdkpJiCa/Fzpg==
Date:   Fri, 7 Apr 2023 14:03:23 +0200
From:   Simon Horman <horms@kernel.org>
To:     Chen Jiahao <chenjiahao16@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        kexec@lists.infradead.org, linux-doc@vger.kernel.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        conor.dooley@microchip.com, guoren@kernel.org, heiko@sntech.de,
        bjorn@rivosinc.com, alex@ghiti.fr, akpm@linux-foundation.org,
        atishp@rivosinc.com, bhe@redhat.com, thunder.leizhen@huawei.com
Subject: Re: [PATCH -next v3 1/2] riscv: kdump: Implement
 crashkernel=X,[high,low]
Message-ID: <ZDAGi2/+1q0oEUZ5@kernel.org>
References: <20230406220206.3067006-1-chenjiahao16@huawei.com>
 <20230406220206.3067006-2-chenjiahao16@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230406220206.3067006-2-chenjiahao16@huawei.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 07, 2023 at 06:02:05AM +0800, Chen Jiahao wrote:
> On riscv, the current crash kernel allocation logic is trying to
> allocate within 32bit addressible memory region by default, if
> failed, try to allocate without 4G restriction.
> 
> In need of saving DMA zone memory while allocating a relatively large
> crash kernel region, allocating the reserved memory top down in
> high memory, without overlapping the DMA zone, is a mature solution.
> Here introduce the parameter option crashkernel=X,[high,low].
> 
> One can reserve the crash kernel from high memory above DMA zone range
> by explicitly passing "crashkernel=X,high"; or reserve a memory range
> below 4G with "crashkernel=X,low".
> 
> Signed-off-by: Chen Jiahao <chenjiahao16@huawei.com>

...

> @@ -1180,14 +1206,37 @@ static void __init reserve_crashkernel(void)
>  		return;
>  	}
>  
> -	ret = parse_crashkernel(boot_command_line, memblock_phys_mem_size(),
> +	ret = parse_crashkernel(cmdline, memblock_phys_mem_size(),
>  				&crash_size, &crash_base);
> -	if (ret || !crash_size)
> +	if (ret == -ENOENT) {
> +		/*
> +		 * crashkernel=X,[high,low] can be specified or not, but
> +		 * invalid value is not allowed.

nit: Perhaps something like this would be easier to correlate with the
     code that follows:

		/* Fallback to crashkernel=X,[high,low] */


> +		 */
> +		ret = parse_crashkernel_high(cmdline, 0, &crash_size, &crash_base);
> +		if (ret || !crash_size)
> +			return;
> +
> +		/*
> +		 * crashkernel=Y,low is valid only when crashkernel=X,high
> +		 * is passed and high memory is reserved successful.

nit: s/successful/successfully/

> +		 */
> +		ret = parse_crashkernel_low(cmdline, 0, &crash_low_size, &crash_base);
> +		if (ret == -ENOENT)
> +			crash_low_size = DEFAULT_CRASH_KERNEL_LOW_SIZE;
> +		else if (ret)
> +			return;
> +
> +		search_start = search_low_max;
> +	} else if (ret || !crash_size) {
> +		/* Invalid argument value specified */
>  		return;
> +	}

...
