Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF7ED62574C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 10:50:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233698AbiKKJuK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 04:50:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233493AbiKKJuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 04:50:08 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 570112A3;
        Fri, 11 Nov 2022 01:50:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j1xEuhy8XwPs45Ftb9iGeEPQoA6eYvAqwNkb5j9lgkSzPx8p5YhKzEN7p857PqNCw1gpFI3WPtnBCALnxWcVacrjf5q2kD3/k0ptHSk+NPJAE2UxX7gvKXR5+D+RdqELR1sf1YFNT4jzmc1AGsWRtHFgcE256rYt8NEvtIZMUyU4PAmDOnPkv9MtZ8DoSp9SwK+38waUgRuAX4d36/8iiz5nEPfFNPbYrrEp3Ki16CMrzULUEdE49ssXRBJ4eS+unnpoBgO8wra+zmzwL3TKq4J57eJqKygnv2So3B5Y7tzQHdRQ4uW2u33lPNLpBNKgWAENKFTenlypW96+LXi0kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mvI2Y0bF2qg32IarGOfBg7tfguky61y84ViXK9qBFrw=;
 b=Kj31PHNnJUVVLu2sUC7hMpqmYjxZetu38cTRRaW4la/oH772aYRdv8xCRYOEa2i6yLJboZ7rQjwiGyJxDqkNegICsLWTp2B7u5USXme11/3nIA1SC1CeXszKZTWe6+r2wJLkchho1/StAktvzP4ok5cQLyrB/h2TJ9Qq4VF0qzTkNEjwr9Q5w/pd/wtChaaljHXMtWDcH9gbXSZepB1xOoTXaCp/YGbyxWKmzYv4YZQrEMwYOq0sxetYzb8ImBxzu5iyay3POs/gnfEEthsk2UQ5092DI4dh2tWGDaxKEi0l2gu5+LZ44Xh5MLjKeLRDBmTJtZzC/9xEiX4W2ntONw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mvI2Y0bF2qg32IarGOfBg7tfguky61y84ViXK9qBFrw=;
 b=E2TrDO2CG4pIdCWFvebP8y830MnJOii9w+7jmUl/EzCOTKMCuSScQNXFpkjZPUZUsQmUEYcVkxvO3OQHNVT8kHPyvXN2T3m8Mem5zX8A9IV+95eqE6enc/aqWjNJrYKkT64s2dbzy94JwJyxBZkl+RaP3k4/LAj8Zf7XMIjpngNnAZgoUGvHSQgx2ULBgNgz/Zl+LlrzflPxxCKie2SMyfnAD+51OGOJuNbjnpYTi82DNeQb9NhxVqSLdk0zretbO2MV2tLIoZk+blB58nEfXIuIivqiniadCC6xEbCBhOTIFSY4G6IQxHPmDL5pCwmYLPOjjXjcOQnGD3jLcBlZKQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Fri, 11 Nov
 2022 09:50:05 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::1912:a3a8:1a8d:a960]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::1912:a3a8:1a8d:a960%4]) with mapi id 15.20.5791.030; Fri, 11 Nov 2022
 09:50:05 +0000
Message-ID: <4fa0b4b4-b2a0-d3ef-b7c5-6c9c90fefebc@nvidia.com>
Date:   Fri, 11 Nov 2022 09:49:58 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 2/5] spi: tegra210-quad: Fix duplicate resource error
Content-Language: en-US
To:     Krishna Yarlagadda <kyarlagadda@nvidia.com>, broonie@kernel.org,
        thierry.reding@gmail.com, linux-spi@vger.kernel.org,
        linux-tegra@vger.kernel.org
Cc:     skomatineni@nvidia.com, ldewangan@nvidia.com,
        linux-kernel@vger.kernel.org
