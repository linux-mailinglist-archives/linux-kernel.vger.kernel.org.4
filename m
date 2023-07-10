Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00A9E74D2F6
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 12:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231209AbjGJKK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 06:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbjGJKKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 06:10:06 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on20602.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8c::602])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59AA63C2A;
        Mon, 10 Jul 2023 03:08:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OoJipLELfOPwDR964tVGhwRPek1beym1B06dc2JDGaWCm3a8xVfacxAD6CyPt9qGNnowgzs6f9C9xUnQHoRgZx2C4ymxnTdiYDQ1+lDueFWVUex0uWAjiESiftOMS76zB/gEoDrTNYKBd9Jg2/teqQ8lI8FjNLUmxu7844d2rH/4tF1RSNzXuW18QBlgnQrOUNSH8B3eCqNx3ycSAWaPfGUcAhG6wEBjw7CwlVnPVMrrert86djvrUjQA044dlRoPDxF2p1UH9kGNNGL55yQyz0cJ8YhSckrP4k7uXdXBw7ExQyDncFGstRtTE2JqSgLn78D2RR0Jc0oQVHXJtkatw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q0vJD8WFWCftl0MLkMZsG8T96rvjOGtEBOYxdwCb6fg=;
 b=Ek1WJgSgzw7Wu0vj7ZnrqMuPWb09QaynqZMwIhr8KVI4Z0Onp/VAZzSbgz4U6wQoLYPSdG12iB/KfduySEiU8LQ+xnwL1QIOLoRcK/MKb250e9I/Wv5VYUQgN+DRjoSc1tlIPkHlQkSesYOuo/GElAy36xj92JqNre01GqyWD9+KyLTlJkeBsmovW/ZWdOAf/sLtgsItWsvH6Ze3HjS8e03HZ1fHxNGUGS6kpZyD2cKhvhJpn7o391YG5GfYsxAfL69ZYlKWKvRF1UEQ73iyybx1vVY6xm2+I1gvLKOcUJdNZNohil5YhMfhoHil28cjfR7XMlQva+10WUfy6q92FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q0vJD8WFWCftl0MLkMZsG8T96rvjOGtEBOYxdwCb6fg=;
 b=eGHflBAGN9D3pr2Izhfwop78tTgaoT2VdnlREloRxWFCjJxAyMXSVmVJBMI+M87rhGZTFYz4WmbYbTq6oe7WxBLO87RQk3EMeXoJ4HwlEW04JwU+4GPQ8Pb5TEifXStrtWZsdhIwRaqs1o3lapCp495jD25Q8p6htLHJTqQ1Bh4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by CYXPR12MB9443.namprd12.prod.outlook.com (2603:10b6:930:db::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31; Mon, 10 Jul
 2023 10:05:32 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::bb94:8eb4:943:d955]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::bb94:8eb4:943:d955%7]) with mapi id 15.20.6565.028; Mon, 10 Jul 2023
 10:05:31 +0000
Message-ID: <940c6040-4c71-a1b6-b568-3d93096411aa@amd.com>
Date:   Mon, 10 Jul 2023 12:05:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] arm64: zynqmp: Fix open drain warning on ZynqMP
Content-Language: en-US
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Manikanta Guntupalli <manikanta.guntupalli@amd.com>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>,
        Andrew Davis <afd@ti.com>,
        Ashok Reddy Soma <ashok.reddy.soma@xilinx.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Parth Gajjar <parth.gajjar@amd.com>,
        Piyush Mehta <piyush.mehta@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>,
        Srinivas Neeli <srinivas.neeli@xilinx.com>,
        Vishal Sagar <vishal.sagar@amd.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <a0faf488dde310e1c1c1a676c371e223db6bdca6.1686227712.git.michal.simek@amd.com>
