Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBAF560BDC3
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 00:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232046AbiJXWrv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 18:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231460AbiJXWrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 18:47:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A88272CDD7C
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 14:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666645710;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Pm5HJkjYWeeX/qs3JDehVtgKORU0AuoMo2twQDux5eA=;
        b=KKmkXtdCSp5S3/ZCDaMAIyF0iQmz2nPD7IBDPufWLYj610ulrHSeJRioIfeoD5M9eL453L
        7m7ovWj/QVx/7OzdJ6IAmuT+LpFVRE7VdKwAawN1GBW/JAXUjRGXhFQXPdM9cy3+GcMjMZ
        K/xmXLdSjD30HMgSKy2yuM/jxpDpabI=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-477-4KwjLKokMceVmMSXvvrbJg-1; Mon, 24 Oct 2022 09:24:01 -0400
X-MC-Unique: 4KwjLKokMceVmMSXvvrbJg-1
Received: by mail-lj1-f198.google.com with SMTP id p6-20020a2e8046000000b0027703bb5701so2170568ljg.11
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 06:24:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pm5HJkjYWeeX/qs3JDehVtgKORU0AuoMo2twQDux5eA=;
        b=zXn1W5/lWN/yIY5SNSz3tkdGtNA2DMXuSGi4+LN6R2VEGONUdDZO5+FKmsehHFSFu9
         eCKoXHF6A9c5TiJus87XPgvubICeD/K5TVUHArliqjM4+qBXylXhUXR7lhLkTRvtOpbn
         PGsdGWhAO1rjiT8JayrJkkJ9FzJVlk0/6xxRtHH3DYokJfem2UOQuIAwKqg4zGUk/Seg
         8kxRPJf5Lf343MlPn/ssB0NXBmFDS8qLTT0olGZNq4JsZMj7J7GtqysbTFLdzzkH69yU
         SK37UmfYhi4LsV8bpyku+6OILpTFOVYnHZy9LVP7j321xxpgOj3Ue8UpLyjHy4NqqXgi
         qRug==
X-Gm-Message-State: ACrzQf0ZlV9vIUYnVQCJDFG/6p/YTo43dYoZwBqxi3kwmSlbNwrDffc9
        n4XHhap1nUojpLLR+zacC+Zx1nJujkBiX86Dl+k+1+JGUDOQabqKUvz1k81XVTYHgitLLvjr+OL
        qJ1sUTWSSe2fOPnl2khOQ3kII
X-Received: by 2002:a05:6512:3d0b:b0:4a2:6d15:91ff with SMTP id d11-20020a0565123d0b00b004a26d1591ffmr12397312lfv.575.1666617839951;
        Mon, 24 Oct 2022 06:23:59 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6nRpfOUd7fXfaQxZAoL/YNjVZG4I1hOQtgleKwhNKXvtlVx02RUh+6naoowPVHW1NVhRqxQg==
X-Received: by 2002:a17:906:8a6a:b0:79e:2efe:e0 with SMTP id hy10-20020a1709068a6a00b0079e2efe00e0mr12680099ejc.401.1666617828842;
        Mon, 24 Oct 2022 06:23:48 -0700 (PDT)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id b27-20020a17090630db00b0073dbaeb50f6sm15619252ejb.169.2022.10.24.06.23.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 06:23:48 -0700 (PDT)
Message-ID: <84d86b61-7694-2e22-3593-b11b3ce33cf8@redhat.com>
Date:   Mon, 24 Oct 2022 15:23:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 00/22] Fallback to native backlight
Content-Language: en-US
To:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
        Akihiko Odaki <akihiko.odaki@daynix.com>
Cc:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jonathan Corbet <corbet@lwn.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        "Lee, Chun-Yi" <jlee@suse.com>, Mark Gross <markgross@kernel.org>,
        Corentin Chary <corentin.chary@gmail.com>,
        Cezary Jackiewicz <cezary.jackiewicz@gmail.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Jonathan Woithe <jwoithe@just42.net>,
        Ike Panhc <ike.pan@canonical.com>,
        Daniel Dadap <ddadap@nvidia.com>,
        Kenneth Chan <kenneth.t.chan@gmail.com>,
        Mattia Dongili <malattia@linux.it>,
        Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
        Azael Avalos <coproscefalo@gmail.com>,
        Lee Jones <lee@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Helge Deller <deller@gmx.de>,
        Robert Moore <robert.moore@intel.com>,
        dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        intel-gfx@lists.freedesktop.org,
        platform-driver-x86@vger.kernel.org,
        acpi4asus-user@lists.sourceforge.net,
        ibm-acpi-devel@lists.sourceforge.net, linux-fbdev@vger.kernel.org,
        devel@acpica.org
References: <20221024113513.5205-1-akihiko.odaki@daynix.com>
 <746e5cc6-516f-8f69-9d4b-8fe237de8fd6@redhat.com>
 <edec5950-cec8-b647-ccb1-ba48f9b3bbb0@daynix.com>
 <20221024131451.lvkesdg3kvyvbi7n@pali>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20221024131451.lvkesdg3kvyvbi7n@pali>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/24/22 15:14, Pali Rohár wrote:
> On Monday 24 October 2022 21:58:57 Akihiko Odaki wrote:
>> Regarding the second limitation, I don't even understand the difference
>> between vendor and native. My guess is that a vendor backlight device uses
>> vendor-specific ACPI interface, and a native one directly uses hardware
>> registers. If my guess is correct, the difference between vendor and native
>> does not imply that both of them are likely to exist at the same time. As
>> the conclusion, there is no more motivation to try to de-duplicate the
>> vendor/native combination than to try to de-duplicate combination of devices
>> with a single type.
> 
> Hello! I just want to point one thing. On some Dell laptops there are
> 3 different ways (= 3 different APIs) how to control display backlight.
> There is ACPI driver (uses ACPI), GPU/DRM driver (i915.ko; uses directly
> HW) and platform vendor driver (dell-laptop.ko; uses vendor BIOS or
> firmware API).

Right and that is just one example of laptops which can register both
vendor + native backlight devices, which is why this whole series is
a bad idea.

Regards,

Hans



> Just every driver has different pre-calculated scaling
> values. So sometimes user wants to choose different driver just because
> it allows to set backlight level with "better" granularity. Registering
> all 3 device drivers is bad as user does not want to see 3 display
> panels and forcing registration of specific one without runtime option
> is also bad (some of those drivers do not have to be suitable or has
> worse granularity as other).

