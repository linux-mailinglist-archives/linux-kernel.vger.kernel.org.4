Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5E676CB73A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 08:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232509AbjC1Gdd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 02:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231987AbjC1GdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 02:33:23 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2078.outbound.protection.outlook.com [40.107.243.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35521C7;
        Mon, 27 Mar 2023 23:33:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RnVP7Ee9NnoLKw7pPHAuXbVrDSZNKgldxOFn6nSbBzG2+OMDs5tDk/bJ9MNfHxutHgMnHMK2h+8Ku+GRBomXXiTv3XFaMdRTbAMadASR5jE5aRwZjVBVbq5y+zKbILEAFnYYs5mrxKPrGhWQss/aiGpDwtziYbmZx7NV4ouKnLc8C1CkFtSQGUzNonzqb72h2qzFx8g1LkOlz6RbZ/bXdTLz4GV857p4yRsu3bXr+4OS6TfXVbuFE+Cq9lDxpCHi55Uga+BUVgDzuGiWol6aSQUfS7Q2c4oP2TU7fl1gRJiuhcUb63pkr0ucA7iHoa6/maMLha0X5dv62bHNmMXogg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=htFUwWi0Vpjhzt67o5WZWMfw/duV0pqNQh9DHqPFCc4=;
 b=hapozWf3ZSFTHW0WqYlp6ksUVZdJqwtiPUy4fKtQrQpfi4/Ob/XLTuhO4667UabZ5s5kZ7pwlEbUMxkgBJ6iUpPa+Qby9SU4VJB10HFsRF7t0dmNfHEaIbOl6nqDpdPle++Brtl3F3WCaKdackxQ80I3ZvT+KTui/MHvJxziOa19xsnH3Eb5JoeD92wBrYwebaSiZ58CJdFYA3u9lvH+PKte9vaWIXmv4vHQVnxlYd9Megxf1ue6YHm2vGB2f3y542P7cvwFEWgOSB8d2NJvi1axkEtW/eI+blSnozqQ10ENt2g5fBamILuuevK0xzALEUfJ5+3biuOnQWBkcczANw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=htFUwWi0Vpjhzt67o5WZWMfw/duV0pqNQh9DHqPFCc4=;
 b=aUcap+aResxezalCSnXSc+6aGcjkMxW5g/vU4nBW35mCi3VJ6C08VbUi7si8gPs6TjWdTgBXEQZoqqhhIgNs/z8jmB1JOK0ZE7qHWHvUx+5IUcg+o9GDyGoCw/iHnxHMcydjsUWxczXc903j+rdHwPa/nZpma9ITnzGYlT/sn9A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by DM6PR12MB4514.namprd12.prod.outlook.com (2603:10b6:5:2a7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41; Tue, 28 Mar
 2023 06:33:20 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::4d07:7f52:c833:9603]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::4d07:7f52:c833:9603%6]) with mapi id 15.20.6178.041; Tue, 28 Mar 2023
 06:33:20 +0000
Message-ID: <68ce9aed-f5a0-ff43-27b3-651773eb3258@amd.com>
Date:   Tue, 28 Mar 2023 08:33:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH -next] spi: xilinx: Use
 devm_platform_get_and_ioremap_resource()
Content-Language: en-US
To:     Yang Li <yang.lee@linux.alibaba.com>, broonie@kernel.org
Cc:     michal.simek@xilinx.com, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230328061524.77529-1-yang.lee@linux.alibaba.com>
From:   Michal Simek <michal.simek@amd.com>
In-Reply-To: <20230328061524.77529-1-yang.lee@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR08CA0267.eurprd08.prod.outlook.com
 (2603:10a6:803:dc::40) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|DM6PR12MB4514:EE_
