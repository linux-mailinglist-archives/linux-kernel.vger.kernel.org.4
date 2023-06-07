Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03A6B7254CE
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 08:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238262AbjFGGx0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 02:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238264AbjFGGxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 02:53:20 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2076.outbound.protection.outlook.com [40.107.102.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23BED1993
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 23:53:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YdDefhE4ziSCSb3VoBfvuk6UygIyQPCVV2wZGNRKuwT8EDRGY6hm6qNxnTVrNcLQjfFcEbFH+0dRFtwmAZNmNRwAEZaytVIsqnibWzRCY9P3qtxvEX16oTNHzsZsjNo3hL6DgPV6i/Qni4epaYkZTPu7SoSdvJomR0HOR+Nurx/HtzXrrhYpTWsr5F7VLeEZoAAPKvW8XD0xJrEZvtKU6VDpIy2tQSJRrzAOwGr03QCgSJ4BKVqu8r1bl3yU0dEXuth0OhuCpfv+OhpDZh+nOm+z/+qIn3wMD7tYSYD6HskvuYo9D5zAdbOlp2Bcua5nCwS2MCJ95FQIZxKAT1EKLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9GIvOc5ZnSmLNLhwUyxI37JI013GrZj+6j8ARjBtsUk=;
 b=DGTTQZMAjS2uO9H7uNeIdxYLURbpErdRkhh1kJanOTdkNl6Yo2ll9J1asjtYFJED/JZFXBhTrNs+M4KbS9OUfx2jgRMJ+H0QF7JAbPtSnSSRjYM7AnmGjfTB6w/TG+FbutDNXZCaUiM7wqlwIeeloIHtScP6NG1cEmf4ROPmvXGtQVySyEvyMUAhJmSIVlHP06x86laQOwtNx/dEnO7Uya+kLE38mofDspkjgOdPVYgTOWI23Zg1cR4vqAJmS0ic3zrb7e+SsgISx5porKCGkD/HZG84uvJcfNdLoxJEGf4VrlMVpYC4hWfQ4OF4Zlb/vw/K/HsAYtqMS/mDwt3wIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9GIvOc5ZnSmLNLhwUyxI37JI013GrZj+6j8ARjBtsUk=;
 b=Opzf/bU+cm3/a4+M9T6+Sru+11pIDSovBgIAFfuK9BcoS+JQceN7pir/c7wwazDeCjpKioFQr0mO3JmyO+H/rMizrpkDHHe3YcBMlwFsAzQM4vJ7gJqQgmz1q0MYkJd8FGXW78GXYcJ/mO20imVQTupNp3P65z5QikQ5WcRC+Rs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4123.namprd12.prod.outlook.com (2603:10b6:5:21f::23)
 by DS0PR12MB6584.namprd12.prod.outlook.com (2603:10b6:8:d0::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.33; Wed, 7 Jun 2023 06:53:12 +0000
Received: from DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::8760:2e89:1243:2b5d]) by DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::8760:2e89:1243:2b5d%6]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 06:53:11 +0000
Message-ID: <59f07a2f-f0eb-5216-453b-8c494a182d99@amd.com>
Date:   Wed, 7 Jun 2023 12:27:54 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH V3 6/9] ASoC: amd: ps: add pm ops support for SoundWire
 dma driver
Content-Language: en-US
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, Basavaraj.Hiregoudar@amd.com,
        Sunil-kumar.Dommati@amd.com, Mastan.Katragadda@amd.com,
        Arungopal.kondaveeti@amd.com, mario.limonciello@amd.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20230606060724.2038680-1-Vijendar.Mukunda@amd.com>
 <20230606060724.2038680-7-Vijendar.Mukunda@amd.com>
 <892b8211-7384-f948-fe76-03c6c48f23c6@linux.intel.com>
