Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2B9264D25F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 23:28:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbiLNW2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 17:28:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbiLNW1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 17:27:54 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2072.outbound.protection.outlook.com [40.107.223.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22CCBEE00;
        Wed, 14 Dec 2022 14:27:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RqJ0huxAZbGLxtXvBiODHwE74CiH08JgjG+DeNJNX/Tr4oZMeMKotQQkKvMikMR+iryNmmH4a+RyA/ILzzNQxEfAR7aOP3+gLpM4uQE5twaVpAOfR8bjDn6iYw6u1zJNfuBhLUMkzub5aIbawHeXTnRDmiP1ffo2SqkSz7pJdQiuGpofPGEKy+RCOV1GHOHNx0A+TrLVuEOzL1nr1sUKq/Ept9AT5DSZ7TPnlwcvuA/OJhQs6EoqcwSdxOkKE4dPXELHSp0nkIgl6V5zIU1vM4+3YLUwFIvpoMPP/Er5ZQ6SwPkA1w6LVZ/ezCMly196rLCxtT1UIVMSSWCBqIdeDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=swU1kWX4VKZ1QbmbvHAIQuWZ3h1tVaCGU0NapjXCewI=;
 b=n9oemutsxxx0UVT1EuvWjZz9/vLbL8RuHSoAYz5PWLsusJibyUrdSZ6UoSleEd+ryc1y0+LDUOLFno0ChohqR7YfV7Ijl+gkD26tg3QO2x7UbVT3BMakE2WK2pz6JvF3UjnSnczEdZQCEGmlMZWSYEibO2byiqO0hQfoaFVXRV59O8EDqFrezoffSSwnbNo/qJLoS9X1j1evgFBGE1kkwFqfzfK/hLelw4zuMWCtmooT6BblZXcdfISArVkPv2S0CQylbaO7B5xAinA1OSwHCFCx41fc/0p3Tb/SoxgByQIYzkOF25bPmaA/407p7k5Sujb2OztjFW6ubr7PM8yCaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=swU1kWX4VKZ1QbmbvHAIQuWZ3h1tVaCGU0NapjXCewI=;
 b=yMyfnWbNyMMSGGubEF3xC6BAGfpXEaZ7RmY5p8larkU+MY6/D2Nz2w82q3EnFWhfDMq6jy7T19tpsErLydFFlkQ2xbe9pN/db2kTp4qeW3D/UyTMoMnmwdIuJpk9tTydL6uqePjcAeXYex5vVfT6v39RF2Q8+TNkaW9tac4Hufw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA3PR12MB8021.namprd12.prod.outlook.com (2603:10b6:806:305::16)
 by IA1PR12MB8309.namprd12.prod.outlook.com (2603:10b6:208:3fe::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Wed, 14 Dec
 2022 22:27:48 +0000
Received: from SA3PR12MB8021.namprd12.prod.outlook.com
 ([fe80::1948:f95c:ea95:8696]) by SA3PR12MB8021.namprd12.prod.outlook.com
 ([fe80::1948:f95c:ea95:8696%9]) with mapi id 15.20.5924.011; Wed, 14 Dec 2022
 22:27:48 +0000
Message-ID: <2ad011e7-e8e0-9e53-6062-7f922f8cbf43@amd.com>
Date:   Wed, 14 Dec 2022 14:27:46 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
Subject: Re: [PATCH] remoteproc: Make rproc_get_by_phandle() work for clusters
To:     Mathieu Poirier <mathieu.poirier@linaro.org>, andersson@kernel.org
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Shah, Tanmay" <tanmay.shah@amd.com>
References: <20221214221643.1286585-1-mathieu.poirier@linaro.org>
Content-Language: en-US
From:   Ben Levinsky <ben.levinsky@amd.com>
In-Reply-To: <20221214221643.1286585-1-mathieu.poirier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0P220CA0028.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::11) To SA3PR12MB8021.namprd12.prod.outlook.com
 (2603:10b6:806:305::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB8021:EE_|IA1PR12MB8309:EE_
X-MS-Office365-Filtering-Correlation-Id: 68132b62-3f2c-4c37-a9f2-08dade226e44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dwYpYS67cJfCA7O21nkDSlzHxJN3jBJtxMx09kKBxEvWX3C8gpPs2J7AUyR1n3kpUMby9D4OsiLW8FurkEN0RGpg6LHPIcryDfedNd80Pg+aIX7uU0BEovWtFS4FAlvjTnkyI1rEhSsDzCN/FX6fkPGf76wQkvlBtAJNEdKW1GiSyDKLpzXo5YWp72y2qmyzvYwtHF0KUanu3J1L7L54WhM6D/NRvxiw+NBAIABJYSdX299m0VP5j5U3kZlTzwL9EubTzT7p7KQcpB9J2vvF0GE3ep6g2IF+shilc18gH4fx9POE0ibUlkuJYHN539X8Wtx96yRz8XGlU0NMsVmsRdA9Sy6svMVsE8inSr15c6zk5dAZKzZpU9Q8hqlSzZB8s4utJqW6bOlMyMD6C73D/GefQgbXul9Tlg4SQcJlQIu7Y9CraojqOqAJbmlJGZOAlCZh+Ea0wWV6zDEKnhnAr4CtKiUf0WjiMM59gw1CGYb+aK7RqG+PZgkJArW0+ZgpCJ/O4ASxEkf4TtwemeapG39aLFtmkS1I1yCf21E4sEUEVEDbogPIRDLLqmb5Q4Q6dySuTVD94zluHuJEZG5hTvGFLkqnRW0qOZVnTUkpTi+VpE8PrQASXqfOZziJw6munAZuPG481sZrJiMwmbM8vf6ccIbHtWCUN+UBeOTN0O9XWB4uZ86NPOMLPFlSv0vkAY6QQJJNFCN3CLcFEAeoJif12smLuqXezG05xEu0a4o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB8021.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(366004)(136003)(396003)(39860400002)(451199015)(36756003)(8936002)(31696002)(31686004)(6486002)(38100700002)(478600001)(86362001)(44832011)(5660300002)(53546011)(41300700001)(4326008)(2616005)(66556008)(186003)(8676002)(66476007)(66946007)(316002)(6512007)(83380400001)(2906002)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OU1rNHVtRnM5QmNXN3VmdVFNc0prWGtzTHVGRnN4SlVDWDNmaWUyYzdQanJG?=
 =?utf-8?B?V0VBT09ZSGdWSlpPaUdjQVcyQW9FbnltU3JmSFJSQkpZWi9WTWZlVTRUS0RW?=
 =?utf-8?B?M3V0cjNDWC9abytWamtpN1FvVUJJbVNudmQ1Q09Oa21uNnRuU3NEcEIrTnFs?=
 =?utf-8?B?dURPV0FKaDN0cmFnZlJNRGJYcEtyN2RVNjVXTVZQeWVvckN0STdtcGI3VXl5?=
 =?utf-8?B?ZUhIcHpHbitSd2Y5Tyt3Y2Nua1JUT0FBbHJ5eno1Qzl1cDkvUW5XbWZudTBo?=
 =?utf-8?B?UnpCYkdybXYya0dRWTA4ejdscDMvMG9NcW5TQ0ZhKzdYQVFzM09wUmdNaU1X?=
 =?utf-8?B?anpKeWZzQ0Q0V2FYTzc4eFVxcDVxbG9TYnM5R2x4M25nSVpwYWlYWEp5cXZy?=
 =?utf-8?B?VHBmdS9xRUdJZGs5dk1JTkJhZStDQjNvOTFyNnBDTkNaUjNpMmw2ZVkxZ1N6?=
 =?utf-8?B?cFBYbXdmaU9kekFRT1NMTFNiWG44M25jRWwrNjdjL010aHc2UG5XNVZVV2Fr?=
 =?utf-8?B?SVRRNzAwdEhkUmpHaTRVbFU3OHBhZEs2aSsvb21ZSFROZERjd01rTzVpUmMw?=
 =?utf-8?B?N3FtcFlia1l3NWpWVm5Gb0F6K2xRdWtjT2ZzblAxaHdGU0ZmaXB3VGxJbkRG?=
 =?utf-8?B?bVR5SVBRYlhnNWVGWXlyV2dFSTdTaURjeWJMZno0TWlOd1RISFZvVEpUTkdG?=
 =?utf-8?B?SmM3Tit5bnFISklIaFlpUHRmUlNCbzYzZnpJU1lkN3JqdDhYRWo4T1FlYlps?=
 =?utf-8?B?OWVBbUo4d0RHL0ROdVV6U2ZIMDBGQ0hURUVPeFBlTVVkQk1LOWRsRDNadHhp?=
 =?utf-8?B?VkwxR3VoU2lLdkRRUGcybHJvQ2dTREx2aGFEdVRqSXV1N2Z3bkhXS29ZSVcz?=
 =?utf-8?B?bHVHbkt1cFBCMTF1ejJXNDQ5Uk1nUFFPTjdIck4yUVdmc0JEODhXWUh6M09y?=
 =?utf-8?B?bnNNZHlqOFBYdjBCamtpTlgvVEUvbGdjYlN3YWZMM2RiRS9PZUF5TnQ4UFlQ?=
 =?utf-8?B?bnNIUGppNUdZTEg5RjJVVnB4eEMyMjBuLzFLalVSQStJcDA3djRXaFdDYWVB?=
 =?utf-8?B?OUNqZ3RlUmZhWnI5KzR4MXdCSTVleGFiUmhQS0Z0ekVXNVZrVFVpa0EyMUFo?=
 =?utf-8?B?d2t5SmxZUDdyMkIybVZhbXh0K2tFR2ZtblBIUm1ZTHZoWUlraUEwTGgwcldh?=
 =?utf-8?B?YUVlVEhua3FUL1k0SjlNWWd2MHlGVEZoM1dnMUs5UXZlYjBuWkN1bWYyeGFV?=
 =?utf-8?B?NWtCdllWTUdmL0pwemlVOGVFVC9wdFF0U1dsekQ1ZGJnWEhWeVFtK1h1QzNZ?=
 =?utf-8?B?Q2FoaVJ6MWRIdlpqdTRWZUdmOXE4NkpFektsMjBOYlIvZXJPVDBLeWRxUktj?=
 =?utf-8?B?VnBMdFdOeE1TY2pLOU5PcUhsRWpEeDY2empTbmlWS1o0MHJCbWhwQlIxUmhr?=
 =?utf-8?B?VnpPYnZObEJublFWamMwenQ1UFJTdC8rWWF3dDBjQXZudXRhUlRsTHlTdlNv?=
 =?utf-8?B?cGhTWVRObTZaQjVWajB0WmZOTS9NRlI4ZTZPL0pNcFpuTXRrK1N6UGpTa2gx?=
 =?utf-8?B?Q1E1RkVxaHhNcFRNWVRCb1gwallzdU1xRWRLZkRCeEY5VEZ1TEhZdTJ3aFhR?=
 =?utf-8?B?TlhrOHYxTHFLRnBpK1JHMzNVai9SQy9NWnNVQXNTTFBoclZ2SmFDOHc4RTFw?=
 =?utf-8?B?akNhQW5lOUh4NHpyT0Z5YjNMcDBLU2tTUzZiUDZGK3B3SmNoNTZaRTlMTkZ4?=
 =?utf-8?B?QVA3MTVtS0pCbzkwOVZFVGhnelV6RFJpa2xnWHd2U0xDcFYvUnRUdmVpQ2tY?=
 =?utf-8?B?aHF1bGFpYmM5aDUvUzZvb2FqdVNVKzIrbWtNb0Y3QU9PaWY3MmNDeHF5b1JT?=
 =?utf-8?B?cnhDT0R2cFRHRkFqSm9TYXgrN2t4WUxGYitPODZiNkplOEFsczRwVFJza1E0?=
 =?utf-8?B?TURhQm8yVnhYbDgwQVBOUDU1UzVtbzFCb2NOdEhXMGNselNhOHQwdXNsY2JJ?=
 =?utf-8?B?TlBZRy9Gd3NZUXhFWVFaOVdLUEpLN1ZTUUFqZVI1M3cvL0VkWjFiaktiU1pD?=
 =?utf-8?B?MS9qR05xd2hzUmdUTEkreTJXTnVNdnZPeWtLVUp0cUlkQkFXbUVCRytHODVt?=
 =?utf-8?B?T2xrcE43L0tDMjRJV3lac2ZqejJGMFdoUkF2aHQzRDNlaWhkakIybDd5dVda?=
 =?utf-8?Q?SWlFlKB91bR/zWvj355oflj1RG+YuZ0Fj06szsWM6Vh7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68132b62-3f2c-4c37-a9f2-08dade226e44
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB8021.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2022 22:27:48.7531
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A3Q/UQ57IaxvkS4D5ni+xrVQeyjWNXRXiwAC5EMfliqqnp5hi1Fv6o269QlWbZSDbd504XFVVPnJQUcjzqX8kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8309
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tested-by: Ben Levinsky <ben.levinsky@amd.com>

On 12/14/22 2:16 PM, Mathieu Poirier wrote:
> CAUTION: This message has originated from an External Source. Please use proper judgment and caution when opening attachments, clicking links, or responding to this email.
> 
> 
> Multi-cluster remoteproc designs typically have the following DT
> declaration:
> 
>          remoteproc_cluster {
>                  compatible = "soc,remoteproc-cluster";
> 
>                  core0: core0 {
>                          compatible = "soc,remoteproc-core"
>                          memory-region;
>                          sram;
>                  };
> 
>                  core1: core1 {
>                          compatible = "soc,remoteproc-core"
>                          memory-region;
>                          sram;
>                  }
>          };
> 
> A driver exists for the cluster rather than the individual cores
> themselves so that operation mode and HW specific configurations
> applicable to the cluster can be made.
> 
> Because the driver exists at the cluster level and not the individual
> core level, function rproc_get_by_phandle() fails to return the
> remoteproc associated with the phandled it is called for.
> 
> This patch enhances rproc_get_by_phandle() by looking for the cluster's
> driver when the driver for the immediate remoteproc's parent is not
> found.
> 
> Reported-by: Ben Levinsky <ben.levinsky@xilinx.com>
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---
>   drivers/remoteproc/remoteproc_core.c | 28 +++++++++++++++++++++++++++-
>   1 file changed, 27 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index 1cd4815a6dd1..91f82886add9 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -33,6 +33,7 @@
>   #include <linux/idr.h>
>   #include <linux/elf.h>
>   #include <linux/crc32.h>
> +#include <linux/of_platform.h>
>   #include <linux/of_reserved_mem.h>
>   #include <linux/virtio_ids.h>
>   #include <linux/virtio_ring.h>
> @@ -2110,7 +2111,9 @@ EXPORT_SYMBOL(rproc_detach);
>   #ifdef CONFIG_OF
>   struct rproc *rproc_get_by_phandle(phandle phandle)
>   {
> +       struct platform_device *cluster_pdev;
>          struct rproc *rproc = NULL, *r;
> +       struct device_driver *driver;
>          struct device_node *np;
> 
>          np = of_find_node_by_phandle(phandle);
> @@ -2121,7 +2124,30 @@ struct rproc *rproc_get_by_phandle(phandle phandle)
>          list_for_each_entry_rcu(r, &rproc_list, node) {
>                  if (r->dev.parent && device_match_of_node(r->dev.parent, np)) {
>                          /* prevent underlying implementation from being removed */
> -                       if (!try_module_get(r->dev.parent->driver->owner)) {
> +
> +                       /*
> +                        * If the remoteproc's parent has a driver, the
> +                        * remoteproc is not part of a cluster and we can use
> +                        * that driver.
> +                        */
> +                       driver = r->dev.parent->driver;
> +
> +                       /*
> +                        * If the remoteproc's parent does not have a driver,
> +                        * look for the driver associated with the cluster.
> +                        */
> +                       if (!driver) {
> +                               cluster_pdev = of_find_device_by_node(np->parent);
> +                               if (!cluster_pdev) {
> +                                       dev_err(&r->dev, "can't get parent\n");
> +                                       break;
> +                               }
> +
> +                               driver = cluster_pdev->dev.driver;
> +                               put_device(&cluster_pdev->dev);
> +                       }
> +
> +                       if (!try_module_get(driver->owner)) {
>                                  dev_err(&r->dev, "can't get owner\n");
>                                  break;
>                          }
> --
> 2.25.1
> 
> 
