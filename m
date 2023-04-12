Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A28976E0116
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 23:41:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbjDLVli (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 17:41:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjDLVlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 17:41:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 609C33AA6
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 14:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681335646;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3402ptPprQnICYcpNgka/a4MlqR0CMRNa5wxHl7tKqM=;
        b=TMkaf7m6jiUJs1XZXmBpz5oaD9/19bVIkmfbP2/WK5B1OqAwH+slmbFMuugFgaA2XkY/06
        zhFjqQHrG/y4VkXIjPMznpK8/yln0BDQKhVVblXlOC8sZjwTTKFSeDyyoZenfb8LKyipDN
        3kl+0nDUcXH9Om/40hjNecYNPSmueZ0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-261-ibRuteuaNUGbZ3xtX_3Yng-1; Wed, 12 Apr 2023 17:40:45 -0400
X-MC-Unique: ibRuteuaNUGbZ3xtX_3Yng-1
Received: by mail-wm1-f72.google.com with SMTP id r20-20020a05600c35d400b003edd2023418so7618802wmq.4
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 14:40:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681335644; x=1683927644;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3402ptPprQnICYcpNgka/a4MlqR0CMRNa5wxHl7tKqM=;
        b=bY5nSGtQXXQfbM//atbkrFhkPSY2Ay61/I/92IFxZBd3EkFHiS1ZyY8XEBMUjXd+PE
         G5lNcA3ycBrg2TxeKHbLydqCkzQdgy3q0z1RgOgU5XRAJujfz7ObsHG15HXwRXfh52/Q
         vN4MWxAv2TebfHjCMjoBPBQfc3UdfKMSgQXlu4z/Rv10qoEGKehHFJNFQJNSZ5sR0CsT
         UtAMtdjNo6gOPVjzV2xTi78RQceEIiWzzFM2LDcIWqxOE/QwST1Dz/0NZDi497vVFe0p
         u0kEahxxA9bfKhySToDNtMUqzyLbRqgvPF9phYlLrGVbTxnJpAhwnUdPGS2Ett37vLcb
         lt2w==
X-Gm-Message-State: AAQBX9f1/6HMZgx92d0l7eAPC5vc4zxYOBeQ/ImfD0qcdeA9xeahtYIn
        s7a6rSXxLp+A8xjiKvGxWAJTyM/NGgenj1UE5mWIAbHUc1TEyLftirHgVZUNRnFrL6CGk5HMVHI
        fgjAT95UB6yMnEYbwum4qCyzn
X-Received: by 2002:a05:6000:1281:b0:2ee:d53b:d9ef with SMTP id f1-20020a056000128100b002eed53bd9efmr9963641wrx.55.1681335644314;
        Wed, 12 Apr 2023 14:40:44 -0700 (PDT)
X-Google-Smtp-Source: AKy350Y0roijCU4a1Gl2gjyzIFHhagHW9zTdNa2E+8Ko5ITsQqw0KUkF7702LR5DmI7Huudjddqhqw==
X-Received: by 2002:a05:6000:1281:b0:2ee:d53b:d9ef with SMTP id f1-20020a056000128100b002eed53bd9efmr9963629wrx.55.1681335644030;
        Wed, 12 Apr 2023 14:40:44 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id n11-20020a5d420b000000b002ceacff44c7sm18073377wrq.83.2023.04.12.14.40.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 14:40:43 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Pierre Asselin <pa@panix.com>
Cc:     Pierre Asselin <pa@panix.com>,
        Jocelyn Falempe <jfalempe@redhat.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Hans de Goede <hdegoede@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH] firmware/sysfb: Fix wrong stride when bits-per-pixel is
 calculated
In-Reply-To: <87fs94stgw.fsf@minerva.mail-host-address-is-not-set>
References: <20230412150225.3757223-1-javierm@redhat.com>
 <2e07f818ccdff7023a060e732d7c4ef6.squirrel@mail.panix.com>
 <87jzyhror0.fsf@minerva.mail-host-address-is-not-set>
 <beeff0335ab4cc244d214a7baadba371.squirrel@mail.panix.com>
 <CAFOAJEdKBUg91pDmNYYw5xigUxjifBgOLz2YgD+xQ+WyEy=V2w@mail.gmail.com>
 <1afd3044c2aca9322ecf304941c7df66.squirrel@mail.panix.com>
 <87fs94stgw.fsf@minerva.mail-host-address-is-not-set>
