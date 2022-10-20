Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60416606AF3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 00:05:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbiJTWE4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 18:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbiJTWEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 18:04:54 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72F9E4623E;
        Thu, 20 Oct 2022 15:04:49 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id n130so1205145oia.6;
        Thu, 20 Oct 2022 15:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3FmWumkd2mTA+JcsRUqk/cvhoYj5gExBmm8jji6MIkQ=;
        b=piaWcQNOk51c7fPLJYjuVO2bxZXIN8dhDDYLjbj0MrUvNKFof1rBgysYCDB4jngY0o
         JjFPM3hgjEPLJOLqSZGWVuUAn69pD2ZDI4W5IGNTvzOL/GtgRcZJsjRebbq+KbhD8P7A
         +TZvuJXtph1ETaWnmGNRg5INAfinaJLclD3oRQg7uYHF7PD/RA6xB0Q83jB3f1zTUVki
         UhyeFkzBaTlEPSp5AuK6z3iYiP+f5B8NtipM3mcptFWNuSQeCW+15PL1AGs29sCJYZnt
         R/T3iK5SY46HWzRKfAZ62HVUi03KrJioNr3sJXOT7y1c/V25yGx5W8cLtFpWxA4m0cOG
         JYlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3FmWumkd2mTA+JcsRUqk/cvhoYj5gExBmm8jji6MIkQ=;
        b=pY2ep3QJgLLOusNz3VTcF9U6+5DPatz08SE321zPEHk8aYmAo+Nny2KG9XKnrfeRcg
         bV+q4fCrvFMa23hIHYEfFF1l4lnCaDdlDPoWU7QcI7DzktWdOT7NGc24aqy7QkNSQeYJ
         Psq/ozFG/lC25dQzQHG05pq9NJkfz0emeeyqXGqNfjydKJQD2XUqnsrJyiZKLaLirhrD
         iAbHF3YJVaU/PGpLPzOw/RFT8nR75+v+2XxyqqH+Qc7crsiuDWSyGN2dW+/B3HzQCJLH
         6rADCQpn3equnEwLgHzBdPmpBFo3te+KqUAn0uePK8VYnMWlwfVN/8e2xkFWehl33nT9
         Huyw==
X-Gm-Message-State: ACrzQf2JYwgWTg8dxp748/Z11+l21wiJ+Bp+wnC/QzUjDwnyoODVP2O/
        nWXSk10gipxxr8ZM4Hhn99JMYvTa338=
X-Google-Smtp-Source: AMsMyM6E+do58XqYz8h86d1ylL4mOaPTLhKzSr0FE31TyVbnQEdJm+IvhwjBJralEM6tG1WKV0eQmA==
X-Received: by 2002:a05:6808:1248:b0:354:2c04:c35b with SMTP id o8-20020a056808124800b003542c04c35bmr21452189oiv.143.1666303488819;
        Thu, 20 Oct 2022 15:04:48 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id db10-20020a0568306b0a00b00661a80d555fsm401770otb.40.2022.10.20.15.04.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 15:04:48 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 20 Oct 2022 15:04:47 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-hwmon@vger.kernel.org, jdelvare@suse.com,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 2/4] hwmon: (jc42) Convert to regmap's built-in
 caching
Message-ID: <20221020220447.GE4035307@roeck-us.net>
References: <20221020210320.1624617-1-martin.blumenstingl@googlemail.com>
 <20221020210320.1624617-3-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221020210320.1624617-3-martin.blumenstingl@googlemail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 20, 2022 at 11:03:18PM +0200, Martin Blumenstingl wrote:
> Move over to regmap's built-in caching instead of adding a custom
> caching implementation. This works for JC42_REG_TEMP_UPPER,
> JC42_REG_TEMP_LOWER and JC42_REG_TEMP_CRITICAL as these values never
> change except when explicitly written. For JC42_REG_TEMP a cache
> variable is still kept as regmap cannot cache this register (because
> it's volatile, meaning it can change at any time).
> 

Just drop that one as well, together with jc42_update_device(),
and read the temperature directly where needed. In practice
caching of 'hot' registers isn't really worth the trouble.

Thanks,
Guenter

> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  drivers/hwmon/jc42.c | 97 ++++++++++++++++++++++++--------------------
>  1 file changed, 54 insertions(+), 43 deletions(-)
> 
> diff --git a/drivers/hwmon/jc42.c b/drivers/hwmon/jc42.c
> index 329a80264556..3f524ab5451c 100644
> --- a/drivers/hwmon/jc42.c
> +++ b/drivers/hwmon/jc42.c
> @@ -200,21 +200,6 @@ static struct jc42_chips jc42_chips[] = {
>  	{ STM_MANID, STTS3000_DEVID, STTS3000_DEVID_MASK },
>  };
>  
> -enum temp_index {
> -	t_input = 0,
> -	t_crit,
> -	t_min,
> -	t_max,
> -	t_num_temp
> -};
> -
> -static const u8 temp_regs[t_num_temp] = {
> -	[t_input] = JC42_REG_TEMP,
> -	[t_crit] = JC42_REG_TEMP_CRITICAL,
> -	[t_min] = JC42_REG_TEMP_LOWER,
> -	[t_max] = JC42_REG_TEMP_UPPER,
> -};
> -
>  /* Each client has this additional data */
>  struct jc42_data {
>  	struct regmap	*regmap;
> @@ -224,7 +209,7 @@ struct jc42_data {
>  	unsigned long	last_updated;	/* In jiffies */
>  	u16		orig_config;	/* original configuration */
>  	u16		config;		/* current configuration */
> -	u16		temp[t_num_temp];/* Temperatures */
> +	u16		temp;		/* Cached temperature register value */
