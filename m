Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8EBB7262C1
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 16:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239831AbjFGO1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 10:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239120AbjFGO1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 10:27:09 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2054.outbound.protection.outlook.com [40.107.93.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CB3BE43
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 07:27:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AkMc963CvkdEozqcw7x70AZYkkQtk0Yqrpa5tQsEEE3gtVIlL0JeLZHN9Q+0bqrd/KJeYffpt6/xNE3BdIDNOHo7JICMhe8QY69+ogReRjMKBMIYWyOivmmFWIAIssk878kVqA3XjMgejLQQwCYmMzsbbMOMRwK5+1pHzlmGCNl7LX+wRByNM1zwB1vhDR2D5EKXo5kMz0h0qoXzXC/rqlqsaAE3MCsf7X3DCc4xEkF89lFkRd93M2yIFD1LquSZFtkv06SiLuegBl+4DuZcJk4rv45rdjk8NlKpDzJrtFb1wHkWboU9xgz0BZNPpgmJIn++t2sYmsI997SHufO24w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=klUT5iWVOkTuLfutogB3eY62d/IukKFoFSrhJIShIC4=;
 b=WiWsCtAsPtHFTKdfbQRcQ3Apmy3NoA5PJp3Mi8DqusSXyG3AJ1R6sU6kVNJ+eyBpJRPkRh+/ZiMHODJK9tz1sUTT4AGk9xSsMjYVpPEAA/Ea8uPI7TQG1qWZu1sdZbdcDq9eYwVycd6hDO2pD0Ay5kMUyFkJoY2ZRyqCaScMx4Xr29UuAlQ8kN/+nV9A4N1pI+Vz7PBd6JFswFTeMVip1A3qlxWYf+zcLe64K85Wg6J0hGoc4l2FyaksvekOfNuVajJzphuN+/CXvkTjOvuDRRnF5RlycCCM+emSlhyDfvCJ9NZtlWdqGr6C/eFpArHvEo7nnsZUKyCZ38iGflj/qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=klUT5iWVOkTuLfutogB3eY62d/IukKFoFSrhJIShIC4=;
 b=4EjE8Oo/4QbDrF6B5ETSRM3eDDH83h8dSS42lKizz7zwIb/sf8kwJbUw/y0IyBtrRcwRL9A1xFzfnM/XFG2qVdlZsfHF4KMK4dhnEchgAcmfs1nf/xkbUq7+k1T5Gbi23UFWIWABMkCwgKVszXARI7TMj0gOhH5PeQRqt91FFu4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 BL1PR12MB5318.namprd12.prod.outlook.com (2603:10b6:208:31d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Wed, 7 Jun
 2023 14:27:03 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::7cbf:236a:55b:2c99]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::7cbf:236a:55b:2c99%4]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 14:27:03 +0000
Message-ID: <95c1cc02-cd5d-c454-7c29-e4c42a6bd54c@amd.com>
Date:   Wed, 7 Jun 2023 19:56:51 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] iommu/amd: Fix possible memory leak of 'domain'
Content-Language: en-US
To:     Jason Gunthorpe <jgg@ziepe.ca>, Su Hui <suhui@nfschina.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, kevin.tian@intel.com,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20230606070742.139575-1-suhui@nfschina.com>
 <ZICSskXNlR+ckKvC@ziepe.ca>
