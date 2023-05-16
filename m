Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7146470565C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 20:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbjEPSvU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 14:51:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjEPSvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 14:51:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2D9A93FB
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 11:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684263019;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D8hrgFwj/IxmETrWztPLsjH83oYYFMWk/GEnHhUo1CE=;
        b=T31VWISAhvp0WPt5/BiR/IR9cFpdvfxxw2s9XdGeSXAbBLy3bFexSRj2fEfAzrMBT+BjF/
        cStfDcPQ0Q+iaBRpKDgWR4iitROjWK+RG6cS7XnxoZC75MOjrephwn7WLJlQrQSQuiWEyL
        OGSGcEcxd2VjY2xOaShKiqd6dF1lpJg=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-353-dmvszCxWNZai2IMZ1AE5wg-1; Tue, 16 May 2023 14:50:16 -0400
X-MC-Unique: dmvszCxWNZai2IMZ1AE5wg-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-94a356c74e0so1407172666b.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 11:50:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684263015; x=1686855015;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D8hrgFwj/IxmETrWztPLsjH83oYYFMWk/GEnHhUo1CE=;
        b=jVmVIGt2IVe1/Rir3RHxYjT+KhwTn7NjpRYsBihhdM4jx7GAbPwt8puU3r/g2FrSGS
         eEKC4cDDXG1jMedt4Abe6HZInsLH9tbEXCkym3ByyM3DtmODrAATUTraATlzHweMYFT9
         GoCToEoiiX89MbXEZYcXUadmo0oUhBowQKJv9CUcIGePEMsHTTiCWC10s/M/hEDsiZaG
         xdBYeGeMrX+4XnkEDSOhubr8gSJLpJHrSWMzKJ8IBeHexR2NdNlw41PSkYySr/rYnIuK
         3XmQ3ClIrfLwhbsbe6uH7CuUxFO+6RSX+afabDXpNYjzklOvNhFX5MXdpzyZLED1WnoB
         OGDg==
X-Gm-Message-State: AC+VfDy1BNE20I4xweMjDULbGh9/hf6ntwceeFqP36NbaeEx769Xat5o
        aBNnqRjjmceAJ5twp0MnJtCwrA5uNMJIKxIiCfD7N5lV8TUPcKTNyWZDotXWdtlBWNUCoyjCTcn
        i7gCs4R4j/WO6ez0jnV/+advE
X-Received: by 2002:a17:907:c10:b0:94d:7b6b:fda6 with SMTP id ga16-20020a1709070c1000b0094d7b6bfda6mr36675640ejc.22.1684263015350;
        Tue, 16 May 2023 11:50:15 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4U2g54EoTrIFzyZ4p5A6oNWLt/P8us3e/AKgSPx7EgkHlb5A4zBWWO043P6KcRjAE+kPGobw==
X-Received: by 2002:a17:907:c10:b0:94d:7b6b:fda6 with SMTP id ga16-20020a1709070c1000b0094d7b6bfda6mr36675621ejc.22.1684263014834;
        Tue, 16 May 2023 11:50:14 -0700 (PDT)
Received: from ?IPV6:2001:1c00:2a07:3a01:67e5:daf9:cec0:df6? (2001-1c00-2a07-3a01-67e5-daf9-cec0-0df6.cable.dynamic.v6.ziggo.nl. [2001:1c00:2a07:3a01:67e5:daf9:cec0:df6])
        by smtp.gmail.com with ESMTPSA id h25-20020a1709070b1900b0094ef923a6ccsm11272105ejl.219.2023.05.16.11.50.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 May 2023 11:50:14 -0700 (PDT)
Message-ID: <c234d570-ed0d-8e98-b5f4-bf95d8ad8e38@redhat.com>
Date:   Tue, 16 May 2023 20:50:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: drivers/platform/x86/apple-gmux.c:276:15: sparse: sparse: cast to
 restricted __be32
Content-Language: en-US
To:     Orlando Chamberlain <orlandoch.dev@gmail.com>
Cc:     kernel test robot <lkp@intel.com>, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <56f2f65b-150d-3cf6-95f9-2dd8232d2717@redhat.com>
 <D62B0A4F-6A2E-495D-B3AE-4CEAEE172E39@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <D62B0A4F-6A2E-495D-B3AE-4CEAEE172E39@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 5/16/23 13:31, Orlando Chamberlain wrote:
