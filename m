Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D44CF6958A3
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 06:47:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbjBNFrC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 00:47:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjBNFq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 00:46:59 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2075.outbound.protection.outlook.com [40.107.102.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDF971631D
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 21:46:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CwYy6UF/uZygY/xaqT3tSDsPvIZBY2tYoHVPuBZibqgjnE72OsYwmONro01NN0rHqUP3wxYuYfd8qyv3SvbfadfJoxO23FKcUhgwKyVBtSfMCLOHx0oNlR8WLGCg3bAb+PtBAyYPE2zopgIvYItExijs+sF+2yOvHR4nWmFWYa4Wr+I/WKZOF5+2I9N8d6Sekn9ACc7dG29hoJiEDbw9c7IJn+BP+YN4i2eW7xC20NhTj6a0WWOzdTi3PRnt+QexS8kraj4O9Oyyh7HGIHLi1THGTvvGTy4qNayPdngtGDvkdKaetSIoLT8/w1Zb/Tc29m1sPpK46+eA+qAY/XwRjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wYXJ6kwFZrkuXdxmpRX0RwfLgRgImMB4ZeUUeiPOXeE=;
 b=bhom3zpDQ71XZ3Dzc99O7rJ/2pqLoryfajWbCdS8V1hojBg+dIf4+eMv5tRg40CH3pb9zLjM3cDvkdL/K6NrkfVXbG368IFK2L1ePJr9DG21yOwBpOByhTfWUfewdCdNu7n65B+aNY/P2Pf4uWbZ7RzQLNlhxBMX8lbivjdoUTOeQM8mhkSC+1pYFOcLG6l8N26r/YWhU+AMFTFRKHxScgSZNpwj0Jvuz6BlQYrlrqgQNyq4EbFQAL9qkiFrPq2zRHEP2hty5hzwkVzO6nNLIpt6s/pVZLS6hzPxOmEWGYrzWSwTcIbnaaDdaS8pmMgtHc9Ca1rq4SDHS/DnSIaO6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wYXJ6kwFZrkuXdxmpRX0RwfLgRgImMB4ZeUUeiPOXeE=;
 b=fRnhAhd6wyjF2E/wp0t9OAdRQaViuYHXkS0t9w02j8S00kEg6+b0OM5fzjMp11YWwUr/iGckQlRd73lTdQjeiag8oduVUQIk4iNDswMiKd7xrd9bBLgue74G1CwiqIZ3ASpJ9OIqqeBlPr41apUbACx0In4CuAJIJBwyzy9EcQ0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4123.namprd12.prod.outlook.com (2603:10b6:5:21f::23)
 by DM4PR12MB6376.namprd12.prod.outlook.com (2603:10b6:8:a0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Tue, 14 Feb
 2023 05:46:49 +0000
Received: from DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::fc88:7080:445e:6866]) by DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::fc88:7080:445e:6866%8]) with mapi id 15.20.6086.024; Tue, 14 Feb 2023
 05:46:49 +0000
Message-ID: <457c2210-547c-422d-7a6d-bbc902bf5fe9@amd.com>
Date:   Tue, 14 Feb 2023 11:19:42 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH V2 3/8] soundwire: amd: register soundwire manager dai ops
Content-Language: en-US
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        vkoul@kernel.org
Cc:     amadeuszx.slawinski@linux.intel.com, Mario.Limonciello@amd.com,
        Sunil-kumar.Dommati@amd.com, Basavaraj.Hiregoudar@amd.com,
        Mastan.Katragadda@amd.com, Arungopal.kondaveeti@amd.com,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        "moderated list:SOUNDWIRE SUBSYSTEM" <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20230213094031.2231058-1-Vijendar.Mukunda@amd.com>
 <20230213094031.2231058-4-Vijendar.Mukunda@amd.com>
 <0522e771-2e88-462b-ebb1-50126cac0026@linux.intel.com>
