Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DC1F7062F9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 10:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbjEQIeD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 04:34:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbjEQIdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 04:33:25 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2046.outbound.protection.outlook.com [40.107.220.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2AB91BF8
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 01:33:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EpV6zGWXR/NI10HE72WP/hgxFhXOJNzUkLsjZmyqctvOfzPxXoUY02e+AHsLlsrEbNMpbNIgTblj77qGq//DgZ0anBVnZqL+nDl/PFRZHF6FKJo8sYZHkcvdXwEyvljLYbPV7hOCqcEfny1PtjPJhI1D+SUMQNxd8+TIA4xFqrxwRyVQogTxn86gvF7GexKM8db4td5T5O02Lo0w703KhEwUSo1jNiG4k6J5iX+fL0cFSBb5AqHiU7/gFfNPUWuYikMKM727m1FCohZMsVowOa7theWYLtb5BWCNEbvVKF7vqJvLeZMbK6J9TsaDUsBXSfioj2/6Z6+B32sLGASLzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vkd0L/FTEQlCVePPrHe3qJ/9eWN3S2g5yq60pRGX0Jc=;
 b=WgB3i5/nJXl5M+GZl2g9nqaP687VyZs6sGUuYir7uwyX4fGKwFfQ8dcmTKvP1esKmKLweyc+kzrzX1rjWsA2Pvuz3EaKNuA5gUWRFVplPuiLO9TyXni8DVDO29s2rhFcvaew1PeMj51YjDvVvtLcJmfScw7kL0vSo/9MjIY8iggvV+C552pDxBaa7TxtavwD5IksMLanULB+jk85qDfMH4AXeOaCqlYy1g2EHgpTV1gchOKCnMbR89B5o+DQ2qv9EuSGbmmTScuJzmmeafAvoJ2hz137wsZ2LF8y4FXcLieAxDeAiexoZkqVpMxABmKxPxxrjEwy6ZRRxXptNN8clQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vkd0L/FTEQlCVePPrHe3qJ/9eWN3S2g5yq60pRGX0Jc=;
 b=47HMbaJbA4fIiOdFfK+u9BGiR1lMLQoc5rbhmgHwVowEWv3QgIsXJhbyQ9H+vPuZTOdfb0ImYDSnBwL0i8aq2pNQj6nRHsMo1SiUyGvXPWo3Bvxke/jBTDc3UqinV4caJZXQD46R12i2n8s6UR9VZWY7fYmLUFSAXLgoo3GGXSk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4123.namprd12.prod.outlook.com (2603:10b6:5:21f::23)
 by CY5PR12MB6153.namprd12.prod.outlook.com (2603:10b6:930:27::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Wed, 17 May
 2023 08:33:12 +0000
Received: from DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::7c50:6c99:76d:f952]) by DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::7c50:6c99:76d:f952%6]) with mapi id 15.20.6387.033; Wed, 17 May 2023
 08:33:12 +0000
Message-ID: <c9afc5b7-b07d-1ef5-7c76-f592577f833a@amd.com>
Date:   Wed, 17 May 2023 14:08:14 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/9] ASoC: amd: ps: create platform devices based on acp
 config
Content-Language: en-US
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Mark Brown <broonie@kernel.org>
Cc:     alsa-devel@alsa-project.org, Basavaraj.Hiregoudar@amd.com,
        Sunil-kumar.Dommati@amd.com, Mastan.Katragadda@amd.com,
        Arungopal.kondaveeti@amd.com, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20230516103543.2515097-1-Vijendar.Mukunda@amd.com>
 <20230516103543.2515097-2-Vijendar.Mukunda@amd.com>
 <a94650e0-f7b4-b431-5a3c-042ce724cf50@linux.intel.com>
