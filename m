Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CE546554A3
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 21:59:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbiLWU7F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 15:59:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbiLWU7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 15:59:03 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 829C8FE0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 12:58:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671829094;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+fwm2GPP6ljPqAqBro6/G3VDNHOYIU57et0/yW+eCIc=;
        b=UREvj5LCLHRBMtb0tcciFNpbRu1q76VwN+E9urCcXY0jKD/EdkGmeSFr4Ia/aIX7I494jK
        t6uTqQIzu5ljkUc1WEtKgsFYp+yC3VNk3l+m83r9YQuZEa8stAIQsmuD6JvabLR8PJ7wru
        ZSukDjxMP6SeHjdsXfrZX5vySR785Oo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-102-DY3seawPP0iOemf_cqltyg-1; Fri, 23 Dec 2022 15:58:13 -0500
X-MC-Unique: DY3seawPP0iOemf_cqltyg-1
Received: by mail-wm1-f72.google.com with SMTP id a6-20020a05600c224600b003d1f3ed49adso1398345wmm.4
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 12:58:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+fwm2GPP6ljPqAqBro6/G3VDNHOYIU57et0/yW+eCIc=;
        b=jygtYYi3HBZhYm0YZDM9Ksz9LxLw6zXn8OV4LfCE28Gk1mb8Pfx7XizlzipVql4VdF
         IiKiVbUvYApHSAh6UOpXzkM7vCOJxKAQYukKC70RqEEaGbokOB2F6ImmhjZwDuheHfXr
         zOKLg6ascEVcoLnfsdvRbidWuk3+KyTG2qvg9BKrmIFy5RltC8/2qr45XTmmzWFO+Akh
         pQK1g4qT8cpSuVWX1COv70L3Ho4uNmsbOhrAYLSWwE9y/IJCrokZ4M9kFJysO+1PEUxO
         4lfdbZvYpThD6FzHm3RVXwOl4bkktpbJbYki0yXOSwHXcWGBI1oMyrZl0bBm1QV9xVfg
         defw==
X-Gm-Message-State: AFqh2kpt2MFJMcBsuhE/CPcOLfeTnqlVCNzpIihdMn92OQzR1DS7S4kC
        z60yRLtDS5VD6kLXuf5sAn7RXxJbeQapjx1D34D76SS4+EHSa1NEfFiirjmOgRFfmNzOnc0R2Kk
        p8eOYCDJZFt4O/G7TDxaI68xb
X-Received: by 2002:a1c:4b04:0:b0:3c6:f0b8:74e6 with SMTP id y4-20020a1c4b04000000b003c6f0b874e6mr8362266wma.4.1671829092197;
        Fri, 23 Dec 2022 12:58:12 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvwTJdWPrVbJTWxaWnNIPcDrG7XtjeUPiYxWUCSByVOVLFXktOF9FLaUHm7oBMX/AGjv+cu/w==
X-Received: by 2002:a1c:4b04:0:b0:3c6:f0b8:74e6 with SMTP id y4-20020a1c4b04000000b003c6f0b874e6mr8362254wma.4.1671829092002;
        Fri, 23 Dec 2022 12:58:12 -0800 (PST)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id 19-20020a05600c021300b003c5571c27a1sm6585681wmi.32.2022.12.23.12.58.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Dec 2022 12:58:11 -0800 (PST)
Message-ID: <ad5471ab-643c-fe4d-13cd-4984d4bb4ee9@redhat.com>
Date:   Fri, 23 Dec 2022 21:58:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 1/4] drm: panel: Add Himax HX8394 panel controller driver
Content-Language: en-US
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     linux-kernel@vger.kernel.org, Ondrej Jirman <megi@xff.cz>,
        Robert Mader <robert.mader@posteo.de>,
        Peter Robinson <pbrobinson@gmail.com>,
        =?UTF-8?Q?Kamil_Trzci=c5=84ski?= <ayufan@ayufan.eu>,
        Martijn Braam <martijn@brixit.nl>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        dri-devel@lists.freedesktop.org
References: <20221222223830.2494900-1-javierm@redhat.com>
 <20221222223830.2494900-2-javierm@redhat.com> <Y6VyJhz9DTjaDUDa@ravnborg.org>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <Y6VyJhz9DTjaDUDa@ravnborg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Sam,

On 12/23/22 10:17, Sam Ravnborg wrote:
> Hi Javier.
> 
> On Thu, Dec 22, 2022 at 11:38:27PM +0100, Javier Martinez Canillas wrote:
>> From: Kamil Trzciński <ayufan@ayufan.eu>
>>
>> The driver is for panels based on the Himax HX8394 controller, such as the
>> HannStar HSD060BHW4 720x1440 TFT LCD panel that uses a MIPI-DSI interface.
> 
> A few comments/nitpicks in the following.
> I have been away for a while, and paged out most of my panel knowledge,
> so read it all with that in mind.
>

Thanks a lot for your feedback! I agree with your comments and will address
those in the next iteration.
 
> In general - very nicely written driver.
> 
> 	Sam
> 

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

