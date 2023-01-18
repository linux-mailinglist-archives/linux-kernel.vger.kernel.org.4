Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E61C672C4B
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 00:09:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbjARXJy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 18:09:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbjARXJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 18:09:45 -0500
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3770859251
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 15:09:44 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id g10so261129qvo.6
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 15:09:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=in-reply-to:mime-version:user-agent:date:message-id:from:references
         :cc:to:subject:from:to:cc:subject:date:message-id:reply-to;
        bh=IW0EUvtT/eTM9SmHYjRtSH3zHytSpiwiMW5t3cRiuAs=;
        b=VVvluB8ybqWVdG8DneWpqFlJKu3ekgdrPKpAh+LYsXTF/FWsvMeX9MT6UfKFaG9ycC
         EVjmcu6c3llYI8UM+ruubyAbcw7J2SujwXetwgxLrqVbpeZB4rjC+FD8zBlhQ+AzYhb/
         +MnXYxuq8WS6WXwnLKH2kHDcOEpXdSuyVwBeQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:mime-version:user-agent:date:message-id:from:references
         :cc:to:subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IW0EUvtT/eTM9SmHYjRtSH3zHytSpiwiMW5t3cRiuAs=;
        b=U1LGwuhnNGatu46dGtVemGGAuqnc8bk0GYFwsC+N5tT2YXyaIItTtvrtBHbl3NtN7Z
         N7ZgNFeG7IcYGwrL1YKz7mjollEPzI8EBkrVsAyQTwaPIx6UO2fsxHjxXwzorYpxq+x5
         aEy4IQF8SOzErTWam5r8vyD/DNixu8ezRI6StrCZMVTMVu9vNFTzQJthsOSJ4ShxwF8Y
         FcObHQw6szPaPXAKbF2FVRbosGdNVXFxHTg5xfdr7Xqv9Pl/ED3vBtGKag5/MPzxjieZ
         9vjdnnWat16UQAHQrS49aiErIycRs5qQ5h1TyLZAAgEYmM5x97cfl4ckNHR0JopD2yDw
         SveQ==
X-Gm-Message-State: AFqh2kqskMtllWAdHdcUfV47GHaIJwIUjhS1iGCC+Oewa5PIrNA24fPH
        9zA6V5tlWFLW+HsVTBJBcmADgkYgYLmjAPyhJ31NaIknQ74XMDEGS8+NPdotCb1ZE1yIOCU3vbZ
        6GbbP3qgM6GC40P05UnLhjjbM1nUcso8LFF8R6osgKH1pALGfp/GGSSsJKkNUBOUviel4KCa7/r
        CWsQvnEdtpAt4=
X-Google-Smtp-Source: AMrXdXuUH363paSmTVFb7SeUGD1ZbUW6gIvxCELUWLysFPNYJS5yINTLkC5WaKXszfKReXZ3CKqrfw==
X-Received: by 2002:a05:6214:5494:b0:4c7:7237:770f with SMTP id lg20-20020a056214549400b004c77237770fmr13005475qvb.50.1674083382773;
        Wed, 18 Jan 2023 15:09:42 -0800 (PST)
Received: from bcacpedev-irv-3.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id s11-20020a05620a0bcb00b00704a9942708sm23171314qki.73.2023.01.18.15.09.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Jan 2023 15:09:41 -0800 (PST)
Subject: Re: [PATCH 10/16] spi: bcm63xx-hsspi: Make dummy cs workaround as an
 option
To:     Mark Brown <broonie@kernel.org>
Cc:     Linux SPI List <linux-spi@vger.kernel.org>,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>,
        anand.gore@broadcom.com, tomer.yacoby@broadcom.com,
        dan.beygelman@broadcom.com, joel.peshkin@broadcom.com,
        f.fainelli@gmail.com, jonas.gorski@gmail.com,
        kursad.oney@broadcom.com, dregan@mail.com,
        linux-kernel@vger.kernel.org
References: <20230106200809.330769-1-william.zhang@broadcom.com>
 <20230106200809.330769-11-william.zhang@broadcom.com>
 <Y8BMiOvbjncXK4RO@sirena.org.uk>
From:   William Zhang <william.zhang@broadcom.com>
Message-ID: <6a69a859-d942-3c86-24f1-c041190d20d3@broadcom.com>
Date:   Wed, 18 Jan 2023 15:09:39 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <Y8BMiOvbjncXK4RO@sirena.org.uk>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="00000000000062063405f291e957"
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--00000000000062063405f291e957
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit

