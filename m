Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF711726643
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 18:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbjFGQrd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 12:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbjFGQrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 12:47:31 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2080.outbound.protection.outlook.com [40.107.94.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0E351FC8
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 09:47:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vx9NSkClkBcYeZxbT+uO1A86BW99q/MLBaPYZqnP9YuxT1zl5FigyTGiPunihLIT9ouJSZlJ66/jpNTQOPxbMxd8xR1gbfJK3GI7CxLj+wsx35oPQfbYD++Wf1SAENFtrTzacymw1zWW8DqD4s7hxmm99/tZ9SLL6WJ30dsK3G6yYe2ehH0rj9+6mPJoNovu9kmIOh7koo1+1vchUmfs0agschqIQZ5yooi9dt4CuIvIKaUGUZPBNuPaVlhAnG7aSy0Lrnd6HoXFAqDT7xdU1IOduRpu38EPCVzW4i0X+XiWoolBSDlYfcOl3PM79Ja8iMYgjpoyud6hbS54KLTynA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=89CnDAVi4deKZBhijlQiYB3aNKa1R/QFagmBHqOvW5Q=;
 b=Fe540J8Nq40phXls//Axt2GFiFAVFI3yMcvgyMb6XSuDn5JPEUKIhzS6PL8rwjOC2/V8klMStrrix1sLfipraxR5Vtmn/HdIbJvFaokvlsYI+zFUT6kAibmUuCQua7rsCSsfFPCcLiTYG4q/wrCf/7nvAYLmRaOvxL+vQ6uCALpRq/C9YE0YwW55YUol4I1Pl+HaW3JObmiboOSVr0oZ4J+TkBWb2GrZu2pKlLRLPaRygkhA985CcVZc840ZYssnolxIDtZRzYzbhoMKlWA6DJuiHBDkFbJp7ork/PchnhMA77VvGNgfVPNTt1No8pc+JwcqTZXiSuO4nwTIKUEKgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=89CnDAVi4deKZBhijlQiYB3aNKa1R/QFagmBHqOvW5Q=;
 b=vHlQiSyJU/+c7o2vYn6MtQ5ct/iN7BcxgAtH/th+AaMhu0+zclRaLXTBRuFGPS105y/nBSgZqON47OPj7nr+Jyr2obP2S6goLpEGnlknaWBdldus2oEuqXsZcq6xyreXOM9nSep5Vbn9YOVm1v+TGVMGWkAFBBvW5tiJDiRvU0o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MN2PR12MB4173.namprd12.prod.outlook.com (2603:10b6:208:1d8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.19; Wed, 7 Jun
 2023 16:47:23 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::43b2:55d7:9958:390e]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::43b2:55d7:9958:390e%5]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 16:47:23 +0000
Message-ID: <ff163aff-6071-f323-0a6b-825b5b394dbf@amd.com>
Date:   Wed, 7 Jun 2023 11:47:19 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH V3 1/9] ASoC: amd: ps: create platform devices based on
 acp config
To:     "Mukunda,Vijendar" <vijendar.mukunda@amd.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, Basavaraj.Hiregoudar@amd.com,
        Sunil-kumar.Dommati@amd.com, Mastan.Katragadda@amd.com,
        Arungopal.kondaveeti@amd.com, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20230606060724.2038680-1-Vijendar.Mukunda@amd.com>
 <20230606060724.2038680-2-Vijendar.Mukunda@amd.com>
 <00aeb130-b3d0-ebab-51da-4e590eef8c7b@linux.intel.com>
 <10f38131-bf85-dce4-fedd-15f0859d46f3@amd.com>
Content-Language: en-US
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <10f38131-bf85-dce4-fedd-15f0859d46f3@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1PR02CA0008.namprd02.prod.outlook.com
 (2603:10b6:806:2cf::13) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|MN2PR12MB4173:EE_
