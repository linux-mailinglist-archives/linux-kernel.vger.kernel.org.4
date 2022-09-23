Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36EB55E7F51
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 18:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232524AbiIWQKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 12:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiIWQKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 12:10:47 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80054.outbound.protection.outlook.com [40.107.8.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F269D100ABF;
        Fri, 23 Sep 2022 09:10:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R0lwXVQaYy2bCqosjikh3DMpA3+DjQs+WaAUrVjq2wRV/BAEE3UBvJaO/qkmRgi86ZXVkSvCTz/ao10tLNvuzg6WFyNiHJIPuvab6zu5U5E36gX2RchMlrJR4fnNshR1Jvy7fHtA+D7aystkkdeHzMSz/c2vLxMwSRdpIrzy2U7x+1K/oucx+na5sARX190r0rkLv8cwRFlBZBSqeOYIUQmRW8ei8Q645pEpD9UImBLjXTRoYkGlfqB2/xkFgRIpxgJzH7aNWQWT98tGdyOy59Z9uYQfC2Ror1D/Q+0LIucci7F3/D4QJduV/SHKQp5YT2HeuigSiLxomC5bcjRDlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0I9d6fFTkUE/1Ec4HDlr0XPlyYKYoNV1csdu1HWClJA=;
 b=POqecjvyXmUCoiADkU+aSyHlsIsEhK89ch+WI88MNuardAcKwV7mEP2ygJa3q+l4Mfkk2FLMCPFbVhT530c2qtLKeYqr5hb4crClUtx5dUL53IP/0fA+lZBTH2rEOr+BIro3iieEMPgjUj8uX7f6aS1ArOSl6vngZA1osN/IhSclaWZvcOGFeDkIIIQssVUuQajcCgmELJgpgTC2owUUokl8U91J0S3Grjw81H4SLBOsC5noD6t0ie9J8wyKhweSy6VRbB5BnWuU+4IF5j/S2hpUsizjS7jKnzFR0R7egW41vbk9vloQ/45+dGXjkF/am5FC0/dUBSal4e1zmXqAxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0I9d6fFTkUE/1Ec4HDlr0XPlyYKYoNV1csdu1HWClJA=;
 b=B1qlAF8H23zlDkmOB7AASlwD7Or5T72RArbywFCcc16SDHb65yZ3nVyNd0Dk4fn5cS8Oa+fGoskY0ev9RSupG4mkhslM+pVDtjpa2KdkLIEPA8Qi2ySsgs5TKKcoT9yeufmvVfyjfukO2WLFvY+/AmgA+Dutjs0MrvCY5204WuIcK1j4F04sU0gZD0i4rvFrhcveqSlu3DwWFiODj8oaP+OzMl1R7uQOLauGcQslHx0liSOzLKxcTNcRYP8Q9iJprEUUvKxo02lmQTqntQIBZ6EuYvcFDlxYsb5mN0IWxdW1HTmluPstq9ejyPJ4kkP5zpFB3Z5ejkQym4xGZHeCmw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4972.eurprd03.prod.outlook.com (2603:10a6:10:7d::22)
 by DBAPR03MB6502.eurprd03.prod.outlook.com (2603:10a6:10:196::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.20; Fri, 23 Sep
 2022 16:10:40 +0000
Received: from DB7PR03MB4972.eurprd03.prod.outlook.com
 ([fe80::204a:de22:b651:f86d]) by DB7PR03MB4972.eurprd03.prod.outlook.com
 ([fe80::204a:de22:b651:f86d%6]) with mapi id 15.20.5654.014; Fri, 23 Sep 2022
 16:10:40 +0000
From:   Sean Anderson <sean.anderson@seco.com>
Subject: Re: [PATCH v2 5/9] arm64: dts: ls1046a: make dma-coherent global to
 the SoC
To:     Li Yang <leoyang.li@nxp.com>, shawnguo@kernel.org,
        devicetree@vger.kernel.org
Cc:     robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>
References: <20220915233432.31660-1-leoyang.li@nxp.com>
 <20220915233432.31660-6-leoyang.li@nxp.com>
Message-ID: <e27d295b-abbf-716c-5e0d-97dd63ce07df@seco.com>
Date:   Fri, 23 Sep 2022 12:10:36 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20220915233432.31660-6-leoyang.li@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0443.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::28) To DB7PR03MB4972.eurprd03.prod.outlook.com
 (2603:10a6:10:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR03MB4972:EE_|DBAPR03MB6502:EE_
X-MS-Office365-Filtering-Correlation-Id: 03b9df79-11ca-44a5-5c2d-08da9d7e28f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6RFEOR0PMY7VTh0AHqYraWPuxMuweTI+8y8BD47ZnAHU0CcHXTRF59q4YtsNN2hy711TQtSVnRohbmFzC8togae51fTMk+I5KdEyBD7Jzzvc5heFOBpU89vHPlFxg+bP31wvz7RhUa94fmsR26unc5dKCgwhueTNPGWym0wH02gTWM8ZJ3v6fr8NvAKoQeljqSnlyYjWwrN80Fii7WmjQSjHLvDidyn+AQaTdhnsSPpHi5C2oIu6185c6CDZebgFL5kkcQVmzbpZMD9m7uKv41i9fh+W07axZy6ORmGJHeUgJfp6aEGg/HIpuXymdbs61+HKjg9pZC5UARoHzTGsmkPzMwndoNfDqpVPgwNJ8BM4govuX3uEnBvo7SVuIUQcr6crUvuzhNgItCj5pgU7FRO5S3Ifr3xmH/WP3suYQqLGJiFxGmR2oWMP/I2EXmnLk0H63TlJRBVRjP5z3s1UIInNrUv5P0xd5EmSqzgh5zjYf6+U1dK+9czVkLhj6sxyWfTMpIFbW9dhAOC44rv7lSplhN4AFErpnmYB4F3dN8CIOIRPx8akNDzrgDeD90hJPygb8s1CaOBQst5FENvd3WohIy8AoR9+wOW47CQz/Ns4xz5TvJA56AhVzCQ6lchD9nnTYJ3auv7i+PuNAMLconfgDFsJ+rHwohzM+XsSCWTxB+s8bk5JlYIYPaDS/qsD5pPEWWs111klQRnbLSCGT65CF/M4xWMUdwXIJ+/hgJWgJ1RVPm2c0fTx5XYP9SBO5BXUdjq5HX/4PkSWaxBz8+Eq0BKdeXqibetMVLeyUM0Hw7xDxDLoROdEmZPvM7V627GNWx52Yr+xfU6XcGnz7d0onO/Mwbv2q29P+eJ6VJg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4972.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(39840400004)(346002)(376002)(136003)(451199015)(6666004)(6506007)(26005)(52116002)(6512007)(53546011)(36756003)(2616005)(316002)(478600001)(6486002)(186003)(966005)(86362001)(38350700002)(38100700002)(31696002)(83380400001)(31686004)(44832011)(2906002)(5660300002)(66946007)(41300700001)(66476007)(4326008)(66556008)(8676002)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZmIrR3A1NGVvVzhhREREWENhSFpacjd2aU9KNk9zRHUvNzhGQVJoMW9xYXM2?=
 =?utf-8?B?MVBtamg0TDRPQ1RMNG1YZ0x3WkZ4VFFwQ0RKWGJMY3YvN1piSFJyRW4ycXhk?=
 =?utf-8?B?M1dZUGJOeXFBNUMvc25EVWN0bEhva3FRQjh2blVUWkNuK0dXdGFDdFFHOWd4?=
 =?utf-8?B?dkcvR09sc2tQUVNZdTZab0dvazAxcUU4TFNTV3pid2x5UFdZcnNoUkhTcExO?=
 =?utf-8?B?dFFHaENMQnk2cUtSbWpRS05tYXRBM0F2Zm1EMU41eEVXdVlUYVRHODFWS1Mz?=
 =?utf-8?B?T1RGb1hobHRtZ0NPYXVJMWhYaXFpZFpLRDBveVRaeXBjSHFkS3dhL29IOHR1?=
 =?utf-8?B?bmRvVGszSHBIeXZsd1hYN01Cc1huQ25kNWZNOVBKcHU4bEpGd3VIQXJlbUp2?=
 =?utf-8?B?MzJaUC9NaUZZZmRIY1M4RU5HeXFmNStTaE1tQi9XcnZwVWVOMjYxanhiMmcz?=
 =?utf-8?B?RWV3MTFxS0NsWXNLeTZuOW9NcWRqQnZYU1F5K3hYaVp0THVCc3RSTTJBRnlp?=
 =?utf-8?B?RmRJdEoxb2dOUTdVQ0Fya096U1pXL0ZZM3FQdW42dHJMbUlaWVlzUXYyQUZ1?=
 =?utf-8?B?YUdXVGFoeXdDc3lZTUloMlJpbmhVMW1oK1VvVlozTlJBbytpU1A0bUJxR0xO?=
 =?utf-8?B?WlduVUZjTjQ1Tkd5ZHNKbHFzaHBYQmNVUThWWmJuUGJ5a2o2L2RBOEtLZTZh?=
 =?utf-8?B?cjV0dk9GTFBsdkhreUFPVmxFN0hlUSttanRNcThyYjN6Tmc5bkFsSDBZc1ZV?=
 =?utf-8?B?ZW9BY0c3bVIzTUdhVDZtTDRZSFhxSWZFdm0wdENRajdXcDdvU2xoaVQ3R3Aw?=
 =?utf-8?B?ZW1LckJCZXVyQ1VkMnpFUTY4cXVMelhQWU4rWWlWZzc4c1Fnc0kwSHBlQ2My?=
 =?utf-8?B?cEJWN1NhZ2w1VitoT2hlY2pMalg0emxjT0xWMmlXNHQ3K3d0ekRXL3JyMmM4?=
 =?utf-8?B?cmIvVlBSYWRtK1hVVzMxcFNhcGtKNVNlWXZkdzNlb1dGbEE3L0dzUy9WbUVh?=
 =?utf-8?B?QmJiMm5ZQmxOc0huWlRyQWRtMGpNOS9MalpJOFY0MmlJN2QxOGxKbHNPeTlP?=
 =?utf-8?B?WmlTbzJtRlVOK2VxUms1ZC8vQVk1akJ3UTA4RDNnM1NEQ3NET2JiL0pBNkhC?=
 =?utf-8?B?T3FpZ1dxMlpUU1FablpHZ3YrWDRJazRSZlRSeTJ5elY0WlIzYXg5djJheEg3?=
 =?utf-8?B?QWhiTElOZEFVbjhOTnhQVDNEOXNyL1RXbEtieTJ6YndyRnB1UDF1ejBIQ3Ni?=
 =?utf-8?B?eGRYd2NPb0N3ZXk4WWk2S1ZHU2ZHeCtqUWIxS3BKeUFLSVIrSmU4T2gzYUVD?=
 =?utf-8?B?dW1OVEJDK1FhU0RrMnNMVjdIZ0I4eGZlVzBsK0lBaUhLaS9EZHRIWnhmc1pj?=
 =?utf-8?B?RFZwMXVzZGhYbzlPbGVYcFFCNlBTNDMzbXZtN3VKYVoyc0xNby9CRDVZR1dw?=
 =?utf-8?B?ejdsRWkxcVlnVCtCNHUrRmtpSzVxMDF1ejUvTlNVUUVzdDBrbi95dk5SNG5y?=
 =?utf-8?B?V3NsVE5WcC9vZFJ1THB6SXE3TC9iQThwQ2hvdHg4Z0FsWUZVdEpGaHlremNi?=
 =?utf-8?B?aktkdjFSam5CM2habWV4ZXlCY0lObytBTERnLzB4a0pZbXdhTlVCbzM4ZE5I?=
 =?utf-8?B?OG0xcWhpTXhFRXZ2TTMrbGdHRjFIeTIwK0FxZGZ6b3ZpT2dEdEU0QjNCYzFR?=
 =?utf-8?B?OEcvdEtNaFJ2R2pXcEwzRXc2ZTE3TTRpd3JNWU1wZDZjY3hEU2haQWlnUUJn?=
 =?utf-8?B?dFRlbjBpcEkzQlhETVhDcnUyRXlVRWxpRHgzTHBTdVBZVUU2Z0YrV2cySU1T?=
 =?utf-8?B?ZWZtSGMraGVGdksrd0JGcWkxTnc0WnV3ZnNGYlNCdjV1WktwTmNyREl6WjRM?=
 =?utf-8?B?d2Z5NHhGK0htUGdSMGRVdDYxMEtmY3FrQUQ1di95UVRQSEVYYy9FdWd6c21U?=
 =?utf-8?B?N3NHV3FaYnRWYS8wdThpdTBkcFhMZ1VxZVljQWR6bkVhMmlMUlhsR0tPZ0dz?=
 =?utf-8?B?cFVkVEVMYUUvdGl6bDNCUDNOWloxcXF2Z2liekNKazdqMXNNWUgxZHN2b0N4?=
 =?utf-8?B?TkNNVHpOaE5leFV2bHFSTjJHaUNadFFaRlk3UHN3cS91YVlrdmtGUVdZcFRS?=
 =?utf-8?B?MzJYT1hTQTE3YXU1YVlqUEFGZTBjekQrWHF3RlV2NGFUUkdBUjdVOGFncXht?=
 =?utf-8?B?d2c9PQ==?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03b9df79-11ca-44a5-5c2d-08da9d7e28f1
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4972.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2022 16:10:40.6567
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mitTPkHrjD7FRKH5P54MwFZHkEIVmrcAOR2Dxze8m4hgt/xcFJwNJCTx5WXUL+i89CGs6qJ1dtYT/Uoljpa6sQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR03MB6502
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi All,

On 9/15/22 7:34 PM, Li Yang wrote:
> These SoCs are really completely dma coherent in their entirety so add
> the dma-coherent property at the soc level in the device tree and drop
> the instances where it's specifically added to a few select devices.
> 
> Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> Signed-off-by: Li Yang <leoyang.li@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
> index 27033c558e3e..e406499a26b4 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
> @@ -273,6 +273,7 @@ soc: soc {
>  		#size-cells = <2>;
>  		ranges;
>  		dma-ranges = <0x0 0x0 0x0 0x0 0x10000 0x00000000>;
> +		dma-coherent;
>  
>  		ddr: memory-controller@1080000 {
>  			compatible = "fsl,qoriq-memory-controller";
> @@ -355,7 +356,6 @@ crypto: crypto@1700000 {
>  			ranges = <0x0 0x00 0x1700000 0x100000>;
>  			reg = <0x00 0x1700000 0x0 0x100000>;
>  			interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
> -			dma-coherent;
>  
>  			sec_jr0: jr@10000 {
>  				compatible = "fsl,sec-v5.4-job-ring",
> @@ -794,7 +794,6 @@ pcie1: pcie@3400000 {
>  			#address-cells = <3>;
>  			#size-cells = <2>;
>  			device_type = "pci";
> -			dma-coherent;
>  			num-viewport = <8>;
>  			bus-range = <0x0 0xff>;
>  			ranges = <0x81000000 0x0 0x00000000 0x40 0x00010000 0x0 0x00010000   /* downstream I/O */
> @@ -834,7 +833,6 @@ pcie2: pcie@3500000 {
>  			#address-cells = <3>;
>  			#size-cells = <2>;
>  			device_type = "pci";
> -			dma-coherent;
>  			num-viewport = <8>;
>  			bus-range = <0x0 0xff>;
>  			ranges = <0x81000000 0x0 0x00000000 0x48 0x00010000 0x0 0x00010000   /* downstream I/O */
> @@ -874,7 +872,6 @@ pcie3: pcie@3600000 {
>  			#address-cells = <3>;
>  			#size-cells = <2>;
>  			device_type = "pci";
> -			dma-coherent;
>  			num-viewport = <8>;
>  			bus-range = <0x0 0xff>;
>  			ranges = <0x81000000 0x0 0x00000000 0x50 0x00010000 0x0 0x00010000   /* downstream I/O */
> 

I'd like to summarize the conclusions of [1] below. This patch breaks
I2C0, which is the only user of eDMA at the moment. eDMA is noncoherent
because snooping is not enabled for it. I have submitted a patch [2] to
U-Boot to enable snooping for eDMA. For now, this patch must add
dma-noncoherent to the i2c0 node.

--Sean

[1] https://lore.kernel.org/linux-arm-kernel/29a09f45-24f9-68be-bdc2-8691af41b5db@seco.com/T/#t
[2] https://lore.kernel.org/u-boot/20220923160551.2200873-1-sean.anderson@seco.com/T/#u
