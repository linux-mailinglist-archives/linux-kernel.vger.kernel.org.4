Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 617396695C8
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 12:39:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240992AbjAMLjM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 06:39:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241262AbjAMLiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 06:38:09 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2061.outbound.protection.outlook.com [40.107.95.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3913E78175
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 03:28:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jbW6tif3SdVQ1CkHGoHOTQWumJM79Cqf2FH+V77fxJrb2ohHlwt6jOkF3U9HlHIpdUwLhvr+I/KzCsNG2iL7GVW4DjM7UWazSfuo+/OGZWfxa/I+/GWpt7XXjqFs1ghS8+npL6YyBYf/ZKkdYAq3um8RH5avu6AlpPwj16ksIhS7BgPHQsQBGR7efGbSFAuKn5zg06OZdX/8S0oKUJi7iuh8uMC9Vkm41EaSwOF2Do3nHXaJWrRUycH5Mxi/3Xxqe0zfXZkTrkign8eTekQ4oA7gyuoYrT0NWJJFejimco+nKJ6pjczSjLsca0F95zl3QcV231b6lzyervJdnC5Lrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mHNzfvWS/S12/cNz/biVSZS7C8Mefz00D42CNld2L60=;
 b=mpviIxEkon6GZ3ywSCoRTQyE0mUV9U7VQWnCvLkeLfUFM9/0AZC1XEOjid0cH3mbVeaba5DmMah9OxwXt3jZkwqyS/TLzdlzwIiu+MdybrNYfwMwgy5n2SEe9EWAAxVtjft9ZcXjyOh1EwkSaYHns6sSgBnzUzXhmUPJ0mOT4uh4bhXNFsCLhptaR+2Y/tZquaZ0glYBbcHQi/EnLkIrNjEqVhXm4Kv7yk/eSJY91pMWnynQd+IhF++TE6lABHxvY01K/p4QxwND57su0PjfUpEkcZa/DfQP1iGaJ4H+roKACVsIIR+YqS/XA3Y7YkA56hwEQ8yKHx3k0YKNgFJPcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mHNzfvWS/S12/cNz/biVSZS7C8Mefz00D42CNld2L60=;
 b=r5yMSbp1hbijNGrRpfhDWdfYewsBDPpFM5i6JsLKtyI0nnvVUnssXkFjX5CRCWTSdiv6Xwpg//kfmjDR47e9/oLhYTSZM/rNp8KJrfmvKLbsm3kR+u+aynl3ZwWCU2uEyY4RS891UyMeFX2jWPk+gOUAdgg5u3iat6bWjQmnpUY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4123.namprd12.prod.outlook.com (2603:10b6:5:21f::23)
 by LV2PR12MB5752.namprd12.prod.outlook.com (2603:10b6:408:14d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Fri, 13 Jan
 2023 11:28:24 +0000
Received: from DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::fc88:7080:445e:6866]) by DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::fc88:7080:445e:6866%5]) with mapi id 15.20.5986.019; Fri, 13 Jan 2023
 11:28:23 +0000
Message-ID: <abf07f9a-d34e-850f-1ed1-54b373960ce2@amd.com>
Date:   Fri, 13 Jan 2023 17:01:35 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 03/19] soundwire: amd: register sdw controller dai ops
Content-Language: en-US
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        broonie@kernel.org, vkoul@kernel.org, alsa-devel@alsa-project.org
Cc:     Basavaraj.Hiregoudar@amd.com, Sunil-kumar.Dommati@amd.com,
        Mario.Limonciello@amd.com, Mastan.Katragadda@amd.com,
        arungopal.kondaveeti@amd.com,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20230111090222.2016499-1-Vijendar.Mukunda@amd.com>
 <20230111090222.2016499-4-Vijendar.Mukunda@amd.com>
 <ad052efb-286e-4716-7608-d284782011cd@linux.intel.com>