From:   "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
In-Reply-To: <0522e771-2e88-462b-ebb1-50126cac0026@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0088.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9a::23) To DM6PR12MB4123.namprd12.prod.outlook.com
 (2603:10b6:5:21f::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4123:EE_|DM4PR12MB6376:EE_
X-MS-Office365-Filtering-Correlation-Id: 9dbd7248-e0f0-4f14-d3d2-08db0e4eddb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e8EUqqFlrc0uoxVNfZoWtmERaHl3RGjjDFD83FsjcqLYCT3nWqfruESndgtl+8+xEsVibJkGvMhYwQu6Uc3hL3NInarp/nb+oBLFAEULabQScAtLtcOGKbh4EaR4d6jXVDlsbHaJe04UjkloAdxgoRRXyzxKUvm/RgZ9yebBveRQjzuHqyQY7HHOCdkAOEm+UjGZW4ZJzpag7lWDt2pr8ZU7hahABZ1ETsqRZ1ibaLJrko/PiEJoz6lcTns03HGQLzDgrxsakwKZrfMUu7Ot3NHOPPLrfmwdLS82w1aOf/c+25dMt6INGvVmjGWYJTBl1ViLX5L1QL5G2ibchLAoiZOuw5jKXe30VvtvTLZpOhKuZD5VTO7kwW0owwPaTQ1ajBPar8TRL6oeY5XHbYCFt2o9IXbdP14WJ8QY2FvKSFrFWzckb5CSQKZx7CIrZTLfmZA7wFSlnZny5MlGbiZxmARn6K+oYCTpShm+6cMVEmWGYaaBS/yOW1BOHvTlgQoLEd5qwhSAWlV4YB5leDpQs1Uh7h6Fej2wjglWQowUHnY1S6zkziVathWgonB1uzxJrL3vUlIrbFTL0nFKDiDdEOcd/12Mg37VqmUL5KK1K1Q0z5V6oy2jRS1qIcWY1vSje1QpCGd14YhUHJ8Adv31MwR3wvfFIUo2rr0YFNESZdAAc0YGkLVY5F8aFGH8PXhQEyVU65pOYlWoCZl1VpLfkudOY+1pIq8PcA8CP9Jh30o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4123.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(396003)(136003)(346002)(39860400002)(376002)(451199018)(83380400001)(38100700002)(41300700001)(2906002)(86362001)(36756003)(31696002)(30864003)(5660300002)(4326008)(8936002)(6512007)(26005)(186003)(6666004)(6506007)(53546011)(316002)(54906003)(66476007)(66946007)(66556008)(2616005)(478600001)(6486002)(8676002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VTB2QTJUbGwrdjlyR1NsZkY4ZUhpdEJuNlJka3oyaElHdHMxSG00QzlQN0NN?=
 =?utf-8?B?MlZhTTVqVjQ0K2tYRjE0ZVdaSjZKNmFlcjZ0QkpBMDE4UnhRYXc0VzRYMzMv?=
 =?utf-8?B?QmhFOE05WXprK2tWcS9nRzBSOG5hY1kydWRmckRYV3g3YTNJTGJ5K3BLZC91?=
 =?utf-8?B?aDVNTmtxc2U0Y0V0elZjcmFMSGpQZnJiVUtoMkVoUmxTTkh4cExPM29lcERp?=
 =?utf-8?B?TGViZlNRUTJUYnBIY0JKa0pTRGZqb0R5dlBLVXdwNmEvWHhrbFVveE1aZDlh?=
 =?utf-8?B?YTJNUU5ibGtJRkM0NDFYUCtyRmhUaERmcXI5WWFCYkhCN1Q3d2U5SXM5RlpC?=
 =?utf-8?B?OVFvY0pkN1VRc1NtSUdwVjFnRDB4YXFSMjl0K0ZpZzV1RTlzMkFkTExPcmlj?=
 =?utf-8?B?WHcwYzhSbVgwZ1A0Ujh5YVpHd1NVRkhLQzlJcEI0S1RQRHhsRXlLOGc2T2sw?=
 =?utf-8?B?bEUxM1pyVmFnYk5yMHBjSEFraXY2QVhiMzFVai9qdkw5UmtPam9ha0pKNWtx?=
 =?utf-8?B?WEp0d1BQZlRRd2VZaENpY296Z3VNVnkySDc3blgwM3hSbUFVLzB3dTZWQWxz?=
 =?utf-8?B?RXkyd0Jic0ZnYjFmTmJVSGFUVVl1L2Q2UzQvVXhYZW91czgydVNObHFGMzhC?=
 =?utf-8?B?ZzVGbnpScW00aDhtRVVFVjJnY1RXWEZnY2hvNTR0UHpWcWVvY1RMUVJrYWNO?=
 =?utf-8?B?L0d4dDNsR0tiMW1scjlIMVBLajI1cHI5VWdhaGpZanh1RWhoK1dOUkdjME1h?=
 =?utf-8?B?YjlGbnRXbnQ5R1d4d1kzMmJYN1dDOWpLRUtjMVpiTzN2R0lWUFJlSDh3Sjh5?=
 =?utf-8?B?N0dCK3lZNHNyM3JmdE1zTitpTVhzZVNkZmh5azFkK0tNZTFYUENrZllsaHFh?=
 =?utf-8?B?S295bFRpZFVTNEZENXZmcnpCcE9Td25zVHl1QmhRbTB5bVVqM0QzRTMrVTJy?=
 =?utf-8?B?Z3lwU1N4M2ZSN1VQbzB5RGlNNlBYbU84a0hYU0puWGtRVzRGeWptN1EwMVdB?=
 =?utf-8?B?dEJ3QU1sRlZTZzZFM0hGZkQ2Sk4yT1FvTEljK2dLUDY5aHRpdnBzS3hsNFM3?=
 =?utf-8?B?Y1F1d0ZwZHh6bGhUYlNUTG9jS2kycW9MZnlMLys5Um1iQjhVU0ZKeVUxaUpJ?=
 =?utf-8?B?MGp6Uk9zUUhUaFUrSkZIZEVwZER0cU1jWFlTalVDZng4WC9Fcnc0OUJpRmpl?=
 =?utf-8?B?UUF6YzVsN3RWeEFUcVZJMGRLWEtWSTBCQVJwS3pjUzVpOGc3dTBDa2xCV2Nm?=
 =?utf-8?B?QW9XdkRWRkRLK3krMzkzVElGeXlaaC9OZVNFODhaYkJvelBXa0JTbjVBb0Fp?=
 =?utf-8?B?YXFCU2FqcXFxYjlJN0t2TDFFYjJxTFhqeTdVQzFYUEQwYVRlTVZ5bHlyTG1k?=
 =?utf-8?B?WGRFMitiLzlZMTZpMmQrOHZJNXZmZEZzOXIrLzM2NTR2UHJzOERJZWNOdGp5?=
 =?utf-8?B?OWdab0QwdXpIVldLVjZiQklDc3NTZnYyY1Y2aWhXV29hbThWRForSVZ1Wi83?=
 =?utf-8?B?RE5MVFVOM2gyWjdVZUJUZXF2RHJSb2JqRENZeFlua2xFRVlQZ0MvRHNRaXVa?=
 =?utf-8?B?Uk92NDFhaFpMY3pHY1p5QXdIN1VzSkdkenBsU3NHMWdXbjFHMzB5WTQzSTZ5?=
 =?utf-8?B?dlNZd1FzNkFwZVJYbjdxb0o3MUdHeXVIcGVmREZCTzRvWHFPdDcweWozUW5B?=
 =?utf-8?B?SGhzcUc2eGdtVG9Xd2xpbHRYVDhuemJnMWVQVmFPSUFscnYvcjV3MkZHMG50?=
 =?utf-8?B?NWtrcEFkZnpWd2w3VHFuRWg0Q2lyMlBkMi9tOFB5UEF1SE5WVWM0aWx2K0VJ?=
 =?utf-8?B?OU5uU2VQclpPSVp2RE5kcXpTWXVvdDZ2SEJSaTFBaFZ0L0R5TFF4T1o0eDh3?=
 =?utf-8?B?ZnRJMFN5OFNOaTBDRkVVckphNWY3QnlubTY1RUkxR0JUZXQ4R2FHc2ZGZk13?=
 =?utf-8?B?ZWNyc3hEU2hudU9aT1RZcWFUN1plL0d0NE5PbVU3OXVaRk8xY0hGTVN6NWNX?=
 =?utf-8?B?bjBwYlZMZzg3eld0aXducFZjUkFOWUtvSlRNYmZOR3N3NVdpUnQzOHh4dUYw?=
 =?utf-8?B?QnFBZTZZbnlWWVd0QlFiWk9oVXBBdDQrbitYN09HcDZncURybk9WMko0NVl1?=
 =?utf-8?Q?XqFZOm5oCmBEv3e448JMJUGuE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dbd7248-e0f0-4f14-d3d2-08db0e4eddb3
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4123.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2023 05:46:49.4095
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OpeAwrJOMfPMC9rkVBkuBPU8yonDfcKOyBcARr/9V6W/f+/vCn1Yp5o//qYNR4i8bCSiZXTjr9woyQDCjijRng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6376
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/02/23 23:39, Pierre-Louis Bossart wrote:
>
> On 2/13/23 03:40, Vijendar Mukunda wrote:
>> Register dai ops for soundwire manager instances.
>>
>> Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
>> ---
>>  drivers/soundwire/amd_manager.c   | 182 ++++++++++++++++++++++++++++++
>>  drivers/soundwire/amd_manager.h   |  18 +++
>>  include/linux/soundwire/sdw_amd.h |  18 +++
>>  3 files changed, 218 insertions(+)
>>
>> diff --git a/drivers/soundwire/amd_manager.c b/drivers/soundwire/amd_manager.c
>> index cd1e5a3d5995..14c88b80ab6d 100644
>> --- a/drivers/soundwire/amd_manager.c
>> +++ b/drivers/soundwire/amd_manager.c
>> @@ -641,6 +641,182 @@ static const struct sdw_master_ops amd_sdw_ops = {
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
>> +	dev_dbg(amd_manager->dev, "%s: dir:%d dai->id:0x%x\n", __func__, dir, dai->id);
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
> do you have a restriction on formats here? IIRC we've removed this from
> the Intel code.
Currently, we have implemented stack for legacy driver(where DSP is disabled).
If we didn't include formats, rates, It's going to break in soc_hw_sainty_check() function
throwing config_err.





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
>> @@ -726,6 +902,12 @@ static int amd_sdw_manager_probe(struct platform_device *pdev)
>>  		dev_err(dev, "Failed to register Soundwire manager(%d)\n", ret);
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
>>  	schedule_work(&amd_manager->probe_work);
>> diff --git a/drivers/soundwire/amd_manager.h b/drivers/soundwire/amd_manager.h
>> index 811ed9ee3d86..3e1bded1e769 100644
>> --- a/drivers/soundwire/amd_manager.h
>> +++ b/drivers/soundwire/amd_manager.h
>> @@ -205,6 +205,24 @@ struct sdw_manager_dp_reg {
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
>> + *  Same mapping should be used for programming DMA controller registers in Soundwire DMA driver.
>> + * i.e if AUDIO0 TX channel is selected then we need to use AUDIO0 TX registers for DMA programming
>> + * in Soundwire DMA driver.
>> + */
>> +
>>  static struct sdw_manager_dp_reg sdw0_manager_dp_reg[AMD_SDW0_MAX_DAI] =  {
>>  	{ACP_SW_AUDIO0_TX_FRAME_FORMAT, ACP_SW_AUDIO0_TX_SAMPLEINTERVAL, ACP_SW_AUDIO0_TX_HCTRL_DP0,
>>  	 ACP_SW_AUDIO0_TX_OFFSET_DP0, ACP_SW_AUDIO0_TX_CHANNEL_ENABLE_DP0},
>> diff --git a/include/linux/soundwire/sdw_amd.h b/include/linux/soundwire/sdw_amd.h
>> index 922d30a540fd..c978cfbc0207 100644
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
> This seems pretty generic non-AMD code, and all the dai registration is
> also 'inspired' from the Intel code, seems like there's room for code
> sharing/reuse.
In V1 version patch set, we have used sdw_stream_runtime structure
and sdw_amd_dma_data structure. As per review comment,
we have used runtime dai array.

This can't be generic. We are going to modify this structure when we migrate
to SOF based solution. Intel code has its own structure members apart from above
mentioned fields in dai runtime structure.
>
>> +
>>  /**
>>   * struct amd_sdw_manager - amd manager driver context
>>   * @bus: bus handle
>> @@ -40,6 +55,7 @@ struct sdw_manager_reg_mask {
>>   * @quirks: soundwire manager quirks
>>   * @wake_en_mask: wake enable mask per soundwire manager
>>   * @power_mode_mask: flag interprets amd soundwire manager power mode
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

