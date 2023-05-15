Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C0A2702687
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 09:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239804AbjEOH6j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 03:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239693AbjEOH63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 03:58:29 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B8B20171F;
        Mon, 15 May 2023 00:55:38 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CCC472F4;
        Mon, 15 May 2023 00:56:22 -0700 (PDT)
Received: from [10.57.83.208] (unknown [10.57.83.208])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 830B33F67D;
        Mon, 15 May 2023 00:55:35 -0700 (PDT)
Message-ID: <89ad5070-db72-7bf1-5d86-a89fea54e789@arm.com>
Date:   Mon, 15 May 2023 08:55:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v4 1/4] devres: Provide krealloc_array
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux@roeck-us.net,
        michal.simek@amd.com, Jonathan.Cameron@huawei.com,
        Jonathan Corbet <corbet@lwn.net>,
        Jean Delvare <jdelvare@suse.com>,
        Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-doc@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org
References: <20230509094942.396150-1-james.clark@arm.com>
 <20230509094942.396150-2-james.clark@arm.com>
 <2023051340-sinuous-darkroom-2497@gregkh>
Content-Language: en-US
From:   James Clark <james.clark@arm.com>
In-Reply-To: <2023051340-sinuous-darkroom-2497@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13/05/2023 12:04, Greg KH wrote:
> On Tue, May 09, 2023 at 10:49:38AM +0100, James Clark wrote:
>> There is no krealloc_array equivalent in devres. Users would have to
>> do their own multiplication overflow check so provide one.
>>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Signed-off-by: James Clark <james.clark@arm.com>
>> ---
>>  Documentation/driver-api/driver-model/devres.rst |  1 +
>>  include/linux/device.h                           | 11 +++++++++++
>>  2 files changed, 12 insertions(+)
>>
>> diff --git a/Documentation/driver-api/driver-model/devres.rst b/Documentation/driver-api/driver-model/devres.rst
>> index 4249eb4239e0..8be086b3f829 100644
>> --- a/Documentation/driver-api/driver-model/devres.rst
>> +++ b/Documentation/driver-api/driver-model/devres.rst
>> @@ -364,6 +364,7 @@ MEM
>>    devm_kmalloc_array()
>>    devm_kmemdup()
>>    devm_krealloc()
>> +  devm_krealloc_array()
>>    devm_kstrdup()
>>    devm_kstrdup_const()
>>    devm_kvasprintf()
>> diff --git a/include/linux/device.h b/include/linux/device.h
>> index 472dd24d4823..58f4f5948edb 100644
>> --- a/include/linux/device.h
>> +++ b/include/linux/device.h
>> @@ -223,6 +223,17 @@ static inline void *devm_kcalloc(struct device *dev,
>>  {
>>  	return devm_kmalloc_array(dev, n, size, flags | __GFP_ZERO);
>>  }
>> +static inline __realloc_size(3, 4) void * __must_check
> 
> Shouldn't you have a blank line before this one?

I was going for consistency with the rest of this section which doesn't
have newlines between the functions for some reason. I can add one and
resubmit but it might look a bit out of place?

> 
>> +devm_krealloc_array(struct device *dev, void *p, size_t new_n, size_t new_size, gfp_t flags)
>> +{
>> +	size_t bytes;
>> +
>> +	if (unlikely(check_mul_overflow(new_n, new_size, &bytes)))
>> +		return NULL;
>> +
>> +	return devm_krealloc(dev, p, bytes, flags);
>> +}
> 
> I dislike how we have to keep copying the "real" functions (i.e.
> krealloc_array) into something like this, but I can't think of a better
> way to do it.
> 

Maybe something could be done with some macro magic, but it would
probably end up being worse than just copying them and would affect the
real ones as well. So yeah I can't think of any easy gains either.

Thanks
James

> thanks,
> 
> greg k-h
