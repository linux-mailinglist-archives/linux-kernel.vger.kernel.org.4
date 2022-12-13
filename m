Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03BE064B847
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 16:21:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236102AbiLMPVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 10:21:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235467AbiLMPVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 10:21:05 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A36A1FCE0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 07:21:04 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id DB4461F8B6;
        Tue, 13 Dec 2022 15:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1670944862; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YiZIoKh/H3JB8O+68Jo0nbSuac+QbMa/5AjW72iFLcQ=;
        b=nx8nCOKHYinmvJBznXJr0NA9gdC5KMVz9qPLNdQE6sVahekKBMny6UcB+kY0kVu3rdBuh9
        +xpPCU/ABaSFcaa3T1Dx6v5V1IAUUoCRb5RAG0lusSMOTSxqAil4SfD+tdqY7zSvovMm4A
        exey6C+8+FLWNlD3UbfK0eFMnyjDASo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1670944862;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YiZIoKh/H3JB8O+68Jo0nbSuac+QbMa/5AjW72iFLcQ=;
        b=dkWRA5cJTlAyO8220c3/QpJ+x2bQ553egsrAzIwu7czAfDF4JJXITzdORx1NC2l3YEbZ3R
        7GUJLCEvf6Ar/ADA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A849D138EE;
        Tue, 13 Dec 2022 15:21:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id c/e2J16YmGMsEgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 13 Dec 2022 15:21:02 +0000
Message-ID: <97c5df42-c6ea-8af5-a727-f1fd77484a59@suse.cz>
Date:   Tue, 13 Dec 2022 16:21:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: mainline build failure due to e240e53ae0ab ("mm, slub: add
 CONFIG_SLUB_TINY")
Content-Language: en-US
To:     Guenter Roeck <linux@roeck-us.net>,
        "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
Cc:     Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Linus Torvalds <torvalds@linux-foundation.org>,
        Marco Elver <elver@google.com>
References: <Y5hTTGf/RA2kpqOF@debian> <20221213131140.GA3622636@roeck-us.net>
 <48cd0d18-a13c-bf20-e064-2041f63b05bf@suse.cz>
 <fd532051-7b11-3a0a-0dd1-13e1820960db@roeck-us.net>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <fd532051-7b11-3a0a-0dd1-13e1820960db@roeck-us.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/13/22 15:11, Guenter Roeck wrote:
> On 12/13/22 05:27, Vlastimil Babka wrote:
>> On 12/13/22 14:11, Guenter Roeck wrote:
>>> On Tue, Dec 13, 2022 at 10:26:20AM +0000, Sudip Mukherjee (Codethink) wrote:
>>>> Hi All,
>>>>
>>>> The latest mainline kernel branch fails to build xtensa allmodconfig
>>>> with gcc-11 with the error:
>>>>
>>>> kernel/kcsan/kcsan_test.c: In function '__report_matches':
>>>> kernel/kcsan/kcsan_test.c:257:1: error: the frame size of 1680 bytes is larger than 1536 bytes [-Werror=frame-larger-than=]
>>>>    257 | }
>>>>        | ^
>>>>
>>>> git bisect pointed to e240e53ae0ab ("mm, slub: add CONFIG_SLUB_TINY")
>>>>
>>>
>>> In part that is because above commit changes Kconfig dependencies such
>>> that xtensa:allmodconfig actually tries to build kernel/kcsan/kcsan_test.o.
>>> In v6.1, CONFIG_KCSAN_KUNIT_TEST is not enabled for xtensa:allmodconfig.
>> 
>> OK, so IIUC
>> - e240e53ae0ab introduces SLUB_TINY and adds !SLUB_TINY to KASAN's depend
>> - allyesconfig/allmodconfig will enable SLUB_TINY
>> - thus KASAN is disabled where it was previously enabled
>> - thus KCSAN which depends on !KASAN is enabled where it was previously disabled
>> - also arch/xtensa/Kconfig:    select ARCH_HAS_STRNCPY_FROM_USER if !KASAN
>> 
>>> Downside of the way SLUB_TINY is defined is that it is enabled for all
>>> allmodconfig / allyesconfig builds, which then disables building a lot
>>> of the more sophisticated memory allocation options.
>> 
>> It does disable KASAN, but seems that on the other hand allows enabling
>> other stuff.
>> Is there a way to exclude the SLUB_TINY option from all(mod/yes)config? Or
>> it needs to be removed to SLUB_FULL and logically reversed?
>> 
> 
> "depends on !COMPILE_TEST" should do it. Not sure though if that would just
> hide the other compile failures seen with powerpc and arm allmodconfig
> builds.

Hmm yeah it seems rather arbitrary and not fixing the root cause(s). If some
options are broken and it becomes apparent due to a change affecting
allmodconfig in a way that enables them, then I'd assume the same could have
already happened with randconfig? So it's best to fix that, or at least
disable those failing options on the respective arches deterministically.

Also worth noting why I resorted to making KASAN depend on !SLUB_TINY:

https://lore.kernel.org/all/14bd73b0-5480-2b35-7b89-161075d9f444@suse.cz/

It's because KASAN_GENERIC and KASAN_SW_TAGS will "select SLUB_DEBUG if
SLUB" and apparently Kconfig doesn't consider it an error, but just a
warning, if that conficts with SLUB_DEBUG depending on !SLUB_TINY.
I just realized that KASAN_HW_TAGS doesn't have this 'select' so it could be
compatible with SLUB_TINY but I disabled that combination as well.

I suppose something like "select SLUB_TINY=n" doesn't exist, as that would
make the KASAN choice "stronger" than SLUB_TINY.

It would probably be the cleanest if the KASAN modes that need SLUB_DEBUG
just depended on it instead of selecting it.

> Guenter
> 

