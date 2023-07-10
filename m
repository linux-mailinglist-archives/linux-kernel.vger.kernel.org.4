Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF3674D307
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 12:11:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233238AbjGJKK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 06:10:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233230AbjGJKKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 06:10:21 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2062e.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8c::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E46C8135;
        Mon, 10 Jul 2023 03:08:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ejcNlRbkeJ/fx2a2uLFiGqYhNYZ5DZiMr9UP+bu1HxAO/JYD5hMKUTXTptXNw1jZL1ikc8+LTq/L27n/XjSn+6p9dBbI6HJlIJ0CejLZaXMO/5S+sRNb55y3ySLty2tCG8bTquD4z50sdckpgh68TMN0Ia10GQVQdShWf7Po0zu244FousZ2ruidCfpDvOjKJs7xq5SQZ+B/A7J3iIu0UK7tMMzkH8Z2z403pqX0x7GjZ2Debi6LtBTHQzdCwF2SY1iOeglvWhdf0oHOMFXuHjfIeWzYBi4LCl1goxajmp21WJ3ux7J8OqblKSHfQ/Xy0TQcR1hYRl/nQp3BhNcatA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OP0ItXI5QmRDCcZA+mMQRud7EtVk48ZKYjNd1r0EBug=;
 b=E7L1SA9b1ZfED01pgD+SOu9sBZqipwWkvQyh8k0dBNbeqkek5/3m+RlFv6wPsrDJaDicFvpZgLefk3DwJKRRMM2Ze/J5wRrVwCqnVgiAe3o7pskcPKFtKRutJbT9wr1DFWjXpco9jMAlAa3Ya1+p472Ro7psMzxr6oPfkTM+gG/uBtLDFoykiwEyk6aIRHKNIBdwb0FC1m/6NURKsEvK7FC0l3GoYuuHyMNQMMqFyk745mxlMVCX4kxLjutXDT+WWsF8LR30j5nJvT8Dhg080D62NiYRuaQVR8d5TOXfleD3GLo1uxJR8x4SawFZZSw1zwkToLpmHCu1HfVz8XhGqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OP0ItXI5QmRDCcZA+mMQRud7EtVk48ZKYjNd1r0EBug=;
 b=dDnAMOj8UkplMUZRbGohyaP26IeoqTsqvWOIHpy+LB0EBKy+iYTuT/gpSI2yc/25NXfKrg2sc6uy5DuiBKauWT5udPyHmhsPv+9GW4QygmYCx6tfpQqgJYPl1UHbJd7+BM9FCm5AYOJb+3QxyXP8lFS+vO7QRMI5/GFGX+XZBvw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by CYXPR12MB9443.namprd12.prod.outlook.com (2603:10b6:930:db::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31; Mon, 10 Jul
 2023 10:06:40 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::bb94:8eb4:943:d955]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::bb94:8eb4:943:d955%7]) with mapi id 15.20.6565.028; Mon, 10 Jul 2023
 10:06:40 +0000
Message-ID: <cdd0ba45-d3b0-3de9-0f84-486df799c6a5@amd.com>
Date:   Mon, 10 Jul 2023 12:06:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] arm64: zynqmp: Add memory reserved node for k26 Kria SOM
 board
Content-Language: en-US
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Sharath Kumar Dasari <sharath.kumar.dasari@xilinx.com>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manikanta Guntupalli <manikanta.guntupalli@amd.com>,
        Parth Gajjar <parth.gajjar@amd.com>,
        Rob Herring <robh+dt@kernel.org>,
        Srinivas Neeli <srinivas.neeli@xilinx.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <8ddc7fb4bf40faead7a015ad7e095f3f7d2ec191.1686555698.git.michal.simek@amd.com>
