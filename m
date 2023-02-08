Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33D7F68EF48
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 13:45:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230506AbjBHMpP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 07:45:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbjBHMpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 07:45:13 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4114E3C16;
        Wed,  8 Feb 2023 04:45:12 -0800 (PST)
Received: from [192.168.2.24] (77-166-152-30.fixed.kpn.net [77.166.152.30])
        by linux.microsoft.com (Postfix) with ESMTPSA id C23B7203B41F;
        Wed,  8 Feb 2023 04:45:10 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C23B7203B41F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1675860311;
        bh=zsNgpuPqBivqaCmeH9lPczboeTc6AtkLFTwm9uwYDDM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=nVumC/htJmv/5DBQN+mAOF+y0vISD25MTAYiddClEiyiceHo0BKsX0MtYX5M36yja
         A4+mzcHWCGPsdp4eT5WCnZkK4nCBCQzY2bNga+nxBOGM3NLNs1KvaJrWNVVx/oeLha
         C4WiYFw2cqD4hGX2x5bCXDGq3SyAjnJqwqHt/x/0=
Message-ID: <3ed3234e-e811-71ef-41f9-d7999066b62d@linux.microsoft.com>
Date:   Wed, 8 Feb 2023 13:45:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v1 6/8] crypto: ccp - Add vdata for platform device
Content-Language: en-US
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     linux-kernel@vger.kernel.org,
        Brijesh Singh <brijesh.singh@amd.com>,
        "Kalra, Ashish" <ashish.kalra@amd.com>,
        linux-crypto@vger.kernel.org
References: <20230123152250.26413-1-jpiotrowski@linux.microsoft.com>
 <20230123152250.26413-7-jpiotrowski@linux.microsoft.com>
 <6f76fe2b-63ea-8c45-87d8-3de30d3d76c2@amd.com>
 <20230201192409.GA14074@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <b4b8e49c-ea5d-916c-5808-7c6aefa44dd2@amd.com>
