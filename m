Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64CFA694580
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 13:12:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231226AbjBMML7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 07:11:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230332AbjBMMLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 07:11:07 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0692C35AE
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 04:10:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676290206;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3mEYzxx/bkDFLt7byV5MhD22WdETXrhwLYc+g6bKb6Q=;
        b=RudnBp4Y6Y9vW4gYLAnxOgdLCQw011jRCPKyC+BBTC2fTXiiy95J5a6N+G4LtKVqCGjLYC
        YNoKnNzsh3w4i8rQ0B5gxQyVO4LvY68IgHFvlVafM49tvQQRkickjsCVKfGl4wUn1T/IJw
        wCrjqRiE4mW+qQ4Xjcr5J/DiFSf7A+A=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-374-vVG_VysvPQq8abdpHdPnjw-1; Mon, 13 Feb 2023 07:09:57 -0500
X-MC-Unique: vVG_VysvPQq8abdpHdPnjw-1
Received: by mail-ej1-f72.google.com with SMTP id qn8-20020a170907210800b0088eda544bd6so7551043ejb.11
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 04:09:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3mEYzxx/bkDFLt7byV5MhD22WdETXrhwLYc+g6bKb6Q=;
        b=LC1Nt3QGZaJ+oX0hUOxt6WNMZRF7Dg26wOvI0jsmFtPm1ZoSxOD4uQj1qNBsqsz2ut
         LF50Vojsf/+woZyBUCffRCzDolbzbtUK4xB383l74TPd6xO1khdD8zgo7cL66CS5xqY2
         BckATanxBbF/ZkL5k7Uv7XU9aRKWDf30t67QMFcMzjkXCrijq8gg1ATUo7p9L9jeqnPX
         FRkeyJzZc28eVDKMGy2mhMzRJ/6r6eQMc6O5ZDQqGU+hP+UTOZsT+yUFeUz6rqYNA6+I
         H+4GLjq5CX3pi4vCi6TjyE9wImuHmRgLJqqzXBIqPqUhorJ7LGmarG4naNIZ05b9w+pr
         7gbA==
X-Gm-Message-State: AO0yUKV7bBVUUQficmgyjWAFwaM1R9RyCu7lYRzuTdbHaCILw1V4qu5a
        qgjqmCLgWOL43fCvFtcKDdqGEqJ7UiKROC1HX59/9tD1vwV3ACnpwNTAF6+4/gt/ckl0q3AczMO
        hqpCTGoZxOu2HSpDabOJ/+ISy
X-Received: by 2002:a17:906:1286:b0:886:50d:be8d with SMTP id k6-20020a170906128600b00886050dbe8dmr26816168ejb.13.1676290196340;
        Mon, 13 Feb 2023 04:09:56 -0800 (PST)
X-Google-Smtp-Source: AK7set/LVnxEG3I8rnVK7885EnaICcxb+lvhiOf/rZbS+wU3TNmlvfBa8qzgmQnMIPHWTVKERIaRaw==
X-Received: by 2002:a17:906:1286:b0:886:50d:be8d with SMTP id k6-20020a170906128600b00886050dbe8dmr26816157ejb.13.1676290196155;
        Mon, 13 Feb 2023 04:09:56 -0800 (PST)
Received: from redhat.com ([2.52.132.212])
        by smtp.gmail.com with ESMTPSA id l26-20020a170906079a00b008966488a5f1sm6757478ejc.144.2023.02.13.04.09.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 04:09:55 -0800 (PST)
Date:   Mon, 13 Feb 2023 07:09:50 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Zheng Wang <zyytlz.wz@163.com>
Cc:     hackerzheng666@gmail.com, jasowang@redhat.com, pbonzini@redhat.com,
        stefanha@redhat.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com,
        virtualization@lists.linux-foundation.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        security@kernel.org, alex000young@gmail.com
Subject: Re: [PATCH v2] scsi: virtio_scsi: Fix poential NULL pointer
 dereference in  virtscsi_rescan_hotunplug
Message-ID: <20230213070906-mutt-send-email-mst@kernel.org>
References: <20230202064124.22277-1-zyytlz.wz@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230202064124.22277-1-zyytlz.wz@163.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 02, 2023 at 02:41:24PM +0800, Zheng Wang wrote:
> There is no check about the return value of kmalloc in
> virtscsi_rescan_hotunplug. Add the check to avoid use
> of null pointer 'inq_result' in case of the failure
> of kmalloc.
> 
> Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
> ---

I fixed a typo in subject and tweaked the patch a bit

> v2:
> - add kfree to avoid memory leak
> ---
>  drivers/scsi/virtio_scsi.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/scsi/virtio_scsi.c b/drivers/scsi/virtio_scsi.c
> index d07d24c06b54..a66d8815d738 100644
> --- a/drivers/scsi/virtio_scsi.c
> +++ b/drivers/scsi/virtio_scsi.c
> @@ -330,7 +330,7 @@ static void virtscsi_handle_param_change(struct virtio_scsi *vscsi,
>  	scsi_device_put(sdev);
>  }
>  
> -static void virtscsi_rescan_hotunplug(struct virtio_scsi *vscsi)
> +static int virtscsi_rescan_hotunplug(struct virtio_scsi *vscsi)
>  {
>  	struct scsi_device *sdev;
>  	struct Scsi_Host *shost = virtio_scsi_host(vscsi->vdev);
> @@ -338,6 +338,11 @@ static void virtscsi_rescan_hotunplug(struct virtio_scsi *vscsi)
>  	int result, inquiry_len, inq_result_len = 256;
>  	char *inq_result = kmalloc(inq_result_len, GFP_KERNEL);
>  
> +	if (!inq_result) {
> +		kfree(inq_result);
> +		return -ENOMEM;
> +	}
> +
>  	shost_for_each_device(sdev, shost) {
>  		inquiry_len = sdev->inquiry_len ? sdev->inquiry_len : 36;
>  
> @@ -366,6 +371,7 @@ static void virtscsi_rescan_hotunplug(struct virtio_scsi *vscsi)
>  	}
>  
>  	kfree(inq_result);
> +	return 0;
>  }
>  
>  static void virtscsi_handle_event(struct work_struct *work)
> @@ -374,12 +380,15 @@ static void virtscsi_handle_event(struct work_struct *work)
>  		container_of(work, struct virtio_scsi_event_node, work);
>  	struct virtio_scsi *vscsi = event_node->vscsi;
>  	struct virtio_scsi_event *event = &event_node->event;
> +	int ret = 0;
>

dropped = 0 here
  
>  	if (event->event &
>  	    cpu_to_virtio32(vscsi->vdev, VIRTIO_SCSI_T_EVENTS_MISSED)) {

and moved declaration here.

>  		event->event &= ~cpu_to_virtio32(vscsi->vdev,
>  						   VIRTIO_SCSI_T_EVENTS_MISSED);
> -		virtscsi_rescan_hotunplug(vscsi);
> +		ret = virtscsi_rescan_hotunplug(vscsi);
> +		if (ret)
> +			return;
>  		scsi_scan_host(virtio_scsi_host(vscsi->vdev));
>  	}
>  
> -- 
> 2.25.1
> 
> 

