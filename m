Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3635D710638
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 09:24:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238999AbjEYHX4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 25 May 2023 03:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232087AbjEYHXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 03:23:53 -0400
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC766D3;
        Thu, 25 May 2023 00:23:49 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-ba8a0500f4aso182452276.3;
        Thu, 25 May 2023 00:23:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684999429; x=1687591429;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qwHaEVHj9rR3QnH3LqNeVcZHACKl1jAO9NgdI/o7VUY=;
        b=HTI0Np4oLo8WUbJxOIHCs7pGc5dZaTlz1SrD2wAt6v98gBwBcpt+rasA5IT0UmHfXX
         JqZ5USAhVWwL47gyaV6u1hd/HTrURU8tH7sIQgMITySEV/XO5rKE0fPbY7I32iybrr9Z
         qDLAR4NhqHI25lZ5Oqvov1uDJyXt7Bv0d2jvT11ZHK8swH4DwT3/mYgXOROsk0Vq15UH
         kUalDtzEJ2Kl4F+iSLkWyTZhGBRboPRyc4QD3kIVl8K15NrI4drEhV3c5j9RskgvR6Ie
         UtooJvh33Nd55mNg9bCqKkK6Q0Cbcq0/XwHAwXQocMwKDsmQgqSkFzBJBeFNv37eNvfb
         cGUQ==
X-Gm-Message-State: AC+VfDykid+nEgQAzYzRZ8dJhZ5+rAe42YiC1xvQqICn90xED23XRmyR
        nTYm/60ZV9Tz5MrIkOK/If3gyA6TDtrQmg==
X-Google-Smtp-Source: ACHHUZ54iX6ByHspeRy4y89lehIiKcfj174gK6lAM3bvSLC0jQ0x94WGI/binv6kXIZRlnKTo3eZbA==
X-Received: by 2002:a25:b08b:0:b0:ba8:1ef7:7175 with SMTP id f11-20020a25b08b000000b00ba81ef77175mr2559068ybj.54.1684999428682;
        Thu, 25 May 2023 00:23:48 -0700 (PDT)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com. [209.85.128.169])
        by smtp.gmail.com with ESMTPSA id b124-20020a256782000000b00ba1a0346360sm149766ybc.13.2023.05.25.00.23.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 May 2023 00:23:48 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-561e5014336so2004777b3.1;
        Thu, 25 May 2023 00:23:47 -0700 (PDT)
X-Received: by 2002:a81:a1ca:0:b0:561:d7d8:aa22 with SMTP id
 y193-20020a81a1ca000000b00561d7d8aa22mr21197961ywg.36.1684999427385; Thu, 25
 May 2023 00:23:47 -0700 (PDT)
MIME-Version: 1.0
References: <ZFAF6pJxMu1z6k4w@makrotopia.org>
In-Reply-To: <ZFAF6pJxMu1z6k4w@makrotopia.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 25 May 2023 09:23:35 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWnpu0TE465Ed=Z5iBw2w7pQwzd1ueDRuE5qXFJfztECQ@mail.gmail.com>
Message-ID: <CAMuHMdWnpu0TE465Ed=Z5iBw2w7pQwzd1ueDRuE5qXFJfztECQ@mail.gmail.com>
Subject: Re: [PATCH] spi: mt65xx: make sure operations completed before unloading
To:     Daniel Golle <daniel@makrotopia.org>
Cc:     linux-spi@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Leilk Liu <leilk.liu@mediatek.com>
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

Hi Daniel,

On Mon, May 1, 2023 at 8:37 PM Daniel Golle <daniel@makrotopia.org> wrote:
> When unloading the spi-mt65xx kernel module during an ongoing spi-mem
> operation the kernel will Oops shortly after unloading the module.
> This is because wait_for_completion_timeout was still running and
> returning into the no longer loaded module:
>
> Internal error: Oops: 0000000096000005 [#1] SMP
> Modules linked in: [many, but spi-mt65xx is no longer there]
> CPU: 0 PID: 2578 Comm: block Tainted: G        W  O       6.3.0-next-20230428+ #0
> Hardware name: Bananapi BPI-R3 (DT)
> pstate: 804000c5 (Nzcv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : __lock_acquire+0x18c/0x20e8
> lr : __lock_acquire+0x9b8/0x20e8
> sp : ffffffc009ec3400
> x29: ffffffc009ec3400 x28: 0000000000000001 x27: 0000000000000004
> x26: ffffff80082888c8 x25: 0000000000000000 x24: 0000000000000000
> x23: ffffffc009609da8 x22: ffffff8008288000 x21: ffffff8008288968
> x20: 00000000000003c2 x19: ffffff8008be7990 x18: 00000000000002af
> x17: 0000000000000000 x16: 0000000000000000 x15: ffffffc008d78970
> x14: 000000000000080d x13: 00000000000002af x12: 00000000ffffffea
> x11: 00000000ffffefff x10: ffffffc008dd0970 x9 : ffffffc008d78918
> x8 : 0000000000017fe8 x7 : 0000000000000001 x6 : 0000000000000000
> x5 : ffffff807fb53910 x4 : 0000000000000000 x3 : 0000000000000027
> x2 : 0000000000000027 x1 : 0000000000000000 x0 : 00000000000c03c2
> Call trace:
>  __lock_acquire+0x18c/0x20e8
>  lock_acquire+0x100/0x2a4
>  _raw_spin_lock_irq+0x58/0x74
>  __wait_for_common+0xe0/0x1b4
>  wait_for_completion_timeout+0x1c/0x24
>  0xffffffc000acc8a4 <--- used to be mtk_spi_transfer_wait
>  spi_mem_exec_op+0x390/0x3ec
>  spi_mem_no_dirmap_read+0x6c/0x88
>  spi_mem_dirmap_read+0xcc/0x12c
>  spinand_read_page+0xf8/0x1dc
>  spinand_mtd_read+0x1b4/0x2fc
>  mtd_read_oob_std+0x58/0x7c
>  mtd_read_oob+0x8c/0x148
>  mtd_read+0x50/0x6c
>  ...
>
> Prevent this by completing in mtk_spi_remove if needed.
>
> Fixes: 9f763fd20da7 ("spi: mediatek: add spi memory support for ipm design")
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>

Thanks for your patch, which is now commit 4be47a5d59cbc939 ("spi:
mt65xx: make sure operations completed before unloading") in spi/for-next.

> --- a/drivers/spi/spi-mt65xx.c
> +++ b/drivers/spi/spi-mt65xx.c
> @@ -1275,6 +1275,9 @@ static int mtk_spi_remove(struct platform_device *pdev)
>         struct mtk_spi *mdata = spi_master_get_devdata(master);
>         int ret;
>
> +       if (mdata->use_spimem && !completion_done(&mdata->spimem_done))
> +               complete(&mdata->spimem_done);

I'm afraid that is not sufficient, as the code that was waiting on the
completion accesses hardware registers and driver-private data after
that, and there is no guarantee all of that has completed by the time
mtk_spi_remove() finishes.

> +
>         ret = pm_runtime_resume_and_get(&pdev->dev);
>         if (ret < 0)
>                 return ret;

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
