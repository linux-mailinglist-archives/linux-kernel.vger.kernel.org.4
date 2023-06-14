Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0D3E72F67E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 09:37:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241009AbjFNHhH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 03:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243251AbjFNHhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 03:37:02 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2073.outbound.protection.outlook.com [40.107.237.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D7121FFC
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 00:36:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KpXr+ckZ1K3v52wILj6502DBj4+TEPIc1fTNfjVMbP31H2Loje55euBvwpeJGZVAPTqBYEA8l+xfRQGFzsLML99JpJZGXvDBuAgTpJjddve+OgC0ZGo6uXhzEjdoMIE18Ap8k+GXwOSyl6bFoPIV4od5GkNhEE8zQwLrEYhdCKn+ph8GXujUIfsSpaxGtOiOUxkTV1gmAziUDnswNbDP2z/JMJpEDB4qDVqBNkZk0npN41edHeg7/zSstIS0jN+RE9PrOotxrqHxQwKhkj4ZNb40cIG49+TLLNGv/TE0iQHHuve5C3BfxCNeFoD6Dpl5lj5P+Uq42zQN760E08HaVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+ApkoeeviJ4GNHwtdE/2ov4+Wql5gv/a9c59MOXaGlg=;
 b=NDtprpKzHi2eaczLSau5YtrMgy4r0lOJSsxOPnelzi8pLQ3obninmrVDwXUlIhO604DK/dFZqHa9PX2fbasvdUAPUWdNieR8MqXADaiDkTnIHQJvHI7T5zFvCwHgi5CfVUOli9ySnb/Bv+607VLA8TGR5IoQCMan62d7BGutHuBx8k29NQ5OSVelqfeHMN7tdicqhxS+VGtt4b0pJtvNQRpY+J1bgrk674G2+2LcmRAC0LErfchEqhyZ1ZvSAM6tJzx2yC7v9osjiob7SeB47277bejTGC9KCkBQRlo085Xj2vEawupqbS2s9BHk+AtB7jqXsLQTrXp1fzRm/goDCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ApkoeeviJ4GNHwtdE/2ov4+Wql5gv/a9c59MOXaGlg=;
 b=eXEzGvUjMn7tn4Bqy8ujNT8G5pgTWozh0UfsdvRQptOQJd4m5EImu9c2ac8FzuDo5FHlyvCGgldMm317BImER+sRJA27tcJMToiy5vBDLCOCHW5HxlaoLfmYCNGYen9aatGr09bqSf1Tjxf1jcqUzHnbJVtOxJbHSUJhE2OamUA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 SN7PR12MB8002.namprd12.prod.outlook.com (2603:10b6:806:34b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.41; Wed, 14 Jun
 2023 07:36:17 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::7cbf:236a:55b:2c99]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::7cbf:236a:55b:2c99%4]) with mapi id 15.20.6477.028; Wed, 14 Jun 2023
 07:36:17 +0000
Message-ID: <cc8cb124-86c8-fceb-a5cc-1b59c5c4a9af@amd.com>
Date:   Wed, 14 Jun 2023 13:06:03 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] iommu/amd: Fix memory leak when domain type checks fail
Content-Language: en-US
To:     Hao Ge <gehao@kylinos.cn>, joro@8bytes.org,
        suravee.suthikulpanit@amd.com, will@kernel.org,
        robin.murphy@arm.com
