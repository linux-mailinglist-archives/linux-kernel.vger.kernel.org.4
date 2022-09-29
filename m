Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6BBA5EF931
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 17:37:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235957AbiI2PgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 11:36:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235955AbiI2PfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 11:35:01 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-eopbgr130052.outbound.protection.outlook.com [40.107.13.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 146121C45AC;
        Thu, 29 Sep 2022 08:33:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XGAdNlPg5/edyUVaWkyOjhjtmoS9LkltHsiKV4cvDeqfPUZRoTLcyoK7ey+NWiYcXxwcYndPoRS+5335ErCUV98PcdX2AZKwOaJ3mbACURbkDCtRo77oVf9IU54Pmu4DJSRtnxFgUN1B0ApKmjFPwoyAdMoGkFxgQy0mqsvwUyqUCDguVf9nKpl4VtJHQNeDo6vHHYq84y6ANpuiYEWFn7nzbhBVS1I/v/8Ok6G5BcUMXxrAdihazHMKchJGzfeJKWTos8fbEL/9Ij7vxEKlbV3Ln64Icf34lJ1bO/+ufG9eLC6b8hA1fnQr02a1c1DrabVawWdJGZws7kIptQ6yjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=++BDQWWTNOJPi+a/Kajotl3K12feo4hO7X/LZzyb43M=;
 b=HfOuSO+QDIkjAbGXYYFkkVf1q/8iyL7Ij/3EMwBGbZ8rIvab9GPnLeulq+7qipnwahLWecH8qWfDaG/3xV1ebj4sqzjg0p1IbUOW1NmwF4XEhlSgxnUUXYx1F/xgxb7OZFjAIW+ppe4gd+IPQPvbc85Y4W7ALP2UsdOFKj0cmeTk2WBkP5NUxRcRwsQnai5OOvc/VMUGv9B6BrkY8Os2djcO4FDRT+sxTJZRGlujgbH86TSyUfmsm/sNSbhkPqVeLfWrYGG1+DNX9nJ3NbAmQC/4P3uSM+wTe9HTf+YMsnWCagAlbUpLkDE1dG/SjY1RZhCwdnxUB65SPL96DwsjRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=++BDQWWTNOJPi+a/Kajotl3K12feo4hO7X/LZzyb43M=;
 b=o/WlDv8ZPiDOoLYgBLw3sySnpXSfnMXKu4OsXg54Rqoo3hE8jRj8FFB2YPxGXaCqdmvXKvsYSArFm7o5LglYr7O4aBJNJ9SDZBBSviTzlKZFti4k/4Cryq5qNCVSH0wcwhNOS4UUUd5dbvrnalYiwnRDg0n8sYuX1tHOasiKN4WWA/OwL7+f0/BjI3aik09b+H5CrLD08Ax7A/ZVeklnK0aLiaUp+RB0M5OOQCj39Jlrgz/Rn4YxybtoLi+d661jBufG58L0YIfmlFrxnlD49q9QwXFAAHT4JFuvugVssukaLMbrR3o0wOKetUd/gIioyBjJNtn/00JN8ZQnLhj/RQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4972.eurprd03.prod.outlook.com (2603:10a6:10:7d::22)
 by PA4PR03MB6814.eurprd03.prod.outlook.com (2603:10a6:102:f1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.20; Thu, 29 Sep
 2022 15:33:53 +0000
Received: from DB7PR03MB4972.eurprd03.prod.outlook.com
 ([fe80::204a:de22:b651:f86d]) by DB7PR03MB4972.eurprd03.prod.outlook.com
 ([fe80::204a:de22:b651:f86d%6]) with mapi id 15.20.5676.020; Thu, 29 Sep 2022
 15:33:53 +0000
Subject: Re: [PATCH v2 5/9] arm64: dts: ls1046a: make dma-coherent global to
 the SoC
To:     Leo Li <leoyang.li@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>
References: <20220915233432.31660-1-leoyang.li@nxp.com>
 <20220915233432.31660-6-leoyang.li@nxp.com>
 <e27d295b-abbf-716c-5e0d-97dd63ce07df@seco.com>
 <AM0PR04MB6289919428F12CD125357D4F8F519@AM0PR04MB6289.eurprd04.prod.outlook.com>
 <1db9ffaa-3c93-9e09-8966-73aba061f52e@seco.com>
 <AM0PR04MB62892A07019165E14802DDCD8F549@AM0PR04MB6289.eurprd04.prod.outlook.com>
From:   Sean Anderson <sean.anderson@seco.com>
Message-ID: <600df10d-c76a-647d-0b92-d46d5eab24a9@seco.com>
Date:   Thu, 29 Sep 2022 11:33:47 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <AM0PR04MB62892A07019165E14802DDCD8F549@AM0PR04MB6289.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR15CA0065.namprd15.prod.outlook.com
 (2603:10b6:208:237::34) To DB7PR03MB4972.eurprd03.prod.outlook.com
 (2603:10a6:10:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR03MB4972:EE_|PA4PR03MB6814:EE_
X-MS-Office365-Filtering-Correlation-Id: 2417240d-b43c-4da1-3419-08daa23003f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LEQ75U/Y6OHpuUUaV8F9EeDyE6rMx4p9NZF9sId0Gtsp/X5wrD0HOkJpUf0LKyPH7VgCVEwtgIH8KUKinoeRRXYcIgB5slxA4CwgizSdnYFTOxqrklc3u0uMOwAoHE1I9n6GronclJgJV6/77hQkmxUQ4SPnDgkAzENdyJlyeiEdOJcXYY5NVr+QKTOGXAiOjGm0vTsZTXaC2sR6k0Jb2BA/XkLehBym6mEO4tkwTxUzgmu7W+XaqD6FEn8VPERMAwCTgQHnDXIgOijqaXAmQvRRKdvqjJTxI9iwCeJ/dMWNuBdREaMxbwqhEtP1WyeqqvJPX+SQ8hrqFDos/Hr4RvkfQU93gTdbmtihYqQIHK84OcKeSjL7r8pPhbRBmPM0ovdwDJi6xzPb49Z8lvdCPpfokFkxsWtNx1KUz3iyOk524Gz/4xB0VEI4vWl5ClIhOzBMNpDoki9rnXZ4pWS0FKbCCylTUkcX44mMrD3M+5XXSJAgsN/kSvHVB/4p7nhFxa7hyuKMcF3jZBtra8piOV8DcqE6neaEil6ljZWk6EyiSimG0bxCCC2ymAJA00Al6Iufz+b8mzdiA5GwIW1lF/xUquptCMKMAaou5YcXC+At4tl2zsfEOw1MXdjbm1JJg+JF5RDfYO9bR0KWzpwu3MM9qSeFfMLvVuSWh/we58JDDf+DVgFPsJY/OQ6Y4RI7lCCwJ+864SdaWzRpxBcFRmZYDZ7dsQs6PhRyqC3W+b7ICSmsc++0a4z1vUlVlGQ+LechnFblgNAGNxuCcd70GAzxCqqP1gF9DEBR/KneTpg2DVHrrq8RSu8QJ/2FqAoMSdaaojLruJLMU/a3otQing==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4972.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(39850400004)(376002)(396003)(366004)(346002)(451199015)(2616005)(6486002)(6512007)(26005)(6506007)(53546011)(31686004)(38350700002)(38100700002)(8676002)(54906003)(4326008)(110136005)(316002)(86362001)(31696002)(36756003)(186003)(83380400001)(478600001)(52116002)(6666004)(44832011)(5660300002)(66946007)(2906002)(66556008)(66476007)(41300700001)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VTFkdlZNS1BiaXdSbngrY01wcGpoVzZ0Qm1BczNYWVEzM1QxaENyT2t5VWZv?=
 =?utf-8?B?Y3E0VUdZazA0MXE1SHRRTkMyOUFETldLOFhzU3NMZnd0S1NJdGVOZTlCd1dx?=
 =?utf-8?B?SlFndG1MaEhpbGJtajNEMVF2UFFBMitIQkdLV3M4V2tVeDE4dHVURzZDcmFH?=
 =?utf-8?B?SEI5a2tmaDZmcjBiTnRsb1dDTzlzVGU0cXF1Si80MTZmZlA5MFI1ZHYrWkRw?=
 =?utf-8?B?WGlxUW1NVHIwR24xcENqU0poVVBiSjN1Ryt1SHBjanRxcmZ0M1cxdVRJak10?=
 =?utf-8?B?TTkzaTlCd1I2QjNIN2toRGJueG94dGw0aEU2QXZ2bWNHMGU4VnBtb2NoVUsw?=
 =?utf-8?B?L3h2NkwxZjhCQnNqS1paZHNjN2hqQ2d4ZnVSYUpYTjdxRTd4NTBNYlR2ci9F?=
 =?utf-8?B?SzBFcHdxSGQxK3c4TDc1U0R1WE9iM3grdHFzb0l1d2E4YXFTVGZiUU8vV0R2?=
 =?utf-8?B?Q3plc2hHS2ZOQUl6UVM5ZVZLSFVQVGs0VHBvS3YxbDRjTDV5VVNYZjhINGpS?=
 =?utf-8?B?MmZCeHNEeWxpN3V4N29pV0dWbVM4dlE1NWFGdHJmbWdPbW9DbGRjeksxK201?=
 =?utf-8?B?YmNxWFBvV3ZpNHdXdXNKOU4xRFpJWmhqTzJ0cExWTGc5NjZXVnhTdjhwVE5E?=
 =?utf-8?B?Rng0L0VYcTdUcXpReUdNMGN5VUZNYkF4QjJSWmlsNERqRTNCSEJGWkptbXUr?=
 =?utf-8?B?ZUNNT3luZjhDZmk0NnRJdElhdnNVdzZWTVFFdTAxdDIxYTlrSksyKzRQc2JU?=
 =?utf-8?B?TDI5RU5IckliR2poMVlpUHJHaVVxUEVkdmlNYnVBT09rZEduWnZ3UkxxdFM3?=
 =?utf-8?B?TTVvVmp2ZGFPY2JwL0J5TWFTWFcvTmJFUVQ3b2VyUzBRZzlTczVHTUJNOWhN?=
 =?utf-8?B?c3lOZi9FWDZuTFQ4YjV3cGl3OWpnYmtqcUIvYUpRT0FpVUJRNzlGaFpxOEdx?=
 =?utf-8?B?dmg2ZUFCWFZwaXhiK3RMTnNrMUQrcXFFdlhCOGltNVViek5va21wSkFKZEpI?=
 =?utf-8?B?ejFncUFmMGxTcUJtQW5UZUxkTW5wSDFPVC9EaSticVF1TCtOZ0lUZUpRSXoy?=
 =?utf-8?B?Ylo0NDExcktFZDc5Y2JTay9ISzVjbUhxY3UxMlcvU0hJVHFDdGdGdHpTaXZ1?=
 =?utf-8?B?bGxzMDFmdjRCSU91Um1PUE8zL2tTYWVoZ1VlcWtsdnFCaGR2WDAzTlNuNW92?=
 =?utf-8?B?d3M5aXR4UkpKbjZBSjVZaHdtZ0lZM1Fqdnk4SVNBZ3dTaFJoMDZlZVhERHpx?=
 =?utf-8?B?YWVIMm9OczlxOFlGbzFxbFRPYmp6WDhHdlh0RjBmUFV1RzNhY21iY3MrMklE?=
 =?utf-8?B?Y2Q1N0prZytmNnByM1ZZU2x6L2cxbmowVkVDQWZMbGxTNE90UEpCZGU4alRl?=
 =?utf-8?B?Y3VXcUM2emFZc1RFUTR6T1RMTWFZQ0ZpTTJzV0ZDMnQrMGtZSjhDOFV5OHJi?=
 =?utf-8?B?b21tQnd1ZzFSSjFZNzFkTHBjRnRIU2x2MHd1a0tkcG9zejVVOCtnNllrVkxS?=
 =?utf-8?B?OEg1aWlJd2hwMkxmRjN5ckJ3aEpHaXFKc1FZaVpQTFU5QWJ3eC9OVFh4Vkcw?=
 =?utf-8?B?Wkc5akRJbkFiN1QrU0VsSEduektiU05nVzNRQlNnZjl1NVlscTArcFJGa3dB?=
 =?utf-8?B?T0JVUTV0UmFpNXJUOEw2ZTVPK29YRjVnMDFpOWo0S0hibEZOT3c2Q0N1djh6?=
 =?utf-8?B?bEdFSHdOYlpPQmJUb3RzZHM4UkNHM0tyZlllVGJsdDVCUXhUVTVPZU1ZWWlw?=
 =?utf-8?B?cmZXcnFaaXBLWTJvNGZCUmpOQ0wrVG1EM21tNXRkTFN1REpzdTJDNmZNMFlR?=
 =?utf-8?B?M0tUYU90K2F3NkR1bDlsbDFTU0FyMXFZYnZWR0ovZFUvWVRFaTA1Z082RktD?=
 =?utf-8?B?QmFuMVJ6L2h6cVJrWkU4L1lRRjY4N1ZBaGtobGJibHRCUXJMdGI1bjA1aTNT?=
 =?utf-8?B?YnQ5Uk04aktwVStaOENCb3NVdVozOTF3dDNQc1lJMTZTV3JrbEpYenptdHY0?=
 =?utf-8?B?Sm5ncE5yK3VoaFZncTQvU2ZSTkhhV3VQRXVzQURKN3pid1pDaXAvcUlFcjBP?=
 =?utf-8?B?eXFTMDlxaUxMU3JKdlJXVGJKWWNwdENnUkFFNXUzYk5WdCs5b0pORFRER3NK?=
 =?utf-8?B?WXBjaDlLMkZacndHNWF0aUd5aGpQK2FjZS9rR0pGU2g3ZHRaNlRsL040dVMr?=
 =?utf-8?B?RHc9PQ==?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2417240d-b43c-4da1-3419-08daa23003f1
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4972.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2022 15:33:53.5865
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SiYZdbOS1M8uelFomdwVKcDwgpcJbnvbP45OmaYV/ucnxMGE7TWgrh9p+TFbdmDT6IjCv1uQHV9VkmCSXvcm1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR03MB6814
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/28/22 7:15 PM, Leo Li wrote:
> 
> 
>> -----Original Message-----
>> From: Sean Anderson <sean.anderson@seco.com>
>> Sent: Friday, September 23, 2022 11:35 AM
>> To: Leo Li <leoyang.li@nxp.com>; shawnguo@kernel.org;
>> devicetree@vger.kernel.org
>> Cc: robh+dt@kernel.org; linux-arm-kernel@lists.infradead.org; linux-
>> kernel@vger.kernel.org; Laurentiu Tudor <laurentiu.tudor@nxp.com>
>> Subject: Re: [PATCH v2 5/9] arm64: dts: ls1046a: make dma-coherent global
>> to the SoC
>> 
>> 
>> 
>> On 9/23/22 12:26 PM, Leo Li wrote:
>> >
>> >
>> >> -----Original Message-----
>> >> From: Sean Anderson <sean.anderson@seco.com>
>> >> Sent: Friday, September 23, 2022 11:11 AM
>> >> To: Leo Li <leoyang.li@nxp.com>; shawnguo@kernel.org;
>> >> devicetree@vger.kernel.org
>> >> Cc: robh+dt@kernel.org; linux-arm-kernel@lists.infradead.org; linux-
>> >> kernel@vger.kernel.org; Laurentiu Tudor <laurentiu.tudor@nxp.com>
>> >> Subject: Re: [PATCH v2 5/9] arm64: dts: ls1046a: make dma-coherent
>> >> global to the SoC
>> >>
>> >>
>> >> Hi All,
>> >>
>> >> On 9/15/22 7:34 PM, Li Yang wrote:
>> >> > These SoCs are really completely dma coherent in their entirety so
>> >> > add the dma-coherent property at the soc level in the device tree
>> >> > and drop the instances where it's specifically added to a few select
>> devices.
>> >> >
>> >> > Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
>> >> > Signed-off-by: Li Yang <leoyang.li@nxp.com>
>> >> > ---
>> >> >  arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi | 5 +----
>> >> >  1 file changed, 1 insertion(+), 4 deletions(-)
>> >> >
>> >> > diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
>> >> > b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
>> >> > index 27033c558e3e..e406499a26b4 100644
>> >> > --- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
>> >> > +++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
>> >> > @@ -273,6 +273,7 @@ soc: soc {
>> >> >  		#size-cells = <2>;
>> >> >  		ranges;
>> >> >  		dma-ranges = <0x0 0x0 0x0 0x0 0x10000 0x00000000>;
>> >> > +		dma-coherent;
>> >> >
>> >> >  		ddr: memory-controller@1080000 {
>> >> >  			compatible = "fsl,qoriq-memory-controller"; @@ -
>> >> 355,7 +356,6 @@
>> >> > crypto: crypto@1700000 {
>> >> >  			ranges = <0x0 0x00 0x1700000 0x100000>;
>> >> >  			reg = <0x00 0x1700000 0x0 0x100000>;
>> >> >  			interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
>> >> > -			dma-coherent;
>> >> >
>> >> >  			sec_jr0: jr@10000 {
>> >> >  				compatible = "fsl,sec-v5.4-job-ring", @@ -
>> >> 794,7 +794,6 @@ pcie1:
>> >> > pcie@3400000 {
>> >> >  			#address-cells = <3>;
>> >> >  			#size-cells = <2>;
>> >> >  			device_type = "pci";
>> >> > -			dma-coherent;
>> >> >  			num-viewport = <8>;
>> >> >  			bus-range = <0x0 0xff>;
>> >> >  			ranges = <0x81000000 0x0 0x00000000 0x40
>> >> 0x00010000 0x0 0x00010000   /* downstream I/O */
>> >> > @@ -834,7 +833,6 @@ pcie2: pcie@3500000 {
>> >> >  			#address-cells = <3>;
>> >> >  			#size-cells = <2>;
>> >> >  			device_type = "pci";
>> >> > -			dma-coherent;
>> >> >  			num-viewport = <8>;
>> >> >  			bus-range = <0x0 0xff>;
>> >> >  			ranges = <0x81000000 0x0 0x00000000 0x48
>> >> 0x00010000 0x0 0x00010000   /* downstream I/O */
>> >> > @@ -874,7 +872,6 @@ pcie3: pcie@3600000 {
>> >> >  			#address-cells = <3>;
>> >> >  			#size-cells = <2>;
>> >> >  			device_type = "pci";
>> >> > -			dma-coherent;
>> >> >  			num-viewport = <8>;
>> >> >  			bus-range = <0x0 0xff>;
>> >> >  			ranges = <0x81000000 0x0 0x00000000 0x50
>> >> 0x00010000 0x0 0x00010000   /* downstream I/O */
>> >> >
>> >>
>> >> I'd like to summarize the conclusions of [1] below. This patch breaks
>> >> I2C0, which is the only user of eDMA at the moment. eDMA is
>> >> noncoherent because snooping is not enabled for it. I have submitted
>> >> a patch [2] to U- Boot to enable snooping for eDMA. For now, this
>> >> patch must add dma- noncoherent to the i2c0 node.
>> >
>> > I have sent a V3 yesterday to set dma-noncoherent on edma node.  But are
>> you saying that the dma-noncoherent need to be added to the i2c node to
>> make it work?
>> 
>> I believe dma coherency is a property of the consumer, not the provider. See
>> e.g.
>> really_probe/platform_dma_configure/of_dma_configure/of_dma_is_cohe
>> rent.
> 
> You are probably right.  The provider dma driver only maps the MMIO register while the consumer i2c driver maps the data buffer in memory which needs correct coherency setting.
> 
>> 
>> > For the u-boot patch, I will check with the hardware team to see if it is safe
>> to set the reserved bit for edma snooping.
>> 
>> Thanks. I'm curious as to whether this omission is intentional or not.
> 
> I have asked around but no one seems to know why LS1046a is different.  So from your experiment, changing the reserved bit does make a impact on the final result?

Yes.

> And setting it together with i2c nodes having dma-coherent enabled make it work.  Right?

Yes. But I only tested I2C0.

> If that's the case, probably it is just a documentation issue that we should fix.

Sounds like it.

--Sean
