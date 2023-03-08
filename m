Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D92BB6B12B5
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 21:13:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbjCHUNR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 15:13:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbjCHUNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 15:13:13 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9417D51FB4;
        Wed,  8 Mar 2023 12:13:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l8Z/6bWf5STQRPCRPfeFpUyCpqr80qaIjL7pIHuVWATyuW9QBScf+rqK194Lzmakg4akkh5knBLr42xIPA5P7ylpdLfxchkjquHf5XpVC07pLIRiDfs2vb6+po3LejfDMTNFDXkjCQ+ZWbeyhKkquizPFaOZ01MSwJ+Ni39oPu2loeODrW7nwmPo6gqj1LS68AtdZ/mATifb4Ldr4vYdzgKBO+J+ec+qaKFjh+PTYG+Nv4ZXXWFwCZRWaSKX7d8VLoHjXFPq6+Q5mVamzpIWHbnkaG+iJqEhFaao2vpCpv/vqC1eGkc1N66j6X4M1r1eukODG0r0Ga3z5NXDFrKp/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hIG3OUcYRWY3WPLnmwoUUWZILZ4dTn8y8hnizQkAylA=;
 b=Boup5VnOF0NuQMDmvNVjNC3Uallgf+d5Rbdr/a++dzA7LTyr37aCTrmDoR9nhLIBDRVorUagVC9Sjgkro/szzMEUeL6QiKMCA0hSd8mPputQaGJlDmPi08HWbAaPGAKe0ZUt0YJ0S/3GA2Eo0wPEMrMKKJgtCYSrCVUW5X/MROshDlyJdXoAPMVSLu9O7UzdRV0nxPfGstJ6jtFBxO4uxvcyQlIT73yfQHkZ02dz1inYPhJmmq3Sts9CyQzzK9qFTGIoKBe/AmPPs6Yb4yq6Ht+T4AwQY4rJCV8aHLp5Qten+Ob1uhbMo6F2MHEnSuSk3PWI34RXte3pdqvGE/ZXMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hIG3OUcYRWY3WPLnmwoUUWZILZ4dTn8y8hnizQkAylA=;
 b=GIOalNBma/5Kd2zdL9dYjgEnmRZFKxnDzWKVVSAnhmYTUhbFzszv/xr1pfFUtgFQZTpiK0zjg4LioH52As0gJSfv3/pmpB2oNiWGn1J1+Jldk9VIGeRDH7uHjXvPJf5uyzIK7x1999YL6Ilb0Hey9ktkvZSWYPOJ93TvboTfhu9rk3++vDmnVikz8+JxSstZ0AdjhRfESjSxllJMXSWGbfgcpMRlEGL4y48bft96aNpu7H7j5SjelXHL0XReywbK/zezVoEzxgt74Xvddbd47J+ThSEp9qWbtCyqSKRBiw6Yfv67GLEi8b0e5UO7qTRJXtEdl2Bjvj/8cA+kZV5OvQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB6604.namprd12.prod.outlook.com (2603:10b6:208:3a0::7)
 by SJ2PR12MB7962.namprd12.prod.outlook.com (2603:10b6:a03:4c2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.17; Wed, 8 Mar
 2023 20:13:08 +0000
Received: from IA1PR12MB6604.namprd12.prod.outlook.com
 ([fe80::735c:fa9:2043:279a]) by IA1PR12MB6604.namprd12.prod.outlook.com
 ([fe80::735c:fa9:2043:279a%4]) with mapi id 15.20.6156.029; Wed, 8 Mar 2023
 20:13:08 +0000
Message-ID: <ef58cd61-f90d-f242-9923-e9544d1aa963@nvidia.com>
Date:   Wed, 8 Mar 2023 12:13:04 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH V2 6/6] arm64: tegra: Add GTE nodes
Content-Language: en-US
To:     Krzysztof Kozlowski <krzk@kernel.org>, thierry.reding@gmail.com,
        jonathanh@nvidia.com, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-gpio@vger.kernel.org,
        linus.walleij@linaro.org, devicetree@vger.kernel.org,
        linux-doc@vger.kernel.org, robh+dt@kernel.org,
        timestamp@lists.linux.dev