Date:   Wed, 12 Apr 2023 23:40:43 +0200
Message-ID: <87cz48srs4.fsf@minerva.mail-host-address-is-not-set>
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

Javier Martinez Canillas <javierm@redhat.com> writes:

[...]

>> ========== Bad after patch, typing blind to log in !==================
>> grub: gfxpayload=keep
>> [    0.003333] Console: colour dummy device 128x48
>> [    0.003333] printk: console [tty0] enabled
>> [    0.423925] fbcon: Taking over console
>> [    0.520030] pci 0000:01:05.0: vgaarb: setting as boot VGA device
>> [    0.520061] pci 0000:01:05.0: vgaarb: bridge control possible
>> [    0.520085] pci 0000:01:05.0: vgaarb: VGA device added:
>> decodes=io+mem,owns=io+mem,locks=none
>> [    0.520120] vgaarb: loaded
>> [    3.290444] simple-framebuffer simple-framebuffer.0: framebuffer at
>> 0xd8000000, 0x240000 bytes
>> [    3.290483] simple-framebuffer simple-framebuffer.0: format=r8g8b8,
>> mode=1024x768x24, linelength=3072
>
> Now, this is the part where things start to break I believe. Because you
> mentioned before that gfxpayload=keep used to set the format to xr8g8b8
> but now after my patch (and also after the original commit f35cd3fa7729)
> it is set to r8g8b8 instead.
>

I still don't understand why this particular configuration didn't work...

The framebuffer starts at 0xd8000000 and has a size of 0x240000 bytes, so
a r8g8b8 pixel format with resolution 1024x768 should be correct. Since is
1024 * 768 * (24 / 8) = 2359296 = 0x240000.

In any case, it seems that there is something wrong on how the screen_info
is reported to sysfb since you mentioned that gfxpayload=1024x768x32 leads
to a format=r8g8b8 and mode=1024x768x24, instead of the format=xr8g8b8 and
mode=1024x768x32 that is expected.

Could you please apply the following diff that will print all the relevant
fields from the screen_info that are used to calculate the bpp and stride.

My guess is that the rsvd_size and rsvd_pos are not correct and that's why
the bpp is set to 24 instead of 32.

diff --git a/drivers/firmware/sysfb_simplefb.c b/drivers/firmware/sysfb_simplefb.c
index 5dc23e57089f..6678ac6ff5b1 100644
--- a/drivers/firmware/sysfb_simplefb.c
+++ b/drivers/firmware/sysfb_simplefb.c
@@ -58,6 +58,13 @@ __init bool sysfb_parse_mode(const struct screen_info *si,
         * If a calculated bits_per_pixel is used instead of lfb_depth,
         * then also ignore lfb_linelength and calculate the stride.
         */
+
+       printk("sysfb: si->lfb_depth %u si->lfb_width %u\n", si->lfb_depth, si->lfb_width);
+       printk("sysfb: si->red_size %u si->red_pos %u\n", si->red_size, si->red_pos);
+       printk("sysfb: si->green_size %u si->green_pos %u\n", si->green_size, si->green_pos);
+       printk("sysfb: si->blue_size %u si->blue_pos %u\n", si->blue_size, si->blue_pos);
+       printk("sysfb: si->rsvd_size %u si->rsvd_pos %u\n", si->rsvd_size, si->rsvd_pos);
+
        if (si->lfb_depth > 8) {
                bits_per_pixel = max(max3(si->red_size + si->red_pos,
                                          si->green_size + si->green_pos,
@@ -69,6 +76,9 @@ __init bool sysfb_parse_mode(const struct screen_info *si,
                stride = si->lfb_linelength;
        }
 
+       printk("sysfb: bits_per_pixel %u si->lfb_linelength %u\n", bits_per_pixel, si->lfb_linelength);
+       printk("sysfb: stride %u\n", stride);
+
        for (i = 0; i < ARRAY_SIZE(formats); ++i) {
                const struct simplefb_format *f = &formats[i];
 
@@ -86,6 +96,7 @@ __init bool sysfb_parse_mode(const struct screen_info *si,
                        mode->width = si->lfb_width;
                        mode->height = si->lfb_height;
                        mode->stride = stride;
+                       printk("sysfb: format %s\n", f->name);
                        return true;
                }
        }

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