X-MS-Office365-Filtering-Correlation-Id: 825eeb65-626b-4bca-ac60-08db6776de02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pQQrLctCE3XBnXXUO/k5MXKHTq5j+WMxct+2HJ4HT6G+Jmr7Ho/aJuBIMEez51Tsyt076mIfPOZqCvHoQ+nzEOL1rE/bekAs+FI7FYY3ySTkKCpLhCSuQS7dGBk+CaFqUruqJh1hCfp1DHRRH1NO1frcRisYcYDEuWPrErOvK9J7r1jOMSLLX9E3p+xy0lJsxmrSJCDZ9HUE2jaEDXHQLrSbZj22KODI/n4O2xoEA71Ov4XDKc1NnhEZ8txUNRggdv+O3jifDiBOlPXSP6qEif3f1vGVSljoY51beDmMVF8Fp2a2hrt7hpF6SjxelC8PrX+czG0IGp5MsWz2d4XFuA+Lji4OAooE8xvS7hCZ6wgBMbPuofDp1iR2vksehGdomE0XxixCqtGSMTb+VbHPVrTkLH5izCys98MqwcLhTe1U9KIR8rR3ymHcArZOlTb+oOsCU7BFVNNaSWdDaUjgL/KeJTfGCi7tzhtiK2KS/5GoMe+dP1+VLJXUg0WgPqd8LFFHaFv0vKjGPMLNlWD/AYainKreNCip8NdsNQTwzaguoh9uqPKMGYJttKAyZO4NwXTqVQiKyQE343ZCw756xE45erM2OUrp7mZ5SC4LJQQo65dfnUGCy9Zst/aqpgw2BvD2P323yYTSQGf3thFikw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(346002)(39860400002)(136003)(376002)(451199021)(54906003)(110136005)(478600001)(5660300002)(8936002)(8676002)(36756003)(2906002)(86362001)(31696002)(66556008)(4326008)(66946007)(66476007)(316002)(38100700002)(41300700001)(6506007)(26005)(53546011)(6512007)(186003)(2616005)(31686004)(6486002)(83380400001)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RUk4MkZqMEVGd3NzcXZPT3lURTQxSVZyK2UyblhKOGJXaGtwTGRDNUJhMERY?=
 =?utf-8?B?RVhYQkJnZGhtNnFzaE5yUzNKS1U0MzdGUUVBOVdXS2JsZzNFbmc1RUZnTmlL?=
 =?utf-8?B?T0ZYcjVJRU1tbXBlZ210QVRKRStXVjFsbWJGYjJyZUYrZmxFM1hEMk1RY2Zj?=
 =?utf-8?B?c1pTL2ZWZEVJbmwvcG45UStTbmJQV0RUWGZGUHdDMXdETXVOb2FjanFhMGgy?=
 =?utf-8?B?NjNMT2ltQWNZazRyWFlDVEdIQXA1TnNzM0ZqK0dVOU92Z2tmMXRlT0F1NjZZ?=
 =?utf-8?B?STZzNlNleGo1WVdoTGE5MVFmZUJ0aUNlN1BSdksrQnhVOXA0c29nV3RXS1R3?=
 =?utf-8?B?L1FYUVhKUXhzcCtZbzQyMVoycWtWbVNhMjRnWkM3WlRNN3hOT1YvWmxjcFJD?=
 =?utf-8?B?RzhsSFdaNEIrOEtBOFhQZEpzeVV3enZ4bnQrS1pJcEwwSEsxdDFtdkhqejl4?=
 =?utf-8?B?ejJpSys1SXNmVXdqajllZzNJbTlEVHJtM1RIZS9BUXZJRFE1MWs1VTkxaGEz?=
 =?utf-8?B?WisrUkJLOE1ETDF2V2lsOWl2NkRHalYwM0x5SmZVRlpYM1d3cTRhZzVoV2Rp?=
 =?utf-8?B?eXYxbCtaRVpkYjBnL2RRRm1wK3RveFB2Tm1HRDJPUlZOaG9DbzZhSjE1WHpk?=
 =?utf-8?B?WlhLK2Q2MGw4N29kMVZMamgvMDBmbVhqNzkzQ2xheUdmcjdjS05hWVVOQWNr?=
 =?utf-8?B?VUlCbW05VzU2UEF6R2Q4dzBPa28yYnZsQ3BvSGx3UVdUNUFSVkJDS05ISVpF?=
 =?utf-8?B?RHRZOGZnYXI5TnU0cW1uelBQSVFKT2U3Q3d5a1o2Z3YwdG9FaXFBd3FScUF2?=
 =?utf-8?B?dklVdVRsZ0pYSTI2dFhkRDhidENrbW1QSWlXVS8rbGhFWnA2VmI5RXMzYTU3?=
 =?utf-8?B?SnF6MEZ0OEp1Z1dyZlN0bkttbFdCRS9tdW9FNVloYnlQUEpXb2twcyt4cnhy?=
 =?utf-8?B?Rm9WekRKRnZMSCtKZWkzMFdETXpyUFQrVitYNkpEOGlJcDJlUWluNE5PNzdK?=
 =?utf-8?B?UzRIckN2dllpbGUwdzhmZDI0U2RLTGNzSzNaQWFrUVdVd1dFL3pNTDBFNkNU?=
 =?utf-8?B?WStINUlTWU1wVE9pUkg4djYwSXJqY08zUjJ4bkZHek5wS3R4UEJHNkFJcVU4?=
 =?utf-8?B?bGNuMUdrbkhWUTlKQmxNNTdmS1lVT3dDZ3RuSDBlOWtna1J6WlVFWGlPeWZq?=
 =?utf-8?B?WGhHM0d5dE9ZVnZlYXBieTdoMWNNTld2UkJYbDBPYmdGaCtHa0FTTjZ5RXk5?=
 =?utf-8?B?ei9HUnllTnRpRVpMb2VoNTBOOW9RNjFhak5hbmJMbjVVc1VmMHA2NkRiMm5l?=
 =?utf-8?B?VGFXZENoWFFBZXMybHFzd255VE5Sai9GV1B3bXJveG5PbENuUnRUbGZzeFlB?=
 =?utf-8?B?bHpKRE9UNkhZdFh5YlFvUnhId1FTNVROYVpIdklhQU4xUm1za3RMQ09yZUh4?=
 =?utf-8?B?Z1IzNlhqOXZuU2UxbEpsMGYyWVc0d2hLdTVTZmVuV21xc3JlY1htYkt0TEl0?=
 =?utf-8?B?WmM4dGx0YUVwMjVuTWRnMy9nN0pNdWFOMGk5ZHM5NFMrV1dYZ0ZBbnBQcmJq?=
 =?utf-8?B?S2pYMFFNRXJTMThSV0UzSkg2RXZvZ283bkljRm5HbzVOZ2lnS05SQTJ3RStk?=
 =?utf-8?B?VEdiMlFiNzUxWFE4K2lJNmUyZ21jV3dack1FMlp0RkhYUm1qU0pCRkxCZG8y?=
 =?utf-8?B?ellVRjQwRDhuRVpOa2owSUM3ays3NFBnNHJWVjRPeDhDZmdoeFBlc3lzbmJ6?=
 =?utf-8?B?NXhjbTVlZFBLaWhDbnMyK0VwanZ1a0p1eVZYRDVneWZDdmFjYXc2alZwNTEx?=
 =?utf-8?B?QVFGZE44VWZWQXhjdktZODdJL2F0M292aDJnSFZldmZsM2tjK1BiVTVURDBO?=
 =?utf-8?B?Y0VhTStuYUtHNkRjcFhZTmxYNUJkWTVOQmEwOHJ2a2pDY25wdVoxL25QTkRn?=
 =?utf-8?B?SGZFT2hQbzFsYm9uazJRM0M5RlRKVEc5NThObkU2ZVFqTlpiMUg2QmkybEkz?=
 =?utf-8?B?T3VmMExWUzZrZnNkdzd5L0lLL3FZbDhtVVF0a3JKdnpJbllLUEJYTy9Qckds?=
 =?utf-8?B?VlBTTjg3NmdnM3E4OUlBMHVmN2I2bmJRSENlUTdrSDUxOG0zMVNKS25jSnVj?=
 =?utf-8?Q?r8mmuPb2SzVTu2e/0YqOXHqCL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 825eeb65-626b-4bca-ac60-08db6776de02
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 16:47:23.3249
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qug589s8qf5+ZM6GHmu8pMY64YYETgbWdixyswNLOmMwj8NaQWcS1y775CrMVBuBxu6li+IxStsHExZGzGEfNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4173
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


