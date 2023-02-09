Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12EDB690DA2
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 16:54:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbjBIPyX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 10:54:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbjBIPyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 10:54:20 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A95681C311
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 07:53:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675958012;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=duqR2qst+IvmIa7vfxKDeX9EYe2M/CdxGV7kSNVEtJE=;
        b=BQvxfxhXGF0gi3JxlAkrkK5UqeLT6ae7vAO9yBmyOv+ihhTH2weryL3eoPNWHhOmrOvIN/
        N2x5XL4Xhp3QcyWRSdvcMjKL6aJ44aBI+JNeehNYHHP4OZdhKn5Zp1AKEDttCjKvi0VaAd
        OpQO6s2UveTfe15pEJ21ZtsP8xs9wWs=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-99-aOe-8l5hPg6aIwRrBWVDKg-1; Thu, 09 Feb 2023 10:53:31 -0500
X-MC-Unique: aOe-8l5hPg6aIwRrBWVDKg-1
Received: by mail-ej1-f71.google.com with SMTP id xh12-20020a170906da8c00b007413144e87fso1764775ejb.14
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 07:53:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=duqR2qst+IvmIa7vfxKDeX9EYe2M/CdxGV7kSNVEtJE=;
        b=yCMyqU9qp5wE0ErbyW+kicvaUVJjyeFYSNxJZGrNH4jxfLo8qSjgCEioRcAHuKKOMs
         MNF+V5pp/S4N+jEY88TswQcHSrPR6mundOnD9Jen6847dt3Avk8JWMmslYcFIeZ74D5B
         G5H9PlD6NhWsffD32VGskBrYbPJfOvz6FGhSaUoOyu9z3t8jFsUsrcmDUkcwJcLjnWIj
         6w/MouICeyreNPjdSI8m7h2F5J4LccNTUwd3IVdx14Mh1fbsk+eURMtXQWJwOCn8y/n1
         J28soabiw2CKbvwiwY/+es8ZvryLC1hMw/ABuJw2t1sydrH60mdRLDlD21vykIlFa/1S
         UZpg==
X-Gm-Message-State: AO0yUKXjVjXIvzSnUI6UI6Zy9VVSekDxE/24/D7R/OnyGn//Q/vY9HvF
        W2Srh+i4SrK7KXwiejOzEaXRahkJ0TsYVVI/bw/Thoh4skwN7LjScwcmiu3ZFMKUJnBDHVgeWO0
        nOEgW3krs+HOoyg9au0ZVu9aR
X-Received: by 2002:a50:d49e:0:b0:46d:35f6:5a9b with SMTP id s30-20020a50d49e000000b0046d35f65a9bmr12745006edi.24.1675958010386;
        Thu, 09 Feb 2023 07:53:30 -0800 (PST)
X-Google-Smtp-Source: AK7set9oGPruByEcU7O1yRet1x2a4MRvbxei/DghFCpGL/0sEQv3gJp2cbeh1tYhJmXvSH0ZwhUTkA==
X-Received: by 2002:a50:d49e:0:b0:46d:35f6:5a9b with SMTP id s30-20020a50d49e000000b0046d35f65a9bmr12744991edi.24.1675958010245;
        Thu, 09 Feb 2023 07:53:30 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id p14-20020a50cd8e000000b004a26665b962sm923715edi.89.2023.02.09.07.53.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Feb 2023 07:53:29 -0800 (PST)
Message-ID: <cefe5482-f30f-e5cc-8722-1f60d610f059@redhat.com>
Date:   Thu, 9 Feb 2023 16:53:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: drm: panel-orientation-quirks: Add quirk for Lenovo IdeaPad Duet
 3 10IGL5
Content-Language: en-US, nl
To:     Maxime Ripard <maxime@cerno.tech>,
        Darrell Kavanagh <darrell.kavanagh@gmail.com>
Cc:     maarten.lankhorst@linux.intel.com, tzimmermann@suse.de,
        airlied@gmail.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <CAMxBKG1RwbRJMG0cKcnbyKgznXeZLL+Zp1zXeOnxpYU0NkOO8A@mail.gmail.com>
 <CAMxBKG3o_6R7M0gaUHXA5yGgSe6HBWYK25fwF=8mN+JTno9t7Q@mail.gmail.com>
 <CAMxBKG0wDi-XwMZwMHq_DbFXt3pgK-CV-G7iT9BNftiXBoUHzQ@mail.gmail.com>
 <20230209153600.jtj6deqhgfocvwgc@houat>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230209153600.jtj6deqhgfocvwgc@houat>
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

On 2/9/23 16:36, Maxime Ripard wrote:
> Hi,
> 
> On Wed, Feb 08, 2023 at 07:04:58PM +0000, Darrell Kavanagh wrote:
>> I've resolved this by adding a matching quirk in
>> drivers/firmware/efi/sysfb_efi.c - see below.

Right, this is a known issue on Lenovo 2-in-1s with
the panel mounted 90 degree rotated issue. For some reason
the efifb info still gives a landscape resolution even though
the actual resolution really is portrait. This also messes
up the pitch of the framebuffer leading to the weird corrupted
looking output you saw.

>> I've resolved this by adding a matching quirk in
>> drivers/firmware/efi/sysfb_efi.c - see below.
>>
>> Are you the right people to be notifying about this?
> 
> Yes, we are.
> 
> Howewer, please follow
> https://www.kernel.org/doc/html/latest/process/submitting-patches.html
> 
> In particular, a proper commit log and your Signed-off-By tag is missing.

Are we, do patches to that file go through drm-misc ?  :

[hans@shalem linux]$ scripts/get_maintainer.pl -f drivers/firmware/efi/sysfb_efi.c
Ard Biesheuvel <ardb@kernel.org> (maintainer:EXTENSIBLE FIRMWARE INTERFACE (EFI))
linux-efi@vger.kernel.org (open list:EXTENSIBLE FIRMWARE INTERFACE (EFI))
linux-kernel@vger.kernel.org (open list)

Either way this should be turned into a proper patch with a proper
Signed-off-By message as Maxime mentioned.

My offer for the drm_panel_orientation_quirks.c patch to turn it into
a proper patch for you also extends to this one. If you want that,
please let me know and again add your Signed-off-by as a standalone
separate line in your reply so that I can use it for the commit message.

Regards,

Hans


