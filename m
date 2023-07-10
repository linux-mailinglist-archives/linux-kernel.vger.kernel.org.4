Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B851374D306
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 12:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233191AbjGJKLB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 06:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233233AbjGJKKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 06:10:22 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on20602.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8c::602])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ED9A18B;
        Mon, 10 Jul 2023 03:08:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uap0XFQCQbtGJb6rGfcvgemafGP7nrjNJqyCX7mpY2KSFb0jKPuUqq2ZHnzTAJLR2OHNecR7IDfi5sEE//CEn7cJGd66aTvsfZ6oeD0leQl+zQ2Ypt0+UOP5c5qalk8fUBB0bAVFAeCGfUHg5l4i+x0pf4OD9v3FUxgu+ihdFpTNwx6zKyDzxezaX47MZpQROXeo+FTFXChcAhDUqseJ4urn4/QDyxK7cMYP2phmUsj1nBd6vyXiLJYDBIhSfxQySd441vRWdfwr2y8vyxv6dvf2pw/4b5RF5FyJ3LOKN+PbARpuIblJ6GHhfSo2zoUAL++jdN5w5phXeF9wYgHDkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Lt99RC05dQ+OGbgP4gyXSi4FAelGVXdenSAq575zIU=;
 b=oGubNaQL2VRteW7ZJPlJie/wsK6RvaGcWIRQpqmlj5nFBMwj9YM8m2JvOOqIwSrCO1q9/Va1Z2ZWxdtMX0fISVeOn/Qjpv/dk0HailsRD05f7teWRMmhtJ8D4wfS+PXipYVOH1M0xW0yODViks4quuWkQk86vCjl+UNCvrHXFgT7ZLqBgAj5seeJ8JOSBVl9a7u9Hq1TC2W64e6zadXctzDsywFmyZQviwAoxAeZRgOPSj3RvFbppdzSGAFjCFFnl8n5J1VFwWIzPrEjcxA0uBxrGxaMD6owRhVX9tf9aCswdBLFO+iSCIPHjO+BaP23y4jmzT46E7kHUajD1FG6AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Lt99RC05dQ+OGbgP4gyXSi4FAelGVXdenSAq575zIU=;
 b=kTQGgumpuHUTlJDUOxLQOhNF9TwqVg9Pd0VepXGSiVGhqRLSLjqvtjQgug2k6tf33Ugt740lgLhkFLr8VW45/YBAJf/LTk1X6pNYMtUOZMijOvkRJ0hrTEwZD+hkO5omJ2Kf+z4mY/GH7bRi4zhMp3TUv7RP5+5nZie1taS3GcA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by CYXPR12MB9443.namprd12.prod.outlook.com (2603:10b6:930:db::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31; Mon, 10 Jul
 2023 10:07:19 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::bb94:8eb4:943:d955]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::bb94:8eb4:943:d955%7]) with mapi id 15.20.6565.028; Mon, 10 Jul 2023
 10:07:19 +0000
Message-ID: <6170e39d-c26a-7b19-4107-f45577f3db85@amd.com>
Date:   Mon, 10 Jul 2023 12:07:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] arm64: zynqmp: Fix dwc3 usb interrupt description
Content-Language: en-US
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Conor Dooley <conor+dt@kernel.org>,
        Harini Katakam <harini.katakam@amd.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        Parth Gajjar <parth.gajjar@amd.com>,
        Piyush Mehta <piyush.mehta@xilinx.com>,
        Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
        Rob Herring <robh+dt@kernel.org>,
        Robert Hancock <robert.hancock@calian.com>,
        Tanmay Shah <tanmay.shah@amd.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <6544d13afd9f3d8f5413e32684aa16e4d155e331.1687160244.git.michal.simek@amd.com>
