Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46C946BC4BD
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 04:31:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbjCPDbC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 23:31:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbjCPDaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 23:30:23 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2060.outbound.protection.outlook.com [40.107.220.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F089824BF4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 20:29:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q7n3l1LBoRHWhLKJflbomOpMRyooni9auW636AbBQYVM87arT+gKLhvum1MA7UMvqIIfFHTYJ7ZWSGCsfzjGEXd3UMShIPHSjfRriDImJaxAoFCuJZmKIrQJvtRiVXSH+UNEh2qsXy9sbFzLfa7XiFXaxr/5LRt2A39889uUBCZYmfonfJas+IpwQpuq2deomlj+8OTOP9tudSgFB5aspGHBkvX/JhSM9UOZDtr3rNncW9cK9f1ayOwFGkePPfRceS+kkPLWOa3p/sUy0KhgJoFhzX+nNom5VUBWoF5XLzGNZ8fmtIu+wsccRHl+UXVm17xxxcFwtj1UhlREYE7jFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ftvKusX/n6vJoyeLh9pXEuJmhU9H/GaOr9vHNEA7TCg=;
 b=dTl6WjFkWux8CpO3hSCLJc6pQRZhdlpVlCba0ltZ99QAWWYJAPanaKOlcwX2Gv1JX6UU5uy2+ACC8P8WDM6LAXyqMXlrS3SwB+hkzfO5Oh3j5U0vHeMWyTLpMlZpri1fHyXEkZOAvZoj8+4h5xPdhg1Ht0GnPMsZmd1v08RaVZZt6BS4PoZlJ2gieMpMAtn/BOwtq7iArTy4WA9acBF6rtvmB7CT+1IMCI2PcBkDiRlwjzy9qvh/Y+o5g0GgA7IM4TMKJzBSOmhR1iTz4hyVY2mZNXIPQbgerFBRJH+aU4yQZVCGWwPzq/2QXvP6OOVYxpXzx3KPmLKNLydPDolYOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ftvKusX/n6vJoyeLh9pXEuJmhU9H/GaOr9vHNEA7TCg=;
 b=v9AluxpG1bCywddcCWoPdA8YtaRIyxy384YNQ2nMirHcYettiXmAXQXx6ent/VvjDgfYuaKrv1XMcryxLa2MqnzeDHaynP19/X4k32HWe6dQ86HXIugpZLKFONguJP0XAnAcsEBhQ3trrjSEJ8ErjqrPpzLSSPE3F6yebnvvlt4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4123.namprd12.prod.outlook.com (2603:10b6:5:21f::23)
 by CO6PR12MB5474.namprd12.prod.outlook.com (2603:10b6:303:139::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.31; Thu, 16 Mar
 2023 03:29:07 +0000
Received: from DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::e4f3:9509:c6ee:41cb]) by DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::e4f3:9509:c6ee:41cb%3]) with mapi id 15.20.6178.024; Thu, 16 Mar 2023
 03:29:07 +0000
Message-ID: <d65dd890-e9c4-1d33-b738-5f805606691a@amd.com>
Date:   Thu, 16 Mar 2023 09:02:54 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH V6 3/8] soundwire: amd: register SoundWire manager dai ops
Content-Language: en-US
To:     Vinod Koul <vkoul@kernel.org>
Cc:     alsa-devel@alsa-project.org, pierre-louis.bossart@linux.intel.com,
        Basavaraj.Hiregoudar@amd.com, Sunil-kumar.Dommati@amd.com,
        Mario.Limonciello@amd.com, amadeuszx.slawinski@linux.intel.com,
        Mastan.Katragadda@amd.com, Arungopal.kondaveeti@amd.com,
        claudiu.beznea@microchip.com,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20230307133135.545952-1-Vijendar.Mukunda@amd.com>
 <20230307133135.545952-4-Vijendar.Mukunda@amd.com> <ZBGWx4kR/eFLoz4q@matsya>
