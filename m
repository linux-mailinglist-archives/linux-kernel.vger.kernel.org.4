Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03DCF65A57D
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 16:17:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232022AbiLaPRu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 10:17:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235696AbiLaPRh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 10:17:37 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42339638A
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 07:16:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672499817;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p6RyrBHhoHlZmqLHt8ucRNR/9+JKL/9Ujqhw74hbHi4=;
        b=OM4H9yL+QYdlZHa/ARfVJX5RcJJA9D0ceCFscwxtSssfcPhZ+OkyQwoIOj80NScX6iJ2f/
        f/CCmiht4yEFj4fXduD36sPtLDnlebhGPvkVLL574+5A2w/OULGFM9QT4UZmpIdmmh2/aY
        FrlValNyuIOvpxCK8hb7hG4QEYkM5a0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-413-UPGHzvoSM1WQsGzLuKKR6Q-1; Sat, 31 Dec 2022 10:16:55 -0500
X-MC-Unique: UPGHzvoSM1WQsGzLuKKR6Q-1
Received: by mail-wm1-f69.google.com with SMTP id fl12-20020a05600c0b8c00b003d96f0a7f36so11315618wmb.1
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 07:16:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p6RyrBHhoHlZmqLHt8ucRNR/9+JKL/9Ujqhw74hbHi4=;
        b=gMNgZtvNx0Cr/AAgF/Hdmg8kIyRtSQIvqs6sVF+AQlokrjhXl5Bqy65QS44sHn+Dwh
         JOYuQ8SONeH3R8doTuDM0+X6HAr+erKTRP7fsYnRaHZI8M3b08DlGIAZYWIPJoanemzc
         qsWKBtmQfHSZI9KNRGBdg+PyZLXdfyLgPtzmWoz7t9Ha8NlWyJLnxyMECQaBp9UcYpe8
         1/rkP7sff+ILabEVK0P9Yd9s9KGR7NZxDGx6HKlsxcPdEGCRJJuFqDXSSaVlubBnUx60
         hXIYLmvVQuH8+TKjFUb7mjnNas7ahzYSSqIbdJnx5q7yoLzo9VIGy7+bS/yb4Kivd0E/
         FAOQ==
X-Gm-Message-State: AFqh2kpCkTPIP1Eb5hOTnBp6xIXqFfnQBSWppIcm0BNCeu28R8C6xd2E
        wcoMVxUZ3VKANAbvDphoA9DR7ZScsDbXBsMQfhNfNX0L22Bed3epsSdpgqjJSldJj1mN0sJcJT3
        rqDkAISirnCnZtjGHNIfPN/ex
X-Received: by 2002:a05:600c:1c8e:b0:3d2:4234:e8fe with SMTP id k14-20020a05600c1c8e00b003d24234e8femr25372383wms.19.1672499814842;
        Sat, 31 Dec 2022 07:16:54 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsitUMnyhwKUqPjb9FjXl0iVtKBrfHjUXgucY11XvuCsDRImLpxjUnSq2XfmJiw3lSKKueGOA==
X-Received: by 2002:a05:600c:1c8e:b0:3d2:4234:e8fe with SMTP id k14-20020a05600c1c8e00b003d24234e8femr25372380wms.19.1672499814628;
        Sat, 31 Dec 2022 07:16:54 -0800 (PST)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id k2-20020a05600c1c8200b003d974076f13sm28905582wms.3.2022.12.31.07.16.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Dec 2022 07:16:54 -0800 (PST)
Message-ID: <ec67d635-86b0-1e43-d819-d1716c4f22ae@redhat.com>
Date:   Sat, 31 Dec 2022 16:16:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v4 3/4] MAINTAINERS: Add entry for Himax HX8394 panel
 controller driver
Content-Language: en-US
To:     =?UTF-8?Q?Ond=c5=99ej_Jirman?= <megi@xff.cz>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Kamil_Trzci=c5=84ski?= <ayufan@ayufan.eu>,
        Martijn Braam <martijn@brixit.nl>,
        Sam Ravnborg <sam@ravnborg.org>,
        Robert Mader <robert.mader@posteo.de>,
        Tom Fitzhenry <tom@tom-fitzhenry.me.uk>,
        Peter Robinson <pbrobinson@gmail.com>,
        Onuralp Sezer <thunderbirdtr@fedoraproject.org>,
        dri-devel@lists.freedesktop.org,
        Maya Matuszczyk <maccraft123mc@gmail.com>,
        Neal Gompa <ngompa13@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Jagan Teki <jagan@amarulasolutions.com>
References: <20221230113155.3430142-1-javierm@redhat.com>
 <20221230113155.3430142-4-javierm@redhat.com>
 <20221230154311.bvgmjlryu5guctyr@core>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20221230154311.bvgmjlryu5guctyr@core>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/30/22 16:43, Ondřej Jirman wrote:

[...]

>>  
>> +DRM DRIVER FOR HIMAX HX8394 MIPI-DSI LCD panels
>> +M:	Javier Martinez Canillas <javierm@redhat.com>
> 
> +M:	Ondrej Jirman <megi@xff.cz>
>

Great! I assume that you also are OK with listing you in the DT
binding doc. I'll include you in both places when posting a v5.

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

