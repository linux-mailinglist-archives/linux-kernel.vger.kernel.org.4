Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16FD96AC60B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 16:59:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbjCFP7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 10:59:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbjCFP6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 10:58:48 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2080.outbound.protection.outlook.com [40.107.95.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93257211C2;
        Mon,  6 Mar 2023 07:58:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I4KK/ulWZY7dOWdpcYj8QVpWWnUXaOWaOC8qsH63LcSr+yq7nJdeN/AKgzwchnm+15Xe68zPuhEOTQpkA/GSoz+KvAHNi9C8Xz5W7Km5T2ZGlSnWUcruLNw+Ohk5UjZ74K/m0MRAcOg/DWVSFVAg3XtvVdQWdfzi5m0DeBucGCBqkjCNFtoZmhnJld0XaHXhcw6zbxI1oPi++L7WKZDqZBdhNtuRGlTnV5NrOaodOnDWsb6bt8n2IZVKD4QtAAi4FgIUAtJ8pffUXzccQIDf48Pgg3hIylvYLim9KdDIbNVjOixTLrDqmBixQ4bxuSM4h8mMqQYYUZGa0vVC3viPNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HdKyKNemNXuFMxaOPYy2UxalAxI9Y4j8dgoIJRlLF/I=;
 b=jT7gyxZoF1EMWQEIO5deNCyEcbsEShf16wEhLBX6av7IMOjqmzVYIIUXQ3zj1qc99a5ksfXMAiWYQpCrVMnapZ51HXsr5ZpPTsJ3w2/JGY34SpqaPdFkg/CmdOVayU04twMjK7WxylElHSo+A3SnxlNNU3xtw6yxNMfoF2VdSdNwl4JPq6SrOK27PDBSbg9ANbMpUI+aFXExwF0cScNXV+DfsmOcHVoRTArVY4BBBRDnOMrmLi7NiaMec6RjDx0gxZKIxhnY62vDOpwb55wRBxdSpMu0ZGeLeLcC7exS6Y8I1Tgr8w2F0tyAg6dntyuATPZupjnuns3fXs46tICAFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HdKyKNemNXuFMxaOPYy2UxalAxI9Y4j8dgoIJRlLF/I=;
 b=X1iJ7S06bx5P2XK4cot+0eZzFl9Sq2m/Gjh2zvp101g7CRhaRiPlTdgu7s6Jp9Cl+Qv9kd269XQewX1XtX+iGrpR/2KXEKNJo8fRFTmP+m7BsWuf1yLlUMJXOPeaQMokTAPdpE2TGBtRq1cbdUrfB9wMfLPKCr6Tm4A59ac+ipq2S5lTvMDfifIDbhOqyfKDhZMGQhsIv/HbwILxM+Qc11wua5HTWYul6nlomiLkUEDWUpluIV4JJ3QCEM+p+xzAtV4OaR5/bDFT3kqq3jqPsxpEggCIbGMwc/wUN8guCiGm34CBp5mYVbDZIb2tNmY0BnK1OAI2rt/fHG6cUXTD7w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 CY8PR12MB8195.namprd12.prod.outlook.com (2603:10b6:930:77::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6156.28; Mon, 6 Mar 2023 15:58:44 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::5464:997b:389:4b07]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::5464:997b:389:4b07%8]) with mapi id 15.20.6156.028; Mon, 6 Mar 2023
 15:58:44 +0000
