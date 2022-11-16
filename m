Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9656C62C530
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 17:45:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238758AbiKPQo6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 11:44:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238923AbiKPQo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 11:44:27 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99A841A820
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 08:39:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668616776;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MKOWgS4WzWGeD29Cp2SqGUWIo6TLQiVsvbTZsJFncDE=;
        b=BP49K4q8fcxI1yRwlaPSYxANCcrdl/6uBZUXz3HHzIWBlfn8RH9MekLOS70sIXuZjDZ5aC
        7ejs0CL/cIa65HtKhy8ij5QbtcCCZPAon7BqE8TZzRZpVyCAPzIwQlJ1xC0DFfhhii3uBG
        jvfFqqXiqr2jSqiIrbnqV7gLRLIXIkQ=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-468-gjXVqh4APiuoZ6kgxVQbLg-1; Wed, 16 Nov 2022 11:39:35 -0500
X-MC-Unique: gjXVqh4APiuoZ6kgxVQbLg-1
Received: by mail-oi1-f200.google.com with SMTP id z19-20020a056808029300b0035a774ed30aso6285678oic.20
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 08:39:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MKOWgS4WzWGeD29Cp2SqGUWIo6TLQiVsvbTZsJFncDE=;
        b=UzKz7v+XlXlxvE4jGyU98g5Ptgt6GUHcnJAWDweOqh4sqoVVmm7UEcUTY30+lCJxGX
         QYUJMdaztORojAWRY2DcUOFmWiWFNKz8fH8p0nGdpgJubtjdyPriu8N2jwV9Vc8RE+HC
         dVVYqB8HAcg/xEPdMcVPTy/VLx5zNJGbG0qp9E5Vx47YZD7jKNzRvUBsuR+WQ5XrgYND
         b0BbNXZdKOzRhbQsAImAmgYdDqJOmoB2K2hIscQLJMeFR5RkvcYMlTQbkC/CQpIt3b9o
         bRiTP6rJmdld24EjEPZ0zKWfW+0yEi0skSN7Y8H4H/6AzlQ4KnbCYutZtwQVkK9j6xSc
         suKw==
X-Gm-Message-State: ANoB5pkxeUgozkrcs4UDvJ1NOr7Tg+jDf5wmshQlpjpEcuo6DJMcb4GG
        J0lgyX8P8rPpf51sSVnt7lDd/7VtTgFlMTPNAgXdmQM1RxGv3go/5u8Zk/UdHso7Y6J1PAx+mtb
        G04ctyfIIhPGao2LN2WJFNiHa
X-Received: by 2002:a05:6808:e8f:b0:354:faf3:50da with SMTP id k15-20020a0568080e8f00b00354faf350damr1980353oil.277.1668616774735;
        Wed, 16 Nov 2022 08:39:34 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6vju2UH23y6HBeQfTVdhTw+4CIus9JPj07In0i4uuXVN8AgOK8z5b0UgszlTIBqN39zYn3oA==
X-Received: by 2002:a05:6808:e8f:b0:354:faf3:50da with SMTP id k15-20020a0568080e8f00b00354faf350damr1980334oil.277.1668616774459;
        Wed, 16 Nov 2022 08:39:34 -0800 (PST)
Received: from halaney-x13s ([2600:1700:1ff0:d0e0::41])
        by smtp.gmail.com with ESMTPSA id e18-20020a9d7312000000b0066c3bbe927esm6804869otk.21.2022.11.16.08.39.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 08:39:34 -0800 (PST)
Date:   Wed, 16 Nov 2022 10:39:31 -0600
From:   Andrew Halaney <ahalaney@redhat.com>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Saravana Kannan <saravanak@google.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        linux-arm-msm@vger.kernel.org, John Stultz <jstultz@google.com>,
        Peter Robinson <pbrobinson@redhat.com>,
        Steev Klimaszewski <steev@kali.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Enric Balletbo i Serra <eballetbo@redhat.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Brian Masney <bmasney@redhat.com>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 2/4] driver core: Set deferred probe timeout to 0 if
 modules are disabled
Message-ID: <20221116163931.ob7szcnjx65c7gz7@halaney-x13s>
References: <20221116115348.517599-1-javierm@redhat.com>
 <20221116120043.519614-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221116120043.519614-1-javierm@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2022 at 01:00:43PM +0100, Javier Martinez Canillas wrote:
> There is no point to schedule the work queue to timeout the deferred probe
> if all the initcalls are done and modules are not enabled. The default for
> this case is already 0 but can be overridden by the deferred_probe_timeout
> parameter. Let's just disable to avoid queuing a work that is not needed.
> 
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> ---
> 
> (no changes since v1)
> 
>  drivers/base/dd.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index 040b4060f903..1e8f1afeac98 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -350,8 +350,10 @@ static int deferred_probe_initcall(void)
>  	flush_work(&deferred_probe_work);
>  	initcalls_done = true;
>  
> -	if (!IS_ENABLED(CONFIG_MODULES))
> +	if (!IS_ENABLED(CONFIG_MODULES)) {
> +		driver_deferred_probe_timeout = 0;
>  		fw_devlink_drivers_done();
> +	}
>  

Potentially a stupid suggestion, but would it make sense to take out
the ability to actually set that param if !CONFIG_MODULES? Then
driver_deferred_probe_timeout would be the default value already.

>  	/*
>  	 * Trigger deferred probe again, this time we won't defer anything
> -- 
> 2.38.1
> 

