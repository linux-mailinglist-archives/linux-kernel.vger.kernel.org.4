Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89998621923
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 17:11:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233578AbiKHQLd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 11:11:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234640AbiKHQLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 11:11:30 -0500
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5782D4C263
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 08:11:28 -0800 (PST)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-13bef14ea06so16760550fac.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 08:11:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IzZJtTel0h21j07X7KO7D0aS4ynI+dBJLPzqyI12t0g=;
        b=kGYypjiYLM1zxDrHFV/0AuzBeOBcAS6yYCv3LYXSDmK0rUoqT2G2X+gvdS/XNhWFS6
         qRSWLMfxifHeM4pOlul6jkx3TEzhkNEFXVCgiFOzRlB29hCMOH+lQ/7TadWLh6sVIzOs
         ZMdLqHttRFnsJwGyR0N/EBAyEgQHtXWVmfDQDwEyBZcLvEzh+RVjOxlFMwKFOXJQKdq8
         nGJIIsGZVmlwGOaxXRYoSTQvJiR2BPGVYi+4SXw+qT1VkckG4H+NAXyRVpYu0LFuYZvI
         pYQFdYgy+tWH7N9adacl1cYYRN6W2ai6z/+lm6yxzoZ+PDdwDJ4Vn1Uq5mY7E8SanEp/
         GFbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IzZJtTel0h21j07X7KO7D0aS4ynI+dBJLPzqyI12t0g=;
        b=vb0GRXi2zuNKJa75PlCuxvzOa9zYWWGq17W/4XU44cgii+qzmvCrO/XUtLfDdSglJ6
         GylmevHcVPwgDcpNLIhJKO/yV6Kg77cbs1JN4WEp/JpROuQFC/vT8Xwhett8QJRqSioz
         c+wulLrWwi5NYnhgh6FEdfOEFaf2DvZ4kavDaWCyEInDPwEK1LROCdfDrt7JPEoQyPB4
         i20t4KdBjxHTJ3rFIB6YdX3Ol6ZI8Zf6quPzIB9Gw2o7cFru5f3mus5wxSKRUNIox2s5
         bwQf15tIbx8/4MfaTJ2KFMWIpGDzKd1PDfBaOh2ylEE6uGjXQnnu0/Ke1V7vxtBgZ/bQ
         UWAQ==
X-Gm-Message-State: ACrzQf2571lzzM59hwyP3JVqCx9pgRta+oAUDGK3hv2Mz7c2yQtO9opb
        urlUlitLK9NEVdS63NrR82Vj3m4n+1MlEfZ7Uic=
X-Google-Smtp-Source: AMsMyM5DYDrwKM88iEhZjq3W6qb4l9uo9kBAzUbmI6TcsLNvxj2thi71mu7FeCuohu/QXUQnRIhJinTr3KQkudY84dY=
X-Received: by 2002:a05:6870:a7a4:b0:136:7c39:979e with SMTP id
 x36-20020a056870a7a400b001367c39979emr33954773oao.96.1667923887729; Tue, 08
 Nov 2022 08:11:27 -0800 (PST)
MIME-Version: 1.0
References: <20221028224813.1466450-1-briannorris@chromium.org>
In-Reply-To: <20221028224813.1466450-1-briannorris@chromium.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 8 Nov 2022 11:11:12 -0500
Message-ID: <CADnq5_O92ourfZJyEKjYh4k01fMw1MWiYQLkEQNYsx2sTXa7nQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amdgpu: Move racy global PMU list into device
To:     Brian Norris <briannorris@chromium.org>,
        "Kim, Jonathan" <Jonathan.Kim@amd.com>,
        "Kuehling, Felix" <Felix.Kuehling@amd.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Xinhui <Xinhui.Pan@amd.com>, amd-gfx@lists.freedesktop.org,
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

On Fri, Oct 28, 2022 at 6:48 PM Brian Norris <briannorris@chromium.org> wrote:
>
> If there are multiple amdgpu devices, this list processing can be racy.
>
> We're really treating this like a per-device list, so make that explicit
> and remove the global list.
>
> Signed-off-by: Brian Norris <briannorris@chromium.org>

@Kuehling, Felix @Kim, Jonathan can you take a look at this patch?

Thanks,

Alex


> ---
>
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  4 ++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c | 12 +++++-------
>  2 files changed, 9 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 0e6ddf05c23c..e968b7f2417c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1063,6 +1063,10 @@ struct amdgpu_device {
>         struct work_struct              reset_work;
>
>         bool                            job_hang;
> +
> +#if IS_ENABLED(CONFIG_PERF_EVENTS)
> +       struct list_head pmu_list;
> +#endif
>  };
>
>  static inline struct amdgpu_device *drm_to_adev(struct drm_device *ddev)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
> index 71ee361d0972..24f2055a2f23 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
> @@ -23,6 +23,7 @@
>
>  #include <linux/perf_event.h>
>  #include <linux/init.h>
> +#include <linux/list.h>
>  #include "amdgpu.h"
>  #include "amdgpu_pmu.h"
>
> @@ -72,9 +73,6 @@ static ssize_t amdgpu_pmu_event_show(struct device *dev,
>                         amdgpu_pmu_attr->event_str, amdgpu_pmu_attr->type);
>  }
>
> -static LIST_HEAD(amdgpu_pmu_list);
> -
> -
>  struct amdgpu_pmu_attr {
>         const char *name;
>         const char *config;
> @@ -558,7 +556,7 @@ static int init_pmu_entry_by_type_and_add(struct amdgpu_pmu_entry *pmu_entry,
>                 pr_info("Detected AMDGPU %d Perf Events.\n", total_num_events);
>
>
> -       list_add_tail(&pmu_entry->entry, &amdgpu_pmu_list);
> +       list_add_tail(&pmu_entry->entry, &pmu_entry->adev->pmu_list);
>
>         return 0;
>  err_register:
> @@ -579,9 +577,7 @@ void amdgpu_pmu_fini(struct amdgpu_device *adev)
>  {
>         struct amdgpu_pmu_entry *pe, *temp;
>
> -       list_for_each_entry_safe(pe, temp, &amdgpu_pmu_list, entry) {
> -               if (pe->adev != adev)
> -                       continue;
> +       list_for_each_entry_safe(pe, temp, &adev->pmu_list, entry) {
>                 list_del(&pe->entry);
>                 perf_pmu_unregister(&pe->pmu);
>                 kfree(pe->pmu.attr_groups);
> @@ -623,6 +619,8 @@ int amdgpu_pmu_init(struct amdgpu_device *adev)
>         int ret = 0;
>         struct amdgpu_pmu_entry *pmu_entry, *pmu_entry_df;
>
> +       INIT_LIST_HEAD(&adev->pmu_list);
> +
>         switch (adev->asic_type) {
>         case CHIP_VEGA20:
>                 pmu_entry_df = create_pmu_entry(adev, AMDGPU_PMU_PERF_TYPE_DF,
> --
> 2.38.1.273.g43a17bfeac-goog
>
