Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99C436054FB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 03:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231288AbiJTB3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 21:29:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231239AbiJTB3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 21:29:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 828581D0D6E
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 18:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666229185;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cMgGZ6JgJsqaOFU1082FRyXxTCRVHVjB7j7NRF7R4zo=;
        b=Uy9S48VTrP1JjZ1pvLD4TRHcRRMaVzAopM030QO2t9awIE2VTFHOiqcx+Ym1E+jALG6qkZ
        qQVAcjb8rrGo3hJUWbvQjaVOcIQ1xtyJbh4kfrgFiYqFhISyTdfUF8eOLtVS6S2MmPTUhb
        cEnyo0ktX6yqZITPFYcJAKBH+egaDSo=
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-470-dmtrUB9zN1e8O0BnkWKusQ-1; Wed, 19 Oct 2022 21:26:24 -0400
X-MC-Unique: dmtrUB9zN1e8O0BnkWKusQ-1
Received: by mail-vs1-f72.google.com with SMTP id b68-20020a676747000000b003a780247edcso5100069vsc.14
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 18:26:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cMgGZ6JgJsqaOFU1082FRyXxTCRVHVjB7j7NRF7R4zo=;
        b=eiWbO1rKVo8Y8yGXZ3GfxzBJ9gnFBnbNblKVCWq8nRmQGYjOnzApbxf79v8+yG5+nS
         lEpcS43hMSaNhXiuLUEYllpFWfq00jnLLO6RpwZpsx4EqSE0pUF56l6WVw5O93yR+Wgx
         /4sQEBeAPi3zChD2ZboZ2BmKEISAj4YWD71849oDKz5lQCXvAGct3vxuOeGPvVUnTklc
         5dzfQyRGbe/wwEIUXlyhZImJxhPw2aZmTwnkvS0h5NiYsoLf7PU0Yr3+Bn31hFZ5oHW/
         IoFXbI5WeTuKkXvX/vnlxBCRB9jd7UaJ4KWr5jskjt2GTwuJWLD5YRlHB3EFUiP00SQm
         bTDQ==
X-Gm-Message-State: ACrzQf0Fw7PV+NBcYXk1WEp+ZNVal28ujKxbzOIDGspZvqqqfgoW7Z4v
        7vqLsbVwXRXVtOZ0x6FpT1PIvAh5CR0eJyb+USx7YllabblVRFlcnDORIW+jGXUVS1fKOdJWU3v
        599ilC7I+6umq1mD3k7QX2IIlIL4AzgzyQ7Oa9vGH
X-Received: by 2002:a1f:43cc:0:b0:3ab:ad61:bf73 with SMTP id q195-20020a1f43cc000000b003abad61bf73mr5209828vka.33.1666229183969;
        Wed, 19 Oct 2022 18:26:23 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5VqJMndKWdo1ttTzuTTW0GETd8TPEBsQhdsNZ8Ipln45lWhXgKpdKmtP1bjflXLDqOWHirpSJF5Vml3H3EyJQ=
X-Received: by 2002:a1f:43cc:0:b0:3ab:ad61:bf73 with SMTP id
 q195-20020a1f43cc000000b003abad61bf73mr5209819vka.33.1666229183758; Wed, 19
 Oct 2022 18:26:23 -0700 (PDT)
MIME-Version: 1.0
References: <20221018100132.355393-1-zys.zljxml@gmail.com>
In-Reply-To: <20221018100132.355393-1-zys.zljxml@gmail.com>
From:   Ming Lei <ming.lei@redhat.com>
Date:   Thu, 20 Oct 2022 09:26:12 +0800
Message-ID: <CAFj5m9L-=DL-bB9iKRkAdVB+Jjdb5LaF12K1hfj5SCKmii1gXw@mail.gmail.com>
Subject: Re: [PATCH] ublk_drv: use flexible-array member instead of
 zero-length array
To:     zys.zljxml@gmail.com
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yushan Zhou <katrinzhou@tencent.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022 at 6:02 PM <zys.zljxml@gmail.com> wrote:
>
> From: Yushan Zhou <katrinzhou@tencent.com>
>
> Eliminate the following coccicheck warning:
> ./drivers/block/ublk_drv.c:127:16-19: WARNING use flexible-array member instead
>
> Signed-off-by: Yushan Zhou <katrinzhou@tencent.com>
> ---
>  drivers/block/ublk_drv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 2651bf41dde3..5afce6ffaadf 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -124,7 +124,7 @@ struct ublk_queue {
>         bool force_abort;
>         unsigned short nr_io_ready;     /* how many ios setup */
>         struct ublk_device *dev;
> -       struct ublk_io ios[0];
> +       struct ublk_io ios[];
>  };
>
>  #define UBLK_DAEMON_MONITOR_PERIOD     (5 * HZ)

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming

