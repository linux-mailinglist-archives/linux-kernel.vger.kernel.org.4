Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 276C2693D89
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 05:52:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbjBMEwA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 23:52:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjBMEv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 23:51:58 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3785A1042F
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 20:51:57 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id b1so7126327pft.1
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 20:51:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oq7C8udiwiuM1QeRLy8ZEJLvZIfEEYFRjz7GBfZu0bQ=;
        b=QMhVRjdrCPbJnYtCrdcYMXoB0eRpPbQcgUIRRLpkGARxwTLhnovFayqBODSFq6QhUA
         Jkz7ZRs0x3eipK65IVp6/kBUPjp+7pXJWnZn4PflTzRFovnigq/WqNpqcYbAnH0OTKKl
         Y1cCxSkVL38c+ZDaqpecNKpk4Ja52YgjWWLmccGomLF+oT8myAq7072SlGdKdEv7MA2x
         Sm3mvT0SZywdO5e3p+xceR9qKnj/MfC4pHOQYWbaSN0Hwx4or67TVQP8z90XjKLYLcMf
         xwTeNR0225m+muWQzC8/i16LrtQiomihHCzxi6uYtW78dWZVdnJEuEMeflr90h4h0mii
         R8Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oq7C8udiwiuM1QeRLy8ZEJLvZIfEEYFRjz7GBfZu0bQ=;
        b=EgmDSqeoMJEOMoepNjUodduk+fwES8jDU+Y8bXJRWd2EV69sTC+xwja14Bih3B0V+P
         KiHi9x+DLae3wx/VhKlXxrTN2wpEibWri4jY64PxufZYyNx5886khgVKApZ0KrFiBT1O
         zKYcISC/0vAq2scs/1RARjpR2WxNBtM4qgOfpn+BSbFZ3JD2tBPfqXFsR2vtQAsjitba
         H0Ux0RW8T1r2mNvqMCqLdX576cIYEymu0YxYDKuu24KkC5OqPnv6nGqOyR5RF5me9BLO
         0opX+Lwe7aOfcnRuRjK/cSJ7QQCMXhkVQ71B3JAsKyWnxXAThqgH53kmZRlsiBAxHBmM
         2daQ==
X-Gm-Message-State: AO0yUKXs7v/btB3t5VuHe/yOKEi36XbdFKYchREpvfjrEka1+mWF1JJC
        4eQ2B7ynImWpIfnqEmIOsj6Yig==
X-Google-Smtp-Source: AK7set9UVe9XBXtZnMsy5uh08YlZ09431p6siV39bLauOyCIvPcH6XKGZV41Wibdh5kV9aFz2s7djw==
X-Received: by 2002:a62:1a8a:0:b0:593:d2ab:fdfb with SMTP id a132-20020a621a8a000000b00593d2abfdfbmr17944729pfa.13.1676263916591;
        Sun, 12 Feb 2023 20:51:56 -0800 (PST)
Received: from sunil-laptop ([49.206.14.226])
        by smtp.gmail.com with ESMTPSA id y16-20020aa78050000000b0056283e2bdbdsm6865417pfm.138.2023.02.12.20.51.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Feb 2023 20:51:56 -0800 (PST)
Date:   Mon, 13 Feb 2023 10:21:47 +0530
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     Conor Dooley <conor@kernel.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Anup Patel <apatel@ventanamicro.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Atish Patra <atishp@rivosinc.com>
Subject: Re: [PATCH 00/24] Add basic ACPI support for RISC-V
Message-ID: <Y+nB43zhZyTevQuH@sunil-laptop>
References: <20230130182225.2471414-1-sunilvl@ventanamicro.com>
 <Y+Ppv6kB1iksf+TF@spud>
 <Y+Pu/z7dN87v3udc@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+Pu/z7dN87v3udc@spud>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Conor,