From:   Michal Simek <michal.simek@amd.com>
In-Reply-To: <6544d13afd9f3d8f5413e32684aa16e4d155e331.1687160244.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0151.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::14) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|CYXPR12MB9443:EE_
X-MS-Office365-Filtering-Correlation-Id: a0aaaec3-72f5-4f5c-5df0-08db812d71f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: spJ2LpVzvHcXwfXhEgFemzbIaEjtly5MRuuyeTGQ5xCw6FcsQphQfZ/Ye6Elt72jEzcrfUyDQEO/nyyRTsCTfXUq06R2ZrAaFcLSd7RuOQ/w57UbVdwq5+lTadRnYgb4k+rH+DOIj2Uebn7Z9w855pw/HXOn4ne/SKp+U/LGjTR0GMuk4H2ClyKQi24Zm1zhJ+2zoo/qyi4RYI3NDS+4VV46PoQ/9/PpoFCxwkgpAho4fpMWnJ+QKIZ3szQ28ahiv8hJadFdqhPmauHalxe5shokJZz5rdd83cSJH3atsqU8uE0w+Yn1UES0r3zdySPUezb4WuyewGt4BDLAGd+LoNxZPOY8M5QXTCfYgtIrSrZL6F1zpmXUSvfJ1ewICLyV9J1Umzz6Dh0oxwJ+AyFirFfm+GEorLoE32vMiVXkYdo4TLG3FRj4yMu8pzPYJYV8g2LpvQvMiH2QXVfJkmJfHvHsc8uvIjULKxhCbCaHvOlidzmJ7H7E9F2adf36nQc6EZIwNkWVcYt0iBjIJ2YpOFeF663p1LIHTo2n2wnmeiDoK5hx/6jugDtgTsC1xERGwi3rnjqoGJpqs5NcefZ5eBI6BG+3Yv95oVm+Fb18YrGekAuHCmX1FybNhHgb7K28xlxnR9g9Pacyfy3nJ2YRPg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4758.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(39860400002)(136003)(396003)(366004)(451199021)(44832011)(7416002)(5660300002)(8676002)(8936002)(316002)(66946007)(66556008)(66476007)(31686004)(41300700001)(2906002)(4326008)(54906003)(6666004)(6486002)(6512007)(6506007)(53546011)(26005)(186003)(83380400001)(2616005)(38100700002)(478600001)(36756003)(86362001)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OWlwcWNmdzJYYmRWdjVtNFF3cnZEbDZKWWFsK0E1ZW1FZmJhR2MyMVlYQzhI?=
 =?utf-8?B?VHhWdE5kMGg4b05VUVljTm5mQkVIemd4VHlBR1RaVlRPNk8wR3lmNUhXcXN5?=
 =?utf-8?B?WWdOWXQ4THMzbVArOFB2a21DbjlpM0x2ZEt5bkFnQ1VkSmlqemJ6MXdWVUJ4?=
 =?utf-8?B?MTZzcmxmRk1qdmM2VHRSbVpyZ3BGbmR2VmcyNlZtck05UUE4Y1V0eW1wUWgr?=
 =?utf-8?B?VG9COFpQdGxsRjEwNEVBbXcwZ0V2ckIrU3A2UTI0dmwwbzh5K3lPaE9LTWNQ?=
 =?utf-8?B?d05qWGQzVnQ2VCtDOU1KaDczZ0lPNTdnTWQyaTVMTjEvNUlKOGxzdERlS2N1?=
 =?utf-8?B?TUo4UXRuZDJBMXIvb1M1dzkxUkdmOTVUeGJhaXpBcnVWaVJucnAreTFaMldT?=
 =?utf-8?B?YzU1OUpZN0t4Y0FwUFZRalNhcW42NmdJeGZZRmYzcmE2TTdxSzg3VnBldmRF?=
 =?utf-8?B?bTF1bkRTdVZSV1ZQNktLcElXeldLZmRod0EwaUI3MDZ0LzRUd04zZE9KMGRF?=
 =?utf-8?B?S3FRa1ZVVDVTUW1JNC90NXVKT1V2TTNzbnB2VVdlZnpuUVh5SnJiUmpkc0I0?=
 =?utf-8?B?aWYzLzRqczZjbE1UaTkxU0NhcjJYSmdRckQwL3RNczNjZUZuS1g0RTBhNzk0?=
 =?utf-8?B?eFcvY2pnRDh5YWJianZWcDBRVVNPM1BhbmVPeGRYQ1VQanowZHZuV3RjdUNP?=
 =?utf-8?B?VGVLMHBmbmxxRCtVbXI4WWVjdXZjVFNHVU1MNDkrcEJGZkx2WnFOQzV1cXlI?=
 =?utf-8?B?ZGJyUTNFNXRkMVMyOW81YXM5bzhLOStqTFBiUDEza2pCZHpxVnJ3K2IyTnlB?=
 =?utf-8?B?OXdBWVV4RFE3aGh1Z0NFMEZ1V1lMU25BUmVMMkNwSWVLbXRPY3U2WVBGTzFj?=
 =?utf-8?B?Y1ByZG94M2crRkM2WC8wREN4bHFwMW9OeHcwemIweDMvb1NEUldIbW5YVU5p?=
 =?utf-8?B?Wllpelk3TEYyRXErVXBMMGloWklaUFdQSVVYNEE1QXJFakx5ZDkweTZHc0ht?=
 =?utf-8?B?NFZRekxVRnc0ZHhyMUZYNjVHd3hETXJBRFZXV20rdnkyRTFSMCtjN2h2dUpI?=
 =?utf-8?B?WUttVWFvWmNodGcyTEFGanIrR3kzbGk4YWhJaEd1ZExaZlZpbFYrRVE0VGVX?=
 =?utf-8?B?Y29WSVp4d0hmd3NOU053Ui9YR2o1YzhrVE1kNHdid3Y4eFJjSXpHR3VJSmNB?=
 =?utf-8?B?eFBlV1hMRGJKVVJtYWMxaXBnM25UbDI2cXFEQzJ2Mnl6Y3Q5bTQ0cW5XdGg0?=
 =?utf-8?B?WkNuaUpCVk1vdVZXLzVqY0x1a3AxdU83Yi9Eb0MzWG9LMjZpS1hyY1RaMHdt?=
 =?utf-8?B?eUdjVmd1amU2ZHI0dFgzbkprSllXSXFxTDM3dGRsQlZ1SkJtaXNFeXlqNFdN?=
 =?utf-8?B?V1U1K1VnUld3VEJMaHdIWjVWdE9mNGRIbG92eWRqYnd4ZkpwTlg4VFA4Q1Z2?=
 =?utf-8?B?dGI4bWxaN1B1RVdSZng2TDVFSXNzdnpXbDdsZTh5ZEF0SERWUlU3UGpKSTkw?=
 =?utf-8?B?b3VzYTcrVnljVUhrazYyd1J0UWhVeFc1cnBzcVFOQjMzNEtSdElxaUlpNmxv?=
 =?utf-8?B?MC8wWjhaZ0p3N2Z3c1IxQVBhanVMMkx3bVE2QkJ1a2p2U2gzT3RXRlZZd25i?=
 =?utf-8?B?bmg3VmE4L0ZTY2pMY3I5RVdENWFrbE80WVBVNVNEQ3JsRFF1R2lYTWVIZW5a?=
 =?utf-8?B?OE02U1FzS3lUVSs2WGUrWnRXd3RWdzdKbVpRR0RqVXRmTXlMV09BaW5obEUx?=
 =?utf-8?B?VjVHdXNPYXMzQ0E2YzRGeXNRblJlN2NsUmJEeUR6TUlSU0dzcTJqZWlJT0xk?=
 =?utf-8?B?K0gzb0Z2KzNHcmdMSDVERTVMb1BBQnZEekJId1EvRzJ0cmd2Yk1wckM1TS9T?=
 =?utf-8?B?OHJPb0V6T0VHd3oyU2hQNXRlTjBudUFTWWROOG5qekQ0ZmZjdzNBcnFZb2JF?=
 =?utf-8?B?RE1Nc3RZaWV4OGhWakU1ZEZ2ZDI2R3A0ZVpSdEFOVXI5ZG41QXFEdGxMY09B?=
 =?utf-8?B?NzUvYnhMOUd3N253cHRReGpQZlZYYmNwWk8vU29MR2F3eGtpZGZwbzhLYWQ5?=
 =?utf-8?B?ekMzb0VFVmNNNUpDOUhFMDNaRGdsblFRT1U1WUFOM0h3aE1QL1Q5ZXl3b1lT?=
 =?utf-8?Q?huylza3X0SraoV4ZXCob186TX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0aaaec3-72f5-4f5c-5df0-08db812d71f0
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 10:07:19.0537
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wmBlRqAN/FfsqZj1zEevubZyD63XL8lKNfQz8cQ9PKbp2+NUei5u4e8VB2KBphzb
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



