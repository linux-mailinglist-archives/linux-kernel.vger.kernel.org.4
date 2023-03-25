Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 054976C8C35
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 08:29:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231770AbjCYH3e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 03:29:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjCYH3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 03:29:33 -0400
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FEB340EE;
        Sat, 25 Mar 2023 00:29:30 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=renyu.zj@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0VeZxngs_1679729366;
Received: from 30.15.221.158(mailfrom:renyu.zj@linux.alibaba.com fp:SMTPD_---0VeZxngs_1679729366)
          by smtp.aliyun-inc.com;
          Sat, 25 Mar 2023 15:29:27 +0800
Message-ID: <6325bd2b-21c5-236c-51cb-25da076d57a4@linux.alibaba.com>
Date:   Sat, 25 Mar 2023 15:29:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [RESEND PATCH] driver/perf: arm-cmn: support ACPI probe
To:     Ilkka Koskinen <ilkka@os.amperecomputing.com>
Cc:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Zhuo Song <zhuo.song@linux.alibaba.com>
References: <1679587838-80000-1-git-send-email-renyu.zj@linux.alibaba.com>
 <557691c9-2176-7e9b-1130-8091507dfdd4@os.amperecomputing.com>
From:   Jing Zhang <renyu.zj@linux.alibaba.com>
In-Reply-To: <557691c9-2176-7e9b-1130-8091507dfdd4@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.0 required=5.0 tests=ENV_AND_HDR_SPF_MATCH,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/3/24 上午6:33, Ilkka Koskinen 写道:
> 
> Hi Jing,
> 
> On Thu, 23 Mar 2023, Jing Zhang wrote:
>> ACPI companion devices call insert_resource() in platform_device_add()
>> to claim the device resources. If the resources are claimed again before
>> ioremap(), and the addresses of multiple resources overlap, it will
>> return -BUSY, causing the driver to fail to load.
>>
>> For example, the CMN700 on my machine is set with two resources similar
>> to CMN600, and the overlap of resource addresses makes the CMN driver
>> unable to match my CMN700. The error log:
> 
> I thought that the two address ranges were only needed for CMN-600?
> I guess, the specification doesn't explicitly forbid giving two ranges for CMN700 although the example shows just one.
> 

Hi Ilkka,

Yes, on our platform, CMN700 is designed with two resources which describe PERIPHBASE and ROOTNODEBASE respectively.

>>
>> [  12.016837] arm-cmn ARMHC700:00: can't request region for resource [mem 0x40000000-0x4fffffff]
>> [  12.028230] arm-cmn: probe of ARMHC700:00 failed with error -16
>> [  12.036832] arm-cmn ARMHC700:01: can't request region for resource [mem 0x40040000000-0x4004fffffff]
>> [  12.051289] arm-cmn: probe of ARMHC700:01 failed with error -16
>>
>> So let ACPI companion devices call arm_cmn_acpi_probe() and not claim
>> resource again. In addition, the arm_cmn_acpi_probe() and
>> arm_cmn_of_probe() functions are refactored to make them compatible
>> with both CMN600 and CMN-ANY.
>>
>> Fixes: 61ec1d875812 ("perf/arm-cmn: Demarcate CMN-600 specifics")
>> Signed-off-by: Jing Zhang <renyu.zj@linux.alibaba.com>
>> ---
>> drivers/perf/arm-cmn.c | 57 ++++++++++++++++++++++++++++++++------------------
>> 1 file changed, 37 insertions(+), 20 deletions(-)
>>
>> diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
>> index 1deb61b..beb3b37 100644
>> --- a/drivers/perf/arm-cmn.c
>> +++ b/drivers/perf/arm-cmn.c
>> @@ -2206,7 +2206,7 @@ static int arm_cmn_discover(struct arm_cmn *cmn, unsigned int rgn_offset)
>>     return 0;
>> }
>>
>> -static int arm_cmn600_acpi_probe(struct platform_device *pdev, struct arm_cmn *cmn)
>> +static int arm_cmn_acpi_probe(struct platform_device *pdev, struct arm_cmn *cmn)
>> {
>>     struct resource *cfg, *root;
>>
>> @@ -2214,12 +2214,21 @@ static int arm_cmn600_acpi_probe(struct platform_device *pdev, struct arm_cmn *c
>>     if (!cfg)
>>         return -EINVAL;
>>
>> -    root = platform_get_resource(pdev, IORESOURCE_MEM, 1);
>> -    if (!root)
>> -        return -EINVAL;
>> +    /* If ACPI defines more than one resource, such as cmn-600, then there may be
>> +     * a deviation between ROOTNODEBASE and PERIPHBASE, and ROOTNODEBASE can
>> +     * be obtained from the second resource. Otherwise, it can be considered that
>> +     * ROOT NODE BASE is PERIPHBASE. This is compatible with cmn-600 and cmn-any.
>> +     */
>> +    if (pdev->num_resources > 1) {
>> +        root = platform_get_resource(pdev, IORESOURCE_MEM, 1);
>> +        if (!root)
>> +            return -EINVAL;
>>
>> -    if (!resource_contains(cfg, root))
>> -        swap(cfg, root);
>> +        if (!resource_contains(cfg, root))
>> +            swap(cfg, root);
>> +    } else {
>> +        root = cfg;
>> +    }
>>     /*
>>      * Note that devm_ioremap_resource() is dumb and won't let the platform
>>      * device claim cfg when the ACPI companion device has already claimed
>> @@ -2227,17 +2236,30 @@ static int arm_cmn600_acpi_probe(struct platform_device *pdev, struct arm_cmn *c
>>      * appropriate name, we don't really need to do it again here anyway.
>>      */
>>     cmn->base = devm_ioremap(cmn->dev, cfg->start, resource_size(cfg));
>> -    if (!cmn->base)
>> -        return -ENOMEM;
>> +    if (IS_ERR(cmn->base))
>> +        return PTR_ERR(cmn->base);
> 
> I believe, devm_ioremap() returns NULL in case of error
> 

Yes, you are right.


Thanks,
Jing
