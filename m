Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C8336336EC
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 09:23:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232685AbiKVIXS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 03:23:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232132AbiKVIXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 03:23:16 -0500
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5610B286CA;
        Tue, 22 Nov 2022 00:23:15 -0800 (PST)
Received: by mail-ed1-f52.google.com with SMTP id y24so14531612edi.10;
        Tue, 22 Nov 2022 00:23:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:from:references:cc:to:content-language:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aPNWYUM3HaHsFf5FSq0uDHZ3ek2lUf+E4gpGnO6Pb/c=;
        b=VqlFpgD0X5PINhinBkdXwo+Zr3ejzmdQ7XCqEEJ8MfY6TH++7gAgGFQkIgKW5TWy11
         WCX+mZYjBmcum17YrxYqbuHbX4HvIjkTJ70TBnmBwYRs6Nj2V14pv8R1rLca4bkJGuol
         MWt56pTjA9xhvYz3SBhTwbhFNc+MjXKbBvVbF5ZYcFrnyffuWqeLS7XUTEQrkT/E1Kmb
         sXQdFFRe/su/Ka7J+MK4+xKz92/RuB1RphE4yCnuJHYYgcfiIs3ZBi0pVLD5ZP5ILqNU
         fHiqz8mVI6X9fAl9H3FKFv7zPCihXbUAIhQN7/e+IsJ8fBoiBKfLlzUKT0NLkQAiZB29
         fePQ==
X-Gm-Message-State: ANoB5pmdlXS+Ss0ozXshAlfq09rnWbOJ6YtKc7JrD48wUM/g7Lc1wzBD
        ACZF8nsJspsdbpAwAOnIr3w=
X-Google-Smtp-Source: AA0mqf7/czcXV9soIbr3fM/6j/05ue+Pwy5Hxv4EzKFr4Dmb171sZSnlraKzztUq3gQv+PqjMcr+mg==
X-Received: by 2002:aa7:d358:0:b0:467:6847:1ea7 with SMTP id m24-20020aa7d358000000b0046768471ea7mr5361969edr.237.1669105393728;
        Tue, 22 Nov 2022 00:23:13 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:49? ([2a0b:e7c0:0:107::aaaa:49])
        by smtp.gmail.com with ESMTPSA id a1-20020a170906368100b0073cd7cc2c81sm5725855ejc.181.2022.11.22.00.23.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Nov 2022 00:23:13 -0800 (PST)
Content-Type: multipart/mixed; boundary="------------NM5TqSYlG0bVcwk6F3CBW0pS"
Message-ID: <0faeb934-a2c9-fcc2-6961-d3f1bbf37fa2@kernel.org>
Date:   Tue, 22 Nov 2022 09:23:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v5 2/3] tty: serial: use uart_port_tx() helper
Content-Language: en-US
To:     Michael Walle <michael@walle.cc>
Cc:     afaerber@suse.de, alexandre.belloni@bootlin.com,
        claudiu.beznea@microchip.com, festevam@gmail.com,
        gregkh@linuxfoundation.org, ilpo.jarvinen@linux.intel.com,
        kernel@pengutronix.de, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        liviu.dudau@arm.com, lorenzo.pieralisi@arm.com, mani@kernel.org,
        nicolas.ferre@microchip.com, richard.genoud@gmail.com,
        s.hauer@pengutronix.de, shawnguo@kernel.org, sudeep.holla@arm.com,
        tklauser@distanz.ch, vz@mleia.com
