Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6A0470D612
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 09:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235877AbjEWHyU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 03:54:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232925AbjEWHyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 03:54:10 -0400
Received: from outbound.mail.protection.outlook.com (mail-dm6nam10on2067.outbound.protection.outlook.com [40.107.93.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DD77E52;
        Tue, 23 May 2023 00:53:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oKvyAC5/fw3AQhRu+q/z4QUO6B88ysbnLlMIIWP+S3xjPSkR3yAHpXxz1A2x1yskhOKpff59WKKXn5uMwno0K7SXEnoatTvzTQW6wfywrpsRnbzXYmKtSt5Yq28HpSvkxb+09mkBx0uow6DfHgRCRjs0YkalwWqulHLJUIhc5X0OW3j3ASZKcPcE3JJ6OILNUukbKhANOS3tNU5KMHG3gs3r1O3ZNSqFWYaYYisOJbpnTfQ0xBP4pAjd/hYEV0nQRWZIJvIah/kdHqhHBCtUH+UAiLXMm2T/r05OwOf3ViG9F8R1+X8eJdNGcXOu+tXXtxsqZyBaHZpHl+Mcf3V1kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WmXiPM65kN0mePAa5xphMwCBHTgA03OWFUC2BvrF67A=;
 b=JprFIdQZ+OmwUXemiLXQd1UK2ZydwzBDBKkj35W0EXiwEJaev4rhiogYcYsbCHzA8lWCFgscVfhNyxgE3sSh1EytYWW3uk3TNe+JkpRIOSgYIctNWtBPnaCruzhaB3FCBvlphOLqdinlu3abVg2AmkBg61UGcPEJ9t5gneatk4yo3kHydTOUuAxG6LqRFr3nVnmWlYNfX/LBp71sZ2sXs5SLYun2XDUMrEAC1QJBIbZLw7hQ9GgdPV2s7vCdjkEER0JGhbSQ91pEfF0Fy90Y/Fyd88JAkTDS+hswMUfaCbh91uJ2nHlER0eNXjVdyOpUKF5dTxPVxibU4AjMQuB5HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WmXiPM65kN0mePAa5xphMwCBHTgA03OWFUC2BvrF67A=;
 b=4TAbENFoh7GRL3W0Hosit1LoSTN5kGwpi4TW9TeY6kAlUTVfXZfb4vlXEHX/ATbaM3KBGQEpkxZ5+RJ5dMIXiyXVxNw0wNBZmGGh6PhFPj+1ZJo0eCeODRWj+KME5IYQjnDOL9PffBVk0SJLKjTE8kLsqWsYQMdoahw/OXxGpZI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4765.namprd12.prod.outlook.com (2603:10b6:805:e4::24)
 by PH0PR12MB5607.namprd12.prod.outlook.com (2603:10b6:510:142::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Tue, 23 May
 2023 07:49:06 +0000
Received: from SN6PR12MB4765.namprd12.prod.outlook.com
 ([fe80::6588:a783:89c2:1d8b]) by SN6PR12MB4765.namprd12.prod.outlook.com
 ([fe80::6588:a783:89c2:1d8b%6]) with mapi id 15.20.6411.027; Tue, 23 May 2023
 07:49:06 +0000
Message-ID: <20816baf-cc07-d2b2-d665-3d6b73dd4cdf@amd.com>
Date:   Tue, 23 May 2023 09:48:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 4/6] arm64: zynqmp: Add L2 cache nodes
Content-Language: en-US
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Harini Katakam <harini.katakam@amd.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Piyush Mehta <piyush.mehta@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>,
        Robert Hancock <robert.hancock@calian.com>,
        Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>,
        Tanmay Shah <tanmay.shah@amd.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <cover.1684767562.git.michal.simek@amd.com>
 <d962547cd72286821714b45f52b0126f9c438919.1684767562.git.michal.simek@amd.com>
From:   Michal Simek <michal.simek@amd.com>
In-Reply-To: <d962547cd72286821714b45f52b0126f9c438919.1684767562.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0502CA0012.eurprd05.prod.outlook.com
 (2603:10a6:803:1::25) To SN6PR12MB4765.namprd12.prod.outlook.com
 (2603:10b6:805:e4::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR12MB4765:EE_|PH0PR12MB5607:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e200ab8-3d76-42d8-3f9d-08db5b622f6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Xk6MSdvSweAaiKXjPMM2PaMzeCkEpJhFeHWZKozUAy0CsbafTBh6IcBhW0NcpA6sc0h5WX/jw7iW1NBKme9A4Wm0O2ldAtIe4gcHKafTPAgy59uah98U/WZU4MvvoOxap9WoqttHygyz54yjvTWeL4JhDX03ozLDpDs7SaQQ306X4m/lcARlqCyOm117fvwSCBSQoo5L8Su+HQJsNhV6Ctrv6w2GJa3Dgt3dXlylOWYtDZB4wfxDzAEOH+Ck7wydOBxF6W+E3O5w1svV3pYOLjs2nexw312SoqYac10bliaO0BR3LnaVj42ze3FYtGBbo5YyAFhxiGfjcmCJDPFGGO5p3L+3NK0uSEiTWndQu36oGpkTsKMGuaEEzTZfLc4Saed0aIKUn8h2aX0CIA/yzwC0W4gf+XMydEiTE9hzEoxi5apWq96RG0cEgwycSr6pAbTPK7hKPxVsergg8wdGjz8EGyMuot39aZZ2yyBFxK235Pzyhk0+gGVUtGUN+gvqRIupVLETciSLPMMbMyOfoVXQMWaMJ4d4p7CZZ80d3LYmXpx2+3lhGUV8NDtXSfpUr/+u5VUmmXOSG9rnW7eYE7EI95g3iSAhyTSl0nERcLIgA5x40tnRDYEh0/W9Vswp6FWZtFEbUVbkqX1c9ubrrw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB4765.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(346002)(136003)(366004)(39860400002)(451199021)(478600001)(66946007)(66556008)(66476007)(4326008)(31696002)(31686004)(6486002)(41300700001)(6666004)(316002)(54906003)(5660300002)(8936002)(8676002)(86362001)(38100700002)(44832011)(6506007)(6512007)(7416002)(26005)(186003)(53546011)(83380400001)(2906002)(2616005)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b1dvbW5uYnlManJidFRHbTgwQUo0S1hiTklLQTRqeEk1bHJqUjJXdTNoYURO?=
 =?utf-8?B?bjEwbnViaHk1RE9YdFMvemUwdGdjeVIrUW1GVUt3VENTVFRIdGFiV24zUnJU?=
 =?utf-8?B?dTUwOGtPU1l2Uk5uVXM3ZXpMdy9leHh4UXN6NU92ck9BS1k5bWowRVBnVXhx?=
 =?utf-8?B?cS84cGxhc3MrTXlVYjJhUm16ZHNjaGNZMmZoTFM4S1p2U2t3UG5oRnB2d2dl?=
 =?utf-8?B?N0ZON1QwbFYzcXZYbHpKeEVJN2RBNXhYVTZXalJsR2xRSWRHcWpCcjJGZ1Ba?=
 =?utf-8?B?akhWNmFHZjRxSmVPVExGNCtrWDI3cmxJanJONTE1Ny9mRUhaejNvekdmRzcw?=
 =?utf-8?B?TGVsUklVVm1IZzQrVUtXcFhpV0dSZmptUGl0MG5XbTJKTmZiTWkrR1ZrUFVx?=
 =?utf-8?B?R2NGR1hDMkpDcUFCaTFOMTF0bkovNUl0RDRwNjRPTHI2UHNFTDhTL3orK3Ur?=
 =?utf-8?B?bXA1MDI0dUw5Z2E1b044a3hveDRjZXh1a1ZlVkxqOWNndVJyVTMvbFJMdnNK?=
 =?utf-8?B?bm9EMjVoaGc5YzNkUWdkeDZ3eEdkbUFERmFBRG5rNG9xOTRialY3NGdORkhw?=
 =?utf-8?B?TWhPbytpZXo1QjgveUkvemNMc09CNE9wSWZwSUVzVGxCM2haTVE5anloc3hk?=
 =?utf-8?B?Y3d6MXVpMWlsMGtPUVZLUzFWdjNPTHVQdkRPZG9ocUZBdVdDMEZuRERXVUFY?=
 =?utf-8?B?RlZQT01keWp2RUFmemhPZXRFa0xlYnBCbFpnYnc0Qzc0QllHNVBkYm02N3h5?=
 =?utf-8?B?NmhsT3E4U2loQ0VGN3V2cXNMUjd0MXh4QkZTTGc2R0FCcWpwVWNHbnBrTFBr?=
 =?utf-8?B?KzFyNU50UG9OYXhJcU1hN09JTmIwMEZEQjl1MHRqcGxkZzNTOSsrVmZxWkFU?=
 =?utf-8?B?MlNlNm42WmdmcjZqeHpwTGMxV05mU25XNm03anN6UStSOUluMU1kT2Z3Uy9Z?=
 =?utf-8?B?Rld2dG9xNXpXMXJkTk53M0JRTHdGbHRpWXBGaGVoU0tvd0NENWt5Q21UcFB4?=
 =?utf-8?B?ZnltSDQxaEZERmwrbW1NdVJGUTZ4em9tQ29DbXpMNFlOUlZkL0lET3k0TmZJ?=
 =?utf-8?B?UTNrbitqQXpYQ0wyaGdVL3ZjSUJTWWVFK085VmMyZE1lUTJyNU14TEFqdi9M?=
 =?utf-8?B?blRsVHVEK3VWYU4zM3FlMHJEalRwMVQ1emZHUUJWMlJtTEFUSGR0WFhQUFFm?=
 =?utf-8?B?Q0ZGK3FTRStBc0xzank5ZGVpaEVvT2JVNU9LMUxObWJlNk16QzhWakpsVkdV?=
 =?utf-8?B?NFBxcXhFbGRrTko5YTJOM2MzVlUvMWg4K0RZV0YvOUtzWjJhOTl6Nm1zQm92?=
 =?utf-8?B?ZUNTSzlud01EaVhBYkNWSlJZVmtkTlpKc085Z1ZPOEw0M004STRXQUdnbmhZ?=
 =?utf-8?B?bEVLdjFQYnNyTkg5Q1pOR1BkMVpkRGtoMzM1WE9JVWVWM3U2UElTeGs1MEtT?=
 =?utf-8?B?d1U3cERxa3UxRytFMDFldGM3Y2U2OW5INU1xWWowM05pak42ODNQY2dnT3ha?=
 =?utf-8?B?OWhtUCtoazJKRXJBVHBJWGRyTVl1QXJvSGxrU3duWExvcG9mcC91NHZ0V3Fk?=
 =?utf-8?B?WWEyMGduNGQ5S2ZDQS8vRCtBSklaakhRK0JEdzVkeWFvWVg5MWVLT2x6Nlkx?=
 =?utf-8?B?ZTRSY1RtVWZhdUFCVS9ZaVFoNGx6NnpVZmtnaTkwa09HOEpCbEdpUkV0akxY?=
 =?utf-8?B?L1RjcGpwbWJxNU0wN2Zxak5Zd2djNzE4YzF3bDNsWk9KSERHdGtnMFprUS9i?=
 =?utf-8?B?b2tBK1pScjlWK2hWd09SdW0vUGY4VVVNOGlJekxOMnBEdTRaUjFqRXgySkJp?=
 =?utf-8?B?S1lSUFAwdlJxQ0NONlVxNXM0MnUzcERPeVpZTkdhMEM3NnJ6ZnAzQXJqQzhD?=
 =?utf-8?B?djhqUTc4NENoUUVWT1Jwb2xlWjhGcUQ5V0VlSXg3ZTlpdXVyTlBHcURqenRU?=
 =?utf-8?B?VnBmc2ZjaFJHM2ZXcWR3ZlVQejIzejNldXZlcEM3cEpPblloYjJaQkxBZW1N?=
 =?utf-8?B?SXd0emxXWnB0OEFaMGZ4UjJBM2QwZjNUL1owbWxPdVl2TUJ5MFVqdXVXTVh0?=
 =?utf-8?B?aTkxanhPYVBFUjR1d2FkcEFBWHB5WHZ6NzlaTDVjQnkvMFhMbUxLUW1lWFhj?=
 =?utf-8?Q?CTQ3XdI3Lto4v9oDmVcisUaFC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e200ab8-3d76-42d8-3f9d-08db5b622f6d
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4765.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 07:49:06.5316
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ju7f92NvqWVytRL3WisgaTV3Pn1ryAD7VU493nXFygP+o5GI32vEn0mG9Ekmms1F
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5607
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/22/23 16:59, Michal Simek wrote:
> From: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
> 
> Describe SoC L2 cache hierarchy.
> 
> Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
> Changes in v2:
> - Update commit message to remove Linux part - reported by Laurent
> 
> Linux kernel throws "cacheinfo: Unable to detect cache hierarchy for
> CPU 0" warning when booting on zu+ Soc. To fix it add the L2 cache
> node and let each CPU point to it.
> 
> ---
>   arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> index a961bb6f31ff..02bd75900238 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> @@ -33,6 +33,7 @@ cpu0: cpu@0 {
>   			operating-points-v2 = <&cpu_opp_table>;
>   			reg = <0x0>;
>   			cpu-idle-states = <&CPU_SLEEP_0>;
> +			next-level-cache = <&L2>;
>   		};
>   
>   		cpu1: cpu@1 {
> @@ -42,6 +43,7 @@ cpu1: cpu@1 {
>   			reg = <0x1>;
>   			operating-points-v2 = <&cpu_opp_table>;
>   			cpu-idle-states = <&CPU_SLEEP_0>;
> +			next-level-cache = <&L2>;
>   		};
>   
>   		cpu2: cpu@2 {
> @@ -51,6 +53,7 @@ cpu2: cpu@2 {
>   			reg = <0x2>;
>   			operating-points-v2 = <&cpu_opp_table>;
>   			cpu-idle-states = <&CPU_SLEEP_0>;
> +			next-level-cache = <&L2>;
>   		};
>   
>   		cpu3: cpu@3 {
> @@ -60,6 +63,12 @@ cpu3: cpu@3 {
>   			reg = <0x3>;
>   			operating-points-v2 = <&cpu_opp_table>;
>   			cpu-idle-states = <&CPU_SLEEP_0>;
> +			next-level-cache = <&L2>;
> +		};
> +
> +		L2: l2-cache {
> +			compatible = "cache";
> +			cache-level = <2>;

Here should be also cache-unified;

Thanks,
Michal
