Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 015D66B84E5
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 23:42:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbjCMWmA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 18:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbjCMWl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 18:41:58 -0400
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F07935A910
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 15:41:56 -0700 (PDT)
Received: by mail-wm1-f45.google.com with SMTP id o38-20020a05600c512600b003e8320d1c11so21350wms.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 15:41:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678747315;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q0prISumv60O78Q0W09lVk3OVYBserufQK67bum629w=;
        b=GdH/lyByxkM/uL+ZfmYzkHJY0FrWWi5agkp84uXw8qm0PxItdS9/RRhXHcE8iL79B9
         M3eq8jVqNszKcY0burp6LOqAWKeg5nlXYsZrD+hLG5gLOTIDINd+QHKH8dQpxYOV2S+E
         o/9Meo573iFmkoLV5e+nU8ybaRYVaFC2zzJdypSdY2RGFiId8y6dOgSabFM+hYsFJZT7
         XXUSIe8gDbzi0KCrSOMO9FapnSwIZHsuf5CCgW2uMt7+ar/Fxo21nCZS/5dxJGWRhbVP
         3+ATMFuGfOnwG4Ii+HdLfe/91voOH2d2I5evTBVVnWWkKkNSCTY9/ScIFKX3+xoVLcXh
         NjOg==
X-Gm-Message-State: AO0yUKUms8+6nXDtcgubJj12apF6bZAgwZIwVKs7CEJpUNh3g1VxRnAp
        bcRwLEjWOoqR2Zp1c21gVo4=
X-Google-Smtp-Source: AK7set+w5FNyuszjQ7bQi3fgWWAE9UWyu3nq8KmzXf7svgRUqhegsM4GIKSId+OkM1dhp+rIOzpe4w==
X-Received: by 2002:a05:600c:1d24:b0:3da:1f6a:7b36 with SMTP id l36-20020a05600c1d2400b003da1f6a7b36mr11868089wms.0.1678747315316;
        Mon, 13 Mar 2023 15:41:55 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id l8-20020a05600c4f0800b003db01178b62sm1024178wmq.40.2023.03.13.15.41.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 15:41:54 -0700 (PDT)
Date:   Mon, 13 Mar 2023 22:41:50 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, rafael@kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Alex Shi <alexs@kernel.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Alexandre Bounine <alex.bou9@gmail.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dexuan Cui <decui@microsoft.com>,
        Eric Dumazet <edumazet@google.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Hannes Reinecke <hare@suse.de>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Hu Haowen <src.res@email.cn>,
        Ilya Dryomov <idryomov@gmail.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Iwona Winiarska <iwona.winiarska@intel.com>,
        Jakub Kicinski <kuba@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Jonathan Corbet <corbet@lwn.net>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Matt Porter <mporter@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paolo Abeni <pabeni@redhat.com>,
        Stuart Yoder <stuyoder@gmail.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Wei Liu <wei.liu@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>
Subject: Re: [PATCH 23/36] driver core: bus: mark the struct bus_type for
 sysfs callbacks as constant
Message-ID: <ZA+mroPKki9/iUkT@liuwe-devbox-debian-v2>
References: <20230313182918.1312597-1-gregkh@linuxfoundation.org>
 <20230313182918.1312597-23-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230313182918.1312597-23-gregkh@linuxfoundation.org>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 13, 2023 at 07:29:05PM +0100, Greg Kroah-Hartman wrote:
> struct bus_type should never be modified in a sysfs callback as there is
> nothing in the structure to modify, and frankly, the structure is almost
> never used in a sysfs callback, so mark it as constant to allow struct
> bus_type to be moved to read-only memory.
[...]
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index d24dd65b33d4..513adba09f56 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -684,7 +684,7 @@ static const struct attribute_group vmbus_dev_group = {
>  __ATTRIBUTE_GROUPS(vmbus_dev);
>  
>  /* Set up the attribute for /sys/bus/vmbus/hibernation */
> -static ssize_t hibernation_show(struct bus_type *bus, char *buf)
> +static ssize_t hibernation_show(const struct bus_type *bus, char *buf)
>  {
>  	return sprintf(buf, "%d\n", !!hv_is_hibernation_supported());
>  }

Acked-by: Wei Liu <wei.liu@kernel.org>
