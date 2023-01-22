Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87389676CB9
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 13:17:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbjAVMRb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 07:17:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbjAVMRa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 07:17:30 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0840D1ABCF
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jan 2023 04:16:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674389808;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=brAkpxNNFoW2Z58ovept6ujrU4B664Hnu1EZEFyhAcY=;
        b=Soq2/WbMyJZMut+or/OzP/n8PGRkB7azsT5D1wAXiPc9qxGK6q4TxExuRnKRm6CzsDbIrn
        iR0+iKhi/DVL8XGQVgWYksnuOyTIiWcDtHtXrWTP9Qk1kci4cb9f/ZwmdWpDiLUBI5xH6j
        JBDC+MnB+ba+GKmpDMHzVF+8o3khWRE=
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-370-8mhxJcJxPmyFO5ZwZYb3Xg-1; Sun, 22 Jan 2023 07:16:44 -0500
X-MC-Unique: 8mhxJcJxPmyFO5ZwZYb3Xg-1
Received: by mail-vk1-f198.google.com with SMTP id i34-20020a0561220c6200b003e20c1ea31bso2334715vkr.8
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jan 2023 04:16:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=brAkpxNNFoW2Z58ovept6ujrU4B664Hnu1EZEFyhAcY=;
        b=6QgtmUVGBkgI0SgxyCO/d3JMfYWvjFozVyaZKJnokr8xb3ISpOtVCL/p/8illxSnso
         VdbYgccFv99RNhPxW63l0JKCD9mki/t8uiAOSvBuBQKzqD/55pJDwdZrjenTTgMJrWAK
         KjqgucOYg1W+JJ0oyR1UsESA1SpE75MnAQETiz5WcDwrzJbAd1k5CCSjz5aRp3N1g9zS
         ImjhBsCVL2mBBtf/gxq1+B9uw89EUSkszxuT9iFMm6bCNrUFUtshydhNI+S01Ve1OlFQ
         n+N7YtD9GoYPA8fLmo7jlJ1nm6+adj5pycpTq4eZRntc6mrpIpEzoA21JpljE4sn35x7
         UraQ==
X-Gm-Message-State: AFqh2korGoz1rEarAyfWgSGb9LmiDhv1ubCwT1eXKBjI1NE8GgcyHJBP
        QXhZ47D+4npZXCjWnhmf80XvwZfWU4NpiLZdr5iUR/tITTt15Q7ZZHUW+Ed1GF4U2bIJ0+HetoU
        h6mYNBMojIFBzARZNWxeXbo3xWZvcQpnzj00jl5up
X-Received: by 2002:a67:ea04:0:b0:3d3:ec78:1d72 with SMTP id g4-20020a67ea04000000b003d3ec781d72mr3367181vso.13.1674389803898;
        Sun, 22 Jan 2023 04:16:43 -0800 (PST)
X-Google-Smtp-Source: AMrXdXstqJIXMudqh70EtyFZQyQrExJwlFEQoxbce+hMZ9zA7g8JYZZgFJ19R51I66UXYr8raWky+/W1qdTceGVyFcI=
X-Received: by 2002:a67:ea04:0:b0:3d3:ec78:1d72 with SMTP id
 g4-20020a67ea04000000b003d3ec781d72mr3367179vso.13.1674389803666; Sun, 22 Jan
 2023 04:16:43 -0800 (PST)
MIME-Version: 1.0
References: <20230121074135.8629-1-lina@asahilina.net>
In-Reply-To: <20230121074135.8629-1-lina@asahilina.net>
From:   Eric Curtin <ecurtin@redhat.com>
Date:   Sun, 22 Jan 2023 12:16:28 +0000
Message-ID: <CAOgh=FwPCJ3pDk0EUgekzdE+Y=OpyWHiWW5bo7qoX21trbMV7Q@mail.gmail.com>
Subject: Re: [PATCH] soc: apple: rtkit: Export non-devm init/free functions
To:     Asahi Lina <lina@asahilina.net>
Cc:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
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

On Sat, 21 Jan 2023 at 07:48, Asahi Lina <lina@asahilina.net> wrote:
>
> While we normally encourage devm usage by drivers, some consumers (and
> in particular the upcoming Rust abstractions) might want to manually
> manage memory. Export the raw functions to make this possible.
>
> Signed-off-by: Asahi Lina <lina@asahilina.net>
> ---

Signed-off-by: Eric Curtin <ecurtin@redhat.com>

