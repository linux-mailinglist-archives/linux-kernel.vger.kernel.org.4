Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A4EA70D511
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 09:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235606AbjEWHdY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 03:33:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235502AbjEWHcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 03:32:53 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on20624.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5a::624])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF5F196
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 00:32:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ie6I188o0IqWK/Ae+JMNpe1u8zXqGGktrU3OtgJHHmF77xnCeDYYpOB/YcOx70iVq0S64i4YtnK1cBJD8z8EXJLcgKajtzlgiAKeRkqokwB8oMTz4gzR187cEApRG9ArWlASV6l3FUNrZwJYiZZVAIQDHD2oMg8d/yvWHEw96a/fibhcj6tXjTg8+WJ47vf8exmudblXLOwWwOAaJTo0QqIKGhGrPQZuKA5AwauBauOW0umsxYixAVgR+YLp4pdlba2dH/vaequNVwpA381Y17bpyC9nAHFWGPxdKCTQZWt5FknzJ/e/Cvfu1ekK9OtY4/AKW/luu6R4SVEOwnLJSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bWaYzCvZ4TCdv+bfI+ekVDIDQhIJ5QNTtAK6cm16YQM=;
 b=KfJo8ZGz9bR+iDnRYq/5dLMnc9C+93pEV1Oihym+5FGETh6TXreZ9VdzW6K88DwJ92HAIk/XtK6Lnzq/+fjh7Hb1pBTgk57OlUOiORE4yZ94/E0fwQrZU1gGfMjrpOZ111OhBaujBu2v7ZDlwEBp3LnMU4jJB+ylNEoz8gPyRrVMyRUgCV6zbNPT2Z/EclAmwlW65n2xeu6f0Eo34KG4g0SZYey7b5NiFwnQ8skw1XoYpS1duEJ/89/bwmmhvgJVPizYO/cWDV0ELVJo9O4/ERJyGhdrEu8vIOTFFBUCddY56grezpC5RDSXaX36spsIg8ylzKFx8if9D4DC4+NnPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bWaYzCvZ4TCdv+bfI+ekVDIDQhIJ5QNTtAK6cm16YQM=;
 b=DvgKQsBtWuAT3wdT12FxqqPgo9yTvNAJAXqghepnzlWb39FV2jfG0RAxq3dO+eFrGUzQ3h+XbcN3HCXi4FNZakA39Uxck2XaLefUYx+awoxUwUGznm2CPXZq1fduz/O1Zq8xkKVTLD52B1Yshydj/JvfxvEVDeW22AsbG224B1A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4123.namprd12.prod.outlook.com (2603:10b6:5:21f::23)
 by DM6PR12MB4944.namprd12.prod.outlook.com (2603:10b6:5:1ba::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Tue, 23 May
 2023 07:32:00 +0000
Received: from DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::7c50:6c99:76d:f952]) by DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::7c50:6c99:76d:f952%7]) with mapi id 15.20.6411.028; Tue, 23 May 2023
 07:32:00 +0000
Message-ID: <2dfeee7c-32bd-c054-22ff-3a2266e62c90@amd.com>
Date:   Tue, 23 May 2023 13:06:59 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH V2 5/9] ASoC: amd: ps: add support for SoundWire DMA
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
References: <20230522133122.166841-1-Vijendar.Mukunda@amd.com>
 <20230522133122.166841-6-Vijendar.Mukunda@amd.com>
 <fea3c862-1470-7911-ff77-5d945b1d77cf@linux.intel.com>