From:   Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <ZICSskXNlR+ckKvC@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0073.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ad::12) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|BL1PR12MB5318:EE_
X-MS-Office365-Filtering-Correlation-Id: 84f1317f-d4aa-4138-116e-08db6763432f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3wHjr3GWIEQjL4SYewfSOrFGtEL9KVE/zBGoMd5Yqkpr1lIs2ghwyQQ/W5TAqaVExNYxWGKAKdAX09fUWzZPLjD+/hiyAyBWXI1fqnHq+0YkETlzdQOM48s7/ubR8x/PUbhx/C7y6uDd8a0bYKVO7nkWNWTvn8sZuHJTcr1dV60Hae41YKmQyxcys0AjItEeZFCpCi558YONROdNvCltJ1on37g9xMQZg+3v0xcuhyrA23eqZQw714yD5gjTb3ZnqxUrL0vM6Nxh6oF+6tv96USXs5y36Jey/af+QSxkSiF/pY2Dby+ODUffQkNPeMvZtXq53Cbtvd6A3TQ2m+mIBzddlMa+UeyMy18f0gxKKEii+Z0eX0fDx9akbz6i8qZZ+nOp2vg09bJ5b2ei8tJ3/Xm5LQ1JJCuZ4457DGTF+0Y1LPgSf7tDkoI6CQdke8Me2AnUS3xt7PD3vIB8Bdqhhd3eXt1FOv+nXZym+sfDQa+ZLIRMBlmMiILwiCyc755YTcsuCWBWA4pt5ivpEMfdphYRcM/cbSpArvgQwLpdI8lodu3MjCMy7TjRcSJqvNuLztwOFogXs+cwKgQP+QmVN5HhX0fEU8qi9swbX/LyFsgiJmJpax9y511EPm8/xdGWRE6hN64cfMsuUuFtLkB7B50B1gNAkm4abocPpd7LGwcXqXM5wy6/j8qI/OUmqON/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(136003)(39860400002)(366004)(396003)(451199021)(8676002)(4326008)(66556008)(66476007)(8936002)(66946007)(316002)(5660300002)(31686004)(41300700001)(54906003)(110136005)(44832011)(2906002)(478600001)(26005)(38100700002)(31696002)(6512007)(86362001)(6506007)(53546011)(186003)(36756003)(6486002)(2616005)(83380400001)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b1BzeDU2YndUbkR0ZlY2R1hLRVBYamFZZkVjd0pQbXM3alNZVCtLSzdEbGY4?=
 =?utf-8?B?em5pM3U3UTROb2kySFJmMDlhays2MGRDL3FSM1BhekVUWFBuajVYUWhNeXQr?=
 =?utf-8?B?bXNRNGhwRHh1V1JzbDRBT05pU2hnbzlJWUdvczhJZWhPWmFWNUxFTFV5TFVC?=
 =?utf-8?B?eXpHbEZmVi80NXBLRVFIMTlIam1FbG9VWm1wWm9yemxGbURnMnRReDNUNDBV?=
 =?utf-8?B?TDVZSE10bmZ4d0tOb2ZDcW5JRm0yaU9QUTNJRC9lemtNam9rL0t6MVRSTzVx?=
 =?utf-8?B?bjJrSnN3SVFrS3hCRTAxa1d2Yjk3eDdKYUlKM1dnNTlPM1VKVDZmQzdjWitS?=
 =?utf-8?B?RzhKL2pnbXAxNFM0T09lS04yc2lUVkFDcVFySXNZejZTdDlXN3VZNnp4Q1l3?=
 =?utf-8?B?Sk0venBmcFpuSmtPMC9DdjQzUkJYNW1QVFAvR0FWZzFuNWszNndoR0lWTzQx?=
 =?utf-8?B?TjI0WmJXQzIxaDEyeXBkMTMySDdBNzRtOWhiVXRPcUxoMVZuWXlrM1VpQWNo?=
 =?utf-8?B?WkpEWWIwTUdEczhxb0ZObUVnQVZ2azl6T3c3OVlwMzUzWnBPS2pERWV6eGpS?=
 =?utf-8?B?WXJqaGlsdzBTZ1BTQlRTdHh2MzBvT2pleGtORldqaExZN0FMa3BCUDE5VHMr?=
 =?utf-8?B?ajduOGhvdGlsYUhLU3RBVE1hTFh1NW5qWlBjMmVWQXZqWjFKQnV5enBEZXN2?=
 =?utf-8?B?SjJ4RmU4UnFNRDU0b2haS1RLT2xjNVRuSTR2dUVkaGtpZm0wTHRXMndCRG8x?=
 =?utf-8?B?dnBCOVlFVWJoenk3ZjJsS2huaWg4WFNmVXF4eS9Ca1hNZGlraEVtYm9URUhU?=
 =?utf-8?B?M2xJd1U3YnB6ZTBvOGttMTlkRlp4dVNuaS8yUVA0eWFIcncyeDhRUzZKSjhJ?=
 =?utf-8?B?Vk5adkkydkFxdENuUDU0TFZNcTlXK0VJOXZBalo3ZEpEcWcvNUkvY01FY1Ni?=
 =?utf-8?B?d3Q2VFZ2L3pCZ3EyZjNWQlN1RTlBSXMybTVvK2hTMThYaDFBcWFqdUZZMEN2?=
 =?utf-8?B?TUIvb3JQbHhvV3l0YVY0TWlLd1YxMTArUmxwWnkvU04xaU5aOUpsRXMraUt0?=
 =?utf-8?B?YW02T3hnK2g1cnJaU1dyUzVZNzg5UFdWYkJvbjhTQy9Ga0x0VXZQcnVqdHBY?=
 =?utf-8?B?UmxxbFhDcXhPeGZ6T29kMWF4NGhiTWxyYzNOZHBpdjlIeDJnRjZwR0ZPSlpq?=
 =?utf-8?B?a1J3a1N6dkVFN0NrN1FDV2t5WWY1anFFamlLMXJtNzhCU1JVUVRxMWd0N3JT?=
 =?utf-8?B?R1A2U240bDJzOUFJNkxpVFhKSlk3aktYaW1QMHI2VjY2L000TEY4VUdZV2RR?=
 =?utf-8?B?WTdsT0VnVFdQQkVraGRwTDBNN1JiK1BlZVpvc1A3aTZmUWptVlpjakdUQm02?=
 =?utf-8?B?QzgvN1lqZ0NpaVNUak5MQWtkZzhyY3MrZWErSzhqZXRhelltTWFuZGwyZjZV?=
 =?utf-8?B?NzNFSXdKZ2liL1dIOHh6TEhNUDF1bUFueVQ3bCtTN2dZSzA5SUlUSHZQVzdU?=
 =?utf-8?B?V09DU1p0L0p0L2R5UjVycFgrOHNHNC9manAxcWJiM3BVS1FqZkhHVlgyWkp6?=
 =?utf-8?B?MWhUWTk3NEZQM0Y4S3I2ejF0clZNUURzUGZpZGhCQ2tCR0ZEeDNsRUFvZTk2?=
 =?utf-8?B?RWpkWS85WFNFQzd2K3ZHeWV4NnNEYzZUVnd3Rk0vMXQ1aVZ1MURPQTB0dXFN?=
 =?utf-8?B?bWRBUTh4TCtEQ1Q0UnZsbFFSd1BSUXZReTF0engxZXYzT0oxVFBSY1grL2Z5?=
 =?utf-8?B?amZVOUcrUnlMVVY3UWJBcGlwUjRXQW5FOFl1Y1dtSlpGWm5TUDhJWWJsOVFm?=
 =?utf-8?B?UEdHNC9idGVIb3ljaFNNWXRhbjY5amp1SVozK25PMW5pQkhXVHIwSWh4aHhY?=
 =?utf-8?B?SjA0MWNkVXZoV3ZzM1pseU5ybjVIU0J6QWF5TEhWZkJKN1JBemxnVmVUUFBy?=
 =?utf-8?B?MU8wSEgxZ1haY2l5alQxNGJhR1RaeFlweXR2Sm1vTzNYSWt1U2NBM3FTK296?=
 =?utf-8?B?QndYNWVjRlZFcXhhRlAzdVJmSU02UGZlN0dBeCtMTnAwSkFiVjV6VUJkNzZH?=
 =?utf-8?B?eU1VMlh4SEVpaEhrUTdwOEVSTFcvbEJPVzh2SFREd3czVXBiNTBzaG1NeVFP?=
 =?utf-8?Q?6LNKCn4/QNgpQzoQZOKaIf7j7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84f1317f-d4aa-4138-116e-08db6763432f
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 14:27:03.5186
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4qXKvytFNkd/RJ0x6WwabkcfPDky3v3oetcG9s+lazgOTKf7R4ts+d7sVT1qWGcWNIN/j7aBhLVoa37EUlWdZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5318
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

Jason,


On 6/7/2023 7:52 PM, Jason Gunthorpe wrote:
> On Tue, Jun 06, 2023 at 03:07:42PM +0800, Su Hui wrote:
>> free memory of domain before return NULL.
>>
>> Fixes: 29f54745f245 ("iommu/amd: Add missing domain type checks")
>> Signed-off-by: Su Hui <suhui@nfschina.com>
>> ---
>>  drivers/iommu/amd/iommu.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
>> index dc1ec6849775..f08e65629c74 100644
>> --- a/drivers/iommu/amd/iommu.c
>> +++ b/drivers/iommu/amd/iommu.c
>> @@ -2094,7 +2094,7 @@ static struct protection_domain *protection_domain_alloc(unsigned int type)
>>  	} else if (type == IOMMU_DOMAIN_DMA || type == IOMMU_DOMAIN_DMA_FQ) {
>>  		pgtable = amd_iommu_pgtable;
>>  	} else {
>> -		return NULL;
>> +		goto out_err;
>>  	}
> 
> It might be nicer to order to allocation after the type checks, it is
> more consistent with the other drivers
> 
> This is fine too

Right. We are working on cleaning up/re-arranging this code path.
Hopefully I will have patches soon.


-Vasant

