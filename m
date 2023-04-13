Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E99EC6E13DD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 20:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbjDMSF0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 14:05:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjDMSFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 14:05:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C4A530DA
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 11:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681409082;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+dsa8AT9LrvaH3MnL8WKmBRioCu+s9PYiLJBxZ5H788=;
        b=HC3ZBRwr6K0Kq1cB1nnAoB0Vf4V+V4B1CfCoeojwHRiOduP5/izVpCkzL9X5ehoKsfh13M
        OWP8i8JGg+BqpuE57qVYbYSfLPIIQ/YSyiL1tdrZ7CNEF6RHFcWyC5gQmGQNu4jBWgWFC6
        go6YgZi1URW+FOPZKmFRN0MUwvG+iPM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-139-wqOZKno4PxuEx3p9hdlinQ-1; Thu, 13 Apr 2023 14:04:41 -0400
X-MC-Unique: wqOZKno4PxuEx3p9hdlinQ-1
Received: by mail-wm1-f72.google.com with SMTP id c19-20020a05600c0a5300b003f07515bce8so7069759wmq.5
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 11:04:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681409080; x=1684001080;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+dsa8AT9LrvaH3MnL8WKmBRioCu+s9PYiLJBxZ5H788=;
        b=F09lRs8EFPU8zSoQ72NNo7gOZvPLYGxXfln9J73Fj/KlH91D+JKukkXMAo0Oo+lDXG
         m+VH3+ZY9XOzYOBdknFQ+CsSTQ8HpRiFQI8waUq88HQbPYDhJIHCBgR/eptSbSBZ/+wD
         HwKq6yff4N4kHtmSTDxbA5J2d09k4OsGvs3KGBm1N2mZQww47X98c8ObVnO0W+hRXL/4
         QQ5RppQ0CbEtFxJydF883b3MmlvsbpvsAa24D8aZWXDupueMLNbnyiUuuspMRiNYOU83
         lLa/TWJeiGhkwBgxxYLchyA+QgrHvrbNmyCLHTn1CNEc9EbXs2v2RDhXUiOEFKAMBCIu
         cJEw==
X-Gm-Message-State: AAQBX9etfXhxh/cyXDCIXs5bT0tfFUCyohuIbl/ac8KsXHakfSFbDBia
        f5vONHDWJvPDZP4YBGVF05zM+7aIWBsyyGQt5MpH3cPaZOiY9FNsJvOTKLIsNFzoM7fBJBMW6AY
        THf2gHf8AZzlAGPJpsGI8a7kG
X-Received: by 2002:a05:600c:2943:b0:3f0:7ddf:d8e1 with SMTP id n3-20020a05600c294300b003f07ddfd8e1mr2593794wmd.14.1681409080133;
        Thu, 13 Apr 2023 11:04:40 -0700 (PDT)
X-Google-Smtp-Source: AKy350a3ljC8OBfSdasM597Vx3IM790lSUv258Si+HcKeU4d67V+XpRuhf1VUC5il7UahvwGB+r8kQ==
X-Received: by 2002:a05:600c:2943:b0:3f0:7ddf:d8e1 with SMTP id n3-20020a05600c294300b003f07ddfd8e1mr2593781wmd.14.1681409079785;
        Thu, 13 Apr 2023 11:04:39 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id g5-20020a7bc4c5000000b003ee10fb56ebsm2444844wmk.9.2023.04.13.11.04.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 11:04:39 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Pierre Asselin <pa@panix.com>
Cc:     Pierre Asselin <pa@panix.com>, tzimmermann@suse.de,
        linux-kernel@vger.kernel.org, jfalempe@redhat.com,
        hdegoede@redhat.com, dri-devel@lists.freedesktop.org,
        daniel.vetter@ffwll.ch, ardb@kernel.org
Subject: Re: [PATCH] firmware/sysfb: Fix wrong stride when bits-per-pixel is
 calculated
In-Reply-To: <84b1b88aabf7e70951d7680f05694249.squirrel@mail.panix.com>
References: <20230412150225.3757223-1-javierm@redhat.com>
 <2e07f818ccdff7023a060e732d7c4ef6.squirrel@mail.panix.com>
 <87jzyhror0.fsf@minerva.mail-host-address-is-not-set>
 <beeff0335ab4cc244d214a7baadba371.squirrel@mail.panix.com>
 <CAFOAJEdKBUg91pDmNYYw5xigUxjifBgOLz2YgD+xQ+WyEy=V2w@mail.gmail.com>
 <1afd3044c2aca9322ecf304941c7df66.squirrel@mail.panix.com>
 <87fs94stgw.fsf@minerva.mail-host-address-is-not-set>
 <87cz48srs4.fsf@minerva.mail-host-address-is-not-set>
 <40edb0fdb0eaff434f4872dd677923a6.squirrel@mail.panix.com>
 <87a5zcsqg8.fsf@minerva.mail-host-address-is-not-set>
 <9e6fff69b09b36cbdd96499cd0015154.squirrel@mail.panix.com>
 <4PxhQn3zK1zcbc@panix1.panix.com>
 <87o7nsuumt.fsf@minerva.mail-host-address-is-not-set>
 <84b1b88aabf7e70951d7680f05694249.squirrel@mail.panix.com>
Date:   Thu, 13 Apr 2023 20:04:38 +0200
Message-ID: <87edonr749.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Pierre Asselin" <pa@panix.com> writes:

>> diff --git a/drivers/firmware/sysfb_simplefb.c
>> b/drivers/firmware/sysfb_simplefb.c
>> index 82c64cb9f531..0ab8c542b1f5 100644
>> --- a/drivers/firmware/sysfb_simplefb.c
>> +++ b/drivers/firmware/sysfb_simplefb.c
>> @@ -55,14 +55,10 @@ __init bool sysfb_parse_mode(const struct screen_info
>> *si,
>>  	 * ignore simplefb formats with alpha bits, as EFI and VESA
>>  	 * don't specify alpha channels.
>>  	 */
>> -	if (si->lfb_depth > 8) {
>> -		bits_per_pixel = max(max3(si->red_size + si->red_pos,
>> -					  si->green_size + si->green_pos,
>> -					  si->blue_size + si->blue_pos),
>> -				     si->rsvd_size + si->rsvd_pos);
>> -	} else {
>> +	if (si->lfb_depth > 8)
>> +		bits_per_pixel = si->lfb_linelength * 8 / si->lfb_width;
>> +	else
>>  		bits_per_pixel = si->lfb_depth;
>> -	}
>>
>>  	for (i = 0; i < ARRAY_SIZE(formats); ++i) {
>>  		const struct simplefb_format *f = &formats[i];
>>
>> base-commit: e62252bc55b6d4eddc6c2bdbf95a448180d6a08d
>> --
>> 2.40.0
>
> Patch is good on both boxes.
>

Thanks for testing it! I'll wait for Thomas though before posting as a
proper patch. I'm sure whether we can rely on lfb_linelength or not...

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

