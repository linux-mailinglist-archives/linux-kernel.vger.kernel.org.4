Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F18C8678A79
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 23:12:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233112AbjAWWMM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 17:12:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232991AbjAWWL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 17:11:59 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BBE72D7A
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 14:10:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674511830;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Tn/O2nlZnV2isuFdcAfSve/LURJU3mBv/b7vcJ8ZS4M=;
        b=Y2rr6XzfYml06IcXbWPxl57pR2t2CQkq/N5/EI8mET8N58TkOOPUklW9qtQVpPodOpZQuy
        a6jGSlwQcO/XBgmhi9wKpZLFtL9OUk5d/V0oT0iaeTTbe6qC0U8gCICaCtqvETG+2VNgBj
        MJNo3DspGUF4/cX6MtM78pICFvCTZjo=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-654-3g-2RsZfOPumkpaxog_BdQ-1; Mon, 23 Jan 2023 17:10:29 -0500
X-MC-Unique: 3g-2RsZfOPumkpaxog_BdQ-1
Received: by mail-ed1-f69.google.com with SMTP id z20-20020a05640240d400b0049e1b5f6175so9277241edb.8
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 14:10:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tn/O2nlZnV2isuFdcAfSve/LURJU3mBv/b7vcJ8ZS4M=;
        b=G9vKHehZeFxWZLmzAsOHpU/T4GCVsy4qS3+nKj2JC45mSkFt6lM42QMLPHthIY11JK
         L2bXkHew8E51GOIY7eWIslFXCKKy68paOmR/jVs4GuMHmkD2vUfipPh5dCp7VaxDl2jq
         4e+ZhxA/yDRGa5IzkjZ+1RaAreXzRvYfrUy6OL0LMtNGLgrO31EGFXZgW/u6gyFWnrX0
         LdECRnTolNFPeyuJDnUeyRh+2/j328IFuMz0+thk6eN4HAVhfUTqxQHLfjZN0zsVHN1D
         vCBgipehArieKZvV9hYoYBfc8KzmdGtlGhEnydglNWC/VeBq9x/tYSntgVMK7DR0s3q9
         2yZw==
X-Gm-Message-State: AFqh2kopw9YM2pKGuEBYzpUiBsUcl2dm3BLePQYeD5RSxsEzc/Zno+pY
        Ipwr5JW1Uhr/9QogtRqMtRrRiYqzbWijZwufzo/Une9ObiznB9cnoQ8bvu/gPQhNZlGKog7BOr3
        bZVbzvyZ0ysPm9mDxbY/zenDI
X-Received: by 2002:a05:6402:1bc3:b0:479:8303:dc1c with SMTP id ch3-20020a0564021bc300b004798303dc1cmr26555237edb.7.1674511828031;
        Mon, 23 Jan 2023 14:10:28 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtGL1+Bx4VyltLVnMYNGDHIki9rQWRdDDuwasI7UL+pOQRRUm2pItzAzGlZPzNtzQzRVGZbSw==
X-Received: by 2002:a05:6402:1bc3:b0:479:8303:dc1c with SMTP id ch3-20020a0564021bc300b004798303dc1cmr26555223edb.7.1674511827839;
        Mon, 23 Jan 2023 14:10:27 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id k15-20020aa7c04f000000b00497d8613532sm272944edo.5.2023.01.23.14.10.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 14:10:27 -0800 (PST)
Message-ID: <ea836a1e-a4ab-1c72-dd1f-b1e61fa9595e@redhat.com>
Date:   Mon, 23 Jan 2023 23:10:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v1 1/3] ACPI: video: Fix refcounting in
 apple_gmux_backlight_present()
Content-Language: en-US, nl
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        acpica-devel@lists.linuxfoundation.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>
References: <20230123171006.58274-1-andriy.shevchenko@linux.intel.com>
 <9e24156c-65fc-d38b-317a-9cc8fb2201b9@redhat.com>
 <Y87PWaFFpHeW5YLv@smile.fi.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <Y87PWaFFpHeW5YLv@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 1/23/23 19:18, Andy Shevchenko wrote:
> On Mon, Jan 23, 2023 at 06:46:44PM +0100, Hans de Goede wrote:
>> On 1/23/23 18:10, Andy Shevchenko wrote:
>>> acpi_dev_get_first_match_dev() gets ACPI device with the bumped
>>> refcount. The caller must drop it when it's done.
>>>
>>> Fix ACPI device refcounting in apple_gmux_backlight_present().
> 
> ...
> 
>> Thank you for your work on this, much appreciated and I like
>> the new acpi_get_first_match_physical_node().
>>
>> But I don't think this patch is a good idea. There is a
>> regression related to apple_gmux_backlight_present()
>> with a patch-set fixing it pending.
>>
>> And that patch-set actually removes this function. Adding
>> a fix for this real, but not really important leak now,
>> will just make backporting the actual fix harder.
>>
>> So I would prefer for this patch to not go in and to
>> go for (a to be submitted v2) of the patch-set fixing
>> the regression right away instead.
> 
> Maybe I missed something, but I noticed that you actually moved (not killed)
> the code which is currently in this function. If it's the case, I prefer my
> fix to be imported first.

The code is not really moved, patch 2/3 of my patch-set factors out
the detection code from drivers/platform/x86/apple-gmux.c's probe
function. The new factored out code uses a similar construct as
the apple_gmux_backlight_present() code (including the same leak).

Then patch 3/3 drops apple_gmux_backlight_present() and calls
the new factored out probe code.

I'll fix the leak in v2 and then add the 3 patches to pdx86/fixes
for the next pull-req to Linus (thus also fixing the leak).

Regards,

Hans

