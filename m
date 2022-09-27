Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72BB65EC18C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 13:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231299AbiI0LgS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 07:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbiI0LgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 07:36:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85E033D5B3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 04:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664278574;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+PgvmRpoUZFCpfRCz+QVT2wprw6tx66g26X33Z5GRNU=;
        b=WIkEnoSA56kvzC0H99/v3oBqe+j+HqB0lamsNbOsgEQ3KkdDdwDDqSpDCRLnNGmtKHEL78
        h2M/7EPTqdXwgtXyMqEhAThns4wrc4vwRDvT8QR7jEc5eZ64SekIlELeWUABOO6G9kWM6z
        nnyUgfKQXIix4hkZsv5jKmgwtftGQAE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-625-rbFtKazoMiuoqiEv3IlR_w-1; Tue, 27 Sep 2022 07:36:13 -0400
X-MC-Unique: rbFtKazoMiuoqiEv3IlR_w-1
Received: by mail-wm1-f72.google.com with SMTP id e3-20020a05600c218300b003b4e4582006so2644403wme.6
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 04:36:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=+PgvmRpoUZFCpfRCz+QVT2wprw6tx66g26X33Z5GRNU=;
        b=OIEzfylSaKs23uLCjXV5PGTGlZzxbKsEWO+7kwhx66Zuttis2D80BOBDJ2FohyqHE/
         9xFsnJ+jeThCmMPdq0pUlkCYOaP6gn2rniZeRdi7Vm4dS1WqIPwa/ADJp+tg6CgB2/xm
         WWTkzW787lZvl33tXdE1XGdkqHydylRTctnV1I5e/loCXkvhWClvE0XBbcnHRQ6ETb6X
         pNRqTzb9mLTKaFTgdS9Pwbt2dqDcPRC4hp0MVnuQK+BMZmgXWr5VofWid/s79GxrfGR0
         c2wYybs4w29aNeqJss71gzL2cc7Je9RuoXKWPqdjt8yJeJ2K6avSr1ReCHgyZxRIIRjU
         +OzQ==
X-Gm-Message-State: ACrzQf1JH4gL1e8R6WAXS74mdImEywqG6RG0OjTWFQ+jxY7AOaW/C7cy
        I5MVcE3Gv4BpCpqV4onqWKwVscR0xrVFlxk2w09M0wo/GMZF+UHT8+cwf7gseYCeIPCpsnsmlMJ
        PymMkveybhmQVO2FJkczy4OM3
X-Received: by 2002:adf:e383:0:b0:228:9a53:612b with SMTP id e3-20020adfe383000000b002289a53612bmr17117924wrm.651.1664278572135;
        Tue, 27 Sep 2022 04:36:12 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM70Hw2qjdhcHs66zqzPuMKkQaLuieUwQ2TF2TX5gRN1X87+80U+3UuAk612MI5hIGS37EpjOw==
X-Received: by 2002:adf:e383:0:b0:228:9a53:612b with SMTP id e3-20020adfe383000000b002289a53612bmr17117897wrm.651.1664278571763;
        Tue, 27 Sep 2022 04:36:11 -0700 (PDT)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id c3-20020a5d63c3000000b00228da396f9dsm1597543wrw.84.2022.09.27.04.36.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Sep 2022 04:36:11 -0700 (PDT)
Message-ID: <fed13d05-999a-8c31-78d6-cd5efbe2a64e@redhat.com>
Date:   Tue, 27 Sep 2022 13:36:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH] drm/ssd130x: Use drm_atomic_get_new_plane_state()
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org
Cc:     David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org
References: <20220923083447.1679780-1-javierm@redhat.com>
 <8a974e5a-949a-5eb8-4f01-64e6114dafa7@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <8a974e5a-949a-5eb8-4f01-64e6114dafa7@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/26/22 09:24, Thomas Zimmermann wrote:
> 
> 
> Am 23.09.22 um 10:34 schrieb Javier Martinez Canillas:
>> The struct drm_plane .state shouldn't be accessed directly but instead the
>> drm_atomic_get_new_plane_state() helper function should be used.
>>
>> This is based on a similar patch from Thomas Zimmermann for the simpledrm
>> driver. No functional changes.
>>
>> Suggested-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
>> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> 
> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
> 

Pushed to drm-misc (drm-misc-next). Thanks!

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

