Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C9655F8743
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 21:59:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbiJHT7Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Oct 2022 15:59:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbiJHT7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 15:59:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F17AC38A0C
        for <linux-kernel@vger.kernel.org>; Sat,  8 Oct 2022 12:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665259159;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Hc9W7HgSLjSy07M4A9xL/NkhzDYCiBve9SmVv914q4w=;
        b=EZ1f+GBTWj4tI6m8tWU4Q2Vl1KWaLOyzbFswRvQc5TudZGQ8pZWXeUVaUPHxpNIMnIU5FJ
        hrXwL24ACGIYIcpSv9QjV7HIvt+vlbC05jNO/CnRzOf+SiUVEbER/rViYPQmnFzspA4WA1
        tK1eyVek1Mx8Ss9KFvexU3mCkrkWbQQ=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-458-caad5Q4yPYGlnLydzw9g4g-1; Sat, 08 Oct 2022 15:59:18 -0400
X-MC-Unique: caad5Q4yPYGlnLydzw9g4g-1
Received: by mail-ej1-f70.google.com with SMTP id jg33-20020a170907972100b0078d174b3bb7so3697689ejc.22
        for <linux-kernel@vger.kernel.org>; Sat, 08 Oct 2022 12:59:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hc9W7HgSLjSy07M4A9xL/NkhzDYCiBve9SmVv914q4w=;
        b=4l+DHFjBrP4I7E68hM5DOegyl3f1Og5Dtt90D4hxRUq/J4izbUxtwJkXa0rBlTiO6H
         qP6aEu5igIe4dhQ9zcmQ/7LjiP4vGMgdezc055h5EpYzqEi2+P2tCK/S2P6wcZl7TjJT
         REj/NkCeG3ox1fKfqQi3iEdgWrDgKyeYEmmoE6YBN5dTvpLbRujEvzg4Ti32S5x33WtM
         qe9gUFmwBYapmC7bHtrGKQWNYK4HaYK4EpHVKVUvvHVvuHV6g5keW9IyzRe3QJGN6gEX
         R2lMnbOiNTq6Qo9LEr7K2t54DRKj4LkTnTKGgYNRuNKI16NPS2vltRWnFh7HIA2Uhmlp
         Xo0g==
X-Gm-Message-State: ACrzQf39cBxPBPcijb9pqTqbbQxmiy33Ta35prc+uzp6DbS4e6nqfzc9
        Q8cL3QFBh2UZTfBnhK6+hwwFqr0GSiLxNI4WQFzr2bcsNQrDRstxMAXOUoPx9IL+ML+MGUOAvz9
        NIKNu/WPBTTKMyJ62QaMGUUhg
X-Received: by 2002:aa7:c78d:0:b0:454:fe1d:8eb1 with SMTP id n13-20020aa7c78d000000b00454fe1d8eb1mr10359396eds.59.1665259156552;
        Sat, 08 Oct 2022 12:59:16 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4mhOBVIk/Ikvn8/UWZE4+y7LNhChHrhkIxe8Y6Xzo2vAqAtsIt2G8/x9DCgwLnG2qQCiZMaw==
X-Received: by 2002:aa7:c78d:0:b0:454:fe1d:8eb1 with SMTP id n13-20020aa7c78d000000b00454fe1d8eb1mr10359389eds.59.1665259156391;
        Sat, 08 Oct 2022 12:59:16 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id d23-20020a170906305700b0078d3e54aca1sm815833ejd.75.2022.10.08.12.59.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Oct 2022 12:59:15 -0700 (PDT)
Message-ID: <d66fa3ea-1efe-e7da-be80-89507067e2a9@redhat.com>
Date:   Sat, 8 Oct 2022 21:59:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [GIT PULL] Backlight for v6.1
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Lee Jones <lee@kernel.org>, Mark Brown <broonie@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Yz18QA27+gN0oaM3@google.com>
 <CAHk-=whK-q1W-X0q0f_nBJ9sKyta-DVJhEAS4BF_oKAVAUQ4Jw@mail.gmail.com>
 <Y0AmmR2NfKc/Y7Mb@google.com>
 <CAHk-=wg=hh8xkPjiySnjAyR66AG64eyZ1Y9gHw+MCs8uuSZReA@mail.gmail.com>
 <Y0HB3K8IRVhX5IvT@smile.fi.intel.com>
 <CAHk-=wixtjmiENLbc1=Hds3mMSjVRA3ZiwXN7yg8mw_1MCg_QQ@mail.gmail.com>
Content-Language: en-US, nl
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAHk-=wixtjmiENLbc1=Hds3mMSjVRA3ZiwXN7yg8mw_1MCg_QQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On 10/8/22 21:02, Linus Torvalds wrote:
> On Sat, Oct 8, 2022 at 11:31 AM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
>>
>> The Intel PMICs are the beasts when we want to run the code on the real
>> hardware.
> 
> Yeah, I don't expect he driver to work on real hardware,

I'm not sure what you mean here. I guess you mean that you
do not expect to be able to test the driver on real hw
yourself?

I have several x86 tablets with this PMIC and the driver
does actually work on real hw, I test it regularly.

As for the admittedly weird:

	depends on I2C_DESIGNWARE_PLATFORM=y

dependency, as Andy mentioned on most of these devices
the ACPI tables (often the _PS0 / _PS3 power on/off methods)
poke at the PMIC through ACPI Opregions which are registered
through the MFD driver. This all needs to be available early
on which is why I2C_DESIGNWARE_PLATFORM needs to be builtin
(the PMIC is connected to the system through a designware
I2C controller).

When built as a module we get a whole bunch of ACPI subsys
errors about OpRegion calls to a non registered OpRegion in
dmesg and this can also results in real bugs like e.g.
a touchscreen not working because it was not powered on.

After several bug reports about this I decided to add this
dependency to force distros to built I2C_DESIGNWARE_PLATFORM
into the main vmlinuz image if they want to enable these
drivers.

<snip>

>     depends on I2C_DESIGNWARE_PLATFORM=y
> 
> might be better with a "|| COMPILE_TEST" to at least find the build
> issues, even if actual runtime testing is a different anumal entirely.

Adding "|| COMPILE_TEST" sounds like a good idea to me. Note that as
I tried to explain the:
	
	depends on I2C_DESIGNWARE_PLATFORM=y

is actually there to avoid known runtime issues with having that
built as a module in combination with this (and a few other similar)
PMIC drivers.

Regards,

Hans

