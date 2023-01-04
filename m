Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 271BE65D3A4
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 14:03:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232042AbjADNCh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 08:02:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234317AbjADNCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 08:02:33 -0500
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 433DB1006F
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 05:02:32 -0800 (PST)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 304BSjNk022820;
        Wed, 4 Jan 2023 14:02:25 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=hgiH8ltvo3OuQOLuGkA7ONnzC2YMWMCv1OtKzJek1ws=;
 b=6bsxQLK2yftNt0pXES8+NJ6SrqExZsfawwjh1CsuiLRABNICsHIOWX3fZKSlNrgzGSbK
 b8qFBdDz6c/5r+YuFe7RQe69XgkFIQPpkbmz6cUVSsg5eGyV/sRBwv321KqnD2JBmyw1
 oTXxS5v2uaL2Zoo4YiTo6r/a2kCyfVjZrF7r2sLyRSPmtkpkPx5FcyHMwhbRYodsZvhU
 pRyD1NF9httxSODfZxO61uXUEslqajhOvv8YO0AG/uoXwXcAdXxfuMisM8ilXdPirFkm
 WWxst5NNeKzTRsVbDzwucHl75y3CULL8Fwh1IupMteVPZYUGiFFi72kzK9nfL/t32aYv 6g== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3mtda6apaq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Jan 2023 14:02:25 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id DE27710002A;
        Wed,  4 Jan 2023 14:02:24 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D80C521D387;
        Wed,  4 Jan 2023 14:02:24 +0100 (CET)
Received: from [10.48.0.157] (10.48.0.157) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.13; Wed, 4 Jan
 2023 14:02:21 +0100
Message-ID: <5d7dac5f-2a39-316f-2123-fe2e7808eec0@foss.st.com>
Date:   Wed, 4 Jan 2023 14:02:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v4 3/3] nvmem: stm32: detect bsec pta presence for
 STM32MP15x
Content-Language: en-US
To:     Etienne Carriere <etienne.carriere@linaro.org>
CC:     Alexandre TORGUE <alexandre.torgue@foss.st.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Lionel DEBIEVE <lionel.debieve@foss.st.com>,
        Amelie DELAUNAY <amelie.delaunay@foss.st.com>,
        Fabrice GASNIER <fabrice.gasnier@foss.st.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <20230103140521.187678-1-patrick.delaunay@foss.st.com>
 <20230103150515.v4.3.I59210046e368cfc22bd3cca2afe1653674f8ece8@changeid>
 <CAN5uoS-dXLSs9DiJFBTAOJbPZPp4BUfxqZ7ND_irzBbUEwaUHg@mail.gmail.com>
From:   Patrick DELAUNAY <patrick.delaunay@foss.st.com>
In-Reply-To: <CAN5uoS-dXLSs9DiJFBTAOJbPZPp4BUfxqZ7ND_irzBbUEwaUHg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.48.0.157]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-04_07,2023-01-04_02,2022-06-22_01
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 1/4/23 10:30, Etienne Carriere wrote:
> Hi Patrick,
>
> On Tue, 3 Jan 2023 at 15:08, Patrick Delaunay
> <patrick.delaunay@foss.st.com> wrote:
>> On STM32MP15x SoC, the SMC backend is optional when OP-TEE is used;
>> the PTA BSEC should be used as it is done on STM32MP13x platform,
>> but the BSEC SMC can be also used: it is a legacy mode in OP-TEE,
>> not recommended but used in previous OP-TEE firmware.
>>
>> The presence of OP-TEE is dynamically detected in STM32MP15x device tree
>> and the supported NVMEM backend is dynamically detected:
>> - PTA with stm32_bsec_pta_find
>> - SMC with stm32_bsec_check
>>
>> With OP-TEE but without PTA and SMC detection, the probe is deferred for
>> STM32MP15x devices.
>>
>> On STM32MP13x platform, only the PTA is supported with cfg->ta = true
>> and this detection is skipped.
>>
>> Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
>> ---
>>
>> (no changes since v3)
>>
>> Changes in v3:
>> - use of_find_compatible_node in optee_presence_check function
>>    instead of of_find_node_by_path("/firmware/optee")
>>
>> Changes in v2:
>> - Added patch in the serie for BSEC PTA support on STM32MP15x
>>    with dynamic detection of OP-TEE presence and SMC support (legacy mode)
>>
>>   drivers/nvmem/stm32-romem.c | 33 +++++++++++++++++++++++++++++++--
>>   1 file changed, 31 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/nvmem/stm32-romem.c b/drivers/nvmem/stm32-romem.c
>> index 2edc61925e52..1b90c78301fa 100644
>> --- a/drivers/nvmem/stm32-romem.c
>> +++ b/drivers/nvmem/stm32-romem.c
>> @@ -159,6 +159,31 @@ static int stm32_bsec_pta_write(void *context, unsigned int offset, void *buf,
>>          return stm32_bsec_optee_ta_write(priv->ctx, priv->lower, offset, buf, bytes);
>>   }
>>
>> +static bool stm32_bsec_smc_check(void)
>> +{
>> +       u32 val;
>> +       int ret;
>> +
>> +       /* check that the OP-TEE support the BSEC SMC (legacy mode) */
>> +       ret = stm32_bsec_smc(STM32_SMC_READ_SHADOW, 0, 0, &val);
>> +
>> +       return !ret;
>> +}
>> +
>> +static bool optee_presence_check(void)
>> +{
>> +       struct device_node *np;
>> +       bool tee_detected = false;
>> +
>> +       /* check that the OP-TEE node is present and available. */
>> +       np = of_find_compatible_node(NULL, NULL, "linaro,optee-tz");
>> +       if (np && of_device_is_available(np))
>> +               tee_detected = true;
>> +       of_node_put(np);
>> +
>> +       return tee_detected;
>> +}
>> +
>>   static int stm32_romem_probe(struct platform_device *pdev)
>>   {
>>          const struct stm32_romem_cfg *cfg;
>> @@ -195,10 +220,14 @@ static int stm32_romem_probe(struct platform_device *pdev)
>>          } else {
>>                  priv->cfg.size = cfg->size;
>>                  priv->lower = cfg->lower;
>> -               if (cfg->ta) {
>> +               if (cfg->ta || optee_presence_check()) {
>>                          rc = stm32_bsec_optee_ta_open(&priv->ctx);
>>                          /* wait for OP-TEE client driver to be up and ready */
>> -                       if (rc)
>> +                       if (rc == -EPROBE_DEFER) {
>> +                               /* BSEC PTA is required or SMC not ready */
>> +                               if (cfg->ta || !stm32_bsec_smc_check())
>> +                                       return -EPROBE_DEFER;
>> +                       } else if (rc)
> Could you fix the logic? The sequence here fails to fallback to BSEC
> SMC service if optee does not embed BSEC PTA service and optee driver
> is probed before stm32_romem.


Yes, I will modify it...


my patch is working only if OP-TEE is probed after BSEC NVMEM when RC = 
defered


stm32_bsec_smc_check() is  not called the OP-TEE is already porbed

(not deferred) but TA is not integrated


>
> Br,
> etienne
>
>>                                  return rc;
>>                          rc = devm_add_action_or_reset(dev, stm32_bsec_optee_ta_close, priv->ctx);
>>                          if (rc) {
>> --
>> 2.25.1
>>
