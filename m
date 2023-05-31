Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A15CC7175C5
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 06:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234088AbjEaEjf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 00:39:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbjEaEjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 00:39:33 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B474197;
        Tue, 30 May 2023 21:39:32 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-256918803baso457678a91.1;
        Tue, 30 May 2023 21:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685507972; x=1688099972;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KVic8ZozVX5AlLBxJqcr+ixPM2ET/77wx3a5l9yrvTA=;
        b=YdkgddUdmRbj6JnRhb0cOb/hkVpjC4ma1FBFF7MmudnlBD7T6ZzdyBwlBbmmKS7mAE
         fPOTVp0kyePChrSuNNq4RexORKiiWGKe6BNknVFN4gmM0Vaz2IN8v1B2xwtRDUFpYR2E
         W5Jos/s/M4bIEJnxNy/Awl8gVHim40jo/ndGy49Jr3VuvK3lRYFAn4tiQkxFqLYC6tSU
         FJGTiSExcjsmUbbNTNtjpF/totbZJkwi8xRFycX7IzRQ/6loY2yAgSJXEFaW7z/6tEI4
         7prr879NFKF5qzYCgXQkb1fGDkK2vJhkXUYT5UiWASWnNbv/Cp/H36Mh82zRPSX9NOwT
         6xpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685507972; x=1688099972;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KVic8ZozVX5AlLBxJqcr+ixPM2ET/77wx3a5l9yrvTA=;
        b=c4DV15tqM3H2JVG4YkKfTNTw1pU+y7lqnEwRdsp2hyMwyYojScEfx7Y+FhOPCLELPg
         BdFGXJo0V2TEaCakLFGfIjKgwAWCRJBuqAsoJGgOXFEQnlRcG78Vh+a23AuY195wJjiL
         npyyyjOz7xq+7BI/hO23tKOP5oHe2HCOfKVFUyMRQR7xA5hoXxCP14/zJePlW6J7hLr7
         iVBuFRgQvSuVa9AK7VtQNnPviiJ2ZvFQr2ZKV4Njum5miGSvu6OyPMwrzsY0YpRxjcsf
         TOxOwufoqjmdd4waOJT4JwuvP3P+1xjPiZlt3xE4ZkMQ25Xp9vdWsgy7eVQPnBNP0Vdj
         wA4w==
X-Gm-Message-State: AC+VfDyHzhCaoiNRARmFSiyea1w7L0DeaIW0Pai1bPd37hvOH03Ca/kj
        vasDPA0L/g+79vGWry8gd7JzmGoCmynM9iWJoXI=
X-Google-Smtp-Source: ACHHUZ7TQ+bwgry6OeU5ofjgd1i5pr0uySNoEw1Qia05YkABxpVcHW04AhtbBXo36TYZBu0rojShIeGrV14pmdoWRiQ=
X-Received: by 2002:a17:90b:4b83:b0:256:9095:a368 with SMTP id
 lr3-20020a17090b4b8300b002569095a368mr993241pjb.4.1685507972065; Tue, 30 May
 2023 21:39:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230526130131.16521-1-lm0963hack@gmail.com> <20230530222150.24oogloda6wtvpvm@intel.intel>
In-Reply-To: <20230530222150.24oogloda6wtvpvm@intel.intel>
From:   lm0963 <lm0963hack@gmail.com>
Date:   Wed, 31 May 2023 12:39:20 +0800
Message-ID: <CAAgLYK7FNrAYFRp7C3LDtqevFENQLw8YYAFR2Pk9wdfQ5RKVeg@mail.gmail.com>
Subject: Re: [PATCH] drm/exynos: fix race condition UAF in exynos_g2d_exec_ioctl
To:     Andi Shyti <andi.shyti@kernel.org>
Cc:     inki.dae@samsung.com, sw0312.kim@samsung.com,
        kyungmin.park@samsung.com, airlied@gmail.com, daniel@ffwll.ch,
        krzysztof.kozlowski@linaro.org, alim.akhtar@samsung.com,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andi,

On Wed, May 31, 2023 at 6:21=E2=80=AFAM Andi Shyti <andi.shyti@kernel.org> =
wrote:
>
> Hi Min,
>
> On Fri, May 26, 2023 at 09:01:31PM +0800, Min Li wrote:
> > If it is async, runqueue_node is freed in g2d_runqueue_worker on anothe=
r
> > worker thread. So in extreme cases, if g2d_runqueue_worker runs first, =
and
> > then executes the following if statement, there will be use-after-free.
> >
> > Signed-off-by: Min Li <lm0963hack@gmail.com>
> > ---
> >  drivers/gpu/drm/exynos/exynos_drm_g2d.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/exynos/exynos_drm_g2d.c b/drivers/gpu/drm/=
exynos/exynos_drm_g2d.c
> > index ec784e58da5c..414e585ec7dd 100644
> > --- a/drivers/gpu/drm/exynos/exynos_drm_g2d.c
> > +++ b/drivers/gpu/drm/exynos/exynos_drm_g2d.c
> > @@ -1335,7 +1335,7 @@ int exynos_g2d_exec_ioctl(struct drm_device *drm_=
dev, void *data,
> >       /* Let the runqueue know that there is work to do. */
> >       queue_work(g2d->g2d_workq, &g2d->runqueue_work);
> >
> > -     if (runqueue_node->async)
> > +     if (req->async)
>
> did you actually hit this? If you did, then the fix is not OK.

No, I didn't actually hit this. I found it through code review. This
is only a theoretical issue that can only be triggered in extreme
cases.

>
> Andi
>
> >               goto out;
> >
> >       wait_for_completion(&runqueue_node->complete);
> > --
> > 2.34.1
> >



--=20
Min Li
