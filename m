Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C11B863E442
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 00:07:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbiK3XHm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 18:07:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbiK3XHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 18:07:34 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7555C975D3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 15:06:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669849588;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d26lChXoDlvGkCKOjB2wAez7JUC+UbRJaOgpbj3f1C4=;
        b=HNIdzqc8+oFEOfpTjm6eCKNgmDfzHNU6W3xv5xlniIZNmB6y1nkE5POnOc48diAWnj+We8
        owQ78IWoMXMoY+kp8SxSQiC6DZBOeD1bGTww26+0tJL2zdokKCNiIC6JdnLxj1/Br983R4
        z6i60oQq3jOJMLTeLmSCchExD85Y8jA=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-540-r1Pb3SagM5G5IzCIejy3ag-1; Wed, 30 Nov 2022 18:06:27 -0500
X-MC-Unique: r1Pb3SagM5G5IzCIejy3ag-1
Received: by mail-io1-f69.google.com with SMTP id y5-20020a056602120500b006cf628c14ddso12456695iot.15
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 15:06:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d26lChXoDlvGkCKOjB2wAez7JUC+UbRJaOgpbj3f1C4=;
        b=eHN5c1XBdiBhwBL1wrLZWb9UOCkkWXCVaG5++6nXsS+v+eNk0QOUjX+uZQcA2pDbKH
         xESD8Ha9vZ4RKZBVVwcnd+3gjG1k1i8Y4Ixd/QjzP/eVwuh4MWq+78E40ExA0GgAExRm
         ZEiAkh+CSxAEVUBngh6+B1jG0CYf2AWUKt1y/1DPcbbmZ9eI/cVDnyhFG4Dp4xf8YFWR
         py4SOMByfONcw2PRNSyzCwAre8SBql9z91CoDnByGusYKCc6vLhukjIFILtRB2lGM21e
         qm6pIgSyvO5OQIfijsF/Ib8m3F+hmToTAXMKr9haM613vAp0TEqEhIO5at+HlJlSM31w
         dRmg==
X-Gm-Message-State: ANoB5plbuRLflAHuH2StxqxsZYVI1xFfvnwQQKxnaa9dTwXzV/Kmjnzm
        RudUvnQ8aaMOjaSfcwFCHp3Eee7OK0AT0oM5NaEQAraJWlGO4+41aLgKVvpUNPVMtSR88Eh9piF
        eskY8NFkM4DVmtbFlr43J2WX1
X-Received: by 2002:a92:cb89:0:b0:302:3c43:20b9 with SMTP id z9-20020a92cb89000000b003023c4320b9mr21109384ilo.300.1669849583863;
        Wed, 30 Nov 2022 15:06:23 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6OkVj5fnMzli9bMlTgGf4gH6vOhgMRZnkJ53hmRbgsaIa7w51XM4Qyhc+P8kRwsJ8espFwxg==
X-Received: by 2002:a92:cb89:0:b0:302:3c43:20b9 with SMTP id z9-20020a92cb89000000b003023c4320b9mr21109374ilo.300.1669849583558;
        Wed, 30 Nov 2022 15:06:23 -0800 (PST)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id w10-20020a05660205ca00b0067b75781af9sm982859iox.37.2022.11.30.15.06.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 15:06:23 -0800 (PST)
Date:   Wed, 30 Nov 2022 16:06:22 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     ruanjinjie <ruanjinjie@huawei.com>
Cc:     <kwankhede@nvidia.com>, <kraxel@redhat.com>, <cjia@nvidia.com>,
        <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        akrowiak@linux.ibm.com, pasic@linux.ibm.com, jjherne@linux.ibm.com,
        farman@linux.ibm.com, mjrosato@linux.ibm.com
Subject: Re: [PATCH] vfio/mdev: fix possible memory leak in module init
 funcs
Message-ID: <20221130160622.0cf3e47d.alex.williamson@redhat.com>
In-Reply-To: <20221118032827.3725190-1-ruanjinjie@huawei.com>
References: <20221118032827.3725190-1-ruanjinjie@huawei.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Cc +vfio-ap, vfio-ccw]

