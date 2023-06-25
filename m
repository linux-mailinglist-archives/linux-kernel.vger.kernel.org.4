Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDC0A73CF8F
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 10:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231830AbjFYI4V convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 25 Jun 2023 04:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231734AbjFYI4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 04:56:15 -0400
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64649E7B;
        Sun, 25 Jun 2023 01:56:09 -0700 (PDT)
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6300afaa43bso17788366d6.3;
        Sun, 25 Jun 2023 01:56:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687683368; x=1690275368;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1aLOG1SDXkQ1qzZvF4569LDgLL4VVaMYgtjO2JV4SiE=;
        b=MTTwTWawGf3iwhTsDIUO+KNTRNuS6DmS0yz0EtjnQqe9+Se2XhhGsoJGDmPqTLIoiU
         4C7Q07ftWfGxvb++8RYlYEietCH8KsbbQcF3DWrWNhs0YFQqifyBdQNgzdr3nnbT6/Ux
         QA8PcJ8wVG6pBAxt0RQh5p6SuTqixsDexk0ut14tOMksddwmERd4Xpb6p0O0x6KCnio/
         fCUCmTi+kjvTdR7P9z3xRWDw4Fjn5/rKNS1ygh1wzF3Dz8PNHyxxyDToXXKla25Gbi+R
         KLNvWkOOpx+tElROlXGZNi3AIl38Z5ztmBplWRoay7eqv0Mb7S8LU4Frc1O+S5F45yOg
         V+rw==
X-Gm-Message-State: AC+VfDyt8rvdmSEqZWgFQclwxa+l7sPNuejWEyXNfTEul9MH+NN8CU5x
        IeGwm91aW5EPwPftUMr6Z8wgZzj+gVykcQ==
X-Google-Smtp-Source: ACHHUZ4OW7RBWzmM6GJ4y0g71dKWkjXKLEo6D9koa4mtmiVEAj3TldrDY2jzPriGS1nNwCAbMltSeQ==
X-Received: by 2002:a05:6214:2302:b0:626:3375:6fea with SMTP id gc2-20020a056214230200b0062633756feamr30750905qvb.22.1687683368373;
        Sun, 25 Jun 2023 01:56:08 -0700 (PDT)
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com. [209.85.160.181])
        by smtp.gmail.com with ESMTPSA id j1-20020ad453a1000000b00631fc149a19sm1830498qvv.110.2023.06.25.01.56.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Jun 2023 01:56:07 -0700 (PDT)
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-40092be7bd5so10905111cf.3;
        Sun, 25 Jun 2023 01:56:07 -0700 (PDT)
X-Received: by 2002:a05:622a:1208:b0:400:8f95:8910 with SMTP id
 y8-20020a05622a120800b004008f958910mr6833378qtx.46.1687683367622; Sun, 25 Jun
 2023 01:56:07 -0700 (PDT)
MIME-Version: 1.0
References: <7b6ffa43307522833103fe29ec6a084b7d621a16.1687423204.git.geert+renesas@glider.be>
 <97bc4380-1a2a-aec7-168e-04536fc74e37@loongson.cn>
In-Reply-To: <97bc4380-1a2a-aec7-168e-04536fc74e37@loongson.cn>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sun, 25 Jun 2023 10:55:56 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX8=16pRQr=2CouUWBUhD16Mkh3_WaNZmRTd7Wjwq_pnw@mail.gmail.com>
Message-ID: <CAMuHMdX8=16pRQr=2CouUWBUhD16Mkh3_WaNZmRTd7Wjwq_pnw@mail.gmail.com>
Subject: Re: [28/39] drm: renesas: shmobile: Use drm_crtc_handle_vblank()
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

On Sat, Jun 24, 2023 at 11:33 AM Sui Jingfeng <suijingfeng@loongson.cn> wrote:
> I'm fine with this patch but I I don't see the benefit.
>
> This reply is more about my personal question.
>
> On 2023/6/22 17:21, Geert Uytterhoeven wrote:
> > Replace the call to the legacy drm_handle_vblank() function with a call
> > to the new drm_crtc_handle_vblank() helper.
> >
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> Reviewed-by: Sui Jingfeng <suijingfeng@loongson.cn>
> > ---
> >   drivers/gpu/drm/renesas/shmobile/shmob_drm_drv.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/renesas/shmobile/shmob_drm_drv.c b/drivers/gpu/drm/renesas/shmobile/shmob_drm_drv.c
> > index c98e2bdd888c3274..6eaf2c5a104f451a 100644
> > --- a/drivers/gpu/drm/renesas/shmobile/shmob_drm_drv.c
> > +++ b/drivers/gpu/drm/renesas/shmobile/shmob_drm_drv.c
> > @@ -86,7 +86,7 @@ static irqreturn_t shmob_drm_irq(int irq, void *arg)
> >       spin_unlock_irqrestore(&sdev->irq_lock, flags);
> >
> >       if (status & LDINTR_VES) {
> > -             drm_handle_vblank(dev, 0);
> > +             drm_crtc_handle_vblank(&sdev->crtc.base);
>
>
> After switching to drm_crtc_handle_vblank(),
>
> your driver need another deference to the pointer of 'struct drm_crtc'
> to get the pointer of 'struct drm_device';
>
> Plus another call to get the index(display pipe) of the CRTC by calling
> drm_crtc_index(crtc).

That is correct.

> Consider that shmob-drm support only one display pipe,
>
> is it that the switching is less straight forward than the original
> implement ?
>
>
> ```
>
> /**
>   * drm_crtc_handle_vblank - handle a vblank event
>   * @crtc: where this event occurred
>   *
>   * Drivers should call this routine in their vblank interrupt handlers to
>   * update the vblank counter and send any signals that may be pending.
>   *
>   * This is the native KMS version of drm_handle_vblank().
>   *
>   * Note that for a given vblank counter value drm_crtc_handle_vblank()
>   * and drm_crtc_vblank_count() or drm_crtc_vblank_count_and_time()
>   * provide a barrier: Any writes done before calling
>   * drm_crtc_handle_vblank() will be visible to callers of the later
>   * functions, if the vblank count is the same or a later one.
>   *
>   * See also &drm_vblank_crtc.count.
>   *
>   * Returns:
>   * True if the event was successfully handled, false on failure.
>   */
> bool drm_crtc_handle_vblank(struct drm_crtc *crtc)
> {
>      return drm_handle_vblank(crtc->dev, drm_crtc_index(crtc));
> }
>
> ```
>
> Is it that drm_crtc_handle_vblank() function is preferred over
> drm_handle_vblank() in the future?
>
> I'm fine with this question answered.

I think the native KMS version is preferred over the legacy version, cfr.

    /**
     * drm_handle_vblank - handle a vblank event
    [...]
     * This is the legacy version of drm_crtc_handle_vblank().
     */
    bool drm_handle_vblank(struct drm_device *dev, unsigned int pipe)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
