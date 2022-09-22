Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29B385E61D0
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 13:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbiIVL4m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 07:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiIVL4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 07:56:37 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60082.outbound.protection.outlook.com [40.107.6.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F38BA1D6E;
        Thu, 22 Sep 2022 04:56:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XgagVrcmXlPRHQpczZln4IVYVw/EmvrV5wTLYkn2wZRX40UM6m58NrgPXVF/LGkRcqYsUoxH3T7gMujl8PIVGA7nvCMc1hWfRkMcNATuWkBpV9o/25sz81NyGBx60OGmTsnLIgj/6u9WkMxhv+7AJwwu9Xe4R8NdTTZCeWjgNd07M+3vepuaSGzU7OiGzQgpg0MHnkUHy2TWEKWDx7pT4VoQ7CgXS8dDwFPOqnOiKIc9xS6Trfbw9XBajPQnaH2qSCXCjL1LmxroutSQHYz00c8XhQyGymjBNja0sFUsG1yFr5rLuO1V5Wz2OmZD5YeHjBq4DOtSW/8nhFKeJOa6OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oxGAgmC250NqR/N021Cz/FHJAzMjeXc/2NphZcmuGyQ=;
 b=gbCWWsxv04VBofs7SG1Dw5f8HBRF23O+Ib6nPHPOe8zC0DjkpncmvEQQcBhlA5ZqBMkQFWBUuqTTJnqfs/hgY+i+Vz0BDr5ypde2rr01kro8Do492C1IOI8pNXHU+fjvgWte/F/U3bNQVrhobhctavRmISAdfkV8FG87wOlPER76Jk5Ptg7CAysCaPLSWD+h6tiiQb0strumaqOh+MTjPZk5i/tId9k+yjpMigCVUy2ZWIYfBccs7C8G3wxe78PK/MU3w6cL528hBtv6ZsB2tLFCo4pQlj+pLZYfWYnGzGFNMWQmx2VY+YQVXiDJ/8LmSZe05zcloiAjDsFC3MVfrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oxGAgmC250NqR/N021Cz/FHJAzMjeXc/2NphZcmuGyQ=;
 b=GyFAbnuEAROxmIVriXQFBEjRGLbMxTcyXgqRLH3t5Apo8derja6Z4YgxHZG2wOJvFG7j/AoTyT5flIUALx9Gsb/Tg/lqaBXDtTcp2okimUpbwvtg6uBwyVXZNBUF7IEnRAaNxM2AhUm5pr/pCK3flH+LvzwOGyW5orM6psX7Pt4pfX2dfjokAmIe1q/z2Iq3QAQ0+v+AxY17M9oHm4vvNBmWZwNCkIHrAyv/TxDfJSFqyrXbEyEQZzZvx1GT9tu7Jwxgs8BIb6U9zJNb4v8IyhPZqBj36YZHoCsGD+PcPVYBltBDpZYrPXt33VQJor4HjcCnxXIPpKj7Yhevpz5rQQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com (2603:10a6:10:2d7::10)
 by AM9PR04MB8906.eurprd04.prod.outlook.com (2603:10a6:20b:409::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.18; Thu, 22 Sep
 2022 11:56:32 +0000
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::5e5e:1989:e5ec:c833]) by DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::5e5e:1989:e5ec:c833%3]) with mapi id 15.20.5654.016; Thu, 22 Sep 2022
 11:56:32 +0000
Message-ID: <0bc7d14f-6e38-009a-9ec7-46d92042b44b@theobroma-systems.com>
Date:   Thu, 22 Sep 2022 13:56:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: =?UTF-8?Q?Re=3a_=5bPATCH_2/3=5d_arm64=3a_dts=3a_rockchip=3a_add_PX3?=
 =?UTF-8?Q?0-=c2=b5Q7_=28Ringneck=29_SoM_with_Haikou_baseboard?=
Content-Language: en-US
To:     Quentin Schulz <foss+kernel@0leil.net>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        heiko@sntech.de, dmitry.torokhov@gmail.com,
        klaus.goger@theobroma-systems.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org
References: <20220922101211.3215888-1-foss+kernel@0leil.net>
 <20220922101211.3215888-3-foss+kernel@0leil.net>
