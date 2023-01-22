Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A42C67714F
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 19:06:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbjAVSGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 13:06:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjAVSGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 13:06:20 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D6E01817F
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jan 2023 10:05:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674410732;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tG4L0cEQEIn10iWcKsfL/igQPD1Vyt3atHFmU9xgaeA=;
        b=WgW+g97CD9NWI9y//4G7IaND1dOCrKCC/quwJdOa9II+/aKR52at6zOxH0B30YkCQ6pQrv
        N6GICLJlobFQWOtk40B6OIwZ/C1Jh2dAYoAR2Cy5eetnAhgWTcHE5ans0O/Da/I/9GiPYD
        YunUyz37kunRFbTII/UUBOeyHx0hN9I=
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-148-q5lEB4eSPx2v3uglYOMuZg-1; Sun, 22 Jan 2023 13:05:30 -0500
X-MC-Unique: q5lEB4eSPx2v3uglYOMuZg-1
Received: by mail-vk1-f200.google.com with SMTP id j84-20020a1fa057000000b003e1a9db9f88so4096293vke.13
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jan 2023 10:05:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tG4L0cEQEIn10iWcKsfL/igQPD1Vyt3atHFmU9xgaeA=;
        b=oSNkXzkpmqT+cgs4OF8Sg2yN7I0tW1PEer/qSxgDrvrN7mXkD+wZx4fqOFeb63MH22
         mwFd7MLVeRsXtzoWNKVCdzY3HUygDeEVTX8h8FyB7QISM+3vp2IICGOv2egxLOvKg8GF
         tErrVCPjgVL5M8ocONjqtlPxjtEXLAPQyQS7ECBxIMD5TJqytqRZ73+qdMLKsH/Zg66C
         6uvo4eJeG2oOmlomlwSI3SsOc55oe0OdnsfImvMAFx7jFfSOz+aqzGQS5ZBJfTkzCAhw
         DVReGGnvmLUL1gSKgfRgbWABMCfPc8V/ZFaUR2qh+OcHOjLtSSFhlSYCqI1xfrydDM6i
         MKEw==
X-Gm-Message-State: AFqh2korkMyk0NEWVO01xJAY5X1G/wSXwQ1nO6fAmQPPymGf06j5TvR2
        zArhP7KALjFopNvpzGtXZVX/FxKolqpdn5qHupxJQzttP+iu5L0t80QBJHprYIreFP8wXjwUUKN
        ROGvXcikVM4RmbEFa8xZXxa3ZGiR2Md+PdW/a6Elj
X-Received: by 2002:a67:e992:0:b0:3d2:e26a:d76f with SMTP id b18-20020a67e992000000b003d2e26ad76fmr2649139vso.41.1674410730089;
        Sun, 22 Jan 2023 10:05:30 -0800 (PST)
X-Google-Smtp-Source: AMrXdXt6xqNFnzcOFl095OFpFyj/GiNxL1ARJlGscYK+I56jVRXdls7GoEtq0uv2D1H4GUbYVv7Yy5Y5IyHwPhmIbco=
X-Received: by 2002:a67:e992:0:b0:3d2:e26a:d76f with SMTP id
 b18-20020a67e992000000b003d2e26ad76fmr2649136vso.41.1674410729838; Sun, 22
 Jan 2023 10:05:29 -0800 (PST)
MIME-Version: 1.0
References: <20230121074253.9774-1-lina@asahilina.net>
In-Reply-To: <20230121074253.9774-1-lina@asahilina.net>
From:   Eric Curtin <ecurtin@redhat.com>
Date:   Sun, 22 Jan 2023 18:05:14 +0000
Message-ID: <CAOgh=FxP_Zf7uD0QYej=0ULTNFDGHg0OHbAQV4L9bjsG4myT1g@mail.gmail.com>
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

Is mise le meas/Regards,

Eric Curtin


On Sat, 21 Jan 2023 at 07:53, Asahi Lina <lina@asahilina.net> wrote:
>
> This allows downstream consumers to keep track of private data for shmem
> mappings. In particular, the Rust abstraction will use this to safely
> drop data associated with a mapping when it is unmapped.
>
> Signed-off-by: Asahi Lina <lina@asahilina.net>
> ---

Sorry Lina, these were obviously supposed to not be signed off tags, but:

Reviewed-by: Eric Curtin <ecurtin@redhat.com>

that's what you get, when you copy a tag from somewhere else!

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

