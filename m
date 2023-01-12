Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55E23667065
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 12:02:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232317AbjALLCJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 06:02:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232167AbjALLAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 06:00:43 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2074.outbound.protection.outlook.com [40.107.93.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FB6032273
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 02:51:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TJt6Yc6zb2AVHrYcT1yUTsWTEJBZvPBDYH9kBgxnwoWyaHqhgKhJe591oPOiYmlK7+2giAhFsyCAvg+LFD+I6z5LzYttzbVFvdMUAFp0FvzV5s6nEEceL2ibFohVakvRJ+9kc8Q6wvfZB42U+gfMwP6wPwlcK0qgr1aJtIPQsG9/uW2Wblnh/YwnzeEZoo56smu8pAFxKiD23VT+0ZF+C215uH8H5cXiyWFK92iocLa81lDavYEmeGXOPqpBSmVGRW3hQYWm7nVqKhzKojcFodUhJ6FIIKSnja3ke8oiG7UXFKRStrsozeQRoPBkgEwOextLsgauBJZqPpFDPfp7pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=291AZmMfY6ipIWU6Yk4FXFPHjAS3Dqu+d2EWCWfXeLE=;
 b=HYXdq7+y+GPGRmSPvFm8t5HJjJAihGEqSK3MKL+4qXUFqyPV0m6ILOFy45t3j+KysM5bI4mbD84a4cKFI9biRTyOtk8eClo8FzAlZqkzUJFZP12OH439IGhqufQzR/Dr7DybVVoRwDEmxIaT3wjnstmEcFVpRF/1n1PNoGng34ZcJmeLrEA3r8BGsW8OKXgWC/x6zIn39FYkfOdFawagbVpbVgt77nZb+IZEMRSijOwK0r+qGtv1N9MoxiN5V5i8cpIhy1wIHWaGhVA2maQlw2Tc9FiTX2WNd9oPonPSGV1++s1XGxZEABsS3tSKevu1VW4Wd9GbsINRhq1e9MuoZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=291AZmMfY6ipIWU6Yk4FXFPHjAS3Dqu+d2EWCWfXeLE=;
 b=uh1vNH5ZhqQ5zqg3I6k+EUHgQGTZOxS+DDPNRZea/H/Ubn/pl8NIDcgzqhzeMnB1kegzn986+Vmn2I1ezeJ3lDdPcXlBWp1WCCkJ5A5t7ABqr/3VBu0Ru5dUfuK7SHHhO7Vv4qlNbhtj6t66CuXq0HlC8/3+VgIs3+J+wpXoZe0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4123.namprd12.prod.outlook.com (2603:10b6:5:21f::23)
 by DS7PR12MB6240.namprd12.prod.outlook.com (2603:10b6:8:94::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Thu, 12 Jan
 2023 10:51:50 +0000
Received: from DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::fc88:7080:445e:6866]) by DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::fc88:7080:445e:6866%5]) with mapi id 15.20.5986.018; Thu, 12 Jan 2023
 10:51:50 +0000
Message-ID: <3ec7726d-b70f-df8b-f6b6-8e876b43a570@amd.com>
Date:   Thu, 12 Jan 2023 16:25:00 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 09/19] ASoC: amd: ps: add support for Soundwire DMA
 interrupts
Content-Language: en-US
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        broonie@kernel.org, vkoul@kernel.org, alsa-devel@alsa-project.org
Cc:     Basavaraj.Hiregoudar@amd.com, Sunil-kumar.Dommati@amd.com,
        Mario.Limonciello@amd.com, Mastan.Katragadda@amd.com,
        arungopal.kondaveeti@amd.com, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        Nathan Chancellor <nathan@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20230111090222.2016499-1-Vijendar.Mukunda@amd.com>
 <20230111090222.2016499-10-Vijendar.Mukunda@amd.com>
 <0d2ccd69-63e3-b8c5-396b-b698110cad14@linux.intel.com>
