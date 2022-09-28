Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3A9F5EE02E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 17:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234560AbiI1PXa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 11:23:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234073AbiI1PXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 11:23:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C50CC8FA
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 08:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664378499;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xDmQ1DANCDaUuqhIrlX3xlqcUcfbmIgkqlY33q/Kj78=;
        b=O8CnQkqr27I+aVBdxDI8iXf7Ts0Cjd/tQyAJHQwsOKp61BRfkB81GOFeLqNfna5oaJeSWZ
        UhK+ZNJdcOo7iLoSDVPOVJ9JwVWJqbWewf2XKIwWuIMdbRmhq2/YVutJfPhnTeXwH0bX5+
        HIadFpc/IbgSIRBYJN+RbQ+2F7o31kQ=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-549-2vddpuvWMBqekcPltCFdUA-1; Wed, 28 Sep 2022 11:21:23 -0400
X-MC-Unique: 2vddpuvWMBqekcPltCFdUA-1
Received: by mail-qt1-f197.google.com with SMTP id e22-20020ac84b56000000b0035bb64ad562so9139212qts.17
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 08:21:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=xDmQ1DANCDaUuqhIrlX3xlqcUcfbmIgkqlY33q/Kj78=;
        b=2QL5ss4q1fdAI4MAlQDxlC+mDaYwelZgy3DwuYHaJtpuCsXXvW/BnuH+8GjKcnqink
         Ijn8d1f2qYOGLQif7cDOd8nfXgohKdhCnuCfeQfMngMwM2ZoiNJZ2+XlFsHamaaWZa8F
         HkzSdfo5uGYsNGpP6ZdKpMMv/xZOkhEkPAIfAv5QvCVwwjBveQ9eordg14RX++9MZ5/Q
         m9rSpHwUeixp45SyGDQXjn18uyp3vRAs4whK2vGeUue5rtoM+LaeQhjRYxryJ7WzH3R7
         Vj/jOtYOAzyK3KlGmPIwNXa/Wk2vl3C+rdv2JieBm8ORH5S/6xovDyH3eKTL+z2XmHjV
         1Esw==
X-Gm-Message-State: ACrzQf1pyudorOFt3dnfflhErOpWrRUWm1sdsmapL3LHglOlBOb4aX+Q
        IQsWg6Uj6IKwCH3Fw/VlXuqqWNbNchwrxKV64ESHehpCIXNWaxvLy5BCpdo9xqC6G7EgjuqzgH1
        GbL6lOJ/hUXGetsZ7VVY50pRT0gJ2WRN/ojbiSmb5+QpGHjFwBJHGbMsaunv2uG+NXke4dV3YEE
        Me
X-Received: by 2002:a05:6214:1bcd:b0:4af:646a:9793 with SMTP id m13-20020a0562141bcd00b004af646a9793mr15914892qvc.94.1664378482433;
        Wed, 28 Sep 2022 08:21:22 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM73nezA3iYhO9c31xv3DWn4iUg7lZDa1ELdpZgByCB9Ae6jn/htBUoq53tpR7IwUkbPk7tmyw==
X-Received: by 2002:a05:6214:1bcd:b0:4af:646a:9793 with SMTP id m13-20020a0562141bcd00b004af646a9793mr15914858qvc.94.1664378482032;
        Wed, 28 Sep 2022 08:21:22 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id m17-20020a05620a24d100b006cbcdc6efedsm3314206qkn.41.2022.09.28.08.21.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 08:21:21 -0700 (PDT)
