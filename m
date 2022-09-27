Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD9C15EBCF2
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 10:14:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbiI0IOp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 04:14:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230240AbiI0IOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 04:14:10 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54FB0B2844;
        Tue, 27 Sep 2022 01:10:43 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28R7k3xu015658;
        Tue, 27 Sep 2022 10:10:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=+izqeZwcaypPBofmCEZkVnT2iabBldmAgNVtUVdiuP4=;
 b=d9P4xa7j4G66l134D0N8EQk22/NG0JF7zteNrfTP8wirftZHoOWwej8KIoTEu0k5Siqf
 JoFkvpsOxMLaYdM0xYsssvw77cogFY2Yfx4N3BMuKEPkPexgv0xyDBuM8983ja639dD8
 ayYfSQZxT+NLWTiMG/roekY5YJhBZT2qkyf4xQIMBuXtI5FCd3Tk7EUNc9FxbSmHuG9b
 xezrSkcEadFIwxrvU69biYQGbX1bmNjO5QODqtqdCTpYd2xdtf7IIMUzEorPOnPKIdVD
 g/DrE1IxNOTyL9pJvD0xN+EvLT+wWX0TnHUgPpklY0jNSQH05YzZSt6pGjRiePDL5ogj cw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3jsrsjgjgu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Sep 2022 10:10:34 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id EEA6710002A;
        Tue, 27 Sep 2022 10:10:32 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id E620D216EC0;
        Tue, 27 Sep 2022 10:10:32 +0200 (CEST)
Received: from [10.211.7.217] (10.75.127.50) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2375.31; Tue, 27 Sep
 2022 10:10:31 +0200
Message-ID: <6aae3d16-0570-793d-4bf8-0a0fddb00be9@foss.st.com>
Date:   Tue, 27 Sep 2022 10:10:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V7 2/2] remoteproc: support attach recovery after rproc
 crash
Content-Language: en-US
To:     Peng Fan <peng.fan@nxp.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        Bjorn Andersson <andersson@kernel.org>
CC:     "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220705011527.2849057-1-peng.fan@oss.nxp.com>
 <20220705011527.2849057-3-peng.fan@oss.nxp.com>
 <20220926220610.GA2817947@p14s>
 <DU0PR04MB941767AEDD07DBA7E7FF9B6E88559@DU0PR04MB9417.eurprd04.prod.outlook.com>
