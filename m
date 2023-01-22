Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2141E677049
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 16:43:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231512AbjAVPnV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 10:43:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231509AbjAVPnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 10:43:19 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14AAE22035
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jan 2023 07:42:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674402154;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IonFMa0lsWsZdfNk5QE4jBoQi/ruUQHMn+oqAHgqoH8=;
        b=hvR1AOBnfzg+8s2xetfkwYYJuvSq5Oy5mctPpo+BivEm3uvzMGvVrd95NuRqyQWqbhUDVa
        HUgUqjCUEhR+QmqAJmDd6m9s9cu452mPRzNhnp1X62+cwI6ZxctwVeaqIM/E9HZov5PsQB
        zVtFRt37ivzGXyX7Ikx8LFM8/fY4df0=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-135-W2e9ig0AN_SfWRh4VCylMw-1; Sun, 22 Jan 2023 10:42:25 -0500
X-MC-Unique: W2e9ig0AN_SfWRh4VCylMw-1
Received: by mail-ed1-f72.google.com with SMTP id s3-20020a50ab03000000b0049ec3a108beso4392416edc.7
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jan 2023 07:42:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IonFMa0lsWsZdfNk5QE4jBoQi/ruUQHMn+oqAHgqoH8=;
        b=QtziOHpzVy3EPLUps2Ve/yzZSNXtbmFOXN5hQeQsR616vy/lzmR42V3BW9C63n49yx
         u9Q10L1aIejXWRBRnP/NzxWTVlKUhWEmJoNcbhOYHdKPLGG3MCuPNOH6Tl2+L8FdUEbT
         rcoavrkwlojISHsX0GNsuoQPsFAupQkCd+g4QdzOATvFzCfk5tXB8hW/FJjF0kYBuBs4
         7hSHYFOQgkR2D4bHuiMPXXCwcS1VX6FCIGPRVvb1Iamy7ZxrKWLKsesGHla8W+WSuzuc
         UkhjHeWPusp26BAr4YCacgeoMkh6EIyBOlQQv/RccwASkklvYojs0xtZB1VfuF3CDMoe
         m0aA==
X-Gm-Message-State: AFqh2kqKvDp/H6BKoIl3M8119PnPR4ToEAeZ/Z0l4GpKXffqUKqxpzYx
        PL/HRpqRuuSq9W9+EB8/qt9C4AoY3lzCOjn7FFJTbvk7FraXLBaavVHhEp/AzbJfhAyFmKgf8G+
        BUixpp5Kmf8F6qX/Ha7858XU3
X-Received: by 2002:a17:906:b317:b0:86e:5124:20b0 with SMTP id n23-20020a170906b31700b0086e512420b0mr24453762ejz.64.1674402144009;
        Sun, 22 Jan 2023 07:42:24 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvxYtwlzriBymW6Z3D7aPp6YK0SgRgIwBhy9+XTG6Yr2FXU6lFqP+zhk9rsn87ItyMtBAKvXA==
X-Received: by 2002:a17:906:b317:b0:86e:5124:20b0 with SMTP id n23-20020a170906b31700b0086e512420b0mr24453748ejz.64.1674402143767;
        Sun, 22 Jan 2023 07:42:23 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id mb9-20020a170906eb0900b0084d34eec68esm19871820ejb.213.2023.01.22.07.42.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Jan 2023 07:42:23 -0800 (PST)
Message-ID: <efcca646-5dc3-359a-5453-2fe241af8f8c@redhat.com>
Date:   Sun, 22 Jan 2023 16:42:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2 2/2] dt-bindings: display: simple-framebuffer: Document
 physical width and height properties
Content-Language: en-US, nl
To:     Rob Herring <robh+dt@kernel.org>, Rayyan Ansari <rayyan@ansari.sh>
Cc:     dri-devel@lists.freedesktop.org,
        ~postmarketos/upstreaming@lists.sr.ht, asahi@lists.linux.dev,
        janne@jannau.net, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>, devicetree@vger.kernel.org,
        Javier Martinez Canillas <javierm@redhat.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>
References: <20230121153544.467126-1-rayyan@ansari.sh>
 <20230121153544.467126-3-rayyan@ansari.sh>
 <CAL_JsqL+G=Cxkc2j_NowznpqNAnixrU+-6SdccFbpMaP6OYSqQ@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAL_JsqL+G=Cxkc2j_NowznpqNAnixrU+-6SdccFbpMaP6OYSqQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 1/22/23 16:36, Rob Herring wrote:
> On Sat, Jan 21, 2023 at 9:36 AM Rayyan Ansari <rayyan@ansari.sh> wrote:
>>
> 
> Why do you need this change?
> 
> The 'simple-framebuffer' contains data on how the bootloader
> configured the display. The bootloader doesn't configure the display
> size, so this information doesn't belong here. The information should
> already be in the panel node, so also no point in duplicating it here.

The idea is that early boot code which uses the simplefb node (no more
complex display driver loaded yet) knows the panel's DPI so that it can
decide if hi-dpi rendering / scaling is necessary or not.

This definitely is a useful feature to have.

I guess that for dt systems an alternative approach could be to
add a link to the panel node to the simplefb dt-node.

Regards,

Hans



