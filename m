Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 969836EF6BB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 16:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240864AbjDZOuC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 10:50:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbjDZOtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 10:49:46 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2063.outbound.protection.outlook.com [40.107.102.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1073030FC
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 07:49:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SWVOSVTxarZ8dp7fb2w+S06dlbORLYvjEf+WADfzgt6EDyrQ4dT5gtn2TtLEmQ7bhry2CrxGZMPqNM7UBuLWIe42lPtV+pd+IMONR1m2u69i6EQgaHGvin/e2CLaRdlFbfXO6mpn81BPg4Mb/KsU+sbGBvu6TaqWE5mzj/g8nQGh8rodMJAWRPecWtsemL5P6ohqVVK4YWAYzpsdfw1bAc/jpd8rYlCuGJLNvXDHGENQl8QKAF8SMfWxovYA+2emqQ3Td5UZAIynmL/MfvKWS4GvNGc99enSL4S3rFpfWcQZ7rinDeRwtoqsBdIJLpF5J9aezTkQ8PwOGLJFEwuDAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=igTkWHtB2OdGdrXpq5/r+TwqqJ9oCCcsJA7kQYqPK80=;
 b=S86s+a/pesjzXCDeia+QQl8Myb2EH72X9dC1dr5BI4Wl0/XXaOSG2ycww5RdiXjx+aLCbHzFUiyBj/Cx4VGnIGIzPC2htVutZKE7coMGSkIkENZ6hKXHjciHZfP+nVLEqrBSdf8qdCTHjm8NNoI4BoixfiR/AMm5S3hOpiop0HeVSTrYlbk93KQkZfC/iKQ/HZOYRi0w/8KQoyRZQyDdm7Grv/gCsPPTrjJe4yqY8pDGEy0ZDvE+yOgidYo3EazkWEk31riftDfCAVt7qfqDkFM5SIVnn23f8Np3W0+8TUeK0n33Tlo4IJUCyh04mdC3/4+ieIvKxTNmtalvUyh6cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=igTkWHtB2OdGdrXpq5/r+TwqqJ9oCCcsJA7kQYqPK80=;
 b=FeL57ebdeAMy6d4KXWqvgcsHWLodw/CYUR1u5GfyGnaHX71tx+0ITpnSgNVBpRPlhEqfPPIgvOklUaJ8ylPnWCvIYmCmBxV3411BVTs1ktvGaAz1PlrncgpekOYxigU2XAQqR40lomnm+7Cb4Sys8f88DF11mBwAxDeIqMFkib4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by PH0PR12MB5608.namprd12.prod.outlook.com (2603:10b6:510:143::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.32; Wed, 26 Apr
 2023 14:49:41 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::8c5f:e48:a658:7611]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::8c5f:e48:a658:7611%5]) with mapi id 15.20.6340.021; Wed, 26 Apr 2023
 14:49:41 +0000
Message-ID: <d1e995fc-02f1-9995-6910-5bc6254e70bb@amd.com>
Date:   Wed, 26 Apr 2023 16:49:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] clocksource: cadence-ttc: fix memory leak in
 ttc_timer_probe
Content-Language: en-US
To:     Feng Mingxi <m202271825@hust.edu.cn>,
        Michal Simek <michal.simek@xilinx.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        =?UTF-8?Q?S=c3=b6ren_Brinkmann?= <soren.brinkmann@xilinx.com>
Cc:     hust-os-kernel-patches@googlegroups.com,
        Dongliang Mu <dzm91@hust.edu.cn>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230425065611.702917-1-m202271825@hust.edu.cn>
