Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D76E062999A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 14:06:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238066AbiKONGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 08:06:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233044AbiKONG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 08:06:29 -0500
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C868220DD;
        Tue, 15 Nov 2022 05:06:28 -0800 (PST)
Received: by mail-qt1-f177.google.com with SMTP id cg5so8609818qtb.12;
        Tue, 15 Nov 2022 05:06:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2p4VX10cau1GaYNBPaUZVp5KNbW01FTiVitlbxHo/SA=;
        b=3k2FqsBNu12vXZlXu4ZkyRNl9C/AGIuU/G9JFDQUdX0FVSU5JkYus+eISDdS8ayWDe
         /wYqCcOlWHe6iUMtf+c62/dflu8CqbuXiiRPX3G4VKGQtc5oTERmuaDFiyO3CZOVxqUs
         69Z5jtrHVXFvW+kydaOG6Ln1TWJ/caDfYL3uWkqUnlx4GIt3BwxD4FmAgQYxS7G0J2Zc
         icCbS55AqgGIl2q0M6cqD2A+FVwPoOvnMjtgnkvXebF6HysH0klbOvkUIqDALT4HT091
         b4Lk+cNzbQStmqkeZkKc6Z8x2SwiOjYIM9TRHdOf0tEFMRlItPL5wkjsZvGN7P0RYRRj
         Dj9g==
X-Gm-Message-State: ANoB5plpQwz1rCncmT6gkzuT6ULKwoUPAHAIpl5uupf0l0jEcJEz8ei9
        K/KNEBcjUXfeQxLBqUGEv+8Z2zY7i1bmqQ==
X-Google-Smtp-Source: AA0mqf70UdsJGB/taq8iaXBRe4IIp8CfLMuNYqwyXCcdRKNLn62wozM8+0CMCf/PoKjn709T/cNqcw==
X-Received: by 2002:ac8:72c7:0:b0:39c:d681:643 with SMTP id o7-20020ac872c7000000b0039cd6810643mr16409975qtp.583.1668517587071;
        Tue, 15 Nov 2022 05:06:27 -0800 (PST)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com. [209.85.128.181])
        by smtp.gmail.com with ESMTPSA id r21-20020a05620a299500b006e702033b15sm8420800qkp.66.2022.11.15.05.06.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Nov 2022 05:06:26 -0800 (PST)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-37063f855e5so136368167b3.3;
        Tue, 15 Nov 2022 05:06:26 -0800 (PST)
X-Received: by 2002:a0d:f6c6:0:b0:373:5c0c:9b37 with SMTP id
 g189-20020a0df6c6000000b003735c0c9b37mr17299691ywf.358.1668517585823; Tue, 15
 Nov 2022 05:06:25 -0800 (PST)
MIME-Version: 1.0
References: <20221026185954.991547-1-pierre.gondois@arm.com>
In-Reply-To: <20221026185954.991547-1-pierre.gondois@arm.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 15 Nov 2022 14:06:14 +0100
X-Gmail-Original-Message-ID: <CAMuHMdV_rQcKVn73ywh_KcJS2uZ0xTdzGAYcTiQov4UzRouRvQ@mail.gmail.com>
Message-ID: <CAMuHMdV_rQcKVn73ywh_KcJS2uZ0xTdzGAYcTiQov4UzRouRvQ@mail.gmail.com>
Subject: Re: [PATCH] cacheinfo: Decrement refcount in cache_setup_of_node()
To:     Pierre Gondois <pierre.gondois@arm.com>
Cc:     linux-kernel@vger.kernel.org, Rob.Herring@arm.com,
        sudeep.holla@arm.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pierre,

On Wed, Oct 26, 2022 at 9:03 PM Pierre Gondois <pierre.gondois@arm.com> wrote:
> Refcounts to DT nodes are only incremented in the function
> and never decremented. Decrease the refcounts when necessary.
>
> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>

Thanks for your patch, which is now commit 3da72e18371c41a6
("cacheinfo: Decrement refcount in cache_setup_of_node()") in
driver-core-next.

I have bisected a refcount underflow during s2ram to this commit:

    PM: suspend entry (deep)
    Filesystems sync: 0.003 seconds
    Freezing user space processes ... (elapsed 0.009 seconds) done.
    OOM killer disabled.
    Freezing remaining freezable tasks ... (elapsed 0.004 seconds) done.
    sd 0:0:0:0: [sda] Synchronizing SCSI cache
    sd 0:0:0:0: [sda] Stopping disk
    Disabling non-boot CPUs ...
    psci: CPU1 killed (polled 0 ms)
    ------------[ cut here ]------------
    refcount_t: addition on 0; use-after-free.
    WARNING: CPU: 2 PID: 22 at lib/refcount.c:25
