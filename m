Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6341669AFCD
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 16:53:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbjBQPxZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 10:53:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjBQPxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 10:53:23 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81375642E6;
        Fri, 17 Feb 2023 07:53:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=ZKpEo6XyxNjGrbygeRi6rclueyeWPltBMlN3l7iEVYk=; b=vl4JGVHCOgh2loTZrAlDXOv3Xy
        Jv+kSDKIA1EXRAfD3b9Bexg2RmX82z13CjDTT4oSdFt1AXhNIrYNNE4ju/RmQ/p8pAUJg7/2QaeN2
        fUh4EE93ZlISLXsldx1pETPy7ueFiRFUBIu6Ctr3o51wThc+Am3ul+mjOupMxDOUwYGAHy48r7hZa
        lk9Dsr2g+AcpFw/+ublCfjUvXqIq4IyTueLwpi9fuLFQvTzP7zJWwkVrZ3h6qG61LaxFeQHZkmwMo
        MP2rw1PINQsn5upkaJEFttWi1wSIvRYsZ9q3WwyFHpSs53Tk8e+Tj40sBYvJBhlZbQ/6hM2EU4Drz
        vm47ickw==;
Received: from [2601:1c2:980:9ec0::df2f]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pT332-00EvNy-2W; Fri, 17 Feb 2023 15:53:20 +0000
Message-ID: <e68c3825-fc8a-d607-1afe-543a4537a81c@infradead.org>
Date:   Fri, 17 Feb 2023 07:53:17 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] module: fix MIPS module_layout -> module_memory
Content-Language: en-US
To:     =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     linux-kernel@vger.kernel.org, Song Liu <song@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-mips@vger.kernel.org
References: <20230214005400.17137-1-rdunlap@infradead.org>
 <59c0ba61-c5d6-b74f-0fbd-844b08d13e5d@linaro.org>
 <2e17b8f6-0c2d-e705-63b9-47077b442d68@infradead.org>
 <20230217115812.GB7701@alpha.franken.de>
 <1dac9eee-f0b9-a6f0-9fed-359242ccb02e@linaro.org>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <1dac9eee-f0b9-a6f0-9fed-359242ccb02e@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/17/23 04:35, Philippe Mathieu-Daudé wrote:
> On 17/2/23 12:58, Thomas Bogendoerfer wrote:
>> On Tue, Feb 14, 2023 at 08:52:04AM -0800, Randy Dunlap wrote:
>>>
>>>
>>> On 2/13/23 23:22, Philippe Mathieu-Daudé wrote:
>>>> Hi Randy,
>>>>
>>>> On 14/2/23 01:54, Randy Dunlap wrote:
>>>>> Correct the struct's field/member name from mod_mem to mem.
>>>>>
>>>>> Fixes this build error:
>>>>> ../arch/mips/kernel/vpe.c: In function 'vpe_elfload':
>>>>> ../arch/mips/kernel/vpe.c:643:41: error: 'struct module' has no member named 'mod_mem'
>>>>>     643 |         v->load_addr = alloc_progmem(mod.mod_mem[MOD_TEXT].size);
>>>>>
>>>>> Fixes: 2ece476a2346 ("module: replace module_layout with module_memory")
>>>>
>>>> On which tree is your patch based?
>>>
>>> linux-next-20230213.
>>
>> so I can't apply, because this is not in mips-next tree. It should be
>> applied to the tree, where this commit is coming from.
> 
> Or squashed...
> 

Sure, either one of those. I copied Song and Luis on the patch
and it begins with "module:".

@Song !??
@Luis !??

thanks.
-- 
~Randy
