Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9956260730B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 10:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbiJUI4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 04:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230309AbiJUI4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 04:56:03 -0400
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2076.outbound.protection.outlook.com [40.107.103.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BD7ADB771;
        Fri, 21 Oct 2022 01:56:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IrsQa6D7uNPMi3n74X9eNo7mGWGS/0y/zoUCp/XKZBvTd5tlHm3Bd4reCdkU3ykwSpCT+UNOS87/+Ve+bCWX7z/7r/eHliTeZf3nK+CUnTWiddQJg+mzfCLo1vbZUbnEQesKf+t4SoUiAIC2kUqv4CqthMXnrS8PSEXwT7S4SnSlFZpd22GCYyHj7Osh19DecGpfoJyaskaTsApoolWF2RIE4Ox8al8yUhHJ3D9VzIaB73tGM0ZZaTBORmPna7987qcflVLa9EbJYQB0R/RDF0A4GXlbEq/+AceYMKC7aJyhm/DhuRvyAJgCgsK3DNWxyrdNPSaFMau55Zt43QlOZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zqdQ/7JpvBzQ6+Q+K0ikvkATlEW8AHshs1eM95l0C5A=;
 b=EoCJSHJ7AL4JHnNG54JWYUK1mCH0EOBrnIt8xIqzr6sX8fZ1LRimk9lmptb7oPsnvr6zewL3GWogHQx9HGAwf27sQoW3/AKNuDFYN/HmTlPoHfMCI39437U1RHs/l/ZcThBPO6fQj5QrgWZS3Ovmvphgz/pbos/OmIp2u6rGVwIsX7Nc7jxgCsJZUzyJm4g13t+cEdtA3J74AuNeLM01B09wFiTZdWRAz44vzc8C3AVmR8jTz5t8Iw/EoIP29vBgUsJ9h3I2TJQqlHtZNWQwmKoUCaq9M7kRWD/GjBSrQvzNYWetfLLCbN6mWE087AxAiFTBoutmibgGswgtwKVWog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zqdQ/7JpvBzQ6+Q+K0ikvkATlEW8AHshs1eM95l0C5A=;
 b=eZiYtkgy323uMXNanroh8k1yCB8/y/lu2dNmmogco8to7Km18ZcWIieJLvvDj8I3DKm7vtavZJnyKALrVbpmM9zhn7LZzsci6BY0USjC26fEyec6tTItADLqRUuylvIP2VMRErYcKAMYqr5f+0w7FyCoMvy9aNiuTvE6htzL0PA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VE1PR04MB7294.eurprd04.prod.outlook.com (2603:10a6:800:1a3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Fri, 21 Oct
 2022 08:55:56 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a5ff:3d28:4bbc:e1ed]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a5ff:3d28:4bbc:e1ed%6]) with mapi id 15.20.5723.032; Fri, 21 Oct 2022
 08:55:56 +0000
Message-ID: <7ede9de4-75ba-6ebf-60a3-fee98e050ea9@oss.nxp.com>
Date:   Fri, 21 Oct 2022 16:55:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0
Subject: Re: [PATCH 05/15] arm64: dts: imx8mp-evk: enable uart1/3 ports
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de,
        devicetree@vger.kernel.org, Peng Fan <peng.fan@nxp.com>,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        kernel@pengutronix.de, festevam@gmail.com,
        linux-arm-kernel@lists.infradead.org
References: <20221020095934.1659449-1-peng.fan@oss.nxp.com>
 <20221020095934.1659449-6-peng.fan@oss.nxp.com>
 <20221020110723.udftsfrfdnghudto@pengutronix.de>
Content-Language: en-US
From:   Peng Fan <peng.fan@oss.nxp.com>
In-Reply-To: <20221020110723.udftsfrfdnghudto@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR03CA0111.apcprd03.prod.outlook.com
 (2603:1096:4:91::15) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|VE1PR04MB7294:EE_