From:   "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
In-Reply-To: <a94650e0-f7b4-b431-5a3c-042ce724cf50@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0152.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:c8::16) To DM6PR12MB4123.namprd12.prod.outlook.com
 (2603:10b6:5:21f::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4123:EE_|CY5PR12MB6153:EE_
X-MS-Office365-Filtering-Correlation-Id: 39f3b57b-7d61-4e4a-bac2-08db56b159bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y1ildroCQBr3cab17XhAj0IJ88R7xV0tIONK9GpoF53pdDGuM7yXM/GLlQYeB4AnEGqiqp1GP1MoGJRYgXp7F/h5ZCxJflCYc9I80St/xN9csata/Gzwd4yjMPD+HA7/8NCPTT1E7RtMVXB54EZmPWzz0CoXyja/avxPQa+QFaP59SIQ8uGNDhoIGVxhZxbYLt0MUDuBw57++a5Yvs9V6+YnL0A9A/H5tUqwQRngEQ/P/Ce+rWg25/vym5qeZN6y9p+wc+//zKaSYpxYiK/bOa64rVHUViFrR+iyErFOnDS2yrJN+UHiCI8Ubicc4QtpA+1LdzJoHYrckUQ6hLlkptY6WNC5IeV7t/uZ3cryL8h6JlIR615ZpWomGpQrg+fySj3oJAWt0yK7GZEYDdIwVsg1GkRtwE8RWuMxVB/gVIYIyeAzZ5HlVRwCi7So9kr/SA2Tw/lp42nBYRsndJhiGptiW0Sr1y/2XY3xU7sla9t8nS5Uq6/PdvfM6+3dizZNGOUsGEfof17hz4e2rfaqeLTdzptHAPxx9CH1sgIZwBnUc/aY0zN81Ux5i13Zkeqor3vtnm6NDyfRII9/kEVH12fnvMbTql3A808olvwW1CR4/E2sVhvxufRl9YuTzF4Bvmork6nLPdM1bbWl2iY3LQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4123.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(136003)(396003)(346002)(376002)(451199021)(6486002)(2616005)(36756003)(83380400001)(6512007)(53546011)(38100700002)(26005)(6506007)(186003)(86362001)(110136005)(54906003)(31696002)(30864003)(2906002)(41300700001)(8676002)(5660300002)(316002)(31686004)(8936002)(4326008)(66556008)(66476007)(66946007)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TGw3cVZTdWFodGRGTXB5N3dGTzlwUTN1bldYZmxyeDFRczdkSjhYMDRPZ0NQ?=
 =?utf-8?B?dGRNbVd3MzFyVnZKUGZqakpTV1BQSVI0ZjM5TDloeHdPcE1MOUdmR1FldmJv?=
 =?utf-8?B?amRvWFdLY3JuL2JmRXZiL0ZjelRPSktQNER0S0NPYzUwbGI3WUZ3Qnh6QXh4?=
 =?utf-8?B?elhrVjBnSXFBSW11ekpZTUFUaTlyb3M5c1pabVkwcjRhaGRtT2oxdHRsUGNM?=
 =?utf-8?B?eGgxMG1LTTJkMTZTeWFBdVpLbE9mbDdlVUpzc1lWOVc2ZHFCcmdLbjkycy9X?=
 =?utf-8?B?Y2w0anQ1SmNSNzJzbzV0ZGx0TjRnejRWa29oYkFpeCtrQ1hGVkpyNVJpUFhM?=
 =?utf-8?B?YmdCaXhGcU5mWTNDYTdJT2orTVlPaFhvOVJRb2NBcjBJVzJ4RFVzZ3JNeTJm?=
 =?utf-8?B?ZFFjcjhJZGFTbzZVUWVFQjgwWTRjcHlaZzhCTy90TkI1RXE0RUpCeFp2TWRm?=
 =?utf-8?B?aVRZcnN0SG53TTBFcWVaMmRocm1MZTlBRXVPaWNLS1h1LzI2VXdLMzB1a2JU?=
 =?utf-8?B?a3ExZ2h6YjRBdEFrSFBrM1hGWldyOUxtV3F6eTh1cEJveGkyL2sydTN6MHBR?=
 =?utf-8?B?ZDlHRHlVNWI1UXdLRC9pZ0RWUlhDSjBUNXBlNUhmZFNGZkFCQWRDeHVoRXJ1?=
 =?utf-8?B?aXNkc2pJZTVlUTZIL05oZDlJN3VmcTRPT2ZWOGppUzZnL1dEMWZxdTJLNXYz?=
 =?utf-8?B?VHRPWDVJWW12aFhNQTlBcDVLVzBVQmJzMEJMVkRPRWpRRS9URU1VenE2UnRW?=
 =?utf-8?B?c2RJa1o3MlRWbzA1UUxaU3hFVzdpdHh3WTNCQVJXb3g4V0ZjcDdzQ1hiQmhs?=
 =?utf-8?B?SytqNlV1cFBlNUJTNDJaTWdzaTNtMUVaeE45TVN2YW4zemI0ZVZQdGlnRXpz?=
 =?utf-8?B?UlNIZVNZVC9obkJVdXJYODc4cFBCQzVCNzFpdUJ0cmhZYTFIdHhnOWtRTU1a?=
 =?utf-8?B?cktPWVBUTzkvZWk0Q2gvZGdtRTdmcGt6R1I0V1RXV0tMYUZNN1I3TWtlc3hH?=
 =?utf-8?B?T25JUitCdDVWbkJ3dXJ4c2lZQ0tveWx1MzBqZTMrRWU1R0JXTzhmaVpkM3dO?=
 =?utf-8?B?Y3BxUGVoc211YS9JSm1iblVQcjJRR0V5aGtsT1p5Z09lWWdyUlFodDljY3JP?=
 =?utf-8?B?Z2NvRmlPK3VxMHNQclcvQmN3L2ZoTUc2dDhOcHR0K2VTUDJsWmxRWERXWDVq?=
 =?utf-8?B?V2lLbmFFbDUwekwxVW1JVmhpNHdMN0FFcTZubGpoY2JFcTFlWTBsRjNJNDNO?=
 =?utf-8?B?SnpHMEdRdlB6TkxkSTl2NUNoQnZoTDg5NjQxZHQ3WjlhVktVTHJFNHBvSDVG?=
 =?utf-8?B?eXBvejJLQVJBblpkekRYcG9pb3JqSTljclNtT2xwTTN3bnNGNkJobXZJRlBN?=
 =?utf-8?B?anZvU1docW4zQzA0RzBDbWZadTBPc09UbVVSNzBJQzBVNWNKcjFNeDNxMHRK?=
 =?utf-8?B?YmFQaVZvWlU3S1NHN3BQYjVuc0s4UzgwMmF6OGZBM1FIQXlEU25RSDFnblk3?=
 =?utf-8?B?NnVmVmN2eWFyOU9zUThXUFRJUzFVcXJNK2xwKytGSE5ObTFoSENQTVcxNm9n?=
 =?utf-8?B?dEs2YVVDMUhuMldPRXJEeERWclFGdXlVa29DWDdjcUxpMXJ0NXhwZnBPWnJo?=
 =?utf-8?B?ejVGbzF1N1I1R1dvWWUzK1hvNEhRSDFVT21aNVRzZk1YYnFXa3Bnc3NEa05h?=
 =?utf-8?B?QVJZTmhhc1ZYYXdxblJsYkhLVytQb3Bpc1RNYnVQS0dSendRT1BQRGRRLzFE?=
 =?utf-8?B?cWxEY0o5Q3hMeUpxV1p6NjRPQ0RSYkhOa1hxckkyWGdHTnRiTXhEbSsvMlNI?=
 =?utf-8?B?aVRiTkRRS3B6MWRBZElvQ0MvRUx4NGI4ODE3L0wwcWk3VzNackFOTmlhQndQ?=
 =?utf-8?B?dU9mbDRDVmdZcWpxM0NXaGFnZVgzaGFCTHhCMTdOUXJraG5ZY0pGd3pPRndO?=
 =?utf-8?B?QlhseWM3M1FMRE40UG9Eb0RDU25IandNNndhZE1kSjFseDFSSkVpblJ0T2lT?=
 =?utf-8?B?bVRmZG1pUUc2K3BqOEtIZUs1Vi85MnZFYlQySzEyU0J6NkFsOEgzaFJYZkUz?=
 =?utf-8?B?TnhCOFlJL09jSFU5K3VPRjVTcGkzcFpKZUNxODcyZTRRSjhiSGRYbEZiSVVs?=
 =?utf-8?Q?g7yd0uMOicKmBDC1cP/AzWbGG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39f3b57b-7d61-4e4a-bac2-08db56b159bd
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4123.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 08:33:11.9096
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gzyXOqJggekDCvxE8IrHN4dpjUnJYGPbHLavOIhU1i79IeEWwEwTa4r/pISx+ZuYb3Fd+oVWKZQN9pEc3C6yuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6153
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/05/23 20:02, Pierre-Louis Bossart wrote:
>
> On 5/16/23 05:35, Vijendar Mukunda wrote:
>> Create platform devices for Soundwire Manager instances and
>> PDM controller based on ACP pin config selection
>> and ACPI fw handle for pink sardine platform.
>>
>> Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
>> ---
>>  sound/soc/amd/ps/acp63.h  |  43 ++++++-
>>  sound/soc/amd/ps/pci-ps.c | 250 ++++++++++++++++++++++++++++++++++++--
>>  2 files changed, 280 insertions(+), 13 deletions(-)
>>
>> diff --git a/sound/soc/amd/ps/acp63.h b/sound/soc/amd/ps/acp63.h
>> index 2f94448102d0..f27f71116598 100644
>> --- a/sound/soc/amd/ps/acp63.h
>> +++ b/sound/soc/amd/ps/acp63.h
>> @@ -10,7 +10,7 @@
>>  #define ACP_DEVICE_ID 0x15E2
>>  #define ACP63_REG_START		0x1240000
>>  #define ACP63_REG_END		0x1250200
>> -#define ACP63_DEVS		3
>> +#define ACP63_DEVS		5
>>  
>>  #define ACP_SOFT_RESET_SOFTRESET_AUDDONE_MASK	0x00010001
>>  #define ACP_PGFSM_CNTL_POWER_ON_MASK	1
>> @@ -55,8 +55,14 @@
>>  
>>  #define ACP63_DMIC_ADDR		2
>>  #define ACP63_PDM_MODE_DEVS		3
>> -#define ACP63_PDM_DEV_MASK		1
>>  #define ACP_DMIC_DEV	2
>> +#define ACP63_SDW0_MODE_DEVS		2
>> +#define ACP63_SDW0_SDW1_MODE_DEVS	3
>> +#define ACP63_SDW0_PDM_MODE_DEVS	4
>> +#define ACP63_SDW0_SDW1_PDM_MODE_DEVS   5
>> +#define ACP63_DMIC_ADDR			2
>> +#define ACP63_SDW_ADDR			5
>> +#define AMD_SDW_MAX_MANAGERS		2
>>  
>>  /* time in ms for acp timeout */
>>  #define ACP_TIMEOUT		500
>> @@ -80,6 +86,12 @@ enum acp_config {
>>  	ACP_CONFIG_15,
>>  };
>>  
>> +enum acp_pdev_mask {
>> +	ACP63_PDM_DEV_MASK = 1,
>> +	ACP63_SDW_DEV_MASK,
>> +	ACP63_SDW_PDM_DEV_MASK,
>> +};
> a comment or kernel-doc wouldn't hurt to explain the difference between
> ACP63_PDM_DEV_MASK and ACP63_SDW_PDM_DEV_MASK, the meaning of the 'SDW"
> prefix is far from obvious.
Above enum's are listed to know the platform device masks.
For example - if ACP63_PDM_DEV_MASK is set, then ACP PCI driver
will create platform device for PDM controller.

If ACP63_SDW_DEV_MASK is set, ACP PCI driver will create platform device
nodes for soundwire manager instances based on instance count retrieved
by scanning the SoundWire Controller.

If ACP63_SDW_PDM_DEV_MASK is set, ACP PCI driver will create platform device
nodes for PDM controller and SoundWire manager instances.

We will add comment for the same.


>
>> +
>>  struct pdm_stream_instance {
>>  	u16 num_pages;
>>  	u16 channels;
>> @@ -95,14 +107,41 @@ struct pdm_dev_data {
>>  	struct snd_pcm_substream *capture_stream;
>>  };
>>  
>> +/**
>> + * struct acp63_dev_data - acp pci driver context
>> + * @acp63_base: acp mmio base
>> + * @res: resource
>> + * @pdev: child platform device node structures
> array of platform devices ?

will fix it.
>
>> + * @acp_lock: used to protect acp common registers
>> + * @sdw_fw_node: SoundWire controller fw node handle
>> + * @pdev_mask: platform device mask
>> + * @pdev_count: platform devices count
>> + * @pdm_dev_index: pdm platform device index
>> + * @sdw0_dev_index: Soundwire Manager-0 platform device index
>> + * @sdw1_dev_index: Soundwire Manager-1 platform device index
>> + * @sdw_dma_dev_index: Soundwire DMA controller platform device index
>> + * @is_dmic_dev: flag set to true if DMIC device exists
> it's not clear what 'DMIC device' refers to here and why it is exposed here.
is_dmic_dev is to know whether PDM controller device node exists or not with in
ACP PCI device ACPI scope by checking _ADDR as mentioned below.

dmic_dev = acpi_find_child_device(ACPI_COMPANION(&pci->dev), ACP63_DMIC_ADDR, 0);

if dmic_dev exists then "is_dmic_dev" is set to true.

To avoid confusion, we will rename "dmic_dev" as "pdm_dev".


>
>> + * @is_sdw_dev: flag set to true if Soundwire manager devices exists
> same, what does this track? What is the difference between 'dmic dev'
> and 'sdw_dev', given that there are references above to SDW_PDM. It's
> confusing.
Similarly, is_sdw_dev flag is set if SoundWire Manager devices
are available after scanning SoundWire controller listed in ACP PCI
device ACPI scope.
>> + * @acp_reset: flag set to true when bus reset is applied across all
>> + * the active soundwire manager instances
> SoundWire
Will fix it.
>
>> + */
>> +
>>  struct acp63_dev_data {
>>  	void __iomem *acp63_base;
>>  	struct resource *res;
>>  	struct platform_device *pdev[ACP63_DEVS];
>>  	struct mutex acp_lock; /* protect shared registers */
>> +	struct fwnode_handle *sdw_fw_node;
>>  	u16 pdev_mask;
>>  	u16 pdev_count;
>>  	u16 pdm_dev_index;
>> +	u8 sdw_manager_count;
>> +	u16 sdw0_dev_index;
>> +	u16 sdw1_dev_index;
>> +	u16 sdw_dma_dev_index;
>> +	bool is_dmic_dev;
>> +	bool is_sdw_dev;
>> +	bool acp_reset;
>>  };
>>  
>>  int snd_amd_acp_find_config(struct pci_dev *pci);
>> diff --git a/sound/soc/amd/ps/pci-ps.c b/sound/soc/amd/ps/pci-ps.c
>> index c957718abefc..f3aa08dc05b2 100644
>> --- a/sound/soc/amd/ps/pci-ps.c
>> +++ b/sound/soc/amd/ps/pci-ps.c
>> @@ -6,6 +6,7 @@
>>   */
>>  
>>  #include <linux/pci.h>
>> +#include <linux/bitops.h>
>>  #include <linux/module.h>
>>  #include <linux/io.h>
>>  #include <linux/delay.h>
>> @@ -15,6 +16,7 @@
>>  #include <sound/pcm_params.h>
>>  #include <linux/pm_runtime.h>
>>  #include <linux/iopoll.h>
>> +#include <linux/soundwire/sdw_amd.h>
>>  
>>  #include "acp63.h"
>>  
>> @@ -119,12 +121,70 @@ static irqreturn_t acp63_irq_handler(int irq, void *dev_id)
>>  	return IRQ_NONE;
>>  }
>>  
>> -static void get_acp63_device_config(u32 config, struct pci_dev *pci,
>> -				    struct acp63_dev_data *acp_data)
>> +static int sdw_amd_scan_controller(struct device *dev)
>> +{
>> +	struct acp63_dev_data *acp_data;
>> +	struct fwnode_handle *link;
>> +	char name[32];
>> +	u32 sdw_manager_bitmap;
>> +	u8 count = 0;
>> +	u32 acp_sdw_power_mode = 0;
>> +	int index;
>> +	int ret;
>> +
>> +	acp_data = dev_get_drvdata(dev);
>> +	acp_data->acp_reset = true;
>> +	/* Found controller, find links supported */
>> +	ret = fwnode_property_read_u32_array((acp_data->sdw_fw_node), "mipi-sdw-manager-list",
>> +					     &sdw_manager_bitmap, 1);
>> +
>> +	if (ret) {
>> +		dev_err(dev, "Failed to read mipi-sdw-manager-list: %d\n", ret);
>> +		return -EINVAL;
>> +	}
>> +	count = hweight32(sdw_manager_bitmap);
>> +	/* Check count is within bounds */
>> +	if (count > AMD_SDW_MAX_MANAGERS) {
>> +		dev_err(dev, "Manager count %d exceeds max %d\n", count, AMD_SDW_MAX_MANAGERS);
>> +		return -EINVAL;
>> +	}
>> +
>> +	if (!count) {
>> +		dev_dbg(dev, "No SoundWire Managers detected\n");
>> +		return -EINVAL;
>> +	}
>> +	dev_dbg(dev, "ACPI reports %d Soundwire Manager devices\n", count);
>> +	acp_data->sdw_manager_count = count;
>> +	for (index = 0; index < count; index++) {
>> +		snprintf(name, sizeof(name), "mipi-sdw-link-%d-subproperties", index);
>> +		link = fwnode_get_named_child_node(acp_data->sdw_fw_node, name);
>> +		if (!link) {
>> +			dev_err(dev, "Manager node %s not found\n", name);
>> +			return -EIO;
>> +		}
>> +
>> +		fwnode_property_read_u32(link, "amd-sdw-power-mode",
>> +					 &acp_sdw_power_mode);
>> +		/*
>> +		 * when soundwire configuration is selected from acp pin config,
>> +		 * based on manager instances count, acp init/de-init sequence should be
>> +		 * executed as part of PM ops only when Bus reset is applied for the active
>> +		 * soundwire manager instances.
> try to be consistent and use the MIPI spelling in comments: "SoundWire".
Will fix it.
>
>> +		 */
>> +		if (acp_sdw_power_mode != AMD_SDW_POWER_OFF_MODE)
>> +			acp_data->acp_reset = false;
>> +	}
>> +	return 0;
>> +}
>> +
>> +static int get_acp63_device_config(u32 config, struct pci_dev *pci, struct acp63_dev_data *acp_data)
>>  {
>>  	struct acpi_device *dmic_dev;
>> +	struct acpi_device *sdw_dev;
>>  	const union acpi_object *obj;
>>  	bool is_dmic_dev = false;
>> +	bool is_sdw_dev = false;
>> +	int ret;
>>  
>>  	dmic_dev = acpi_find_child_device(ACPI_COMPANION(&pci->dev), ACP63_DMIC_ADDR, 0);
>>  	if (dmic_dev) {
>> @@ -134,22 +194,83 @@ static void get_acp63_device_config(u32 config, struct pci_dev *pci,
>>  			is_dmic_dev = true;
>>  	}
>>  
>> +	sdw_dev = acpi_find_child_device(ACPI_COMPANION(&pci->dev), ACP63_SDW_ADDR, 0);
>> +	if (sdw_dev) {
>> +		acp_data->sdw_fw_node = acpi_fwnode_handle(sdw_dev);
>> +		ret = sdw_amd_scan_controller(&pci->dev);
>> +		if (!ret)
>> +			is_sdw_dev = true;
>> +	}
>> +
>> +	dev_dbg(&pci->dev, "Audio Mode %d\n", config);
>>  	switch (config) {
>> -	case ACP_CONFIG_0:
>> -	case ACP_CONFIG_1:
>> +	case ACP_CONFIG_4:
>> +	case ACP_CONFIG_5:
>> +	case ACP_CONFIG_10:
>> +	case ACP_CONFIG_11:
>> +		if (is_dmic_dev) {
>> +			acp_data->pdev_mask = ACP63_PDM_DEV_MASK;
>> +			acp_data->pdev_count = ACP63_PDM_MODE_DEVS;
>> +		}
>> +		break;
>>  	case ACP_CONFIG_2:
>>  	case ACP_CONFIG_3:
>> -	case ACP_CONFIG_9:
>> -	case ACP_CONFIG_15:
>> -		dev_dbg(&pci->dev, "Audio Mode %d\n", config);
>> +		if (is_sdw_dev) {
>> +			switch (acp_data->sdw_manager_count) {
>> +			case 1:
>> +				acp_data->pdev_mask = ACP63_SDW_DEV_MASK;
>> +				acp_data->pdev_count = ACP63_SDW0_MODE_DEVS;
>> +				break;
>> +			case 2:
>> +				acp_data->pdev_mask = ACP63_SDW_DEV_MASK;
>> +				acp_data->pdev_count = ACP63_SDW0_SDW1_MODE_DEVS;
>> +				break;
>> +			default:
>> +				return -EINVAL;
>> +			}
>> +		}
>>  		break;
>> -	default:
>> -		if (is_dmic_dev) {
>> +	case ACP_CONFIG_6:
>> +	case ACP_CONFIG_7:
>> +	case ACP_CONFIG_12:
>> +	case ACP_CONFIG_8:
>> +	case ACP_CONFIG_13:
>> +	case ACP_CONFIG_14:
>> +		if (is_dmic_dev && is_sdw_dev) {
>> +			switch (acp_data->sdw_manager_count) {
>> +			case 1:
>> +				acp_data->pdev_mask = ACP63_SDW_PDM_DEV_MASK;
>> +				acp_data->pdev_count = ACP63_SDW0_PDM_MODE_DEVS;
>> +				break;
>> +			case 2:
>> +				acp_data->pdev_mask = ACP63_SDW_PDM_DEV_MASK;
>> +				acp_data->pdev_count = ACP63_SDW0_SDW1_PDM_MODE_DEVS;
>> +				break;
>> +			default:
>> +				return -EINVAL;
>> +			}
>> +		} else if (is_dmic_dev) {
>>  			acp_data->pdev_mask = ACP63_PDM_DEV_MASK;
>>  			acp_data->pdev_count = ACP63_PDM_MODE_DEVS;
>> +		} else if (is_sdw_dev) {
>> +			switch (acp_data->sdw_manager_count) {
>> +			case 1:
>> +				acp_data->pdev_mask = ACP63_SDW_DEV_MASK;
>> +				acp_data->pdev_count = ACP63_SDW0_MODE_DEVS;
>> +				break;
>> +			case 2:
>> +				acp_data->pdev_mask = ACP63_SDW_DEV_MASK;
>> +				acp_data->pdev_count = ACP63_SDW0_SDW1_MODE_DEVS;
>> +				break;
>> +			default:
>> +				return -EINVAL;
>> +			}
>>  		}
>>  		break;
>> +	default:
>> +		break;
> it really wouldn't hurt to have a high-level description of this series
> of switch/ifs/else, it's very hard to review.

Based on ACP PIN Config, "is_dmic_dev" , "is_sdw_dev" flags ACP PCI driver will create platform device nodes.
pdev_mask value to know what combination of platform devices need to be created and
pdev_count refers to total number of platform device nodes to be created.

We will add comments.

>
>>  	}
>> +	return 0;
>>  }
>>  
>>  static void acp63_fill_platform_dev_info(struct platform_device_info *pdevinfo,
>> @@ -173,6 +294,7 @@ static void acp63_fill_platform_dev_info(struct platform_device_info *pdevinfo,
>>  
>>  static int create_acp63_platform_devs(struct pci_dev *pci, struct acp63_dev_data *adata, u32 addr)
>>  {
>> +	struct acp_sdw_pdata *sdw_pdata;
>>  	struct platform_device_info pdevinfo[ACP63_DEVS];
>>  	struct device *parent;
>>  	int index;
>> @@ -205,8 +327,110 @@ static int create_acp63_platform_devs(struct pci_dev *pci, struct acp63_dev_data
>>  		acp63_fill_platform_dev_info(&pdevinfo[2], parent, NULL, "acp_ps_mach",
>>  					     0, NULL, 0, NULL, 0);
>>  		break;
>> +	case ACP63_SDW_DEV_MASK:
>> +		if (adata->pdev_count == ACP63_SDW0_MODE_DEVS) {
>> +			sdw_pdata = devm_kzalloc(&pci->dev, sizeof(struct acp_sdw_pdata),
>> +						 GFP_KERNEL);
>> +			if (!sdw_pdata) {
>> +				ret = -ENOMEM;
>> +				goto de_init;
>> +			}
>> +
>> +			sdw_pdata->instance = 0;
>> +			sdw_pdata->acp_sdw_lock = &adata->acp_lock;
>> +			adata->sdw0_dev_index = 0;
>> +			adata->sdw_dma_dev_index = 1;
>> +			acp63_fill_platform_dev_info(&pdevinfo[0], parent, adata->sdw_fw_node,
>> +						     "amd_sdw_manager", 0, adata->res, 1,
>> +						     sdw_pdata, sizeof(struct acp_sdw_pdata));
>> +			acp63_fill_platform_dev_info(&pdevinfo[1], parent, NULL, "amd_ps_sdw_dma",
>> +						     0, adata->res, 1, &adata->acp_lock,
>> +						     sizeof(adata->acp_lock));
>> +		} else if (adata->pdev_count == ACP63_SDW0_SDW1_MODE_DEVS) {
>> +			sdw_pdata = devm_kzalloc(&pci->dev, sizeof(struct acp_sdw_pdata) * 2,
>> +						 GFP_KERNEL);
>> +			if (!sdw_pdata) {
>> +				ret = -ENOMEM;
>> +				goto de_init;
>> +			}
>> +
>> +			sdw_pdata[0].instance = 0;
>> +			sdw_pdata[1].instance = 1;
>> +			sdw_pdata[0].acp_sdw_lock = &adata->acp_lock;
>> +			sdw_pdata[1].acp_sdw_lock = &adata->acp_lock;
>> +			sdw_pdata->acp_sdw_lock = &adata->acp_lock;
>> +			adata->sdw0_dev_index = 0;
>> +			adata->sdw1_dev_index = 1;
>> +			adata->sdw_dma_dev_index = 2;
>> +			acp63_fill_platform_dev_info(&pdevinfo[0], parent, adata->sdw_fw_node,
>> +						     "amd_sdw_manager", 0, adata->res, 1,
>> +						     &sdw_pdata[0], sizeof(struct acp_sdw_pdata));
>> +			acp63_fill_platform_dev_info(&pdevinfo[1], parent, adata->sdw_fw_node,
>> +						     "amd_sdw_manager", 1, adata->res, 1,
>> +						     &sdw_pdata[1], sizeof(struct acp_sdw_pdata));
>> +			acp63_fill_platform_dev_info(&pdevinfo[2], parent, NULL, "amd_ps_sdw_dma",
>> +						     0, adata->res, 1, &adata->acp_lock,
>> +						     sizeof(adata->acp_lock));
>> +		}
>> +		break;
>> +	case ACP63_SDW_PDM_DEV_MASK:
>> +		if (adata->pdev_count == ACP63_SDW0_PDM_MODE_DEVS) {
>> +			sdw_pdata = devm_kzalloc(&pci->dev, sizeof(struct acp_sdw_pdata),
>> +						 GFP_KERNEL);
>> +			if (!sdw_pdata) {
>> +				ret = -ENOMEM;
>> +				goto de_init;
>> +			}
>> +
>> +			sdw_pdata->instance = 0;
>> +			sdw_pdata->acp_sdw_lock = &adata->acp_lock;
>> +			adata->pdm_dev_index = 0;
>> +			adata->sdw0_dev_index = 1;
>> +			adata->sdw_dma_dev_index = 2;
>> +			acp63_fill_platform_dev_info(&pdevinfo[0], parent, NULL, "acp_ps_pdm_dma",
>> +						     0, adata->res, 1, &adata->acp_lock,
>> +						     sizeof(adata->acp_lock));
>> +			acp63_fill_platform_dev_info(&pdevinfo[1], parent, adata->sdw_fw_node,
>> +						     "amd_sdw_manager", 0, adata->res, 1,
>> +						     sdw_pdata, sizeof(struct acp_sdw_pdata));
>> +			acp63_fill_platform_dev_info(&pdevinfo[2], parent, NULL, "amd_ps_sdw_dma",
>> +						     0, adata->res, 1, &adata->acp_lock,
>> +						     sizeof(adata->acp_lock));
>> +			acp63_fill_platform_dev_info(&pdevinfo[3], parent, NULL, "dmic-codec",
>> +						     0, NULL, 0, NULL, 0);
>> +		} else if (adata->pdev_count == ACP63_SDW0_SDW1_PDM_MODE_DEVS) {
>> +			sdw_pdata = devm_kzalloc(&pci->dev, sizeof(struct acp_sdw_pdata) * 2,
>> +						 GFP_KERNEL);
>> +			if (!sdw_pdata) {
>> +				ret = -ENOMEM;
>> +				goto de_init;
>> +			}
>> +			sdw_pdata[0].instance = 0;
>> +			sdw_pdata[1].instance = 1;
>> +			sdw_pdata[0].acp_sdw_lock = &adata->acp_lock;
>> +			sdw_pdata[1].acp_sdw_lock = &adata->acp_lock;
>> +			adata->pdm_dev_index = 0;
>> +			adata->sdw0_dev_index = 1;
>> +			adata->sdw1_dev_index = 2;
>> +			adata->sdw_dma_dev_index = 3;
>> +			acp63_fill_platform_dev_info(&pdevinfo[0], parent, NULL, "acp_ps_pdm_dma",
>> +						     0, adata->res, 1, &adata->acp_lock,
>> +						     sizeof(adata->acp_lock));
>> +			acp63_fill_platform_dev_info(&pdevinfo[1], parent, adata->sdw_fw_node,
>> +						     "amd_sdw_manager", 0, adata->res, 1,
>> +						     &sdw_pdata[0], sizeof(struct acp_sdw_pdata));
>> +			acp63_fill_platform_dev_info(&pdevinfo[2], parent, adata->sdw_fw_node,
>> +						     "amd_sdw_manager", 1, adata->res, 1,
>> +						     &sdw_pdata[1], sizeof(struct acp_sdw_pdata));
>> +			acp63_fill_platform_dev_info(&pdevinfo[3], parent, NULL, "amd_ps_sdw_dma",
>> +						     0, adata->res, 1, &adata->acp_lock,
>> +						     sizeof(adata->acp_lock));
>> +			acp63_fill_platform_dev_info(&pdevinfo[4], parent, NULL, "dmic-codec",
>> +						     0, NULL, 0, NULL, 0);
>> +		}
>> +		break;
>>  	default:
>> -		dev_dbg(&pci->dev, "No PDM devices found\n");
>> +		dev_dbg(&pci->dev, "No PDM or Soundwire manager devices found\n");
> what does this mean? I find this debug adds more confusion.
Currently, we are trying to create platform devices for PDM controller and SoundWire
Manager instances based on ACP pin config and ACPI _ADDR fields scan under ACP PCI device
scope.
Earlier We have added support for ACP PDM controller.
ACP PIN config supports different audio configurations other than PDM and SoundWire
based audio endpoints.

If there is no pdev_mask set, it refers to default switch case.
This dev_dbg statement to notify that no PDM and Soundwire manager devices found
from ACPI scan.

This patch adds support for platform device creation logic for Soundwire manager instances &
PDM controller combinations based on ACP PIN Config and ACPI _ADDR field scan.

Possible combination of platform device nodes:

1) ACP PDM Controller, dmic-codec, machine driver platform device node
2) ACP PDM Controller , dmic-codec, SW0 manager instance, platform device for SoundWire DMA driver
3) SW0, SW1 SoundWire manager instances, platform device for SoundWire DMA driver
3) ACP PDM Controller, dmic-codec, SDW0, SDW1 manager instances, platform device for SoundWire DMA driver



>
>>  		return 0;
>>  	}
>>  
>> @@ -290,7 +514,11 @@ static int snd_acp63_probe(struct pci_dev *pci,
>>  		goto de_init;
>>  	}
>>  	val = readl(adata->acp63_base + ACP_PIN_CONFIG);
>> -	get_acp63_device_config(val, pci, adata);
>> +	ret = get_acp63_device_config(val, pci, adata);
>> +	if (ret) {
>> +		dev_err(&pci->dev, "get acp device config failed:%d\n", ret);
>> +		goto de_init;
>> +	}
>>  	ret = create_acp63_platform_devs(pci, adata, addr);
>>  	if (ret < 0) {
>>  		dev_err(&pci->dev, "ACP platform devices creation failed\n");

