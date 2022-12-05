Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CBA46420E2
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 01:54:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbiLEAx7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 19:53:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231164AbiLEAx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 19:53:58 -0500
Received: from post.baikalelectronics.com (post.baikalelectronics.com [213.79.110.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D36BF6369
        for <linux-kernel@vger.kernel.org>; Sun,  4 Dec 2022 16:53:52 -0800 (PST)
Received: from post.baikalelectronics.com (localhost.localdomain [127.0.0.1])
        by post.baikalelectronics.com (Proxmox) with ESMTP id B8928E0E70;
        Mon,  5 Dec 2022 03:53:50 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        baikalelectronics.ru; h=cc:cc:content-type:content-type:date
        :from:from:in-reply-to:message-id:mime-version:references
        :reply-to:subject:subject:to:to; s=post; bh=hFlIYXLtWgwf3BvbLddd
        MFkfFhyY6ZIiyrxUPGfhk5s=; b=gyj7fcRzVUHBbQFHq/iPsuXVCPDf+M8A7rZx
        02uDjFBHnp9k2YTH2Sv+tkAr91bPr+UfmkY0us5vRvaGA1PDlt89t4mRoZXY2Z7j
        ykULN48oZnavY5gDm9z758S+VXNgE5YmMhwfLtwUEbd0PwuTR+LGx/PY9OChuKIw
        kJXVfnc=
Received: from mail.baikal.int (mail.baikal.int [192.168.51.25])
        by post.baikalelectronics.com (Proxmox) with ESMTP id 925F0E0E6A;
        Mon,  5 Dec 2022 03:53:50 +0300 (MSK)
Received: from mobilestation (10.8.30.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 5 Dec 2022 03:53:50 +0300
Date:   Mon, 5 Dec 2022 03:53:49 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     <ye.xingchen@zte.com.cn>
CC:     <arnd@arndb.de>, <linux-kernel@vger.kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>
Subject: Re: [PATCH] bus: use sysfs_emit() to instead of scnprintf()
Message-ID: <20221205005349.ubqkmx6z5c4edmoi@mobilestation>
References: <202212010938142826551@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <202212010938142826551@zte.com.cn>
X-Originating-IP: [10.8.30.10]
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 01, 2022 at 09:38:14AM +0800, ye.xingchen@zte.com.cn wrote:
> From: ye xingchen <ye.xingchen@zte.com.cn>
> 
> Replace the open-code with sysfs_emit() to simplify the code.

Nice cleanup. Thanks.
Acked-by: Serge Semin <fancer.lancer@gmail.com>

* One note. Next time please use the scripts/get_maintainer.pl script
to get the driver maintainers list and their actual email addresses.

-Sergey

> 
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
> ---
>  drivers/bus/bt1-apb.c | 6 +++---
>  drivers/bus/bt1-axi.c | 4 ++--
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/bus/bt1-apb.c b/drivers/bus/bt1-apb.c
> index 63b1b4a76671..bcf10f1d6dc1 100644
> --- a/drivers/bus/bt1-apb.c
> +++ b/drivers/bus/bt1-apb.c
> @@ -265,7 +265,7 @@ static ssize_t count_show(struct device *dev, struct device_attribute *attr,
>  {
>  	struct bt1_apb *apb = dev_get_drvdata(dev);
> 
> -	return scnprintf(buf, PAGE_SIZE, "%d\n", atomic_read(&apb->count));
> +	return sysfs_emit(buf, "%d\n", atomic_read(&apb->count));
>  }
>  static DEVICE_ATTR_RO(count);
> 
> @@ -283,7 +283,7 @@ static ssize_t timeout_show(struct device *dev, struct device_attribute *attr,
> 
>  	timeout = bt1_apb_n_to_timeout_us(apb, n);
> 
> -	return scnprintf(buf, PAGE_SIZE, "%lu\n", timeout);
> +	return sysfs_emit(buf, "%lu\n", timeout);
>  }
> 
>  static ssize_t timeout_store(struct device *dev,
> @@ -310,7 +310,7 @@ static DEVICE_ATTR_RW(timeout);
>  static ssize_t inject_error_show(struct device *dev,
>  				 struct device_attribute *attr, char *buf)
>  {
> -	return scnprintf(buf, PAGE_SIZE, "Error injection: nodev irq\n");
> +	return sysfs_emit(buf, "Error injection: nodev irq\n");
>  }
> 
>  static ssize_t inject_error_store(struct device *dev,
> diff --git a/drivers/bus/bt1-axi.c b/drivers/bus/bt1-axi.c
> index 70e49a6e5374..04c14821bb3c 100644
> --- a/drivers/bus/bt1-axi.c
> +++ b/drivers/bus/bt1-axi.c
> @@ -197,14 +197,14 @@ static ssize_t count_show(struct device *dev,
>  {
>  	struct bt1_axi *axi = dev_get_drvdata(dev);
> 
> -	return scnprintf(buf, PAGE_SIZE, "%d\n", atomic_read(&axi->count));
> +	return sysfs_emit(buf, "%d\n", atomic_read(&axi->count));
>  }
>  static DEVICE_ATTR_RO(count);
> 
>  static ssize_t inject_error_show(struct device *dev,
>  				 struct device_attribute *attr, char *buf)
>  {
> -	return scnprintf(buf, PAGE_SIZE, "Error injection: bus unaligned\n");
> +	return sysfs_emit(buf, "Error injection: bus unaligned\n");
>  }
> 
>  static ssize_t inject_error_store(struct device *dev,
> -- 
> 2.25.1
> 