Hi Mark,

Sorry for the late reply. Please see my comments below.

On 01/12/2023 10:08 AM, Mark Brown wrote:
> On Fri, Jan 06, 2023 at 12:08:02PM -0800, William Zhang wrote:
> 
>> Due to the controller limitation to keep the chip select low during the
>> bus idle time between the transfer, a dummy cs workaround was used when
>> this driver was first upstreamed to the kernel.
>>
>> The workaround picks dummy_cs as !actual_cs and usually cs is 0 and
>> dummy cs is 1. But this does not work out in all the situations as
>> customer reported issues for their board design. Due to SPI block design
>> constrain, the controller works in different mode internally depending
>> on the clock. When clock is 30MHz or above, controller works in faster
>> mode and cs 1 signal is used internally as feedback from the pad. So cs
>> 1 pin must be brought out and configured as chip select function in
>> pinmux. When clock is below 30MHz, only cs 0 pin is used. In summary
>> when clock is below 30MHz, the workaround always works as only cs 0 is
>> involved. For clock faster than 30MHz, it require cs1 pin used in the
>> board design and configured as chip selection function.
> 
>> In a typical usage of SPI flash on cs 0 that normally runs at 100MHz,
>> cs 1 pin must be used in the board design but this is not always the
>> case for many customer boards.
> 
>> For voice daughtercard usage,  the SoC alway uses internal cs 7 for
>> voice card SPI control. Then it requires cs 0 pin as the dummy cs but
>> board with voice design may not use cs 0 pin at all.
> 
> So I think what this is trying to say is that operation over 30MHz with
> the existing workaround requires that the board be designed to bring out
> the chip select used as the dummy as a physical chip select (or
> potentially it has to be the actual chip select for the device?) 
Yes as the physical chip select and its pinmux must set as spi slave 
chip select function.  If that pin is configured as GPIO function, this 
workaround won't work. For the old SoCs, this dummy cs 1 pin are default 
to cs pinmux function so the issue was not revealed. For all new SoC, 
the cs 1 pin is default to GPIO function so it stops working.

> but that likely won't have been done?
Correct. This was never a requirement from Broadcom for any board design 
because the Broadcom in-house SPI bus driver in its initial software 
release was essentially based on prepend mode so no such hardware design 
requirement and it does not make sense to reserve the dummy cs1 pin 
while customer only have one spi device at cs0. So no customer board 
would do that unless they have two devices. We decided to switch to the 
upstream  driver with prepend mode addition as default in our late 
software release couple years ago. It has been running pretty smooth in 
the field.

> And potentially this only works if CS
> 1 is the one brought out?  I'm unclear if CS 1 is just the most common
> dummy chip select or if there's something else going on here.
> 
Yes with pinmux set correctly. It can be other cs but the code set 
dummy_cs = !actual_cs. So it can be either 1 or 0. In most common case, 
board only have one spi device on cs 0. So dummy is mostly cs1.

>> The controller actually has a prepend feature that can combine multiple
>> SPI transfers in a SPI message into one single transfer when the
>> transfers meet certain requirements. So there is no need for keeping cs
>> low when the message only has one transfer. Most of the SPI devices
>> including SPI NOR, SPI NAND flash, Broadcom voice card and etc can use
>> this feature without the dummy cs workaround.
> 
>> This patch makes the dummy cs workaround as an option based on the
>> dts flag brcm,use-cs-workaround. By default dummy cs workaround is
>> hard coded to enable. We will use the prepend feature and disable this
>> workaround as default in the next patch of this series unless this flag
>> is set in dts.
> 
> ...and based on your other comments I gather it's difficult to disable
> the workaround per message?  I'm also guessing that the overhead from
> always doing full duplex transfers is noticable so it's better to try
> the workaround.
> 
The main issue the max_message/transfer_size setup during the driver 
probe function. prepend mode has a max size of 512 bytes while dummy cs 
does not. I don't think it is safe to update these function ptr at 
runtime and it will be too late for the driver to update.

But I think we can always set the max size as in prepend mode. It does 
looses some performance for dummy cs (about 15% slower on throughput 
when test on 100MHz SPI NAND) because the size limit. The prepend buffer 
copy and other handling is insignificant. But since dummy cs does not 
work on 100MHz in general, it is still much better throughput when doing 
prepend mode at 100Mhz with size limit comparing dummy cs at 30MHz.

