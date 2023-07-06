Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D58CB74A2C2
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 19:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232211AbjGFRF6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 13:05:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231169AbjGFRF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 13:05:57 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF88F1BE8
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 10:05:55 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id 5614622812f47-3a3373211a1so856790b6e.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jul 2023 10:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20221208.gappssmtp.com; s=20221208; t=1688663155; x=1691255155;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DbYorBSGNgBnNiqoshTpZfEFQccGjhuwwnRL/44SoP0=;
        b=i4T0nNOBYy25Tum7t/4GwKsh3/lK7Uikcmkb4kOyw4gG9SEUDys1g5J3pJUji2g/jJ
         LPaszbqCG0hhdxw9/hcWYxo+RYH1ml6lnNIyZhbERDGwRvHc2ctOj7XJ44sxi7yENjUw
         ISHeOYxF9bfqqQgSJQFLfwKIWcXdzga6nV9hUibEpf/kvOAbkrIbqaSJYSVMFCC5fXPg
         NqTooUkkAax89B8soY2d4ySMk4P3KloKJZNOjV7UtnbJUPzBK/u/RQMv8olff4elOxxD
         8bPApwuR0J8ZY0C0moK+z9bNXqPu0MEPf38pn/4p0aoolZvo2R1Y15goKKKXtRMx59w7
         uAOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688663155; x=1691255155;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DbYorBSGNgBnNiqoshTpZfEFQccGjhuwwnRL/44SoP0=;
        b=HR3Iy26Dpyb80Bdz/h2f2CklNJCPtjR+wJEx8IoMNikIn9AgTLWeqwhQf+fgH5Y9na
         +zh13JnYj+S3AU+rRo2o0fnNPjCCoZrAq5+xoSDxfF0bCLwIAB7JkFR57VRkKBJw/RHK
         6zVLAqLZ3y+C3uEM/NJp41DvPXaCkdz2qMXQurmY8r3NRiH7j6yvTQ/l/xUiTE0DyVyO
         vrySWMYc6bcOa8Thaz/iCcLa+Orq+qZRbpuFCGNvi5AnsP17gM0jpF1yf92E9XSmgS5b
         k0GyH0f0iu36kENksyMev49YOsKLQWklqialntPij8RMg59sog1vjRYSbMwtXz4PX2mL
         F09A==
X-Gm-Message-State: ABy/qLZih4zIj6eoQvPZMhhteJB6mS35mHP19TfacYlp2Wvn/mowxPM9
        8naMt4WxziMjK97NIoBE80BX3A==
X-Google-Smtp-Source: APBJJlHVjAgGUeOK5ZObTBmnmtOv0vpCjPIptZy244A4rKJYcvX5zFmOq+/846tjHtfgDBgeTsJodw==
X-Received: by 2002:a05:6808:2784:b0:3a2:1b3b:494b with SMTP id es4-20020a056808278400b003a21b3b494bmr2067218oib.45.1688663154961;
        Thu, 06 Jul 2023 10:05:54 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id 3-20020a17090a030300b0026390b2d136sm46808pje.18.2023.07.06.10.05.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 10:05:54 -0700 (PDT)
Date:   Thu, 06 Jul 2023 10:05:54 -0700 (PDT)
X-Google-Original-Date: Thu, 06 Jul 2023 10:05:06 PDT (-0700)
Subject:     Re: [PATCH] riscv: Start of DRAM should at least be aligned on PMD size for the direct mapping
In-Reply-To: <20230704121837.248976-1-alexghiti@rivosinc.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        suagrfillet@gmail.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, alexghiti@rivosinc.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     alexghiti@rivosinc.com
Message-ID: <mhng-c5a71036-061e-4704-bcdf-2b23cab36908@palmer-ri-x1c9a>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 04 Jul 2023 05:18:37 PDT (-0700), alexghiti@rivosinc.com wrote:
> So that we do not end up mapping the whole linear mapping using 4K
> pages, which is slow at boot time, and also very likely at runtime.
>
> So make sure we align the start of DRAM on a PMD boundary.
>
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---
>  arch/riscv/mm/init.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index 4fa420faa780..4a43ec275c6d 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -214,8 +214,13 @@ static void __init setup_bootmem(void)
>  	memblock_reserve(vmlinux_start, vmlinux_end - vmlinux_start);
>
>  	phys_ram_end = memblock_end_of_DRAM();
> +
> +	/*
> +	 * Make sure we align the start of the memory on a PMD boundary so that
> +	 * at worst, we map the linear mapping with PMD mappings.
> +	 */
>  	if (!IS_ENABLED(CONFIG_XIP_KERNEL))
> -		phys_ram_base = memblock_start_of_DRAM();
> +		phys_ram_base = memblock_start_of_DRAM() & PMD_MASK;

This rounds down, which IIUC will result in mappings outside what 
memblock detected as the start af DRAM.  I'd expect that to cause bad 
behavior somewhere.

Shouldn't we be rounding up?

>
>  	/*
>  	 * In 64-bit, any use of __va/__pa before this point is wrong as we
