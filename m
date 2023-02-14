Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC3CB696A5E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 17:52:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232651AbjBNQwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 11:52:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbjBNQwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 11:52:33 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20CAD2D141;
        Tue, 14 Feb 2023 08:52:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=agNXxSvgHeipQocwNTjMKFzMaSrH58IPKqeehvfo9CA=; b=MKZroS1EsP8KPZyhQMaHp8HDuH
        W3DcMOgVq3jUQOsQYl2b7zlAGH1pc9YKseSkGqtCp+Bz5g4VUcxyDqLkQMDKAQZ6UBHDJ3l5vYdRO
        HMNO3rCPGskmRp9DOhchSSb6sN50OwJMLAfSzHckRVOQ0AhjllU9+DEGS815SXriKaCd+sdQfsQzh
        wlTachyk2axTdjLPlbjH9VTvrGQq8gGW8emYPKHY3hFKzTKZhIAWKnCLkev5sXVA6sxgg1Hy+pH/b
        i2lax/AslqrYgUwsbFlIuef8pDLeBlLSCbolvurU4wDI3XLT1qv6pkEiqkEtT95FCUXhAfsDVNuRN
        0VnwFBOA==;
Received: from [2601:1c2:980:9ec0::df2f]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pRyXE-002uGl-MU; Tue, 14 Feb 2023 16:52:04 +0000
Message-ID: <2e17b8f6-0c2d-e705-63b9-47077b442d68@infradead.org>
Date:   Tue, 14 Feb 2023 08:52:04 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] module: fix MIPS module_layout -> module_memory
Content-Language: en-US
To:     =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
        linux-kernel@vger.kernel.org
Cc:     Song Liu <song@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org
References: <20230214005400.17137-1-rdunlap@infradead.org>
 <59c0ba61-c5d6-b74f-0fbd-844b08d13e5d@linaro.org>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <59c0ba61-c5d6-b74f-0fbd-844b08d13e5d@linaro.org>
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



On 2/13/23 23:22, Philippe Mathieu-Daudé wrote:
> Hi Randy,
> 
> On 14/2/23 01:54, Randy Dunlap wrote:
>> Correct the struct's field/member name from mod_mem to mem.
>>
>> Fixes this build error:
>> ../arch/mips/kernel/vpe.c: In function 'vpe_elfload':
>> ../arch/mips/kernel/vpe.c:643:41: error: 'struct module' has no member named 'mod_mem'
>>    643 |         v->load_addr = alloc_progmem(mod.mod_mem[MOD_TEXT].size);
>>
>> Fixes: 2ece476a2346 ("module: replace module_layout with module_memory")
> 
> On which tree is your patch based?

linux-next-20230213.

> fatal: ambiguous argument '2ece476a2346': unknown revision or path not in the working tree.
> 
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Cc: Song Liu <song@kernel.org>
>> Cc: Luis Chamberlain <mcgrof@kernel.org>
>> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
>> Cc: linux-mips@vger.kernel.org
>> ---
>> Has this already been fixed?
>>
>>   arch/mips/kernel/vpe.c |    2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff -- a/arch/mips/kernel/vpe.c b/arch/mips/kernel/vpe.c
>> --- a/arch/mips/kernel/vpe.c
>> +++ b/arch/mips/kernel/vpe.c
>> @@ -640,7 +640,7 @@ static int vpe_elfload(struct vpe *v)
>>           layout_sections(&mod, hdr, sechdrs, secstrings);
>>       }
>>   -    v->load_addr = alloc_progmem(mod.mod_mem[MOD_TEXT].size);
>> +    v->load_addr = alloc_progmem(mod.mem[MOD_TEXT].size);
>>       if (!v->load_addr)
>>           return -ENOMEM;
>>   
> 

-- 
~Randy
