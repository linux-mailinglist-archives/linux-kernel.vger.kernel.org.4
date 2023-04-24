Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FBDE6ECA77
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 12:38:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231522AbjDXKh7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 06:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231600AbjDXKhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 06:37:46 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2056.outbound.protection.outlook.com [40.107.21.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFF673AAF;
        Mon, 24 Apr 2023 03:37:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SpdrpMjLKNXjAfy05jvbMmrSuk3Y7GdDzQslNEO/JKdQEa1HnUXH/s0hNPVGVLnIAk0vKzw8XCwFs0P3J3qRGbDWzR4WxnTL87DasbbqQ0aTxwBJ86NnbmEZUxPIgTfm5jRCOIdomkWDWB5lv70HCbCyby0Jg5e5WpHM4eaZk2iZOcOUjByPHL+cuchJHFL1nwBw48k4qex7dtLNSldBJXBNs/j2NHnnjTu3JedfU/mB3J7Hs3HAsvKEBByRHrBoS7Na+AoIRjquuKuZ+NGYkoF3ck9NZe01AqPJUqrCvKrRlpDctNVfqYRKMCzN3q1UGrh+Kc0VAOCLPpb87AVNkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ftobvent/qpbHbT6V3nGwPp/7qepc+NL7D8Vy9njuhc=;
 b=jnbmhIrynLKukW+T6rwn6YgKQM2DXicL58Z7XbtgD3vrT0B5GzDO/+ufOt0J1b+xY+QNT7V60AKi6i1chT8NC64aEHY4jOUqyrSE/zUSLRak1uOQzuMgARfP6Q5lc9MRCikbWpHojBoo6QWEx4uOyvGtxwowDdJr+8K4L3GmIA/2b73TSOIBn2c0JSHRtq+/c3fUE1Za8XzE+WYtLXdWQUh1Xz+XypqFuqRIUF3x9YId0TXmRsmrbyFmEN6MgomhetGloygJJmF1OIyGV+Ldz+Bp3RAOcQ3O28hq4UPxDGM+K+5WdMHCZhxxi6AmclOANSMXrpaeLhkrOvW1y23VSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ftobvent/qpbHbT6V3nGwPp/7qepc+NL7D8Vy9njuhc=;
 b=H7cpaYwuyjlvnqABcwX1AVqdJpKv+CY7CZ6uaCV5zsUDQ9SHCb/SJ70zdEwdG/8uXXRjG8uRZU4zaCEItHY0ZiYHAhg+Z8eFf1e4wljbN9ouqb5+wds92/fU579Fhj3sOyavgKGIHauO2cO/ioNEsdLEvUPe7ZTumEpXSxmcfg0YyRbJL/0LLdz8Mt7ZhpGgu5FHoNlNbwncaDq0goIh4mbJXQmy7w7XQsStV3qjuVnEokfaYLeFYs72NLsk7hfM/x3LzzCj6jZGicI9JrpwYz5PF04nufEL0NR+lZ7jHY8eIDcFyu4jyHUhDNfyM8m3+kYYpgSBO6n3CkbwZxgB7A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB5070.eurprd04.prod.outlook.com (2603:10a6:803:57::16)
 by PAXPR04MB8078.eurprd04.prod.outlook.com (2603:10a6:102:1c1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Mon, 24 Apr
 2023 10:37:37 +0000
Received: from VI1PR04MB5070.eurprd04.prod.outlook.com
 ([fe80::4fcd:4d1d:14ec:1ea0]) by VI1PR04MB5070.eurprd04.prod.outlook.com
 ([fe80::4fcd:4d1d:14ec:1ea0%7]) with mapi id 15.20.6319.032; Mon, 24 Apr 2023
 10:37:37 +0000
Message-ID: <aa3c1fda-553b-fa71-21dc-41d1244007a4@suse.com>
Date:   Mon, 24 Apr 2023 12:37:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] arm64: dts: s32: add missing cache properties
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Chester Lin <clin@suse.com>,
        =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>,
        NXP S32 Linux Team <s32@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230421223202.115472-1-krzysztof.kozlowski@linaro.org>
From:   Matthias Brugger <mbrugger@suse.com>
In-Reply-To: <20230421223202.115472-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0141.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::12) To VI1PR04MB5070.eurprd04.prod.outlook.com
 (2603:10a6:803:57::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5070:EE_|PAXPR04MB8078:EE_
X-MS-Office365-Filtering-Correlation-Id: 0978464b-11a2-437a-f7a8-08db44afeb9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WmDl32ljZF/PfO/iEVmwmazelvH1yakOtNo+fCZHgoVFNrW0Rfo3/k/NijLVGx0z/DKPwWB6QC5beb1g3KjQ9H0aoe2dhsYlQxawhk6SS5na+iMe1WUGWRLqBKT/0MtPG5Own5d5i00fBgv+0JpABu9kBUKqxaF1/i6nNzmx3BUJ7n4VR11NQsK2SQ8RNrjrRIMoI4VqU3Pqy6tmROkS37cj0Hp4DQUIl1SVPDklg3mCaM9WIAZPFeqNn0USrXGTGAJ27KQ9xQ2DjqgDuutiaXnPcEqIN+7FoHc9SRp4oiWBkm50CtNJthcOUpeoO0YJg6TEt6506IJTFr0xuZp7CQW2+X40tOShnOSLTxSsPKwkYxaRhs5/deUYPWhOE/WDk36cqpsO4grJ3FL1XJDXCcBs9Kae3piY3xCNe0YIca8x/Zfqypmkf7QNXZ/Fx+D8J7Le0gwe1MynnavahJmzuAKPpm8ZPt37Bk5VPRplZyZeSuRkvFm9iVqpIcE9n4tc1ig4Z8lRJb/kVv0C3hk6NVINTBsLQ7JWx0eb1RQE8v3rZvMWAedIBgh7StMEU/+X0N9MyXBCqGYX+exG23qynyFIA3uT3tYv7dfZpsexcIfXDl9cGsAiRmLpjx+lkIvGEyL5vXAhe1vTEbhfu9cnOnkmwLM6VAga0wqZZOWBPcs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5070.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(39860400002)(376002)(366004)(346002)(451199021)(53546011)(6506007)(26005)(6512007)(2616005)(36756003)(83380400001)(186003)(921005)(38100700002)(66946007)(31696002)(478600001)(86362001)(66556008)(66476007)(31686004)(8936002)(8676002)(7416002)(110136005)(5660300002)(6486002)(41300700001)(2906002)(6666004)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R1d0eGtQRnFpUUNLd2dlU3FFcVBKUzlkQzNCWkd2UzFFMVdHMFFnL2EvKys1?=
 =?utf-8?B?NG1BR0FPdmJZNHV3cDB0c3dia3VYQkZWMUVxWGRlZkppRHl2RzZ5czVaOEZx?=
 =?utf-8?B?SnUvQnJPc3NmNVI2Vm5zYStaVTdVMXFZTzBhVmtacWJTL1g0ZzdUV0VuZlh3?=
 =?utf-8?B?L29DU2FyelppMWF5d043RmtlTU1TQ0NscTJwKzBXQnlkY1M2NkZ3djlkRTMr?=
 =?utf-8?B?R0VqUzdPb0FYcHFCL3JGZ0lER0JOVFQzenQzaG5oTUxBQnliRkRMY1pwY2lP?=
 =?utf-8?B?VU9oU3lzR2hXOFFsUWpLelYwRDFDL0krMk50bzVIcnZmWThlT0lUNGhrQWZB?=
 =?utf-8?B?dFlWclNvaVNnL1d4REN6a2hqM3dRL2pKNmtYV2tYQUJodDR1U0ZrMEhtRnhO?=
 =?utf-8?B?WnZhakh2WG01TmRUdDRNR2NDdlNSV1E1Z2JrYjB4UmNDNUhDQzkvcUx5VGpx?=
 =?utf-8?B?TW5hb2U3dDVPQnVBVlc3czV1SjIzcHpmM2JQREVRUmdPVk1xSlkrL0NmNzFj?=
 =?utf-8?B?M0ZnNzBmRmlZc0FjQmVCdXdITEZUalJzajBkTXBNRURtSytzUlBuOGI4dzNj?=
 =?utf-8?B?enM0WEVEdnhoclcrVzQ0bVlUSkNIWEgycFRhczgxQUk4ZTFlZ2lSWjFHbVhI?=
 =?utf-8?B?aTJFOExDT2hxSHdINDFZNFdOdWkyUEdaZzdqN3pnZTIrdndJbGJreG5sK2JJ?=
 =?utf-8?B?TjNmS2FWeFlPMWtsZUdNYzVhS05ITWtqekJzM1J6VWdPc1l3d05SUE8zR1NP?=
 =?utf-8?B?bXF6cDZWd04ra1IzR1BYRk05WFdiM2tKbFVEWndRcHI3WFF5YnNBelJpVEpN?=
 =?utf-8?B?L29QY1VVVElzWDNjQ05YZStDV0VzQmtZRGMxTUlQM0tDSFNITmFFZ21EN280?=
 =?utf-8?B?RHJnVVArbVdtMW5wT2NUU1B2YWtuQzFkUDlCemVNdUg2bEFkWSt1NzY1c0E2?=
 =?utf-8?B?K3FBWXBPT3VMbzVsVW42U2E3NlBhcmUxekhvUld1c2RpY1BEUHo0dEZEazFn?=
 =?utf-8?B?aU5PMVRHalVrSVpLanBRNTVCZE9LVUVxZDRoMnJNTElCRjkvU2YrSnJxMUtV?=
 =?utf-8?B?anBDalFqVGhTMjltc3NWTGVmMjhFYWM4Y2tjcmdNNWViN1NMMUZOSmkySG96?=
 =?utf-8?B?NDkwZHppSFlkczBoZVdLQUYrSkl0SGtIT2UvWEhoS1Bib0ptZlFFaFcveXMw?=
 =?utf-8?B?NTFsOWNGVVl1SXJkV2pQbDQvOEF4VTd2M2s1NEkvd08yR2l1ZVBDRTlzbnJk?=
 =?utf-8?B?WnYwTC96VmROSHdxOGpBbS8wYitBeFhuWWlDQ3Frck81dGkwZ1F3VVdjN0wr?=
 =?utf-8?B?UGNVZG82QkF1M0VLdUpaakRYWGwwT3I2aXd3c2NWdUUrZVJ3RnJFQ3dLekti?=
 =?utf-8?B?bkZIQndkTllqZkU0QTVzUWVNNVk2OTdwWjZDMlVUZlQ4a0tZOXFYZmJEMTRX?=
 =?utf-8?B?MUc1OVZoWDM1NHJYZ29pTHZsQjBGQXZlNXY0UXEwZnBRRVovam9Bd2JGQ3Vk?=
 =?utf-8?B?U2lpRGhsekplYTF5YjR1MVBPNUR6SWlJOG1mRkRVbzVoS2traTI5MHpaeStO?=
 =?utf-8?B?ZkI4V0JxTnpUbmc3Ni9iVzlKUDBsc0xLbkhHNk9JQXZoV0trSUpVQ1pnVW5h?=
 =?utf-8?B?Y2M0MHdTMmpkcUlXaXhKWEhpNjRVVll6aTVWVHZBS1pIQ0dSU0loNnJmUGhF?=
 =?utf-8?B?b21CRWxxVkNaQUFtanpXNFQrM3hEY0h0eFJXR2ROcnRkbjUrNmRUM2NQTnMr?=
 =?utf-8?B?ZXZUeENnVkxxb0d2emYzMGYyQVJ2UDhTdzExdE0rbUpMNnZ4UE1IV09iU09S?=
 =?utf-8?B?Rnk5ZDJ2anhLcHk2QlJRZ2ZSeVNQVDIweHNtbXhFZTBEb2t0aWpHVFpUZSt2?=
 =?utf-8?B?RTVxRHBVWkdJS1BtYkZ3QWRYc1p4L2ZkaWhxSXNzNFVKd0ZEcUF2UGliUEND?=
 =?utf-8?B?VlRnNWlBTXlDdllDWlhUaVRGbGtwWWhNRXdzUTh3N3pOSCtEdDZpV2YxWXha?=
 =?utf-8?B?WkFybXBNaUJIb1FENzBUeEwxbmdHNXBLQitvUDJyM01XNW5jdnRhbEtXamo3?=
 =?utf-8?B?Uk5EMTlOdCtveXB5c3luS2laY1NyL2pNbHNRaDh4Qlo5WjRUQU9PQUs3UThP?=
 =?utf-8?Q?zfC6yC5+SRdOyk19CyeRZzMqy?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0978464b-11a2-437a-f7a8-08db44afeb9d
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5070.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2023 10:37:37.0074
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mFMdRD/lZ4TCKR+2I+9/sc0LN++oWVS7NeG+ktOQ6eYJHsHXyKhp1c0IGKvFvslajQyBNA+43W/sNqHfH1p2iA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8078
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22/04/2023 00:32, Krzysztof Kozlowski wrote:
> As all level 2 and level 3 caches are unified, add required
> cache-unified properties to fix warnings like:
> 
>    s32g274a-evb.dtb: l2-cache1: 'cache-unified' is a required property
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Matthias Brugger <mbrugger@suse.com>

> 
> ---
> 
> Please take the patch via sub-arch SoC tree.
> ---
>   arch/arm64/boot/dts/freescale/s32g2.dtsi   | 2 ++
>   arch/arm64/boot/dts/freescale/s32v234.dtsi | 2 ++
>   2 files changed, 4 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/s32g2.dtsi b/arch/arm64/boot/dts/freescale/s32g2.dtsi
> index d8c82da88ca0..5ac1cc9ff50e 100644
> --- a/arch/arm64/boot/dts/freescale/s32g2.dtsi
> +++ b/arch/arm64/boot/dts/freescale/s32g2.dtsi
> @@ -53,11 +53,13 @@ cpu3: cpu@101 {
>   		cluster0_l2: l2-cache0 {
>   			compatible = "cache";
>   			cache-level = <2>;
> +			cache-unified;
>   		};
>   
>   		cluster1_l2: l2-cache1 {
>   			compatible = "cache";
>   			cache-level = <2>;
> +			cache-unified;
>   		};
>   	};
>   
> diff --git a/arch/arm64/boot/dts/freescale/s32v234.dtsi b/arch/arm64/boot/dts/freescale/s32v234.dtsi
> index 3e306218d533..42409ec56792 100644
> --- a/arch/arm64/boot/dts/freescale/s32v234.dtsi
> +++ b/arch/arm64/boot/dts/freescale/s32v234.dtsi
> @@ -62,11 +62,13 @@ cpu3: cpu@101 {
>   		cluster0_l2_cache: l2-cache0 {
>   			compatible = "cache";
>   			cache-level = <2>;
> +			cache-unified;
>   		};
>   
>   		cluster1_l2_cache: l2-cache1 {
>   			compatible = "cache";
>   			cache-level = <2>;
> +			cache-unified;
>   		};
>   	};
>   
