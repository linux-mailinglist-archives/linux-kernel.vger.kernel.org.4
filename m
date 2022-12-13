Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6C164B5C3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 14:09:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235171AbiLMNJi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 08:09:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233881AbiLMNJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 08:09:35 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04E36E23
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 05:08:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670936932;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c5GbNffUHKoYDGS5GasSK3TAuvDPgSfJHeVsYif+NA4=;
        b=RPwLQ02YOU4bjE+8YoitHT2agEHnvcirARBYg/kMrTrHp+xUBEfm6yhxtEQ+2NjX03JNXP
        pJLV8QqlAmW6sg9f0KhXf0fYMAFJFfSEeUqEuZU9te+m+Fs7umoe2mNKrX2ydRpWKeyl9t
        3BG4iIjyGixtFy1st2HRPoAzef9B5vY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-131-ODvOl5QoNEu2wwID0VxOzQ-1; Tue, 13 Dec 2022 08:08:50 -0500
X-MC-Unique: ODvOl5QoNEu2wwID0VxOzQ-1
Received: by mail-wm1-f70.google.com with SMTP id bg25-20020a05600c3c9900b003cf3ed7e27bso4802363wmb.4
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 05:08:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c5GbNffUHKoYDGS5GasSK3TAuvDPgSfJHeVsYif+NA4=;
        b=E1Zp8hhbUJEKxKJSDoixpC6/dIvCDrgxFaO8BBYPNz28qYw4sFvBISlsYQHI70UzM8
         1BRhclWUDx41tWlqMCu+OR/FBPBllfP01NOpgmlnYLgPDiuEAPM6ywWP+lAGagdXl3jG
         0MESWK7HUoskZsbXCmm6fWoCWiL8XFfSrrt3BJ52P4fFg0fsonEKchiOgmhwiK+eGG28
         bVjDG6tqu7nK4BPgz0QjGSdCp6m9kUu+0S155VAdF7x4oAQ3zdSsEixgpXn2XbF8Z0YB
         U96KlQs5JQ5IEKwNjy70hMNGARLFws50MLcRgplWvAnGKiRZjev1HECUJJ5c+BnaLm8B
         Gn0w==
X-Gm-Message-State: ANoB5plSA5vE7Gfo7aRlsBFTer0cdH+sm8DXOctk9Y0Ce0FSGHeF4WIU
        NsVI3HcB/AW0KLnLHw0wuUgBqxaXmajuS8dPF04KfGOhqKMEhoipQHlpKH0wVPVWm1d9bap/8Dx
        bksQVhEkhTkWHF4WDFaf4M6PK
X-Received: by 2002:a5d:6591:0:b0:242:1ce4:bf47 with SMTP id q17-20020a5d6591000000b002421ce4bf47mr10987290wru.59.1670936929899;
        Tue, 13 Dec 2022 05:08:49 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7QYjlCoBgHey0f9pw7o07HPD1UnRbeqZ7uQNwA3VRyD2bIAB+tFnoLU8ojHCD6OQfLwLyCtQ==
X-Received: by 2002:a5d:6591:0:b0:242:1ce4:bf47 with SMTP id q17-20020a5d6591000000b002421ce4bf47mr10987284wru.59.1670936929645;
        Tue, 13 Dec 2022 05:08:49 -0800 (PST)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id g14-20020adffc8e000000b002421ed1d8c8sm11421142wrr.103.2022.12.13.05.08.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Dec 2022 05:08:48 -0800 (PST)
Message-ID: <13238048-f07c-3e8d-f170-5330ce94767c@redhat.com>
Date:   Tue, 13 Dec 2022 14:08:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 4/4] arm64: dts: qcom: sc8280xp: add missing spi nodes
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Brian Masney <bmasney@redhat.com>,
        Shazad Hussain <quic_shazhuss@quicinc.com>,
        Mark Brown <broonie@kernel.org>
Cc:     andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        konrad.dybcio@linaro.org, robh+dt@kernel.org,
        johan+linaro@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ahalaney@redhat.com, echanude@redhat.com, linux-spi@vger.kernel.org
References: <20221212182314.1902632-1-bmasney@redhat.com>
 <20221212182314.1902632-5-bmasney@redhat.com>
 <c1c7b1eb-08e7-2ba5-d89a-e0be8f76fd69@quicinc.com> <Y5hvlX35nr8xQKEd@x1>
 <77c29d8c-34b3-f508-26bf-22520ccc1f2a@linaro.org>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <77c29d8c-34b3-f508-26bf-22520ccc1f2a@linaro.org>
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

Hello Krzysztof,

Long time no see :)

On 12/13/22 14:02, Krzysztof Kozlowski wrote:
> On 13/12/2022 13:27, Brian Masney wrote:

[...]

> 
> qcom,spi-video-codec is still not specific enough. You need to describe
> real device behind spidev. To be clear - you do not describe userspace,
> but the device.
> 

Agree.

I believe Brian just used "qcom,spi-video-codec" as an example but is only
a make up name to illustrate the concept. QC needs to determine what would
be the correct <vendor,device> tuple for the IP block that the user-space
driver will drive.

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

