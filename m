Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D672649AA9
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 10:07:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231736AbiLLJHR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 04:07:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231779AbiLLJHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 04:07:11 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C0A65FD1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 01:06:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670835973;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xyZnfD0GKpCtoGnDuZNwaqbFZdn7D4bcR1Mw17gItoM=;
        b=Nrnlb2jDPKXkphWdgv39WTB3JOibCP0+uwM0KzNzbbC2MFidsGAbCtfU5jNFO6x8C43d0Y
        0NXvwQk2s/ndadSsnDg1wXWuVZ3CATItGzaX+d9DVlEzwNt+WS8MBbt0pM9tJBR2cEOrhm
        On4vhcsfnEC0rOAY+pbyt/62rFDTQRs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-327-f3OoXQhuOge6F3gNpD125Q-1; Mon, 12 Dec 2022 04:06:12 -0500
X-MC-Unique: f3OoXQhuOge6F3gNpD125Q-1
Received: by mail-wm1-f69.google.com with SMTP id f20-20020a7bc8d4000000b003d1cda5bd6fso1752788wml.9
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 01:06:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xyZnfD0GKpCtoGnDuZNwaqbFZdn7D4bcR1Mw17gItoM=;
        b=5n4FA2q4oREClITfYTSMphNK13uIPULtap7X+oJrnqOfxqnoBz4ZhoZZ3vpZVEwbuZ
         LOvzcNgECfBfj3/IIvry7OAA1wy+EXI9bbI9Wsx4tdeBSbjr+wB9d5k4a9aJPOVsBN82
         kjryXUcAgtMfI1LoK5z1pyNhp88tcc26bsPcn/ML08SPfhksvanycPlXxMcEcW4187Os
         xmcxEzsSo5LuJCnND4Gq5By2xsLUVUVirucErLen7pCYDLTGx/Lk4IQPYxKEIZ7m2cgd
         oLiiS3m35XKLwH1HayPGmY8jd1kGOTGC7oqLD+IuT1Bc5cNCp8W+sXuDj4Sd1VnlP+yW
         qNEA==
X-Gm-Message-State: ANoB5pnAYn9CJSNtO3JQmgX1hwMwXj1/AcPuO7BzgBEMrmFkE6AjLcie
        FM5xvZBQGk+nkOyp6oaeULMIAW9wq0DMXBNpceGXmdiuOaJAcmUd/ArsqUMBR0+PCMSAfsITqZt
        91RVwxCenOTA1x9Y2Ixesaber
X-Received: by 2002:adf:e0ce:0:b0:238:3d56:f061 with SMTP id m14-20020adfe0ce000000b002383d56f061mr9864856wri.63.1670835970995;
        Mon, 12 Dec 2022 01:06:10 -0800 (PST)
X-Google-Smtp-Source: AA0mqf420ffJ13awaij/Y52UxGgBgOrQjohdoc4xUU12o3LXQ8ISYWq8M0p0IqFKvgDdusLqgNjxbg==
X-Received: by 2002:adf:e0ce:0:b0:238:3d56:f061 with SMTP id m14-20020adfe0ce000000b002383d56f061mr9864836wri.63.1670835970732;
        Mon, 12 Dec 2022 01:06:10 -0800 (PST)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id s14-20020a5d6a8e000000b00242814c2cf0sm8327648wru.4.2022.12.12.01.06.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Dec 2022 01:06:10 -0800 (PST)
Message-ID: <83ec1332-7e08-208e-31aa-d326af67337f@redhat.com>
Date:   Mon, 12 Dec 2022 10:06:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 1/4] driver core: Make driver_deferred_probe_timeout a
 static variable
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     John Stultz <jstultz@google.com>, linux-kernel@vger.kernel.org,
        Brian Masney <bmasney@redhat.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Peter Robinson <pbrobinson@redhat.com>,
        Enric Balletbo i Serra <eballetbo@redhat.com>,
        Steev Klimaszewski <steev@kali.org>,
        Rob Herring <robh@kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        linux-arm-msm@vger.kernel.org,
        Saravana Kannan <saravanak@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
References: <20221116115348.517599-1-javierm@redhat.com>
 <20221116115348.517599-2-javierm@redhat.com>
 <CANDhNCoa+LRu8B4+M+uU4_m2kd=HriO0SyNP=n=XpXwXG2k9LA@mail.gmail.com>
 <549800ec-6da2-64ad-62a6-c8e4a35dc212@redhat.com>
 <Y5bthMXYH1MuD9VY@kroah.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <Y5bthMXYH1MuD9VY@kroah.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/12/22 09:59, Greg Kroah-Hartman wrote:
> On Mon, Dec 12, 2022 at 09:50:16AM +0100, Javier Martinez Canillas wrote:

[...]

>> Could you please pick this patch? Is a fix independent of the other
>> patches in the series and it has already been acked by John.
> 
> It is the middle of the merge window and I can't take anything now until
> after 6.2-rc1 is out.  I also really can't take individual patches out
> of a patch series easily, so please just resend it as a single patch
> when 6.2-rc1 is out.
>

Sure, I will. Thanks!
 
> thanks,
> 
> greg k-h
> 

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

