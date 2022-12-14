Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D038364CC91
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 15:45:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238372AbiLNOpE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 09:45:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238715AbiLNOov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 09:44:51 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4324924F33
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 06:44:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671029046;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Od+ZzidxMkq0q/yuo1WBwXnhx0kOazQnqrbp3yVh/SA=;
        b=LQ9/9GUsW7IN2rzsoG2ucCUUvjMsOXD+mGN7uVi7G1r4c1Tvr9KeDOErdCq3SHk84zuLeq
        xLltx9bCD88kGxHAQF+XdV1wyfB7zv5FjlcdC8Gy8FpKVV41lnRkbLewAv8eX/QICP8UpG
        WQC0rUP9VADvqUmB0D6mSyKE6417A3U=
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-259-FcaKH12OMiCjzXiJuFziXA-1; Wed, 14 Dec 2022 09:44:05 -0500
X-MC-Unique: FcaKH12OMiCjzXiJuFziXA-1
Received: by mail-vs1-f69.google.com with SMTP id q28-20020a056102205c00b003b0cb47410bso5254394vsr.20
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 06:44:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Od+ZzidxMkq0q/yuo1WBwXnhx0kOazQnqrbp3yVh/SA=;
        b=xDVH439dRejcEnaQdxQXzouE8BwJRw8qq8p0NnoT0St6zLMcL8uy2CbVc1ynPrYqcb
         QnUpXDC9GB4/YKvvGOvcxNjBen+N6AHhazWE3VIxMHZB23pVdidwuoHmKRIcKeYOiEPD
         /WSw7dhAVZsHO3XX6/sRq6P7SHJmKWcZCDGM51oElgrshU5jyPQhMdRiIC6f4Ja0joh3
         dGxIY2FVg4I5HVSlbVvHu+ZIWJql1Bq9+UCpNiiVq5Wrh+1bO4UxFCdpu4Q2uYM6VJUu
         iD5RlKRjAv6zqg5FXp5PVTNUmcOkotZefiVLKuBf9/lqZv1M9r1Px4wVauikhpuBZiMV
         ns0Q==
X-Gm-Message-State: ANoB5plqAtiv5BYW35vKEs2x85VcEZVJ8YzvAAT/lawnnTmZ+unV6foN
        6k9ql/MVdku+YP63XXmdTLrKeAf46OAO7cbbKa8ixVk7STzmJmYcpw2jWYlwOumnTEEpij8MOMP
        giLRPGrx64tKf2A75PClPMpkNzkKiEHBp4Hya9FvF
X-Received: by 2002:ab0:1626:0:b0:3b3:e759:ed55 with SMTP id k35-20020ab01626000000b003b3e759ed55mr47758860uae.106.1671029044291;
        Wed, 14 Dec 2022 06:44:04 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5dYfeZwV/UZD42wC3ZAeGn3qE4Z/ss22NsGqT1kATRGiXRxDym15thfFXzewCPVqoLEowiNwDy+9HORdcuxjQ=
X-Received: by 2002:ab0:1626:0:b0:3b3:e759:ed55 with SMTP id
 k35-20020ab01626000000b003b3e759ed55mr47758856uae.106.1671029044007; Wed, 14
 Dec 2022 06:44:04 -0800 (PST)
MIME-Version: 1.0
References: <20221214142952.9372-1-marcan@marcan.st>
In-Reply-To: <20221214142952.9372-1-marcan@marcan.st>
From:   Eric Curtin <ecurtin@redhat.com>
Date:   Wed, 14 Dec 2022 14:43:48 +0000
Message-ID: <CAOgh=FwYsdi1aK3ajgmJ23HBNUajZ=k+q4r2qrdYja28tHLYoA@mail.gmail.com>
Subject: Re: [PATCH] nvmem: core: Fix race in nvmem_register()
To:     Hector Martin <marcan@marcan.st>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        asahi@lists.linux.dev, linux-kernel@vger.kernel.org
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

On Wed, 14 Dec 2022 at 14:40, Hector Martin <marcan@marcan.st> wrote:
>
> nvmem_register() currently registers the device before adding the nvmem
> cells, which creates a race window where consumers may find the nvmem
> device (and not get PROBE_DEFERred), but then fail to find the cells and
> error out.
>
> Move device registration to the end of nvmem_register(), to close the
> race.
>
> Observed when the stars line up on Apple Silicon machines with the (not
> yet upstream, but trivial) spmi nvmem driver and the macsmc-rtc client:
>
> [    0.487375] macsmc-rtc macsmc-rtc: error -ENOENT: Failed to get rtc_offset NVMEM cell
>
> Fixes: eace75cfdcf7 ("nvmem: Add a simple NVMEM framework for nvmem providers")
> Signed-off-by: Hector Martin <marcan@marcan.st>

Reviewed-by: Eric Curtin <ecurtin@redhat.com>

> ---
>  drivers/nvmem/core.c | 18 ++++++++----------
>  1 file changed, 8 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> index 321d7d63e068..d255feca5e17 100644
> --- a/drivers/nvmem/core.c
> +++ b/drivers/nvmem/core.c
> @@ -837,20 +837,16 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
>
>         dev_dbg(&nvmem->dev, "Registering nvmem device %s\n", config->name);
>
> -       rval = device_register(&nvmem->dev);
> -       if (rval)
> -               goto err_put_device;
> -
>         if (nvmem->nkeepout) {
>                 rval = nvmem_validate_keepouts(nvmem);
>                 if (rval)
> -                       goto err_device_del;
> +                       return ERR_PTR(rval);
>         }
>
>         if (config->compat) {
>                 rval = nvmem_sysfs_setup_compat(nvmem, config);
>                 if (rval)
> -                       goto err_device_del;
> +                       return ERR_PTR(rval);
>         }
>
>         if (config->cells) {
> @@ -867,19 +863,21 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
>         if (rval)
>                 goto err_remove_cells;
>
> +       rval = device_register(&nvmem->dev);
> +       if (rval)
> +               goto err_put_device;
> +
>         blocking_notifier_call_chain(&nvmem_notifier, NVMEM_ADD, nvmem);
>
>         return nvmem;
>
> +err_put_device:
> +       put_device(&nvmem->dev);
>  err_remove_cells:
>         nvmem_device_remove_all_cells(nvmem);
>  err_teardown_compat:
>         if (config->compat)
>                 nvmem_sysfs_remove_compat(nvmem, config);
> -err_device_del:
> -       device_del(&nvmem->dev);
> -err_put_device:
> -       put_device(&nvmem->dev);
>
>         return ERR_PTR(rval);
>  }
> --
> 2.35.1
>
>

