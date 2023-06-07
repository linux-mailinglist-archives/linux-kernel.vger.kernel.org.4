Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D939B725173
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 03:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240376AbjFGBSr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 21:18:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234417AbjFGBSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 21:18:36 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2C9BE6B
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 18:18:35 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-30ae9cb91a3so980145f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 18:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686100714; x=1688692714;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I1KgDHaOI1Us1uVdvmrUMFfMciSCryMc/a4pLaA9Lhg=;
        b=I2ghSAq3JDT4gj7Uf+IncMN0ipTmkzdn/4Yv5r4OjGYZKNar5OSApbCuLtKpwgaaog
         2ZoEIa9s8vQMupST9rS7w/tpwanQboypHhI87vF+mi84EHtmDaVK8vVxpg6PyUdfK5uI
         ab+7EDkMd8SddEeu0b4zwawV5ph6mNXZh3ymCoecgLkthdhkE4FX0dUgL9XhMbm04haN
         oG6rxssFsRg4TGy5yCrDqA0fJoI7bXbOXRAN6/E0Xtxyaw0oHLxz9qntXstDd2LGXRZB
         2clZB3Fj7s6uXhe3a+5qIkRzXMxjFiI8lOjRJz0Yd9PZymQpoVRRNyaNbmO57/FrpZCd
         GUuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686100714; x=1688692714;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I1KgDHaOI1Us1uVdvmrUMFfMciSCryMc/a4pLaA9Lhg=;
        b=DN/vWZFiWTU2na0pe+RQF0pxInrUYrke31uIHHnqarPrjJ6yr9brpFo6N1Z5jsR6sm
         sdyAMU2tfLCIko2Zfg+eSJTnWIGqfeT50ROXKYi6YG9+sAmBW7tRJ5qMc2wAcd8KcPZd
         MGKWk21aS04glRjWQxZZi+7QawMah2LyJNgjzq5wYfF4uBauBcnRD2HoneuhsMRslDbh
         XTEI3+U3lpD0zTINipEIHvPkHtTOfZ6DHbtiUGcAYwEe0w6F21fzptoWpbF0LoEWT2HC
         hQB9PB/KKENY+09Qh/2JvbFglpEJCNCu1AvBEOk84TAloxxz5fIZ8F5+pVF9h++Ugcve
         Z+MA==
X-Gm-Message-State: AC+VfDwszfmdpLUw7BOXgGTPb3BQqVh4ANJE/mHhFCAcMVyV5DHtP+QY
        ao3I9Pg/BCScfG5hZTjRiJ9+bBY2XxcGwy91YTwQKZZ5
X-Google-Smtp-Source: ACHHUZ7/cuO+TEChxTs+dXb7rNdJomNMj0QOWI0kWSVci+W1pvM3G3ccLLQvp1XZweD4REkWnWlEo8tN3KIEeW2PImU=
X-Received: by 2002:adf:eac5:0:b0:30c:2bd4:5141 with SMTP id
 o5-20020adfeac5000000b0030c2bd45141mr2614850wrn.4.1686100713726; Tue, 06 Jun
 2023 18:18:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230606143247.433018-1-nunes.erico@gmail.com>
In-Reply-To: <20230606143247.433018-1-nunes.erico@gmail.com>
From:   Vasily Khoruzhick <anarsoul@gmail.com>
Date:   Tue, 6 Jun 2023 18:18:06 -0700
Message-ID: <CA+E=qVcv4CrGki1cTYb53p5Ys0AgF=qfrK7XYB7X0gvu9knD-g@mail.gmail.com>
Subject: Re: [Lima] [PATCH] drm/lima: fix sched context destroy
To:     Erico Nunes <nunes.erico@gmail.com>
Cc:     yuq825@gmail.com, dri-devel@lists.freedesktop.org,
        lima@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        luben.tuikov@amd.com, daniel@ffwll.ch, airlied@gmail.com,
        christian.koenig@amd.com
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

On Tue, Jun 6, 2023 at 7:33=E2=80=AFAM Erico Nunes <nunes.erico@gmail.com> =
wrote:
>
> The drm sched entity must be flushed before finishing, to account for
> jobs potentially still in flight at that time.
> Lima did not do this flush until now, so switch the destroy call to the
> drm_sched_entity_destroy() wrapper which will take care of that.
>
> This fixes a regression on lima which started since the rework in
> commit 2fdb8a8f07c2 ("drm/scheduler: rework entity flush, kill and fini")
> where some specific types of applications may hang indefinitely.
>
> Fixes: 2fdb8a8f07c2 ("drm/scheduler: rework entity flush, kill and fini")
> Signed-off-by: Erico Nunes <nunes.erico@gmail.com>

Reviewed-by: Vasily Khoruzhick <anarsoul@gmail.com>

> ---
>  drivers/gpu/drm/lima/lima_sched.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/lima/lima_sched.c b/drivers/gpu/drm/lima/lim=
a_sched.c
> index ff003403fbbc..ffd91a5ee299 100644
> --- a/drivers/gpu/drm/lima/lima_sched.c
> +++ b/drivers/gpu/drm/lima/lima_sched.c
> @@ -165,7 +165,7 @@ int lima_sched_context_init(struct lima_sched_pipe *p=
ipe,
>  void lima_sched_context_fini(struct lima_sched_pipe *pipe,
>                              struct lima_sched_context *context)
>  {
> -       drm_sched_entity_fini(&context->base);
> +       drm_sched_entity_destroy(&context->base);
>  }
>
>  struct dma_fence *lima_sched_context_queue_task(struct lima_sched_task *=
task)
> --
> 2.40.1
>
