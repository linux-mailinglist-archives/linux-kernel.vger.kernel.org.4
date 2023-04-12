Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E173B6E01B2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 00:10:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbjDLWK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 18:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjDLWKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 18:10:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D35761A4
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 15:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681337371;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yRj54bgaB8gZZi4XXPwLVXURq2Cocc/7c3rY+uFVd7I=;
        b=Bgc3vv3AK+Ov7yLC1TmiFPqTmRAY6Oxe/9pppLvSa6FJGOpBUNG7jPVtBLxuSXNDQa514b
        KFQH8YG2cncneQJ9hzVptP2z9usumcLkI9q5x1RZwvQMwPrEZJUwsX6/NrfcN8I5MY8HVw
        CROQEb/tj7P2aXWcXGCKq15O1eber5w=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-287-JTQNv9z4N_OOAX4VfPCOtg-1; Wed, 12 Apr 2023 18:09:29 -0400
X-MC-Unique: JTQNv9z4N_OOAX4VfPCOtg-1
Received: by mail-wm1-f70.google.com with SMTP id bg22-20020a05600c3c9600b003ef6ee937b8so3320789wmb.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 15:09:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681337368; x=1683929368;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yRj54bgaB8gZZi4XXPwLVXURq2Cocc/7c3rY+uFVd7I=;
        b=bbIaOxJXr7ScvXRdk2MY2lR/Zsrt3RhT8Fi1HuZM6P91LuEFjWoLl7rW2ewi27DXY/
         SP1RUByOZyPEhi7QJ7NHnaDEalC94Nm4Db/C0P7K0nda5CKymunZprsS87vSpF/85djz
         6azCLYkUVUDTSePeJNYztevBfDiHvgBjdj8rtOd6qI3ZCGjuWeKR4xSliKp6g2zHyrud
         jfKQV9zCvyFHazUhVw9zbGIeohjpvsupimeGAnFHLYv2eDcKgW6BXAMMkoXgUoFq3kiU
         X64LMSb5E9cuq37O+KG3pMO6M62p67GpUqUPgxN+MFT3LJTuAkz8XKusVz9a2AvQ+RdJ
         I4jQ==
X-Gm-Message-State: AAQBX9dxXx6MnGeUOOjpHlaE6qJa0zuceVFythBtO8O6tBIX1D8TpOGA
        XvwsF3IQ0GPhBEeDn8tZV30pshKnrm7cwKvAwDPlyey9L7d7DX8vgyf+qVZGjjN3M0mGqqWYXtB
        HIVsnfIM0cHtqIJv228uNeqUT
X-Received: by 2002:a5d:690d:0:b0:2ef:6371:1b0e with SMTP id t13-20020a5d690d000000b002ef63711b0emr5168208wru.59.1681337368826;
        Wed, 12 Apr 2023 15:09:28 -0700 (PDT)
X-Google-Smtp-Source: AKy350bAsuc0qAu1f2vhFNzUPfOLWRskc1H352Gxo6cbSyy8PAO5iro+nR9z1hsSp3O4jwehRSnFLQ==
X-Received: by 2002:a5d:690d:0:b0:2ef:6371:1b0e with SMTP id t13-20020a5d690d000000b002ef63711b0emr5168196wru.59.1681337368566;
        Wed, 12 Apr 2023 15:09:28 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id y12-20020a5d470c000000b002f598008d50sm283235wrq.34.2023.04.12.15.09.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 15:09:28 -0700 (PDT)
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
In-Reply-To: <40edb0fdb0eaff434f4872dd677923a6.squirrel@mail.panix.com>
References: <20230412150225.3757223-1-javierm@redhat.com>
 <2e07f818ccdff7023a060e732d7c4ef6.squirrel@mail.panix.com>
 <87jzyhror0.fsf@minerva.mail-host-address-is-not-set>
 <beeff0335ab4cc244d214a7baadba371.squirrel@mail.panix.com>
 <CAFOAJEdKBUg91pDmNYYw5xigUxjifBgOLz2YgD+xQ+WyEy=V2w@mail.gmail.com>
 <1afd3044c2aca9322ecf304941c7df66.squirrel@mail.panix.com>
 <87fs94stgw.fsf@minerva.mail-host-address-is-not-set>
 <87cz48srs4.fsf@minerva.mail-host-address-is-not-set>
 <40edb0fdb0eaff434f4872dd677923a6.squirrel@mail.panix.com>
Date:   Thu, 13 Apr 2023 00:09:27 +0200
Message-ID: <87a5zcsqg8.fsf@minerva.mail-host-address-is-not-set>
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

>> Javier Martinez Canillas <javierm@redhat.com> writes:
>>
>> I still don't understand why this particular configuration didn't work...
>>
>> The framebuffer starts at 0xd8000000 and has a size of 0x240000 bytes, so
>
> Says who ?  It's the same grub, same video mode as before the regression,
> so the size is probably 0x300000 like it always was.
>
>> a r8g8b8 pixel format with resolution 1024x768 should be correct. Since is
>> 1024 * 768 * (24 / 8) = 2359296 = 0x240000.
>
> That is internally consistent, but at variance with the video mode
> set up by grub.
>
> It is better to sqeeze bits by 4:3 on each line (regression) than to
> scatter 4 logical lines across 3 physical lines (regression, patched) !
>

Indeed. I noticed now that the IORESOURCE_MEM is set-up in the function
sysfb_create_simplefb() so is likely that is internally consistent as you
said but wrong :)

>> Could you please apply the following diff that will print all the relevant
>> fields from the screen_info that are used to calculate the bpp and stride.
>
> YES !  I can't peer into that struct screen_info and I don't know to
> write the printk's.  (Hm, doesn't look too hard, but trust me, I would
> fumble it.)
>
> I'll back out the original patch first.
> Stand by.
>
> --PA
>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

