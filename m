Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4686670296F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 11:45:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240681AbjEOJpq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 15 May 2023 05:45:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240933AbjEOJoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 05:44:55 -0400
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E453610C3
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 02:42:57 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-55a2691637bso181713237b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 02:42:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684143777; x=1686735777;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hU3ilFv1v41SW4iLmjhAxafFaVCLvufvLWY2ivP9Jek=;
        b=EdgHOk/Z3tzZJ5moL17KfB48kHFLNJWGFk5+P/I1dPIJ+p8Nj7l8vT3wpheaRuiZc+
         nqDsiAM8hnY2dhQyaYR/yveixR73qf0fqQEOyr3r3iYF99fCO5mOM7D5fhdhv+PFvYSs
         hh9NGZAnTRWga3h0s7xZcqU7dqdXbXA2+Hw0KHhOrIeejAIIamIyoRJGy9oaiNVNxzPt
         0uW9ppAMFXdhKIYaLwr/C6wzPvRGUMBxOECZhmAZvf2D+z7rfWbn7ZT5H9EfShMoAgDA
         QJO5mBp/WCra2RR8412o+Hj7nW1Q6etAwyu9mOL8Ihw35ml5RMr2xmhdoqpMShButHs5
         yaMQ==
X-Gm-Message-State: AC+VfDxKTyI6T2tvFoLse4nroy6EPkwLvFqJp644bEXe44XQV25eQ2+w
        JsSV+BElMh0k5mDXs9pZoNtivAb0tLCxcw==
X-Google-Smtp-Source: ACHHUZ60CDVWVGIfS6WrHxT0jHpoMlhqjHWCNiwg9CNp/v49M4G6vYg7TFopoX+08LfICMfQsxQFpw==
X-Received: by 2002:a0d:d6cc:0:b0:55a:535c:5c53 with SMTP id y195-20020a0dd6cc000000b0055a535c5c53mr33419434ywd.8.1684143776731;
        Mon, 15 May 2023 02:42:56 -0700 (PDT)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com. [209.85.128.180])
        by smtp.gmail.com with ESMTPSA id o138-20020a0dcc90000000b0054fb931adefsm7648301ywd.4.2023.05.15.02.42.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 May 2023 02:42:56 -0700 (PDT)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-55d2e87048cso181503627b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 02:42:56 -0700 (PDT)
X-Received: by 2002:a81:a106:0:b0:55a:2cdb:55c9 with SMTP id
 y6-20020a81a106000000b0055a2cdb55c9mr29319131ywg.3.1684143775752; Mon, 15 May
 2023 02:42:55 -0700 (PDT)
