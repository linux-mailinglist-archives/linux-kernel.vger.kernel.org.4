Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9A776728D6
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 20:58:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbjART60 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 14:58:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjART6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 14:58:24 -0500
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94B4E53E7B;
        Wed, 18 Jan 2023 11:58:23 -0800 (PST)
Received: by mail-ej1-f49.google.com with SMTP id az20so52931ejc.1;
        Wed, 18 Jan 2023 11:58:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hA+fH1BKAR8DwjMQTDciJR2Bu4noelLBTmt8cjD5KaI=;
        b=xJOZOTVU8i+HWnAMzZLwxQ/REhvPSoYG2i+OlD97lmOijewiPr0eAGOvyv+dN5nh3h
         Hw/qL9FhkV//QdryXSpJHpiYCArMc5eMITzV/mpE+x331R4ZPLoA3u64I7M+NuEN3xG4
         AQeNqFv6i/1mCplXcma/60MnfhwEMw9XnQk8GgluR+or0F50MuixeCzdu59c3sopHPB7
         p5DDnzxVQrtToXaHqLGC0dNpRWAGb98oFsyG4K0WcMBDbAs78stwAtB6/QmhfxnM223S
         /M0hPLl7mveZPphWCh+OAb1/WORI7Ge5uWyFcEmAHeXnjjMJXNdOBw9+5Uli0Dla4gjr
         /tZQ==
X-Gm-Message-State: AFqh2kpjmfzFwQ6BvMAMChHzGD9LLyTDbSH+S6Ktor/v/lMXO4BE002S
        eCkvtPHK5ZlHtuU08eYq4tUjN8yikrbxxH6EaQ8=
X-Google-Smtp-Source: AMrXdXvvwrZIs7ntsyO+zj2+7gXuS5qiF9VA4U6VXle23mAtwuQoZb2YhlwIM7trf/SHSlflmUHgxxjHRXPDrTFs6K8=
X-Received: by 2002:a17:906:64a:b0:84d:3c6a:4c55 with SMTP id
 t10-20020a170906064a00b0084d3c6a4c55mr1058644ejb.509.1674071902195; Wed, 18
 Jan 2023 11:58:22 -0800 (PST)
MIME-Version: 1.0
References: <cover.1674030722.git.viresh.kumar@linaro.org> <d6e5d4fcca5f66d290e907d10c45cb2e7bbb09e5.1674030722.git.viresh.kumar@linaro.org>
In-Reply-To: <d6e5d4fcca5f66d290e907d10c45cb2e7bbb09e5.1674030722.git.viresh.kumar@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 18 Jan 2023 20:58:10 +0100
Message-ID: <CAJZ5v0j5Rfw7pj05WsNka0BCNOszxsvPuMfNH8Kh88J+QZFHfA@mail.gmail.com>
Subject: Re: [PATCH V4 1/3] thermal: core: call put_device() only after
 device_register() fails
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2023 at 9:38 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> put_device() shouldn't be called before a prior call to
> device_register(). __thermal_cooling_device_register() doesn't follow
> that properly and needs fixing. Also
> thermal_cooling_device_destroy_sysfs() is getting called unnecessarily
> on few error paths.
>
> Fix all this by placing the calls at the right place.
>
> Based on initial work done by Caleb Connolly.
>
> Fixes: 4748f9687caa ("thermal: core: fix some possible name leaks in error paths")
> Fixes: c408b3d1d9bb ("thermal: Validate new state in cur_state_store()")
> Reported-by: Caleb Connolly <caleb.connolly@linaro.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

OK, so I think that this patch is needed for 6.2 and the other two may
be queued up for later (they do depend on this one, though, of
course).  Is my understanding correct?

> ---
> For v6.2-rc.
>
> V3->V4:
> - The first three versions were sent by Caleb.
> - The new version fixes the current bugs, without looking to optimize the
>   code any further, which is done separately in the next two patches.
>
>  drivers/thermal/thermal_core.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index f17ab2316dbd..77bd47d976a2 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -909,15 +909,20 @@ __thermal_cooling_device_register(struct device_node *np,
>         cdev->devdata = devdata;
>
>         ret = cdev->ops->get_max_state(cdev, &cdev->max_state);
> -       if (ret)
> -               goto out_kfree_type;
> +       if (ret) {
> +               kfree(cdev->type);
> +               goto out_ida_remove;
> +       }
>
>         thermal_cooling_device_setup_sysfs(cdev);
> +
>         ret = dev_set_name(&cdev->device, "cooling_device%d", cdev->id);
>         if (ret) {
> +               kfree(cdev->type);
>                 thermal_cooling_device_destroy_sysfs(cdev);
> -               goto out_kfree_type;
> +               goto out_ida_remove;
>         }
> +
>         ret = device_register(&cdev->device);
>         if (ret)
>                 goto out_kfree_type;
> @@ -943,6 +948,8 @@ __thermal_cooling_device_register(struct device_node *np,
>         thermal_cooling_device_destroy_sysfs(cdev);
>         kfree(cdev->type);
>         put_device(&cdev->device);
> +
> +       /* thermal_release() takes care of the rest */
>         cdev = NULL;
>  out_ida_remove:
>         ida_free(&thermal_cdev_ida, id);
> --
> 2.31.1.272.g89b43f80a514
>
