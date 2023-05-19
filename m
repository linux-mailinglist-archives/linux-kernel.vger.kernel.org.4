Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7236F709E7C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 19:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbjESRps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 13:45:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbjESRpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 13:45:46 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2072.outbound.protection.outlook.com [40.107.243.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84A75FA;
        Fri, 19 May 2023 10:45:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ppg+71jCFiaabfeufd7FApCDIZEXmIpE+XPg8HxQnIzVOBlLksSNmE6ijmV9SWU1Ymt3Ao3k1WVoXogKAZkix1oWmIXejfLCB4dS9iKtHqQ+pJz/Pvd8UhYewPyiWQbrgLeUA5iQaR9FZhL8f7G25HCO76pyiVkfp3ylBPUcOxpob3I5TtTlOtZcBBzeS072s3jG+h+2UvEJPAHurdAn/7Pq4sP3lLA+O1S5GL8yGPxkqkmXtmvBg2ZVXifmdcrU/IALOlp1hNm45uPZdUCKG5Jmon7FQ4cxkmVKEPvhczgh3glsaZYjTLzvo2LjLp4pa9BeeSVeHmz8kp1f+iphQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j6WC/cVxaj9ybZ5XMFXyqrPquAi+C7ftmXM2cHM77ZQ=;
 b=RJ//H3fi/KFCq5+1yFQ/4sk89tqSjoYYM6JXVwJmqO+zeb3bV8gJTmSJbCkfJV+Tc2AD7/win6DWiZBN/yMOUf4rJbMY9MpQvIiCa/gijbZJ4qBl+3IKZvSrTwYlN1RFWy+jobbb2hdqg/PQ/Z7EplKnoCIIKw0tjCChUn1TNq68r4l/jdP1p10vQPJ17qITE6wx9mV7Lj1adiSDEkC3p78joH1TvD8DdR9MQPBq1aLCUifKXLZfeXh1avEM9UzqkQREwq0+gMRH9dHk9PXfZ35VN1lYIm8e6kowrF4sKFpdzJybt45zGJI17rSMfgRaz/UOCnWnyO287uMKnxcEYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j6WC/cVxaj9ybZ5XMFXyqrPquAi+C7ftmXM2cHM77ZQ=;
 b=GsnfOmpX4FGqnIewkm1YrSR3JbBxsCsMjqtMGFc2VtWoXYDRy2OkIDGvyVHHhV2UulGVhUadlS7c6KmMlcwNSXer3I7aP8xSpIt0gkalo3vZ55tw1ZCL2R9KD0cWfk+eavmV1u68cMLU7evk+oXxWn7pp28IBehGWELlc5V7Hyc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CH0PR12MB5329.namprd12.prod.outlook.com (2603:10b6:610:d4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.21; Fri, 19 May
 2023 17:45:40 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3f45:358e:abba:24f5]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3f45:358e:abba:24f5%3]) with mapi id 15.20.6411.019; Fri, 19 May 2023
 17:45:40 +0000
Message-ID: <a7493000-c72f-34af-d41c-9735eae5fd34@amd.com>
Date:   Fri, 19 May 2023 12:44:48 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 3/3] crypto: ccp - Add support for PCI device 0x156E
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
To:     Tom Lendacky <thomas.lendacky@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>
Cc:     John Allen <john.allen@amd.com>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230519032414.94247-1-mario.limonciello@amd.com>
 <20230519032414.94247-4-mario.limonciello@amd.com>
Content-Language: en-US
In-Reply-To: <20230519032414.94247-4-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN1PR12CA0061.namprd12.prod.outlook.com
 (2603:10b6:802:20::32) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CH0PR12MB5329:EE_
