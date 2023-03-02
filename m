Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F1296A8352
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 14:17:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbjCBNRL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 08:17:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjCBNRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 08:17:10 -0500
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52C8338B46;
        Thu,  2 Mar 2023 05:17:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
        s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=OSGo8od9/vvLzXzkl3lpRBXCnyJUu3KOtGdrSgduc+I=; b=lXFObTFlAUfcMFAcgGY34eRrdX
        SK1qEVmYwzNAUCKZu/71M5QpprxdunY2xknX0+PPyymLmylKPHTM66CleDxT1E3pJ3nyrR0xqr/wW
        JvBZV0+B+vm+DHGOynXAbf1Na1sRw0YdYM5EXmReRY5EWloctuiMnffnQsnYnrOB6OvltLWqNgQSS
        2uFfhjxxQENtGpyf8r1+TwhuwIzHR8mZlhX5cnqN6x8+IuK8dwnTcbaV5h+qJjj/bcqhIvcEAYDTu
        Q4PS6AlG3BsoqqJRui+63lAzCgPadUGrlV9v+vx5gNm2WoilGojhXT6WAHGOXPoqKlNO/u6Q4SUH2
        YlfzGK7g==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www381.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <lars@metafoo.de>)
        id 1pXins-000MgE-9B; Thu, 02 Mar 2023 14:17:00 +0100
Received: from [2604:5500:c0e5:eb00:da5e:d3ff:feff:933b]
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1pXinr-000C9C-Ou; Thu, 02 Mar 2023 14:16:59 +0100
Message-ID: <87bc192e-45ae-9480-5e84-8fe0adfc12e7@metafoo.de>
Date:   Thu, 2 Mar 2023 05:16:54 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v3 2/2] iio: adc: Add TI ADS1100 and ADS1000
Content-Language: en-US
To:     Mike Looijmans <mike.looijmans@topic.nl>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        Caleb Connolly <caleb.connolly@linaro.org>,
        ChiYuan Huang <cy_huang@richtek.com>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        linux-kernel@vger.kernel.org
References: <20230228063151.17598-1-mike.looijmans@topic.nl>
 <20230228063151.17598-2-mike.looijmans@topic.nl>
 <Y/9vez/fzLD5dRVF@smile.fi.intel.com>
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.0685d97e-4a28-499e-a9e3-3bafec126832@emailsignatures365.codetwo.com>
 <a2ba706f-888b-0a72-03a5-cbf761dfaf19@topic.nl>
From:   Lars-Peter Clausen <lars@metafoo.de>
In-Reply-To: <a2ba706f-888b-0a72-03a5-cbf761dfaf19@topic.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.8/26828/Thu Mar  2 07:36:42 2023)
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/1/23 23:49, Mike Looijmans wrote:
>
>
>> ...
>> ...
>>
>>> +static int ads1100_runtime_suspend(struct device *dev)
>>> +{
>>> +    struct iio_dev *indio_dev = 
>>> i2c_get_clientdata(to_i2c_client(dev));
>>> +    struct ads1100_data *data = iio_priv(indio_dev);
>>> +
>>> +    ads1100_set_config_bits(data, ADS1100_CFG_SC, ADS1100_SINGLESHOT);
>>> +    regulator_disable(data->reg_vdd);
>> Wrong devm / non-devm ordering.
>
> Don't understand your remark, can you explain further please?
>
> devm / non-devm ordering would be related to the "probe" function. As 
> far as I can tell, I'm not allocating resources after the devm calls. 
> And the "remove" is empty.

Strictly speaking we need to unregister the IIO device before disabling 
the regulator, otherwise there is a small window where the IIO device 
still exists, but doesn't work anymore. This is a very theoretical 
scenario though.

You are lucky :) There is a new function 
`devm_regulator_get_enable()`[1], which will manage the 
regulator_disable() for you. Using that will also reduce the boilerplate 
in `probe()` a bit

- Lars

[1] https://lwn.net/Articles/904383/

