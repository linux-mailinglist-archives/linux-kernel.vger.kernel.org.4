Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ECF2647E42
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 08:05:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbiLIHFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 02:05:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbiLIHEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 02:04:49 -0500
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24E5B1C405;
        Thu,  8 Dec 2022 23:04:48 -0800 (PST)
Received: from [192.168.192.83] (unknown [50.47.134.245])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id CA85542546;
        Fri,  9 Dec 2022 07:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1670569486;
        bh=Rw1LgZrAHKmOPFMlSc8m5mrXgg+i195LB/soUVfMO7k=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=eydc90K9HuIjQkBqAUlYJQp7LGFNmC1aNsirsLOaDf5E7KLee6uWYR5ckh8ZoWeyd
         t706NyaJjw1c1R7pmNJfZRab/gcaBPTdJ15FAnol2SiJ4/cknZJznk79ZhAHrbYBaZ
         oSQHraCbffz+QER9UpKaYFDssMwG3kYrxkVJtk8piZ3FtWaOi32aWcizaSDCFbEuBw
         YagtGmtx4RUf91Ww6QK23XLYjWWRm+LypLvi6CKtmOZO2L+0fbJAUPpTVubWp5IY5c
         7Km1L+tu6xQ8Lv/Qg1DaIalqpCNNjnNo5UFTkfZGw5fYiQvW+TLjAP7WeQExZ0BYzh
         PZXwRlVtx2VuA==
Message-ID: <9d9564a4-cf78-4eee-465b-90f0e7b2fdff@canonical.com>
Date:   Thu, 8 Dec 2022 23:04:42 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: security: policy_unpack.c:325:10: error: use of undeclared
 identifier 'TRI_TRUE'
Content-Language: en-US
To:     David Gow <davidgow@google.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        lkft-triage@lists.linaro.org, apparmor@lists.ubuntu.com,
        Nick Terrell <terrelln@fb.com>, Rae Moar <rmoar@google.com>
References: <CA+G9fYu5JjZzpFfNOqzLV+KQnSL1VU7n8Yv-FrZYvuvwo1Ayug@mail.gmail.com>
 <CABVgOSms-8vXDVX68JX-4UEnaGyCgVyNWH37W8qGz7eVtFcWag@mail.gmail.com>
From:   John Johansen <john.johansen@canonical.com>
Organization: Canonical
In-Reply-To: <CABVgOSms-8vXDVX68JX-4UEnaGyCgVyNWH37W8qGz7eVtFcWag@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/8/22 22:57, David Gow wrote:
> On Thu, 8 Dec 2022 at 15:36, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>>
>> Following build regresion found on Linux next-20221208 tag.
>>
>> Regressions found on riscv:
>>    - build/clang-nightly-defconfig
>>    - build/gcc-8-defconfig
>>    - build/gcc-11-defconfig
>>    - build/clang-15-defconfig
>>
>> make --silent --keep-going --jobs=8
>> O=/home/tuxbuild/.cache/tuxmake/builds/1/build LLVM=1 LLVM_IAS=1
>> ARCH=riscv CROSS_COMPILE=riscv64-linux-gnu- 'HOSTCC=sccache clang'
>> 'CC=sccache clang' defconfig
>> make --silent --keep-going --jobs=8
>> O=/home/tuxbuild/.cache/tuxmake/builds/1/build LLVM=1 LLVM_IAS=1
>> ARCH=riscv CROSS_COMPILE=riscv64-linux-gnu- 'HOSTCC=sccache clang'
>> 'CC=sccache clang'
>> security/apparmor/policy_unpack.c:316:18: error: unknown type name 'tri'
>> VISIBLE_IF_KUNIT tri aa_unpack_array(struct aa_ext *e, const char
>> *name, u16 *size)
>>                   ^
>> security/apparmor/policy_unpack.c:325:10: error: use of undeclared
>> identifier 'TRI_TRUE'
>>                  return TRI_TRUE;
>>                         ^
>> security/apparmor/policy_unpack.c:328:9: error: use of undeclared
>> identifier 'TRI_NONE'
>>          return TRI_NONE;
>>                 ^
>> security/apparmor/policy_unpack.c:331:9: error: use of undeclared
>> identifier 'TRI_FALSE'
>>          return TRI_FALSE;
>>                 ^
>> security/apparmor/policy_unpack.c:455:42: error: use of undeclared
>> identifier 'TRI_TRUE'
>>                  if (aa_unpack_array(e, NULL, &size) != TRI_TRUE)
>>                                                         ^
>> security/apparmor/policy_unpack.c:529:42: error: use of undeclared
>> identifier 'TRI_TRUE'
>>                  if (aa_unpack_array(e, NULL, &size) != TRI_TRUE)
>>                                                         ^
>> security/apparmor/policy_unpack.c:559:42: error: use of undeclared
>> identifier 'TRI_TRUE'
>>                  if (aa_unpack_array(e, NULL, &size) != TRI_TRUE)
>>                                                         ^
>> security/apparmor/policy_unpack.c:611:42: error: use of undeclared
>> identifier 'TRI_TRUE'
>>                  if (aa_unpack_array(e, NULL, &size) != TRI_TRUE ||
>>                                                         ^
>> security/apparmor/policy_unpack.c:674:42: error: use of undeclared
>> identifier 'TRI_TRUE'
>>                  if (aa_unpack_array(e, NULL, &size) != TRI_TRUE)
>>                                                         ^
>> 9 errors generated.
>> make[4]: *** [scripts/Makefile.build:252:
>> security/apparmor/policy_unpack.o] Error 1
>> make[4]: Target 'security/apparmor/' not remade because of errors.
>> make[3]: *** [scripts/Makefile.build:504: security/apparmor] Error 2
>>
>> Build link,
>>    - https://builds.tuxbuild.com/2IcJeyR3s4kGd2Nca8vVq7Sleao/
>>    - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20221208/testrun/13508560/suite/build/test/gcc-11-defconfig/details/
>>
>> Build results comparison:
>>    - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20221208/testrun/13508560/suite/build/test/gcc-11-defconfig/history/
>>
>>
>> steps to reproduce:
>> # To install tuxmake on your system globally:
>> # sudo pip3 install -U tuxmake
>> #
>> # See https://docs.tuxmake.org/ for complete documentation.
>> # Original tuxmake command with fragments listed below.
>> # tuxmake --runtime podman --target-arch riscv --toolchain gcc-11
>> --kconfig defconfig
>>
>>
>> tuxmake --runtime podman --target-arch riscv --toolchain gcc-11
>> --kconfig https://builds.tuxbuild.com/2IcJeyR3s4kGd2Nca8vVq7Sleao/config
>>
>> --
>> Linaro LKFT
>> https://lkft.linaro.org
> 
> I suspect this is in need of the fix here:
> https://lore.kernel.org/all/bff89220-df3a-a148-2ba4-6aad3874f322@canonical.com/
> 

yes, that is what is needed to fix this