From:   Michal Simek <michal.simek@amd.com>
In-Reply-To: <20230425065611.702917-1-m202271825@hust.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P195CA0073.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:59::26) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|PH0PR12MB5608:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a2a12cd-af7a-4246-3180-08db46657735
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2Rhw1DGulH3u0DItAsk7hLJrqK+02gUHiIPXmkFtFp7Az6qezqqeA4Odysk4Xg6/dv4vMj2XqD1zh1VcQFvpcJWMSBfM2KbfAzr93LmqKVtcbvFt5dZbyGT4XnSdaB+zEheeSLDtmrG4/bk7gVd/eFX2z6FwCpAaJD8myXW32bEY0DwnWqV2RV5jse05b0zNdcQ8HP6wWwMJdf+7Pnb6sc3TmJ7ncT5UGbcR9nwgfGR7Q+kNvS7+TXMHn5JlwJ4/+l83RfIQbJ2BpXUl8afBoV4NSVHPzKYed2/5onXrI/iyxJfZGgGkC36O1pkAFEYE1By4C4SAbd9hcabrcJ9+LuHEFS6WzV5HIIRCyup77wVJiYgoWLpOd06DrT/WGEmkJb7npnSf3kN1LjT/BDlrlG4w+mGMegG383FKzyt57dcD+xVl5PssL4xRBFjSOxCwRLKFo9WjOMVwt/ep42A2LRS8kXVDOZB7TMTUqmL4I+AMjwLNC0pL5/9j1FrP2iJUMg/h3la2c6XZQo5E/8gszACqI9GeJzoTJiUyefcW4s3gnU14GfJNpk7hoYPkbkj9Zu5AeuxZJ48Mu42cowtCPuSDPKQCLt59Se2LxFRM4j7GuX4YuQoZa6OqP/Z60qHSdNVP8hDnPfQRH5g3PzrGiQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4758.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(346002)(39860400002)(366004)(396003)(451199021)(83380400001)(478600001)(6486002)(2616005)(110136005)(6506007)(26005)(186003)(53546011)(6512007)(44832011)(5660300002)(36756003)(66946007)(31696002)(38100700002)(2906002)(66556008)(66476007)(4326008)(41300700001)(86362001)(8676002)(8936002)(316002)(6666004)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SnI0NTZVdC91OWJNcXMwNFpzc01lWWV3RjVJUGZUcWo4RDFRU3AzVC9LSWtr?=
 =?utf-8?B?VkJEVzB3Y2toTjNNcm9sR3ZUWjJqUFBYNlN1Q2lHcjF1c1ZNZDR6QktUWkdN?=
 =?utf-8?B?Q0NJeDRjYmpPT0VCQ0xEV3pHUjlpZ2NxWldRalRDeXk1ZFZlU3E5VWlkNEVQ?=
 =?utf-8?B?cE56a0VyZ21kdmRvci9Xenc3VTQ5YWEzTzBTeTBUZHhiY3AvWUFaZjdOQk5L?=
 =?utf-8?B?UG8rZlg5N0pCYkg1V2tQaDRXMmdUK2c4WnNSckVKVE5CU21qZ2YxZHYzZ2px?=
 =?utf-8?B?eFZTeHU1YlhRdFpGM3B3RlczUmVwNHYxWDNwT0lWczh3ZDkyZCt2aHd5ZTZu?=
 =?utf-8?B?U0x1Rm5kZ0FKc2RPMlVsdXUya0Q0czA1RTFlSkl0VGtZMjhDSXE2cWZBeFBK?=
 =?utf-8?B?RlQ2QXNrWU5EcVdNL09EZVdqQ2JDSWtRcnNtMEJGclBrLzB4NnpqKzQ2eDhD?=
 =?utf-8?B?dldZVkROV01WRDdJUk8vS1hnSG15akZDSUVwRlIwUDNCM212MzdZR2ZVQjcr?=
 =?utf-8?B?T25mcGtIK2ZkMlcyNUJONkNjNTkyMy9vT1NOWHZtL0NvL2VXT1QxOGg0UStQ?=
 =?utf-8?B?Vy9mNDQvZ0p6eUZpZ3R0Z2RXMk5DUlN5RkU2WlJJWEpjVStvM2NmdjBMcll1?=
 =?utf-8?B?MmExNlBPdXVQME9nK0FTU0tNNFFjdnZiY3h3ellUcnRDS0RNYlhnUmFzNzNT?=
 =?utf-8?B?ejJqUDJqWmYwN1VZNjNtaWlreFRrRXpvV2hpZWRFcGNLbEpyeXpScGFpVTFr?=
 =?utf-8?B?WE5XR2VvVXBZZlJkTGdHdEVSRG9qbVVkOWMxMWFaMEsrME9HTitHTzU3TFRZ?=
 =?utf-8?B?RWs1aml5YUszOE12ZlZBdEk5YW5zdC8yUkZQMDlPMytaTGFBWHhldzQ2VlRD?=
 =?utf-8?B?RVVWakhodEZhVnB1VW1HdStvZnlaMFJJWkkwVVFDajZHV2RhOXp2QzNrbFM1?=
 =?utf-8?B?L285aG0wS0lyOC9iQnBZc1hIUmZWR2J6Wk02YkwvblJLVTdhNkhmN1VVakhT?=
 =?utf-8?B?L1dkMkM5bXU5R1UxQzhxQW5saEtJWkxISHhMVDViQUkzZlJIVmtHeUZIMGp3?=
 =?utf-8?B?aDQ2Z1E3b1R3OEJkR05qVFpENTdmMllSQzRwb3p6TWJvWWR1K1krb21QUWhu?=
 =?utf-8?B?eHlnVVJ6WXdtUm1MYVEzOThaT2t6enhLY09ubmtlcjlZUUVRb0c2TVljZHRH?=
 =?utf-8?B?T3N3a1YzWS9OdnBqVW53TVdjeGt6eW1PVUg3T3lrMXkrN3pHVW1uV1RzOXdX?=
 =?utf-8?B?UWJwVm9iK2lTdkRRc2hIYzhSQnJmbDFaYnA5WXYwTkVxN2UwUlhkL3NGT2tu?=
 =?utf-8?B?TEdzL2dlZmVPL2xoekRXazFyNFRSR2ZsODVqK0NRYkZ5TFFKLzBubEJWbzVR?=
 =?utf-8?B?NExKVk02K2Y3cUNJNWtSK2FrV1VWK01KanVWa0NNeXU1SGxnUlltM0llU1pw?=
 =?utf-8?B?RzZIQXM2S21YUnpuVXBjQnB2K0dTVjRQRnhaTVVFaDZ6M3BYeHBBMDFkcm5D?=
 =?utf-8?B?UjUyYlZsSGo5SUpsT2l2U3JObnNsUGh0QVhMYVloY3liTzVrUVZGd3FzZkxk?=
 =?utf-8?B?MU5qZm83aVRGR245OWlWNnFDMWNPUVkvdnFCeGJ6VHBiVnp6ZElFbTErcngz?=
 =?utf-8?B?NHQ1TFBQS0k0UVU5YjBzWWZkZHFQN1F0Um9ZYnhmcVd1Ym94Q0ZMR2U4SGhK?=
 =?utf-8?B?YklTc3ZzcHNId012RHlOWDZKaG1BUkhJYlB2V29ReVpWMmZWSStKTU80S0N2?=
 =?utf-8?B?d2J5UndqQTJtZldwNEMyc1ViODR0WUwwWDlwTGdxMlJXb2dHUVo0ZkxMa2NL?=
 =?utf-8?B?VXJWem4vVEdubEtvRlJad3RlSzYydHdrbk54SWp6V09UOVQxTmJocm9vcUlu?=
 =?utf-8?B?ZDM5MmNma3pZZzhSSUVyZld0TkJPZFU4bVI3eXFFejcxeGVmK2lIb0ZHSGls?=
 =?utf-8?B?NS94RW51eDlibjFWWXI4THdQQVFPbmZQRUpkUVNZT2xKQjJyek4xNzdXekhh?=
 =?utf-8?B?bmZIOHVmN2RqTG1TVm51VURIdzJ5cEt1WnUwZDc1OXN4c3ZyMWRiQm5EdjJj?=
 =?utf-8?B?alVNa3hjOUFNeDlPVkhsaittWVduZG91QzBiTjd6OXZVUlRNaXlVV0ZTVDJw?=
 =?utf-8?Q?MB4BmvduYeqGXasLvTNoYxIv2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a2a12cd-af7a-4246-3180-08db46657735
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2023 14:49:41.1588
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Quk6SWVUYVcHG1GSeMJV49mkOtA6vNPj1txS/w/4aqzPYurvkOzbApHw1hwCCHDf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5608
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/25/23 08:56, Feng Mingxi wrote:
> 
> Smatch reports:
> drivers/clocksource/timer-cadence-ttc.c:529 ttc_timer_probe()
> warn: 'timer_baseaddr' from of_iomap() not released on lines: 498,508,516.
> 
> timer_baseaddr may have the problem of not being released after use,
> I replaced it with the devm_of_iomap() function and added the clk_put()
> function to cleanup the "clk_ce" and "clk_cs".
> 
> Fixes: e932900a3279 ("arm: zynq: Use standard timer binding")
> Fixes: 70504f311d4b ("clocksource/drivers/cadence_ttc: Convert init function to return error")
> Signed-off-by: Feng Mingxi <m202271825@hust.edu.cn>
> Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>
> ---
> The issue is discovered by static analysis, and the patch is not tested yet.
> ---
>   drivers/clocksource/timer-cadence-ttc.c | 19 +++++++++++++------
>   1 file changed, 13 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/clocksource/timer-cadence-ttc.c b/drivers/clocksource/timer-cadence-ttc.c
> index 4efd0cf3b602..0d52e28fea4d 100644
> --- a/drivers/clocksource/timer-cadence-ttc.c
> +++ b/drivers/clocksource/timer-cadence-ttc.c
> @@ -486,10 +486,10 @@ static int __init ttc_timer_probe(struct platform_device *pdev)
>           * and use it. Note that the event timer uses the interrupt and it's the
>           * 2nd TTC hence the irq_of_parse_and_map(,1)
>           */
> -       timer_baseaddr = of_iomap(timer, 0);
> -       if (!timer_baseaddr) {
> +       timer_baseaddr = devm_of_iomap(&pdev->dev, timer, 0, NULL);
> +       if (IS_ERR(timer_baseaddr)) {
>                  pr_err("ERROR: invalid timer base address\n");
> -               return -ENXIO;
> +               return PTR_ERR(timer_baseaddr);
>          }
> 
>          irq = irq_of_parse_and_map(timer, 1);
> @@ -513,20 +513,27 @@ static int __init ttc_timer_probe(struct platform_device *pdev)
>          clk_ce = of_clk_get(timer, clksel);
>          if (IS_ERR(clk_ce)) {
>                  pr_err("ERROR: timer input clock not found\n");
> -               return PTR_ERR(clk_ce);
> +               ret = PTR_ERR(clk_ce);
> +               goto put_clk_cs;
>          }
> 
>          ret = ttc_setup_clocksource(clk_cs, timer_baseaddr, timer_width);
>          if (ret)
> -               return ret;
> +               goto put_clk_ce;
> 
>          ret = ttc_setup_clockevent(clk_ce, timer_baseaddr + 4, irq);
>          if (ret)
> -               return ret;
> +               goto put_clk_ce;
> 
>          pr_info("%pOFn #0 at %p, irq=%d\n", timer, timer_baseaddr, irq);
> 
>          return 0;
> +
> +put_clk_ce:
> +       clk_put(clk_ce);
> +put_clk_cs:
> +       clk_put(clk_cs);
> +       return ret;
>   }
> 
>   static const struct of_device_id ttc_timer_of_match[] = {
> --
> 2.34.1
> 

Acked-by: Michal Simek <michal.simek@amd.com>

Thanks,
Michal
