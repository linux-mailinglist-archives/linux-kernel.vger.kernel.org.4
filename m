Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81530677A14
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 12:24:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231859AbjAWLYE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 06:24:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231492AbjAWLYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 06:24:00 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 094E02107
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 03:23:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674472991;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=P4b4VDNUOrCuuYzHrxL50l8orvsgc64zf6MDB9/G7nI=;
        b=gXha7neNnPg8RFXLLMTcmc/FtrG/qaCzXnrIMsSZmqb2n4+wE4vnCR/Be2kPGWDGaPkwUY
        eoVR4jr1tIILKJgxDPZ7M9ki7DPMZvDh5FZcx6GUtYepFq75bXs2C2Ea9oWpoYlL0CTCor
        bgK5vKSuaejv++jsdsB6szXge6V2ZQ0=
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-280-wMWdHPBGOdSdXOj_FviSkw-1; Mon, 23 Jan 2023 06:23:10 -0500
X-MC-Unique: wMWdHPBGOdSdXOj_FviSkw-1
Received: by mail-vk1-f198.google.com with SMTP id w6-20020a1f9406000000b00388997b8d31so4773435vkd.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 03:23:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P4b4VDNUOrCuuYzHrxL50l8orvsgc64zf6MDB9/G7nI=;
        b=ti2CQKExKo1imYP13Iz6V0f6lVJPQOnQ5h7xA9jn7fUQV6FYTPQ7siqrbpCQvd5UeU
         Z7jfr+PasR2d68drx1W9fuqQC6mBIRQ5GGSfD93BVjZi/pYVYeLQViYQginfWiulODCe
         r3HewGQJ0J6Ui315+iWQLUzv0rv2Sk4QqE7g4StjH05m86Paw/cdnrymRJ4dBXFjDFVQ
         JGlPIqEhOs6KcqhAlqKfRkwTsbYMlt/7thRUtEZwes4RmHjdeTg+f6Flv8RFqHipn0tF
         K6mNDUGfwSkQQiowN/WQayf6tvJZqJYqHE5f7p8CwWILdwm0/JV2RHx99po2vK62fGWb
         5GZw==
X-Gm-Message-State: AFqh2kq7QV1c3Aza20hq3RGOLsWc0gac7nMNYJhH0+UBDmoRS30ytKLu
        C61CZIU3v3Nd6BnO2PDXbggVXxJeNhWIK0g4HhQh4V/vUxDEYrWIGwyMwUAhCUEcSpUjjritHgy
        oDNHhSZLg4R3awEkTzKMLSgZCoMBXzYVbHS6jL/fC
X-Received: by 2002:a67:ea04:0:b0:3d3:ec78:1d72 with SMTP id g4-20020a67ea04000000b003d3ec781d72mr3814534vso.13.1674472989366;
        Mon, 23 Jan 2023 03:23:09 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuc4Nm/Dd8Fe0BnJ+91lG8llg4zFQJ+QI5+ZUz5w0mVaUsCVB3YJcAwwxLUJmz1/ORwUCIYKtjwtj8FATe11nY=
X-Received: by 2002:a67:ea04:0:b0:3d3:ec78:1d72 with SMTP id
 g4-20020a67ea04000000b003d3ec781d72mr3814527vso.13.1674472989089; Mon, 23 Jan
 2023 03:23:09 -0800 (PST)
MIME-Version: 1.0
References: <20230123065125.26350-1-marcan@marcan.st>
In-Reply-To: <20230123065125.26350-1-marcan@marcan.st>
From:   Eric Curtin <ecurtin@redhat.com>
Date:   Mon, 23 Jan 2023 11:22:53 +0000
Message-ID: <CAOgh=FwEpMGx-F6GZumOBkBYShtU_SVUWTzZ+WWY0Euc-75YGQ@mail.gmail.com>
Subject: Re: [PATCH] soc: apple: apple-pmgr-pwrstate: Switch to IRQ-safe mode
To:     Hector Martin <marcan@marcan.st>
Cc:     Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Janne Grunau <j@jannau.net>, asahi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Jan 2023 at 07:01, Hector Martin <marcan@marcan.st> wrote:
>
> This requires changing the reset path locking primitives to the spinlock
> path in genpd, instead of the mutex path.
>
> Signed-off-by: Hector Martin <marcan@marcan.st>
> ---

