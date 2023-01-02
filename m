Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0692065B3FA
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 16:15:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236278AbjABPPv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 10:15:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236300AbjABPPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 10:15:37 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2112F95B3;
        Mon,  2 Jan 2023 07:15:32 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id g10so6739498wmo.1;
        Mon, 02 Jan 2023 07:15:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=g55WvUk3pZh+76FrJSOP93CM4aqDNumn6UAqJNnkV2I=;
        b=aLCMPvNvQuBR+BOYVst4ixKSXgpzdzOHK/L6SNa38txbqSLncrahKEF85ZT0ZQfGmV
         +6n4bE1gkxhKRRnmJTdArfVryEqzNDUCzrLiS58xtUJK9Y3rNXOSSNMEgvHdragORXBL
         g8Rq7umFfKXusEHfeLLV4Fgdv+Kht9Ipb6IzORx0/I0wJD4aIv1iIgIqJq+LymVkdinv
         f2KmE/k3LBnhLE19WhgFqU9AhhUW6UJxYGl8nDq1af+M19nTKAk2Yva8JfZ7rVAyM7Iv
         hNzZwcA982VJq2cZHFtkuzrbOi9RnpFxh6q62shorF38/C4+DBitILoM4xQdnmirG/LM
         O0iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g55WvUk3pZh+76FrJSOP93CM4aqDNumn6UAqJNnkV2I=;
        b=biOfI+aLxCJskaOFXtg3Kah8QC28u5ghJAIhTXn90OHJRv/Bs1fQbajV11Ao2m0GAD
         CM/q5Hpb+OrsTzgW0vrytdFZuRRXgq8PQqiN8I2oND8BVEfZsVzCkAaNqVUeJbWoOI9l
         mV/S8negjCuYE3po9DsiVETqhQ6FXNbuVSn1BOtrE691WVUUXt0xLP6jPEXUKgB60Ei/
         vShzwvtnJsczbNySjHLeKnu7D5+SXo4rXvuNo1/QIqFJcmYtMdw9UPUvBoe3ogkVGowE
         1sKOFFLjRcZFOUBI54cK+JlsgLht/5psKVcBQBBT9CRlm/gBeuzbFOlS3YBVU+QoyjHd
         0Xvg==
X-Gm-Message-State: AFqh2kotF3SfMr74jq3iHZFgUxPjTqIxzThPn9ZXZPQdzcUoFJjlc5Vq
        QfMnuBYpH9Qp1+HoOJiZER4=
X-Google-Smtp-Source: AMrXdXvWTO524DeOp1N1HHR64ziyxg9sB0QO+udZTlGU/KNr/N+PZ9N8XO12CWRs/u839irqaO2vaw==
X-Received: by 2002:a7b:ca51:0:b0:3d2:7a7:5cc6 with SMTP id m17-20020a7bca51000000b003d207a75cc6mr32325317wml.18.1672672530638;
        Mon, 02 Jan 2023 07:15:30 -0800 (PST)
Received: from Red ([2a01:cb1d:3d5:a100:4a02:2aff:fe07:1efc])
        by smtp.googlemail.com with ESMTPSA id i2-20020a05600c354200b003d35acb0fd7sm47313218wmq.34.2023.01.02.07.15.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jan 2023 07:15:30 -0800 (PST)
Date:   Mon, 2 Jan 2023 16:15:27 +0100
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>, rafael@kernel.org, lenb@kernel.org,
        linux-acpi@vger.kernel.org, erik.kaneda@intel.com
Cc:     Dominik Brodowski <linux@dominikbrodowski.net>,
        linux-kernel@vger.kernel.org
Subject: Re: pcmcia: ti: regression cannot get IRQ
Message-ID: <Y7L1D6UTVwCKRx3+@Red>
References: <Y7HMfUTjuWC+Zudk@Red>
 <52ec1b11-4756-4396-866b-6250c6018f93@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <52ec1b11-4756-4396-866b-6250c6018f93@app.fastmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Mon, Jan 02, 2023 at 09:30:07AM +0100, Arnd Bergmann a écrit :
