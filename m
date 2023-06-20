Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09CCB736FC4
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 17:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233183AbjFTPGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 11:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232881AbjFTPGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 11:06:11 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7421C95
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 08:06:09 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-5728df0a7d9so38182667b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 08:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687273568; x=1689865568;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M7HRYRUpKPOPse2tXMEV0Yq8b6ZSnqJ+PgMEIBRmNbo=;
        b=KdB1g1hIC4JXwor25dWvQhIY9iA1Z/HcjggxeojGoh6XTmMk4FzWDOeQRchA7RJdRQ
         f3ETTij+EX4+MUPsicFJw0yt69qa+KTkWCgqD2ZHi7M86Uj0NiLyLN3hTcbA9R/epSlW
         Ly/51wZ6adxwBHMCOVB8bAmp/hzlgUAXMVyrrsGBaK77x11z31jmu1ycb0YmuAVdbif/
         W7G4P/sL56eI5shPJCygI0PAYzT080pGh8CqUDEVk+I3m1vpw6nIXoAPGBaBWS+yi8RX
         c3UWg83aS0HuBHPQwvkpI/N65uefJCBK5jnKLdePHFdmTPk4ksG9+O2qHAncY9vJ05/s
         PzWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687273568; x=1689865568;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=M7HRYRUpKPOPse2tXMEV0Yq8b6ZSnqJ+PgMEIBRmNbo=;
        b=dqEw1nyrkemibiemd71ZETEM2ylymQmKhUj5ki9Dj855acI43PaPmyHAnq7VjdGyMa
         sEDn+xAwNkCWCLs5v6jCQIYRxQcspCPItqqF7oBNsz8VL+DoGFTI/fV+vICmHyjgHKgc
         o61P0D+/ZC0L9ss7iEvPyrpmdrEHRoB/k1JoGjtQfpkVR/jlhUy2IWeAzze8FdDbxPfD
         N3uAPtfSFv6sca4kFMFOlTG/E7gqEALDmFQkhsAj2iLmK7eqDioySqoB3LfumuuPMgeE
         8MIAg38UDNc8yVifJoL/NqdeRT4pGR6ka/swp3h7mYtwqvZZXrIltTik3uoCflMZHmzA
         br2g==
X-Gm-Message-State: AC+VfDz6+1bRHWDbqA5cHXpyFSmyHN2TS2Jf9HgrNbZNUH0QyGVlVFpn
        sG6q7mlnKP4EBs9ZKwaMInplM+QgzA==
X-Google-Smtp-Source: ACHHUZ7rKUDEwUmSQwSQdPCfFs4voZe9/PQFV4vZ/KgBBgbWBmFyZ9C7jhCjot+0QMa/X49kgyJa4w==
X-Received: by 2002:a81:bf52:0:b0:570:17e5:e536 with SMTP id s18-20020a81bf52000000b0057017e5e536mr14142882ywk.36.1687273568416;
        Tue, 20 Jun 2023 08:06:08 -0700 (PDT)
Received: from serve.minyard.net ([47.184.157.108])
        by smtp.gmail.com with ESMTPSA id y142-20020a0dd694000000b005707fb5110bsm533462ywd.58.2023.06.20.08.06.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 08:06:07 -0700 (PDT)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from mail.minyard.net (unknown [IPv6:2001:470:b8f6:1b:3c66:2774:dcfe:891a])
        by serve.minyard.net (Postfix) with ESMTPSA id EFF741800E8;
        Tue, 20 Jun 2023 15:06:06 +0000 (UTC)
Date:   Tue, 20 Jun 2023 10:06:05 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Ivan Orlov <ivan.orlov0322@gmail.com>,
        openipmi-developer@lists.sourceforge.net
Subject: Re: [PATCH] ipmi: make ipmi_class a static const structure
Message-ID: <ZJHAXakwV6slpZB/@mail.minyard.net>
Reply-To: minyard@acm.org
References: <20230620143701.577657-2-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230620143701.577657-2-gregkh@linuxfoundation.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2023 at 04:37:02PM +0200, Greg Kroah-Hartman wrote:
> From: Ivan Orlov <ivan.orlov0322@gmail.com>
> 
> Now that the driver core allows for struct class to be in read-only
> memory, move the ipmi_class structure to be declared at build time
> placing it into read-only memory, instead of having to be dynamically
> allocated at boot time.

