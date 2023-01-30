Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 019F968140D
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 16:05:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235183AbjA3PFV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 10:05:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237540AbjA3PFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 10:05:18 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0A9D17140
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 07:04:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675091066;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AHzUAFOISigJSuZLYSE9gYkWGGTM6t11vLNDnydgJJc=;
        b=a1vaLtZyLfqrReFBHXnQUgoGowgcfcFzpzCdLhmg6xfnaP6mq2QfNMURpR1/DWxgn5eIAt
        mEGwOclb2axLTvo1YjexKPfBwXhG6uapreTFrp0tFWeQHtkycNQuajqmxwe9x6vLF2oj/U
        iP1AQgSQOK+f02Z4VLk7VTqYKfqBZX0=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-248-W8kX_6flOxWd1VbMQlJeOw-1; Mon, 30 Jan 2023 10:04:23 -0500
X-MC-Unique: W8kX_6flOxWd1VbMQlJeOw-1
Received: by mail-qv1-f72.google.com with SMTP id px22-20020a056214051600b00537657b0449so6663922qvb.23
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 07:04:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AHzUAFOISigJSuZLYSE9gYkWGGTM6t11vLNDnydgJJc=;
        b=mcCE3b0ftNPWpdedJbvsUZ1Z53Z9GKQhWzuBPiYsDKiXMQJJn7w0HTOYaguE8f1Rzz
         Ra4K4aNsa9d5Fua3XtEh0O7YI2g1IaJTSeXypOOs4lg6fZwsnEle/1K2rkffzRuQ6Fr8
         5hdezav19v0FuRORMb1yMjzr90ryJJY72bJEKEtn9kI89mprGxd5casPMFbHpKqSTBpS
         qydt/5v3KlwnVs477FYSAmGirDVeZWrom+6FOlnLmZu9YF26GyhRJAubk77Pj10xZdHB
         LvUyN4h6NjHs+wOccKHLgrXQotC2EwjluTuRWNwYFufEBH3+AOa6NzXFfZW8tCxgcNDo
         E6uA==
X-Gm-Message-State: AO0yUKXWS5oU2+hRdY3/a7AQgJEUkosab7YIx48FDwXIUbYGlfZJHvsv
        CsRkhpxB9igAukPSvwuDyAPaNxsqR1xKqOtBuD92MgJovaVvVr4Vh1Q5gUR39pcsFH4p6ftCYVi
        FnF1n0Aca90hLXo3yk+dXvXRI
X-Received: by 2002:ac8:5ccf:0:b0:3b8:6aaf:acfe with SMTP id s15-20020ac85ccf000000b003b86aafacfemr4750206qta.38.1675091062951;
        Mon, 30 Jan 2023 07:04:22 -0800 (PST)
X-Google-Smtp-Source: AK7set9YJRIkiVvinAoDC8719oWhQC2COIk00xm3Dl23OMFlPho0p5nFr66Bab8WpRnJVguTUiT25Q==
X-Received: by 2002:ac8:5ccf:0:b0:3b8:6aaf:acfe with SMTP id s15-20020ac85ccf000000b003b86aafacfemr4750176qta.38.1675091062547;
        Mon, 30 Jan 2023 07:04:22 -0800 (PST)
Received: from jsavitz-csb (c-98-229-96-5.hsd1.ct.comcast.net. [98.229.96.5])
        by smtp.gmail.com with ESMTPSA id b1-20020ac85bc1000000b003b6325dfc4esm8246094qtb.67.2023.01.30.07.04.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 07:04:21 -0800 (PST)
Date:   Mon, 30 Jan 2023 10:04:19 -0500
From:   Joel Savitz <jsavitz@redhat.com>
To:     Jongwoo Han <jongwooo.han@gmail.com>
Cc:     f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        gregkh@linuxfoundation.org, linux-rpi-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vc04_services: mmal-vchiq: fix typo in comment
Message-ID: <20230130150419.GA1268781@jsavitz-csb>
References: <20230130145400.40890-1-jongwooo.han@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230130145400.40890-1-jongwooo.han@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 30, 2023 at 11:54:00PM +0900, Jongwoo Han wrote:
> Signed-off-by: Jongwoo Han <jongwooo.han@gmail.com>
> ---
>  drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
> index 294b184d4..e318f3609 100644
> --- a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
> +++ b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
> @@ -245,7 +245,7 @@ static void event_to_host_cb(struct vchiq_mmal_instance *instance,
>  /* workqueue scheduled callback
>   *
>   * we do this because it is important we do not call any other vchiq
> - * sync calls from witin the message delivery thread
> + * sync calls from within the message delivery thread
>   */
>  static void buffer_work_cb(struct work_struct *work)
>  {
> -- 
> 2.34.1
> 
> 
> _______________________________________________
> linux-rpi-kernel mailing list
> linux-rpi-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rpi-kernel
> 
Acked-by: Joel Savitz <jsavitz@redhat.com>

