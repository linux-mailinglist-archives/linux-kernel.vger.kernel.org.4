Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBB246CB427
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 04:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232115AbjC1Cb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 22:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbjC1Cb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 22:31:56 -0400
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.215])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B46282136
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 19:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
        Content-Type; bh=tA0fWIdSREazRi2gsLXlzBOKFVkGlLcy9hDX6nupWJw=;
        b=dTgF/Uti4piGybbbfm/Ad3OY7td8IalSUzmPmCJ32ywJSDRRG4fo1e53h31xMo
        TeMjEeO3NZXKy5CB2n2NH9bSBV5t2ng96SpCsL58XiUk83VAx3lYDlhq4jpOILd4
        PUPIcNqY1VCnIJh3e97oeB+lGp8MbRtwEgfWsWgAJ7HpI=
Received: from [10.88.19.164] (unknown [61.150.11.36])
        by zwqz-smtp-mta-g2-0 (Coremail) with SMTP id _____wA3vVXwUCJkCStCAg--.9235S2;
        Tue, 28 Mar 2023 10:29:06 +0800 (CST)
Message-ID: <79968005-28f3-d890-dfea-faca2e7d7947@163.com>
Date:   Tue, 28 Mar 2023 10:29:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH 2/3] perf/amlogic: Fix large number of counter issue
To:     Will Deacon <will@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Kelvin Zhang <kelvin.zhang@amlogic.com>,
        Chris Healy <cphealy@gmail.com>,
        Chris Healy <healych@amazon.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230209115403.521868-1-jiucheng.xu@amlogic.com>
 <20230209115403.521868-2-jiucheng.xu@amlogic.com>
 <20230327141054.GC31752@willie-the-truck>
Content-Language: en-US
From:   Jiucheng Xu <jiuchengxu@163.com>
In-Reply-To: <20230327141054.GC31752@willie-the-truck>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: _____wA3vVXwUCJkCStCAg--.9235S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7trykurW7Xr1kJw4fGrW3ZFb_yoW8ur43pF
        WkCFyFkrs8Jr1qgw17Z3Wa9a18Xw47Ar9agrW2gw1YvF12qF9xWasrW39I9r1DJrs2kF4I
        qFyYg3y5uFyrZr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jfqXdUUUUU=
X-Originating-IP: [61.150.11.36]
X-CM-SenderInfo: pmlxuxxhqj53i6rwjhhfrp/xtbB0xhA4lXlyiHoCgAAsQ
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


My Amlogic email box has some issues. Use my personal email 
<jiucheng.xu@163.com> to reply.

On 2023/3/27 22:10, Will Deacon wrote:
> [ EXTERNAL EMAIL ]
>
> On Thu, Feb 09, 2023 at 07:54:02PM +0800, Jiucheng Xu wrote:
>> When use 1ms interval, very large number of counter happens
>> once in a while as below:
>>
>> 25.968654513 281474976710655.84 MB meson_ddr_bw/chan_1_rw_bytes,arm=1/
>> 26.118657346 281474976710655.88 MB meson_ddr_bw/chan_1_rw_bytes,arm=1/
>> 26.180137180 281474976710655.66 MB meson_ddr_bw/chan_1_rw_bytes,arm=1/
>>
>> Root cause is the race between irq handler
>> and pmu.read callback. Use spin lock to protect the sw&hw
>> counters.
>>
>> Signed-off-by: Jiucheng Xu <jiucheng.xu@amlogic.com>
>> ---
>>   drivers/perf/amlogic/meson_ddr_pmu_core.c | 10 +++++++++-
>>   1 file changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/perf/amlogic/meson_ddr_pmu_core.c b/drivers/perf/amlogic/meson_ddr_pmu_core.c
>> index 0b24dee1ed3c..9b2e5d5c0626 100644
>> --- a/drivers/perf/amlogic/meson_ddr_pmu_core.c
>> +++ b/drivers/perf/amlogic/meson_ddr_pmu_core.c
>> @@ -14,6 +14,7 @@
>>   #include <linux/perf_event.h>
>>   #include <linux/platform_device.h>
>>   #include <linux/printk.h>
>> +#include <linux/spinlock.h>
>>   #include <linux/sysfs.h>
>>   #include <linux/types.h>
>>   
>> @@ -23,6 +24,7 @@ struct ddr_pmu {
>>   	struct pmu pmu;
>>   	struct dmc_info info;
>>   	struct dmc_counter counters;	/* save counters from hw */
>> +	spinlock_t lock;		/* protect hw/sw counter */
>>   	bool pmu_enabled;
>>   	struct device *dev;
>>   	char *name;
>> @@ -92,10 +94,12 @@ static void meson_ddr_perf_event_update(struct perf_event *event)
>>   	int idx;
>>   	int chann_nr = pmu->info.hw_info->chann_nr;
>>   
>> +	spin_lock(&pmu->lock);
> Why doesn't this need the _irqsave() variant if we're racing with the irq
> handler?
>
> Will
I think meson_ddr_perf_event_update function is called with hard irq off.
So update function couldn't be interrupted by irq handler. Right?

Thanks,
Jiucheng
>

