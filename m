Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91FD767D35E
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 18:39:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231902AbjAZRjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 12:39:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbjAZRjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 12:39:04 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F076223662
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 09:38:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674754696;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UP86k1APrPz3BcZvXfy0BmlimniXATisUf4b1IG1aSc=;
        b=CslAXUJ8RSsCtkZWLaTf3hEeZ3hm1p12DctbpjdnHqHTb7tPh58t+7fV7fUutR/q0kdr/5
        VKvOLnai86Fz2INhoQ2AjKXYeSQ3teubuxTVv0gBweATkqiMdADhv/35/j+jj3LC6Taq5i
        vGP0XMDIESMPB8Ir/qX0b75gVksVRnk=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-473-1iixaDoZOCy4XwTt1EFnRg-1; Thu, 26 Jan 2023 12:38:15 -0500
X-MC-Unique: 1iixaDoZOCy4XwTt1EFnRg-1
Received: by mail-il1-f199.google.com with SMTP id i14-20020a056e020d8e00b003034b93bd07so1620363ilj.14
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 09:38:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UP86k1APrPz3BcZvXfy0BmlimniXATisUf4b1IG1aSc=;
        b=glReiAYAaTSL36L+v7YSpEnxcHadomGpOwogOs6+vvJ4umYoZEx9AnACtNoNg3Hj1T
         mA6S/h/uqrW5rKM3Vipj+fIQ/xsgtazF3UKNoZRjvVQn6+SGDLBFBdEMKJsK5k6jclnA
         pMtNbV3HW8gGrVzWUYOEl/lXVhJAFbGFMzUKiFg8h7+oFs3nXHSYI8e+6UM9ngl8wjMI
         w7Fs7VVfvDbTumMdHUCDVnil2ggDC5lT+wJ+1MHNrIw3GHM8f6RODtzNxInedOwBNBSx
         xYXykihVAkWLn7hvXvVNFN35uaE0Kz5IJdhl4dKCKRP/vQi0rVYsG62IH/+wcM2TwZPy
         2YLQ==
X-Gm-Message-State: AFqh2krxDD0h4QbccEltnQiu5xkNoE0mvnw2TX+7w+QJA7+lNPZ0tMmQ
        i54swNRi8vzclK7imggO43WRd16/fG9KQ+72PvWKfrZB/Vl7uuyrxeHT9a/6p5wSfn34wAleusW
        VZvtq7hhvO0CzHa6eKDV6B8OQ
X-Received: by 2002:a05:6602:1242:b0:704:9ebf:848 with SMTP id o2-20020a056602124200b007049ebf0848mr25058019iou.19.1674754693856;
        Thu, 26 Jan 2023 09:38:13 -0800 (PST)
X-Google-Smtp-Source: AMrXdXu/ToZ0kBl/JrTKRaBTVHkP2FQYvtd7FCcVvvxUz4y2MV/vmPuwEztf/7hd1B7ZSTYapXgxyA==
X-Received: by 2002:a05:6602:1242:b0:704:9ebf:848 with SMTP id o2-20020a056602124200b007049ebf0848mr25058016iou.19.1674754693620;
        Thu, 26 Jan 2023 09:38:13 -0800 (PST)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id c8-20020a6bfd08000000b00704ae903dd7sm462573ioi.13.2023.01.26.09.38.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 09:38:13 -0800 (PST)
Date:   Thu, 26 Jan 2023 10:38:11 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Tony Krowiak <akrowiak@linux.ibm.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Finn Behrens <me@kloenk.de>, Miguel Ojeda <ojeda@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] vfio-mdev: add back CONFIG_VFIO dependency
Message-ID: <20230126103811.56d71351.alex.williamson@redhat.com>
In-Reply-To: <20230126163719.3585002-1-arnd@kernel.org>
References: <20230126163719.3585002-1-arnd@kernel.org>
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

On Thu, 26 Jan 2023 17:37:06 +0100
Arnd Bergmann <arnd@kernel.org> wrote:

> From: Arnd Bergmann <arnd@arndb.de>
> 
> CONFIG_VFIO_MDEV cannot be selected when VFIO itself is
> disabled, otherwise we get a link failure:
> 
> WARNING: unmet direct dependencies detected for VFIO_MDEV
>   Depends on [n]: VFIO [=n]
>   Selected by [y]:
>   - SAMPLE_VFIO_MDEV_MTTY [=y] && SAMPLES [=y]
>   - SAMPLE_VFIO_MDEV_MDPY [=y] && SAMPLES [=y]
>   - SAMPLE_VFIO_MDEV_MBOCHS [=y] && SAMPLES [=y]
> /home/arnd/cross/arm64/gcc-13.0.1-nolibc/x86_64-linux/bin/x86_64-linux-ld: samples/vfio-mdev/mdpy.o: in function `mdpy_remove':
> mdpy.c:(.text+0x1e1): undefined reference to `vfio_unregister_group_dev'
> /home/arnd/cross/arm64/gcc-13.0.1-nolibc/x86_64-linux/bin/x86_64-linux-ld: samples/vfio-mdev/mdpy.o: in function `mdpy_probe':
> mdpy.c:(.text+0x149e): undefined reference to `_vfio_alloc_device'
> 
> Fixes: 8bf8c5ee1f38 ("vfio-mdev: turn VFIO_MDEV into a selectable symbol")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  samples/Kconfig | 3 +++
>  1 file changed, 3 insertions(+)

Seems like it wouldn't just be the sample drivers with this issue,
don't VFIO_CCW, VFIO_AP, and DRM_I915_GVT_KVMGT all have this problem?
Thanks,

Alex

> 
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