From:   Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <20220922101211.3215888-3-foss+kernel@0leil.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS9PR06CA0204.eurprd06.prod.outlook.com
 (2603:10a6:20b:45d::30) To DU2PR04MB8536.eurprd04.prod.outlook.com
 (2603:10a6:10:2d7::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8536:EE_|AM9PR04MB8906:EE_
X-MS-Office365-Filtering-Correlation-Id: 172514c8-4104-40b6-04ba-08da9c917d8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZKZARB7jU7MtKX65o1ZE9q4fo/Z1r24DbUZB4TRN33HV2vtkfvS3uapqN2E/pfmP/R7QNu0fXc5CnDN+qwi6xGKvdvLsS0C2Vfl2JPKUgs5T0lwptkPhyUKj+69vt1WfwcO6Mlw6WFDUMhtHDq0VPBLeJZQozfq0suZ5yPAPBWtK4umdPjCFTIm3xW5zm1S4T/uyVtdaQdsbU6XwDdWQD4SaTGA1JldUn9xfYHZkgi7lzFD1b0UsOS0kL8OqKMq1Fdv/nZPOO1nf62F9+yElri4Rt8IKSxBKKDsQ2JAR72RJy2x5Kj4Hd7o65teesHgQaVKl3D62DrY0sAjpP9227aLx+pKSkcuUSxTeUFUFOEqzK5Wfe2n17HDyL6v76C7fo/rN3tHcP+oQ5FrXE6xcgfwZW7JHzXiGU+QHC6g8Mc2rdP1edUl7ZmRJQM1dN9AdYKVsMzAUD9bNXTGXCZ9i8OV+TsfICd3uTUadOONEYtYhncV8GE9HB71XBgoWDnrDDzb/N/lsVyLqWzyJblyWO1QXC+A2CZa2TkeMmgYidyGZdDnMBnUFLuEkOhm7jF7Nkgk2AQlXxpCXN21vA+0YENo8O+lwsa7di4TI+tV2+AKutAI3spE7dcFIFFG3hSiC1XzGpkrsH1IAP3+OcKBbTFqmj0E5Y/7DtZwWhWl+BjENuWO0Cen8pzis3v9UdsAxFDjkhsN2aUb5I6w8BOhkce60N4PmTL6HP6XFS4VDkjLsUmgNqccNN+MKbpl/No7zJWfk8zevFzKAtKgmtDc23kMA1FXfbm7hDX4oVkq5Kfw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8536.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(396003)(39850400004)(376002)(366004)(346002)(451199015)(224303003)(53546011)(36756003)(31686004)(2906002)(41300700001)(5660300002)(7416002)(8936002)(86362001)(4326008)(31696002)(66476007)(66946007)(66556008)(316002)(186003)(6486002)(83380400001)(44832011)(26005)(478600001)(6506007)(6512007)(2616005)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V1FKakdXdlpRKzg0azliRTZRU0xBWlVmS2RqNnZaVytlOEEzdmRWayswbHFF?=
 =?utf-8?B?eVA3ZFJrVVlibUlmZlYxelJic1dDMEEzc0hrdzZwbHBCT3ZKWExGUEZpMTls?=
 =?utf-8?B?NGx3SVh3ZjNUeW9TYlpRblgvZzBBWUZDRWoyRjloR2FPTkFRUFd3aXo2WWpM?=
 =?utf-8?B?R3lMR01CVllZYll5Q0ZlN1lBTEtxOUdYTDJpbEFSUVVoS0VLN09pWkdFMXNJ?=
 =?utf-8?B?cEJja1N0K0FGclZMcmRrdjdxaThQSDVuMzN6NjFJaHh6RG1hV1poZmE2Vmgw?=
 =?utf-8?B?dktBMHRQZmZKUmZVZEI3MVRwUEJEWW1adEdneDgrYXRLQWluRk9GSlNPNS8w?=
 =?utf-8?B?N01nZGhKRWh1V1gvc3JnV29aUWduT3JvNnNSOWVSWW1nYVNsR0JEelcyVUFs?=
 =?utf-8?B?ZC8vN1liaHhibU9zZTNoeWo0V1QwU3FINE5vUkJJR0c3ZE1EZklkR1F2d2Ix?=
 =?utf-8?B?Q3JLd0hTWXF4d2RMVlNSOEF6ZHhtRHhkaEJKdkltMUVRSmtMYVNsQ1N1UDVy?=
 =?utf-8?B?ZlFnRTRTZXJ0WDNma0dUWGZJYk5vUUh0QWxlZDZBbUpjc3hiVkJmYlk1bUZm?=
 =?utf-8?B?VmxCOGdseHFSdFgrdG1kT1ltdVhZVmVyVEYrcWpsazN2RndSUEhYZ0NuZmFv?=
 =?utf-8?B?a2ZGV05Bei9PdVovVmorWmsvUVZPR2tPbWRteHh2Qlkrc1FKK29COWdKdm02?=
 =?utf-8?B?bWdYdXh6SHNzQURFRXV5SndReWdnaTRaOVA3ajZxaVJvWGROeWhueUg5MGFK?=
 =?utf-8?B?dzZOZ2xRYmNubFBWYmlPL3VuZ290UEhVU2R4UFU5RVJrU1JsM0w1TkxSTGFB?=
 =?utf-8?B?cTFPTkE1UGhHbnBza01wbFFwaXhWTXFVV085Qnc5cGxjNG9UeStQNEhSL3Na?=
 =?utf-8?B?RU5DWi9TL0svWkU5U24za3JFamV5WXpPV1BiT29yRU9UMFRvT0MzUEcwNG1T?=
 =?utf-8?B?UytNcVYreDllbXVVN1E0MDYwaGV1OHA2N3VIS1FSWDJEcFl4RlhYWDZvQUVL?=
 =?utf-8?B?c0RYYzg2MGp6RncwUHk5RWFqYkxLQm1tNXF3bWJmU2FMc2dLWEpNL2tDV0hH?=
 =?utf-8?B?R1ZsZktFd2wyUTNSUStsUjljb1ZoNnVKWTBLSjRQU3JaR2llT2FrVk5HZ2Fm?=
 =?utf-8?B?L3ZGdEMyN1ZRaTlaOXFaUkpUZU5HTjRpMlVSRG5NQUlrU0VLbjVmR2xJS0pH?=
 =?utf-8?B?aEExWFpuQmpCeHBYbW5HSGw2UDRDSzNTVFR4TTdqQ0trVU5od3ROOVBNWjgr?=
 =?utf-8?B?UklkcDhOTVI1STUxQXdxT3FVZmZyU2N4NlpJYWpGK3BEQU1LUDg4SlhyZndI?=
 =?utf-8?B?aHdiR2RFeUtxOHV1enlldVJHMWY2TWVLUXVXZFFuZHRmaWZMcng2dWkvVGRU?=
 =?utf-8?B?Z1hEQmhDdlVwcXVJSFhiMmFTOU91VHJTajNKZGsydVQyc2ZFUWFaaEkzblNJ?=
 =?utf-8?B?QVBBbVJwQVlnVG81dnVpdW5xNFg0UkFqUnNNQkk4QmVFWWQ2cmhNd2NyMjRX?=
 =?utf-8?B?aDVQTDVUZG9Rdmtua3FsNk82NHZzM2pRSDBTZk53YlZ3ak8yQzByZXhNa1Fo?=
 =?utf-8?B?b2hPZjg4UXh4QlgycHRjVTFFZUY4V0t0UkkrZndORmJLSW8rQlZGd1VTT3ha?=
 =?utf-8?B?UklpSlpKdjVJK1B5MnVxd0JyRG9WaDdsYkpDNGlsU1hGbldsZ1RyS1pPTW4y?=
 =?utf-8?B?QytpdlBZWHZkQW9WOU1pZ1dXRVRLeUlQOE1YUjR1a0NUSlh1RUNsSklyaVdG?=
 =?utf-8?B?NmM5dTJodTZyelQzNEFvakptcVVVSmlKT0JZcThnZjVHSlVqSmZndDdhNkF1?=
 =?utf-8?B?VE9qY2RzTFZibHQ5aFJhY0U1ckNUSytXUlZaKzZ0V2ljK0tvWmpSNldwVFFl?=
 =?utf-8?B?d01PYTNPRnhNN0NpNE1GaFdUNWo3cG83L3pqOG54UVRsUEVreHZFWmlsbFdk?=
 =?utf-8?B?WHNLb0E3eENTbXJ3ODgxNDNtdWwzUFFwRHZXZmc1S2E3S1Z5UmhxcDVRZm4y?=
 =?utf-8?B?Vk9EU2JxakpIay96YlFEMzBZTTVjajY2NDBLcmF1QUxEL1kxK0JDdGZmd0ds?=
 =?utf-8?B?eVpFa244T1ppbGJvQlFhSnkzSDI0QmdncDNyOUxOTVJlOHg0dWVNb05LNkdn?=
 =?utf-8?B?OVUwME9CSWVLeU5veFBrbFFMc3RKQldiOWRjUFhrMlZaT3NKYmZEeHJ3cFlp?=
 =?utf-8?Q?XOgDNr0L9WZt95GqQlLd7sk=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 172514c8-4104-40b6-04ba-08da9c917d8b
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8536.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2022 11:56:32.0703
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cip1q1XFL1j1xPIH2JJIIsPPUyXhxRrHIRT8FOMAultchPcgmpcNsxIV4lKDVI56FwNVJps0oSnW6GhnPbTwQVg2/YHzNt0/2T8obVVyGRnVdSdU3gednP6kVms0mY9T
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8906
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

On 9/22/22 12:12, Quentin Schulz wrote:
[...]
> diff --git a/arch/arm64/boot/dts/rockchip/px30-ringneck.dtsi b/arch/arm64/boot/dts/rockchip/px30-ringneck.dtsi
> new file mode 100644
> index 000000000000..74a7f1182c21
> --- /dev/null
> +++ b/arch/arm64/boot/dts/rockchip/px30-ringneck.dtsi
> @@ -0,0 +1,347 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2022 Theobroma Systems Design und Consulting GmbH
> + */
> +
> +/dts-v1/;
> +#include "px30.dtsi"
> +
> +/ {
> +	aliases {
> +		mmc0 = &emmc;
> +		mmc1 = &sdio;
> +		rtc0 = &rtc_twi;
> +		rtc1 = &rk809;
> +	};
> +
> +	emmc_pwrseq: emmc-pwrseq {
> +		compatible = "mmc-pwrseq-emmc";
> +		pinctrl-0 = <&emmc_reset>;
> +		pinctrl-names = "default";
> +		reset-gpios = <&gpio1 RK_PB3 GPIO_ACTIVE_HIGH>;
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&module_led_pin>;
> +		status = "okay";
> +
> +		module_led: led-0 {
> +			label = "module_led";
> +			gpios = <&gpio1 RK_PB0 GPIO_ACTIVE_HIGH>;
> +			linux,default-trigger = "heartbeat";
> +		};
> +	};
> +
> +	vcc5v0_sys: vccsys {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc5v0_sys";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +	};
> +};
> +
> +&cpu0 {
> +	cpu-supply = <&vdd_arm>;
> +};
> +
> +&cpu1 {
> +	cpu-supply = <&vdd_arm>;
> +};
> +
> +&cpu2 {
> +	cpu-supply = <&vdd_arm>;
> +};
> +
> +&cpu3 {
> +	cpu-supply = <&vdd_arm>;
> +};
> +
> +&emmc {
> +	bus-width = <8>;
> +	cap-mmc-highspeed;
> +	mmc-hs200-1_8v;
> +	supports-emmc;
> +	mmc-pwrseq = <&emmc_pwrseq>;
> +	non-removable;
> +	vmmc-supply = <&vcc_3v3>;
> +	vqmmc-supply = <&vcc_emmc>;
> +
> +	status = "okay";
> +};
> +
> +/* On-module TI DP83825I PHY but no connector, enable in carrierboard */
> +&gmac {
> +	snps,reset-gpio = <&gpio3 RK_PB0 GPIO_ACTIVE_LOW>;
> +	snps,reset-active-low;
> +	snps,reset-delays-us = <0 50000 50000>;
> +	phy-supply = <&vcc_3v3>;
> +	clock_in_out = "output";
> +};
> +

I forgot:

&gpio2 {
         /*
          * The Qseven BIOS_DISABLE signal on the PX30-µQ7 keeps the 
on-module
          * eMMC powered-down initially (in fact it keeps the reset signal
          * asserted). BIOS_DISABLE_OVERRIDE pin allows to re-enable eMMC.
          */
         bios_disable_override {
                 gpios = <RK_PB5 GPIO_ACTIVE_LOW>;
                 output-high;
                 line-name = "bios_disable_override";
                 gpio-hog;
         };
};

Since I had this change in the bootloader that was enough during my 
tests, but better not rely on the bootloader whenever/wherever possible :)

I'll wait a bit for reviews before sending a v2 just for that.

Cheers,
Quentin