On 6/7/2023 1:35 AM, Mukunda,Vijendar wrote:
> On 06/06/23 19:30, Pierre-Louis Bossart wrote:
>>
>>> +/**
>>> + * acp_pdev_mask corresponds to platform device mask based on audio endpoint combinations.
>>> + * acp_pdev_mask will be calculated based on ACPI Scan under ACP PCI device and
>>> + * ACP PIN Configuration.
>>> + * Based acp_pdev_mask, platform devices will be created.
>>> + * Below are possible platform device combinations.
>>> + * 1) ACP PDM Controller, dmic-codec, machine driver platform device node
>>> + * 2) ACP PDM Controller , dmic-codec, SW0 SoundWire manager instance, platform device for
>>> + *    SoundWire DMA driver
>>> + * 3) SW0, SW1 SoundWire manager instances, platform device for SoundWire DMA driver
>>> + * 4) ACP PDM Controller, dmic-codec, SDW0, SDW1 manager instances, platform device for
>>> + *    SoundWire DMA driver
>>> + * ACP63_PDM_DEV_MASK corresponds to platform device mask for ACP PDM controller.
>>> + * ACP63_SDW_DEV_MASK corresponds to platform device mask for SDW manager instances.
>>> + * ACP63_SDW_PDM_DEV_MASK corresponds to platform device mask for ACP PDM + SDW manager combination
>>> + */
>>> +enum acp_pdev_mask {
>>> +	ACP63_PDM_DEV_MASK = 1,
>>> +	ACP63_SDW_DEV_MASK,
>>> +	ACP63_SDW_PDM_DEV_MASK,
>>> +};
>> This does not look like a mask, the definitions prevent bit-wise
>> operations from happening.
>>
>> Either use BIT(0), BIT(1), BIT(2) or GENMASK(1, 0), or demote this to a
>> regular enum (e.g. pdev_config or something)
> ACP63_PDM_DEV_MASK - Will be set only PDM config is selected.
> ACP63_SDW_DEV_MASK - will be set only when SDW config is selected.
> ACP63_SDW_PDM_DEV_MASK - will be set only when ACP PDM + SDW config is selected.
>
> We have already added comments for above masks definitions in code.
> Our intention is to use it as a mask.
> We don't think it breaks anything.
> Currently, we have only one extra check for SDW case, in suspend/resume scenario.
> Based on SoundWire power mode, ACP PCI driver should invoke acp_deinit/acp_init()
> calls in suspend/resume callbacks.
> For this, we have added check for pdev_mask. If pdev_mask is set to ACP63_SDW_DEV_MASK
> (2) or ACP63_SDW_PDM_DEV_MASK(3), in this case only by checking SoundWire power mode
> invoke acp_deinit/acp_init() sequence. This is already in place.
>
> There won't be any extra checks will be added in the future.
> As per our understanding, it's good to go.
>
I think the problem is in use of the word "mask" in this context.
That usually means that you can do a bitwise operation on it.
Really it's behaving more like an "enum" does.