> I wonder if we can't do this by selecting the workaround based on the
> configured device speed.  If the device is configured to use more than
> 30MHz then disable the workaround, if it's set to lower then use it.  In
> practice most devices don't change their speed after setup, and the
> driver could check for and handle that case I guess (eg, limit the speed
> configured if the workaround has been activated or rewrite the message
> to a single transfer if neded).  That would be less error prone for
> users, there wouldn't be any possibility of them setting this flag
> incorrectly.
> 
I agree.  We can get rid of the cs workaround dts flag and make run time 
decision based on the device speed. And for the cut off frequency,  we 
want to make it bit more conservative.  According to our VSLI designer, 
the cut off freq depends on the chip floor plan - the distance from the 
SPI peripheral block to the SPI pins. So for some chips, the freq is 
25Mhz, for some is 30Mhz.  So we think 25MHz is good number to use.

As our SDK release uses prepend mode as default and it has been field 
tested with different and multiple SPI devices simultaneously in our 
large customer bases, I don't feel like to change the default mode to 
dummy cs mode and I am more comfortable to stick with prepend mode.

So my preferred choice is to use prepend mode as default. In the 
unlikely event that SPI transfers can not be merged for prepend mode, 
we switch to dummy cs workaround mode and force the transfer to run at 
25MHz. This make sure everything works under the hood automatically and 
no dts setting is required. I can add sysfs knobs to override this 
behavior and force to use either mode just in case. Does this sounds 
good to you?



--00000000000062063405f291e957
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
YDZuuBJwnyCzevMoPtVYPharioL5H3BRnQi8YoTXH7/uRo33dewYFm474yFjwwnt82TFtveVZkVq
6h4WIQ4wTcwFfET8zMkELnGzS5SHCl8sPD+lNxxJ1JDZYwIDAQABo4IB2zCCAdcwDgYDVR0PAQH/
BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDovL3NlY3VyZS5nbG9i
YWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3J0MEEGCCsGAQUF
BzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAy
MDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xv
YmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBAMD6gPKA6hjhodHRw
Oi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNybDAlBgNV
HREEHjAcgRp3aWxsaWFtLnpoYW5nQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAf
BgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUq65GzwZxydFHjjYEU/9h
xHhPWlwwDQYJKoZIhvcNAQELBQADggEBAA2hGG3JPAdGPH0ZdohGUCIVjKz+U+EFuIDbS6A/5jqX
VhYAxZlzj7tSjUIM7G7IhyfqPC46GKJ/4x+Amz1Z6YxNGy71L68kYD6hIbBcA5AM42QBUufly6Oa
/ppSz3WoflVyFFQ5YXniZ+eU+2/cdnYZg4aVUnFjimOF5o3NfMLzOkhQNxbaDjFUfUYD8hKmU6v4
0vUBj8KZ9Gi1LIagLKUREn8jku0lcLsRbnJ5Ey5ScajC/FESPyYWasOW8j8/1EoJksmhbYGKNS6C
urb/KlmDGfVrIRYDbL0ckhGQIP5c6L+kSQZ2sHnQK0e0WgIaZYxaPYeY5u0GLCOze+3vyRMxggJt
MIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYD
VQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgwxuh2XG3FXRL1W
JOEwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIPYlUOUjcbiTZDltTF/3gcS/Yv6l
gdPBTMX9G+kXon+BMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIz
MDExODIzMDk0M1owaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsG
CWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFl
AwQCATANBgkqhkiG9w0BAQEFAASCAQAHnpTfDyQR5WIq+UPupDhYn9cwIXsKDX05jucmajXRK+Ck
juVhNb6A7cXN3ZZ6gXM2zIo+TgFi2Vkyb4A3eVZs4qSXOp+Bq2lRhELVdVy0bUbLOMkkDgvHiHRj
RYvFkzh1fIUPxr5AdIXgAbBJlFlaZfX8V8MOQt9SGz6/8BnFlGATd6wIHxe3jtBm338How0pRvZi
cApbOjp0oEa+jQSM2uCm+UzIYFrryWzHeJ81UbjFkpRnyOrowl+21E6ELv/VIZvficHgpqPVX4Yp
LC2kYQuZUXv5cOORIUiJgbc+EhSmsJ7piJJhd7GLLod9R5BdjU48Mz/ZqcHtJk5+iNJG
--00000000000062063405f291e957--
