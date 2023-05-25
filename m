Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 840C6710F55
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 17:18:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241732AbjEYPSa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 11:18:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233538AbjEYPS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 11:18:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1664E98
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 08:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685027865;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fOUzguOOu1eni0hOPBESb2FaTGC+gEEK2fy0+NLRd2Y=;
        b=a/742ry9r0lLvK8ERgjUlTwe2l4RJHJP/4RhRKbC/l4KRp1ud1GawS3hGRe42OzIC9WT9h
        gZbjZpFS/l9E/M6u8N0fMM6uCOzDoglx6a4bmqo1DGLbnft5JhidfSqpgG9RcPbQvBkyGE
        HL8UF7O2FrdZbecBg6w0kifuMYm1sDA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587--50MNHoFOo2WRg_ymbLqZA-1; Thu, 25 May 2023 11:17:41 -0400
X-MC-Unique: -50MNHoFOo2WRg_ymbLqZA-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-30953bcb997so858498f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 08:17:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685027860; x=1687619860;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fOUzguOOu1eni0hOPBESb2FaTGC+gEEK2fy0+NLRd2Y=;
        b=CpGBuvquz9oh1AZmePUqd3DiQkDGd5VwGZoxowFssRFKc3Fp1EdW9sAsv7w24lj72m
         T8Ok5tkAMXMv3osT++QGDdBqPSUW0X3bb9Wjwmi1m/ihc/kA85VZmEV02nV5AGt2dLzG
         67qzjjPS6aUZDh5uQzCxnve4TLvwjzb72aG6uEEG7OUFGyHpyfnSF1MnQ4HkfkhNmb52
         t8Jhugp/+5gbYyQvfTuLoplmJKrGkym4RHF8jldhiYlJTA6UP/UnCnlOfQmwtwhrdpJP
         fJjcIiSMMmSXZjcv/4kcO9N4J8mfHrDWEl9s9PBOw0CSKtDTctd+9Ff+rdGHwXnTLYt/
         L3Mw==
X-Gm-Message-State: AC+VfDzbjl/URhZIEOAC/onXeayaSRSOi5wHoNQHqNI2EwtC1c6A3dIR
        TtUJKZ43wSqkPMWBu/CbsccruGSzuFJr7S15ft0X/0LWNJSSvWFCDntOEIYYAxP4+mRkLWfQvXI
        MRGjVh19J2JpzHKNwVmjsLtPr
X-Received: by 2002:a5d:4212:0:b0:2ef:ba4f:c821 with SMTP id n18-20020a5d4212000000b002efba4fc821mr2822695wrq.36.1685027860657;
        Thu, 25 May 2023 08:17:40 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6u2bAg+oYFeJ8M2WSKlZ3Xymkov7A3BUBv/G/uJks2LTYCIXu75pDamPUph1Z92vbUzEybCA==
X-Received: by 2002:a5d:4212:0:b0:2ef:ba4f:c821 with SMTP id n18-20020a5d4212000000b002efba4fc821mr2822672wrq.36.1685027860264;
        Thu, 25 May 2023 08:17:40 -0700 (PDT)
Received: from sgarzare-redhat ([217.171.68.36])
        by smtp.gmail.com with ESMTPSA id g12-20020a5d488c000000b003090cb7a9e6sm2104222wrq.31.2023.05.25.08.17.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 08:17:39 -0700 (PDT)
Date:   Thu, 25 May 2023 17:17:36 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Simon Horman <horms@kernel.org>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] virtio: Add missing documentation for structure fields
Message-ID: <xjns5ktnvejnlze6viube6qzxs4fd5fb5trpvqpip2rlrvift4@utwfddrxavxw>
References: <20230510-virtio-kdoc-v3-1-e2681ed7a425@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230510-virtio-kdoc-v3-1-e2681ed7a425@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 25, 2023 at 04:35:42PM +0200, Simon Horman wrote:
>Add missing documentation for the vqs_list_lock field of struct virtio_device,
>and the validate field of struct virtio_driver.
>
>./scripts/kernel-doc says:
>
> .../virtio.h:131: warning: Function parameter or member 'vqs_list_lock' not described in 'virtio_device'
> .../virtio.h:192: warning: Function parameter or member 'validate' not described in 'virtio_driver'
> 2 warnings as Errors
>
>No functional changes intended.
>
>Signed-off-by: Simon Horman <horms@kernel.org>
>---
>Changes in v3:
>- As suggested by Stefano Garzarella
>  + Drop inline comment for @vqs_list_lock which is now covered by Kdoc
>  + Add "Returns 0 or -errno." to @validate Kdoc
>- Link to v2: https://lore.kernel.org/r/20230510-virtio-kdoc-v2-1-1c5a20eb4cfe@kernel.org
>
>Changes in v2:
>- As suggested by Michael S. Tsirkin
>  + @validate is not called on probe
>  + @validate does validates config space
>  + embarrassingly, validate was misspelt
>- Link to v1: https://lore.kernel.org/r/20230510-virtio-kdoc-v1-1-d2b1824a9a2b@kernel.org
>---
> include/linux/virtio.h | 5 ++++-
> 1 file changed, 4 insertions(+), 1 deletion(-)
>
>diff --git a/include/linux/virtio.h b/include/linux/virtio.h
>index b93238db94e3..de6041deee37 100644
>--- a/include/linux/virtio.h
>+++ b/include/linux/virtio.h
>@@ -103,6 +103,7 @@ int virtqueue_resize(struct virtqueue *vq, u32 num,
>  * @config_enabled: configuration change reporting enabled
>  * @config_change_pending: configuration change reported while disabled
>  * @config_lock: protects configuration change reporting
>+ * @vqs_list_lock: protects @vqs.
>  * @dev: underlying device.
>  * @id: the device type identification (used to match it with a driver).
>  * @config: the configuration ops for this device.
>@@ -117,7 +118,7 @@ struct virtio_device {
> 	bool config_enabled;
> 	bool config_change_pending;
> 	spinlock_t config_lock;
>-	spinlock_t vqs_list_lock; /* Protects VQs list access */
>+	spinlock_t vqs_list_lock;
> 	struct device dev;
> 	struct virtio_device_id id;
> 	const struct virtio_config_ops *config;
>@@ -160,6 +161,8 @@ size_t virtio_max_dma_size(const struct virtio_device *vdev);
>  * @feature_table_size: number of entries in the feature table array.
>  * @feature_table_legacy: same as feature_table but when working in legacy mode.
>  * @feature_table_size_legacy: number of entries in feature table legacy array.
>+ * @validate: the function to call to validate features and config space.
>+ *            Returns 0 or -errno.
>  * @probe: the function to call when a device is found.  Returns 0 or -errno.
>  * @scan: optional function to call after successful probe; intended
>  *    for virtio-scsi to invoke a scan.
>

LGTM!

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks,
Stefano

