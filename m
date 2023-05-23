Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9347570D433
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 08:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbjEWGom (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 02:44:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234545AbjEWGoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 02:44:39 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2063.outbound.protection.outlook.com [40.107.94.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CB39192
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 23:44:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lZJ7BY96GvkdGo/tVCDCzA2lDltN38xQBXKY4uno8myXeyTPcwHbmpT0s1fcP1RBacTcTOmNDi1bj37SWZL/s8BVxxkOoilQDzfLdY09wAb1L2xt0BPa1Zp0hquCIISkdMWjPAbSipZiPN9aOPPfXQtxqnyDqmX4WVrs6nt2CQiqWiQrrad7CAPkPAlTIZwlf9bs0EvzOWDkTRJEB+M4zyruwmkjG17ZdL2OSA6nz+O4xaFIph4dqUk5x7RXDG+DiNpjTlB+1o4O7B+5fJOyC0cKSbUKs5L8zsBiN94fvSbfb/RpRXlSe34Uj1HDzpmSQwQPmFsEB4ZOOciQzt9VAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8mJwuLxt2cBbTG5UTSqkeOUAizpinSqXxzGrGQJUhoo=;
 b=mMS/FmY6J0q15AyLqLIUEQ1YbHV3Kz8Ao5lMQ3U7iw0vpyjnjWuc1iYwJwM/cXY8iYkOVvIouE0mpzUBr6Dy4VRjV1BU1uAlYfb2+hZTc24f8uoaAXo8wyLYVFbYMRzwuyxl4gbU/o2MfnqHlFGdLKcuMaacMB0psBOdabcuuOtBkNtG7W9BN36G+zvNQMYpH0K9wFtHHcB4bv0Y5O9AxCMA5Hb4euDhmvJuT7FbKdr1upCQOPQySn9CDAu5l1jStWUdh8px+xl8nJK4H7sWHPWpdKBpV/jNGA2PeITmz0ukWVbmMW4b5sqedVdI/QxUaTkoYeSohiHcjEDoA+/UZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8mJwuLxt2cBbTG5UTSqkeOUAizpinSqXxzGrGQJUhoo=;
 b=t+z1T/9RL1W6WdzvIjET4PECggGOcjmZzBb3QGsBIQDPzD1Z8g4aJPc5PwiBTuBBIaTdgkUOplwp/gllGkeVlO0XmFj4sqt+HfcqViuJBnH9Pt0J5bwKLFSEOkqgw+yN6bSRPvhdhkKFSBgc5O34GX5RzqzuOe4WOclWxsBBVBU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4123.namprd12.prod.outlook.com (2603:10b6:5:21f::23)
 by CH2PR12MB4200.namprd12.prod.outlook.com (2603:10b6:610:ac::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Tue, 23 May
 2023 06:44:03 +0000
Received: from DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::7c50:6c99:76d:f952]) by DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::7c50:6c99:76d:f952%7]) with mapi id 15.20.6411.028; Tue, 23 May 2023
 06:44:03 +0000
Message-ID: <2e8d3af4-7d54-becf-1084-c9b07a3436d0@amd.com>
Date:   Tue, 23 May 2023 12:19:01 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH V2 2/9] ASoC: amd: ps: handle SoundWire interrupts in acp
 pci driver
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
 <20230522133122.166841-3-Vijendar.Mukunda@amd.com>
 <134a2efd-648a-fb4b-4b61-154173b97f04@linux.intel.com>