References: <20230214115553.10416-1-dipenp@nvidia.com>
 <20230214115553.10416-7-dipenp@nvidia.com>
 <16e3ddb4-219e-70a8-8644-c62973f84d31@kernel.org>
X-Nvconfidentiality: public
From:   Dipen Patel <dipenp@nvidia.com>
In-Reply-To: <16e3ddb4-219e-70a8-8644-c62973f84d31@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0143.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::28) To IA1PR12MB6604.namprd12.prod.outlook.com
 (2603:10b6:208:3a0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6604:EE_|SJ2PR12MB7962:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ea158f4-7a4a-4974-752e-08db201188b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /QZdcmI+kxX7+iiOrbqRQ+m5q1BDxy6hFMFJGt9ImB96YkiuVb7xizIkQ1meRPUCHC8so5TnR9Jz/s+jIc9u78u8fWs6KuRLQan94+V3bCXcgPENHeMNLuUtWPSg1QdNT4buJgRGi0v+h+BG55CZxBIrxIBxYa0PfD3PtEebMOBawnzUuson92Rk55k6mJ/M2+7eDawnI2JwAN6f40TgRIB8C1eK3gmjnzQCYa4kwjDf9cKjQysyQFVSZagwIc9p4JyrSqDcQX7NlfFvhJBNc7GTvVM5d8+ZYxW7GEKCeIRSSFRDo6prNnSDDa7yIIemp0lYMsTDyabXRezcqskpwoAAG2hlGf09TIGhEl5ve8qkHfOClRYseqApOWmvQt8/sbiwuOQkFBt+Af/eQPqXryHCaJ97ECxyhyWsIm//o9GLrbsuolF12S5qeCIF2a8muSijXhrkNGtCWld77/a2BEzDx/XZDgojCMKMnSa6aIYeRHpotFa87mfZfzlWa/GC0GghR6vHNsOiK0yRXb/Y2twyCeAqxGDSGpcB5paYxsxsXBzyyLkk2uHtr36ERt5otwo3WaSVnyR0DRK/KOfY/isaMyJiRGco7Cl7yEr59RUlmDTtshmdBr3Ervci9QUhypeXlkhNyQcKcXeDHWUBGdVu8cOesvphw2t7lPbNLmwcbKH9PKI0YCWhY2OxNSVzwNOUUDfAh+c/JVgJv4rBUk0goun2yNZJUljMoRqoKQ98vXndMNGkcV+jN60uf0J8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6604.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(376002)(39860400002)(136003)(346002)(366004)(451199018)(36756003)(2616005)(316002)(478600001)(7416002)(6486002)(2906002)(8676002)(66476007)(66556008)(66946007)(41300700001)(8936002)(5660300002)(26005)(921005)(86362001)(38100700002)(186003)(6666004)(53546011)(6506007)(6512007)(83380400001)(31696002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dkZZeThZMUlVNnpvMFE1RVNzaWVsUXg0emhmOTVpZmFrNjZqQjlQdjlNUVhZ?=
 =?utf-8?B?Ymc2bThLYk5aWHM1WVcwRTdyTDJ6eDJXeGZienN4UVNRZGhvSGRTT2JIMEZh?=
 =?utf-8?B?VTdGRjU2TnRmclVhYWVTU1d5ODExNk5CN2Qzck1TcDVIVE9RenFGdGJaNzFj?=
 =?utf-8?B?M3BLWEo5RGRIV21Qc3VHME9HKzJJNTVlT0RPbVg4U0w4RGRXRSsyVmhDMExz?=
 =?utf-8?B?dndHS1ZMMXNGalVxc05CRUQ2WW1pL0t6M0UrelR0VGhGaXhEbXpqcEE1MFl6?=
 =?utf-8?B?a0x0TGVCOFBybzZ6cGdWOWNudU94eGJkZEhKYmtEOU5oY3pCdlZlbFZGb0l4?=
 =?utf-8?B?ZUQyT1RJazdsNUt3U0l2Y1lrSjRKN3lXU1EwWXh5bkZtajJOUjhjZWxoTklt?=
 =?utf-8?B?OFV1cC9id0NzZ05TVnNYOUJaeEQzRFcrRjN2YmxFREQxbHdWUmRqSVBpRDda?=
 =?utf-8?B?dXhZb2prUXVoNTZJSGhacklHdWsrc1FMWm9wRFZwSUJJQVpRVGs1a2c5ZzVZ?=
 =?utf-8?B?NHNLM3lhb29xVTlDa0ZpYXQyTlNHRk5sbTNIb290cTcrYUNYTDZQdUkvWnFW?=
 =?utf-8?B?elBUZVY2MFY2ODFXZ3NMbGY5eGFrT016aS8zUkNJU1RxaHc5UGFkU1ZsbzBa?=
 =?utf-8?B?RHVZYWQxSkU0c3hNemFoR2xBbFFSbmlldFMreDVHSWozR1BtRllXbk5HZjZz?=
 =?utf-8?B?T0FWK2k2YnVBYlZqbXdOcmtvUHJjYi9mcEFUZ241K3ZnNGx2N3hkVDRmc3Rr?=
 =?utf-8?B?RTNvbXNaTmtuMG9DV1phdkt6NXk1SFhORmZMS3R6aDQzdGJYVXdNcHRSUXRC?=
 =?utf-8?B?TDlLRjF5aWYvODdLb3FySUhtYXk4VzdEMVgyaVRTbmtFWHR1WWFES0JJL2RQ?=
 =?utf-8?B?dEFhK3RqSXc1Q0kxMk5HYmVNUFM4dXlZbVBuNCtVeVdTTEVtdmU4d0RhMXRZ?=
 =?utf-8?B?SUFXV1hXNnQ3TjBmdlArcTFRTjBaYzMzWFJ0aTM2SCsyTGw1dUdUSGJQYUsz?=
 =?utf-8?B?cUpaV1VkN0JVMGJ1N1UweXNvTWQzcWZ6a2NaZnNUODFtWTc4VFlZTVNDR2VJ?=
 =?utf-8?B?SHN1Nm8xa1dwWWppcG1jRFVIS1VaQW1sRHpYZHJnR2Q2c0ZNcFNEelNJYzBV?=
 =?utf-8?B?K0lNS3JLTWVaYlN6U1JjMnJrUm5JT1dGNjJERXhJQXlQSnlUL3BCOHc1UHpu?=
 =?utf-8?B?SWZWdFlqRmFRZFNSR2tmS0xaTzlVdDE1cnd6c1pyMEZFcjErRHVHQzJWUmVm?=
 =?utf-8?B?UHdmQnlVdGdtQXlUVnRQdmpNY2xwNlJFalkvZmpQcXZlNTVLcnExMG5wMmdl?=
 =?utf-8?B?WUIySk5HbEJCR3ZKZ1pxTTlaOWZhZkZoR1RsTDF2eHUvMUF4WGJScDhrcVBa?=
 =?utf-8?B?aXdrZmJkQy9CQzF1bi91cTZlSVUxZFRpVUgxK2Z6RkVWWVdkMHI1VHVSVEJF?=
 =?utf-8?B?OS81NWFPQnl6dmdSVmcralZ2QmdoaWFwZEpnTHlkQnFpODF0NFJJeGtXWlhF?=
 =?utf-8?B?L2dmWVRCTVFrZVZHMDZNRldlcVlvUHNmY2YvUzJuWVpseE9oTFpkcDJQWFJk?=
 =?utf-8?B?bm9QMzRKbjJxNnc2VjVzejZpZWwrWFdLbnpicEk5WXBGMUljU1p3L3BYVGs5?=
 =?utf-8?B?WGJWcFJta1NLU2VZUzVFazZ1d3ZTd2YvQmJqcmcya1RBdmg4aHgxZDM0eU9Z?=
 =?utf-8?B?S2hPRUNscjg3ci82TjBzTkF4SEhWRGdadkZlSThGeHA3aVJneWxBZ1M3NEVY?=
 =?utf-8?B?OWwwVjNYa3RVN3ZFR0J5MXlyU2hQSXFNdUE4Q1BDQTFDNUFkMlNKWEdiUHN2?=
 =?utf-8?B?WHFmenZkMEQ0ckwxbllHWUhPQ3ZPR3hQcEszeVJBN3FzeHpXNUZDcVZUTm4x?=
 =?utf-8?B?NU0waklsTklOQVplS1ZDcVFieVpyNUNQRG1YKzFpbENBZFUwdlAwWUQ1L0NB?=
 =?utf-8?B?c285RlV4bWYvL3YwRjQ1TG9GRlVEdlVTSjJsb1MwRUdmUkFmUTlZd1pzWHNu?=
 =?utf-8?B?VzdiRDA4UFVReG1aSUtPUjNxblE2dzF1MW1KOFB0enk5NDJwOG8rYm85OXhR?=
 =?utf-8?B?cGtQdVFHWllZVEJsN2R2MllST2NqU0JSb2RlZmtNM0xld25sMzdEWDNPaUVs?=
 =?utf-8?Q?AtZPfWBGTy2autlWgVtrz47ms?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ea158f4-7a4a-4974-752e-08db201188b3
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6604.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2023 20:13:08.5551
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mTXMk18Hcvw6APJMEXpGiUHStge4uPgLinNnbGAEhMRau9T5dJbPPIelk1XXgMSpmvBuDbthKQFBN1W9rVeiVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7962
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/16/23 6:18 AM, Krzysztof Kozlowski wrote:
> On 14/02/2023 12:55, Dipen Patel wrote:
>> Add GTE nodes for the tegra234. Also modify AON GTE nodes for the
>> tegra194 to remove nvidia,slice property and add nvidia,gpio-controller
>> propertyto specify AON GPIO controller node so that GTE driver can
>> do namespace conversion between GPIO lines provided by the gpiolib
>> framework and hardware timestamping engine subsystem.
>>
>> Signed-off-by: Dipen Patel <dipenp@nvidia.com>
>> ---
>>  arch/arm64/boot/dts/nvidia/tegra194.dtsi |  3 +--
>>  arch/arm64/boot/dts/nvidia/tegra234.dtsi | 19 +++++++++++++++++++
>>  2 files changed, 20 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
>> index 4afcbd60e144..4c92850b1ec4 100644
>> --- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
>> +++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
>> @@ -1363,7 +1363,6 @@
>>  			reg = <0x3aa0000 0x10000>;
>>  			interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
>>  			nvidia,int-threshold = <1>;
>> -			nvidia,slices = <11>;
>>  			#timestamp-cells = <1>;
>>  			status = "okay";
>>  		};
>> @@ -1586,7 +1585,7 @@
>>  			reg = <0xc1e0000 0x10000>;
>>  			interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
>>  			nvidia,int-threshold = <1>;
>> -			nvidia,slices = <3>;
>> +			nvidia,gpio-controller = <&gpio_aon>;
>>  			#timestamp-cells = <1>;
>>  			status = "okay";
>>  		};
>> diff --git a/arch/arm64/boot/dts/nvidia/tegra234.dtsi b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
>> index eaf05ee9acd1..4a87490c5fd4 100644
>> --- a/arch/arm64/boot/dts/nvidia/tegra234.dtsi
>> +++ b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
>> @@ -1086,6 +1086,15 @@
>>  			clock-names = "fuse";
>>  		};
>>  
>> +		hte_lic: hardware-timestamp@3aa0000 {
>> +			compatible = "nvidia,tegra234-gte-lic";
>> +			reg = <0x3aa0000 0x10000>;
>> +			interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
>> +			nvidia,int-threshold = <1>;
>> +			#timestamp-cells = <1>;
>> +			status = "okay";
> 
> Why do you need status? It's okay by default.
what's harm of having to explicitly mentioned? I can see status = okay in this dtsi file
for other nodes as well and was just following that.
> 
>> +		};
>> +
>>  		hsp_top0: hsp@3c00000 {
>>  			compatible = "nvidia,tegra234-hsp", "nvidia,tegra194-hsp";
>>  			reg = <0x03c00000 0xa0000>;
>> @@ -1603,6 +1612,16 @@
>>  			#mbox-cells = <2>;
>>  		};
>>  
>> +		hte_aon: hardware-timestamp@c1e0000 {
>> +			compatible = "nvidia,tegra234-gte-aon";
>> +			reg = <0xc1e0000 0x10000>;
>> +			interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
>> +			nvidia,int-threshold = <1>;
>> +			nvidia,gpio-controller = <&gpio_aon>;
>> +			#timestamp-cells = <1>;
>> +			status = "okay";
> 
> 
> Also here
> 
> Best regards,
> Krzysztof
> 

