Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB5256ECB03
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 13:09:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbjDXLJw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 07:09:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjDXLJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 07:09:50 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 51F6F210A
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 04:09:48 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 050F9D75;
        Mon, 24 Apr 2023 04:10:32 -0700 (PDT)
Received: from [192.168.1.3] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CA8EB3F5A1;
        Mon, 24 Apr 2023 04:09:46 -0700 (PDT)
Message-ID: <2c6cbccb-44e9-edaf-f1a1-ac9c5175537f@arm.com>
Date:   Mon, 24 Apr 2023 12:09:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v5 13/13] coresight: Fix CTI module refcount leak by
 making it a helper device
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        coresight@lists.linaro.org, quic_jinlmao@quicinc.com,
        mike.leach@linaro.org
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230404155121.1824126-1-james.clark@arm.com>
 <20230404155121.1824126-14-james.clark@arm.com>
 <51111c59-064f-1458-44ea-5fdae9f26211@arm.com>
Content-Language: en-US
From:   James Clark <james.clark@arm.com>
In-Reply-To: <51111c59-064f-1458-44ea-5fdae9f26211@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24/04/2023 11:43, Suzuki K Poulose wrote:
> On 04/04/2023 16:51, James Clark wrote:
>> The CTI module has some hard coded refcounting code that has a leak.
>> For example running perf and then trying to unload it fails:
>>
>>    perf record -e cs_etm// -a -- ls
>>    rmmod coresight_cti
>>
>>    rmmod: ERROR: Module coresight_cti is in use
>>
>> The coresight core already handles references of devices in use, so by
>> making CTI a normal helper device, we get working refcounting for free.
>>
>> Signed-off-by: James Clark <james.clark@arm.com>
>> ---
>>   drivers/hwtracing/coresight/coresight-core.c  | 104 ++++++------------
>>   .../hwtracing/coresight/coresight-cti-core.c  |  52 +++++----
>>   .../hwtracing/coresight/coresight-cti-sysfs.c |   4 +-
>>   drivers/hwtracing/coresight/coresight-cti.h   |   4 +-
>>   drivers/hwtracing/coresight/coresight-priv.h  |   4 +-
>>   drivers/hwtracing/coresight/coresight-sysfs.c |   4 +
>>   include/linux/coresight.h                     |  30 +----
>>   7 files changed, 75 insertions(+), 127 deletions(-)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-core.c
>> b/drivers/hwtracing/coresight/coresight-core.c
>> index 16689fe4ba98..2af416bba983 100644
>> --- a/drivers/hwtracing/coresight/coresight-core.c
>> +++ b/drivers/hwtracing/coresight/coresight-core.c
>> @@ -236,60 +236,44 @@ void coresight_disclaim_device(struct
>> coresight_device *csdev)
>>   }
>>   EXPORT_SYMBOL_GPL(coresight_disclaim_device);
>>   -/* enable or disable an associated CTI device of the supplied CS
>> device */
>> -static int
>> -coresight_control_assoc_ectdev(struct coresight_device *csdev, bool
>> enable)
>> +/*
>> + * Add a helper as an output device. This function takes the
>> @coresight_mutex
>> + * because it's assumed that it's called from the helper device,
>> outside of the
>> + * core code where the mutex would already be held. Don't add new
>> calls to this
>> + * from inside the core code, instead try to add the new helper to
>> the DT and
>> + * ACPI where it will be picked up and linked automatically.
>> + */
>> +void coresight_add_helper(struct coresight_device *csdev,
>> +              struct coresight_device *helper)
>>   {
>> -    int ect_ret = 0;
>> -    struct coresight_device *ect_csdev = csdev->ect_dev;
>> -    struct module *mod;
>> +    int i;
>> +    struct coresight_connection conn = {};
>> +    struct coresight_connection *new_conn;
>>   -    if (!ect_csdev)
>> -        return 0;
>> -    if ((!ect_ops(ect_csdev)->enable) || (!ect_ops(ect_csdev)->disable))
>> -        return 0;
>> +    mutex_lock(&coresight_mutex);
>> +    conn.dest_fwnode = fwnode_handle_get(dev_fwnode(&helper->dev));
>> +    conn.dest_dev = helper;
>> +    conn.dest_port = conn.src_port = -1;
>> +    conn.src_dev = csdev;
>>   -    mod = ect_csdev->dev.parent->driver->owner;
>> -    if (enable) {
>> -        if (try_module_get(mod)) {
>> -            ect_ret = ect_ops(ect_csdev)->enable(ect_csdev);
>> -            if (ect_ret) {
>> -                module_put(mod);
>> -            } else {
>> -                get_device(ect_csdev->dev.parent);
>> -                csdev->ect_enabled = true;
>> -            }
>> -        } else
>> -            ect_ret = -ENODEV;
>> -    } else {
>> -        if (csdev->ect_enabled) {
>> -            ect_ret = ect_ops(ect_csdev)->disable(ect_csdev);
>> -            put_device(ect_csdev->dev.parent);
>> -            module_put(mod);
>> -            csdev->ect_enabled = false;
>> -        }
>> -    }
>> +    /*
>> +     * Check for duplicates because this is called every time a helper
>> +     * device is re-loaded. Existing connections will get re-linked
>> +     * automatically.
>> +     */
>> +    for (i = 0; i < csdev->pdata->nr_outconns; ++i)
>> +        if (csdev->pdata->out_conns[i]->dest_fwnode == conn.dest_fwnode)
>> +            goto unlock;
>>   -    /* output warning if ECT enable is preventing trace operation */
>> -    if (ect_ret)
>> -        dev_info(&csdev->dev, "Associated ECT device (%s) %s failed\n",
>> -             dev_name(&ect_csdev->dev),
>> -             enable ? "enable" : "disable");
>> -    return ect_ret;
>> -}
>> +    new_conn =
>> +        coresight_add_out_conn(csdev->dev.parent, csdev->pdata, &conn);
> 
> ultra minor nit:
>     new_conn = coresight_add_out_conn(....,
>                       .... );

