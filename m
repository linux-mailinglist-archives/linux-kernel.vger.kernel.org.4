Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D29772EA6D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 20:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240069AbjFMSB0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 14:01:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240031AbjFMSBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 14:01:23 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 223B213E;
        Tue, 13 Jun 2023 11:01:23 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1b3d44e3d1cso19375515ad.0;
        Tue, 13 Jun 2023 11:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686679282; x=1689271282;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=T/a3r5sKbhzcbRyUYdob5Nl5dKbRVOL3UiqhaaSpST4=;
        b=B6nGrki7dC4POqaR5IBxM33VDnBBh6hQssOvi3oTmV1FtbtGlyf/oH/GrKPfyyMN39
         DysgEThI0bkvujQPvKr3Rk0cwrbhwQ1MgnyA8JmeLHOqK/RXVqucEmohMBUbNvKO6kOC
         XZ3vgysp+C/iWYuS1c8FqYgeDBeHqeF2kvmcFZmAhZbDeKR92VNlB7htxTP6VM6V3GpN
         wZIlREJxiAudVkeXHYz6hglcTFPIyT1Kgcj9sPYD9FFDgGjrsAoemGeT81K4JEBexbcT
         YIz4I8QAmbZn7HcOYtXXTiz9Ew7co96YRYqpZqucUV9Enp0c9xvihLKkHjcIbxXDyP0N
         k5PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686679282; x=1689271282;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T/a3r5sKbhzcbRyUYdob5Nl5dKbRVOL3UiqhaaSpST4=;
        b=eWv4k5NyWl/cVUnoWJF4Si6GlxtUy5Ol4FXBn0ozyfemUzOhCxSkc7jtL58qS6UV6P
         7s9LXEbiMALXHf+84vABIxvdtRH3B4msBm4RkXYBensPatjNfAtUOBNHfOxWDuqfcvH0
         CSrwi6vNPZ5k+aBF5BoAYABuUEmuU3GYIANKixXB0faFpzhb3wxP6vCs5cawlqbxOPEj
         O0u/4xKxXb/i9Qmf8C7BWy7RzQxA7/laQRmj3H2z8pfcVYTwkwJbkCV8bHa8Q4TT9ciP
         jVu3/UbJEDGvKaxCkH6XoY8xewuUXQILcgcSvJJBviDRACvgSOSWZ6V5iMY4//PRponM
         Uz0g==
X-Gm-Message-State: AC+VfDzai0WiRSJaPLz8W+W48+GOzWN+ffK/B4hEC1Wxu2jPtT3K34/5
        Pv/2IVnuM98CQqYh8q2wI0A=
X-Google-Smtp-Source: ACHHUZ4nDCJfmPpznJna2xSkhH384iiKUB8svBrHAmcq/f5IuT5ldnsId6M4h29uvNbu8gE2E0MgPw==
X-Received: by 2002:a17:902:e752:b0:1b0:6038:2982 with SMTP id p18-20020a170902e75200b001b060382982mr12451026plf.41.1686679282498;
        Tue, 13 Jun 2023 11:01:22 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k5-20020a170902ba8500b001ae5fe602c3sm10546479pls.159.2023.06.13.11.01.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jun 2023 11:01:21 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <0a725f74-d077-8556-6e55-25f55dfc95ff@roeck-us.net>
Date:   Tue, 13 Jun 2023 11:01:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 5.10 00/68] 5.10.184-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de
References: <20230612101658.437327280@linuxfoundation.org>
 <ab4e5232-ccc4-144a-cb72-2a0cce825f31@roeck-us.net>
 <2023061300-cardstock-buckshot-0ccc@gregkh>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <2023061300-cardstock-buckshot-0ccc@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/13/23 10:36, Greg Kroah-Hartman wrote:
> On Tue, Jun 13, 2023 at 09:35:37AM -0700, Guenter Roeck wrote:
>> On 6/12/23 03:25, Greg Kroah-Hartman wrote:
>>> This is the start of the stable review cycle for the 5.10.184 release.
>>> There are 68 patches in this series, all will be posted as a response
>>> to this one.  If anyone has any issues with these being applied, please
>>> let me know.
>>>
>>> Responses should be made by Wed, 14 Jun 2023 10:16:41 +0000.
>>> Anything received after that time might be too late.
>>>
>>
>> Am I the only one seeing this problem ?
>>
>> Build reference: v5.10.183-69-g32cae866b182
>> Compiler version: x86_64-linux-gcc (GCC) 11.3.0
>> Assembler version: GNU assembler (GNU Binutils) 2.39
>>
>> Building x86_64:allyesconfig ... failed
>> --------------
>> Error log:
>> x86_64-linux-objcopy: vmlinux: unsupported relocation type 0x44
>> x86_64-linux-objcopy: vmlinux[.text]: relocation count is negative: bad value
>> make[3]: *** [arch/x86/boot/compressed/Makefile:114: arch/x86/boot/compressed/vmlinux.bin] Error 1
>> make[3]: *** Waiting for unfinished jobs....
>> Unsupported relocation type: unknown type rel type name (-1939958716)
>> make[3]: *** [arch/x86/boot/compressed/Makefile:122: arch/x86/boot/compressed/vmlinux.relocs] Error 1
>> make[3]: *** Deleting file 'arch/x86/boot/compressed/vmlinux.relocs'
>> make[2]: *** [arch/x86/boot/Makefile:115: arch/x86/boot/compressed/vmlinux] Error 2
>> make[1]: *** [arch/x86/Makefile:274: bzImage] Error 2
>> make: *** [Makefile:192: __sub-make] Error 2
>>
>> It affects 5.4.y and 5.10.y for me.
> 
> Odd.  Let me go build with gcc-11, I have just moved to gcc-12 on those
> two branches locally...
> 

Don't bother. This seems to be related to my build environment, not to the kernel.
Rebuilding passed on different servers. It may have to do with my recent update
to Ubuntu 22.04 on the server experiencing the problem. I'll try to figure out
what is going on.  Sorry for the noise.

Guenter