References: <20221001122148.9158-1-kyarlagadda@nvidia.com>
 <20221001122148.9158-2-kyarlagadda@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <20221001122148.9158-2-kyarlagadda@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0254.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8a::26) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|BN9PR12MB5129:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ca40b9d-c11b-4782-ddee-08dac3ca1bec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R+eU76jT4nH5SMnbOFob62p1V77rv2ap5cKW6zmpufVpjI5i3xLiu2TQ7mLFUcYkhaOUvHP/Sjw4DulzjLhuitSbz7pjRnvhqX/thoWPvNECBeysWfykWh1OKdifKsPu+Wh4hlwZarSBKhPGA8HvJh9HSt2H9tw6K+jhSKj2qbGSIfRqQSyFD88fRelC/jScxaKmjLE77WumpFlXO3iJ668RzL6NWmen44xJ+abfwLyseCHHIIJ6XOheoyXXD/4Kc06a/zDeafrXNnyVA6qiReeu+ca4jutu5Q7A77k9yKcaXe6QjoWZ3oybiaiSvJFRu47DLaQKZGJbJYynI4tlxBC6pRFQfoV9rrrp7wnmJ3ez/XyRAqSg2EwcmYmu6k0RGwdtLWRw+he2peRS9ztfRQfTj5BBck9TqgSiaGG06Krqi2FSVwNN3yue8CBriaIuLDN0ri+anE2BkB5x0+s23u+rARqN+71xuEOnlkBBpA+ScIsc9pfxtCGYv+yQaExYE6ii2u6+oDD7IkYCyMPQlKwJqcZcDTcZryqjE9SDDMM7+kvx3hfrWSo/qSCqAdKOo2cJYyeKP80ELtLkDnrPxkrF3zcwvsJ0n0Nqhy7ZXmTBQJGA1yd4YL99xAcvbfLh/iPP/fGDfiYACLk6Zy+RZadkIMXpZEqb7Sn5DSmpsDOFMmgF0WxiD3ZS6pn7P0OfAfwbltyNrTu1KmvXkGkWrvzGfZrK/N3c2R4Uh6tmhrDT+GyiCz6fDz8Mw2Wzoa6OVmoJRUvtJMo/fRY0Ia8CdDAHPUBIPNLSDEsGy+m0p/o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(346002)(366004)(376002)(396003)(451199015)(5660300002)(8936002)(2616005)(31696002)(41300700001)(86362001)(38100700002)(2906002)(186003)(36756003)(83380400001)(31686004)(6486002)(478600001)(53546011)(316002)(6506007)(6512007)(4326008)(66476007)(66946007)(8676002)(66556008)(6666004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VE5yeE1ORE43SFI5RFU0M0xMN1RUazRyb2cwZ21uYXpGaldkSGd0NDdqdWJj?=
 =?utf-8?B?YjR6cXAzZDQ3SERqdmFmek5sdXk2VUtOOUwvaG1lS2JoM3Z2YnpwSkc0bTJ6?=
 =?utf-8?B?ZzhWbXFvdExYUGJzNngyWjlXamEzN0xQa0lWTiswZVhId1h0MEUyT3FGMTFB?=
 =?utf-8?B?aWI2L3VsWGtJTVV6L0NqSC9xNUUvZlhENDdPMjBnZlBpcmFpR1o0VHZ6Smcz?=
 =?utf-8?B?Qk90YWtjRXlTSGp2cElaSDNrQkVZMEJaZUF3Tjg4d3FyY0lBVndJYmxwTWRo?=
 =?utf-8?B?Sml5OHlkdDQrVDBmejc0VG9Oa2luQkhDYVZpbTRaOVg5citaaEpBZkd4aTZv?=
 =?utf-8?B?VnB5aU42Z1dCcExVdUpOTUVGdVBiVWhWeEhuN29va3BEVnl0VEZYSGF2Q0ZH?=
 =?utf-8?B?dzlaQ2pLTVlpWEd0WU85bXZGRTBLZ2F1ZWVESktjQ3lvbnJ4YUNPQmpBb0xh?=
 =?utf-8?B?RXZqWmRGY2J3UXhSVDI2U0FmYkdvTFpVdWx0RDdoMFNNK2pVRUVoaS9SOExx?=
 =?utf-8?B?bDdQMUdzUXRxR0FCTUEvQVBONFN5L3NFeEcyZUVsMFNZeXQ0UEFPenBwdFVY?=
 =?utf-8?B?Z0VadnRVdHdXTklHeEJ0T3RWV01tWGlENTNjY2pFNEIwM3JCZHZ5ZWhXVmdO?=
 =?utf-8?B?NCtqZ1JaVFI3b2hYeGJWNjVLcnNYVlROUkdjMFFDV1dqVFIwaWhNb1lpVWpQ?=
 =?utf-8?B?c0VLWTNYdE5YVXFOWm5rUG02alRxaFgxdlZNR1ZzM21xTVVLMjYrQTF6S212?=
 =?utf-8?B?TGRwNWFyOTFaK0JLN3lDY2xReTJOSzh5L2xXZ2l3ZmtVRERvK1kyNGJ4emw3?=
 =?utf-8?B?dzFNajNDaUpPYWM4NkJ5blV2MFNjY2pHWWlaYnlHcEZVNGFCMGR6OHlRdlp6?=
 =?utf-8?B?dzBOeDV2TjNGaGJZVnBlWmdYb2lmR29LbnhXcVZ5M05WeVdaemlIczZ2emRD?=
 =?utf-8?B?dEYvQi9rVDZxR2ZnOWlnblErWFhsYUtHM3orMzlDZStWVnhNdUQzQW9rY1VB?=
 =?utf-8?B?K3JvdDBjVkMwOXZySmRWYVRRVUpOckZvb1BFSDh0b3NQR2JjK0gxcFlEdGty?=
 =?utf-8?B?MmFVNjMxQkxiRFdjeWNmZ1BjY1IrNjNXcHJ5OEY2NnVvWjVGRjlyYUdONXdC?=
 =?utf-8?B?TFY3cTFMdk1YSnRsSTBIM2dBZ05SREdNeVV2bWVYVVlVY3czSFVnb0w5L1ZX?=
 =?utf-8?B?cFI4cWNiT2V0SHJnUkd4T1o1dEQyak91cElIK0NpRXl1ZXY2VWUzODBUVGRx?=
 =?utf-8?B?WG1JbE5wajg5RTZxNEk2T2xwZUJLc3dkK2k5YmtoOHl0ZDhYN1FzL1ZGaHBZ?=
 =?utf-8?B?RUZMY0dMcUtJanhOSkNLKzRBT1FaTVplc1ExQW5zNTRhSXFDRm1JemRTdW40?=
 =?utf-8?B?MlkrL3JMUXh4bmxxUmhJQXVYZ0E2M1VodGpUUm5IY2FnMzBKSlkzckwzYmpt?=
 =?utf-8?B?TWNJY2p2WXhzcTUvZzdlaURiRlN1WWQ1djdCVDhXTkVuSE1reTlMUEhMNmw4?=
 =?utf-8?B?bmZSWklCa2dSbzFNOHNudmRQRTdNam9OSDhwWnE5V25KQzd0OXNHUUVLOUZk?=
 =?utf-8?B?NWhMWGFBMmlERXQzQy95czdkUjk5cDhoa05zUDRraktPUW1pTVQza3l6UlhR?=
 =?utf-8?B?OVRBNWlZaE96UUZNb0l4ZnlvR2ViT1lXazRnemtOMjBObVN3eTdMa0JnT2xn?=
 =?utf-8?B?My91eE80d3d1NkQ5aHRKNkVpK1c2SVdLMG5xbmZ0MFBTNy8wempIeUM3Njgv?=
 =?utf-8?B?VzlUZ0lEcFp4VXlhNlcrUXU2RWZDa3dzaUNTS29DcEtubmhBbjAxU1ovOU82?=
 =?utf-8?B?Z3BxT2oycytsSm9VS1pWYTZNVlowZWFPeEUxaExoaThkVytVZnNEWTk2U2hu?=
 =?utf-8?B?MnFBa2ZvL2tiL1BZanVEUVRvRUM1bi9Tb2kxYStmS0hkRnEzeUgxRkFRZFpR?=
 =?utf-8?B?UXEwMW95cHhkek1vQjVqam1xeXU2ckMya041OThlSVFRYTB3R09seGQyUGho?=
 =?utf-8?B?QzVUbHcxQjRjTGZUVXJ0ZTl2S0xIUUdud2dqaUdyQm9MNGhQQjNCWFVUQ0JL?=
 =?utf-8?B?aUs1OGpTVVFMVU05d0lZazZZTzM2UVcrNzZsZXZDMVF6eWhuWWdhbTdsT0xk?=
 =?utf-8?B?VnphS09vV2VIY3N2Q2lTY0VlTWhDZ2pXdmJzMlNnRG9wV0F1K2pneXBMcS9C?=
 =?utf-8?B?NS9la0tYK0wwOUVieXVFMzZiQW1NMlFtd1JkSFNFRko2NjI0NFB5OHJ6TUJq?=
 =?utf-8?B?L2FGczBLcWh0dlF5OUxWMkVHQjJBPT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ca40b9d-c11b-4782-ddee-08dac3ca1bec
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2022 09:50:04.8789
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RWZEZmH2KoPnAPivgDmg10vLSnFU9MAcJRdtxc++q2d9KuFxwSwS3I2v7f/gop28Nut6/u1+DWrEDs6wcJMXzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5129
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 01/10/2022 13:21, Krishna Yarlagadda wrote:
> controller data alloc is done with client device data causing duplicate
> resource error. Allocate memory using controller device when using devm
> 
> Signed-off-by: Krishna Yarlagadda <kyarlagadda@nvidia.com>
> ---
>   drivers/spi/spi-tegra210-quad.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-tegra210-quad.c b/drivers/spi/spi-tegra210-quad.c
> index 904972606bd4..06bf19d0cfc1 100644
> --- a/drivers/spi/spi-tegra210-quad.c
> +++ b/drivers/spi/spi-tegra210-quad.c
> @@ -918,8 +918,9 @@ static int tegra_qspi_start_transfer_one(struct spi_device *spi,
>   static struct tegra_qspi_client_data *tegra_qspi_parse_cdata_dt(struct spi_device *spi)
>   {
>   	struct tegra_qspi_client_data *cdata;
> +	struct tegra_qspi *tqspi = spi_master_get_devdata(spi->master);
>   
> -	cdata = devm_kzalloc(&spi->dev, sizeof(*cdata), GFP_KERNEL);
> +	cdata = devm_kzalloc(tqspi->dev, sizeof(*cdata), GFP_KERNEL);
>   	if (!cdata)
>   		return NULL;
>   


This fixes the following error I have been observing ...

  CRIT KERN spi spi0.0: Resources present before probing

Krishna, can you resend this with the following fixes tag?

Fixes: f89d2cc3967a ("spi: tegra210-quad: use devm call for cdata memory")

May be worth sending this separately from the reset of the series if 
that still needs work. Also, it could be worth indicating that this 
fixes the above error that we are observing and that the wrong device 
was being used for devm. Otherwise ...

Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon

-- 
nvpublic
