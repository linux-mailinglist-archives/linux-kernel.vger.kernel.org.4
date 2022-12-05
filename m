Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 664C76427E7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 12:57:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231321AbiLEL5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 06:57:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbiLEL5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 06:57:16 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DB61271
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 03:57:15 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id q71so10281384pgq.8
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 03:57:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TXun/kAIegggkRWwvKTWnoGIg6kCLFAZaySakeuzmV0=;
        b=HXZE3FhBYo/gZpNhla6VQNJVLrbWHvcTWTXS4KZqL0s2yTvm/rjZlOjXmjD0uC6vmh
         u3fc1+kw3vp0S16967sAId/hgDG6EhtO8SvwMAg/p9XUXHKMNU0vNhAEpyoTF3fj/CLe
         FhHi6kyZKsdw4gmD6mW7fHf/1cbbDGzttiC6U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TXun/kAIegggkRWwvKTWnoGIg6kCLFAZaySakeuzmV0=;
        b=Btp8fxZ2CGEQT23Yaan1Ky10jp93ufz3AKMtMiouwpaRq5gQmny09fBqQqmqibs+cL
         qr3kO6LCLKr12a1URRJbvBMeTbOm88u4oSZYJWgXZU9CyqCvmQz/Gu5TEkvAkB/uxhxC
         xBX/byNitHnIB5oCx1P+/JjiXPcQMFQ9Eakj6cSZlgxALYw1Lj0VporN49IYEjdlwSxA
         X8/PIxQyamiHnx9xuwl7kE69vKaUUu4YuvGgpjg6z/l7tgK8gzpS64GLcYHB0zqdBWs4
         6yx6CifgzNB74SDTr/H0h5XDx2UilKmv/n7F3NEONVi6V8VYjaMsyfS40QnXddcZEDg9
         WWPg==
X-Gm-Message-State: ANoB5pnBEHM39CMK8c6n6AxC4tCbq1vtgcHQsd44Pel53m3AJgUx+eXa
        B92UUbRjfVlWWM6dhTVaJ47ftQ==
X-Google-Smtp-Source: AA0mqf4+p9xXaOsU5CmfEI/+Dsuw0eicjIJLgBfd42PZevuKYdb8mCxKymOtEhGhpKvhcu33ilTtBg==
X-Received: by 2002:a63:f545:0:b0:477:e3ce:739c with SMTP id e5-20020a63f545000000b00477e3ce739cmr42344595pgk.363.1670241435037;
        Mon, 05 Dec 2022 03:57:15 -0800 (PST)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id a14-20020a170902ecce00b00186b1bfbe79sm10476341plh.66.2022.12.05.03.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 03:57:13 -0800 (PST)
Date:   Mon, 5 Dec 2022 20:57:09 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        Yunke Cao <yunkec@chromium.org>
Subject: Re: [PATCH v2] media: uvcvideo: Recover stalled ElGato devices
Message-ID: <Y43clUZMl6n5D4IV@google.com>
References: <20220920-resend-elgato-v2-0-06b48b3b486a@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220920-resend-elgato-v2-0-06b48b3b486a@chromium.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/12/02 18:01), Ricardo Ribalda wrote:
> Elgato Cam Link 4k can be in a stalled state if the resolution of
> the external source has changed while the firmware initializes.
> Once in this state, the device is useless until it receives a
> USB reset. It has even been observed that the stalled state will
> continue even after unplugging the device.
> 
> lsusb -v
> 
> Bus 002 Device 002: ID 0fd9:0066 Elgato Systems GmbH Cam Link 4K
> Device Descriptor:
>   bLength                18
>   bDescriptorType         1
>   bcdUSB               3.00
>   bDeviceClass          239 Miscellaneous Device
>   bDeviceSubClass         2
>   bDeviceProtocol         1 Interface Association
>   bMaxPacketSize0         9
>   idVendor           0x0fd9 Elgato Systems GmbH
>   idProduct          0x0066
>   bcdDevice            0.00
>   iManufacturer           1 Elgato
>   iProduct                2 Cam Link 4K
>   iSerial                 4 0005AC52FE000
>   bNumConfigurations      1
> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>

>  
> +static const struct usb_device_id elgato_cam_link_4k = {
> +						USB_DEVICE(0x0fd9, 0x0066)};
> +

A nit, I'd format this slightly different:

+static const struct usb_device_id elgato_cam_link_4k = {
+	USB_DEVICE(0x0fd9, 0x0066)
+};