From:   "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
In-Reply-To: <892b8211-7384-f948-fe76-03c6c48f23c6@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0036.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::15) To DM6PR12MB4123.namprd12.prod.outlook.com
 (2603:10b6:5:21f::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4123:EE_|DS0PR12MB6584:EE_
X-MS-Office365-Filtering-Correlation-Id: b4c74477-6d5c-4aed-77e3-08db6723dc22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nuno45hbibfyMODSzoMiwn9y1Ch46FmSVb7jpJmfmkeCMJLQC6rgHBJRgoL45i5fFi6tf5aqPyFrSYlsfNPeQ6s1vFG/p7qoT4oG6Va//IjDBsffRMGezyXXyAukptYwiHu2lfLERt8AXcgS2WB4pOhm8xl9AZeBpEjKLCBQ3+Ln1LIgCzbo/ix91phvwxh6OFDRk41lwppqNlh3qAUXHtOT2Rf9XkRt7LRyqIhBvcuXKivWI0WMITr3TzEOhVbN/XRgZpndbU+CajoZ+8lnc7B4J7CNdesc467bzFJJRXTQzXviMT9TiZM/SbdNqiTBpsSADGcwh+kuHV+lR+xojmq/HYsM0csAG9zq+yTsyDpQyBIpPG1h0cYTq2s/bSSMvZQRzLHzh/B23i6l0C5kfihZk97kcbuvA0+t8d38xZVOUJiiE/K/7fWajUZvg5CiRLf+o9PRbXshq6zkWo5zyUgoypxgwTEZMDLkrW3o1zxsqpAPHMfrAAioJjm5YSz2LmlDvSFNAm6V6tFDUu7ONW3M/qcEC0WdyHtNR68AnXREex3M8v+Oo3mWQgngs7NB6nW6wV1tYfwRhEZjrsw5r0ED+MR7HvBrUK0XUc1rm1D2mGtVuyMMo4FfAyIHh4hE+3EqDhBXUoh8yrORg00I1w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4123.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(366004)(39860400002)(376002)(396003)(451199021)(54906003)(478600001)(5660300002)(8676002)(8936002)(4326008)(66946007)(66556008)(66476007)(316002)(41300700001)(38100700002)(2616005)(186003)(83380400001)(6486002)(6666004)(53546011)(6512007)(6506007)(26005)(31696002)(86362001)(36756003)(2906002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?blZBdmpWaEhVbnBIYWd0dVdJYjVuUmFKMm5idWFJUmM5L2lWay9WWTlIZVpa?=
 =?utf-8?B?dWhoVm9hYU1qMER5SjlRYmxYM0w0UE8yNTQ1dUcwOXBDaXJtTWJvQzdNdWJ4?=
 =?utf-8?B?TWNmVzVxcnVlakljTzV6RFgvNlBOZmdVZ0U0aWdHb203SHBGSTJpYnpKbEVU?=
 =?utf-8?B?UVVmOEZTVjY0K2Qrby9zb0oydFlsZDdCREZJcTczSHhWUFhmNlFSbXFHOEhR?=
 =?utf-8?B?bHptdm1CTW53ei9XTFJiWDJQM2c5MVExM1JwWWlSTm5SNzdsNnNlL1QwV3pW?=
 =?utf-8?B?UUJoMjNsQnVia2h1VnJKaWZ1V2RuRmplQWJsNDEwYSt0WVVGWkEyVldyR1pu?=
 =?utf-8?B?TklJS2NIYWo0SUJ0ak9kREZiMzZXM1B4ZC9QYmI5Zk5PVmJ0NkszdUdHSHZ0?=
 =?utf-8?B?TUhhMitrb0VNRko0YklJOWpzOEYzeUN3a3I1a1FDS2FLTVNKVHZrbFlBWEVz?=
 =?utf-8?B?NktXcjRmSVlHNVBOaEtFQUREcm5vUEJZeGZRWDNiNE1Xd2NERnhKa1MwdjZX?=
 =?utf-8?B?R0pJMG0rck9hMWs3VmZIalhwM2VJNFUxR0ZWYmNlZGxieEtLaDdtY29zNEwr?=
 =?utf-8?B?U1pRMUhUNm5pK3dGdWR6WjhsWWNHLzBKTG1aS2daOGFpbTVPYnU3Z0YydTZW?=
 =?utf-8?B?dlNkV2dCUXhvaktESG5RY0QzcnlrNFQ1dkUxeEhvdlM4OTdWRjA4UlYwQ2pL?=
 =?utf-8?B?YU04dlNHaVFBUm05YlJTRFAwSlU2OFdadFd2SXU1V3NhTTYrNXYrT2h6VlBs?=
 =?utf-8?B?ZThnRmlObXlBS3RPU2ZhYmVhdkV1OXMveVB6SzlhMExZZllLYmdiODU5N1VY?=
 =?utf-8?B?ZXFLeWg0ZG84YzFaNDFUSUxZMXBnNkxTYmlzNVcyYy82bnJ4WFRmZGlzdGRa?=
 =?utf-8?B?TnVNVW9hK0pDbzB6RVBYck8waVZDMlVwbTdpd2lJd0h3ZytHYmhML05BZmdG?=
 =?utf-8?B?R3BMQy83UGNTemJNNkxBRzc3Vm9nVjBVQ014Q2tjMEZBM1ErSmk5VCtTeS92?=
 =?utf-8?B?MWlDd1FXT3F5d2Q5eXJGSEViMXdOQW9mS1NTQ1llNHJuZW8xTU9kSzNWM0Zl?=
 =?utf-8?B?cTRYbmExTHBXWklwYjlhVHRuZVRJYVpGK3R2dUMvRnhHOE9sSnNLWTc3Rklu?=
 =?utf-8?B?dG8wVFZWTE5GU2tDV1FBa3RNYVRZMnZUaTdoR2ZPRDIrcWdocHJzejI0bHQr?=
 =?utf-8?B?c0pYdWtvMmJUOWVGV3REWk9ZZElNdHozQWNraDBZSmZvS29UVXdaRmxEYXlL?=
 =?utf-8?B?Nm41aGFDMzdCY0gvTmhJOWRuQ1B0dE5jV294VHUrb3AxZnI2UWg4dGlmT2Nu?=
 =?utf-8?B?c2ptZFhEVnhWOGc4V2JpTTJFNWE3ckpFWEJMSENoNGJudGMyWmoxaFpPMzJD?=
 =?utf-8?B?RXpHanlCQklKVm44NGxvVXN3YU9HRGIwZmNNT2g5K0w3NHBKMjhuclhjek1w?=
 =?utf-8?B?K2Y4RnNjU0o3VkIxb2xBRUtDclN5OG1aY1dDNnNzbUN5UnFJSXFzZTZGZTRo?=
 =?utf-8?B?NWpQczh5KzM3MCtoVGs5UVFEZHhvRzN5SHJNelNENVFlbXl3eS92N0JDVDFI?=
 =?utf-8?B?Sy9kb21obEt5TzdUalQwTmZMRGpOSlRSVitNbEsrTEtMaDBGVjFXdXpYdDht?=
 =?utf-8?B?R0dVQml4NElFOXVqcHF4Z0c3ZUc0bG9LZWRCblprWjhzaitXN2tQS08yaTBq?=
 =?utf-8?B?NzRTT1F0WmpGNmduUjdHeXNJcWZsbXVNWkFsR3ZOZTk5MStwV21sQ0dLOWhD?=
 =?utf-8?B?dDlJNXRYTzNLUEZ3SUdmMnhkYWxPV3VRb2pCL0l6RXBMcjkvYVc3SksyNlF6?=
 =?utf-8?B?T1ZYczRTQTh1VFVmK2NxZFB0NWllSzlRUFB2NVQ3SHZnUUR3Vi9SaVcxc2Uy?=
 =?utf-8?B?VVRsRDZQSUdyWEZUKzJSWDVlTFg5SXpMNC9YTllqMnJuZ2NOcEZaMVBIRGFN?=
 =?utf-8?B?cDFlV1ovMWRwbWdwNTlnbVRmMjc3MUFIVVVzbWZsczlndmdyLzlkNmIrVVdL?=
 =?utf-8?B?eWdhMlNwaU95WGFpSWExRzE1UHhxVi85YmkyV2xMZE5vWjM5WEM0NHA0Zm85?=
 =?utf-8?B?N1R4RG1RL3ViSkxwb2tXTWREZkt3ejJ6NEEvalpnY0VSakM3cTYvOW4wN3c4?=
 =?utf-8?Q?WwbkRXuIB3+KA8hQ5MJxakVdx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4c74477-6d5c-4aed-77e3-08db6723dc22
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4123.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 06:53:11.8904
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dtvUHuwavxyy0Rw6yCXyAIhLMiaOLGDpvn28uK70aO3+6q3LeGAmK6lNAd2PVoVHbBh8IRuRDu2yxMl89xpFNg==
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

On 06/06/23 20:32, Pierre-Louis Bossart wrote:
>
> On 6/6/23 01:07, Vijendar Mukunda wrote:
>> Add support pm ops support for SoundWire dma driver.
>>
>> Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
>> ---
>>  sound/soc/amd/ps/ps-sdw-dma.c | 98 ++++++++++++++++++++++++++++++++++-
>>  1 file changed, 96 insertions(+), 2 deletions(-)
>>
>> diff --git a/sound/soc/amd/ps/ps-sdw-dma.c b/sound/soc/amd/ps/ps-sdw-dma.c
>> index 06d847c6a50e..118f4c3674ab 100644
>> --- a/sound/soc/amd/ps/ps-sdw-dma.c
>> +++ b/sound/soc/amd/ps/ps-sdw-dma.c
>> @@ -12,6 +12,7 @@
>>  #include <sound/pcm_params.h>
>>  #include <sound/soc.h>
>>  #include <sound/soc-dai.h>
>> +#include <linux/pm_runtime.h>
>>  #include <linux/soundwire/sdw_amd.h>
>>  #include "acp63.h"
>>  
>> @@ -102,6 +103,29 @@ static const struct snd_pcm_hardware acp63_sdw_hardware_capture = {
>>  	.periods_max = SDW_CAPTURE_MAX_NUM_PERIODS,
>>  };
>>  
>> +static void acp63_enable_disable_sdw_dma_interrupts(void __iomem *acp_base, bool enable)
>> +{
>> +	u32 ext_intr_cntl, ext_intr_cntl1;
>> +	u32 irq_mask = ACP_SDW_DMA_IRQ_MASK;
>> +	u32 irq_mask1 = ACP_P1_SDW_DMA_IRQ_MASK;
>> +
>> +	if (enable) {
>> +		ext_intr_cntl = readl(acp_base + ACP_EXTERNAL_INTR_CNTL);
>> +		ext_intr_cntl |= irq_mask;
>> +		writel(ext_intr_cntl, acp_base + ACP_EXTERNAL_INTR_CNTL);
>> +		ext_intr_cntl1 = readl(acp_base + ACP_EXTERNAL_INTR_CNTL1);
>> +		ext_intr_cntl1 |= irq_mask1;
>> +		writel(ext_intr_cntl1, acp_base + ACP_EXTERNAL_INTR_CNTL1);
>> +	} else {
>> +		ext_intr_cntl = readl(acp_base + ACP_EXTERNAL_INTR_CNTL);
>> +		ext_intr_cntl &= ~irq_mask;
>> +		writel(ext_intr_cntl, acp_base + ACP_EXTERNAL_INTR_CNTL);
>> +		ext_intr_cntl1 = readl(acp_base + ACP_EXTERNAL_INTR_CNTL1);
>> +		ext_intr_cntl1 &= ~irq_mask1;
>> +		writel(ext_intr_cntl1, acp_base + ACP_EXTERNAL_INTR_CNTL1);
>> +	}
>> +}
>> +
>>  static void acp63_config_dma(struct acp_sdw_dma_stream *stream, void __iomem *acp_base,
>>  			     u32 stream_id)
>>  {
>> @@ -464,16 +488,86 @@ static int acp63_sdw_platform_probe(struct platform_device *pdev)
>>  	status = devm_snd_soc_register_component(&pdev->dev,
>>  						 &acp63_sdw_component,
>>  						 NULL, 0);
>> -	if (status)
>> +	if (status) {
>>  		dev_err(&pdev->dev, "Fail to register sdw dma component\n");
>> +		return status;
>> +	}
>> +	pm_runtime_set_autosuspend_delay(&pdev->dev, ACP_SUSPEND_DELAY_MS);
>> +	pm_runtime_use_autosuspend(&pdev->dev);
>> +	pm_runtime_mark_last_busy(&pdev->dev);
>> +	pm_runtime_set_active(&pdev->dev);
>> +	pm_runtime_enable(&pdev->dev);
>> +	return 0;
>> +}
>>  
>> -	return status;
>> +static int acp63_sdw_platform_remove(struct platform_device *pdev)
>> +{
>> +	pm_runtime_disable(&pdev->dev);
>> +	return 0;
>>  }
>>  
>> +static int acp_restore_sdw_dma_config(struct sdw_dma_dev_data *sdw_data)
>> +{
>> +	struct acp_sdw_dma_stream *stream;
>> +	struct snd_pcm_substream *substream;
>> +	struct snd_pcm_runtime *runtime;
>> +	u32 period_bytes, buf_size, water_mark_size_reg;
>> +	u32 stream_count;
>> +	int index, instance, ret;
>> +
>> +	for (instance = 0; instance < AMD_SDW_MAX_MANAGERS; instance++) {
>> +		if (instance == ACP_SDW0)
>> +			stream_count = ACP63_SDW0_DMA_MAX_STREAMS;
>> +		else
>> +			stream_count = ACP63_SDW1_DMA_MAX_STREAMS;
>> +
>> +		for (index = 0; index < stream_count; index++) {
>> +			if (instance == ACP_SDW0) {
>> +				substream = sdw_data->sdw0_dma_stream[index];
>> +				water_mark_size_reg =
>> +						sdw0_dma_ring_buf_reg[index].water_mark_size_reg;
>> +			} else {
>> +				substream = sdw_data->sdw1_dma_stream[index];
>> +				water_mark_size_reg =
>> +						sdw1_dma_ring_buf_reg[index].water_mark_size_reg;
>> +			}
>> +
>> +			if (substream && substream->runtime) {
> can this be false?
Yes if its corrupted somehow. Better to have null checks.
>> +				runtime = substream->runtime;
>> +				stream = runtime->private_data;
>> +				period_bytes = frames_to_bytes(runtime, runtime->period_size);
>> +				buf_size = frames_to_bytes(runtime, runtime->buffer_size);
>> +				acp63_config_dma(stream, sdw_data->acp_base, index);
>> +				ret = acp63_configure_sdw_ringbuffer(sdw_data->acp_base, index,
>> +								     buf_size, instance);
>> +				if (ret)
>> +					return ret;
>> +				writel(period_bytes, sdw_data->acp_base + water_mark_size_reg);
>> +			}> +		}
>> +	}
>> +	acp63_enable_disable_sdw_dma_interrupts(sdw_data->acp_base, true);
>> +	return 0;
>> +}
>> +
>> +static int __maybe_unused acp63_sdw_pcm_resume(struct device *dev)
>> +{
>> +	struct sdw_dma_dev_data *sdw_data;
>> +
>> +	sdw_data = dev_get_drvdata(dev);
>> +	return acp_restore_sdw_dma_config(sdw_data);
>> +}
>> +
>> +static const struct dev_pm_ops acp63_pm_ops = {
>> +	SET_SYSTEM_SLEEP_PM_OPS(NULL, acp63_sdw_pcm_resume)
>> +};
>> +
>>  static struct platform_driver acp63_sdw_dma_driver = {
>>  	.probe = acp63_sdw_platform_probe,
>> +	.remove = acp63_sdw_platform_remove,
>>  	.driver = {
>>  		.name = "amd_ps_sdw_dma",
>> +		.pm = &acp63_pm_ops,
>>  	},
>>  };
>>  