Date:   Wed, 28 Sep 2022 08:21:20 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH 2/2] dmaengine: idxd: track enabled workqueues in bitmap
Message-ID: <20220928152120.3wsvc4iungzsmryn@cantor>
References: <20220919215553.600246-1-jsnitsel@redhat.com>
 <20220919215553.600246-3-jsnitsel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220919215553.600246-3-jsnitsel@redhat.com>
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 19, 2022 at 02:55:53PM -0700, Jerry Snitselaar wrote:
> Now that idxd_wq_disable_cleanup() sets the workqueue state to
> IDXD_WQ_DISABLED, use a bitmap to track which workqueues have been
> enabled. This will then be used to determine which workqueues
> should be re-enabled when attempting a software reset to recover
> from a device halt state.
> 
> Cc: Fenghua Yu <fenghua.yu@intel.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Vinod Koul <vkoul@kernel.org>
> Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
> ---
>  drivers/dma/idxd/device.c | 2 ++
>  drivers/dma/idxd/idxd.h   | 2 ++
>  drivers/dma/idxd/init.c   | 6 ++++++
>  drivers/dma/idxd/irq.c    | 4 ++--
>  drivers/dma/idxd/sysfs.c  | 1 +
>  5 files changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
> index 31911e255ac1..f0c7d6d348e3 100644
> --- a/drivers/dma/idxd/device.c
> +++ b/drivers/dma/idxd/device.c
> @@ -196,6 +196,7 @@ int idxd_wq_enable(struct idxd_wq *wq)
>  	}
>  
>  	wq->state = IDXD_WQ_ENABLED;
> +	set_bit(wq->id, idxd->wq_enable_map);
>  	dev_dbg(dev, "WQ %d enabled\n", wq->id);
>  	return 0;
>  }
> @@ -223,6 +224,7 @@ int idxd_wq_disable(struct idxd_wq *wq, bool reset_config)
>  
>  	if (reset_config)
>  		idxd_wq_disable_cleanup(wq);
> +	clear_bit(wq->id, idxd->wq_enable_map);
>  	wq->state = IDXD_WQ_DISABLED;
>  	dev_dbg(dev, "WQ %d disabled\n", wq->id);
>  	return 0;
> diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
> index fed0dfc1eaa8..f527a7f88b92 100644
> --- a/drivers/dma/idxd/idxd.h
> +++ b/drivers/dma/idxd/idxd.h
> @@ -11,6 +11,7 @@
>  #include <linux/idr.h>
>  #include <linux/pci.h>
>  #include <linux/ioasid.h>
> +#include <linux/bitmap.h>
>  #include <linux/perf_event.h>
>  #include <uapi/linux/idxd.h>
>  #include "registers.h"
> @@ -299,6 +300,7 @@ struct idxd_device {
>  	int rdbuf_limit;
>  	int nr_rdbufs;		/* non-reserved read buffers */
>  	unsigned int wqcfg_size;
> +	unsigned long *wq_enable_map;
>  
>  	union sw_err_reg sw_err;
>  	wait_queue_head_t cmd_waitq;
> diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
> index aa3478257ddb..7e27e69ff741 100644
> --- a/drivers/dma/idxd/init.c
> +++ b/drivers/dma/idxd/init.c
> @@ -151,6 +151,12 @@ static int idxd_setup_wqs(struct idxd_device *idxd)
>  	if (!idxd->wqs)
>  		return -ENOMEM;
>  
> +	idxd->wq_enable_map = bitmap_zalloc_node(idxd->max_wqs, GFP_KERNEL, dev_to_node(dev));
> +	if (!idxd->wq_enable_map) {
> +		kfree(idxd->wqs);
> +		return -ENOMEM;
> +	}
> +
>  	for (i = 0; i < idxd->max_wqs; i++) {
>  		wq = kzalloc_node(sizeof(*wq), GFP_KERNEL, dev_to_node(dev));
>  		if (!wq) {
> diff --git a/drivers/dma/idxd/irq.c b/drivers/dma/idxd/irq.c
> index 743ead5ebc57..8efaf137fc65 100644
> --- a/drivers/dma/idxd/irq.c
> +++ b/drivers/dma/idxd/irq.c
> @@ -49,9 +49,9 @@ static void idxd_device_reinit(struct work_struct *work)
>  		goto out;
>  
>  	for (i = 0; i < idxd->max_wqs; i++) {
> -		struct idxd_wq *wq = idxd->wqs[i];
> +		if (test_bit(i, idxd->wq_enable_map)) {
> +			struct idxd_wq *wq = idxd->wqs[i];
>  
> -		if (wq->state == IDXD_WQ_ENABLED) {
>  			rc = idxd_wq_enable(wq);
>  			if (rc < 0) {
>  				dev_warn(dev, "Unable to re-enable wq %s\n",

Hi Dave and Fenghua,

Thinking about this last night, this should probably clear the bit here in
the case where an error is returned from idxd_wq_enable here, yes? I can
send a v2.


> diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
> index 3f262a57441b..3325b16ed959 100644
> --- a/drivers/dma/idxd/sysfs.c
> +++ b/drivers/dma/idxd/sysfs.c
> @@ -1405,6 +1405,7 @@ static void idxd_conf_device_release(struct device *dev)
>  	struct idxd_device *idxd = confdev_to_idxd(dev);
>  
>  	kfree(idxd->groups);
> +	bitmap_free(idxd->wq_enable_map);
>  	kfree(idxd->wqs);
>  	kfree(idxd->engines);
>  	ida_free(&idxd_ida, idxd->id);
> -- 
> 2.37.2
> 

