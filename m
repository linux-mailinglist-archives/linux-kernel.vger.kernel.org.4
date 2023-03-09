Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 988E56B1E0A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 09:27:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbjCII1c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 03:27:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbjCII07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 03:26:59 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54A26E0636
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 00:24:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678350257;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KKd192dm2AeL+ZfUgfO3ZLwcRrb/6MAd0iIB60AdtXk=;
        b=AFNlK2RB7tJ8t9HSYjPAC+mWZ/t8LUE+ztRowJDZsFxx3G/Nz+PVH5GA9zb7JfNUpWcEr2
        rzqvCkFpnly6ETQmIV3AcywxES2MOWrvWK/x4SdW3l4f0NJC25CNuSekyU9jt6yj/TkW3U
        h78qgciRtwIVpuswnuJ2uXw71oIDNLQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-523-9WY7fMuMNcaA7l0UfqNdaQ-1; Thu, 09 Mar 2023 03:24:16 -0500
X-MC-Unique: 9WY7fMuMNcaA7l0UfqNdaQ-1
Received: by mail-wm1-f72.google.com with SMTP id u19-20020a05600c00d300b003eb24ce58ceso382466wmm.9
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 00:24:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678350255;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KKd192dm2AeL+ZfUgfO3ZLwcRrb/6MAd0iIB60AdtXk=;
        b=bQmeP7tYSLmEW3uF1jswK8Zwx/j+NXFi83wlKXfdv0gOh/GF9F3/VElziuGNQUq3XG
         hp/+gtXzIxBbb6QhSDceeK2yFBfMcW9xF0yqUpRX76cPA6AT1sZpAr4e1H78Yak5mJ/Y
         DixalKE2+zgELI4xo3ewY3OfjsPxDNRppldhL3cvy4hWbRntXtHKdGAiDZAFf86tLuKg
         XoC/akYtDW+Td2coK3Ht72PXTHvespV5CwjO2VPA8Jsnz+d9sLczaBvk7J6M1PlAeW7h
         nMHoZvPqP6GhtVz9oFUyWGhUJa266Z4NaXDNfG4CFHdTWANdCRVSsBy1unVRQLgr+H+3
         qWTQ==
X-Gm-Message-State: AO0yUKXpmpf1dKpsqXVPHStDFeHS1/5PTgTjS4Cq3cotyfC9OoD7OUzl
        y8QEEixAMe8Qlg21ssVkoiLccXnxHnkNYrJWz2n5R0LfRpkTJmt+thb5Sj9nBX812O4x7IOh5BF
        AcjhvGl9r7wbp1svcW9+Ozkf+
X-Received: by 2002:a05:600c:1c12:b0:3eb:389d:156c with SMTP id j18-20020a05600c1c1200b003eb389d156cmr18410276wms.37.1678350255022;
        Thu, 09 Mar 2023 00:24:15 -0800 (PST)
X-Google-Smtp-Source: AK7set81Q5EAoFOSJYyUpDBHF44G5XfExEzpA2t/qHqCgPH7fAmK72jRNAakqfKtUPzJ2Tpk8jg1Ew==
X-Received: by 2002:a05:600c:1c12:b0:3eb:389d:156c with SMTP id j18-20020a05600c1c1200b003eb389d156cmr18410264wms.37.1678350254762;
        Thu, 09 Mar 2023 00:24:14 -0800 (PST)
Received: from sgarzare-redhat (host-82-57-51-170.retail.telecomitalia.it. [82.57.51.170])
        by smtp.gmail.com with ESMTPSA id o4-20020a05600c378400b003e4326a6d53sm1752740wmr.35.2023.03.09.00.24.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 00:24:14 -0800 (PST)
Date:   Thu, 9 Mar 2023 09:24:11 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Rong Tao <rtoax@foxmail.com>
Cc:     mst@redhat.com, Jason Wang <jasowang@redhat.com>,
        "open list:VIRTIO CORE AND NET DRIVERS" 
        <virtualization@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tools/virtio: virtio_test: Fix indentation
Message-ID: <20230309082411.nm5apbepytansfpm@sgarzare-redhat>
References: <tencent_89579C514BC4020324A1A4ACA44B5B95BB07@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <tencent_89579C514BC4020324A1A4ACA44B5B95BB07@qq.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 09, 2023 at 02:13:20PM +0800, Rong Tao wrote:
>Replace eight spaces with Tab.
>
>Signed-off-by: Rong Tao <rtoax@foxmail.com>
>---
> tools/virtio/virtio_test.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/tools/virtio/virtio_test.c b/tools/virtio/virtio_test.c
>index 6e348fbdc5d8..44409a311580 100644
>--- a/tools/virtio/virtio_test.c
>+++ b/tools/virtio/virtio_test.c
>@@ -134,7 +134,7 @@ static void vdev_info_init(struct vdev_info* dev, unsigned long long features)
> 	dev->buf_size = 1024;
> 	dev->buf = malloc(dev->buf_size);
> 	assert(dev->buf);
>-        dev->control = open("/dev/vhost-test", O_RDWR);
>+	dev->control = open("/dev/vhost-test", O_RDWR);
> 	assert(dev->control >= 0);
> 	r = ioctl(dev->control, VHOST_SET_OWNER, NULL);
> 	assert(r >= 0);
>-- 
>2.39.1
>

