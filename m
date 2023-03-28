Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 326746CC11B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 15:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232802AbjC1NiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 09:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232303AbjC1NiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 09:38:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5598CCA07
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 06:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680010604;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=38WhB1xhz6iO9xwaGoOJESCsJJ1GMow8wYkaX1OpVf0=;
        b=cznFg6XMfwGXc6k4vXdyQ5Vkq5Z1pzwBSGo/CuLUQ/ihAGv2IVc+CT6O74rsirowiHPYKB
        h3wyUFwDyLxIoZ7niFj0zHklX8diSCmSXmo7Tu7Sck9+rRq85h+xcSRa/l4EiPQnRttvXm
        WixAkV5WPB8LCRd/dJFHQ4AldqbgSgk=
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-467-eUazwkn0MdabtsOMonE5fw-1; Tue, 28 Mar 2023 09:36:43 -0400
X-MC-Unique: eUazwkn0MdabtsOMonE5fw-1
Received: by mail-vs1-f70.google.com with SMTP id y22-20020a67d216000000b00425ef23aa54so3702538vsi.20
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 06:36:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680010602;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=38WhB1xhz6iO9xwaGoOJESCsJJ1GMow8wYkaX1OpVf0=;
        b=P/1AXrbw9SVXkIu5VMdcY3lH7rccCjCAfjkAigYIwUoRW6wXCsHVxI/48qD//0rNmO
         fsod43cSI78FHhKgJT1rnHelKsFpFQoQWmO+flzPX0tzZPrYMG1cBrciGa5I4aKDls1J
         WgOjTYD0H6LLA2APRgbfqUVstM9+cXG8vsb1eyDJ65aTVHTRHJcREwH5kZk3ChULjY1a
         iKEDHTJriz/P5CkF/k5SRTd5C/pbL68KeNok5GlAQXaFcVGKL12X6TJZs/zwRLP5qHQw
         AkgBNVzCWIu0i1bGhEkHLfUDjQ3NkkIZg7LCwA6u4ZCXZtZk4aPg3hBGveQkQC5qO3CV
         lUPw==
X-Gm-Message-State: AAQBX9evU3MLDB3f8FA6yifGFV7ikLF48Erqt0ZZ2YFvCbUCp4OGvBlG
        CAxd/ZwryTnybztvSpkFmPprlSuTSWPYmA98YiSKHbyUeAgWUQSWeCu6ZCvQl/OGK9jS7gEBTPs
        E6Hrg8P5Jn/70Vh956R9Vy0yl6Ys3gP+wfRtoUo+uZrxaaFM//EIwwg==
X-Received: by 2002:a67:d78d:0:b0:425:dd21:acc8 with SMTP id q13-20020a67d78d000000b00425dd21acc8mr8457957vsj.7.1680010602695;
        Tue, 28 Mar 2023 06:36:42 -0700 (PDT)
X-Google-Smtp-Source: AKy350aD49wliP3FptdixB7cu5C7ONZu/9rIPSHjym/CTFrbaUpovBd8LuxZBaGrdm3pSCVMhO5vQdqJWYOKsWvWXH8=
X-Received: by 2002:a67:d78d:0:b0:425:dd21:acc8 with SMTP id
 q13-20020a67d78d000000b00425dd21acc8mr8457942vsj.7.1680010602358; Tue, 28 Mar
 2023 06:36:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230328-soc-mailbox-v1-0-3953814532fd@marcan.st> <20230328-soc-mailbox-v1-1-3953814532fd@marcan.st>
In-Reply-To: <20230328-soc-mailbox-v1-1-3953814532fd@marcan.st>
From:   Eric Curtin <ecurtin@redhat.com>
Date:   Tue, 28 Mar 2023 14:36:26 +0100
Message-ID: <CAOgh=Fwur3_aBhKqRW-JaTKXHJaKhCpvA-9d7ZKhMbRmtGYHWQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] soc: apple: rtkit: Get rid of apple_rtkit_send_message_wait
To:     Hector Martin <marcan@marcan.st>
Cc:     Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Janne Grunau <j@jannau.net>, linux-kernel@vger.kernel.org,
        asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Mar 2023 at 14:20, Hector Martin <marcan@marcan.st> wrote:
