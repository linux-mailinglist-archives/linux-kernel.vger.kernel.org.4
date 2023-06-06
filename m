Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CECF723C44
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 10:54:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232649AbjFFIyK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 04:54:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237306AbjFFIyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 04:54:06 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on20607.outbound.protection.outlook.com [IPv6:2a01:111:f400:7ea9::607])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBE49109;
        Tue,  6 Jun 2023 01:54:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WskwSm8NktaWPjLtH7tW6mAX5JayYchEjsu8bmoGiKTbSSX336sPZIR89DRypK0PzvckEw5XYUUKybIzQGGniatElmauzIqvZOcGzYhrLybb+F2x4zD01sOnu66Xd7xqS6gLfY6V0RpAFQbY4HU2QkQAAxNIQFDLHz9MvYA1KlX6tL2oHJVWoUvP/EBRhsQAnAz5UYIw8shZFF96HRLXXUtqfqipPF10b85y6b79VLVBZYJV9V+F39cPT/dEovOaWWewQH0FUg6Wj6TsK9CM2Ia5JXabVJ9OSYYWDUy7y0LvC6OHfnwveewmvwwO7ckxb4WmijzEaJN0J9FGc6qpJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lk68J4R4+yFiPH453QIrLaakQFCfEMvf0lcZcSLot/s=;
 b=DMpyQzaUmsnf3buLEXR/04xOr6zb3H1X83c2jMHngdaKMdYmWO23MssiViCVVYLebJyfdiFm/VhMT11gtkNFSBulqPtR2o6b0r9digAS9WE5Y/zzjhYvua7nY6L4vL/vSl5jtjWe7d2G2nHBJFjOswbYNbmPPOo15DwDVB40RSqb+Wqha24cgVwPqeSnS7m7Z4TTXYj+jNk92mX60/1n4vAcsSDqCKY7s9ZM2TOjy9jcQBO5dx8qTi0Dn0aGCcF81OE51fYArP2BORyFPazIipE3oIHk4ZMj/nEsaFHuPLQlkrjHHrj2XcXpwP7PyMR8jQdfI91uF/0UXVUTuNRhxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lk68J4R4+yFiPH453QIrLaakQFCfEMvf0lcZcSLot/s=;
 b=RGgabu8idxqm4odehepsv6uRhefRp4kmBiLO9oOshB6eImKJxwnIPjlKZHO5lxS52trpVOyDgEsXbXv/F4Ch2iwZCMSdExMA19p0jD/tQ4Bta0T/0lkWJgf7kIs1toi8jDkx+SyvoQ0TxRKVlYFylHsq1ZiQ1u6uHggjp2bkkDh7ogCeExOPrZ2v703LclZj/AMXsHU7L3kKPinKqlIZgEjzNa0ISTg3aJg1lDoCVyLnp1U8dc21xcVEbJWpB+sjg4Zhdm4kgJwh7sMCAlrP/Cb3baKZce5QQ1c0LfcpltffLtUpzkobYe7j4+nL6Xdtw8kUUnFytAbBHX2rtFI7hA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 CH3PR12MB9193.namprd12.prod.outlook.com (2603:10b6:610:195::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Tue, 6 Jun
 2023 08:54:01 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::21ef:9d59:5b2d:f1e8]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::21ef:9d59:5b2d:f1e8%4]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 08:54:01 +0000
Message-ID: <56dcfcff-3b36-25ea-eb72-2b9d2f8f3883@nvidia.com>
Date:   Tue, 6 Jun 2023 09:53:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] gpio: tegra186: Check PMC driver status before any
 request
Content-Language: en-US
To:     Prathamesh Shete <pshete@nvidia.com>, linus.walleij@linaro.org,
        brgl@bgdev.pl, thierry.reding@gmail.com,
        linux-tegra@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     smangipudi@nvidia.com, Manish Bhardwaj <mbhardwaj@nvidia.com>
