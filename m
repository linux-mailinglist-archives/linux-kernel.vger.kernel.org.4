Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 035CA72542B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 08:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234757AbjFGGas (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 02:30:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234728AbjFGGan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 02:30:43 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2057.outbound.protection.outlook.com [40.107.94.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 519EB106
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 23:30:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qnhk1ZCgI/TPYXSvNCP8qKOIDk4kIQnyuJ9YR6KzXsdhK+iD681MrqMo5q6+ckHIC0nqph1R1E96dWfXzN+g/2v3OS8T3nbQ05lB7ms/Ct9m0FthfMfzOw1ud254RS1b9EZxbueOObMyjXE5L9blKSn1gB+qDebdq//LHaOzvCItUP0KRhdqga8Z5hM7kWL0F4G9vm57wznPSsb6+YpMuFIR0bZB6vTVfmo5lPEwmC9ntVZJFuDVUzJR5X9T8YaZUsayQ7djkblScBexjJIShDyaUB5pmzzuc6beUOHsEQ/RnHofUTjOo2cdDrRAUI3MAtHrBl3+CuHkGdEaIZ61PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GzSWErJSwdNiCMpLtZyyiLBmmuN5aa2wQGzbJxV90tk=;
 b=hWNZyI+FToZSnwyEgmxmRN4XB7QatVh+qbkJVSY6q8G8dUMQbk9c8JbWp/T+6D5W22O9aEcgy8TDYruPc39YSUWB/UYJ6AdG8bHFj5Nb1UsOYyW2ctk0BtoSfdWyusCdcKlL9vAvVrgWDXrkzVQLMKiFHWp0lnL+X+b3D3IpRnxJcQNqGAkzEWojhx1rjGnqz75WbzH4rWL5x7FoFYnZSPIuYhpobCihmVCX5J8Vbg/gDhgQO688cVkbZxPHrbgGhsoT1KmMG4fy0Wb8vLxbR97vzy9W1DOKPBtDKIrpHHUROr1mnt6Ui2o2HoQD3Mkt5VpyNz/wvtarjFSrf5DlGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GzSWErJSwdNiCMpLtZyyiLBmmuN5aa2wQGzbJxV90tk=;
 b=JutWHls6vvDtd8RgzlhZKCxD1kaOVYoYtu7q3JNfWRBSOfyi5BsPCoeMb6jR3ljUo2u/Yujy7s75tbd11/TatRUO8MK2QS0+HM1s4KFgYHjnXg0vkkMcgZGQ6RHYVl81L3I9TSJG0l/drQnBErkGPWsN5OZvWuyr879Ugo3SSQ0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4123.namprd12.prod.outlook.com (2603:10b6:5:21f::23)
 by CY5PR12MB6060.namprd12.prod.outlook.com (2603:10b6:930:2b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Wed, 7 Jun
 2023 06:30:38 +0000
Received: from DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::8760:2e89:1243:2b5d]) by DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::8760:2e89:1243:2b5d%6]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 06:30:38 +0000
Message-ID: <10f38131-bf85-dce4-fedd-15f0859d46f3@amd.com>
Date:   Wed, 7 Jun 2023 12:05:19 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH V3 1/9] ASoC: amd: ps: create platform devices based on
 acp config
Content-Language: en-US
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, Basavaraj.Hiregoudar@amd.com,
        Sunil-kumar.Dommati@amd.com, Mastan.Katragadda@amd.com,
        Arungopal.kondaveeti@amd.com, mario.limonciello@amd.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20230606060724.2038680-1-Vijendar.Mukunda@amd.com>
 <20230606060724.2038680-2-Vijendar.Mukunda@amd.com>
 <00aeb130-b3d0-ebab-51da-4e590eef8c7b@linux.intel.com>
