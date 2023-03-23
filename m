Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 814F46C6920
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 14:08:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230476AbjCWNIQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 09:08:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbjCWNIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 09:08:13 -0400
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39F8A3252C;
        Thu, 23 Mar 2023 06:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
        s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=lR1kDIljz9mk7Z+jDAJ/8E94RHyMpc5juD6t09t1Rmg=; b=hLswf0FCCx4LsTAvIbxpnyG0Fn
        Wv+ItuF8s9mAtJKBa1e55GOYLjGevgIor3tw1RV6vwIy5/qgLL7VmUoCVM+vxo8GY4+a9FRBByd25
        kAnn++9xwOb/2NUSaEREDgVr74l7/foAwcxWCrhvomPwexE6rRB+MG4Qq8dO5FctH73bywrbLCvFR
        kuPwosmAfB4PQU3IeSrG4dpx/pn2t1pLShK4QcQETe2Q9jjvYTEx6ni+XqtD9VM/dp7ccYBbqOqLc
        gB/rK12bQ1s8OKBPlOWwt4osLYW9jmqMkAjWEwdisWVp6L7WBUjNbs+VyvU0/VcqqcCbzhlXMjURn
        XxUTQZ5w==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www381.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <lars@metafoo.de>)
        id 1pfKfM-000FK5-9O; Thu, 23 Mar 2023 14:07:40 +0100
Received: from [2604:5500:c0e5:eb00:da5e:d3ff:feff:933b]
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1pfKfL-0000WK-Tm; Thu, 23 Mar 2023 14:07:40 +0100
Message-ID: <65b08184-0c6b-0a43-df80-4d5ae537a709@metafoo.de>
Date:   Thu, 23 Mar 2023 06:07:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 1/2] iio: max597x: Add support for max597x
Content-Language: en-US
To:     Naresh Solanki <naresh.solanki@9elements.com>,
        Lee Jones <lee@kernel.org>, Jonathan Cameron <jic23@kernel.org>
Cc:     Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
References: <20230322124316.2147143-1-Naresh.Solanki@9elements.com>
 <826f5de9-3aeb-6f7a-59e6-0504f8e92180@metafoo.de>
 <34756312-8a25-5a10-4ea5-59aeeb9e199b@9elements.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
In-Reply-To: <34756312-8a25-5a10-4ea5-59aeeb9e199b@9elements.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.8/26852/Thu Mar 23 08:22:35 2023)
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/23/23 05:01, Naresh Solanki wrote:
> Hi,
>
> On 22-03-2023 09:28 pm, Lars-Peter Clausen wrote:
>> Hi,
>>
>> This looks really good. A few minor comments inline.
>>
>> On 3/22/23 05:43, Naresh Solanki wrote:
>>> [...]
>>> +static int max597x_iio_read_raw(struct iio_dev *iio_dev,
>>> +                struct iio_chan_spec const *chan,
>>> +                int *val, int *val2, long info)
>>> +{
>>> +    int ret;
>>> +    struct max597x_iio *data = iio_priv(iio_dev);
>>> +    unsigned int reg_l, reg_h;
>>> +
>>> +    switch (info) {
>>> +    case IIO_CHAN_INFO_RAW:
>>> +        ret = regmap_read(data->regmap, chan->address, &reg_l);
>>> +        if (ret < 0)
>>> +            return ret;
>>> +        ret = regmap_read(data->regmap, chan->address - 1, &reg_h);
>>> +        if (ret < 0)
>>> +            return ret;
>> Is there any chance of a race condition of getting inconsistent data 
>> when splitting this over two reads? I.e. registers being updated with 
>> new values in between the two reads.
> yes, reg_l holds lower 2 bits. due to latency in reads, value may differ.
>>> +        *val = (reg_h << 2) | (reg_l & 3);
>>> +
>>> +        return IIO_VAL_INT;
>>> +    case IIO_CHAN_INFO_SCALE:
>>> +
>>> +        switch (chan->address) {
>>> +        case MAX5970_REG_CURRENT_L(0):
>>> +            fallthrough;
>>
>> `fallthrough` should not be needed for multiple case statements right 
>> on top of each other with no code in between. Same below
> Sure.
>>
>>> +        case MAX5970_REG_CURRENT_L(1):
>>> +            /* in A, convert to mA */
>>> +            *val = data->irng[chan->channel] * 1000;
>>> +            *val2 =
>>> +                data->shunt_micro_ohms[chan->channel] * ADC_MASK;
>> ADC_MASK should really have a MAX5970_ prefix, but I guess it is 
>> defined in max597x.h
> Yes its taken from max597x.h
>>> +            return IIO_VAL_FRACTIONAL;
>>> +
>>> +        case MAX5970_REG_VOLTAGE_L(0):
>>> +            fallthrough;
>>> +        case MAX5970_REG_VOLTAGE_L(1):
>>> +            /* in uV, convert to mV */
>>> +            *val = data->mon_rng[chan->channel];
>>> +            *val2 = ADC_MASK * 1000;
>>> +            return IIO_VAL_FRACTIONAL;
>>> +        }
>>> +
>>> +        break;
>>> +    }
>>> +    return -EINVAL;
>>> +}
>>> [..]
>>> +static int max597x_iio_probe(struct platform_device *pdev)
>>> +{
>>> +    struct max597x_data *max597x = dev_get_drvdata(pdev->dev.parent);
>>> +    struct i2c_client *i2c = to_i2c_client(pdev->dev.parent);
>>> +    struct regmap *regmap = dev_get_regmap(pdev->dev.parent, NULL);
>>> +    struct iio_dev *indio_dev;
>>> +    struct max597x_iio *priv;
>>> +    int ret, i;
>>> +
>>> +    if (!regmap)
>>> +        return -EPROBE_DEFER;
>>> +
>>> +    if (!max597x || !max597x->num_switches)
>>> +        return -EPROBE_DEFER;
>>> +
>>> +    /* registering iio */
>>> +    indio_dev = devm_iio_device_alloc(&i2c->dev, sizeof(*priv));
>> For the devm allocations we should be using &pdev->dev and not the 
>> I2C device, since this is the device to which the allocations belong 
>> and where they should be freed when the device is removed.
> Sure. Will use &pdev->dev
>>> +    if (!indio_dev) {
>>> +        dev_err(&i2c->dev, "failed allocating iio device\n");
>> Consider using dev_err_probe() for error message printing. This will 
>> give a consistent formatting of the messages. Also again use 
>> &pdev->dev instead of I2C device to get the right device listed in 
>> the error messages.
> Sure. Will use
> dev_err_probe(&pdev->dev, ret, "could not register iio device");
>>> +        return -ENOMEM;
>>> +    }
>>> +    indio_dev->name = dev_name(&i2c->dev);
>> The IIO ABI wants the type of the chip for the name. E.g. "max5970", 
>> using dev_name() of the parent I2C device will result in something else.
> Sure. Will make it:
> indio_dev->name = dev_name(&pdev->dev);
>
dev_name() in general should not be used for indio_dev->name, it does 
not meet the ABI requirements for the IIO ABI. Move this into the switch 
block below and then assign "max5970" or "max5978" depending on the 
device type.


