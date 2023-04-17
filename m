Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D560D6E4A04
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 15:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbjDQNfU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 17 Apr 2023 09:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbjDQNfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 09:35:05 -0400
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C99959759;
        Mon, 17 Apr 2023 06:34:36 -0700 (PDT)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-54fa9da5e5bso217178497b3.1;
        Mon, 17 Apr 2023 06:34:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681738466; x=1684330466;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vuYclpeiJRPrLHWKW+XqsKHh8mT/S+D96VMBdCK00iE=;
        b=eYUAk5zpJQNUqjQ93XRGfQPV/RW/xWR5sdYdk86HgqsVpQdUPFx2CcyWDEu3COWShy
         WkrAXKg3fhbRoMbwOHqgzafggcL8SQoShsog92kYWbu5RyxkLYeITaiN4SX/LtfUiLkL
         4cZdpdc12p9YiqGYWoaJyC8ZhojNWR2wu6xFyKNZiba1LP0qYULF49vBiUAuropv2gV1
         N1fze0GBLWvNx6/U4to1u7QOIhCJzr85SdabVzuwgCBn3Xv+o0Wl49+hlFxpnX61IJU4
         4fLC1ik/ovJ2U4lRvnFBPZqRuHEZIBxUe64/CtxOPddBZ5ShC5WOLnmTlkh4F5TEpNsP
         O5jA==
X-Gm-Message-State: AAQBX9cxQX0cC+rKfD9GMVJq+R+X1Km0nmA+3KDwJiFMrfrH/LOOC6b0
        43Ooq3izHCFWpb/0lxvF1b7YN4FLxIb97A==
X-Google-Smtp-Source: AKy350YIG+9hSgNMbyg75fyhg4hcLAuzxLU2vtTdd9ZCNA4jc+P4x/vpKaDny0QYzQxZVECi/Xo0xA==
X-Received: by 2002:a81:1611:0:b0:54f:8371:aa5b with SMTP id 17-20020a811611000000b0054f8371aa5bmr18011272yww.18.1681738465828;
        Mon, 17 Apr 2023 06:34:25 -0700 (PDT)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com. [209.85.128.173])
        by smtp.gmail.com with ESMTPSA id d139-20020a814f91000000b0054f8de7c6f1sm3100146ywb.70.2023.04.17.06.34.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Apr 2023 06:34:25 -0700 (PDT)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-54f21cdfadbso366308137b3.7;
        Mon, 17 Apr 2023 06:34:24 -0700 (PDT)
X-Received: by 2002:a81:b71c:0:b0:54f:b931:adf7 with SMTP id
 v28-20020a81b71c000000b0054fb931adf7mr9946168ywh.4.1681738464551; Mon, 17 Apr
 2023 06:34:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230417113219.1354078-1-suijingfeng@loongson.cn>
In-Reply-To: <20230417113219.1354078-1-suijingfeng@loongson.cn>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 17 Apr 2023 15:34:13 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV0pcPhpYJ8GtjeCSNkRgjGOTbtjWORKZEveB1WjhoVnA@mail.gmail.com>
Message-ID: <CAMuHMdV0pcPhpYJ8GtjeCSNkRgjGOTbtjWORKZEveB1WjhoVnA@mail.gmail.com>
Subject: Re: [PATCH v3] drm/fbdev-generic: prohibit potential out-of-bounds access
To:     Sui Jingfeng <suijingfeng@loongson.cn>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Li Yi <liyi@loongson.cn>,
        Helge Deller <deller@gmx.de>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, loongson-kernel@lists.loongnix.cn,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 17, 2023 at 1:45 PM Sui Jingfeng <suijingfeng@loongson.cn> wrote:
> The fbdev test of IGT may write after EOF, which lead to out-of-bound
> access for the drm drivers using fbdev-generic. For example, on a x86
> + aspeed bmc card platform, with a 1680x1050 resolution display, running
> fbdev test if IGT will cause the linux kernel hang with the following
> call trace:
>
>   Oops: 0000 [#1] PREEMPT SMP PTI
>   [IGT] fbdev: starting subtest eof
>   Workqueue: events drm_fb_helper_damage_work [drm_kms_helper]
>   [IGT] fbdev: starting subtest nullptr
>
>   RIP: 0010:memcpy_erms+0xa/0x20
>   RSP: 0018:ffffa17d40167d98 EFLAGS: 00010246
>   RAX: ffffa17d4eb7fa80 RBX: ffffa17d40e0aa80 RCX: 00000000000014c0
>   RDX: 0000000000001a40 RSI: ffffa17d40e0b000 RDI: ffffa17d4eb80000
>   RBP: ffffa17d40167e20 R08: 0000000000000000 R09: ffff89522ecff8c0
>   R10: ffffa17d4e4c5000 R11: 0000000000000000 R12: ffffa17d4eb7fa80
>   R13: 0000000000001a40 R14: 000000000000041a R15: ffffa17d40167e30
>   FS:  0000000000000000(0000) GS:ffff895257380000(0000) knlGS:0000000000000000
>   CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>   CR2: ffffa17d40e0b000 CR3: 00000001eaeca006 CR4: 00000000001706e0
>   Call Trace:
>    <TASK>
>    ? drm_fbdev_generic_helper_fb_dirty+0x207/0x330 [drm_kms_helper]
>    drm_fb_helper_damage_work+0x8f/0x170 [drm_kms_helper]
>    process_one_work+0x21f/0x430
>    worker_thread+0x4e/0x3c0
>    ? __pfx_worker_thread+0x10/0x10
>    kthread+0xf4/0x120
>    ? __pfx_kthread+0x10/0x10
>    ret_from_fork+0x2c/0x50
>    </TASK>
>   CR2: ffffa17d40e0b000
>   ---[ end trace 0000000000000000 ]---
>
> The direct reason is that damage rectange computed by
> drm_fb_helper_memory_range_to_clip() does not guaranteed to be in-bound.
> It is already results in workaround code populate to elsewhere. Another
> reason is that exposing a larger buffer size than the actual needed help
> to trigger this bug intrinsic in drm_fb_helper_memory_range_to_clip().
>
> Others fbdev emulation solutions write to the GEM buffer directly, they
> won't reproduce this bug because the .fb_dirty function callback do not
> being hooked, so no chance is given to drm_fb_helper_memory_range_to_clip()
> to generate a out-of-bound when drm_fb_helper_sys_write() is called.
>
> This patch break the trigger condition of this bug by shrinking the shadow
> buffer size to sizes->surface_height * buffer->fb->pitches[0].
>
> Fixes: '8fbc9af55de0 ("drm/fbdev-generic: Set screen size to size of GEM
> buffer")'
>
> Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>

Thanks, this fixes the crashes when running fbtest on shmob-drm.
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
