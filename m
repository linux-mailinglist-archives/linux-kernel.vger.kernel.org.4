Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7260748228
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 12:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232142AbjGEK3u convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 5 Jul 2023 06:29:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjGEK3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 06:29:48 -0400
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CBB7E6E;
        Wed,  5 Jul 2023 03:29:47 -0700 (PDT)
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-bb3a77abd7bso7272788276.0;
        Wed, 05 Jul 2023 03:29:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688552986; x=1691144986;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N6aXvCfEidZYxvood9hpU+j2xHJrXwUMnh0Cp5slv0k=;
        b=I8uwIvJSwSMoutSjFITMzFHVqQdNA805ihgs3pbNAwK/s5ZZMyfvS30MLgGYE3AaNE
         h89lkT5SYV4/cRhIdhVXXWpED0fXlSjW5guQyB1gwXqg7RM4Yo3x2WJ9W1ZjdCf/A2wG
         EL0pTaleMQLFueKUP54HM/ohVVp530fLgw6ycIr5Op4aGuQZt6Hia6fZTD7TgTiP32/4
         JrSTyPiCtrrBcpRG1Blpe4unbI0t5SV/24y6QRLeKtGozpuU77vkoSFRwCEodwGVKNDu
         HUHqgyUFNbrJP6KbonNwt9RZRSdNVGW/mtqo/ZudSSmLRZdfIBCjy8q7tZBtg2dlLRKg
         Rjeg==
X-Gm-Message-State: ABy/qLb2lm69bJCd1rfWdJvOtEoVLSxHHkkAhAZgd2DU3QpwPd+2gaC+
        LrmQZl05JcGmUT1+R9XQQNfzi+/OqcWiPw==
X-Google-Smtp-Source: APBJJlFCOYclxiQe2GRr4VR65o7n3+ttWr/gflRtyDHLkC8sV1VGR00D63Jy5zZSSnF/YprTLYyVUg==
X-Received: by 2002:a25:2313:0:b0:c4d:14d2:c48c with SMTP id j19-20020a252313000000b00c4d14d2c48cmr8861117ybj.24.1688552986171;
        Wed, 05 Jul 2023 03:29:46 -0700 (PDT)
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com. [209.85.219.180])
        by smtp.gmail.com with ESMTPSA id e128-20020a255086000000b00c4ec3a3f695sm1754995ybb.46.2023.07.05.03.29.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jul 2023 03:29:45 -0700 (PDT)
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-bd61dd9a346so7247379276.2;
        Wed, 05 Jul 2023 03:29:45 -0700 (PDT)
X-Received: by 2002:a25:11c6:0:b0:c00:514c:55f with SMTP id
 189-20020a2511c6000000b00c00514c055fmr12165982ybr.47.1688552985708; Wed, 05
 Jul 2023 03:29:45 -0700 (PDT)
MIME-Version: 1.0
References: <2c28c0a137854d39b6bc997a21bd6d2db1f7a0a5.1687423204.git.geert+renesas@glider.be>
 <903c71fb-61af-e12a-ca56-a49d4e930f9f@loongson.cn>
In-Reply-To: <903c71fb-61af-e12a-ca56-a49d4e930f9f@loongson.cn>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 5 Jul 2023 12:29:34 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXoZiDupub2zEFjOwTJFswEsJq62zVa_K-g6TWg+zS7-g@mail.gmail.com>
Message-ID: <CAMuHMdXoZiDupub2zEFjOwTJFswEsJq62zVa_K-g6TWg+zS7-g@mail.gmail.com>
Subject: Re: [32/39] drm: renesas: shmobile: Shutdown the display on remove
To:     Sui Jingfeng <suijingfeng@loongson.cn>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Magnus Damm <magnus.damm@gmail.com>,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
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

On Tue, Jun 27, 2023 at 4:57 PM Sui Jingfeng <suijingfeng@loongson.cn> wrote:
> On 2023/6/22 17:21, Geert Uytterhoeven wrote:
> > When the device is unbound from the driver, the display may be active.
> > Make sure it gets shut down.
>
> would you mind to give a short description why this is necessary.

That's a good comment.
It turned out that this is not really necessary here, but to avoid a regression
with "[PATCH 34/39] drm: renesas: shmobile: Atomic conversion part 1", where
it is needed to call drm_atomic_helper_shutdown().
As the comments for drm_atomic_helper_shutdown() says it is the
atomic version of drm_helper_force_disable_all(), I figured I had to
introduce a call to the latter first, before doing the atomic conversion.

Does that make sense?

> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

> > --- a/drivers/gpu/drm/renesas/shmobile/shmob_drm_drv.c
> > +++ b/drivers/gpu/drm/renesas/shmobile/shmob_drm_drv.c
> > @@ -16,6 +16,7 @@
> >   #include <linux/pm_runtime.h>
> >   #include <linux/slab.h>
> >
> > +#include <drm/drm_crtc_helper.h>
> >   #include <drm/drm_drv.h>
> >   #include <drm/drm_fbdev_generic.h>
> >   #include <drm/drm_gem_dma_helper.h>
> > @@ -145,6 +146,7 @@ static int shmob_drm_remove(struct platform_device *pdev)
> >       struct drm_device *ddev = &sdev->ddev;
> >
> >       drm_dev_unregister(ddev);
> > +     drm_helper_force_disable_all(ddev);
>
> Is it that the DRM core recommend us to use
> drm_atomic_helper_disable_all() ?

Well, drm_atomic_helper_shutdown() is a convenience wrapper
around drm_atomic_helper_disable_all()... But we can't call any
atomic helpers yet, before the conversion to atomic modesetting.

>
> >       drm_kms_helper_poll_fini(ddev);
> >       return 0;
> >   }

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
