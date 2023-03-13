Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 396A06B73B2
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 11:19:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbjCMKTj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 06:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbjCMKTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 06:19:13 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2053.outbound.protection.outlook.com [40.107.93.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 646C323C55;
        Mon, 13 Mar 2023 03:19:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OCxO2HIm4Tw06s9680BFABMjEauNli5FpgYLZQOjZabsYFjDWByklwfZJwyLkxaLDYg2VT2DrP3sUHTWrEHLBGFOxmB6ehK37ZRtBmDn/JM5jinpayyKL9EL3Lt6KrTFMi8pdRYo0c5L+Mf2K8JZAqVRhvIqUSlqknUrJvbD9Gge99fMFLngkEsujwqPFdq+Z6PtRRmOp3eUQPa4qaiYx/ehcUHS0fBZyF5kVA8R0IBLVinQi6gSrNi7Bww1RfcYqKt/LCQf9a2FyYDIKsOnj+RiUc6M/kwAk8KKxwvAmKPqzh4KlSHO8upaI83rm/xaaAbUfVUTywIAVAXzIPT+yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iD6PhLitmklSnVLD4boJ/vZ1eh7sn4V+66ExJgF4FSI=;
 b=C3ajmaHNqZbuCgOCoh9qH4Dh34/VE7OjZunMe3ycksUiAVVN8TZRqbdAK3NDet6e0rJ7OzyMHtZGFSwGXY6A4IpHNrusfIZ4WYvvCFsdshBSfNYyCh5SidmvIY5OhG7NK+hxfyF253az11gvyZ5x52PIsv8eswyRBlbRWA39TWF7KRjcFjBgOwuR3TzEeMUSzvleBFk6WrCBYZ7QwTvfUCdTBEM9jacvDEE3gDSvvUEFpJyarLqziQNfwoqr0SfK98MjmBubl6EN5eha7l2zDdSLauNMrG1CTyGahZuy7oV+8t4Qb2f3LMZEjfouTG4mdO0jy+AYvIbQO7gx/bf19w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iD6PhLitmklSnVLD4boJ/vZ1eh7sn4V+66ExJgF4FSI=;
 b=i1yRGaj96H+sS4DIG1fOD18Ms34DOZ8vRlWOOeDaUWYkYwus3Ik1ptTp9Qq+DVQXJKeGl16R8jd07oybT4ngajwBGT7JtlALOhPhifwrsLwU4WeIQEJP+02AF7fss/QNz2voCqeS8VZ7J+lWPkWLLJCkakHIbYwOLwHTXJ9UVmE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by DS7PR12MB6023.namprd12.prod.outlook.com (2603:10b6:8:85::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.24; Mon, 13 Mar 2023 10:19:09 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::4d07:7f52:c833:9603]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::4d07:7f52:c833:9603%6]) with mapi id 15.20.6178.024; Mon, 13 Mar 2023
 10:19:08 +0000
Message-ID: <c6a5dc7f-46bf-8f1e-0a9c-2614d5f1824d@amd.com>
Date:   Mon, 13 Mar 2023 11:18:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] soc: xilinx: Use of_property_present() for testing DT
 property presence
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20230310144725.1545315-1-robh@kernel.org>
From:   Michal Simek <michal.simek@amd.com>
In-Reply-To: <20230310144725.1545315-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0204.eurprd07.prod.outlook.com
 (2603:10a6:802:3f::28) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|DS7PR12MB6023:EE_