X-MS-Office365-Filtering-Correlation-Id: e1925487-6861-40fc-257b-08dab34210c9
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2knkef3emZIYfk11qGtX3Su9vB6Zr4OqiOyoMkG+HYcMxzg9HXiPU7Fxp1gO4h9S2hcbGHjbXMoXgqsgWr4k5B1SWtm+5YHIQyNLLrGwBP7TxZyIzYmicU+gcqCaKmswDxjQQDEd9peRZG4uR2RI85iM7Xla3UocikxQm+OToNJ092AoHmLrQxbMp8f5X9VLpGVME2fx7uDpB5ZJOXxvZH7OorXL1eEl3QbehVKJzHFT8hw1EU7+NXqhdyW8eNrjEJYxRQexLy+hnCF0m6iCydNYjzL3hAAoT91QiKjKM8zBMojsSzS8Mz688qPBI/y/mgLEcMeKvY65SiDOGspPdtvu62fNnAGttVvSrN4KUM2t8AV3gTjSZSbfqT4pOOTdXH/MeNMboxPL8RVsBj7DLBVH3wP5FGeXIojZOSdMCr2BNls26UP7eTk4PX3sBOrmHkSi0cL4IFnO902nhvevj6lqGgNkMfFmEnsQKgGg1yD74iO/c85CyKUK5yo4qKDrGr1pUpyFArxGXrC5t+0Bc3YpUYu2d5HC+8WEE8qmKKxA1Lvyrc0sqvchjGXI3BqguLTulDFIgTBsOW5xkhSuvkNkm/r/oRWxn/LcbUreL+F2f+2pWuhvk/Q2y19Tw8QbfAiu09HRH4Eug4ek8cgT9drV8p2koZYpSOCt838EtwYMRAzJpiTnKv1z6gfB9bVma2oZAFuUXxM0lhIiJCsdf7sfTNwNCHhNufjkUdcOCjItBbEfvkNZIk3pSPckrRWknpNrXw8wmMG5YiIHdhv37Qmep3VP3Tg7sO+BrsQLnHlMYomvESHNsdKmbWsg+30lo2YHzjav1raFdkHTQQeGGJaGYxivSGJsHfXTcFw09xvR70UAc1boIZVaMebTPxWh
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(39860400002)(396003)(376002)(136003)(451199015)(86362001)(44832011)(6916009)(66476007)(8676002)(66946007)(66556008)(31696002)(5660300002)(41300700001)(4326008)(316002)(6506007)(6512007)(53546011)(83380400001)(7416002)(52116002)(26005)(8936002)(6666004)(31686004)(6486002)(38100700002)(2906002)(38350700002)(186003)(2616005)(478600001)(32563001)(45980500001)(43740500002)(473944003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZFlvYzhlUDJOdjFIcENxbEVXYzc0ZWRicWh2YWh1SENPTVU4NHUvWmNUUGUz?=
 =?utf-8?B?eG0vS1YwTFFYcjgvNHZWaWxjOEFaUWIvZWdabVJDR1luRno5ZEh4cjYyWm1N?=
 =?utf-8?B?TlVybFJQR095VlphUEcwQTZ4aWcwTmcyM2toZFlJUG9CWjJIeUkzdkFsNmFi?=
 =?utf-8?B?dFFJd1pSMEF3YVZQeUhqdlo2QmlJQUw4NVVMYWk3KzZPcDJqbERTdGJkaEVq?=
 =?utf-8?B?YWtnQjQvKzZ6bWRZejREa3laTy9teWFQZWpudmRKUEY5OW1DSHF2M1pBU2lt?=
 =?utf-8?B?VkJKMURzK2VUK25RNWJtNUFQRldkTDVVQnlIajZMdTRQdWtWMHdnYTJncWhw?=
 =?utf-8?B?MHR6dG03ZkQ0bTRXcnpuMVNJcXdGYzlFbkxnTW4yTzBvaGtPWkhmNlhNczB4?=
 =?utf-8?B?SktvWGFoblQ3eTRvcHZncVpKOTdqbndldFpTUytZWWhwV3UyZ0ttVHg1Njh4?=
 =?utf-8?B?VlVKSTdYaG1JZ1NKYTBiMlpHZU1QY0k5UEZ2aXhvYTQ5cG15MjJlK2lwamhx?=
 =?utf-8?B?bHpEWWxSSFVyK21mazFlb2kwSU9ZOHFvZEg1dHRXMU1YTUlLa1g4S0ZwMTJR?=
 =?utf-8?B?NDBWTUNrWnNtZUtSa3V3dzdHS0daSHBQVzdSVWljZk9pTW9QMzJaZVR4NGxh?=
 =?utf-8?B?S2Zva2pCWkc2R2dxRjlqamtORlpVWGpRVU10cnFYY04yNkhGZ3Mwb1l4WDJs?=
 =?utf-8?B?Y0VWMmpoUnZDMmpTeVlDUTNKR0NrbE0zM0xQTXV3K1JpUnRyNEpOSjgvQ29x?=
 =?utf-8?B?SzFxWXQ4QitWWENqWWhnbE9wbXhNcmUyamJBTDYzbkg4Q0g0ZG1sVDUwZnZi?=
 =?utf-8?B?bnNEQmppMjRKckRsK1pQVzd1Q1kyOWIxNjF5TGgwbGtnQ0FkVHRCZDVLY3lM?=
 =?utf-8?B?ZWlSRzdxd1I2Ykg5ekxpelByMjF3MjhHRUdldkd5NFN2T21JODZYc2Z0ZHhp?=
 =?utf-8?B?dnZkSkJodHMyTEkremlyMzdzdFQzaDFUYWhhQVFJazFTQ1Y4MEgySExWRnVp?=
 =?utf-8?B?b2tnQzZQZWt5enBROFpPanhyTUVxVnRod25ZRjBPNXMxeWhMNWkvNTJMb2ds?=
 =?utf-8?B?ZlB4OXRuRXdlOWs3STRxemNpd0NFZXBpTTNPM2NUZklidHUwRDl6eWwwRHJx?=
 =?utf-8?B?a3JDWDVoWGNNMnByWXVTdDJxb1lHay96bnRqeW5ldjVrUm1XOEJQQ09TYWVB?=
 =?utf-8?B?L0hFVTZiRnJuc05Qa2NhM2QwSnFtT2R1NjExMWFZdXF0a280S3IwdkZXQkhP?=
 =?utf-8?B?SWoxZ25KRVVsclF2d3djOTlLVS8yRFpCckk0SjZuRG1JU01FOXJCZmdVU3Bj?=
 =?utf-8?B?WElGUFE1aHFUV3NrU3RpSVMweERoSlREQklacTcyNzh3ZHdjclBOSWxxRlJC?=
 =?utf-8?B?VUNidkpDUnF1MWxsZDAxbTJ4bUtDTVNmQnVOR2ptdEwzK0RGRWl4UU1vNmY5?=
 =?utf-8?B?cU5GTTJKMWR0YUlNemNWcWtHemJvWDV6WnZZenBGSjNmZEYxSUMvRmk4NzJz?=
 =?utf-8?B?d21ubVFmTzFCdHRZNFI1VmNaVkdFYkYyckZYVlhWVFJuekpnSW1YTE1pWWJh?=
 =?utf-8?B?MEJWV01tN1BJUVA3bUhmMGtlMnQzaWxtL0VNaHZYbUlCVnlZdkZMbndVLzVD?=
 =?utf-8?B?WHAzRGpmeFhFViswNzlKZW1aNEs0cXN0elVWVlFXS1pveFF3aW1vdkxVUWlw?=
 =?utf-8?B?ZlI5eTFGVlJUNzRZN0ttcVZWUDUyMGtvV2pGczFpRnBNbEJHUlBPbDN1dEF1?=
 =?utf-8?B?OE1RcVpaUXNHcEpCMkVSYU9UZWo1aXJRNjk4TjRJUXhUMUo5VHRnVTZNSXZP?=
 =?utf-8?B?YThVaWVYUUJNR1dRY1A2TzlRMXJlWnBoZEFGQlpXdU04M1BXbTBhY3Z3VGV5?=
 =?utf-8?B?WGxrdUhDazF1MldZNW9xbmhObDhqVEdqeWVaUHJOc2V0S3FWUGtEYUNBNDVv?=
 =?utf-8?B?QnZLNFhEbkFCbXFIZVF5MkRhTXRrdGRLbXJHRHQvL2VjYThnZ1Y4bG5haWRC?=
 =?utf-8?B?SXZxMW5TSzVzUzBtQWoxSnIwTmNNd3AyUWwrZlVmdStYS3E4MzVVbTQ0MHVu?=
 =?utf-8?B?cVVGZHpMcXArdGV4V0RzQzhoaWdaQmFDM3huaWhvK2xicmpYWnlTMFVzN21u?=
 =?utf-8?Q?Kn1X3tlOvgYIzuW20p2s+eG9M?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1925487-6861-40fc-257b-08dab34210c9
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2022 08:55:56.1708
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pLsD9WDRJCEuB+dt9fkNxf5s7rwoJbBSVxIWZbkp1YxsyaheFBmBdlei7rGCcpem1oj80hGGUj/qR2hG0rq6pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7294
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marco,

On 10/20/2022 7:07 PM, Marco Felsch wrote:
> Hi Peng,
> 
> On 22-10-20, Peng Fan (OSS) wrote:
>> From: Peng Fan <peng.fan@nxp.com>
>>
>> Enable uart1/3 ports for evk board.
>>
>> Signed-off-by: Peng Fan <peng.fan@nxp.com>
>> ---
>>   arch/arm64/boot/dts/freescale/imx8mp-evk.dts | 36 ++++++++++++++++++++
>>   1 file changed, 36 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
>> index 2e29bb3c041c..366f709f8790 100644
>> --- a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
>> +++ b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
>> @@ -428,6 +428,15 @@ &snvs_pwrkey {
>>   	status = "okay";
>>   };
>>   
>> +&uart1 { /* BT */
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pinctrl_uart1>;
>> +	assigned-clocks = <&clk IMX8MP_CLK_UART1>;
>> +	assigned-clock-parents = <&clk IMX8MP_SYS_PLL1_80M>;
> 
> I'm curious, what is the default parent and why is this wrong? For the
> already exisiting uart2 we don't do that. Same applies for uart3.

The default parent is OSC_24M. The uart2 is for console, so 24M is ok.
As I recall, we met issue 24M not able to get higher baudrate.


Regards,
Peng.
> 
> Regards,
>    Marco
> 
> 
>> +	fsl,uart-has-rtscts;
>> +	status = "okay";
>> +};
>> +
>>   &uart2 {
>>   	/* console */
>>   	pinctrl-names = "default";
>> @@ -450,6 +459,15 @@ &usb_dwc3_1 {
>>   	status = "okay";
>>   };
>>   
>> +&uart3 {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pinctrl_uart3>;
>> +	assigned-clocks = <&clk IMX8MP_CLK_UART3>;
>> +	assigned-clock-parents = <&clk IMX8MP_SYS_PLL1_80M>;
>> +	fsl,uart-has-rtscts;
>> +	status = "okay";
>> +};
>> +
>>   &usdhc2 {
>>   	assigned-clocks = <&clk IMX8MP_CLK_USDHC2>;
>>   	assigned-clock-rates = <400000000>;
>> @@ -625,6 +643,15 @@ MX8MP_IOMUXC_SD2_RESET_B__GPIO2_IO19	0x40
>>   		>;
>>   	};
>>   
>> +	pinctrl_uart1: uart1grp {
>> +		fsl,pins = <
>> +			MX8MP_IOMUXC_UART1_RXD__UART1_DCE_RX	0x140
>> +			MX8MP_IOMUXC_UART1_TXD__UART1_DCE_TX	0x140
>> +			MX8MP_IOMUXC_UART3_RXD__UART1_DCE_CTS	0x140
>> +			MX8MP_IOMUXC_UART3_TXD__UART1_DCE_RTS	0x140
>> +		>;
>> +	};
>> +
>>   	pinctrl_uart2: uart2grp {
>>   		fsl,pins = <
>>   			MX8MP_IOMUXC_UART2_RXD__UART2_DCE_RX	0x140
>> @@ -638,6 +665,15 @@ MX8MP_IOMUXC_GPIO1_IO14__USB2_OTG_PWR	0x10
>>   		>;
>>   	};
>>   
>> +	pinctrl_uart3: uart3grp {
>> +		fsl,pins = <
>> +			MX8MP_IOMUXC_ECSPI1_SCLK__UART3_DCE_RX		0x140
>> +			MX8MP_IOMUXC_ECSPI1_MOSI__UART3_DCE_TX		0x140
>> +			MX8MP_IOMUXC_ECSPI1_SS0__UART3_DCE_RTS		0x140
>> +			MX8MP_IOMUXC_ECSPI1_MISO__UART3_DCE_CTS		0x140
>> +		>;
>> +	};
>> +
>>   	pinctrl_usdhc2: usdhc2grp {
>>   		fsl,pins = <
>>   			MX8MP_IOMUXC_SD2_CLK__USDHC2_CLK	0x190
>> -- 
>> 2.37.1
>>
>>
>>
