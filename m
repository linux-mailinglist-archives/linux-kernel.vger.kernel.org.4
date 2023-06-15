Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B8797314B9
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 12:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241768AbjFOKAU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 06:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237827AbjFOKAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 06:00:16 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DDCC1A3;
        Thu, 15 Jun 2023 03:00:14 -0700 (PDT)
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
Received: by mail.gandi.net (Postfix) with ESMTPSA id CBCA64000B;
        Thu, 15 Jun 2023 10:00:01 +0000 (UTC)
Message-ID: <653f51b6-9f6e-12f1-9165-541922bed7a9@ghiti.fr>
Date:   Thu, 15 Jun 2023 12:00:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 08/10] Documentation: admin-guide: Add riscv
 sysctl_perf_user_access
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
 <20230512085321.13259-9-alexghiti@rivosinc.com>
 <20230531-0707dc46df8078cd92711314@orel>
From:   Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20230531-0707dc46df8078cd92711314@orel>
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


On 31/05/2023 17:07, Andrew Jones wrote:
> On Fri, May 12, 2023 at 10:53:19AM +0200, Alexandre Ghiti wrote:
>> riscv now uses this sysctl so document its usage for this architecture.
>>
>> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
>> ---
>>   Documentation/admin-guide/sysctl/kernel.rst | 24 +++++++++++++++++----
>>   1 file changed, 20 insertions(+), 4 deletions(-)
>>
>> diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
>> index 4b7bfea28cd7..93cd518ca94b 100644
>> --- a/Documentation/admin-guide/sysctl/kernel.rst
>> +++ b/Documentation/admin-guide/sysctl/kernel.rst
>> @@ -941,16 +941,32 @@ enabled, otherwise writing to this file will return ``-EBUSY``.
>>   The default value is 8.
>>   
>>   
>> -perf_user_access (arm64 only)
>> -=================================
>> +perf_user_access (arm64 and riscv only)
>> +=======================================
>> +
>> +Controls user space access for reading perf event counters.
>>   
>> -Controls user space access for reading perf event counters. When set to 1,
>> -user space can read performance monitor counter registers directly.
>> +arm64
>> +=====
>>   
>>   The default value is 0 (access disabled).
>> +When set to 1, user space can read performance monitor counter registers
>> +directly.
>>   
>>   See Documentation/arm64/perf.rst for more information.
>>   
>> +riscv
>> +=====
>> +
>> +When set to 0, user access is disabled.
>> +
>> +When set to 1, user space can read performance monitor counter registers
>> +directly only through perf, any direct access without perf intervention will
>> +trigger an illegal instruction.
>> +
>> +The default value is 2, which enables legacy mode (user space has direct
>> +access to cycle, time and insret CSRs only). Note that this legacy value
>> +is deprecated and will be removed once all userspace applications are fixed.
> All modes can access the time CSR so I'm not sure if it should be pointed
> out here as if it's an exception. Maybe we shouldn't point it out at all
> or we should point it out for all three?


Ok I removed the reference to the time CSR for the legacy mode and 
instead added a note stating that this CSR is always accessible whatever 
the mode.

Thanks!


>
> Thanks,
> drew
