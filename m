Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 486EB5E6328
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 15:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbiIVNGu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 09:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbiIVNGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 09:06:46 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CD799EBBC0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 06:06:45 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 29F8A1595;
        Thu, 22 Sep 2022 06:06:52 -0700 (PDT)
Received: from [10.57.1.91] (unknown [10.57.1.91])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0ACD83F73B;
        Thu, 22 Sep 2022 06:06:43 -0700 (PDT)
Message-ID: <489f42fc-2ec1-510b-6f3f-017ee10ee7d2@arm.com>
Date:   Thu, 22 Sep 2022 14:06:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 0/1] arm64: defconfig: Add Coresight as module
Content-Language: en-US
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        suzuki.poulose@arm.com, mathieu.poirier@linaro.org,
        mike.leach@linaro.org, leo.yan@linaro.org, broonie@kernel.org,
        linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
References: <20220921140535.152627-1-james.clark@arm.com>
 <Yyso42iP40niLTxO@arm.com> <adc70f4a-83f8-2bcc-87f1-28db004ae8e8@arm.com>
 <Yyw+gHXLG/fXoQbT@arm.com>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <Yyw+gHXLG/fXoQbT@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22/09/2022 11:52, Catalin Marinas wrote:
> On Thu, Sep 22, 2022 at 10:34:45AM +0100, James Clark wrote:
>> On 21/09/2022 16:08, Catalin Marinas wrote:
>>> 2. Always on CONFIG_PID_IN_CONTEXTIDR (we might as well remove the
>>>    Kconfig entry). This would write the root pid namespace value
>>>    (task_pid_nr()).
>>
>> If we're not worried about the overhead after all, this would be the
>> easiest solution. And then SPE or Coresight already decide whether they
>> want to use the value or not, so no further changes are needed.
>>
>> From Leo's patch there is a table that shows a 1% overhead with it
>> enabled permanently, and I've heard a figure like that mentioned before.
>> So I could also resurrect that patch to use static keys? Although it's a
>> bit more complicated, that would be my preference. And then we can have
>> that mode always on.
> 
> I don't think we should bother with static keys, just always enable it
> but try to reduce/group the ISBs from all the functions called on the
> __switch_to() path. We may actually get a speed-up.
> 

Ok thanks I will take a look at this
