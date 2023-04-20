Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2FE46E8D95
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 11:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233935AbjDTJJB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 20 Apr 2023 05:09:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234568AbjDTJIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 05:08:15 -0400
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 469636A4C;
        Thu, 20 Apr 2023 02:04:25 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id b10so1670076ybk.9;
        Thu, 20 Apr 2023 02:04:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681981464; x=1684573464;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wKtBzMUV9hqGJdb9Z5c6Q0amkNjCy+P79xURFwU+I0A=;
        b=RDIhJ/XZ8jYakOfYxBVL0fRe/azaxvvFeI/Zq5Y+RknY5ec5Zz20wge+ltJZxSsbXd
         kEX/qhet4ZBDij9RCwYhEw/T0TSzxmgH/40J67UTzRFs9DxL5N+ScgSJg2hdBxhFnmI+
         CtakY1+orxMuvb/wzxu5uEjAY74B+w284FdMgp4whPiD1wcu3IykHCs8Xl6WX8dHvExk
         nLu9ZrKjCHMyR027WMpHFz72QurUaVcqj/+fs4g5//WRC/NykJmNIuZ6szJ9Vd20NkTI
         cZyFFoA6MJ9ogHSbNFq6ncalLUEDsoA+7QEnyUmJJAwm0DMV594Qfoal5Hx+MgbJ3TBK
         M9+Q==
X-Gm-Message-State: AAQBX9dRiN9AWmRtMog0AfTy3rv5nUvfAme3ZSMawEjlylLTz3Yo3qMs
        JSMrX4nD5k7/GMu8MxdGFr3w8OeQ5so+ng==
X-Google-Smtp-Source: AKy350ZIh34cpgU2rQKHhKLhOpegiG2PH2phwkEs1rVUqRpWQEd4a6gG96YJhPDumiiy4AYnoQstig==
X-Received: by 2002:a25:aa4d:0:b0:b8e:c965:2111 with SMTP id s71-20020a25aa4d000000b00b8ec9652111mr716408ybi.55.1681981464166;
        Thu, 20 Apr 2023 02:04:24 -0700 (PDT)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com. [209.85.128.182])
        by smtp.gmail.com with ESMTPSA id 206-20020a2505d7000000b00b7767ca746fsm212128ybf.12.2023.04.20.02.04.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Apr 2023 02:04:23 -0700 (PDT)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-54fbb713301so31017237b3.11;
        Thu, 20 Apr 2023 02:04:23 -0700 (PDT)
X-Received: by 2002:a81:a1d5:0:b0:54f:c1c1:199a with SMTP id
 y204-20020a81a1d5000000b0054fc1c1199amr290622ywg.18.1681981461935; Thu, 20
 Apr 2023 02:04:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230420030500.1578756-1-suijingfeng@loongson.cn>
In-Reply-To: <20230420030500.1578756-1-suijingfeng@loongson.cn>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 20 Apr 2023 11:04:10 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUZoBZEM73fo8-PitSae8wgv-m6sez3nA8J3RFMAtOyOQ@mail.gmail.com>
Message-ID: <CAMuHMdUZoBZEM73fo8-PitSae8wgv-m6sez3nA8J3RFMAtOyOQ@mail.gmail.com>
Subject: Re: [PATCH v5] drm/fbdev-generic: prohibit potential out-of-bounds access
To:     Sui Jingfeng <suijingfeng@loongson.cn>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Li Yi <liyi@loongson.cn>,
        Helge Deller <deller@gmx.de>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, loongson-kernel@lists.loongnix.cn
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

Hi Sui,

On Thu, Apr 20, 2023 at 5:09 AM Sui Jingfeng <suijingfeng@loongson.cn> wrote:
> The fbdev test of IGT may write after EOF, which lead to out-of-bound
> access for drm drivers hire fbdev-generic. For example, run fbdev test
> on a x86+ast2400 platform, with 1680x1050 resolution, will cause the
> linux kernel hang with the following call trace:
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
> The is because damage rectangles computed by
> drm_fb_helper_memory_range_to_clip() function does not guaranteed to be
> bound in the screen's active display area. Possible reasons are:
>
> 1) Buffers are allocated in the granularity of page size, for mmap system
>    call support. The shadow screen buffer consumed by fbdev emulation may
>    also choosed be page size aligned.
>
> 2) The DIV_ROUND_UP() used in drm_fb_helper_memory_range_to_clip()
>    will introduce off-by-one error.
>
> For example, on a 16KB page size system, in order to store a 1920x1080
> XRGB framebuffer, we need allocate 507 pages. Unfortunately, the size
> 1920*1080*4 can not be divided exactly by 16KB.
>
>  1920 * 1080 * 4 = 8294400 bytes
>  506 * 16 * 1024 = 8290304 bytes
>  507 * 16 * 1024 = 8306688 bytes
>
>  line_length = 1920*4 = 7680 bytes
>
>  507 * 16 * 1024 / 7680 = 1081.6
>
>  off / line_length = 507 * 16 * 1024 / 7680 = 1081
>  DIV_ROUND_UP(507 * 16 * 1024, 7680) will yeild 1082
>
> memcpy_toio() typically issue the copy line by line, when copy the last
> line, out-of-bound access will be happen. Because:
>
>  1082 * line_length = 1082 * 7680 = 8309760, and 8309760 > 8306688
>
> Note that userspace may stil write to the invisiable area if a larger
> buffer than width x stride is exposed. But it is not a big issue as
> long as there still have memory resolve the access if not drafting so
> far.
>
>  - Also limit the y1 (Daniel)
>  - keep fix patch it to minimal (Daniel)
>  - screen_size is page size aligned because of it need mmap (Thomas)
>  - Adding fixes tag (Thomas)
>
> Fixes: aa15c677cc34 ("drm/fb-helper: Fix vertical damage clipping")
>
> Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
> Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks for the update!  This v5 is completely different from the v3
I tested before, so keeping my Tested-by is not really appropriate...

I have retested fbtest with shmob-drm on Armadillo-800-EVA
(800x480@RG16, i.e. 187.5 pages), and fortunately this version still
works fine, so
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