> Hi,
> 
>> On 16 May 2023, at 8:27 pm, Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> ﻿Hi,
>>
>>> On 5/16/23 12:16, kernel test robot wrote:
>>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>>> head:   f1fcbaa18b28dec10281551dfe6ed3a3ed80e3d6
>>> commit: 0c18184de990e63f708b090bcb9fc6c0fbc427cd platform/x86: apple-gmux: support MMIO gmux on T2 Macs
>>> date:   9 weeks ago
>>> config: i386-randconfig-s001-20230515
>>> compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
>>> reproduce:
>>>        # apt-get install sparse
>>>        # sparse version: v0.6.4-39-gce1a6720-dirty
>>>        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=0c18184de990e63f708b090bcb9fc6c0fbc427cd
>>>        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>>>        git fetch --no-tags linus master
>>>        git checkout 0c18184de990e63f708b090bcb9fc6c0fbc427cd
>>>        # save the config file
>>>        mkdir build_dir && cp config build_dir/.config
>>>        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 olddefconfig
>>>        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash drivers/platform/x86/
>>>
>>> If you fix the issue, kindly add following tag where applicable
>>> | Reported-by: kernel test robot <lkp@intel.com>
>>> | Link: https://lore.kernel.org/oe-kbuild-all/202305161712.5l3f4iI4-lkp@intel.com/
>>
>> <snip>
>>
>>> vim +276 drivers/platform/x86/apple-gmux.c
>>>
>>>   265    
>>>   266    static u32 gmux_mmio_read32(struct apple_gmux_data *gmux_data, int port)
>>>   267    {
>>>   268        u32 val;
>>>   269    
>>>   270        mutex_lock(&gmux_data->index_lock);
>>>   271        gmux_mmio_wait(gmux_data);
>>>   272        iowrite8((port & 0xff), gmux_data->iomem_base + GMUX_MMIO_PORT_SELECT);
>>>   273        iowrite8(GMUX_MMIO_READ | sizeof(val),
>>>   274            gmux_data->iomem_base + GMUX_MMIO_COMMAND_SEND);
>>>   275        gmux_mmio_wait(gmux_data);
>>>> 276        val = be32_to_cpu(ioread32(gmux_data->iomem_base));
>>
>> Ok, so sparse does not like this line.
>>
>>>   277        mutex_unlock(&gmux_data->index_lock);
>>>   278    
>>>   279        return val;
>>>   280    }
>>>   281    
>>>   282    static void gmux_mmio_write32(struct apple_gmux_data *gmux_data, int port,
>>>   283                       u32 val)
>>>   284    {
>>>   285        mutex_lock(&gmux_data->index_lock);
>>>> 286        iowrite32(cpu_to_be32(val), gmux_data->iomem_base);
>>
>> Nor this line. But this is what we want (convert to/from be32 to CPU
>> when reading/writing).
>>
>> There is iowrite32be() but that always unconditionally swabs
>> the byte order independent of the CPU byte-order.
>>
>> Now this is an x86 driver so always swapping is fine, still
>> I wonder if there is a better option here then using
>> iowrite32be() and ioread32be() ?
> 
> Thanks for finding those functions. I can't think of anything better unless there's a simple way to change sparse's rules so that it will be happy with code like this.

Ok, can you please submit a pathc to switch to iowrite32be() and
ioread32be() then (when you have time to work on this) ?

Regards,

Hans






>>>   287        iowrite8(port & 0xff, gmux_data->iomem_base + GMUX_MMIO_PORT_SELECT);
>>>   288        iowrite8(GMUX_MMIO_WRITE | sizeof(val),
>>>   289            gmux_data->iomem_base + GMUX_MMIO_COMMAND_SEND);
>>>   290        gmux_mmio_wait(gmux_data);
>>>   291        mutex_unlock(&gmux_data->index_lock);
>>>   292    }
>>>   293    
>>>
>>
> 

