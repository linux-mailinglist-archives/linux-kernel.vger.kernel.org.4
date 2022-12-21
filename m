Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F3F96530CA
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 13:28:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231165AbiLUM22 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 07:28:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbiLUM20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 07:28:26 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2048.outbound.protection.outlook.com [40.107.237.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6545B7D
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 04:28:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RZ7RzBeoU6WBaQ6PTI46rWz4thl5bNsziN3fwFssjpbUvJsmX0PayQ69kO9Q2fOMib3Y4Bp9IYrpcdxL9ubiVWhr8wLesgLcFp9KURTRSEGCL9mJ27+hw0YVb1TacuNVBa5wypQG/6aJv5GqYl8UA3MmVSuG+41vGiUXjGyUb4ZCdh0JgzUI7c+iEnzktPOEAvcanq9xWheAWNjxvtvwb5iVgjP0+HVXJPxDP0k3Uskc63VZfVJ+uJLymIEBrZoSugct9HU/gCfL6pQ3ssP5gDmCFiKKTLs1k3uo+8xLcfL7wS4X/TMzVcAo1PMsKoxbytsvy+QOjVI9onqTJ5IcVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wP+osznubDwFunzSVRrkO9Qy5/p+dx+pC7P3URuZsHA=;
 b=lNrcQmFF19CkK50ydi6YItCEGFenn/B0UEFyEb85l6Asf1efLI4oktDqyHYEV0GUjUD4RUSyRZ4mg58kJbwOz+T71qPcs6lSciFP9tgV437fluk3numl/60ilqvdHQ80doZFhkr98kCVN9DSMQFfAhc6uWKv7cm9sJIjyuWpm9mOZoCr0XtieXjUFse9GPvo3geGzGeuIgNzYYkI9maMwezb7X0x+FJQuXYFYLCljGdQgw6OnWK1uL0j/JeGounVnxiKFXZW9e5S87/YHzPftCAJUOLknOC7w0Z62uXN/FuH9o1/jnU6NqI9PO2+gjDNgnPGX6mnYXH1W7heNJkYKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wP+osznubDwFunzSVRrkO9Qy5/p+dx+pC7P3URuZsHA=;
 b=h+/PyuJvs7ObtB2Zj+B8gqCbqqgQpEfJy8P4tk1VIMTiNLtyosil2LjQc2E+PV5kfSSaENA7xV3cuGk47eNqKvNnsAuTFTLNUvPabewCOBjhR6sb/bBjSFOxNnySfF6OjVG7wNAj3GAxAg4e5ZqiONrZvU8D4hzEICJUBt/HDY0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4123.namprd12.prod.outlook.com (2603:10b6:5:21f::23)
 by MN2PR12MB4520.namprd12.prod.outlook.com (2603:10b6:208:26f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Wed, 21 Dec
 2022 12:28:17 +0000
Received: from DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::7d2d:dc01:79cf:df79]) by DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::7d2d:dc01:79cf:df79%3]) with mapi id 15.20.5924.016; Wed, 21 Dec 2022
 12:28:17 +0000
Message-ID: <191928a9-ef60-e274-6678-963b187752ec@amd.com>
Date:   Wed, 21 Dec 2022 18:00:48 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH V2 1/4] ASoC: amd: ps: implement api to retrieve acp
 device config
Content-Language: en-US
To:     broonie@kernel.org, alsa-devel@alsa-project.org
Cc:     Basavaraj.Hiregoudar@amd.com, Sunil-kumar.Dommati@amd.com,
        Mario.Limonciello@amd.com, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20221221112611.1373278-1-Vijendar.Mukunda@amd.com>