From:   "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
In-Reply-To: <134a2efd-648a-fb4b-4b61-154173b97f04@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0196.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e9::8) To DM6PR12MB4123.namprd12.prod.outlook.com
 (2603:10b6:5:21f::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4123:EE_|CH2PR12MB4200:EE_
X-MS-Office365-Filtering-Correlation-Id: 53032c70-a838-4793-392f-08db5b5918de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CIYvNQYxANVG+Zk+OlC2Fdv3BN6W030hZWFUl6zAwuDOxzAgUzJsBRPhxJHW7cQjgVtGmJYSDIkg3K54mboUdg27VFI+qml4a0HX7AwOwa3A9zeVY5eb7ugvtPex6SnAdTcE8MHVZomrOvlWHFGfyvK9EMH4uWBX/kS3v6086ftaNHbq6y+Gy/Q8EZ6VVLfCwAfpyKKuyEqV6KimlNZL/DIulV3LmrHWOBksdVPDRZgfHbNJ1gycegoy8vuCaJgjEOUy39Euy4dEPBxjE8vCpgySLSw7oxp6ueBKPkNLmsAZSZIKKkDO2Pwwnr3pTqjleufAd6lZ2GRDowjY+ZcC28uNQQVwvJNKnF0uf2U/BoatVroNvpg9Z/WaTkH1lq7aGyEStB1gqjVo+JWkfjcL5PqwpsOvzr/dKhMJvcBmSx1eeUL0wRuf5CX/b9q+bMv8fRyE0Lu2+WHXyPTgLpkNrWXvL8baD5P+H2Tt+DQtGJa21OvaG/sFAVB3GKM9CbOwPl1HZUFT5MeGzA2LM3xH1v1kPNnCS+5xa4A6IdjUn34dT0igiWWlvubu/PwdS8gm5baA10ghQFoUzvnIV/59HkXx7+3LoXGh+462d6/Ck2YBK1xqKwrJLgVTrnAb0V4Czfr5NeC1Q/fy6FRfSlG/xQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4123.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(136003)(346002)(396003)(376002)(451199021)(6506007)(6512007)(26005)(53546011)(31686004)(6486002)(54906003)(66946007)(66556008)(66476007)(4326008)(478600001)(316002)(41300700001)(8676002)(8936002)(5660300002)(31696002)(86362001)(83380400001)(38100700002)(2906002)(186003)(36756003)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UXFBN2UrbktoZENoWThuN2dmU0RNWmJjZDJCeTV6Tkt0WEUvWGlRcy80WDhG?=
 =?utf-8?B?MWk0bE1uM1kvK1FYWk9TdG0xR2U3RWlIOXRmL0V5L21ZTi9jOVNYT1hOK1RZ?=
 =?utf-8?B?dmxTNVJHa20zQXI1TXhDaFRyMldqa0VkL04vcWltS0VGQ1BBNE9jVXJtVlhD?=
 =?utf-8?B?Zjk5bXM1UTFvcWNLY1paTEYrREY1RVJKUUIrSndoblI3UEdXQzN1V29YOFVO?=
 =?utf-8?B?aGh6ZDd2N2xmNmo2ellab2FBbWxVS0pJZ2p2aXVIcEV3aGRndWNGVDNpRGVU?=
 =?utf-8?B?V3NLaGk0MGlFZEJ2K0dpN2pNMFhFQWFacUdZZU5PUHNSak9IQk51S0FFTEU3?=
 =?utf-8?B?WHhXelB0OTFGamtrd0JaRG0wUnFGQytTNjhKNzA2UDFsU0tvR2w4MFprY3lY?=
 =?utf-8?B?M1k4SVQvM0JpTURWS0ZHZU5ydXprUHpSaUhUUjg3dXBjRzJHVGlKT3B5dmZI?=
 =?utf-8?B?cjIxMEszeG9ENlkzT1AzS05GczBxTFk3MXVXeG1DZzZJUVpWWU1sUmdwVGd5?=
 =?utf-8?B?VXk4VWZvdThXam50eEszbDduQStRelB6cWxJUkQ1SW93VG5RQ2pLV21yaWtE?=
 =?utf-8?B?Q1BmZytwZTEwOGlvbWxxVWw3d2pQWXVMWHA1L1BMZ2NBdDN2d0VFOUlLZWo3?=
 =?utf-8?B?WDh6K3MvZU1TZ3dxeDRVMjdwTjhlbUdHbmM4UFNsTEF6Yy9SYUl3QzMrSnhC?=
 =?utf-8?B?NXNFMGVWWW9iZjZVNE5qWUQveWxramxQdExVSWhOeHlZb0VPaDFEOWFDZDFi?=
 =?utf-8?B?OWlxRTlrVHh5N0FTYXpXbHAvSEt2MUtQVEo3VDNEbzI2MkZiNFVoTlNkcStj?=
 =?utf-8?B?TTBJdUdoVWFvb1pVQ00yOVpiZTRialgrT1c5R3VLdXQ1dHpKRVhnZTdnemQv?=
 =?utf-8?B?YnAvbUxuSUxFTDJpR2hEckQyQ1Z5ek1NV0QveWl3MWkyR2pOb05OQkZHeTcz?=
 =?utf-8?B?bFk4anBDMnhzZG8vaG44WmVqOVBsS2hVdDQyTThiL3ZOQ1ZycWw0UEtQY295?=
 =?utf-8?B?SmM2UGllcDkzbWlhSFY4YWR5Y1ZpbnVJUm0xdzBiTzZwNVBUUVcyZlJpYko3?=
 =?utf-8?B?ZzJDSTBCMk56WUVoOURzMUk3VnJzNEkxbHloM254eG5sOHh6ZkpOSS9mTjV2?=
 =?utf-8?B?SkFYWDRKUFJkTDIyZXJhZU5BWGNOU0xucUhNbHp2QmNoTFdMZXNTd21ZSDFH?=
 =?utf-8?B?Vm5LN1B6SDZhNjJNbVJRUVRGbndXUHI1NGFBSWlLR0ZkU2hjUWtpUURRQVBE?=
 =?utf-8?B?OHlTbGF1ZFZsc3VGTmI4UDY2eDYrRHFmMU9zWWE3dWROdnh2djNCeFA0WktS?=
 =?utf-8?B?clhWWklFYkNid1l0aXc4STJpdm1ackVqS3JzUTU5Rm9NM241MDB4TGh4R0ZP?=
 =?utf-8?B?em1RM0czSE9ZR2hTRGhISFB0ZHhrQnVvSkJrZXJaTmUwaDRZT0JvUmorMEp5?=
 =?utf-8?B?SmpsWHhBQXRzNkt4dTI5ZjJWTDhGS2tMeTR5bVVkZTFFWk12aVliOStLa2dv?=
 =?utf-8?B?OTJZOHAydFFQV0VoMDhneU93MmF3Qk9wMEFGMDN2cVkrQmZCcjhaSjJqK0R5?=
 =?utf-8?B?UmJWZ2pKdXNrY0FObjdRMkxMQ0ViUkdKM1d0SVAxVWJIUG9UOC9LUlplb1h2?=
 =?utf-8?B?UEVCZ0VPUlNDUkJuREJXU1Z0dlFhK0dCQkhhL0dmQkVYbEEyQS9UeTIvd2ox?=
 =?utf-8?B?ZEFTT3k1dDNFdGhvYWJUSkRNd1I4Njh2QjBlMElQZHM1eHcxWVVFSEFUYXo0?=
 =?utf-8?B?NzN6TlV3QzF3STFjblBLVk1aaTdYeFBiTnZ1MlFmeUVEZ2xFRTd4MWJpZUZY?=
 =?utf-8?B?TVBlT0xqbGl0TnFSK1h2T1g0UlpZaEtDRzMrdVJEVjdsVUdvSFBTUDN2azVh?=
 =?utf-8?B?UDE3SFNMZUZoSklZb1krUlh4Rkp2ZjdDaERWWkRHK2tNTGY4NHlrZFBQU3RL?=
 =?utf-8?B?QjdHY3c5cm5PYk1KR3pGV0QvamF5ejJySGoySjc1SlI5ZWNjdlVsek4xVnMv?=
 =?utf-8?B?QUdDSXFPQWZhWEZ0bmtIM1BSVVVESy83Mnd4NmlXckJBMS9hQTZ3MG5lZm10?=
 =?utf-8?B?NFJQNFdpVEg2K1NBbFpOR3VIRzdwdFIwSzlmY2dVcDU3cDdQTmlYT2V0Q2RT?=
 =?utf-8?Q?k70cLvNwVad3DflsxnKWsnRff?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53032c70-a838-4793-392f-08db5b5918de
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4123.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 06:44:03.4674
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: As95lWDrvxpynD4nc1cMrU80vd6qUaxXM6k+Zb8BprNqj5vLzMN5O1dbYYdmWiJDcjHfCpVu6+afgBIUt3l/Zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4200
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

On 22/05/23 21:56, Pierre-Louis Bossart wrote:
>
> On 5/22/23 08:31, Vijendar Mukunda wrote:
>> Handle SoundWire manager related interrupts in ACP PCI driver
>> interrupt handler and schedule SoundWire manager work queue for
>> further processing.
>>
>> Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
>> ---
>>  sound/soc/amd/ps/acp63.h  |  4 ++++
>>  sound/soc/amd/ps/pci-ps.c | 43 ++++++++++++++++++++++++++++++++++-----
>>  2 files changed, 42 insertions(+), 5 deletions(-)
>>
>> diff --git a/sound/soc/amd/ps/acp63.h b/sound/soc/amd/ps/acp63.h
>> index 95bb1cef900a..d296059be4f0 100644
>> --- a/sound/soc/amd/ps/acp63.h
>> +++ b/sound/soc/amd/ps/acp63.h
>> @@ -88,6 +88,10 @@
>>  /* time in ms for acp timeout */
>>  #define ACP_TIMEOUT		500
>>  
>> +#define ACP_SDW0_STAT		BIT(21)
>> +#define ACP_SDW1_STAT		BIT(2)
>> +#define ACP_ERROR_IRQ		BIT(29)
>> +
>>  enum acp_config {
>>  	ACP_CONFIG_0 = 0,
>>  	ACP_CONFIG_1,
>> diff --git a/sound/soc/amd/ps/pci-ps.c b/sound/soc/amd/ps/pci-ps.c
>> index 02caae6968ad..26514e340a33 100644
>> --- a/sound/soc/amd/ps/pci-ps.c
>> +++ b/sound/soc/amd/ps/pci-ps.c
>> @@ -56,6 +56,7 @@ static int acp63_reset(void __iomem *acp_base)
>>  static void acp63_enable_interrupts(void __iomem *acp_base)
>>  {
>>  	writel(1, acp_base + ACP_EXTERNAL_INTR_ENB);
>> +	writel(ACP_ERROR_IRQ, acp_base + ACP_EXTERNAL_INTR_CNTL);
> you may want to comment on why you don't have a read-modify-write
> approach for something that looks generic and not limited to a single
> error bit?
This function will be called when ACP enters D0 state, or during probe
sequence.
ACP reset will be applied which will put all registers to default value.
In this case, ACP_EXTERNAL_INTR_CNTL register default value is zero.
Our intention is to set only ACP error mask in acp external control register.
Rest of the places, IRQ mask programming will use read-modify-write.
>>  }
>>  
>>  static void acp63_disable_interrupts(void __iomem *acp_base)
>> @@ -102,23 +103,55 @@ static irqreturn_t acp63_irq_handler(int irq, void *dev_id)
>>  {
>>  	struct acp63_dev_data *adata;
>>  	struct pdm_dev_data *ps_pdm_data;
>> -	u32 val;
>> +	struct amd_sdw_manager *amd_manager;
>> +	u32 ext_intr_stat, ext_intr_stat1;
>> +	u16 irq_flag = 0;
>>  	u16 pdev_index;
>>  
>>  	adata = dev_id;
>>  	if (!adata)
>>  		return IRQ_NONE;
>> +	ext_intr_stat = readl(adata->acp63_base + ACP_EXTERNAL_INTR_STAT);
>> +	if (ext_intr_stat & ACP_SDW0_STAT) {
>> +		writel(ACP_SDW0_STAT, adata->acp63_base + ACP_EXTERNAL_INTR_STAT);
> [1]
>
> this is confusing, if this is w1c, should this be:
>
> writel(ext_intr_stat, adata->acp63_base + ACP_EXTERNAL_INTR_STAT);
>
> Otherwise you may be clearing fields that have not been set?
As per our register spec, writing zero to register fields doesn't
have any effect. Only writing 1 to register bit will clear that
interrupt.
We are handling bit by bit irq check and clearing the irq mask
based on irq bit and take an action related to that particular irq
bit.


>
>> +		pdev_index = adata->sdw0_dev_index;
>> +		amd_manager = dev_get_drvdata(&adata->pdev[pdev_index]->dev);
>> +		if (amd_manager)
>> +			schedule_work(&amd_manager->amd_sdw_irq_thread);
>> +		irq_flag = 1;
>> +	}
>>  
>> -	val = readl(adata->acp63_base + ACP_EXTERNAL_INTR_STAT);
>> -	if (val & BIT(PDM_DMA_STAT)) {
>> +	ext_intr_stat1 = readl(adata->acp63_base + ACP_EXTERNAL_INTR_STAT1);
>> +	if (ext_intr_stat1 & ACP_SDW1_STAT) {
>> +		writel(ACP_SDW1_STAT, adata->acp63_base + ACP_EXTERNAL_INTR_STAT1);
> same comment here.
>
>> +		pdev_index = adata->sdw1_dev_index;
>> +		amd_manager = dev_get_drvdata(&adata->pdev[pdev_index]->dev);
>> +		if (amd_manager)
>> +			schedule_work(&amd_manager->amd_sdw_irq_thread);
>> +		irq_flag = 1;
>> +	}
>> +
>> +	if (ext_intr_stat & ACP_ERROR_IRQ) {
>> +		writel(ACP_ERROR_IRQ, adata->acp63_base + ACP_EXTERNAL_INTR_STAT);
> [2]
>
> and this is even move confusing because you may end-up writing twice to
> the same adata->acp63_base + ACP_EXTERNAL_INTR_STAT with [1] and [2], so
> the previous write
>
> writel(ACP_SDW0_STAT, adata->acp63_base + ACP_EXTERNAL_INTR_STAT);
>
> may have cleared the register already.
>
> Something looks wrong here?
As mentioned above, writing zero doesn't have any effect.
We are handling bit by bit in irq stat register.
>
>> +		/* TODO: Report SoundWire Manager instance errors */
>> +		writel(0, adata->acp63_base + ACP_SW0_I2S_ERROR_REASON);
>> +		writel(0, adata->acp63_base + ACP_SW1_I2S_ERROR_REASON);
>> +		writel(0, adata->acp63_base + ACP_ERROR_STATUS);
>> +		irq_flag = 1;
>> +	}
>> +
>> +	if (ext_intr_stat & BIT(PDM_DMA_STAT)) {
>>  		pdev_index = adata->pdm_dev_index;
>>  		ps_pdm_data = dev_get_drvdata(&adata->pdev[pdev_index]->dev);
>>  		writel(BIT(PDM_DMA_STAT), adata->acp63_base + ACP_EXTERNAL_INTR_STAT);
>>  		if (ps_pdm_data->capture_stream)
>>  			snd_pcm_period_elapsed(ps_pdm_data->capture_stream);
>> -		return IRQ_HANDLED;
>> +		irq_flag = 1;
>>  	}
>> -	return IRQ_NONE;
>> +	if (irq_flag)
>> +		return IRQ_HANDLED;
>> +	else
>> +		return IRQ_NONE;
>>  }
>>  
>>  static int sdw_amd_scan_controller(struct device *dev)

