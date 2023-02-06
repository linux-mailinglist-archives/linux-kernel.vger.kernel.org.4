Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E717468C87E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 22:20:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbjBFVUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 16:20:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjBFVUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 16:20:12 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E76913D5B;
        Mon,  6 Feb 2023 13:20:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1675718388; bh=gBtjdvssNf9n9f0ivSMYdvAOv6l23bSSAPBydFZKfLg=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=kDOKWBRsyFqDzI1QMNzAfVxYHVRc/7HL1giDhA3KCr3IFPyN9B5YqI533KKULhHKd
         uQ1YVTzkGULHqXaorzvBDVnsvjdfAKY/G6BUdOfqtAd2Y5LUQFcoj2ibtjsasr9yhX
         rvj8pHJPbt5Edz0HiH/uOD3/sX5QdDAAjkCKBY8adwBAXxnGfrFpZg5d1ORsPKkBQp
         s876ebbnC4azkBCBxHrm7k7i3BVty0XAYa8HkHSHaVPRBXG8fKz+3NGcNMMkRBhvTs
         cEVy/btX5h24coZBI+IRHJ5wX6PUq7oh/92O4QQqG8hd1ZzSE+14IqjFhrHXZAlY5j
         t14pcKE2/iX7w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.14] ([141.30.226.119]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MKbgE-1pAlHU2GwG-00KvLR; Mon, 06
 Feb 2023 22:19:48 +0100
Subject: Re: [PATCH 1/2] platform/x86: dell-ddv: Add hwmon support
To:     Guenter Roeck <linux@roeck-us.net>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     markgross@kernel.org, jdelvare@suse.com,
        platform-driver-x86@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230205205456.2364-1-W_Armin@gmx.de>
 <20230205205456.2364-2-W_Armin@gmx.de>
 <a7d2e011-142d-88b9-2591-cf4508f1b8c5@redhat.com>
 <20230206162303.GA195090@roeck-us.net>
From:   Armin Wolf <W_Armin@gmx.de>
Message-ID: <08af724c-8c65-db41-ece8-f330f67a3dc2@gmx.de>
Date:   Mon, 6 Feb 2023 22:19:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20230206162303.GA195090@roeck-us.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Provags-ID: V03:K1:NydaLpAeKm/q247J+lHcy0UktCrV7N1pPR5QP4LrMfnndd93t/G
 L+LmJOBW1FOkRer1j+Vxc6xRHr20vxtNr9sK7riC9qIA56A6t6XInus0QOqVF/i1/oVN0AL
 cVU+TtXH041ZQrKCMQURUfNWu5+1S1ushMadQkJKuzHXYdP5tywCkkV7CdpaV3ANbwBrvd+
 r2VYW3EACKnL+UkYLTURw==
UI-OutboundReport: notjunk:1;M01:P0:rKKXN3+pvtM=;owy0w449dm+D2EMy/Rzxcf04ygy
 kz5sz8iPjgRTpenrSmA4CRxfgCHL5oEFAD86Pm3/WCwQ2/34ZGbUXe/sd6PhIGInG0nSw1ojc
 srO1dOFBRx5DfkRpprDantaaco6QL5QdktGLU6P0Qlesb2CbD5urmM/3SchaSVVf/x/5Yog30
 gEWF1td/ka3hMxwcTztj2Qsfo7oGdQwO/WkGEgt0AnQMHtrbG0w4Ky3mV6pfarm5FATbMaTNi
 n91sxGFkLs3+MqvqZ8uMqjW1az3KvFWQVAhOmP+NbdgZjxUjIGZ1uC/TXJV00yrseMq2yOpML
 P6Sx7qaJuDvfAgCcgz0kN7+xSgWTnbh6YrEGVNbDfn/HRU2Zw42FghNUHatL9LR2W810yhn2K
 CVZC3KwpeMa4C9Nx/XB+wyFg4vQI4FyK46rBWP2+Ulex7swc/pBzu3B7jmQgHpXNB1vnznCdq
 aznvMMhazOKjg5x6qj2MXDCPPpXsaCimFytLMCDnADPvzCFEc5oMx4bTgyj9YN/f9F176a7mD
 Y/IYKjjsFI4fhknfXBdLZ/kzzsR3x16S5+EAliYJWhomIZE7xoAzxQ9pgd0HdlKGH1GBWKtVf
 m7AkQXKIg/OxGGSz1IzOrw7w5KA/yYQNToTzoH8i0kEeRD4x27hjZlR40x0FF4QNcslsy8G69
 02yFaBPMoF+w7GIi+R0W7/XYebmSmvrZtwAPSm+nPKW1/acpM7LkcpxDntntLtlG8/Eq3n1H4
 aCv+W0qI9ATCuvbg+q66XDc9f+W9U22FdLJ9LYzHAI1eOHl/cFuCLv6Pa/VTsfMCXU5/DOsoE
 NUfn8TTgneCieLufgFW3LXKG/i0ZCIMyBUTUrRb5VYEID/XV7118UVU8EqH49IMG0Su/UXxr4
 zEK/9E0oWoPvfzRTwRyDkQZYFIx51UFCm+Gmd1OfvKPL6TbDfDCoR89mWm891ddiNZiRRPyUo
 3B2/hxxABwLzOsZpal7GwpxxZ3o=
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 06.02.23 um 17:23 schrieb Guenter Roeck:

> On Mon, Feb 06, 2023 at 03:13:25PM +0100, Hans de Goede wrote:
>> Hi Armin,
>>
>> On 2/5/23 21:54, Armin Wolf wrote:
>>> Thanks to bugreport 216655 on bugzilla triggered by the
>>> dell-smm-hwmon driver, the contents of the sensor buffers
>>> could be almost completely decoded.
>>> Add an hwmon interface for exposing the fan and thermal
>>> sensor values. Since the WMI interface can be quite slow
>>> on some machines, the sensor buffers are cached for 1 second
>>> to lessen the performance impact.
>>> The debugfs interface remains in place to aid in reverse-engineering
>>> of unknown sensor types and the thermal buffer.
>>>
>>> Tested-by: Anton=C3=ADn Skala <skala.antonin@gmail.com>
>>> Tested-by: Gustavo Walbon <gustavowalbon@gmail.com>
>>> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
>> This looks nice and clean to me, thank you:
>>
>> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
>>
>> I'm going to wait a bit with merging this to see if Guenter
>> has any remarks. If there are no remarks by next Monday then
>> I'll merge this for the 6.3 merge window.
>>
> I don't have any further remarks. I won't send an Ack, though.
> I noticed that the empty lines before return statements distract
> me sufficiently enough that I am not sure about the actual code.
>
> Guenter

I will send a 3rd revision of the patch series to remove those empty lines=
 then.
Speaking of a 3rd revision, i noticed that jiffies are not updated during =
suspend,
so the sensor values might be wrong for a short time when resuming after a=
 long time.

This can be solved by either usingktime_get_boottime_ns(), which does not =
stop during suspend, or by
invalidating the sensor cache upon resume. Which method should be used
in this case? Armin Wolf

