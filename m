Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19BC172AC5C
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 16:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234960AbjFJOjJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 10:39:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjFJOjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 10:39:07 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6184B30E8;
        Sat, 10 Jun 2023 07:39:06 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1b39d67ea37so5472175ad.1;
        Sat, 10 Jun 2023 07:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686407946; x=1688999946;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2qopnUmixAlEvP9yxsQYqJj5bG7AmKHZ/6sELnX42H8=;
        b=ZdE2YLOTcbyc6PpFjkmgx3+/CngX9h3/j6lDjBEa/rq1+4+nHL9A3lHgi4uYoReT8z
         NsfriXBi1GJb5bVj9xJWpQxWApUs/1vOvWn1PyNiblHq/yuMr0FWcy6WKDhoT3oNJe52
         9pR6SYw8L//3245SVUY6JBPqXheUqCyWj9xdeglCDj4huGp3ZpjRWpcUGA69tfsyR3Jk
         fK7JaahGNLjscgl7criBCcqhfp4o3cYJO60WV9oBp9VbOv+Mk7kG6r+0CRy7rnRuQsv9
         93LgVumOXiLQLMafKZdbXRGl6yMweiJmYvBUj1uZwT1qo90VKOTCPnkYdxsh2Mc9Qtm4
         I7Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686407946; x=1688999946;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2qopnUmixAlEvP9yxsQYqJj5bG7AmKHZ/6sELnX42H8=;
        b=LTbaAY7EfMkv1ERUsEGwvlOF0NNN6kjweV9L/v7xDQY1/fS0FxHdrbLjn2XRdbZLx7
         lSphAr1aohl9vAF7aRwj+xCpFlvYVVE6d4PiREZqo7KJmnkgU+huxojDYWcKcn/OUcRk
         DNndt2G+g0gbkbQ0h+50zoJSCoF1CSzpGd0XjqmP39mq9zXZBsS73Ahoyzmrw8EqYgRH
         WXkhAU7O4y0nAoK1B1Oc7ZhVLXuAnYPPpgV/3CeFtSGI46QD0M7CEb85zDbN5nZG1R53
         JoVsIhn6QTVQRyViVnPt+8nxxW9b0vqkc6SqpViKp/Q0l9IaSg3sKg7T60FJYa6DhBdm
         k8UQ==
X-Gm-Message-State: AC+VfDxppX2Hm/lvf17DH1TyvDn5wz6UMeogzcoWRq/7ZScstmPUWkrm
        ME2Omcv3k7jxsCgwTmwfdsc=
X-Google-Smtp-Source: ACHHUZ5Z/BtdYjB3c1V/mcqJqbzIASBeXrjux+w7gQXgzxmlDEM+pXVTnOu3vb5AcRNf6DYhKCrINw==
X-Received: by 2002:a17:903:2285:b0:1a3:cd4c:8d08 with SMTP id b5-20020a170903228500b001a3cd4c8d08mr2381010plh.38.1686407945841;
        Sat, 10 Jun 2023 07:39:05 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p4-20020a1709026b8400b001b034d2e71csm5082178plk.34.2023.06.10.07.39.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jun 2023 07:39:05 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sat, 10 Jun 2023 07:39:04 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Yongsheng Yang <iyysheng@gmail.com>
Cc:     jdelvare@suse.com, corbet@lwn.net, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Documentation/hwmon: Fix description of
 devm_hwmon_device_unregister()
Message-ID: <e605a8d8-4f40-447d-8238-eccb7e22342a@roeck-us.net>
References: <20230609075510.1305-1-iyysheng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230609075510.1305-1-iyysheng@gmail.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 09, 2023 at 11:55:10AM +0400, Yongsheng Yang wrote:
> Use devm_hwmon_device_register_with_info to replace
> hwmon_device_register_with_info in description of
> devm_hwmon_device_unregister.
> 

You didn't add () to function names, but I guess it is better to do that
in a separate patch anyway.

Applied.

Thanks,
Guenter

> Signed-off-by: Yongsheng Yang <iyysheng@gmail.com>
> Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
>  Documentation/hwmon/hwmon-kernel-api.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/hwmon/hwmon-kernel-api.rst b/Documentation/hwmon/hwmon-kernel-api.rst
> index c2d1e0299d8d..6cacf7daf25c 100644
> --- a/Documentation/hwmon/hwmon-kernel-api.rst
> +++ b/Documentation/hwmon/hwmon-kernel-api.rst
> @@ -66,7 +66,7 @@ hwmon_device_register_with_info.
>  
>  devm_hwmon_device_unregister does not normally have to be called. It is only
>  needed for error handling, and only needed if the driver probe fails after
> -the call to hwmon_device_register_with_info and if the automatic (device
> +the call to devm_hwmon_device_register_with_info and if the automatic (device
>  managed) removal would be too late.
>  
>  All supported hwmon device registration functions only accept valid device
