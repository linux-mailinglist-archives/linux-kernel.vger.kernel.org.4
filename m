Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3A8D5E9B97
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 10:05:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbiIZIFb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 04:05:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233625AbiIZIFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 04:05:06 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2096.outbound.protection.outlook.com [40.107.243.96])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46932DF6B;
        Mon, 26 Sep 2022 01:02:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K1YlTRVDG+1TSS+PhGPAR3ikxmqMg1nHV5kKVxgYcVIIXnh5qWeDM3JIqZD0EinFNj9O6kAvYMSCMFH3gxPL7xwTMCK3opIT4VoL5XR0mWiUUhuqPAa/FH/DESiYW9jDk04U559FEY1KcVxhiTKo1dGDMJzKlvuJBxRtjTM1q5nYJyQM2zJdbizIpuAW9v06oq8v8d5AzsJqzD4H59csXcF14OMOP1DM0EqDIdl80dLLBoULT6HLgGBx3aRJsF30/iK8SiAUvcTPa2bZkNqfgDEx+g++GxGSiWEDUTzeg59JVdI4+ib8yhHqK3+exKmffGAAKHs7BGs48AuzsTsDeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9p4LfnPfs7bFw5FmlZauOFB4lbXby0RUPJrAqMR4Gvs=;
 b=YhOMWjT057LJ8v2DwF8gS5hjKfzHNY7xL3BW87jGNZ5nrqvWMI/YXbXH1B//IH967zNXJNCDbwLDvM4lP3s3t8A9Fd7GmGl1EhGrCNJiUPgcaEcw7M80uKD82fclSOmdtQ3Ve/AYukK8PFKSAjQ+9f/dRV9n+VYC0nBGaB1bN5h2VKULAkc+q9XXY2xVdaCEjv3XwXE5/7yCMaO3ZBknbgt4SetlXQm7SrvOCWu6/m2YnHOHPupBNTQmUCfJXdP5rUg8M0ltoo844SRzKwa2NL598YmwWhYUJWMOuZD4iF+DBiUMAkPIB9XPn4bxLZnwYtg/aAdRBbE2F5gMrnvamg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9p4LfnPfs7bFw5FmlZauOFB4lbXby0RUPJrAqMR4Gvs=;
 b=L/PyRDykgpwzKL4fWyodWl5KQJwSB9+nQH8SXWeHcfZdvevVMJ15MAyKyYdyYiY7Y+aql5qViggd8BTRjzsa9pJrncVNBNFhI56HCTy5XHa3LDdLeeJ1hBVLJ4nM/zSLjXbdDZviCo/PwheqrxPzWdU2xs6G+dtPinRSOuh5JqI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SJ0PR01MB7282.prod.exchangelabs.com (2603:10b6:a03:3f2::24) by
 BYAPR01MB5079.prod.exchangelabs.com (2603:10b6:a03:7c::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5654.24; Mon, 26 Sep 2022 08:02:24 +0000
Received: from SJ0PR01MB7282.prod.exchangelabs.com
 ([fe80::7d50:e907:8e2e:1ff0]) by SJ0PR01MB7282.prod.exchangelabs.com
 ([fe80::7d50:e907:8e2e:1ff0%3]) with mapi id 15.20.5654.025; Mon, 26 Sep 2022
 08:02:24 +0000
Message-ID: <9a5699a1-0649-808a-ff5b-e37c1e299418@os.amperecomputing.com>
Date:   Mon, 26 Sep 2022 15:02:08 +0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.0
Subject: Re: [PATCH] ARM: dts: aspeed: mtjade: Remove gpio-keys entries
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, openbmc@lists.ozlabs.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     Phong Vo <phong@os.amperecomputing.com>,
        Thang Nguyen <thang@os.amperecomputing.com>,
        Open Source Submission <patches@amperecomputing.com>
References: <20220915080828.2894070-1-quan@os.amperecomputing.com>
Content-Language: en-CA
From:   Quan Nguyen <quan@os.amperecomputing.com>
In-Reply-To: <20220915080828.2894070-1-quan@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0010.apcprd02.prod.outlook.com
 (2603:1096:4:194::15) To SJ0PR01MB7282.prod.exchangelabs.com
 (2603:10b6:a03:3f2::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR01MB7282:EE_|BYAPR01MB5079:EE_
X-MS-Office365-Filtering-Correlation-Id: 49b1e242-895b-43c1-d8b4-08da9f957249
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5Jnp4T10AA5qHCPn4gri6/OxsL0Q/BDQB5mJLK42sQQAIrQIaVExii1RYnsYCQtpswWpnXEXrZ130thiRe/axjPh5JKPS3DIKWkIqgY2lih0y95299xCYvHXuXfsz+TYszkcdRYOCi/VNLKRfHhf62Vvot6VInvlwdNXNhjKgaLYxmgjd3Vsu1tp50PNGx/Ad0eARw3HCACPMMpY89Okz9oh6PjcYH72qgxQAVHnaGbyG8TXrlXCkXLXsjH4sk1XMcfKDnXMq0Cyvy0v9jsle+ceOOfSEwvK2MVTAAseIYZOB8LOlQd+BIUMBC7ZJOm0KQI2txRso8H0ezWjS4UwZRNZklzlATCPsW53Bw29CUWKeufq3ckwMt+lDDcw/0Er5bGiS5W7+n+j8/03vY9/rpaZlFDzWrktI9osOKuVR3whzkEwFppGZSY8LfrJpgdiMSmGrEb+jyC4ZPEu3SPzCVWehb0x59OyS+OZ24rUp/BdQ1ylnnP50rTPoThONRKk38VWDDenrBPwCfHwLZusIvF1yPVbNRXs63mOlhTK521BFV8ahrKjqacCr09tHJG0bkXOvx0VLOgtwVQEBWhsHWwdJhNqo5l6OSJodftEHku1WZD45b3JfJ2plMuCR7yNnPHvffB4kw/3sgNWY+XFXsCVkbjb8gaSAsdkrkzq5znTr4gkBt5hTO5vh7PhMr4pCFOhDwaPk8TbKrRVwm0vCHFXfiFWoserHIBBOoXjRF78k4YQYCHMlaEdxvMz2iG4SlvkMjMdcqLFuKZxeDqaKoaq/KzKpGCV2v7fmX9n4CI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR01MB7282.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39840400004)(396003)(366004)(136003)(346002)(376002)(451199015)(186003)(6506007)(110136005)(2616005)(54906003)(52116002)(53546011)(26005)(6666004)(6486002)(6512007)(478600001)(107886003)(38350700002)(38100700002)(31696002)(86362001)(83380400001)(31686004)(8936002)(2906002)(316002)(41300700001)(5660300002)(66946007)(66556008)(66476007)(4326008)(8676002)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VnoxdUpRMU9xM0ZaOGtpOGRQYW9rRENtR0xHRjhjc29Ua3JyK1VNSkpEZ3hp?=
 =?utf-8?B?NnQzMmZWbFZBNGNwaWlUcFBsM3NWYnFrWlpkTWNvdnhEU2ZyNlcrWEJ6dkFt?=
 =?utf-8?B?dmRkWUlWTWJuRDdDMkRyVGgyZmNib0srS0lTWjhkTmpJQ2NBN2RRRkoxVDdh?=
 =?utf-8?B?MmVCd21LRWxHMnBwL2Z4dUI2WEdwcnp0WXFwclI3ejZiaDRaNUZ1WXpwMTY5?=
 =?utf-8?B?REF1ZHo0MDNLeDRJMXRDK3c5b1NZRVJkOHZHMytHY0FOUmFCQ0FJeVFtWkM0?=
 =?utf-8?B?b3E4U1M5Yk5GU3d4eHN1Q2RTWk1qQmdSeGdjSjdaVzNLdy8xcnA5U0gwLzZ0?=
 =?utf-8?B?Um9XSkI3UEQ0ZFJ2alZwVXBQMUtuMUlrTmFVdGFLM3Z4SHRHd0I4VEU2QUhz?=
 =?utf-8?B?M1lXTEN3R3Z2VFBWNGlWc1F2am9aZzhWWkFUSFlaT3RCcFNhWVFOK0oya0Ny?=
 =?utf-8?B?SEF4Nlo0bTNDYnllZCtRdityRUxNUlBUQUhiOGlwREdTRmtDdUMwYjErL2pX?=
 =?utf-8?B?QWRTeHc2S2x1SmxtaU4zSzFhS3pUekMvNjVKUGExL0V5NU9UYzY5bHc0NU9o?=
 =?utf-8?B?Szc2ZGZ6eTJZd0NsdmVKSG9JRS9sV1RBRmRhWE9SaTMzVE11ZW9UeGhqbW9a?=
 =?utf-8?B?QmZoamZVWWprRURKYWZ1YVhyM0lpNndKaWNleTVJbmgvUHR0MFVjdkZyODdv?=
 =?utf-8?B?Wi9Bc0pIUUdQUGR5dnJGWThEbVpOL3BLdGpxMHBkd2haRDhRaE54aEJZMnA0?=
 =?utf-8?B?VGtDZkc3bXJBYXdKZWRlRGtvc1BjcmFuUW5leThjZmlva1RnMUNOWUxyWkd2?=
 =?utf-8?B?S3dQWDBqZ0d3UGJqVkgxSTI1dXBvaVpNdi8zUE5KeldpTDRzZWNOMWM0bHJ2?=
 =?utf-8?B?TDdreVFQUlZNVFF4aGc1RXYwTHNIeEVsNXF2TlV2dnFLUktSV3A4UzlhZVIw?=
 =?utf-8?B?bDhON3dzd2lhYXd1ZkhIL3Z6WURLZUNaajlGZWxKSDBJbmVtWmR4dW5ZZVo3?=
 =?utf-8?B?aWlEOVROZ3ljMkpnK1p4WWxIeThBY3ovaytpNHN0Nkx4UEx0anlHV01JaERE?=
 =?utf-8?B?LzhwMktSdnkzN1BPTGhsbXd0dUJHcHp6emtKMVdONElyU2R5SGdSbWY5N3kx?=
 =?utf-8?B?RHlQZ3d6WHdCRjk1TU4vL0Rjd1M3VElXelpYSGRDZ2tXanlQNkJhOTZnNDlH?=
 =?utf-8?B?VEZnS1FLUnRnMUlTdVM2bFdJVjdsdzRQOWZuaG5ibmIwODZFY3RvMzVDZ3lL?=
 =?utf-8?B?UnRXcTFNdk9FT3IzOUJzYVRlWms5NUQwS2xWZlJCd2piUWtXY0ZlYXd0WmFU?=
 =?utf-8?B?VHJJVzA5bFBTRUtFZXVYM3R6UmNMcXNWRE9GMnQ4ZVpBN2ZDQ004c3BQNS9o?=
 =?utf-8?B?ZXNod3hTT0FSTXQvdDhWRzFGemRkMG5aaFJKaFpWQ29kNmt4Q2l0QmE1YkVl?=
 =?utf-8?B?WHJKNE1CZlVQbzdwRFFuUnozMXJxSGNZYUJrUENxOGNsZFZPL1JRdjVKZEph?=
 =?utf-8?B?SndvcTNmTEFFNHVtNGFKZGhqbmN5NGJKSmRNUlliaGwyQlNtbzZrY0t3elNy?=
 =?utf-8?B?cTlZYWUvL0FZSWRaVnk0aW1ZYU1hWE5xVlJSWGlVQlkwSWxmcnJzU0REbVJ2?=
 =?utf-8?B?Q2FxNnNqU1BnSllybi9Ob3YxWEt0RWVjQkozVWk5T0JRcDB5TmhCMW5DT3ha?=
 =?utf-8?B?aHd1b05UVGhnd1NmdjJpVm8vdWNVUEpQWUYwR28vMUJxb09RaTc4Vm8yR09x?=
 =?utf-8?B?QS9FUkIyMk5VWnRSQ200cENPT1R0OE04b0ZqL0U3KzdNNElCM01QSTk2Q0ZM?=
 =?utf-8?B?eEZUSzRQVVhGN2tuZk42RklPWmtvN0tIWCt3a3JNeDFFdnptN0VsTTVXZEVU?=
 =?utf-8?B?MXllQTZEWDVkMUtEclBSeWhSS1hvUnBBQ25jVlFuaXlFVE13b2RaY2NuOU5K?=
 =?utf-8?B?Sy9WWncrQm04QVlwMHpQSjBlMDBiRklCS0d0NWFXOXlMVWpjcDhnNGljSm1n?=
 =?utf-8?B?Si9maUd3S0FUcE9OTWxnUjRCYUtOb3Bvc1YvZm9CcTc0RUNNd1JoZ2ZvL2RH?=
 =?utf-8?B?bkErWUFYdTNubW5ZeUR0TzBLeXJoNDlzTDdJemN0cS9uUmliVjFxaE44OVFV?=
 =?utf-8?B?N1V0MW5KazljQklRbSs5ak9zZjF6RHlJZ1RpL3V5blRPSHNkcjErS3BxZm0x?=
 =?utf-8?Q?5vGGjgneUPpuNAW2WIlXIK8=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49b1e242-895b-43c1-d8b4-08da9f957249
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR01MB7282.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2022 08:02:24.4919
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0sz0ehgVoQryU+XmJZOO92ydI9+Ih8QdoIPiqktfgRC40BpnT7FzsjvEzZ1jjuElFCLzn2FqR9X2sMvxR6W5cUoGY4DHDTt7kraes300AMA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR01MB5079
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear reviewers,
Just a gentle ping for the patch.

Thank you,
- Quan

On 15/09/2022 15:08, Quan Nguyen wrote:
> Remove the gpio-keys entries from the Ampere's Mt. Jade BMC device
> tree. The user space applications are going to change from using
> libevdev to libgpiod.
> 
> Signed-off-by: Quan Nguyen <quan@os.amperecomputing.com>
> ---
>   .../arm/boot/dts/aspeed-bmc-ampere-mtjade.dts | 95 -------------------
>   1 file changed, 95 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/aspeed-bmc-ampere-mtjade.dts b/arch/arm/boot/dts/aspeed-bmc-ampere-mtjade.dts
> index 82a6f14a45f0..d127cbcc7998 100644
> --- a/arch/arm/boot/dts/aspeed-bmc-ampere-mtjade.dts
> +++ b/arch/arm/boot/dts/aspeed-bmc-ampere-mtjade.dts
> @@ -97,101 +97,6 @@ identify {
>   		};
>   	};
>   
> -	gpio-keys {
> -		compatible = "gpio-keys";
> -
> -		event-shutdown-ack {
> -			label = "SHUTDOWN_ACK";
> -			gpios = <&gpio ASPEED_GPIO(G, 2) GPIO_ACTIVE_LOW>;
> -			linux,code = <ASPEED_GPIO(G, 2)>;
> -		};
> -
> -		event-reboot-ack {
> -			label = "REBOOT_ACK";
> -			gpios = <&gpio ASPEED_GPIO(J, 3) GPIO_ACTIVE_LOW>;
> -			linux,code = <ASPEED_GPIO(J, 3)>;
> -		};
> -
> -		event-s0-overtemp {
> -			label = "S0_OVERTEMP";
> -			gpios = <&gpio ASPEED_GPIO(G, 3) GPIO_ACTIVE_LOW>;
> -			linux,code = <ASPEED_GPIO(G, 3)>;
> -		};
> -
> -		event-s0-hightemp {
> -			label = "S0_HIGHTEMP";
> -			gpios = <&gpio ASPEED_GPIO(J, 0) GPIO_ACTIVE_LOW>;
> -			linux,code = <ASPEED_GPIO(J, 0)>;
> -		};
> -
> -		event-s0-cpu-fault {
> -			label = "S0_CPU_FAULT";
> -			gpios = <&gpio ASPEED_GPIO(J, 1) GPIO_ACTIVE_HIGH>;
> -			linux,code = <ASPEED_GPIO(J, 1)>;
> -		};
> -
> -		event-s0-scp-auth-fail {
> -			label = "S0_SCP_AUTH_FAIL";
> -			gpios = <&gpio ASPEED_GPIO(J, 2) GPIO_ACTIVE_LOW>;
> -			linux,code = <ASPEED_GPIO(J, 2)>;
> -		};
> -
> -		event-s1-scp-auth-fail {
> -			label = "S1_SCP_AUTH_FAIL";
> -			gpios = <&gpio ASPEED_GPIO(Z, 5) GPIO_ACTIVE_LOW>;
> -			linux,code = <ASPEED_GPIO(Z, 5)>;
> -		};
> -
> -		event-s1-overtemp {
> -			label = "S1_OVERTEMP";
> -			gpios = <&gpio ASPEED_GPIO(Z, 6) GPIO_ACTIVE_LOW>;
> -			linux,code = <ASPEED_GPIO(Z, 6)>;
> -		};
> -
> -		event-s1-hightemp {
> -			label = "S1_HIGHTEMP";
> -			gpios = <&gpio ASPEED_GPIO(AB, 0) GPIO_ACTIVE_LOW>;
> -			linux,code = <ASPEED_GPIO(AB, 0)>;
> -		};
> -
> -		event-s1-cpu-fault {
> -			label = "S1_CPU_FAULT";
> -			gpios = <&gpio ASPEED_GPIO(Z, 1) GPIO_ACTIVE_HIGH>;
> -			linux,code = <ASPEED_GPIO(Z, 1)>;
> -		};
> -
> -		event-id {
> -			label = "ID_BUTTON";
> -			gpios = <&gpio ASPEED_GPIO(Q, 5) GPIO_ACTIVE_LOW>;
> -			linux,code = <ASPEED_GPIO(Q, 5)>;
> -		};
> -
> -		event-psu1-vin-good {
> -			label = "PSU1_VIN_GOOD";
> -			gpios = <&gpio ASPEED_GPIO(H, 4) GPIO_ACTIVE_LOW>;
> -			linux,code = <ASPEED_GPIO(H, 4)>;
> -		};
> -
> -		event-psu2-vin-good {
> -			label = "PSU2_VIN_GOOD";
> -			gpios = <&gpio ASPEED_GPIO(H, 5) GPIO_ACTIVE_LOW>;
> -			linux,code = <ASPEED_GPIO(H, 5)>;
> -		};
> -
> -		event-psu1-present {
> -			label = "PSU1_PRESENT";
> -			gpios = <&gpio ASPEED_GPIO(I, 0) GPIO_ACTIVE_LOW>;
> -			linux,code = <ASPEED_GPIO(I, 0)>;
> -		};
> -
> -		event-psu2-present {
> -			label = "PSU2_PRESENT";
> -			gpios = <&gpio ASPEED_GPIO(I, 1) GPIO_ACTIVE_LOW>;
> -			linux,code = <ASPEED_GPIO(I, 1)>;
> -		};
> -
> -	};
> -
>   	gpioA0mux: mux-controller {
>   		compatible = "gpio-mux";
>   		#mux-control-cells = <0>;
