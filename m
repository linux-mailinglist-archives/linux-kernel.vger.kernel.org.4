Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ABBA734223
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 18:14:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237205AbjFQQOZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 12:14:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236972AbjFQQOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 12:14:21 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7E641FD3;
        Sat, 17 Jun 2023 09:14:20 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-1a997531cceso1725053fac.3;
        Sat, 17 Jun 2023 09:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687018460; x=1689610460;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p6+LjqTkrNRU01Zz+GeTO55AR/K34Z0WlrGrCZ9xml8=;
        b=TRjGdNk/VlTqNbHWAyTRreJdyFVzJ54szhX8WtU8SxeuNc08CIvXLpsWUNhrctTphM
         VAwmJFt8MfmkDQt2rMvgfrJbAG2PzgupFslMUBP1Fvco3JdaMis6Hwp5GaM68YSctGd8
         N7jvPUV2WZNBpcDaFPxxDwdMNPyAME4a9J0TJhRK7qOm6w6nmg0jW0rKhwloKqIOwoIW
         4ULrKnXeHRDr5j9Fe7Z+1BQo++4x0BIU/jsdoE0JDLuvIBjgMUiQYhwtpT/8m5AZdZGg
         s4QFo2kOt2w7y9EduE9pBzjEfxc6D4y6n96ENoqMZRYuhGRUtsHHWZPdBXwVNfVa91N9
         7N3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687018460; x=1689610460;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p6+LjqTkrNRU01Zz+GeTO55AR/K34Z0WlrGrCZ9xml8=;
        b=J/FBTzmsntcK0Q9N6B4UqMBAR9PuqRBXDmWq6y2jW3t8R146Oj61ExMOqGmIw2Nk4A
         G4203RX+RBKm8MJhJKJO5BLNGm+kZc5Xg+R3mElCHlY3/FML54gCW7j7zkTUN8hhlbn0
         91LUa/l6Aa1RCXwYcpkku3llTacJ0Xcr/tGQVsEsmoiY5GK2iSvpGpV4wZgDUTX4ro9y
         RiDWfEhTLr5HMNwHbvysjBP+L75G7pc01nHk641g/+GxbAnUNd21M/pfUhgVvm7TY2KR
         v4L6jQR4C1a7cLZslaGyaAzzr8ueQohjIylJowXdO7zj9hv9JLf0hgd8TSqIXTZ1E0vx
         jSTQ==
X-Gm-Message-State: AC+VfDxpOk6oUgQWOFtfkOCZZUvM0Tpj0D/K4hZD4nHmUXlCP0G1k4D2
        ku2QzZfUCepIq60t5+MdcAuT8NgEIdk=
X-Google-Smtp-Source: ACHHUZ5+zNrtLpDjNBrYho9u3MbkEA56OKlnQSOvjZgNZYI1efvnf+Rnx6wJ0Rl/BJ7uw3gw9FUDPw==
X-Received: by 2002:a05:6870:d2aa:b0:19f:a1da:49db with SMTP id d42-20020a056870d2aa00b0019fa1da49dbmr2222314oae.15.1687018459868;
        Sat, 17 Jun 2023 09:14:19 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g15-20020aa7874f000000b006542462d040sm15111165pfo.206.2023.06.17.09.14.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jun 2023 09:14:19 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sat, 17 Jun 2023 09:14:18 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     JuenKit Yip <JuenKit_Yip@hotmail.com>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/6] hwmon: (sht3x) complement sysfs interface for
 sts3x
Message-ID: <56a3a6fd-604c-4e67-81d6-52a12c6c866e@roeck-us.net>
References: <20230616160017.21228-1-JuenKit_Yip@hotmail.com>
 <DB4PR10MB6261B912ADFA6BB78240596F9258A@DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB4PR10MB6261B912ADFA6BB78240596F9258A@DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM>
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

On Sat, Jun 17, 2023 at 12:00:17AM +0800, JuenKit Yip wrote:
> Compared to sht3x, sts3x has the similiar functions and operations

s/similiar/similar/

> but it has no humidity sensor.
> 
> Signed-off-by: JuenKit Yip <JuenKit_Yip@hotmail.com>

Applied to hwmon-next after fixing the above. Please run checkpatch
on your patches; it would have told you.

Thanks,
Guenter

> ---
>  drivers/hwmon/sht3x.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/hwmon/sht3x.c b/drivers/hwmon/sht3x.c
> index adfc11c12..ae384ced7 100644
> --- a/drivers/hwmon/sht3x.c
> +++ b/drivers/hwmon/sht3x.c
> @@ -707,6 +707,14 @@ static struct attribute *sht3x_attrs[] = {
>  
>  static struct attribute *sts3x_attrs[] = {
>  	&sensor_dev_attr_temp1_input.dev_attr.attr,
> +	&sensor_dev_attr_temp1_max.dev_attr.attr,
> +	&sensor_dev_attr_temp1_max_hyst.dev_attr.attr,
> +	&sensor_dev_attr_temp1_min.dev_attr.attr,
> +	&sensor_dev_attr_temp1_min_hyst.dev_attr.attr,
> +	&sensor_dev_attr_temp1_alarm.dev_attr.attr,
> +	&sensor_dev_attr_heater_enable.dev_attr.attr,
> +	&sensor_dev_attr_update_interval.dev_attr.attr,
> +	&sensor_dev_attr_repeatability.dev_attr.attr,
>  	NULL
>  };
>  
