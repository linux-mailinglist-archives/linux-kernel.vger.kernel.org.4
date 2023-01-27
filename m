Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1A9667EC32
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 18:13:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235091AbjA0RNc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 12:13:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235025AbjA0RN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 12:13:26 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4B7D1E07E
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 09:13:05 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5D8DA2B;
        Fri, 27 Jan 2023 09:13:40 -0800 (PST)
Received: from [10.57.75.194] (unknown [10.57.75.194])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ABA833F71E;
        Fri, 27 Jan 2023 09:12:56 -0800 (PST)
Message-ID: <c5d7833d-6372-7eb7-67fe-3cda0bdd4715@arm.com>
Date:   Fri, 27 Jan 2023 17:12:55 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH] Coresight: tpda/tpdm: remove incorrect __exit annotation
To:     Arnd Bergmann <arnd@arndb.de>, Arnd Bergmann <arnd@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Tao Zhang <quic_taozha@quicinc.com>,
        Mao Jinlong <quic_jinlmao@quicinc.com>,
        Will Deacon <will@kernel.org>
Cc:     Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linaro.org>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20230126163530.3495413-1-arnd@kernel.org>
 <7ec6bd88-7f18-7eca-fa92-cfea9a25a395@arm.com>
 <cd4f23d7-cdd7-49e1-8eff-9ec04dcb36c8@app.fastmail.com>
 <e6c3fa24-963b-57c0-1a9a-fd056a9ac591@arm.com>
 <f87c8f49-227e-40fb-b13b-00d869d81fe8@app.fastmail.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <f87c8f49-227e-40fb-b13b-00d869d81fe8@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/01/2023 17:00, Arnd Bergmann wrote:
> On Fri, Jan 27, 2023, at 17:46, Suzuki K Poulose wrote:
>> On 26/01/2023 20:37, Arnd Bergmann wrote:
>>> On Thu, Jan 26, 2023, at 19:02, Suzuki K Poulose wrote:
>>>> On 26/01/2023 16:35, Arnd Bergmann wrote:
>>>>> From: Arnd Bergmann <arnd@arndb.de>
>>>> Thanks for the fix, I will queue this. Btw, I did try to
>>>> reproduce it locally, but couldn't trigger the warnings,
>>>> even with
>>>>
>>>> CONFIG_WERROR=y
>>>>
>>>> and all CORESIGHT configs builtin. I see other drivers doing the
>>>> same outside coresight too. Just curious to know why is this
>>>> any different. Is it specific to "bus" driver (e.g. AMBA) ?
>>>
>>> The warning comes from postprocessing the object file, it's got
>>> nothing to do with the bus type, only with a symbol in .data
>>> referencing a symbol in .init.text. Maybe there are some
>>> config options that keep the section from getting discarded?
>>> Or possibly you only built the files in this directory, but did
>>> not get to the final link?
>>
>> I did a full kernel build. Also, I see a similar issue with the
>> coresight-etm4x (by code inspection) driver. Did you not hit that ?
>>
>> May be there is a config option that is masking it on my end. But
>> the case of etm4x driver is puzzling.
>>
>> $ git grep etm4_remove_amba
>> drivers/hwtracing/coresight/coresight-etm4x-core.c
>> drivers/hwtracing/coresight/coresight-etm4x-core.c:static void __exit
>> etm4_remove_amba(struct amba_device *adev)
>> drivers/hwtracing/coresight/coresight-etm4x-core.c:     .remove
>> = etm4_remove_amba,
> 
> Indeed, that one clearly has the same but, but I have never
> observed a warning for it.
> 
> I checked one more thing and found that I only get the warning
> for 32-bit Arm builds, but not arm64. Since the etm4x driver
> 'depends on ARM64' for its use of asm/sysreg.h,
> I never test-built it on 32-bit arm.
> 
>  From the git history of arch/arm64/kernel/vmlinux.lds.S,
> I can see that arm64 never discards the .exit section, see
> commit 07c802bd7c39 ("arm64: vmlinux.lds.S: don't discard
> .exit.* sections at link-time").

That makes sense, thanks for getting to the bottom of this. I
have pushed it to coresight next.

https://git.kernel.org/coresight/c/0c1ccc158bbc

Kind regards
Suzuki



> 
>       Arnd