From:   "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
In-Reply-To: <ad052efb-286e-4716-7608-d284782011cd@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN0PR01CA0011.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:4f::16) To DM6PR12MB4123.namprd12.prod.outlook.com
 (2603:10b6:5:21f::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4123:EE_|LV2PR12MB5752:EE_
X-MS-Office365-Filtering-Correlation-Id: b94eb1c9-1a6e-4921-2f62-08daf55947f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A9kpgB3ia4shLAa84fMlVO54sjawSK4bpC/iZNloDwFQaDW9FGMNs3t3YXVngretvHZFjsM7Z82XjH1lAETjYz63aIX5dHjEjIYr+gb9wbaKonS/cUkDYBC/LnS5VT8/4OfkWHS+2mgMxhIm3O+yUhkZFthDpFdkJ+s2f6iaWJVca4hv2zwf3PvsiO2ilKQ0e/AX2IhIvuoPa70YibAtjrxzVmo/5HiTKVe67Q6LH2RrSeKOo2nvm90fWzjLk5lpQN7X7pJyKixnzPldDzm7MF9EFAfmgfsGI1r9pTXjMo7OLpQiDv2i07eFLpXmaBTqAkB+L5I+41yvxuFBEoHgaEzE+GTr7x7yhqhIiezcUQfSQkrst6fVsodKb6WXf+EEZFEa3YwIWZd6eEQo3/b9CDScg9BXzH9hlxvmQg3ysmhHorLz18tSR+WTqPDz1xuRuYF1VeovHa9zBW0OCUWZHpncrFPH0tZCNu5HqtJ8IvZC0ZSk/E/xESxxsi+mEpVzTrWrXSGmPQslMHsPKIQmzcrf7PlCEgcdOQr+e/Og/uQ9ejA/aKchJN5L+Rlz4tXFQnC+bwo3VtsVfcl41BDpoNMel97LbrJQBgRl5hJOqTjzQAUGEdezWxvxlyQ/Evx+K7mYiA3C301+xdrYjoY0rCoipxVNxlDiz13HcKpebh0JR5yzgCc74Pi7NOeHRWB1va+DTK+DhgQx2xsA4tk2NEF4Qvsc2BZBxS9bP3PCmNg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4123.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(346002)(396003)(366004)(39860400002)(451199015)(66556008)(86362001)(31696002)(38100700002)(83380400001)(66476007)(4326008)(6486002)(66946007)(5660300002)(2906002)(8936002)(8676002)(53546011)(26005)(6512007)(186003)(6506007)(2616005)(6666004)(54906003)(316002)(41300700001)(478600001)(36756003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NkRXWUFUQXpDSWFnYmN2QXZibDVyNzlQN3JkYzI0L21aWndkbTF2TW5sdERi?=
 =?utf-8?B?QlYzY0NhSGhVRmRucXdST0lvR2wyWTlNczZtdFF6bWVHcCtPZkd4QmhQMW54?=
 =?utf-8?B?U3RjeHhnT0xnUWo5ZFZZNVpzODlBN1VCSTh6QzFkL3NKb0V1czhTY2VmL2py?=
 =?utf-8?B?b0xqQ3VOLzhJc3FJMFVBc0VDSFFuWkpGNWUyeWxYQSs5cGNzVHQzQ3QwYXlW?=
 =?utf-8?B?OG93eFl6MCtWNHZ0S0gwSGZPR0FDaGYzVDNMODBuU3hDd1c0S2w2TWxES01T?=
 =?utf-8?B?Uk1yZFQxMXpUdU90d0FoVUxTVGxVNjVnaVQzMVcvYXRGcnArYzZQRGprS1cx?=
 =?utf-8?B?QXRPTWFldzMvemtvY1ljWVhhdFYrWkhMdmE1L3U0YVJjd0hQaHlhamtwOW1L?=
 =?utf-8?B?d3grNXkyaVlLQnFTdzk2WHcybmNOVG11bm50Rzg4ZGxFaVA2Z294WlU2cVdq?=
 =?utf-8?B?cjIzRzZFMk03WHlGZzQwYXQrQ01DRnlveDA0cmt6cVF6bmlLOWo2T1l4SWdk?=
 =?utf-8?B?aUVEc2FDamc5TlZKYWhrV2xjZERmL2J1TXh0ci9Wb1FrR0twbDVxNVlhVUNn?=
 =?utf-8?B?WVNsRG5uWjMwaWo5WHdOTHo5RVBDMzJuRlZIeUNOMS9JY1l2WUpjMnU5dHRB?=
 =?utf-8?B?RVcvWWtNQXAvMGR2MnNXVkVLMDhXSFdGaVV1QzJkQ0Z0bXBqYzdtd1I2QzRD?=
 =?utf-8?B?S1poRzZrb1ZReHptdFdUOVd6NnVmamd4VkE1Y2Nwc21Dckh5dmVITXVTQita?=
 =?utf-8?B?Z2pCRjFYcW1VK0xLaTAvRTRUcjRLTlBSblQzb3VNTHlZeXlreDdWZWZ5Vitu?=
 =?utf-8?B?RzZCaWkxQ0FFWWJ0bi82Z2g0VmtORTFxRFVoTm5xeWRRYWJoSk45U1NiWmNZ?=
 =?utf-8?B?TGovUFRMTDEyTE10NWNsaTdwNzBNVW9MeW9DdXcrR3E4MTlGVElhVEhrKzlQ?=
 =?utf-8?B?dE1DUGQvR2x5UDRaQkpaQzhLZ0J1ajIwL0VpcFRlTUh0N1FuTUNMTUtyam5L?=
 =?utf-8?B?cTVRTi96R3NFa1BYWVJSWkM3OXF4SFdWNGZCUDRCV2ZHNkp3bmMyd0QvQ3RN?=
 =?utf-8?B?L0cxMWx0Z0tjaW9PQzhsdFlIWmptLzFQQlZhbW5KelNlb3Y4Sk5TTnNsOVpm?=
 =?utf-8?B?T3NIUTdjSVB2OEI2VjBENnJGdk5BNW9YcnlOcEIyOWtvMkxKUkJ6RE1tdTZX?=
 =?utf-8?B?bkpPM29ReXp5dFFzZXJvdUlDVUJ0d3lxcmFsOUxIZzJwZEhvUWttL0hrTEpP?=
 =?utf-8?B?ckh3NlRsWjhjZEhKeEhWUjlhUTlNN3hBTURtZjFlL0FHTjkxQlc1OStHSEJn?=
 =?utf-8?B?SGJ1MjQvdXBtaEJXUFk1UGhzUnJ2V21kamc4R2ZiR05oalZxcDRSZ2JuT1l0?=
 =?utf-8?B?eFFaOW03c2xDOFdiVkRxNFE2cjVRZGNZb0xxc1Rzbk1sUCtDQWR2S05UeS9G?=
 =?utf-8?B?bXdQb1RIZUNHQ2wvZXdYcy9PbXVPTG9SWENoNEI3UGJJWUFPbHF1Z3ZZWWdN?=
 =?utf-8?B?d2NBdXhwTGZyZVlFdEN3ZmZ4Y01uaTE4ck9OZDFXakNPdzkwRytYcC9WNVJu?=
 =?utf-8?B?eEVXMGRlclVJWStuUWFPVldsZzNpTzdmNDUwUGZHMHlNTE5UeGJ5b0dqdkZ4?=
 =?utf-8?B?cFhnN0pBY2NPYlJWRDlFWWFzSm9DM05IQ3piRjlKK0VmTkVLQWlvcjdCQ3BZ?=
 =?utf-8?B?UitEblpQbGwrMEJ5VmlJb05pV1JHMXl0Vk53NUtMSWpERFpxNTBMNnBrc0p0?=
 =?utf-8?B?ZnlyQ3grZXB2cWVBQTRyeFJpQjV0VEk3WldBV212VzJUUVBramNXSm5uTEFS?=
 =?utf-8?B?eGp6NE1NMlcrS2pHUGdQR3ZOMml4UXh2Sm44TlFuTjBzbHEyTjRsYXM0WFI1?=
 =?utf-8?B?L2FUNCtCZ0NpZnZieVlaSitidkFCQU9iQjVQUjlVN29yejNxSWFndzJkb01o?=
 =?utf-8?B?SmNJa2ZGbVJ2UlVhNHdWKzlweXRlWVhhN1FkaXhhb285NWRNZC9sOXlPK3Ew?=
 =?utf-8?B?YWdnOGE4WUdCd1A4MDBiZU92N0NXanlTbitjeXVRNVQvbzgrd20zUzNleVJS?=
 =?utf-8?B?V1lsMDZIcjA5QVUrS1JVd3I0Nnp4bk9ZTGRrZEM3QzBzTkwySXJRcFFyYk5m?=
 =?utf-8?Q?hTf77TCTK5Es9eVa3xfC0sPVF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b94eb1c9-1a6e-4921-2f62-08daf55947f9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4123.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2023 11:28:23.6784
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CHBA+o3ii4O6mwF5aGDEfoUeMZlRso3w9YQY1G20ErJ9cxnHRgMu3V7UV+zKz7B3Ee4dxdsdUJv+MuNYvKklkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5752
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/01/23 20:28, Pierre-Louis Bossart wrote:
>
> On 1/11/23 03:02, Vijendar Mukunda wrote:
>> Register dai ops for two controller instances.
> manager instances
will change it.
>
>> diff --git a/drivers/soundwire/amd_master.c b/drivers/soundwire/amd_master.c
>> index 7e1f618254ac..93bffe6ff9e2 100644
>> --- a/drivers/soundwire/amd_master.c
>> +++ b/drivers/soundwire/amd_master.c
>> @@ -952,6 +952,186 @@ static const struct sdw_master_ops amd_sdwc_ops = {
>>  	.read_ping_status = amd_sdwc_read_ping_status,
>>  };
>>  
>> +static int amd_sdwc_hw_params(struct snd_pcm_substream *substream,
>> +			      struct snd_pcm_hw_params *params,
>> +			      struct snd_soc_dai *dai)
>> +{
>> +	struct amd_sdwc_ctrl *ctrl = snd_soc_dai_get_drvdata(dai);
>> +	struct sdw_amd_dma_data *dma;
>> +	struct sdw_stream_config sconfig;
>> +	struct sdw_port_config *pconfig;
>> +	int ch, dir;
>> +	int ret;
>> +
>> +	dma = snd_soc_dai_get_dma_data(dai, substream);
>> +	if (!dma)
>> +		return -EIO;
>> +
>> +	ch = params_channels(params);
>> +	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE)
>> +		dir = SDW_DATA_DIR_RX;
>> +	else
>> +		dir = SDW_DATA_DIR_TX;
>> +	dev_dbg(ctrl->dev, "%s: dir:%d dai->id:0x%x\n", __func__, dir, dai->id);
>> +	dma->hw_params = params;
>> +
>> +	sconfig.direction = dir;
>> +	sconfig.ch_count = ch;
>> +	sconfig.frame_rate = params_rate(params);
>> +	sconfig.type = dma->stream_type;
>> +
>> +	sconfig.bps = snd_pcm_format_width(params_format(params));
>> +
>> +	/* Port configuration */
>> +	pconfig = kzalloc(sizeof(*pconfig), GFP_KERNEL);
>> +	if (!pconfig) {
>> +		ret =  -ENOMEM;
>> +		goto error;
>> +	}
>> +
>> +	pconfig->num = dai->id;
>> +	pconfig->ch_mask = (1 << ch) - 1;
>> +	ret = sdw_stream_add_master(&ctrl->bus, &sconfig,
>> +				    pconfig, 1, dma->stream);
>> +	if (ret)
>> +		dev_err(ctrl->dev, "add master to stream failed:%d\n", ret);
>> +
>> +	kfree(pconfig);
>> +error:
>> +	return ret;
>> +}
> This looks inspired from intel.c, but you are not programming ANY
> registers here. is this intentional?
We don't have any additional registers to be programmed like intel.
>
>> +static int amd_sdwc_hw_free(struct snd_pcm_substream *substream, struct snd_soc_dai *dai)
>> +{
>> +	struct amd_sdwc_ctrl *ctrl = snd_soc_dai_get_drvdata(dai);
>> +	struct sdw_amd_dma_data *dma;
>> +	int ret;
>> +
>> +	dma = snd_soc_dai_get_dma_data(dai, substream);
>> +	if (!dma)
>> +		return -EIO;
>> +
>> +	ret = sdw_stream_remove_master(&ctrl->bus, dma->stream);
>> +	if (ret < 0) {
>> +		dev_err(dai->dev, "remove master from stream %s failed: %d\n",
>> +			dma->stream->name, ret);
>> +		return ret;
>> +	}
>> +	dma->hw_params = NULL;
>> +	return 0;
>> +}
>> +
>> +static int amd_set_sdw_stream(struct snd_soc_dai *dai, void *stream, int direction)
>> +{
>> +	struct amd_sdwc_ctrl *ctrl = snd_soc_dai_get_drvdata(dai);
>> +	struct sdw_amd_dma_data *dma;
> you want to avoid using dma_data and use your own runtime. We made that
> change recently for cadence_runtime.c
>
will check the implementation.
>> +
>> +	if (stream) {

>> +		if (direction == SNDRV_PCM_STREAM_PLAYBACK)
>> +			dma = dai->playback_dma_data;
>> +		else
>> +			dma = dai->capture_dma_data;
>> +
>> +		if (dma) {
>> +			dev_err(dai->dev,
>> +				"dma_data already allocated for dai %s\n",
>> +				dai->name);
>> +			return -EINVAL;
>> +		}
>> +
>> +		/* allocate and set dma info */
>> +		dma = kzalloc(sizeof(*dma), GFP_KERNEL);
>> +		if (!dma)
>> +			return -ENOMEM;
>> +		dma->stream_type = SDW_STREAM_PCM;
>> +		dma->bus = &ctrl->bus;
>> +		dma->link_id = ctrl->instance;
>> +		dma->stream = stream;
>> +
>> +		if (direction == SNDRV_PCM_STREAM_PLAYBACK)
>> +			dai->playback_dma_data = dma;
>> +		else
>> +			dai->capture_dma_data = dma;
>> +	} else {
>> +		if (direction == SNDRV_PCM_STREAM_PLAYBACK) {
>> +			kfree(dai->playback_dma_data);
>> +			dai->playback_dma_data = NULL;
>> +		} else {
>> +			kfree(dai->capture_dma_data);
>> +			dai->capture_dma_data = NULL;
>> +		}
>> +	}
>> +	return 0;
>> +}
>> +
>> +static int amd_pcm_set_sdw_stream(struct snd_soc_dai *dai, void *stream, int direction)
>> +{
>> +	return amd_set_sdw_stream(dai, stream, direction);
>> +}
>> +
>> +static void *amd_get_sdw_stream(struct snd_soc_dai *dai, int direction)
>> +{
>> +	struct sdw_amd_dma_data *dma;
>> +
>> +	if (direction == SNDRV_PCM_STREAM_PLAYBACK)
>> +		dma = dai->playback_dma_data;
>> +	else
>> +		dma = dai->capture_dma_data;
>> +
>> +	if (!dma)
>> +		return ERR_PTR(-EINVAL);
>> +
>> +	return dma->stream;
>> +}
>> +
>> +static const struct snd_soc_dai_ops amd_sdwc_dai_ops = {
>> +	.hw_params = amd_sdwc_hw_params,
>> +	.hw_free = amd_sdwc_hw_free,
>> +	.set_stream = amd_pcm_set_sdw_stream,
> In the first patch there was support for PDM exposed, but here it's PDM
> only?
Didn't get your question.
First patch talks about creating dev nodes for Soundwire managers and
ACP PDM controller based on ACP pin config.

Let us know if we are missing anything?
>
>> +	.get_stream = amd_get_sdw_stream,
>> +};
>> +
>> +static const struct snd_soc_component_driver amd_sdwc_dai_component = {
>> +	.name = "soundwire",
>> +};
>> +
>> +static int amd_sdwc_register_dais(struct amd_sdwc_ctrl *ctrl)
>> +{
>> +	struct snd_soc_dai_driver *dais;
>> +	struct snd_soc_pcm_stream *stream;
>> +	struct device *dev;
>> +	int i, num_dais;
>> +
>> +	dev = ctrl->dev;
>> +	num_dais = ctrl->num_dout_ports + ctrl->num_din_ports;
>> +	dais = devm_kcalloc(dev, num_dais, sizeof(*dais), GFP_KERNEL);
>> +	if (!dais)
>> +		return -ENOMEM;
>> +	for (i = 0; i < num_dais; i++) {
>> +		dais[i].name = devm_kasprintf(dev, GFP_KERNEL, "SDW%d Pin%d", ctrl->instance, i);
>> +		if (!dais[i].name) {
>> +			dev_err(ctrl->dev, "-ENOMEM dai name allocation failed\n");
> remove, we don't add error logs on memory allocation issues.
>
>> +			return -ENOMEM;
>> +		}
>> +
>> +		if (i < ctrl->num_dout_ports)
>> +			stream = &dais[i].playback;
>> +		else
>> +			stream = &dais[i].capture;
>> +
>> +		stream->channels_min = 2;
>> +		stream->channels_max = 2;
> Is this a port limitation or just a software definition?
>
>> +		stream->rates = SNDRV_PCM_RATE_48000;
>> +		stream->formats = SNDRV_PCM_FMTBIT_S16_LE;
> Wondering if this is needed. I don't even recall why it's in the Intel
> code, we tested with 32 bit data and 192kHz, that looks unnecessary to
> me unless the hardware is really limited to those values.
>
>> +
>> +		dais[i].ops = &amd_sdwc_dai_ops;
>> +		dais[i].id = i;
>> +	}
>> +
>> +	return devm_snd_soc_register_component(ctrl->dev, &amd_sdwc_dai_component,
>> +					       dais, num_dais);
>> +}
>> +
>>  static void amd_sdwc_probe_work(struct work_struct *work)
>>  {
>>  	struct amd_sdwc_ctrl *ctrl  = container_of(work, struct amd_sdwc_ctrl, probe_work);
>> @@ -1043,6 +1223,12 @@ static int amd_sdwc_probe(struct platform_device *pdev)
>>  			ret);
>>  		return ret;
>>  	}
>> +	ret = amd_sdwc_register_dais(ctrl);
>> +	if (ret) {
>> +		dev_err(dev, "CPU DAI registration failed\n");
>> +		sdw_bus_master_delete(&ctrl->bus);
>> +		return ret;
>> +	}
>>  	INIT_WORK(&ctrl->probe_work, amd_sdwc_probe_work);
>>  	schedule_work(&ctrl->probe_work);
>>  	return 0;
>> diff --git a/include/linux/soundwire/sdw_amd.h b/include/linux/soundwire/sdw_amd.h
>> index 5ec39f8c2f2e..7a99d782969f 100644
>> --- a/include/linux/soundwire/sdw_amd.h
>> +++ b/include/linux/soundwire/sdw_amd.h
>> @@ -13,6 +13,7 @@
>>  #define ACP_SDW0	0
>>  #define ACP_SDW1	1
>>  #define ACP_SDW0_MAX_DAI	6
>> +#define AMD_SDW_MAX_DAIS	8
> How does this work? 6 dais for the first master and 2 for the second?
>
>>  
>>  struct acp_sdw_pdata {
>>  	u16 instance;
>> @@ -25,6 +26,7 @@ struct amd_sdwc_ctrl {
>>  	void __iomem *mmio;
>>  	struct work_struct probe_work;
>>  	struct mutex *sdw_lock;
>> +	struct sdw_stream_runtime *sruntime[AMD_SDW_MAX_DAIS];
> well no, a stream runtime needs to be allocated per stream and usually
> there's a 1:1 mapping between dailink and stream. A stream may use
> multiple DAIs, possibly on different masters - just like a dailink can
> rely on multiple cpu- and codec-dais.
>
> You are conflating/confusing concepts I am afraid here.
>
>>  	int num_din_ports;
>>  	int num_dout_ports;
>>  	int cols_index;
>> @@ -36,4 +38,23 @@ struct amd_sdwc_ctrl {
>>  	bool startup_done;
>>  	u32 power_mode_mask;
>>  };
>> +
>> +/**
>> + * struct sdw_amd_dma_data: AMD DMA data
>> + *
>> + * @name: SoundWire stream name
>> + * @stream: stream runtime
>> + * @bus: Bus handle
>> + * @stream_type: Stream type
>> + * @link_id: Master link id
>> + * @hw_params: hw_params to be applied in .prepare step
>> + */
>> +struct sdw_amd_dma_data {
>> +	char *name;
>> +	struct sdw_stream_runtime *stream;
>> +	struct sdw_bus *bus;
>> +	enum sdw_stream_type stream_type;
>> +	int link_id;
>> +	struct snd_pcm_hw_params *hw_params;
>> +};
>>  #endif

