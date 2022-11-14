Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7F7F628255
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 15:21:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235738AbiKNOVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 09:21:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237069AbiKNOVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 09:21:25 -0500
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 605AB2870E
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 06:21:20 -0800 (PST)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AEECO6l004656;
        Mon, 14 Nov 2022 15:21:04 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=8k8wy4rZLTlTfBDj4MdDZV1ef9nz7sSUdKXYYs2wBxA=;
 b=3cgP44siccOR8Gtf4MAStx1mc5obDx9B8GG3ScNoa4T8x919GMTjtjonh63dbENmLLTv
 Kp6CR3oZKsHEmvxTWGuK53IcITYlOynakZxgOsqj1O7k1HxBAmuFnX8KIrDjxRO+3aWJ
 JrJ/gncO5/lJ/DBVeuPV1b8+pBUWnmnsSNZ7dVmI5zDe7zlR2BDzA/oYafrUCxoPX+oL
 ALYKvhKGxNecuM8aiUTHz/hgKV31b/ZDON8mOHddkyMN+Ae084/5N1LnTu/hheBejzVk
 3k1KeuIOAczZiedjw+UAkqMWixyWi6SjcXkK2L52LyOGoB5CT2YoTXI+imTZl+xMoHjF HA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3kudxqkcub-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Nov 2022 15:21:03 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3EB5E100034;
        Mon, 14 Nov 2022 15:20:57 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 3736123150E;
        Mon, 14 Nov 2022 15:20:57 +0100 (CET)
Received: from [10.48.0.157] (10.48.0.157) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Mon, 14 Nov
 2022 15:20:56 +0100
Message-ID: <814e7d66-4e97-e394-e183-ac174c7298ad@foss.st.com>
Date:   Mon, 14 Nov 2022 15:20:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 2/3] nvmem: stm32: add OP-TEE support for STM32MP13x
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Alexandre TORGUE <alexandre.torgue@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
CC:     Fabrice GASNIER <fabrice.gasnier@foss.st.com>,
        Etienne CARRIERE <etienne.carriere@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <20221110154550.3220800-1-patrick.delaunay@foss.st.com>
 <20221110164329.v2.2.Ibc43aa73f865090affeb1751af0cc260c7f1dd07@changeid>
 <46a5151e-73e4-e1e3-cb3a-7b36ef34221c@linaro.org>
