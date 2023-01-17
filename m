Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F05766D959
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 10:10:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235634AbjAQJKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 04:10:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236454AbjAQJJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 04:09:41 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A613302A4;
        Tue, 17 Jan 2023 01:03:46 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id p185so4281152oif.2;
        Tue, 17 Jan 2023 01:03:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=0NAtipYSyTW+GwDFf12zqOPhjTjzg7AWvFqV0EBka+Q=;
        b=eN26VWG15wRzfEmyfbgEpgrnkd+1vEg9MtMA4OwJsJffJd9jrJ+X/urBex/z60kcXE
         QSbODoslFuO3oZPzu8gv46JFExd0s/znOcTeQ32KB2yUlI2VGUUvZ0W0cgcfRslIyf1p
         i5B5FHmvWmflMFjGJtmRHFLfsxp9l5/cQy9QNFnLZpz62TtUQ1G5cAhLWKPEVURtM6Ri
         2RQjwCP6qJPCcUaW0AWToJaLi7+SuNOLpKAaFELXqpbDQNqnQ0tAscuSJhuh/wXkSqg5
         TWhlFURWN08stm1Jk3H/GhuZ8iwulvTkygpjA6LxXGgAlWeANY2EZLIT56vCAw8t1m1i
         GV+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0NAtipYSyTW+GwDFf12zqOPhjTjzg7AWvFqV0EBka+Q=;
        b=EvqC3pakVdFZU1S5vYXhCd+qpS0wK5GWuw9emJ5qQgxM/uO75cyA4zRofedaAvl0rx
         Eu8sMNlUq7tR5ZmKMTVgifajPggNeIbwDhBGawPZuaT+hzIftZTbefMxsE+V/0wJh9Yv
         K/0/1YxXzlhs7gRgHeV9xVcOmp3Vvvh4cCy1hRug62v8Ev2ikQq6MbU/8ngpncPfvt2W
         UdIq60/3Y2CcN7yKumnzlVPsO/5YJLvpO6mSpFe4YtOkJQ1JiuhyK7fLdFlWhD2cN4Kf
         UJlMapTtfaLGlNEHQ//oH+jxuWq1Amd+FIAEw2yIX5TMj5Vv1fGIgselCibF/Q3+rCfh
         6v9Q==
X-Gm-Message-State: AFqh2kr3/xx7B7oVNo6lqJ6hZRGaPe1a2JmSE8dG5LzakShvaqtkx2xA
        wsgSwh/IFvtn6Gg/LXtZYSkk490CCBU=
X-Google-Smtp-Source: AMrXdXuyuk41ifaJojeX4IsRrNf98cQzYgZjR7zyulKHdhUtsWWWQukx9Ch3bOZcdsg3yFr9AxI26g==
X-Received: by 2002:a05:6808:6d7:b0:360:c338:b958 with SMTP id m23-20020a05680806d700b00360c338b958mr1024178oih.55.1673946225861;
        Tue, 17 Jan 2023 01:03:45 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v63-20020acaac42000000b003670342726fsm2108210oie.12.2023.01.17.01.03.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jan 2023 01:03:44 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <bdcef623-58c0-fd59-f833-79b3e117604a@roeck-us.net>
Date:   Tue, 17 Jan 2023 01:03:43 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: Build regressions/improvements in v6.2-rc4
Content-Language: en-US
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
References: <CAHk-=wgcOEWvT-WjmRf-zCCXyFJaVVFH=26BPQ+N1OFTTnN=RA@mail.gmail.com>
 <20230116122924.116745-1-geert@linux-m68k.org>
 <46ba7912-3df6-dff9-792-49f4eaadefec@linux-m68k.org>
 <Y8V94PKtaWO3yRS4@osiris> <20230116184127.GA1721129@roeck-us.net>
 <Y8Zi89nN+ONOEki7@osiris>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <Y8Zi89nN+ONOEki7@osiris>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/17/23 00:57, Heiko Carstens wrote:
> On Mon, Jan 16, 2023 at 10:41:27AM -0800, Guenter Roeck wrote:
>> On Mon, Jan 16, 2023 at 05:40:00PM +0100, Heiko Carstens wrote:
>>> On Mon, Jan 16, 2023 at 01:36:34PM +0100, Geert Uytterhoeven wrote:
>>>> On Mon, 16 Jan 2023, Geert Uytterhoeven wrote:
>>>>> JFYI, when comparing v6.2-rc4[1] to v6.2-rc3-8-g1fe4fd6f5cad346e[3], the summaries are:
>>>>>   - build errors: +1/-5
>>>>
>>>>    + /kisskb/src/include/linux/fortify-string.h: error: '__builtin_memcpy' reading 128 bytes from a region of size 0 [-Werror=stringop-overread]:  => 57:33
>>>>
>>>> s390x-gcc11/s390-allmodconfig
>>>>
>>>> /kisskb/src/arch/s390/kernel/setup.c: In function 'setup_lowcore_dat_on':
>>>> /kisskb/src/include/linux/fortify-string.h:57:33: error: '__builtin_memcpy' reading 128 bytes from a region of size 0 [-Werror=stringop-overread]
>>>>     57 | #define __underlying_memcpy     __builtin_memcpy
>>>>        |                                 ^
>>>> /kisskb/src/include/linux/fortify-string.h:578:9: note: in expansion of macro '__underlying_memcpy'
>>>>    578 |         __underlying_##op(p, q, __fortify_size);                        \
>>>>        |         ^~~~~~~~~~~~~
>>>> /kisskb/src/include/linux/fortify-string.h:623:26: note: in expansion of macro '__fortify_memcpy_chk'
>>>>    623 | #define memcpy(p, q, s)  __fortify_memcpy_chk(p, q, s,                  \
>>>>        |                          ^~~~~~~~~~~~~~~~~~~~
>>>> /kisskb/src/arch/s390/kernel/setup.c:526:9: note: in expansion of macro 'memcpy'
>>>>    526 |         memcpy(abs_lc->cregs_save_area, S390_lowcore.cregs_save_area,
>>>>        |         ^~~~~~
>>>>
>>>> Looks like this was "'__builtin_memcpy' offset [0, 127] is out of the bounds
>>>> [0, 0]" before.
>>>
>>> Thanks for reporting. Of course this doesn't happen with gcc-12, and
>>> this code will be rewritten with the next merge window anyway.
>>> But to workaround this with gcc-11, we could go with the below:
>>>
>>
>> This is because of
>>
>> #define S390_lowcore (*((struct lowcore *) 0))
>>
>> and is fixed with something like
>>
>> #define S390_lowcore (*((struct lowcore *) absolute_pointer(0)))
>>
>> See commit f6b5f1a56987 ("compiler.h: Introduce absolute_pointer macro").
> 
> Yes, I'm aware of that. However absolute_pointer() is not an option for
> S390_lowcore. See also commit f0be87c42cbd ("gcc-12: disable
> '-Warray-bounds' universally for now") and the referenced s390 commit.
> 

Interesting. It works (builds) just fine for me after the above suggested
change.

Guenter

>> The problem is only seen with gcc 11.2. I don't see it with 11.3 or 12.2.
> 
> FWIW, the compile warning is seen with gcc 11.1 and 11.2, but not with any
> other compiler. Given that this isn't the first report, I'm tempted to
> workaround this now.