X-MS-Office365-Filtering-Correlation-Id: 94e7770a-596e-4928-a234-08db2f56526b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cRxeHaXoal9HqHl6c1IwMNM614ImJXm/pKb86EkPpxErpVIH0K6+zrY3rxKDCruK2Rc++1w3sd2T0CaOH6TojZTUUz4iHgCE2eBR6OohbXoFC1zFjJF0WaM9jdRiFJAcV7c/0Cysc9yoSrC3vfG3lyCNRK8edSx8BY0aZGUS88GeyvnJxa7/ENRyr33Gx7AWbPnKboTZ+3hoF7bvJYvO6HblRbszyNAWlb/HnFfwfbbssKHoQVPdP1Vj1KOox7bu0hC7TPhOu6H/KxTasan6D9rf2o55lwb17yYEBCa6S1019Jw+8/KUQ1djjC123MEu+YONP89kAV983+OOZTaKMte2vE4pZExzxJqqsqbUaxP5B12lFnIp9HIEHvTekegsprFTACrIMFr4bK0W8yDAh7viXmLyEoDQ+e7kSEg+0N7pJT/1YLfLlqiDxyecIsWxu8jmALVP3uEVCj1PAosWV9g8ZtWSlKXi2irb+uWxEVSCVnaF70H5Vc4Qls2FX6PLleuh4v6rXya8117e8uFrN2JMxfkMiTo2nxiALhk0zbdqS9UR304c7ZSc67XMJpL+ELU8FaIRRESXNR+Y+bSMmszqcDo0nBgAfX5V672xjp0lFtFAQ7ecjG44gH3tIAi++KNB+GhR0aU55jLI7KFgzg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4758.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(136003)(346002)(376002)(39860400002)(451199021)(66476007)(66556008)(26005)(66946007)(8676002)(53546011)(186003)(6512007)(4326008)(316002)(38100700002)(5660300002)(8936002)(41300700001)(2616005)(6506007)(83380400001)(6666004)(6486002)(86362001)(2906002)(31696002)(36756003)(44832011)(478600001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c1FiWVdETWJRaUQwcFgzb2RURzcwUDRvKzlDSzJPOWx5SEVWemhSTUJhQTFs?=
 =?utf-8?B?c1g0NzlWR1hFQXVTM0RvUjRTSU9WRzhDVU5rdjZyYUt3eTg3K2U2Z0hsNFBv?=
 =?utf-8?B?bFNzMmJ3cGlzMEFHSDN2S0hDakJPUnJ0dnF4QkdQeFF0cVh6akp1QWowN2RD?=
 =?utf-8?B?U3pVSzB1aUswN2ZOQ0k1Yi9oZncvcHF1bklIZU5wcjNwTUlyVEVyR1dmWDFq?=
 =?utf-8?B?ekJYdStPK0s5WmtRcit3bndSY3V4UkJzajVTdWlLclBxQUJiY0s1TVUwbHpT?=
 =?utf-8?B?ajY3aWZsczM3aGsrb0NJYUFnVUFhYmpjK0trbDBKaDZ4T1lTUkR4Y2gxSGtE?=
 =?utf-8?B?VGg4eEY0aUdqUW0zUHpaZ3ZHdVBmQUNSUjUvaXhzQU4yb21CQXdKQnB4TXpl?=
 =?utf-8?B?R2RkMm1qRXpRbXVPbS9GRWhIOXRJekpSWlFIb1VtZWJTRTFFNEdtVHloQnFt?=
 =?utf-8?B?azNHR3JRK2cwTVBobGZncEx6eFI3Rk8xU2V2V0ttaHB2VkZGVktiZTVKVmhj?=
 =?utf-8?B?NDd0djJ6ZTV1Z1J6ZVdjOEl2MjNqMmpJWUtZTTR3NE50cTNnNm5heUtPQ2hK?=
 =?utf-8?B?QWthbVQzTGhYL3dSa0szaE5oa2xDMURRZU43RzVFNERuUktsd3BpN0dTYk5E?=
 =?utf-8?B?UURmUUxsSUtDVFF4YzZSaEhKdlMycFZvbzBuWkJkcVBTS1lqSlJFYVplQ1Ro?=
 =?utf-8?B?VkN2S2kzSXVVSDYrdjlBYjlLbnhtalFKcllPenlHQUVXQ21tNDRSUEJZVDc2?=
 =?utf-8?B?cjVSdFNSMC9NVHlPSDRlM2FwbUt5NEZJT08yWXhwWjdvcDhxNUg3bFZYZ1lM?=
 =?utf-8?B?bDhLMzIwY0ZlK1lLcWV0K1FYN0RyazJUT0RGSGNrRHFYVVlTTlBtdVZnNUVv?=
 =?utf-8?B?U2hmZWVVR214REUyTzhLT0dmT3cxUFQzNlV3MHV5VStncVA1MzQ2ZlI2bmVs?=
 =?utf-8?B?TzVYN3pxaXoyNk9Ldkg1RjVvdXJmT3paV00za2NwYU9PckFRQ2RNZEk2VGh2?=
 =?utf-8?B?bFJ3ODVSSk4zSmhmOEorNWFTVnBQb05NWll1TGhqVjZXSjhKSDB0cmlXL3FW?=
 =?utf-8?B?WkdsZ0NaUStTcWhIRmcrS0IxUHZaV1ZNRVdCQ1IrTnVJZUJWTG9VcUhha3Jm?=
 =?utf-8?B?RHk1ekExdzZpK1J6bG0xbVpDbXk3THVOeHVjSCtVdjVSVWNnb3pNU1NablhB?=
 =?utf-8?B?bG5KUWZjMzlYQTlQbnV4ckw1dEsxM2dwMDJlbkhFQVB6OTE3dm9LcGYvY0J3?=
 =?utf-8?B?Tm4ycjVWR2tuYlVPN1ZRUXZHanRCQ1k4V1A1ZFdJMWxkN1ZaWXVvTWN3Mmxw?=
 =?utf-8?B?ZXpzSjdJTW1FcW9xbDVQV3FacFVpcXZwR3kzckVuU0VtVGMzcHRFUENlYU1i?=
 =?utf-8?B?UFowdi9oTXBrWnJXanFFNWNlL1NsODdZRkZVbnhuWEU2MmdLUjFsNElzS3FD?=
 =?utf-8?B?NHBLVmNHbk83bS9ibjB3QWJEbU1kRU80MTJ4dUpHc3JCd1lmek56TjFqLzQ3?=
 =?utf-8?B?RENwTzBwSWtCaVpaWmg2Rjc2YVJKclhGMEo3K00xc1k3amFwb0J0YTRBdTZh?=
 =?utf-8?B?VHRzZHZiU0d0YUhVRzluSVU2R0ZLU202b0JLOTlXNDE4N2JhNkQzSVJleS9s?=
 =?utf-8?B?eFhmWTJtMXFBOUtpMFpBLzBueE1WclhYbjFqUW1YME9vbWpqZkhWRmtkaXg3?=
 =?utf-8?B?Q2h0N1hJd204bFcyWEVzdWwyem1vVWhNSXIrQ0FDdnRHZmFQb2RyWWFSZ1F3?=
 =?utf-8?B?dDBNbjVCSkV4M1BEcWt6Z2UyaXJsanZVR1c5V1JwcjBVTEs5NCtxTVdWSG1W?=
 =?utf-8?B?U0F1YXlCRllKZVZsVmluZ3VxRkV2QnZxaEhUMkpnQUpLZStLNE5WeG5NTUNz?=
 =?utf-8?B?K0duWnVGYkxlYmxIZlI1Vlk5OC9RQU1EWDZreTlWRHNvK1ZWVnlVQnprUkRs?=
 =?utf-8?B?WFlpSmgrc2JCZmdDQjBTVjRRejExeWR4QmNjR3Bkc1k4aGFQUnhzdzVSbVp4?=
 =?utf-8?B?V0ZXZ3cwY01rL1c5L1lzWHhJUnFES3VSbFdPR2grcE9aenB5WTI4TUx2QWlF?=
 =?utf-8?B?clNKZHZuZmMvdkY3M3Q5cHFMQnR1R3ZrVGUwTHZZNDhzMk1xTnZESTBxMmlP?=
 =?utf-8?Q?9yFYlBgRfsmM9tlr2zt/iOeoG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94e7770a-596e-4928-a234-08db2f56526b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2023 06:33:20.0785
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OXAfwbOgLxVL1mQEWt6QLib3gE90Xt5dHUr0B8nk7CZcUDRVkKTn+9Y+iyGM4TAr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4514
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/28/23 08:15, Yang Li wrote:
> According to commit 890cc39a8799 ("drivers: provide
> devm_platform_get_and_ioremap_resource()"), convert
> platform_get_resource(), devm_ioremap_resource() to a single
> call to devm_platform_get_and_ioremap_resource(), as this is exactly
> what this function does.
> 
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>   drivers/spi/spi-xilinx.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/spi/spi-xilinx.c b/drivers/spi/spi-xilinx.c
> index 5dd3d1901412..8e6e3876aa9a 100644
> --- a/drivers/spi/spi-xilinx.c
> +++ b/drivers/spi/spi-xilinx.c
> @@ -440,8 +440,7 @@ static int xilinx_spi_probe(struct platform_device *pdev)
>          xspi->bitbang.txrx_bufs = xilinx_spi_txrx_bufs;
>          init_completion(&xspi->done);
> 
> -       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -       xspi->regs = devm_ioremap_resource(&pdev->dev, res);
> +       xspi->regs = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
>          if (IS_ERR(xspi->regs))
>                  return PTR_ERR(xspi->regs);
> 
> --
> 2.20.1.7.g153144c
> 

Reviewed-by: Michal Simek <michal.simek@amd.com>

Thanks,
Michal