From:   "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
In-Reply-To: <ZBGWx4kR/eFLoz4q@matsya>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0046.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::22) To DM6PR12MB4123.namprd12.prod.outlook.com
 (2603:10b6:5:21f::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4123:EE_|CO6PR12MB5474:EE_
X-MS-Office365-Filtering-Correlation-Id: 7825e413-7977-4e05-62b7-08db25ce9953
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LwlPQglskbB3p4ZK5leSTN68Ir4cSD3gv9rgJP18qUvGfZbpJu3BAuvnOagGn6liY/Vr9RsHtU7ashigLmwo2XZRAMUIPeQFLtaBobED9NW15H1htlj3MtrZDXAubEMQMyYStI+wdqtogO6x2GMx5qsomNjOaetApKjW+gDUBnPvbn6YCEgcOX3OCGk+z3pa7ePa0FRW8gqbS6aqGuYG5UP11lrg4RlOSVPDee6bc5q0b6IX4rECC+l19WmlV6sO2lVUPLl/z07YpRCQmaNngLHzTiRheku+6yOyWxFDVKcdu6KZPnqSJ+ERoT6RmIhcEBTBZjtnV1n8/GrrUTFsU5st+gFFqk4HSH/eu3TjyYJrGuLAfNgkd4lsxljB89aJ3HreMFJTsUSLs29iakLDgKblOjh5xJOiItMt32+/3FfeG7g8aLGNtU5oKVfB5fxSvHGVcE2of02gpF7oU6OiHXRBamR8EKSBYZWskIqGFVoQNb5VpPtx1GqajkpjmAiUKg5KPGrmuWA/ZEnFHD2mxYuJNOZ9+NArGPdUga6vRMZcLUtU+Wt9Fqh7NpFeeR2mGfFrqq+GcF6zQqIs/+yNRGENFRbPfTgT5lBFb7lBKK71x0enBNlK+WyxRR+vI1tB8ndTAhliD17QzzYoGga5zFhLiG/5V8F6GOeti+pM9zv+k8JIS8WP274SdXIRZoJobcrx0j10THQnKToInoXmA4Lb6+AKyfHFuaRv0JVZWO8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4123.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(346002)(136003)(39860400002)(396003)(366004)(451199018)(8936002)(5660300002)(41300700001)(4326008)(6916009)(31696002)(36756003)(86362001)(38100700002)(2906002)(8676002)(6486002)(966005)(6666004)(83380400001)(478600001)(186003)(2616005)(6512007)(6506007)(26005)(53546011)(31686004)(66946007)(66556008)(54906003)(66476007)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Tzl1SU5SS1lhSDRBSjBFcnpCZmdPUzgxWWhsZXdZZHFTZjdNV3dsaWdxZnVk?=
 =?utf-8?B?TGZXZDNxTHR1TDJYejVkbFMxamIyMGVhaSsyOThFNVd6dVVWalNNenVNMG1K?=
 =?utf-8?B?NFRUNWJaWnltRE8xc1ExMElmbThpVGhsakNJbUQ2YlRoaHhOZjhZK041S3FQ?=
 =?utf-8?B?Z29qemlzTk5aOTRmeHRFeU0zYncycldUK1J1T3VidzBhZmxpVmdoTDg1SlpJ?=
 =?utf-8?B?NDdMRlNqcUNWNVJRV1BVNm5SS2o1TDNwMWNvUWNNVzZDMURkNHB6V2gwelhx?=
 =?utf-8?B?bm5GMmcxdytyVEJFanRvQVAxdXhFeGxGTlRzdGs0d1RPS0FrcmtlVTBDcG1j?=
 =?utf-8?B?MzZNenJmY0Z4RlRnUDZhdm16VG9ST3lFbHRNWVVnYnBrVGxCQWtlSTA5KzJU?=
 =?utf-8?B?NFF4SVc0L2xtVW8rVGtXMjR4RGF2cHhLQTZuMmlEeHp2TFM3aHBRWUVYRlFD?=
 =?utf-8?B?cDFSTVcvSVpBQWdXUjhWS1l1ckh5c0RXR3hqVkZtOGhFUkxySXlCZXRXc2lh?=
 =?utf-8?B?Sm5oRlB0K1c1V1hFekVPdk5yOTZycEQ5SmY3ZDNGaWpjZUVOeVN6cEhoV0Yw?=
 =?utf-8?B?clFZblJldHF4OHd4WDNtNVVrMjZhcTRqSW9Kci9HKy9ucGJmQVNkblQ4eEI3?=
 =?utf-8?B?VUVqUlpZVnNXKzVUMDJ6Z3VNYjBTYjBIbGxLUGJWQTBFcm5jd0wzWHk4Mjk1?=
 =?utf-8?B?c1pIYk1JQkg4UnlWclg2ZWhZTXJvcWwxZEFZckRJTFB6QTdrSzRBNGgxM0lN?=
 =?utf-8?B?bGI5eEFhVDhjc0Rad3BISkMycVdmR0RQakg3Y0RTOGZnWUtkOWtEUjZoRzlZ?=
 =?utf-8?B?dlFlWHBOUjVrMDJQNm0yTlNwUXJmK2F6VC95eC9vSGJjQ1FYWndjc0hwRnhS?=
 =?utf-8?B?OWlyeFhyYXV2a29LVnVFa1R2VHFlaEhCNjIrYWZRa0ljQVpSVWs1M2Z6QWVY?=
 =?utf-8?B?TWpDQXBCWC9IY2k5NUI5L1U3NTN4RnFDZVVPZldQdnJheTh1TGVsVjMxSTB2?=
 =?utf-8?B?b3Q5bnZobXhwT0VIdUJ2MnJ4WVl1L3F5S3EwQlFQQStLajM5b05LM2pYbGEv?=
 =?utf-8?B?eVdQVE1xTE93ZlJZTzdzNXIyeHVzaDIwbFBQbGlJR0dvR2xRUGh0UWZrN1NB?=
 =?utf-8?B?MFA5K01IWHlMK3BoR3pBTXFzUTMxdkJMVStPM2xNckt4OEQ1eXpKUEdYVGI3?=
 =?utf-8?B?QVpDbEtnWmMrcUpnanhTb1MySkVsb01aRFAvWVhnNEFoVTR3dHBhQitrTmdq?=
 =?utf-8?B?ejZ4SHVzTkhjVG5zd1dIWWROSmtHUmVDVzRhWE12L1ZuT2VacFF0Y0dCWTB1?=
 =?utf-8?B?aVAxTXhQSEJQdzJOZkViMUhtTDhxYVJjc2V4M1o5YW8yVVpqci9ldmdwVkZX?=
 =?utf-8?B?aUp6VlJjd2haaklFS0hQZzlnNzBDT2g2N1VRNnpIZmh6NHIyVEUwWVpkc2Q0?=
 =?utf-8?B?VTg2MkpyVGtpR0l4T29ERytVWXo3OXNkRUdWZVNNVVdhRFpQd2hmUVJKaEdN?=
 =?utf-8?B?WlVjY3RWTzY4TWRvZmt6Nm92YTBWV242eG5PU1RTN1FMRWxSbSt2M3RhSmdK?=
 =?utf-8?B?UVpZMXNkc1pHVHc2dG9MZ293SkdxZ1g5R1hMMlZoZXM4YnB1ZDE1OU9wTGRX?=
 =?utf-8?B?VXd0UXhXbGF2R1BFS0k4SzE0ZjNBclU0VE9yU3JGMHo2TUNNSDNjaytlVHdE?=
 =?utf-8?B?NHdnbnlVZW9pajBHdDBXdDhMUk40SHdzSGdjVkhJbWxoaDhJMkJjZnhOOE80?=
 =?utf-8?B?U0haK011UTFMeE9QK203YUh2aE5pNm1vMkNLQjFvc29abENZR1IzNE5TalQ2?=
 =?utf-8?B?aHJhY3hjZSt2SHpLQ3huY0tzOGM0Ym1Xek5SSEk0ZzI5TnM0UE1PbkZqeVJj?=
 =?utf-8?B?cHhORzRadkE4MlVlNFJrU2lXSm45L094RDdSWjdqc0JuTGVFUWJMejRLRjFN?=
 =?utf-8?B?YTNBMHh2K1M1NkFjejVYWVFxUk1YUEdPc3FvOU9UVmt0YzRVOWlZYlBZMTVO?=
 =?utf-8?B?NlFQdnNLMmhhTSs5NUM3ekI5QVF6VTZxZGcvN09EblhwTkxCVTBLV1ZNUDhm?=
 =?utf-8?B?elNJM0ZIWjBPckFQODNnTXF3bFEySTdZS2ZNWXV4eGVpb3RsNHRMeGFJVUgx?=
 =?utf-8?Q?Vfonf5nqeLCK5sDCSDgeMdFkG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7825e413-7977-4e05-62b7-08db25ce9953
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4123.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2023 03:29:07.3145
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fatzE/A9YrqWwtIr6yukWbg+ne6x6FOAxzU+nWZ4YyEa6QXxzPZUjRasF5oYR58PaBUtrluAE6r1f723tI3D+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5474
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/03/23 15:28, Vinod Koul wrote:
> On 07-03-23, 19:01, Vijendar Mukunda wrote:
>> Register dai ops for SoundWire manager instances.
>>
>> Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
>> Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>> Link: https://lore.kernel.org/lkml/20230227154801.50319-4-Vijendar.Mukunda@amd.com
>> ---
>>  drivers/soundwire/amd_manager.c   | 182 ++++++++++++++++++++++++++++++
>>  drivers/soundwire/amd_manager.h   |  18 +++
>>  include/linux/soundwire/sdw_amd.h |  18 +++
>>  3 files changed, 218 insertions(+)
>>
>> diff --git a/drivers/soundwire/amd_manager.c b/drivers/soundwire/amd_manager.c
>> index a5cf6acd936c..dd7fd4036d89 100644
>> --- a/drivers/soundwire/amd_manager.c
>> +++ b/drivers/soundwire/amd_manager.c
>> @@ -581,6 +581,182 @@ static const struct sdw_master_ops amd_sdw_ops = {
>>  	.read_ping_status = amd_sdw_read_ping_status,
>>  };
>>  
>> +static int amd_sdw_hw_params(struct snd_pcm_substream *substream,
>> +			     struct snd_pcm_hw_params *params,
>> +			     struct snd_soc_dai *dai)
>> +{
>> +	struct amd_sdw_manager *amd_manager = snd_soc_dai_get_drvdata(dai);
>> +	struct sdw_amd_dai_runtime *dai_runtime;
>> +	struct sdw_stream_config sconfig;
>> +	struct sdw_port_config *pconfig;
>> +	int ch, dir;
>> +	int ret;
>> +
>> +	dai_runtime = amd_manager->dai_runtime_array[dai->id];
>> +	if (!dai_runtime)
>> +		return -EIO;
>> +
>> +	ch = params_channels(params);
>> +	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE)
>> +		dir = SDW_DATA_DIR_RX;
>> +	else
>> +		dir = SDW_DATA_DIR_TX;
>> +	dev_dbg(amd_manager->dev, "dir:%d dai->id:0x%x\n", dir, dai->id);
>> +
>> +	sconfig.direction = dir;
>> +	sconfig.ch_count = ch;
>> +	sconfig.frame_rate = params_rate(params);
>> +	sconfig.type = dai_runtime->stream_type;
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
>> +	ret = sdw_stream_add_master(&amd_manager->bus, &sconfig,
>> +				    pconfig, 1, dai_runtime->stream);
>> +	if (ret)
>> +		dev_err(amd_manager->dev, "add manager to stream failed:%d\n", ret);
>> +
>> +	kfree(pconfig);
>> +error:
>> +	return ret;
>> +}
>> +
>> +static int amd_sdw_hw_free(struct snd_pcm_substream *substream, struct snd_soc_dai *dai)
>> +{
>> +	struct amd_sdw_manager *amd_manager = snd_soc_dai_get_drvdata(dai);
>> +	struct sdw_amd_dai_runtime *dai_runtime;
>> +	int ret;
>> +
>> +	dai_runtime = amd_manager->dai_runtime_array[dai->id];
>> +	if (!dai_runtime)
>> +		return -EIO;
>> +
>> +	ret = sdw_stream_remove_master(&amd_manager->bus, dai_runtime->stream);
>> +	if (ret < 0)
>> +		dev_err(dai->dev, "remove manager from stream %s failed: %d\n",
>> +			dai_runtime->stream->name, ret);
>> +	return ret;
>> +}
>> +
>> +static int amd_set_sdw_stream(struct snd_soc_dai *dai, void *stream, int direction)
>> +{
>> +	struct amd_sdw_manager *amd_manager = snd_soc_dai_get_drvdata(dai);
>> +	struct sdw_amd_dai_runtime *dai_runtime;
>> +
>> +	dai_runtime = amd_manager->dai_runtime_array[dai->id];
>> +	if (stream) {
>> +		/* first paranoia check */
>> +		if (dai_runtime) {
>> +			dev_err(dai->dev,
>> +				"dai_runtime already allocated for dai %s\n",
>> +				dai->name);
> single line would look better
will fix it.
>
>> +			return -EINVAL;
>> +		}
>> +
>> +		/* allocate and set dai_runtime info */
>> +		dai_runtime = kzalloc(sizeof(*dai_runtime), GFP_KERNEL);
>> +		if (!dai_runtime)
>> +			return -ENOMEM;
>> +
>> +		dai_runtime->stream_type = SDW_STREAM_PCM;
>> +		dai_runtime->bus = &amd_manager->bus;
>> +		dai_runtime->stream = stream;
>> +		amd_manager->dai_runtime_array[dai->id] = dai_runtime;
>> +	} else {
>> +		/* second paranoia check */
>> +		if (!dai_runtime) {
>> +			dev_err(dai->dev,
>> +				"dai_runtime not allocated for dai %s\n",
>> +				dai->name);
>> +			return -EINVAL;
>> +		}
>> +
>> +		/* for NULL stream we release allocated dai_runtime */
>> +		kfree(dai_runtime);
>> +		amd_manager->dai_runtime_array[dai->id] = NULL;
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
>> +	struct amd_sdw_manager *amd_manager = snd_soc_dai_get_drvdata(dai);
>> +	struct sdw_amd_dai_runtime *dai_runtime;
>> +
>> +	dai_runtime = amd_manager->dai_runtime_array[dai->id];
>> +	if (!dai_runtime)
>> +		return ERR_PTR(-EINVAL);
>> +
>> +	return dai_runtime->stream;
>> +}
>> +
>> +static const struct snd_soc_dai_ops amd_sdw_dai_ops = {
>> +	.hw_params = amd_sdw_hw_params,
>> +	.hw_free = amd_sdw_hw_free,
>> +	.set_stream = amd_pcm_set_sdw_stream,
>> +	.get_stream = amd_get_sdw_stream,
>> +};
>> +
>> +static const struct snd_soc_component_driver amd_sdw_dai_component = {
>> +	.name = "soundwire",
>> +};
>> +
>> +static int amd_sdw_register_dais(struct amd_sdw_manager *amd_manager)
>> +{
>> +	struct sdw_amd_dai_runtime **dai_runtime_array;
>> +	struct snd_soc_dai_driver *dais;
>> +	struct snd_soc_pcm_stream *stream;
>> +	struct device *dev;
>> +	int i, num_dais;
>> +
>> +	dev = amd_manager->dev;
>> +	num_dais = amd_manager->num_dout_ports + amd_manager->num_din_ports;
>> +	dais = devm_kcalloc(dev, num_dais, sizeof(*dais), GFP_KERNEL);
>> +	if (!dais)
>> +		return -ENOMEM;
>> +
>> +	dai_runtime_array = devm_kcalloc(dev, num_dais,
>> +					 sizeof(struct sdw_amd_dai_runtime *),
>> +					 GFP_KERNEL);
>> +	if (!dai_runtime_array)
>> +		return -ENOMEM;
>> +	amd_manager->dai_runtime_array = dai_runtime_array;
>> +	for (i = 0; i < num_dais; i++) {
>> +		dais[i].name = devm_kasprintf(dev, GFP_KERNEL, "SDW%d Pin%d", amd_manager->instance,
>> +					      i);
>> +		if (!dais[i].name)
>> +			return -ENOMEM;
>> +		if (i < amd_manager->num_dout_ports)
>> +			stream = &dais[i].playback;
>> +		else
>> +			stream = &dais[i].capture;
>> +
>> +		stream->channels_min = 2;
>> +		stream->channels_max = 2;
>> +		stream->rates = SNDRV_PCM_RATE_48000;
>> +		stream->formats = SNDRV_PCM_FMTBIT_S16_LE;
>> +
>> +		dais[i].ops = &amd_sdw_dai_ops;
>> +		dais[i].id = i;
>> +	}
>> +
>> +	return devm_snd_soc_register_component(dev, &amd_sdw_dai_component,
>> +					       dais, num_dais);
>> +}
>> +
>>  static void amd_sdw_probe_work(struct work_struct *work)
>>  {
>>  	struct amd_sdw_manager *amd_manager = container_of(work, struct amd_sdw_manager,
>> @@ -664,6 +840,12 @@ static int amd_sdw_manager_probe(struct platform_device *pdev)
>>  		dev_err(dev, "Failed to register SoundWire manager(%d)\n", ret);
>>  		return ret;
>>  	}
>> +	ret = amd_sdw_register_dais(amd_manager);
>> +	if (ret) {
>> +		dev_err(dev, "CPU DAI registration failed\n");
>> +		sdw_bus_master_delete(&amd_manager->bus);
>> +		return ret;
>> +	}
>>  	dev_set_drvdata(dev, amd_manager);
>>  	INIT_WORK(&amd_manager->probe_work, amd_sdw_probe_work);
>>  	/*
>> diff --git a/drivers/soundwire/amd_manager.h b/drivers/soundwire/amd_manager.h
>> index 0d4b8653877e..cad26034087b 100644
>> --- a/drivers/soundwire/amd_manager.h
>> +++ b/drivers/soundwire/amd_manager.h
>> @@ -204,6 +204,24 @@ struct sdw_manager_dp_reg {
>>  	u32 lane_ctrl_ch_en_reg;
>>  };
>>  
>> +/*
>> + * SDW0 Manager instance registers  6 CPU DAI (3 TX & 3 RX Ports)
>> + * whereas SDW1  Manager Instance registers 2 CPU DAI (one TX & one RX port)
>> + * Below is the CPU DAI <->Manager port number mapping
>> + * i.e SDW0 Pin0 -> port number 0 -> AUDIO0 TX
>> + *     SDW0 Pin1 -> Port number 1 -> AUDIO1 TX
>> + *     SDW0 Pin2 -> Port number 2 -> AUDIO2 TX
>> + *     SDW0 Pin3 -> port number 3 -> AUDIO0 RX
>> + *     SDW0 Pin4 -> Port number 4 -> AUDIO1 RX
>> + *     SDW0 Pin5 -> Port number 5 -> AUDIO2 RX
>> + *  Whereas for SDW1 instance
>> + *  SDW1 Pin0 -> port number 0 -> AUDIO1 TX
>> + *  SDW1 Pin1 -> Port number 1 -> AUDIO1 RX
>> + *  Same mapping should be used for programming DMA controller registers in SoundWire DMA driver.
>> + * i.e if AUDIO0 TX channel is selected then we need to use AUDIO0 TX registers for DMA programming
>> + * in SoundWire DMA driver.
>> + */
>> +
>>  static struct sdw_manager_dp_reg sdw0_manager_dp_reg[AMD_SDW0_MAX_DAI] =  {
>>  	{ACP_SW_AUDIO0_TX_FRAME_FORMAT, ACP_SW_AUDIO0_TX_SAMPLEINTERVAL, ACP_SW_AUDIO0_TX_HCTRL_DP0,
>>  	 ACP_SW_AUDIO0_TX_OFFSET_DP0, ACP_SW_AUDIO0_TX_CHANNEL_ENABLE_DP0},
>> diff --git a/include/linux/soundwire/sdw_amd.h b/include/linux/soundwire/sdw_amd.h
>> index c14a291a40e8..ac537419301d 100644
>> --- a/include/linux/soundwire/sdw_amd.h
>> +++ b/include/linux/soundwire/sdw_amd.h
>> @@ -23,6 +23,21 @@ struct sdw_manager_reg_mask {
>>  	u32 acp_sdw_intr_mask;
>>  };
>>  
>> +/**
>> + * struct sdw_amd_dai_runtime: AMD sdw dai runtime  data
>> + *
>> + * @name: SoundWire stream name
>> + * @stream: stream runtime
>> + * @bus: Bus handle
>> + * @stream_type: Stream type
>> + */
>> +struct sdw_amd_dai_runtime {
>> +	char *name;
>> +	struct sdw_stream_runtime *stream;
>> +	struct sdw_bus *bus;
>> +	enum sdw_stream_type stream_type;
>> +};
>> +
>>  /**
>>   * struct amd_sdw_manager - amd manager driver context
>>   * @bus: bus handle
>> @@ -40,6 +55,7 @@ struct sdw_manager_reg_mask {
>>   * @quirks: SoundWire manager quirks
>>   * @wake_en_mask: wake enable mask per SoundWire manager
>>   * @power_mode_mask: flag interprets amd SoundWire manager power mode
>> + * @dai_runtime_array: dai runtime array
>>   */
>>  struct amd_sdw_manager {
>>  	struct sdw_bus bus;
>> @@ -63,5 +79,7 @@ struct amd_sdw_manager {
>>  	u32 quirks;
>>  	u32 wake_en_mask;
>>  	u32 power_mode_mask;
>> +
>> +	struct sdw_amd_dai_runtime **dai_runtime_array;
>>  };
>>  #endif
>> -- 
>> 2.34.1