From:   "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
In-Reply-To: <20221221112611.1373278-1-Vijendar.Mukunda@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN0PR01CA0031.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:4e::21) To DM6PR12MB4123.namprd12.prod.outlook.com
 (2603:10b6:5:21f::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4123:EE_|MN2PR12MB4520:EE_
X-MS-Office365-Filtering-Correlation-Id: f1369e9c-9eb9-4d0f-ca73-08dae34ed624
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ln9w5sqKTaBab+cn+UCmyG0SSjanZb611Hm8Revv3RiSCEyrnEIYGkNcrYrDTEcHBkRsugYYGYcgFBOzo3fz8BSIErHwsiDS7R5PMs79DRFmnQlnJ0ifImPfRE9KE2l6vL/DZZCOfy+7TfGCh685sYMAM+U9/mudTClvHNCxBaugyTZbyr1+0YbZ8sb8211aOiOe/ToHFqqg/V185HB+RhnRKxBmm1aJGHpGgy3RON4B3/jXdVsOXIUcql2BVev5811C7vc2qv+G2IHdhwsaRhC3D4l3oWU9rTdUizfDVrTCpYbS/AQNdfItI7JUjsl63kNNBr+dy27an4TeeuBmdRGSQIV7uk8VCSjK9ASVIuj8oVFzVOTFQVFXHiaL3IFJfJxbjiQMDjg/x+Ti+8WbaNaPOQpaEz2i4FRAnHxeOQl2YQMPstMXdYnzKlh7f94RIMwL4gfajzYN5lsdmiDXqSOx5GUYtbaoAffJ/hfl5bOEMyAlk6AJuV2lS8F87wVT8BiVViSohwCJIrtXPfdZV1zrJJVpGxNMmxCRgp/d8fpiQ7K408hiIA5XlRvv460Qjm8fXUPnpVU48srEuQLWgt8Yux1k/sedUioUzc0uWuNMm2XV/s5OpmpIxFJN3xGTJfDYFUHaeI1Wscdbm0Dtkk/5a28NCTMBTp4WFOyz/O/Vf9NxVUob5l6EyRw25cv5C/Woh2H+y2sHSsNeQFL0gM+kJtAbYT5Mu/wRXlTUeLo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4123.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(366004)(136003)(346002)(39860400002)(451199015)(6666004)(8936002)(5660300002)(83380400001)(41300700001)(186003)(6512007)(26005)(2906002)(31686004)(478600001)(316002)(6506007)(6486002)(54906003)(53546011)(86362001)(4326008)(36756003)(66476007)(2616005)(66556008)(66946007)(31696002)(38100700002)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TmNmenlPOWRiSTJmZ0RaTHJuaDV5N0FPU3Y4TEpTYkFBc2V3Rmx3U0FxZW03?=
 =?utf-8?B?OTkrbHNVdnVaeTNoT0hXQktWZ0owNU80bWlPdk5JbnVTaU5YUEMrSjBxUUl1?=
 =?utf-8?B?bmUvL2lwK1R1Q3BVYzZLdUJPY21TaWdiRW4vcG82VS9UU2xycW5EOE1kRVJI?=
 =?utf-8?B?a2w5NldzY2pvYkN1SHNKMFcvNHFqRzErYmlXVXFjQ1I1eXdsQkQ5RHI5SXIv?=
 =?utf-8?B?LzdQM2dZVWdLWGdiU2ljcWlqZ2toanJYbXR4UFhYd2lBZG12czFEYy8yUXFm?=
 =?utf-8?B?MXhVQjRZTE5MbWFvRUM5UkxUY25YVUtxSEIvdGtCMWQvTzMrSGNiRkwvclRM?=
 =?utf-8?B?U0hCZmlNVExYdkdhbkwyeFQ4eWw4WmhKMkZsYzhUTXIvRU9MMHpOS1Y0MWdl?=
 =?utf-8?B?WjBIaVZvOHRsME1tT2JOdzZGeHVVa1M4dXpRd29palgvNCtSRTlIWVM4NXlJ?=
 =?utf-8?B?SkM1dDh3N0RXN294bTFSMnFEazNMRC8zbVVVWDZHU2RjdVFFYzFsVVpzZDFh?=
 =?utf-8?B?VnMvSjIxWVE1QTd2S0R3akRBYkZwczVNYUNkVGxkR0d1Q3A0QU9heUhVdk1H?=
 =?utf-8?B?TmFkdnducHIrYjdYcE5XTG1NSy9MSHl0MTIzVXFYQWZvWjJrek9oQWlFb1dy?=
 =?utf-8?B?c21ZN3pJeXpJSy93bkN0RDBTTmhPVnFJNzhoc3JOSVJMSkFjaTd5REVFcC8y?=
 =?utf-8?B?eEpJMnlPS2k3bUxkZmxCL2N3VkdWVERzS25zeU1uTUFFcUNETjd0ZmpKemRz?=
 =?utf-8?B?ZkQwMGQzT3NuRm0rKzRHdWxTZ1lQQzF3VXYxcGsxcHVDQTRJQ1RRWDFnSXRj?=
 =?utf-8?B?OWJhNlpwcENnR2lOSDN6VUFYZDNkWUxtbUhtNkJuSnB4bG9pQWI5cVdsdTNm?=
 =?utf-8?B?eVFZQi9JMGNOVjRZOElTOUJPODB0d3ZJVGY3R3MyZ2ZBOUNxUVpvdFFkZnFs?=
 =?utf-8?B?aXY4bjhYT1JXeEx3RlQ2QndOZjk5dHNoblQ0clcxeW1CWXV1bys0RnBLMkVr?=
 =?utf-8?B?UlZ6STM3ekg4YUxRbEIyWXJYL3F2bzd3T3M4eHlYOHM2cXZ3bExaYU83dStv?=
 =?utf-8?B?VXNEMWNDSUttSmUya09mK2JML1I5aHRCeVprSjRkWFdIOWhPRHJmdE0zZndT?=
 =?utf-8?B?cFlhY09oSFI3VzRHQkQ0UlBjRUk0d3RuRk1DZW1oM2c4MGljcnNqSkZVdkcw?=
 =?utf-8?B?SlVEZW9sbktEWm9MZ0Z5cG52Wk1OWFJkM3h6bzFITVZra2RQYlJxT0xIbXZo?=
 =?utf-8?B?Q0ZWc1duUW1EL1pUNjNZM2NwdlNzWUtUME1NRFVTamFjTXNPcE5YSUw5U0ho?=
 =?utf-8?B?Umd2d0g1bVY4UGFWaFdqMDh4L3BNOXc0Tms2MkRUeUh3b0JLNlFsajNjWExO?=
 =?utf-8?B?UnVacDZKRGVlN2VCWk9DNXBMYmxwVDA4UnlrZkNad25GUGtadllPSWZDaVAw?=
 =?utf-8?B?Z3hPVHZOZDdhVXovRnlXOUQ5dzBvZm5vWnBpWGR1YVE4QjlPZTcxck9uSDVQ?=
 =?utf-8?B?dXkxdGNiWmdzM0xCL2hOUnZrb3pUM1AwRjVKTFl6ZjFPRVo5R29pT3NRa3FD?=
 =?utf-8?B?UHczUkFOdlZsMEhLTm1qa25HU2xQQ3V4c0tSejJVTEpEVnNnelJXUXphVFUv?=
 =?utf-8?B?UC80TEw1NmZIc0U0aXc2b2NMVTV6dUNiQkg4ckVoSzJZK2VadEV0SlFaRUdW?=
 =?utf-8?B?bmYxUDJ1NWM2bmZ0aEtQWi9ZTUthcE41clpZNkR2Sk0vQWErbHJmQWIyTGRE?=
 =?utf-8?B?djBvMS9kRWZGTHpqTTZFc2hWS2JsVDUxMithcDREdTVEZU1NWFZCOEg1NlB2?=
 =?utf-8?B?VmU1Y1YrVDZJOWwvUDFFZy9pVVZKajdaWjczNHFxR1R6eFVuazI3RDMrUlFP?=
 =?utf-8?B?K0JmRlNaSmdVTU5rU1REMnNNNTcyTVF5VjFyQnErKzRjWUhlYWs2Szg5VWpX?=
 =?utf-8?B?QThZc3hrN0RuejZmL0hLOURpNXBoN1hyUmtyd0xQUVZpb2NqL0RFdndvVDE4?=
 =?utf-8?B?N2N3azNMZ0xxWElnWThrc0p0SEhQbEplNTNXZnFQL1d5WUZoZ213R3QrMWtn?=
 =?utf-8?B?eHY2Z2EvTlNuLzU1bTl0ZHh4YVNXM292MVFQZ3Z0M2ltUDZRaUlHWmhqWWJz?=
 =?utf-8?Q?F+8HRTyxm1xJjxnuDRcheYKdc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1369e9c-9eb9-4d0f-ca73-08dae34ed624
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4123.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2022 12:28:16.9641
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LBk6TMKozWhCPBi2TCcbLLcvQeNYCJ+2bqEAiLkuGxuIy2xf8a9Wnzwmb+HvmlSfc14YUCPr0l3H/yROE9Q68g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4520
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/12/22 16:56, Vijendar Mukunda wrote:
> Implement API to retrieve acp device config and calculate platform
> device count and dev mask for platform device node creation.
>
> Currently for DMIC configuration, mask and dev count are calculated.
> Same api will be used to extend support for different ACP device
> configurations.

By mistake, patch series was sent as V2 instead of V1.
>
> Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
> ---
> v1->v2:
>     - used ACP_DMIC_DEV macro instead of hard coded value
>     - changed is_dmic_dev variable initialization
>     - changed debug level
>
>  sound/soc/amd/ps/acp63.h  |  7 +++++++
>  sound/soc/amd/ps/pci-ps.c | 37 +++++++++++++++++++++++++++++++++++--
>  2 files changed, 42 insertions(+), 2 deletions(-)
>
> diff --git a/sound/soc/amd/ps/acp63.h b/sound/soc/amd/ps/acp63.h
> index 5e7f9c1c1b0e..b015e845e5fa 100644
> --- a/sound/soc/amd/ps/acp63.h
> +++ b/sound/soc/amd/ps/acp63.h
> @@ -54,6 +54,11 @@
>  /* time in ms for runtime suspend delay */
>  #define ACP_SUSPEND_DELAY_MS	2000
>  
> +#define ACP63_DMIC_ADDR		2
> +#define ACP63_PDM_MODE_DEVS		3
> +#define ACP63_PDM_DEV_MASK		1
> +#define ACP_DMIC_DEV	2
> +
>  enum acp_config {
>  	ACP_CONFIG_0 = 0,
>  	ACP_CONFIG_1,
> @@ -102,4 +107,6 @@ struct acp63_dev_data {
>  	struct resource *res;
>  	bool acp63_audio_mode;
>  	struct platform_device *pdev[ACP63_DEVS];
> +	u16 pdev_mask;
> +	u16 pdev_count;
>  };
> diff --git a/sound/soc/amd/ps/pci-ps.c b/sound/soc/amd/ps/pci-ps.c
> index 489f01a20699..9066a625e501 100644
> --- a/sound/soc/amd/ps/pci-ps.c
> +++ b/sound/soc/amd/ps/pci-ps.c
> @@ -132,6 +132,38 @@ static irqreturn_t acp63_irq_handler(int irq, void *dev_id)
>  	return IRQ_NONE;
>  }
>  
> +void get_acp63_device_config(u32 config, struct pci_dev *pci, struct acp63_dev_data *acp_data)
> +{
> +	struct acpi_device *dmic_dev;
> +	const union acpi_object *obj;
> +	bool is_dmic_dev = false;
> +
> +	dmic_dev = acpi_find_child_device(ACPI_COMPANION(&pci->dev), ACP63_DMIC_ADDR, 0);
> +	if (dmic_dev) {
> +		if (!acpi_dev_get_property(dmic_dev, "acp-audio-device-type",
> +					   ACPI_TYPE_INTEGER, &obj) &&
> +					   obj->integer.value == ACP_DMIC_DEV)
> +			is_dmic_dev = true;
> +	}
> +
> +	switch (config) {
> +	case ACP_CONFIG_0:
> +	case ACP_CONFIG_1:
> +	case ACP_CONFIG_2:
> +	case ACP_CONFIG_3:
> +	case ACP_CONFIG_9:
> +	case ACP_CONFIG_15:
> +		dev_dbg(&pci->dev, "Audio Mode %d\n", config);
> +		break;
> +	default:
> +		if (is_dmic_dev) {
> +			acp_data->pdev_mask = ACP63_PDM_DEV_MASK;
> +			acp_data->pdev_count = ACP63_PDM_MODE_DEVS;
> +		}
> +		break;
> +	}
> +}
> +
>  static int snd_acp63_probe(struct pci_dev *pci,
>  			   const struct pci_device_id *pci_id)
>  {
> @@ -183,6 +215,7 @@ static int snd_acp63_probe(struct pci_dev *pci,
>  	if (ret)
>  		goto release_regions;
>  	val = acp63_readl(adata->acp63_base + ACP_PIN_CONFIG);
> +	get_acp63_device_config(val, pci, adata);
>  	switch (val) {
>  	case ACP_CONFIG_0:
>  	case ACP_CONFIG_1:
> @@ -195,14 +228,14 @@ static int snd_acp63_probe(struct pci_dev *pci,
>  	default:
>  
>  		/* Checking DMIC hardware*/
> -		adev = acpi_find_child_device(ACPI_COMPANION(&pci->dev), 0x02, 0);
> +		adev = acpi_find_child_device(ACPI_COMPANION(&pci->dev), ACP_DMIC_ADDR, 0);
>  
>  		if (!adev)
>  			break;
>  
>  		if (!acpi_dev_get_property(adev, "acp-audio-device-type",
>  					   ACPI_TYPE_INTEGER, &obj) &&
> -					   obj->integer.value == 2) {
> +					   obj->integer.value == ACP_DMIC_DEV) {
>  			adata->res = devm_kzalloc(&pci->dev, sizeof(struct resource), GFP_KERNEL);
>  			if (!adata->res) {
>  				ret = -ENOMEM;

