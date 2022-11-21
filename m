Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8038D632C94
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 20:03:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230513AbiKUTDH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 14:03:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbiKUTDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 14:03:04 -0500
Received: from smtp.smtpout.orange.fr (smtp-28.smtpout.orange.fr [80.12.242.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E25AA1B791
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 11:03:01 -0800 (PST)
Received: from [192.168.1.18] ([86.243.100.34])
        by smtp.orange.fr with ESMTPA
        id xC4IoUqnv1SdMxC4IoKsmk; Mon, 21 Nov 2022 20:02:59 +0100
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 21 Nov 2022 20:02:59 +0100
X-ME-IP: 86.243.100.34
Message-ID: <23c26121-6827-fef2-d9b6-6e64000d006f@wanadoo.fr>
Date:   Mon, 21 Nov 2022 20:02:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v4 3/3] interconnect: qcom: Add QDU1000/QRU1000
 interconnect driver
To:     Melody Olvera <quic_molvera@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org,
        christophe.jaillet@wanadoo.fr, devicetree@vger.kernel.org,
        djakov@kernel.org, konrad.dybcio@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        quic_okukatla@quicinc.com, robh+dt@kernel.org
References: <20221118182245.31035-1-quic_molvera@quicinc.com>
 <20221118182245.31035-4-quic_molvera@quicinc.com>
 <6b68b7c2-e070-0a88-35ee-2060dcbdee91@wanadoo.fr>
 <76219489-99cc-7f2e-7df6-b11f6a2c1933@quicinc.com>
Content-Language: fr, en-GB
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <76219489-99cc-7f2e-7df6-b11f6a2c1933@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 21/11/2022 à 18:55, Melody Olvera a écrit :
> 
> 
> On 11/20/2022 6:19 AM, Christophe JAILLET wrote:
>> Le 18/11/2022 à 19:22, Melody Olvera a écrit :
>>> Add interconnect provider driver for Qualcomm QDU1000 and QRU1000
>>> platforms.
>>>
>>> Signed-off-by: Melody Olvera <quic_molvera-jfJNa2p1gH1BDgjK7y7TUQ@public.gmane.org>
>>> ---
>>>    drivers/interconnect/qcom/Kconfig   |    9 +
>>>    drivers/interconnect/qcom/Makefile  |    2 +
>>>    drivers/interconnect/qcom/qdu1000.c | 1079 +++++++++++++++++++++++++++
>>>    drivers/interconnect/qcom/qdu1000.h |   95 +++
>>>    4 files changed, 1185 insertions(+)
>>>    create mode 100644 drivers/interconnect/qcom/qdu1000.c
>>>    create mode 100644 drivers/interconnect/qcom/qdu1000.h
>>>
>>
>> [...]
>>
>>> +static int qnoc_probe(struct platform_device *pdev)
>>> +{
>>> +    int ret;
>>> +
>>> +    ret = qcom_icc_rpmh_probe(pdev);
>>> +    if (ret)
>>> +        dev_err(&pdev->dev, "failed to register ICC provider\n");
>>> +
>>> +    return ret;
>>> +}
>>> +
>>> +static int qnoc_remove(struct platform_device *pdev)
>>> +{
>>> +    struct qcom_icc_provider *qp = platform_get_drvdata(pdev);
>>> +
>>> +    icc_nodes_remove(&qp->provider);
>>> +    icc_provider_del(&qp->provider);
>>
>> qcom_icc_rpmh_remove()?
>>
>> (more future proof, less verbose and more consistent with qcom_icc_rpmh_probe() in the probe)
>>
>> CJ
> 
> Good call. Does it make sense to just set the .probe and .remove functions as
> qcom_icc_rpmh_probe() and qcom_icc_rpmh_remove(), respectively? Probe function
> is just reporting if qcom_icc_rpmh_probe fails.

I guess it is fine to remove qcom_icc_rpmh_probe() and 
qcom_icc_rpmh_remove().

I've already seen such pattern in some other drivers.


But this is just the point of view of someone who never wrote a driver 
himself :)

So let see if a maintainer gives his POV.

CJ

> 
> Thanks,
> Melody
>>
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +static const struct of_device_id qnoc_of_match[] = {
>>> +    { .compatible = "qcom,qdu1000-clk-virt",
>>> +      .data = &qdu1000_clk_virt
>>> +    },
>>> +    { .compatible = "qcom,qdu1000-gem-noc",
>>> +      .data = &qdu1000_gem_noc
>>> +    },
>>> +    { .compatible = "qcom,qdu1000-mc-virt",
>>> +      .data = &qdu1000_mc_virt
>>> +    },
>>> +    { .compatible = "qcom,qdu1000-system-noc",
>>> +      .data = &qdu1000_system_noc
>>> +    },
>>> +    { }
>>> +};
>>> +MODULE_DEVICE_TABLE(of, qnoc_of_match);
>>> +
>>> +static struct platform_driver qnoc_driver = {
>>> +    .probe = qnoc_probe,
>>> +    .remove = qnoc_remove,
>>> +    .driver = {
>>> +        .name = "qnoc-qdu1000",
>>> +        .of_match_table = qnoc_of_match,
>>> +    },
>>> +};
>>
>> [...]
>>
> 
> 

