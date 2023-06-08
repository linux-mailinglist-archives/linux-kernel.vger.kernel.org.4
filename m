Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63BF072769C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 07:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232250AbjFHFUY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 01:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232805AbjFHFUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 01:20:20 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2064.outbound.protection.outlook.com [40.107.220.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6EFF10EA
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 22:20:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DO1nZ9y8e2+C8QQYmGsF8ZLfx1izWOGrUQ7svVjWfpFlHCuqorP5fe9zON70DOQGqfZ00KBhTOLPy293E4A4ObBcCb6Uwb+stmaYLiKAls5jrqlWwIX4kOQyaJC2WVqDP4LEpvKZc+UAc1R5HVg2736eKj0wZ9XBiTQuSZ/CROwcGV2aPQwpzuF6MxgXX6HI7n6oVs1SGcHciINt/P3pGuS3/LUKOwuSNvyhyryQGPmRB3i955o4qzNxJlJ91ViXWOIblBpsGViWoNArCT+27bAb2ocg2SNzZ1ddoIEJXQGP1CU1NCG5OjRRkyIEo0zkaau//g19y2rVFVMPuZJOng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y8AsYNBXBl3gPYrH/ifbMXDKUdPtRfuutnNS6YEAL6k=;
 b=IUpk83KJ/14Ca2C3wSnit9fFSSWJZaHrydOW502p+FOpa9XuGXMtRAZCd1CRd5fN5YxWXBMWDlkD3Tm/+5kZWhemVdbZZtgXAFN0OkppyNF0s15kSm0KdG3p9/Z1D0gAold40wdApADKotpMO2xfbLTN3vsULu9mAj7zHXSDvS7b0phVTtvROiPdFPskirswBmUCt/T6veizK3x1qER8dZdt0FvOuH4RC7Gqtm4crXY/SilLanqnbZWClQtuhqq2taaSJLu8bLVmnvtHAnzyfKTVuc9qJ3a8Ai2tCylUaVSc/BRYqXaBbX5tkAYtjkoL3Kro/b+vunmZX3PZFQ/sCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y8AsYNBXBl3gPYrH/ifbMXDKUdPtRfuutnNS6YEAL6k=;
 b=ouva0eJQtR8EO2qMEHCJE29/PHnAdCvlPJL9dd9Nazdhj0nq7Uv8u93NiFlhS5au1RqWcVmysfH4YRWrFQhjBjD/do2CbTbE6TktdnxJ8j7ZuDls9xkxtVyqkFys/tkwRZIR5wLrKn6smOhfpGP/QDXHUof3cd8RJ6BlUbogyvM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4123.namprd12.prod.outlook.com (2603:10b6:5:21f::23)
 by PH7PR12MB5709.namprd12.prod.outlook.com (2603:10b6:510:1e0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.36; Thu, 8 Jun
 2023 05:20:14 +0000
Received: from DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::8760:2e89:1243:2b5d]) by DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::8760:2e89:1243:2b5d%6]) with mapi id 15.20.6455.030; Thu, 8 Jun 2023
 05:20:14 +0000
Message-ID: <f139d79f-f224-2bba-8dff-1fc5734d5d14@amd.com>
Date:   Thu, 8 Jun 2023 10:54:54 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH V3 1/9] ASoC: amd: ps: create platform devices based on
 acp config
Content-Language: en-US
To:     "Limonciello, Mario" <mario.limonciello@amd.com>,
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
 <ff163aff-6071-f323-0a6b-825b5b394dbf@amd.com>
