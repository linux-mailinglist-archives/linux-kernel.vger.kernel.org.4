Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10106677153
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 19:06:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbjAVSGw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 13:06:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjAVSGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 13:06:50 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FA0718A80
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jan 2023 10:06:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674410763;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vcaIEvEw2kQFdDtVG6J3qw3jie84Jdha/erxS3HJUJ4=;
        b=cvaAp5/vbfVffM/AlIrWVY4cbNhu7mVYRRthmrsDjCBlHz378D8/1Zmt8WgV/EELIElXaS
        dyuvn4gmPSX3xtG6CeC4hk65w56yLSJ+6SK9/KwcpMQBZRLwhYk6V+ebcVs7LTlpwiewbc
        Ma+y5JAqUCJJ2VQy7WPGYTvVxfhqJ3c=
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-557-autcGrryOW6p4SeixDADeA-1; Sun, 22 Jan 2023 13:06:01 -0500
X-MC-Unique: autcGrryOW6p4SeixDADeA-1
Received: by mail-vk1-f199.google.com with SMTP id u187-20020a1fabc4000000b003ca3e899f8fso4091457vke.22
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jan 2023 10:06:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vcaIEvEw2kQFdDtVG6J3qw3jie84Jdha/erxS3HJUJ4=;
        b=5pR0cYbtUA774mMWkwUa+TPaF4Hmo+Iyoc8hyfCEd+B1GOOky1cpfCAOwGY3nAUmi0
         glkKkASCEqtEv2cvPnVxEzumctAjeRpTUU0JCINchk/Bf19LifItgshwRsu8u7khKwhP
         jkZ1Ta2RdoKOpssvrJW86/B6unMjUFN8v9ZYqUpM+IPWy7gPgUnZkC4Jyibz0breYGcK
         8zGldrJp3lOb9XSs10dFq6eqRh7LsfBfbuvXOlfrialLgOabLFWmbXxvItlGbB85+rD9
         rAIec95JkjzxvRBp9Cix4UwJ3TOSH27+Z2ry1mCJRrBj/18g9Iqd9Zialgt/cFFdTfPr
         WxDw==
X-Gm-Message-State: AFqh2kqVkiaE6zKeBpNds1GJl3ZTDJ7cSoj8aDJZhXJkX8IKtv4hSuD6
        zcUPI6Vh01Q3UCjdkMMyaVLuxTtLapir6RrDWDhdPgztD59Pgkj4JMaiioj3v7G9x7Yw4tgdg2h
        NGsnkJj9oXXPqudN3UzKA6V2IxXvLdxeFr8tBD2v/
X-Received: by 2002:ab0:39d6:0:b0:5d6:87df:263d with SMTP id g22-20020ab039d6000000b005d687df263dmr2268027uaw.58.1674410761277;
        Sun, 22 Jan 2023 10:06:01 -0800 (PST)
X-Google-Smtp-Source: AMrXdXt7kt+tvJVSdjC7CXhzl7u8uiu/MSmcfTHSlJjAFczq7OXUmYCh4CDD2soj8KhGCdG1oy5hrUxPqUexDaa/k4Y=
X-Received: by 2002:ab0:39d6:0:b0:5d6:87df:263d with SMTP id
 g22-20020ab039d6000000b005d687df263dmr2268026uaw.58.1674410761031; Sun, 22
 Jan 2023 10:06:01 -0800 (PST)
MIME-Version: 1.0
References: <20230121074135.8629-1-lina@asahilina.net>
In-Reply-To: <20230121074135.8629-1-lina@asahilina.net>
From:   Eric Curtin <ecurtin@redhat.com>
Date:   Sun, 22 Jan 2023 18:05:45 +0000
Message-ID: <CAOgh=FwZ0niWu3=tvjYu91Bt0uxyv=6mE449we78X7KWPBPcCw@mail.gmail.com>
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

Reviewed-by: Eric Curtin <ecurtin@redhat.com>

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

