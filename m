Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF7316DC7B3
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 16:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbjDJOOH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 10:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjDJOOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 10:14:06 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A8A255B8;
        Mon, 10 Apr 2023 07:14:00 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id h24-20020a17090a9c1800b002404be7920aso4519332pjp.5;
        Mon, 10 Apr 2023 07:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681136040; x=1683728040;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uBIZ4Jbk4NcYTcPJUs3ckcMxZs3ulhQ8AP4uxmk9HQI=;
        b=RU1a0zbVMraVlgYjZveDU1IpOxYV68WszdZ85R93duL7vJy+Khy1mLBh0UJsqReACX
         a7H5uxNhw5bpnlaSM7RlYw5ILeLir4h4AMBGHP16T+dup++JLpOdqpAtbVi8/DaNtRnX
         8qBnTptN7B/q66clJuXseg5Lwd7yB3tIij/cUO+bQ12sk6eGC9RpDdWwloB1U7EhVqyu
         PIsrztpfZhXlPGSGR4KKI7k2wumZE7rwOMIrMYt8DwTNaevb9aPNlrJ9+Z91KRbqcYuQ
         1YyUMhaX1j6JV7ptnQkyB4xytUn4v1mocnSp1g46NJdXrxtun/BMSNQ59EsBnC/EFzi4
         P3og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681136040; x=1683728040;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uBIZ4Jbk4NcYTcPJUs3ckcMxZs3ulhQ8AP4uxmk9HQI=;
        b=UFAX6qr8Oe7NFOdBdd7iaRzRdjJRsPlHLUGWbuWpezWmjTTvFIG66NS0MlpiTSUlPC
         3WPf4HNH5bgVn/Ja/mhBCXLfCpxLdOKjjB+y4R/Zc2Xdk69E+4nEXY70koA2RaFq5MLC
         2gBF6hMFkIVJiVvAHlP/95c3A6vNesggYEfYi/3RbXqsDz/3Wnx4bh+SdD1/JQOyA78u
         hFKFFMcO130c6GuYAcH7Hg9PQ0j6HBJITIhQBryGL/xzoEGsOYp6mnuuQlSLff+0mI0L
         lxpS8a+s6GEC9UDNIFNYaXW4KQrKl4bvGRfzCL+RxfKfHmVOf9N2vdCHXwdEXZ5c3/Ke
         GVig==
X-Gm-Message-State: AAQBX9fp9uDM8bNQw40OGLd3sYzsxIALdSkotXrodcaWkHHGbbK55Hse
        Yfh9hjWMblAB4uKLrO4KQ2JAmT40Q/c=
X-Google-Smtp-Source: AKy350ZqRPzXAZGZSZ5H/FHZ4mrzgZ4lEfQutkIyXrBR+Er9OZpKeCUWkpYpfyBeViT+XHQcg63GuA==
X-Received: by 2002:a17:90b:1d11:b0:23d:158c:a60c with SMTP id on17-20020a17090b1d1100b0023d158ca60cmr13924315pjb.44.1681136039969;
        Mon, 10 Apr 2023 07:13:59 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u5-20020a17090282c500b001a3d041ca71sm7858455plz.275.2023.04.10.07.13.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Apr 2023 07:13:59 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <ff111499-c871-e97d-0f0c-237cb0879aeb@roeck-us.net>
Date:   Mon, 10 Apr 2023 07:13:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-US
To:     Badhri Jagan Sridharan <badhri@google.com>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230410073134.488762-1-badhri@google.com>
 <2023041028-irritate-starless-a42f@gregkh>
 <CAPTae5KZ0zkaCWrtPYzyX8oTyvDhBhc-hvxyHn9VHZ32UOqJ3g@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v1] usb: typec: tcpm: Add kernel config to wrap around
 tcpm logs
In-Reply-To: <CAPTae5KZ0zkaCWrtPYzyX8oTyvDhBhc-hvxyHn9VHZ32UOqJ3g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/10/23 01:08, Badhri Jagan Sridharan wrote:
> On Mon, Apr 10, 2023 at 12:45 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>>
>> On Mon, Apr 10, 2023 at 07:31:34AM +0000, Badhri Jagan Sridharan wrote:
>>> This change adds CONFIG_TCPM_LOG_WRAPAROUND which when set allows the
>>> logs to be wrapped around. Additionally, when set, does not clear
>>> the TCPM logs when dumped.
>>>
>>> Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
>>> ---
>>>   drivers/usb/typec/tcpm/Kconfig | 6 ++++++
>>>   drivers/usb/typec/tcpm/tcpm.c  | 9 +++++++--
>>>   2 files changed, 13 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/usb/typec/tcpm/Kconfig b/drivers/usb/typec/tcpm/Kconfig
>>> index e6b88ca4a4b9..4dd2b594dfc9 100644
>>> --- a/drivers/usb/typec/tcpm/Kconfig
>>> +++ b/drivers/usb/typec/tcpm/Kconfig
>>> @@ -18,6 +18,12 @@ config TYPEC_TCPCI
>>>        help
>>>          Type-C Port Controller driver for TCPCI-compliant controller.
>>>
>>> +config TCPM_LOG_WRAPAROUND
>>> +     bool "Enable TCPM log wraparound"
>>> +     help
>>> +       When set, wraps around TCPM logs and does not clear the logs when dumped. TCPM logs by
>>> +       default gets cleared when dumped and does not wraparound when full.
>>
>> Kconfig help text needs to be wrapped at the properly width.
> 
> I assumed that the width is 100 characters, but it looks like it is
> 80. Will fix it in the next version.
>>
>> And you do not provide any hint here as to why this is not the default
>> option, or why someone would want this.
> 
> "TCPM logs by default gets cleared when dumped and does not wraparound
> when full." was intended
> to convey why someone would want to set this. Perhaps it's not effective.
> 
> Does the below look better:
> "TCPM logs by default gets cleared when dumped and does not wraparound
> when full. This can be overridden by setting this config.
> When the config is set, TCPM wraps around logs and does not clear the
> logs when dumped."
> 
> Also, I could make this default if that's OK with Guenter.
> 

The reason to not wrap around the buffer was that it tends to fill up quickly
if something goes wrong. Initially I had it wrap around and often ended up
seeing endless reset sequences in the log but not the actual problem.

>>
>> So, why is this not just the default operation anyway?  Why would you
>> ever want the logs cleared?
> 
> I remember Guenter mentioning that he was finding it useful to not
> wrap around the logs to fix problems
> during tcpm_register_port (init sequence). IMHO wrapping around the
> logs helps to triage interoperability
> issues uncovered during testing. So both approaches have their own advantages.
> 
Yes, except that "testing" at the time included connecting an arbitrary new
device to the type c port. Pretty much each of them had its own flaws.
This was also the reason for not using tracing, because I wanted to have a
log available _all_ the time, not just when explicitly enabled.

Maybe the protocol is now more stable than it used to be, and switching
to a wraparound buffer and/or to tracing makes more sense now.
I can't really say.

Guenter

> Thanks for taking the time to review !
> - Badhri
> 
>>
>> thanks,
>>
>> greg k-h

