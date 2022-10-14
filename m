Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E02575FE60E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 02:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbiJNAHU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 20:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbiJNAHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 20:07:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 870EF1781C1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 17:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665706035;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hHkH9nDLl3aJpoOFwoHcbNVheMWWstwOpF0hvFWehWU=;
        b=Klcy1OrUF81ChOFMaYuoBBfKfiDZPj4owu0FtVJJk0FmqbXUisLwHCgMqzApt9UFUOKgIz
        kWjPnnrMdk4utbIkvj9fxa93VjGySFMSd4zDIROBp1tGNVxqF8CZRbT907Him+DTLqsZNY
        tYVzKjvrSuBh9Z4AaWgTUqHmHl4bBlI=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-607--JKUZJnCNiqH4qdsxjzmcQ-1; Thu, 13 Oct 2022 20:07:12 -0400
X-MC-Unique: -JKUZJnCNiqH4qdsxjzmcQ-1
Received: by mail-ed1-f70.google.com with SMTP id i17-20020a05640242d100b0044f18a5379aso2549590edc.21
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 17:07:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hHkH9nDLl3aJpoOFwoHcbNVheMWWstwOpF0hvFWehWU=;
        b=HU7+QGHSJ1iUVGi0dN62slR9kx70GgCsJGgvTrJI3cuD4U1jY3wS1hWkYs9ybWjOGx
         mcUf64rK4bao7nhFG6UTHTURbcASCRPZ3a+/RpaxLAR4k+lBhAioRioh1/EyaTNDWgya
         0kjazpPLli/xaW2FOmSxx6f1rJ3TV22GQ4BYK6OwmwcL63gFBYMn0zQG0ZtcaUiTNzX0
         npWbV10MYb4zC0C6H+p589BQg63gy7MukBGIwmNwQpmzWmEmFhlgqxK0ciVlmhgMPAxV
         0DWoAJFPxjgQKdq5603LNm4wvFe9GTsllfH32P0iTcYEnJ9hW/3wW2OT6i2BpAPf0lRj
         LQ4Q==
X-Gm-Message-State: ACrzQf1DQdk1qlPf9JWnUR6ENq+2cIilH4L7bI6lx+1Lb2n3aBmzl+pm
        f1qLfC1SeV5yLLDi1TwtYshSp7PEclo50PjSh1dZUWIvgjCZYz441zh4L8T9q8vpaItNqljLK7o
        iBUjJWCv8o4GU/Ic/Hr73K8Mo
X-Received: by 2002:a17:907:6eac:b0:78d:ce9c:3761 with SMTP id sh44-20020a1709076eac00b0078dce9c3761mr1580485ejc.738.1665706031256;
        Thu, 13 Oct 2022 17:07:11 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6xwFavq+mMqtUbSl48MHAHii/+xABQu3zibneARPMz60To4vvPYW7LegyAT+rcLKCxccJdTw==
X-Received: by 2002:a17:907:6eac:b0:78d:ce9c:3761 with SMTP id sh44-20020a1709076eac00b0078dce9c3761mr1580476ejc.738.1665706031070;
        Thu, 13 Oct 2022 17:07:11 -0700 (PDT)
Received: from ?IPV6:2a02:810d:4b40:2ee8:642:1aff:fe31:a15c? ([2a02:810d:4b40:2ee8:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id ky15-20020a170907778f00b0078bfff89de4sm612592ejc.58.2022.10.13.17.07.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Oct 2022 17:07:10 -0700 (PDT)
Message-ID: <4010f21b-4478-d860-c5ba-d6680d35993b@redhat.com>
Date:   Fri, 14 Oct 2022 02:07:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH drm-misc-next v3 4/7] drm/arm/hdlcd: use drm_dev_unplug()
Content-Language: en-US
To:     Liviu Dudau <liviu.dudau@arm.com>
Cc:     daniel@ffwll.ch, airlied@linux.ie, tzimmermann@suse.de,
        mripard@kernel.org, brian.starkey@arm.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20221001011905.433408-1-dakr@redhat.com>
 <20221001011905.433408-5-dakr@redhat.com>
 <Y0bYGjtAHbjeGJHF@e110455-lin.cambridge.arm.com>
From:   Danilo Krummrich <dakr@redhat.com>
Organization: RedHat
In-Reply-To: <Y0bYGjtAHbjeGJHF@e110455-lin.cambridge.arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Liviu,

On 10/12/22 17:07, Liviu Dudau wrote:
> Hi Danilo,
> 
> Appologies again for the delay in reviewing this as I was at XDC last week.

No worries, thanks for following up.

> Looking at the documentation for drm_dev_unplug, you can get a hint about what is going on:
> 
>   /*
>   * [....] There is one
>   * shortcoming however, drm_dev_unplug() marks the drm_device as unplugged before
>   * drm_atomic_helper_shutdown() is called. This means that if the disable code
>   * paths are protected, they will not run on regular driver module unload,
>   * possibly leaving the hardware enabled.
>   */
> 

Yes, that's the issue we have and pretty unfortunate. What we'd want for 
platform device drivers is to still be able to enter the sections locked 
with drm_dev_{enter,exit} on driver unbind, which we can't for at the 
moment.

I discussed this with Daniel Vetter on #dri-devel and for now he 
suggests to just not lock access to platform device bound resources and 
respin the patchset removing those parts.

Besides that I'll also work on a solution for drm_dev_unplug() / 
drm_dev_{enter,exit} to overcome this issue in the future.

> I'm finally getting to a conclusion: I'm still not sure what problem you were trying
> to solve when you have started this series and if you have found a scenario where
> you've got use after free then I would like to be able to reproduce it on my setup.
> Otherwise, I think this whole series introduces a regression on the behaviour of the
> driver and I would be inclined to reject it.

The problem is that DRM modeset objects should never be allocated with 
devm_*, since this can result in use-after free issues on driver unload. 
They should be freed when the last reference to the object is dropped, 
which DRM managed APIs take care of. As a consequence, DRM managed 
objects can potentially out-live platform device bound resources, which 
then should be protected from access. The first at least we can and 
should do.

It's not an issue that's unique to hdlcd, it's just a known issue to be 
addressed by all drivers. There's still the shortcoming concerning 
protecting platform bound resources as discussed above, but "the drmm 
parts should be a good idea no matter what" to cite Daniel.

I'll send a v4 without the drm_dev_{enter,exit} parts removed if that's 
fine for you.

- Danilo

> 
> Best regards,
> Liviu

