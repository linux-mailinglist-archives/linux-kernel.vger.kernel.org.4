Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1BE7668B99
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 06:39:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235113AbjAMFjO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 00:39:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234842AbjAMFia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 00:38:30 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2071.outbound.protection.outlook.com [40.107.93.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63A1943E53;
        Thu, 12 Jan 2023 21:38:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JrpgzytHGlNgUbjpdHVCYM0+leLjYv8TGo4IqtB8/xK5vKfdl10uImHF2fhg0Km+tZ+Or9txW5ybuVfyZM3VdIXYWP4rNm9TmIZ842gKtA/TPE2uJQAEjcESV5h8Z1RPYuCXEZdFp19aH2fLqLWAMb29xzcvzT6PdUWSwVuSXoXS4rs3iLlrYrj3VroDookcE5hMVPeauO1exgYCSdOqOKCbJn+L0pwhWGAfNoBF7MGJXBni6cNjbZwlYk5gT29VTIqPjJ9gJZyAcdNM3hFgbQ8YDVL8Qx6wrUgVIiHGCMT6VstxjSFJPeSPt0HPbNlH66sUwUSfhy3hpXDRSEfohw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jmSK0+FpV/xnaOmfDZzYNEYuZMpBLVgrDRKLaA8a11U=;
 b=eVIAMWut/UR4I7Yer1a1cfGgwU74r7oqEs0gQUIovJreGfaYA2p30xDKUIiPbYqZoHwJbmMTSzNN9clFxTJG+d+hVLa6nnFTarYx9996z1pJyikkMVYkCQX/3bcuTQCGP1fgoome30joXZqwOXDQp3a2I8iWCkjKkDJxRqcraTatL4++W5a40wmU3VnCGi5Gomk9n7NFot1xvmOSAJFfkJwsxHCNzqK85+9yuSbPCSyasAjgG5lqQpVBVKgUTyam/rOxIozD0siE98p9Nads/9b3I/iQ8CCyMihVhZBiaA8yT+ppAm0nfBjtTkxknAM0GpWIzp/aWjXVYUkDYuweeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jmSK0+FpV/xnaOmfDZzYNEYuZMpBLVgrDRKLaA8a11U=;
 b=xl7v8rI/3rgJsu1bt02wmWYtNbh6weKFUfJhzthhUPQ4bCFMnncWuJKmIclcL08KRLX6w3sRDGAnkSFt8Ul+Bu0d8uGlUk7GYAdfGI87fvyRjDQMvc1o/FfwGsuJPTfZ3XP7Wai2ANM3dzdnKUw7zEBxmHTYSjruLPkQN2Pp8ew=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SJ1PR12MB6146.namprd12.prod.outlook.com (2603:10b6:a03:45b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Fri, 13 Jan
 2023 05:38:26 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::ff3c:2d37:75f3:442a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::ff3c:2d37:75f3:442a%7]) with mapi id 15.20.5986.018; Fri, 13 Jan 2023
 05:38:26 +0000
Message-ID: <a3d870c7-c906-dc89-7a1c-e933b3a32536@amd.com>
Date:   Thu, 12 Jan 2023 23:38:23 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v2 4/6] Documentation: amd_pstate: Move amd_pstate param
 to alphabetical order
Content-Language: en-US
To:     Wyes Karny <wyes.karny@amd.com>,
        Rafael J Wysocki <rafael@kernel.org>,
        Huang Rui <ray.huang@amd.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Viresh Kumar <viresh.kumar@linaro.org>, Perry.Yuan@amd.com,
        Ananth Narayan <ananth.narayan@amd.com>, gautham.shenoy@amd.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>,
        santosh.shukla@amd.com
References: <20230113052141.2874296-1-wyes.karny@amd.com>
 <20230113052141.2874296-5-wyes.karny@amd.com>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20230113052141.2874296-5-wyes.karny@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR07CA0090.namprd07.prod.outlook.com
 (2603:10b6:5:337::23) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SJ1PR12MB6146:EE_
