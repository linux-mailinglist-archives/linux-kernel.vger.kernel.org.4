Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76DAD696CEA
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 19:29:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232097AbjBNS3V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 13:29:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231687AbjBNS3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 13:29:17 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7E362ED56;
        Tue, 14 Feb 2023 10:29:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=l8eNA24fiwwfGPSZyYQZ3w2UcUTVfrcUMih4l9bY7F8=; b=YfM14wEWMwnmcdR95BE45AyqSC
        n2+PVmQ5PNuaBIdrKI5czHVOGWrsNsd9myLmY32sO/aK63k5JKGbF5rzE2CLJkww4W6SexbProjYR
        g6crMqUXgrWJwYm0ZPxnxM5UOqUNrkcj45RG6cDMlRSIgHGQyScQ3quZOM92Lz4BO/1LEQu4FTjs5
        m76E0ckJQM9GhvGjxaz7UlcIRtgUX4Yr6YmTXofXwysaHuspqmS2lpAHHRO14h8a607P9govAJozb
        nbC8FoJI/wLWQ41CwYyttPJGcKxcUsO3KkaENfI9ArNGFQ8LMPtiAADrYOEkMcBw2AQuFrf8GMiPk
        d2Lw34gg==;
Received: from [2601:1c2:980:9ec0::df2f]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pS03I-003AzF-1o; Tue, 14 Feb 2023 18:29:16 +0000
Message-ID: <3284be35-be54-411b-206e-389fb0605622@infradead.org>
Date:   Tue, 14 Feb 2023 10:29:15 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] MIPS: vpe-mt: provide a default 'physical_memsize'
Content-Language: en-US
To:     =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
        linux-kernel@vger.kernel.org
Cc:     kernel test robot <lkp@intel.com>,
        Dengcheng Zhu <dzhu@wavecomp.com>,
        John Crispin <john@phrozen.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, Qais Yousef <qyousef@layalina.io>
References: <20230214010942.25143-1-rdunlap@infradead.org>
 <7a2eca01-8420-dd98-9d4d-edf192f099fb@linaro.org>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <7a2eca01-8420-dd98-9d4d-edf192f099fb@linaro.org>
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

Hi,

On 2/13/23 23:40, Philippe Mathieu-Daudé wrote:
> Hi Randy,
> 
> On 14/2/23 02:09, Randy Dunlap wrote:
>> When neither LANTIQ nor MIPS_MALTA is set, 'physical_memsize' is not
>> declared. This causes the build to fail with:
>>
>> mips-linux-ld: arch/mips/kernel/vpe-mt.o: in function `vpe_run':
>> arch/mips/kernel/vpe-mt.c:(.text.vpe_run+0x280): undefined reference to `physical_memsize'
>>
>> Fix this by declaring a 0-value physical_memsize with neither LANTIQ
>> nor MIPS_MALTA is set, like LANTIQ does.
>>
>> Fixes: 1a2a6d7e8816 ("MIPS: APRP: Split VPE loader into separate files.")
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Link: https://lore.kernel.org/all/202302030625.2g3E98sY-lkp@intel.com/
>> Cc: Dengcheng Zhu <dzhu@wavecomp.com>
>> Cc: John Crispin <john@phrozen.org>
>> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
>> Cc: linux-mips@vger.kernel.org
>> ---
>> How has this build error not been detected for 10 years?
>>
>>   arch/mips/kernel/vpe-mt.c |    9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff -- a/arch/mips/kernel/vpe-mt.c b/arch/mips/kernel/vpe-mt.c
>> --- a/arch/mips/kernel/vpe-mt.c
>> +++ b/arch/mips/kernel/vpe-mt.c
>> @@ -22,6 +22,15 @@ static int major;
>>   /* The number of TCs and VPEs physically available on the core */
>>   static int hw_tcs, hw_vpes;
>>   +#if !defined(CONFIG_MIPS_MALTA) && !defined(CONFIG_LANTIQ)
>> +/* The 2 above provide their own 'physical_memsize' variable. */
> 
> Which seems dubious. The variable should be defined once, likely in
> arch/mips/kernel/vpe-mt.c, since arch/mips/include/asm/vpe.h declares
> it.
> 
> I'm surprised CONFIG_MIPS_MALTA always links malta-dtshim.o, but
> malta-dtshim.o depends on MIPS_VPE_LOADER_MT, and I can't find a
> CONFIG_MIPS_MALTA -> MIPS_VPE_LOADER_MT Kconfig dep.
> 
>> +/*
>> + * This is needed by the vpe-mt loader code, just set it to 0 and assume
>> + * that the firmware hardcodes this value to something useful.
>> + */
>> +unsigned long physical_memsize = 0L;
> 
> I agree this is where this variable has be be declared / initialized,
> but having this dependent on CONFIG_MIPS_MALTA/CONFIG_LANTIQ machines
> doesn't seem right.
> 
>> +#endif
>> +
>>   /* We are prepared so configure and start the VPE... */
>>   int vpe_run(struct vpe *v)
>>   {

OK, I'll try to consolidate all of these into one location.

Thanks.
-- 
~Randy