From:   Michal Simek <michal.simek@amd.com>
In-Reply-To: <a0faf488dde310e1c1c1a676c371e223db6bdca6.1686227712.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0155.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::15) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|CYXPR12MB9443:EE_
X-MS-Office365-Filtering-Correlation-Id: d47b59b4-0688-465b-0d49-08db812d31dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Jo5+jWZv8did0SgNzpjZxWrcEBuNA9uWCImpLzsIwIAbazPfc8jqTYt6rBph1HLm2xXcynh+Pp4ORXofGb7iwyBl1Sbssvyvhxnn2cMq8XxcuEfZsCh8HdeHyBi+3R8QwKgvZr+yyBgBsXLmEZ4l1Mb4emN6T293makrHK+x+2+XEH3hp0nNWogktELbxnnYBS2dazVSwY07i5/ouj3uvllKuHXEe29Mii0NxPzDDxoY+zTPP2Iyms7VU9N1d3n5lOk0iMYEq6Pd8Wcha72dPYPIgLlcRtkzTSeJbpAU+Md/xC+Nbjj86fuHTtwou0XDdVXMUm7IX/ypLhHvmu2bdm1cYBm55PpnvPTVgNjVZGAwl3UyFjfWL3YxhKawcPtbHgfnos+OZ8ARBDlsDuFabDa4Wi7f0HOTv5sNm1/GV3zix4Z5csqTi7O/xLyw2TKNU6GIINXV1+3/hFRbh2iTCfXc6DUQS9vu2VLzPwpn2LJsQ+2Q5VT8lWih8ur8dGmOAk6tqOdcL2JeVAxuPlKxdbJaednEAlJcOMFW/60bOp+lKXXOu2f4R09l8C9Nb3NfEFdr1kmbhXeeubpfyKo2BWxTP9cvhuLmDe1DfkaqwllzGdLn2pE4XyzTqcgbMRyiEmtHTNv7io5v0IrzEHpmCw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4758.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(39860400002)(136003)(396003)(366004)(451199021)(44832011)(7416002)(5660300002)(8676002)(8936002)(316002)(66946007)(66556008)(66476007)(31686004)(41300700001)(2906002)(4326008)(54906003)(6666004)(6486002)(6512007)(6506007)(53546011)(26005)(186003)(83380400001)(30864003)(2616005)(38100700002)(478600001)(36756003)(86362001)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OC9lMGFNKzRpMzZiSm9admZUTzNxYUN3SWQrdU43dWI3a1Rpa1lqdkR0VDUx?=
 =?utf-8?B?YUJxOUo1UUpXLzhHYUZTNmNiOWZwT0VRS1RjeUFCZm9TbUN5UVJMSHVQRVdt?=
 =?utf-8?B?YkovTWlVVWJaUnlMNkgvSkNqS0tYS1RnZEE5RER0OFhTRENkeEtTN0RLamNF?=
 =?utf-8?B?SUR2MWhBOEt0bG9FRFljVE9lclI0ZTVFK3JrdDJ5SFpZRTYzY1ZuMXVZZTAr?=
 =?utf-8?B?RjJXbUJNdFpZMHREN3d1T0dLaDFETXlGOW1BaEVDVnozK3gzZ2lXZk4zeVlV?=
 =?utf-8?B?T2xYV2YzdWdBVlBaSWp4M2N1SjdHZjlOVmVnMi8zZmVReGRpS2VpMDBqczlM?=
 =?utf-8?B?WmZwMCsxV0w5RzdPeHRXS2NMakFYOEJMcGhUN1ZFVzFzY2FsOXM2Q1E2VGMy?=
 =?utf-8?B?TnBoMFpvTjM5Q25mZER3aXVXOHdYcExNdmdHcHlKdjRXQTAvQXhKMUJVd0Vm?=
 =?utf-8?B?clhQcTVNNmpPN1hpbUlDdkJDY3JGMFJVZGRpVk0rSFdGL1IzTDhzOXB5b2U4?=
 =?utf-8?B?cUd5bmcwUFVsamxpT0crcVpZc3BKU3FuYmpZNWl2VUJRQlcrYXRJMXFhbXdr?=
 =?utf-8?B?Qkd0N0RMeUZkVjkyQkNQT2tjaVE4QlQzY3NTaE93WEk4R1lGOUxDRWJRL1ps?=
 =?utf-8?B?aWxpYjlYNmhPRUpTVlBBK3pudjIrbzU3ZmtLMlQ1SDcwUHBXcW9JYTl1R094?=
 =?utf-8?B?Nmt5Rkw4Z3o3VklTK2tMT1Nlc3M4Y2ZCN0h1ZEhBbTBSaitHR014bUlzUUpt?=
 =?utf-8?B?OU5oTkNwVFpBb2hGMk1KbWVoMGdkN2RtQWxUN1c1aTJTM1psbHVDRHIzajFN?=
 =?utf-8?B?d0FTQ2JkSEt0cVl3c1A3REczV2VVMVNMZVk1MWYrQUd0QnBURGxzazZXbHV5?=
 =?utf-8?B?ZVBzWi9FUW5ObnBDbmx5V2o5LzB2Z0Vhem93SnBPc3l1MThLencwdTViMmI5?=
 =?utf-8?B?d2YxOWNVNGtxL2loSVhTQ3RZVHVJdUxqc0gyL1hnV2FEUk90c1Ntam1wcTFH?=
 =?utf-8?B?MFljS0dKZW5Dd0c5V1cvdGJSbEtGNU9jcWhzWVdvVHl5YXVkWGxPVGE5QnFr?=
 =?utf-8?B?SFJMWWt2MDhETVVSeW1wZmg5OVVFM0pJQVprSGRwUGEyRTJXR0l2VGNvNmkw?=
 =?utf-8?B?aTRBbmtrM25MWG1iY05Pd3ZLQ0tJQWpXQVZPV3YwMnVzemtMVWZ5MTZSNmpF?=
 =?utf-8?B?cGE5cExZR0MyN214WDRpTjZkQXJ2SzZiMlFKSzdLS0JQWnlDWUw2TWFwZzVK?=
 =?utf-8?B?WUlLOXBlbWZEU090U2czRGxhS1R6UkN3eGNQZEkzMHJQMWNGN0IxOTVEK3po?=
 =?utf-8?B?WndyM0t4Q0FhY0JDdlgrVEhMbytYVlI3WTBHdzgrV2t2WlFBd0UrWUMwdk41?=
 =?utf-8?B?WWtpRjlRSXhvUkdxMU1OVitPeUF0ODJmM1lQYzlsdy8wcWVJNzFTNXVYL1hJ?=
 =?utf-8?B?d252VENHSHJKWFVuUzhpTXNyOXJHUDg3eFp0Mllac3RFWlYrTTFWRk5VL3g1?=
 =?utf-8?B?ZVJNbUlXYVZSdU0xWHMzMnYzR1ZpejNZVUdXdmtTVDZjTTROT1ZmOERkeExj?=
 =?utf-8?B?QndGUCtsVnRIZlg3Qi9FYUU5MjdQSldHaWhTYXJmcHcwbEU2T0ErcFpIM1NG?=
 =?utf-8?B?NHRhRXdYL2pwV2x2cmx2K3VnNUZvbEV4bUlnQXRyVHVCRjRVVXp4UHhoYWZ5?=
 =?utf-8?B?YkV4Ung4TDRKanFpbHl5TDNGWlllY1BJU2xrRE9rTzFoaHpZRmNFbmlIdWtL?=
 =?utf-8?B?K05hcGd2RU5CaGxFZkV3VXgxV0ZNdUFjRkJCL0dMa29VVEtacDU4RUszcUVC?=
 =?utf-8?B?YnJzaDZrdU1FaC9aSHBSc3Z0NS9MQmFKYWd2Q00wcWxiYiszL0pJMXdDS1BF?=
 =?utf-8?B?eFZTRXBwRlc2eWtXUUdHWVlFMG1pbFRucHRLTnZtQTBaRnFjc04vSU9qVHN2?=
 =?utf-8?B?blBHWXFQcVplUmFsRTV2bXhkaDJsOFNLdkZtUHQ2RkR2cWpNWGgraUVKUXR2?=
 =?utf-8?B?TS80RDRlWS9RaU9SWXZCLzJJRG9nYUc2bGtQQUs5QnhzUE5NZzhKQWE1VWlp?=
 =?utf-8?B?M0xzWGRFWjAxaU12eHErdWxaR1BKOEl0SjY4cDh0R1RwTkdYZ000ai92ODFL?=
 =?utf-8?Q?pfuKOUsaqtg111qQ8rBdUNo9O?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d47b59b4-0688-465b-0d49-08db812d31dc
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 10:05:31.6174
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Z0lL2r0AZWgLwOv2J7uae6vOTOp6BTURFqpARKShaiTjUXCYG810gb33R9YEByp
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



