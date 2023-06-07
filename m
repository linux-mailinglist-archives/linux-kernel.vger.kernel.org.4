Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCB007254BE
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 08:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237959AbjFGGvN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 02:51:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234994AbjFGGvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 02:51:10 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA3631723
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 23:51:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BQ4J8/hMoqsnio1wF2EG4DYJ3Mb7g/hY09k5mrItI+ef9J+HTnyNnqe3OygI2+UlP5KyUHGDKwlNbtIkrLscgPuvevb5OE0p77HX4QcTJ4BrJv312SDS7RrkLgqfSUlHMTTFhDPwGCmAP/A7zNULVuOU7Xty14Yz2mZAXGem4g5eOJGsaoprE8O6yQZ0jvMBm3wSIP93vodqWqngR+7iaz+xYW/CNyH8wzDOixc3+Xz6B1d7hGUwJSf6K8n/TvZca0ySy5fgr1yoJ7Tw4iwxwIRbZcuVTQp4todIZTKRtun5YY2/MnxBxELepiKOEvqNA3bwjcqyJwANxDN5hfc2Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3duK25oAgHbss2A8wMDw+wJJ83s1MZ0s5UTCEnh/I58=;
 b=OTd/wEh0tpPa4NBx7BWHcV3IHeqx/TNihp7JVFVc0LI5Lt/TXGEzWRUXQ12NUvfIFMl4QH0kQITMZYepqouVN7f7T8QDmbquTnaxxiO/rae2XJ/VjjKahfPL0LKl871bBwKpm0pebzMcSJ0KAXM+hqxVEF4UD+N8Je/xR0aPzKgq5lbCWl0yvJyLhJl63TId0CRBD8k5dieIy+QPTBzPnDYzTecHHH8wLeIvKlZwiWFBCV2vju6YfnFODQggRBFmGA8auPrnrG4YZqSgAlBadXveNtYnd+bsfkT+PLIpDYe3+4zx2bILBR03SXyqpcN45s064sxb4GbzXjRLjFhL+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3duK25oAgHbss2A8wMDw+wJJ83s1MZ0s5UTCEnh/I58=;
 b=fA+ejeAQ8Ns2Z9iee6zAMHsDLqo7MZXDYKCLz3w+nd8ZQnjTnSeUwqZdpAx8CGWJ4kQRfOGN+boH1aGds4Wl2gBndVDoGgs+XO4xmX7cvGcmgVdcRXUM/1QBQdNPN/J2bjnpTvLHWU/ugB1NyxXCS7rfYHlfqNM85RWmjQL2Sr8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4123.namprd12.prod.outlook.com (2603:10b6:5:21f::23)
 by DS0PR12MB6584.namprd12.prod.outlook.com (2603:10b6:8:d0::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.33; Wed, 7 Jun 2023 06:51:06 +0000
Received: from DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::8760:2e89:1243:2b5d]) by DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::8760:2e89:1243:2b5d%6]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 06:51:06 +0000
Message-ID: <de3c86cc-6cba-0cbd-0e04-43711b4c9bc2@amd.com>
Date:   Wed, 7 Jun 2023 12:25:48 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH V3 5/9] ASoC: amd: ps: add support for SoundWire DMA
 interrupts
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
 <20230606060724.2038680-6-Vijendar.Mukunda@amd.com>
 <6c44969f-4d25-7b71-cd35-cd7087e083e4@linux.intel.com>
