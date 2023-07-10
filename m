Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 534FE74D2F4
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 12:10:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232192AbjGJKKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 06:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233131AbjGJKJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 06:09:54 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2062e.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8c::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B03E3A8B;
        Mon, 10 Jul 2023 03:08:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YklfdJ3YkPKlCztAWbXZ299ziS/Ba8lAUhjQbS+2i5rRcfpZgKGxLYhYTrK/DsfqMLRvjf/uX+2PSVo88IHetTVKyC4R/H+hSbAsV4K6QiCJfNF9jF/srSs0SskirKPhvuZ/uS++nCHL2MAgFIkVU1TenfBEH/W3MH9qoOw/B27XvnqqbCglJ7u1nCDxIlpa3x2Z4zBkmjPa8oodJwzYEHrcSdmKfI0E7E7CNOnE/HhKpQBZeY0xpMuuLhbCr2yA9vtNvPCDf45sPnUBnO31xN2OX9EZeysC3aInVf3x1Pd7sH8WvFABAfYfS4/tHWenqZl2KWVP4zCQB7yHP1PJ+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PdnRDmPdDV5AQ9Ew7Jhzb3hL1n7tYDcVIE99T8afz2U=;
 b=VnC/hBd7iiVc8FsdUY0bvm+cZ5ubV9lhr2L/nVQTKGnW1HfCox1ECV7/PcyvQVhtL+kQZ8Zrcqb4wwriKrjwEJW0+2CXC3UcP0aD9OBkG7T10Z3jrKiAmzoP6lz4AoTTDSVwcstJOemOCTCzlElWS+uMhE9yu+/+OfRK4WvtI22SYdZM7eaQXcRebioWgYB0JFZMXQTT0cbCugEteQgWO9J9RSRMmQrll/pnJF8+MMaTTJG9BP81rsK/2+LvyPa1F9+GZ+nasyslSjr4umFlQImtdVGiWxvQkNtCeNs9gq/RU4mUYhzzakVX6r/wopEx1peGfg+dy1VzzTOvmxxigg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PdnRDmPdDV5AQ9Ew7Jhzb3hL1n7tYDcVIE99T8afz2U=;
 b=svwfbn4A8DiepLx71oamh6qda4Tl3HnfMIGqoAT//KYY2pjB93z08ikv+7OK6WYBEoKp3cDyQ7N2UyAxpeUbpbUc4axfUTWG3oaUcjgdZjYgBYI6D5EH6JHqYmwPvwDVD+DqDBomeuYtX+aeT3swkM65upflaLum/WJ3PF7ScBo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by CYXPR12MB9443.namprd12.prod.outlook.com (2603:10b6:930:db::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31; Mon, 10 Jul
 2023 10:06:18 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::bb94:8eb4:943:d955]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::bb94:8eb4:943:d955%7]) with mapi id 15.20.6565.028; Mon, 10 Jul 2023
 10:06:18 +0000
Message-ID: <bc160892-6b84-fe20-ec6a-a3f9f7faef11@amd.com>
Date:   Mon, 10 Jul 2023 12:06:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] arm64: zynqmp: Assign TSU clock frequency for GEMs
Content-Language: en-US
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Harini Katakam <harini.katakam@amd.com>, Andrew Davis <afd@ti.com>,
        Ashok Reddy Soma <ashok.reddy.soma@xilinx.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Manikanta Guntupalli <manikanta.guntupalli@amd.com>,
        Parth Gajjar <parth.gajjar@amd.com>,
        Rob Herring <robh+dt@kernel.org>,
        Robert Hancock <robert.hancock@calian.com>,
        Vishal Sagar <vishal.sagar@amd.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <3b9285b50a2a4abb136ecb0873343a4e84626581.1686228675.git.michal.simek@amd.com>
