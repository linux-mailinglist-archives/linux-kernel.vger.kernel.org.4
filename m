Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAD816017E2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 21:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbiJQTkc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 15:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbiJQTk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 15:40:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4F606C750;
        Mon, 17 Oct 2022 12:40:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B04CBB81A2E;
        Mon, 17 Oct 2022 19:40:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BA86C433D7;
        Mon, 17 Oct 2022 19:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666035619;
        bh=PoXBeSReIgM+CQoQFfALFgw1SR3n3qlfZ7NKvcrE5EU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dLbdx3qp4igqZeYdoIqsPx9OipZNjUoAH5jTM6hMaf60PyURO4ukHV+fiCMlCstS6
         InK/ibE8Wt4PT1Usl94deknM1j9AjVmCyqP9OuwOq2hH007N5KvOVAfbLuhX1ojWhU
         /hJ2yc8kHTbw2pViQF+1oOE5xW1kiSHft+Cq/Gf2kJN3F6PTRwY00D7mgseDw6oX2b
         UAgHHWDyHVIBYRKgGUqmbugxXX7qidWPpKcNGf+uaAsCO3fEZAlE93oazPcjUQQz+c
         pfZ973IIquhBinsUzB5soRIdDqcWZdTMPBLNeXHJ5S4s2Nbef0C91W6qhWRRfR7i1e
         xm66VcLLXdhvg==
Date:   Mon, 17 Oct 2022 20:40:11 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Xianting Tian <xianting.tian@linux.alibaba.com>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, anup@brainfault.org, heiko@sntech.de,
        guoren@kernel.org, mick@ics.forth.gr,
        alexandre.ghiti@canonical.com, bhe@redhat.com, vgoyal@redhat.com,
        dyoung@redhat.com, corbet@lwn.net, Conor.Dooley@microchip.com,
        bagasdotme@gmail.com, kexec@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, crash-utility@redhat.com,
        heinrich.schuchardt@canonical.com, k-hagio-ab@nec.com,
        hschauhan@nulltrace.org, yixun.lan@gmail.com
Subject: Re: [PATCH V2 2/2] Documentation: kdump: describe VMCOREINFO export
 for RISCV64
Message-ID: <Y02vm7FrhdEoSXZ+@spud>
References: <20221014134139.5151-1-xianting.tian@linux.alibaba.com>
 <20221014134139.5151-3-xianting.tian@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221014134139.5151-3-xianting.tian@linux.alibaba.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 14, 2022 at 09:41:39PM +0800, Xianting Tian wrote:
> The following interrelated definitions and ranges are needed by the kdump
> crash tool, they are exported by "arch/riscv/kernel/crash_core.c":
>     VA_BITS,
>     PAGE_OFFSET,
>     phys_ram_base,
>     MODULES_VADDR ~ MODULES_END,
>     VMALLOC_START ~ VMALLOC_END,
>     VMEMMAP_START ~ VMEMMAP_END,
>     KASAN_SHADOW_START ~ KASAN_SHADOW_END,
>     KERNEL_LINK_ADDR ~ ADDRESS_SPACE_END
> 
> Document these RISCV64 exports above.
> 
> Signed-off-by: Xianting Tian <xianting.tian@linux.alibaba.com>
> ---
>  .../admin-guide/kdump/vmcoreinfo.rst          | 30 +++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kdump/vmcoreinfo.rst b/Documentation/admin-guide/kdump/vmcoreinfo.rst
> index 6726f439958c..8e2e164cf3db 100644
> --- a/Documentation/admin-guide/kdump/vmcoreinfo.rst
> +++ b/Documentation/admin-guide/kdump/vmcoreinfo.rst
> @@ -595,3 +595,33 @@ X2TLB
>  -----
>  
>  Indicates whether the crashed kernel enabled SH extended mode.
> +
> +RISCV64
> +=======
> +
> +VA_BITS
> +-------
> +
> +The maximum number of bits for virtual addresses. Used to compute the
> +virtual memory ranges.
> +
> +PAGE_OFFSET
> +-----------
> +
> +Indicates the virtual kernel start address of direct-mapped RAM region.

Apologies for not seeing this sooner, but should there not be a "the"
prior to "direct-mapped"?

> +
> +phys_ram_base
> +-------------
> +
> +Indicates the start physical RAM address.
> +
> +MODULES_VADDR|MODULES_END|VMALLOC_START|VMALLOC_END|VMEMMAP_START|VMEMMAP_END|KASAN_SHADOW_START|KASAN_SHADOW_END|KERNEL_LINK_ADDR|ADDRESS_SPACE_END
> +----------------------------------------------------------------------------------------------------------------------------------------------------
> +
> +Used to get the correct ranges:
> +
> +  * MODULES_VADDR ~ MODULES_END : Kernel module space.
> +  * VMALLOC_START ~ VMALLOC_END : vmalloc() / ioremap() space.
> +  * VMEMMAP_START ~ VMEMMAP_END : vmemmap region, used for struct page array.

Since I'm in pedant mode, it does look a little odd that you're using
region for vmemmap but space for the others but idc that much.

Thanks,
Conor.

> +  * KASAN_SHADOW_START ~ KASAN_SHADOW_END : kasan shadow space.
> +  * KERNEL_LINK_ADDR ~ ADDRESS_SPACE_END : Kernel link and BPF space.
> -- 
> 2.17.1
> 
> 
