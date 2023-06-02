Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0253972011D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 14:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235683AbjFBMHH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 08:07:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234948AbjFBMHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 08:07:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A104E1A8
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 05:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685707581;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=r3eog2jJ180dc325mkmwjwsvnRZJ4iih8R1ZCYZSotw=;
        b=VfG2TzGyRPPWFBxHHyrLo7lyl8B6COm32M4E5qjbUqDNMQ3louEodLQmrPo/NMHyy3k/mV
        fAMc43oYFLNBmZe4ciul8AYyhzlgPEzlyrQcM12G3Lev+9IhMMOiHf7IMtBtWUoQox1mZF
        TmZKWuDQgZ5jG5vi3bmxNYDC0wvlOhA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-XIAyvuhCO4GpV2rR6lIOKQ-1; Fri, 02 Jun 2023 08:06:20 -0400
X-MC-Unique: XIAyvuhCO4GpV2rR6lIOKQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3f603b8eb61so11566775e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 05:06:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685707579; x=1688299579;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r3eog2jJ180dc325mkmwjwsvnRZJ4iih8R1ZCYZSotw=;
        b=MWmWIEVqMm8yJTw31cFd30CtncwhMlvq+rYbuUrF4pmxZ4Mq9jrCEdzpQrAf9qrHKS
         hHeK9Bjlr/qmPevnBqAN6TWJCG98HUosgMp2tiYEy+ajepSBykDv7FSlyppBJPuK8oeL
         FNfsF9uXTaO9lZKpGdLEhgyMIG1uhcc90/6d3W3VV+9rk25LumLRaJFBCuop9lZJQ9r4
         cXvYgNja+oahnWI/Xchxy9m/gvzw6P6hPEwnSeaG4kDOAxK0PhrZELSzCs1Q3iUyUpkF
         2xa1xsi0CGSM48zWOEGKte8NKHIlaNeGQ9jk4wl1ZqiEcSAm6tC0tiexktX7xInZtx+8
         sZyQ==
X-Gm-Message-State: AC+VfDxyM8G7dSsDb+3Djviqleax79PsCLiJPtXBCQ64t8GpVseTjbqF
        sxb3xJGge7eVDBV/gLrpVzDFXbYYGPbPQx2XQL8bJkAlUohaMhmBQgVVmcqnqHoWtgPKV67AY4i
        /IHjm55U/2V4dO8PMQtG2E+iYW9h2c/Rb
X-Received: by 2002:a1c:6a15:0:b0:3f6:89e:2716 with SMTP id f21-20020a1c6a15000000b003f6089e2716mr1982211wmc.33.1685707579183;
        Fri, 02 Jun 2023 05:06:19 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5208596q5G59Oc8rJfdmFIY+/Vvnx/JmMv3Fx9NDu17J8RLqtPrBw/B/kjXPHSnF2ttJ7m/A==
X-Received: by 2002:a1c:6a15:0:b0:3f6:89e:2716 with SMTP id f21-20020a1c6a15000000b003f6089e2716mr1982190wmc.33.1685707578902;
        Fri, 02 Jun 2023 05:06:18 -0700 (PDT)
Received: from redhat.com ([2.55.4.169])
        by smtp.gmail.com with ESMTPSA id y20-20020a05600c365400b003f60a446fe5sm1760836wmq.29.2023.06.02.05.06.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 05:06:18 -0700 (PDT)
Date:   Fri, 2 Jun 2023 08:06:15 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH] scsi: virtio_scsi: Remove a useless function call
Message-ID: <20230602080607-mutt-send-email-mst@kernel.org>
References: <08740635cdb0f8293e57c557b22e048daae50961.1685345683.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08740635cdb0f8293e57c557b22e048daae50961.1685345683.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 29, 2023 at 09:35:08AM +0200, Christophe JAILLET wrote:
> 'inq_result' is known to be NULL. There is no point calling kfree().
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  drivers/scsi/virtio_scsi.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/scsi/virtio_scsi.c b/drivers/scsi/virtio_scsi.c
> index 58498da9869a..bd5633667d01 100644
> --- a/drivers/scsi/virtio_scsi.c
> +++ b/drivers/scsi/virtio_scsi.c
> @@ -338,10 +338,8 @@ static int virtscsi_rescan_hotunplug(struct virtio_scsi *vscsi)
>  	int result, inquiry_len, inq_result_len = 256;
>  	char *inq_result = kmalloc(inq_result_len, GFP_KERNEL);
>  
> -	if (!inq_result) {
> -		kfree(inq_result);
> +	if (!inq_result)
>  		return -ENOMEM;
> -	}
>  
>  	shost_for_each_device(sdev, shost) {
>  		inquiry_len = sdev->inquiry_len ? sdev->inquiry_len : 36;
> -- 
> 2.34.1