From:   Michal Simek <michal.simek@amd.com>
In-Reply-To: <3b9285b50a2a4abb136ecb0873343a4e84626581.1686228675.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0144.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::18) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|CYXPR12MB9443:EE_
X-MS-Office365-Filtering-Correlation-Id: b398f58b-1d49-42b4-ec37-08db812d4d67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B7l1c9qhh3Q1i/v5jFey5TzprX0EgMj/GJvvkplou6lxrZDzYNCohFwJfT61HQnO6fJaqW6KiA+qD/8904ar+q/AJZf7F5BhE90BNbO+jPceTTtxd9rMzatWyiGKvebXcjim0xTtgQaEK8N5ombEjaLjuVB3wNAfsiVc0KrrWC5IGDLdjDmMArExCW5rzohQR5qc54b3RgAWm5bQyqRQbV3Q6wwX37Yua1AV8B4+IrSZ4q9SQmdwIev0CQJxwiTsYfxnizgrf9qkfAZDOYmrr6/EsrMlW7PXj+sggSmRCRReFMo6wrteE9m4h0eqZayXyvM6FnLIXy0lfFaeeIpMOo+5r7XG1Zk2HGcJuqruc4rxm1shWNOSOhENVLRivelNBHt4660XckkDyzxy6MHBSMNuLnFDPo1cUv6ZDkwUvx6/fJ+UBqbljUmgZ5Ja/S8xkqt5hAyesD4gIZjzH+7GyE64FFkJq1mSWk94MIJy11kiWXPRIQn2EV1J9gMsxUF3G+OrJyYpFbHRI7O1GZhgAh+5dDyUDhRszbVtOShdrQIWOUNQ058qmDOJv0b92aR0DR3tcDgWDMRFu+pMn5l9AEDSFm9RM7bd71FFZIA1KC7lnrTvUOapS5LL3gnW9Hzk88xqQuaj5o7x35f+zJCfIg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4758.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(39860400002)(136003)(396003)(366004)(451199021)(44832011)(7416002)(5660300002)(8676002)(8936002)(316002)(66946007)(66556008)(66476007)(31686004)(41300700001)(2906002)(4326008)(54906003)(6666004)(6486002)(6512007)(6506007)(53546011)(26005)(186003)(83380400001)(2616005)(38100700002)(478600001)(36756003)(86362001)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SHAxWmlzQjZJbnFHTFZZMFRvbVl5R3lnZGVKd01LK2F3ZGM3Z0tlNHNUem51?=
 =?utf-8?B?YW9wUTd4SU1OUmsxYkh4VTlVeFNPOVNjck1JTFVISnpYdFg4blBrNmk3VlZj?=
 =?utf-8?B?N05XMEdQU09hMTQySlEvNkZlWlh6VVRFTlBUbEtwZzBWbjZ1QlA2VS9rZnRx?=
 =?utf-8?B?d1pvMVBWM0YyRU5KS0FSOXRHQURlUWhhemdaN2VXelhjQlJvaTFWZXUrcGNv?=
 =?utf-8?B?dks5VFRYV2s0YStNaXNKQkR0RzNINUVXY1lqMDVtdUtVTzViWW1NbXIxU0Vo?=
 =?utf-8?B?YmRKaHEvcEV2VTZSQmJQR0JKdUtTYXFpRURXVnlyK3hSdDdBVGxZT1J0eW5k?=
 =?utf-8?B?UkVQdFY3ZnlzUXJ6MHRDM0lZUEg3WDBiSUg3S2I3VjNJaUExcmU2SkVEdmxu?=
 =?utf-8?B?ZllkME9LZHllR0RnSDdxQUVsZkFoNWkyWjJKanluYXlmQStwc2UzVDliNHJv?=
 =?utf-8?B?S1lYME80d29wREFXUXF3SGdQbG5ObFFaaFo4RnNKKzk0NmhCVkY0TmtneG5Q?=
 =?utf-8?B?UXlKcEV6d3crTGxMdkwvbVh6SEJ5b0lzemd2VS9vZ3FmODlZMjZqcFcrbElY?=
 =?utf-8?B?RFlvS2Nrd1pyZU1jWCtRT0hNOS9TWXZ3cU9wQUQzRit4cmlkbmxoNnhWTDVi?=
 =?utf-8?B?MHpidm5sSU5Ja2UyWi9DY2R0aUJzTE9EYWphUWVrTDgyRTI4ZUxjc2ZNbnpp?=
 =?utf-8?B?Y3VEcjNkYXBMdU5xSmpBRjdLL2YrVUk0UVpla0NlQ2w1Z0JrbWRORGxMam8x?=
 =?utf-8?B?anl2bldQQlFFTWVSbVI4RHBieEphOEUrbk9QSnhUaXVXQjhFOXR0VUNZZE8r?=
 =?utf-8?B?SjIrZ0RRcGduQ09tT1I4NUM3SHVjaDdNQk8vZldaYmlJUzRWK1UydVRTa2xD?=
 =?utf-8?B?OGE2SUY4Mlg3SXdNbjJkUFRsdUlqeXNTWWFuR0pmdk1IWlBqaXFFM1pwL3dm?=
 =?utf-8?B?NmJhZUE0ek5mUFoxUWZ1eUJLSHRNa1BHamY4eHBaMmNyenFhNzNLd2FMK2Z5?=
 =?utf-8?B?bWR0ajV1TVZhcmo4cnRCK3g5RXFRUjlCTzE0dzhCQjMzSmV4eE0zd2VQM2Yr?=
 =?utf-8?B?Ylh5dlJacFpzd0xZL09uaWZsTUpBbFRhTENqOW0ySWx6TlBrQ2Z4NTNoTGE4?=
 =?utf-8?B?MVhycmxxTmdnQ2g3NDZaQW5rR0N1WXR6dWhWQ0hLQWV1TTVwMEdaWWdsZ3Vl?=
 =?utf-8?B?aVJ2NzBmTTh1YUY1ZmxtR0RnZWh2UFNjak93Ykg4c3pjTVhIVFhTTzVsZFli?=
 =?utf-8?B?UEdyUDVkQTJIMXIxSHpMYnpmcWMwL0RPR00zbFpYQU0zbFFpeFowM2tRamZU?=
 =?utf-8?B?dy8xOXBKck9IcHFHdkJhbTd3K05icmtVOS8zSnYrcUt1SVQwRnpPakt6cVRB?=
 =?utf-8?B?bEZGY0JUNWs0cHY2eTlvUU1pMHZ3SDlSRXo0cEh5MnhOMFA0bkpUSEg4RzFy?=
 =?utf-8?B?Z01iTERxblVQOXh2ZHlTYUllRVBvYTNIT2NSRWRBN2htQWppUnBXZDNMK2JW?=
 =?utf-8?B?T0cyS1daRlpXdDNsL3JCRVFkbnZXNEVOUVVwRDRJTVVNU0I3eENkUi9id0NB?=
 =?utf-8?B?OVRtNWgzNjYxMWVuamZwVDNPWW1taXhOci9BWk41dGVhODEwQ3VseDV3Q1Ew?=
 =?utf-8?B?ZVlvMEZqeWc0ZlBKVjlzWjRiNjZpc00vSCtBU2NSdUVMb0V4dStaWU1BRVNY?=
 =?utf-8?B?YXZhbDVaRWtHMUpDckxQdHZrU1M0a3lzenpaM1M3UkpCUnJPdUN5TjF2U2hG?=
 =?utf-8?B?N3RGWldOeHdOVFVaS3Y2Z0RMOWE0K0lMeUcwMGJiUVU2cVBBMWZRV2IxTUxi?=
 =?utf-8?B?V0grQUUwVnJJQWxZaTRtWi9sSXdpMG91NmdFWE96WlRjY3lsSk9XRlZoNWll?=
 =?utf-8?B?SmVjWmNhalh0SUNtc1JicXlNS0w3ak5CVlFQZEorTGg1SE9rdDA1OHIrdlIz?=
 =?utf-8?B?OGdSUU1IaGltNW1ZZEp3V1BCa2lUbElubHV1aGF2QkpEQ1MzbDR3TkVZc3c4?=
 =?utf-8?B?ZGN3bU92dHJLa3Q4V0d3MnBBU0RtOXdqZnFXN25rZk52TFE4ZVo4NElJYnVW?=
 =?utf-8?B?UkNCb015OUJqNVoreFdvSklyRnpESlNrRDVGdndmeThuYXBMQjJXUHJ1b2dI?=
 =?utf-8?Q?090vUebhTxSByzcdyHN1poCN+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b398f58b-1d49-42b4-ec37-08db812d4d67
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 10:06:18.1289
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uActWmkNXp9iUb0mwLtMX4mr+mSk/qclbhQ8cCQd7dZYZo5gnNJxpYt8lAsLKb37
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