> On Sun, Jan 1, 2023, at 19:10, Corentin Labbe wrote:
> > Hello
> >
> > I was trying to boot again my old compaq armada 7400 laptop and the 
> > network card is unusable.
> >
> > Last known working kernel is 4.16.18.
> > First known bad kernel is 4.17.19
> >
> > The interesting log is:
> > [    3.503348] yenta_cardbus 0000:00:0c.0: ISA IRQ mask 0x0698, PCI irq 
> > 0
> > [    3.503442] yenta_cardbus 0000:00:0c.0: Socket status: 30000006
> > [    3.505250] yenta_cardbus 0000:00:0c.1: CardBus bridge found 
> > [0e11:b048]
> > [    3.505370] yenta_cardbus 0000:00:0c.1: adjusting diagnostic: 60 -> 
> > 00
> > [    3.505457] yenta_cardbus 0000:00:0c.1: Using INTVAL to route CSC 
> > interrupts to PCI
> > [    3.505554] yenta_cardbus 0000:00:0c.1: Routing CardBus interrupts 
> > to ISA
> > [    3.505556] yenta_cardbus 0000:00:0c.1: TI: mfunc 0x00000000, devctl 
> > 0x64
> > [    3.505556] yenta_cardbus 0000:00:0c.1: TI: no PCI interrupts. Fish. 
> > Please report.
> > [    3.505556] yenta_cardbus 0000:00:0c.1: no PCI IRQ, CardBus support 
> > disabled for this socket.
> > [    3.505556] yenta_cardbus 0000:00:0c.1: check your BIOS CardBus, 
> > BIOS IRQ or ACPI settings.
> > [    3.632323] yenta_cardbus 0000:00:0c.1: ISA IRQ mask 0x0698, PCI irq 
> > 0
> > [    3.632416] yenta_cardbus 0000:00:0c.1: Socket status: 30000020
> >
> > Full 4.16.18 log is availlable at: 
> > http://kernel.montjoie.ovh/zoo/armada/dmesg-4.16.18.txt
> > Since 4.17 (and 4.18) is stuck sarting init, I have log for 5.0.29
> > Full 5.0.29 log is availlable at: 
> > http://kernel.montjoie.ovh/zoo/armada/dmesg-5.0.21.txt
> 
> I see you hit this code path:
> 
>         if (!socket->cb_irq || request_irq(socket->cb_irq, yenta_interrupt, IRQF_SHARED, "yenta", socket)) {
>                 /* No IRQ or request_irq failed. Poll */
>                 socket->cb_irq = 0; /* But zero is a valid IRQ number. */
>                 timer_setup(&socket->poll_timer, yenta_interrupt_wrapper, 0);
>                 mod_timer(&socket->poll_timer, jiffies + HZ);
>                 dev_info(&dev->dev,
>                          "no PCI IRQ, CardBus support disabled for this socket.\n");
>                 dev_info(&dev->dev,
>                          "check your BIOS CardBus, BIOS IRQ or ACPI settings.\n");
>         } else {
> 
> 
> The "socket->cb_irq" is just the device IRQ, which is originally
> set to "11", and this one appears to be shared with all the other
> PCI devices:
> 
> [    2.402035] ACPI: PCI Interrupt Link [C168] (IRQs *11)
> [    2.403507] ACPI: PCI Interrupt Link [C16C] (IRQs *11)
> [    2.405461] ACPI: Blank _CRS EXT IRQ resource
> [    2.405546] ACPI: PCI Interrupt Link [C16D] (IRQs 11) *0, disabled.
> [    2.407578] ACPI: Blank _CRS EXT IRQ resource
> [    2.407663] ACPI: PCI Interrupt Link [C16E] (IRQs 11) *0, disabled.
> [    2.409610] ACPI: Blank _CRS EXT IRQ resource
> [    2.409695] ACPI: PCI Interrupt Link [C16F] (IRQs 11) *0, disabled.
> [    2.411647] ACPI: Blank _CRS EXT IRQ resource
> [    2.411733] ACPI: PCI Interrupt Link [C170] (IRQs 11) *0, disabled.
> [    2.413690] ACPI: Blank _CRS EXT IRQ resource
> [    2.413775] ACPI: PCI Interrupt Link [C171] (IRQs 11) *0, disabled.
> [    2.416055] ACPI: Blank _CRS EXT IRQ resource
> [    2.416140] ACPI: PCI Interrupt Link [C172] (IRQs 11) *0, disabled.
> 
> If any of them try to get the IRQ as non-shared, then the cardbus
> one would fail. Do you see anything suspicious in /proc/interrupts?
> 

Hello

On 4.16.18 /proc/interrupts:
           CPU0       
  0:      55783    XT-PIC      timer
  1:          9    XT-PIC      i8042
  2:          0    XT-PIC      cascade
  8:          0    XT-PIC      rtc0
 11:        684    XT-PIC      acpi, yenta, yenta, eth2
 12:        136    XT-PIC      i8042
 14:       1526    XT-PIC      pata_triflex
 15:          0    XT-PIC      pata_triflex
NMI:          0   Non-maskable interrupts
LOC:          0   Local timer interrupts
SPU:          0   Spurious interrupts
PMI:          0   Performance monitoring interrupts
IWI:          0   IRQ work interrupts
RTR:          0   APIC ICR read retries
TRM:          0   Thermal event interrupts
THR:          0   Threshold APIC interrupts
MCE:          0   Machine check exceptions
MCP:          1   Machine check polls
ERR:          0
MIS:          0
PIN:          0   Posted-interrupt notification event
NPI:          0   Nested posted-interrupt event
PIW:          0   Posted-interrupt wakeup event

On 5.0.21 /proc/interrupts give:
           CPU0       
  0:       4736    XT-PIC      timer
  1:          9    XT-PIC      i8042
  2:          0    XT-PIC      cascade
  4:        438    XT-PIC      ttyS0
  8:          0    XT-PIC      rtc0
 11:          0    XT-PIC      acpi
 12:        136    XT-PIC      i8042
 14:       1224    XT-PIC      pata_triflex
 15:          0    XT-PIC      pata_triflex
NMI:          0   Non-maskable interrupts
LOC:          0   Local timer interrupts
SPU:          0   Spurious interrupts
PMI:          0   Performance monitoring interrupts
IWI:          0   IRQ work interrupts
RTR:          0   APIC ICR read retries
TRM:          0   Thermal event interrupts
THR:          0   Threshold APIC interrupts
MCE:          0   Machine check exceptions
MCP:          1   Machine check polls
ERR:        227
MIS:          0
PIN:          0   Posted-interrupt notification event
NPI:          0   Nested posted-interrupt event
PIW:          0   Posted-interrupt wakeup event


I have bisected this to:
first bad commit: [5a8361f7ecceaed64b4064000d16cb703462be49] ACPICA: Integrate package handling with module-level code
So I added ACPI people.

Regards
