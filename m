Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9744868A8C0
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 08:13:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233170AbjBDHNO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 02:13:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbjBDHNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 02:13:12 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36EE61A481;
        Fri,  3 Feb 2023 23:13:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=H/qDAs0aG9wKJfINKmJuWustItYw8wCMUlwnF3oMGdU=; b=z5u9JO2WNGqw2FmnLGZV+STHzI
        u+lGL5wRuHWmUQNjKyfFxv3qNlXXX7xe0DZttGfSCbKw8zJFexb09aVjYtIWAd3qQteWKAcQK2e+u
        dWaoDJ+UAIozY3S9d/1dF03b1eGimxKlxC/HloEOJC28jyDHXbzyUDIxRrHu196+wabf4VN+U8nbL
        N1JstiDtDEtDLDnfdNNjhG69rMSkOhs6KTF0rGQOz4mMOsh7b1QzjEnTZe2KCUMQKQQf4W35uSUQT
        KpWwhzmydA0ngbslng2MhmxFlkKFArfMBXl8RI7G8Ml8V03248Bnqid4iRnf+d/EaYbjGNyIgOLsP
        SKpKA+hw==;
Received: from [2601:1c2:d00:6a60::9526]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pOCjT-004cp8-Ep; Sat, 04 Feb 2023 07:13:07 +0000
Message-ID: <b70e8b58-e981-1222-4d79-1e408ad60f18@infradead.org>
Date:   Fri, 3 Feb 2023 23:13:05 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2] sh: init: use OF_EARLY_FLATTREE for early init
Content-Language: en-US
To:     "D. Jeff Dionne" <djeffdionne@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, Rich Felker <dalias@libc.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        linux-sh@vger.kernel.org
References: <20230204055116.22591-1-rdunlap@infradead.org>
 <C8F0719C-0C0A-45F0-A4DA-66DE807DECDA@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <C8F0719C-0C0A-45F0-A4DA-66DE807DECDA@gmail.com>
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



On 2/3/23 23:05, D. Jeff Dionne wrote:
> Randy, which SH3 chipset target are you building for?  Of course all that stay need to be converted to device tree, but a DT SH3 proof of existence that you build for already will surely cover good swath of the missing drivers.
> 

Hi Jeff,
I don't have a specific target.  I'm just fixing a build error.

> 
>> On Feb 4, 2023, at 14:51, Randy Dunlap <rdunlap@infradead.org> wrote:
>>
>> When CONFIG_OF_EARLY_FLATTREE and CONFIG_SH_DEVICE_TREE are not set,
>> SH3 build fails with a call to early_init_dt_scan(), so in
>> arch/sh/kernel/setup.c and arch/sh/kernel/head_32.S, use
>> CONFIG_OF_EARLY_FLATTREE instead of CONFIG_OF_FLATTREE.
>>
>> Fixes this build error:
>> ../arch/sh/kernel/setup.c: In function 'sh_fdt_init':
>> ../arch/sh/kernel/setup.c:262:26: error: implicit declaration of function 'early_init_dt_scan' [-Werror=implicit-function-declaration]
>>  262 |         if (!dt_virt || !early_init_dt_scan(dt_virt)) {
>>
>> Fixes: 03767daa1387 ("sh: fix build regression with CONFIG_OF && !CONFIG_OF_FLATTREE")
>> Fixes: eb6b6930a70f ("sh: fix memory corruption of unflattened device tree")
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Suggested-by: Rob Herring <robh+dt@kernel.org>
>> Cc: Frank Rowand <frowand.list@gmail.com>
>> Cc: devicetree@vger.kernel.org
>> Cc: Rich Felker <dalias@libc.org>
>> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
>> Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
>> Cc: linux-sh@vger.kernel.org
>> ---
>> v2: use Suggested-by: for Rob.
>>    add more Cc's.
>>
>> arch/sh/kernel/head_32.S |    6 +++---
>> arch/sh/kernel/setup.c   |    4 ++--
>> 2 files changed, 5 insertions(+), 5 deletions(-)
>>
>> diff arch/sh/kernel/setup.c arch/sh/kernel/setup.c
>> diff -- a/arch/sh/kernel/setup.c b/arch/sh/kernel/setup.c
>> --- a/arch/sh/kernel/setup.c
>> +++ b/arch/sh/kernel/setup.c
>> @@ -244,7 +244,7 @@ void __init __weak plat_early_device_set
>> {
>> }
>>
>> -#ifdef CONFIG_OF_FLATTREE
>> +#ifdef CONFIG_OF_EARLY_FLATTREE
>> void __ref sh_fdt_init(phys_addr_t dt_phys)
>> {
>> 	static int done = 0;
>> @@ -326,7 +326,7 @@ void __init setup_arch(char **cmdline_p)
>> 	/* Let earlyprintk output early console messages */
>> 	sh_early_platform_driver_probe("earlyprintk", 1, 1);
>>
>> -#ifdef CONFIG_OF_FLATTREE
>> +#ifdef CONFIG_OF_EARLY_FLATTREE
>> #ifdef CONFIG_USE_BUILTIN_DTB
>> 	unflatten_and_copy_device_tree();
>> #else
>> diff -- a/arch/sh/kernel/head_32.S b/arch/sh/kernel/head_32.S
>> --- a/arch/sh/kernel/head_32.S
>> +++ b/arch/sh/kernel/head_32.S
>> @@ -64,7 +64,7 @@ ENTRY(_stext)
>> 	ldc	r0, r6_bank
>> #endif
>>
>> -#ifdef CONFIG_OF_FLATTREE
>> +#ifdef CONFIG_OF_EARLY_FLATTREE
>> 	mov	r4, r12		! Store device tree blob pointer in r12
>> #endif
>> 	
>> @@ -315,7 +315,7 @@ ENTRY(_stext)
>> 10:		
>> #endif
>>
>> -#ifdef CONFIG_OF_FLATTREE
>> +#ifdef CONFIG_OF_EARLY_FLATTREE
>> 	mov.l	8f, r0		! Make flat device tree available early.
>> 	jsr	@r0
>> 	 mov	r12, r4
>> @@ -346,7 +346,7 @@ ENTRY(stack_start)
>> 5:	.long	start_kernel
>> 6:	.long	cpu_init
>> 7:	.long	init_thread_union
>> -#if defined(CONFIG_OF_FLATTREE)
>> +#if defined(CONFIG_OF_EARLY_FLATTREE)
>> 8:	.long	sh_fdt_init
>> #endif
>>
> 

-- 
~Randy
