Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8E2174AB0B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 08:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232709AbjGGGVo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 02:21:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232543AbjGGGVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 02:21:17 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2063.outbound.protection.outlook.com [40.107.212.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27D0E1FC7
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 23:21:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g7HaemYsFcMNwyjp1He8GY3XjNJSQCY1VC6C5TplUb9VKBjhYZiMASsxbXPtaVBgsT0Bhkj4T8Ey05vd4XdGODFh0RX2KRCet+MMQ9mJSdpcQG2HQ8AnRpc2sUtW4jHlwTeQNdf1Lbf6xGnfVC9gLIHo3/SJGv43VSK+Ppf9d2//TsKzJOCjlAAHXZWXy+0df9fH6JXgtYEvDjRlzHlWHF/9becFZnLSAe5lwiVE07tae7kyStk5vJHXbc/UphQI0rciNYVtRH2zfXM+xowjZhnNjoZxeNiAlzPHQqFndbaRxprlRQYJVNXAjiZYFcR9G60ZC8RojB5BgQpwpWo8Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mC1jA4niBCz4VorsBYM0zPxlo3hqYztHZwP4KU24rTs=;
 b=Hj3jaSuR6t4str9M4yyPrEpV+qQXAN+pXpijSOiCOcL2DCFqfmd/DrGVHYDjpyREw9ebF0U6zAUeRxHgGqaZKbS/I0/0X1dQIys9jrSRoJqZ9rMph+mqKDHsneazNPbbS+G2p+QJVZ7zX64DthVp/AMUR4s3a56GlDOm4dPohUFwjUCYH+zqePuGiJEmkpRRXNNX0xzMFyaUREmZ4P3geN3tM/f0cSWwf6z2IcNxHF8gn5lU5BNCBxxI5G6p4olnTyuE7ZTAETL1WZeso9NUx78Jq5bhTcfs1Gu9y81m2PXFxRs/FNMG/twfwlvq2pm0qGapIKDbu4+YDqPHptNmXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mC1jA4niBCz4VorsBYM0zPxlo3hqYztHZwP4KU24rTs=;
 b=ZYwV7RzWH52fEOpDzN8xlAeagmuByvd3BxTcsXiMCX4z3g+RaVG1J/bvvcmSnsZI9KwFZk2mllcWSC+yHN2AeUmKesClMqesy+4nsdpAtrnW8Eyr5SRXuE99j95ppC7Tf0LWsyc+O7DRkvf9bD6q7Zn41fQt/nIfA8RKVri6a50=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by MN0PR12MB5977.namprd12.prod.outlook.com (2603:10b6:208:37c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Fri, 7 Jul
 2023 06:21:13 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::bb94:8eb4:943:d955]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::bb94:8eb4:943:d955%6]) with mapi id 15.20.6565.016; Fri, 7 Jul 2023
 06:21:13 +0000
Message-ID: <64347d8a-4427-6c0e-3164-e879a028e4b0@amd.com>
Date:   Fri, 7 Jul 2023 08:21:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 3/3] misc: xilinx_tmr_manager: Use
 devm_platform_get_and_ioremap_resource()
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>,
        Appana Durga Kedareswara rao 
        <appana.durga.kedareswara.rao@amd.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230707024224.78907-1-frank.li@vivo.com>
 <20230707024224.78907-3-frank.li@vivo.com>
