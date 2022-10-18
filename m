Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A3DB602FE6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 17:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbiJRPkO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 11:40:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbiJRPkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 11:40:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C77275499
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 08:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666107608;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=n1ntOmfZrs8dqZ6k2VCqVjRnTeyOx20Q25jn6A/FnCk=;
        b=dVdcrzd0Q5IOAkAr5QCWGbnh0+QVei+n5eYm5D8t64EeukPTJYUQgQDlU3D2+cWzY0uxG9
        Bd/uA9Ir22+8yFygJRgDNg62+OgvBIB1vrO+q0kEfGR9vdLr6DKaICi9DvnxzhwIVptXQJ
        eRXwqVqxJODp295+eNFVytGBkg+ohBY=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-302-wm6e3k7oMsGS-LwRQSWuFg-1; Tue, 18 Oct 2022 11:39:57 -0400
X-MC-Unique: wm6e3k7oMsGS-LwRQSWuFg-1
Received: by mail-qv1-f72.google.com with SMTP id dh7-20020ad458c7000000b004b1c8f7205eso8826046qvb.5
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 08:39:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n1ntOmfZrs8dqZ6k2VCqVjRnTeyOx20Q25jn6A/FnCk=;
        b=RPhMrXg8nhJo0N480JqP/UPxG3hA9raFLIguD5Ub7f+HGOgHXuIFjUXzFaAZaWraka
         U8cdZk6BHBUULt+E50wdo/JwL+ZFYzv68Hcgp5i15xvsLIwqzEbUOTC6GGnxlw+Gi7zD
         K3tEcIox09D97YmUbm9UpzqDzKUDIOz8JkagEIpI8ALeB9WcLdrhHYBCcyksIbXuvLE0
         0psscxZFb22jp5qPdowKZmjUEzMXVgxr5lsxckxRL7VsiioynftYsPi42kdWwC6yFqAb
         bhrm4bYcIjqE6rfVxCz1LGOjmKJah5xaYvPECANjZxvyGzmxTFJyPSIOvW9XW5GsD2YF
         UDrA==
X-Gm-Message-State: ACrzQf01ywXoD1XXyo5/2E8brA3ZvO/o9vJX0EVkLfs57JWz0zMbB6Of
        NOWj2P3zRvmYEoBM64fQi8ow45TBDwGiHv0nf88jLMKNk/11HgGYI92EIDRj3w/5dIsVV472/Mt
        0xb9pY93jCycQPV/wnRiJlC0R
X-Received: by 2002:a05:622a:95:b0:39c:c9df:8db with SMTP id o21-20020a05622a009500b0039cc9df08dbmr2576325qtw.349.1666107597124;
        Tue, 18 Oct 2022 08:39:57 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7otvOjB+1WMOHwHy+ISe/cHO3iDr0yYS4pArNJuJCmujDYQmiQUjY8SAsUr16B5Qj+1fUiBQ==
X-Received: by 2002:a05:622a:95:b0:39c:c9df:8db with SMTP id o21-20020a05622a009500b0039cc9df08dbmr2576312qtw.349.1666107596881;
        Tue, 18 Oct 2022 08:39:56 -0700 (PDT)
Received: from sgarzare-redhat ([5.179.166.161])
        by smtp.gmail.com with ESMTPSA id z15-20020a05622a124f00b0039a08c0a594sm2083410qtx.82.2022.10.18.08.39.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 08:39:56 -0700 (PDT)
Date:   Tue, 18 Oct 2022 17:39:48 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     mst@redhat.com, corbet@lwn.net, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, mikelley@microsoft.com,
        vkuznets@redhat.com, liuwe@microsoft.com, kkashanjat@microsoft.com,
        cohuck@redhat.com, otubo@redhat.com, andavis@redhat.com,
        aadam@redhat.com, stefanha@redhat.com,
        virtualization@lists.linux-foundation.org
Subject: Re: [RFC PATCH] virtio: document virtio hardening status and TODO
Message-ID: <20221018153948.2ocwejx4ut3sf3br@sgarzare-redhat>
References: <20221014042037.23639-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20221014042037.23639-1-jasowang@redhat.com>
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm not a native speaker, so the following suggestions can be wrong :-)

On Fri, Oct 14, 2022 at 12:20:37PM +0800, Jason Wang wrote:
>This patch summarizes the status of hardening and TODO of hardening
>virtio core and drivers.
>
>Signed-off-by: Jason Wang <jasowang@redhat.com>
>---
> Documentation/security/virtio/core.rst | 49 ++++++++++++++++++++++++++
> MAINTAINERS                            |  1 +
> 2 files changed, 50 insertions(+)
> create mode 100644 Documentation/security/virtio/core.rst
>
>diff --git a/Documentation/security/virtio/core.rst b/Documentation/security/virtio/core.rst
>new file mode 100644
>index 000000000000..b8baa104d7c8
>--- /dev/null
>+++ b/Documentation/security/virtio/core.rst
>@@ -0,0 +1,49 @@
>+================
>+Virtio hardening
>+================
>+
>+The virtio core and drivers should not trust the devices. This means
>+all kinds of input from the device must be validated before being
>+used. This document summarizes the current status and TODO for this
>+validation/hardening efforts.

s/efforts/effort

>+
>+
>+Status
>+======
>+
>+The virtio core and drivers has done some basic hardening:
>+
>+* Config callback hardening: The core makes sure the config interrupt
>+  callbacks are enabled after the driver is ready and disable before
>+  the driver is removed.
>+
>+* Descriptor ring hardening: The metadata of a descriptor were copied
>+  and stored in a driver private memory that can not be accessed by the
>+  device. The eliminates the device triggerable behaviours through the

s/The/This ? (not sure)
)
>+  descriptor ring.
>+
>+* Device configuration space validation: Some of the virtio drivers
>+  validates the fields of device configuration space before try to use

s/validates/validate

>+  them.
>+
>+
>+TODO
>+====
>+
>+* Input buffer length validation: The virtio core needs to validate
>+  the input buffer length validation before passing them to individual

Remove "validation"?

>+  virtio drivers.
>+
>+* Virtqueue callback hardening: The virtio core (or with the help of
>+  the drivers) should guarantee that the virtqueue callbacks should not
>+  be triggered before the driver is ready or after the driver is
>+  removed.
>+
>+* Transport specific data validation: The virtio transport driver should
>+  validate the virtio transport specific data provided by the device
>+  before trying to use them in the probing.

s/in the probing/during the probe   ?

>+
>+* Device specific validation: Driver should validate the device specific
>+  metadata before being used by a specific subsystem.
>+
>+
>diff --git a/MAINTAINERS b/MAINTAINERS
>index 673b9f9b8d8a..b33cc5c751c1 100644
>--- a/MAINTAINERS
>+++ b/MAINTAINERS
>@@ -21516,6 +21516,7 @@ S:	Maintained
> F:	Documentation/ABI/testing/sysfs-bus-vdpa
> F:	Documentation/ABI/testing/sysfs-class-vduse
> F:	Documentation/devicetree/bindings/virtio/
>+F:	Documentation/security/virtio/core.rst
> F:	drivers/block/virtio_blk.c
> F:	drivers/crypto/virtio/
> F:	drivers/net/virtio_net.c
>-- 
>2.25.1
>

Thanks,
Stefano

