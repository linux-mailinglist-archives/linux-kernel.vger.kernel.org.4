Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E05BB5F9867
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 08:33:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231310AbiJJGdC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 02:33:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231287AbiJJGc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 02:32:59 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2045.outbound.protection.outlook.com [40.107.93.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6FF956035;
        Sun,  9 Oct 2022 23:32:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dzdGLNi5CjJxeHJ0ypxuIxO6eBfhEhgupXs+CQBAsonXie5B5Am6XBc8NtTNFjbzJVHU7YD8AREE9aZkaZciOoRaCc0Xt7QQbeD/M/JLRtGimhx5HrY1RYL/xNjh1/DxNMCUTf7DKXTUSKs+4TcPdxrDCrRXHP8Jf9XRwTdGBXKHwY9uWxBVDna8YK1rGLarqmnDoraWMrMhF5qYj11tZzHfgovYZsUtum+FPVFuUlo5ix5L7t0lYOg2L20gPJ6Kb1JAvG2Lc63HvdD7xf6ayZfN9joSOik5w6+bDLZTpmotiuT5/A6ym7j/h1AV2PPyt5NYVHjgwWbYRaUi9sH3dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dwWVsUBRtJBveRTV8XDLtYhpQTMOOaLutFzwaeoRu0c=;
 b=Z9dqh6AyTNAJV85mJFDgeIzunw5WwLQgZIomhpjZqh3Nkilw57j/Oolzq2q4Syp8TorCxmzo5FbR4cb4iG637KgcH8qodopLU4Eri/u3TlYCdzMjiFn2xUiA7rWEOsNtzvi1Z+fsWp6hkfHHMIKPvy/aRa1m7ZxVxDLJsAVfoKJRpkopLKNiei1StHL0UBL9s0IogcB5oNlrdhjgEEXjsuSGjf7WyLvmmfxrOghaEtt5F8mcMnYHHmAK46GbwxuBVHcFFRikji2ePN1MNWZ8hBb0FqcyFEZ4YHdT/zXKvF5au0FFcUMQ+/tUTFYW5ahcTWf8o0Z9Ig9VdaTj7y9fog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dwWVsUBRtJBveRTV8XDLtYhpQTMOOaLutFzwaeoRu0c=;
 b=fK6ozwbY+zKjifCZrUziZ5lyXqWJgUt5iyQp0CgYJpS0APea+7QNyUo2W4QqSEkLscLd7l3NI1HHrsFs3ytHIT2NPtSW78LfvfUTsUngNJb8JVMRpw6sXRlaReS7dh0Sw/sWkmitY0K9dTVHxBrYW5M+/Sb3zWWyhwPyBKKQEbbo5aCmgNJSQCSjV75sILwHy6lPJdS8Ok0PU34MQI70GuXCdaL2s2Ot+zVrMSIsG2KsRQX1WzbR3F88Bvl1Og450Tsmkd3Zx5V+h513sqWQcW9SMTiZ6w8DCX0gl6XSwyJWkixT+RZJFAJOg6PQ4nTI7WbuSbAVq4+VFw+HIc25DQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN8PR12MB2900.namprd12.prod.outlook.com (2603:10b6:408:69::18)
 by CY8PR12MB7339.namprd12.prod.outlook.com (2603:10b6:930:51::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Mon, 10 Oct
 2022 06:32:55 +0000
Received: from BN8PR12MB2900.namprd12.prod.outlook.com
 ([fe80::d9ae:c30e:ce3d:9cb3]) by BN8PR12MB2900.namprd12.prod.outlook.com
 ([fe80::d9ae:c30e:ce3d:9cb3%7]) with mapi id 15.20.5676.031; Mon, 10 Oct 2022
 06:32:54 +0000
Message-ID: <0da02e87-be98-48d3-f66e-2282ad4968a7@nvidia.com>
Date:   Mon, 10 Oct 2022 12:02:43 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH V1] arm64: tegra: Fix Prefetchable aperture ranges of
 Tegra234 PCIe controllers
Content-Language: en-US
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        mperttunen@nvidia.com
Cc:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com
References: <20220928062731.18032-1-vidyas@nvidia.com>
From:   Vidya Sagar <vidyas@nvidia.com>
In-Reply-To: <20220928062731.18032-1-vidyas@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1PR01CA0172.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:d::16) To BN8PR12MB2900.namprd12.prod.outlook.com
 (2603:10b6:408:69::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB2900:EE_|CY8PR12MB7339:EE_
X-MS-Office365-Filtering-Correlation-Id: 9318666d-9f5a-4ed4-9388-08daaa89435b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fvDSeZEXc57oakv9PKcJs0TOfFhQp2WsDCikfMv+x1L3B5ti1x6qUp4+i+H1cS+Hp/VlKBlvUizAckq/ZfpZNmWT4fehRPkq1OxEKcA90rBJrDBenBtujO9rerHIGNhUXL2d8A/9PJ6i+ePtiMWdl7PxhtwM1du5ZLgBKil4RkmUifTkT6xMMD/3qLqdObc2RTDyoe6rYIILdV78JR9VyBzZIADGxqo+Z4FPooWlkuDJf6gsgtGU5Y/G7+oHlMc7vkWipj3OgVivK/+lF2hiDrmxSeWmBS8kTzgmPQTqfOPtCAofMukU9KK1rLlGvH1sEgbIkphXvw06z/XsVHMsVsQw4WwU+/b0NkXsA/RzfnRNwWUZ4TAnIKS6nj9o4eZCpbDKT/I4s50ePdab/nzS+/i8Lq2JJ13tWjHI4ki2udcRr/oPHCawg/fbrw7pgqH+QHd8SSp5ynZwT8DkH+Avhswh1g642rRlmzDoi1hIZ7Jwf3yjrdxW/wIE1HPvzNcdEN4RZfh2W7uLZYDDgWbW90H9VDIVAyWfXsMwqE2mg1m5qMp5L+jsjdSzHmNaaYvyOcKKsX+G4cDfuyrPjokLARYazxOm+/57LepuMSUyF7+CUovkVjTyp6Zzt2u27fnyQvd9mgval+qEOs51Bg5vZLMIhl7U+UvrDVYZw5EGo2rue4168FZEKTZ/Bi6eZJvcl5LxLLZpMWfY0j90jItfukmrTn7Mid4UfatnczzS2o/TSI2IyVLIwLh5WOcMwKNC1xY8zJS42l3cyUpmXkVXBs1Oi4R/E1BloQ0sZoApq8k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB2900.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(39860400002)(376002)(136003)(346002)(451199015)(6512007)(53546011)(6666004)(2616005)(26005)(6506007)(6636002)(38100700002)(5660300002)(31696002)(86362001)(4326008)(66946007)(66476007)(41300700001)(66556008)(478600001)(316002)(8936002)(31686004)(36756003)(8676002)(6486002)(2906002)(186003)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T1NNNTc2alVqMVVzNUxHVHZJSTBXVGdzSEc5b1NBUGxxUWpRdzgvSmFvZHpM?=
 =?utf-8?B?UlFuazBWVUh4WDRJbGsvZG5RSk9HRFhYOTFIWlJ3bmR4VzNOTVptNytOdEFX?=
 =?utf-8?B?ZUgwQ3pETytLZnVDM1B6ZUQyVWY1SjBjSWMrSHNQUGxmemVtRjdPZ1VZaDBp?=
 =?utf-8?B?dEsrbEtVcjRXMzhDWFltTVBObHc4aHZ1ZktvQTVZRUs5enFVL3VuQzltS2ZH?=
 =?utf-8?B?Q3ViVFh3MVBrcktjejczVEc2Yys3Z0NVQmp1MEdMVUhnaGkwWnUrOTREdDNs?=
 =?utf-8?B?M0tEaVppYW5NUHpObVdKK1o4azA4VytlMW5mZVVCTGRwWXA5akRSK215Mkg0?=
 =?utf-8?B?eUZNZWVoUlVaY0JaWXltVFdzWm40eTRkSTQ2VlpxeEVpWmtNVTJNOHMxTnZN?=
 =?utf-8?B?VTk1aG82UmttZDFZa2lnVWVyeVlhaE9kT1B0RWEvUlZzZkxwOCtjSitlenYz?=
 =?utf-8?B?QVBQejFmNUc5aVJiVnF4L2pzSTFZeG0wajIrSHJpWFd1ZjIrQzhLelMzbnpV?=
 =?utf-8?B?MnVVMS9YVWxOdVVIWXRza0p6dnpIL1B4c3l2R3NLMkRzTWh6KzVVbHp4RDBr?=
 =?utf-8?B?cVRpMytFdlZCdUNLaWlpbXAxT0VpMVp3ZC8wZ0w1aHM3ek5rRThOd1dtS3RR?=
 =?utf-8?B?eU84YU1lQ0VydEZXcm12eWZjakxHaUgrNmxFbzBnMXVtSDI2NXVIVkJXd3Yy?=
 =?utf-8?B?Y0t2RlNHSXNZd1kvYzczRXBXakN4eTdXQ3MrZ0szaHZkb2djVUZidTNCNEVJ?=
 =?utf-8?B?N2ZTbXlhN2FnVkJ2RVVnSWVUOHhRNWdxdS9ud05IYmZBWktIWTEvcjlVMWQ0?=
 =?utf-8?B?KzVwK3RpQ2xwQWtnSWpuYzdhbXBnelRraGdkc3h6WUtqYXFmejN2UnhDNmFm?=
 =?utf-8?B?QlI5bjd6b0lVZ2wyaDlidU92YktYYnJNSnd6Vno4c1RtSlRRMEo5VmJjZEJw?=
 =?utf-8?B?bEpMRTNXUjgwUGxqclhPOWpSeHVKNmdpT0ZDSXZPMWd3NTJ3Zkt5OURUb1R2?=
 =?utf-8?B?ck4vODA5TFRWTU42QTZHd2dOTmZ4NFhQNWR1SnpReG9hUWZsNWpNTVNKR05v?=
 =?utf-8?B?YmRTZFYvRnV6N2tkM0EvYUk0RUpYZSt1UFJ2ZVhQWlpVNnB0SzF2KzdKZ3N5?=
 =?utf-8?B?TTAwZWllMVY5ZGZJL01pWXdNczlRUnFuMlh1Z0pEWWxheFFIWS9PWGpjaUFM?=
 =?utf-8?B?NTlROG5Da3p3WTg3M1NkTmJwM3VYSzVlTXREQVFKc1dtZ3V6bDRXZzQ2Uy9i?=
 =?utf-8?B?ZmhPbnpTOWpTY3FtVjI2WnZSd3BkU01JdzBGRjJkUVJITE1nb05SNHR6RDE4?=
 =?utf-8?B?U3l2OStWQmljSmhrYjlGNWdpcjF1SVdMQUFBVzFwSDBIM1UxQWZuNWUrVWlq?=
 =?utf-8?B?SzFIRkw4alJiSGszMjUvVWFpVlFGelNLcmcyZ3E0em1KMjZhRURNYjNvcVVO?=
 =?utf-8?B?U1BlQnk4b0lNTmxCU2Z2UFJIcllTR2NqMHIyU0d6UWhldUw3T0xQdEFwSkVk?=
 =?utf-8?B?MUZ4WFFLYVJFK1loaTlSbFNieWpsSmFQeDBsS2NHaWdIWnRqNVEzTjdtS2Z5?=
 =?utf-8?B?aTBmdzd4bngwWXRDRlpJVTVLVDdIazFHRGo1UzZDa1JCRjBaSjZ2aGhZNDZn?=
 =?utf-8?B?UldQQnBodGdLdHdNY3dRa1l1TG1hbXVNMjhFSGVzSDIveFhVdHU2YSsveUg1?=
 =?utf-8?B?Nk1hdDdPMk9kWk9CUnpmenFtQk02RFBQVklyV0tHQ3k1ZkhteEY2d01BWE9n?=
 =?utf-8?B?TU9UVnN3dUVndDJ2M2c2bzlTYkp0OHo3eEV3eEpKL3BYTnU0cmVqYk1XOXR6?=
 =?utf-8?B?VWU2VEN1UFRqbm03ZVRpTGJnRldxSlhuVkZTMW1iWXlkVHoyYURtTjlBd0th?=
 =?utf-8?B?cGY1YnNQOC8wczQ4dTRZQ2IybHVGMCtuQ0NDb0VUaWc4SlMrNTFBZTlKQUd3?=
 =?utf-8?B?bDJWRDc5NVlSc2NDNUluUUVDTXYzRFJ3QzNMQktlMm95Z0pjZFMwTVpTeHdv?=
 =?utf-8?B?THFkcGtIYmdGS1BLVkt1b0U1U0x0M2svTWdaZkM2RzEyMWpheVREUVNxY0ZT?=
 =?utf-8?B?ZndJd1ZpWXlsZktOd1J4T1hqeUJlNUVxZFpVdU1sclgvcEZ3ZjlLVHZPWGlT?=
 =?utf-8?Q?TrfkTbUe+DN3xiuSHeLoS3kmM?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9318666d-9f5a-4ed4-9388-08daaa89435b
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB2900.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2022 06:32:54.7256
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3eIzQhNhPzA0+kEm+7dA04UC/CFQj4m72TIeGkpiFSjjk0KNCzaW61R38Reamr8EZKb36SjEZE0oibDB1CNbfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7339
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob / Thierry,
Any comments on this patch?

Thanks,
Vidya Sagar

On 9/28/2022 11:57 AM, Vidya Sagar wrote:
> commit edf408b946d3 ("PCI: dwc: Validate iATU outbound mappings against
> hardware constraints") exposes an issue with the existing partitioning of
> the aperture space where the Prefetchable apertures of controllers
> C5, C7 and C9 in Tegra234 cross the 32GB boundary hardware constraint.
> This patch makes sure that the Prefetchable region doesn't spill over
> the 32GB boundary.
> 
> Fixes: ec142c44b026 ("arm64: tegra: Add P2U and PCIe controller nodes to Tegra234 DT")
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
>   arch/arm64/boot/dts/nvidia/tegra234.dtsi | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/nvidia/tegra234.dtsi b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
> index 0170bfa8a467..9b43a0b0d775 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra234.dtsi
> +++ b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
> @@ -1965,7 +1965,7 @@
>   
>   		bus-range = <0x0 0xff>;
>   
> -		ranges = <0x43000000 0x35 0x40000000 0x35 0x40000000 0x2 0xe8000000>, /* prefetchable memory (11904 MB) */
> +		ranges = <0x43000000 0x35 0x40000000 0x35 0x40000000 0x2 0xc0000000>, /* prefetchable memory (11264 MB) */
>   			 <0x02000000 0x0  0x40000000 0x38 0x28000000 0x0 0x08000000>, /* non-prefetchable memory (128 MB) */
>   			 <0x01000000 0x0  0x2c100000 0x00 0x2c100000 0x0 0x00100000>; /* downstream I/O (1 MB) */
>   
> @@ -2336,7 +2336,7 @@
>   
>   		bus-range = <0x0 0xff>;
>   
> -		ranges = <0x43000000 0x27 0x40000000 0x27 0x40000000 0x3 0xe8000000>, /* prefetchable memory (16000 MB) */
> +		ranges = <0x43000000 0x28 0x00000000 0x28 0x00000000 0x3 0x28000000>, /* prefetchable memory (12928 MB) */
>   			 <0x02000000 0x0  0x40000000 0x2b 0x28000000 0x0 0x08000000>, /* non-prefetchable memory (128 MB) */
>   			 <0x01000000 0x0  0x3a100000 0x00 0x3a100000 0x0 0x00100000>; /* downstream I/O (1 MB) */
>   
> @@ -2442,7 +2442,7 @@
>   
>   		bus-range = <0x0 0xff>;
>   
> -		ranges = <0x43000000 0x2e 0x40000000 0x2e 0x40000000 0x3 0xe8000000>, /* prefetchable memory (16000 MB) */
> +		ranges = <0x43000000 0x30 0x00000000 0x30 0x00000000 0x2 0x28000000>, /* prefetchable memory (8832 MB) */
>   			 <0x02000000 0x0  0x40000000 0x32 0x28000000 0x0 0x08000000>, /* non-prefetchable memory (128 MB) */
>   			 <0x01000000 0x0  0x3e100000 0x00 0x3e100000 0x0 0x00100000>; /* downstream I/O (1 MB) */
>   
> 
