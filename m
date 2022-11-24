Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F678637293
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 07:53:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbiKXGx4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 01:53:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbiKXGxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 01:53:55 -0500
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37202C4B48;
        Wed, 23 Nov 2022 22:53:54 -0800 (PST)
Received: by mail-ed1-f54.google.com with SMTP id s12so1288882edd.5;
        Wed, 23 Nov 2022 22:53:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iY6ZcqTTzxn4fRkMMwseAbYXc9/C12zRHdPoC7nG4+o=;
        b=bEqqMoDVcv5J/XOkGre/RGj0X7KQTLtpnBpy+lt+873JXMTZeXO7qTux8rU2STn2Cj
         5ebttfOD6b2zwp7jzOGRnvwKbgbchUJGEb9+lyHMCNDm1JakHEhvH6VT2E/AK+xiuE5B
         UzRfPJbE2jMYix9D6aIheV+dvzKukaH8i9wK1yV49TP05mc22Nru/eiE+UoV0aIxWs/D
         kmDdklqo6xLquPAjpeukk1fv1KKvHnuKbJ+J/YfiEnyrzwfwDdU5pLz17SRty/kO3Kr/
         Ry0Ljhj53jfMrTE0fDVZQ8w6LSLy9D2m2DOz2gS+nC1/4rEayqTH6Ywtkz7Ijbfhy0rr
         Ubwg==
X-Gm-Message-State: ANoB5pkkFWVDk3C53WanvDJuyM/RNgMhg+AawSRgnsqWj2hlY/x2lImf
        V6C+VbbXDHFeW20mlYO8XvhshDnhhBI=
X-Google-Smtp-Source: AA0mqf4K7o5VSk7GHDPYog09RKIoAm6TRMYBZNhaDqjolSQDmdfEO0Q0jeZA+d8g42ipSTA45J8tPQ==
X-Received: by 2002:a05:6402:1655:b0:46a:80cc:d5bd with SMTP id s21-20020a056402165500b0046a80ccd5bdmr1546199edx.210.1669272832529;
        Wed, 23 Nov 2022 22:53:52 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:49? ([2a0b:e7c0:0:107::aaaa:49])
        by smtp.gmail.com with ESMTPSA id t18-20020a056402021200b00463a83ce063sm150395edv.96.2022.11.23.22.53.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Nov 2022 22:53:51 -0800 (PST)
Message-ID: <562c1505-d3bc-6422-9598-15c399e6fbba@kernel.org>
Date:   Thu, 24 Nov 2022 07:53:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Content-Language: en-US
To:     Tony Lindgren <tony@atomide.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@intel.com>,
        =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-serial@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220615062455.15490-1-tony@atomide.com>
 <Yrmfr3GfXYhclKXA@kroah.com> <Yrm1HaUtjTMcSIE+@atomide.com>
From:   Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v2 1/1] serial: core: Start managing serial controllers to
 enable runtime PM
In-Reply-To: <Yrm1HaUtjTMcSIE+@atomide.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am returning to v2, as I managed to read only v3 and only now. But 
here was already the point below.

On 27. 06. 22, 15:48, Tony Lindgren wrote:
>>> Considering the above, let's improve the serial core layer so we can
>>> manage the serial port controllers better. Let's register the controllers
>>> with the serial core layer in addition to the serial ports.
>>
>> Why can't controllers be a device as well?
> 
> The controllers are devices already probed by the serial port drivers.
> What's missing is mapping the ports (as devices based on the comments
> above) to the controller devices. I don't think we need another struct
> device for the serial controller in addition to the serial port driver
> device and it's child port devices.

To be honest, I don't like the patch (even v3). We have uart_state which 
I already hate and now we have another structure holding *some* other 
info about a serial device (apart from uart_port). It's mess already and 
hard to follow, esp. to newcomers.

AFAIU, what Greg suggests would be:

PCI/platform/acpi/whatever struct dev
   -> serial controller 1 struct dev
      -> serial port 1 struct dev (tty_port instance exists for this)
      -> serial port 2 struct dev (tty_port instance exists for this)
      -> ...
   -> serial controller 2 struct dev
      -> serial port 1 struct dev (tty_port instance exists for this)
      -> serial port 2 struct dev (tty_port instance exists for this)
      -> ...

And you are objecting that mostly (or in all cases?), there will never 
be "serial controller 2"?

But given your description, I believe you need it anyway -- side note: 
does really the PM layer/or you need it or would you be fine with 
"serial port N" dev children? But provided you don't have the 
controller, you work around it by struct serial_controller. So what's 
actually the point of the workaround instead of sticking to proper 
driver model? With the workaround you seem you have to implement all the 
binding, lookup and such yourself anyway. And that renders the serial 
even worse :P. Let's do the reverse instead.

The only thing I am not sure about, whether tty_port should be struct 
dev too -- and if it should have serial port 1 as a parent. But likely 
so. And then with pure tty (i.e. tty_driver's, not uart_driver's), it 
would have PCI/platform/acpi/whatever as a parent directly.

In sum, the above structure makes perfect sense to me. There has only 
been noone to do the real work yet. And having tty_port was a hard 
prerequisite for this to happen. And that happened long time ago. All 
this would need a lot of work initially¹⁾, but it paid off a lot in long 
term.

¹⁾I know what I am writing about -- I converted HID. After all, the core 
was only 1000 lines patch (cf 85cdaf524b7d) + patches to convert all the 
drivers incrementally (like 8c19a51591).

thanks,
-- 
js
suse labs

