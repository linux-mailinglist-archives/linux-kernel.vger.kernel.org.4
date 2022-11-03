Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20153618794
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 19:33:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232094AbiKCSdI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 14:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231907AbiKCScj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 14:32:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 293131DDFE
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 11:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667500269;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=96DwOq7bRZmj3BKNU2gLHyg7G0DUiTS1PVMxGzvJh30=;
        b=HtaaUpn5EIAiH/KzQwpu/weLpQbTY6I4qTiVVGYHve/Wpy7GqLVFgnu6FrdbdexQLIKt6g
        0jRzezpYw/hJJOuONWHDlJxsrSa7tKPr0Cd/b4H3sEYhXcGzPHTsLZxaBNth1LobJIWeJ8
        lR3FLgN4DJ/MVDY5LZm9aJgXru0v/1M=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-341-qtvi-ILtOYa-FQVTwu_3NA-1; Thu, 03 Nov 2022 14:31:07 -0400
X-MC-Unique: qtvi-ILtOYa-FQVTwu_3NA-1
Received: by mail-wr1-f70.google.com with SMTP id u13-20020adfa18d000000b00236566b5b40so724434wru.9
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 11:31:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=96DwOq7bRZmj3BKNU2gLHyg7G0DUiTS1PVMxGzvJh30=;
        b=t90I5ceKZH+lcqI7BP6eKqap1Accl4NXprzbLX7KkTUTndekgz+P1cJpdsZgQXmyWM
         i61DnYp85cz/aHv8raLEksrezacGtZY/NpPQR98P4YPCc/hEmiLLmjZbWSNvl7EGXQC0
         1kxPAjA0lcXs+rlVXVCiqFOHqssQjuWgWzfKG6CWVW5Hc4W7jiUccX5QQc3OMFWawLEk
         ehn6p1j04AMvGA8ooVYCAooE6SI6FYNBcLWQtjs0PUryJYVb1mNKAkfr/0h2rhu3swyX
         vgG1SbVJ4z3nMJGJE7GQJSCtC0bxAXxaovkKzMlXEtLwjI9hi439TmQAqEmNJZ6+2ECa
         717w==
X-Gm-Message-State: ACrzQf3nLb7/7z9DsuWIb3zvKFK29Rq97iymXU1sVul73YveX7N+bbsn
        A+oKtdslb8T61i8RlDSQ9JhYXhVEPpqI86qEOCdVhRkf/1xUyLkwDgYQddnmxo1njySzNnlVhcK
        vk/IlAV6G9CjpByg1RtIuMZmG
X-Received: by 2002:a05:600c:314f:b0:3c6:f3fa:cfec with SMTP id h15-20020a05600c314f00b003c6f3facfecmr30397332wmo.68.1667500266792;
        Thu, 03 Nov 2022 11:31:06 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM743biIUOhZ1cFkZY+y9Lx/XeNUQXdC75sHCosLEhgjYu6ofOamZkBxiiogbiBHGP4vmIMSiA==
X-Received: by 2002:a05:600c:314f:b0:3c6:f3fa:cfec with SMTP id h15-20020a05600c314f00b003c6f3facfecmr30397319wmo.68.1667500266585;
        Thu, 03 Nov 2022 11:31:06 -0700 (PDT)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id d4-20020adff2c4000000b002366b17ca8bsm1665923wrp.108.2022.11.03.11.31.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Nov 2022 11:31:06 -0700 (PDT)
Message-ID: <c8c7baad-e8ce-7683-933a-1d5f98f9c843@redhat.com>
Date:   Thu, 3 Nov 2022 19:31:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH] drm: rcar_du: DRM_RCAR_DU optionally depends on
 RCAR_MIPI_DSI
Content-Language: en-US
To:     Randy Dunlap <rdunlap@infradead.org>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        linux-kernel@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        LUU HOAI <hoai.luu.ub@renesas.com>,
        dri-devel@lists.freedesktop.org,
        Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
References: <20221018181828.19528-1-rdunlap@infradead.org>
 <a68a24a0-eda3-8711-21c1-334289eca0d3@infradead.org>
 <166747314442.3962897.9754510086268412956@Monstersaurus>
 <c9064cc6-2a9d-1094-53fb-cf56f9cbf191@redhat.com>
 <f5a46aef-780e-6fec-85b4-82549fb7a7a1@infradead.org>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <f5a46aef-780e-6fec-85b4-82549fb7a7a1@infradead.org>
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

On 11/3/22 17:26, Randy Dunlap wrote:

[...]

>>
>> Randy, I think that it's more idiomatic though to it express as following:
>>
>> depends on DRM_RCAR_MIPI_DSI || !DRM_RCAR_MIPI_DSI
> 
> I count just over 200 of each idiom (but my grep strings could be
> too crude). I guess that you want a v2 with that change?
> 

I believe Kieran was happy with either so no objections from
me. I don't have a strong opinion, I just thought the latter
was more idiomatic but you said that both are used alike.

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

