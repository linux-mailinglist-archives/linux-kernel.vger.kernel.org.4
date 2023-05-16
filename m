Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70361704842
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 10:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231435AbjEPIzp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 04:55:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230408AbjEPIzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 04:55:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF21FEC
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 01:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684227299;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Eq/mJ6TAAxJjl7zNrtuDiAJaf9k+xodjW5Fgf6CgBUc=;
        b=a2SL57+dRf6+KEzdZxslngrwhszXpUDDrkd9uZkeLxbmOO9d4JvAEm7eRT8+tYSCSwtnyq
        XPPej0u6yHvd2o0JIeqG9sT2oRSiaxSOyFqYpdCE7hIM0ebwKoZAsvK/6rFNz0764FK7AY
        eAqqZaSecvNwYa7B83j/0Sk1HgJCuxc=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-HmOYOA-YOYGujKMZxKK9aA-1; Tue, 16 May 2023 04:54:57 -0400
X-MC-Unique: HmOYOA-YOYGujKMZxKK9aA-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-758ae5c9494so998401585a.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 01:54:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684227297; x=1686819297;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Eq/mJ6TAAxJjl7zNrtuDiAJaf9k+xodjW5Fgf6CgBUc=;
        b=SEHJ1XqBYg8ouXizOrQJKmJr0Q0i6YEclFEU2X66/uhYY1dv0mw25I8uJBuUUUHtP9
         5ZSVQ/w6g+IXBsUbcEkPOOTVlOYxTvh8pJSlI/psxnLoHhDQc12rxHC+vivmiNmGpptO
         r+l/Z1hiMmxKpgquxNvxYCavBgvThPQMq2uHc2SJD8hKulN/cOTY+VVux9saQ/9rRki6
         RjtaVnyct47sTP4iGhLYyJvsrGNfo6hZlpJHs1lQTsuD1M1M8LEnEPCgBjKVesn0Zi99
         b0HC3Se8WSZS8X+YkgUB0Cv089YpPyaMyqvewB+T5tO3q89NDycdzapJAfYYN44vO+CH
         rq/A==
X-Gm-Message-State: AC+VfDzIiqb97bF8U4m94Lv/7CZo+RG7k+gbnl31g66B3BnADa0w63EG
        szJOwMQXplsPLTbmtpuq4AjjYHxXs11e1VEhHRHHk1CZTSh8nZlTkYzgD7F55SHXsLg1CzFABdV
        sZzl3hM1088h17muSqxm8eoULLbH6omBoIBg=
X-Received: by 2002:a05:622a:1209:b0:3ef:2649:44ae with SMTP id y9-20020a05622a120900b003ef264944aemr58730391qtx.13.1684227296801;
        Tue, 16 May 2023 01:54:56 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5D9o1sGj4fhdU2O4/61znCNopICXE8BhGEHjhbqI5WM+IEL+ulBtWf2tSFOkkGS6Bw6+fuOw==
X-Received: by 2002:a05:622a:1209:b0:3ef:2649:44ae with SMTP id y9-20020a05622a120900b003ef264944aemr58730380qtx.13.1684227296564;
        Tue, 16 May 2023 01:54:56 -0700 (PDT)
Received: from sgarzare-redhat (c-115-213.cust-q.wadsl.it. [212.43.115.213])
        by smtp.gmail.com with ESMTPSA id t14-20020a05622a148e00b003f549b8b7d6sm24436qtx.68.2023.05.16.01.54.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 01:54:56 -0700 (PDT)
Date:   Tue, 16 May 2023 10:54:49 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Simon Horman <horms@kernel.org>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] virtio: Add missing documentation for structure fields
Message-ID: <y6kgnwu35oci7y5hx2htfobglrecjhxgpnqmtjetv52xk7hlsc@gwvfoojunl4x>
References: <20230510-virtio-kdoc-v2-1-1c5a20eb4cfe@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230510-virtio-kdoc-v2-1-1c5a20eb4cfe@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 11, 2023 at 04:46:22PM +0200, Simon Horman wrote:
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
>Changes in v2:
>- As suggested by Michael S. Tsirkin
>  + @validate is not called on probe
>  + @validate does validates config space
>  + embarrassingly, validate was misspelt
>- Link to v1: https://lore.kernel.org/r/20230510-virtio-kdoc-v1-1-d2b1824a9a2b@kernel.org
>---
> include/linux/virtio.h | 2 ++
> 1 file changed, 2 insertions(+)

I left some minor comments, anyway this version LGTM:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/include/linux/virtio.h b/include/linux/virtio.h
>index b93238db94e3..3abe8e9c8090 100644
>--- a/include/linux/virtio.h
>+++ b/include/linux/virtio.h
>@@ -103,6 +103,7 @@ int virtqueue_resize(struct virtqueue *vq, u32 num,
>  * @config_enabled: configuration change reporting enabled
>  * @config_change_pending: configuration change reported while disabled
>  * @config_lock: protects configuration change reporting
>+ * @vqs_list_lock: protects @vqs.

Maybe we can now remove `/* Protects VQs list access */`

>  * @dev: underlying device.
>  * @id: the device type identification (used to match it with a driver).
>  * @config: the configuration ops for this device.
>@@ -160,6 +161,7 @@ size_t virtio_max_dma_size(const struct virtio_device *vdev);
>  * @feature_table_size: number of entries in the feature table array.
>  * @feature_table_legacy: same as feature_table but when working in legacy mode.
>  * @feature_table_size_legacy: number of entries in feature table legacy array.
>+ * @validate: the function to call to validate features and config space

Maybe we can add ". Returns 0 or -errno."

Thanks,
Stefano

>  * @probe: the function to call when a device is found.  Returns 0 or -errno.
>  * @scan: optional function to call after successful probe; intended
>  *    for virtio-scsi to invoke a scan.
>

