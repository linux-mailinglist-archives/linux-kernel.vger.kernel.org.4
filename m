Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64F2D69B66F
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 00:24:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbjBQXYM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 18:24:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbjBQXYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 18:24:10 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE895457E5;
        Fri, 17 Feb 2023 15:24:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=UjS1u+gmVzuL5FxBbKJQNccOBVKsZ9PBAvdbdSMHdSM=; b=en8a4SUIl777LJK5ENO7Zv6t+Z
        0h8bsAAXNomTqFyetZK5sebb0DAWa7o56pBxH2uDKY98XP9wDp97ZBFimdiFQALVM/vyv7WVggcnY
        jWN144IsO5xX+o2LzUh3G9cnv4OTxsodCZtJAcYt3RxxqbNcwA9pLpfbVAkUedMZC+Opd+PYwhivp
        utTujW8+o5YVy/Bqayc5jP23K6YIM6LK84P4/x0qIgdnJ7u0cWYWb/AhOmO6GwplfEYVef2nC8hON
        w3x1UEa2fdKIupyAOoXPhaoivv2ELl1F0JQNtosuy4NGnNvmPuAtVWqSOBaM6dke1cuYzVyKOdwSu
        5Q6yyoIA==;
Received: from [2601:1c2:980:9ec0::df2f]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pTA5E-00Fwjw-Uu; Fri, 17 Feb 2023 23:24:05 +0000
Message-ID: <fec9d8ca-b385-b2e4-8f20-db427c2ae964@infradead.org>
Date:   Fri, 17 Feb 2023 15:24:04 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH] MIPS: vpe-mt: provide a default 'physical_memsize'
Content-Language: en-US
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Dengcheng Zhu <dzhu@wavecomp.com>,
        John Crispin <john@phrozen.org>, linux-mips@vger.kernel.org,
        Qais Yousef <qyousef@layalina.io>
References: <20230214010942.25143-1-rdunlap@infradead.org>
 <7a2eca01-8420-dd98-9d4d-edf192f099fb@linaro.org>
 <a2a7806b-ba53-9f37-938b-d3f48ea217f2@infradead.org>
 <20230217115713.GA7701@alpha.franken.de>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230217115713.GA7701@alpha.franken.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/17/23 03:57, Thomas Bogendoerfer wrote:
> On Wed, Feb 15, 2023 at 10:59:35PM -0800, Randy Dunlap wrote:
>>> I agree this is where this variable has be be declared / initialized,
>>> but having this dependent on CONFIG_MIPS_MALTA/CONFIG_LANTIQ machines
>>> doesn't seem right.
>>
>> So far I have been able to consolidate the LANTIQ code into a general
>> patch, but not MALTA.
> 
> if I didn't miss something physical_memory is always 0 for LANTIQ 
> and something for MALTA depending on command line/DT. Now
> 
> arch/mips/kernel/vpe-mt.c contains
> 
>         /*
>          * The sde-kit passes 'memsize' to __start in $a3, so set something
>          * here...  Or set $a3 to zero and define DFLT_STACK_SIZE and
>          * DFLT_HEAP_SIZE when you compile your program
>          */
>         mttgpr(6, v->ntcs);
>         mttgpr(7, physical_memsize);
> 
> so the 0 for LANTIQ is fine with the correct VPE payload. But for
> MALTA could cause major problems, if the VPE payload uses the top
> of memory for it's stack. So I would guess nobody uses this "mode".
> Therefore let's get rid of physical_memory in vpe.c completly.

Hi Thomas,

What is this line doing?
          mttgpr(6, v->ntcs);

Does it need to stay?
But the comment and mttgpr(7, physical_memsize); can be deleted?

thanks.
-- 
~Randy
