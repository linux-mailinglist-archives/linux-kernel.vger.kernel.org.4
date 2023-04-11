Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C480F6DD2CD
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 08:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbjDKGah (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 02:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbjDKGaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 02:30:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 685001FEA
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 23:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681194586;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oSR/BoPrTP4dM6eEMbqNicTKlgGAh6IQScE+JTRaUCI=;
        b=Hra8B2eCWiJ6BdeclaIvYpWFdv1Yuk6cRegWMdaj6GhlrolKkaEfbYcFT10240nA2mnu6k
        5xaXtIZ5NpGUs/QxUDJ4tWuCxS/sef6kbGllsxWD1obVoyRpB4+K/bW68s9w8zpa0YWyZb
        T/57KP+tOdmd7EZKPkiohNP2TcN5+9E=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-328-V1ixWlo2Pfi3FArAWyFxtg-1; Tue, 11 Apr 2023 02:29:42 -0400
X-MC-Unique: V1ixWlo2Pfi3FArAWyFxtg-1
Received: by mail-wr1-f70.google.com with SMTP id c28-20020adfa31c000000b002d5737d3835so923431wrb.21
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 23:29:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681194582;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oSR/BoPrTP4dM6eEMbqNicTKlgGAh6IQScE+JTRaUCI=;
        b=hy8oY6yO1SxwduWUsjKhR1eQg7Tcnab01i4FqG+QWsV7z3SzUbWWy7laoHs4Av5IyE
         RyTSkQhZP5EuM8dj81yF18/lmWeuU0o7ILHoJXwJo/OeyHY4ef3g0Uexk4up1a3trImz
         Y+So66kRd1ybYOze9QA9UPgaXfhG42/FC7BB4Ah4b0fXOkOz7fwb8RqcbXdIPnmwYSTB
         lTJA6c02P8MB4uI36PBFwvHFpDNAsxjyAr8FnaXiQPtZrA3kLGdvDpeV+zXYwtegKm6Z
         7658/5LnaZYIbmQKPapaJq47+euan/zjtdUJMUIsWNpj/qOh5XYg+4ZFVXO0s2r639xe
         foBQ==
X-Gm-Message-State: AAQBX9enmL7nCuYZBCHct7MjvvddqoAgDTKSnldIUMNLQ/W6TDI1oG2f
        Wr+pd2/EN3i9ZMK+uK3Ssrn8mNiBKnR/iAFotji+L6oSkYdPfhYvJA1BctUg0I31nAP8UXS8cn4
        +5Ti7Uzv21zSjfhzV2YVg8Mis
X-Received: by 2002:a05:600c:3786:b0:3eb:3104:efec with SMTP id o6-20020a05600c378600b003eb3104efecmr6103020wmr.16.1681194581882;
        Mon, 10 Apr 2023 23:29:41 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZMnDmXJKwVPTFLe5E+xPCjkP07zR84RGkXb1tNKi76IBa8wNnsmfGG09/OTcO4lFwDkKN4+Q==
X-Received: by 2002:a05:600c:3786:b0:3eb:3104:efec with SMTP id o6-20020a05600c378600b003eb3104efecmr6103012wmr.16.1681194581491;
        Mon, 10 Apr 2023 23:29:41 -0700 (PDT)
Received: from redhat.com ([2.52.10.80])
        by smtp.gmail.com with ESMTPSA id m30-20020a05600c3b1e00b003ef5deb4188sm19722538wms.17.2023.04.10.23.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 23:29:40 -0700 (PDT)
Date:   Tue, 11 Apr 2023 02:29:37 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Angus Chen <angus.chen@jaguarmicro.com>
Cc:     jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtio_pci: Wait for legacy device to be reset
Message-ID: <20230411022329-mutt-send-email-mst@kernel.org>
References: <20230411013833.1305-1-angus.chen@jaguarmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230411013833.1305-1-angus.chen@jaguarmicro.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 11, 2023 at 09:38:32AM +0800, Angus Chen wrote:
> We read the status of device after reset,
> It is not guaranteed that the device be reseted successfully.

Sorry not guaranteed by what? I am guessing you have a legacy device
that does not reset fully on write, and you need to wait?

> We can use a while loop to make sure that,like the modern device did.
> The spec is not request it ,but it work.
> 
> Signed-off-by: Angus Chen <angus.chen@jaguarmicro.com>

Generally I don't much like touching legacy, no telling what
that will do. Case in point, is your device a pure
legacy device or a transitional device?

> ---
>  drivers/virtio/virtio_pci_legacy.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/virtio/virtio_pci_legacy.c b/drivers/virtio/virtio_pci_legacy.c
> index 2257f1b3d8ae..f2d241563e4f 100644
> --- a/drivers/virtio/virtio_pci_legacy.c
> +++ b/drivers/virtio/virtio_pci_legacy.c
> @@ -14,6 +14,7 @@
>   *  Michael S. Tsirkin <mst@redhat.com>
>   */
>  
> +#include <linux/delay.h>
>  #include "linux/virtio_pci_legacy.h"
>  #include "virtio_pci_common.h"
>  
> @@ -97,7 +98,8 @@ static void vp_reset(struct virtio_device *vdev)
>  	vp_legacy_set_status(&vp_dev->ldev, 0);
>  	/* Flush out the status write, and flush in device writes,
>  	 * including MSi-X interrupts, if any. */
> -	vp_legacy_get_status(&vp_dev->ldev);
> +	while (vp_legacy_get_status(&vp_dev->ldev))
> +		msleep(1);

The problem with this is that it will break surprise
removal even worse than it's already broken.


>  	/* Flush pending VQ/configuration callbacks. */
>  	vp_synchronize_vectors(vdev);
>  }
> -- 
> 2.25.1