>
> It is fundamentally broken and has no users. Just remove it.
>
> Signed-off-by: Hector Martin <marcan@marcan.st>

Watched the stream

Acked-by: Eric Curtin <ecurtin@redhat.com>

Is mise le meas/Regards,

Eric Curtin

> ---
>  drivers/soc/apple/rtkit.c       | 32 --------------------------------
>  include/linux/soc/apple/rtkit.h | 18 ------------------
>  2 files changed, 50 deletions(-)
>
> diff --git a/drivers/soc/apple/rtkit.c b/drivers/soc/apple/rtkit.c
> index d9f19dc99da5..7c9b9f25bbc1 100644
> --- a/drivers/soc/apple/rtkit.c
> +++ b/drivers/soc/apple/rtkit.c
> @@ -641,38 +641,6 @@ int apple_rtkit_send_message(struct apple_rtkit *rtk, u8 ep, u64 message,
>  }
>  EXPORT_SYMBOL_GPL(apple_rtkit_send_message);
>
> -int apple_rtkit_send_message_wait(struct apple_rtkit *rtk, u8 ep, u64 message,
> -                                 unsigned long timeout, bool atomic)
> -{
> -       DECLARE_COMPLETION_ONSTACK(completion);
> -       int ret;
> -       long t;
> -
> -       ret = apple_rtkit_send_message(rtk, ep, message, &completion, atomic);
> -       if (ret < 0)
> -               return ret;
> -
> -       if (atomic) {
> -               ret = mbox_flush(rtk->mbox_chan, timeout);
> -               if (ret < 0)
> -                       return ret;
> -
> -               if (try_wait_for_completion(&completion))
> -                       return 0;
> -
> -               return -ETIME;
> -       } else {
> -               t = wait_for_completion_interruptible_timeout(
> -                       &completion, msecs_to_jiffies(timeout));
> -               if (t < 0)
> -                       return t;
> -               else if (t == 0)
> -                       return -ETIME;
> -               return 0;
> -       }
> -}
> -EXPORT_SYMBOL_GPL(apple_rtkit_send_message_wait);
> -
>  int apple_rtkit_poll(struct apple_rtkit *rtk)
>  {
>         return mbox_client_peek_data(rtk->mbox_chan);
> diff --git a/include/linux/soc/apple/rtkit.h b/include/linux/soc/apple/rtkit.h
> index fc456f75c131..8c9ca857ccf6 100644
> --- a/include/linux/soc/apple/rtkit.h
> +++ b/include/linux/soc/apple/rtkit.h
> @@ -160,24 +160,6 @@ int apple_rtkit_start_ep(struct apple_rtkit *rtk, u8 endpoint);
>  int apple_rtkit_send_message(struct apple_rtkit *rtk, u8 ep, u64 message,
>                              struct completion *completion, bool atomic);
>
> -/*
> - * Send a message to the given endpoint and wait until it has been submitted
> - * to the hardware FIFO.
> - * Will return zero on success and a negative error code on failure
> - * (e.g. -ETIME when the message couldn't be written within the given
> - * timeout)
> - *
> - * @rtk:            RTKit reference
> - * @ep:             target endpoint
> - * @message:        message to be sent
> - * @timeout:        timeout in milliseconds to allow the message transmission
> - *                  to be completed
> - * @atomic:         if set to true this function can be called from atomic
> - *                  context.
> - */
> -int apple_rtkit_send_message_wait(struct apple_rtkit *rtk, u8 ep, u64 message,
> -                                 unsigned long timeout, bool atomic);
> -
>  /*
>   * Process incoming messages in atomic context.
>   * This only guarantees that messages arrive as far as the recv_message_early
>
> --
> 2.40.0
>
>

