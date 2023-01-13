Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0A2C669565
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 12:19:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240752AbjAMLTv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 06:19:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241565AbjAMLSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 06:18:35 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2044.outbound.protection.outlook.com [40.107.243.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 311397DE37
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 03:13:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d1ebtIq7w5tcqhHnlFQOccj02Rs/6zH0Im2Wl+YIlK7S9NGTiocWo8+jPO1L4uY84VCHM22aDDP4amGld/PNiDdJJQrg5N3EbooTmMUtqhSfrWvWqA+ZSWmM0G0ytf/X/zGooouxeqTaTlmcI4IQjDETZduzZVnOl+gDtY0FcujoakTIuRfDy5DwCTp/65c0+8RzKizMI/Ob7k0W4CMQrU4cgeLz4vhoMJKF8ZVt/+QoWbDIR1C1zmbWgRwOzQA6HrvZBOE4/U2s+rxkuhETHDIPS4M3oUxak4BVAuTZ5qfpLiyeFELyAjPoHLeb0SVggB20SayD1SLK+ixFJw6Z5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PDIOPS2edmKPC+5ohZjjO4+sfBRNwkAYgQXn268TCTM=;
 b=cQbXwOzDGYiNP573tM0Vn1JLwzmlkG1CC9xdFtf7f8lol4nwKg+KxgMHsGCKEyu+avk2NDdNKisvzK6D7iNNKy1CCusp9dpvvoPKbZsaRqV44lTxlTAROjee2WAMNWnN2A1CTGB+glbNxP5W+fXAtieQB2//aW+2OTZo/lrpvy3LmiLS2yR+UPEgtzTXqkaIoSjSyw23Vf1z1TPr5i++q9U2nanX4OXU7UeD4Cv6Hcub8Nb9L5DXxNVU7JnjGMGfDgTt2lMi3zTG/PwaFnhjkTILvfOqYDC4N6XieOwjPVB08QH1Oofm4k2IGB/75HXBmHJSfcTFv5x9PlqZySX6gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PDIOPS2edmKPC+5ohZjjO4+sfBRNwkAYgQXn268TCTM=;
 b=v+2nhpxdYBNxAZkQyxKFuQcnJo9OaW3w7WC92xXDOPSTkb/m4fBw1HsPRR57IzyIjHkEKLIkrjbbG5OG5xw6cv4yAPEw11iHZhmVDvx9PYeGGkKB/0AM+kLg7frEELKc8JY5pRafhAxXcbk2nzj6nX9vwuh0hfhRzKPk/IFkubY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4123.namprd12.prod.outlook.com (2603:10b6:5:21f::23)
 by MW5PR12MB5681.namprd12.prod.outlook.com (2603:10b6:303:19e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Fri, 13 Jan
 2023 11:13:16 +0000
Received: from DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::fc88:7080:445e:6866]) by DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::fc88:7080:445e:6866%5]) with mapi id 15.20.5986.019; Fri, 13 Jan 2023
 11:13:15 +0000
Message-ID: <6bb9b13c-2829-d7c3-872b-6e9586189300@amd.com>
Date:   Fri, 13 Jan 2023 16:46:25 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 08/19] ASoC: amd: ps: add soundwire dma driver dma ops
Content-Language: en-US
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        broonie@kernel.org, vkoul@kernel.org, alsa-devel@alsa-project.org
Cc:     Mastan.Katragadda@amd.com, Sunil-kumar.Dommati@amd.com,
        open list <linux-kernel@vger.kernel.org>,
        Basavaraj.Hiregoudar@amd.com, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mario.Limonciello@amd.com,
        arungopal.kondaveeti@amd.com,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>
References: <20230111090222.2016499-1-Vijendar.Mukunda@amd.com>
 <20230111090222.2016499-9-Vijendar.Mukunda@amd.com>
 <77e35f54-323e-42d0-9e74-be984eebc0fe@linux.intel.com>
