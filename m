Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9904A652E5A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 10:18:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234546AbiLUJS0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 04:18:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234073AbiLUJSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 04:18:21 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 621B3FCE7
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 01:17:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671614258;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AergAdW6+TgtRXhtnjRDfBqIWsvcGuj5y1ttsyoo6mc=;
        b=TB9kWcwi9ghGmpF3bYE0ggQk8mlWQSTmoo2xSmqgaYy3Ww9sozZlQqgJNYwZ87am4V7JkK
        JZ1iY7C9VJ2uI7+P0xPY9kLhcpKbipSYGgmekFoRzBo82u30w3EHqSYJZbb+joaeSwYNjd
        GkB19Ih/zPDLUfZqIs4aad5vR2CSSWQ=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-556-9IxsV4r9M6CJWiUk5QYaOg-1; Wed, 21 Dec 2022 04:17:37 -0500
X-MC-Unique: 9IxsV4r9M6CJWiUk5QYaOg-1
Received: by mail-ej1-f70.google.com with SMTP id hs18-20020a1709073e9200b007c0f9ac75f9so10036735ejc.9
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 01:17:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AergAdW6+TgtRXhtnjRDfBqIWsvcGuj5y1ttsyoo6mc=;
        b=Fhpm2JiKoJrLI7B9Z0KdKH8w0ZUS3S5UWs2y0p4CrAkOuMlvETU4OICDAeQZ4InJcJ
         yZeAuwRHRezyOsM+9WQzKZ7xp2CchcsILbp4NVnuOehgFICaplelCOC8uOhnKGKxqxmM
         OSqDcx6gsOdFmtlT/Qo0lLiJoaRksowDLra6cRRmbhF3fY/AxV9uNOtpvsVn6T8RKED1
         YzQkNGkWZInmNDr378ssnZ40C6lor8q2mb+b6uQ+eoBDTifPLuuhZ5obDzsUs9IJfhOM
         506tow5WbVgv/QLAGKMJweLrjhqrK/zq9jdM2EKaR5sCCAKzOSlUJNoHgUkaIHNsTphf
         zAIg==
X-Gm-Message-State: AFqh2kr0AvC4E9lAjSkpWsqUtMd4v2jNcv8AY9LOsV+er3oIY6ojFFvI
        a+5I6/MeHkivTxhNRqK/4hv+aUHQfCrKqaWPC8ttsKrdxZtlRVRvivNod4ApdhIaPV2qksveGI9
        TXBFhX8sO8vn/uAn7m+tmYSOd
X-Received: by 2002:a17:907:c28f:b0:83f:5f77:8ff9 with SMTP id tk15-20020a170907c28f00b0083f5f778ff9mr555338ejc.12.1671614256279;
        Wed, 21 Dec 2022 01:17:36 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtsQIsCOCRbzktd3KBHd26Cph4enfdKBy5a5qRXNFpei1bQ8jMMoxgPGhW6LIpdLJz34o1fZA==
X-Received: by 2002:a17:907:c28f:b0:83f:5f77:8ff9 with SMTP id tk15-20020a170907c28f00b0083f5f778ff9mr555327ejc.12.1671614256062;
        Wed, 21 Dec 2022 01:17:36 -0800 (PST)
Received: from sgarzare-redhat (host-87-11-6-51.retail.telecomitalia.it. [87.11.6.51])
        by smtp.gmail.com with ESMTPSA id ch16-20020a170906c2d000b0079e11b8e891sm6677651ejb.125.2022.12.21.01.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Dec 2022 01:17:35 -0800 (PST)
Date:   Wed, 21 Dec 2022 10:17:32 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     mst@redhat.com, eperezma@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vdpa_sim: use weak barriers
Message-ID: <20221221091732.gvc724dnq2ntza7g@sgarzare-redhat>
References: <20221221062146.15356-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20221221062146.15356-1-jasowang@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 21, 2022 at 02:21:46PM +0800, Jason Wang wrote:
>vDPA simulators are software emulated device, so let's switch to use
>weak barriers to avoid extra overhead in the driver.
>
>Signed-off-by: Jason Wang <jasowang@redhat.com>
>---
> drivers/vdpa/vdpa_sim/vdpa_sim.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

I was going to propose the same :-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
>index b071f0d842fb..eeaeaf43b476 100644
>--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
>+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
>@@ -68,7 +68,7 @@ static void vdpasim_queue_ready(struct vdpasim *vdpasim, unsigned int idx)
> 	struct vdpasim_virtqueue *vq = &vdpasim->vqs[idx];
>
> 	vringh_init_iotlb(&vq->vring, vdpasim->dev_attr.supported_features,
>-			  VDPASIM_QUEUE_MAX, false,
>+			  VDPASIM_QUEUE_MAX, true,
> 			  (struct vring_desc *)(uintptr_t)vq->desc_addr,
> 			  (struct vring_avail *)
> 			  (uintptr_t)vq->driver_addr,
>-- 
>2.25.1
>