From:   "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
In-Reply-To: <ff163aff-6071-f323-0a6b-825b5b394dbf@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0128.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::13) To DM6PR12MB4123.namprd12.prod.outlook.com
 (2603:10b6:5:21f::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4123:EE_|PH7PR12MB5709:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f321f5a-bff6-4bc1-f41c-08db67e00a42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xMNIuTpsLorjblSz/+qrMsTKiX5VjCS/JTr8obtbx0g0e+E41P9Y9HCtKHkJwRGOfh9fbroCEY10S01GFkUC9u0PunX1z0gbOqB4H3HDEAaycED5jg6asAbjmkI5cCHoKdkSbTlpHARWmfHDsuY8mPQq9v8alYrV7rwHnzIq3zRctQ9WM2gq98vYF00IXneQaaTRIwgtcGc3fcjypGUaFUM6r9Djb6RiHaKsiYB0VmigjIolulqN0x53q2kMxIHOD50JES+UQxz8c2qARb+2NHdecguteuom58iw0YdJy1FS4MMH3MPrGwquAmx7G4hu4uABpvX6lbg8f8m/oXzhVqj4tYgN8J8xGu0ZqODkt6MXgGqZ2Gm9zbl0y6jfpFttY1EhLjNl54H5a5u2V0uFfdF7GD/rb+gbmLUolHhKO8PQ15XZapH8sPk52CZlAErj0rOT4lyPhejmZoIeFRi2rj+5oxZMX70YAramf+z0+MlKXfQSvHv/qPsmjcLuSdRZ6L2t216okLzlJchAPRd8qoEcyy+cE2w8ARfnS6++C5u0nzhxtJ752JvUzS7ByldlNWOKEpydus7JYAsezKe0CwFkpmD9tW1CVpQtUaqNVagmszfdNTabcwZbiYymdzHR/WC0hnxSwop1Pw0C7oZQnQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4123.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(396003)(39860400002)(376002)(366004)(451199021)(83380400001)(110136005)(54906003)(478600001)(8936002)(8676002)(4326008)(86362001)(66946007)(66476007)(66556008)(31696002)(38100700002)(5660300002)(316002)(41300700001)(6486002)(6666004)(36756003)(2906002)(6512007)(186003)(26005)(6506007)(53546011)(31686004)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aWlTYkphR3JHVSt1ZmdpdFYydkN1bjRTS1lrY2V2aDlGTjVrckxyUTIwNGJm?=
 =?utf-8?B?OUNvYVVSWDJuZUU4RTkzLytCWDV2cFJ4NFBEYjdpR0dLVVBXSEZqU0JNY0lZ?=
 =?utf-8?B?d1hPcllXOXR2bTQxVnh4RDV5b1VycitpbEZ2L3dkNER6d3VhWHN5dXdpQng1?=
 =?utf-8?B?SUpyRzBoc1d0OTJnWU56WDRWYkJON3hXbnpTRk11UzBPMjRFOUlHMDRIRS9Z?=
 =?utf-8?B?RFhLc3B0VVlVUXRuT3cvSCtaa3Z2VVVaZmRaWkNDbExhWGl1cHZlaWMxc2wy?=
 =?utf-8?B?ZHJvOVRaQ3BsQng1OXIralM2RUU4emFGMzJTZHRadzBYN3RuVGYyK3Y1enlN?=
 =?utf-8?B?TXNkMFZKSnZBYVlGOHU2eWtOWWlyMTZoWTVySWJ6N3lxY0lSaS9MNHNkVjZX?=
 =?utf-8?B?NWsrSWVNRTNPUGpJUGtHY2FTYVFWelcrbFh6MzBRWHBidXRMRXlGa3VZRGNo?=
 =?utf-8?B?TVNCa0RkNHdpZjFDWlpjeHBiQ1FNdWdJcDBjVGhiSzJha0NERkoyWmpuTFRu?=
 =?utf-8?B?MWJaYTlUVEVxcU1DdVZIVDAzVmRvN1F6dlk3VkI3UUZtUGpjYitZajhua1N4?=
 =?utf-8?B?dW1KbXlDMzF4R3pYSmhDaDJyb2t1WElVc0c2b2NZcDMvaTFneWpZSjYxNFM1?=
 =?utf-8?B?VjJhZUxIM1g2WDBSdnBoMmwraHkzakVkS2FrL2hvbUVaRC9JY3owUElZYkpL?=
 =?utf-8?B?aUlMQW9JcEpnV1dJTG5hSFd2Tkk3bktjdFF2Rk42UkdaNUErUngzSTA4MkFT?=
 =?utf-8?B?ZDRtQzM1YjNtWDBudS9Ed0hQUkJQVEd2MGhONVhJQXVxVDh2dFlnRzNqU2t3?=
 =?utf-8?B?VzhwK2xmdUJ1Qy9OcmFGS2JiSVBRbkQ4bGczM2RHc2hWeFo4bDJNcDRQd0dJ?=
 =?utf-8?B?ZjdCNTFoSTM5VXhMUERqRVg0U2hOVUVkZnFReHlxUGNpMktHK01PTTJDenFo?=
 =?utf-8?B?YklBakNVQWRTYWVvNFZULytiTkl3b2REVC9mSFhET25DdFkxZ3VIc2VjNlpM?=
 =?utf-8?B?eUNqT3FTYWtZb1BSN1p3MDdiUlFGdVBmODMzSTVmUUdocjFTNEdPcTFZK29H?=
 =?utf-8?B?WlFYVzRjdUpLS3d4Q00rcGV2YzRnazNaN3NUYzIraDRvL2k4RXJEcndSOXZG?=
 =?utf-8?B?NFp5THEyUlVFeFpsZDBaR3FRRllsaEJJd2ZKYnUwM0NrZXFDOW1lZkhaRHJD?=
 =?utf-8?B?NGxwVGo0WTZ3d1hTczl6UGJPaDJwYm5YN0lYN0JXRDhPVGh6b3lrSlZsUm41?=
 =?utf-8?B?NWJnQ2pkRm9jSFJCdXJJTTFnakFsaENJQ3lkbzViUGNGR004ZDV3UTF3THVJ?=
 =?utf-8?B?dXg5TmpSekhPV1l6K1BuV0liR3AvTFdBZzBPeXMvbHpOU2JPKzZvdkI2Y2p5?=
 =?utf-8?B?V1kyMkJRQ0wyMDZXempISG5vazJieDA3aDltejF4c2tkQ2tsR3BsRys2U2NE?=
 =?utf-8?B?NHF1cENlb3ZFOHZFKzR0Tzd5QXpHYnl5MlEyQnpKL0VYRktqa3k5bUR4ZzJp?=
 =?utf-8?B?ZklKaXJTZ0txK2VVY0V0a0NjMFRlQVkxcmV2TVpBeFVtQ3J0RGI3V2p5cjho?=
 =?utf-8?B?bXJHRm5JalNrSkVldXFyOUMvemNnUFZpUGhrbnE2OXArVm53RHk1TXc1M0Yx?=
 =?utf-8?B?aytqQjVnZzNLTjc1UE9GU0diR3RPRW9WY1dvS2pnRVlEZVUvbVI4Wkk4eUVa?=
 =?utf-8?B?MitZQncvZkFzVlNVN3ZzN0wyMFlwNVA0bko3VkpXb3BkZjlRbFJ6aXF3b3pj?=
 =?utf-8?B?UnVpWnVCc25tdVFqemJKOEJWUkVGNVZDRCtaSUJLMk5YOXI1U2tHOGJQUk5U?=
 =?utf-8?B?WjZyeXhHVGNXenJBdVhqVWdSVXFNNGJxYWVuWk5CTzFERExJaW0xNXBOVHA4?=
 =?utf-8?B?U3BWL1dMdE1VUXJnWXFxTUU2eUFVTHhVOGZnajlmSjNXb2ZyNzZyZDd0T2xE?=
 =?utf-8?B?NHRqbVo1KzdHVXlDMkxGdU9KSnhEMjhZSlNZeVltRDRPRmRYTDV0ZGc2RS85?=
 =?utf-8?B?cHZYL08zS1dhbnJXOW9QRThOY09OMmVidlA2UmdNbjgxVjJGQ2pTVGlvNDVD?=
 =?utf-8?B?Y1JQb1VLeE9IK3c3WFpTYjh1Rng5ZTFvVnJOenlGNnNzTW5JL1k1OC9vMTA4?=
 =?utf-8?Q?Mpu+yWSc9ZCpB0DuFVX2r/p0F?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f321f5a-bff6-4bc1-f41c-08db67e00a42
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4123.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 05:20:14.7636
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PFaz3NYrdTzPUZefs1Ka6rvV3vmk/X5yjqlQblCAThXBtTVsWJFxy1sT8YhL3oqpCRoRBz/usr3JKvtHv7auGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5709
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/06/23 22:17, Limonciello, Mario wrote:
>
> On 6/7/2023 1:35 AM, Mukunda,Vijendar wrote:
>> On 06/06/23 19:30, Pierre-Louis Bossart wrote:
>>>
>>>> +/**
>>>> + * acp_pdev_mask corresponds to platform device mask based on audio endpoint combinations.
>>>> + * acp_pdev_mask will be calculated based on ACPI Scan under ACP PCI device and
>>>> + * ACP PIN Configuration.
>>>> + * Based acp_pdev_mask, platform devices will be created.
>>>> + * Below are possible platform device combinations.
>>>> + * 1) ACP PDM Controller, dmic-codec, machine driver platform device node
>>>> + * 2) ACP PDM Controller , dmic-codec, SW0 SoundWire manager instance, platform device for
>>>> + *    SoundWire DMA driver
>>>> + * 3) SW0, SW1 SoundWire manager instances, platform device for SoundWire DMA driver
>>>> + * 4) ACP PDM Controller, dmic-codec, SDW0, SDW1 manager instances, platform device for
>>>> + *    SoundWire DMA driver
>>>> + * ACP63_PDM_DEV_MASK corresponds to platform device mask for ACP PDM controller.
>>>> + * ACP63_SDW_DEV_MASK corresponds to platform device mask for SDW manager instances.
>>>> + * ACP63_SDW_PDM_DEV_MASK corresponds to platform device mask for ACP PDM + SDW manager combination
>>>> + */
>>>> +enum acp_pdev_mask {
>>>> +    ACP63_PDM_DEV_MASK = 1,
>>>> +    ACP63_SDW_DEV_MASK,
>>>> +    ACP63_SDW_PDM_DEV_MASK,
>>>> +};
>>> This does not look like a mask, the definitions prevent bit-wise
>>> operations from happening.
>>>
>>> Either use BIT(0), BIT(1), BIT(2) or GENMASK(1, 0), or demote this to a
>>> regular enum (e.g. pdev_config or something)
>> ACP63_PDM_DEV_MASK - Will be set only PDM config is selected.
>> ACP63_SDW_DEV_MASK - will be set only when SDW config is selected.
>> ACP63_SDW_PDM_DEV_MASK - will be set only when ACP PDM + SDW config is selected.
>>
>> We have already added comments for above masks definitions in code.
>> Our intention is to use it as a mask.
>> We don't think it breaks anything.
>> Currently, we have only one extra check for SDW case, in suspend/resume scenario.
>> Based on SoundWire power mode, ACP PCI driver should invoke acp_deinit/acp_init()
>> calls in suspend/resume callbacks.
>> For this, we have added check for pdev_mask. If pdev_mask is set to ACP63_SDW_DEV_MASK
>> (2) or ACP63_SDW_PDM_DEV_MASK(3), in this case only by checking SoundWire power mode
>> invoke acp_deinit/acp_init() sequence. This is already in place.
>>
>> There won't be any extra checks will be added in the future.
>> As per our understanding, it's good to go.
>>
> I think the problem is in use of the word "mask" in this context.
> That usually means that you can do a bitwise operation on it.
> Really it's behaving more like an "enum" does.
>
> In patch 9 you have the following code:
>
> +    if (adata->pdev_mask & ACP63_SDW_DEV_MASK) {
>
> That's checking if bits 0 and 1 are both set.
>
> But if in the future a new set of hypothetical device types was introduced
> that mapped out to values "4" and "5" then you might end up with matches
> in the code that don't make sense.
>
> So it makes more sense to do one of these solutions:
>
> 1) rename this adev->pdev_mask to be adev->pdev_config and then in patch 9
> to use something like this:
>
> if (adev->pdev_config == ACP63_SDW_DEV_CONFIG)
>
> 2) re-assign it so each config gets a single bit and keep the patch 9 behavior.
> PDM is BIT(0), SDW is BIT(1) PDM + SDW is BIT(2) etc.
>
> Either way that will ensure that you never have an unexpected match.
> Unexpected matches can be more likely as the code base grows and it's used for
> more platforms and configs.

