Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6F61682021
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 00:56:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbjA3Xz6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 18:55:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbjA3Xz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 18:55:56 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12D7F1630B
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 15:55:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675122910;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I6XKRgTHaxCkR0HH+Nrj2oOYUJNCbOYMsc1ckog7mYs=;
        b=bM5hi2vgDcAn0HTTk85Hy2DjclOfDSlQX38+hJGO3dX0IPfZ7Up6umx7uE6PHvnKhP5eeH
        yw8O7M/3zxUMYM7maxo5jpSLjLSOo0/obR7cZxfYVzIGlM+poDYCq7QmC5QoMuaVdKoQHo
        gt1xZXOVbEqaDqU4+EsyJ/pibu8Qy8I=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-590-IHhqJPkDPwO1AHZFKspnZQ-1; Mon, 30 Jan 2023 18:55:09 -0500
X-MC-Unique: IHhqJPkDPwO1AHZFKspnZQ-1
Received: by mail-io1-f69.google.com with SMTP id y22-20020a5d94d6000000b007076e06ba3dso7589358ior.20
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 15:55:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I6XKRgTHaxCkR0HH+Nrj2oOYUJNCbOYMsc1ckog7mYs=;
        b=nBdmjlKXZu8jAjHmZV6MhlEBAddm7mq3UsausDPHPgDozNHZpDFmVX6alvK4IMIwic
         sNMR4gg9amLtF7wVyBopt/w8dCEkmRmjAFLBHT30pwC/5pBAmRGG2IlkoVjz6AwV/mJu
         SfCiZblPz8kE4ti1j73sZtRsM11cyRiw36D9nBjRLOH1ObN4ONQeQ5QKxQjNBoiFdlQR
         OyZt1scs65aah14JL1XB3wNzcb64jm/yiGYt3leb5zZnbnSTUgC7n1UBf+oIIbN0h14E
         c6/o0V/yezmc5oLShbbQ4MBrQ6vhhk8oJrBVtmMa/odSK8nWKr7obatrS09QctEDyOEA
         4r7g==
X-Gm-Message-State: AFqh2kqsDXg2PCk/57Q+lx/KMFBaH45GStIkMgESTcqVedcO4zznRhYh
        F3XYIpSY6Ypm80YJQThPIgvqhSi/OHvYXC93yV/eLTCpft+IKh+6XnwefrIUgjh2CPQu/dZT9L/
        RwikBA0nYUAhEJy3scFeaZdua
X-Received: by 2002:a6b:780a:0:b0:6de:13e4:69e7 with SMTP id j10-20020a6b780a000000b006de13e469e7mr32745461iom.7.1675122908354;
        Mon, 30 Jan 2023 15:55:08 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsVcQJzVnX0GMu/OUz3NlgUC/KS2BWuNYsYKkPZqsiIn3ia7OGLHzo9GwnvsFWlw9ia3Nvr1g==
X-Received: by 2002:a6b:780a:0:b0:6de:13e4:69e7 with SMTP id j10-20020a6b780a000000b006de13e469e7mr32745446iom.7.1675122908119;
        Mon, 30 Jan 2023 15:55:08 -0800 (PST)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id a3-20020a92c543000000b003036d1ee5cbsm4404645ilj.41.2023.01.30.15.55.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 15:55:07 -0800 (PST)
Date:   Mon, 30 Jan 2023 16:55:06 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     <ye.xingchen@zte.com.cn>
Cc:     <jgg@ziepe.ca>, <rostedt@goodmis.org>, <akrowiak@linux.ibm.com>,
        <alex.gaynor@gmail.com>, <ojeda@kernel.org>, <mhiramat@kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] samples: fix the compile error about SAMPLE_VFIO_MDEV_
 series
Message-ID: <20230130165506.03d15fe1.alex.williamson@redhat.com>
In-Reply-To: <202301301655039458241@zte.com.cn>
References: <202301301655039458241@zte.com.cn>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Jan 2023 16:55:03 +0800 (CST)
<ye.xingchen@zte.com.cn> wrote:

> From: ye xingchen <ye.xingchen@zte.com.cn>
> 
> When CONFIG_VFIO = m, SAMPLE_VFIO_MDEV_MTTY, SAMPLE_VFIO_MDEV_MTTY and
> SAMPLE_VFIO_MDEV_MBOCHS can be selected as:
> CONFIG_SAMPLE_VFIO_MDEV_MTTY = y;
> CONFIG_SAMPLE_VFIO_MDEV_MTTY = y;
> CONFIG_SAMPLE_VFIO_MDEV_MBOCHS = y;
> 
> That will cause compile error such as:
> 
> ld: samples/vfio-mdev/mdpy.o: in function 'mdpy_remove':
> samples/vfio-mdev/mdpy.c:294: undefined reference to
> 'vfio_unregister_group_dev'
> 
> ld: samples/vfio-mdev/mtty.o: in function 'mtty_remove':
> samples/vfio-mdev/mtty.c:793: undefined reference to
> 'vfio_unregister_group_dev'
> 
> ld: samples/vfio-mdev/mbochs.o: in function 'mbochs_remove':
> samples/vfio-mdev/mbochs.c:603: undefined reference to
> 'vfio_unregister_group_dev'
> 
> Add dependency make SAMPLE_VFIO_MDEV_MTTY, SAMPLE_VFIO_MDEV_MTTY and
> SAMPLE_VFIO_MDEV_MBOCHS not allowed to set as y when
> CONFIG_VFIO = m.
> 
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
> ---
>  samples/Kconfig | 3 +++
>  1 file changed, 3 insertions(+)

Thanks for the fix!  Another version[1] was sent last week that includes
a more complete fix and has been merged into the vfio next branch.
Thanks,

Alex

[1]https://lore.kernel.org/all/20230126211211.1762319-1-arnd@kernel.org/

 
> diff --git a/samples/Kconfig b/samples/Kconfig
> index 56b191d128d8..44a09dfa8a0b 100644
> --- a/samples/Kconfig
> +++ b/samples/Kconfig
> @@ -185,6 +185,7 @@ config SAMPLE_UHID
> 
>  config SAMPLE_VFIO_MDEV_MTTY
>  	tristate "Build VFIO mtty example mediated device sample code"
> +	depends on VFIO
>  	select VFIO_MDEV
>  	help
>  	  Build a virtual tty sample driver for use as a VFIO
> @@ -192,6 +193,7 @@ config SAMPLE_VFIO_MDEV_MTTY
> 
>  config SAMPLE_VFIO_MDEV_MDPY
>  	tristate "Build VFIO mdpy example mediated device sample code"
> +	depends on VFIO
>  	select VFIO_MDEV
>  	help
>  	  Build a virtual display sample driver for use as a VFIO
> @@ -209,6 +211,7 @@ config SAMPLE_VFIO_MDEV_MDPY_FB
> 
>  config SAMPLE_VFIO_MDEV_MBOCHS
>  	tristate "Build VFIO mdpy example mediated device sample code"
> +	depends on VFIO
>  	select VFIO_MDEV
>  	select DMA_SHARED_BUFFER
>  	help