Content-Language: en-US
From:   Patrick DELAUNAY <patrick.delaunay@foss.st.com>
In-Reply-To: <46a5151e-73e4-e1e3-cb3a-7b36ef34221c@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.48.0.157]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-14_12,2022-11-11_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/11/22 18:18, Srinivas Kandagatla wrote:
>
>
> On 10/11/2022 15:45, Patrick Delaunay wrote:
>> For boot with OP-TEE on STM32MP13, the communication with the secure
>> world no more use STMicroelectronics SMC but communication with the
>> BSEC TA, for data access (read/write) or lock operation:
>> - all the request are sent to OP-TEE trusted application,
>> - for upper OTP with ECC protection and with word programming only
>>    each OTP are permanently locked when programmed to avoid ECC error
>>    on the second write operation
>>
>> Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
>> ---
>>
>> Changes in v2:
>> - rebase series on linux-next/master
>> - minor update after V1 revue
>> - add missing sentinel in stm32_romem_of_match()
>> - reorder function and remove prototypes for stm32_bsec_pta... functions
>> - change stm32_bsec_pta_find to static
>> - add return value in dev_err()
>> - cleanups some comments, which can be on one line
>> - remove test on priv->ctx in stm32_bsec_pta_remove
>> - add missing tee_shm_free(shm) in stm32_bsec_pta_write() when
>>    tee_shm_get_va failed
>> - return error in stm32_bsec_pta_find when devm_add_action_or_reset 
>> failed
>> - handle driver_register error in stm32_romem_init
>>
>>   drivers/nvmem/stm32-romem.c | 445 +++++++++++++++++++++++++++++++++++-
>>   1 file changed, 441 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/nvmem/stm32-romem.c b/drivers/nvmem/stm32-romem.c
>> index d1d03c2ad081..0a0e29d09b67 100644
>> --- a/drivers/nvmem/stm32-romem.c
>> +++ b/drivers/nvmem/stm32-romem.c
>> @@ -11,6 +11,7 @@
>>   #include <linux/module.h>
>>   #include <linux/nvmem-provider.h>
>>   #include <linux/of_device.h>
>> +#include <linux/tee_drv.h>
>>     /* BSEC secure service access from non-secure */
>>   #define STM32_SMC_BSEC            0x82001003
>> @@ -25,14 +26,401 @@
>>   struct stm32_romem_cfg {
>>       int size;
>>       u8 lower;
>> +    bool ta;
>>   };
>>     struct stm32_romem_priv {
>>       void __iomem *base;
>>       struct nvmem_config cfg;
>>       u8 lower;
>> +    struct device *ta;
>>   };
>>   +#if IS_ENABLED(CONFIG_OPTEE)
>> +/*
>
> ...
>
>> +
>> +static const struct tee_client_device_id stm32_bsec_id_table[] = {
>> +    {
>> +        UUID_INIT(0x94cf71ad, 0x80e6, 0x40b5,
>> +              0xa7, 0xc6, 0x3d, 0xc5, 0x01, 0xeb, 0x28, 0x03)
>> +    },
>> +    { }
>> +};
>> +
>> +MODULE_DEVICE_TABLE(tee, stm32_bsec_id_table);
>> +
>> +static struct tee_client_driver stm32_bsec_pta_driver = {
>> +    .id_table    = stm32_bsec_id_table,
>> +    .driver        = {
>> +        .name = "stm32-bsec-pta",
>> +        .bus = &tee_bus_type,
>> +        .probe = stm32_bsec_pta_probe,
>> +        .remove = stm32_bsec_pta_remove,
>> +    },
>> +};
>> +
>> +static void stm32_bsec_put_device(void *data)
>> +{
>> +    put_device(data);
>> +}
>> +
>> +static struct device *stm32_bsec_pta_find(struct device *dev)
>> +{
>> +    struct device *pta_dev;
>> +    int ret;
>> +
>> +    pta_dev = driver_find_next_device(&stm32_bsec_pta_driver.driver, 
>> NULL);
>
> This is clearly not representing the dependencies in a proper device 
> model.
>
>
> If the nvmem provider is a TEE client driver lets model it that way.. 
> brining in a additional device and somehow trying to link it with TEE 
> driver is  a hack.
>

TEE is a firmware which allow access to secure ressource... including 
BSEC ressources


I think it is also the case on a other driver = mson_sm.c

=> econfig->priv = fw;

       fw is a handle to the firmware (secure monitor) which provide 
access to secure ressource



BSEC is a hardware device on the bus,

it it describe in the device tree, with a compatible,

the same description should be used for any SW, not only Linux kernel.

and the nvmem cell description are sub-node of BSEC node, used as 
phandle by other device.


I need to have a link between the NVMEM driver and the OP-TEE session;

But I use the tee bus discovery here it is a error,

because that create a second uneeded driver "stm32_bsec_pta_driver"...


I will remove this part, and only kept the PTA request with new lib 
functions "stm32_bsec_pta_XXX()".



>
>> +
>> +    if (pta_dev) {
>> +        ret = devm_add_action_or_reset(dev, stm32_bsec_put_device, 
>> pta_dev);
>> +        if (ret)
>> +            dev_err(dev, "devm_add_action_or_reset() failed (%d)\n", 
>> ret);
>> +
>> +        return ERR_PTR(ret);
>> +    }
>> +
>> +    return pta_dev;
>> +}
>> +
>> +#else
>> +static int stm32_bsec_pta_read(void *context, unsigned int offset, 
>> void *buf,
>> +                   size_t bytes)
>> +{
>> +    pr_debug("%s: TA BSEC request without OPTEE support\n", __func__);
>> +
>> +    return -ENXIO;
>> +}
>> +
>> +static int stm32_bsec_pta_write(void *context, unsigned int offset, 
>> void *buf,
>> +                size_t bytes)
>> +{
>> +    pr_debug("%s: TA BSEC request without OPTEE support\n", __func__);
>> +
>> +    return -ENXIO;
>> +}
>> +
>> +static struct device *stm32_bsec_pta_find(struct device *dev)
>> +{
>> +    pr_debug("%s: TA BSEC request without OPTEE support\n", __func__);
>> +
>> +    return NULL;
>> +}
>> +#endif
>
> ifdefing inside the drvier is really ugly, please move this libary 
> functions to a seperate file and add dependecy properly in Kconfig.


Ok

regards


Patrick