Message-ID: <3c1354b2-831e-d523-a539-904135fe34f4@nvidia.com>
Date:   Mon, 6 Mar 2023 15:58:38 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] soc/tegra: cbb: remove linux/version.h
Content-Language: en-US
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     kernel@collabora.com, kernel-janitors@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230303130346.2062989-1-usama.anjum@collabora.com>
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <20230303130346.2062989-1-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0073.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bd::6) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|CY8PR12MB8195:EE_
X-MS-Office365-Filtering-Correlation-Id: c5f40f67-fd30-4fd9-4fac-08db1e5ba9f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wB21IPeWv1XM2PGbxXOy0eIQ3PpxPjnGQMeGsLEyj9s7Mshj9csAXFrWGDocMhC1Y02QHU3uG43OxALuMYbIPKr++3zCC2KZj0xsElelg/oSBPC+PpteUpqAmhn6dLtu1S50UYTjAwpZgOPEOqwJFB9puxzqKJ7Qtfh2LF3E+WttzkngNeCuCJ/vlfWbrdYm+YNHSUTAV3dr2lZDUSkTSnhXgUsHaldA48vJNI7N8pBPVzqkaLh9ygdmXjo86KUCKdocpUwxLJuKewkHEaz4MMxZSim+U2eR8cN304gi0sBdckbDXrSnE3F7GHQaugQryqhfBhdCLlbXLJuQlfmHHIVY/AvmM6z2UdO+D1b7SM/e/S1uiwni3hqKa3nu5hqF/4IPz38RhWzXuha0nlEpOhOj4BiZSQGGK36HRH/AgXPU56YHaGcZGcQ2x+iDbFKMKLYP9EUfehK2/Y14lT8h5Kz2pvUZ39piUFzxQDogHTETwAisl2EfEKm0LwJb76RM7J2S3ssSXfRLfllHQaLzMTLJfgxkqPrsfppdzKcR9/iq6Vt0Wcy3PDzDFrwgbDj35b6bpTlRlmQlMaNFPqISiJjMa0VGGvtyNIxSbXh6e5EGCVxOpZo+mWjEa3CpKcYJ7rj9kCpcGTfbPkm38Q0cAKCii8A2r+qoI/CRMubd3LW8RK0W1daoD5lWsllJUh1Z6Q1aPnbRbeCtvHEP53eRu9bs/fSAb8N9O6iaD4J51tk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(39860400002)(366004)(136003)(346002)(376002)(451199018)(6506007)(6512007)(53546011)(6486002)(6666004)(36756003)(83380400001)(31696002)(86362001)(38100700002)(186003)(2616005)(41300700001)(66946007)(66556008)(4326008)(8676002)(2906002)(66476007)(8936002)(31686004)(5660300002)(316002)(110136005)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VjJxeDhwaTdyeXFGbThTSXowK21QdDlHM3A2N0hYbG9kR0QxSzJpR0dNVnYw?=
 =?utf-8?B?Q2pRS1kxbVM0V1pUc3NjdXdUMWswTmJuMzljOXN4d0FyMUZneGl6RFZLQS9q?=
 =?utf-8?B?OVRLajR1NGozS2Yvd041U3h3Q1V3dzZjRjVmWmVqL1JCd1RXY1VlUmQ0RHZB?=
 =?utf-8?B?MUF0VUJvcUt2TTB2OWIvaHNIWkJWTlN4cUIxNnIrYWpNVk5jRlQ2Q2xQZ1dO?=
 =?utf-8?B?ZlpWSWVTYmpmdnQ4UXNaL0FNS3ViRkhsV1haSG1RWkZnS2hxb1FpMWhQeGZG?=
 =?utf-8?B?d3VGRHhqS3BvMUZhUDdGS2ZocTJidGt5eENqWUN2blU5dDR6WmFHMmxnMmh1?=
 =?utf-8?B?UnZqZXcxZ2ZsZFlxdGd2c3lOZXhQUHU5ME0rUndyR202WWxEL0lCSVlGUXFP?=
 =?utf-8?B?Z0x4OHBOTkUyMGVuaDNHMG5iRm5YRUZLcTd2bm95MzJETEM4MjVkdGdRejd6?=
 =?utf-8?B?aGFPYXBkeVBsTzFWSzZ5MktPNXh2VkU2TXYybjF2R3Z0aFpFYlRSM05Jczh6?=
 =?utf-8?B?Um9sMllpQmlPcVh0UmdmVFF2bm5uTFlxalpILzNOUFlXcHRVL20xaDNIenRZ?=
 =?utf-8?B?ODdRV3ZjRVRINktUbHFwTzBhZ0hXa0owWFpOanpCODRuVWtvMkh4Y2tsQzhX?=
 =?utf-8?B?cmpsaHI4bUtyVzY2dnJXWTlYaXArUE5BaVg2TEg1YktTS2ZLeWppdHVjczRT?=
 =?utf-8?B?UUZNdytLbXhpcUVPMW1oZFZHR0FQNWdwbTZGUGtGRHgrT3JWWnR1aXZsQ3E2?=
 =?utf-8?B?V3BKUTMwVVNYcmlLUThqS2tQRmpSbkZxY3d3dlBNeWNQNnd6djZ1NXVuRW5x?=
 =?utf-8?B?ZUJqSHFhby90L29LamprRkR5Z3VrRStIOWJtVXZwU3VTRTMvWDc2N2RFaGRa?=
 =?utf-8?B?OVgxblJHaWtWK3JYUXFNRU94alZTaUp1anFjaGlwR3Bodld0V3p2Vy9LWEhv?=
 =?utf-8?B?Q3prODRnUmo5MEVaNkMyUUI0SXlLOTIydWRmaTVzMk1CcXpzdVlpZVpNaEhZ?=
 =?utf-8?B?NExQU1pQbFJVQ0tyeENKR0RlQWdSdmR3MXoxeGhOcU83anJtTjVFOTdwSTN5?=
 =?utf-8?B?djhvOGtCN2ZOSEZ6ZU9Fa2YyMjhqOTVkNVlRcFljWTA2b3ZHbzdWdVdXSEJQ?=
 =?utf-8?B?eHVURXFmVWVIOGdHYXNjcS9qa3BQVkdtalRKSDVYYWJxMlErcStnNkNmYytX?=
 =?utf-8?B?em8xdlhHbXAyQldCeHVwYmRweTB3Ulp4NXliNUk0YWppdjlya0ZaT2gzZHd1?=
 =?utf-8?B?RjZkL0hDbE1QWWswd0UxdzRZL29UQ3RWODZkOHd2RHdrekNoWGhUTkFzSnJS?=
 =?utf-8?B?NHN4a05lQisreXBIc3lVUWwrcG5XQm0xZFVENWdDNE1reTFveGFhanIyS25J?=
 =?utf-8?B?S21sYVprTmJtQkVKTWhtenZIMVRzeHBrTlVVL1AwZ3lFTkdMOC8wVDBCeU9K?=
 =?utf-8?B?RTdndW93VGp3V0h4QXpZZkN6YVdxYmtIZ1VaUVhHZkNxREhITzU0dURIc2lX?=
 =?utf-8?B?enEvbmUwdnE0UEx2bFUzdmtFTkxwTTl2ZmVpVlZQOXR0NmlrU3pucVAvMHdX?=
 =?utf-8?B?UkNJc0cyQXo1eTZPcVlzbUt6dEgrblZ4SzlGTnpPa3Z6akRXZGtMSk1jd3Zr?=
 =?utf-8?B?eGJsUXNzM3dFRTJ2SUQ0eDdkbTc3Ny8vWlJYak9ra1dweDQ3V1gzSDNqZDJT?=
 =?utf-8?B?S3BkTjlwcUNHOFowTzRJTEhQclFWcWFWZFJpUEVOS1BNZjk0eWMybTlVR3ZJ?=
 =?utf-8?B?ZFB3ZXdBZlU2VURSUEVtakszY2lzY2JlZjVQdEliL0RTNE5Nam82TGJ4aTJS?=
 =?utf-8?B?eVFQbGo3TEJGRElLSmRycUFBdnIrbEZDNk0ydzZSNUE0eEtqRWo1UWg5WlU5?=
 =?utf-8?B?QXdsRVVpQ1p5eDd6eXFHYkI4cnRhYWl6bjdHR2J0dXZmTUFZa3lnbWNYZ0tG?=
 =?utf-8?B?YVBtOXZPRXIwekZlUXBqbVd0MURsNlo3QWlQNG9XOGFScnVXYTdISHNwc0h6?=
 =?utf-8?B?a2xWajhZTGpjM0RySlQxNi9VUm1MVnFLY1FsMlh2OS9NZTlOMGhCVHUycDFE?=
 =?utf-8?B?MHNvRU9xWlA0TmtXamVWSnhLK0Q3MWtYK1dLTnc0a2wyWWVBTVVHb2tnN0gw?=
 =?utf-8?B?aThHYTBzUGdEdXZOUjZBSTh2ekxDSk0vcDM1WmtQZ0pCMGxZcUZOQlJEdFkw?=
 =?utf-8?B?LzZCek52aFJydnZEM0hNcExWQmxGa3pWSXI1Z2RGV2NZSUdjeXJQbVpMUDJr?=
 =?utf-8?B?ejhFdDhHMWRoK2hKWFdJVHBvU1lRPT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5f40f67-fd30-4fd9-4fac-08db1e5ba9f9
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2023 15:58:44.8114
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7w3irN1toy3DD96yOEagZMwse4evES/KHkJQ16ax4mS65kYdhsSb+pm6FZscq5/x1c+jh/YkCN7mjuXmPj0Inw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8195
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 03/03/2023 13:03, Muhammad Usama Anjum wrote:
> make versioncheck reports the following:
> ./drivers/soc/tegra/cbb/tegra-cbb.c: 19 linux/version.h not needed.
> ./drivers/soc/tegra/cbb/tegra194-cbb.c: 26 linux/version.h not needed.
> ./drivers/soc/tegra/cbb/tegra234-cbb.c: 27 linux/version.h not needed.
> 
> So remove linux/version.h from these files.
> 
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
>   drivers/soc/tegra/cbb/tegra-cbb.c    | 1 -
>   drivers/soc/tegra/cbb/tegra194-cbb.c | 1 -
>   drivers/soc/tegra/cbb/tegra234-cbb.c | 1 -
>   3 files changed, 3 deletions(-)
> 
> diff --git a/drivers/soc/tegra/cbb/tegra-cbb.c b/drivers/soc/tegra/cbb/tegra-cbb.c
> index a8566b9dd8de..bd96204a68ee 100644
> --- a/drivers/soc/tegra/cbb/tegra-cbb.c
> +++ b/drivers/soc/tegra/cbb/tegra-cbb.c
> @@ -16,7 +16,6 @@
>   #include <linux/of_address.h>
>   #include <linux/interrupt.h>
>   #include <linux/ioport.h>
> -#include <linux/version.h>
>   #include <soc/tegra/fuse.h>
>   #include <soc/tegra/tegra-cbb.h>
>   
> diff --git a/drivers/soc/tegra/cbb/tegra194-cbb.c b/drivers/soc/tegra/cbb/tegra194-cbb.c
> index d4112b683f00..a05fc2caff3b 100644
> --- a/drivers/soc/tegra/cbb/tegra194-cbb.c
> +++ b/drivers/soc/tegra/cbb/tegra194-cbb.c
> @@ -23,7 +23,6 @@
>   #include <linux/of_address.h>
>   #include <linux/interrupt.h>
>   #include <linux/ioport.h>
> -#include <linux/version.h>
>   #include <soc/tegra/fuse.h>
>   #include <soc/tegra/tegra-cbb.h>
>   
> diff --git a/drivers/soc/tegra/cbb/tegra234-cbb.c b/drivers/soc/tegra/cbb/tegra234-cbb.c
> index f33d094e5ea6..e23e8acfd7c7 100644
> --- a/drivers/soc/tegra/cbb/tegra234-cbb.c
> +++ b/drivers/soc/tegra/cbb/tegra234-cbb.c
> @@ -24,7 +24,6 @@
>   #include <linux/of_address.h>
>   #include <linux/interrupt.h>
>   #include <linux/ioport.h>
> -#include <linux/version.h>
>   #include <soc/tegra/fuse.h>
>   #include <soc/tegra/tegra-cbb.h>
>   

Reviewed-by: Jon Hunter <jonathanh@nvidia.com>

Thanks
Jon

-- 
nvpublic
