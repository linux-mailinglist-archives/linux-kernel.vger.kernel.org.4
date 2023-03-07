Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19DA76AEC16
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 18:52:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbjCGRw0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 12:52:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232259AbjCGRvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 12:51:53 -0500
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1127A17CA;
        Tue,  7 Mar 2023 09:46:29 -0800 (PST)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-17638494edbso15856085fac.10;
        Tue, 07 Mar 2023 09:46:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678211189;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7ljyexdjspfyojq9LyjNf8Q41+ny1p3UM1Q8HcfXJhM=;
        b=etUfRIegKB9eRp8EInBvs9uyZ5M3BVQi0ulfpgxlMaVkk6/qrBnirkFNyMy6N9cmb5
         tSPmJ3w0IZiHHLaSUqEzMpqqOukGDHOsPhXPBjVzCt3XqzGjomIvWTlNZGYtyvQYXujd
         5hZMcZntF/n/lISwDtHkhSDrKV3XJV1XbBXFmA9+aywCcTZEOyMarg0+AwVpQAfw1Mzx
         KMiC0fHWiIzWRB07TheLNZy3NXPP0i/7DyJpltScKk+UOXPX3g+0lSzlhYKNFN1oVOdt
         jLWQjJL4GgrS7x/i8U8gPSfUFXlTSWHGCy1tyv25hy8GryAEOqAjFdEol6ZW6mNMqj0V
         FSJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678211189;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7ljyexdjspfyojq9LyjNf8Q41+ny1p3UM1Q8HcfXJhM=;
        b=oHfMPCD6gKZFmkg2reVFLvODjmwld1jxaLWf5DBfUJ9g8GROWHKecb5v2zPE4csnTb
         ebEpYV8HAAqxodK+qu8yIrQzAAxvoCpNBSiyd/jsoTG50RKmZuff1ymf5Ni2455wH1ZO
         It2gEPlsyUlqgnj8i1xU/EZzHsCNSBBJQv2t+P7E+TaFIjOeI8nugNrrvxxR6IVkH6wi
         OtkC1Z5rZSe9qVl3WXNWFtsogvVLLrdIxFWNkAWd2cfE3iGHomsYr+hGZj8S3XcQvmUl
         zh1u7jnJsrLA2te+8VzIOLB2JS71nE59vURz1EIa4hfR/5m7WOjjq4tSGpOAOOz6iJkM
         NFug==
X-Gm-Message-State: AO0yUKXxbaoNOx3G15iKnCr/tI9S08Kdr/a/CjTsV1qUzY85ltLPiHZi
        u8U4EdZOBv1KtYix4Q2Rc2O9yApPjzY=
X-Google-Smtp-Source: AK7set/w8ZO6MgDAGj+z6aAisZXiq8AHWmMNh2f4gQDzcJQPI0FY048RRrQ/Y53fZ3tGC1SlrQI2lg==
X-Received: by 2002:a05:6870:5703:b0:176:4a1f:4f93 with SMTP id k3-20020a056870570300b001764a1f4f93mr9414741oap.43.1678211189045;
        Tue, 07 Mar 2023 09:46:29 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v2-20020a056830140200b006941ecefc34sm5533688otp.18.2023.03.07.09.46.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 09:46:28 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 7 Mar 2023 09:46:27 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc:     linux-watchdog@vger.kernel.org, wim@linux-watchdog.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] watchdog: rt2880-wdt: prefer unsigned int over
 unsigned
Message-ID: <0298c226-4c96-4112-9f95-6a55a8e9cdba@roeck-us.net>
References: <20230301065510.2818425-1-sergio.paracuellos@gmail.com>
 <20230301065510.2818425-2-sergio.paracuellos@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230301065510.2818425-2-sergio.paracuellos@gmail.com>
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

On Wed, Mar 01, 2023 at 07:55:10AM +0100, Sergio Paracuellos wrote:
> Instead of declare 'reg' variable in read and write operations as a bare
> 'unsigned' type prefer to declate it as 'unsigned int'.
> 
> Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/rt2880_wdt.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/watchdog/rt2880_wdt.c b/drivers/watchdog/rt2880_wdt.c
> index e54737bcf939..4499ba0eb5ea 100644
> --- a/drivers/watchdog/rt2880_wdt.c
> +++ b/drivers/watchdog/rt2880_wdt.c
> @@ -54,12 +54,12 @@ MODULE_PARM_DESC(nowayout,
>  		"Watchdog cannot be stopped once started (default="
>  		__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
>  
> -static inline void rt_wdt_w32(void __iomem *base, unsigned reg, u32 val)
> +static inline void rt_wdt_w32(void __iomem *base, unsigned int reg, u32 val)
>  {
>  	iowrite32(val, base + reg);
>  }
>  
> -static inline u32 rt_wdt_r32(void __iomem *base, unsigned reg)
> +static inline u32 rt_wdt_r32(void __iomem *base, unsigned int reg)
>  {
>  	return ioread32(base + reg);
>  }
