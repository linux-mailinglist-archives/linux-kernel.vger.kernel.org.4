Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04E7165B6DB
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 20:09:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236205AbjABTJF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 14:09:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233131AbjABTJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 14:09:01 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B7165F84
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 11:08:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672686494;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F4ofZIv0IxIEQU2OkhdFQLomYdGk3PsuGMeKiK+hXoA=;
        b=JcXPnizjHfw08BblXmHGHVO2kQMyFN67Rs6QjmFM+h8OaVx4/QbmP0h1Wf9u6qM0A+LUN3
        2lAO/0YUDPYb0eJfbq+/ULonryTAdOp82QogUrUasiCNF5Jy6eVfAmTvU7A/Lw+MEouL1v
        eSxHmw/91tlsdm8uweIlomCcr3oPsHc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-231-KPdShPpNN_CKP721uNZxUA-1; Mon, 02 Jan 2023 14:08:13 -0500
X-MC-Unique: KPdShPpNN_CKP721uNZxUA-1
Received: by mail-wm1-f70.google.com with SMTP id bd6-20020a05600c1f0600b003d96f7f2396so15822760wmb.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jan 2023 11:08:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F4ofZIv0IxIEQU2OkhdFQLomYdGk3PsuGMeKiK+hXoA=;
        b=1Q2dlti8oik3PwtexLIm9tHUXKCzMA4gaIsjK11YXBRo1f+wYsCtAecOA37fiprby4
         cWT9McqaEP8GFPDDcrxnzTZXCzqLe3GHJXSygdj1gAkGnOVwE784nUVq7f6N/lsEogWR
         7OuUDdF30CJy71s7k9VnzW5QUR7eWutQBYR/RBhnoX+loDQakaHH1xcy2TExxmvfLKhB
         cgAWw0Z27mBHHTve8iSGAsd+28jkwasGwBgM8tYVYx+fnEJNGqOC16PdN5m3yTeR2lgA
         kpBiOt8qMuIh7Zbfje9PwBgbpLhjiVf1VPm6UVSa1xFcBvo1ck6VfhJjI/vG+rFj8qfm
         OfAw==
X-Gm-Message-State: AFqh2kq8fGNSIwudY805OOv+95RjNuXxr09vf86pBfVR5DOXf5Aud+vU
        1BCS3HBNtIABj2Q67NuU7WAD+uQaB43vrAImOs5Sf2JIIcPHVwQyxF+2SHE89vhNuaE64Lwsl8n
        5DAWpaIUJSQosVLH4ATIEcHT8
X-Received: by 2002:a05:600c:5022:b0:3d3:5893:f4f8 with SMTP id n34-20020a05600c502200b003d35893f4f8mr29107452wmr.23.1672686492333;
        Mon, 02 Jan 2023 11:08:12 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtW4sPNTyvBtLeWnkh+MknYOaDLNrSPJzqLeJJHGNdlGV/JcS7IV5Qbb8k460QkFgbShcr1rw==
X-Received: by 2002:a05:600c:5022:b0:3d3:5893:f4f8 with SMTP id n34-20020a05600c502200b003d35893f4f8mr29107446wmr.23.1672686492190;
        Mon, 02 Jan 2023 11:08:12 -0800 (PST)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id l6-20020a05600c4f0600b003d9780466b0sm34301349wmq.31.2023.01.02.11.08.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Jan 2023 11:08:11 -0800 (PST)
Message-ID: <c96f9d0b-2838-fc8a-cf2b-47c5be463ff1@redhat.com>
Date:   Mon, 2 Jan 2023 20:08:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 14/14] drm/panel-xinpeng-xpp055c272: Drop custom DSI write
 macro
Content-Language: en-US
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Thierry Reding <thierry.reding@gmail.com>
References: <20221228014757.3170486-1-javierm@redhat.com>
 <20221228014757.3170486-15-javierm@redhat.com>
 <Y7MoPm/7wLxSgiHF@ravnborg.org>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <Y7MoPm/7wLxSgiHF@ravnborg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/2/23 19:53, Sam Ravnborg wrote:

[...]

>>  }
>>  
>> -#define dsi_generic_write_seq(dsi, cmd, seq...) do {			\
>> -		static const u8 b[] = { cmd, seq };			\
>> -		int ret;						\
>> -		ret = mipi_dsi_dcs_write_buffer(dsi, b, ARRAY_SIZE(b));	\
> Notice that this is *dcs*
>

I missed that! Thanks a lot for catching this inconsistency in the naming.

[...]

>> -	dsi_generic_write_seq(dsi, XPP055C272_CMD_SETEXTC, 0xf1, 0x12, 0x83);
>> -	dsi_generic_write_seq(dsi, XPP055C272_CMD_SETMIPI,
>> +	mipi_dsi_generic_write_seq(dsi, XPP055C272_CMD_SETEXTC, 0xf1, 0x12, 0x83);
> This is wrong - here you should use mipi_dsi_dcs_write_seq()
> Likewise for the rest of the file.
>

Agreed.

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