X-MS-Office365-Filtering-Correlation-Id: aab1c6c0-7ffa-4286-2f3e-08db23ac61d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cHcm553hXaJiUfvbS2qHmMXw1jwogNHjr7UWCfGzC85Bd0NnqQzTI7wzRO3ka2mWlKYveoJpkkylPkVHtElQSc3jlssbjmMSezv8jFgHgqb1NhRWHkYlcGnQjKzdkssOteoWpPtepyZfAt557k0p7esrVqmF9B+9b7BvLhY0ikR9e424CZ/A0GaKwo2zLngx5VOVPLbaNmOoAwSg1UeS0c2xN4rK/XjEBxVoBy5pVxoXoX1Cv0BJ6161IE1k33+gIM+GEYrRzZIKdBljB4ueSmrBnsJhkvvnxPt4tG0j4n+0msYS2sYmzUd2jv3n0NZe7RugCm41/iZhUEj43j9hqMkC+cL2RWfDWARVclbHaWcw3A4UYlz9P+Uo0c2fpsny11dfiYpKfzOrdIifjQEOWzJ9qdFT8vD8JYs75F5kleEnbPltJFVhXmAXnF7NBS4sX1q4BexMSd6jNtq7f7y7ATJK1rW0sAQYHxjuzinZFi68H+u82HRnI74j62isF6tbnOntYxkuUfkpvK66WYtGe1WQsCuX38m01Vu8FQBZkIT90pnhLJNR5j4aNeMjlXpH8r9XGxfY+b5HtgyB0fZdfgT/OIcVyWe1kZuJmGeeddxleeRFkgnT5fAXtl3a6uAl6is2gErt5C+bF1Wqg8Yj5vAdJkLXviOOlguqEgscAuidHmgWgY/04EoYA7yyIvSDpkDP0puPgjxc40Y/I3yapbib4mO7wxILU4svZg0joyI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4758.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(39860400002)(376002)(366004)(136003)(346002)(451199018)(31696002)(86362001)(36756003)(38100700002)(8676002)(4326008)(66556008)(66476007)(66946007)(8936002)(110136005)(41300700001)(478600001)(316002)(6506007)(5660300002)(44832011)(2906002)(2616005)(83380400001)(6486002)(186003)(6666004)(6512007)(26005)(53546011)(966005)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RDhQZlFVbVB1QVI4RCt1alFqWkYyb2R3T3Z3dWN2TEdNS0lRb2FGc3o3TnlY?=
 =?utf-8?B?cGxYYWFkbnlzU3BrM2ZNYVN4cFEyc0pxTFVuam5KdldNU0ROTWZjZjg3VVdn?=
 =?utf-8?B?QW9MckhjSjUwZUdPNFZIVm1rVk9oNkVOSzdFWHI5ZXVheVh6QXBTdkpzemwx?=
 =?utf-8?B?ZEhzVVdDUkF2RGZCb0NlQkEzd3lkelFDNjVQcFRMYlhKSkxDb3lFU1Vpd2pL?=
 =?utf-8?B?d20ra2JQSytwdUVjSHRJMDRIOTAzL2NQY1htZmpackFXUmE3RVVHbU54dDkr?=
 =?utf-8?B?cmw1NEFGdXdwd3Z3cEtYR3JkaEY1ZnNBdDRZNWlWbTJRNG9CUkZ4Y1lwS1Rr?=
 =?utf-8?B?MG9XcGlVaEN6Q21MWUhmVmxodTlIcENLQUV4ak9ENE1ZUXNPV1liQXVITU8w?=
 =?utf-8?B?OWttTjdTY3dsVG03aTRaTERhOWp5UEQ1d3NWK2JaT2pSMC9KT0toMGZMRUgz?=
 =?utf-8?B?YlNGZUlzcGtiOWROdWsyTlRuSWZuZm92dFgyUWpyZi9EcktoOCttT0IxM0dF?=
 =?utf-8?B?ZVZnVEpoSWdBY0hlcngra2dXOFNtc0VMRTM3bzJ2QnYyMkRvY0t2Z0cxdEJ0?=
 =?utf-8?B?cU9Fd3czQi9zVmg1ZVZ6ejQ5TXdpMkh2SXRuRHJFbkZGMU1DdzQ1NjllT3Zx?=
 =?utf-8?B?UGRmbldTU05EMWVZWXZCTG5aeHUrb0tsMkpRYWJQR3VCMjJDV25JdU5BSVVT?=
 =?utf-8?B?T3B1WWJvZmNFN2YvVERMRVJuVE1PTytYS0cyY3ppUXdjQ0EyZFZFcUR2YXd1?=
 =?utf-8?B?MVFZVFN0Yk9MZFV5SnFxVE10M1V3RHlPeVg3eElHRmI1QjhJTTBqb1VQc2kr?=
 =?utf-8?B?SExMUmg1OGxsbjhvNHY4QlZSOElTcmdTenpCM3R2cnZHYUlKNXFVeGs0UmFi?=
 =?utf-8?B?cUlsVW9aNUE4SnBhbnYzcGk1QWRJQ0ZGQ25pdUxNRmNGVHgxK2VpY0I1ZkRK?=
 =?utf-8?B?cWtHZVVsUjBjZTJXTXZLVkp2WWVESk8reHBKbGkzT1ZSUHY2SlZCd2psdFRk?=
 =?utf-8?B?bWszK0hLb0d3QlFLYm1aWWJWZER2VW5vSStEZ3NTbmp1SmxqbkxjSVN3YW5Y?=
 =?utf-8?B?QU5oV1g1M2x4eWxnd3lDTHNOdnBIZUZQWkdyK0FidUdYQ1MxOHdkdGczZDRX?=
 =?utf-8?B?ZzV0bzI0cWVuSWd6RnpkWHZqc3pmY1RiNzY5dU1GN1hKL00wYWZvbnAxNTlU?=
 =?utf-8?B?aTRtMzhXenhQbVhkYXZ6QnVQT1lVc1ErYWRPUE4ydWYyTjJzMkFheHdXdG1W?=
 =?utf-8?B?VzZWY25nQ0VWQkFIYUx4NWltSlRqdlMwck9sUU5yUlNqMjUwYkxmS1RiR2pQ?=
 =?utf-8?B?LzdqTVNLZ3crZGxINFlDbytBcTRJWks2Q0t4aERuRHB5VGY5ZjBTSnRkVkli?=
 =?utf-8?B?OHVPN2tvTWJZSk9YTTF4TlBJWHI2V0crUmI5RlEyUGFaZGpCZC8vQVByaEc1?=
 =?utf-8?B?a2NYUndQRXYyRExnYUhZNUpNMy9oQ09OSzgwaGpVUFR0QTlXVWpaMUpiL2c1?=
 =?utf-8?B?VFNsUVZ4djM3MXhFVXp6TkloaEVRd3R6SW4vRkxRZFNENjcrN0hVY0JPa1p5?=
 =?utf-8?B?TWVXZk5KM2xyOGdWNVdOQ1VZWGFxRTZjL1hYZHRLN1VVTW9ocCtCUVlRb21q?=
 =?utf-8?B?T29aQnNFVmFDODZiMEV1Sy91b1QxekVEZG1YdE9NMDhvNmw4cUdWa3FIbEU3?=
 =?utf-8?B?bWRxWmFOano5MHdLbTlpQ0JHMDdJMXZ1RnVKWmxoM3hHa3lYdkpMYlJNenRn?=
 =?utf-8?B?Y3c5ZXFBbHVsTUJpM2VRcWlGTi9ZYUdQWWs3QUliRFJSc2owcStWR1FQbDln?=
 =?utf-8?B?eXBWVmZFZUswREo3SEJ6Sjh5eEdwS0o2ZnBWYXZqTUJWQ05YbHY1NUU0NFFW?=
 =?utf-8?B?em9zZU54Sm1RS01EV0V4QnR0V3oxVnEyWERCUThEMEI0TGRSdXhKWUNtMnFi?=
 =?utf-8?B?eEFMU1ZFU0labi9rbWRocHVxanhMUVBpUXJpcGxZdGtpSjVONFpaZFoxNXIy?=
 =?utf-8?B?L0NhM0RFcmRkU2ROODUrV2ZKb3NXNTUzSlVzc0wzano5WEp1a0hrcjZlYkxR?=
 =?utf-8?B?OXVNTCs5ZjRNcjFVUDRYM2tiaVoySnpXWnNxTk1tRFJxZ1VyNjdvWG1LNjdG?=
 =?utf-8?Q?3me/CO4pt6HxPIYwuKIhVimZT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aab1c6c0-7ffa-4286-2f3e-08db23ac61d6
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2023 10:19:08.8799
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VjlqhYMe5B1M+4yrRwA17Y8SXOElNtQGHMnCFWI+K6ECNims1fs94Vu4V6GHWaAa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6023
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/10/23 15:47, Rob Herring wrote:
> It is preferred to use typed property access functions (i.e.
> of_property_read_<type> functions) rather than low-level
> of_get_property/of_find_property functions for reading properties. As
> part of this, convert of_get_property/of_find_property calls to the
> recently added of_property_present() helper when we just want to test
> for presence of a property and nothing more.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>   drivers/soc/xilinx/zynqmp_power.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/soc/xilinx/zynqmp_power.c b/drivers/soc/xilinx/zynqmp_power.c
> index 78a8a7545d1e..641dcc958911 100644
> --- a/drivers/soc/xilinx/zynqmp_power.c
> +++ b/drivers/soc/xilinx/zynqmp_power.c
> @@ -218,7 +218,7 @@ static int zynqmp_pm_probe(struct platform_device *pdev)
>          } else if (ret != -EACCES && ret != -ENODEV) {
>                  dev_err(&pdev->dev, "Failed to Register with Xilinx Event manager %d\n", ret);
>                  return ret;
> -       } else if (of_find_property(pdev->dev.of_node, "mboxes", NULL)) {
> +       } else if (of_property_present(pdev->dev.of_node, "mboxes")) {
>                  zynqmp_pm_init_suspend_work =
>                          devm_kzalloc(&pdev->dev,
>                                       sizeof(struct zynqmp_pm_work_struct),
> @@ -240,7 +240,7 @@ static int zynqmp_pm_probe(struct platform_device *pdev)
>                          dev_err(&pdev->dev, "Failed to request rx channel\n");
>                          return PTR_ERR(rx_chan);
>                  }
> -       } else if (of_find_property(pdev->dev.of_node, "interrupts", NULL)) {
> +       } else if (of_property_present(pdev->dev.of_node, "interrupts")) {
>                  irq = platform_get_irq(pdev, 0);
>                  if (irq <= 0)
>                          return -ENXIO;
> --
> 2.39.2
> 

Waiting for v2 because of missing of.h header reported by lkp.
https://lore.kernel.org/all/202303120017.BIw01Y21-lkp@intel.com/

M
