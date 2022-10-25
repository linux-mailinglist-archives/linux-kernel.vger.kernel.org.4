Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 477E760CD9B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 15:36:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232898AbiJYNgD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 09:36:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232038AbiJYNgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 09:36:00 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED1F518A038
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 06:35:59 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id g10so14141986oif.10
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 06:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=J70jijssEagDP3Vhwq363Yf98xAsG6U4OeAwP38Jv4o=;
        b=GRM2bHAxIoDmgZAsAtSuq7CsCgHocptOR32YNFgMcPiMhssB2d1u14v86pZeQelbru
         p/o1WBr86IWnAzd2FGcVDB0ko8vewc6pzhNpL1PHDo4aM1qihFpIoolnmL5n8Lu3JYS9
         BuG5896I96BPIuCfJB7F8mn2iQOGEWgQYrknk+hKMM5fCFhx/f0IN2UfPWtD40qTCqVb
         FuGpuE6cuCYHckn2cW82YgU12vZRnUmY1V6bc5/fmUgBmsT5YTKacmnUhmk0Q1u1oboz
         H4anNk9inuu9P2iDap/jFU8scVl8qnBr48kKMye/QOqoFAzRBaAwsY1BuW4HGQ4Itom0
         +jdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J70jijssEagDP3Vhwq363Yf98xAsG6U4OeAwP38Jv4o=;
        b=jh6kax+0uIpbxYs76wpW/ZuZVNBdk8ALZls5Cl6819KKx29owzmTFDnZ5jOMdUw+km
         f3kbX23JrBf17AWNhBgpdYoMBcQm3yBjaKeDsvFX1rirgMXvYPGUGfUe+4U+e/ahavXF
         J6d2SuoEmbKhJ1w7kgFv5oN+zfmXF8Rmo94iwbl0ZJEF4DboR//AfMgXn7EXBZkIOXE2
         fqGqFlkq7AyXGxzMD1SCBIL7+XzDekrciO7URO+fL0UVPfXVM/SOse9XzEGnBDwA53mw
         t97w/ctRfQYJCeKUrx+6Vq/knvGRnK5OyXcRc3oVsXJ5ksJGFukpV6ySATE/8uDsyqDK
         qscQ==
X-Gm-Message-State: ACrzQf2Bl5sR0t9TH9GfAFXoqC3U+AGUQpwdaN0gs1vF5WP5a0sdb3dV
        0VVLSy4zp+nz3L3Ej0MjK+BZ1BTjuYV1gq6vmQjbB9Zi
X-Google-Smtp-Source: AMsMyM6Ga/lqz4/aonDFqi5BhAicY7+pmSj/4v47bJ54+lZaseAtPF6bP0fGOXyplhBA/+wKPSmFsSNxBrq0Jvd3lgI=
X-Received: by 2002:a05:6808:14d2:b0:354:c733:abd3 with SMTP id
 f18-20020a05680814d200b00354c733abd3mr19023263oiw.96.1666704959289; Tue, 25
 Oct 2022 06:35:59 -0700 (PDT)
MIME-Version: 1.0
References: <20221025061846.447975-1-brolerliew@gmail.com>
In-Reply-To: <20221025061846.447975-1-brolerliew@gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 25 Oct 2022 09:35:48 -0400
Message-ID: <CADnq5_NweAo-7snRLkidNkOizu7Ft+7GgXCS2Rnv1oxmRFb_RQ@mail.gmail.com>
Subject: Re: [PATCH] drm/scheduler: set current_entity to next when remove
 from rq
To:     brolerliew <brolerliew@gmail.com>,
        "Tuikov, Luben" <Luben.Tuikov@amd.com>
Cc:     Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Luben

On Tue, Oct 25, 2022 at 2:55 AM brolerliew <brolerliew@gmail.com> wrote:
>
> When entity move from one rq to another, current_entity will be set to NULL
> if it is the moving entity. This make entities close to rq head got
> selected more frequently, especially when doing load balance between
> multiple drm_gpu_scheduler.
>
> Make current_entity to next when removing from rq.
>
> Signed-off-by: brolerliew <brolerliew@gmail.com>
> ---
>  drivers/gpu/drm/scheduler/sched_main.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
> index 2fab218d7082..00b22cc50f08 100644
> --- a/drivers/gpu/drm/scheduler/sched_main.c
> +++ b/drivers/gpu/drm/scheduler/sched_main.c
> @@ -168,10 +168,11 @@ void drm_sched_rq_remove_entity(struct drm_sched_rq *rq,
>         spin_lock(&rq->lock);
>
>         atomic_dec(rq->sched->score);
> -       list_del_init(&entity->list);
>
>         if (rq->current_entity == entity)
> -               rq->current_entity = NULL;
> +               rq->current_entity = list_next_entry(entity, list);
> +
> +       list_del_init(&entity->list);
>
>         if (drm_sched_policy == DRM_SCHED_POLICY_FIFO)
>                 drm_sched_rq_remove_fifo_locked(entity);
> --
> 2.34.1
>
