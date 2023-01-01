Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93D6D65A8B8
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Jan 2023 04:21:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbjAADVs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 22:21:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjAADVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 22:21:47 -0500
Received: from mail.zytor.com (unknown [IPv6:2607:7c80:54:3::138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 197375FB9
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 19:21:46 -0800 (PST)
Received: from [IPV6:2601:646:8600:40c1:5967:deb4:a714:2940] ([IPv6:2601:646:8600:40c1:5967:deb4:a714:2940])
        (authenticated bits=0)
        by mail.zytor.com (8.17.1/8.17.1) with ESMTPSA id 3013LBSf1836735
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Sat, 31 Dec 2022 19:21:12 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 3013LBSf1836735
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2022120601; t=1672543276;
        bh=WIkcRuVq/el9XOhBRQxjh/z/c+yfDK8TbGXrc0PHyK4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Si3MsTlr5mcUVdVJbXSlyr5oh99MW38ld7tVuUbWL5uFjlZbVhvZgcaLeXhC7aVME
         OUKJS4T2Dr6Qgi1wPirnSFLL/3v/tiws+liRyOvrb9VBqjMHY1FdJWSRMidiEGYHU9
         KJNCyXYvvI774v1ZeYlvDueCrGuliB9kGen6zi7oMo7u/JhyDkcLfN9iMr1e7mAqqc
         yabwWShSSBxJF6WEbw7SQkmEeKEUwIC9sZ348BF7EATttaQv3pQPCrX2PRY376jh3e
         /pBZA4RGAWGUeb3OQrVEhgL58pu3R0oqiWkixYmq8OgbklXzfKTJYQKkK3QU/IWYZk
         1K31twN3b1lng==
Message-ID: <60566f8b-c90f-12e7-c13e-94e9829eee2d@zytor.com>
Date:   Sat, 31 Dec 2022 19:21:06 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH qemu] x86: don't let decompressed kernel image clobber
 setup_data
Content-Language: en-US
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
From:   "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <Y7CGzde+qPB7YJP4@zn.tnic>
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



On 12/31/22 11:00, Borislav Petkov wrote:
> On Sat, Dec 31, 2022 at 07:22:47PM +0100, Jason A. Donenfeld wrote:
>> So with that understanding confirmed, I'm confused at your surprise that
>> hpa's unrelated fix to the different issue didn't fix this issue.
> 
> No surprise there - I used a qemu variant without your patch to prevent the
> setup_data clobbering so hpa's fix can't help there.
> 
>> But since the kernel doesn't do this now, and the 62MiB bug also seems
>> to apply to existing kernels, for the purposes of QEMU for now, I think
>> the v3 patch is probably best, since it'll handle existing kernels.
> 
> Right, we can't fix all those guests which are out there.
> 
>> Alternatively, setup_data could be relocated, the boot param protocol
>> could be bumped, and then QEMU could conditionalized it's use of
>> setup_data based on that protocol version. That'd work, but seems a bit
>> more involved.
> 
> I think this is at least worth considering because the kernel overwriting
> setup_data after having been told where that setup_data is located is not really
> nice.
> 
> Well not explicitly at least - it gets the pointer to the first element and
> something needs to traverse that list to know which addresses are live. But
> still, that info is there so perhaps we need to take setup_data into
> consideration too before decompressing...
> 

As far as the decompression itself goes, it should only a problem if we 
are using physical KASLR since otherwise the kernel has a guaranteed 
safe zone already allocated by the boot loader. However, if physical 
KASLR is in use, then the decompressor needs to know everything there is 
to know about the memory map.

However, there also seems to be some kind of interaction with AMD SEV-SNP.


The bug appears to have been introduced by:

b57feed2cc2622ae14b2fa62f19e973e5e0a60cf
x86/compressed/64: Add identity mappings for setup_data entries
https://lore.kernel.org/r/TYCPR01MB694815CD815E98945F63C99183B49@TYCPR01MB6948.jpnprd01.prod.outlook.com

... which was included in version 5.19, so it is relatively recent.

For a small amount of setup_data, the solution of just putting it next 
to the command line makes a lot of sense, and should be safe indefinitely.

	-hpa
