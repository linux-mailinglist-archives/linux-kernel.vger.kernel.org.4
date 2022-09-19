Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D60C5BD5E7
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 22:50:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbiISUus (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 16:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiISUuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 16:50:44 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFB152DEF
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 13:50:42 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a26so1520184ejc.4
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 13:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=Wra6TfVQpUcA1pTMwMXTsetIQg9lFEyERfQZe8FkrK0=;
        b=r/DkTdq1bOBe356n+JKLU6qwnz1CE8Y1qJGo13qtdMdpGJtPXnxSoaHPEfvgAQszhr
         Yf0sAjKu1YmGAIteN3kyaRWZg+wTfSV/gYouwKlrr9hVPo9wMuU9AvksiWLmlvPkbaWd
         q0IHpBXIZ4cMRVFAvK0sdGmXAv3ml0lQzhgjV8HVwUhXiq5Yj3z+w8iSgZEasuBd2Abl
         agI/LlWqW7R63KtzrBQz6jPrXsb372Cgh2OLgNoheK8IFt3tYY+MMc+WwQN9wnuDWjU8
         UmtzxmBcL1jx2sPvPqkTO7NhQxv9oX4hCbSEVen3F7nVFKTlP7dA3mgF6eYecrK9Wrme
         1x5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Wra6TfVQpUcA1pTMwMXTsetIQg9lFEyERfQZe8FkrK0=;
        b=L1VfgXdIc7Enl4zATj2qbo1j/sUEH2HU3iBBSpHal+/FWTSD4aY3s8n3Mos21udIKp
         PMA7T1bnIG775mWaOcC+DoDhjz43LcV8C0lrs/2EYYBQals2KIlwl0At8XsLEZw9rhYg
         K8GH4300urhPE2+4Y8ea5ZxkmNlneylo6vGQ8fEGe0lUA4rY3GuDEuoHj1v18NUMLTOt
         2E9oAk9dlKZmHMK6Hm9IDYecn1o07vnQjL406LpxHlNOAbKRC2ciOsKs8nGez2YxUC2j
         ziJnyBas/KGYooZt0TyVmFJT+nSxc9AE+2ex3Fwlj4u93zcxSjEZlR9fWhPzLhn0mQbw
         Qxmg==
X-Gm-Message-State: ACrzQf1Y2sbLo1Qawtr6hub7fZzIz0/ys+MvtWwuegq7J2LrTSsZgGze
        Vl/EMSu8rtWSrZBj0fvui8iQ6HbGfKsVmuoHq1bHEA==
X-Google-Smtp-Source: AMsMyM75ZnCoIzl1gPPUjiOaiEJ4qygmv/PILjLhJUHNliLl2ZbXfidHrwme3vNs7tqBCWYwd0kA/pFAkdB2h/dOPQA=
X-Received: by 2002:a17:907:2672:b0:780:8bb5:25a3 with SMTP id
 ci18-20020a170907267200b007808bb525a3mr13785851ejc.281.1663620641520; Mon, 19
 Sep 2022 13:50:41 -0700 (PDT)
MIME-Version: 1.0
References: <1663310366-720-1-git-send-email-shengjiu.wang@nxp.com>
In-Reply-To: <1663310366-720-1-git-send-email-shengjiu.wang@nxp.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Mon, 19 Sep 2022 14:50:30 -0600
Message-ID: <CANLsYkzj8fO0aqKM4iQVTP-=MP7+Ht0_2q41+DezDBW2=MHYfw@mail.gmail.com>
Subject: Re: [PATCH] rpmsg: char: Avoid double destroy of default endpoint
To:     Shengjiu Wang <shengjiu.wang@nxp.com>, arnaud.pouliquen@foss.st.com
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        shengjiu.wang@gmail.com, Bjorn Andersson <andersson@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Sept 2022 at 00:57, Shengjiu Wang <shengjiu.wang@nxp.com> wrote:
>
> The rpmsg_dev_remove() in rpmsg_core is the place for releasing
> this default endpoint.
>
> So need to avoid destroying the default endpoint in
> rpmsg_chrdev_eptdev_destroy(), this should be the same as
> rpmsg_eptdev_release(). Otherwise there will be double destroy
> issue that ept->refcount report warning:
>
> refcount_t: underflow; use-after-free.
>
> Call trace:
>  refcount_warn_saturate+0xf8/0x150
>  virtio_rpmsg_destroy_ept+0xd4/0xec
>  rpmsg_dev_remove+0x60/0x70
>
> Fixes: bea9b79c2d10 ("rpmsg: char: Add possibility to use default endpoint of the rpmsg device")
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  drivers/rpmsg/rpmsg_char.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/rpmsg/rpmsg_char.c b/drivers/rpmsg/rpmsg_char.c
> index 0850ae34fb88..562d545ac0d3 100644
> --- a/drivers/rpmsg/rpmsg_char.c
> +++ b/drivers/rpmsg/rpmsg_char.c
> @@ -76,7 +76,8 @@ int rpmsg_chrdev_eptdev_destroy(struct device *dev, void *data)
>
>         mutex_lock(&eptdev->ept_lock);
>         if (eptdev->ept) {
> -               rpmsg_destroy_ept(eptdev->ept);
> +               if (!eptdev->default_ept)
> +                       rpmsg_destroy_ept(eptdev->ept);
>                 eptdev->ept = NULL;

Arnaud - please look into this one.

Thanks,
Mathieu

>         }
>         mutex_unlock(&eptdev->ept_lock);
> --
> 2.34.1
>