Cc:     kevin.tian@intel.com, jgg@ziepe.ca, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, gehao618@163.com
References: <20230612021718.82293-1-gehao@kylinos.cn>
From:   Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20230612021718.82293-1-gehao@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0164.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:de::6) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|SN7PR12MB8002:EE_
X-MS-Office365-Filtering-Correlation-Id: d3f16af3-aa9b-4005-78da-08db6caa09a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h0hArIp2cbmZW47EHmkytQ4+XPDVKDw71lUaAd5cSHGRfzOmu8ezF/gJnsU4GaxuXZCGPIHAu59RVcAYPgKtY+UIrouJll+WfBsWS+5oWBKhy0tnDEpCyqr0UIupsbRVedWYydT36UHaDGwgZ5zH3opfcqv5pZcAOLksYIcITI2xOxuBQ2b7X9KK0CvnxXY4LZ8E1w3ZR5fXLeZwMHbYEkI4kxbTO1ulLPR+zE7myXfvVYVrx2IQvmjhMBYwVL4cyP9Z5fmDXul1anp67wHfVBvKnnkw6E1zvkx8J5TMBjiz58a6laXzHovKlFoEro/zTMBiujhXMiWG+8FDHMCLNxOLgM4ZDmoXN8OipotTrSse2OpWtgouxGJBkJgln0NffG5yJ1oyy+wkqBtOfw1poGJO0NEYrAFIQwmMqbu2Xyz7KBCu0NGYD23KdxfxGxEs3wb5TPt/1w9e675+jWcbw9sv07PWwVzj8ne+HrSkwP/TH93nx90Ys6fo8KQdGoaWDUnYed7yhxOIBInYnJwTMePcGnp8Ffhg1SNCifQsC/XjabpyqXko296/4YwjGQ+I5mRdWE9uEY6sGRooB8DUoNxDVgmUvjTk454e9gXdQoEyHvcPWQPvPgjZThRxxXdhI8FnJkF2ZjnV/s91Fk1NEA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(346002)(39860400002)(376002)(136003)(451199021)(6486002)(316002)(966005)(41300700001)(53546011)(2616005)(186003)(26005)(6506007)(44832011)(86362001)(4744005)(2906002)(83380400001)(38100700002)(6512007)(31696002)(36756003)(5660300002)(8676002)(66556008)(66476007)(66946007)(478600001)(8936002)(31686004)(6666004)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MmRhTmFGekdwbWZSVVl4QUVOSGNmMEhPUzV5bGVQSkROTlZzczcwcFcrTUE1?=
 =?utf-8?B?TmUrVjdwZUtSakN6K1MrYjhkS2RISTdidk1HT1paUDVldjVJOHZ1TDB5OER0?=
 =?utf-8?B?RGlnT1ZNQm9uVjhQZzcvbGVocjNod3hPdFFSOVEyN2hwTkM5aXNQc0ozejlV?=
 =?utf-8?B?QVhEblBPem9DKzUrT0w3Q0FhYVF6NzNpdWpvYTQ0MlNOTzlMRU96SnRNOFND?=
 =?utf-8?B?RDdOWDN4dmNEQ2N5Z3ZsUEt0cE1aU21OWXczZTB5RjJZSnlUY09XbGx4bXZU?=
 =?utf-8?B?cDEva3VocEJhUE9ubnUvcHYyTGppb3ZvZDFNbjJtM3pVcDV0UnNaS3JWTnp3?=
 =?utf-8?B?Q2c3VEpCS1BpVkVxZEl0SlA5L3BlUjBTQ0dZU09MQUdaRHpDZG9sWFBvSG9Q?=
 =?utf-8?B?cHFXNi81Zyt4dGg5MXNoMmJIczI0bzlnR1lzcGVTSDJhdmowVndDa1FTUHN3?=
 =?utf-8?B?dStiUnJUQ1NyNU9IdHY0d0RtWHVUWjdiL2drMmFEeGNXa093THRFdGVZYy9k?=
 =?utf-8?B?eldyck5wOW5yRzVhelg3emd6REYwUU0vZi9UOHptcnZQRFJNUnhiZlNvamVF?=
 =?utf-8?B?MGdVTlZFL0w2WDMrbSt3b3FaR0RJVzFacXRYcjJVRnFZS1ppSDM4RlFIZjZ4?=
 =?utf-8?B?Y0ZoMVpjT0ZmcC9SVjdTWTBGL3JWWC9TSzY3eElGODRJREN6ZXdYcDQyYmpx?=
 =?utf-8?B?czVCZFVWMXpPaXhjTlFNdS9jTDJYbnhGVVpZdkx4eG5LNzhDWDAzb0Y0RUJE?=
 =?utf-8?B?aFExV3lMYVF5ZzhzQzVPMmZNQXdzTWZDMmJKUGxTMUtTVDI4Qm9GZ0MxTyti?=
 =?utf-8?B?WEZCOXF5N0FKWFlySnUvOHRNMnVkejN1QlBVMTFUdDEzaHNITEUyZFc5SUdO?=
 =?utf-8?B?djZxSlk4cjZZZkhpWStzMkJDd0hCMEl0U291eThKV2JPYmhZMS9kNlRwc2Jo?=
 =?utf-8?B?T0t2SFNQRHNWakJpdXRCWjZ4dDduTnFWOW8rOHY1aGRETU1ZUWNieWxiODZy?=
 =?utf-8?B?VkE4V2JtOU1zRWlpcHNsWi9oSXJySlNNVFlYdVhpUytJeHNnbmxYblpaeWpm?=
 =?utf-8?B?T1lWb2I3bnNtTldiOVJCZmJ4NmlFeFl0bUZCYnAydjRKT0djOXE4VjB1U2t1?=
 =?utf-8?B?US9jb2NhdjhjejFxNlI1Y2xHK2tuODNOeXZYR3g4VkVRWE1rdE52by9vd1c1?=
 =?utf-8?B?eXBpcEZWd0tVQ2I4NVhVcDJVVnJIMy9xZjNhODlrM3p4ZXV0Q1BTdUZkOTh2?=
 =?utf-8?B?bFBlaFluZ1hCaXdIL2RHb1g3SmhHNDlhV0pRN01EMXpXai9QOHIzVkY0OGpz?=
 =?utf-8?B?WTROUUE4SW9QZFAzNjVBenc2SmNnZTdnaEF5dEVxMXZVbFVTUzBuc2hsUFFM?=
 =?utf-8?B?NDdyZ3ZyMyt4NnJWVllvRGFFWHdNOHluVml5SFpKeHRkdkVMSjYxL21tdU9H?=
 =?utf-8?B?SXc3ampYdkVLZnMySkdIeFp4c0RkTkRaTnpsaFQ0TDN5VitWRy96dVhZOEEz?=
 =?utf-8?B?WldYaXBvTG9kWHh5aEZDZGMrZTYyMGRacUg0eno2aDRYUVpjQk1DMFZnV3BK?=
 =?utf-8?B?bGtyaFg4T0Ezc2gyWTNJUWpBOGw5c0ZMTnZ4ODhVUU5KandZbHhLQ2xCRTRN?=
 =?utf-8?B?QnNUR3VEcnErY0NmZjFQcFpWakFwby9CNkhVdkZnKzA0VlM4aWozdno1TlZw?=
 =?utf-8?B?US95V2tZTTBwV05Wbk5HQVM3aHd6ckJoY0M1OFVYRTkyK3M4U05qdzRmVlNZ?=
 =?utf-8?B?ZHF6YjBMR055L0tRL3BUZlRrM3BvcE0wYW1uZlcrVVhFMVFBWmhrRlV3NFcz?=
 =?utf-8?B?aDZ1UXRmRGRVWGtVOXlETkl3ZmJGK3llZGdvU3VURURiZjNaTGtyZnZ6aE9v?=
 =?utf-8?B?OHJPcmIwc0VTcGNNcU5aayt3N08vbExncmZXb3psclJ4K1JwZGdIWFN5cm9Z?=
 =?utf-8?B?RitOcTlNSGptNy9kTkFvS1BXbFkyRVZ6ZVNLL2pQTkZEclFmRlNweVR2Viti?=
 =?utf-8?B?NGk5Ly9EVGw3M1FIVDFxaU1pSk85YzhtekNiQS83cmlQdzArTGx1anhISDBu?=
 =?utf-8?B?QmVXWUtYc2ZZMVl5b1lHRElwQzZxTjdIZVpwcmZoMmlxZTlFaHp2eEw2Ny82?=
 =?utf-8?Q?5jhitjhn4TlCmUwujXF7LLmu/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3f16af3-aa9b-4005-78da-08db6caa09a8
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2023 07:36:16.9540
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nh3jWDW8Tq+ZWA4KU6id+gzBUENRdaTFYEdL9MnTu2BazoiHQevQ2rNNjcgbVPuPIkrj4roICb3khvkhBtcprw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8002
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

Hi,

On 6/12/2023 7:47 AM, Hao Ge wrote:
> When domain type checks fail,we also should free protection_domain struct
> to avoid memory leak in protection_domain_alloc
> 

There is another patch from Su to fix this issue [1].

[1] https://lore.kernel.org/linux-iommu/20230608021933.856045-1-suhui@nfschina.com/

-Vasant

> Fixes: 29f54745f245 ("iommu/amd: Add missing domain type checks")
> Signed-off-by: Hao Ge <gehao@kylinos.cn>
> ---
>  drivers/iommu/amd/iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index dc1ec6849775..f08e65629c74 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -2094,7 +2094,7 @@ static struct protection_domain *protection_domain_alloc(unsigned int type)
>  	} else if (type == IOMMU_DOMAIN_DMA || type == IOMMU_DOMAIN_DMA_FQ) {
>  		pgtable = amd_iommu_pgtable;
>  	} else {
> -		return NULL;
> +		goto out_err;
>  	}
>  
>  	switch (pgtable) {