References: <20230606071717.8088-1-pshete@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <20230606071717.8088-1-pshete@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0307.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a5::31) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|CH3PR12MB9193:EE_
X-MS-Office365-Filtering-Correlation-Id: 0dda8347-9daa-4cdf-b12b-08db666b9257
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R8aO/95157PmTj9+Ul+zy0q1J77C9kVO1eUYXV8buw90Sm4xXh6W6qfIElXKdpqZ6OsgyBwIY+5vAO5vBQQ6ZU12RjWBXkp8qHSsKex7XCqyEFHql9zOBfWtxd4DedIY/koM09nup2K1sUd03tDWRpG2GSMkHpp7xCCOSZS03M4uZ4RgE5GkwxlT/THJLePEr+UGH7gPgfp+xGr83MOg3cFt0wj18YAUGimKlLdavtWzOuI1pFv6YH+Yggak3w13eFeYl2sff8yvbVp1elE/IQrzwtvvspqfCUVrDePWzrEgyYUTuVLrXtbvSmpi0wbSvzXCyLjlf6+v03XV37gvZalgl78vICai4dAfUXdq7kEdD5EnDMlpTVIXH0zKMPxsb/6n9FpDNlYN8LUT37GefamBybVQhsi23dOrOFsodPcholWykao2xtVOqvKoUq6fZsyCyGVKDLXvck1YXrIuGyLfotOnjSaCI+gVtVnjJWj8TOoUc+ruhzUozSOSoWreQXGeiAI0W8Y9QlPww2LXQKym9OiVRwuPmeTXsDMjT6xyc+WHbNYZVku6jo4CS+st2q3uE384hFPlyQ68QhlIGSuIp13c9sp8C+vEMCLIvPc+AtDpRfneSPA5h0pjOloymKrdLUdF7skG2bvy1mUheQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(366004)(136003)(396003)(346002)(451199021)(66476007)(66946007)(478600001)(31686004)(316002)(2906002)(8936002)(41300700001)(4326008)(8676002)(66556008)(6666004)(5660300002)(6486002)(53546011)(55236004)(26005)(107886003)(6506007)(6512007)(38100700002)(2616005)(186003)(83380400001)(36756003)(86362001)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aTBMZFNwWUl2cGs2NktaY3RCTnRVRFNtNHF4a3hBSWxxa2pqR2xyQkV6VkFW?=
 =?utf-8?B?cVJZUmUwaHlsOVBabStqa0JueW5PNzBOc05qMzA1dGY1UERUNzFmY3pQaW9U?=
 =?utf-8?B?Z05RU1FoZDhzUUhJcDU2RnZCdzlJVWFRU1ZhZUc4SkhzUFl1SW5XU3loR2hM?=
 =?utf-8?B?QU5SMlQrVzJ4UU8xR01Sb3FJNjM3OHgvazVPRUFrU1drbEZqa0xxMlRmKzZz?=
 =?utf-8?B?SFdwQnEzTzAvNHl6bXdudkdUcWdFZzhWVEYrZE53MWR0aHFFd0R3dlRHNFo5?=
 =?utf-8?B?b0RoWmwvOVFTVVluandwMjE4QTk0Q3Q0UVpJQXJBRll1bDdIZ3daTEd2eUNH?=
 =?utf-8?B?a0JrMDZCS0RoT21tT1FEMVVabmpsWmFYaSswTENvRzY3ekdmN0ZQNk1qQ243?=
 =?utf-8?B?MWF1WWUyMUgydmg2VkZ1QnRTWnBNenA2NlBiWUFja1drL2tpbjZaRWl5OXd0?=
 =?utf-8?B?YjRPRDloUW5keHd0QUNKNFNRSDcxN2hkdHA2V3I0aXdmczJ6bjBHdG84bEVu?=
 =?utf-8?B?ZUdIUHlxditVMjdBVHhOZ25JS1FvL2gxWmZkRTB3S3RLdVZpQno1U2R3MWtm?=
 =?utf-8?B?VFY2eVhjdmo4czZhSG1CRFNnN2dwTG43OVpveCtXcERTZU9WanVuSHlCaUR3?=
 =?utf-8?B?MGN4MDg2WDhrbUNsZFg5QkxlS2VTRHBZYUFvNTUwUHA1bzhWV0gzekcvQWx3?=
 =?utf-8?B?bm5MUUkySE9Id09mbmI1dTBiL1NBWmpaemJLWi96VlFITnVBNWE5N0Y3N0tY?=
 =?utf-8?B?MnhrT24rY0FMcWkvZGV5alYwU0hqNW5VREVycXR1SjB3UWxXaHlCMS9ydVYv?=
 =?utf-8?B?WUNUM1J5WHZIM2hPdXRSM2VESkx3NE1CT3ltVjBncHlwdVZCMVpRaUF4d0RL?=
 =?utf-8?B?bDlIRmhOWURrZjM1L0V2aURSK3NRdGRNcEZSSE02SmI3T0syc1lRMU4zMGRC?=
 =?utf-8?B?R3JHTXBlOFA1L1ROL1pwVHZpZGt2S1FaSlg1TSs1aUExWEdVZ2VjMEdqbFNL?=
 =?utf-8?B?L1dUUkpJcEdIaTVFdG1haHQxcTE0bVJtQ0graEJTNFVOc21sKytabS90djNq?=
 =?utf-8?B?SGdqMVVlVDFod0w5S0k5VDEwTHlUMG9WTDJDcFIzMkoyc2Ntby9BWXY1OS8w?=
 =?utf-8?B?S3Zqcm4wdS9kTUJ3Q0w3czArYUFSM1ptai9yTDkrOUx5YTRkdmsxOXB4ZHV1?=
 =?utf-8?B?MVJHWGhORU16bFhYd1Exa3RSTXpzZFdPTm5pR0hqUStnNWV6NjJRNUxSa1Y2?=
 =?utf-8?B?azlqWnZkREo2akJhb2YyQnFJV3dMcFF0QllHblRDbERDcHNKekkyQlJwSkhh?=
 =?utf-8?B?NDJtV2FKdHgxQ2RtVXJ0dzBYS3dVM0xWK2RBbUZWbWxFV2Q1cUM3Vjgwak1Q?=
 =?utf-8?B?eHN0SDRuYmZ0SkYvc0hNRSttMUlyNkszV29PNFpuNy9XN2o3Rk1kVFVnMzJ6?=
 =?utf-8?B?ci84cWgwemdtTTVhaEJtTXlQN2J0S215WTJ6VkswL0lSYVFNUEJRK29kSGh2?=
 =?utf-8?B?MXBnTUZsVlloWG5Rd2NjQTZ5NVdOTEE2OUFDNUVBK25zY1dEcVJzWWdsNHIr?=
 =?utf-8?B?SEFlOFZSUGc3bG5qMlFzNzdKc0JrZGJITlZrMzZJbFlWU2Erc0J1NUxsZlNM?=
 =?utf-8?B?SVlPQStjL0d2UTVXckZJM1ZraEtPbS9tS0k0STlGNVVwT2s2VExITm9FVHZF?=
 =?utf-8?B?THhPTVNxY2kyVGNwN0ZaU21xRDBaZ09vVDRXZ3A3Smo3WlBtNEJlaG9zWkRs?=
 =?utf-8?B?bGYyZEZRRUFFck5kSmV0RFM1VVdRQWxPemt5VUQ2NDNKVDhyb2lmU3NCUHQz?=
 =?utf-8?B?S3RycUg5cjdxbXRxU1hKV0dDeUtJNjgwT0s5L2NmZDhERU55VmloN09ONGVP?=
 =?utf-8?B?Und3U0Uva3FpVG1sMHlTWmlFVStVdUJFb2NKa2xmWm1neEpIenptVGhTMkhZ?=
 =?utf-8?B?MXhBdERSMjBSay9qMG1UM1lNbS9uTE9sbXFCaFRWK2VLUkc4L3pGVU1Tclk5?=
 =?utf-8?B?R2xlSmVsS1JEWmk5dnFqQ0xWQjhQcE9wVjdTQWF0dDBRTlhFbDN4TDNMcEh4?=
 =?utf-8?B?N2IvY2o3d3dHa2dWVVlVdzAvY2tkaFdEVFozeVRoZHlsRW0vL0hyRlRONmFa?=
 =?utf-8?B?ZFU2R1BCUTE1cG1wcHFDbWs1U3RPZmhJMHk4U1dhaSs2TmRxN0ZBNGVDL0po?=
 =?utf-8?B?b1E9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dda8347-9daa-4cdf-b12b-08db666b9257
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 08:54:00.9810
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Fd8QuHt6hW8hoBnJq6d3bJ4k5GQmkjSyqpElCMkK5or+fbUKReNaY5h2JkIgjtYdm4k5Hb3392IOFAmlDH6WQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9193
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 06/06/2023 08:17, Prathamesh Shete wrote:
> This patch fixes the issue where even if PMC driver status is
> disabled still we are trying to look up for the IRQ domain
> that PMC driver would've registered if it had been enabled.

