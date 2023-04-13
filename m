Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 246E06E1266
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 18:35:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbjDMQfd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 12:35:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjDMQfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 12:35:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B50CAD
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 09:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681403685;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ekA2VCpAp9UKw6KLbdSwuXdGQWeqh5YSiPTkG8jESh0=;
        b=VnT3dj+TNCPHDQxr5xUrYkAywySvTYAuZe5VrK2QAI22G1unHdpGbuvBQL3A7C2UMqI6hS
        z9S5CltRYwehNhAUnH1o2YQOGnBMKcVTjLBFZLja0nCe2GbB3lYsDqIJsdzvb4GYJeIjwV
        6MwQHyErLoi+7hlp81w8JHKe8equ0Ps=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-C5Fi5ad1OhiptiXY5kC9Bw-1; Thu, 13 Apr 2023 12:34:43 -0400
X-MC-Unique: C5Fi5ad1OhiptiXY5kC9Bw-1
Received: by mail-wm1-f69.google.com with SMTP id ay4-20020a05600c1e0400b003f0ad935168so698871wmb.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 09:34:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681403682; x=1683995682;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ekA2VCpAp9UKw6KLbdSwuXdGQWeqh5YSiPTkG8jESh0=;
        b=DKmeUbh5Qx08IhbGTpvdTm1cXi/RSLSgUxH78Hz4OO6Z0Sf5Qk0BWwVJ4fzYVsAmoY
         So6/NhnU5XO5BAkrLXeXbGQhxbC302o+a2kSrASkP/bFEXHJrZ6KxwPcaF+CcjyLRQum
         a9JOtQIylV5GuRfVZJQrTp0MfRcL/nD/D0NTylE/B/fMMTxa10+drQp2hnhEWGjrdJ0k
         /bgq6NGyDp6rFV41CIcUNG/Y0hxVSECWGvOyy/vNhCTVUIV/E4BPkeYp3v6HPaiPUZZM
         nJRNrOL/HZDQzKqcsr/HrY+khBf/UNTfFmjOKQpd7MGoLfGQDwIZEoL78MVwxM+Cr7Xs
         lcNw==
X-Gm-Message-State: AAQBX9cBCngQruiLkGjs3JOWmvtHKB6FRcuunQarcxdRouVvbXIDk+SV
        BiVJ+NMrNpACNMN9tF6ilra0D8MDF+NZlWxuvEj+CyTzK45rNa2r1GrWExPHYvOxJrcXhCuVpTI
        +QMJ2SM8hKduY98fqEJpVCqDe
X-Received: by 2002:a7b:cd93:0:b0:3ed:320a:3721 with SMTP id y19-20020a7bcd93000000b003ed320a3721mr2450642wmj.22.1681403682717;
        Thu, 13 Apr 2023 09:34:42 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZRh9fa4sewh00qfbeBg0LvlQLLgGJvfMgChhNLKe98mfIgoWkSSF5jrm9Rl1/yQtbMURZNqQ==
X-Received: by 2002:a7b:cd93:0:b0:3ed:320a:3721 with SMTP id y19-20020a7bcd93000000b003ed320a3721mr2450625wmj.22.1681403682436;
        Thu, 13 Apr 2023 09:34:42 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id f16-20020a05600c155000b003f0a1c18128sm3194059wmg.29.2023.04.13.09.34.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 09:34:42 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Pierre Asselin <pa@panix.com>
Cc:     Pierre Asselin <pa@panix.com>, tzimmermann@suse.de,
        linux-kernel@vger.kernel.org, jfalempe@redhat.com,
        hdegoede@redhat.com, dri-devel@lists.freedesktop.org,
        daniel.vetter@ffwll.ch, ardb@kernel.org
Subject: Re: [PATCH] firmware/sysfb: Fix wrong stride when bits-per-pixel is
 calculated
In-Reply-To: <ae5f6784c72e1b31cdf7766d3c6dbe0c.squirrel@mail.panix.com>
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
 <ae5f6784c72e1b31cdf7766d3c6dbe0c.squirrel@mail.panix.com>
Date:   Thu, 13 Apr 2023 18:34:40 +0200
Message-ID: <87jzyfrba7.fsf@minerva.mail-host-address-is-not-set>
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

>> pa@panix.com (Pierre Asselin) writes:

[...]

>>> -		bits_per_pixel = max(max3(si->red_size + si->red_pos,
>>> +		bits_per_pixel = max3(max3(si->red_size + si->red_pos,
>>>  					  si->green_size + si->green_pos,
>>>  					  si->blue_size + si->blue_pos),
>>> -				     si->rsvd_size + si->rsvd_pos);
>>> +				     si->rsvd_size + si->rsvd_pos,
>>> +				     si->lfb_depth);
>
>
>> I would defer to Thomas but personally I don't like it. Seems to me that
>> this is getting too complicated just to workaround buggy BIOS that are not
>> reporting consistent information about their firmware-provided
>> framebuffer.
>
> Okay, but remember, this is a regression.  The buggy BIOSes were there

Yes, I agree that is a regression and has to be fixed. I'm just arguing
against this particular fix.

> the whole time and the old code that matched f->bits_per_pixel against
> si->lfb_depth used to work against these buggy BIOSes.
>
> And is it a bug, or is it an underspecified standard ?  "These bits aren't
> reserved, we just ignore them" or some such.
>
> My reading of Thomas' comments in the code was that sometimes lfb_depth
> was reported too small but never too large ?  But I'm not sure.  It's
> true in my two cases.
>

I (mis?)understood that it could be too small as well. But that's why I
prefer Thomas to chime in before agreeing on any path forward. But he is
in vacation this week I believe.

>> I would either trust the pixel channel information (what Thomas patch did)
>> + my patch to calculate the stride (since we can't trust the line lenght
>> which is based on the reported depth) + a DMI table for broken machines.
>
>> But that will only work if your systems are the exception and not a common
>> issue, otherwise then Thomas' approach won't work if there are too many
>> buggy BIOS out there.
>
> The laptop is ancient but the Dell tower is maybe 4 years old.  The
> BIOS is 09/11/2019 according to dmidecode, and the most recent for
> this box.
>

I see.

>> Another option is to do the opposite, not calculate a BPP using the pixel
>> and then use that value to calculate a new stride, but instead assume that
>> the lfb_linelength is correct and use that to calculate the BPP.
>
> Or reject (some) inconsistencies in the struct screen_info and return
> false, so the kernel falls back to e.g. vesa ?
>

That a reasonable approach too. But better if we can make simpledrm work
too since many distros have dropped all the fbdev drivers in favor of it.

>> Something like the following patch, which should also fix your regression
>> and may be enough to address Thomas' concerns of inconsistent depths too?
>
> I'll try that patch.
>

Thanks for all your information and testing with this bug!

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