It seems we need this to avoid a race from reading #asahi-dev IRC,
commit message could be more detailed here.

Reviewed-by: Eric Curtin <ecurtin@redhat.com>

Is mise le meas/Regards,

Eric Curtin

>  drivers/soc/apple/apple-pmgr-pwrstate.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/soc/apple/apple-pmgr-pwrstate.c b/drivers/soc/apple/apple-pmgr-pwrstate.c
> index e1122288409a..a3e2bc1d2686 100644
> --- a/drivers/soc/apple/apple-pmgr-pwrstate.c
> +++ b/drivers/soc/apple/apple-pmgr-pwrstate.c
> @@ -116,8 +116,9 @@ static int apple_pmgr_ps_power_off(struct generic_pm_domain *genpd)
>  static int apple_pmgr_reset_assert(struct reset_controller_dev *rcdev, unsigned long id)
>  {
>         struct apple_pmgr_ps *ps = rcdev_to_apple_pmgr_ps(rcdev);
> +       unsigned long flags;
>
> -       mutex_lock(&ps->genpd.mlock);
> +       spin_lock_irqsave(&ps->genpd.slock, flags);
>
>         if (ps->genpd.status == GENPD_STATE_OFF)
>                 dev_err(ps->dev, "PS 0x%x: asserting RESET while powered down\n", ps->offset);
> @@ -129,7 +130,7 @@ static int apple_pmgr_reset_assert(struct reset_controller_dev *rcdev, unsigned
>         regmap_update_bits(ps->regmap, ps->offset, APPLE_PMGR_FLAGS | APPLE_PMGR_RESET,
>                            APPLE_PMGR_RESET);
>
> -       mutex_unlock(&ps->genpd.mlock);
> +       spin_unlock_irqrestore(&ps->genpd.slock, flags);
>
>         return 0;
>  }
> @@ -137,8 +138,9 @@ static int apple_pmgr_reset_assert(struct reset_controller_dev *rcdev, unsigned
>  static int apple_pmgr_reset_deassert(struct reset_controller_dev *rcdev, unsigned long id)
>  {
>         struct apple_pmgr_ps *ps = rcdev_to_apple_pmgr_ps(rcdev);
> +       unsigned long flags;
>
> -       mutex_lock(&ps->genpd.mlock);
> +       spin_lock_irqsave(&ps->genpd.slock, flags);
>
>         dev_dbg(ps->dev, "PS 0x%x: deassert reset\n", ps->offset);
>         regmap_update_bits(ps->regmap, ps->offset, APPLE_PMGR_FLAGS | APPLE_PMGR_RESET, 0);
> @@ -147,7 +149,7 @@ static int apple_pmgr_reset_deassert(struct reset_controller_dev *rcdev, unsigne
>         if (ps->genpd.status == GENPD_STATE_OFF)
>                 dev_err(ps->dev, "PS 0x%x: RESET was deasserted while powered down\n", ps->offset);
>
> -       mutex_unlock(&ps->genpd.mlock);
> +       spin_unlock_irqrestore(&ps->genpd.slock, flags);
>
>         return 0;
>  }
> @@ -222,6 +224,7 @@ static int apple_pmgr_ps_probe(struct platform_device *pdev)
>                 return ret;
>         }
>
> +       ps->genpd.flags |= GENPD_FLAG_IRQ_SAFE;
>         ps->genpd.name = name;
>         ps->genpd.power_on = apple_pmgr_ps_power_on;
>         ps->genpd.power_off = apple_pmgr_ps_power_off;
> --
> 2.35.1
>
>

