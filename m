Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53CF664B629
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 14:28:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235280AbiLMN2L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 08:28:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235603AbiLMN1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 08:27:51 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 466311A044
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 05:27:49 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id EFBF0228EB;
        Tue, 13 Dec 2022 13:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1670938067; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2t/UYI9MSV5VugIDUL9AEWRw4BbvAyzLCXl4/1d9eQs=;
        b=POrVO0Y5rm0fbk1MTDw+nSOp5Jmj+PXDcehIEvohtiBsqGXkE5AWRV3Wmp9B49n/YCzgA2
        7TKu7GCB+ZiiHv1wIwgMcVjfjuhlWLEuCi9Z8q4/2Xr/2utSu3t+UMbYYDOB6Ev+mH02dk
        p2dU4OcBPgY5t7YjHLoKWv14F0BwNMw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1670938067;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2t/UYI9MSV5VugIDUL9AEWRw4BbvAyzLCXl4/1d9eQs=;
        b=5c39LK8d0VE6+u9icsbvftW8M943k6yLUofds0ZyVTr9JPSZyG3yTvXWOxFQXEXhhINCZZ
        MO9Ww1cZKW/yfhDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C7810138EE;
        Tue, 13 Dec 2022 13:27:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 4xX+L9N9mGPCTQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 13 Dec 2022 13:27:47 +0000
Message-ID: <48cd0d18-a13c-bf20-e064-2041f63b05bf@suse.cz>
Date:   Tue, 13 Dec 2022 14:27:47 +0100
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
        linux-mm@kvack.org, Linus Torvalds <torvalds@linux-foundation.org>
References: <Y5hTTGf/RA2kpqOF@debian> <20221213131140.GA3622636@roeck-us.net>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20221213131140.GA3622636@roeck-us.net>
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

On 12/13/22 14:11, Guenter Roeck wrote:
> On Tue, Dec 13, 2022 at 10:26:20AM +0000, Sudip Mukherjee (Codethink) wrote:
>> Hi All,
>> 
>> The latest mainline kernel branch fails to build xtensa allmodconfig 
>> with gcc-11 with the error:
>> 
>> kernel/kcsan/kcsan_test.c: In function '__report_matches':
>> kernel/kcsan/kcsan_test.c:257:1: error: the frame size of 1680 bytes is larger than 1536 bytes [-Werror=frame-larger-than=]
>>   257 | }
>>       | ^
>> 
>> git bisect pointed to e240e53ae0ab ("mm, slub: add CONFIG_SLUB_TINY")
>> 
> 
> In part that is because above commit changes Kconfig dependencies such
> that xtensa:allmodconfig actually tries to build kernel/kcsan/kcsan_test.o.
> In v6.1, CONFIG_KCSAN_KUNIT_TEST is not enabled for xtensa:allmodconfig.

OK, so IIUC
- e240e53ae0ab introduces SLUB_TINY and adds !SLUB_TINY to KASAN's depend
- allyesconfig/allmodconfig will enable SLUB_TINY
- thus KASAN is disabled where it was previously enabled
- thus KCSAN which depends on !KASAN is enabled where it was previously disabled
- also arch/xtensa/Kconfig:    select ARCH_HAS_STRNCPY_FROM_USER if !KASAN

> Downside of the way SLUB_TINY is defined is that it is enabled for all
> allmodconfig / allyesconfig builds, which then disables building a lot
> of the more sophisticated memory allocation options.

It does disable KASAN, but seems that on the other hand allows enabling
other stuff.
Is there a way to exclude the SLUB_TINY option from all(mod/yes)config? Or
it needs to be removed to SLUB_FULL and logically reversed?

> Guenter