From:   "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
In-Reply-To: <6c44969f-4d25-7b71-cd35-cd7087e083e4@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0087.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9a::12) To DM6PR12MB4123.namprd12.prod.outlook.com
 (2603:10b6:5:21f::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4123:EE_|DS0PR12MB6584:EE_
X-MS-Office365-Filtering-Correlation-Id: 509406c9-cec1-4991-ffe7-08db67239144
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jWN+tLVF9gG1uZytITXJYgEvjvTSVwfLxsPSJ7IqZjXtYwQ62osj9UeeHbYQyjv3NxFSDLOKY6Lxqzl7NdFXAOz581Nxh+9wIHmsFQp/cjKZJy2ysZbXRvv1Xux/iQNA50JJ8EWc9OtHwXUv01kGuWC+2Qyg9VxC62ISiq+qK5h1dzq8ka+Vbl/zqgq0sv1ZqXzKPTSHgLeflI9zdm8zzgtsNIEyyMdRS+c7m4DxYzE4X6EN76/DDNyiVcRDOe08ShYJYusv6RZQ+yJle4FTPkQRYzkSWcevuGyA30jvqmBqplxHzMZpTmHK0rBL5G2mxDg1S+g+dLaNC9Va1oePjUbl/aM6V8Frkh0h1CfeH7aSpQqlK9c7nKczkHQ279Cv37D0sxrr5bNT5xLvb/dZy5glTHGHZYcgoaU2otYUPqp+LOow/tNDPUgxivVbzUSckuJIHv5Nbx6vwhX1id0NQ8leAoh41PIHEuuSPip+f7bmpdPGmtcXuCmzvKBEq0iJPLLQJMVeV+5DBRma6LM4uHn6fkaW5rqB0fb67FZdIFz1NXzrYjReLr0/VSHzWJYa0k3CA2SbkRLPJ7iozEC3/wMIK1aNFoj2UUK7cW9XSJwfCnbsDNDtRtBcedEjAWLeG3Z72DpW9Kqq+sAikTBbPQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4123.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(366004)(39860400002)(376002)(396003)(451199021)(54906003)(478600001)(5660300002)(8676002)(8936002)(4326008)(66946007)(66556008)(66476007)(316002)(41300700001)(38100700002)(2616005)(186003)(83380400001)(6486002)(6666004)(53546011)(6512007)(6506007)(26005)(31696002)(86362001)(36756003)(2906002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VmJ1eGJQUVQ4RVZWMGJYK3pKUzlhdFhqV0R1RDd4NFFBU2RNa3c5QmVQa1N3?=
 =?utf-8?B?S09KUnNCUmZVOVlLRkRWYTZNSEQvcHEzSlMydS9oc1VUcHoxQ29vbDEwb2VC?=
 =?utf-8?B?c1dXWUc5MllFMERKOEVUb1ZESDhHVFlrUjFVdk1lZWZjSnpCY1pXTjZSNmJF?=
 =?utf-8?B?QkZWVnJ5LzRPNG5mTkM2Q3JnZWx4VnpTQkRrQnFWOHhvZlI1a1FDNGtFL09m?=
 =?utf-8?B?eGRtR1pjeXZrYkxvblJ4c3Z0OC9yRWZkUThHNDRnTTQwdWw5a3pVVkV1cDNl?=
 =?utf-8?B?VnZQM2tpQTFiS0w0bHJXOGpwcVFBZHkvQld2Z0dWbzhRZjYybjl6WDEyZk9W?=
 =?utf-8?B?Z2tpdzgzWmlpUzhzakM4TXR2S1Irc1p1S2gwU2FTYzFBd1gzZlBIZFRlVEx5?=
 =?utf-8?B?bXZ0bE5SQWJwNzVnNlNlQ25rb3MrQXBDWFhwcEhYNHgwUHNDYkZVUWNuTDlC?=
 =?utf-8?B?YjFxdGhmSzlaUExnK213eDgyYVRJYXBVbEw4MDJkK0V4RUZUc25ROWZCSksw?=
 =?utf-8?B?YlE0RjNtMUZMTzMvQmF3Yyt0bSsxUEFWVC9NKzdia2JVcGFaMjVYN3o2RWE5?=
 =?utf-8?B?SHlqZHQraWRmbzU1MHU2ZXBqaU9IemlHL0MwTnl5bjZrbFluN1ZPQlhEU1oz?=
 =?utf-8?B?UEJxanVDZllnU1R4TGxuUGhwUy8vNm5MVFhHVldHc2lPYnRBQXA5ZXl6RzNI?=
 =?utf-8?B?ZFcyS0dUQkVFSEFFZGRNS3JvcGY1NGNoc1B2d05IZnBsbm1iL2ZSTGRzWGp5?=
 =?utf-8?B?aUh4VmNwWDJJWjY0Tk9vSG53bVZ1WExVR0hkaXZzWTVIbTJBdnFmcjdEaUtM?=
 =?utf-8?B?R2FXUjVPODkvUXdDS1kzSmxUaVNleEQ4dWpXNWplTzhmOThlK09CTVAybWpr?=
 =?utf-8?B?SnBaOW9DTDdGZnZhMjl2SVZOQzRLdEhwRmE2bUpQdXZ2Y3hMMEFjRzhBaTMw?=
 =?utf-8?B?L2VGdHB0TUs0VjNjbm5ZS3dIanJDay9qb1BiUm1NRXozTFN3YVR5eGJqcXpM?=
 =?utf-8?B?Z3ZESUNXYlFWQk4rN3ZLNTlMVWN6dEdtdVVzRitEY01FcmhvVW85ZWV6NThJ?=
 =?utf-8?B?Ukh0L0o1dy9QT0FWVXRUd1RYZmMySlhGTGVaWVVsWldOVHcrcDlYUzROM2xR?=
 =?utf-8?B?YlpmZVA5UXhLcnRIT0lWVDhCNHdkVERRSHUvR2pvY0dUb0lYeHFSbVVPUVRl?=
 =?utf-8?B?L01WbStIUEhQSGtkaHJyNGV0Y1MwNUdDTVVjd3F2emx4SUVzc2JYWHJ6bld3?=
 =?utf-8?B?dnZydVJIUzdKc20xd3FSVFQveVpJR21iejhPdG5yVlF5bzJkd1BGSzFaY2Yv?=
 =?utf-8?B?Wi9ub2ExVUVaVDdUWXRaWUQ2WXB5akdua1lYV29KdFZpZVREdlJVeFkxbGZo?=
 =?utf-8?B?RlZ6M3NhTkxUb2pJdG5EalVaYjd2ZGpMNUlFREtObDNuSXhKMWN4SDFJZjVN?=
 =?utf-8?B?aTdDQVVuTUY5Si8yUlhES2t1RGVab2RvSmhJaXIrdDByR2pxT0xHZ0tYL3BX?=
 =?utf-8?B?aDVyNng5SjdMZ1Y1cWtYdkhHa3VuN0xpOWpwRGI1VEMxYnd0eU5FeUgxSExx?=
 =?utf-8?B?V0FtYWZwaHR5MXVMS1p2T1JBRkF4VEVseGZnRkpoRkxNZXhDNXhGUi8rMjcx?=
 =?utf-8?B?RnFhOCtXTzdraElNdnJMMkNVVk4vR0pEQXdJc2ptQS95Y21BQXB4RXV5MkF6?=
 =?utf-8?B?Mk9ndTF3SDNkdy9JQmU2bVB2elU4Vkc2bTVjcDhETGVrYjRHTVpldnN2U0dY?=
 =?utf-8?B?b0ZpYzZTcE83RUVadUhYb3FVUElhZ0hWWUMzenZwL2k0Zkc5cTd6ajhXbEhI?=
 =?utf-8?B?RmtLU2ZsczdqcWM1SEdVU0EvR2EyM1lHS0M5UHdOcTJPN2lrSmFGdWlMTmhx?=
 =?utf-8?B?YWZ6MEtuc3ZjcmpqRTcvSWwzYVZnMHZ0bk0rRTdodmNLNVZBVFNvdGFxZHlN?=
 =?utf-8?B?R0cvMmZXQ2hDanE4OHRyeUs0ckd5VDMrV3R6QzNIYlBTeHJCS3o0ZzZ5cmpL?=
 =?utf-8?B?RU8wRVpQRDVsYnREV2IrdVZhWGtaVEczZWdLRENjc05nUkJYUll2VlB1Q2Ey?=
 =?utf-8?B?RjVBb0t4QnEwcmRMNW5sbnBMRVdZTk9rTDEwdlV2T01hRDlNYi8wZ0dpRHd0?=
 =?utf-8?Q?n2abMzSVxBmGGY8vhPhgXz6uv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 509406c9-cec1-4991-ffe7-08db67239144
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4123.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 06:51:06.5318
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qZt01T7R91wbtaE7dZpdz5J50+Yq/OB3RLeB6A79lEVR24ueQSvNQfXdvYELSIG6qyo8mp6Xhq4qwbK3DutIBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6584
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

On 06/06/23 20:29, Pierre-Louis Bossart wrote:
>> +enum amd_sdw0_channel {
>> +	ACP_SDW0_AUDIO0_TX = 0,
>> +	ACP_SDW0_AUDIO1_TX,
>> +	ACP_SDW0_AUDIO2_TX,
>> +	ACP_SDW0_AUDIO0_RX,
>> +	ACP_SDW0_AUDIO1_RX,
>> +	ACP_SDW0_AUDIO2_RX,
>> +};
>> +
>> +enum amd_sdw1_channel {
>> +	ACP_SDW1_AUDIO1_TX,
>> +	ACP_SDW1_AUDIO1_RX,
> any specify reason why SDW0 starts with AUDIO0 and SDW1 with AUDIO1?
Currently, SDW0 instance uses 3 TX, 3 RX  ports whereas SDW1 instance
uses 1 TX, 1 RX ports.

For SDW1 instance, It uses AUDIO1 register set as per our register spec.
We have mantained similar mapping convention here for enums as well.
We have already described SoundWire instance TX/RX ports mapping
in comments in amd_manager.h file.
Please refer comments mentioned in amd_manager.h file.
>
>> +};
>> +
>>  struct pdm_stream_instance {
>>  	u16 num_pages;
>>  	u16 channels;
>> @@ -239,6 +253,8 @@ struct sdw_dma_ring_buf_reg {
>>   * @sdw0_dev_index: SoundWire Manager-0 platform device index
>>   * @sdw1_dev_index: SoundWire Manager-1 platform device index
>>   * @sdw_dma_dev_index: SoundWire DMA controller platform device index
>> + * @sdw0-dma_intr_stat: DMA interrupt status array for SoundWire manager-SW0 instance
>> + * @sdw_dma_intr_stat: DMA interrupt status array for SoundWire manager-SW1 instance
>>   * @acp_reset: flag set to true when bus reset is applied across all
>>   * the active SoundWire manager instances
>>   */
>> @@ -256,6 +272,8 @@ struct acp63_dev_data {
>>  	u16 sdw0_dev_index;
>>  	u16 sdw1_dev_index;
>>  	u16 sdw_dma_dev_index;
>> +	u16 sdw0_dma_intr_stat[ACP63_SDW0_DMA_MAX_STREAMS];
>> +	u16 sdw1_dma_intr_stat[ACP63_SDW1_DMA_MAX_STREAMS];
>>  	bool acp_reset;
>>  };
>>  
>> diff --git a/sound/soc/amd/ps/pci-ps.c b/sound/soc/amd/ps/pci-ps.c
>> index 17e29a3e1c21..daf54fe9cafd 100644
>> --- a/sound/soc/amd/ps/pci-ps.c
>> +++ b/sound/soc/amd/ps/pci-ps.c
>> @@ -99,14 +99,44 @@ static int acp63_deinit(void __iomem *acp_base, struct device *dev)
>>  	return 0;
>>  }
>>  
>> +static irqreturn_t acp63_irq_thread(int irq, void *context)
>> +{
>> +	struct sdw_dma_dev_data *sdw_dma_data;
>> +	struct acp63_dev_data *adata = context;
>> +	u32 stream_index;
>> +	u16 pdev_index;
>> +
>> +	pdev_index = adata->sdw_dma_dev_index;
>> +	sdw_dma_data = dev_get_drvdata(&adata->pdev[pdev_index]->dev);
>> +
>> +	for (stream_index = 0; stream_index < ACP63_SDW0_DMA_MAX_STREAMS; stream_index++) {
>> +		if (adata->sdw0_dma_intr_stat[stream_index]) {
>> +			if (sdw_dma_data->sdw0_dma_stream[stream_index])
> can this test be false?
Our intention is to invoke period elapsed callback for active substreams
based on irq received. Its good to have a NULL check for substream.
>
>> +				snd_pcm_period_elapsed(sdw_dma_data->sdw0_dma_stream[stream_index]);
>> +			adata->sdw0_dma_intr_stat[stream_index] = 0;
>> +		}
>> +	}
>> +	for (stream_index = 0; stream_index < ACP63_SDW1_DMA_MAX_STREAMS; stream_index++) {
>> +		if (adata->sdw1_dma_intr_stat[stream_index]) {
>> +			if (sdw_dma_data->sdw1_dma_stream[stream_index])
> can this test be false?
Please refer above comments.
>
>> +				snd_pcm_period_elapsed(sdw_dma_data->sdw1_dma_stream[stream_index]);
>> +			adata->sdw1_dma_intr_stat[stream_index] = 0;
>> +		}
>> +	}
>> +	return IRQ_HANDLED;
>> +}
>> +
>>  static irqreturn_t acp63_irq_handler(int irq, void *dev_id)
>>  {
>>  	struct acp63_dev_data *adata;
>>  	struct pdm_dev_data *ps_pdm_data;
>>  	struct amd_sdw_manager *amd_manager;
>>  	u32 ext_intr_stat, ext_intr_stat1;
>> +	u32 stream_id = 0;
>>  	u16 irq_flag = 0;
>> +	u16 sdw_dma_irq_flag = 0;
>>  	u16 pdev_index;
>> +	u16 index;
>>  
>>  	adata = dev_id;
>>  	if (!adata)
>> @@ -153,6 +183,56 @@ static irqreturn_t acp63_irq_handler(int irq, void *dev_id)
>>  			snd_pcm_period_elapsed(ps_pdm_data->capture_stream);
>>  		irq_flag = 1;
>>  	}
>> +	if (ext_intr_stat & ACP_SDW_DMA_IRQ_MASK) {
>> +		for (index = ACP_AUDIO2_RX_THRESHOLD; index <= ACP_AUDIO0_TX_THRESHOLD; index++) {
>> +			if (ext_intr_stat & BIT(index)) {
>> +				writel(BIT(index), adata->acp63_base + ACP_EXTERNAL_INTR_STAT);
>> +				switch (index) {
>> +				case ACP_AUDIO0_TX_THRESHOLD:
>> +					stream_id = ACP_SDW0_AUDIO0_TX;
>> +					break;
>> +				case ACP_AUDIO1_TX_THRESHOLD:
>> +					stream_id = ACP_SDW0_AUDIO1_TX;
>> +					break;
>> +				case ACP_AUDIO2_TX_THRESHOLD:
>> +					stream_id = ACP_SDW0_AUDIO2_TX;
>> +					break;
>> +				case ACP_AUDIO0_RX_THRESHOLD:
>> +					stream_id = ACP_SDW0_AUDIO0_RX;
>> +					break;
>> +				case ACP_AUDIO1_RX_THRESHOLD:
>> +					stream_id = ACP_SDW0_AUDIO1_RX;
>> +					break;
>> +				case ACP_AUDIO2_RX_THRESHOLD:
>> +					stream_id = ACP_SDW0_AUDIO2_RX;
>> +					break;
>> +				}
>> +
>> +				adata->sdw0_dma_intr_stat[stream_id] = 1;
>> +				sdw_dma_irq_flag = 1;
>> +			}
>> +		}
>> +	}
>> +
>> +	/* SDW1 BT RX */
>> +	if (ext_intr_stat1 & ACP_P1_AUDIO1_RX_THRESHOLD) {
>> +		writel(ACP_P1_AUDIO1_RX_THRESHOLD,
>> +		       adata->acp63_base + ACP_EXTERNAL_INTR_STAT1);
>> +		adata->sdw1_dma_intr_stat[ACP_SDW1_AUDIO1_RX] = 1;
>> +		sdw_dma_irq_flag = 1;
>> +	}
>> +
>> +	/* SDW1 BT TX*/
> keep spaces before */
will fix it.
>
>> +	if (ext_intr_stat1 & ACP_P1_AUDIO1_TX_THRESHOLD) {
>> +		writel(ACP_P1_AUDIO1_TX_THRESHOLD,
>> +		       adata->acp63_base + ACP_EXTERNAL_INTR_STAT1);
>> +		adata->sdw1_dma_intr_stat[ACP_SDW1_AUDIO1_TX] = 1;
>> +		sdw_dma_irq_flag = 1;
>> +	}
>> +
>> +	if (sdw_dma_irq_flag)
>> +		return IRQ_WAKE_THREAD;
>> +
>>  	if (irq_flag)
>>  		return IRQ_HANDLED;
>>  	else
>> @@ -544,8 +624,8 @@ static int snd_acp63_probe(struct pci_dev *pci,
>>  	ret = acp63_init(adata->acp63_base, &pci->dev);
>>  	if (ret)
>>  		goto release_regions;
>> -	ret = devm_request_irq(&pci->dev, pci->irq, acp63_irq_handler,
>> -			       irqflags, "ACP_PCI_IRQ", adata);
>> +	ret = devm_request_threaded_irq(&pci->dev, pci->irq, acp63_irq_handler,
>> +					acp63_irq_thread, irqflags, "ACP_PCI_IRQ", adata);
>>  	if (ret) {
>>  		dev_err(&pci->dev, "ACP PCI IRQ request failed\n");
>>  		goto de_init;