Is mise le meas/Regards,

Eric Curtin

>  drivers/soc/apple/rtkit.c       | 15 ++++++++++-----
>  include/linux/soc/apple/rtkit.h | 19 +++++++++++++++++++
>  2 files changed, 29 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/soc/apple/rtkit.c b/drivers/soc/apple/rtkit.c
> index fa3cda831d2b..bb33f3cd4efd 100644
> --- a/drivers/soc/apple/rtkit.c
> +++ b/drivers/soc/apple/rtkit.c
> @@ -686,7 +686,7 @@ static int apple_rtkit_request_mbox_chan(struct apple_rtkit *rtk)
>         return mbox_start_channel(rtk->mbox_chan);
>  }
>
> -static struct apple_rtkit *apple_rtkit_init(struct device *dev, void *cookie,
> +struct apple_rtkit *apple_rtkit_init(struct device *dev, void *cookie,
>                                             const char *mbox_name, int mbox_idx,
>                                             const struct apple_rtkit_ops *ops)
>  {
> @@ -739,6 +739,7 @@ static struct apple_rtkit *apple_rtkit_init(struct device *dev, void *cookie,
>         kfree(rtk);
>         return ERR_PTR(ret);
>  }
> +EXPORT_SYMBOL_GPL(apple_rtkit_init);
>
>  static int apple_rtkit_wait_for_completion(struct completion *c)
>  {
> @@ -922,10 +923,8 @@ int apple_rtkit_wake(struct apple_rtkit *rtk)
>  }
>  EXPORT_SYMBOL_GPL(apple_rtkit_wake);
>
> -static void apple_rtkit_free(void *data)
> +void apple_rtkit_free(struct apple_rtkit *rtk)
>  {
> -       struct apple_rtkit *rtk = data;
> -
>         mbox_free_channel(rtk->mbox_chan);
>         destroy_workqueue(rtk->wq);
>
> @@ -936,6 +935,12 @@ static void apple_rtkit_free(void *data)
>         kfree(rtk->syslog_msg_buffer);
>         kfree(rtk);
>  }
> +EXPORT_SYMBOL_GPL(apple_rtkit_free);
> +
> +static void apple_rtkit_free_wrapper(void *data)
> +{
> +       apple_rtkit_free(data);
> +}
>
>  struct apple_rtkit *devm_apple_rtkit_init(struct device *dev, void *cookie,
>                                           const char *mbox_name, int mbox_idx,
> @@ -948,7 +953,7 @@ struct apple_rtkit *devm_apple_rtkit_init(struct device *dev, void *cookie,
>         if (IS_ERR(rtk))
>                 return rtk;
>
> -       ret = devm_add_action_or_reset(dev, apple_rtkit_free, rtk);
> +       ret = devm_add_action_or_reset(dev, apple_rtkit_free_wrapper, rtk);
>         if (ret)
>                 return ERR_PTR(ret);
>
> diff --git a/include/linux/soc/apple/rtkit.h b/include/linux/soc/apple/rtkit.h
> index 2d837aa7b91f..62bfa37b5adb 100644
> --- a/include/linux/soc/apple/rtkit.h
> +++ b/include/linux/soc/apple/rtkit.h
> @@ -77,6 +77,25 @@ struct apple_rtkit *devm_apple_rtkit_init(struct device *dev, void *cookie,
>                                           const char *mbox_name, int mbox_idx,
>                                           const struct apple_rtkit_ops *ops);
>
> +/*
> + * Non-devm version of devm_apple_rtkit_init. Must be freed with
> + * apple_rtkit_free.
> + *
> + * @dev:         Pointer to the device node this coprocessor is assocated with
> + * @cookie:      opaque cookie passed to all functions defined in rtkit_ops
> + * @mbox_name:   mailbox name used to communicate with the co-processor
> + * @mbox_idx:    mailbox index to be used if mbox_name is NULL
> + * @ops:         pointer to rtkit_ops to be used for this co-processor
> + */
> +struct apple_rtkit *apple_rtkit_init(struct device *dev, void *cookie,
> +                                         const char *mbox_name, int mbox_idx,
> +                                         const struct apple_rtkit_ops *ops);
> +
> +/*
> + * Free an instance of apple_rtkit.
> + */
> +void apple_rtkit_free(struct apple_rtkit *rtk);
> +
>  /*
>   * Reinitialize internal structures. Must only be called with the co-processor
>   * is held in reset.
> --
> 2.35.1
>
>

