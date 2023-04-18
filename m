Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 209526E6AFF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 19:29:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232488AbjDRR3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 13:29:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231877AbjDRR3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 13:29:45 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8DFB93D8;
        Tue, 18 Apr 2023 10:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681838983; x=1713374983;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=61V/qAwqnBFdBOqNk/oS9bVHtvIe8KLKP/DdJwKdTEM=;
  b=RVk0JmVY7d9FPd20YEeP1Z882+ucTF5CCjzoYQF+IM/nMP9jlzB7sOQy
   txmDEKEIdWrPzeAsdhODJlkVMTDdBGxNfg9h88hPn5QrsYskPYeDBNA5p
   gwUKICQWcEA02UoU5N7/i2Cif+GAASDJi1Tp8dISfQGGEdZezRcLSZLOh
   0FYUkUscga1zWFsYH6qD9/ds6kq4frH3VG6EHQWqrGifgSStkENLtzIqC
   0Zqq12sjGHcw8UDTSGBH7nUVQ5fd2LrQp5TjEX+u7iXbJr8e9jyn2e0gJ
   Q4qzYfP/FfLP5pRrQwxDlb/xm+CX/Pm9NccHA/YIk1z1P0ZVrhmsadSXH
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="334044432"
X-IronPort-AV: E=Sophos;i="5.99,207,1677571200"; 
   d="scan'208";a="334044432"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 10:29:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="668648225"
X-IronPort-AV: E=Sophos;i="5.99,207,1677571200"; 
   d="scan'208";a="668648225"
Received: from dinguyen-mobl1.amr.corp.intel.com (HELO [10.213.190.103]) ([10.213.190.103])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 10:29:41 -0700
Message-ID: <a1a34c32-dbd4-7a77-ab7e-5e34af85900f@linux.intel.com>
Date:   Tue, 18 Apr 2023 12:29:40 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 3/5] hwmon: (socfpga) Add hardware monitoring support on
 SoCFPGA platforms
Content-Language: en-US
To:     Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org
Cc:     dinguyen@kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-kernel@vger.kernel.org, jdelvare@suse.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <20230410153314.27127-1-dinh.nguyen@linux.intel.com>
 <20230410153314.27127-3-dinh.nguyen@linux.intel.com>
 <09730359-8731-e21e-3335-bf60ba7f1280@roeck-us.net>
 <a3e966f8-8e9d-7081-1665-9d2e87acb310@linux.intel.com>
 <8d158880-1e6a-5fdd-dae7-a7647794eb60@roeck-us.net>
