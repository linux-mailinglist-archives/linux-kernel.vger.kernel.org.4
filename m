Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F04D569C052
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 14:22:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbjBSNWV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 08:22:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbjBSNWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 08:22:16 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CB1F10AB2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 05:21:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676812896;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y9GsrtbgmRLQ9WJ6Uc2hVrmt2kggCScaPCAaKtCdoVc=;
        b=PZqPseuQo1r0qLNDrlC+V+FgmLnh8fY8Egz7EtdlpWzmzXDCVLpL9Gx1jHiMfb6QY6GZSp
        fEavRZtoT/AoDUPVOpQtEtx6g6xcEeVxaZ6fknmzCWg1c4widTR38h8O83N35U5xWldoin
        iBV0Dlsu1f1hr8gI1wmkVvZTGnhvkFg=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-665-oxZTqaryMcutWvhJt6Hg7A-1; Sun, 19 Feb 2023 08:21:34 -0500
X-MC-Unique: oxZTqaryMcutWvhJt6Hg7A-1
Received: by mail-ed1-f69.google.com with SMTP id ee24-20020a056402291800b004ad51f8fc36so659537edb.22
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 05:21:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y9GsrtbgmRLQ9WJ6Uc2hVrmt2kggCScaPCAaKtCdoVc=;
        b=TQVkDXVklSoIWwczx5j5QR3hSSHTN2U5EJz1mRlIXn425E6zyxEVwRSIq5JyhRIcnY
         Xox+3uSsuOQnOISw4HTcIXSizyCKAgTW9DdMBs41TEpb3cxJ8BDNw9O2yJIIFVsy8Bd7
         hrzyI9j9rlHQ1YY5rx6sym29bpqvF/7mGuv0m9FSbUtjI4wUYbfDcOsUidk4noCAgoDH
         hQ2n2Tfklra6eWDyZJtSYtrqxCmG82f18gWvMmzhSYOL9Cntk3KnMjfo79vYqyY5G8jM
         el9YMMDxu0j2y/enGClt66dOrCvGvZUTElV3BLBicMTg1zNxQHMkI+JR7URvAm4ukSzA
         4NEQ==
X-Gm-Message-State: AO0yUKWm16Ct9sacXaKDhPVfofu13C6QW018f5H/qmSI9MmEQcU3z8MJ
        BzOpAD+BxBNMHvx41ZQML9iUtacVgIFrtDiFqZ+T4mprrEN5eIQa1ibWQRPKk/2GGDwaL0AOlRM
        mgBzkLJfRPLHd7/zQ3Egjldzy
X-Received: by 2002:a17:907:8a1a:b0:8b1:2fda:c7bb with SMTP id sc26-20020a1709078a1a00b008b12fdac7bbmr10302896ejc.42.1676812893790;
        Sun, 19 Feb 2023 05:21:33 -0800 (PST)
X-Google-Smtp-Source: AK7set8HWIYao5vl6dv7OT+73lfSw51uOkZfOK63qF3CaUxRx9k/+6XL53Kcv9Msz0hR9bYZ59IlfA==
X-Received: by 2002:a17:907:8a1a:b0:8b1:2fda:c7bb with SMTP id sc26-20020a1709078a1a00b008b12fdac7bbmr10302880ejc.42.1676812893524;
        Sun, 19 Feb 2023 05:21:33 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id mm16-20020a170906cc5000b008b0fbcf4b11sm4467784ejb.66.2023.02.19.05.21.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Feb 2023 05:21:32 -0800 (PST)
Message-ID: <093c5929-add3-689f-1fdd-6819f33c705c@redhat.com>
Date:   Sun, 19 Feb 2023 14:21:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 4/5] apple-gmux: support MMIO gmux on T2 Macs
Content-Language: en-US, nl
To:     Orlando Chamberlain <orlandoch.dev@gmail.com>
Cc:     Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Wunner <lukas@wunner.de>,
        Seth Forshee <sforshee@kernel.org>,
        Aditya Garg <gargaditya08@live.com>,
        Aun-Ali Zaidi <admin@kodeit.net>,
        Kerem Karabay <kekrby@gmail.com>
References: <20230216122342.5918-1-orlandoch.dev@gmail.com>
 <20230216122342.5918-5-orlandoch.dev@gmail.com>
 <cd6beabe-3026-d84e-63fd-3833948ecc1f@redhat.com>
 <20230217110531.6d3c07a1@redecorated-mbp>
 <20230217230246.53e3d013@redecorated-mbp>
 <9be4b45a-83cb-b671-e7df-c4c8812b5506@redhat.com>
 <20230218235222.17983234@redecorated-mbp>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230218235222.17983234@redecorated-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLACK autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2/18/23 13:52, Orlando Chamberlain wrote:
> On Sat, 18 Feb 2023 11:49:52 +0100
> Hans de Goede <hdegoede@redhat.com> wrote:
> 
>> Hi,
>>
>> On 2/17/23 13:02, Orlando Chamberlain wrote:
>>> On Fri, 17 Feb 2023 11:05:31 +1100
>>> Orlando Chamberlain <orlandoch.dev@gmail.com> wrote:  
>>>>>
>>>>> Question are we not worried about MacBooks with an "APP000B"
>>>>> ACPI device (with a value IORSOURCE_MEM entry) but which do not
>>>>> actually have a gmux, because they are iGPU only ?    
>>>>
>>>> It looks like iMac20,1, iMac20,2, and iMacPro1,1 have APP000B:
>>>>
>>>> apple_gmux: Failed to find gmux I/O resource
>>>>
>>>> iMac20,2: https://linux-hardware.org/?probe=ec2af584b3&log=dmesg
>>>> iMac20,1: https://linux-hardware.org/?probe=fee7644b9c&log=dmesg
>>>> iMacPro1,1: https://linux-hardware.org/?probe=6c26c9ff8c&log=dmesg
>>>>
>>>> But I'm not sure if they actually have it or not. I'll see if I can
>>>> get people with those models to test if it's a real gmux. There
>>>> does seem to be a pattern in that those three all have AMD GPU's.  
>>>
>>> Kerem Karabay managed to find the acpi tables and macOS's ioreg
>>> from and iMacPro1,1:
>>>
>>> https://github.com/khronokernel/DarwinDumped/blob/master/iMacPro/iMacPro1%2C1/Darwin%20Dumper/DarwinDumper_3.0.4_30.12_15.30.40_iMacPro1%2C1_Apple_X64_High%20Sierra_17C2120_apple/ACPI%20Tables/DSL/DSDT.dsl#L10423
>>> https://github.com/khronokernel/DarwinDumped/blob/master/iMacPro/iMacPro1%2C1/Darwin%20Dumper/DarwinDumper_3.0.4_30.12_15.30.40_iMacPro1%2C1_Apple_X64_High%20Sierra_17C2120_apple/IORegistry/IOReg.txt#L5096
>>>
>>> The DSDT table has the same APP000B device as MacBooks with actual
>>> gmux, while the ioreg has no mention of Apple's driver
>>> AppleMuxControl2 being used for that device.
>>>
>>> I think that confirms Apple has not fixed the issue of putting
>>> APP000B's where they don't need to.
>>>
>>> Solutions to this I can think of are:
>>>
>>> - Use DMI matching to ignore product_names "iMacPro1,1" "iMac20,1",
>>>   "iMac20,2"
>>> - Maybe check if the MMIO region for gmux is filled with 0xff*
>>>
>>> *I don't know if this would work or not as I don't have a machine to
>>> check with. On my machine everything surrounding the 16 bytes used
>>> for gmux is 0xff:
>>>
>>> # hexdump -n48 -C -s 0xfe0b01f0 /dev/mem
>>> fe0b01f0  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff
>>> |................| fe0b0200  00 00 3e 4f 00 00 00 00  00 00 00 00
>>> 00 00 14 00  |..>O............| fe0b0210  ff ff ff ff ff ff ff ff
>>> ff ff ff ff ff ff ff ff  |................|
>>>
>>> so maybe on the iMacPro and iMac's, this would all be 0xff.  
>>
>> Yes checking for a regular ioread32 returning 0xffffffff sounds
>> like it should work. Can you add a check for that in the next version
>> please ?  Note this means we still need to do an iomap + unmap as
>> you pointed out in another email, but I see no way around that.
> 
> I'll check that GMUX_MMIO_COMMAND_SEND (16th byte) is not 0xff, as if
> the gmux is present it will reset that to 0x00, unless a command isn't
> finished yet, in which case it will be one of 0x1, 0x4, 0x41, or 0x44.

Ok, this sounds good to me, thanks.

Regards,

Hans



>>>> I've looked at dmesg or at least lsmod on all the models with the
>>>> T2 chip and there wasn't evidence of any other models having that
>>>> error or having apple-gmux loaded on any models that shouldn't
>>>> have a gmux, other than the three mentioned above. Of course I
>>>> don't know if its possible for there to be firmware versions where
>>>> this isn't the case. 
>>>>>
>>>>> I have learned the hard way (through backlight control regressions
>>>>> in 6.1) that at least some older model MacBooks with an IO
>>>>> resource have an APP000B ACPI device without them actually having
>>>>> a gmux, these get caught by the version check and then do not
>>>>> pass the indexed check so that apple_gmux_detect() properly
>>>>> returns false.
>>>>>
>>>>> Maybe make gmux_mmio_read32() a static inline inside
>>>>> include/linux/apple-gmux.h and try to read the version here ?    
>>>>
>>>> For that would we need to ioremap() and iounmap()?  
>>>>>
>>>>> Has this been tested on iGPU only T2 Macs?    
>>>>
>>>> I don't think so. 
>>>>  
>>>>>
>>>>> Regards,
>>>>>
>>>>> Hans
>>>>>
>>>>>     
>>>>  
>>>   
>>
> 

