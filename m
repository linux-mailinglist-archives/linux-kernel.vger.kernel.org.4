Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C05B67E1D7
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 11:39:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232070AbjA0KjM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 05:39:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232009AbjA0KjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 05:39:08 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1499F187
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 02:38:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674815882;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Fk+ipPxiMp+7ND5JXMDPhtIXGWCz80q2gfmOrGgnSTs=;
        b=HWQcggqNbcisc8AY3YbZoncFRez29VAQzrTqw9ckpeVqZtPABqjY8pyMZEdC31La6rpmIP
        s8Ylc6eLvm8vRkh+Fn4Y23AwvgW2o/NkuVfMi7nzeOqpPhm+7gHKLneHNuiBpx4svcpAGy
        HEu5jIjyr2WrMQVKQNJY4clc/yl62Cg=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-304-XDLmjfr0O5iOuqP4GLuw9g-1; Fri, 27 Jan 2023 05:38:01 -0500
X-MC-Unique: XDLmjfr0O5iOuqP4GLuw9g-1
Received: by mail-ed1-f71.google.com with SMTP id y20-20020a056402271400b0046c9a6ec30fso3304540edd.14
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 02:38:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fk+ipPxiMp+7ND5JXMDPhtIXGWCz80q2gfmOrGgnSTs=;
        b=v/JgEIRwYT3LeiNNYldFDztltiBmQPfIH52nVEbCdGfKpo5e3qn6zykoht/0o+gK02
         lTbbDq3p28rR0/A76q4pWatM6R0CiHSCOCbM4b8kLuvxozlPzCzOQf23Ui+aolUhLYov
         qsCDHHgRu8AmTLa14G0g4uSVJX6GodxAat3LPSetf8dSFF7r+CS0jNZywFTQcXEiLWQe
         DtplKTcKD56EmXLwMCK484mVLjsm7qZ4vcNoMBs7nIjI2sX0eQZuzFt6CvlD04CSCZcv
         nDiqJ2rj484PZ2MJJtQCgDHYyLzPLX6trbODstSUU0uoXhFWIqo2OSHDMpTVkQG+WsIb
         T/ow==
X-Gm-Message-State: AFqh2kpPDFhv361Qu5I68+nuHwgbDcko4xLx+3gAuWgnszcij+8cor1t
        j9bB95f1ua5/cn38VftApdJcI4FKUJ2VScs3agsaBlw7j8efSjsKAI7QFqfFjfNi3m2eE/wVo0n
        FcLzHUcjc5nCuNEGNmRt+qJIT
X-Received: by 2002:a05:6402:27d3:b0:499:b3db:6aa3 with SMTP id c19-20020a05640227d300b00499b3db6aa3mr51028703ede.1.1674815879204;
        Fri, 27 Jan 2023 02:37:59 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuCkhc1dIvkqg7CLSpA28ZBiD86VH7jdYHoje2OT9EaPm8dwEocuWCHOEbV3Rx+p6Me5lkY1Q==
X-Received: by 2002:a05:6402:27d3:b0:499:b3db:6aa3 with SMTP id c19-20020a05640227d300b00499b3db6aa3mr51028689ede.1.1674815878988;
        Fri, 27 Jan 2023 02:37:58 -0800 (PST)
Received: from redhat.com ([2.52.137.69])
        by smtp.gmail.com with ESMTPSA id k20-20020a508ad4000000b004873927780bsm751419edk.20.2023.01.27.02.37.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 02:37:58 -0800 (PST)
Date:   Fri, 27 Jan 2023 05:37:55 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Tanmay Bhushan <007047221b@gmail.com>
Cc:     Zhu Lingshan <lingshan.zhu@intel.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vdpa: ifcvf: Do proper cleanup if IFCVF init fails
Message-ID: <20230127053731-mutt-send-email-mst@kernel.org>
References: <772e9fe133f21fa78fb98a2ebe8969efbbd58e3c.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <772e9fe133f21fa78fb98a2ebe8969efbbd58e3c.camel@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 27, 2022 at 10:15:25PM +0100, Tanmay Bhushan wrote:
> >From 7eae04667ddaac8baa4812d48ef2c942cedef946 Mon Sep 17 00:00:00 2001
> From: Tanmay Bhushan <007047221b@gmail.com>
> Date: Tue, 27 Dec 2022 22:02:16 +0100
> Subject: [PATCH] vdpa: ifcvf: Do proper cleanup if IFCVF init fails
> 
> ifcvf_mgmt_dev leaks memory if it is not freed before
> returning. Call is made to correct return statement
> so memory does not leak. ifcvf_init_hw does not take
> care of this so it is needed to do it here.
> 
> Signed-off-by: Tanmay Bhushan <007047221b@gmail.com>
> ---
>  drivers/vdpa/ifcvf/ifcvf_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c
> b/drivers/vdpa/ifcvf/ifcvf_main.c
> index f9c0044c6442..44b29289aa19 100644
> --- a/drivers/vdpa/ifcvf/ifcvf_main.c
> +++ b/drivers/vdpa/ifcvf/ifcvf_main.c
> @@ -849,7 +849,7 @@ static int ifcvf_probe(struct pci_dev *pdev, const
> struct pci_device_id *id)

BTW your patch was mangled but I fixed it.

>  	ret = ifcvf_init_hw(vf, pdev);
>  	if (ret) {
>  		IFCVF_ERR(pdev, "Failed to init IFCVF hw\n");
> -		return ret;
> +		goto err;
>  	}
>  
>  	for (i = 0; i < vf->nr_vring; i++)
> -- 
> 2.34.1
> 