From:   "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
In-Reply-To: <00aeb130-b3d0-ebab-51da-4e590eef8c7b@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0041.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::10) To DM6PR12MB4123.namprd12.prod.outlook.com
 (2603:10b6:5:21f::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4123:EE_|CY5PR12MB6060:EE_
X-MS-Office365-Filtering-Correlation-Id: 609def57-09cf-42f8-03e3-08db6720b598
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JwSGAiyTfd/7v3XnQdsJKsXc1IoaCGMhXEWwd48i8FD8NXS915/Fob+W4KWSGuJO3Gho+VxwyI7S/8axR/Lva0bszYFYVuuTeu+lw0BdtBwm+TjK7zL5ZcG/MPI2NduFQ5iusPBeWpgX7qOEraNpZZtIm4bu4x7S1zDYwhQ/lYZvNAv4qSIkbDPUm2ZM7c7/acJ3ZxQ21s5fyI3dTxK3d74FyO7rv4rHlLVkUUkROJ2UB4kxFYuQAWBQlX5uxTRXHj5DAEW/UDRf44v7J8QPtfOXXGLgfmmXsMqRWuJ3iP+ES6Q047YSRqeZH2gd6sh8gpVHdpVyAonzbhIT7YWX13oAWpprpc6Z7pteuqf/U8AJWHDncbcedNtPq+oB8YlKwVjUSLtB4XJeddDlLGKUOlPlwDVcuVBoX8ZKWd2u/a7YnAG0AJQ7EVWi9xY2PX98uRt7OB6kELrIPbB0T3lszGkD9x82DZn2ySRB1BJPE92aW9YrSAFzbEHCCdixKQrocAt7U02s9f4eV+8HINuzwU6GXDauyZJLJfBbpbnET96IMdT7mpO5HusEZOb0wCtj3rWeW+Hi1cwxUj4aG25t6IqyR6cg3HV5qtGdDzzr6pqIz6fgxUhFPMU1DPGYwYYHkwTXw6B0TFoucN/dFm8hdg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4123.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(366004)(376002)(396003)(136003)(451199021)(31696002)(2906002)(83380400001)(2616005)(36756003)(86362001)(38100700002)(6486002)(41300700001)(6666004)(5660300002)(316002)(8676002)(8936002)(54906003)(478600001)(66556008)(66946007)(31686004)(66476007)(4326008)(6512007)(53546011)(6506007)(26005)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S3Z3NlNRbzkydXJqbHc2NXdxV1NuSzBQcVNGMTR5NjBrcGNaSDYvakpKWTZw?=
 =?utf-8?B?NDV6VlZVM3Q0ZlEzM0dhZmVqcmxEeC93SGtmZ21Ia3prTXROY2U2V2EzWktz?=
 =?utf-8?B?SStMMkwrWEtyRGN0dkp4N214TmtCL05KNUFyb0ZaWW1SUExXMGFqRm9FOS9C?=
 =?utf-8?B?clMrdlNkdjk1UUVuOENPL2R6UllQNTlwMHgyenBGdGVSRTg2S21ENjhjUXN6?=
 =?utf-8?B?MlhMRDU1M0pmcUlHVCtFTzREM3JsNk5meEwvbzFvZzFuVlhmTkRVZDZrNDJD?=
 =?utf-8?B?dzRGVHdSU2FwYWxLNmVrVkxjRUtxMWRRa1V3REdGWWkwcVFieHdhdkhIZkoz?=
 =?utf-8?B?Vjd0MTREaEpKRGo1R2k2WTJHeEVDL05ETDRGUm9GOERPbk5EaWxvdm1XUFND?=
 =?utf-8?B?RnlTSm96c0JHamxLTHV6QmpZNW11MTV3NFNiSmd1Q29hV3RyR1VqeVNmUFlH?=
 =?utf-8?B?SDJzaGRScEJyTzJnT0VORysraTVlRmVaRFQ3ZzM4b3pUb2lLK2V0UTlHYVg5?=
 =?utf-8?B?d0NuT1lOQW1EenFKdnUzRTdWR1EvY1R1TVJCdFdJYm40KzJ0NkxZMzdsSE91?=
 =?utf-8?B?NGV5MlZWTkVXd3FNWGtjU2ZnYklKeHd2WTZtc1BaUm05QlRvVTJwdTdUUGM2?=
 =?utf-8?B?QTVwMmFxK2hEUEpUQkwrYlE0ZldiamxKMUlJcXl1MWFISWNOdGVOSkhMaSta?=
 =?utf-8?B?MHdCako1R21FOGd2Z3IxUTlwQm90SnhCSzBXUDRlTzV1QmM0NWp1WWdHbDI4?=
 =?utf-8?B?ZFZZRHpUVFE0bGF3SXJBUGlFTlRmUjBvd2ZBM1owSXlFK1dxODl3Z3dvNUEv?=
 =?utf-8?B?SnRJLzdCNTlxbnV2dFZRV2pGamlMNXpWNDhSbE9paEN1MmxrTVhrNXNCNEl5?=
 =?utf-8?B?cjBYUXBvNXlUM3BBRG1rUW9uc1NVVTZrWVE2MGtCUlRJV0hCRy9XVzN6RXFl?=
 =?utf-8?B?N2hlV2x1RW80cHBSL3AzVjVSbFJWa1pscEIyODJ3WE5JSys5bjdWLzl3TFRW?=
 =?utf-8?B?VTFDczhtWlVQd25hNDg5SnhSWU92R1pMY21iUVhScmlISDJDdUExTXAzM2o3?=
 =?utf-8?B?dE5NRjBoZDBxamxXVmdqT3FPNE9xRVlic004QUl5b3hWWXNaT2QvMlFsN1BX?=
 =?utf-8?B?YzVzN3BqWUN6cnpubmNFeURXOTlXWXJ2Q01UaW9FaUVuMHJsSkRBaUVOdW4w?=
 =?utf-8?B?eXlwa3M0ajdiWGR1dVl2eHZQS0trUjJWdWd4MHdta1lWVEFUMkR6ZTZIakZX?=
 =?utf-8?B?SDY0bEgwbEVVUlRpUnFHRGJkaXY5dm1BTktDa2gvMnJCNnJnUE5HOUNMWDdu?=
 =?utf-8?B?eGhuc2ppY2R3ZEZYdTBoWEVhRmh2WExEcWlDQy96OTVjYzdCemRsakFzdi9l?=
 =?utf-8?B?YktFRXlBQTEzMm5BREg3UVJibVNhQXUyRzlpSXJyT1prK2JvdU5vZnErRWVV?=
 =?utf-8?B?Q1g1UG1TY2Jwayt3cjNLRkkwS2lwbEJ5TUNaZUVSZjFyQ2pzbkpBRWxmSWVj?=
 =?utf-8?B?aWk5QUV2VUs4VFdDSmo3Y1Y4TDZGY1l3U3V5dERHVEs5MFlOdWs1QnArT2Zm?=
 =?utf-8?B?S0tOQzlqbEZZVkhtT3hZZDMwRGJmZ3M2eC9wanhsdEluNEtlcThSRFJhTmZ4?=
 =?utf-8?B?eFVXYVJPNnhQUFptdTU1M1dQZ25wdHN6SHluTVVhcnVOd3RTTnRyYXVFQ2wv?=
 =?utf-8?B?RzJ3MHl1MnU0OG95bVN2R0JPdDZhWUV6OG5rcEZ4K2lVcXErUWFsYW5BQ1Qz?=
 =?utf-8?B?ZVh4UWc2T1ZBOStyZmVGRGRxbFppOVI2eVRiemJNUkFzeGswNkhLZnVyZW9G?=
 =?utf-8?B?ajQ5SWcvS0VhWFkrU2xPUE5LN0FGNlhLd3A2cGdycXBSWmJ4Nml6a0xxN2I3?=
 =?utf-8?B?N2dtU2E1OFY2cTQwcWNFR1pEeVVhR2tXeDV3cHpzQUFmTktVMEdiZ3ZLZlha?=
 =?utf-8?B?YWhLMTNscHV2ZHhXc1dVbUJtTkpUWW9KWHBEQ2VwamM4M0cxVzdReWtzRUl4?=
 =?utf-8?B?OHR6TzNNaWlnSWJrRk5pckt4RE9taGdlUDFpZ3pPUUtaN0JYaGhkU1FjdVc0?=
 =?utf-8?B?SDM5MTNhOUNRbWR3RWs5emlhVUI1SlhDZWpLY29WRHJWZnoyeEI0b3hNZ2pC?=
 =?utf-8?Q?pb3sswXV6cNmfQl5KIplcdgm7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 609def57-09cf-42f8-03e3-08db6720b598
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4123.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 06:30:38.7605
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JPlHBp9sJzMdXiTbRQFRDFAH+QXqp+bx+/6/HUBQ3Iu6dkz7eHx9gXZVlWFeSuLKvVQa6h3PWqvmr8EsqThkgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6060
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/06/23 19:30, Pierre-Louis Bossart wrote:
>
>
>> +/**
>> + * acp_pdev_mask corresponds to platform device mask based on audio endpoint combinations.
>> + * acp_pdev_mask will be calculated based on ACPI Scan under ACP PCI device and
>> + * ACP PIN Configuration.
>> + * Based acp_pdev_mask, platform devices will be created.
>> + * Below are possible platform device combinations.
>> + * 1) ACP PDM Controller, dmic-codec, machine driver platform device node
>> + * 2) ACP PDM Controller , dmic-codec, SW0 SoundWire manager instance, platform device for
>> + *    SoundWire DMA driver
>> + * 3) SW0, SW1 SoundWire manager instances, platform device for SoundWire DMA driver
>> + * 4) ACP PDM Controller, dmic-codec, SDW0, SDW1 manager instances, platform device for
>> + *    SoundWire DMA driver
>> + * ACP63_PDM_DEV_MASK corresponds to platform device mask for ACP PDM controller.
>> + * ACP63_SDW_DEV_MASK corresponds to platform device mask for SDW manager instances.
>> + * ACP63_SDW_PDM_DEV_MASK corresponds to platform device mask for ACP PDM + SDW manager combination
>> + */
>> +enum acp_pdev_mask {
>> +	ACP63_PDM_DEV_MASK = 1,
>> +	ACP63_SDW_DEV_MASK,
>> +	ACP63_SDW_PDM_DEV_MASK,
>> +};
> This does not look like a mask, the definitions prevent bit-wise
> operations from happening.
>
> Either use BIT(0), BIT(1), BIT(2) or GENMASK(1, 0), or demote this to a
> regular enum (e.g. pdev_config or something)

ACP63_PDM_DEV_MASK - Will be set only PDM config is selected.
ACP63_SDW_DEV_MASK - will be set only when SDW config is selected.
ACP63_SDW_PDM_DEV_MASK - will be set only when ACP PDM + SDW config is selected.

We have already added comments for above masks definitions in code.
Our intention is to use it as a mask.
We don't think it breaks anything.
Currently, we have only one extra check for SDW case, in suspend/resume scenario.
Based on SoundWire power mode, ACP PCI driver should invoke acp_deinit/acp_init()
calls in suspend/resume callbacks.
For this, we have added check for pdev_mask. If pdev_mask is set to ACP63_SDW_DEV_MASK
(2) or ACP63_SDW_PDM_DEV_MASK(3), in this case only by checking SoundWire power mode
invoke acp_deinit/acp_init() sequence. This is already in place.

There won't be any extra checks will be added in the future. 
As per our understanding, it's good to go.




>> +
>>  struct pdm_stream_instance {
>>  	u16 num_pages;
>>  	u16 channels;
>> @@ -95,14 +144,38 @@ struct pdm_dev_data {
>>  	struct snd_pcm_substream *capture_stream;
>>  };
>>  
>> +/**
>> + * struct acp63_dev_data - acp pci driver context
>> + * @acp63_base: acp mmio base
>> + * @res: resource
>> + * @pdev: array of child platform device node structures
>> + * @acp_lock: used to protect acp common registers
>> + * @sdw_fw_node: SoundWire controller fw node handle
>> + * @pdev_mask: platform device mask
>> + * @pdev_count: platform devices count
>> + * @pdm_dev_index: pdm platform device index
>> + * @sdw_manager_count: SoundWire manager instance count
>> + * @sdw0_dev_index: SoundWire Manager-0 platform device index
>> + * @sdw1_dev_index: SoundWire Manager-1 platform device index
>> + * @sdw_dma_dev_index: SoundWire DMA controller platform device index
>> + * @acp_reset: flag set to true when bus reset is applied across all
>> + * the active SoundWire manager instances
>> + */
>> +
>>  struct acp63_dev_data {
>>  	void __iomem *acp63_base;
>>  	struct resource *res;
>>  	struct platform_device *pdev[ACP63_DEVS];
>>  	struct mutex acp_lock; /* protect shared registers */
>> +	struct fwnode_handle *sdw_fw_node;
>>  	u16 pdev_mask;
>>  	u16 pdev_count;
>>  	u16 pdm_dev_index;
>> +	u8 sdw_manager_count;
>> +	u16 sdw0_dev_index;
>> +	u16 sdw1_dev_index;
>> +	u16 sdw_dma_dev_index;
>> +	bool acp_reset;
>>  };
>>  
>>  int snd_amd_acp_find_config(struct pci_dev *pci);
>> diff --git a/sound/soc/amd/ps/pci-ps.c b/sound/soc/amd/ps/pci-ps.c
>> index 54752d6040d6..816c22e7f1ab 100644
>> --- a/sound/soc/amd/ps/pci-ps.c
>> +++ b/sound/soc/amd/ps/pci-ps.c
>> @@ -6,6 +6,7 @@
>>   */
>>  
>>  #include <linux/pci.h>
>> +#include <linux/bitops.h>
>>  #include <linux/module.h>
>>  #include <linux/io.h>
>>  #include <linux/delay.h>
>> @@ -15,6 +16,7 @@
>>  #include <sound/pcm_params.h>
>>  #include <linux/pm_runtime.h>
>>  #include <linux/iopoll.h>
>> +#include <linux/soundwire/sdw_amd.h>
>>  
>>  #include "acp63.h"
>>  
>> @@ -119,37 +121,162 @@ static irqreturn_t acp63_irq_handler(int irq, void *dev_id)
>>  	return IRQ_NONE;
>>  }
>>  
>> -static void get_acp63_device_config(u32 config, struct pci_dev *pci,
>> -				    struct acp63_dev_data *acp_data)
>> +static int sdw_amd_scan_controller(struct device *dev)
>> +{
>> +	struct acp63_dev_data *acp_data;
>> +	struct fwnode_handle *link;
>> +	char name[32];
>> +	u32 sdw_manager_bitmap;
>> +	u8 count = 0;
>> +	u32 acp_sdw_power_mode = 0;
>> +	int index;
>> +	int ret;
>> +
>> +	acp_data = dev_get_drvdata(dev);
>> +	acp_data->acp_reset = true;
>> +	/* Found controller, find links supported */
>> +	ret = fwnode_property_read_u32_array((acp_data->sdw_fw_node), "mipi-sdw-manager-list",
>> +					     &sdw_manager_bitmap, 1);
> IIRC this is only defined in the DisCo 2.0 spec, previous editions had a
> 'mipi-master-count'. A comment would not hurt to point to the minimal
> DisCo spec version.
We will add comment.
>> +
>> +	if (ret) {
>> +		dev_err(dev, "Failed to read mipi-sdw-manager-list: %d\n", ret);
>> +		return -EINVAL;
>> +	}
>> +	count = hweight32(sdw_manager_bitmap);
>> +	/* Check count is within bounds */
>> +	if (count > AMD_SDW_MAX_MANAGERS) {
>> +		dev_err(dev, "Manager count %d exceeds max %d\n", count, AMD_SDW_MAX_MANAGERS);
>> +		return -EINVAL;
>> +	}
>> +
>> +	if (!count) {
>> +		dev_dbg(dev, "No SoundWire Managers detected\n");
>> +		return -EINVAL;
>> +	}
>> +	dev_dbg(dev, "ACPI reports %d SoundWire Manager devices\n", count);
>> +	acp_data->sdw_manager_count = count;
>> +	for (index = 0; index < count; index++) {
>> +		snprintf(name, sizeof(name), "mipi-sdw-link-%d-subproperties", index);
>> +		link = fwnode_get_named_child_node(acp_data->sdw_fw_node, name);
>> +		if (!link) {
>> +			dev_err(dev, "Manager node %s not found\n", name);
>> +			return -EIO;
>> +		}
>> +
>> +		ret = fwnode_property_read_u32(link, "amd-sdw-power-mode", &acp_sdw_power_mode);
>> +		if (ret)
>> +			return ret;
>> +		/*
>> +		 * when SoundWire configuration is selected from acp pin config,
>> +		 * based on manager instances count, acp init/de-init sequence should be
>> +		 * executed as part of PM ops only when Bus reset is applied for the active
>> +		 * SoundWire manager instances.
>> +		 */
>> +		if (acp_sdw_power_mode != AMD_SDW_POWER_OFF_MODE) {
>> +			acp_data->acp_reset = false;
>> +			return 0;
>> +		}
>> +	}
>> +	return 0;
>> +}
>> +
>> +static int get_acp63_device_config(u32 config, struct pci_dev *pci, struct acp63_dev_data *acp_data)
>>  {
>>  	struct acpi_device *dmic_dev;
>> +	struct acpi_device *sdw_dev;
>>  	const union acpi_object *obj;
>>  	bool is_dmic_dev = false;
>> +	bool is_sdw_dev = false;
>> +	int ret;
>>  
>>  	dmic_dev = acpi_find_child_device(ACPI_COMPANION(&pci->dev), ACP63_DMIC_ADDR, 0);
>>  	if (dmic_dev) {
>> +		/* is_dmic_dev flag will be set when ACP PDM controller device exists */
>>  		if (!acpi_dev_get_property(dmic_dev, "acp-audio-device-type",
> usually properties start with the 'mipi-' or 'vendor-' prefix. Is there
> a missing 'amd-' here or is 'acp-' unique enough?
It's not SoundWire related MIPI/Vendor property. 
Our BIOS changes are freeze. We can't modify this one as of this moment.
We will consider it for next platform.
