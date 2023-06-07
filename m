Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90E0F7254F3
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 09:00:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238571AbjFGHAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 03:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238634AbjFGG75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 02:59:57 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2059.outbound.protection.outlook.com [40.107.92.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAE3911A
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 23:59:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=boyzI9tDYgX0GbCbPGyrqNVQIjrxG4IW/OyH9GuLHByO5kb7Wna15O+8vluhytMdXFZY5jd1/bCLytpvYHER+e9ZxB/Rsq0iZg8HSTxLtCfOYnA/tVxzaWNdi5QJmQKyCQWTztl8tdWRxMGzHN0rKCZ+4iMe6FUqVwx6qd0YzMIPlEH2H1+FFpNGx6a4EXMIXpTm7/TCQ52n8iZCXxbBi9LJj4gl0r8sfkpdYgC0UZKOHwPH4drTyNWRWhJShVINfk2ZIHbxBbct263MdgKmcvEFzgYM7Jb/22A+7K/32P89p52va+vFgjR9R6lEZ91wlfoHndcxU0w5bOFCyetsiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SR46HJ6hvBH8CS/VGE83IDCAFzpUXifklWZbppdQt40=;
 b=QHHRrTRceAkRCRgKZBdUFWFum+jejIpkTKl20dvEaR6Q8Z6BlAvT+lo02U7yhtxnkCJx1hHbAaKDA7TI8ctPMxH781bihrLWEjeMWK4pgJp9/pXr9FAA5I51iMXTpeV4/IXxQdYy0jLD0nsS8/SD8zRBL5YRFsP4J1vs4pNg95rlrVnU/hu7GuqHlKOY3eLh9qxdMq0Ru5B2drQ/C2OMd0FI/ukKJ2ANfdTXE36KhL/mrFhyjgzfgairyex/Yfvwsp0ULeTEQ+OUk2UhrdPHU/LswYkVDgr4+gDmTdh3UkMZXecWdWnKjxQJz9q25RYE+DepLgb+fexVpyG3AyC4yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SR46HJ6hvBH8CS/VGE83IDCAFzpUXifklWZbppdQt40=;
 b=WmMx7WHmU+lcuR4QR4VdDtJ1YucTZhoTrlsijapy7hRUUxRKsgfzS5ICABVW6zVgozKzewHUoNjfXtBZVTxh62wSj9DAUXeNcCVt/bxpRwRBfIoZ5XLt5FHR/k007kMnhpsT1+rq86S9aV/8FR/OY8g1agaCbxe+qgf0hc0OGXA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4123.namprd12.prod.outlook.com (2603:10b6:5:21f::23)
 by DM4PR12MB6040.namprd12.prod.outlook.com (2603:10b6:8:af::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Wed, 7 Jun
 2023 06:59:53 +0000
Received: from DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::8760:2e89:1243:2b5d]) by DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::8760:2e89:1243:2b5d%6]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 06:59:53 +0000
Message-ID: <7d4016a7-871e-91d3-8744-7dc10d809d35@amd.com>
Date:   Wed, 7 Jun 2023 12:34:34 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH V3 4/9] ASoC: amd: ps: add SoundWire dma driver dma ops
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
 <20230606060724.2038680-5-Vijendar.Mukunda@amd.com>
 <7ed3e421-ad04-746a-e252-45bc83f76256@linux.intel.com>
