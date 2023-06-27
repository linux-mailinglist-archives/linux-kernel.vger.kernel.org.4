Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A964C7401C8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 18:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbjF0Q5x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 12:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbjF0Q5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 12:57:50 -0400
Received: from mail.genode-labs.com (mail.genode-labs.com [94.130.141.206])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D774E10E7
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 09:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=genode-labs.com; s=2018-03; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:Subject:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=QZSD4OeyJjzUSAVsIghToG5ou0EbCOGlffCslfIitnY=; b=sTlGFP6JM5lRAi8/OXevQ6u9GN
        nXYh9X83YZwOwHRoe9baRFUjmEpHXEG7iB1rDyClsOoBQ8H/U+pWiLiC1aURgR4Okz/HNnohyZK/Y
        4Yn/wtddst3vK2787o7sLRiZrLRAd3atye34kq8cLbQPmBv4FnjY4LiDByi2Zm9feMl2gwzMXjSdn
        XNeZJwu5NoVKwkqlecp55/d2xT7cw8P9aEhMnPUpZbJmLeP3Ih1gKM0feG7eXloB9xoxNvh/2rjsH
        BQ1Zbp8J4PKz4iSayn3Czb/WTD7zWQemHVSLyDBBqot1XgCNPPeNr/54tmjY0iLQ0JFdm0wUVJAxT
        WryFA9YQ==;
Received: by mail.genode-labs.com (Exim 4.95-1-g73e85c617) with esmtpsa (TLS1.3:TLS_AES_128_GCM_SHA256:128)
        (envelope-from <Sebastian.Sumpf@genode-labs.com>)
        id 1qEC0S-008yrS-N5 ;
        Tue, 27 Jun 2023 18:57:33 +0200
Message-ID: <7738ff3a-3f5a-2583-93f7-458425fd84a5@genode-labs.com>
Date:   Tue, 27 Jun 2023 18:57:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
To:     Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@intel.com>,
        Richard Weinberger <richard@nod.at>
Cc:     tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
References: <cb18590f-686e-cc53-7781-1a36e91faade@genode-labs.com>
 <20230626210604.GLZJn9vA3gcMAuy/eP@fat_crate.local>
 <ce1cc0a5-3393-d16f-eaaf-5e7149d5164f@genode-labs.com>
 <02b36386-a18c-8bfb-2c70-c398f6fc964b@intel.com>
 <20230627042538.GAZJpkwldpkqTKeeDL@fat_crate.local>
Content-Language: en-US
From:   Sebastian Sumpf <Sebastian.Sumpf@genode-labs.com>
Subject: Re: [Bug report] __arch_hweight32/64 x86
In-Reply-To: <20230627042538.GAZJpkwldpkqTKeeDL@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/27/23 06:25, Borislav Petkov wrote:
> On Mon, Jun 26, 2023 at 03:41:27PM -0700, Dave Hansen wrote:
>> I'm not even sure that UML needs GENERIC_HWEIGHT.  From a quick glance,
>> it looks like x86 used to use GENERIC_HWEIGHT, but got arch-specific
>> versions later.  UML just never moved over to the arch-specific versions.
> 
> Thanks - that could very well be the explanation.
> 
> That bug report made me blink a couple of times since I did take extra
> precaution to not clobber regs in arch/x86/lib/hweight.S as this was
> part of the whole pain back then with calling a function from asm where
> gcc doesn't even know we're calling a function, see:
> 
> f5967101e9de ("x86/hweight: Get rid of the special calling convention")
> 
>> I _think_ the attached patch might just fix the problems with the C
>> version and bring the x86/UML implementation back in line with the rest
>> of x86.
>>
>> Thoughts?
> 
>> diff --git a/arch/x86/um/Kconfig b/arch/x86/um/Kconfig
>> index 186f13268401..76d507860be4 100644
>> --- a/arch/x86/um/Kconfig
>> +++ b/arch/x86/um/Kconfig
>> @@ -44,6 +44,3 @@ config ARCH_HAS_SC_SIGNALS
>>   
>>   config ARCH_REUSE_HOST_VSYSCALL_AREA
>>   	def_bool !64BIT
>> -
>> -config GENERIC_HWEIGHT
>> -	def_bool y
> 
> Yeah, we should do it. UML should not do anything different wrt calling
> conventions so it should be able to handle the arch/x86/lib/hweight.S
> versions just fine.

Thank you for the quick resolution! It fixes the problem for me and sorry for 
not explaining well enough.

> Richi?
> 

-- 
Sebastian Sumpf
Genode Labs

http://www.genode-labs.com · http://genode.org

Genode Labs GmbH · Amtsgericht Dresden · HRB 28424 · Sitz Dresden
Geschäftsführer: Dr.-Ing. Norman Feske, Christian Helmuth




