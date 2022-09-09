Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91A025B38B1
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 15:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbiIINMb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 09:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiIINM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 09:12:27 -0400
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E124196FF3;
        Fri,  9 Sep 2022 06:12:25 -0700 (PDT)
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-1279948d93dso3698009fac.10;
        Fri, 09 Sep 2022 06:12:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=UIRvXHTNoeDqezjVDKZIa9QbJ/vSoeeLNCnvGd1A/vc=;
        b=W5MAEL96nd7bZHpnVME9pqpX72gDrM1qyD2BZAjEEHeUFuy/K+jhhlpdYS71fJ0GaV
         ndzgAZz0FnNaXF2FXBX2xfAJBhhWJvfo/0xBwBnZpbEanAr7h9FLHMm38sY6IRsAwQL9
         1LjPm11AUgZZy9CSNDlinEL1cfaDhMNSsXSuhJ/kUAuFFndTfxPwDDbWYIjsXHK294O/
         6Gedkcr5QDCMqjaakwieirZlvElRczM9FQ61KBtnKaDRzOwY90HF4/XtPOAnyl7cTLlg
         RHGxOatyS0OKZ672jAF3LSkjf9M7ZkzCIq7vivxrMrDSNVTm3HHRZcvc7z9VE0cEUf8R
         tObQ==
X-Gm-Message-State: ACgBeo22qkjwMWI0pbKZIEuU6hyRuoxuZE5U8Ch5/8m6IMEamZIltnNY
        zl/fFbNjjoofMDfPAyLaP0PCBPOCVA==
X-Google-Smtp-Source: AA6agR7cCDucdSYelHHvnx027e8Kw1szzFVyW4fTzmwx0A3MdQvbRHl7VXLH0+ZF0EGR0NDVMpya4A==
X-Received: by 2002:a05:6871:14e:b0:127:3f08:4599 with SMTP id z14-20020a056871014e00b001273f084599mr4748909oab.183.1662729145015;
        Fri, 09 Sep 2022 06:12:25 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id a8-20020a544e08000000b0034d8b1b3c4bsm216108oiy.36.2022.09.09.06.12.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 06:12:24 -0700 (PDT)
Received: (nullmailer pid 812506 invoked by uid 1000);
        Fri, 09 Sep 2022 13:12:23 -0000
Date:   Fri, 9 Sep 2022 08:12:23 -0500
From:   Rob Herring <robh@kernel.org>
To:     Marek Bykowski <marek.bykowski@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v3] of/fdt: =?iso-8859-1?Q?Don'?=
 =?iso-8859-1?Q?t_calculate_initrd_size_from_DT_if=A0start?= > end