On 6/8/23 14:35, Michal Simek wrote:
> From: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
> 
> Mark both GPIO lines as GPIO_OPEN_DRAIN which is required by i2c-gpio DT
> binding. Similar change was done by commit 8df80c1801c9 ("ARM: dts: exynos:
> Convert to new i2c-gpio bindings").
> 
> Signed-off-by: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso   | 4 ++--
>   arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso   | 4 ++--
>   arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts      | 4 ++--
>   arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts | 4 ++--
>   arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts | 4 ++--
>   arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm019-dc5.dts | 8 ++++----
>   arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts      | 4 ++--
>   arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts      | 8 ++++----
>   arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts      | 4 ++--
>   arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts      | 4 ++--
>   arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts      | 8 ++++----
>   arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts      | 8 ++++----
>   12 files changed, 32 insertions(+), 32 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso b/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso
> index 603839c82599..e06c6824dea4 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso
> @@ -27,8 +27,8 @@ &i2c1 { /* I2C_SCK C23/C24 - MIO from SOM */
>   	pinctrl-names = "default", "gpio";
>   	pinctrl-0 = <&pinctrl_i2c1_default>;
>   	pinctrl-1 = <&pinctrl_i2c1_gpio>;
> -	scl-gpios = <&gpio 24 GPIO_ACTIVE_HIGH>;
> -	sda-gpios = <&gpio 25 GPIO_ACTIVE_HIGH>;
> +	scl-gpios = <&gpio 24 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
> +	sda-gpios = <&gpio 25 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
>   
>   	/* u14 - 0x40 - ina260 */
>   	/* u27 - 0xe0 - STDP4320 DP/HDMI splitter */
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso b/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso
> index a91d09e7da4b..030e2c93f0e6 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso
> @@ -22,8 +22,8 @@ &i2c1 { /* I2C_SCK C23/C24 - MIO from SOM */
>   	pinctrl-names = "default", "gpio";
>   	pinctrl-0 = <&pinctrl_i2c1_default>;
>   	pinctrl-1 = <&pinctrl_i2c1_gpio>;
> -	scl-gpios = <&gpio 24 GPIO_ACTIVE_HIGH>;
> -	sda-gpios = <&gpio 25 GPIO_ACTIVE_HIGH>;
> +	scl-gpios = <&gpio 24 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
> +	sda-gpios = <&gpio 25 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
>   
>   	/* u14 - 0x40 - ina260 */
>   	/* u43 - 0x2d - usb5744 */
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts
> index dfd1a18f5a10..c1f21b0e1760 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts
> @@ -245,8 +245,8 @@ &i2c1 {
>   	status = "okay";
>   	bootph-all;
>   	clock-frequency = <400000>;
> -	scl-gpios = <&gpio 24 GPIO_ACTIVE_HIGH>;
> -	sda-gpios = <&gpio 25 GPIO_ACTIVE_HIGH>;
> +	scl-gpios = <&gpio 24 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
> +	sda-gpios = <&gpio 25 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
>   
>   	eeprom: eeprom@50 { /* u46 - also at address 0x58 */
>   		bootph-all;
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts
> index d9d1de5f313c..e821d55d8d5a 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts
> @@ -119,8 +119,8 @@ &i2c1 {
>   	pinctrl-names = "default", "gpio";
>   	pinctrl-0 = <&pinctrl_i2c1_default>;
>   	pinctrl-1 = <&pinctrl_i2c1_gpio>;
> -	scl-gpios = <&gpio 36 GPIO_ACTIVE_HIGH>;
> -	sda-gpios = <&gpio 37 GPIO_ACTIVE_HIGH>;
> +	scl-gpios = <&gpio 36 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
> +	sda-gpios = <&gpio 37 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
>   
>   	eeprom: eeprom@55 {
>   		compatible = "atmel,24c64"; /* 24AA64 */
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts
> index 6503f4985f8d..b59e11316b4b 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts
> @@ -110,8 +110,8 @@ &i2c0 {
>   	pinctrl-names = "default", "gpio";
>   	pinctrl-0 = <&pinctrl_i2c0_default>;
>   	pinctrl-1 = <&pinctrl_i2c0_gpio>;
> -	scl-gpios = <&gpio 6 GPIO_ACTIVE_HIGH>;
> -	sda-gpios = <&gpio 7 GPIO_ACTIVE_HIGH>;
> +	scl-gpios = <&gpio 6 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
> +	sda-gpios = <&gpio 7 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
>   
>   	tca6416_u26: gpio@20 {
>   		compatible = "ti,tca6416";
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm019-dc5.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm019-dc5.dts
> index b1e933b8a2cd..0d2ea9c09a0a 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm019-dc5.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm019-dc5.dts
> @@ -91,8 +91,8 @@ &i2c0 {
>   	pinctrl-names = "default", "gpio";
>   	pinctrl-0 = <&pinctrl_i2c0_default>;
>   	pinctrl-1 = <&pinctrl_i2c0_gpio>;
> -	scl-gpios = <&gpio 74 GPIO_ACTIVE_HIGH>;
> -	sda-gpios = <&gpio 75 GPIO_ACTIVE_HIGH>;
> +	scl-gpios = <&gpio 74 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
> +	sda-gpios = <&gpio 75 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
>   };
>   
>   &i2c1 {
> @@ -100,8 +100,8 @@ &i2c1 {
>   	pinctrl-names = "default", "gpio";
>   	pinctrl-0 = <&pinctrl_i2c1_default>;
>   	pinctrl-1 = <&pinctrl_i2c1_gpio>;
> -	scl-gpios = <&gpio 76 GPIO_ACTIVE_HIGH>;
> -	sda-gpios = <&gpio 77 GPIO_ACTIVE_HIGH>;
> +	scl-gpios = <&gpio 76 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
> +	sda-gpios = <&gpio 77 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
>   
>   };
>   
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
> index 44d1f351bb75..d0091d3cb764 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
> @@ -180,8 +180,8 @@ &i2c1 {
>   	pinctrl-names = "default", "gpio";
>   	pinctrl-0 = <&pinctrl_i2c1_default>;
>   	pinctrl-1 = <&pinctrl_i2c1_gpio>;
> -	scl-gpios = <&gpio 4 GPIO_ACTIVE_HIGH>;
> -	sda-gpios = <&gpio 5 GPIO_ACTIVE_HIGH>;
> +	scl-gpios = <&gpio 4 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
> +	sda-gpios = <&gpio 5 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
>   	clock-frequency = <100000>;
>   	i2c-mux@75 { /* u11 */
>   		compatible = "nxp,pca9548";
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
> index 8767f147cbe3..84952c14f021 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
> @@ -233,8 +233,8 @@ &i2c0 {
>   	pinctrl-names = "default", "gpio";
>   	pinctrl-0 = <&pinctrl_i2c0_default>;
>   	pinctrl-1 = <&pinctrl_i2c0_gpio>;
> -	scl-gpios = <&gpio 14 GPIO_ACTIVE_HIGH>;
> -	sda-gpios = <&gpio 15 GPIO_ACTIVE_HIGH>;
> +	scl-gpios = <&gpio 14 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
> +	sda-gpios = <&gpio 15 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
>   
>   	tca6416_u97: gpio@20 {
>   		compatible = "ti,tca6416";
> @@ -497,8 +497,8 @@ &i2c1 {
>   	pinctrl-names = "default", "gpio";
>   	pinctrl-0 = <&pinctrl_i2c1_default>;
>   	pinctrl-1 = <&pinctrl_i2c1_gpio>;
> -	scl-gpios = <&gpio 16 GPIO_ACTIVE_HIGH>;
> -	sda-gpios = <&gpio 17 GPIO_ACTIVE_HIGH>;
> +	scl-gpios = <&gpio 16 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
> +	sda-gpios = <&gpio 17 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
>   
>   	/* PL i2c via PCA9306 - u45 */
>   	i2c-mux@74 { /* u34 */
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
> index e185709c0d84..5084ddcee00f 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
> @@ -140,8 +140,8 @@ &i2c1 {
>   	pinctrl-names = "default", "gpio";
>   	pinctrl-0 = <&pinctrl_i2c1_default>;
>   	pinctrl-1 = <&pinctrl_i2c1_gpio>;
> -	scl-gpios = <&gpio 16 GPIO_ACTIVE_HIGH>;
> -	sda-gpios = <&gpio 17 GPIO_ACTIVE_HIGH>;
> +	scl-gpios = <&gpio 16 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
> +	sda-gpios = <&gpio 17 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
>   
>   	/* Another connection to this bus via PL i2c via PCA9306 - u45 */
>   	i2c-mux@74 { /* u34 */
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts
> index 7fceebd1815c..b273bd1d920a 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts
> @@ -145,8 +145,8 @@ &i2c1 {
>   	pinctrl-names = "default", "gpio";
>   	pinctrl-0 = <&pinctrl_i2c1_default>;
>   	pinctrl-1 = <&pinctrl_i2c1_gpio>;
> -	scl-gpios = <&gpio 16 GPIO_ACTIVE_HIGH>;
> -	sda-gpios = <&gpio 17 GPIO_ACTIVE_HIGH>;
> +	scl-gpios = <&gpio 16 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
> +	sda-gpios = <&gpio 17 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
>   
>   	tca6416_u97: gpio@20 {
>   		compatible = "ti,tca6416";
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
> index 27b2416cb6d8..50c384aa253e 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
> @@ -245,8 +245,8 @@ &i2c0 {
>   	pinctrl-names = "default", "gpio";
>   	pinctrl-0 = <&pinctrl_i2c0_default>;
>   	pinctrl-1 = <&pinctrl_i2c0_gpio>;
> -	scl-gpios = <&gpio 14 GPIO_ACTIVE_HIGH>;
> -	sda-gpios = <&gpio 15 GPIO_ACTIVE_HIGH>;
> +	scl-gpios = <&gpio 14 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
> +	sda-gpios = <&gpio 15 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
>   
>   	tca6416_u97: gpio@20 {
>   		compatible = "ti,tca6416";
> @@ -508,8 +508,8 @@ &i2c1 {
>   	pinctrl-names = "default", "gpio";
>   	pinctrl-0 = <&pinctrl_i2c1_default>;
>   	pinctrl-1 = <&pinctrl_i2c1_gpio>;
> -	scl-gpios = <&gpio 16 GPIO_ACTIVE_HIGH>;
> -	sda-gpios = <&gpio 17 GPIO_ACTIVE_HIGH>;
> +	scl-gpios = <&gpio 16 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
> +	sda-gpios = <&gpio 17 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
>   
>   	/* PL i2c via PCA9306 - u45 */
>   	i2c-mux@74 { /* u34 */
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
> index 6224365826d8..617cb0405a7d 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
> @@ -205,8 +205,8 @@ &i2c0 {
>   	pinctrl-names = "default", "gpio";
>   	pinctrl-0 = <&pinctrl_i2c0_default>;
>   	pinctrl-1 = <&pinctrl_i2c0_gpio>;
> -	scl-gpios = <&gpio 14 GPIO_ACTIVE_HIGH>;
> -	sda-gpios = <&gpio 15 GPIO_ACTIVE_HIGH>;
> +	scl-gpios = <&gpio 14 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
> +	sda-gpios = <&gpio 15 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
>   
>   	tca6416_u22: gpio@20 {
>   		compatible = "ti,tca6416";
> @@ -385,8 +385,8 @@ &i2c1 {
>   	pinctrl-names = "default", "gpio";
>   	pinctrl-0 = <&pinctrl_i2c1_default>;
>   	pinctrl-1 = <&pinctrl_i2c1_gpio>;
> -	scl-gpios = <&gpio 16 GPIO_ACTIVE_HIGH>;
> -	sda-gpios = <&gpio 17 GPIO_ACTIVE_HIGH>;
> +	scl-gpios = <&gpio 16 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
> +	sda-gpios = <&gpio 17 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
>   
>   	i2c-mux@74 { /* u26 */
>   		compatible = "nxp,pca9548";

Applied.
M