On Wed, Feb 08, 2023 at 06:50:39PM +0000, Conor Dooley wrote:
> On Wed, Feb 08, 2023 at 06:28:15PM +0000, Conor Dooley wrote:
> > Hey Sunil,
> > 
> > On Mon, Jan 30, 2023 at 11:52:01PM +0530, Sunil V L wrote:
> > > This patch series enables the basic ACPI infrastructure for RISC-V.
> > > Supporting external interrupt controllers is in progress and hence it is
> > > tested using polling based HVC SBI console and RAM disk.
> > > 
> > > The series depends on Anup's IPI improvement series.
> > > https://github.com/avpatel/linux/commits/riscv_ipi_imp_v17
> > 
> > In the future, please provide links to patchsets rather than "random"
> > git trees.
> > 
> > > Jisheng Zhang (1):
> > >   riscv: move sbi_init() earlier before jump_label_init()
> >     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > 
> > What has this patch got to do with your series? Just something that was
> > sitting in your tree?
> > 
> > If you need this, it'd be ideal if you would submit *with* the R-b tags
> > it appears to have had by v6 [1] & add the reason that you need to move
> > it to the commit message.
> > In Jisheng's series that was obvious, but this is a significantly larger
> > series and it is hard to spot your reasoning for it.
> 
> Apologies, I forgot to provide the link!
> https://lore.kernel.org/all/20220821140918.3613-1-jszhang@kernel.org/
> 

First of all, thank you very much for your detailed review!!. Will address
your comments in the next revision of the series I am preparing to send this
week.

This patch from Jisheng is required to enable ACPI for the same reason.
sbi_init() should be called before jump_label_init(). Otherwise, I hit a
panic like below.

[   0.000000] efi: seeding entropy pool
 [   0.000000] sbi_remote_fence_i: Enter for cpu_mask = 0000000000000000
 [   0.000000] Kernel panic - not syncing: __sbi_rfence is called before sbi_init!!!
 [   0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 5.19.0-rc3-00079-gd3ee951eeea1-dirty #3
 [   0.000000] Call Trace:
 [   0.000000] [<ffffffff80005900>] dump_backtrace+0x1c/0x24
 [   0.000000] [<ffffffff8072a83e>] show_stack+0x2c/0x38
 [   0.000000] [<ffffffff8072fe7c>] dump_stack_lvl+0x40/0x58
 [   0.000000] [<ffffffff8072fea8>] dump_stack+0x14/0x1c
 [   0.000000] [<ffffffff8072ae4a>] panic+0x106/0x2c6
 [   0.000000] [<ffffffff8072a964>] sbi_remote_fence_i+0x32/0x4a
 [   0.000000] [<ffffffff80009c22>] flush_icache_all+0x1a/0x44
 [   0.000000] [<ffffffff8000622a>] patch_text_nosync+0x1e/0x2a
 [   0.000000] [<ffffffff800084da>] arch_jump_label_transform+0x48/0xd0
 [   0.000000] [<ffffffff801013ee>] __jump_label_update+0x82/0xd4
 [   0.000000] [<ffffffff801014bc>] jump_label_update+0x7c/0xca
 [   0.000000] [<ffffffff80101b5c>] static_key_enable_cpuslocked+0x70/0x9c
 [   0.000000] [<ffffffff80101b9e>] static_key_enable+0x16/0x24
 [   0.000000] [<ffffffff80730c16>] crng_set_ready+0x18/0x20
 [   0.000000] [<ffffffff80022f06>] execute_in_process_context+0x3e/0x92
 [   0.000000] [<ffffffff80730dc8>] _credit_init_bits+0x9c/0x140
 [   0.000000] [<ffffffff80827024>] add_bootloader_randomness+0x3e/0x48
 [   0.000000] [<ffffffff8082c434>] efi_config_parse_tables+0x114/0x21c
 [   0.000000] [<ffffffff8082dd18>] efi_init+0x11e/0x22a
 [   0.000000] [<ffffffff80803256>] setup_arch+0xc8/0x5fa
 [   0.000000] [<ffffffff80800716>] start_kernel+0x88/0x74e
 [   0.000000] ---[ end Kernel panic - not syncing: __sbi_rfence is called before sbi_init!!! ]---


Yes, I missed V6 of Jishang. Will update it. I will also use public
patchset linkgs.

Thanks!
Sunil
