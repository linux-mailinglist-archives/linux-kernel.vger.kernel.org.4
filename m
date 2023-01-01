Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C3EF65A8BB
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Jan 2023 04:32:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbjAADbq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 22:31:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjAADbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 22:31:44 -0500
Received: from mail.zytor.com (unknown [IPv6:2607:7c80:54:3::138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61BD060FF
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 19:31:43 -0800 (PST)
Received: from [IPV6:2601:646:8600:40c1:5967:deb4:a714:2940] ([IPv6:2601:646:8600:40c1:5967:deb4:a714:2940])
        (authenticated bits=0)
        by mail.zytor.com (8.17.1/8.17.1) with ESMTPSA id 3013VRi51840087
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Sat, 31 Dec 2022 19:31:27 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 3013VRi51840087
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2022120601; t=1672543888;
        bh=lR+4TdzkHpeKvvcDRlvTiBP6ffmLVC1yR5HIRaZiqGE=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=Mh39Voc1zeiiz6SOGBH3JBhx9oNvq1G3lb/EXlf0xoCPJ3JFx8l/Dpo3DCSoj07Qu
         N9o1IdNgkdKjgGEK0FOSI3O9PyGhgO4kwjkAwfq25pt6KnWzj5JQOhJJW0h//RqMW0
         TZNUT+hron3KS8trGua3eVH6f9MdQtSK8eqJAn7bJIMmleex0ypXv+ZgNA4oAwZjbz
         dwd0po5z8y5fDUNErsoqxnyjeNto2+2MHq5HMILOwYcYD1OXDnq/PeFv3FzLPTfAm3
         4oMW161e9MGX36vM3LSQ7OS2GsTUy5NZYRcDAfXXIRnQgyWyfYhPyF0Aq18AjZ2Cla
         GE4rmoGuBr3qQ==
Message-ID: <8f072588-7d66-0932-7486-ed9159ae93ae@zytor.com>
Date:   Sat, 31 Dec 2022 19:31:21 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH qemu] x86: don't let decompressed kernel image clobber
 setup_data
Content-Language: en-US
From:   "H. Peter Anvin" <hpa@zytor.com>
To:     Borislav Petkov <bp@alien8.de>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     pbonzini@redhat.com, ebiggers@kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, qemu-devel@nongnu.org,
        ardb@kernel.org, kraxel@redhat.com, philmd@linaro.org
References: <Y69B40T9kWfxZpmf@zn.tnic>
 <E5D0A77E-5ABC-4978-9A66-37B60DA43869@zytor.com> <Y69h6ur79SMhu61F@zx2c4.com>
 <46466e54-25c3-3194-8546-a57cd4a80d9d@zytor.com> <Y7A76+IBS4fnucrW@zn.tnic>
 <Y7A8qP05B0YRbQIN@zx2c4.com> <Y7A9nBud6UeH+wYd@zn.tnic>
 <Y7A+YELM7m5E2PUQ@zx2c4.com> <Y7BGIAL4z6o6FEI5@zn.tnic>
 <Y7B993P1+jYB/etX@zx2c4.com> <Y7CGzde+qPB7YJP4@zn.tnic>
 <60566f8b-c90f-12e7-c13e-94e9829eee2d@zytor.com>
In-Reply-To: <60566f8b-c90f-12e7-c13e-94e9829eee2d@zytor.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RDNS_NONE,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/31/22 19:21, H. Peter Anvin wrote:
>>
>>> Alternatively, setup_data could be relocated, the boot param protocol
>>> could be bumped, and then QEMU could conditionalized it's use of
>>> setup_data based on that protocol version. That'd work, but seems a bit
>>> more involved.
>>
>> I think this is at least worth considering because the kernel overwriting
>> setup_data after having been told where that setup_data is located is 
>> not really
>> nice.
>>
>> Well not explicitly at least - it gets the pointer to the first 
>> element and
>> something needs to traverse that list to know which addresses are 
>> live. But
>> still, that info is there so perhaps we need to take setup_data into
>> consideration too before decompressing...
>>

It would probably be a good idea to add a "maximum physical address for 
initrd/setup_data/cmdline" field to struct kernel_info, though. It 
appears right now that those fields are being identity-mapped in the 
decompressor, and that means that if 48-bit addressing is used, physical 
memory may extend past the addressable range.

	-hpa