References: <20221004104927.14361-3-jirislaby@kernel.org>
 <20221121202724.1708460-1-michael@walle.cc>
 <f95ef7b7-cc23-9fed-5d05-1aa66aaeb86a@kernel.org>
 <0ef4f1e6d92601a39fe0d1c316506c12@walle.cc>
 <325fdfbf37b155c41e2b45bcddd96e9b@walle.cc>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <325fdfbf37b155c41e2b45bcddd96e9b@walle.cc>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------NM5TqSYlG0bVcwk6F3CBW0pS
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 22. 11. 22, 9:18, Michael Walle wrote:
> Am 2022-11-22 09:09, schrieb Michael Walle:
>> Hi,
>>
>> Am 2022-11-22 08:02, schrieb Jiri Slaby:
>>> On 21. 11. 22, 21:27, Michael Walle wrote:
>>>> This will break serial output for the userspace on my board
>>>> (arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt*dts). The 
>>>> uart_port_tx()
>>>> helper will call __port->ops->stop_tx(__port) if 
>>>> uart_circ_chars_pending()
>>>> returns 0. But the code above, doesn't do that. In fact, removing the
>>>> stop_tx() call in the helper macro, will fix the console output.
>>>>
>>>> Any ideas how to fix that?
>>>
>>> Hm, so ATMEL_US_TXRDY is removed from tx_done_mask in stop_tx, but not
>>> added back in start_tx. So the tx interrupt is never handled (the tx
>>> tasklet is not scheduled to send the queue chars) in
>>> atmel_handle_transmit().
>>>
>>> Any chance, the below fixes it?
>>>
>>> diff --git a/drivers/tty/serial/atmel_serial.c
>>> b/drivers/tty/serial/atmel_serial.c
>>> index 11bf2466390e..395370e0c77b 100644
>>> --- a/drivers/tty/serial/atmel_serial.c
>>> +++ b/drivers/tty/serial/atmel_serial.c
>>> @@ -596,6 +596,8 @@ static void atmel_start_tx(struct uart_port *port)
>>>                 /* re-enable PDC transmit */
>>>                 atmel_uart_writel(port, ATMEL_PDC_PTCR, 
>>> ATMEL_PDC_TXTEN);
>>>
>>> +       atmel_port->tx_done_mask |= ATMEL_US_TXRDY;
>>> +
>>>         /* Enable interrupts */
>>>         atmel_uart_writel(port, ATMEL_US_IER, atmel_port->tx_done_mask);
>>>
>>>
>>> thanks,
>>
>> Unfortunately, that doesn't help. Btw, some characters are transmitted:
>>
>>
>> [    6.219356] Key type dns_resolver registered
>> [    6.223679] Registering SWP/SWPB emulation handler
>> [    6.247530] Loading compiled-in X.509 certificates
>> [    6.288467] Freeing unused kernel image (initmem) memory: 1024K
>> [    6.297789] Run /init as init process
>> WbSOROSOSOSOSOStarting linuxptp system clock synchronization: O
>>
>> -michael
> 
> But you made me look at atmel_stop_tx() and there is this:
> 
>         /*
>      * Disable the transmitter.
>      * This is mandatory when DMA is used, otherwise the DMA buffer
>      * is fully transmitted.
>      */
>      atmel_uart_writel(port, ATMEL_US_CR, ATMEL_US_TXDIS);
> 
> Removing that write, will also fix the problem. Could it be, that
> the transmit is still active (via DMA) but the driver will call
> tx_stop() and then stop the transmission in the background?

Yes, that was exactly the next step to try. The datasheet doesn't tell 
much what happens when TXDIS is written while the characters are 
transmitted. So can you give the attached patch a try?

thanks,
-- 
js

--------------NM5TqSYlG0bVcwk6F3CBW0pS
Content-Type: text/x-patch; charset=UTF-8; name="0001-atmel-fix.patch"
Content-Disposition: attachment; filename="0001-atmel-fix.patch"
Content-Transfer-Encoding: base64

