Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8CA16BC7D2
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 08:55:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbjCPHyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 03:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjCPHyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 03:54:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D7DA12588
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 00:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678953225;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aZYLoXgK/JW3b9cmlgSFtaDq15S+diTkjhEeDbb70oY=;
        b=IdUuh5JNrZJPjGTIUyzudtERX5y2RcB81vTI94yaPvGqcyZiGgYd2A1ikoNTwPuMIcAiOU
        9e8iPx7ZyOOlaZvml3Y4LU06F0l9ZdL/3L1CbJSHxHlbowNg/4BqvZxtXXN1sBNCp1Stpr
        S3glGTlIZaKKRunF2MDX3gfFgwQipyk=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-397-Eeh8ZUJjOZKGWAW-DiI-rw-1; Thu, 16 Mar 2023 03:53:44 -0400
X-MC-Unique: Eeh8ZUJjOZKGWAW-DiI-rw-1
Received: by mail-ed1-f70.google.com with SMTP id h11-20020a0564020e8b00b004e59d4722a3so1793845eda.6
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 00:53:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678953223;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aZYLoXgK/JW3b9cmlgSFtaDq15S+diTkjhEeDbb70oY=;
        b=t9L72pew491BEBrYMENfbRi50Y+/GlbswQFSQveFirrsEjUeqG32El6H3YX2j/l8pt
         O/InXhXRsQ1i4UOF2391zAHrO+/Q7Tt9cGdulji2EtP5Az4qEWxr7lmGzLq4qxbwLIex
         MLMbwYmxSigmKnvmq6zrC7lulWipWF7naMoLsKoRgU+LmC3dtNYeWYTfNNSFvisECguE
         bwahJb0X3lg8xfeUBUj+tO9Y+I1qNMcGVMFYkFSSR13lRKeHWGWV6TsLXkga3YQK47Ip
         SiStc75eE8+wJxlJeCOr/rTCPN5G4DCW07zhlshjOL8TUHmyXk/j6r/V91EdXDaj5qVv
         eoew==
X-Gm-Message-State: AO0yUKXI4T/RBK+DFi5SxeuTBguRSTzCJI0dduZvUGtMPeaJFqGBORWc
        3IOKLTcEfKClyMLyO/uHpRyLbVcNZHetn6UlBxMKaj80A0inUbj7/QDi9KBQ/ku/Y1+fk4lt0cg
        gIRHZP/xOBxPvTG3O6Te83g4=
X-Received: by 2002:a17:907:60c9:b0:8e1:12b6:a8fc with SMTP id hv9-20020a17090760c900b008e112b6a8fcmr11086084ejc.4.1678953222999;
        Thu, 16 Mar 2023 00:53:42 -0700 (PDT)
X-Google-Smtp-Source: AK7set84iHWAWy9wrsukpTv+yvJRTM3Gf1ub8/HI94lAt1/UoUW/Pjk54pFWWJhGC8DFoWm9E8vr+w==
X-Received: by 2002:a17:907:60c9:b0:8e1:12b6:a8fc with SMTP id hv9-20020a17090760c900b008e112b6a8fcmr11086065ejc.4.1678953222665;
        Thu, 16 Mar 2023 00:53:42 -0700 (PDT)
Received: from [10.43.17.73] (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id mh1-20020a170906eb8100b008eddbd46d7esm3482399ejb.31.2023.03.16.00.53.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Mar 2023 00:53:42 -0700 (PDT)
Message-ID: <c8e4cc40-f764-0a99-be50-015d4000adfd@redhat.com>
Date:   Thu, 16 Mar 2023 08:53:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: next: arm-32bit: build errors: kernel/module/internal.h:252:56:
 error: expected ';', ',' or ')' before 'const'
Content-Language: en-US
To:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org, bpf <bpf@vger.kernel.org>,
        linux-mips@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Arnd Bergmann <arnd@arndb.de>, Jiri Olsa <jolsa@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>
References: <CA+G9fYsqpaicB4TKpMHKbma+YKs0Lm_mpsGBnxvh4tHcubAUeg@mail.gmail.com>
From:   Viktor Malik <vmalik@redhat.com>
In-Reply-To: <CA+G9fYsqpaicB4TKpMHKbma+YKs0Lm_mpsGBnxvh4tHcubAUeg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/16/23 08:14, Naresh Kamboju wrote:
> Results from Linaro’s test farm.
> Following mips and arm builds failed.
> 
> Regressions found on mips:
>   - build/gcc-12-ath79_defconfig
>   - build/gcc-8-ath79_defconfig
> 
> Regressions found on arm:
>   - build/gcc-8-omap1_defconfig
>   - build/gcc-12-omap1_defconfig
>   - build/clang-nightly-omap1_defconfig
>   - build/clang-16-omap1_defconfig
> 
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> Build log:
> ------------
> 
> In file included from kernel/module/main.c:59:
> kernel/module/internal.h:252:56: error: expected ';', ',' or ')' before 'const'
>    252 |                                                        const char *name)
>        |                                                        ^~~~~
> make[4]: *** [scripts/Makefile.build:252: kernel/module/main.o] Error 1
> In file included from kernel/module/strict_rwx.c:12:
> kernel/module/internal.h:252:56: error: expected ';', ',' or ')' before 'const'
>    252 |                                                        const char *name)
>        |                                                        ^~~~~
> make[4]: *** [scripts/Makefile.build:252: kernel/module/strict_rwx.o] Error 1
> In file included from kernel/module/tree_lookup.c:11:
> kernel/module/internal.h:252:56: error: expected ';', ',' or ')' before 'const'
>    252 |                                                        const char *name)
>        |                                                        ^~~~~
> make[4]: *** [scripts/Makefile.build:252: kernel/module/tree_lookup.o] Error 1
> In file included from kernel/module/procfs.c:13:
> kernel/module/internal.h:252:56: error: expected ';', ',' or ')' before 'const'
>    252 |                                                        const char *name)
>        |                                                        ^~~~~
> make[4]: *** [scripts/Makefile.build:252: kernel/module/procfs.o] Error 1
> In file included from kernel/module/sysfs.c:15:
> kernel/module/internal.h:252:56: error: expected ';', ',' or ')' before 'const'
>    252 |                                                        const char *name)
>        |                                                        ^~~~~
> make[4]: *** [scripts/Makefile.build:252: kernel/module/sysfs.o] Error 1
> 
> 
> build log:
>   - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230316/testrun/15632981/suite/build/test/gcc-12-omap1_defconfig/log
>   - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230316/testrun/15632981/suite/build/test/gcc-12-omap1_defconfig/details/
> 

Hi,

this was fixed by Alexei by force-pushing bpf-next [1] but it seems that 
linux-next has managed to pull bpf-next in the meantime. I'm not sure 
what is the best way to fix this in linux-next, let me know if I should 
send a patch.

I apologize for the trouble.
Viktor

[1] 
https://lore.kernel.org/bpf/6c8f828c-3995-a9b0-3bdd-37724e96a4ce@redhat.com/T/#m44dc53d16524fa818d6a9397487107805e5f0713

> 
> --
> Linaro LKFT
> https://lkft.linaro.org
> 