refcount_warn_saturate+0x98/0x140
    CPU: 2 PID: 22 Comm: cpuhp/2 Not tainted
6.1.0-rc1-arm64-renesas-00026-g3da72e18371c #1870
    Hardware name: Renesas Salvator-X 2nd version board based on r8a77951 (DT)
    pstate: 600000c5 (nZCv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
    pc : refcount_warn_saturate+0x98/0x140
    lr : refcount_warn_saturate+0x98/0x140
    sp : ffff80000a3b3710
    x29: ffff80000a3b3710 x28: ffff0a00ffffff05 x27: ffff80000a3b3aa2
    x26: ffff8000091c5fe0 x25: ffff800008f2ade8 x24: ffff0006ff7c1bf0
    x23: ffff80000a3b3a88 x22: 0000000000000000 x21: ffff80000a3b3aa7
    x20: ffff0000ffffff00 x19: ffff0006ff7c1c58 x18: 0000000000000010
    x17: 0000000000000004 x16: 0000000000000000 x15: ffff0004c028ca00
    x14: 00000000000001e6 x13: ffff0004c028ca00 x12: 00000000ffffffea
    x11: 00000000ffffefff x10: 00000000ffffefff x9 : ffff8000095cc850
    x8 : 0000000000017fe8 x7 : c0000000ffffefff x6 : 000000000000bff4
    x5 : ffff0006ff704b60 x4 : 0000000000000000 x3 : 0000000000000027
    x2 : 0000000000000023 x1 : 0000000000000000 x0 : 0000000000000000
    Call trace:
     refcount_warn_saturate+0x98/0x140
     kobject_get+0x94/0x98
     of_node_get+0x1c/0x30
     of_fwnode_get+0x30/0x50
     fwnode_handle_get+0x2c/0x48
     fwnode_get_nth_parent+0x70/0x80
     fwnode_full_name_string+0x44/0xb8
     device_node_string+0x318/0x3f0
     pointer+0x248/0x350
     vsnprintf+0x1fc/0x720
     vprintk_store+0x104/0x4c8
     vprintk_emit+0x104/0x340
     vprintk_default+0x34/0x40
     vprintk+0xc4/0xe8
     _printk+0x5c/0x80
     of_node_release+0xc0/0xe0
     kobject_put+0xa4/0xf0
     of_node_put+0x14/0x20
     free_cache_attributes.part.0+0x138/0x190
     cacheinfo_cpu_pre_down+0x70/0x88
     cpuhp_invoke_callback+0x1d8/0xbc0
     cpuhp_thread_fun+0x1b0/0x218
     smpboot_thread_fn+0x1b4/0x270
     kthread+0x10c/0x118
     ret_from_fork+0x10/0x20
    irq event stamp: 438
    hardirqs last  enabled at (437): [<ffff80000827c668>]
put_cpu_partial+0x1e8/0x258
    hardirqs last disabled at (438): [<ffff8000080ff52c>]
vprintk_store+0x394/0x4c8
    softirqs last  enabled at (0): [<ffff8000080820dc>]
copy_process+0x6bc/0x1888
    softirqs last disabled at (0): [<0000000000000000>] 0x0
    ---[ end trace 0000000000000000 ]---
    ------------[ cut here ]------------
    refcount_t: underflow; use-after-free.
    WARNING: CPU: 2 PID: 22 at lib/refcount.c:28
refcount_warn_saturate+0xec/0x140
    CPU: 2 PID: 22 Comm: cpuhp/2 Tainted: G        W
6.1.0-rc1-arm64-renesas-00026-g3da72e18371c #1870
    Hardware name: Renesas Salvator-X 2nd version board based on r8a77951 (DT)
    pstate: 600000c5 (nZCv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
    pc : refcount_warn_saturate+0xec/0x140
    lr : refcount_warn_saturate+0xec/0x140
    sp : ffff80000a3b3720
    x29: ffff80000a3b3720 x28: ffff0a00ffffff05 x27: ffff80000a3b3aa2
    x26: ffff8000091c5fe0 x25: ffff800008f2ade8 x24: ffff0006ff7c1bf0
    x23: ffff80000a3b3a88 x22: 00000000ffffffff x21: ffff80000a3b3aba
    x20: ffff0000ffffff00 x19: ffff0006ff7c1c58 x18: 0000000000000010
    x17: 0000000000000004 x16: 0000000000000000 x15: ffff0004c028ca00
    x14: 0000000000000219 x13: ffff0004c028ca00 x12: 00000000ffffffea
    x11: 00000000ffffefff x10: 00000000ffffefff x9 : ffff8000095cc850
    x8 : 0000000000017fe8 x7 : c0000000ffffefff x6 : 000000000000bff4
    x5 : ffff0006ff704b60 x4 : 0000000000000000 x3 : 0000000000000027
    x2 : 0000000000000023 x1 : 0000000000000000 x0 : 0000000000000000
    Call trace:
     refcount_warn_saturate+0xec/0x140
     kobject_put+0xe4/0xf0
     of_node_put+0x14/0x20
     of_fwnode_put+0x30/0x40
     fwnode_handle_put.part.0+0x1c/0x28
     fwnode_handle_put+0x18/0x28
     fwnode_full_name_string+0x94/0xb8
     device_node_string+0x318/0x3f0
     pointer+0x248/0x350
     vsnprintf+0x1fc/0x720
     vprintk_store+0x104/0x4c8
     vprintk_emit+0x104/0x340
     vprintk_default+0x34/0x40
     vprintk+0xc4/0xe8
     _printk+0x5c/0x80
     of_node_release+0xc0/0xe0
     kobject_put+0xa4/0xf0
     of_node_put+0x14/0x20
     free_cache_attributes.part.0+0x138/0x190
     cacheinfo_cpu_pre_down+0x70/0x88
     cpuhp_invoke_callback+0x1d8/0xbc0
     cpuhp_thread_fun+0x1b0/0x218
     smpboot_thread_fn+0x1b4/0x270
     kthread+0x10c/0x118
     ret_from_fork+0x10/0x20
    irq event stamp: 438
    hardirqs last  enabled at (437): [<ffff80000827c668>]
put_cpu_partial+0x1e8/0x258
    hardirqs last disabled at (438): [<ffff8000080ff52c>]
vprintk_store+0x394/0x4c8
    softirqs last  enabled at (0): [<ffff8000080820dc>]
copy_process+0x6bc/0x1888
    softirqs last disabled at (0): [<0000000000000000>] 0x0
    ---[ end trace 0000000000000000 ]---
    OF: ERROR: Bad of_node_put() on /cpus/cache-controller-0
    ------------[ cut here ]------------
    refcount_t: saturated; leaking memory.
    WARNING: CPU: 2 PID: 22 at lib/refcount.c:22
refcount_warn_saturate+0x6c/0x140
    CPU: 2 PID: 22 Comm: cpuhp/2 Tainted: G        W
6.1.0-rc1-arm64-renesas-00026-g3da72e18371c #1870
    Hardware name: Renesas Salvator-X 2nd version board based on r8a77951 (DT)
    pstate: 600000c5 (nZCv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
    pc : refcount_warn_saturate+0x6c/0x140
    lr : refcount_warn_saturate+0x6c/0x140
    sp : ffff80000a3b3670
    x29: ffff80000a3b3670 x28: ffff0a00ffffff05 x27: ffff80000a1f8bfa
    x26: ffff8000091c5fe0 x25: ffff800008f2ade8 x24: ffff0006ff7c1bf0
    x23: ffff80000a1f8c14 x22: 0000000000000000 x21: ffff80000a1f8bff
    x20: ffff0000ffffff00 x19: ffff0006ff7c1c58 x18: 0000000000000010
    x17: 0000000000000004 x16: 0000000000000000 x15: ffff0004c028ca00
    x14: 000000000000024a x13: ffff0004c028ca00 x12: 00000000ffffffea
    x11: 00000000ffffefff x10: 00000000ffffefff x9 : ffff8000095cc850
    x8 : 0000000000017fe8 x7 : c0000000ffffefff x6 : 000000000000bff4
    x5 : ffff0006ff704b60 x4 : 0000000000000000 x3 : 0000000000000027
    x2 : 0000000000000023 x1 : 0000000000000000 x0 : 0000000000000000
    Call trace:
     refcount_warn_saturate+0x6c/0x140
     kobject_get+0x7c/0x98
     of_node_get+0x1c/0x30
     of_fwnode_get+0x30/0x50
     fwnode_handle_get+0x2c/0x48
     fwnode_get_nth_parent+0x70/0x80
     fwnode_full_name_string+0x44/0xb8
     device_node_string+0x318/0x3f0
     pointer+0x248/0x350
     vsnprintf+0x1fc/0x720
     vscnprintf+0x30/0x50
     printk_sprint+0x3c/0x1a8
     vprintk_store+0x414/0x4c8
     vprintk_emit+0x104/0x340
     vprintk_default+0x34/0x40
     vprintk+0xc4/0xe8
     _printk+0x5c/0x80
     of_node_release+0xc0/0xe0
     kobject_put+0xa4/0xf0
     of_node_put+0x14/0x20
     free_cache_attributes.part.0+0x138/0x190
     cacheinfo_cpu_pre_down+0x70/0x88
     cpuhp_invoke_callback+0x1d8/0xbc0
     cpuhp_thread_fun+0x1b0/0x218
     smpboot_thread_fn+0x1b4/0x270
     kthread+0x10c/0x118
     ret_from_fork+0x10/0x20
    irq event stamp: 438
    hardirqs last  enabled at (437): [<ffff80000827c668>]
put_cpu_partial+0x1e8/0x258
    hardirqs last disabled at (438): [<ffff8000080ff52c>]
vprintk_store+0x394/0x4c8
    softirqs last  enabled at (0): [<ffff8000080820dc>]
copy_process+0x6bc/0x1888
    softirqs last disabled at (0): [<0000000000000000>] 0x0
    ---[ end trace 0000000000000000 ]---
    CPU: 2 PID: 22 Comm: cpuhp/2 Tainted: G        W
6.1.0-rc1-arm64-renesas-00026-g3da72e18371c #1870
    Hardware name: Renesas Salvator-X 2nd version board based on r8a77951 (DT)
    Call trace:
     dump_backtrace+0xcc/0xd8
     show_stack+0x14/0x38
     dump_stack_lvl+0x88/0xb0
     dump_stack+0x14/0x2c
     of_node_release+0xc4/0xe0
     kobject_put+0xa4/0xf0
     of_node_put+0x14/0x20
     free_cache_attributes.part.0+0x138/0x190
     cacheinfo_cpu_pre_down+0x70/0x88
     cpuhp_invoke_callback+0x1d8/0xbc0
     cpuhp_thread_fun+0x1b0/0x218
     smpboot_thread_fn+0x1b4/0x270
     kthread+0x10c/0x118
     ret_from_fork+0x10/0x20
    psci: CPU2 killed (polled 0 ms)
    psci: CPU3 killed (polled 0 ms)
    psci: CPU4 killed (polled 4 ms)
    OF: ERROR: Bad of_node_put() on /cpus/cache-controller-1
    CPU: 5 PID: 37 Comm: cpuhp/5 Tainted: G        W
6.1.0-rc1-arm64-renesas-00026-g3da72e18371c #1870
    Hardware name: Renesas Salvator-X 2nd version board based on r8a77951 (DT)
    Call trace:
     dump_backtrace+0xcc/0xd8
     show_stack+0x14/0x38
     dump_stack_lvl+0x88/0xb0
     dump_stack+0x14/0x2c
     of_node_release+0xc4/0xe0
     kobject_put+0xa4/0xf0
     of_node_put+0x14/0x20
     free_cache_attributes.part.0+0x138/0x190
     cacheinfo_cpu_pre_down+0x70/0x88
     cpuhp_invoke_callback+0x1d8/0xbc0
     cpuhp_thread_fun+0x1b0/0x218
     smpboot_thread_fn+0x1b4/0x270
     kthread+0x10c/0x118
     ret_from_fork+0x10/0x20
    psci: CPU5 killed (polled 0 ms)
    psci: CPU6 killed (polled 0 ms)
    psci: CPU7 killed (polled 0 ms)

Reverting this commit fixes the issue.

> --- a/drivers/base/cacheinfo.c
> +++ b/drivers/base/cacheinfo.c
> @@ -196,7 +196,7 @@ static void cache_of_set_props(struct cacheinfo *this_leaf,
>
>  static int cache_setup_of_node(unsigned int cpu)
>  {
> -       struct device_node *np;
> +       struct device_node *np, *prev;
>         struct cacheinfo *this_leaf;
>         unsigned int index = 0;
>
> @@ -206,19 +206,24 @@ static int cache_setup_of_node(unsigned int cpu)
>                 return -ENOENT;
>         }
>
> +       prev = np;
> +
>         while (index < cache_leaves(cpu)) {
>                 this_leaf = per_cpu_cacheinfo_idx(cpu, index);
> -               if (this_leaf->level != 1)
> +               if (this_leaf->level != 1) {
>                         np = of_find_next_cache_node(np);
> -               else
> -                       np = of_node_get(np);/* cpu node itself */
> -               if (!np)
> -                       break;
> +                       of_node_put(prev);
> +                       prev = np;
> +                       if (!np)
> +                               break;
> +               }
>                 cache_of_set_props(this_leaf, np);
>                 this_leaf->fw_token = np;
>                 index++;
>         }
>
> +       of_node_put(np);
> +
>         if (index != cache_leaves(cpu)) /* not all OF nodes populated */
>                 return -ENOENT;
>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
