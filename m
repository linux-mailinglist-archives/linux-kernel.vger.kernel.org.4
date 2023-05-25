Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2E41711377
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 20:17:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240131AbjEYSRV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 14:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbjEYSRU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 14:17:20 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 441E8B6;
        Thu, 25 May 2023 11:17:19 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1ae52ce3205so12804905ad.3;
        Thu, 25 May 2023 11:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685038639; x=1687630639;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=APX05tj9E7efqTidQP7VQKHtmHHvf1trXj0/IRgjZ1w=;
        b=g9eG++XA46zXzdZzxBjVlcMp6A8KNczhdKQpN+A1FLBwnwo4rmKLaqYifBiSVwGNhe
         pRS3lJqS5dTU0NPOKa5jF6ffmNwmr+yIadIwuMrg2kUhDIH4qKAfsulYE1MgTXvgpN+j
         J8GHDya0O0NcfIACQzGzXkFGZ0BcBCR/uo8K03Trv2uGlTrXCWU3XHT361CGvSA+WIWs
         yJWoXOTvT/T+E3O7Ge0oSAtIOq3Xxv4TG6T3IcGeLvf8zmozrY45ePXPfoeH9KEqHcTj
         5MEorHDjBOVfkjrxDZq1G26eJFq69rjDFxL0EbQQkhzfJnGmfUGXrnq8tbs9eeUnVEMk
         09/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685038639; x=1687630639;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=APX05tj9E7efqTidQP7VQKHtmHHvf1trXj0/IRgjZ1w=;
        b=j/EFOoSps0bYT2iulN2vN0DKAK+I5URR4A8u1wu0WdwAkmtONDj7oAutV10SQUcQ2x
         YMyAdtNugaIl2xg3WHv8zOsE6D1yN9zseNZvRhqbwbeHFZ+oYKsQt/TCVnp59KiB4lKl
         goxef1zZpR2bp1cd9HcvMRgnOQKtsaFUIGga7kiPLUpRkw4I7e+adg5CMVvuNmMnoDcz
         E934LwfHYHAuhExKfKEkmSjmFuRCmd9V0vMeiI5JckFl44+kOQ7bstZRuLE1TKYz5uaX
         OtnOEzG0cu/RS5QpQT6uTW7bc5njYRv5YgPU8hUkSBBgvTZuOPd5YorzyaYlwS4OQ2US
         b4vg==
X-Gm-Message-State: AC+VfDwsi6HSSihSXZH8pnEtebeiBl2uPJ9/JLzQOTCNhE+mFCEJeLgw
        VMP3Kv1861sxPNrErUKuDQg=
X-Google-Smtp-Source: ACHHUZ5MpbeviPZHEPAlcPBefSVuO9kZxwvTaT+FD9Jn8ZjDhIP8823XPUIJ5C3yeWG8oAcrGtpOsQ==
X-Received: by 2002:a17:902:cec1:b0:1aa:f818:7a23 with SMTP id d1-20020a170902cec100b001aaf8187a23mr3230990plg.27.1685038638755;
        Thu, 25 May 2023 11:17:18 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d20-20020a170902b71400b001a4edbabad3sm1708031pls.230.2023.05.25.11.17.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 11:17:18 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 25 May 2023 11:17:17 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Osama Muhammad <osmtendev@gmail.com>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] adm1266.c: Drop error checking for debugfs_create_dir
Message-ID: <5b8700fb-d455-469e-a34d-62cb6f68d324@roeck-us.net>
References: <20230525160827.15285-1-osmtendev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230525160827.15285-1-osmtendev@gmail.com>
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

On Thu, May 25, 2023 at 09:08:27PM +0500, Osama Muhammad wrote:
> This patch fixes the error checking in adm1266.c.
> The DebugFS kernel API is developed in
> a way that the caller can safely ignore the errors that
> occur during the creation of DebugFS nodes.
> 
> Signed-off-by: Osama Muhammad <osmtendev@gmail.com>

Confusing. Is this v3 of the patch ?

Guenter

> ---
>  drivers/hwmon/pmbus/adm1266.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/hwmon/pmbus/adm1266.c b/drivers/hwmon/pmbus/adm1266.c
> index 1ac2b2f4c570..184d75269d2b 100644
> --- a/drivers/hwmon/pmbus/adm1266.c
> +++ b/drivers/hwmon/pmbus/adm1266.c
> @@ -340,8 +340,6 @@ static void adm1266_init_debugfs(struct adm1266_data *data)
>  		return;
>  
>  	data->debugfs_dir = debugfs_create_dir(data->client->name, root);
> -	if (!data->debugfs_dir)
> -		return;
>  
>  	debugfs_create_devm_seqfile(&data->client->dev, "sequencer_state", data->debugfs_dir,
>  				    adm1266_state_read);
> -- 
> 2.34.1
> 
