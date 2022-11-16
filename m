Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 670F162B47B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 09:04:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232966AbiKPIEA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 03:04:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233027AbiKPIDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 03:03:55 -0500
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC1786448;
        Wed, 16 Nov 2022 00:03:54 -0800 (PST)
Received: by mail-qv1-f44.google.com with SMTP id j6so11406980qvn.12;
        Wed, 16 Nov 2022 00:03:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lPiNEEPz3fwn9yX9FoJryScC2rMVAcwvbsIVAG/NCvQ=;
        b=gJVKjN0JzIr2MRIUJu8zToHL6B332ddDzALsYB5D0I01nD2I1LuV9Oh7JSQmucg3dc
         eaZH6IEB7+UMGnShlmY0jjAhn5DBNc0RjQCiaTSD6X7GJwIML0eDNHCkU1rmuwCkXF2f
         feB5IKQ8CLzN2iOxeQKg6gUzBDmhOnMqHiH9gPDfMRJFuk1wziYpQVS7CoLx956Err18
         jtKh24o233HocgoEF9u0R+4tU+HDiIgdq8vlS39JW/ZysMZ9jsYoOcpmi8KHu/wq/11b
         h/fDdnLoAFpLwsC+u1AXICbRWmvM9MgUiffQCglVB2VfVHvfc9xgbdCY1bys/Cy3dlpt
         0B8w==
X-Gm-Message-State: ANoB5pndJY00D2eEDBz/s4Qt8OUlYHWZpsFY9gdb/jHSL2VqXWi2EQLb
        u8b3zoGMSg24pAa8XPcdVDiNdtXhDAky2g==
X-Google-Smtp-Source: AA0mqf5uouyK/PLj6C7AaZa1ct6llF4GQ5ATD4Bto13Jum5dL4sot51q/Ct2noOzhYv7gmaf/6jZfg==
X-Received: by 2002:ad4:4f11:0:b0:4bb:7436:49de with SMTP id fb17-20020ad44f11000000b004bb743649demr19542930qvb.27.1668585833808;
        Wed, 16 Nov 2022 00:03:53 -0800 (PST)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com. [209.85.128.172])
        by smtp.gmail.com with ESMTPSA id v14-20020a05620a440e00b006fba0a389a4sm2224852qkp.88.2022.11.16.00.03.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Nov 2022 00:03:53 -0800 (PST)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-3691e040abaso160075747b3.9;
        Wed, 16 Nov 2022 00:03:52 -0800 (PST)
X-Received: by 2002:a0d:dd81:0:b0:373:6180:dae5 with SMTP id
 g123-20020a0ddd81000000b003736180dae5mr20337776ywe.283.1668585832484; Wed, 16
 Nov 2022 00:03:52 -0800 (PST)
MIME-Version: 1.0
References: <20221115220520.2076189-1-pierre.gondois@arm.com>
In-Reply-To: <20221115220520.2076189-1-pierre.gondois@arm.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 16 Nov 2022 09:03:41 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWB_PZAL7dgWfYVVBQL2tkb92bg_tuvxeGrWFbGQD9fNw@mail.gmail.com>
Message-ID: <CAMuHMdWB_PZAL7dgWfYVVBQL2tkb92bg_tuvxeGrWFbGQD9fNw@mail.gmail.com>
Subject: Re: [PATCH -next] cacheinfo: Remove of_node_put() for fw_token
To:     Pierre Gondois <pierre.gondois@arm.com>
Cc:     linux-kernel@vger.kernel.org, Rob.Herring@arm.com,
        sudeep.holla@arm.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15, 2022 at 11:06 PM Pierre Gondois <pierre.gondois@arm.com> wrote:
> fw_token is used for DT/ACPI systems to identify CPUs sharing caches.
> For DT based systems, fw_token is set to a pointer to a DT node.
>
> commit ("cacheinfo: Decrement refcount in cache_setup_of_node()")
> doesn't increment the refcount of fw_token anymore in
> cache_setup_of_node(). fw_token is indeed used as a token and not
> as a (struct device_node*), so no reference to fw_token should be
> kept.
>
> However, [1] is triggered when hotplugging a CPU multiple times
> since cache_shared_cpu_map_remove() decrements the refcount to
> fw_token at each CPU unplugging, eventually reaching 0.
>
> Remove of_node_put() for fw_token in cache_shared_cpu_map_remove().
>
> [1]
> [   53.651182] ------------[ cut here ]------------
> [   53.651186] refcount_t: saturated; leaking memory.
> [   53.651223] WARNING: CPU: 4 PID: 32 at lib/refcount.c:22 refcount_warn_saturate (lib/refcount.c:22 (discriminator 3))
> [   53.651241] Modules linked in:
> [   53.651249] CPU: 4 PID: 32 Comm: cpuhp/4 Tainted: G        W          6.1.0-rc1-14091-g9fdf2ca7b9c8 #76
> [   53.651261] Hardware name: ARM LTD ARM Juno Development Platform/ARM Juno Development Platform, BIOS EDK II Oct 31 2022
> [   53.651268] pstate: 600000c5 (nZCv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [   53.651279] pc : refcount_warn_saturate (lib/refcount.c:22 (discriminator 3))
> [   53.651293] lr : refcount_warn_saturate (lib/refcount.c:22 (discriminator 3))
> [...]
> [   53.651513] Call trace:
> [...]
> [   53.651735] of_node_release (drivers/of/dynamic.c:335)
> [   53.651750] kobject_put (lib/kobject.c:677 lib/kobject.c:704 ./include/linux/kref.h:65 lib/kobject.c:721)
> [   53.651762] of_node_put (drivers/of/dynamic.c:49)
> [   53.651776] free_cache_attributes.part.0 (drivers/base/cacheinfo.c:712)
> [   53.651792] cacheinfo_cpu_pre_down (drivers/base/cacheinfo.c:718)
> [   53.651807] cpuhp_invoke_callback (kernel/cpu.c:247 (discriminator 4))
> [   53.651819] cpuhp_thread_fun (kernel/cpu.c:785)
> [   53.651832] smpboot_thread_fn (kernel/smpboot.c:164 (discriminator 3))
> [   53.651847] kthread (kernel/kthread.c:376)
> [   53.651858] ret_from_fork (arch/arm64/kernel/entry.S:861)
> [   53.651869] ---[ end trace 0000000000000000 ]---
>
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>

Thanks, this fixes the issue for me!

Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
