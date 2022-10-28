Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CB3E6115DE
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 17:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbiJ1Pat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 11:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbiJ1PaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 11:30:19 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D95C550B9B
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 08:30:17 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id cy15-20020a056830698f00b0065c530585afso3171714otb.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 08:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pVC7omGYGHWjyxu8HSssobUiNhAheSxDNb5DGhYJISA=;
        b=ft7EONnxR0qQF3VVWwkZyDfGV/Fv2zZRdCYnkxD+HUW8s5qRgBodMFhMJIx9oOvebl
         Z1go3Mjc2sumYtLldBwBWjNPs4+rdNvkMqUp2fTyiIQyYIrJVcKaclY9+v0bQZf7+p83
         S7VPJ4f0kj2ws+oeSr/2m21AH4SguIh+NRG62sDGUpKoCpo5Wg6E/dHxma7nBNLM6BEh
         YKAbDMyJjOPYT2pEO1oRTmmc1+WsxoCYuJAM/rXhKUGhSLSXoym5K4aIdiNU4C4VRCrt
         ldqvKbGk8+fwu7kM0NC40geHGozwZV5sdvUDMGAGGd2f+wQ0vLKJBXN5D3DkWgyOHytp
         rqBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pVC7omGYGHWjyxu8HSssobUiNhAheSxDNb5DGhYJISA=;
        b=HeRxTCXSVRjvsci+I58lgyfB+FBna0I8XoYblq5K52wDnnH0v1zEQzqWL9At7DcrkR
         D3eWDCYx+gM2bNh5gk+ZCwjRATJlygcAFebJIjaJRtisrA6TwduSb8e9gHsuTb7jO8IN
         ucoc+sSuTmTWvUfS7bggE6UrjimMxBbsgXOlhXLeeO/wPQt70s56UOsqpQwwj5lncMl2
         Bsy11mmvliyULcQecWkPUahB1wjks+iSlAN6fa12y4OtBUa2dcYEn4RvGW2NNtREK9Ic
         qMiUJEA1fMp8ffhQhGfOFsEf1vp66GmQCNAXF5rR4pArp2Vo2Ps2TBXcFogHsinIs31W
         mdng==
X-Gm-Message-State: ACrzQf22rf7ayZD7FNJrRfm33M6brbA2DpPZwlLvZuD9rQmZ8z+rdzRp
        Zc4LE0sqgQtts2flvMS4YoBM4QAep2E=
X-Google-Smtp-Source: AMsMyM5Bsi8dLgSLpso4bnUKABB8xvpRjEQn5ubzeUuW8IlSMqSVPUFDqOTrSSXF3ej06qvtAy30aw==
X-Received: by 2002:a05:6830:6016:b0:661:959a:c60d with SMTP id bx22-20020a056830601600b00661959ac60dmr27705709otb.74.1666971017040;
        Fri, 28 Oct 2022 08:30:17 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l13-20020a9d550d000000b0063696cbb6bdsm1752850oth.62.2022.10.28.08.30.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Oct 2022 08:30:16 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <4ed6a6f6-a6e7-fbda-7658-9f645c95326a@roeck-us.net>
Date:   Fri, 28 Oct 2022 08:30:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>
References: <20221027150525.753064657@goodmis.org>
 <20221027222404.GA3123386@roeck-us.net>
 <20221027185859.1087d3ca@gandalf.local.home>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [RFC][PATCH v2 00/31] timers: Use del_timer_shutdown() before
 freeing timers
In-Reply-To: <20221027185859.1087d3ca@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/27/22 15:58, Steven Rostedt wrote:
> On Thu, 27 Oct 2022 15:24:04 -0700
> Guenter Roeck <linux@roeck-us.net> wrote:
> 
>> On Thu, Oct 27, 2022 at 11:05:25AM -0400, Steven Rostedt wrote:
>>>
>>> Back in April, I posted an RFC patch set to help mitigate a common issue
>>> where a timer gets armed just before it is freed, and when the timer
>>> goes off, it crashes in the timer code without any evidence of who the
>>> culprit was. I got side tracked and never finished up on that patch set.
>>> Since this type of crash is still our #1 crash we are seeing in the field,
>>> it has become a priority again to finish it.
>>>
>>> This is v2 of that patch set. Thomas Gleixner posted an untested version
>>> that makes timer->function NULL as the flag that it is shutdown. I took that
>>> code, tested it (fixed it up), added more comments, and changed the
>>> name to del_timer_shutdown() as Linus had asked. I also converted it to use
>>> WARN_ON_ONCE() instead of just WARN_ON() as Linus asked for that too.
>>>    
>>
>> Here are various warnings and crashes. Complete logs are at
>>
>> https://kerneltests.org/builders
>>
>> in the "testing" column of the qemu test results.
>>
>> This is with the published patch set plus the fixups in
>> timer_fixup_init() and timer_fixup_free().
>>
>> Guenter
>>
>> ---
[ ... ]

>>
>> WARNING: CPU: 0 PID: 280 at lib/debugobjects.c:502 debug_print_object+0xa4/0xd8
>> ODEBUG: init active (active state 0) object type: timer_list hint: tulip_timer+0x0/0x38
>>


The problem is that the tulip code calls timer_setup() repeatedly (and
unnecessarily). Apparently either the new timer code and/or the associated
ODEBUG code doesn't like that. The patch below fixes the problem.

I think there needs to be a means to handle that situation gracefully.
The parport code has the same problem (see second patch below), and
I am sure there are others.

Thanks,
Guenter

---
tulip:

diff --git a/drivers/net/ethernet/dec/tulip/tulip_core.c b/drivers/net/ethernet/dec/tulip/tulip_core.c
index ecfad43df45a..0c86066929d3 100644
--- a/drivers/net/ethernet/dec/tulip/tulip_core.c
+++ b/drivers/net/ethernet/dec/tulip/tulip_core.c
@@ -770,8 +770,6 @@ static void tulip_down (struct net_device *dev)

         spin_unlock_irqrestore (&tp->lock, flags);

-       timer_setup(&tp->timer, tulip_tbl[tp->chip_id].media_timer, 0);
-
         dev->if_port = tp->saved_if_port;

         /* Leave the driver in snooze, not sleep, mode. */
@@ -1869,10 +1867,14 @@ static int __maybe_unused tulip_resume(struct device *dev_d)
  static void tulip_remove_one(struct pci_dev *pdev)
  {
         struct net_device *dev = pci_get_drvdata (pdev);
+       struct tulip_private *tp;

         if (!dev)
                 return;

+       tp = netdev_priv(dev);
+       del_timer_shutdown(&tp->timer);
+
         unregister_netdev(dev);
  }


---
parport:

diff --git a/drivers/parport/ieee1284.c b/drivers/parport/ieee1284.c
index 4547ac44c8d4..50dbd2ea23fc 100644
--- a/drivers/parport/ieee1284.c
+++ b/drivers/parport/ieee1284.c
@@ -73,7 +73,7 @@ int parport_wait_event (struct parport *port, signed long timeout)
         timer_setup(&port->timer, timeout_waiting_on_port, 0);
         mod_timer(&port->timer, jiffies + timeout);
         ret = down_interruptible (&port->physport->ieee1284.irq);
-       if (!del_timer_sync(&port->timer) && !ret)
+       if (!del_timer_shutdown(&port->timer) && !ret)
                 /* Timed out. */
                 ret = 1;


