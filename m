Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9F1260242F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 08:14:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbiJRGN5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 02:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbiJRGNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 02:13:54 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2074.outbound.protection.outlook.com [40.107.92.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D784BA3454;
        Mon, 17 Oct 2022 23:13:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XEpUEcC+J6hABIQPcj7P8n6aGYEvKCwGOaX7k/n7RUEVW/vMqLD4HIy5WjnNAC+aGbgz6dJJ7jmie/hD+CVK/232s8O7EZZBOpyd/vXKaHiHJwhr6TSw2g4ZCbGNIrGMxrZgZFb1xdjgWQ0K4xVcIpTH1KZNJcItVls6QGNNb+CFwaQu4y7zSf2zgRlmO6ZS8gJtUvMSvAWIp5FKYJRKjd933MpXPeM5LwvyZ3tdv1FCUSBC9TJ4oTad36RMG+mtMLbXnMqktNCHggVJJR2RtRR6Ux3YjML6JtKouKMnpNRyEe9jsrritGKC53UUiQZXvfdC5LIN2N8SSsphFa6NUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dzRuuvOXc6CIKylGkaFzLYiaEbO/KMt4ok38xoxstvU=;
 b=H3CwGNiRAs/fqK9tILxpNY3ErWG6J6haA/cfFRwteC9jLIykPfHk2eCcLj8MotOkflhQxjahu4q7jQ4yvmwgRcMlx+xj8klSKc6Url5E2n4I28hNqtjc3+SiuJcPEZZm3A75Iu3+MQrHU4BYLe27l91XN+mhxRaawuE39wV72lKV68mwMM+Gnjviw6DAPv+aU7fBNLvTfCons7VRiS1735dm723djFoH1dNLY4nKnnDA9TksO9lwi8lB0yvrjNn8NNzuGn64snQjCkPD1h8UgXchoi5gCdeiHIyo+3zWjFYkzhWRpXdk1WEec6Gnj7ikqUE6/fjHr6Ma8wW/4U9+nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dzRuuvOXc6CIKylGkaFzLYiaEbO/KMt4ok38xoxstvU=;
 b=T4Uvgpr/N8dlHA3vC5ByOkyQW0PhbT3/FXPLa3Worpr35J0yyEuOPLABBy1o99lAwc46c5E3KzhtXyxRCtwDHRhLplfibM+XzVArwy7AqKfeOSonGcbs++8/8ExOnsjKw8rNgbFb4v4edglcQOuBXOqVZ40yciC35icaFnEfdveXpI262J0pckUuKZOwgB3+hIQGDdnHMoekL6Wb/RIsR3xNzblmx5/Gr4j+hM7XnH7Lm1nAwSxCjYtRnqvJIqJrbC/fQVdmX0T/gEuu6Jr8w5BnOy7fQT6Ueq9oMFqhxWuiQBIKu99QGH3MhPaTFGMdkGaxSeHswsTWNA614E7m1A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 MN2PR12MB4157.namprd12.prod.outlook.com (2603:10b6:208:1db::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Tue, 18 Oct
 2022 06:13:51 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::c0e5:f111:3e59:7c66]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::c0e5:f111:3e59:7c66%5]) with mapi id 15.20.5723.033; Tue, 18 Oct 2022
 06:13:51 +0000
Message-ID: <41293685-54aa-6fa3-ca41-189fdbb7e8b0@nvidia.com>
Date:   Tue, 18 Oct 2022 07:13:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v4 05/16] iommu: Move bus setup to IOMMU device
 registration
Content-Language: en-US
To:     Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org,
        Thierry Reding <treding@nvidia.com>,
        Dmitry Osipenko <digetx@gmail.com>