MIME-Version: 1.0
References: <dd1b560bbe426b351cdbb3bbf89414753c3d0117.1679446472.git.fthain@linux-m68k.org>
In-Reply-To: <dd1b560bbe426b351cdbb3bbf89414753c3d0117.1679446472.git.fthain@linux-m68k.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 15 May 2023 11:42:44 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU9rGxnGCZhDMb2D35M45DL1mVFkVg5Xt+0BcAKYsVi=w@mail.gmail.com>
Message-ID: <CAMuHMdU9rGxnGCZhDMb2D35M45DL1mVFkVg5Xt+0BcAKYsVi=w@mail.gmail.com>
Subject: Re: [PATCH] nubus: Remove proc entries before adding them
To:     Finn Thain <fthain@linux-m68k.org>
Cc:     linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 22, 2023 at 1:52 AM Finn Thain <fthain@linux-m68k.org> wrote:
> The config ROMs on some Nubus cards contain mistakes such as resource
> duplication. This results in a warning from proc_register():
>
> [    1.660000] NuBus: Scanning NuBus slots.
> [    1.740000] ------------[ cut here ]------------
> [    1.750000] WARNING: CPU: 0 PID: 1 at fs/proc/generic.c:376 proc_register+0xbc/0xda
> [    1.770000] proc_dir_entry '24/5' already registered
> [    1.790000] Modules linked in:
> [    1.800000] CPU: 0 PID: 1 Comm: swapper Not tainted 6.1.0-5-m68k #1  Debian 6.1.12-1
> [    1.800000] Stack from 00829d18:
> [    1.800000]         00829d18 00451507 00451507 00000000 00000009 0038c57c 00451507 00386bae
> [    1.800000]         00442945 0045f062 00000178 00868580 00868f50 00386c42 0045f062 00000178
> [    1.800000]         00166fc8 00000009 00000000 00829d78 008685e4 0037f9ec 00000025 00248808
> [    1.800000]         0045f0df 00829d94 00166fc8 0045f062 00000178 00000009 0045f0df 008689e4
> [    1.800000]         008685e4 fafe3a20 00868980 00829df3 00829e32 00000024 00829dc0 00167332
> [    1.800000]         00868980 00868580 00829e40 00248d36 00829df3 00008124 00868980 00248b0c
> [    1.800000] Call Trace: [<0038c57c>] dump_stack+0xc/0x10
> [    1.800000]  [<00386bae>] __warn+0x70/0xbc
> [    1.800000]  [<00386c42>] warn_slowpath_fmt+0x48/0x66
> [    1.800000]  [<00166fc8>] proc_register+0xbc/0xda
> [    1.800000]  [<0037f9ec>] memcmp+0x0/0x56
> [    1.800000]  [<00248808>] nubus_get_rsrc_str+0x0/0x5e
> [    1.800000]  [<00166fc8>] proc_register+0xbc/0xda
> [    1.800000]  [<00167332>] proc_create_single_data+0x40/0x48
> [    1.800000]  [<00248d36>] nubus_proc_add_rsrc_mem+0x68/0xa4
> [    1.800000]  [<00008124>] amiga_mksound+0xb8/0xc8
> [    1.800000]  [<00248b0c>] nubus_proc_rsrc_show+0x0/0xa4
> [    1.800000]  [<00386180>] memset+0x0/0x94
> [    1.800000]  [<0024864a>] nubus_readdir+0x0/0x66
> [    1.800000]  [<00560f35>] nubus_get_vendorinfo.isra.0+0x87/0x10e
> [    1.800000]  [<00560fb4>] nubus_get_vendorinfo.isra.0+0x106/0x10e
> [    1.800000]  [<00248d72>] nubus_proc_add_rsrc+0x0/0x8e
> [    1.800000]  [<001f6f50>] __dynamic_pr_debug+0x0/0x96
> [    1.800000]  [<0038741e>] _printk+0x0/0x18
> [    1.800000]  [<0016fafe>] kernfs_link_sibling+0x9a/0xaa
> [    1.800000]  [<00561cb0>] nubus_init+0x660/0x79c
> [    1.800000]  [<0037f7c6>] strcpy+0x0/0x1c
> [    1.800000]  [<0003f58c>] parse_args+0x0/0x308
> [    1.800000]  [<00002104>] do_one_initcall+0x0/0x184
> [    1.800000]  [<00561650>] nubus_init+0x0/0x79c
> [    1.800000]  [<00010000>] frc1_dst+0xe/0x14
> [    1.800000]  [<00002172>] do_one_initcall+0x6e/0x184
> [    1.800000]  [<0037f7c6>] strcpy+0x0/0x1c
> [    1.800000]  [<0003f58c>] parse_args+0x0/0x308
> [    1.800000]  [<00002104>] do_one_initcall+0x0/0x184
> [    1.800000]  [<0054b25c>] kernel_init_freeable+0x192/0x19c
> [    1.800000]  [<00561650>] nubus_init+0x0/0x79c
> [    1.800000]  [<0038c6c4>] kernel_init+0x0/0xec
> [    1.800000]  [<0038c6d8>] kernel_init+0x14/0xec
> [    1.800000]  [<0038c6c4>] kernel_init+0x0/0xec
> [    1.800000]  [<0000297c>] ret_from_kernel_thread+0xc/0x14
> [    1.800000]
> [    1.810000] ---[ end trace 0000000000000000 ]---
>
> This particular card (a Radius video card) contains a duplicated resource
> hence the /proc/bus/nubus/a/1/24/5 entry got registered twice.
> (A date resource has ID 5, the vendor info directory has ID 24)
>
> The solution for this is to remove a potentially pre-existing entry before
> adding the procfs entry for the resource.
>
> Reported-and-tested-by: Stan Johnson <userm57@yahoo.com>
> Signed-off-by: Finn Thain <fthain@linux-m68k.org>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
i.e. will queue in the m68k for-v6.5 branch.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