On 6/19/23 09:37, Michal Simek wrote:
> Based on DT binding dwc_usb3 is single entry without anything else. That's
> why combination dwc3_usb3, otg is not allowed. That's why split it to host
> and peripheral pair which both points to the same IRQ.
> DWC3 code is reading these two properties first before generic dwc_usb3.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> index 02cfcc716936..e8104ffc6663 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> @@ -888,8 +888,8 @@ dwc3_0: usb@fe200000 {
>   				compatible = "snps,dwc3";
>   				reg = <0x0 0xfe200000 0x0 0x40000>;
>   				interrupt-parent = <&gic>;
> -				interrupt-names = "dwc_usb3", "otg";
> -				interrupts = <0 65 4>, <0 69 4>;
> +				interrupt-names = "host", "peripheral", "otg";
> +				interrupts = <0 65 4>, <0 65 4>, <0 69 4>;
>   				clock-names = "bus_early", "ref";
>   				iommus = <&smmu 0x860>;
>   				snps,quirk-frame-length-adjustment = <0x20>;
> @@ -915,8 +915,8 @@ dwc3_1: usb@fe300000 {
>   				compatible = "snps,dwc3";
>   				reg = <0x0 0xfe300000 0x0 0x40000>;
>   				interrupt-parent = <&gic>;
> -				interrupt-names = "dwc_usb3", "otg";
> -				interrupts = <0 70 4>, <0 74 4>;
> +				interrupt-names = "host", "peripheral", "otg";
> +				interrupts = <0 70 4>, <0 70 4>, <0 74 4>;
>   				clock-names = "bus_early", "ref";
>   				iommus = <&smmu 0x861>;
>   				snps,quirk-frame-length-adjustment = <0x20>;

Applied.
M