X-MS-Office365-Filtering-Correlation-Id: b44b35ed-da75-49a6-2efe-08db5890dc71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c6WY1GGIBQCltVGHpHILRjBx+K+YD2g+ehiZ2pkcO5X/Ctwz3ZV+Pv+eiQXfrIKK4bBP2zLm3r74dp8gvo+/NLIZkhlTUiBq+OYs26BBlvVza5+b6hoFc/Mx/Kl8dJvZqHGR2L9X2f/ayRdEsrq1C5UiVj8wuz/vNNvY9Mu3Wprft9z0/OstHDFIdcboC5ULuhpXo/JHQwipeidTxCETfKF3RMxXlA799X8FyIcMm+w/dH+hEFA40EkS1qHGKi+VwQY2cLVnrLBm7qcTAJ6NZ9wuefqstNd4/Il/NDMTW/qtL56FSOqIvnKW3JvHGIlHOqHAGAwzYvE6BE9jvKalL8hESKtZrCVg49XjSs6rwrOEOFVgkm3GM+0KwaeSYHCAN57HgB2o5BsxRzZF2K+BYN+F9CgmH9uIN1SxTdTBsY/qzy2MaJ0I30Wwr0Petrr3ry4xnVQ3rNRziOzxe9ITjYJ4JwCdWbJFjL4DrEaYqP546hmrnRHDlwjcx5iTa02/0UpEo+NAceOvpPpidfe2OG30d9ihlv/v7J3rWVKF8fiIdJW6r+LYDmEKyUMR7J+HIkkB9eBTQSC9rAWu8sGu2xVz0qcvT4fwH/QUJDe1B8+upRaBZa7w6smtf6M7vVmRpHBTTxvDoAVGZFmPpv8a9g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(136003)(376002)(346002)(366004)(451199021)(66946007)(66476007)(66556008)(4326008)(8676002)(8936002)(316002)(110136005)(31686004)(478600001)(41300700001)(86362001)(2906002)(31696002)(53546011)(6506007)(26005)(6512007)(36756003)(6486002)(38100700002)(186003)(5660300002)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZUR3dUxCanByOHFoNWpJMWNaZU5TTDZuSEdPbGlsMURkR2x3Sm9ya2NHVGkv?=
 =?utf-8?B?N2dVS0tGcnpWcGh6dTF1NFBENCtVT1dtcGMvQTQ3bE9Wbmp4OWtWRDBXUldR?=
 =?utf-8?B?MW5KcVI5Z2RBQlMybFZDem9Sam5abmZnMUZNejV2R1g4MmJVRFFnOFl0R1RX?=
 =?utf-8?B?UlA0VDdBMGQwVlo2Vzd0aXlydVlSWnZZMXVDdmFZZDg3eUx4UlJJVlBSUXUy?=
 =?utf-8?B?cmxnOTlFRXdIc0lpTUF1ZGZsd1dlbEJPSmNseEp0akxUYW5BVEZjaXpzQi8x?=
 =?utf-8?B?UDA3aERwUm05Mzd2OUFPdmVjSmpXTTZxTnExSjNSQWU4eUxVM2dBN0tUNXY5?=
 =?utf-8?B?MjVWR2lFUVpYaStReUdEQTZLV0svNzcrU3BBcFJrN0JpL05aeDl2RTNSVjN2?=
 =?utf-8?B?QTdIR3FoN3ZHYnc5bzNFRmswOUlBckpzSlYzYWdUL25uOG9VdXlRQnF1NlVp?=
 =?utf-8?B?dEhvQ1NETFFjeU9wNGV0QmQ0eC9vVmNzd0VBdDlJWTcranZzelhJNk5mS3ha?=
 =?utf-8?B?TVBVcGdUNWxNMWpFNGYxTDlPV2RRNnRYTnE0NXBJR3JxWC8wZ3hKUjhFc1N1?=
 =?utf-8?B?TGRxU3ZvZkdWcmVXWDVsZ3Vpbkpwa1Z6eGFsT0NrS0ZVN2FoL2hwMWJ1S3lw?=
 =?utf-8?B?YzI0a0ZNZFdLL1liTWdzLzRXb3VsckQvRXhmUm44TmVLZ1BST0dyOEVZQU1w?=
 =?utf-8?B?eXZ5WXhMY1lPNW53OGdldTAzWDBIdVpWc2ExT2V6d0tCMURCVm5GS3RaQnJD?=
 =?utf-8?B?d1VhamFaSWdyRWxqVUljR2p3UVZoQTJRSGJINTR3d2Ryd1lvaHRTQUJBWjNG?=
 =?utf-8?B?Vnl0QkpJamd6M3BGOCs1aW1xYVVVaG5UNFdnRG1EUXhKT1BsMHdGZGY0dEZE?=
 =?utf-8?B?Z21adzVURDE1MVpPRzE5ZlVUWnA1Mm5ZdURyNjdBejRTSWlNbEVTbEg4b1FN?=
 =?utf-8?B?aGovcGRCeVVWREdhMGNOZy92OUtYaDhaZENjbkJsZ3VrOVBWV2FSU0lNclFh?=
 =?utf-8?B?YUxnaTI5SEkxWlZSNVNTWGx4bEdFNS83Q2NqcTlCOUVkSkIzb3RhWVg2bkFv?=
 =?utf-8?B?U2E0L2ZhSDhjRitKTUdCQWVITkp1akFGT005bjFKTXVYc2VjWEg1Ty9kS2FV?=
 =?utf-8?B?OGtYN2NITEg5S3JaRWtxbytvWVVjNWF1bEVtRXVJcDRTNjZGU1JPRXY5Qzkv?=
 =?utf-8?B?V3BvUDRBYmo3aDV1eUd1eVZQVUxGQW9rbVlPZkhLUC83bU1OUWhIUVdrTXhn?=
 =?utf-8?B?UG5ReE44SExOTlhBVUIydGlWcmVBUmNVUWtGaUZoN1ArM1NMV1NwRktzYmhO?=
 =?utf-8?B?aGVwNVVyUzNiQVl5Sjd4c055dnFuZldGenE2WkZiTzI3eDZjVGl4WFNadG4x?=
 =?utf-8?B?enhPT2xsUDZhUlpzbEZZSTkxUmY2T2IwM3FoUG8vcElrWGNvY3FaekRBRHNW?=
 =?utf-8?B?cExnN2hwUUlPSHdjSVFIbFh2eUVzRHByM1BidVBGcGtyQ2Y0MGNHUU9PbVdX?=
 =?utf-8?B?YkNPNDFKcGVSakcydjBkaDB4NDJGcnlKaDlKbzFzbkViVTVjVE9VWEVIYzlI?=
 =?utf-8?B?MGpZQ3U0UHY4bkFPeTRRVDdzbmx5aVcrSW9JcFJyWmtBL2JlWExtSG8yeXNJ?=
 =?utf-8?B?R0FETkZ2Q2R2QUhxWlRkZkdFcVphUC9lVnRwSHRiMDF2Y3NISUtHcFFtOXVI?=
 =?utf-8?B?TzdYbXVic2JJeUoxVXVmOTJRQmRSRG5EUFFEZEFxanZBcTNlbXYyZ2RIeXV1?=
 =?utf-8?B?RTJsdjJMa0ZnUWYzT1FZbTNER3JVeUZMYU1iRjBWZFdWenFuaTVBZ1FFdUIz?=
 =?utf-8?B?ejZLSmp1V1htVjFjVUtsSTQ3R0lEeDNMWmROQkhpa0JrUkJrVDRaNjZSdmYx?=
 =?utf-8?B?c1owcUJJQmhUNEtkdnA3YUVrSUdqdXE2QXhlNThMZVlYQlJzbWNHTjJGa1Jl?=
 =?utf-8?B?NjRPOTN3NWIvcjQ5R2h0NVQ3aU9XVHdBbnllTVBCdWV1dFdqZjFHTlZHd1Ev?=
 =?utf-8?B?K2JWSi96MzM3enlicTQ2aDU4MUVCQ2tZSFM5aFhINWt2RVoxWVVjZnByQ1BS?=
 =?utf-8?B?YW1OMG9MTTUwZ0xxZ3dwR09iZjN1QW94dnVTa3g0dVdCR3RRcWh6bUY5MTZR?=
 =?utf-8?Q?tgpuhPLlrtq2UYfuWO2Fi1cLU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b44b35ed-da75-49a6-2efe-08db5890dc71
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2023 17:45:40.1707
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vg8EOCw/c28huL48mbV/ihQFq63pEE4oyDTXWpdFLQYIUYkhHMyuIHvHCYBWTN/SeooWEsSmV7diB94pn4evkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5329
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/18/2023 10:24 PM, Mario Limonciello wrote:
> From: John Allen <john.allen@amd.com>
>
> Add a new CCP/PSP PCI device ID and new PSP register offsets.
>
> Signed-off-by: John Allen <john.allen@amd.com>

