Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7342465AED1
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 10:45:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbjABJpu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 04:45:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231983AbjABJpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 04:45:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACEC32DC8
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 01:44:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672652697;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hrNAqV6ZY5ivQJapJxCgpk49bJb25LBax+4yjjic7Lg=;
        b=WmNDkqtCQk6ec86uQyjquoaw9HFORyJS2745aVBd3OqWytSqiH7Lp4vLpB8L+yoe5eGep/
        GIFl+aEjP4z7ZbnvDWPHnY6ebquk30uRLk3MiyDp8V3eOeAqUTAVh3A6TpOsSEGJSY8jt0
        QEUxx0/AgY0BB84i2cnCGSGLQea7rmM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-193-1wf9S6LTOmmwF5PDs3ARAw-1; Mon, 02 Jan 2023 04:44:56 -0500
X-MC-Unique: 1wf9S6LTOmmwF5PDs3ARAw-1
Received: by mail-wm1-f71.google.com with SMTP id j1-20020a05600c1c0100b003d99070f529so8978221wms.9
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jan 2023 01:44:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hrNAqV6ZY5ivQJapJxCgpk49bJb25LBax+4yjjic7Lg=;
        b=a9QV0NpJDOGiiXN8FEZm3D0CzL84Un2XF536CbKHXOcAjT7Rvm94oC/gsWZY4DT41a
         L0iAfR8hIBYedBD78PIdUbbiJK2p11ElFOQW0nhEpEza7gp16s/lXCcdE1FzseQq9saW
         4yZl/X566B8QfXvnplHd5HtQi9YVv4mZhqORUi3ukhryKDrbHLEU9bg5gDjTFHQKbcic
         UBnVPvguthc9GTGQQmL8DSUIRUbi3Xx5Px3+awTmCPHNiypSWDjuJuh0NHEKl9zclqFi
         drF2TaXj85ArCVpE9oed6mzBAhYcQwReslFQWEdmF4GL7dXXJzQo3Vj1IzEt0Xvh8LXy
         bOwg==
X-Gm-Message-State: AFqh2ko8mzvbNS4WcYXhrbBfbMPHi/yiIHIVp+N97Z7/HWcW8QkmKvGp
        Xu/Ty4eHXtZbsNwkIOn61thSbGfbwtSb69KICKAXyFUT43Dl1q3uqWOQalP0I3ZnolalXAEINVR
        KBQzy50coVNnk365rEt//LzRk
X-Received: by 2002:a05:600c:d2:b0:3d2:2b70:f2fd with SMTP id u18-20020a05600c00d200b003d22b70f2fdmr29035350wmm.21.1672652695631;
        Mon, 02 Jan 2023 01:44:55 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvGGW0J+6nq6DUxW1h2xRC/i7kscSszFCvw0h/Drz9ysxqRksonNdlBfYAtcIGbHZBQsbKS3Q==
X-Received: by 2002:a05:600c:d2:b0:3d2:2b70:f2fd with SMTP id u18-20020a05600c00d200b003d22b70f2fdmr29035334wmm.21.1672652695377;
        Mon, 02 Jan 2023 01:44:55 -0800 (PST)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id m8-20020a05600c4f4800b003cfaae07f68sm44938241wmq.17.2023.01.02.01.44.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Jan 2023 01:44:54 -0800 (PST)
Message-ID: <c0c5b5ac-821c-1277-a2f1-d896a6ed680b@redhat.com>
Date:   Mon, 2 Jan 2023 10:44:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v4 0/4] Add PinePhone Pro display support
Content-Language: en-US
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Neal Gompa <ngompa13@gmail.com>, dri-devel@lists.freedesktop.org,
        Martijn Braam <martijn@brixit.nl>,
        Caleb Connolly <kc@postmarketos.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?UTF-8?Q?Kamil_Trzci=c5=84ski?= <ayufan@ayufan.eu>,
        Sam Ravnborg <sam@ravnborg.org>,
        linux-rockchip@lists.infradead.org,
        Jagan Teki <jagan@amarulasolutions.com>,
        Peter Robinson <pbrobinson@gmail.com>,
        devicetree@vger.kernel.org, Robert Mader <robert.mader@posteo.de>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Onuralp Sezer <thunderbirdtr@fedoraproject.org>,
        linux-kernel@vger.kernel.org,
        Tom Fitzhenry <tom@tom-fitzhenry.me.uk>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Ondrej Jirman <megi@xff.cz>,
        Maya Matuszczyk <maccraft123mc@gmail.com>
References: <20221230113155.3430142-1-javierm@redhat.com>
 <Y7H5UJOz/zYuZn7j@duo.ucw.cz>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <Y7H5UJOz/zYuZn7j@duo.ucw.cz>
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

Hello Pavel,

On 1/1/23 22:21, Pavel Machek wrote:
> Hi!
> 
>> This series add support for the display present in the PinePhone Pro.
>>
>> Patch #1 adds a driver for panels using the Himax HX8394 panel controller,
>> such as the HSD060BHW4 720x1440 TFT LCD panel present in the PinePhone Pro.
>>
>> Patch #2 adds a devicetree binding schema for this driver and patch #3 adds
>> an entry for the driver in the MAINTAINERS file.
>>
>> Finally patch #4 adds the needed devicetree nodes in the PinePhone Pro DTS,
>> to enable both the display and the touchscreen. This makes the upstream DTS
>> much more usable and will allow for example to enable support for the phone
>> in the Fedora distribution.
> 
> Thanks for the series. Please cc: phone-devel@vger.kernel.org with
> future patches.
>

Sure, I will.
 
> Best regards,
> 								Pavel

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