From:   "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
In-Reply-To: <77e35f54-323e-42d0-9e74-be984eebc0fe@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0128.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::13) To DM6PR12MB4123.namprd12.prod.outlook.com
 (2603:10b6:5:21f::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4123:EE_|MW5PR12MB5681:EE_
X-MS-Office365-Filtering-Correlation-Id: f1f2643b-70f5-41ba-edcb-08daf5572aaf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Rq9G+FMjqjZNXmevMFtzNXD4SWFjlL4quyMLX7UqiGg7BfGVv8PzlyHGYaZS+0K3blxq6RwBnJAa4HOxAtVHQ0/t1wGO5guBgyu2DbtJuNg4elxCIXgk8iRN2lk/i5xFTCVXjMPE3aKvmzE3IoIr9VLH4LG+o5KRrlXRP5cICuzMv5bPln0JXASrO2at3nZnQPBb7uXMLxTEa7nmQjETTrWG4cVPzZAcSiklF5TVtvYJ75IHO4e19EQHS/P+XUdGAc10jqPQxf25w0QfIZEuTFYBQg+dswr0p93ccVqWGEmUFX229ki1p0u211unn2o6YdWgww9OviO9dOKoHZihpBbc9bndL2AFcF8PXMEzZxq9/9Wm99aOVRAMFplwV+qHj+W0Y8fO0kVYTPYfw35GVDNUp9Sq4QUrMyLt/A0nY1w13TKslnDBl3fs7j92YmngA2IwcLVyr2Zgy8R9k1AEtkjAlGO3Jl39+bWEd+J4lmesJpjUQPU7YUXXXYE6EEEuupSWUl6rIplWr5RZPWfuNyDwixoqKV2EmJLOLRIT8meqYGxfn2fU/RVj1jkkqdJag01x1KyuBD0WPxI4wNuYUt+cFOcNdgyS1rByoYnXz0kKmY7u0az9dHFT5bmPRGDRpaWps3L5ue1YatfjthGrxa/0D+RzbB+o3OeKn05WHjzms2OvHUw0xhm3yQEDCiaSFEpK3r2LtNsmqPZTPFNQTQwHBrJ16jFgTiWPAOJYxJk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4123.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(396003)(136003)(346002)(376002)(451199015)(53546011)(31686004)(66899015)(2906002)(6506007)(6486002)(26005)(6512007)(6666004)(478600001)(186003)(8676002)(2616005)(83380400001)(66946007)(36756003)(316002)(66556008)(66476007)(54906003)(4326008)(41300700001)(38100700002)(31696002)(86362001)(8936002)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NENwRUxWSkFJYURvQ21UczJpYUVmK1ByTkJjSE1MSlQ4ZXUxYTVLNWMrME52?=
 =?utf-8?B?U1FOd2FCTTNhTDZUWkF4c2ljSkdjK1dxcGZ2dTAxeERZL2dKbWZhMzNZSzVJ?=
 =?utf-8?B?Zy80K3FiTXJlcmhrTUtDcDFJQW1SMkthYTkyL3ZLM2NTdHo3ZllZR1BEZDVw?=
 =?utf-8?B?VEYzY1V3ZDNZeVlCL21TMlVRaGU4dGlsTWF2U29oaEtpeVVrak4wODRrTHhs?=
 =?utf-8?B?OGg1KytGK3pmd3k4YkM1ZENneENqQTYyUU9nSGYyOURKbFIyMDE0aVdrQnF3?=
 =?utf-8?B?YlRUVDV5Ky93Z25KZGFzUmdqblkvT1Q2QUpLQ1VVbnJQMnpTalliYUFVZ1U0?=
 =?utf-8?B?WENKM3Y1M2REcEZLdDdOWGVKVm9NM293bE02bmo4amswRWk0NWhYUzB1bmJv?=
 =?utf-8?B?OHA3SXdVcUNsN3R2bEJPOHVRZ21iQ0FMV0pLc2NVWjlKZFFZVWxXMkgyaGF4?=
 =?utf-8?B?U3BGUTJ5M25ObjhjaGptdWsvL0VhR3Btem5hNkpvSW40QXlqUElKTEF6S2Zw?=
 =?utf-8?B?OElxbllUSnp1emJmWEFHOFVYWURScVN6aUJSWE44UXExOWt5blVqejBHM1RL?=
 =?utf-8?B?MENvbWR5UFVkS1ZVb21YL0tuZnpnSVVKNXc5NDlPaDhTbFVnVUdoLzA3b3VI?=
 =?utf-8?B?WjZ6YnQ2LzIvSG1keE1XSHJOeGxvb0hNbEVqOHk0ejRYK1NIUy92aEdaRy84?=
 =?utf-8?B?UUc4L1FCSDh3UnhwdVM3dmlwZFBucjM0dWNjL1dsU1RoMHBYM3NUUXJHeDRK?=
 =?utf-8?B?TURNRTRYdlZsM0tqN2JNaVBtRGdsYzNNQnBsc21OSGNtYzgvOElXOTNEZVBz?=
 =?utf-8?B?dVNPaTRIL2gydkN2RE9rM28wYjRIUVg0VG9JY1BlWlcwYU5hQlNZOU1UeHZW?=
 =?utf-8?B?WTVlTS9XQ1NtS2w2WW05WWxHK2l6QkN3RGpnR01lQ3lyYXVRd3dmRTFsVUxs?=
 =?utf-8?B?YVZEeGZuKzEzYVFXZmNiTVEzSWhERHFxcTkwL084RTZJWm9CK3VZS2tKVHUy?=
 =?utf-8?B?MVBEZThDbE43aWpaOWtoRWp3dExVOGZUS3Z1cU16WVpHbHhnbUswbFBuOEw0?=
 =?utf-8?B?YmhqVXUwdkpWdlFmR0MwSjBJUmQ3dGdkUmlaNllzektOK1h0MzVoNkN0alJl?=
 =?utf-8?B?aU1wdmdmcHgwdG5NSTgyeXhCa1dpeXU4N24vYVphVlFGZnlCT1UrZlpKYk12?=
 =?utf-8?B?U05KVUI4d1NGMU4rZllLdlZKZWdsTkNKNEJ2N0x3MTUzQk1jZEg5c3BNNG0z?=
 =?utf-8?B?eFlqQkt4dEt1NjRkYWpzTzc3bVVMOGJrYUg0eWVWRnpYb2RvRWliTEJlL0la?=
 =?utf-8?B?Wk9MdmFiWDJLWkl6M0h2UHJ1SmtTUGhVL3kvNklZWWwvUmIxMUFsNzVLbXRF?=
 =?utf-8?B?OGdEbzVDZVVJcjhEK2V3eXNKYUw2MWhreGczMmF5Tlk0ZExiZ1B0UURDZTVt?=
 =?utf-8?B?aHk4QmR4dHNUWGd6Q25Ic21mU2szZnRlQ0VzTkhYRFdvWWFLeVFQdldxZzN2?=
 =?utf-8?B?TzJkNlpIeS9MSHhDRDZNSmtaNUZvdUVMNWZ0ei9zT2xFTzViTUcyekdCS1VJ?=
 =?utf-8?B?c2VZUWlyS251Q0svRDF3Q1pEOVNsVlBqeDFlNVJObGZZMGpoR1ZxN29iL1Rm?=
 =?utf-8?B?bXpHb2lXVXlVMDB0MlFxanpQcm9MZ1h5YlJWaFNlWFZzNzRJYmFVNWduMDlK?=
 =?utf-8?B?ejlHYmJkVSswVmtkbHVPOHArQUo4eWZITTIydmFRb3YyZGVlRWp0dzNFRHdS?=
 =?utf-8?B?QWVhVTFVM3VEUXU4aEhxK09kb0ZKZzdMeXZJbXJlZnJTTkwvZk9RVGY2aXBN?=
 =?utf-8?B?NjVlM3NhS2FteThlQmRkRHFpdmd6MEtFTzlrU2g0RHkxVEtubFFrWm1XY1l2?=
 =?utf-8?B?bVo3V0tOWHZsZDk2N0JSekVCUjF6RDNOSXZ5QldtQ2RWNTdJdUhYS1o4aG5j?=
 =?utf-8?B?MGZ0cERTWVJsRmNjR1BGNlpDalRnTUxQd2xXUC9kTFpYblRTbWRzOXRLTnZU?=
 =?utf-8?B?WFNIY1Y3RmNHaE5qWlRuS1UwRnowSDhBTXVxeW9RMnhobEtNTS8yQkVOMGNh?=
 =?utf-8?B?ekRnejN0Y2cvWXFMeTJndE5rdEE5NUZtNkNGb2hzY05PTkFraXJmQUxzVGNC?=
 =?utf-8?Q?7UFQrixYVbYn1pExbQWm6ISRL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1f2643b-70f5-41ba-edcb-08daf5572aaf
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4123.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2023 11:13:15.8166
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +3GNlCM3HS3V2qGH05Te/ln3+mROIH/yMvRxDpyy+eDTi+IstwREMOPKhfwdPVvy1v2oItS8T9GviCkEcs1O/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5681
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/01/23 21:04, Pierre-Louis Bossart wrote:
>
> On 1/11/23 03:02, Vijendar Mukunda wrote:
>> Add Soundwire DMA driver dma ops for Pink Sardine platform.
>>
>> Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
>> ---
>>  sound/soc/amd/ps/acp63.h      |  61 ++++
>>  sound/soc/amd/ps/ps-sdw-dma.c | 531 ++++++++++++++++++++++++++++++++++
>>  2 files changed, 592 insertions(+)
>>
>> diff --git a/sound/soc/amd/ps/acp63.h b/sound/soc/amd/ps/acp63.h
>> index b462320fdf2a..8963cfb6120d 100644
>> --- a/sound/soc/amd/ps/acp63.h
>> +++ b/sound/soc/amd/ps/acp63.h
>> @@ -67,6 +67,38 @@
>>  #define ACP_SDW0_IRQ_MASK	21
>>  #define ACP_SDW1_IRQ_MASK	2
>>  #define ACP_ERROR_IRQ_MASK      29
>> +#define ACP_AUDIO_TX_THRESHOLD	28
>> +#define ACP_BT_TX_THRESHOLD	26
>> +#define ACP_HS_TX_THRESHOLD	24
>> +#define ACP_AUDIO_RX_THRESHOLD	27
>> +#define ACP_BT_RX_THRESHOLD	25
>> +#define ACP_HS_RX_THRESHOLD	23
>> +#define ACP_P1_BT_TX_THRESHOLD	6
>> +#define ACP_P1_BT_RX_THRESHOLD	5
>> +#define ACP_SDW_DMA_IRQ_MASK	0x1F800000
>> +#define ACP_P1_SDW_DMA_IRQ_MASK	0x60
>> +#define ACP63_SDW_MAX_STREAMS		8
>> +
>> +#define ACP_DELAY_US		5
>> +#define SDW_MEM_WINDOW_START	0x4800000
>> +#define ACP_SDW_SRAM_PTE_OFFSET	0x03800400
>> +#define SDW_PTE_OFFSET		0x400
>> +#define SDW_FIFO_SIZE		0x100
>> +#define SDW_DMA_SIZE		0x40
>> +#define ACP_SDW_FIFO_OFFSET	0x100
>> +#define ACP_SDW_RING_BUFF_ADDR_OFFSET (128 * 1024)
>> +
>> +#define SDW_PLAYBACK_MIN_NUM_PERIODS    2
>> +#define SDW_PLAYBACK_MAX_NUM_PERIODS    8
>> +#define SDW_PLAYBACK_MAX_PERIOD_SIZE    8192
>> +#define SDW_PLAYBACK_MIN_PERIOD_SIZE    1024
>> +#define SDW_CAPTURE_MIN_NUM_PERIODS     2
>> +#define SDW_CAPTURE_MAX_NUM_PERIODS     8
>> +#define SDW_CAPTURE_MAX_PERIOD_SIZE     8192
>> +#define SDW_CAPTURE_MIN_PERIOD_SIZE     1024
>> +
>> +#define SDW_MAX_BUFFER (SDW_PLAYBACK_MAX_PERIOD_SIZE * SDW_PLAYBACK_MAX_NUM_PERIODS)
>> +#define SDW_MIN_BUFFER SDW_MAX_BUFFER
>>  
>>  enum acp_config {
>>  	ACP_CONFIG_0 = 0,
>> @@ -93,6 +125,17 @@ enum acp_pdev_mask {
>>  	ACP63_SDW_PDM_DEV_MASK,
>>  };
>>  
>> +enum channel_type {
>> +	ACP_SDW_AUDIO_TX = 0,
>> +	ACP_SDW_BT_TX,
>> +	ACP_SDW_HS_TX,
>> +	ACP_SDW_AUDIO_RX,
>> +	ACP_SDW_BT_RX,
>> +	ACP_SDW_HS_RX,
>> +	ACP_SDW1_BT_TX,
>> +	ACP_SDW1_BT_RX,
>> +};
> this was defined in another patch already?
will drop this change.
>
>> +
>>  struct pdm_stream_instance {
>>  	u16 num_pages;
>>  	u16 channels;
>> @@ -139,4 +182,22 @@ struct acp63_dev_data {
>>  struct sdw_dma_dev_data {
>>  	void __iomem *acp_base;
>>  	struct mutex *acp_lock;
>> +	struct snd_pcm_substream *sdw_stream[ACP63_SDW_MAX_STREAMS];
>> +};
>> +
>> +struct sdw_stream_instance {
> sdw_stream is already a well-defined concept. Please use sdw_dma_stream
> or something less confusing naming-wise.
will rename it.
>> +	u16 num_pages;
>> +	u16 channels;
>> +	u32 stream_id;
>> +	dma_addr_t dma_addr;
>> +	u64 bytescount;
>> +	void __iomem *acp_base;
>> +};
>> +
>> +union acp_sdw_dma_count {
>> +	struct {
>> +	u32 low;
>> +	u32 high;
>> +	} bcount;
>> +	u64 bytescount;
>>  };
>> diff --git a/sound/soc/amd/ps/ps-sdw-dma.c b/sound/soc/amd/ps/ps-sdw-dma.c
>> index 388a4b7df715..e94f76053c66 100644
>> --- a/sound/soc/amd/ps/ps-sdw-dma.c
>> +++ b/sound/soc/amd/ps/ps-sdw-dma.c
>> @@ -12,12 +12,543 @@
>>  #include <sound/pcm_params.h>
>>  #include <sound/soc.h>
>>  #include <sound/soc-dai.h>
>> +#include <linux/soundwire/sdw_amd.h>
>>  #include "acp63.h"
>>  
>>  #define DRV_NAME "amd_ps_sdw_dma"
>>  
>> +static const struct snd_pcm_hardware acp63_sdw_hardware_playback = {
>> +	.info = SNDRV_PCM_INFO_INTERLEAVED |
>> +		SNDRV_PCM_INFO_BLOCK_TRANSFER |
>> +		SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_MMAP_VALID |
>> +		SNDRV_PCM_INFO_PAUSE | SNDRV_PCM_INFO_RESUME,
>> +	.formats = SNDRV_PCM_FMTBIT_S16_LE |  SNDRV_PCM_FMTBIT_S8 |
>> +		   SNDRV_PCM_FMTBIT_U8 | SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S32_LE,
>> +	.channels_min = 2,
>> +	.channels_max = 2,
>> +	.rates = SNDRV_PCM_RATE_48000,
>> +	.rate_min = 48000,
>> +	.rate_max = 48000,
> is this really limited to 2ch 48kHz? This doesn't align with the
> references to Bluetooth above?
As of now we are enabling solution for 48khz, 2Ch, 16bit.
We will expand the coverage in the future.
>> +	.buffer_bytes_max = SDW_PLAYBACK_MAX_NUM_PERIODS * SDW_PLAYBACK_MAX_PERIOD_SIZE,
>> +	.period_bytes_min = SDW_PLAYBACK_MIN_PERIOD_SIZE,
>> +	.period_bytes_max = SDW_PLAYBACK_MAX_PERIOD_SIZE,
>> +	.periods_min = SDW_PLAYBACK_MIN_NUM_PERIODS,
>> +	.periods_max = SDW_PLAYBACK_MAX_NUM_PERIODS,
>> +};
>> +
>> +static const struct snd_pcm_hardware acp63_sdw_hardware_capture = {
>> +	.info = SNDRV_PCM_INFO_INTERLEAVED |
>> +		SNDRV_PCM_INFO_BLOCK_TRANSFER |
>> +		SNDRV_PCM_INFO_MMAP |
>> +		SNDRV_PCM_INFO_MMAP_VALID |
>> +		SNDRV_PCM_INFO_PAUSE | SNDRV_PCM_INFO_RESUME,
>> +	.formats = SNDRV_PCM_FMTBIT_S16_LE |  SNDRV_PCM_FMTBIT_S8 |
>> +		   SNDRV_PCM_FMTBIT_U8 | SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S32_LE,
>> +	.channels_min = 2,
>> +	.channels_max = 2,
>> +	.rates = SNDRV_PCM_RATE_48000,
>> +	.rate_min = 48000,
>> +	.rate_max = 48000,
> same here?
>
>> +	.buffer_bytes_max = SDW_CAPTURE_MAX_NUM_PERIODS * SDW_CAPTURE_MAX_PERIOD_SIZE,
>> +	.period_bytes_min = SDW_CAPTURE_MIN_PERIOD_SIZE,
>> +	.period_bytes_max = SDW_CAPTURE_MAX_PERIOD_SIZE,
>> +	.periods_min = SDW_CAPTURE_MIN_NUM_PERIODS,
>> +	.periods_max = SDW_CAPTURE_MAX_NUM_PERIODS,
>> +};
>> +
>> +static void acp63_config_dma(struct sdw_stream_instance *sdw_ins, u32 stream_id)
>> +{
>> +	u16 page_idx;
>> +	u32 low, high, val;
>> +	dma_addr_t addr;
>> +
>> +	addr = sdw_ins->dma_addr;
>> +	val = SDW_PTE_OFFSET + (stream_id * 256);
>> +
>> +	/* Group Enable */
>> +	acp63_writel(ACP_SDW_SRAM_PTE_OFFSET | BIT(31), sdw_ins->acp_base +
>> +		     ACPAXI2AXI_ATU_BASE_ADDR_GRP_2);
>> +	acp63_writel(PAGE_SIZE_4K_ENABLE, sdw_ins->acp_base +
>> +		     ACPAXI2AXI_ATU_PAGE_SIZE_GRP_2);
>> +	for (page_idx = 0; page_idx < sdw_ins->num_pages; page_idx++) {
>> +		/* Load the low address of page int ACP SRAM through SRBM */
>> +		low = lower_32_bits(addr);
>> +		high = upper_32_bits(addr);
>> +
>> +		acp63_writel(low, sdw_ins->acp_base + ACP_SCRATCH_REG_0 + val);
>> +		high |= BIT(31);
>> +		acp63_writel(high, sdw_ins->acp_base + ACP_SCRATCH_REG_0 + val + 4);
>> +		val += 8;
>> +		addr += PAGE_SIZE;
>> +	}
>> +
>> +	/*cache Invalidation added for Testing */
Below register programming is required. We will remove the comment.
> /* cache
>
>> +	acp63_writel(0x1, sdw_ins->acp_base + ACPAXI2AXI_ATU_CTRL);
>> +}
>> +static int acp63_sdw_dma_hw_params(struct snd_soc_component *component,
>> +				   struct snd_pcm_substream *substream,
>> +				   struct snd_pcm_hw_params *params)
>> +{
>> +	struct sdw_stream_instance *sdw_stream_data;
>> +	struct sdw_dma_dev_data *sdw_data;
>> +	u32 period_bytes;
>> +	u32 water_mark_size_reg;
>> +	u32 irq_mask, ext_intr_ctrl;
>> +	u64 size;
>> +	u32 stream_id;
>> +	u32 acp_ext_intr_cntl_reg;
>> +	int ret;
>> +
>> +	stream_id = 0;
> useless initialization...
Will remove it.
>> +	sdw_data = dev_get_drvdata(component->dev);
>> +	sdw_stream_data = substream->runtime->private_data;
>> +	if (!sdw_stream_data)
>> +		return -EINVAL;
>> +	stream_id = sdw_stream_data->stream_id;
> ... overriden here
>
>> +	sdw_data->sdw_stream[stream_id] = substream;
>> +	size = params_buffer_bytes(params);
>> +	period_bytes = params_period_bytes(params);
>> +	sdw_stream_data->dma_addr = substream->runtime->dma_addr;
>> +	sdw_stream_data->num_pages = (PAGE_ALIGN(size) >> PAGE_SHIFT);
>> +	acp63_config_dma(sdw_stream_data, stream_id);
>> +	ret = acp63_configure_sdw_ringbuffer(sdw_stream_data->acp_base, stream_id, size);
>> +	if (ret) {
>> +		dev_err(component->dev, "Invalid channel type\n");
>> +		return -EINVAL;
>> +	}
>> +	switch (stream_id) {
>> +	case ACP_SDW_AUDIO_TX:
>> +		water_mark_size_reg = ACP_AUDIO_TX_INTR_WATERMARK_SIZE;
>> +		irq_mask = BIT(ACP_AUDIO_TX_THRESHOLD);
>> +		acp_ext_intr_cntl_reg = ACP_EXTERNAL_INTR_CNTL;
>> +		break;
> so there's ONE resource to deal with external codecs? How does this work
> if you have a headset codec and an amplifier?
Are you referring to playing a same stream over headset codec and
amplifier?
It's all about channel selection from DMA perspective.
We have tested speaker aggregation and headset playback use cases.


>> +	case ACP_SDW_BT_TX:
>> +		water_mark_size_reg = ACP_BT_TX_INTR_WATERMARK_SIZE;
>> +		irq_mask = BIT(ACP_BT_TX_THRESHOLD);
>> +		acp_ext_intr_cntl_reg = ACP_EXTERNAL_INTR_CNTL;
>> +		break;
>> +	case ACP_SDW_HS_TX:
>> +		water_mark_size_reg = ACP_HS_TX_INTR_WATERMARK_SIZE;
>> +		irq_mask = BIT(ACP_HS_TX_THRESHOLD);
>> +		acp_ext_intr_cntl_reg = ACP_EXTERNAL_INTR_CNTL;
>> +		break;
>> +	case ACP_SDW1_BT_TX:
>> +		water_mark_size_reg = ACP_P1_BT_TX_INTR_WATERMARK_SIZE;
>> +		irq_mask = BIT(ACP_P1_BT_TX_THRESHOLD);
>> +		acp_ext_intr_cntl_reg = ACP_EXTERNAL_INTR_CNTL1;
>> +		break;
>> +	case ACP_SDW_AUDIO_RX:
>> +		water_mark_size_reg = ACP_AUDIO_RX_INTR_WATERMARK_SIZE;
>> +		irq_mask = BIT(ACP_AUDIO_RX_THRESHOLD);
>> +		acp_ext_intr_cntl_reg = ACP_EXTERNAL_INTR_CNTL;
>> +		break;
>> +	case ACP_SDW_BT_RX:
>> +		water_mark_size_reg = ACP_BT_RX_INTR_WATERMARK_SIZE;
>> +		irq_mask = BIT(ACP_BT_RX_THRESHOLD);
>> +		acp_ext_intr_cntl_reg = ACP_EXTERNAL_INTR_CNTL;
>> +		break;
>> +	case ACP_SDW_HS_RX:
>> +		water_mark_size_reg = ACP_HS_RX_INTR_WATERMARK_SIZE;
>> +		irq_mask = BIT(ACP_HS_RX_THRESHOLD);
>> +		acp_ext_intr_cntl_reg = ACP_EXTERNAL_INTR_CNTL;
>> +		break;
>> +	case ACP_SDW1_BT_RX:
>> +		water_mark_size_reg = ACP_P1_BT_RX_INTR_WATERMARK_SIZE;
>> +		irq_mask = BIT(ACP_P1_BT_RX_THRESHOLD);
>> +		acp_ext_intr_cntl_reg = ACP_EXTERNAL_INTR_CNTL1;
>> +		break;
>> +	default:
>> +		dev_err(component->dev, "%s: Invalid channel type\n", __func__);
>> +		return -EINVAL;
>> +	}
>> +
>> +	ext_intr_ctrl = acp63_readl(sdw_stream_data->acp_base + acp_ext_intr_cntl_reg);
>> +	ext_intr_ctrl |= irq_mask;
>> +	acp63_writel(ext_intr_ctrl, sdw_stream_data->acp_base + acp_ext_intr_cntl_reg);
>> +	acp63_writel(period_bytes, sdw_stream_data->acp_base + water_mark_size_reg);
>> +	return 0;
>> +}

