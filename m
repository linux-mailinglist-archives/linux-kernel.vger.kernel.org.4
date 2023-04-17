Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 208A16E4300
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 10:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbjDQI7N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 04:59:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjDQI7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 04:59:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5161AE63
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 01:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681721900;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OQahvJkJyfsl2iBHDg48gWYNrk5bRLMj3uUnlrcI4PM=;
        b=XSMnaIB11Kl804rWsOqpFpTW/Gy0cYcxpN/8Sygc7JXNu21bJMhu0xX897nUzlcXofsbMJ
        VfE5FDn0FejXQia1qKJi7BPaDpvC6CZylNN8vAZDUbP8jdQbURTIa++5+RnG2lqehNzrm1
        p/H7ddpYGTAS7NH1ZG9Q6iKDtxpM9HE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-340-NCjZo4hwNTKfO05sJkxjNQ-1; Mon, 17 Apr 2023 04:58:19 -0400
X-MC-Unique: NCjZo4hwNTKfO05sJkxjNQ-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-2ef39671038so336953f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 01:58:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681721898; x=1684313898;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OQahvJkJyfsl2iBHDg48gWYNrk5bRLMj3uUnlrcI4PM=;
        b=Oe4XcBpQZrVdZvqGbnHCZ4o/WOCjteuQd+N4h1SX/zyHxYvcn9GgcHlQfnRlmejbz2
         L8G/jbVP1EgkcPRVHS0nv7B6L98DI1hqv4t4RjIPEgkkDJBrAYD+NUb9q9Sddp66Q5qF
         Wf2LsYWw0Kfs3I9oy6Gtu8w77Q9IJqxNYSiINrwv6rsfPE43cW+ndNT1plHRKJEB25v4
         c7R0VqiwCUzA1VGgE+Ggw3Tt3wXbbFK8A8REU6bbxm2NRBtNWnHXEs7WLl7ANny1R7gx
         dSwejsVLuEiMnVEaUXg1k6Tkaw0MbnH7XV8kTSXfXgpOiQctCVW2xjRKrrDmsJQwOTYC
         HXDw==
X-Gm-Message-State: AAQBX9flkmShoeVWu+dE9EzbEgn+DTOmMr8HM+Cf5Uf/ylYRRyuBZv86
        +ZG78iUKt3sUhxlW6per3OxFf51LeuAsdwXp/rHOSpH5/qWqGSEULiUHroENC9rKP1pMmX1v3kd
        vrvp4ihKKGka5SMqry7eN9XMK
X-Received: by 2002:adf:f285:0:b0:2d8:4e4:8cf1 with SMTP id k5-20020adff285000000b002d804e48cf1mr3888923wro.21.1681721898024;
        Mon, 17 Apr 2023 01:58:18 -0700 (PDT)
X-Google-Smtp-Source: AKy350Yes3M1Odd4PdfUkZGoppbAMuZJHcQ1huVKlfUi03Wa/UcFApHhOHBNB3F7463IlokZBR/obw==
X-Received: by 2002:adf:f285:0:b0:2d8:4e4:8cf1 with SMTP id k5-20020adff285000000b002d804e48cf1mr3888905wro.21.1681721897701;
        Mon, 17 Apr 2023 01:58:17 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id v14-20020a5d678e000000b002f2b8cb5d9csm10006760wru.28.2023.04.17.01.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 01:58:17 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        Pierre Asselin <pa@panix.com>
Cc:     jfalempe@redhat.com, daniel.vetter@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        hdegoede@redhat.com, ardb@kernel.org
Subject: Re: [PATCH] firmware/sysfb: Fix wrong stride when bits-per-pixel is
 calculated
In-Reply-To: <23d45518-3565-e915-c6d4-45dabe82ea4c@suse.de>
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
 <f3004fccf706fb3cbb7ef6877dcd9168.squirrel@mail.panix.com>
 <23d45518-3565-e915-c6d4-45dabe82ea4c@suse.de>
Date:   Mon, 17 Apr 2023 10:58:16 +0200
Message-ID: <87zg76evh3.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Hi,
>
> thanks a lot to both of you for this bug fix.
>
> Am 13.04.23 um 03:34 schrieb Pierre Asselin:
>>> (not tested)
>> 
>> Tested.  It fixes the regression on my laptop.
>> 
>>> diff --git a/drivers/firmware/sysfb_simplefb.c
>>> b/drivers/firmware/sysfb_simplefb.c
>>> index 82c64cb9f531..9f5299d54732 100644
>>> --- a/drivers/firmware/sysfb_simplefb.c
>>> +++ b/drivers/firmware/sysfb_simplefb.c
>>> @@ -56,10 +56,11 @@ __init bool sysfb_parse_mode(const struct screen_info
>>> *si,
>>>   	 * don't specify alpha channels.
>>>   	 */
>>>   	if (si->lfb_depth > 8) {
>>> -		bits_per_pixel = max(max3(si->red_size + si->red_pos,
>>> +		bits_per_pixel = max3(max3(si->red_size + si->red_pos,
>>>   					  si->green_size + si->green_pos,
>>>   					  si->blue_size + si->blue_pos),
>>> -				     si->rsvd_size + si->rsvd_pos);
>>> +				     si->rsvd_size + si->rsvd_pos,
>>> +				     si->lfb_depth);
>
> I'm OK with this change. There's a comment
>
>   "The best solution is to compute bits_per_pixel here and ignore 
> lfb_depth."
>
> I'd change this to
>
>   "The best solution is to compute bits_per_pixel here from the color 
> bits, the reserved bits and the reported color depth; whatever is highest."
>
> That will hopefully clarify the meaning of these max3() statements. They 
> are not obvious at first.
>

I'm OK with this as well but then should probably also apply my patch [1]
that computed the stride too. Since if we don't trust the lfb_depth and
calculate the BPP, then we shouldn't trust the reported line length too.

As Pierre reported in the thread [2], when the wrong BPP was calculated (and
wrong pixel format chosen), the line lenght didn't match the BPP * lfb_width.

He mentioned that it was like this:

 format=r8g8b8, mode=1024x768x24, linelength=4096

Instead of the expected:

 format=r8g8b8, mode=1024x768x24, linelength=3072

My patch in [1], fixed the linelength calculation so it was internally
consistent (but still wrong since the pixel format was really xr8g8b8).

In other words, I think that we should either:

a) Trust the lfb_linelength and lfb_width (we are already doing that since
   mode->stride and mode->width are set to those once the format matches).
   
   If we decided to trust those, then the bits-per-pixel could just be
   calculated as: bits_per_pixel = si->lfb_linelength * 8 / si->lfb_width

   which is what I do on my v2 patch [3].

b) Not trust lfb_linelength, since that would need to be recalculated after
   the BPP was calcualted. That's why I mentioned that we need Pierre's fix +
   my patch [1] that did:

   stride = DIV_ROUND_UP(si->lfb_width * bits_per_pixel, 8)

But calculating a BPP yet blindly using linelength doens't make sense to me.

[1]: https://lists.freedesktop.org/archives/dri-devel/2023-April/399963.html
[2]: https://lore.kernel.org/dri-devel/dfb4f25ca8dfb0d81d778d6315f104ad.squirrel@mail.panix.com/
[3]: https://lists.freedesktop.org/archives/dri-devel/2023-April/400088.html

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

