Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E11AE6779DE
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 12:12:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231633AbjAWLMG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 06:12:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbjAWLMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 06:12:00 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 710AC227BA
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 03:11:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674472278;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZLW1zu/uqNqiNzxwf0pUEyEiwMB4MNxJjb70gD496nc=;
        b=EUGCJ6rfLWoaw+KtkUrmk7/eeuq8EizjcR5Tl/R0ZDoblUj5qYkyoet2lpeCMhQvvG40HY
        fkgQ1aU8Db0PScmqmYtJG56U50hIXbew0fj2PQZ6FbDAFexp/V4uNnXvloxIXi0bMXWMAX
        1btmwfy/Ity/xKBWK+nM3XkufLOAjXc=
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-422-USohlqBBMrSNCWo7L6pMAw-1; Mon, 23 Jan 2023 06:11:17 -0500
X-MC-Unique: USohlqBBMrSNCWo7L6pMAw-1
Received: by mail-vk1-f199.google.com with SMTP id u187-20020a1fabc4000000b003ca3e899f8fso4767718vke.22
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 03:11:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZLW1zu/uqNqiNzxwf0pUEyEiwMB4MNxJjb70gD496nc=;
        b=rUyzPhyfz0EsyKo3py8OxGwj8eMqBYjBdsPs3hXCxl+HYtYxdScfQROHhBOOdFd/Oh
         8dNReswm9vEkQlH/YMGc5ShI/1fesH+i4zZ6Wmd5cLm7dBbESfgMgZOlcCPZqKpFTCoH
         QD/SiyTxNAUMgb69gOb0fTkp/j8EamwOk6m1E2+DxoPmE0aqwXxJXZ26OXd8c4yTe2Kh
         5fAVzDUs3altE1i7GrZ1uGyDulEgjaEOCh8m3TsVKkfU01bXyKvHr8NdqX812TsWL16p
         /6Gy4dXLiuyZ21jVvysy+9Dc754kc0sRRLrPXsT6URZ9v9qdJ1csX/Pep7g5WYvjaWhv
         Bldw==
X-Gm-Message-State: AFqh2kqnnMg9iBa6uLM/ixybngpyIsX4bsJVDGdZq8nPSMD68UeV2W5D
        rH5kMgcaQMRxiVzpjdf1r2eXFwo1VBpVbB8t7cpSplxVTfpFl2XRFg5IS17IeA1nrXf/FaimgKP
        rmmYQHEUyefTy2T4emXKY2E7BPEOJTPwoiuWgXwwi
X-Received: by 2002:ab0:25d1:0:b0:419:23:73b5 with SMTP id y17-20020ab025d1000000b00419002373b5mr2625762uan.17.1674472276856;
        Mon, 23 Jan 2023 03:11:16 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvNuFzf3awsJRX31iM/Ic/uH+uRpF3B1E+2FTOiZ733WSjUePPEahunKZ6rWi5dytte8R/Rn1vNjkVBRgkYvIw=
X-Received: by 2002:ab0:25d1:0:b0:419:23:73b5 with SMTP id y17-20020ab025d1000000b00419002373b5mr2625759uan.17.1674472276610;
 Mon, 23 Jan 2023 03:11:16 -0800 (PST)
MIME-Version: 1.0
References: <20230123065354.28179-1-marcan@marcan.st>
In-Reply-To: <20230123065354.28179-1-marcan@marcan.st>
From:   Eric Curtin <ecurtin@redhat.com>
Date:   Mon, 23 Jan 2023 11:11:00 +0000
Message-ID: <CAOgh=FxQLtA3OaQOq=tTGzTwod-BOSu+CP5QpgR2z4iFmoCX3w@mail.gmail.com>
Subject: Re: [PATCH] soc: apple: rtkit: Add apple_rtkit_idle() function
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

On Mon, 23 Jan 2023 at 07:03, Hector Martin <marcan@marcan.st> wrote:
>
> This is yet another low power mode, used by DCP.
>
> Signed-off-by: Hector Martin <marcan@marcan.st>
> ---

New power state, nice

Reviewed-by: Eric Curtin <ecurtin@redhat.com>

Is mise le meas/Regards,

Eric Curtin

>  drivers/soc/apple/rtkit.c       | 21 +++++++++++++++++++++
>  include/linux/soc/apple/rtkit.h |  5 +++++
>  2 files changed, 26 insertions(+)
>
> diff --git a/drivers/soc/apple/rtkit.c b/drivers/soc/apple/rtkit.c
> index ceb4516e442c..509b050cf040 100644
> --- a/drivers/soc/apple/rtkit.c
> +++ b/drivers/soc/apple/rtkit.c
> @@ -9,6 +9,7 @@
>  enum {
>         APPLE_RTKIT_PWR_STATE_OFF = 0x00, /* power off, cannot be restarted */
>         APPLE_RTKIT_PWR_STATE_SLEEP = 0x01, /* sleeping, can be restarted */
> +       APPLE_RTKIT_PWR_STATE_IDLE = 0x201, /* sleeping, retain state */
>         APPLE_RTKIT_PWR_STATE_QUIESCED = 0x10, /* running but no communication */
>         APPLE_RTKIT_PWR_STATE_ON = 0x20, /* normal operating state */
>  };
> @@ -882,6 +883,26 @@ int apple_rtkit_shutdown(struct apple_rtkit *rtk)
>  }
>  EXPORT_SYMBOL_GPL(apple_rtkit_shutdown);
>
> +int apple_rtkit_idle(struct apple_rtkit *rtk)
> +{
> +       int ret;
> +
> +       /* if OFF is used here the co-processor will not wake up again */
> +       ret = apple_rtkit_set_ap_power_state(rtk,
> +                                            APPLE_RTKIT_PWR_STATE_IDLE);
> +       if (ret)
> +               return ret;
> +
> +       ret = apple_rtkit_set_iop_power_state(rtk, APPLE_RTKIT_PWR_STATE_IDLE);
> +       if (ret)
> +               return ret;
> +
> +       rtk->iop_power_state = APPLE_RTKIT_PWR_STATE_IDLE;
> +       rtk->ap_power_state = APPLE_RTKIT_PWR_STATE_IDLE;
> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(apple_rtkit_idle);
> +
>  int apple_rtkit_quiesce(struct apple_rtkit *rtk)
>  {
>         int ret;
> diff --git a/include/linux/soc/apple/rtkit.h b/include/linux/soc/apple/rtkit.h
> index 2a0edb5fa6fe..f8d9cc0691de 100644
> --- a/include/linux/soc/apple/rtkit.h
> +++ b/include/linux/soc/apple/rtkit.h
> @@ -132,6 +132,11 @@ int apple_rtkit_wake(struct apple_rtkit *rtk);
>   */
>  int apple_rtkit_shutdown(struct apple_rtkit *rtk);
>
> +/*
> + * Put the co-processor into idle mode
> + */
> +int apple_rtkit_idle(struct apple_rtkit *rtk);
> +
>  /*
>   * Checks if RTKit is running and ready to handle messages.
>   */
> --
> 2.35.1
>
>