From:   Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
In-Reply-To: <b4b8e49c-ea5d-916c-5808-7c6aefa44dd2@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-20.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/02/2023 20:13, Tom Lendacky wrote:
> On 2/1/23 13:24, Jeremi Piotrowski wrote:
>> On Tue, Jan 31, 2023 at 02:36:01PM -0600, Tom Lendacky wrote:
>>> On 1/23/23 09:22, Jeremi Piotrowski wrote:
>>>> When matching the "psp" platform_device, determine the register offsets
>>>> at runtime from the ASP ACPI table. Pass the parsed register offsets
>>> >from the ASPT through platdata.
>>>>
>>>> To support this scenario, mark the members of 'struct sev_vdata' and
>>>> 'struct psp_vdata' non-const so that the probe function can write the
>>>> values. This does not affect the other users of sev_vdata/psp_vdata as
>>>> they define the whole struct const and the pointer in struct
>>>> sp_dev_vdata stays const too.
>>>>
>>>> Signed-off-by: Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
>>>> ---
>>>>   arch/x86/kernel/psp.c            |  3 ++
>>>>   drivers/crypto/ccp/sp-dev.h      | 12 +++----
>>>>   drivers/crypto/ccp/sp-platform.c | 57 +++++++++++++++++++++++++++++++-
>>>>   3 files changed, 65 insertions(+), 7 deletions(-)
>>>>
>>>> diff --git a/arch/x86/kernel/psp.c b/arch/x86/kernel/psp.c
>>>> index 24181d132bae..68511a14df63 100644
>>>> --- a/arch/x86/kernel/psp.c
>>>> +++ b/arch/x86/kernel/psp.c
>>>> @@ -199,6 +199,9 @@ static int __init psp_init_platform_device(void)
>>>>       if (err)
>>>>           return err;
>>>>       err = platform_device_add_resources(&psp_device, res, 2);
>>>> +    if (err)
>>>> +        return err;
>>>> +    err = platform_device_add_data(&psp_device, &pdata, sizeof(pdata));
>>>>       if (err)
>>>>           return err;
>>>> diff --git a/drivers/crypto/ccp/sp-dev.h b/drivers/crypto/ccp/sp-dev.h
>>>> index 20377e67f65d..aaa651364425 100644
>>>> --- a/drivers/crypto/ccp/sp-dev.h
>>>> +++ b/drivers/crypto/ccp/sp-dev.h
>>>> @@ -40,9 +40,9 @@ struct ccp_vdata {
>>>>   };
>>>>   struct sev_vdata {
>>>> -    const unsigned int cmdresp_reg;
>>>> -    const unsigned int cmdbuff_addr_lo_reg;
>>>> -    const unsigned int cmdbuff_addr_hi_reg;
>>>> +    unsigned int cmdresp_reg;
>>>> +    unsigned int cmdbuff_addr_lo_reg;
>>>> +    unsigned int cmdbuff_addr_hi_reg;
>>>>   };
>>>>   struct tee_vdata {
>>>> @@ -56,9 +56,9 @@ struct tee_vdata {
>>>>   struct psp_vdata {
>>>>       const struct sev_vdata *sev;
>>>>       const struct tee_vdata *tee;
>>>> -    const unsigned int feature_reg;
>>>> -    const unsigned int inten_reg;
>>>> -    const unsigned int intsts_reg;
>>>> +    unsigned int feature_reg;
>>>> +    unsigned int inten_reg;
>>>> +    unsigned int intsts_reg;
>>>>   };
>>>>   /* Structure to hold SP device data */
>>>> diff --git a/drivers/crypto/ccp/sp-platform.c b/drivers/crypto/ccp/sp-platform.c
>>>> index ea8926e87981..281dbf6b150c 100644
>>>> --- a/drivers/crypto/ccp/sp-platform.c
>>>> +++ b/drivers/crypto/ccp/sp-platform.c
>>>> @@ -22,6 +22,7 @@
>>>>   #include <linux/of.h>
>>>>   #include <linux/of_address.h>
>>>>   #include <linux/acpi.h>
>>>> +#include <linux/platform_data/psp.h>
>>>>   #include "ccp-dev.h"
>>>> @@ -30,11 +31,31 @@ struct sp_platform {
>>>>       unsigned int irq_count;
>>>>   };
>>>> +#ifdef CONFIG_CRYPTO_DEV_SP_PSP
>>>> +static struct sev_vdata sev_platform = {
>>>> +    .cmdresp_reg = -1,
>>>> +    .cmdbuff_addr_lo_reg = -1,
>>>> +    .cmdbuff_addr_hi_reg = -1,
>>>> +};
>>>> +static struct psp_vdata psp_platform = {
>>>> +    .sev = &sev_platform,
>>>> +    .feature_reg = -1,
>>>> +    .inten_reg = -1,
>>>> +    .intsts_reg = -1,
>>>> +};
>>>> +#endif
>>>> +
>>>>   static const struct sp_dev_vdata dev_vdata[] = {
>>>>       {
>>>>           .bar = 0,
>>>>   #ifdef CONFIG_CRYPTO_DEV_SP_CCP
>>>>           .ccp_vdata = &ccpv3_platform,
>>>> +#endif
>>>> +    },
>>>> +    {
>>>> +        .bar = 0,
>>>> +#ifdef CONFIG_CRYPTO_DEV_SP_PSP
>>>> +        .psp_vdata = &psp_platform,
>>>>   #endif
>>>>       },
>>>>   };
>>>> @@ -57,7 +78,7 @@ MODULE_DEVICE_TABLE(of, sp_of_match);
>>>>   #endif
>>>>   static const struct platform_device_id sp_plat_match[] = {
>>>> -    { "psp" },
>>>> +    { "psp", (kernel_ulong_t)&dev_vdata[1] },
>>>>       { },
>>>>   };
>>>>   MODULE_DEVICE_TABLE(platform, sp_plat_match);
>>>> @@ -86,6 +107,38 @@ static struct sp_dev_vdata *sp_get_acpi_version(struct platform_device *pdev)
>>>>       return NULL;
>>>>   }
>>>> +static struct sp_dev_vdata *sp_get_plat_version(struct platform_device *pdev)
>>>> +{
>>>> +    struct sp_dev_vdata *drvdata = (struct sp_dev_vdata *)pdev->id_entry->driver_data;
>>>
>>> s/drvdata/vdata/
>>>
>>
>> ok
>>
>>>> +    struct device *dev = &pdev->dev;
>>>> +
>>>
>>> Should check for null vdata and return NULL, e.g.:
>>>
>>>     if (!vdata)
>>>         return NULL;
>>>
>>
>> ok
>>
>>>> +    if (drvdata == &dev_vdata[1]) {
>>>
>>> This should be a check for vdata->psp_vdata being non-NULL and
>>> vdata->psp_vdata->sev being non-NULL, e.g.:
>>>
>>>     if (vdata->psp_vdata && vdata->psp_vdata->sev) {
>>>
>>>> +        struct psp_platform_data *pdata = dev_get_platdata(dev);
>>>> +
>>>> +        if (!pdata) {
>>>> +            dev_err(dev, "missing platform data\n");
>>>> +            return NULL;
>>>> +        }
>>>> +#ifdef CONFIG_CRYPTO_DEV_SP_PSP
>>>
>>> No need for this with the above checks
>>>
>>>> +        psp_platform.feature_reg = pdata->feature_reg;
>>>
>>> These should then be:
>>>
>>>         vdata->psp_vdata->inten_reg = pdata->feature_reg;
>>>         ...
>>
>> I see where you're going with this and the above suggestions, but
>> the psp_vdata pointer is const in struct sp_dev_vdata and so is the
>> sev pointer in struct psp_vdata. I find these consts to be important
>> and doing it this way would require casting away the const. I don't
>> think that's worth doing.
> 
> Ok, then maybe it would be better to kmalloc a vdata structure that you fill in and then assign that to dev_vdata field for use. That could eliminate the removal of the "const" notations in one of the previous patches. I just don't think you should be changing the underlying module data that isn't expected to be changed.
> 

I can do that and undo the removal of consts from the
struct (sev|psp)_vdata members, but the outcome would look something
like this:

static void sp_platform_fill_vdata(struct sp_dev_vdata *vdata,
					struct psp_vdata *psp,
					struct sev_vdata *sev,
					const struct psp_platform_data *pdata)
{
	struct sev_vdata sevtmp = {
		.cmdbuff_addr_hi_reg = pdata->sev_cmd_buf_hi_reg,
		.cmdbuff_addr_lo_reg = pdata->sev_cmd_buf_lo_reg,
		.cmdresp_reg = pdata->sev_cmd_resp_reg,
	};
	struct psp_vdata psptmp = {
		.feature_reg = pdata->feature_reg,
		.inten_reg = pdata->irq_en_reg,
		.intsts_reg = pdata->irq_st_reg,
		.sev = sev,
	};

	memcpy(sev, &sevtmp, sizeof(*sev));
	memcpy(psp, &psptmp, sizeof(*psp));
	vdata->psp_vdata = psp;
}

static struct sp_dev_vdata *sp_get_platform_version(struct sp_device *sp)
{
	struct sp_platform *sp_platform = sp->dev_specific;
	struct psp_platform_data *pdata;
	struct device *dev = sp->dev;
	struct sp_dev_vdata *vdata;
	struct psp_vdata *psp;
	struct sev_vdata *sev;

	pdata = dev_get_platdata(dev);
	if (!pdata) {
		dev_err(dev, "missing platform data\n");
		return NULL;
	}

	sp_platform->is_platform_device = true;

	vdata = devm_kzalloc(dev, sizeof(*vdata) + sizeof(*psp) + sizeof(*sev), GFP_KERNEL);
	if (!vdata)
		return NULL;

	psp = (void *)vdata + sizeof(*vdata);
	sev = (void *)psp + sizeof(*psp);
	sp_platform_fill_vdata(vdata, psp, sev, pdata);

	/* elided debug print */
	...

	return vdata;
}

with the const fields in the struct it's not possible to assign in any
other way than on initialization, so I need to use the helper function,
tmp structs and memcpy.

Could you ack that you like this approach before I post a v2?