X-MS-Office365-Filtering-Correlation-Id: 59f40f44-3de3-4b9f-249c-08daf52864a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2GTsClL9dmnEftS7oDLVHFvKLlHDEUcBXyqT6FbMFhbH+uc7vsn7i1EsFIdWQJrIHac8ejFn32kG1k1ouKpBG4dQ355YwKpX1geof2QxO5MvRdd70KphZYIvLXYssblZs14DWJbW+MGW4UZGYxd7W6n79FzbsNQDK8YS8GKHk4TOdZmQsAtPt4ZFOLmO0xr5XhZFstQ7FIcpL/nUYSDTVB7rWWyJnzhWqxI7VrPha+lgQYuH6T72E99CnUD47VFzY2XCXCAqrc0pMYWX9IcvTngKRnlHcqs2FV+dvjitu7iUj4IunMpOUvmKTsfTf5/tSR+4X16nBbIlt0dTxEfqHlVB2Ea1nxjgxRGyfMuJ96A+X7cOKXsSUE7bMUQAfP0AKrl++S3eY+Mp38eqxacji+yCEfDp+a+L1iPCHDTX4dHgFSqjTrOf8EPgMkxhNnc5MQXZNp2Ny1BgeeknMTEzUA2zEOkCJHwvzlGCopuREl2xhgwnAnZ3HQYR4S3luh4UskSvgVFYJbp+3hvizHT0OYnwV6Huvj9y4aBbOpBre3ERQOaXj0xdbvT4wuylsinV7sc5aFAnUWJuEWs84+RWjKoQgrmmEGmTMkhRbwTMuosLfKcEmpe7yoqxe7P/Du9nz4l58prcw5PpLWuaZRgMltBfYyGDAklfBcNkatVrfXcd3HEm32u6Eio32avs1y33fRfRgHflG2sxii8tkTpg72Yik7OUDlSkskzb52nXqYE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(346002)(136003)(39860400002)(376002)(451199015)(8936002)(2906002)(5660300002)(41300700001)(66556008)(4326008)(8676002)(316002)(66946007)(66476007)(110136005)(6636002)(6512007)(38100700002)(2616005)(86362001)(44832011)(31686004)(186003)(31696002)(83380400001)(36756003)(53546011)(6506007)(478600001)(6666004)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M2NVN3h4VEJ5SHBsZWJ5eGxmdDVvNXBQdjVZTC9laVdlbmZ2RE5YUk4zVWpW?=
 =?utf-8?B?YndhRTJjbWVPVlBobE5sQ0dMd2M3Ri93WWxIcU51Sis4SmVIUDg5MUIvNWI1?=
 =?utf-8?B?OGJRNERqaTZubFBSMURWUndvK0NqVHJBRlByRkJpbzUyVE1ZQ1FaUWU5aEhj?=
 =?utf-8?B?SVlLWExZcGpxSGpVVEdiNHpyaWo1ZitIakJxdU5RejBEai9KKzV6cVBjM0FW?=
 =?utf-8?B?K0FxMjlwRkdQUG5DUngxVGxJOWhRbjJ6QmdqWlNUcHdPS3FxWmVGdHB1RnpO?=
 =?utf-8?B?bmVNNVlxeUVnZm5RWmd5S2tBZEp4U1Bna2JKeXlPUVQ4bnM0K0tpT3JLNCtG?=
 =?utf-8?B?b1BHZTVLYUxWN0QrSmE2dzRrcmpMZlVzNUtyUVhMcXNlMkVERzlEL1l1L0ZQ?=
 =?utf-8?B?TXJBVnVMKzBSdVlkZTdoOVJMV0JESnRURjhFcWcybE1zNFY1eThwaGRyUWF4?=
 =?utf-8?B?cEpyOElwc1k1dENZN2pjb0dPWHpLREJkK2p3VXNaa3JVL0YreHBlYk1jTm1J?=
 =?utf-8?B?c2pQSlVwR1FLZmQ2ZG1GOWpHY0xCb3ZwQUJ5ZmY3TENNZFN1bE5OZlVnOHFL?=
 =?utf-8?B?c3FUTGJLaDgweXBUTVhnNDNLb0ZYaW0vUVNHUk5raUdEeFpvSlVOWEhLM1Zt?=
 =?utf-8?B?NDdnY2loempLRms3SFpyRXpHYzdkZEp0OTZOL2tSaU5uRU9CaFBsOVljWmlm?=
 =?utf-8?B?K2Q5R2IwMEo4RjNlQjVQcHliMXFURmNycURKei82RTJvQUMrWEg4Z2xtTUww?=
 =?utf-8?B?T0Q0b3lXRFlab2lHM3FSOVVYS0JMNU5XS0FMRzRFZWdoaytobFVsc3NhMUxS?=
 =?utf-8?B?Y3VlQkptSEtXNnhZajdZT2xKak5QYWVjTGtxUzNUTTZmRGdSSWQrMlk3Y0k2?=
 =?utf-8?B?aEJMYUE5Sk5iUWZGdklzeEFTUlpNQ0ZJdkU4Ym1jUi9lb1NFcDZTQ2k1a0hW?=
 =?utf-8?B?QnVUbkN6US9wOENJOFpSZVJBMDdNQmdSMWR3VXBLa1QzTnVZejJOUGl0MElC?=
 =?utf-8?B?Yy9NZ2VpT056b2ZLRFZFbnRETTNqWnY4ZFpLQTBpY1EzZ3FOd2NnU1Q0a3Ji?=
 =?utf-8?B?S1NyMmNHZG9SVmVkTis5SWpzdWdiTHl4RHJ0Wm1PbnZiNjNQdkk5cEY3b2xR?=
 =?utf-8?B?NDFSMnNNRm9lZXBiTm5hNmxVTWpYQ2tCeVQ0YmV3RHR4WURTTkdiS0J6NTg0?=
 =?utf-8?B?aFRKd295c2RYTUZmL3VsM016cE9LWlF4L1o1b3VsWFMvcjRCNW4xSkpGZTUv?=
 =?utf-8?B?czJxM0NQNFFxNzQ4US8wUFFsODkvb0lnSXc5dXJ5WWxJWFV2ZDBadWRvaE1S?=
 =?utf-8?B?RW50Vlp1Z2NhanRhK1JRVVN2Y2JrckZ4cUVvd2FvbENaa0NVQUEwMlJwQkRy?=
 =?utf-8?B?a01XM2hPakFBRUJaRzA2QitJejVZdlo4SmRKSk1mb0J0citFeHc0ODF4TFh6?=
 =?utf-8?B?SlpaM0pYSzhjQlptcFYvTStQK3docGIvRUsxbWJ5ZlhmczNHN3lxTkJ2NHVn?=
 =?utf-8?B?SFNmU1RySGczZC9sNnc1TUloRkduVnhORTVyOUE5TmNpRk9DSDRsYlpTZlNp?=
 =?utf-8?B?WjN5WTkwWWdWUG9Ec3VRSFhxU3BObWs0N1REZmRiKzR2MjlvVk5xMHFQRVlH?=
 =?utf-8?B?eE9KL3JtMzU5WWcxV3AwSUFIMG9taVhxNzgyS0dwUTE1emovMC8zdUhRUWNG?=
 =?utf-8?B?MzRTcm1oNjF0N2FaOUY5cFFVT3BDTnlaOVZsMjdBQzVsdmpZY3JaR2FySWZY?=
 =?utf-8?B?TXJXbkpCd1d6eFRhNVVKUFNwYzRzK2VJeUx6UVVRNTFPSVl2MWtDTzVEby9O?=
 =?utf-8?B?VENJckd2R2VMYzgxUDhHbHQ0ZTdIQStsMndMM2xobUcwNWNDdW5vUGNTejU3?=
 =?utf-8?B?SExkNDE4QTV0MDJyK2I4bzFMK1ArZTJqTU5LUktpODNuTU5sWkQyRGNRNkN1?=
 =?utf-8?B?NGFGUHp0YnpkcHJRQ1diaHRqWXkzVWRGTVljbGdYdCszdExPMWxMdXVsYy9T?=
 =?utf-8?B?aWtyMU1rdVBibGVBYzJYWHRQTGIyUmFBa2ZtNWNLb1Z0Sk4xaDRKMjBEQmUx?=
 =?utf-8?B?cDlRN29xV0J1bU51WE5qWGJMTy9rTzM3akxPeFdCdGlIRkpFQzhJOTk5Y0g1?=
 =?utf-8?B?bTczL0IyVXIvOWlFdisrUjJKUDMvdzhJTlF6K1h6Rk9rOGh4ci9iUSt5UVRj?=
 =?utf-8?Q?62iIX0ouZD7WQS3HkRo7t7mBz/4D267I12pf1a1kwIOx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59f40f44-3de3-4b9f-249c-08daf52864a3
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2023 05:38:26.4301
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5DwnbloZ7de+6o7WyqvkGf0ZB+wjhLycbdkFxm23g5hwZZtAcKQHLYW8pRlwKA6rcGtGv7mK71DGToY93E1+sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6146
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/12/23 23:21, Wyes Karny wrote:
> Move amd_pstate command line param description to correct alphabetical
> order.
> 
> Signed-off-by: Wyes Karny <wyes.karny@amd.com>

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