This is in my next tree and seems to work fine.  Thanks.

-corey

> 
> Cc: Corey Minyard <minyard@acm.org>
> Cc: openipmi-developer@lists.sourceforge.net
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/char/ipmi/ipmi_devintf.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/char/ipmi/ipmi_devintf.c b/drivers/char/ipmi/ipmi_devintf.c
> index 73e5a9e28f85..332082e02ea5 100644
> --- a/drivers/char/ipmi/ipmi_devintf.c
> +++ b/drivers/char/ipmi/ipmi_devintf.c
> @@ -807,7 +807,9 @@ struct ipmi_reg_list {
>  static LIST_HEAD(reg_list);
>  static DEFINE_MUTEX(reg_list_mutex);
>  
> -static struct class *ipmi_class;
> +static const struct class ipmi_class = {
> +	.name = "ipmi",
> +};
>  
>  static void ipmi_new_smi(int if_num, struct device *device)
>  {
> @@ -822,7 +824,7 @@ static void ipmi_new_smi(int if_num, struct device *device)
>  	entry->dev = dev;
>  
>  	mutex_lock(&reg_list_mutex);
> -	device_create(ipmi_class, device, dev, NULL, "ipmi%d", if_num);
> +	device_create(&ipmi_class, device, dev, NULL, "ipmi%d", if_num);
>  	list_add(&entry->link, &reg_list);
>  	mutex_unlock(&reg_list_mutex);
>  }
> @@ -840,7 +842,7 @@ static void ipmi_smi_gone(int if_num)
>  			break;
>  		}
>  	}
> -	device_destroy(ipmi_class, dev);
> +	device_destroy(&ipmi_class, dev);
>  	mutex_unlock(&reg_list_mutex);
>  }
>  
> @@ -860,15 +862,13 @@ static int __init init_ipmi_devintf(void)
>  
>  	pr_info("ipmi device interface\n");
>  
> -	ipmi_class = class_create("ipmi");
> -	if (IS_ERR(ipmi_class)) {
> -		pr_err("ipmi: can't register device class\n");
> -		return PTR_ERR(ipmi_class);
> -	}
> +	rv = class_register(&ipmi_class);
> +	if (rv)
> +		return rv;
>  
>  	rv = register_chrdev(ipmi_major, DEVICE_NAME, &ipmi_fops);
>  	if (rv < 0) {
> -		class_destroy(ipmi_class);
> +		class_unregister(&ipmi_class);
>  		pr_err("ipmi: can't get major %d\n", ipmi_major);
>  		return rv;
>  	}
> @@ -880,7 +880,7 @@ static int __init init_ipmi_devintf(void)
>  	rv = ipmi_smi_watcher_register(&smi_watcher);
>  	if (rv) {
>  		unregister_chrdev(ipmi_major, DEVICE_NAME);
> -		class_destroy(ipmi_class);
> +		class_unregister(&ipmi_class);
>  		pr_warn("ipmi: can't register smi watcher\n");
>  		return rv;
>  	}
> @@ -895,11 +895,11 @@ static void __exit cleanup_ipmi(void)
>  	mutex_lock(&reg_list_mutex);
>  	list_for_each_entry_safe(entry, entry2, &reg_list, link) {
>  		list_del(&entry->link);
> -		device_destroy(ipmi_class, entry->dev);
> +		device_destroy(&ipmi_class, entry->dev);
>  		kfree(entry);
>  	}
>  	mutex_unlock(&reg_list_mutex);
> -	class_destroy(ipmi_class);
> +	class_unregister(&ipmi_class);
>  	ipmi_smi_watcher_unregister(&smi_watcher);
>  	unregister_chrdev(ipmi_major, DEVICE_NAME);
>  }
> -- 
> 2.41.0
> 
