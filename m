Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBF91745AA4
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 12:56:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231217AbjGCK43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 06:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjGCK42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 06:56:28 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BBAEBB2;
        Mon,  3 Jul 2023 03:56:26 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2FBFD2F4;
        Mon,  3 Jul 2023 03:57:09 -0700 (PDT)
Received: from [10.57.38.117] (unknown [10.57.38.117])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6E8C83F762;
        Mon,  3 Jul 2023 03:56:24 -0700 (PDT)
Message-ID: <a195f4b7-283a-1929-de72-c6c5319d2203@arm.com>
Date:   Mon, 3 Jul 2023 11:56:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 3/4] perf/arm_cspmu: Clean up ACPI dependency
Content-Language: en-GB
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     will@kernel.org, mark.rutland@arm.com, suzuki.poulose@arm.com,
        bwicaksono@nvidia.com, ilkka@os.amperecomputing.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
References: <cover.1685983270.git.robin.murphy@arm.com>
 <9d126711c7498b199b3e6f5cf48ca60ffb9df54c.1685983270.git.robin.murphy@arm.com>
 <CAMuHMdU7kiGni_T1mRU7EC-8sQn8EjhND1-POc2h2V4V8Oeuqg@mail.gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <CAMuHMdU7kiGni_T1mRU7EC-8sQn8EjhND1-POc2h2V4V8Oeuqg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On 2023-07-03 10:21, Geert Uytterhoeven wrote:
> Hi Robin,
> 
> On Mon, Jun 5, 2023 at 7:05 PM Robin Murphy <robin.murphy@arm.com> wrote:
>> Build-wise, the ACPI dependency consists of only a couple of things
>> which could probably stand being factored out into ACPI helpers anyway.
>> However for the immediate concern of working towards Devicetree support
>> here, it's easy enough to make a few tweaks to contain the affected code
>> locally, such that we can relax the Kconfig dependency.
>>
>> Reviewed-and-Tested-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> Reviewed-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> 
> Thanks for your patch, which is now commit f9bd34e3753ea8f1
> ("perf/arm_cspmu: Clean up ACPI dependency") upstream.
> 
>> --- a/drivers/perf/arm_cspmu/Kconfig
>> +++ b/drivers/perf/arm_cspmu/Kconfig
>> @@ -4,8 +4,7 @@
>>
>>   config ARM_CORESIGHT_PMU_ARCH_SYSTEM_PMU
>>          tristate "ARM Coresight Architecture PMU"
>> -       depends on ARM64 && ACPI
>> -       depends on ACPI_APMT || COMPILE_TEST
>> +       depends on ARM64 || COMPILE_TEST
> 
>  From looking at the code, the "arm-cs-arch-pmu" platform device can
> be instantiated only through ACPI.  So I think it is a bit premature to
> relax the dependency, and expose this question to people configuring
> an ARM64 kernel without ACPI/APMT support.
> 
> Am I missing something?

As was mentioned in the original cover letter on v1, these patches were 
actually the bottom half of a branch adding DT support - the DT parts 
are still untested and not quite complete (there's a property I don't 
need for the thing I'm looking at, but still deserves to be hooked up in 
general), but it seemed worth landing these prep patches since they 
impact what Besar and Ilkka are also working on in parallel.

At this point, the kconfig could indeed be "depends on (ARM64 && 
ACPI_APMT) || COMPILE_TEST". I can't recall why I didn't change that 
when splitting these patches out for posting - I may have decided the 
impact was negligible (i.e. even with DT support, it's still going to be 
a driver most people won't care about anyway), or the visibility vs. 
functional dependency aspect may have just slipped my mind entirely. 
You're welcome to make that change for now if you'd like to.

(I'm not sure how soon I'll be posting the follow-up DT patches, since 
I'm dependent on other people to provide testing and feedback, and 
haven't heard any news yet)

Thanks,
Robin.


> Thanks!
> 
>>          help
>>            Provides support for performance monitoring unit (PMU) devices
>>            based on ARM CoreSight PMU architecture. Note that this PMU
> 
> Gr{oetje,eeting}s,
> 
>                          Geert
> 
