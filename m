Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3538962BECA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 13:58:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233530AbiKPM6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 07:58:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbiKPM6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 07:58:35 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EF481DA6D
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 04:57:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668603457;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=P3dZVUJWS9YfhEwx2MGdoRYm/+IpeyLBcM/mBcpGfB4=;
        b=JuduYWyQBfInGk6/jJYmx8xKweJNQsCB4j8LjFjOdVrK48snN2gjcBFfOlZ1kwh0nJkARu
        iX14B0aURaUVi6DVxwai+cRxODi2bczt1tEHszLsmNzTD1GzBCbrLhVqYQXwakW/fo/K1o
        Ob0U3Ge/yv8ACpE0HFGFN3+IFtAN3iY=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-44-ieqneteMMdyKe9UFW0VtYg-1; Wed, 16 Nov 2022 07:57:36 -0500
X-MC-Unique: ieqneteMMdyKe9UFW0VtYg-1
Received: by mail-oo1-f70.google.com with SMTP id g28-20020a4a251c000000b0049c515643ecso6516834ooa.14
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 04:57:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P3dZVUJWS9YfhEwx2MGdoRYm/+IpeyLBcM/mBcpGfB4=;
        b=uInPqfa8j0SocgvVAdDHudrHzZBlQEuGP1wmnae/905d3n9UZh2GV1uO1hx3kfDjp6
         YheFR1fO+9JIReY4EXK5nCYjj4u9tV9N55EupEJnV3Co8gdX0z3JJS8cEOmZ2pc2yTGb
         Ir4ikFAosahAmQUlJxSf/9f/AUcEkt7WOGVBT2Rz8qkzkY3BBX0lAqyOjflbYZv2U5rW
         xs0QmbE/Mcl0CeG9ebqie9W1IoSCRYbBsvmmdBTVDBXZ93AEYHlNRUpKy8XzgIoCY+t7
         NnP7E5uG1C/0WMqJZzfGkLtxJGjg0djREXGsukp4zQRFe/ihKd6oSakZF0GeCsy8voIP
         ehFg==
X-Gm-Message-State: ANoB5pnRA0t4HBXCbwdYcbYOS9cNCprJEItLvYgZBAgL7xZldeIYMfIk
        +H5dh6VmQwbHlgSH6F7BOZuGqmYg5ar1cwMWnM6y7gLuzN6NCBxlK/JzFxSWlOKxdNLg+GFbunH
        8lGhpXMjLdJZpAvtOHRBoJs8p
X-Received: by 2002:a05:6870:d8b:b0:13c:f48b:7cc4 with SMTP id mj11-20020a0568700d8b00b0013cf48b7cc4mr1578233oab.196.1668603453540;
        Wed, 16 Nov 2022 04:57:33 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4vPwsXILiXdWzuZ31PUaS5KlMLO/I2br8NXWKvphTq/eBqG58DOWNeUUld0J4wDgO9fsqGeQ==
X-Received: by 2002:a05:6870:d8b:b0:13c:f48b:7cc4 with SMTP id mj11-20020a0568700d8b00b0013cf48b7cc4mr1578215oab.196.1668603453333;
        Wed, 16 Nov 2022 04:57:33 -0800 (PST)
Received: from halaney-x13s ([2600:1700:1ff0:d0e0::41])
        by smtp.gmail.com with ESMTPSA id g8-20020a056870d20800b0012d6f3d370bsm7848854oac.55.2022.11.16.04.57.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 04:57:32 -0800 (PST)
Date:   Wed, 16 Nov 2022 06:57:30 -0600
From:   Andrew Halaney <ahalaney@redhat.com>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Brian Masney <bmasney@redhat.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        John Stultz <jstultz@google.com>,
        Peter Robinson <pbrobinson@redhat.com>,
        Enric Balletbo i Serra <eballetbo@redhat.com>,
        Steev Klimaszewski <steev@kali.org>,
        Rob Herring <robh@kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        linux-arm-msm@vger.kernel.org,
        Saravana Kannan <saravanak@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 1/4] driver core: Make driver_deferred_probe_timeout a
 static variable
Message-ID: <20221116125730.mvah5kxbxrll6ls4@halaney-x13s>
References: <20221116115348.517599-1-javierm@redhat.com>
 <20221116115348.517599-2-javierm@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221116115348.517599-2-javierm@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2022 at 12:53:45PM +0100, Javier Martinez Canillas wrote:
> It is not used outside of its compilation unit, so there's no need to
> export this variable.
> 
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>

Reviewed-by: Andrew Halaney <ahalaney@redhat.com>

> ---
> 
> (no changes since v1)
> 
>  drivers/base/dd.c             | 6 ++----
>  include/linux/device/driver.h | 1 -
>  2 files changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index 3dda62503102..040b4060f903 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -257,13 +257,11 @@ static int deferred_devs_show(struct seq_file *s, void *data)
>  DEFINE_SHOW_ATTRIBUTE(deferred_devs);
>  
>  #ifdef CONFIG_MODULES
> -int driver_deferred_probe_timeout = 10;
> +static int driver_deferred_probe_timeout = 10;
>  #else
> -int driver_deferred_probe_timeout;
> +static int driver_deferred_probe_timeout;
>  #endif
>  
> -EXPORT_SYMBOL_GPL(driver_deferred_probe_timeout);
> -
>  static int __init deferred_probe_timeout_setup(char *str)
>  {
>  	int timeout;
> diff --git a/include/linux/device/driver.h b/include/linux/device/driver.h
> index 2114d65b862f..50d0a416a5e7 100644
> --- a/include/linux/device/driver.h
> +++ b/include/linux/device/driver.h
> @@ -240,7 +240,6 @@ driver_find_device_by_acpi_dev(struct device_driver *drv, const void *adev)
>  }
>  #endif
>  
> -extern int driver_deferred_probe_timeout;
>  void driver_deferred_probe_add(struct device *dev);
>  int driver_deferred_probe_check_state(struct device *dev);
>  void driver_init(void);
> -- 
> 2.38.1
> 