As this patch was from John, I forgot to include my S-o-b:

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Herbert if you would like me to resend with this directly
in the patch, let me know and I will.

> ---
>   drivers/crypto/ccp/sp-pci.c | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)
>
> diff --git a/drivers/crypto/ccp/sp-pci.c b/drivers/crypto/ccp/sp-pci.c
> index d0d70af0c4c0..b603ad9b8341 100644
> --- a/drivers/crypto/ccp/sp-pci.c
> +++ b/drivers/crypto/ccp/sp-pci.c
> @@ -420,6 +420,14 @@ static const struct psp_vdata pspv5 = {
>   	.intsts_reg		= 0x10514,	/* P2CMSG_INTSTS */
>   };
>   
> +static const struct psp_vdata pspv6 = {
> +	.sev                    = &sevv2,
> +	.tee                    = &teev2,
> +	.feature_reg            = 0x109fc,	/* C2PMSG_63 */
> +	.inten_reg              = 0x10510,	/* P2CMSG_INTEN */
> +	.intsts_reg             = 0x10514,	/* P2CMSG_INTSTS */
> +};
> +
>   #endif
>   
>   static const struct sp_dev_vdata dev_vdata[] = {
> @@ -478,6 +486,12 @@ static const struct sp_dev_vdata dev_vdata[] = {
>   		.bar = 2,
>   #ifdef CONFIG_CRYPTO_DEV_SP_PSP
>   		.psp_vdata = &pspv5,
> +#endif
> +	},
> +	{	/* 8 */
> +		.bar = 2,
> +#ifdef CONFIG_CRYPTO_DEV_SP_PSP
> +		.psp_vdata = &pspv6,
>   #endif
>   	},
>   };
> @@ -491,6 +505,7 @@ static const struct pci_device_id sp_pci_table[] = {
>   	{ PCI_VDEVICE(AMD, 0x15C7), (kernel_ulong_t)&dev_vdata[6] },
>   	{ PCI_VDEVICE(AMD, 0x1649), (kernel_ulong_t)&dev_vdata[6] },
>   	{ PCI_VDEVICE(AMD, 0x17E0), (kernel_ulong_t)&dev_vdata[7] },
> +	{ PCI_VDEVICE(AMD, 0x156E), (kernel_ulong_t)&dev_vdata[8] },
>   	/* Last entry must be zero */
>   	{ 0, }
>   };