From:   Michal Simek <michal.simek@amd.com>
In-Reply-To: <8ddc7fb4bf40faead7a015ad7e095f3f7d2ec191.1686555698.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0148.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::6) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|CYXPR12MB9443:EE_
X-MS-Office365-Filtering-Correlation-Id: bfcae84d-b5c9-4c3b-4903-08db812d5a95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RqDkSnfZ5NhN/DT5TNAc432zZVNt5HzOkXsjwCYktqM3lS142jS6x/Rvx9Oy0Nf0mhj7bwzlmd41o2s0EJ8x4BhIsE26vio5v9YYYbZ9t4C8NpN0wLzKbp0S90iB/XT0q31HX1HjpZbiAVHroP3o3UitMeOVlB5fGwEU9IKMOdBdTFoo/Jyp/V6iuWFrroIoWd5lYD1uhd+BNpod8IOrjRDJC+kJK/pXr1TYu3KGhc+TA91u4YD0BinQ8XiYp8y6+QamwZsWr1qtWI6pDmzQhlni6OioRLMdKKlgzcm+H/DrcVmTdUeSB+asAZqMaDzy2x+GwidDPsfHY5T2nzL3xneFN5FqA2PyS3wwhEWlQC3IL999aeylKgP/Ta4giV+806GmeQSusk8B1j2HeLhnZTxWw3fsfg+L34uvemQPQox6VzFl5M+LkK/4xmFYpT1N2DvDZ2fYF+/kh6fyrIbpdtZQHlPeLW5ZKvsOSlfFldvg4w2LDHDPBpxKnlvfptvwarfCUEfEInHq5Vq9AM16hIJJGnQ/zBtfYl5o9LldfMPivywsz0I0hkmj6BcgQ4cY8jFRUQugyzayCv1tYlfx3lFQ0xj2rKEFGZJV7UUw1kUDHj/h7/Hr0BooMhXHS2uqxdK7XMvHq66s69OpBCWQIQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4758.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(39860400002)(136003)(396003)(366004)(451199021)(44832011)(7416002)(5660300002)(8676002)(8936002)(316002)(66946007)(66556008)(66476007)(31686004)(41300700001)(2906002)(4326008)(54906003)(6666004)(6486002)(6512007)(6506007)(53546011)(26005)(186003)(83380400001)(2616005)(38100700002)(478600001)(36756003)(86362001)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TldGV2wxTHBoYVdvdjFJc0RwTzNneUxCa0pzcFh4dTlHNGRXM1QrSURydFQr?=
 =?utf-8?B?cVoxVWZ1UmtmR2JKVS9IaUJTUm13MDlrcHVTY2xHSXlEalE1T1FvVm9jQXJj?=
 =?utf-8?B?OFhPcUs2a0U5OTlIMStEZmtpTkppT1RMK0cydlFwd2dwR202SWpSL1haMmx2?=
 =?utf-8?B?N0Y3SG1ZaXFxZmRERzEzcTZqeFVyMkcyVkl5QlZISDFaaWlJaUgydmQxZlJx?=
 =?utf-8?B?Z2NKU3oxeVlienFTK0pBczdVTzRsSkRyMXFpZXFTZlB0aG1QZ2lSQWRaM3J4?=
 =?utf-8?B?bkk2eWpPUHJ3azRQSlUxOVNiK3dXRmVGTCtGODV5U3E3SDV4VTBXbU04OUVB?=
 =?utf-8?B?aVVMYXVRalpDMWIrdGhSTk91N1dJRGZlcDFnSE54R2NGb0JXZUQrYjhWK1Iz?=
 =?utf-8?B?NndCYWJYelF6eGFZOVZVbDJSN0hKZ2I0K0dReVBCa0ZVWWhhMnNNRjBWSEhB?=
 =?utf-8?B?aWo3dlVnSjNlRElwK1c5WDdLZHRremtRRUY3cDc4U0hlOGVpZUFnNVM3SGEx?=
 =?utf-8?B?akdMQUtWalpUQWYrblR3NXFMaHBvcE93SVNucXJNdzFaQjAxK2F1OUd3UzNa?=
 =?utf-8?B?ZEU3YjQ3WXNOcWhLMDVaQzVkUjZYSkZTL3lKQnFaZE0zYjc5QzZRMExxcnA3?=
 =?utf-8?B?dU83NzVqanlQSnJmWjFBeU45N3NOT01sTjU3WDk2R0hkUXdzY2pEVXRNOHJL?=
 =?utf-8?B?SWlMUDI2dWpkQ1p4Zk90ODI4bXFuVno4M3IrWGJyZWROUFVmS0ZERWw4Qlly?=
 =?utf-8?B?TWJ4MUdITTFVQVg0bjJqcTI4eXdiZk0zSzJrMUJEMURJR1lBMFMwSk5CMlBj?=
 =?utf-8?B?VUh3eE5XUGNEQzNRZ1c4SGh1Q0hLcVdhR3hwcFdJRk1yV0FyUUpXYWJZazdZ?=
 =?utf-8?B?Ymp5ckRacUs3ZTJlWEtaN3I5ZG51ckZRdnBkbENnK2Y1NGNCTjBkeVhMbEI4?=
 =?utf-8?B?aE1Vbmw4TWVLRWE1Si9mUWIzdVZ6a3dsR1ZQS3Zua0s0MERCTGVLTWgzajUv?=
 =?utf-8?B?RU5qNkxZTWFoU2ErTEt0TG53ZnBjeEgrN3lENGxGYmZ6SWRpSVlobGdacGE3?=
 =?utf-8?B?TVkvbkprckk4K1A1TlBvMWJYQ0tzNi8vSm5DdHI5NWRsUE5XNVNpTVM5UVhJ?=
 =?utf-8?B?anE5L0xQbzBFMlVzZTR6RFFCbitlQTFZckpaQjZ2R3N3L3YrQS8vVVpUV0Jm?=
 =?utf-8?B?VTN5R213L3ZidS9OZ205RlNQb2oxQnZKdEJGakJvbUpuRUdybHM5OFQ0TmF2?=
 =?utf-8?B?WWNYZll1LzNuSWZOblZqTmhvU1FldWh4cnlpbTMweTVYMDdYdlllejM0QzM5?=
 =?utf-8?B?bWNKTGNKN0lXVStnQ2F0bGNEWlRKa3M1REZnTWZ3NHAraTMxRkFSbklBWXlK?=
 =?utf-8?B?TlU0aHM1NkdBZENuRi9MT1RIUjd6K3labFlpQ2tZbkFBQklPTkRiaCsvWUJu?=
 =?utf-8?B?K21ZZFVQMTJRVldCYnNqRjcrM3I3WU1yaXZ3RHdNckpmU3BYMUFoSmdhV2JF?=
 =?utf-8?B?R3UvRExZL1VQZy9uTThXeCtUUEJXLy9raHRDYzFkQVh5MXEya1NlcmIxYmpB?=
 =?utf-8?B?SWZRNW9mTzRtM2Rxd0t0SndzYXpqRENnM2Rld2xpUWwrZ2g4eGFVa1JQdHJU?=
 =?utf-8?B?OVM3Q1lkODFwUW0wcHBnUTl0bk1UMUN3bUQrVVZmZFBEUkxJRC9URkhuTnBB?=
 =?utf-8?B?dDRLcjhaQ04wb3pUcitVMGZ2UU11dER6SzU3czc2czdmZGUrendFZ2VUZWZE?=
 =?utf-8?B?d21YeUhEQms1N2o2YWF5MWExVDNod2EycDBtSE5DOEw3Uk4zQW5MSloxSU9p?=
 =?utf-8?B?YWVNczh3akVpRUw2bk8rcUQyaTJZa2kwRnRSM0h6aWY3R0cvek5KODYvanVt?=
 =?utf-8?B?TlYxNXplWW5hVTBFMDVwRjhhT0VXWTd4YkIvTzBBL21ZMTRRbVdkYk02Z2t0?=
 =?utf-8?B?b0FibndiL0pIK1Ureml5c0FFWUZMRmozT1FwV0VmcnVjZXE4OEV1YzVtT1lY?=
 =?utf-8?B?NE5IUnZYdllBMWZKSGp4Qm45VDJUSnFIRmpBbFdIUjdEQkQwbUZ5WXJ5djlW?=
 =?utf-8?B?TUhRQmtSSll2TTVoK1hLT0xQY21ZRmVLRlBzWVNzZitaVGMxL2YvQjNrbzkv?=
 =?utf-8?Q?wgHHIhLyNFYj8ilwFG32ifmfY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfcae84d-b5c9-4c3b-4903-08db812d5a95
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 10:06:39.9218
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /Kx0UwIWXqfHa924QbNer6aJNcsK82Uqu/8lEvgWDCB+Vl5Ay6JuLnLtCjcuiTQN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9443
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/12/23 09:41, Michal Simek wrote:
> From: Sharath Kumar Dasari <sharath.kumar.dasari@xilinx.com>
> 
> PMUFW (Power Management Unit firmware) requires top 1MB of the lower DDR
> memory reserved for its operation, this is missing in k26 SM static dts
> file. Bootloader or kernel shouldn't access this location.
> 
> Signed-off-by: Sharath Kumar Dasari <sharath.kumar.dasari@xilinx.com>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts
> index c1f21b0e1760..c4774a42d5fc 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts
> @@ -50,6 +50,17 @@ memory@0 {
>   		reg = <0x0 0x0 0x0 0x80000000>, <0x8 0x00000000 0x0 0x80000000>;
>   	};
>   
> +	reserved-memory {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		pmu_region: pmu@7ff00000 {
> +			reg = <0x0 0x7ff00000 0x0 0x100000>;
> +			no-map;
> +		};
> +	};
> +
>   	gpio-keys {
>   		compatible = "gpio-keys";
>   		autorepeat;

Applied.
M
