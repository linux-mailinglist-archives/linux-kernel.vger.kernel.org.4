Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1493973ED02
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 23:43:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbjFZVnG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 17:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbjFZVnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 17:43:03 -0400
Received: from mail.genode-labs.com (mail.genode-labs.com [94.130.141.206])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E1BF10DA
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 14:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=genode-labs.com; s=2018-03; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:Subject:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=pJX39uXX0SJ0gooiznRcZ9v63lMUS6cJu6HT3REilk8=; b=MPufJopnKkteaQvOlCgUcexnGM
        8wBYFXiW8tuMRrkmC4tCIwKiYnpmQvzZ6R+kvayCJV9YtT1OX/7VvhRCp8FGm+uqPvkrz94YwBLve
        EFzegKKkNm3FGjbs2gID0Inq8Aam/XMtCxBMFH2KmBXF8he3p8CrzlrVa6IEO72rV9cynxgheOKb5
        BDrtGiqPcLHAmI+WSMwtqHwf+x+hsC5NWQAeDbM54o9y67NK9wBLJiK/BzOfrQbxngnSYJjOHRYy/
        av8gk0g+DtUf7KTPkQ7sWiKWAgYHIN6SthpUjT0/COQkId4MIOE3qszWRKrTbu8m3qytf4t7JsTD7
        AHPyL+Kw==;
Received: by mail.genode-labs.com (Exim 4.95-1-g73e85c617) with esmtpsa (TLS1.3:TLS_AES_128_GCM_SHA256:128)
        (envelope-from <Sebastian.Sumpf@genode-labs.com>)
        id 1qDtz1-008qYV-Sn ;
        Mon, 26 Jun 2023 23:42:52 +0200
Message-ID: <ce1cc0a5-3393-d16f-eaaf-5e7149d5164f@genode-labs.com>
Date:   Mon, 26 Jun 2023 23:42:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
References: <cb18590f-686e-cc53-7781-1a36e91faade@genode-labs.com>
 <20230626210604.GLZJn9vA3gcMAuy/eP@fat_crate.local>
From:   Sebastian Sumpf <Sebastian.Sumpf@genode-labs.com>
Subject: Re: [Bug report] __arch_hweight32/64 x86
In-Reply-To: <20230626210604.GLZJn9vA3gcMAuy/eP@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Borislav,

On 6/26/23 23:06, Borislav Petkov wrote:
> Hello,
> 
> On Mon, Jun 26, 2023 at 10:49:44PM +0200, Sebastian Sumpf wrote:
>> The 'ALTERNATIVE' macro checks for the popcnt feature. In case this fails
>> the '__sw_hweight' C-function is called from inline assembly with rax and
>> rdi as intput/output operands. However, the code does not contain a clobber
>> list of any callee safe registers that might be touched by the
>> '__sw_height64' C-function.

>> Which registers are those? Can you be more specific?

Registers that are free to use by a called C-function are: rcx, rdx, rsi, rdi, 
and r8-r11 for x86_64. See the "System V Application Binary Interface
AMD64 Architecture Processor Supplement" [1] page 21. x86_32 I would have to 
look up.


>> Therefore, these registers will not be restored
>> upon function return by the compiler. This leads to varying
>> exceptions/bad behavior caused by the thus corrupted registers later
>> on.
> 
> How do I reproduce what you're observing so that I can take a look?

This is hard to tell, I would disable the " X86_FEATURE_POPCNT" feature and use 
the ' CONFIG_ARCH_HAS_FAST_MULTIPLIER' option in order to use the multiplier 
implementation in '__sw_hweight64' in 'lib/hweight.c' At least that is what 
triggered it here.

Regards,

Sebastian

[1] http://www.uclibc.org/docs/psABI-x86_64.pdf

-- 
Sebastian Sumpf
Genode Labs

http://www.genode-labs.com · http://genode.org

Genode Labs GmbH · Amtsgericht Dresden · HRB 28424 · Sitz Dresden
Geschäftsführer: Dr.-Ing. Norman Feske, Christian Helmuth