In patch 9 you have the following code:

+	if (adata->pdev_mask & ACP63_SDW_DEV_MASK) {

That's checking if bits 0 and 1 are both set.

But if in the future a new set of hypothetical device types was introduced
that mapped out to values "4" and "5" then you might end up with matches
in the code that don't make sense.

So it makes more sense to do one of these solutions:

1) rename this adev->pdev_mask to be adev->pdev_config and then in patch 9
to use something like this:

if (adev->pdev_config == ACP63_SDW_DEV_CONFIG)

2) re-assign it so each config gets a single bit and keep the patch 9 
behavior.
PDM is BIT(0), SDW is BIT(1) PDM + SDW is BIT(2) etc.

Either way that will ensure that you never have an unexpected match.
Unexpected matches can be more likely as the code base grows and it's 
used for
more platforms and configs.

>
>
>>> +
>>>   struct pdm_stream_instance {
>>>   	u16 num_pages;
>>>   	u16 channels;
>>> @@ -95,14 +144,38 @@ struct pdm_dev_data {
>>>   	struct snd_pcm_substream *capture_stream;
>>>   };
>>>   
>>> +/**
>>> + * struct acp63_dev_data - acp pci driver context
>>> + * @acp63_base: acp mmio base
>>> + * @res: resource
>>> + * @pdev: array of child platform device node structures
>>> + * @acp_lock: used to protect acp common registers
>>> + * @sdw_fw_node: SoundWire controller fw node handle
>>> + * @pdev_mask: platform device mask
>>> + * @pdev_count: platform devices count
>>> + * @pdm_dev_index: pdm platform device index
>>> + * @sdw_manager_count: SoundWire manager instance count
>>> + * @sdw0_dev_index: SoundWire Manager-0 platform device index
>>> + * @sdw1_dev_index: SoundWire Manager-1 platform device index
>>> + * @sdw_dma_dev_index: SoundWire DMA controller platform device index
>>> + * @acp_reset: flag set to true when bus reset is applied across all
>>> + * the active SoundWire manager instances
>>> + */
>>> +
>>>   struct acp63_dev_data {
>>>   	void __iomem *acp63_base;
>>>   	struct resource *res;
>>>   	struct platform_device *pdev[ACP63_DEVS];
>>>   	struct mutex acp_lock; /* protect shared registers */
>>> +	struct fwnode_handle *sdw_fw_node;
>>>   	u16 pdev_mask;
>>>   	u16 pdev_count;
>>>   	u16 pdm_dev_index;
>>> +	u8 sdw_manager_count;
>>> +	u16 sdw0_dev_index;
>>> +	u16 sdw1_dev_index;
>>> +	u16 sdw_dma_dev_index;
>>> +	bool acp_reset;
>>>   };
>>>   
>>>   int snd_amd_acp_find_config(struct pci_dev *pci);
>>> diff --git a/sound/soc/amd/ps/pci-ps.c b/sound/soc/amd/ps/pci-ps.c
>>> index 54752d6040d6..816c22e7f1ab 100644
>>> --- a/sound/soc/amd/ps/pci-ps.c
>>> +++ b/sound/soc/amd/ps/pci-ps.c
>>> @@ -6,6 +6,7 @@
>>>    */
>>>   
>>>   #include <linux/pci.h>
>>> +#include <linux/bitops.h>
>>>   #include <linux/module.h>
>>>   #include <linux/io.h>
>>>   #include <linux/delay.h>
>>> @@ -15,6 +16,7 @@
>>>   #include <sound/pcm_params.h>
>>>   #include <linux/pm_runtime.h>
>>>   #include <linux/iopoll.h>
>>> +#include <linux/soundwire/sdw_amd.h>
>>>   
>>>   #include "acp63.h"
>>>   
>>> @@ -119,37 +121,162 @@ static irqreturn_t acp63_irq_handler(int irq, void *dev_id)
>>>   	return IRQ_NONE;
>>>   }
>>>   
>>> -static void get_acp63_device_config(u32 config, struct pci_dev *pci,
>>> -				    struct acp63_dev_data *acp_data)
>>> +static int sdw_amd_scan_controller(struct device *dev)
>>> +{
>>> +	struct acp63_dev_data *acp_data;
>>> +	struct fwnode_handle *link;
>>> +	char name[32];
>>> +	u32 sdw_manager_bitmap;
>>> +	u8 count = 0;
>>> +	u32 acp_sdw_power_mode = 0;
>>> +	int index;
>>> +	int ret;
>>> +
>>> +	acp_data = dev_get_drvdata(dev);
>>> +	acp_data->acp_reset = true;
>>> +	/* Found controller, find links supported */
>>> +	ret = fwnode_property_read_u32_array((acp_data->sdw_fw_node), "mipi-sdw-manager-list",
>>> +					     &sdw_manager_bitmap, 1);
>> IIRC this is only defined in the DisCo 2.0 spec, previous editions had a
>> 'mipi-master-count'. A comment would not hurt to point to the minimal
>> DisCo spec version.
> We will add comment.
>>> +
>>> +	if (ret) {
>>> +		dev_err(dev, "Failed to read mipi-sdw-manager-list: %d\n", ret);
>>> +		return -EINVAL;
>>> +	}
>>> +	count = hweight32(sdw_manager_bitmap);
>>> +	/* Check count is within bounds */
>>> +	if (count > AMD_SDW_MAX_MANAGERS) {
>>> +		dev_err(dev, "Manager count %d exceeds max %d\n", count, AMD_SDW_MAX_MANAGERS);
>>> +		return -EINVAL;
>>> +	}
>>> +
>>> +	if (!count) {
>>> +		dev_dbg(dev, "No SoundWire Managers detected\n");
>>> +		return -EINVAL;
>>> +	}
>>> +	dev_dbg(dev, "ACPI reports %d SoundWire Manager devices\n", count);
>>> +	acp_data->sdw_manager_count = count;
>>> +	for (index = 0; index < count; index++) {
>>> +		snprintf(name, sizeof(name), "mipi-sdw-link-%d-subproperties", index);
>>> +		link = fwnode_get_named_child_node(acp_data->sdw_fw_node, name);
>>> +		if (!link) {
>>> +			dev_err(dev, "Manager node %s not found\n", name);
>>> +			return -EIO;
>>> +		}
>>> +
>>> +		ret = fwnode_property_read_u32(link, "amd-sdw-power-mode", &acp_sdw_power_mode);
>>> +		if (ret)
>>> +			return ret;
>>> +		/*
>>> +		 * when SoundWire configuration is selected from acp pin config,
>>> +		 * based on manager instances count, acp init/de-init sequence should be
>>> +		 * executed as part of PM ops only when Bus reset is applied for the active
>>> +		 * SoundWire manager instances.
>>> +		 */
>>> +		if (acp_sdw_power_mode != AMD_SDW_POWER_OFF_MODE) {
>>> +			acp_data->acp_reset = false;
>>> +			return 0;
>>> +		}
>>> +	}
>>> +	return 0;
>>> +}
>>> +
>>> +static int get_acp63_device_config(u32 config, struct pci_dev *pci, struct acp63_dev_data *acp_data)
>>>   {
>>>   	struct acpi_device *dmic_dev;
>>> +	struct acpi_device *sdw_dev;
>>>   	const union acpi_object *obj;
>>>   	bool is_dmic_dev = false;
>>> +	bool is_sdw_dev = false;
>>> +	int ret;
>>>   
>>>   	dmic_dev = acpi_find_child_device(ACPI_COMPANION(&pci->dev), ACP63_DMIC_ADDR, 0);
>>>   	if (dmic_dev) {
>>> +		/* is_dmic_dev flag will be set when ACP PDM controller device exists */
>>>   		if (!acpi_dev_get_property(dmic_dev, "acp-audio-device-type",
>> usually properties start with the 'mipi-' or 'vendor-' prefix. Is there
>> a missing 'amd-' here or is 'acp-' unique enough?
> It's not SoundWire related MIPI/Vendor property.
> Our BIOS changes are freeze. We can't modify this one as of this moment.
> We will consider it for next platform.

Besides impact to BIOS it also has impact to drivers in other
operating systems as well.  So changing a property name is not
something that can be taken lightly.

I'd also point out the use of the ACPI property is localized to
an AMD specific driver not generic code.

