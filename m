Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E53664E4AE
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 00:30:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbiLOXab (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 18:30:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiLOXa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 18:30:28 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7FA960362;
        Thu, 15 Dec 2022 15:30:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dBukrUDmJjAjFm5mG6O0pde+IKWSuI9KpkR3RvOV2ksW4ZSu5gisd1dQtMBVmYBxN9TC466nvaAC7MDWn+7BUqDS2fSS+iNmd9+I9lXZbfeVefMk2sn8OmESe+hKvRgoCdZja+Thai8uEEwmwj9CVzDE5tw6d7YwNda/XbHQvwoHh77Et3PaZAf7yPk35WgL008QQb8XjNIPuGQbXLGGHjUtsFGjOaJBbT3O8lQ7PAT4TnF3xWVgPVECbQFN4roZmT7e6ZVpKh7H7P4IbwDDyeYXvLCHfbFyi06BHXLdME18eP41Js6jJPauD6y3S/zZ9AVxu1x8p/JMY2vTONWkGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WyFGPQkxHTW4Tg3cy519NmAfNKhFRZxFcgCbDESkDGI=;
 b=RV99bJRk4otN/7VXCi7fL+ZAA1NpcM7SIKGV56UpZIKiZopb+SuJxEqK2eFPzvIk2SpsH6/vsRxm34oyANHVU6KCzaitpXzXYqhrnKagButcPE3z/+hz9uRvPircF2MFLMrf9Y56cvpZw9x/NKhPhzEHLIdfFEiusGJsE+T/G7T8tTMAv+YmKNtahV9qciZVzCbtieV3azdarmLJsrlNR1Dd8CiuY++x/+CdZ6om8lJxkae8JaXtDO6rCuft5vBLcdw4mjH5/kih9lDfngci0UtcBq0wGoQZSMP6g3RUIQHQ1rku2o2ocqBCY3N27HoeqgUOA4bu4bx8256HA38egQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WyFGPQkxHTW4Tg3cy519NmAfNKhFRZxFcgCbDESkDGI=;
 b=iA+zY8EhiF7H5ozpWx1V3mhP0ONjugKu8NpR9gtTB+Mikfeg/OsPYdQuNDlzC8LTlhWdjHatoB9eBiCAQiQ3HtGn8MXLotzS2zlE0S49u2bzTw8v5AQv4mDhPdpHYTpCRk+qguwdQ5KLqkxMytIWmOkY1VtbONt9S8rGBAbtBM5CuFciZcKtXa+p+teMf+FzozNicLx3wZKZkKgCiCbWuCaAlorXR1lWKw5mpd/lCrm5EFGbXiUxFtgcMC9JxQ3EmFsNjPMziN0V9exJn+WFwctdQucWtJ4rIAW2zPRtnl6e0aAyYX3R8hkZx9/BVdkspyeztHnPryPIAIos8PdrjQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB6604.namprd12.prod.outlook.com (2603:10b6:208:3a0::7)
 by DM4PR12MB6640.namprd12.prod.outlook.com (2603:10b6:8:8f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Thu, 15 Dec
 2022 23:30:25 +0000
Received: from IA1PR12MB6604.namprd12.prod.outlook.com
 ([fe80::72da:3d0c:a811:be88]) by IA1PR12MB6604.namprd12.prod.outlook.com
 ([fe80::72da:3d0c:a811:be88%7]) with mapi id 15.20.5924.011; Thu, 15 Dec 2022
 23:30:25 +0000
Message-ID: <38f2d681-80a8-dc97-e5ed-4886e5e3bf7c@nvidia.com>
Date:   Thu, 15 Dec 2022 15:30:21 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
Subject: Re: [PATCH] hte: tegra: fix 'struct of_device_id' build error
To:     Arnd Bergmann <arnd@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221215164626.1209452-1-arnd@kernel.org>
Content-Language: en-US
X-Nvconfidentiality: public
From:   Dipen Patel <dipenp@nvidia.com>
In-Reply-To: <20221215164626.1209452-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0271.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::6) To IA1PR12MB6604.namprd12.prod.outlook.com
 (2603:10b6:208:3a0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6604:EE_|DM4PR12MB6640:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fe162d7-759c-4418-f31f-08dadef457e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sbNzyly3MB8vMbdjMpkJShVtuqGrHxCB9bvnl9kYwGNfPneGx3m+G1iOeYH29sesNQw39CWLInRy+Z+8Bq8NuKga7h1OIb1zAHC08GawDz0t/nuVH1GMyYC/z3gUTvXWwO6u7tn8gQVQvfgF+GnS9UEum/o/mYSSBCDtqjuvL/+NqzbegM8y5Ya+KtKkTIraCnlcmYrUf9alfPJomXYM2/iXETO15Iwy/bK9JPDUlyVrWbvWUjeB8d811/ZCi/PZTZoUro1GNG/l/kmSntp9B/Q8Z+JV6f/D+NlfdfPYnSMH5eq/H1GZ/CFC1xIOjznsUdRQXRBn9dkm5vqU2pjtmFX/47P56nm85w3/rql8NoalVLZt8xtOX4uajbyNuzNSYfaoEEQKHDdtVQzbQIfu77D0cJi7jGMy0luCGXub3lko50sTpZD+Yv/JapcNj4v4RSQw9A+ABHq2BOVHGoNt3JglZXhqQb68N2n0Op/iQr/HGtHsBAWu9QS0vK5E2C2cCBdjNV7q+d64L7InTVy6XI7dPjSWvnbPdtoeUf/qzrUvRekTDu3AH7MoWYM9FNx+lM9zEnmzRD3nY0EfQcsK7LvaIS36Be2W4CcgPZl17deE9jS2hiCN45SE4tNj5O5Uw6fTF36Rjfv4I/w+dbpstYcbeXtjYVaRGqtaJau5TD8VHmZ4Eqp6VvBa+PzHpnktG/D0WJ9HJFoI1rxmNUvuhmPA86umow9SR14CrRqk6hU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6604.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(366004)(396003)(346002)(376002)(451199015)(83380400001)(478600001)(53546011)(6486002)(6512007)(6506007)(110136005)(26005)(186003)(2616005)(6666004)(66476007)(4326008)(8676002)(86362001)(31696002)(2906002)(41300700001)(66946007)(54906003)(6636002)(316002)(66556008)(36756003)(5660300002)(31686004)(8936002)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OGJpYmZKdnlEV0d4RjdBOU83THpSdG1kaCs2OUQvR1Bsa3Z3c3VFNG1sb0NM?=
 =?utf-8?B?QUVwTVJrTE94d2VvNVdWajhpTjByaTVaMnpuZU9seVpLdDhjUUZjVDF6clpF?=
 =?utf-8?B?MkliUCtEM1JDSVpEQVZKcjRncUs2ZGxmOXQ1MDJpYXhxMU5Ic0tJVVhTZHhG?=
 =?utf-8?B?MWczWFhFdGZPZ3MxcWdnU3I3NXQ5QnRvL3BYUTdUaHFuYjkwbmJVU0FkSHhp?=
 =?utf-8?B?ZjBLbCs0b1VYVjdQRWVaVTNJdmdxNjVkSFoxSFVJU0NqcUtEUzc2cDJyTDU1?=
 =?utf-8?B?Z1YvaitOY3RLazNnWXVLYzZKTlhpOGtCRWs0bnRxOUtTWlF6UTJzSU0xNHVh?=
 =?utf-8?B?SGNDMWJueDNSOVlTWDZCRDdvQmtvWGtoTTdLWm1hUlU5Y21OOVF5ajBDRENh?=
 =?utf-8?B?TlVNdDVUcWVldHQrSTFlK0dxMFVBbzlFcTNsbVpCbWVlb1NPaWN5bnBCMEpa?=
 =?utf-8?B?ODBiSHgvSVpPZnpNNWVWdXVpQ2xpT3B6c0sybWVTN2wweFMwUktBT2d5cVFE?=
 =?utf-8?B?YXZFWGJnb3FuMndBdTZtRFBkbW05VERVQWliOFhDR2ZRc2w1ZVlNYkFoZWRF?=
 =?utf-8?B?ak9JRzVsaW8xbk94NUdRaG80VE5YTTlWb0Q3Y0lKSDZGOUp2WWgyS0t5T25s?=
 =?utf-8?B?ZG5ZMlNBQ3BEVXMzdGVHL3pMTzdvMGMrc0RhbTZKRGJXQ09lMDBUZjh3YXdX?=
 =?utf-8?B?dU45NE1hcGJ4NW40eGNNQjh3MWdBT29wbFQyVzEwOXNhZUNSZHdYYWVPSXJw?=
 =?utf-8?B?T25sVXd0elRTRTBIZ3R1QURoRUhDWWRVdEFiSW05SGlJaDRzMlhOVHA0cFVs?=
 =?utf-8?B?Ylp1TGp0ZVkyb1ZYb3p1M1hvM0dqbGRQYWRFbUhJZTJFRFFZdVFMSmRReHNr?=
 =?utf-8?B?ODlBaVhNM0tqTTF2Q2llckpPUWZWNVU1c3FpUTYrRmFvV1lIV0ZqeTRKRnJZ?=
 =?utf-8?B?UGRCaFkrTnZTRUU5LzlGeTFpb2VBOTNxaCs0MGZCY1dUa0pKamhENGFnbENu?=
 =?utf-8?B?Sm03YnZxNVBya21VeCtKdWhKNVhOdWxZNnBBTzRvcDIyT0E3YXlDWGZTaVcz?=
 =?utf-8?B?UEVzMmlXQ2E2SVdBTW51cUpFNzVuRzNaTllYaEIyZEJQclFZcFM2SWtRZzRR?=
 =?utf-8?B?QVgyQnlSNEFCdzNrU05TL242eXFFQW5qeGNyUXhmczFzb3c4Ukpkd042Q0V4?=
 =?utf-8?B?NkNZb1dLZk5SRk8rY1RVWjR4MHo2S3g5bzNkay9EMTZXUHd0YWNoMkorcVVm?=
 =?utf-8?B?WmJGMmExSWpiWmJ1bWhBUGowU2lxSkEvYkw0a1hSVVFhOCs2eEkwVmN4anFk?=
 =?utf-8?B?eWJCVFpKOS9KUUxMdmszNHRyYkh6aWYrK25jcUJYakRCQWkwNzJ3b2xtZ2lZ?=
 =?utf-8?B?N0pwUFNvV1RSdGpLc0Vmd1ZDMjJnekdDSkpaSHlmb3ZPcUd5enZMakJVYnkr?=
 =?utf-8?B?VnFDSG9GTjFvc3E4UVROOUwxa1VPQmZBR2JBVjdLUWxMSzBvNHdydzEvUzZN?=
 =?utf-8?B?ci9QWUtId2RHejBrelNrbEtTdEhZdGRhOTZyVzJBR1c3bXJTaUZEY2FCcERh?=
 =?utf-8?B?cUhIQUpuamdoakRVZVBYcnNMVkpTTHhiZlVRcEx1YldOempKVnV3VmQ0ZW9l?=
 =?utf-8?B?b1dtVkpFRkU2Wk81YnpONXByd0ZSemRNOGVKS1JnNGJBaDZJMHMwMTdFRmg3?=
 =?utf-8?B?dTBkVTVid1pYQW5MNnJNK1Y1YWNTMGphWXZpWStqNjRqL2JzcjVlWVRHVzZJ?=
 =?utf-8?B?bitocnV2a3U0V3hRQ3BDYUJscnBZVVVyVnlOQnVUSWFocVVtTDJEdW44VWxm?=
 =?utf-8?B?MlZJYXNtekJNM3F0TWpqL0thV29ndHUzbndPWFl4VUZZdEtrVVpKNTRHU0RW?=
 =?utf-8?B?TnJsaC9pUEd2MStOREpjWkZ5cGpWOS95aE1PQXozcTJxV1ZCRkUxUXFoSHlS?=
 =?utf-8?B?QUI5LytSNkp0akNUeEZGYk4wdFlwNGZlMURmcHpBUEVZd2xHdS93K1lZemRa?=
 =?utf-8?B?d0swd3J1RUpORHVIVGNZamZLUVNvOHJNeERSa0ZlU0FUSWRWN1UxazFCQSsr?=
 =?utf-8?B?M2RDcUhUbEt3WUp5TFlHaXJZb3F2UTJURmRvUDJldHpVK2N5SnBtYkM2OC82?=
 =?utf-8?Q?fWa+4lnnOjfCc+jLDWuvk4Mqo?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fe162d7-759c-4418-f31f-08dadef457e2
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6604.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2022 23:30:25.5473
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KgB1yCsRLd4A/3C7cNSwT2owwMafTG72bttiV5AGBbZHxZmN2xybypALReHFdlTnMLA/Gykn9kRRlm9mhljhqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6640
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/15/22 8:46 AM, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Without the extra #include, this driver produces a build failure
> in some configurations.
> 
> drivers/hte/hte-tegra194-test.c:96:34: error: array type has incomplete element type 'struct of_device_id'
>    96 | static const struct of_device_id tegra_hte_test_of_match[] = {
> 
> Fixes: 9a75a7cd03c9 ("hte: Add Tegra HTE test driver")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/hte/hte-tegra194-test.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/hte/hte-tegra194-test.c b/drivers/hte/hte-tegra194-test.c
> index 5d776a185bd6..ce8c44e79221 100644
> --- a/drivers/hte/hte-tegra194-test.c
> +++ b/drivers/hte/hte-tegra194-test.c
> @@ -6,6 +6,7 @@
>   */
>  
>  #include <linux/err.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/module.h>
>  #include <linux/moduleparam.h>
>  #include <linux/interrupt.h>

I will push this change from HTE tree. Thanks.

Acked-by: Dipen Patel <dipenp@nvidia.com>
