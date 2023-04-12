Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDE206DFCC4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 19:32:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbjDLRcX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 13:32:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjDLRcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 13:32:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C399E40C5
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 10:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681320695;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TfEBVoMuh9JyHTvdb8tDKkvHKW1yHCS+PCAl2pLfY2E=;
        b=WPfGzFLNFO9WVEjvKBEZZzRv8gPN8n590wtogjpU8zyDuXtxdW7EVsoWg2fCzVuAUPrPNp
        D6qJpbIcFY/E+ynxv7kaH24XlqHUl123Xs23yayKFJHF66AcZfX1r9+U+JTfG6j520QB/M
        1Pcu+k1dZDItkLi+CchWnFt5e4gRW/0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-533-xI5swbjwMjaSScZdEPsnWw-1; Wed, 12 Apr 2023 13:31:33 -0400
X-MC-Unique: xI5swbjwMjaSScZdEPsnWw-1
Received: by mail-wm1-f69.google.com with SMTP id c19-20020a05600c0a5300b003f07515bce8so5330015wmq.5
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 10:31:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681320692; x=1683912692;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TfEBVoMuh9JyHTvdb8tDKkvHKW1yHCS+PCAl2pLfY2E=;
        b=jjwiHMo6MyhkNLdlG9MCpIAqsAHVlWo94Fkpf4lDtG00uZvVoQPb+BkDQWCPAlXUkc
         wEjwzMh+cPmlEFVpYwTbjDXs7EvN4gBVilb3FkAFsGDemFivd1RKeSy4mzVqn+9o7RnI
         /YA9cvQ3h42A2+h+yWlnzmaoKtInTQkbs4S1n0i7UnfO9DVusMrVGFRJCveTvLkT22z/
         a0Yqs1xtrjWsVOxkoCqHKjmJMqVjiNNCthKzvA89PG+1l79Z1kSPnLL2ZVuV5w5/BKzx
         VTRW/B1JNVlyysB2Ye4i7QItDtsCbbJqx8Z63sn2oxrnoFm8Jr3rgcWakgZzZqLogtYq
         OrSg==
X-Gm-Message-State: AAQBX9ehB7Q4GrWBM4f6ms1xYPyQC6PaKqxAtRcmkLNddM28hA1jl9fr
        W/08ZU43kDGBXH9+fbAA8GDMqQqrNjDe/1ya01J24lJFFXeW0Vdgao3xKItjxmf+jobiDP08rT3
        UpH5YglZtaDsmo4vMPSnAn6Gk2B5gLCJu
X-Received: by 2002:a5d:4f06:0:b0:2ce:a7b3:1c71 with SMTP id c6-20020a5d4f06000000b002cea7b31c71mr13271013wru.35.1681320692687;
        Wed, 12 Apr 2023 10:31:32 -0700 (PDT)
X-Google-Smtp-Source: AKy350YN2PMFM71kRQyiEnrfpzjiNeoWjbiPuuEil1NnO/uUFOG80zKe4TLyarVa7omcBU11lNnprQ==
X-Received: by 2002:a5d:4f06:0:b0:2ce:a7b3:1c71 with SMTP id c6-20020a5d4f06000000b002cea7b31c71mr13270998wru.35.1681320692404;
        Wed, 12 Apr 2023 10:31:32 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id i3-20020adfdec3000000b002f24db41f50sm7591393wrn.69.2023.04.12.10.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 10:31:32 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Pierre Asselin <pa@panix.com>
Cc:     Jocelyn Falempe <jfalempe@redhat.com>,
        Pierre Asselin <pa@panix.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Hans de Goede <hdegoede@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH] firmware/sysfb: Fix wrong stride when bits-per-pixel is
 calculated
In-Reply-To: <2e07f818ccdff7023a060e732d7c4ef6.squirrel@mail.panix.com>
References: <20230412150225.3757223-1-javierm@redhat.com>
 <2e07f818ccdff7023a060e732d7c4ef6.squirrel@mail.panix.com>
Date:   Wed, 12 Apr 2023 19:31:31 +0200
Message-ID: <87jzyhror0.fsf@minerva.mail-host-address-is-not-set>
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

>> The commit f35cd3fa7729 ("firmware/sysfb: Fix EFI/VESA format selection")
>> fixed format selection, by calculating the bits-per-pixel instead of just
>> using the reported color depth.
>>
>> But unfortunately this broke some modes because the stride is always set
>> to the reported line length (in bytes), which could not match the actual
>> stride if the calculated bits-per-pixel doesn't match the reported depth.
>>
>> Fixes: f35cd3fa7729 ("firmware/sysfb: Fix EFI/VESA format selection")
>> Reported-by: Pierre Asselin <pa@panix.com>
>> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
>> ---
>>
>>  drivers/firmware/sysfb_simplefb.c | 9 +++++++--
>>  1 file changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/firmware/sysfb_simplefb.c
>> b/drivers/firmware/sysfb_simplefb.c
>> index 82c64cb9f531..5dc23e57089f 100644
>> --- a/drivers/firmware/sysfb_simplefb.c
>> +++ b/drivers/firmware/sysfb_simplefb.c
>>
>> [patch elided]
>
> NOOOOOO !  The 1024x768x32 screen is all garbled.
> (gfxpayload=keep, gfxpayload=1024x768x32 or vga=0x318).
>

That's suprising... I tested the patch with vga=ask and picked
1024x768x15, 1024x768x16, 1024x768x24 and 1024x768x32. For all
cases the bits-per-pixel and line length values were correct.

But I don't have a machine with legacy BIOS so I testee using QEMU and
SeaBIOS.

> The other modes work as before (but the dmesg has less information;
> I'll investigate.)
>

Interesting. So you don't have the simplefb output that you had before ?

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