> ---
>   .../admin-guide/kernel-parameters.txt         | 46 +++++++++----------
>   1 file changed, 23 insertions(+), 23 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 0d8486325c9a..5f6a3a34251e 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -339,6 +339,29 @@
>   			             This mode requires kvm-amd.avic=1.
>   			             (Default when IOMMU HW support is present.)
>   
> +	amd_pstate=	[X86]
> +			disable
> +			  Do not enable amd_pstate as the default
> +			  scaling driver for the supported processors
> +			passive
> +			  Use amd_pstate with passive mode as a scaling driver.
> +			  In this mode autonomous selection is disabled.
> +			  Driver requests a desired performance level and platform
> +			  tires to match the same performance level (if it is
> +			  satisfied by guaranteed performance level).
> +			active
> +			  Use amd_pstate_epp driver instance as the scaling driver,
> +			  driver provides a hint to the hardware if software wants
> +			  to bias toward performance (0x0) or energy efficiency (0xff)
> +			  to the CPPC firmware. then CPPC power algorithm will
> +			  calculate the runtime workload and adjust the realtime cores
> +			  frequency.
> +			guided
> +			  Activate guided autonomous mode. Driver requests minimum and
> +			  maximum performance level and the platform autonomously
> +			  selects a performance level in this range and appropriate
> +			  to the current workload.
> +
>   	amijoy.map=	[HW,JOY] Amiga joystick support
>   			Map of devices attached to JOY0DAT and JOY1DAT
>   			Format: <a>,<b>
> @@ -7009,26 +7032,3 @@
>   				memory, and other data can't be written using
>   				xmon commands.
>   			off	xmon is disabled.
> -
> -	amd_pstate=	[X86]
> -			disable
> -			  Do not enable amd_pstate as the default
> -			  scaling driver for the supported processors
> -			passive
> -			  Use amd_pstate with passive mode as a scaling driver.
> -			  In this mode autonomous selection is disabled.
> -			  Driver requests a desired performance level and platform
> -			  tires to match the same performance level (if it is
> -			  satisfied by guaranteed performance level).
> -			active
> -			  Use amd_pstate_epp driver instance as the scaling driver,
> -			  driver provides a hint to the hardware if software wants
> -			  to bias toward performance (0x0) or energy efficiency (0xff)
> -			  to the CPPC firmware. then CPPC power algorithm will
> -			  calculate the runtime workload and adjust the realtime cores
> -			  frequency.
> -			guided
> -			  Activate guided autonomous mode. Driver requests minimum and
> -			  maximum performance level and the platform autonomously
> -			  selects a performance level in this range and appropriate
> -			  to the current workload.

