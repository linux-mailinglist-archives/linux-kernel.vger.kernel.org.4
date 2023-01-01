Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E317265A8D7
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Jan 2023 05:34:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231411AbjAAEeY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 23:34:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjAAEeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 23:34:22 -0500
Received: from mail.zytor.com (unknown [IPv6:2607:7c80:54:3::138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45BEC6375
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 20:34:21 -0800 (PST)
Received: from [IPV6:2601:646:8600:40c1:5967:deb4:a714:2940] ([IPv6:2601:646:8600:40c1:5967:deb4:a714:2940])
        (authenticated bits=0)
        by mail.zytor.com (8.17.1/8.17.1) with ESMTPSA id 3014Y4Ss1855911
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Sat, 31 Dec 2022 20:34:05 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 3014Y4Ss1855911
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2022120601; t=1672547646;
        bh=VpwZJfHjUoFCQG04147cJw1T6GjsP7kTmWFVBOMEzis=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=FBj19I80P/nTqvFwmpAMVESYgiNL+uPue00zX9GK6uE6lH5ZLMxKP/u7h+zU9c9U+
         VL6mDEnllaUrwWJ+/eWcXib16lPgJGsegWLNVsWJ+6KYPOtK4kRWSji4CUFB7dLBwX
         3SF2nN7UCuGWX6uRVA+UvjgK9e7HXG/N9RzHx1ng6ut2LrXIIzBYbSoA2HL9St6Fh0
         JFj+rWaRfUMF7n/iqo0td/ab6vDdojuMsR15IrAIyOq7Y5PjwYRe8W//TaTWYUNDWg
         DtBOQ6EZxPVwj4Aqzrvw4PM8SD9Osy5sN7Gk/4TCOPEBS974Lbevdhp6QOHyFyeBYe
         SswuztX9dAvkA==
Message-ID: <24908710-09f6-da2a-d821-58a81c572f6c@zytor.com>
Date:   Sat, 31 Dec 2022 20:33:59 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH qemu] x86: don't let decompressed kernel image clobber
 setup_data
Content-Language: en-US
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Borislav Petkov <bp@alien8.de>
Cc:     pbonzini@redhat.com, ebiggers@kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, qemu-devel@nongnu.org,
        ardb@kernel.org, kraxel@redhat.com, philmd@linaro.org
References: <CAHmME9oPUJemVRvO3HX0q4BJGTFuzbLYANeizuRcNq2=Ykk1Gg@mail.gmail.com>
 <Y69B40T9kWfxZpmf@zn.tnic> <E5D0A77E-5ABC-4978-9A66-37B60DA43869@zytor.com>
 <Y69h6ur79SMhu61F@zx2c4.com> <46466e54-25c3-3194-8546-a57cd4a80d9d@zytor.com>
 <Y7A76+IBS4fnucrW@zn.tnic> <Y7A8qP05B0YRbQIN@zx2c4.com>
 <Y7A9nBud6UeH+wYd@zn.tnic> <Y7A+YELM7m5E2PUQ@zx2c4.com>
 <Y7BGIAL4z6o6FEI5@zn.tnic> <Y7B993P1+jYB/etX@zx2c4.com>
From:   "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <Y7B993P1+jYB/etX@zx2c4.com>
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



On 12/31/22 10:22, Jason A. Donenfeld wrote:
> On Sat, Dec 31, 2022 at 03:24:32PM +0100, Borislav Petkov wrote:
>> On Sat, Dec 31, 2022 at 02:51:28PM +0100, Jason A. Donenfeld wrote:
>>> That failure is unrelated to the ident mapping issue Peter and
>>> I discussed. The original failure is described in the commit message:
>>> decompression clobbers the data, so sd->next points to garbage.
>>
>> Right
> 
> So with that understanding confirmed, I'm confused at your surprise that
> hpa's unrelated fix to the different issue didn't fix this issue.
> 

If decompression does clobber the data, then we *also* need to figure 
out why that is. There are basically three possibilities:

1. If physical KASLR is NOT used:

	a. The boot loader doesn't honor the kernel safe area properly;
	b. Somewhere in the process a bug in the calculation of the
	   kernel safe area has crept in.

2. If physical KASLR IS used:

	The decompressor doesn't correctly keep track of nor relocate
	all the keep-out zones before picking a target address.

One is a bootloader bug, two is a kernel bug. My guess is (2) is the 
culprit, but (1b) should be checked, too.

	-hpa

