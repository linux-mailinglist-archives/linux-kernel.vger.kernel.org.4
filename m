Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C772367552E
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 14:02:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbjATNCr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 08:02:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjATNCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 08:02:46 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42275BCE35
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 05:02:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674219722;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=h7wBVjsJdeTQ+WNvN3DH4I2K8ExSDoZ538kq0KcWHf4=;
        b=UT/E1w2DP1PelB7vRzu3JQftutuZ6a2dy4gqKu4z5J2omVr/AMwhqhL304IDGmnPFbircn
        R92MPvCIO2EPkWa24Guj1rvUNg12BBd/KBiXmaOkdpd1L8LRuPC5PMIR1sgPwVSqWHdCVp
        Jlq8NTRxKIsB7a+F9r5sMaHsZ6wmqJA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-643-WfCL5KPsPoCjxEZ1feduFQ-1; Fri, 20 Jan 2023 08:01:59 -0500
X-MC-Unique: WfCL5KPsPoCjxEZ1feduFQ-1
Received: by mail-wm1-f71.google.com with SMTP id c7-20020a1c3507000000b003d355c13ba8so2984658wma.6
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 05:01:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h7wBVjsJdeTQ+WNvN3DH4I2K8ExSDoZ538kq0KcWHf4=;
        b=UreD1E+AlqL9E1pfs4PjOr9Th82kNN9Vlmjy6ZbhhHek2qTop1hgpGWgEtukNqrAkV
         IuAdlTzE/5+OjjWH38iOipOnsrLfsFzeiASAjp5a3oSmzPU6kw22UUazD81W8YBJBk/4
         JjZqnPR8t/xiXrZmW+rt0BCnq/uEfkJGZwMBzAvbrcUVF2g++R32gxugn9tKC6LNDu10
         oaMrBetvtSu6MVB9rOjlX+4K6yH6pGBg07hP2l4qafbI+pnYiBNXsiqkG+EUx6cA6tNH
         AvdoPhpDhxsFj5vdSeYcgihvBUD92ncEWKMSriNHEn/BVr51hGa9xoi2FR7At1IgKIsF
         Gyqg==
X-Gm-Message-State: AFqh2kq2FD+bn/WeBoZC13PVjiezxtPzuOgbIFsc7l6lW001NTxdk7Hm
        2IZf5SotZXNMKf15u3v3HCr+b3af+EkGU9icTX/mBRypTuyFZy7xrrgPg4F/otFCelmcqTKxXZk
        +sH7O5bCGDmmF/sEjs3HLrQg5
X-Received: by 2002:adf:a31e:0:b0:2be:5cff:5d00 with SMTP id c30-20020adfa31e000000b002be5cff5d00mr1661015wrb.70.1674219718236;
        Fri, 20 Jan 2023 05:01:58 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuAFTj3ASCRpytlHara8uZNPHYOknLCkK+Sp90nWm9UfQI1VggsDul6y0CDGx+uH0kt54hfdw==
X-Received: by 2002:adf:a31e:0:b0:2be:5cff:5d00 with SMTP id c30-20020adfa31e000000b002be5cff5d00mr1660988wrb.70.1674219717939;
        Fri, 20 Jan 2023 05:01:57 -0800 (PST)
Received: from redhat.com ([2.52.19.29])
        by smtp.gmail.com with ESMTPSA id k18-20020adfb352000000b00241fab5a296sm36619113wrd.40.2023.01.20.05.01.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 05:01:57 -0800 (PST)
Date:   Fri, 20 Jan 2023 08:01:53 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, elena.reshetova@intel.com,
        kirill.shutemov@linux.intel.com, Andi Kleen <ak@linux.intel.com>,
        Amit Shah <amit@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v1 1/6] virtio console: Harden multiport against invalid
 host input
Message-ID: <20230120080130-mutt-send-email-mst@kernel.org>
References: <20230119135721.83345-1-alexander.shishkin@linux.intel.com>
 <20230119135721.83345-2-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230119135721.83345-2-alexander.shishkin@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2023 at 03:57:16PM +0200, Alexander Shishkin wrote:
> From: Andi Kleen <ak@linux.intel.com>
> 
> It's possible for the host to set the multiport flag, but pass in
> 0 multiports, which results in:
> 
> BUG: KASAN: slab-out-of-bounds in init_vqs+0x244/0x6c0 drivers/char/virtio_console.c:1878
> Write of size 8 at addr ffff888001cc24a0 by task swapper/1
> 
> CPU: 0 PID: 1 Comm: swapper Not tainted 5.15.0-rc1-140273-gaab0bb9fbaa1-dirty #588
> Call Trace:
>  init_vqs+0x244/0x6c0 drivers/char/virtio_console.c:1878
>  virtcons_probe+0x1a3/0x5b0 drivers/char/virtio_console.c:2042
>  virtio_dev_probe+0x2b9/0x500 drivers/virtio/virtio.c:263
>  call_driver_probe drivers/base/dd.c:515
>  really_probe+0x1c9/0x5b0 drivers/base/dd.c:601
>  really_probe_debug drivers/base/dd.c:694
>  __driver_probe_device+0x10d/0x1f0 drivers/base/dd.c:754
>  driver_probe_device+0x68/0x150 drivers/base/dd.c:786
>  __driver_attach+0xca/0x200 drivers/base/dd.c:1145
>  bus_for_each_dev+0x108/0x190 drivers/base/bus.c:301
>  driver_attach+0x30/0x40 drivers/base/dd.c:1162
>  bus_add_driver+0x325/0x3c0 drivers/base/bus.c:618
>  driver_register+0xf3/0x1d0 drivers/base/driver.c:171
> ...
> 
> Add a suitable sanity check.
> 
> Signed-off-by: Andi Kleen <ak@linux.intel.com>
> Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Amit Shah <amit@kernel.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/char/virtio_console.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
> index 6a821118d553..f4fd5fe7cd3a 100644
> --- a/drivers/char/virtio_console.c
> +++ b/drivers/char/virtio_console.c
> @@ -1843,6 +1843,9 @@ static int init_vqs(struct ports_device *portdev)
>  	int err;
>  
>  	nr_ports = portdev->max_nr_ports;
> +	if (use_multiport(portdev) && nr_ports < 1)
> +		return -EINVAL;
> +
>  	nr_queues = use_multiport(portdev) ? (nr_ports + 1) * 2 : 2;
>  
>  	vqs = kmalloc_array(nr_queues, sizeof(struct virtqueue *), GFP_KERNEL);

Weird.  Don't we already check for that?

        /* Don't test MULTIPORT at all if we're rproc: not a valid feature! */
        if (!is_rproc_serial(vdev) &&
            virtio_cread_feature(vdev, VIRTIO_CONSOLE_F_MULTIPORT,
                                 struct virtio_console_config, max_nr_ports,
                                 &portdev->max_nr_ports) == 0) {
                if (portdev->max_nr_ports == 0 ||
                    portdev->max_nr_ports > VIRTCONS_MAX_PORTS) {
                        dev_err(&vdev->dev,
                                "Invalidate max_nr_ports %d",
                                portdev->max_nr_ports);
                        err = -EINVAL;
                        goto free;
                }
                multiport = true;
        }




> -- 
> 2.39.0

