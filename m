Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47BA372DF6C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 12:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239004AbjFMK2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 06:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240535AbjFMK2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 06:28:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2270E55
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 03:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686652080;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VjOh3j42VnEHvBh9X73UN1iWeAfBCJGoPl2D5dCUXYo=;
        b=c4D9sYW72b1zLsbdmtcQiLkKfQbOfI4W5wf6lV+iveh0YuYP5IqQa+oxtmoIpJy6QB89Tn
        +VeK9hmKAPFK7V21/wKl3a27YCgYFXQwvnMiID4nHa65lCXsFz9ehXyoEyTTlN8eOqaIfV
        1VPAiboP8wgp8nTRQqk4b6pzReZQ++Q=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-28-CaHJsHt5OvGaym8vYi2-1w-1; Tue, 13 Jun 2023 06:27:58 -0400
X-MC-Unique: CaHJsHt5OvGaym8vYi2-1w-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-9715654ab36so476191166b.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 03:27:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686652077; x=1689244077;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VjOh3j42VnEHvBh9X73UN1iWeAfBCJGoPl2D5dCUXYo=;
        b=Yz7gk7VK2WA84SAFF/KS456wfgEiR6WKiF6wAXEIXU7DcxSLF4bT/UGhrvuGtsoC7S
         +NQldO1TZmbkxqMWdRJJcdhPnfNR5R7pnd7aTMlgialDIqsFfKHbHAfLvvaLQ/TmHNYa
         4lXuUKBHYCKfJI8vTJIg8IIjL1ONBGzivyBcLeNQSCVtlU9ocgDNXNiE3ZuP7co2rhvT
         LrR5g96Oj5BieIHlBj0osH+5R6kLRqVo62rNsbV6eo5gEfiBESwYZXl5vvmQGuDwzSXE
         UTM4WtGXK3eh+l4OyMgvvFQrN28XxK6wj8sLo48DLXRgw0iW+dgvBUMsF6kPq0eRmDaD
         seoQ==
X-Gm-Message-State: AC+VfDyiLMFItWP34KuOKXCtM2OLQ0Db8MHWy8ayWlreR3XbSSXKIG/u
        nVibijda2GKu8Zm4lcRge5gZB2RFm6jI72IHG7BGb9FVlguTzuW9MNt4maC8ad+mfOB00nRX5bw
        Wd/Qlw3WXbilJ553nv3kW2mRI
X-Received: by 2002:a17:907:a48:b0:96f:e2c4:a063 with SMTP id be8-20020a1709070a4800b0096fe2c4a063mr11910786ejc.33.1686652077666;
        Tue, 13 Jun 2023 03:27:57 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4mVxo/w4Lp23PWKiz0By6Qg6RhSIQ7iSW/2m5DAqiJ2IGHvP8ROkjIDiGfiT7GVH0bqID9Ow==
X-Received: by 2002:a17:907:a48:b0:96f:e2c4:a063 with SMTP id be8-20020a1709070a4800b0096fe2c4a063mr11910771ejc.33.1686652077342;
        Tue, 13 Jun 2023 03:27:57 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id kg6-20020a17090776e600b009661484e84esm6424110ejc.191.2023.06.13.03.27.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jun 2023 03:27:56 -0700 (PDT)
Message-ID: <5db606f4-c9ec-43a8-1c0d-16e1673668a7@redhat.com>
Date:   Tue, 13 Jun 2023 12:27:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 0/1] platform/x86: asus-wmi: add support for ASUS
 screenpad
Content-Language: en-US, nl
To:     Luke Jones <luke@ljones.dev>
Cc:     platform-driver-x86@vger.kernel.org,
        =?UTF-8?Q?Barnab=c3=a1s_P=c5=91cze?= <pobrn@protonmail.com>,
        =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-kernel@vger.kernel.org, acpi4asus-user@lists.sourceforge.net,
        corentin.chary@gmail.com, markgross@kernel.org, jdelvare@suse.com,
        linux@roeck-us.net
References: <20230505043013.2622603-1-luke@ljones.dev>
 <06314c8dc4adeb69cd7801f9621c831f75a37c89.camel@ljones.dev>
 <ffdd2d13-975e-1c74-0d2b-132ba461a3ee@redhat.com> <5946924.lOV4Wx5bFT@fedora>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <5946924.lOV4Wx5bFT@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 6/7/23 00:45, Luke Jones wrote:

<snip>

>> I must admit I've lost track a bit of the state of v2 during this
>> discussion.  Can I pick up v2 as is, or were there (other) remarks
>> which need addressing and should I expect a v3 ?
> 
> There will be a V3. I don't anticipate any issues at all with this, and some 
> folks have been using this patch with Gnome and KDE since V2 was submitted.

Ok.


>> ####### Switch to (off-topic) GPU mux discussion ########
> **snip**
>>>> I think the best thing to do here is to just use EFI on machines like
>>>> this. That or put grub in text mode so that it makes BIOS calls to
>>>> display text. Using GRUB_TERMINAL_OUTPUT=gfxterm combined with
>>>> classic BIOS booting will make grub try to directly drive the gfx
>>>> card itself and I'm not surprised that it gets that wrong in this
>>>> case.
>>>> Note I think that just using EFI is prefered over switching grub to
>>>> GRUB_TERMINAL_OUTPUT=console. I would expect
>>>> GRUB_TERMINAL_OUTPUT=console to also work but I'm not sure. I don't
>>>> think that the classic BIOS boot stuff is still tested by laptop
>>>> vendors and esp. not tested with non standard BIOS settings ...
>>>
>>> The grub gfx mode is GRUB_TERMINAL_OUTPUT="console", fedora default in
>>> all cases here. Grub itself shows fine when the MUX mode is in dgpu
>>> mode (aka, internal display connected to dgpu).
>>
>> Ah ok, so I misunderstood and the problem only happens *after* grub?
>>
>> Have I understood that correctly?
>>
>> And this is on Fedora with the nvidia binary driver ?
>>
>> The problem then likely is that the nvidia binary driver is not in
>> the initrd (which is by design since it may need to be rebuild on
>> a driver update while the kernel is kept at the same version,
>> so the initrd won't be rebuild).
> 
> That was indeed the issue. It also creates new problems for when a user wants 
> to use iGPU only via the plain (and frankly not adequate or good) method of 
> simply removing the dGPU from the device tree.
> 
> Currently I maintain the supergfxd tool which is a lot more advanced than the 
> other gpu switchers around, and I expose both the above method, and also PCI 
> hotplug, and the ASUS WMI method (which I now think is used by other vendors 
> also). Hotplug and Asus method can force the device off, and it can't be 
> brought back by a PCI rescan - but to do so safely the Nvidia drivers must be 
> unused and unloaded. I guess I'll need to tweak the boot process of supergfxd 
> and block things until this is done.
> 
> Maybe we can move this to a new topic, because there looks to be a few things 
> to discuss in relation to hybrid laptops, and specifically Nvidia with MUX, 
> and Advanced Optimus.

Yes if you want to discuss this further please start a new mailinglist
thread for this and also please put the dri-devel list on the Cc:

dri-devel@lists.freedesktop.org

Regards,

Hans