On Fri, 18 Nov 2022 11:28:27 +0800
ruanjinjie <ruanjinjie@huawei.com> wrote:

> Inject fault while probing module, if device_register() fails,
> but the refcount of kobject is not decreased to 0, the name
> allocated in dev_set_name() is leaked. Fix this by calling
> put_device(), so that name can be freed in callback function
> kobject_cleanup().
> 
> unreferenced object 0xffff88807d687008 (size 8):
>   comm "modprobe", pid 8280, jiffies 4294807686 (age 12.378s)
>   hex dump (first 8 bytes):
>     6d 64 70 79 00 6b 6b a5                          mdpy.kk.
>   backtrace:
>     [<ffffffff8174f19e>] __kmalloc_node_track_caller+0x4e/0x150
>     [<ffffffff81731d53>] kstrdup+0x33/0x60
>     [<ffffffff83aa1421>] kobject_set_name_vargs+0x41/0x110
>     [<ffffffff82d91abb>] dev_set_name+0xab/0xe0
>     [<ffffffffa0260105>] 0xffffffffa0260105
>     [<ffffffff81001c27>] do_one_initcall+0x87/0x2e0
>     [<ffffffff813739cb>] do_init_module+0x1ab/0x640
>     [<ffffffff81379d20>] load_module+0x5d00/0x77f0
>     [<ffffffff8137bc40>] __do_sys_finit_module+0x110/0x1b0
>     [<ffffffff83c944a5>] do_syscall_64+0x35/0x80
>     [<ffffffff83e0006a>] entry_SYSCALL_64_after_hwframe+0x46/0xb0
> 
> unreferenced object 0xffff888101ccbcf8 (size 8):
>   comm "modprobe", pid 15662, jiffies 4295164481 (age 13.282s)
>   hex dump (first 8 bytes):
>     6d 74 74 79 00 6b 6b a5                          mtty.kk.
>   backtrace:
>     [<ffffffff8174f19e>] __kmalloc_node_track_caller+0x4e/0x150
>     [<ffffffff81731d53>] kstrdup+0x33/0x60
>     [<ffffffff83aa1421>] kobject_set_name_vargs+0x41/0x110
>     [<ffffffff82d91abb>] dev_set_name+0xab/0xe0
>     [<ffffffffa0248134>] 0xffffffffa0248134
>     [<ffffffff81001c27>] do_one_initcall+0x87/0x2e0
>     [<ffffffff813739cb>] do_init_module+0x1ab/0x640
>     [<ffffffff81379d20>] load_module+0x5d00/0x77f0
>     [<ffffffff8137bc40>] __do_sys_finit_module+0x110/0x1b0
>     [<ffffffff83c944a5>] do_syscall_64+0x35/0x80
>     [<ffffffff83e0006a>] entry_SYSCALL_64_after_hwframe+0x46/0xb0
> 
> unreferenced object 0xffff88810177c6c8 (size 8):
>   comm "modprobe", pid 23657, jiffies 4295314656 (age 13.227s)
>   hex dump (first 8 bytes):
>     6d 62 6f 63 68 73 00 a5                          mbochs..
>   backtrace:
>     [<ffffffff8174f19e>] __kmalloc_node_track_caller+0x4e/0x150
>     [<ffffffff81731d53>] kstrdup+0x33/0x60
>     [<ffffffff83aa1421>] kobject_set_name_vargs+0x41/0x110
>     [<ffffffff82d91abb>] dev_set_name+0xab/0xe0
>     [<ffffffffa0248124>] 0xffffffffa0248124
>     [<ffffffff81001c27>] do_one_initcall+0x87/0x2e0
>     [<ffffffff813739cb>] do_init_module+0x1ab/0x640
>     [<ffffffff81379d20>] load_module+0x5d00/0x77f0
>     [<ffffffff8137bc40>] __do_sys_finit_module+0x110/0x1b0
>     [<ffffffff83c944a5>] do_syscall_64+0x35/0x80
>     [<ffffffff83e0006a>] entry_SYSCALL_64_after_hwframe+0x46/0xb0
> 
> Fixes: d61fc96f47fd ("sample: vfio mdev display - host device")
> Fixes: 9d1a546c53b4 ("docs: Sample driver to demonstrate how to use Mediated device framework.")
> Fixes: a5e6e6505f38 ("sample: vfio bochs vbe display (host device for bochs-drm)")
> Signed-off-by: ruanjinjie <ruanjinjie@huawei.com>
> ---
>  samples/vfio-mdev/mbochs.c | 4 +++-
>  samples/vfio-mdev/mdpy.c   | 4 +++-
>  samples/vfio-mdev/mtty.c   | 4 +++-
>  3 files changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/samples/vfio-mdev/mbochs.c b/samples/vfio-mdev/mbochs.c
> index 117a8d799f71..1c47672be815 100644
> --- a/samples/vfio-mdev/mbochs.c
> +++ b/samples/vfio-mdev/mbochs.c
> @@ -1430,8 +1430,10 @@ static int __init mbochs_dev_init(void)
>  	dev_set_name(&mbochs_dev, "%s", MBOCHS_NAME);
>  
>  	ret = device_register(&mbochs_dev);
> -	if (ret)
> +	if (ret) {
> +		put_device(&mbochs_dev);
>  		goto err_class;
> +	}
>  
>  	ret = mdev_register_parent(&mbochs_parent, &mbochs_dev, &mbochs_driver,
>  				   mbochs_mdev_types,


vfio-ap has a similar unwind as the sample drivers, but actually makes
an attempt to catch this ex:

	...
        ret = device_register(&matrix_dev->device);
        if (ret)
                goto matrix_reg_err;

        ret = driver_register(&matrix_driver);
        if (ret)
                goto matrix_drv_err;

        return 0;

matrix_drv_err:
        device_unregister(&matrix_dev->device);
matrix_reg_err:
        put_device(&matrix_dev->device);
	...

So of the vfio drivers calling device_register(), vfio-ap is the only
one that does a put_device() if device_register() fails, but it also
seems sketchy to call both device_unregister() and put_device() in the
case that we exit via matrix_drv_err.

I wonder if all of these shouldn't adopt a flow like:

	ret = device_register(&dev);
	if (ret)
		goto err1;

	....

	return 0;

err2:
	device_del(&dev);
err1:
	put_device(&dev);

Thanks,

Alex

> diff --git a/samples/vfio-mdev/mdpy.c b/samples/vfio-mdev/mdpy.c
> index 946e8cfde6fd..bfb93eaf535b 100644
> --- a/samples/vfio-mdev/mdpy.c
> +++ b/samples/vfio-mdev/mdpy.c
> @@ -717,8 +717,10 @@ static int __init mdpy_dev_init(void)
>  	dev_set_name(&mdpy_dev, "%s", MDPY_NAME);
>  
>  	ret = device_register(&mdpy_dev);
> -	if (ret)
> +	if (ret) {
> +		put_device(&mdpy_dev);
>  		goto err_class;
> +	}
>  
>  	ret = mdev_register_parent(&mdpy_parent, &mdpy_dev, &mdpy_driver,
>  				   mdpy_mdev_types,
> diff --git a/samples/vfio-mdev/mtty.c b/samples/vfio-mdev/mtty.c
> index e72085fc1376..dddb0619846c 100644
> --- a/samples/vfio-mdev/mtty.c
> +++ b/samples/vfio-mdev/mtty.c
> @@ -1330,8 +1330,10 @@ static int __init mtty_dev_init(void)
>  	dev_set_name(&mtty_dev.dev, "%s", MTTY_NAME);
>  
>  	ret = device_register(&mtty_dev.dev);
> -	if (ret)
> +	if (ret) {
> +		put_device(&mtty_dev.dev);
>  		goto err_class;
> +	}
>  
>  	ret = mdev_register_parent(&mtty_dev.parent, &mtty_dev.dev,
>  				   &mtty_driver, mtty_mdev_types,