From:   "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
In-Reply-To: <0d2ccd69-63e3-b8c5-396b-b698110cad14@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN0PR01CA0047.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:49::11) To DM6PR12MB4123.namprd12.prod.outlook.com
 (2603:10b6:5:21f::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4123:EE_|DS7PR12MB6240:EE_
X-MS-Office365-Filtering-Correlation-Id: 58320c71-be57-41ae-233a-08daf48b0264
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IlnqKrmB11Fy+vNNQQ7nfDwrQ5WQfY3XhIUUgaOWTv8bwqt1vVVqVF4bY123kxzg065sT1KnCyuKcc9cdzWtGFqEm3EzF3L0GhxM+A6CnT3su1jr+1kcLVZLyHIVaGovWdmuFTTCx984hEN3jsR6KMXgwIb8ZOxr6K09yUkU7r4FhK8qWS7qB11tzwx38oD2+O771Zjmt9NPvLHVlQ7YURDcLpQx0jV3sEamILW9TcnkUBJaUac3bEP0zkmnf7J5E/HPTOW7avX/UYwzehCsjMYmWhhv9d3TSsBHvHlwtWyTmPClBnPme8rdhhPXfgrXa0OmqciR/DnODB3lXz4Ogj/RX8OLHJxQ5QKuPb2hxSr9tkzRDBxspKfSmSKwvc8L3ltka+xUpDQfUcAn1aAmruGqRVECFw1cEBjfaKrsss+9Gkp0aSE1J0JwAB8ZzxIX9o1g1elJiF0CeeNuEPVKP9aixaIykhHhr0MW7rI6AY2DpUSss9rsmLqCIX1GkaBoo5Tg1hOqV75QDKf0dFjuVK08xkZdPvoVQJM18nN+bt575o//MGjZP/L+qQpLHN+TWCVHG0Gv3kIw1RKpMsOLNvNIhu7WZ4aAlPBqrk5CttN+WgFan4ZmWE+eX///9OK77kPEzBBWFGYs0FSoBIFtH56raFV2JiAV/+eUM4JkzHqbIAikO2R7xiBYlceOnneAz5GWsyyT+TJduARh2pg8JhxAcZuxFi56JLoNONd5S10=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4123.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(376002)(366004)(396003)(346002)(451199015)(316002)(86362001)(26005)(6512007)(5660300002)(186003)(478600001)(6486002)(2616005)(41300700001)(31696002)(66556008)(4326008)(66946007)(54906003)(66476007)(8676002)(36756003)(8936002)(83380400001)(6666004)(53546011)(31686004)(6506007)(38100700002)(2906002)(66899015)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZldBVzFBb0NRb0ZEZGpzbFk5T2lHbXhYdUlsUjBWMW53YlRTUUV4Z0MzdGZa?=
 =?utf-8?B?TU1QRlp4VmxpdjNqamwwUEl3Y3J1WFdFM1RPZU01MmFESy96UmlKOWxzTjY5?=
 =?utf-8?B?MjZrQjZDRFhHYS9iK2VuMm1rUVEwS25pZU93NjBUTW5rWFUrZGRCYjNnOHZn?=
 =?utf-8?B?ZHV4cklsb2tXK0NManVGUEtMdjZXdHhyNDNhUXZWUFlyM0VxWG5wZUZKWmRB?=
 =?utf-8?B?b2lMd21UN3l1QkxXK2todWlEdFBnVXFDYTNsSG9EYm1VS1B0S1RUaGdGTGUv?=
 =?utf-8?B?YkZTR0hEY1ZsaUJKeWdPS3grWFp3M1lWcW9tcEdDRVFBYUdObVgzb1FMRFBP?=
 =?utf-8?B?TDBjWUpPVXY3czVzVkpnSGRDNUp3USsyY0xWVlQxTmE0dVgxcVozS3hMcFhO?=
 =?utf-8?B?L1VrLzdzb0tIc0xkaHV6YVh1elZvdmNGT0lnbGZXREgyY1hEUHVTa2pLNlFq?=
 =?utf-8?B?NE9uK29sd2I4RHRpZjZDSlo0ZGtIemdBSTVUZVhRTHFudDA5TDcxRjZ0SFBH?=
 =?utf-8?B?UVU3eDJ0eDh6YUV4VmlJQXhnSEVreS9oODF5b1VYdmpsdnIwVXk4WHBNTEll?=
 =?utf-8?B?bFJubUt5ckY2VFZKQ0NOeTI2ckg2VGlFcnE0blR4WkRRaktJUlRyb253VXQ3?=
 =?utf-8?B?TjJ6a1d3ckw5RVlXR0tGRGoza2VSR3dSdUh3M0JxQWlBSkd3UWNGd0ZhNmlu?=
 =?utf-8?B?NFYrM1dZOFFqaUliUGpQVkpteU1HYXFoUE1HcjBmYlAydUZqZTJmblNxcmhs?=
 =?utf-8?B?ZTNWOXQyK29rNFQ5Yi92aUJ3UXhsbjF2VXN0eFR3dzhkblVBU1RwK1BWWWFE?=
 =?utf-8?B?VnFJNXlueTNreFJXQmU2WXJzNk9lK08rQ0hKa3BIT2tNcGs5eVBTSUorZmUz?=
 =?utf-8?B?YzRMaWtaOUxncmxCRjMrRFhDZElZNmRTL29XZ01oZnd1Ni9zSXZUU3dYcVNh?=
 =?utf-8?B?b29aWnBCVUFYRWtkcHR0ZE9sODN4S1R3aXpmaTFObWxZb1ZWcmNCRjlmWWh2?=
 =?utf-8?B?MGN2WkIrU0czUUlOWEZaQ1pUTStvSXhzOVBWR1E3L2ZmV0p0Y2t4em5CcjhW?=
 =?utf-8?B?OE1SNGRndHFJQzVnT0dxbURObVgzU2hzR1VZRGpPczMrQ1dJYWY2OUVOUGNi?=
 =?utf-8?B?aFFwcEJGRFp5Z2Y0TXpFS3ljbGl4SGQzekJxaVI0OCswcHZHZXZJdWtYYzVB?=
 =?utf-8?B?NnNRQmZDdy9jV1g3MjhlSXZFbFVIL0pDY3lXT1I0V1VsZ1RxMFlrbFZEOGM0?=
 =?utf-8?B?bmJIMnJLeWdRRFBZZlE2YW85RTBYZXV4Z2tHVnpUNUx1WXhpaktoejVWZVZR?=
 =?utf-8?B?TXRKTkJTT1dRcFYxK1R2VXREYUhzYjdTRjNCUTJHeThQTndybXdERGpqWVdo?=
 =?utf-8?B?OHdGMkdGbnBPTVV4M2FoZXJGZWlVVzR0WU1LREFEYlRCNFBkMHVMOEpCdkpU?=
 =?utf-8?B?ajVDdDdleFVadnZhQzJuNmpTQjhuTkJ4cHFyUVY0cHcrWWNnUjBtclhXcTNo?=
 =?utf-8?B?NXNCRFJDMjZWODNiSDZOZ1NMOHBlc1ZSQllDS3dIaDJqNzlLVDNtang4UWpS?=
 =?utf-8?B?VmJEOGsvZ3V4cXFRaVFJOXRsWUdweU12UHJpRHlMVnZ3K1d1cVAzTkZJK0E2?=
 =?utf-8?B?UStvdU1xZm8wcW55dlkvbWhYNmtCUjRBR0dCUHRNNmdmVDdJYnhDUngxM3p5?=
 =?utf-8?B?THBvMHI5d253cldqWFRBcHYxTWRuS1N0MVQrd2lFRWhzY2NmUFkxY2FXdzZX?=
 =?utf-8?B?RWtRaWs2dkFvUEh5RVJ4dmVvYTRyMDNMVytIa2FzcVlDQmcwUEJwTlRHWC9j?=
 =?utf-8?B?L283ZklVdDFldFY2RVFkZkVwcy9GNTh2TGMwYzV2UXVKVzUwdm5jT0ROcnR5?=
 =?utf-8?B?TmhzZ0dtNXJxR3F6ZlZHZlZXNklTcHI5b0RSK1ZCdHVBNW90NGtrbjNaUmhv?=
 =?utf-8?B?QmFyNVB3TnZpWHhrcXNWQ2p4Yk14YWJLMWtXcnZXSUc0ZUcvU0dQYS9lbmc3?=
 =?utf-8?B?cDRpYSszQ2l4aHhBb2hkcE54a01WZmpNOFc5VlhSUWpCbGxkMGFwazJqMkpF?=
 =?utf-8?B?VldkQ05TdC8zcGkwdDZURXpvWnk5Y1dMb1ltblBBQ0h3b3VXc1V5ZkFmOFda?=
 =?utf-8?Q?oxbZzqQ8dwfHI4gt4oWMnGrHX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58320c71-be57-41ae-233a-08daf48b0264
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4123.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2023 10:51:50.5032
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p+1uORiF5leN4BR91YOJDZqkeiW2BQIv+sDYHyxxFceB23UimSWDWXvrt7Z1sVR2pCalQLqiu8YZJRwZ1yYytg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6240
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/01/23 21:08, Pierre-Louis Bossart wrote:
>
>
>> @@ -167,9 +167,11 @@ struct acp63_dev_data {
>>  	struct platform_device *pdev[ACP63_DEVS];
>>  	struct mutex acp_lock; /* protect shared registers */
>>  	struct fwnode_handle *sdw_fw_node;
>> +	struct work_struct acp_sdw_dma_work;
>>  	u16 pdev_mask;
>>  	u16 pdev_count;
>>  	u16 pdm_dev_index;
>> +	u16 dma_intr_stat[ACP63_SDW_MAX_STREAMS];
> streams and DMAs are different things in SoundWire. You can have a 1:N
> mapping.
>
>>  	u8 sdw_master_count;
>>  	u16 sdw0_dev_index;
>>  	u16 sdw1_dev_index;
>> diff --git a/sound/soc/amd/ps/pci-ps.c b/sound/soc/amd/ps/pci-ps.c
>> index 0fbe5e27f3fb..5b82ee8e3ad8 100644
>> --- a/sound/soc/amd/ps/pci-ps.c
>> +++ b/sound/soc/amd/ps/pci-ps.c
>> @@ -113,14 +113,37 @@ static int acp63_deinit(void __iomem *acp_base, struct device *dev)
>>  	return 0;
>>  }
>>  
>> +static void acp63_sdw_dma_workthread(struct work_struct *work)
>> +{
>> +	struct acp63_dev_data *adata = container_of(work, struct acp63_dev_data,
>> +						    acp_sdw_dma_work);
>> +	struct sdw_dma_dev_data *sdw_dma_data;
>> +	u32 stream_index;
>> +	u16 pdev_index;
>> +
>> +	pdev_index = adata->sdw_dma_dev_index;
>> +	sdw_dma_data = dev_get_drvdata(&adata->pdev[pdev_index]->dev);
>> +
>> +	for (stream_index = 0; stream_index < ACP63_SDW_MAX_STREAMS; stream_index++) {
>> +		if (adata->dma_intr_stat[stream_index]) {
>> +			if (sdw_dma_data->sdw_stream[stream_index])
>> +				snd_pcm_period_elapsed(sdw_dma_data->sdw_stream[stream_index]);
> is there a reason why you do this in a work thread?
>
> IIRC we did this in SOF because of an issue where during an xrun a stop
> IPC would be sent while we were dealing with an IPC.
>
> I don't quite see why it's needed for a DMA?
>
> What am I missing?
Initially, we have used in atomic context. We have seen issues
during stream closure, in interrupt context , handling
period_elapsed causing sleep in atomic context.
To avoid that , we have declared dai_link as non-atomic and
moved period_elapsed code to work queue.
>> +			adata->dma_intr_stat[stream_index] = 0;
>> +		}
>> +	}
>> +}

