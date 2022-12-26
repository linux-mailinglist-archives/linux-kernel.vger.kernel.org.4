Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E02D656513
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 22:04:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232165AbiLZVEH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 16:04:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiLZVEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 16:04:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A2CF1144
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 13:04:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D3771B80D41
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 21:04:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32541C433EF;
        Mon, 26 Dec 2022 21:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672088640;
        bh=RrC2UFeJ5OcV6CtCFnGV1SEMl0pRTD3ZrD0EjoM85ZM=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=PxQS6MshRotttfQfYFz4wHOtKM+FM5xX3PHNogxCpCppj6zOIBOOtZfbS3w38r2k9
         hzMc/5kiBULmF9fdrauS8SI9hnRecxGs5mW/28cZFkj4CzoZyRTELDaDQ0XBgeKFu/
         Q0PyJpILMI8w8zATYsY9zzuJTK+tai2/N3Jtp+zoYRvokGM+NnkfzbRmlYA+KDKJ+K
         2YSToyVA4D5F4Qfo2krx4JtqBF2z3avmMkny8ZLYVM4RfqTAyn6PP/4dV45aI187v2
         DS+UwPyrcqVhBwZA8OjFmvTC9ZMplTbprhjAonsek/EeEiFJeqMn5lgV2aFCSPsZoC
         g2bHJv8AoVcEA==
Date:   Mon, 26 Dec 2022 13:03:59 -0800
From:   Kees Cook <kees@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: Linux 6.2-rc1
User-Agent: K-9 Mail for Android
In-Reply-To: <CAHk-=whD1zMyt4c7g6-+tWvVweyb-6oHMT_+ZVHqe1EXwtFpCQ@mail.gmail.com>
References: <CAHk-=wgf929uGOVpiWALPyC7pv_9KbwB2EAvQ3C4woshZZ5zqQ@mail.gmail.com> <20221226195206.GA2626419@roeck-us.net> <CAHk-=whD1zMyt4c7g6-+tWvVweyb-6oHMT_+ZVHqe1EXwtFpCQ@mail.gmail.com>
Message-ID: <DA632860-284E-4923-8863-9D2745DD289E@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On December 26, 2022 12:56:29 PM PST, Linus Torvalds <torvalds@linux-founda=
tion=2Eorg> wrote:
>On Mon, Dec 26, 2022 at 11:52 AM Guenter Roeck <linux@roeck-us=2Enet> wro=
te:
>>
>> fs/f2fs/inline=2Ec: In function 'f2fs_move_inline_dirents':
>> include/linux/fortify-string=2Eh:59:33: error: '__builtin_memset' point=
er overflow between offset [28, 898293814] and size [-898293787, -1] [-Werr=
or=3Darray-bounds]
>> fs/f2fs/inline=2Ec:430:9: note: in expansion of macro 'memset'
>>   430 |         memset(dst=2Ebitmap + src=2Enr_bitmap, 0, dst=2Enr_bitm=
ap - src=2Enr_bitmap);
>>       |         ^~~~~~
>
>Well, that's unfortunate=2E

I'll look into this=2E

> [=2E=2E=2E]
>> Not exactly a regression, but worth mentioning:
>>
>> CONFIG_MEMCPY_KUNIT_TEST now sometimes takes several minutes to
>> execute in qemu=2E On top of that, it may result in hung task timeouts
>> if the hung task timeout is set to low values (45 seconds and below)=2E
>> Example, seen with s390:
>>
>> =2E=2E=2E
>> [   18=2E494320]     ok 2 memcpy_test
>> [   52=2E969037]     ok 3 memcpy_large_test
>> =2E=2E=2E
>> [   52=2E974505]     ok 4 memmove_test
>> [   87=2E325400]     ok 5 memmove_large_test
>> [  143=2E562760] INFO: task swapper/0:1 blocked for more than 46 second=
s=2E
>> =2E=2E=2E
>> [  143=2E564441] Call Trace:
>> [  143=2E564689]  [<0000000000f1ec80>] __schedule+0x370/0x720
>> [  143=2E565175]  [<0000000000f1f098>] schedule+0x68/0x110
>> [  143=2E565374]  [<0000000000f278d4>] schedule_timeout+0xc4/0x160
>> [  143=2E565603]  [<0000000000f1fde2>] __wait_for_common+0xda/0x250
>> [  143=2E565816]  [<0000000000903c90>] kunit_try_catch_run+0x98/0x178
>> [  143=2E566029]  [<0000000000f05c9c>] kunit_run_case_catch_errors+0x7c=
/0xb8
>> [  143=2E566956]  [<00000000009023c0>] kunit_run_tests+0x220/0x638
>> =2E=2E=2E
>>
>> That is too much for my test bed=2E I dropped this test as result=2E Th=
is means
>> that extending the tests has, at least in the context of my testing, th=
e
>> opposite effect=2E
>
>Kees? This indeed seems counter-productive=2E=2E

Hrm, that is not supposed to take THAT long=2E=2E=2E But yes a cross-arxh =
qemu run would be slow=2E :(

The changes there were to help find any future memcpy problem (like seen w=
hile porting the i386 memcpy asm=2E=2E=2E) I'll try to get this reduced=2E =
Dropping the test isn't so great=2E :)



--=20
Kees Cook