From:   Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
In-Reply-To: <DU0PR04MB941767AEDD07DBA7E7FF9B6E88559@DU0PR04MB9417.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-27_02,2022-09-22_02,2022-06-22_01
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/27/22 05:03, Peng Fan wrote:
> Hi Mathieu,
> 
>> Subject: Re: [PATCH V7 2/2] remoteproc: support attach recovery after rproc
>> crash
>>
>> On Tue, Jul 05, 2022 at 09:15:27AM +0800, Peng Fan (OSS) wrote:
>>> From: Peng Fan <peng.fan@nxp.com>
>>>
>>> Current logic only support main processor to stop/start the remote
>>> processor after crash. However to SoC, such as i.MX8QM/QXP, the remote
>>> processor could do attach recovery after crash and trigger watchdog to
>>> reboot itself. It does not need main processor to load image, or
>>> stop/start remote processor.
>>>
>>> Introduce two functions: rproc_attach_recovery, rproc_boot_recovery
>>> for the two cases. Boot recovery is as before, let main processor to
>>> help recovery, while attach recovery is to recover itself without help.
>>> To attach recovery, we only do detach and attach.
>>>
>>> Acked-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
>>> Signed-off-by: Peng Fan <peng.fan@nxp.com>
>>> ---
>>>  drivers/remoteproc/remoteproc_core.c | 62
>>> +++++++++++++++++++---------
>>>  1 file changed, 43 insertions(+), 19 deletions(-)
>>>
>>> diff --git a/drivers/remoteproc/remoteproc_core.c
>>> b/drivers/remoteproc/remoteproc_core.c
>>> index ed374c8bf14a..ef5b9310bc83 100644
>>> --- a/drivers/remoteproc/remoteproc_core.c
>>> +++ b/drivers/remoteproc/remoteproc_core.c
>>> @@ -1884,6 +1884,45 @@ static int __rproc_detach(struct rproc *rproc)
>>>  	return 0;
>>>  }
>>>
>>> +static int rproc_attach_recovery(struct rproc *rproc) {
>>> +	int ret;
>>> +
>>> +	ret = __rproc_detach(rproc);
>>> +	if (ret)
>>> +		return ret;
>>
>> I thought there was a specific reason to _not_ call rproc->ops->coredump()
>> for processors that have been attached to but looking at the STM32 and
>> IMX_DSP now, it would seem logical to do so.  Am I missing something?
> 
> ATTACH RECOVERY is to support recovery without help from Linux,
> 
> STM32 and IMX_DSP, both require linux to load image and start remote
> core. So the two cases should not enable feature:
> RPROC_FEAT_ATTACH_ON_RECOVERY
> 
> Also considering the recovery is out of linux control, actually when linux
> start dump, remote core may already recovered. 

I asked myself the same question. Indeed how to manage a core dump if the
remote processor restarts autonomously.
The answer doesn't seem obvious because it seems to be platform specific.

For time being on STM32 we consider that the remoteproc memory can be corrupted
so we don't plan to enable the feature by default even if the hardware allows it.

If we implement it, I would see 2 use cases:
- no core dump, the remote processor restart autonomously (need to manage the
VIRTIO_CONFIG_S_NEEDS_RESET in resource table vdev for resynchronization)
- core dump and the Linux stm32 driver handle the reset of the remote
processor core to be able to perform the core dump (no firmware loading)

What about dealing with the coredump in a separate thread, based on a concrete
use case/need?

Regards,
Arnaud
 
> 
>>
>> And this set will need a rebase.
> 
> I'll do the rebase and send V8 if the upper explanation could eliminate
> your concern.
> 
> Thanks,
> Peng.
> 
>>
>> Thanks,
>> Mathieu
>>
>>> +
>>> +	return __rproc_attach(rproc);
>>> +}
>>> +
>>> +static int rproc_boot_recovery(struct rproc *rproc) {
>>> +	const struct firmware *firmware_p;
>>> +	struct device *dev = &rproc->dev;
>>> +	int ret;
>>> +
>>> +	ret = rproc_stop(rproc, true);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	/* generate coredump */
>>> +	rproc->ops->coredump(rproc);
>>> +
>>> +	/* load firmware */
>>> +	ret = request_firmware(&firmware_p, rproc->firmware, dev);
>>> +	if (ret < 0) {
>>> +		dev_err(dev, "request_firmware failed: %d\n", ret);
>>> +		return ret;
>>> +	}
>>> +
>>> +	/* boot the remote processor up again */
>>> +	ret = rproc_start(rproc, firmware_p);
>>> +
>>> +	release_firmware(firmware_p);
>>> +
>>> +	return ret;
>>> +}
>>> +
>>>  /**
>>>   * rproc_trigger_recovery() - recover a remoteproc
>>>   * @rproc: the remote processor
>>> @@ -1898,7 +1937,6 @@ static int __rproc_detach(struct rproc *rproc)
>>>   */
>>>  int rproc_trigger_recovery(struct rproc *rproc)  {
>>> -	const struct firmware *firmware_p;
>>>  	struct device *dev = &rproc->dev;
>>>  	int ret;
>>>
>>> @@ -1912,24 +1950,10 @@ int rproc_trigger_recovery(struct rproc
>>> *rproc)
>>>
>>>  	dev_err(dev, "recovering %s\n", rproc->name);
>>>
>>> -	ret = rproc_stop(rproc, true);
>>> -	if (ret)
>>> -		goto unlock_mutex;
>>> -
>>> -	/* generate coredump */
>>> -	rproc->ops->coredump(rproc);
>>> -
>>> -	/* load firmware */
>>> -	ret = request_firmware(&firmware_p, rproc->firmware, dev);
>>> -	if (ret < 0) {
>>> -		dev_err(dev, "request_firmware failed: %d\n", ret);
>>> -		goto unlock_mutex;
>>> -	}
>>> -
>>> -	/* boot the remote processor up again */
>>> -	ret = rproc_start(rproc, firmware_p);
>>> -
>>> -	release_firmware(firmware_p);
>>> +	if (rproc_has_feature(rproc, RPROC_FEAT_ATTACH_ON_RECOVERY))
>>> +		ret = rproc_attach_recovery(rproc);
>>> +	else
>>> +		ret = rproc_boot_recovery(rproc);
>>>
>>>  unlock_mutex:
>>>  	mutex_unlock(&rproc->lock);
>>> --
>>> 2.25.1
>>>