It might be clearer to say ...

When the PMC device is disabled, probing of the Tegra186 GPIO driver 
fails because the IRQ domain that is registered by the PMC driver is not 
found. Fix this by checking to see if the PMC device is enabled before 
attempting to lookup the IRQ domain registered by the PMC.

Otherwise ...

Reviewed-by: Jon Hunter <jonathanh@nvidia.com>

> Signed-off-by: Manish Bhardwaj <mbhardwaj@nvidia.com>
> Signed-off-by: Prathamesh Shete <pshete@nvidia.com>
> ---
>   drivers/gpio/gpio-tegra186.c | 14 +++++++++-----
>   1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-tegra186.c b/drivers/gpio/gpio-tegra186.c
> index 464b0ea3b6f1..80d08ddde40e 100644
> --- a/drivers/gpio/gpio-tegra186.c
> +++ b/drivers/gpio/gpio-tegra186.c
> @@ -964,11 +964,15 @@ static int tegra186_gpio_probe(struct platform_device *pdev)
>   
>   	np = of_find_matching_node(NULL, tegra186_pmc_of_match);
>   	if (np) {
> -		irq->parent_domain = irq_find_host(np);
> -		of_node_put(np);
> -
> -		if (!irq->parent_domain)
> -			return -EPROBE_DEFER;
> +		if (of_device_is_available(np)) {
> +			irq->parent_domain = irq_find_host(np);
> +			of_node_put(np);
> +
> +			if (!irq->parent_domain)
> +				return -EPROBE_DEFER;
> +		} else {
> +			of_node_put(np);
> +		}
>   	}
>   
>   	irq->map = devm_kcalloc(&pdev->dev, gpio->gpio.ngpio,

-- 
nvpublic
