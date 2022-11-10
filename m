Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC189624314
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 14:19:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbiKJNTC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 08:19:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbiKJNSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 08:18:55 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2086.outbound.protection.outlook.com [40.107.237.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D28A4725FA;
        Thu, 10 Nov 2022 05:18:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZEdXcX5r0G2Xd+V9CKDbLdWN3U9Y5XNTxDlLqqYsE4APkF9HWJHYJ7SSisud4JWHv5/w82IcB/hFxC8qlFVgGxaB+S5t65I82Pia0XyqSlJi0JFELKkwDZjoaOFx2OWG6WYtHObEzjJA7mdHv6xW3F9Mhj7pCnwG1RlORobwoNwhi0G2lWYB3M+H/HM483DKoxkFFBr2xq9oQILr/4PXxc2zbprKF8o7bskOEzLbWJDB3ys9ulEGcuUiTQ0X+lpOCWudcQAO+rHVgfa3qqG5L2RGN7anKD5x28zZAYnUgWBUHXF4lAl7KV2GJnmiSVgbiB7rjBJpjlmJltsTVQJ9Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HROMns94G3VadlJuNC0TNQ92akbzPCZno526Cw7o2/Q=;
 b=YoDuYce/zPr5P2a/9BWIkMxPYXgeKUFbAnlH8m7qfUHa7KoBN9CAnwYL8zPrvmrhJFRL9hUyT8R5jIWcZ7wMhzAnf+4i/CsrHpAyqzxHbAFBQBXDwHfO+DrAOF8sEDwJhKDTjFKPhqSVwpjb6PdHoITgTte+U/cnUDg1OPmhmxZqr6099kWEIdDFM1TWHCsDMYXjCBVjpEt7exPYmOTAWo4+gSVgd0it4CUyhWz2dkbIhWniNdcKe2pPeyU1rcCYQKVS5Z+khgHN9rOKLWpfMi2oyg+DUtTLfSDOuL1OS23EqoIhLzadI6E9E5Im2gRWxid0U0j97TMLC4FGDjlf3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HROMns94G3VadlJuNC0TNQ92akbzPCZno526Cw7o2/Q=;
 b=Zas2blWq/+uDF8OlfW3gsvP4pwifbm4mxiTMAO0trRtj99teUWnwclLa9vbk4ierlKJ7XwrH5nu6FmZDIT3PzwPUcpoFK7LAuJEK4Uin4acfnIK/I79uIu9FBaY9I3yAWcXqfOllsa5n32PZd6xIfTcBOnauaLJ5Mz4xgFq+40BzLh9XPwgII+wx9yraiKEXcI8bRWZmu1ghSo2Hv8DJItDHsF22BNOQYdv6RPSZapXysW26U3D6/Mh0IL0MO79dGMLlr7zANLSx5BK1grA8K2hucEEQurVEU8frnECSOjzBe/0m1/rPgXN1z+WTmZts7LpWNT3a+XmR6sE856/T9g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 MW4PR12MB6828.namprd12.prod.outlook.com (2603:10b6:303:209::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.25; Thu, 10 Nov
 2022 13:18:37 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::1912:a3a8:1a8d:a960]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::1912:a3a8:1a8d:a960%5]) with mapi id 15.20.5791.026; Thu, 10 Nov 2022
 13:18:36 +0000
