Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B572274E0E7
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 00:15:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbjGJWPr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 18:15:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjGJWPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 18:15:46 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C66C5186;
        Mon, 10 Jul 2023 15:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=/20lzeATL6XNAUoXPVIsEpJavXLnPumR9witgHW8cpI=; b=fl5lXArkWvd6LHDrrNuNKxgwQb
        cEvuKAVfS0v3Zirc55kkO3ZYEQ7b1k+ZTPzCapO4nXOPD3mvttpGdwsYKrkGCWfN54MCWH2FO1sYZ
        qU+629htHGyC96MTgoa2Wro/QYDjqvLXLcwjF22QojArphXNPSvKWaarc1T9YhGHXUxZpKH0EgLX/
        lVua1VNyPMQY5tMXgXItt0lGw+XcZHqwRNLLllyMpKjrMRTQSRi89uhHIdZ+tx6MYv9GdAEyAgQYA
        WjUZA67W4ERd6ukmgn3IyFKwZoOMrJUzJEInDBRXSPEA8wiLHkhB2uN1PDy7GfF8/eBLU3wRHMNKq
        kHbhUSzw==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qIzA5-00Cpu8-2O;
        Mon, 10 Jul 2023 22:15:19 +0000
Message-ID: <5311ed1b-ab09-6e9c-4ca6-061fe0201de6@infradead.org>
Date:   Mon, 10 Jul 2023 15:15:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: linux-next: Tree for Jul 10
 (arch/s390/kernel/machine_kexec_file.c)
Content-Language: en-US
To:     Eric DeVolder <eric.devolder@oracle.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20230710113814.4a4916cf@canb.auug.org.au>
 <9536c8ca-a0f2-c4be-d705-2ac1054ebf7d@infradead.org>
 <8a848504-6e4c-ba7a-4777-3175c1fdc6d7@oracle.com>
 <903448cf-b333-cb75-87e2-4bee8d1d915e@oracle.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <903448cf-b333-cb75-87e2-4bee8d1d915e@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/10/23 14:27, Eric DeVolder wrote:
> 
> 
> On 7/10/23 15:23, Eric DeVolder wrote:
>>
>>
>> On 7/10/23 15:11, Randy Dunlap wrote:
>>>
>>>
>>> On 7/9/23 18:38, Stephen Rothwell wrote:
>>>> Hi all,
>>>>
>>>> Changes since 20230707:
>>>>
>>>
>>> on s390:
>>>
>>> ../arch/s390/kernel/machine_kexec_file.c: In function 's390_verify_sig':
>>> ../arch/s390/kernel/machine_kexec_file.c:69:15: error: implicit declaration of function 'verify_pkcs7_signature' [-Werror=implicit-function-declaration]
>>>     69 |         ret = verify_pkcs7_signature(kernel, kernel_len,
>>>        |               ^~~~~~~~~~~~~~~~~~~~~~
>>> cc1: some warnings being treated as errors
>>>
>>>
>>> Full randconfig file is attached.
>>>
>>
>> Randy,
>> Thanks for this. This appears to be randconfig testing against linux-next.
>> As of right now, linux-next does not contain the v5 that I posted friday.
>> The v5 posted friday was picked up by Andrew and over the weekend no fails
>> discovered, and the series currently sits in mm-everything branch. So hopefully
>> it will appear soon in linux-next!
>>
>> Let me know if I misunderstand the situation.
>> Thanks!
>> eric
> 
> Well the root cause is a missing SYSTEM_DATA_VERIFICATION. This was discussed
> through MODULE_SIG_FORMAT thread. I don't think v5 changed anything with
> respect to this issue, so it will likely reveal itself again.
> 
> Since it was agreed to drop MODULE_SIG_FORMAT, and my attempt to select
> SYSTEM_DATA_VERIFICATION results in same circular dependency as with
> MODULE_SIG_FORMAT, I'm unsure how to proceed.
> 
> The arch/s390/Kconfig S390 option has a 'select KEXEC' (but not KEXEC_FILE),
> maybe we consider adding a 'select SYSTEM_DATA_VERIFICATION' as well?

Sure, since some other configs select it also.
And as long as it doesn't cause a circular dependency problem.

thanks.
-- 
~Randy
