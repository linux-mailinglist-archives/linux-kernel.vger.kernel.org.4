Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 595897314C6
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 12:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245272AbjFOKCn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 06:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238766AbjFOKCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 06:02:40 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1017195;
        Thu, 15 Jun 2023 03:02:35 -0700 (PDT)
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id AA24FFF805;
        Thu, 15 Jun 2023 10:02:28 +0000 (UTC)
Message-ID: <35dc3141-ac83-791c-7439-1c1f25ca95e8@ghiti.fr>
Date:   Thu, 15 Jun 2023 12:02:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 10/10] perf: tests: Adapt mmap-basic.c for riscv
Content-Language: en-US
To:     Andrew Jones <ajones@ventanamicro.com>,
        Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>,
        Will Deacon <will@kernel.org>, Rob Herring <robh@kernel.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
References: <20230512085321.13259-1-alexghiti@rivosinc.com>
 <20230512085321.13259-11-alexghiti@rivosinc.com>
 <20230531-31bd9ddeaca8cb338f81ed14@orel>
From:   Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20230531-31bd9ddeaca8cb338f81ed14@orel>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 31/05/2023 17:15, Andrew Jones wrote:
> On Fri, May 12, 2023 at 10:53:21AM +0200, Alexandre Ghiti wrote:
>> riscv now supports mmaping hardware counters to userspace so adapt the test
>> to run on this architecture.
>>
>> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
>> ---
>>   tools/perf/tests/mmap-basic.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/perf/tests/mmap-basic.c b/tools/perf/tests/mmap-basic.c
>> index e68ca6229756..f5075ca774f8 100644
>> --- a/tools/perf/tests/mmap-basic.c
>> +++ b/tools/perf/tests/mmap-basic.c
>> @@ -284,7 +284,7 @@ static struct test_case tests__basic_mmap[] = {
>>   			 "permissions"),
>>   	TEST_CASE_REASON("User space counter reading of instructions",
>>   			 mmap_user_read_instr,
>> -#if defined(__i386__) || defined(__x86_64__) || defined(__aarch64__)
>> +#if defined(__i386__) || defined(__x86_64__) || defined(__aarch64__) || __riscv_xlen == 64
>>   			 "permissions"
>>   #else
>>   			 "unsupported"
>> @@ -292,7 +292,7 @@ static struct test_case tests__basic_mmap[] = {
>>   		),
>>   	TEST_CASE_REASON("User space counter reading of cycles",
>>   			 mmap_user_read_cycles,
>> -#if defined(__i386__) || defined(__x86_64__) || defined(__aarch64__)
>> +#if defined(__i386__) || defined(__x86_64__) || defined(__aarch64__) || __riscv_xlen == 64
>>   			 "permissions"
>>   #else
>>   			 "unsupported"
>> -- 
>> 2.37.2
>>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>


Thanks for your review Andrew, as usual, always helpful.

And sorry for the delay!

Alex


>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
