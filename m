Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9631624DDD
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 23:59:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231753AbiKJW7T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 17:59:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbiKJW7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 17:59:16 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B38917E17
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 14:59:15 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id p12so2802697plq.4
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 14:59:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LCiO+gXRF0lDVHlLBo3c4ej39VeZ3e6BYvKE2zsZKq0=;
        b=abTOCpM9RICqb1ONalOCn5LkxeesH4sL8drYDcbMXZ7kf00g+YuIpyzU4MM/cveqUN
         qweuuVXbHDaEYOpB2fvFUJ/8dB8L1x4/dbT3Tw452JhPAxjfIByRa/xziRHAHlkDIQW7
         qVvFTRg94rg0VkuoHQkhasr4ks6dXRN7pgaNfFhs47M/OgE9odD2HzsUweTg6tuai6Ea
         xKpQQVdSrZpzco6K6nR4sCVmSwI1mghyTguejHX9lokPPVS3gk53pqK4lyC+QNGNrpWc
         ThI6Z0UNwrLX0Jq2x4Ze/dlzkGwrQsC/pu619Mx8MXENmFS23EjZKrOR+p5MSOXfAuEH
         ZfcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LCiO+gXRF0lDVHlLBo3c4ej39VeZ3e6BYvKE2zsZKq0=;
        b=wIFgy3HZDJLbNEpPlLsMBM7+v5n+HfU92vUdAvg9nIvq/fU5RpF8T1xVlaUTnhpyR9
         5mrAOQMc3TpnTAsC+JK3qXyZunqL4LLdOcpvYJcGXng2lQQCgQWB9WD2Om2SIw5KZagS
         l6PFXejkVfjL5/L2RHSpFQYw5V/7sDCNoBNaa9X4Pa/9J0ZqlXpRHP1DUOIVTvE1yrdX
         CY0trhaEyydJ9O2v8wtE5PdP/iWa+ngGujs5Jn3zW/JuxGpGSBoGS/H6kvAJMaTfM0mY
         hDK3XmeGe1Ci0bA9KnbSOHv7q8bKMUJJI5p4OI/YAN9doYNEJq5SaPzT42kNg9TVH2Wq
         lPEg==
X-Gm-Message-State: ACrzQf3nhatzLRnHrTNyEUYm9B/uQ766eWnmyXtfD63xa4Vxfo7FOSGn
        zTQQ3KFAej7Wskd5gXk+JdnuMQ==
X-Google-Smtp-Source: AMsMyM6QmlJIusDk6bkMVYwQaiW/f3iTlZWIxaYlNHDq8CwDnodWF9tpEOQ3GmtzvkQ7TR4kWRhTnQ==
X-Received: by 2002:a17:902:eccb:b0:176:cf64:2f39 with SMTP id a11-20020a170902eccb00b00176cf642f39mr2423235plh.93.1668121154780;
        Thu, 10 Nov 2022 14:59:14 -0800 (PST)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id a11-20020a170902eccb00b00186b7443082sm196815plh.195.2022.11.10.14.59.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 14:59:14 -0800 (PST)
In-Reply-To: <20221107151524.3941467-1-conor.dooley@microchip.com>
References: <20221107151524.3941467-1-conor.dooley@microchip.com>
Subject: Re: [PATCH v1] riscv: fix reserved memory setup
Message-Id: <166812084905.21827.16442600363878515593.b4-ty@rivosinc.com>
Date:   Thu, 10 Nov 2022 14:54:09 -0800
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-36ce3
Cc:     Atish Patra <atishp@rivosinc.com>, linux-riscv@lists.infradead.org,
        Albert Ou <aou@eecs.berkeley.edu>,
        Nick Kossifidis <mick@ics.forth.gr>,
        linux-kernel@vger.kernel.org,
        Evgenii Shatokhin <e.shatokhin@yadro.com>,
        Anup Patel <anup@brainfault.org>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Valentina Fernandez <valentina.fernandezalanis@microchip.com>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Conor Dooley <conor.dooley@microchip.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Nov 2022 15:15:25 +0000, Conor Dooley wrote:
> Currently, RISC-V sets up reserved memory using the "early" copy of the
> device tree. As a result, when trying to get a reserved memory region
> using of_reserved_mem_lookup(), the pointer to reserved memory regions
> is using the early, pre-virtual-memory address which causes a kernel
> panic when trying to use the buffer's name:
> 
>  Unable to handle kernel paging request at virtual address 00000000401c31ac
>  Oops [#1]
>  Modules linked in:
>  CPU: 0 PID: 0 Comm: swapper Not tainted 6.0.0-rc1-00001-g0d9d6953d834 #1
>  Hardware name: Microchip PolarFire-SoC Icicle Kit (DT)
>  epc : string+0x4a/0xea
>   ra : vsnprintf+0x1e4/0x336
>  epc : ffffffff80335ea0 ra : ffffffff80338936 sp : ffffffff81203be0
>   gp : ffffffff812e0a98 tp : ffffffff8120de40 t0 : 0000000000000000
>   t1 : ffffffff81203e28 t2 : 7265736572203a46 s0 : ffffffff81203c20
>   s1 : ffffffff81203e28 a0 : ffffffff81203d22 a1 : 0000000000000000
>   a2 : ffffffff81203d08 a3 : 0000000081203d21 a4 : ffffffffffffffff
>   a5 : 00000000401c31ac a6 : ffff0a00ffffff04 a7 : ffffffffffffffff
>   s2 : ffffffff81203d08 s3 : ffffffff81203d00 s4 : 0000000000000008
>   s5 : ffffffff000000ff s6 : 0000000000ffffff s7 : 00000000ffffff00
>   s8 : ffffffff80d9821a s9 : ffffffff81203d22 s10: 0000000000000002
>   s11: ffffffff80d9821c t3 : ffffffff812f3617 t4 : ffffffff812f3617
>   t5 : ffffffff812f3618 t6 : ffffffff81203d08
>  status: 0000000200000100 badaddr: 00000000401c31ac cause: 000000000000000d
>  [<ffffffff80338936>] vsnprintf+0x1e4/0x336
>  [<ffffffff80055ae2>] vprintk_store+0xf6/0x344
>  [<ffffffff80055d86>] vprintk_emit+0x56/0x192
>  [<ffffffff80055ed8>] vprintk_default+0x16/0x1e
>  [<ffffffff800563d2>] vprintk+0x72/0x80
>  [<ffffffff806813b2>] _printk+0x36/0x50
>  [<ffffffff8068af48>] print_reserved_mem+0x1c/0x24
>  [<ffffffff808057ec>] paging_init+0x528/0x5bc
>  [<ffffffff808031ae>] setup_arch+0xd0/0x592
>  [<ffffffff8080070e>] start_kernel+0x82/0x73c
> 
> [...]

Applied, thanks!

[1/1] riscv: fix reserved memory setup
      https://git.kernel.org/palmer/c/50e63dd8ed92

Best regards,
-- 
Palmer Dabbelt <palmer@rivosinc.com>