On 6/8/23 14:51, Michal Simek wrote:
> From: Harini Katakam <harini.katakam@amd.com>
> 
> Allow changing TSU clock for all GEMs. Kria SOM is using this
> functionality that's why set TSU clock frequency as 250MHz (minimum when
> running at 1G) to allow PTP functionality.
> 
> Signed-off-by: Harini Katakam <harini.katakam@amd.com>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi       | 4 ++++
>   arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso | 1 +
>   arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso | 1 +
>   3 files changed, 6 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi
> index f04716841a0c..ccaca29200bb 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi
> @@ -146,24 +146,28 @@ &gem0 {
>   	clocks = <&zynqmp_clk LPD_LSBUS>, <&zynqmp_clk GEM0_REF>,
>   		 <&zynqmp_clk GEM0_TX>, <&zynqmp_clk GEM0_RX>,
>   		 <&zynqmp_clk GEM_TSU>;
> +	assigned-clocks = <&zynqmp_clk GEM_TSU>;
>   };
>   
>   &gem1 {
>   	clocks = <&zynqmp_clk LPD_LSBUS>, <&zynqmp_clk GEM1_REF>,
>   		 <&zynqmp_clk GEM1_TX>, <&zynqmp_clk GEM1_RX>,
>   		 <&zynqmp_clk GEM_TSU>;
> +	assigned-clocks = <&zynqmp_clk GEM_TSU>;
>   };
>   
>   &gem2 {
>   	clocks = <&zynqmp_clk LPD_LSBUS>, <&zynqmp_clk GEM2_REF>,
>   		 <&zynqmp_clk GEM2_TX>, <&zynqmp_clk GEM2_RX>,
>   		 <&zynqmp_clk GEM_TSU>;
> +	assigned-clocks = <&zynqmp_clk GEM_TSU>;
>   };
>   
>   &gem3 {
>   	clocks = <&zynqmp_clk LPD_LSBUS>, <&zynqmp_clk GEM3_REF>,
>   		 <&zynqmp_clk GEM3_TX>, <&zynqmp_clk GEM3_RX>,
>   		 <&zynqmp_clk GEM_TSU>;
> +	assigned-clocks = <&zynqmp_clk GEM_TSU>;
>   };
>   
>   &gpio {
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso b/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso
> index e06c6824dea4..ae1b9b2bdbee 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso
> @@ -145,6 +145,7 @@ &gem3 { /* required by spec */
>   	pinctrl-0 = <&pinctrl_gem3_default>;
>   	phy-handle = <&phy0>;
>   	phy-mode = "rgmii-id";
> +	assigned-clock-rates = <250000000>;
>   
>   	mdio: mdio {
>   		#address-cells = <1>;
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso b/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso
> index 030e2c93f0e6..b59e48be6465 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso
> @@ -128,6 +128,7 @@ &gem3 { /* required by spec */
>   	pinctrl-0 = <&pinctrl_gem3_default>;
>   	phy-handle = <&phy0>;
>   	phy-mode = "rgmii-id";
> +	assigned-clock-rates = <250000000>;
>   
>   	mdio: mdio {
>   		#address-cells = <1>;

Applied.
M
