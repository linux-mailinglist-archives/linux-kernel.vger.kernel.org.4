Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7BC26A0D51
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 16:51:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233862AbjBWPvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 10:51:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjBWPvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 10:51:09 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51BD13756E
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 07:51:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=gcaOWdjkRuwLLoyj6ZoLjXSkHlPAfZqEuB5/VEUD0fI=; b=Ot7dJ9+wvbJRfG4duiWBJQO6Oa
        9LJgmKjMl5QrQb+AQ0DQmlwvXHBYSmEL2hkbvYXUZlxWKIaJ/GGwOcY4UZHicVUC/VU4zv4QvdJZs
        779PJrDbLbfJlM6N2sP6Rw+j3ylct3XmdyAq4NXqp5hcpl+mSInonIDo1xaWZ/7lHcHB8zFfEqsen
        UVY3sqGaaodSgnmFduiFHL9w1zZY8EaoWBoCYEl8rsQ099UofjDxTP2zjkeNTid0TwCdCDiBQskw/
        z2J/tdaDa161SfEFmeYt3z+joic2U4Djt1isuaRUGUZg7VBk6uyGRGAbboHo194hRZCFOREMXFtAz
        HSDHCsBg==;
Received: from [2601:1c2:980:9ec0::df2f]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pVDs6-00H8rh-Eb; Thu, 23 Feb 2023 15:51:02 +0000
Message-ID: <7e5c3c59-68c1-eb45-d462-bb093aee5da3@infradead.org>
Date:   Thu, 23 Feb 2023 07:51:01 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH] macintosh: via-pmu-led: *********************************
Content-Language: en-US
To:     Michael Ellerman <mpe@ellerman.id.au>, linux-kernel@vger.kernel.org
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Elimar Riesebieter <riesebie@lxtec.de>,
        linuxppc-dev@lists.ozlabs.org
References: <20230223014151.19270-1-rdunlap@infradead.org>
 <877cw8bvzv.fsf@mpe.ellerman.id.au>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <877cw8bvzv.fsf@mpe.ellerman.id.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/23/23 00:56, Michael Ellerman wrote:
> Randy Dunlap <rdunlap@infradead.org> writes:
>> LEDS_TRIGGER_DISK depends on ATA, so selecting LEDS_TRIGGER_DISK
>> when ATA is not set/enabled causes a Kconfig warning:
>>
>> WARNING: unmet direct dependencies detected for LEDS_TRIGGER_DISK
>>   Depends on [n]: NEW_LEDS [=y] && LEDS_TRIGGERS [=y] && ATA [=n]
>>   Selected by [y]:
>>   - ADB_PMU_LED_DISK [=y] && MACINTOSH_DRIVERS [=y] && ADB_PMU_LED [=y] && LEDS_CLASS [=y]
>>
>> Fix this by making ADB_PMU_LED_DISK depend on ATA.
> 
> Should it just depend on LEDS_TRIGGER_DISK ?

Hmph. Yes, good idea. Thanks.

> 
>> Seen on both PPC32 and PPC64.
>>
>> Fixes: 0e865a80c135 ("macintosh: Remove dependency on IDE_GD_ATA if ADB_PMU_LED_DISK is selected")
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> Cc: Paul Mackerras <paulus@samba.org>
>> Cc: Elimar Riesebieter <riesebie@lxtec.de>
>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>> Cc: linuxppc-dev@lists.ozlabs.org
>> ---
>>  drivers/macintosh/Kconfig |    1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff -- a/drivers/macintosh/Kconfig b/drivers/macintosh/Kconfig
>> --- a/drivers/macintosh/Kconfig
>> +++ b/drivers/macintosh/Kconfig
>> @@ -86,6 +86,7 @@ config ADB_PMU_LED
>>  
>>  config ADB_PMU_LED_DISK
>>  	bool "Use front LED as DISK LED by default"
>> +	depends on ATA
>>  	depends on ADB_PMU_LED
>>  	depends on LEDS_CLASS
>>  	select LEDS_TRIGGERS

-- 
~Randy