From:   Dinh Nguyen <dinh.nguyen@linux.intel.com>
In-Reply-To: <8d158880-1e6a-5fdd-dae7-a7647794eb60@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/17/2023 4:51 PM, Guenter Roeck wrote:
> On 4/17/23 13:55, Dinh Nguyen wrote:
>>
>> On 4/10/2023 9:44 PM, Guenter Roeck wrote:
>>> On 4/10/23 08:33, dinh.nguyen@linux.intel.com wrote:
>>>> From: Dinh Nguyen <dinh.nguyen@linux.intel.com>
>>>>
>>>> The driver supports 64-bit SoCFPGA platforms for temperature and 
>>>> voltage
>>>> reading using the platform's SDM(Secure Device Manager). The driver
>>>> also uses the Stratix10 Service layer driver.
>>>>
>>>> This driver only supports OF SoCFPGA 64-bit platforms.
>>>>
>>>> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>>>> Signed-off-by: Dinh Nguyen <dinh.nguyen@linux.intel.com>
>>>> ---
>>>>   Documentation/hwmon/index.rst                 |   1 +
>>>>   Documentation/hwmon/socfpga-hwmon.rst         |  30 ++
>>>>   drivers/firmware/stratix10-svc.c              |  18 +-
>>>
>>> Changes outside the hwmon subsystem need to be in a separate patch.
>>
>> will separate...
>>
>>>
>>>> drivers/hwmon/Kconfig |  11 +
>>>>   drivers/hwmon/Makefile                        |   1 +
>>>>   drivers/hwmon/socfpga-hwmon.c                 | 406 
>>>> ++++++++++++++++++
>>>>   include/linux/firmware/intel/stratix10-smc.h  |  34 ++
>>>>   .../firmware/intel/stratix10-svc-client.h     |   6 +
>>>>   8 files changed, 506 insertions(+), 1 deletion(-)
>>>>   create mode 100644 Documentation/hwmon/socfpga-hwmon.rst
>>>>   create mode 100644 drivers/hwmon/socfpga-hwmon.c
>>>>
>>>>
>> ...
>>>> +
>>>> +enum hwmon_type_op {
>>>> +    SOCFPGA_HWMON_TYPE_TEMP,
>>>> +    SOCFPGA_HWMON_TYPE_VOLT,
>>>> +    SOCFPGA_HWMON_TYPE_MAX
>>>
>>> Unused define
>>
>> Removed.
>>
>>>
>>>> +};
>>>> +
>>>> +static const char *const hwmon_types_str[] = { "temperature", 
>>>> "voltage" };
>>>> +
>>>> +static umode_t socfpga_is_visible(const void *dev,
>>>> +                  enum hwmon_sensor_types type,
>>>> +                  u32 attr, int chan)
>>>> +{
>>>> +    switch (type) {
>>>> +    case hwmon_temp:
>>>> +    case hwmon_in:
>>>> +        return 0444;
>>>> +    default:
>>>> +        return 0;
>>>> +    }
>>>> +}
>>>> +
>>>> +static void socfpga_smc_callback(struct stratix10_svc_client *client,
>>>> +                      struct stratix10_svc_cb_data *data)
>>>> +{
>>>> +    struct socfpga_hwmon_priv *priv = client->priv;
>>>> +    struct arm_smccc_res *res = data->kaddr1;
>>>> +
>>>> +    if (data->status == BIT(SVC_STATUS_OK))    {
>>>> +        if (priv->msg.command == COMMAND_HWMON_READTEMP)
>>>> +            priv->temperature.value = res->a0;
>>>> +        else
>>>> +            priv->voltage.value = res->a0;
>>>> +    } else
>>>> +        dev_err(client->dev, "%s returned 0x%lX\n", __func__, 
>>>> res->a0);
>>>> +
>>>
>>> Missing { } in else branch. Please run checkpatch --strict and fix
>>> continuation line alignment issues as well as unbalanced if/else
>>> reports.
>> Will do.
>>>
>>>> + complete(&priv->completion);
>>>> +}
>>>> +
>>>> +static int socfpga_hwmon_send(struct socfpga_hwmon_priv *priv)
>>>> +{
>>>> +    int ret;
>>>> +
>>>> +    priv->client.receive_cb = socfpga_smc_callback;
>>>> +
>>>> +    ret = stratix10_svc_send(priv->chan, &priv->msg);
>>>> +    if (ret < 0)
>>>> +        return ret;
>>>> +
>>>> +    if (!wait_for_completion_timeout(&priv->completion, 
>>>> HWMON_TIMEOUT)) {
>>>> +        dev_err(priv->client.dev, "SMC call timeout!\n");
>>>> +        return -ETIMEDOUT;
>>>> +    }
>>>> +
>>>> +    return 0;
>>>> +}
>>>> +
>>>> +static int socfpga_hwmon_err_to_errno(struct socfpga_hwmon_priv 
>>>> *priv)
>>>> +{
>>>> +    int value = priv->temperature.value;
>>>> +
>>>> +    if (!(value & ETEMP_ERROR))
>>>> +        return 0;
>>>> +
>>>
>>> This is odd. int is normally 32 bit, this function is called from
>>> socfpga_read() for temperatures, which presumably are defined
>>> as "signed 32-bit fixed point binary". That means that negative
>>> temperatures would be treated as errors. Please verify.
>>
>> That's correct, if bit 31 is set, then it indicates an error.
>>
>
> This ...
>
>>>
>>>> +    dev_err(priv->client.dev, "temperature sensor code 0x%08x\n", 
>>>> value);
>>>> +
>>>
>>> Please don't clog the log with such messages.
>>
>> Removed.
>>
>>>
>>>> +    value &= ~ETEMP_ERROR;
>>>> +    switch (value) {
>>>> +    case ETEMP_NOT_PRESENT:
>>>> +        return -ENOENT;
>>>> +    case ETEMP_CORRUPT:
>>>> +    case ETEMP_NOT_INITIALIZED:
>>>> +        return -ENODATA;
>>>> +    case ETEMP_BUSY:
>>>> +        return -EBUSY;
>>>> +    case ETEMP_INACTIVE:
>>>> +    case ETEMP_TIMEOUT:
>>>> +    case ETEMP_TOO_OLD:
>>>> +        return -EAGAIN;
>>>> +    default:
>>>> +        /* Unknown error */
>>>> +        return -EINVAL;
>>>
>>> Should be -EIO.
>>>
>> Replaced.
>>>> +    }
>>>> +}
>>>> +
>>>> +static int socfpga_read(struct device *dev, enum 
>>>> hwmon_sensor_types type,
>>>> +            u32 attr, int chan, long *val)
>>>> +{
>>>> +    struct socfpga_hwmon_priv *priv = dev_get_drvdata(dev);
>>>> +    int ret;
>>>> +
>>>> +    mutex_lock(&priv->lock);
>>>> +    reinit_completion(&priv->completion);
>>>> +
>>>> +    switch (type) {
>>>> +    case hwmon_temp:
>>>> +        priv->msg.arg[0] = BIT_ULL(priv->temperature.chan[chan]);
>>>> +        priv->msg.command = COMMAND_HWMON_READTEMP;
>>>> +        if (socfpga_hwmon_send(priv))
>>>> +            goto status_done;
>>>> +
>>>> +        ret = socfpga_hwmon_err_to_errno(priv);
>>>> +        if (ret)
>>>> +            break;
>>>> +        /*
>>>> +         * The Temperature Sensor IP core returns the Celsius
>>>> +         * temperature value in signed 32-bit fixed point binary
>
> ... and this contradict each other. If bit 31 indicates an error,
> this can not be a signed 32-bit value.
>
You're right! I've re-read the spec and should have the the code look 
for the specific error values:

0x80000000 - inactive

0x80000001 - old value

0x80000002 - invalid channel

0x80000003 -  corrupted.

...

Dinh