From:   "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
In-Reply-To: <fea3c862-1470-7911-ff77-5d945b1d77cf@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0216.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:ea::14) To DM6PR12MB4123.namprd12.prod.outlook.com
 (2603:10b6:5:21f::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4123:EE_|DM6PR12MB4944:EE_
X-MS-Office365-Filtering-Correlation-Id: 778a200b-d8ad-4df0-65f6-08db5b5fcb6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e9OwTc9KxwvqBq7hSym1aVFUUqbRNS5fFHNELVlymYJCeG+RNEOFr12hPBh7v41HNZ5cVfPAkDfyRzd0y+fGhLtUU9sOju68yQEiuiBRqP5rLxYTTNKNNgbR1TdGj4GM8juZkuWeYOSkpPE0YH2mfVK2A6p0Y0yHa7czQxhqLpLfivMY6Lb/c0jlbTZTjNRmAhWcL64UNXI++Fijv6DLcNS5XGx6KBwjuU+KCeQRbMP2d5ErGmZQzNLoKtVzU1ALiGLSN4wwLumA+JPZi0QE84JIqed7Qu9LVOMimU3el7qdRZF7gl4ZXhmiant1jwkeOPR0jTVm4eBRT9MCywOM/o8MKauIhR9vZzJMziyK8XgrijiAps4j+XgAKXXjGmzrSCZd5CLbbQrnIv/sGOc8TVk/MKM7vHMCg8TuO8USwEuE1jx5Cx055BDu6b4iLfMi2ZUDnNKZdhztr5/C+FVi0bjb6NcMMzsIlQTqFMwJcMMZ01nCFIvvCHw2aoNeXAoBhqN2DcpYzSF/1yv0+zeMiw+7YA9+XQem5miOwOC6FvtdZo1/es1bTED0AT+Z27guf7RNBBuB3FQbTGiuBxr8JS4g4KwTZDUfHGjtMA36DZvi/thPltRgkB/tqNOGKWnNBTvIZjPr4hkvqnPXC5qOiQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4123.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(396003)(366004)(346002)(136003)(451199021)(41300700001)(66556008)(66476007)(66946007)(2906002)(186003)(478600001)(26005)(6486002)(4326008)(316002)(31686004)(5660300002)(54906003)(6512007)(8936002)(8676002)(53546011)(36756003)(2616005)(6506007)(83380400001)(86362001)(31696002)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S3pacEdmcGRiOVVGM0U5aWdTS3c0a3JnczVmSlppeTQvdDJKTFpzQXB4UDJk?=
 =?utf-8?B?ZmJQQ3dCQVlkaWdBd0lBQXlCVDQvcDlVVnFiM0o3RU91WEZPRFZJNXZDMk5u?=
 =?utf-8?B?MDF3eUM3dVNDaTZxc1hmMUI4WUI5NWJOUzdNT3VZWXJkUERpZ0U0WHBBT0Jj?=
 =?utf-8?B?blVCOHJSM1NTZVpROVYwU0ZZNTdMRlRpVmRJeU1BQk5tS2hTODJqWEhtdzdj?=
 =?utf-8?B?NXVYY0k1VEVKbWV3aW5UaHo5cUx0RnlPOEtNS3FYUG1MdTdmeTBYRHU1WVc2?=
 =?utf-8?B?UktyakhGTDg3dEdIYUMzTEhmZ0x0N3hwNzZtbUNVVEdjTmFNanM2K3grbERR?=
 =?utf-8?B?MzVMczFlMHFlREc0ZWJOc1JodXNwVkdlWTlkUU9TS1hJMEppOGxKQno5ZEtK?=
 =?utf-8?B?QWVnYnJrNzRnV0JlMWwxbUllOGIrZFZucVlMRUE3a1lIbEJmaUprWFF5b2ll?=
 =?utf-8?B?TllnakRYSVJjU2hUZm54NEJqNVlMUUR1VlB4cFU3SDB2a3FRS1ZmRmdreThR?=
 =?utf-8?B?NmZvNzQyKzAzZUoxSDd0eTFjbXQ0dllBVmh2RTRjREhwREZQUmplVDVSa0E3?=
 =?utf-8?B?RDNjNUgyaXQvWitaYUFXMFVwNXR3WWdXWC9ySXVUS1djenRqUGVqWXE5RThD?=
 =?utf-8?B?emUwQ3N4SDI1bFU0TTgvUGpQZTl1YjlITG92NFBCQllNODFlQlNYNnc0NjRi?=
 =?utf-8?B?cWFrcngyOVBJWGNrME5GeWs2aXdWci9WRlhUaWozZDhkQUNaV01PYk5ibitH?=
 =?utf-8?B?ZWJwUVZ3a0EveFNoMkk0bXdaZUtIdmM3TVp1bE95MlR3NndFbjN3UEo1cmFl?=
 =?utf-8?B?MEtqazRzSlpmL0dza1B5QnZlaXpKSks3bXh5OEt1YTN1TWJUV0VjSkpiZlkz?=
 =?utf-8?B?bkdOYkFnWmdiaEpGeC80VTk4NmR2UGRNclJIZ0ordlFuY3dzdWhpWElzdmNw?=
 =?utf-8?B?VzJkWm1JYnp0NmJEd2VPVUZod1VsMzVpejRVSlZMR2dQZk0rNXhsOEl6NjBV?=
 =?utf-8?B?aXVXQVE1QUVRRzl5T2NXMmRpcElMNUNSaFg5VGd6ZGZqa2RTT3BRd0JrSkxL?=
 =?utf-8?B?VG9PSTBaR1JEeXZITWJsUmlyNVhScWpCNmtpVU5Kc3RsdHVaSDcyT0lKazMv?=
 =?utf-8?B?YWhGN1lqZmJVdE9lTHJTUllvbUtWV2VMZzJDdytqMnNkTVQyOWRUSFJ0eUl4?=
 =?utf-8?B?cERzdTkvWUFGY2M3eFY0RzdBWkFVeXp4cmEvcUdyZnVFUmxBKzJhTEl2OTl0?=
 =?utf-8?B?eUtCUDNzc1dzbkxlYlZXZnRzN2IrYmkxVGV5emUwLzdWSytzUkkxWHBEVmdE?=
 =?utf-8?B?dFJlL2drdkIwdTVFMExQeWhXbitZd2VpR0JqQ2FYblNFcjFxZThXMDFCbmlP?=
 =?utf-8?B?TjZWSEs1Z3llQ1JCSTM3ZDc4d2RzK3NNUkQxT05zWXVIT2IyVGVZYW5NMVRw?=
 =?utf-8?B?MGIwcjJ2YmNVeUU3YXVQaFAwY2Rta2Foem5ocEE4TDBWaWNlRVdqRm5kcEhl?=
 =?utf-8?B?blAvVjd4YXNUank5THl6RzAxUjNRWm5NNktKUnRBRmhLdDlXdnVRTkVNSFdC?=
 =?utf-8?B?MWRyRmZQQTNZaUlLUmY4YmtXeGNhblNUWkJCbWhJeHBja2ZKWU5TRWtMZzNs?=
 =?utf-8?B?WSs3MFMzZ25MWlgxQ25sU2o0M01TUGl4U21aU2dXbGZKSjRzTjV3dzYzQ3JY?=
 =?utf-8?B?MHpMM3dySEg2dU5WQXR5RXZET0V2aTdFKzNyRDNJR0FsL2lYeXNaRW16ZkRU?=
 =?utf-8?B?R0dVQzc3Z3BwU0thZUZJNC9aWGNIa3FFSVNOdXZvQnFPTFROTlpuT0dEamov?=
 =?utf-8?B?S1gxVThieXdMT1o4emErUG5zTXU0N0JhTWwxSStQZDdLQXVCai9nUkt0SWVK?=
 =?utf-8?B?QncrN3dTTjJmT1NnWmtoRmUrd3N4RlhXR1BFL1l2NEw0WkUvQmNKTmV0bDkr?=
 =?utf-8?B?NW5Ec3JsVHNWV29waW9XaGxTcGtobC9JdWZTWXdrbm5GVGliUmxhN2x2MFJv?=
 =?utf-8?B?YXpRM1lBZVhOWU9OcWFFNE15czJlQ2VOZTd2L0VyS2Rjd2RVWk1GTWJiQUJ0?=
 =?utf-8?B?V1V5UDRwZ2djVG9OemJQaWpLY1RkV1pYWUJIRjNVbnRDQU1FSU5yY3N5RFcx?=
 =?utf-8?Q?CY9pTZEpimHTGDvGKZzhuK4VV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 778a200b-d8ad-4df0-65f6-08db5b5fcb6a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4123.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 07:31:59.7872
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3Xqb1nEIjZf4+kbPMST6mlHfZPARfPHYthrw101W+NnSBQnsQFj93T3I/UMC8bbGmqY79LOzXQId9CZNwgCmrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4944
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/05/23 23:42, Pierre-Louis Bossart wrote:
>
> On 5/22/23 08:31, Vijendar Mukunda wrote:
>> Initialize workqueue for SoundWire DMA interrupts handling.
>> Whenever audio data equal to the SoundWire FIFO watermark level
>> are produced/consumed, interrupt is generated.
>> Acknowledge the interrupt and schedule the workqueue.
> It would help to explain why a work queue is needed is the first place,
> as opposed to handling periods in the interrupt thread.
For SoundWire DAI link, we are setting nonatomic flag to true.
If we return period elapsed from hard irq handler instead of workqueue,
soft lock up is observed during stream closure.

We can use interrupt thread as well. To have a symmetry with
SoundWire manager work queues, we have used workqueue for
DMA interrupts.

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
>> +	for (stream_index = 0; stream_index < ACP63_SDW0_DMA_MAX_STREAMS; stream_index++) {
>> +		if (adata->sdw0_dma_intr_stat[stream_index]) {
>> +			if (sdw_dma_data->sdw0_dma_stream[stream_index])
>> +				snd_pcm_period_elapsed(sdw_dma_data->sdw0_dma_stream[stream_index]);
>> +			adata->sdw0_dma_intr_stat[stream_index] = 0;
>> +		}
>> +	}
>> +	for (stream_index = 0; stream_index < ACP63_SDW1_DMA_MAX_STREAMS; stream_index++) {
>> +		if (adata->sdw1_dma_intr_stat[stream_index]) {
>> +			if (sdw_dma_data->sdw1_dma_stream[stream_index])
>> +				snd_pcm_period_elapsed(sdw_dma_data->sdw1_dma_stream[stream_index]);
>> +			adata->sdw1_dma_intr_stat[stream_index] = 0;
>> +		}
>> +	}
> I am not clear on the benefits of the workqueue which only tests a flag
> that's set ...
In top half, we are checking all stream irq mask and setting
corresponding stream id index in interrupt status array when dma
irq is raised.

Our intention is to handle snd_pcm_period_elapsed in process context.
if the flag is set, call the period elapsed for the substream based on stream
id in work queue.
>
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
>> @@ -148,7 +178,57 @@ static irqreturn_t acp63_irq_handler(int irq, void *dev_id)
>>  			snd_pcm_period_elapsed(ps_pdm_data->capture_stream);
>>  		irq_flag = 1;
>>  	}
>> -	if (irq_flag)
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
> .. here ...
Please refer above comment.
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
> ... and here ...
>
>> +		sdw_dma_irq_flag = 1;
>> +	}
>> +
>> +	/* SDW1 BT TX*/
>> +	if (ext_intr_stat1 & ACP_P1_AUDIO1_TX_THRESHOLD) {
>> +		writel(ACP_P1_AUDIO1_TX_THRESHOLD,
>> +		       adata->acp63_base + ACP_EXTERNAL_INTR_STAT1);
>> +		adata->sdw1_dma_intr_stat[ACP_SDW1_AUDIO1_TX] = 1;
> ... or here ...
>
>> +		sdw_dma_irq_flag = 1;
>> +	}
>> +
>> +	if (sdw_dma_irq_flag)
>> +		schedule_work(&adata->acp_sdw_dma_work);
>> +
>> +	if (irq_flag || sdw_dma_irq_flag)
>>  		return IRQ_HANDLED;
>>  	else
>>  		return IRQ_NONE;

