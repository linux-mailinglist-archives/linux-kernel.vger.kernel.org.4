Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86424676CA9
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 13:08:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbjAVMI4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 07:08:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjAVMIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 07:08:55 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A63E1816C
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jan 2023 04:08:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674389287;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OzUQ1IkPAYdsRop+9FhR/pn1TRh9vi4iBxojZGSjAcA=;
        b=BU/7cnxg1tu35pnWOYNiiRealJHNFLGJd+/u/CRBAjzrY8LD8Ylphra2T9DC2P88nw50C6
        UyNgl7iSaHAooKiYC2I4qKVDJO9OzQxyAwvZz1q7oD2YeaZPgT2WehRAgVQygUwoRebAYO
        4QUAOj6NI7kpS8FxrQNnEJae/fgn81I=
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-330-zF5YLJsCO1CGgQMtjFQhfA-1; Sun, 22 Jan 2023 07:08:05 -0500
X-MC-Unique: zF5YLJsCO1CGgQMtjFQhfA-1
Received: by mail-vk1-f198.google.com with SMTP id m123-20020a1f2681000000b003e1a5d83657so3775656vkm.20
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jan 2023 04:08:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OzUQ1IkPAYdsRop+9FhR/pn1TRh9vi4iBxojZGSjAcA=;
        b=okB1YZPIYHfsnnSj4hGBsSfc4SD6eYi45MKUKE+gYPogtAOrKSbMcr3Gmuqek7nM8b
         R6qxAdNSOQ88vUh3ytlNJGCdR8xIJWHOcDLdfrvbRYoF3pM39P7Lp7TDVhHpUwrOcB0f
         Jfcd6oaetRvgscKLvvzxZgVy1r6ulJ3loWZIcIukTkCWjGlN0OpTdrNSweRL19UUZ2c9
         6Ah83tJnka3fEql0HJ+b44XiCj2yNpnNv+De6KjcfBT08OZIL1WFnURzJ95LlSEdK99h
         FqGuL1EsaDiH2SbZM9vk3DL1tSPZjOM0aOkhmW/a0Ey3+6pNIyzv09CqPAgsYD/+a7i1
         D4xQ==
X-Gm-Message-State: AFqh2kolYNoTGxHg4fPzz2bUlwxRPcu67W2S+xIjyKU3wN9GZuS8ASUw
        8ExJ7OhpcDo1iWGR7L8ATMilwC6qU2oGGIlEYfmjR8nbVpdUYyvp5PS5pLR2wwV+dKHnHr/Ut7q
        pk0s+iJg88mb4EF9hRguJy64U44MegwFTwqYYn9rs
X-Received: by 2002:a1f:a386:0:b0:3d9:6e23:f2db with SMTP id m128-20020a1fa386000000b003d96e23f2dbmr2789047vke.28.1674389285300;
        Sun, 22 Jan 2023 04:08:05 -0800 (PST)
X-Google-Smtp-Source: AMrXdXspC4d9VfafbDNXzL4W89BnXS++Urwf3QLuB3Datz2LORxYulZlK7PQNdVqveWY+hlYOabiqmbWh9Blcw8zKWc=
X-Received: by 2002:a1f:a386:0:b0:3d9:6e23:f2db with SMTP id
 m128-20020a1fa386000000b003d96e23f2dbmr2789044vke.28.1674389285103; Sun, 22
 Jan 2023 04:08:05 -0800 (PST)
MIME-Version: 1.0
References: <20230121074253.9774-1-lina@asahilina.net>
In-Reply-To: <20230121074253.9774-1-lina@asahilina.net>
From:   Eric Curtin <ecurtin@redhat.com>
Date:   Sun, 22 Jan 2023 12:07:49 +0000
Message-ID: <CAOgh=FwrkFsst9sdL54jF=aKZRo6PP+TPwcXad_GN4Fiq_b_8g@mail.gmail.com>
Subject: Re: [PATCH] soc: apple: rtkit: Add a private pointer to apple_rtkit_shmem
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

On Sat, 21 Jan 2023 at 07:53, Asahi Lina <lina@asahilina.net> wrote:
>
> This allows downstream consumers to keep track of private data for shmem
> mappings. In particular, the Rust abstraction will use this to safely
> drop data associated with a mapping when it is unmapped.
>
> Signed-off-by: Asahi Lina <lina@asahilina.net>
> ---

Signed-off-by: Eric Curtin <ecurtin@redhat.com>

>  include/linux/soc/apple/rtkit.h | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/include/linux/soc/apple/rtkit.h b/include/linux/soc/apple/rtkit.h
> index 62bfa37b5adb..1a9888a1797a 100644
> --- a/include/linux/soc/apple/rtkit.h
> +++ b/include/linux/soc/apple/rtkit.h
> @@ -22,6 +22,7 @@
>   * @size:      Size of the shared memory buffer.
>   * @iova:      Device VA of shared memory buffer.
>   * @is_mapped: Shared memory buffer is managed by the co-processor.
> + * @private:   Private data pointer for the parent driver.
>   */
>
>  struct apple_rtkit_shmem {
> @@ -30,6 +31,7 @@ struct apple_rtkit_shmem {
>         size_t size;
>         dma_addr_t iova;
>         bool is_mapped;
> +       void *private;
>  };
>
>  /*
> --
> 2.35.1
>
>