From:   Michal Simek <michal.simek@amd.com>
In-Reply-To: <20230707024224.78907-3-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0052.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::15) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|MN0PR12MB5977:EE_
X-MS-Office365-Filtering-Correlation-Id: 453067cd-a933-404d-31a0-08db7eb25c65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZnWDqOvM4/HRc8E49U1KLcIFI1AcVZywuXjM/r2EDrrEevx2rGSaw9vzgABrqJ4N9iTHDMYd4rIQY03h2rp7DDtLuREFHBk8OkEgq98d3LiNc4cj0N9fVtPEx5ohyMMzsvgi49xlEMWCItnYLZB46xNUAGWGTdCXwv3KOYGV6AQ4Cs0zdCiki9wWVR5PJysG+6JAZRlKECWvbrw7Bw5gv0qreN6RGqasr78fKqy/OLe6FC3GtesC0nkaNJivi92hINSDjZkM8kegvJGVCLvbRj6znmw4SGlqbbvELBH8b2Y8WtmPe19GYF5eUllF6G3JvidDkXVKGD4JawU0TGQXw+3Tgq65/uezPJC6Px+rqQbUEgKKucvhp6WGgCRkjg8gwsZZKTnv96gC4DO08lY6SwJegpOY7l4vyEqnNjdfLpwQkoUtU278ZRt6uDkOxsn9x1aEJkmM6u/d35yxQtkIG5NsC83LSwNEGCgnkdq6Oy9J7eiRWIU+Zr2F8KF1BYoPysqtD4lbaVmBZZ5wIMW5FCTnAtsJLlLJjx1En3pylh6tjT2+333U0jHLzq4rrxAEmbWw3FJwByx6Se2fVaGcEkXpYpcwoGAfVmmaVQkjASh/QdogjUzWkTwn3ycMnd7/7dg+MngUaA5yBnBs9xerlA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4758.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(346002)(396003)(136003)(39860400002)(451199021)(6486002)(478600001)(110136005)(6666004)(2616005)(26005)(186003)(6512007)(53546011)(2906002)(66556008)(41300700001)(316002)(66946007)(44832011)(8676002)(5660300002)(8936002)(38100700002)(4326008)(66476007)(36756003)(31696002)(83380400001)(6506007)(86362001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MVMzN0tTVE5uamdRRk53MGdaTnM1ck5nNVdJcnRxcnVaUVRvR0I1ZHNoYy9L?=
 =?utf-8?B?NThVNGg2d0txZFU1RHhRR3dlL2h1bzFFb0wzYk15UHdrSnB5ZmhPN1kvWDE1?=
 =?utf-8?B?TERaL2VaWFIwTXdFSENtK2tUK2IydjdyOGw3SkpDd0RFcS9Pbk56bU1zVG9k?=
 =?utf-8?B?dUIyVkNEd3dJRWp2TnozVW9uRkwvSGc2a3ErQmFsNWRSVmIvUW5XcS84SUxa?=
 =?utf-8?B?SDBUUlZqNStHUDUwNjkvam4xL1lQdDZEYkN2ZGFUQldvd2I4MElKaVVOdm16?=
 =?utf-8?B?bDUwOS96ZHJtdmJ3Y3FUWU5JcVdCdzFJL1JPb2VTQXh6UmZkRmY1dVFGYkww?=
 =?utf-8?B?SWhrdTZ4T01JdmpPaVJmdXVRZkY5dnZoSXhIQnpZbldCTnVGQnJVdXZMWUM1?=
 =?utf-8?B?SWJURGtKZjZHVGZmRENpRTROUXBtMEpFK1g0bXkwS25yZDh6TjRvTjZJVkYv?=
 =?utf-8?B?YkVLNmhia0FaWW1lVWpiSEpra3laUFlYNTN3MVpQNGpTMWtvMEVYaW43d1Jy?=
 =?utf-8?B?bGd1TjFUSkU4ZTREUmlyNUhiRy9FUTY3NXRYMUpmZTVDSG12TUMzTjZqSy9x?=
 =?utf-8?B?SkRVR0R4YTJxY09qMXFZWnBRQnJYWjl3S1BrTnBHa1FVeGViNlhqcklnTzRC?=
 =?utf-8?B?VEVnRmg2aUxmcVNURjU2NjdpTDhaMVRHbzYwUURpMTdFRDhnOTB1bXdHZEtR?=
 =?utf-8?B?RlRNcXhCQmxQZS9LUUdKeTg5YXhQYzlLdnNnMHlIZWpxZmNpUUVhVVpLQVlO?=
 =?utf-8?B?S0dzdmlLcjlMVmpZTW9JNC91R2lNTlV1VTNSOGdaekVKMUhiRDJJbUR0dG1O?=
 =?utf-8?B?QWtGcWdmVlVkSjJWV3NNMlAwZlVZMUpaUFVnVHZKVzFvN3R0VzhuZ1lZRmVa?=
 =?utf-8?B?MmZZQzRWTlVwbTlpQk1YcFZkbzJ1ZVQwejRyUXV5eVJqT2lWSE9zamV3RVQv?=
 =?utf-8?B?anQrVmdxbThSc1RvNEdlOG1mWk9zUVZyczZlZFR0VGtZZHBzdmlTYjZ6V0RD?=
 =?utf-8?B?ZjQvT2VNZkh0VGRzTEdtNDlaVkRLYTlrZllFekxpRDdtb3gwSUM5NTVCSFVt?=
 =?utf-8?B?ZFdwTzBUMStlL0hTdzZWbituT1F4RDhUaDVraFRkY1JZbzJHMG95a0FlVmVV?=
 =?utf-8?B?L215WnZiQlo0eCt3blhSTlNkQ3ovMGNnd2lWWVJQUnhvamU1TGhVUVU0dWpU?=
 =?utf-8?B?OXl1N3NBRnJHaGdxeTVEOE9jMHZkbGtpcXhDYnNZMVB3cm8xOUNEanJLa3BC?=
 =?utf-8?B?UE9nWWY1dDFvLzFDempXWkJpWHZCRkxoOHBSdGhHZzJ3TENBcTVkdHV2UjQy?=
 =?utf-8?B?S3pHNmtOOHdycFdHUUpPUmtLLzlnRDN6NkY5OWM5YXZCVVVQNCtXL1Z1QVU5?=
 =?utf-8?B?ZmxVamNVUUtjR2MzY25mNndqaC9RdTFRNXRDT3doTHQ2ekpJL1BvODlTcFZR?=
 =?utf-8?B?N1ZYa3pHVzJ0VnduQTUxdGUzanowMldCOEVMUTBxTGl4WStZNHFEVlFQdWIy?=
 =?utf-8?B?K3A5NjdaV2oxQWwxUGNUNzl5L1dqTnNEakdKOTFoSWQyTTRFcTdiQWg5bnE2?=
 =?utf-8?B?K0ZpZTF1MTNtVFUvMzgxMGFuaDVJbGZBc1p0REx6ZEdSeW1OL2NkTS9DZnl5?=
 =?utf-8?B?OVpFVDZuNkRpaXM0aUpoay9ZWjZnUDU0QXowZEFQWWVlWEdWRnlpVmZ6bkt0?=
 =?utf-8?B?c0NhUWhySFpPTWFWRVRrWEc3QnJ5OUhpS21zYStDYVllRFpEQ1pSOC9pSXhs?=
 =?utf-8?B?T1ZHNkJkbzZtZU9URWQyR0puQTNZUXB1UVdNZFFPRHVEbzlZNGFkU2U5REd3?=
 =?utf-8?B?NW53RkV6anpBTDZxeE53OC9NRFltTE02TFk5Q29rMWJ3MEFLeHF6U3ZmTUNY?=
 =?utf-8?B?dnFFOFFOTUxJRG15dHdoZy9BU0dqWmxLN0lmdHI0RXNmT3NLdGkvaWdwYm1w?=
 =?utf-8?B?OFlOQVFteWJ4OU1taStNR0ZtVXdrR1pIaUo3QnRDamlvYjUyYmsxTFpXakVD?=
 =?utf-8?B?TTFTaTRSUUdDQTJOQjN3LzRLWGZpdk9UbFZBKzBDVG85VTNWN1ZzTSs2UVhW?=
 =?utf-8?B?U1ZoY3hGa2NBRWhyMHVQcG5qSjI5bTM0cC9ZQUE5ZmM3cSt5cCtTRXZZVnpo?=
 =?utf-8?Q?LxFkFVbbxUIUSx7xcwpSsvHU8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 453067cd-a933-404d-31a0-08db7eb25c65
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 06:21:12.6436
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1ah6G8bDrkV6M7+z4mLuWzwSPRi5g4mPyqFeoqLgaA0oc9eDXXCbEHXiQiC/85u8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5977
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



On 7/7/23 04:42, Yangtao Li wrote:
> Convert platform_get_resource(), devm_ioremap_resource() to a single
> call to devm_platform_get_and_ioremap_resource(), as this is exactly
> what this function does.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>   drivers/misc/xilinx_tmr_manager.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/misc/xilinx_tmr_manager.c b/drivers/misc/xilinx_tmr_manager.c
> index 0ef55e06d3a0..2e7a5f37a01f 100644
> --- a/drivers/misc/xilinx_tmr_manager.c
> +++ b/drivers/misc/xilinx_tmr_manager.c
> @@ -170,8 +170,7 @@ static int xtmr_manager_probe(struct platform_device *pdev)
>   	if (!xtmr_manager)
>   		return -ENOMEM;
>   
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	xtmr_manager->regs =  devm_ioremap_resource(&pdev->dev, res);
> +	xtmr_manager->regs = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
>   	if (IS_ERR(xtmr_manager->regs))
>   		return PTR_ERR(xtmr_manager->regs);
>   

Reviewed-by: Michal Simek <michal.simek@amd.com>

Thanks,
M
