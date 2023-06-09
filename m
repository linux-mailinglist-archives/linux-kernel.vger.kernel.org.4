Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B909B729FCF
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 18:14:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242079AbjFIQOK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 12:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242100AbjFIQOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 12:14:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B52930CD
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 09:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686327202;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0D0fx1mFB/JV/q+hvvzbZ4BbnjjH4XlfjQ5soZ7CGmE=;
        b=D8S7a501JNFuJdUf0CSInZL7Pme5X0QodUWsUfwJYD62fFeAZwyqtRDYAW76bEBTzATnxX
        RefTsHQxSeqIpeimeMo+naH3y8JoCftroQTmKkpJnbmA9ni6VumO3ckoS7PRqtQDTQdoeS
        pbQ/DmePAM6lXX7it15JPa+IeEpRjPE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-74-HQ0UZGBsP5CbGgV1YBJFjw-1; Fri, 09 Jun 2023 12:13:21 -0400
X-MC-Unique: HQ0UZGBsP5CbGgV1YBJFjw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3f7ef0e0292so7521825e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 09:13:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686327200; x=1688919200;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0D0fx1mFB/JV/q+hvvzbZ4BbnjjH4XlfjQ5soZ7CGmE=;
        b=UkSaNNA0zLpWk0b/ioIUfvhpsU1leOjwFSRdSymIfPkpXjKpbPH6QGq1gJIO3DkSnD
         heXVwMHvYzaFnYjaj7WM3QZBTdp+sFDAAwQWXksVqaEI1Tf8Sfsx2fCGiO2cltJpSdg2
         kV4/HCZ46g4UnP62i/nt3OaJOmJYAB/HN9eIk5xNM5U+aHDf68AFx/Zr6WzZ8A5xd0DL
         q27ok0acxQUmtv8hPRXf2NtRro5nrTy2imwl/uGnjCNpSpw/F32Lza2iI8otE1M9XZkx
         oXn/VZ4ntY6iY24Tgd31QhhWBufszGHn37jP8gDFHi/j1gFCNv1Y+DkYjIZRquAz05Ek
         z4GA==
X-Gm-Message-State: AC+VfDxsM4zYhTvbFQGcTWZvVQbAV2T7yEwRSeD83YoUH2ADNN2g7Cys
        8wM35I9Hyvk+TpP8TWExfiMQHVBY53wivoO4HPsrwWjtUKsT4mg9ZOUMmmJ8VTJ0UNjwASsyTmh
        k84UAN73+xqVXePIghXc+Q36a
X-Received: by 2002:a1c:7903:0:b0:3f5:60b:33 with SMTP id l3-20020a1c7903000000b003f5060b0033mr1210772wme.5.1686327199939;
        Fri, 09 Jun 2023 09:13:19 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6PvTuWonpbAPcqcGK+Qy57af6UFWRA4xTXacgkC8KC6k77AUEeUdQkIRV+Tm1Yn4p/8VPllg==
X-Received: by 2002:a1c:7903:0:b0:3f5:60b:33 with SMTP id l3-20020a1c7903000000b003f5060b0033mr1210743wme.5.1686327199617;
        Fri, 09 Jun 2023 09:13:19 -0700 (PDT)
Received: from redhat.com ([2a06:c701:7403:2800:22a6:7656:500:4dab])
        by smtp.gmail.com with ESMTPSA id f26-20020a1c6a1a000000b003f7ea771b5dsm3187488wmc.1.2023.06.09.09.13.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 09:13:19 -0700 (PDT)
Date:   Fri, 9 Jun 2023 12:13:15 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        Zhu Lingshan <lingshan.zhu@intel.com>,
        virtualization@lists.linux-foundation.org,
        "Gonglei (Arei)" <arei.gonglei@huawei.com>, longpeng2@huawei.com,
        Lei Yang <leiyang@redhat.com>,
        Parav Pandit <parav@mellanox.com>,
        Gautam Dawar <gdawar@xilinx.com>,
        Dragos Tatulea <dtatulea@nvidia.com>,
        Laurent Vivier <lvivier@redhat.com>, linux-api@vger.kernel.org,
        Liuxiangdong <liuxiangdong5@huawei.com>,
        linux-kernel@vger.kernel.org, alvaro.karsz@solid-run.com,
        Shannon Nelson <snelson@pensando.io>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Cindy Lu <lulu@redhat.com>, si-wei.liu@oracle.com,
        Harpreet Singh Anand <hanand@xilinx.com>
Subject: Re: [PATCH v2 2/4] vdpa: accept
 VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK backend feature
Message-ID: <20230609121244-mutt-send-email-mst@kernel.org>
References: <20230609092127.170673-1-eperezma@redhat.com>
 <20230609092127.170673-3-eperezma@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230609092127.170673-3-eperezma@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 09, 2023 at 11:21:25AM +0200, Eugenio Pérez wrote:
> Accepting VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK backend feature if
> userland sets it.
> 
> Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
> Acked-by: Shannon Nelson <shannon.nelson@amd.com>

I don't get it, so all vdpa devices accept this automatically?
Should this not be up to the parent?

> ---
>  drivers/vhost/vdpa.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index bf77924d5b60..a3204406b73d 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -680,7 +680,8 @@ static long vhost_vdpa_unlocked_ioctl(struct file *filep,
>  			return -EFAULT;
>  		if (features & ~(VHOST_VDPA_BACKEND_FEATURES |
>  				 BIT_ULL(VHOST_BACKEND_F_SUSPEND) |
> -				 BIT_ULL(VHOST_BACKEND_F_RESUME)))
> +				 BIT_ULL(VHOST_BACKEND_F_RESUME) |
> +				 BIT_ULL(VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK)))
>  			return -EOPNOTSUPP;
>  		if ((features & BIT_ULL(VHOST_BACKEND_F_SUSPEND)) &&
>  		     !vhost_vdpa_can_suspend(v))
> -- 
> 2.31.1