This whole patchset is now formatted with the kernel clang-format rules.
Are you sure this one is against the conventions?

The problem is running the formatter on all changed lines makes it
almost impossible to go back and undo indents like this.

> 
>> +    if (!IS_ERR(new_conn))
>> +        coresight_add_in_conn(new_conn);
>>   -/*
>> - * Set the associated ect / cti device while holding the coresight_mutex
>> - * to avoid a race with coresight_enable that may try to use this value.
>> - */
>> -void coresight_set_assoc_ectdev_mutex(struct coresight_device *csdev,
>> -                      struct coresight_device *ect_csdev)
>> -{
>> -    mutex_lock(&coresight_mutex);
>> -    csdev->ect_dev = ect_csdev;
>> +unlock:
>>       mutex_unlock(&coresight_mutex);
>>   }
>> -EXPORT_SYMBOL_GPL(coresight_set_assoc_ectdev_mutex);
>> +EXPORT_SYMBOL_GPL(coresight_add_helper);
>>     static int coresight_enable_sink(struct coresight_device *csdev,
>>                    enum cs_mode mode, void *data)
>> @@ -303,12 +287,8 @@ static int coresight_enable_sink(struct
>> coresight_device *csdev,
>>       if (!sink_ops(csdev)->enable)
>>           return -EINVAL;
>>   -    ret = coresight_control_assoc_ectdev(csdev, true);
>> -    if (ret)
>> -        return ret;
>>       ret = sink_ops(csdev)->enable(csdev, mode, data);
>>       if (ret) {
>> -        coresight_control_assoc_ectdev(csdev, false);
>>           return ret;
>>       }
>>       csdev->enable = true;
>> @@ -326,7 +306,6 @@ static void coresight_disable_sink(struct
>> coresight_device *csdev)
>>       ret = sink_ops(csdev)->disable(csdev);
>>       if (ret)
>>           return;
>> -    coresight_control_assoc_ectdev(csdev, false);
>>       csdev->enable = false;
>>   }
>>   @@ -351,17 +330,11 @@ static int coresight_enable_link(struct
>> coresight_device *csdev,
>>           return PTR_ERR(outconn);
>>         if (link_ops(csdev)->enable) {
>> -        ret = coresight_control_assoc_ectdev(csdev, true);
>> -        if (!ret) {
>> -            ret = link_ops(csdev)->enable(csdev, inconn, outconn);
>> -            if (ret)
>> -                coresight_control_assoc_ectdev(csdev, false);
>> -        }
>> +        ret = link_ops(csdev)->enable(csdev, inconn, outconn);
>> +        if (!ret)
>> +            csdev->enable = true;
>>       }
>>   -    if (!ret)
>> -        csdev->enable = true;
>> -
>>       return ret;
>>   }
>>   @@ -382,7 +355,6 @@ static void coresight_disable_link(struct
>> coresight_device *csdev,
>>         if (link_ops(csdev)->disable) {
>>           link_ops(csdev)->disable(csdev, inconn, outconn);
>> -        coresight_control_assoc_ectdev(csdev, false);
>>       }
>>         if (link_subtype == CORESIGHT_DEV_SUBTYPE_LINK_MERG) {
>> @@ -410,14 +382,9 @@ int coresight_enable_source(struct
>> coresight_device *csdev, enum cs_mode mode,
>>         if (!csdev->enable) {
>>           if (source_ops(csdev)->enable) {
>> -            ret = coresight_control_assoc_ectdev(csdev, true);
>> -            if (ret)
>> -                return ret;
>>               ret = source_ops(csdev)->enable(csdev, data, mode);
>> -            if (ret) {
>> -                coresight_control_assoc_ectdev(csdev, false);
>> +            if (ret)
>>                   return ret;
>> -            }
>>           }
>>           csdev->enable = true;
>>       }
>> @@ -488,7 +455,6 @@ bool coresight_disable_source(struct
>> coresight_device *csdev, void *data)
>>       if (atomic_dec_return(&csdev->refcnt) == 0) {
>>           if (source_ops(csdev)->disable)
>>               source_ops(csdev)->disable(csdev, data);
>> -        coresight_control_assoc_ectdev(csdev, false);
>>           coresight_disable_helpers(csdev);
>>           csdev->enable = false;
>>       }
> 
> You may also remove the "ect" from the
> 
> static struct device_type coresight_dev_type[]
> 

Will fix this and Mike's last comments and send a v6

> Suzuki
> 
> 