From:   "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
In-Reply-To: <7ed3e421-ad04-746a-e252-45bc83f76256@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0153.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:c8::18) To DM6PR12MB4123.namprd12.prod.outlook.com
 (2603:10b6:5:21f::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4123:EE_|DM4PR12MB6040:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e8ec5d9-0e19-438d-87ba-08db6724cb41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DCvHPuSRZrn4I9zuXP+VHI2yEA9m9RWG+Mp2jrVJJi7Oa/8EPM0AE639nfNJL5e321AAjCVtINMX/Vy3/sAjLf+6QEQxOndz57Mm/fDQFtnAZMrfZhxG/OmbvbgLf8C7WGgpMaS0Aiy/JomJAwV+uvn31TrcPLs/APUe8wjjg+r8sfGl4usuJpeGnXp5P6nQIqbrUrogPyL1GFRnipFIynFBf3pnfFV0tTRnleTqgwOsWbxlCexp3idO3c3E20VC2kgBnkKkFYvzGsAdYFl/JnaJxKfY/xObrqfcMS396vS4szVvIQknRVNute8e8hgUc4fftgXkc5awqk+qGCkO5s8Duo0RAouyrz8b/4TKRIRKhr/jhLNzPo3XM0xBk+c4JBYLAWd7zskxh5xn9pnrmDOUbkcKAqrw/jah3CJJZkX4lgCpr2A8pQDS8H7Rq1v5OirAxrPT5CflzcoJC04gVrg7Q8HWU7zyCZs5plkmSnoRboIrJi4dHpb+et2R9soOavvRDxEgOYB48D4B3Y3Ch3BgIIMYHI8yrPmLh8OWbnHxfF2E6sp5SKqqKMy6WdN3/74f+x3uDc/4pKzE2yUZlR1wMbxFad/ebVdkmE5j+3lN2cKr/OdZgQn69sHid/ffrfo7jFP2Eo0ilkvyIR3awQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4123.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(346002)(366004)(376002)(396003)(451199021)(83380400001)(2906002)(2616005)(31696002)(36756003)(86362001)(38100700002)(41300700001)(6486002)(316002)(6666004)(5660300002)(8936002)(8676002)(478600001)(54906003)(66946007)(66556008)(66476007)(4326008)(31686004)(6506007)(53546011)(6512007)(26005)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N3RzWjh3cG5sV0Z4MkNUVDFvQUsrcDI5Ty9BNEQwYkkxT1VXSUtRWWJ2LzdW?=
 =?utf-8?B?eW91WmR2Y1EzRStsOWxHemZoVFBXR0I4UmlxUk8zaUhSNmJKeGswa1RWMk13?=
 =?utf-8?B?bGpZMjNURGtVTWtkRjFPWlBvTy94cmdmY0tvQnE0ZGgwWE5tK1Y1TnZ1VVFk?=
 =?utf-8?B?MjZuVFJKaytsNHFSUFJVZURyM1lyMDhabXZXNkkrVnFya2xHL09uc09JdThk?=
 =?utf-8?B?bWJMdCtlZ0lLS2hsTG91d1l1dVVrbkRmRDFLalVxcnhMaldLTk91K0JoQzNp?=
 =?utf-8?B?VVZtN1FaQ2tiSkV2OVB6dXBNL1kyQUdpL0lwanNXdlFEZW9oMUJwTXBiaWZu?=
 =?utf-8?B?Y1RCMVg0RzQ2VStnZkJpbDJudWROcjB5M2w0TFl2WE9qTVZUMndhTEN1SmRU?=
 =?utf-8?B?bm1PSmdXakJ6Zlk0MTZZN05GQ21zcHdROUo5YTc1NS9naEpkbVU5WCs3NEJn?=
 =?utf-8?B?cnQ5V05Cck0zODdEaTR3d3ZydU56OUtPc3RUQVQrODY5WURtbXB4QVhRUnZR?=
 =?utf-8?B?VURtQTVFb0dCNEUwZ1JLYjFMTkIyUGlHZHBoWFhaUlpRYXA5UnFUQVVOcStO?=
 =?utf-8?B?UEU3WkF4Rk5pTXhSc2ZnUi81Ymx5S3JzVGprR3BOazJXeDRta3dQbk4zYUlk?=
 =?utf-8?B?OE40ZXNjWWl5cDFubTZIVVAxUmRLZzlCWGZrYloxWGY2dmM1dnBqbUJZVUw1?=
 =?utf-8?B?bnc2c2ZNcEY1L0o0ZG5jNUV5ZnViWEtPSE9MZkJoWEdwUVV5amxvUG9EM2hV?=
 =?utf-8?B?WjJPb1lEbU8wYTRMT3V0UThBTm1EbXVmOTdKd1A5WWdPYi9iNjhzRXdpcHVx?=
 =?utf-8?B?STl4LzR2ZFcyNmY4K0FMa3JYRXJhQ3BXcWs0VWhSWU1ReHNoMWF2alZqNlhS?=
 =?utf-8?B?SERVTlMvaDRWNmJPYUFTeXF3ZG8xc0R4UUtDYzNQT213Y1pHT2ZjZ0tNbWM0?=
 =?utf-8?B?eFhnL3JNaWpFcXc0aWxTelh3NFJBR2tDdSsxQjBPWGpzZkZZS0NDSkJsWGx6?=
 =?utf-8?B?K3ovUnZ2ZWFCTGtCYlcya3ZLbFNIUkN0YnNNLysxQ1puNkhqLzl5Y3luSHFq?=
 =?utf-8?B?c1UyWVVsSG1zT3NVanZKa0hsN08reGZMRlpWbmU4Y1haQk5vWGc0VEZTVlNr?=
 =?utf-8?B?NVlUWTY4L2FZWjNnV1U4QkhrNlB1Zkg1N291emR5UW1SQ2lUSktsYXhERjEz?=
 =?utf-8?B?d2FsQ2RZNFY2My9SYlRWc3VtelV1eU5ZNlhmdEJuVmlBd1k3Y3R6b3BlVnhz?=
 =?utf-8?B?MXpRL0pSaUNla2hLREJEZVg3Y1lpZVRvaHduVVViOHl1dzcrd0V5QThramlP?=
 =?utf-8?B?d1hkT1JWOGpUdEtrRVZhQ3JQanlEMUJrQXZZWE9DUlNKdXAxRldPcENtVk1H?=
 =?utf-8?B?Q3N4WUhVM0p3T295bjQvdmVTNVp4UlMxdktISWRQUEgwTUEwdFN3RXZwYjBy?=
 =?utf-8?B?Z1JIOFRnbzlrVGxyUU9jNm0wRkh0ZlVGZWIvZzJXZEFmV0tzR0c4UDJhK0Qz?=
 =?utf-8?B?dkY0bXV3RnBDaHpPZ3RHTW1kSERGSjFSVVcwanBDcmJkSml3UlNaVnBteHhm?=
 =?utf-8?B?a0p2Y0xLbnNpd1pHbFc0dzZIemtlUTJzTnRnaGlyTGJOVUNCNEU5VzhPdytJ?=
 =?utf-8?B?TVRsMGg5Z3dubmRJV1JYa0dkWWNqMUxDcUNsbE9vK3E4dFM1eTYwRWxwUzlx?=
 =?utf-8?B?UTl4TmlVeVBJMG93UXZhczgyUUZsRTFFcjRuWStRMlVQT0ROMURTeURXclZ5?=
 =?utf-8?B?bmtNQ3lTdUsxbFVEbGYyNVo4SmltbWRWZE55RHlPUXNHZm9HcXEyN09ROVho?=
 =?utf-8?B?d1NlYVp1UHRwcXQwRDVwNnBxL1MvdTdKQUxpZmd6NUxMOENxa0FGMlRSRjBC?=
 =?utf-8?B?Yzhpc2h4V0UzcFlHbHVna1dXVWtTRFpGTkwzOXl4elJBQ2hrb0grVytyUDZB?=
 =?utf-8?B?T1NwY3ZiL0k2elh6YndCeEhhLzIzbzlORU9DRnBDVDBWNWMwYStWaFRKQzF1?=
 =?utf-8?B?S3FvdjhReTZwY1Rld3U2YWt5SlV4VVNlbWJJZUJzZzNNeVMrRGFialIrZkto?=
 =?utf-8?B?eXNKb2RHWVVHeDNvNWxpMDJ1c2lZUFc4TG91S2Z4cFpOYXpLa2tBUWd4cHh1?=
 =?utf-8?Q?tVgtCAB+HJX/fcAgEo5dtKfta?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e8ec5d9-0e19-438d-87ba-08db6724cb41
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4123.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 06:59:53.2912
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wjS1XfpDd+AhRNdWqf8/MnnA4nUOvbNJ4qhITTay4BXu2qOZwrOjWjEPDJMDv2tfesJaoGfFJcv03F/QJgG4YA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6040
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

On 06/06/23 21:08, Pierre-Louis Bossart wrote:
>> +static int acp63_sdw_dma_start(struct snd_pcm_substream *substream, void __iomem *acp_base)
>> +{
>> +	struct acp_sdw_dma_stream *stream;
>> +	u32 stream_id;
>> +	u32 sdw_dma_en_reg;
>> +	u32 sdw_dma_en_stat_reg;
>> +	u32 sdw_dma_stat;
>> +
>> +	stream = substream->runtime->private_data;
>> +	stream_id = stream->stream_id;
>> +	switch (stream->instance) {
>> +	case ACP_SDW0:
>> +		sdw_dma_en_reg = sdw0_dma_enable_reg[stream_id];
>> +		break;
>> +	case ACP_SDW1:
>> +		sdw_dma_en_reg = sdw1_dma_enable_reg[stream_id];
>> +		break;
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +	writel(0x01, acp_base + sdw_dma_en_reg);
>> +	sdw_dma_en_stat_reg = sdw_dma_en_reg + 4;
>> +	return readl_poll_timeout(acp_base + sdw_dma_en_stat_reg, sdw_dma_stat,
>> +				  (sdw_dma_stat & BIT(0)), ACP_DELAY_US, ACP_COUNTER);
>> +}
>> +
>> +static int acp63_sdw_dma_stop(struct snd_pcm_substream *substream, void __iomem *acp_base)
>> +{
>> +	struct acp_sdw_dma_stream *stream;
>> +	u32 stream_id;
>> +	u32 sdw_dma_en_reg;
>> +	u32 sdw_dma_en_stat_reg;
>> +	u32 sdw_dma_stat;
>> +
>> +	stream = substream->runtime->private_data;
>> +	stream_id = stream->stream_id;
>> +	switch (stream->instance) {
>> +	case ACP_SDW0:
>> +		sdw_dma_en_reg = sdw0_dma_enable_reg[stream_id];
>> +		break;
>> +	case ACP_SDW1:
>> +		sdw_dma_en_reg = sdw1_dma_enable_reg[stream_id];
>> +		break;
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +
>> +	writel(0, acp_base + sdw_dma_en_reg);
>> +	sdw_dma_en_stat_reg = sdw_dma_en_reg + 4;
>> +	return readl_poll_timeout(acp_base + sdw_dma_en_stat_reg, sdw_dma_stat, !sdw_dma_stat,
>> +				  ACP_DELAY_US, ACP_COUNTER);
>> +}
> these start/stop routines look mostly the same, except for the value to
> be written in the register. Maybe they can be factored with a common
> helper, e.g. acp63_sdw_dma_enable(true/false).
Yes, it can be refactored. Will fix it.
>> +
>> +static int acp63_sdw_dma_trigger(struct snd_soc_component *comp,
>> +				 struct snd_pcm_substream *substream,
>> +				 int cmd)
>> +{
>> +	struct sdw_dma_dev_data *sdw_data;
>> +	int ret;
>> +
>> +	sdw_data = dev_get_drvdata(comp->dev);
>> +	switch (cmd) {
>> +	case SNDRV_PCM_TRIGGER_START:
>> +	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
>> +	case SNDRV_PCM_TRIGGER_RESUME:
>> +		ret = acp63_sdw_dma_start(substream, sdw_data->acp_base);
>> +		break;
>> +	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
>> +	case SNDRV_PCM_TRIGGER_SUSPEND:
>> +	case SNDRV_PCM_TRIGGER_STOP:
>> +		ret = acp63_sdw_dma_stop(substream, sdw_data->acp_base);
>> +		break;
>> +	default:
>> +		ret = -EINVAL;
>> +	}
>> +	if (ret)
>> +		dev_err(comp->dev, "trigger %d failed: %d", cmd, ret);
>> +	return ret;
>> +}

