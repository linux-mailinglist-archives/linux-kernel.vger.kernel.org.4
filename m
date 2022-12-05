Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97ECD643297
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 20:27:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233901AbiLET1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 14:27:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233814AbiLET0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 14:26:46 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43B8FB4A
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 11:21:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670268115;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NHh5/ehdO6YhAxmmSjwHUVYTjnZwE/kakF1qkVdl8Io=;
        b=GVZ20fTBXZ8nCdCuOWA+RN+vRkRxGiSm5MOzhtkIxgtwPeBa9qcnAdxEhaw0c144Wkdi2v
        WBcgIotEtN26EOkqcXhnSCW2185ytneV3jamxSqflYbzc8r4cC03jfnN4gUAzJ33TD+2Tj
        P/kNQyqvcPV7XOxZp53d8UmB9tEJYCo=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-388-qfPxyC_oMVaQ3pE8yhMzFQ-1; Mon, 05 Dec 2022 14:21:54 -0500
X-MC-Unique: qfPxyC_oMVaQ3pE8yhMzFQ-1
Received: by mail-ej1-f69.google.com with SMTP id sb2-20020a1709076d8200b007bdea97e799so165889ejc.22
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 11:21:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NHh5/ehdO6YhAxmmSjwHUVYTjnZwE/kakF1qkVdl8Io=;
        b=JZBEULDB/H4mBSoItZQNp+YCmWqL0yek2qXbHzz3qlHb7erR2t2JOVyq4NODe/967S
         mIJnfwmXo8YlVxpjPEIQbRknUhR9D7q4b033hOEDdBXJqCUk3s5Khagv+PsqoFGqYpF4
         Bf3Bj5atvjuN8oXSSDY7Vor1vkzA8IdATuhmrkOWMcsHhdVCue2AL1PbdS53Arm3SWCw
         zdQF4aUpbfPys54QrlbVFLUmlzDzOAnaaIOw0m/NEPvZpS4ZPAPJERuY+QnfWV1vUsds
         Kqsz6suRmN7/3l9V17Ky/kHNUi9yosQxGHNGT0bp1aBMSDYlIxaJgtcJsAdBoaXxr35c
         nCzg==
X-Gm-Message-State: ANoB5pkOiJeghwNu1KPWGiO+9JHg5nOnoIcejKm6cnhLukVrFJxIhppO
        Vrpx39qQY0+HG4Xk/FwrMI2DyhJa4+Za4oEtbXaVmN3CfeapzgJAYyLkGWJiSFymVElXpmmQ5uJ
        0zLaf4cpx0fSpNkZEo7P1qvBT
X-Received: by 2002:aa7:da01:0:b0:46b:9f6e:4005 with SMTP id r1-20020aa7da01000000b0046b9f6e4005mr23639152eds.203.1670268113205;
        Mon, 05 Dec 2022 11:21:53 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4wJEzMynCDpVS/VO6+rAtu9FW6RTYYX4rfbKHh41bRkqEluYyEJHf1U9GtRadW3UGnczqXEw==
X-Received: by 2002:aa7:da01:0:b0:46b:9f6e:4005 with SMTP id r1-20020aa7da01000000b0046b9f6e4005mr23639142eds.203.1670268113059;
        Mon, 05 Dec 2022 11:21:53 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id kz14-20020a17090777ce00b007806c1474e1sm6539898ejc.127.2022.12.05.11.21.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Dec 2022 11:21:52 -0800 (PST)
Message-ID: <38bc80ac-0f19-eaa1-5076-b5487aa52ee4@redhat.com>
Date:   Mon, 5 Dec 2022 20:21:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 0/4] PCI: Continue E820 vs host bridge window saga
To:     Konrad J Hambrick <kjhambrick@gmail.com>
Cc:     Werner Sembach <wse@tuxedocomputers.com>,
        Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        Florent DELAHAYE <kernelorg@undead.fr>,
        Matt Hansen <2lprbe78@duck.com>,
        =?UTF-8?Q?Benoit_Gr=c3=a9goire?= <benoitg@coeus.ca>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        mumblingdrunkard@protonmail.com, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
References: <20221203175743.GA1121812@bhelgaas>
 <d7f1408d-ae9f-ad55-5fc9-9d9886384a3d@redhat.com>
 <9869d438-a715-fa5e-2877-b58f1bb6fc91@tuxedocomputers.com>
 <ec78042b-0013-e120-a7fe-16e0a92c6783@redhat.com>
 <CANBHt+MoHWz6nB39N3vCM8OkWcjqn_5Va-_bbEcknYDQ3Ve8=Q@mail.gmail.com>
Content-Language: en-US, nl
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CANBHt+MoHWz6nB39N3vCM8OkWcjqn_5Va-_bbEcknYDQ3Ve8=Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/5/22 17:29, Konrad J Hambrick wrote:
> 
> 
> On Mon, Dec 5, 2022 at 8:26 AM Hans de Goede <hdegoede@redhat.com <mailto:hdegoede@redhat.com>> wrote:
> 
> 
>     > Do you mean the X170KM-G? I don't think it has the option to switch to Legacy BIOS mode (At least i didn't found an option in the bios version i have)
> 
>     I'm talking about this patch:
> 
>     https://lore.kernel.org/linux-pci/20221010150206.142615-1-hdegoede@redhat.com/ <https://lore.kernel.org/linux-pci/20221010150206.142615-1-hdegoede@redhat.com/>
> 
>     Regards,
> 
>     Hans
> 
> 
> Hans --
> 
> I applied Bjorn's four Patches last night and built 6.1-rc8 and the 'Clevo X170KM-G Barebone' Quirk is still in the pci_crs_quirks[] array in arch/x86/pci/acpi.c, even after I applied Bjorn's Patches.

Right that is expected, the point which I was trying to make is, that at least for
those models which support Legacy BIOS mode, we need to keep the quirks around.

> I am stuck on a project for my 'real job' and I won't be free until this evening.
> 
> Do you still need a set of logs from 6.1-rc8 ?

I don't remember ever asking for logs in this email thread. I guess Bjorn maybe
asked for logs? Assuming I have that right I will leave answering the question
if logs are still necessary up to Bjorn.

Regards,

Hans


