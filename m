Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2DD6617C08
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 12:58:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231401AbiKCL6A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 07:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbiKCL5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 07:57:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C6C5120AB
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 04:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667476622;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xUsslBgfioG7+iWyattqFfLmG0F1gkOA/LUNlKDCuUE=;
        b=ifARAnz2bYRfVxIBOeTUOMIqPcuQDkW304H5GDwreHCYy8mLRcgOOontQE6BjmlFLK7oAy
        2Al9Vlmg2+Ng8Lt7c5uTp3TfiAgruMQoVHcts7WTCV+YB3j9qlJAvji3wW/U8O8HH7CLMn
        IA/oM7Bf89uFIYbg7iXk/WhuWdI9Gc8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-220-hkhi3lxvPsu_st00XhTnOw-1; Thu, 03 Nov 2022 07:57:00 -0400
X-MC-Unique: hkhi3lxvPsu_st00XhTnOw-1
Received: by mail-wm1-f72.google.com with SMTP id ay40-20020a05600c1e2800b003cf8aa16377so714945wmb.7
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 04:56:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xUsslBgfioG7+iWyattqFfLmG0F1gkOA/LUNlKDCuUE=;
        b=I51y8xgNuZULI6Apgrp008FLh4zEEVmCmrz7MRkJxD9vci5T5TDp04Rg3cD7ZT9v/s
         xtuurv2NZKDlBXPl5IZZJ9T2xF6iL/3Tc/fhSoZV4Sbv/JX+2ag8K85vTcyqcghH0P8o
         cDirAzbXgvn+M2ZC3uJRUME7oYmgOhHvAe2sTTJRL6+9OX6HLmX+VrW9dMEQzCCMy/T8
         H69aM7grVc6O48OTmzNG9jF6LxH/sAt0/WG7wbYLvdkA5C//ksGrfwuiVyO/fDF8TdFo
         nJWSTZbJGfKBqfpr7H9lvcKZqcy7kEyisGs0RDE5EISEcVMC+2l32nIaij914/p5tlC6
         6U1g==
X-Gm-Message-State: ACrzQf09JTmcF+30an1gjebNPWtPA5dGDf9T6+DdrT2zPvL7f6IC5h2t
        3XDRkGGXrT/Eu8aAVUhRQjCdD1NDra/frFSmp9abSu34k9j48lM4x6kRzDhNZ9fwcat0DYECHMs
        8ff49FIE6tAyvmmQorgpEVWs0
X-Received: by 2002:a05:600c:5563:b0:3cf:857e:18c0 with SMTP id ja3-20020a05600c556300b003cf857e18c0mr6148485wmb.24.1667476618221;
        Thu, 03 Nov 2022 04:56:58 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6jlojoGO8BlWc+DQVkk3s3r1Mp7Cu2UjhVDtTHUEWmRy034Ohm8DlDf7vSROFbjktagpDy0w==
X-Received: by 2002:a05:600c:5563:b0:3cf:857e:18c0 with SMTP id ja3-20020a05600c556300b003cf857e18c0mr6148473wmb.24.1667476617980;
        Thu, 03 Nov 2022 04:56:57 -0700 (PDT)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id l12-20020a1c790c000000b003c5571c27a1sm1145704wme.32.2022.11.03.04.56.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Nov 2022 04:56:57 -0700 (PDT)
Message-ID: <88d5165b-1825-3a71-c8c0-dd5a99cd8bf6@redhat.com>
Date:   Thu, 3 Nov 2022 12:56:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH] drm: rcar_du: DRM_RCAR_DU optionally depends on
 RCAR_MIPI_DSI
Content-Language: en-US
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org
Cc:     Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>,
        LUU HOAI <hoai.luu.ub@renesas.com>
References: <20221018181828.19528-1-rdunlap@infradead.org>
 <a68a24a0-eda3-8711-21c1-334289eca0d3@infradead.org>
 <166747314442.3962897.9754510086268412956@Monstersaurus>
 <c9064cc6-2a9d-1094-53fb-cf56f9cbf191@redhat.com>
In-Reply-To: <c9064cc6-2a9d-1094-53fb-cf56f9cbf191@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/3/22 12:53, Javier Martinez Canillas wrote:

[...]

>>
> 
> What this Kconfig expression is saying is that it depends on DRM_RCAR_MIPI_DSI=y
> if DRM_RCAR_DU=y and DRM_RCAR_MIPI_DSI=m if DRM_RCAR_DU=m. But that the it can

It should had been s/and/or here but you get the idea.

> also be satisfied if is not set DRM_RCAR_MIPI_DSI.
> 
> This is usually used to make sure that you don't end with a configuration where
> DRM_RCAR_MIPI_DSI=y and DRM_RCAR_DU=m or DRM_RCAR_MIPI_DSI=m and DRM_RCAR_DU=y.
> 
> Randy, I think that it's more idiomatic though to it express as following:
> 
> depends on DRM_RCAR_MIPI_DSI || !DRM_RCAR_MIPI_DSI
> 

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

