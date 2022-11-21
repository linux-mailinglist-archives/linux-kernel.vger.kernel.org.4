Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C20C4632A2F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 18:02:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbiKURCq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 12:02:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbiKURCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 12:02:45 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 269A410045;
        Mon, 21 Nov 2022 09:02:42 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 74C2B220D3;
        Mon, 21 Nov 2022 17:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1669050160; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=waH8qi7rSOq7I4vWunq+Hx7MA0/6o23u8Uhy7medoKs=;
        b=M3t81rO8cMELjgUY3Pdvd3u12xeF18kly28iM45Jh2xBoA0q2rqwb0X1LTQJ7XKitDOpmg
        C7kIz1ftFw/3KzsErpk7pinZ8z5Ecv924W6QC4bxFzdhwCNayzo79WGuPIOHQ5GuHtijlT
        cZfAnna+18wBK9/wokB1Iwkp2Ft+kzg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1669050160;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=waH8qi7rSOq7I4vWunq+Hx7MA0/6o23u8Uhy7medoKs=;
        b=tyZD79BhpWMMOi79km59eEyhlhrTkn1DIB8dMHZeEyXRwr6a+tN9XlBAvcIgXaWLoiX7dC
        n3OtrqDkpmh6CiAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E13501377F;
        Mon, 21 Nov 2022 17:02:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Slg/Ni+ve2OJdAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 21 Nov 2022 17:02:39 +0000
Message-ID: <e7861283-4280-7019-126c-cf56b89c37e7@suse.cz>
Date:   Mon, 21 Nov 2022 18:02:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: Deprecating and removing SLOB
Content-Language: en-US
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     Conor Dooley <conor@kernel.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Pekka Enberg <penberg@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Rustam Kovhaev <rkovhaev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Alexander Shiyan <shc_work@mail.ru>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        openrisc@lists.librecores.org, linux-riscv@lists.infradead.org,
        linux-sh@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Conor.Dooley@microchip.com, Paul Cercueil <paul@crapouillou.net>
References: <b35c3f82-f67b-2103-7d82-7a7ba7521439@suse.cz>
 <CA+CK2bD-uVGJ0=9uc7Lt5zwY+2PM2RTcfOhxEd65S7TvTrJULA@mail.gmail.com>
 <c1caa5ce-eeaf-8038-2dea-051c98aade45@suse.cz> <Y260tkNHc2vFITJ3@spud>
 <a5bba3ca-da19-293c-c01b-a28291533466@opensource.wdc.com>
 <93079aba-362e-5d1e-e9b4-dfe3a84da750@opensource.wdc.com>
 <44da078c-b630-a249-bf50-67df83cd8347@suse.cz>
 <35650fd4-3152-56db-7c27-b9997e31cfc7@opensource.wdc.com>
 <Y3JU5cfyid1rBoOy@hyeyoo>
 <97c0735c-3127-83d5-30ff-8e57c6634f6e@opensource.wdc.com>
 <452c3833-9275-37c7-3d48-5c996c0e2557@suse.cz>
 <6a1883c4-4c3f-545a-90e8-2cd805bcf4ae@opensource.wdc.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <6a1883c4-4c3f-545a-90e8-2cd805bcf4ae@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/21/22 05:30, Damien Le Moal wrote:
> On 11/17/22 02:51, Vlastimil Babka wrote:
>> On 11/15/22 05:24, Damien Le Moal wrote:
>>> On 11/14/22 23:47, Hyeonggon Yoo wrote:
>>>> On Mon, Nov 14, 2022 at 08:35:31PM +0900, Damien Le Moal wrote:
>>>
>>> Test notes: I used Linus 6.1-rc5 as the base. That is the only thing I
>>> changed in buildroot default config for the sipeed maix bit card, booting
>>> with SD card. The test is: booting and run "cat /proc/vmstat" and register
>>> the nr_free_pages value. I repeated the boot + cat 3 to 4 times for each case.
>>>
>>> Here are the results:
>>>
>>> 6.1-rc5, SLOB:
>>>     - 623 free pages
>>>     - 629 free pages
>>>     - 629 free pages
>>> 6.1-rc5, SLUB:
>>>     - 448 free pages
>>>     - 448 free pages
>>>     - 429 free pages
>>> 6.1-rc5, SLUB + slub_max_order=0:
>>>     - Init error, shell prompt but no shell command working
>>>     - Init error, no shell prompt
>>>     - 508 free pages
>>>     - Init error, shell prompt but no shell command working
>>> 6.1-rc5, SLUB + patch:
>>>     - Init error, shell prompt but no shell command working
>>>     - 433 free pages
>>>     - 448 free pages
>>>     - 423 free pages
>>> 6.1-rc5, SLUB + slub_max_order=0 + patch:
>>>     - Init error, no shell prompt
>>>     - Init error, shell prompt, 499 free pages
>>>     - Init error, shell prompt but no shell command working
>>>     - Init error, no shell prompt
>>>
>>> No changes for SLOB results, expected.
>>>
>>> For default SLUB, I did get all clean boots this time and could run the
>>> cat command. But I do see shell fork failures if I keep running commands.
>>>
>>> For SLUB + slub_max_order=0, I only got one clean boot with 508 free
>>> pages. Remaining runs failed to give a shell prompt or allow running cat
>>> command. For the clean boot, I do see higher number of free pages.
>>>
>>> SLUB with the patch was nearly identical to SLUB without the patch.
>>>
>>> And SLUB+patch+slub_max_order=0 gave again a lot of errors/bad boot. I
>>> could run the cat command only once, giving 499 free pages, so better than
>>> regular SLUB. But it seems that the memory is more fragmented as
>>> allocations fail more often.
>>>
>>> Hope this helps. Let me know if you want to test something else.
>> 
>> Could you please try this branch with CONFIG_SLUB_TINY=y?
>> https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/linux.git/log/?h=slub-tiny-v1r0
>> 
>> Seeing your results I didn't modify default slub_max_order by this new
>> CONFIG (yet?) so maybe after trying the default, trying then also with
>> manual slub_max_order=0 and slub_max_order=1 would be useful too. Otherwise
>> it should be all changes to lower SLUB memory footprint. Hopefully it will
>> be visible in the number of free pages. But if fragmentation is an issue, it
>> might not be enough. BTW, during boot there should be a line "Built X
>> zonelists, mobility grouping ..." can you grep for it and provide please, I
>> wonder if mobility grouping ends up being off or on on that system.
> 
> I ran your branch with CONFIG_SLUB_TINY=y. Here are the results with 3-4
> runs per config:
> 
> * tiny slub with default slub_max_order:
> 	- Clean boot, 579 free pages
> 	- Clean boot, 575 free pages
> 	- Clean boot, 579 free pages
> 
> * tiny slub with slub_max_order=0 as boot argument:
>         - Init error, shell prompt but no shell command working
> 	- Init error, shell prompt, 592 free pages
> 	- Init error, shell prompt, 591 free pages
> 	- Init error, shell prompt, 591 free pages
> 
> * tiny slub with slub_max_order=1 as boot argument:
> 	- Clean boot, 601 free pages
> 	- Clean boot, 601 free pages
> 	- Clean boot, 591 free pages
> 	- Clean boot, 601 free pages

Oh that's great result, better than I'd hope!
I'll change the default slub_max_order=1 with CONFIG_SLUB_TINY then.

> For all cases, mobility grouping was reported as off:
> 
> [    0.000000] Built 1 zonelists, mobility grouping off.  Total pages: 2020

Yeah, expected that would be the case, thanks for confirming.

> So it looks like your tiny slub branch with slub_max_order=1 puts us
> almost on par with slob and that slub_max_order=0 seems to be generating
> more fragmentation leading to unreliable boot. I also tried
> slub_max_order=2, which gives clean boot and around 582 free pages, almost
> the same as the default.
> 
> With this branch applied, I have no issues with having slob deprecated :)
> Thanks !

Great, thanks for the testing!

>> 
>> Thanks!
>> 
>>> Cheers.
>>>
>> 
> 