I think Mask word is created confusion here.
These changes are specific to PS platform only.
To avoid further confusion, we will rename the pdev_mask as pdev_config.
  "if (adata->pdev_mask & ACP63_SDW_DEV_MASK)" condition check can be
refactored.
will fix it and post V4 patch set.
>
>>
>>
>>>> +
>>>>   struct pdm_stream_instance {
>>>>       u16 num_pages;
>>>>       u16 channels;
>>>> @@ -95,14 +144,38 @@ struct pdm_dev_data {
>>>>       struct snd_pcm_substream *capture_stream;
>>>>   };
>>>>   +/**
>>>> + * struct acp63_dev_data - acp pci driver context
>>>> + * @acp63_base: acp mmio base
>>>> + * @res: resource
>>>> + * @pdev: array of child platform device node structures
>>>> + * @acp_lock: used to protect acp common registers
>>>> + * @sdw_fw_node: SoundWire controller fw node handle
>>>> + * @pdev_mask: platform device mask
>>>> + * @pdev_count: platform devices count
>>>> + * @pdm_dev_index: pdm platform device index
>>>> + * @sdw_manager_count: SoundWire manager instance count
>>>> + * @sdw0_dev_index: SoundWire Manager-0 platform device index
>>>> + * @sdw1_dev_index: SoundWire Manager-1 platform device index
>>>> + * @sdw_dma_dev_index: SoundWire DMA controller platform device index
>>>> + * @acp_reset: flag set to true when bus reset is applied across all
>>>> + * the active SoundWire manager instances
>>>> + */
>>>> +
>>>>   struct acp63_dev_data {
>>>>       void __iomem *acp63_base;
>>>>       struct resource *res;
>>>>       struct platform_device *pdev[ACP63_DEVS];
>>>>       struct mutex acp_lock; /* protect shared registers */
>>>> +    struct fwnode_handle *sdw_fw_node;
>>>>       u16 pdev_mask;
>>>>       u16 pdev_count;
>>>>       u16 pdm_dev_index;
>>>> +    u8 sdw_manager_count;
>>>> +    u16 sdw0_dev_index;
>>>> +    u16 sdw1_dev_index;
>>>> +    u16 sdw_dma_dev_index;
>>>> +    bool acp_reset;
>>>>   };
>>>>     int snd_amd_acp_find_config(struct pci_dev *pci);
>>>> diff --git a/sound/soc/amd/ps/pci-ps.c b/sound/soc/amd/ps/pci-ps.c
>>>> index 54752d6040d6..816c22e7f1ab 100644
>>>> --- a/sound/soc/amd/ps/pci-ps.c
>>>> +++ b/sound/soc/amd/ps/pci-ps.c
>>>> @@ -6,6 +6,7 @@
>>>>    */
>>>>     #include <linux/pci.h>
>>>> +#include <linux/bitops.h>
>>>>   #include <linux/module.h>
>>>>   #include <linux/io.h>
>>>>   #include <linux/delay.h>
>>>> @@ -15,6 +16,7 @@
>>>>   #include <sound/pcm_params.h>
>>>>   #include <linux/pm_runtime.h>
>>>>   #include <linux/iopoll.h>
>>>> +#include <linux/soundwire/sdw_amd.h>
>>>>     #include "acp63.h"
>>>>   @@ -119,37 +121,162 @@ static irqreturn_t acp63_irq_handler(int irq, void *dev_id)
>>>>       return IRQ_NONE;
>>>>   }
>>>>   -static void get_acp63_device_config(u32 config, struct pci_dev *pci,
>>>> -                    struct acp63_dev_data *acp_data)
>>>> +static int sdw_amd_scan_controller(struct device *dev)
>>>> +{
>>>> +    struct acp63_dev_data *acp_data;
>>>> +    struct fwnode_handle *link;
>>>> +    char name[32];
>>>> +    u32 sdw_manager_bitmap;
>>>> +    u8 count = 0;
>>>> +    u32 acp_sdw_power_mode = 0;
>>>> +    int index;
>>>> +    int ret;
>>>> +
>>>> +    acp_data = dev_get_drvdata(dev);
>>>> +    acp_data->acp_reset = true;
>>>> +    /* Found controller, find links supported */
>>>> +    ret = fwnode_property_read_u32_array((acp_data->sdw_fw_node), "mipi-sdw-manager-list",
>>>> +                         &sdw_manager_bitmap, 1);
>>> IIRC this is only defined in the DisCo 2.0 spec, previous editions had a
>>> 'mipi-master-count'. A comment would not hurt to point to the minimal
>>> DisCo spec version.
>> We will add comment.
>>>> +
>>>> +    if (ret) {
>>>> +        dev_err(dev, "Failed to read mipi-sdw-manager-list: %d\n", ret);
>>>> +        return -EINVAL;
>>>> +    }
>>>> +    count = hweight32(sdw_manager_bitmap);
>>>> +    /* Check count is within bounds */
>>>> +    if (count > AMD_SDW_MAX_MANAGERS) {
>>>> +        dev_err(dev, "Manager count %d exceeds max %d\n", count, AMD_SDW_MAX_MANAGERS);
>>>> +        return -EINVAL;
>>>> +    }
>>>> +
>>>> +    if (!count) {
>>>> +        dev_dbg(dev, "No SoundWire Managers detected\n");
>>>> +        return -EINVAL;
>>>> +    }
>>>> +    dev_dbg(dev, "ACPI reports %d SoundWire Manager devices\n", count);
>>>> +    acp_data->sdw_manager_count = count;
>>>> +    for (index = 0; index < count; index++) {
>>>> +        snprintf(name, sizeof(name), "mipi-sdw-link-%d-subproperties", index);
>>>> +        link = fwnode_get_named_child_node(acp_data->sdw_fw_node, name);
>>>> +        if (!link) {
>>>> +            dev_err(dev, "Manager node %s not found\n", name);
>>>> +            return -EIO;
>>>> +        }
>>>> +
>>>> +        ret = fwnode_property_read_u32(link, "amd-sdw-power-mode", &acp_sdw_power_mode);
>>>> +        if (ret)
>>>> +            return ret;
>>>> +        /*
>>>> +         * when SoundWire configuration is selected from acp pin config,
>>>> +         * based on manager instances count, acp init/de-init sequence should be
>>>> +         * executed as part of PM ops only when Bus reset is applied for the active
>>>> +         * SoundWire manager instances.
>>>> +         */
>>>> +        if (acp_sdw_power_mode != AMD_SDW_POWER_OFF_MODE) {
>>>> +            acp_data->acp_reset = false;
>>>> +            return 0;
>>>> +        }
>>>> +    }
>>>> +    return 0;
>>>> +}
>>>> +
>>>> +static int get_acp63_device_config(u32 config, struct pci_dev *pci, struct acp63_dev_data *acp_data)
>>>>   {
>>>>       struct acpi_device *dmic_dev;
>>>> +    struct acpi_device *sdw_dev;
>>>>       const union acpi_object *obj;
>>>>       bool is_dmic_dev = false;
>>>> +    bool is_sdw_dev = false;
>>>> +    int ret;
>>>>         dmic_dev = acpi_find_child_device(ACPI_COMPANION(&pci->dev), ACP63_DMIC_ADDR, 0);
>>>>       if (dmic_dev) {
>>>> +        /* is_dmic_dev flag will be set when ACP PDM controller device exists */
>>>>           if (!acpi_dev_get_property(dmic_dev, "acp-audio-device-type",
>>> usually properties start with the 'mipi-' or 'vendor-' prefix. Is there
>>> a missing 'amd-' here or is 'acp-' unique enough?
>> It's not SoundWire related MIPI/Vendor property.
>> Our BIOS changes are freeze. We can't modify this one as of this moment.
>> We will consider it for next platform.
>
> Besides impact to BIOS it also has impact to drivers in other
> operating systems as well.  So changing a property name is not
> something that can be taken lightly.
>
Agreed.

> I'd also point out the use of the ACPI property is localized to
> an AMD specific driver not generic code.
>