Cc:     will@kernel.org, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, baolu.lu@linux.intel.com,
        kevin.tian@intel.com, suravee.suthikulpanit@amd.com,
        vasant.hegde@amd.com, mjrosato@linux.ibm.com,
        schnelle@linux.ibm.com, linux-kernel@vger.kernel.org,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <cover.1660572783.git.robin.murphy@arm.com>
 <d342b6f27efb5ef3e93aacaa3012d25386d74866.1660572783.git.robin.murphy@arm.com>
 <89d873fc-9f0a-156e-dcf2-48a2b9f93dcc@nvidia.com>
 <583c4689-844d-2ae2-79fb-4750b21c4304@arm.com>
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <583c4689-844d-2ae2-79fb-4750b21c4304@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0369.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18e::14) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|MN2PR12MB4157:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c1431c0-1dab-4177-ac27-08dab0cfecf2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YsJor8pRcSnoVgy/HJIkAuySGcTzKhuamWDgGBqkwcKztskOoeMx5MYBEa9fIEmLjt2fZntavQe6EoN1t3K8mxKPC9wjLs9XLEpPI7WH8eE4tWYff58Liwxt5y9DgUINv94TNWnjOQGse8WfOfFTFeP0tzir8ERYYjoya4PwMO7dqBc+GdBEbieM54VWi97IRfH1hJGP83ZBoxHPPboskUjS3rBFY1EtHfEMLW+yIQXblABoEYKOiCvO0PtGn+F41k1+7JUeild3Jg0xBv0pGUsETYJSfJNeAaissd6Dg+LP9fHUE4DtbJmaDsNz672xcIJehJHKJNTulonbjUS3/1ULqnCSOcBkyuSWvKtWwL2cTi/i36ymv0h8deRwnF4V/sM3ZXtJgYsjhu3CZ/IHkU/HMYIqsfSiVuktGtk9dOzPSYpqmklztka/k6EVsa+xSKRJqGJM5GRQwwlA3lo5dy2nq5y0u7skAJqbbETAVX1/eHcr27f/sd63ZKWDZvfFrM3dC8ss/EgpWsHBvs0vJ1nOnQd2pYrOSCCeEqqstKPHjS0FlR692CR5zcF7XLOtUFkrAvQiQyzD7psM/olYpsXvjCmuyeOjxX/GSMzP1YhVbaqffSgvUS0U/AOOaLFvY7st1o36AmoJuZZrD2iTeax+cANFdGo+FuCuYOiHl3Xdr4DfnLkoD8k5unYelXBzzrv2u3DDpz3VTVsPk9uSplNGOV8LopogigCo1O6i17ywYGuXBeFJ88qlGOFRbjxXugr7bWOvUk7L0hUgvro+EYQNgMLQW7ctC9upNnOmy8c=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(366004)(376002)(39860400002)(136003)(451199015)(38100700002)(478600001)(7416002)(316002)(36756003)(6506007)(110136005)(31696002)(6666004)(53546011)(66946007)(66556008)(4326008)(8676002)(8936002)(66476007)(6512007)(83380400001)(41300700001)(5660300002)(86362001)(31686004)(186003)(2906002)(2616005)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UEQrQkwxWDNzMjNlcExjZ2w3alVPbVhlNzVuMVZRUStDUzJQd0pEM0U2bXJi?=
 =?utf-8?B?dmhVakl2amo2WTlzamFBOTFPNy96djdFOHI2SUREd3R4OU42N0twaXJySWla?=
 =?utf-8?B?MGhEVzJFOFQ0djB6OG5qc3VDRDUxZzYxcXJJc29ZQksvOFdMR1dsTVZWZDdN?=
 =?utf-8?B?NFVpSUw4ZDliQzZOQ0JieE1raFliQUs2NlZVSm5SVVRHZllOQis1QlE3aldP?=
 =?utf-8?B?NHpFeDk5SnRPa0FReUtCVWg3MXhvSFpzdEdJaDlrM1U3V21Rd0MrKzBEVjl5?=
 =?utf-8?B?V05ldTJGU1REVWc0NHEzM3BGVzdUTFN2UCs1RzVrSUZ6Sm50ZlRsdjg1NEtK?=
 =?utf-8?B?cGRLSEpLTWN5bFFtc2FZaDRzNUEwdlJFZW1pMDhyeFY3UmtsVDdrdGgxaENT?=
 =?utf-8?B?emNqbDE4VjdJd2QzZ0UrbW1PYWQzM0xITmNkS1dQMzJ1Y0ZIL3RBMFRiblQv?=
 =?utf-8?B?N3JyVE1kM1g4YTVWVWhodG9vSHJOOWRieGFsZjZCWnZYbVdrNVVUY3pROHZL?=
 =?utf-8?B?cVVGYUlsMGh6cEp3RXJ5OGJBOXdqRzEvcjRNclRaemYwUkQvRXpadWJnQnF0?=
 =?utf-8?B?SnNqVFg4aGduUHVDOGtMS0ZpTXNnWEgrOVYvNUJheWFJcUlXQTNFOUpkbXZU?=
 =?utf-8?B?eHFJbndESFNMeXpBajU4Z2pCbTRCdnNLOHc2OERJNkU4b21HN0M1dC9ib2Rj?=
 =?utf-8?B?NDhIa2x5MzZFMHZVRCtqM3dVdG5uMnR5ZnU0WnN0Z2tBSXFEd2xNRk9SVkMr?=
 =?utf-8?B?emwzano0VHVjZ2R1UEFrRHFXRjdvcmI5aDZ1KzFUMlBpaTZveGQwKzJaYXdz?=
 =?utf-8?B?bVFJRjFNd3cxZ1FOamFCWU5DbWMxY05zWnc5VXQrTWx6OWlIYUNwdFRiTnFT?=
 =?utf-8?B?QTF2UU0yYmtjRUcyVnV6QnFxZ290VW11WjRWbTdNd0xLK3d5ZTRtZHNXZTM2?=
 =?utf-8?B?dmtUNUVoUDFHWjNKQTVaWnI5akkzL25hdGJ6N2xKS3QxbFBwQUNyOXgzTTdG?=
 =?utf-8?B?UzRMVm5LOVQ4d0s1TXVHdXpMU2l6cDhsZXpNMlUyMDYvWnYrSXV4M2g4bDdF?=
 =?utf-8?B?eG9BUEVrMjA1R21YaXUvZS9LTUwzMUZFQWRpRCtaRXJ1bTV2cHc2czB0RlRQ?=
 =?utf-8?B?SHhJMXAvYWlkVUhVVU5OZnJCM1UrcDBaVUNDeTB5dThZZUJacW1RMGx0NU1y?=
 =?utf-8?B?dVM5L1JGWUs5cHBsUjJSU3RUclJsMGxTNHdTSTR0TFBmbDA1Nm9BSGwyaXFz?=
 =?utf-8?B?cnA4NG1iTWc1bGFEendCeXp6ck4vb1l5endrUGZQUTFqaHRlUmVFdThTbE5V?=
 =?utf-8?B?NVFnSEw5bnNhejlGQkVPM3FoSzFpWE9nUDhFZTlFSWE4ekRyZTBpUDFweTFt?=
 =?utf-8?B?NFA2UWdDcW1NSHBYVWtvUEx4RTcrU1VQT0t6QktuWnA3UWpRZXhaWmJKZ01V?=
 =?utf-8?B?QzZNcmh1aTBhSktRaVVNZVJ5UDhLNUR2dENmSGxCQnUxTlpMUDlwRXhBYWp6?=
 =?utf-8?B?SFh0eGNHWlVaQ3JrM0VuUDNLYnBlNzhha2N2Y2R4U3RaWUNjam8vMTJ2MDBV?=
 =?utf-8?B?WDd1WWtiZ2M2K0hMblhQTzdjSUxtNzVjM3dsWVFOTXNUZlkrYXpKdnZWNWxL?=
 =?utf-8?B?Tk9UL2crWXV6Wk1xNmIyR0ZOd0pPMmQrZlU2aG1uUDNZcHF1T3RmYTJKOW9m?=
 =?utf-8?B?MnYwZE1ZUjR6Snk4R0p2OFRTOGRkRkxnWTczWkdVRUFQQ0FzcXJBVlluT2wz?=
 =?utf-8?B?Q0hDcG5xMDNGeGI1UE9SSUFCNlNhMThrV0dXOEp0TmgzVml4ZWJ2ZTRXSllV?=
 =?utf-8?B?ZDhVZXJ1SVB1OEFTbkhMVmxpMXdXMEZjMUNTNk0rb09WUFdDdUxHR0RGM2ds?=
 =?utf-8?B?eUxtbll5eEQ2cUVrcDU4RHdhTk5yZXBsRHJWTXQwTDZ2REhRQXVzUmxJaVln?=
 =?utf-8?B?NFUvUFJVaFVPN1J5TVVtN1JzdkJqNkhyTHBxQ0VyRTd5NUwzZ3B3TnRhN092?=
 =?utf-8?B?M3FPOGk1Rk1idGx0MHFBQ0pNY3NmZ21kVGpsdWZjNGREdU9mREJPblVUSGI3?=
 =?utf-8?B?WHYrV1FiOGRlQ3ZncWU1NWRrUGhONURGZzQrZE1jSWZHTEdSL1JuRUJ5cmFx?=
 =?utf-8?B?K2x3SUhVL3pjV3lvWHBFTlR2OU9vMGFWNDRWQi9TTnMxZmFldjdTY0s4eGNk?=
 =?utf-8?B?a1U1K0t6VUZ3U0FRUTgwa0tSM0l2RnpPOE5HVmhaV1lDWTFtSlJaazhKRGpR?=
 =?utf-8?B?ak1ZU3RVRkFWWHk1SmI5dktuVDJ3PT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c1431c0-1dab-4177-ac27-08dab0cfecf2
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2022 06:13:50.9828
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aOKFLSGeHRpuGQvt/JwG+GaSPhdN6iXDVzFwsBpMSZhT3fPrCy8ZtjK7gdltmqWehrC6nYx1LcFYYXajbZmOwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4157
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 06/10/2022 16:27, Robin Murphy wrote:
> On 2022-10-06 15:01, Jon Hunter wrote:
>> Hi Robin,
>>
>> On 15/08/2022 17:20, Robin Murphy wrote:
>>> Move the bus setup to iommu_device_register(). This should allow
>>> bus_iommu_probe() to be correctly replayed for multiple IOMMU instances,
>>> and leaves bus_set_iommu() as a glorified no-op to be cleaned up next.
>>>
>>> At this point we can also handle cleanup better than just rolling back
>>> the most-recently-touched bus upon failure - which may release devices
>>> owned by other already-registered instances, and still leave devices on
>>> other buses with dangling pointers to the failed instance. Now it's easy
>>> to clean up the exact footprint of a given instance, no more, no less.
>>
>>
>> Since this change, I have noticed that the DRM driver on Tegra20 is 
>> failing to probe and I am seeing ...
>>
>>   tegra-gr2d 54140000.gr2d: failed to attach to domain: -19
>>   drm drm: failed to initialize 54140000.gr2d: -19
>>
>> Bisect points to this change and reverting it fixes it. Let me know if 
>> you have any thoughts.
> 
> Oh, apparently what's happened is that I've inadvertently enabled the 
> tegra-gart driver, since it seems that *wasn't* calling bus_set_iommu() 
> before. Looking at the history, it appears to have been that way since 
> c7e3ca515e78 ("iommu/tegra: gart: Do not register with bus"), so 
> essentially that driver has been broken and useless for close to 8 years 
> now :(
> 
> Given that, I'd be inclined to "fix" it as below, or just give up and 
> delete the whole thing.
> 
> Thanks,
> Robin.
> 
> ----->8-----
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index 5c5cb5bee8b6..7b3f7fd6e527 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -230,6 +230,7 @@ config TEGRA_IOMMU_GART
>       bool "Tegra GART IOMMU Support"
>       depends on ARCH_TEGRA_2x_SOC
>       depends on TEGRA_MC
> +    depends on BROKEN
>       select IOMMU_API
>       help
>         Enables support for remapping discontiguous physical memory


Thanks Robin. This works for me.

Thierry, Dmitry, we need a fix for v6.1 and so OK with the above?

Jon

-- 
nvpublic