Message-ID: <20220909131223.GA812258-robh@kernel.org>
References: <20220909023358.76881-1-marek.bykowski@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220909023358.76881-1-marek.bykowski@gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 09 Sep 2022 02:33:57 +0000, Marek Bykowski wrote:
> If the properties 'linux,initrd-start' and 'linux,initrd-end' of
> the chosen node populated from the bootloader, eg. U-Boot, are so that
> start > end, then the phys_initrd_size calculated from end - start is
> negative that subsequently gets converted to a high positive value for
> being unsigned long long. Then, the memory region with the (invalid)
> size is added to the bootmem and attempted being paged in paging_init()
> that results in the kernel fault.
> 
> For example, on the FVP ARM64 system I'm running, the U-Boot populates
> the 'linux,initrd-start' with 8800_0000 and 'linux,initrd-end' with 0.
> The phys_initrd_size calculated is then ffff_ffff_7800_0000
> (= 0 - 8800_0000 = -8800_0000 + ULLONG_MAX + 1). paging_init() then
> attempts to map the address 8800_0000 + ffff_ffff_7800_0000 and oops'es
> as below.
> 
> It should be stressed, it is generally a fault of the bootloader's with
> the kernel relying on it, however we should not allow the bootloader's
> misconfiguration to lead to the kernel oops. Not only the kernel should be
> bullet proof against it but also finding the root cause of the paging
> fault spanning over the bootloader, DT, and kernel may happen is not so
> easy.
> 
>   Unable to handle kernel paging request at virtual address fffffffefe43c000
>   Mem abort info:
>     ESR = 0x96000007
>     EC = 0x25: DABT (current EL), IL = 32 bits
>     SET = 0, FnV = 0
>     EA = 0, S1PTW = 0
>   Data abort info:
>     ISV = 0, ISS = 0x00000007
>     CM = 0, WnR = 0
>   swapper pgtable: 4k pages, 39-bit VAs, pgdp=0000000080e3d000
>   [fffffffefe43c000] pgd=0000000080de9003, pud=0000000080de9003
>   Unable to handle kernel paging request at virtual address ffffff8000de9f90
>   Mem abort info:
>     ESR = 0x96000005
>     EC = 0x25: DABT (current EL), IL = 32 bits
>     SET = 0, FnV = 0
>     EA = 0, S1PTW = 0
>   Data abort info:
>     ISV = 0, ISS = 0x00000005
>     CM = 0, WnR = 0
>   swapper pgtable: 4k pages, 39-bit VAs, pgdp=0000000080e3d000
>   [ffffff8000de9f90] pgd=0000000000000000, pud=0000000000000000
>   Internal error: Oops: 96000005 [#1] PREEMPT SMP
>   Modules linked in:
>   CPU: 0 PID: 0 Comm: swapper Not tainted 5.4.51-yocto-standard #1
>   Hardware name: FVP Base (DT)
>   pstate: 60000085 (nZCv daIf -PAN -UAO)
>   pc : show_pte+0x12c/0x1b4
>   lr : show_pte+0x100/0x1b4
>   sp : ffffffc010ce3b30
>   x29: ffffffc010ce3b30 x28: ffffffc010ceed80
>   x27: fffffffefe43c000 x26: fffffffefe43a028
>   x25: 0000000080bf0000 x24: 0000000000000025
>   x23: ffffffc010b8d000 x22: ffffffc010e3d000
>   x23: ffffffc010b8d000 x22: ffffffc010e3d000
>   x21: 0000000080de9000 x20: ffffff7f80000f90
>   x19: fffffffefe43c000 x18: 0000000000000030
>   x17: 0000000000001400 x16: 0000000000001c00
>   x15: ffffffc010cef1b8 x14: ffffffffffffffff
>   x13: ffffffc010df1f40 x12: ffffffc010df1b70
>   x11: ffffffc010ce3b30 x10: ffffffc010ce3b30
>   x9 : 00000000ffffffc8 x8 : 0000000000000000
>   x7 : 000000000000000f x6 : ffffffc010df16e8
>   x5 : 0000000000000000 x4 : 0000000000000000
>   x3 : 00000000ffffffff x2 : 0000000000000000
>   x1 : 0000008080000000 x0 : ffffffc010af1d68
>   Call trace:
>    show_pte+0x12c/0x1b4
>    die_kernel_fault+0x54/0x78
>    __do_kernel_fault+0x11c/0x128
>    do_translation_fault+0x58/0xac
>    do_mem_abort+0x50/0xb0
>    el1_da+0x1c/0x90
>    __create_pgd_mapping+0x348/0x598
>    paging_init+0x3f0/0x70d0
>    setup_arch+0x2c0/0x5d4
>    start_kernel+0x94/0x49c
>   Code: 92748eb5 900052a0 9135a000 cb010294 (f8756a96)
> 
> Signed-off-by: Marek Bykowski <marek.bykowski@gmail.com>
> ---
> v2 -> v3:
> - I confused the description I fixed now. I put that we should
>   complain if start < end and it should be the other way around
>   if end > start
> v1 -> v2:
> - followed Rob's suggestion that we check on start > end instead of
>   for end being 0
> ---
>  drivers/of/fdt.c | 2 ++
>  1 file changed, 2 insertions(+)
> 

Applied, thanks!