Message-ID: <6b282110-c9dc-c4ae-9003-1e75c3a0ff98@nvidia.com>
Date:   Thu, 10 Nov 2022 13:18:30 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] pwm: tegra: Fix 32 bit build
Content-Language: en-US
To:     Steven Price <steven.price@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-tegra@vger.kernel.org
References: <20221110114549.34121-1-steven.price@arm.com>
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <20221110114549.34121-1-steven.price@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LNXP265CA0062.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5d::26) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|MW4PR12MB6828:EE_
X-MS-Office365-Filtering-Correlation-Id: 62516a3c-ea71-47ab-b3ed-08dac31e1346
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: szFXn3RPJpznAxdEDeEMyO3nnMfvmh8tn2Kea0KIInXSMl2BCS/11mthrgTN/QVYHpvjNWj11uatsbqjDE7ZxQtZSh5TJ6yq/9X1GWdtVJ5dED+3GrN8eNvPs72eZNoX369tK4pwUxLlf3sQOLcbMFYL824HCpZkhbNlo/jhO35etzibTqWOJQD3hgnRKmpBFavI2bhIPE6UQ4eX6XJUX+7+qiezmidXRb6XT/0VeEHOT1QDvIj/kgAuIQyd1HHTh2Hk0NIikBLn5zB/6IG13zsLcUfqEBNj9rD0nXzDsdxn99Id9xwwbo5IOrkhsRlBurX6UjLamHLPZXwjQkFBj4+59ZO1fHMIsQS8EK0pYiorU/ZGO9fyCnm97A44P0iAjBgTUDsn3H8thjUuw/y9/haLEJA52H6ju0ckfaBEXcnYkbC412gC72Cl6Lvgj92FbN+QlNd2TbcBbYdlztjc5FuW3neFJk/jjFzTsVqEe8aeQ4GqwWbxHyi8uMJyWx8eHrvkIhQgBKGCaYYyUWHiYUDI1tpiAacu7hmH3PpvoyYliKEAUyORR/ttwg9WCj55xpPpcqZ+El3JLjYaP87ec11QIcHK7DmId1MnGuQZY9n0yyXBWcT9fKq/dWHlJM2uipzyk5XKLnxDXadNRj953J+Cgqeo5qRVgB4TUCXutJ2kdysXL7H5ZbeeVgrvAsdX/n/RmP2g+Pu3KwljeLHOHm4rRWueIDE0AeqzpeEo8b8Hmjvj+CFERPiFn7zt4yD866ZW/haGCGJqE59w/IpXFEj9TU1DZ287Zs4jI9wM0N0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(366004)(346002)(376002)(136003)(451199015)(8676002)(110136005)(66476007)(316002)(4326008)(66946007)(83380400001)(5660300002)(2906002)(6486002)(31696002)(66556008)(38100700002)(6506007)(6666004)(8936002)(53546011)(86362001)(55236004)(26005)(6512007)(478600001)(2616005)(41300700001)(31686004)(186003)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YVhXZUt6K0hrNFZCaWJJakRNTkpIdVpTVVJQdjZEWU9Mc3dyVHFnblVSQU9m?=
 =?utf-8?B?UFFtWHV1Ti81dDE5Qnc2WjhZQldmYzFsaExEcTF2S2hwL25kUHNTVXpaWTBw?=
 =?utf-8?B?R09YTmdrWVNsckNCTWRtYlFMTEVIZkJTQ21EUHhpTFZMSVUxV3ZjV1pQMGhT?=
 =?utf-8?B?aTJucDlqWnRjcjB3VjhqblUzNjdpbkZjR3RTUWMyeWRTTU1ZKzB2VTg2OFdX?=
 =?utf-8?B?dzgxV3NncjZiRy9na1BVWGZwRUVyU1ZFMHBVaHdVVlFIUW1kaVNJWGNacDUv?=
 =?utf-8?B?SVQyaytWNTlUbmVXdjZXdmdYRkEvUXNiNUtvL3VmUHkrbDVQNDJwQ0JuRkFw?=
 =?utf-8?B?NGpuSlRhdVpIaHU4UXRVYnRVWlhNa2F0bGpKajNpVjFBK0s1aENmWmJTVnl4?=
 =?utf-8?B?dXB2TzdqeWdadGNBUHpMdVpFRzczVE1UVWdENThnZ3ZpZEtCZGxqMnpVN2Nn?=
 =?utf-8?B?Y0hzOFNnb0VoYmYwNjNpZHJjS2dkS2dIMEZaNCt5RHFiTzc3bkZydFR2UFhG?=
 =?utf-8?B?N01ETXZ6dXo2ZGpOUUs1UEFxbE5ZYVhwOEE0ZnA1K0NzNWZzdkJ0WHpNa2VC?=
 =?utf-8?B?bEFMK2J3bitUSXhyNlFhZTZkSW5jRVdnbzJsZzkxRmIxRjdvbXdJQVFtSXc3?=
 =?utf-8?B?QkRoaHAwajlXa2tnWUNycENqMTQ4WXdtaEtWdlVBY1JrcmN2VHg3Tm8zdmtG?=
 =?utf-8?B?RFZxczdQczFYczQ1ZUpORjJNMUlXOGN2d2JmTHMvOFpmUjFZR2l0K29VK0ZF?=
 =?utf-8?B?Umo2TjBHR0g4K2pySmZiYlgvazJOdWpHMlIxVy80c0NmTUJjbWlveFpGUXor?=
 =?utf-8?B?dk9wcGxIeWpWaUp6ZTFDOVZ1Q29TOVUxekNVeVI5VXBHOHZiL2FFOHZiMVhu?=
 =?utf-8?B?eEtmQkNsZGRhcU9pR2xwSjY4SnZ5dTB2OTB0TGJGc1E1TjVnN2lRV2kzWFFh?=
 =?utf-8?B?SFkyYndXM0JMWVNpWDRVWkQvNHMzZkJCbDRnLzZvT2pHUlY2ZWxQSS9SdGV0?=
 =?utf-8?B?Q0VacENhYmdHb2d1MitSM3VHK21rcVUxcmwvY3BFdkptM0kyK3llckVUVFlZ?=
 =?utf-8?B?VDFGUXpWL3hkbXQvRnY3djBFMVhUVGdGN2dEYTl2OEZ0TmNEalZGeW5Tcklk?=
 =?utf-8?B?em9zMVFzTEtEN21WeXBUSTlCenVHRW92VjdmS3VSTlN1MzJKWGhNUU1MRi9G?=
 =?utf-8?B?T3d0Q2NHRUFzVXZpcy9hN0liTlJDck5NQ2dRdnI5b0NWb2xhbWlFaDU1Vzha?=
 =?utf-8?B?LzlQem9pc1U4ck8rUXFiRkoxWmRhTldaYzlxbWNWUE9jL3lvSytTMkxHQUhJ?=
 =?utf-8?B?YnF1S05VRno2MHNjVFppcjZldExUSkpRTjZRaER3WXU0YllRSlFuY29TYnY1?=
 =?utf-8?B?NWF0N29vRzN0cFdFWm1xTno3Y0pkeDEzWnZ0OWE4R1BQYmVFQ1JTYlJ0Yjc2?=
 =?utf-8?B?aG1PbDVzc2NqUVdvSlRHd2RVL01zSThFbGxGWlpRa05IVm5xVzZxWFZkYmRE?=
 =?utf-8?B?Y0Q3eUFidUwyVEdqdGRWNy9RUWhiV2QrUHlOSHdHYkV2QmQwbFVib3E1cU9T?=
 =?utf-8?B?RmNjY3l2S3QyTzdRa3Zld1BvcENteER2eC8vZkd4OUNoK1Fqa1NwYStDUTBj?=
 =?utf-8?B?SEFVOUdRaUJnbVRjbjg3NUQ0dmhRZHBHaGN1MWkvUGFzampOTHl4am5ONlVH?=
 =?utf-8?B?NFpTRkhDZUFLRE1ESWRsSHAzNmdJYTRkaWJyQjVEMFd1WGZuVHhkeEpWcXo0?=
 =?utf-8?B?RjlNSFZwYWtFZFNEclFMT01tY2J2ZG4vNjdBd3B2SElqYTZ1NndxNlR2RjY1?=
 =?utf-8?B?TU9mSzEra1FpdkxuRVNDMkNCVG14TW1qaHZCQkNNbitTd0tmR1ZuUDZFVFVu?=
 =?utf-8?B?cUtlaXhEVlRURDN2RkNBVHJIWFZRQ0Yxb0dHSE5ISzZHSWFpV0Fwd0l1anM3?=
 =?utf-8?B?Mm9KdjhsbHpHaVRrN0grdUU4a0Z4WlVlcEtsS1NiWlpHV0daRnhnY3d5UjRp?=
 =?utf-8?B?ZkJ3UG04VW5PSFVkQTRTNzNWNmVnQ2lDcVRodzFpSnN3Y3N2R3N6RU8zZEh4?=
 =?utf-8?B?Y0pIaEo1cEJHSzFVU05LTEIxeTI5NTRNNjNYMG1aUVFuSW9NQWM1QmhFNHY4?=
 =?utf-8?B?QmNQbHpKelg5bDZiUnpEeE1PcC9Mc3BRVU1qNXJLMnNoRVorUjByZ3ptdnNR?=
 =?utf-8?B?U1E9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62516a3c-ea71-47ab-b3ed-08dac31e1346
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2022 13:18:36.8369
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7MfdqDHpL7wx1K1w4ihh6wbppqWWKlgV78tANbi0/5JmMDocfnGGDJgjclpCHtXqPyTt0FLjfwgG932K0s6Wxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6828
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/11/2022 11:45, Steven Price wrote:
> The value of NSEC_PER_SEC << PWM_DUTY_WIDTH doesn't fix within a 32 bit
> integer causing a build warning/error (and the value truncated):
> 
>    drivers/pwm/pwm-tegra.c: In function ‘tegra_pwm_config’:
>    drivers/pwm/pwm-tegra.c:148:53: error: result of ‘1000000000 << 8’ requires 39 bits to represent, but ‘long int’ only has 32 bits [-Werror=shift-overflow=]
>      148 |   required_clk_rate = DIV_ROUND_UP_ULL(NSEC_PER_SEC << PWM_DUTY_WIDTH,
>          |                                                     ^~
> 
> Explicitly cast to a u64 to ensure the correct result.
> 
> Fixes: cfcb68817fb3 ("pwm: tegra: Improve required rate calculation")
> Signed-off-by: Steven Price <steven.price@arm.com>
> ---
>   drivers/pwm/pwm-tegra.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
> index 6fc4b69a3ba7..249dc0193297 100644
> --- a/drivers/pwm/pwm-tegra.c
> +++ b/drivers/pwm/pwm-tegra.c
> @@ -145,7 +145,7 @@ static int tegra_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
>   		 * source clock rate as required_clk_rate, PWM controller will
>   		 * be able to configure the requested period.
>   		 */
> -		required_clk_rate = DIV_ROUND_UP_ULL(NSEC_PER_SEC << PWM_DUTY_WIDTH,
> +		required_clk_rate = DIV_ROUND_UP_ULL((u64)NSEC_PER_SEC << PWM_DUTY_WIDTH,
>   						     period_ns);
>   
>   		if (required_clk_rate > clk_round_rate(pc->clk, required_clk_rate))


Thanks!

Reviewed-by: Jon Hunter <jonathanh@nvidia.com>

Jon

-- 
nvpublic