RnJvbSAyZGNjNzkzODRiOTdhMjE3NmJiZjg0ZWE2MzRhYWU0YTI2ZWZkMGI0IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiAiSmlyaSBTbGFieSAoU1VTRSkiIDxqaXJpc2xhYnlA
a2VybmVsLm9yZz4KRGF0ZTogVHVlLCAyMiBOb3YgMjAyMiAwOTowNTo1MSArMDEwMApTdWJq
ZWN0OiBbUEFUQ0hdIGF0bWVsOiBmaXgKCi0tLQogZHJpdmVycy90dHkvc2VyaWFsL2F0bWVs
X3NlcmlhbC5jIHwgNDAgKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLQogMSBmaWxl
IGNoYW5nZWQsIDI0IGluc2VydGlvbnMoKyksIDE2IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdp
dCBhL2RyaXZlcnMvdHR5L3NlcmlhbC9hdG1lbF9zZXJpYWwuYyBiL2RyaXZlcnMvdHR5L3Nl
cmlhbC9hdG1lbF9zZXJpYWwuYwppbmRleCAxMWJmMjQ2NjM5MGUuLmJiNDRmMjk3YTRmYyAx
MDA2NDQKLS0tIGEvZHJpdmVycy90dHkvc2VyaWFsL2F0bWVsX3NlcmlhbC5jCisrKyBiL2Ry
aXZlcnMvdHR5L3NlcmlhbC9hdG1lbF9zZXJpYWwuYwpAQCAtNTUyLDE5ICs1NTIsMjMgQEAg
c3RhdGljIHVfaW50IGF0bWVsX2dldF9tY3RybChzdHJ1Y3QgdWFydF9wb3J0ICpwb3J0KQog
c3RhdGljIHZvaWQgYXRtZWxfc3RvcF90eChzdHJ1Y3QgdWFydF9wb3J0ICpwb3J0KQogewog
CXN0cnVjdCBhdG1lbF91YXJ0X3BvcnQgKmF0bWVsX3BvcnQgPSB0b19hdG1lbF91YXJ0X3Bv
cnQocG9ydCk7CisJYm9vbCBpc19wZGMgPSBhdG1lbF91c2VfcGRjX3R4KHBvcnQpOworCWJv
b2wgaXNfZG1hID0gaXNfcGRjIHx8IGF0bWVsX3VzZV9kbWFfdHgocG9ydCk7CiAKLQlpZiAo
YXRtZWxfdXNlX3BkY190eChwb3J0KSkgeworCWlmIChpc19wZGMpIHsKIAkJLyogZGlzYWJs
ZSBQREMgdHJhbnNtaXQgKi8KIAkJYXRtZWxfdWFydF93cml0ZWwocG9ydCwgQVRNRUxfUERD
X1BUQ1IsIEFUTUVMX1BEQ19UWFRESVMpOwogCX0KIAotCS8qCi0JICogRGlzYWJsZSB0aGUg
dHJhbnNtaXR0ZXIuCi0JICogVGhpcyBpcyBtYW5kYXRvcnkgd2hlbiBETUEgaXMgdXNlZCwg
b3RoZXJ3aXNlIHRoZSBETUEgYnVmZmVyCi0JICogaXMgZnVsbHkgdHJhbnNtaXR0ZWQuCi0J
ICovCi0JYXRtZWxfdWFydF93cml0ZWwocG9ydCwgQVRNRUxfVVNfQ1IsIEFUTUVMX1VTX1RY
RElTKTsKLQlhdG1lbF9wb3J0LT50eF9zdG9wcGVkID0gdHJ1ZTsKKwlpZiAoaXNfZG1hKSB7
CisJCS8qCisJCSAqIERpc2FibGUgdGhlIHRyYW5zbWl0dGVyLgorCQkgKiBUaGlzIGlzIG1h
bmRhdG9yeSB3aGVuIERNQSBpcyB1c2VkLCBvdGhlcndpc2UgdGhlIERNQSBidWZmZXIKKwkJ
ICogaXMgZnVsbHkgdHJhbnNtaXR0ZWQuCisJCSAqLworCQlhdG1lbF91YXJ0X3dyaXRlbChw
b3J0LCBBVE1FTF9VU19DUiwgQVRNRUxfVVNfVFhESVMpOworCQlhdG1lbF9wb3J0LT50eF9z
dG9wcGVkID0gdHJ1ZTsKKwl9CiAKIAkvKiBEaXNhYmxlIGludGVycnVwdHMgKi8KIAlhdG1l
bF91YXJ0X3dyaXRlbChwb3J0LCBBVE1FTF9VU19JRFIsIGF0bWVsX3BvcnQtPnR4X2RvbmVf
bWFzayk7CkBAIC01ODEsMjcgKzU4NSwzMSBAQCBzdGF0aWMgdm9pZCBhdG1lbF9zdG9wX3R4
KHN0cnVjdCB1YXJ0X3BvcnQgKnBvcnQpCiBzdGF0aWMgdm9pZCBhdG1lbF9zdGFydF90eChz
dHJ1Y3QgdWFydF9wb3J0ICpwb3J0KQogewogCXN0cnVjdCBhdG1lbF91YXJ0X3BvcnQgKmF0
bWVsX3BvcnQgPSB0b19hdG1lbF91YXJ0X3BvcnQocG9ydCk7CisJYm9vbCBpc19wZGMgPSBh
dG1lbF91c2VfcGRjX3R4KHBvcnQpOworCWJvb2wgaXNfZG1hID0gaXNfcGRjIHx8IGF0bWVs
X3VzZV9kbWFfdHgocG9ydCk7CiAKLQlpZiAoYXRtZWxfdXNlX3BkY190eChwb3J0KSAmJiAo
YXRtZWxfdWFydF9yZWFkbChwb3J0LCBBVE1FTF9QRENfUFRTUikKKwlpZiAoaXNfcGRjICYm
IChhdG1lbF91YXJ0X3JlYWRsKHBvcnQsIEFUTUVMX1BEQ19QVFNSKQogCQkJCSAgICAgICAm
IEFUTUVMX1BEQ19UWFRFTikpCiAJCS8qIFRoZSB0cmFuc21pdHRlciBpcyBhbHJlYWR5IHJ1
bm5pbmcuICBZZXMsIHdlCiAJCSAgIHJlYWxseSBuZWVkIHRoaXMuKi8KIAkJcmV0dXJuOwog
Ci0JaWYgKGF0bWVsX3VzZV9wZGNfdHgocG9ydCkgfHwgYXRtZWxfdXNlX2RtYV90eChwb3J0
KSkKLQkJaWYgKGF0bWVsX3VhcnRfaXNfaGFsZl9kdXBsZXgocG9ydCkpCi0JCQlhdG1lbF9z
dG9wX3J4KHBvcnQpOworCWlmIChpZF9kbWEgJiYgYXRtZWxfdWFydF9pc19oYWxmX2R1cGxl
eChwb3J0KSkKKwkJYXRtZWxfc3RvcF9yeChwb3J0KTsKIAotCWlmIChhdG1lbF91c2VfcGRj
X3R4KHBvcnQpKQorCWlmIChpc19wZGMpIHsKIAkJLyogcmUtZW5hYmxlIFBEQyB0cmFuc21p
dCAqLwogCQlhdG1lbF91YXJ0X3dyaXRlbChwb3J0LCBBVE1FTF9QRENfUFRDUiwgQVRNRUxf
UERDX1RYVEVOKTsKKwl9CiAKIAkvKiBFbmFibGUgaW50ZXJydXB0cyAqLwogCWF0bWVsX3Vh
cnRfd3JpdGVsKHBvcnQsIEFUTUVMX1VTX0lFUiwgYXRtZWxfcG9ydC0+dHhfZG9uZV9tYXNr
KTsKIAotCS8qIHJlLWVuYWJsZSB0aGUgdHJhbnNtaXR0ZXIgKi8KLQlhdG1lbF91YXJ0X3dy
aXRlbChwb3J0LCBBVE1FTF9VU19DUiwgQVRNRUxfVVNfVFhFTik7Ci0JYXRtZWxfcG9ydC0+
dHhfc3RvcHBlZCA9IGZhbHNlOworCWlmIChpc19kbWEpIHsKKwkJLyogcmUtZW5hYmxlIHRo
ZSB0cmFuc21pdHRlciAqLworCQlhdG1lbF91YXJ0X3dyaXRlbChwb3J0LCBBVE1FTF9VU19D
UiwgQVRNRUxfVVNfVFhFTik7CisJCWF0bWVsX3BvcnQtPnR4X3N0b3BwZWQgPSBmYWxzZTsK
Kwl9CiB9CiAKIC8qCi0tIAoyLjM4LjEKCg==

--------------NM5TqSYlG0bVcwk6F3CBW0pS--
