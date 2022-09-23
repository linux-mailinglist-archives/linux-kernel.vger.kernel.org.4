Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C7FA5E7FF6
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 18:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232596AbiIWQh5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 12:37:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbiIWQhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 12:37:36 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70042.outbound.protection.outlook.com [40.107.7.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F231314C9F0;
        Fri, 23 Sep 2022 09:35:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=md8Yxue+SO/L/5pmw9YmA4bkwoq6z/oZZoXXMrgjOZbtgbn/k5/jjjgkZbBFkP5M+tBO/SlzMfVEFbhf9aa2wOP2CAj7daGiciR5K3+2rHReSvnH97yfY9cr60vqSjtHpvlF7WhjVktiI2qBc2a0S8wZ5CLITcdedSB2OaXIY4NZr09ffJykwjCVSirjRziKJE1Tbmjx9+ZcPCRj9TYeIxCrKeXFuiVS3qzTGJzQM77qZplZrX7To42scQHMp/0/oaeM2HZ7E4vcYVJ3zki69CYOn+N1O1j2pLKzZCsMrac52rUDgfTXTMpEmLNzr6TqV722rZdbtPfa0ilHdTtrcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h8qvM2/fXIf3bkW58Qd44st1VcymDqprufHaShR5y0Y=;
 b=JprsVMf5ZmKojtEvFb+T2euTulf+WGAx/FgmPkiBeEAthMPNvUbTfchNTmbimBdiUdAMx1kfSJkbVTKdHv4fSJ3xnJIxD04/RM1hTw4eiUrBMNhONFIoIhLEIKG3TerGP9tlzcY2cyWgiL3sCgD8JTux3ScmnlX7aNtopZnLGcnJBbv20TWaEB7DMcDilpMZSeFH0d4viRQL+CJ3KqrhrEDvU4JqqNLsn6TpBfAYywXyfvIEZA9Xx3zu6bi81+aThaZBhpGiZ28qQcpCEsbbnBuLT1eYOgPMBVr83guvURMpAUDW4cXbk8gKjWoRygtr7ouje/+GV/ZqwkILJy8DXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h8qvM2/fXIf3bkW58Qd44st1VcymDqprufHaShR5y0Y=;
 b=0x8/29vCVAamWckrGYo07aHVyjHCT0kzpS0DZ9lQYIDW87+0XHuS+MyslS3QR3sEZ4LEoVrADmukwgU4tSz02Xhg0d2vjwPWkibhTkms2mQJUc52MFWWzlZXP5h86C3Se2cS17iBYbdz9CXJ+kj5HrfcZ2Radn6xiYTVryX3IQANf4v7MZng3b/35Mj0y/LMeCELrH/fv8NSOZk6vzRquf7oVJeZI0cob++Mzk0d0eCZaT0BmbuWOM0KAnVYqCGd8CYx5LVLNI8JjpKsIV1ArMPp6QtSMMDaYwd1gOjCSuBDZ0JOjC2bjfqi/XW7wxk08GKsj+ZL8RBS/jZ9UZ6+Rg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4972.eurprd03.prod.outlook.com (2603:10a6:10:7d::22)
 by DU2PR03MB8123.eurprd03.prod.outlook.com (2603:10a6:10:2f2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.19; Fri, 23 Sep
 2022 16:35:04 +0000
Received: from DB7PR03MB4972.eurprd03.prod.outlook.com
 ([fe80::204a:de22:b651:f86d]) by DB7PR03MB4972.eurprd03.prod.outlook.com
 ([fe80::204a:de22:b651:f86d%6]) with mapi id 15.20.5654.014; Fri, 23 Sep 2022
 16:35:04 +0000
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
From:   Sean Anderson <sean.anderson@seco.com>
Message-ID: <1db9ffaa-3c93-9e09-8966-73aba061f52e@seco.com>
Date:   Fri, 23 Sep 2022 12:35:00 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <AM0PR04MB6289919428F12CD125357D4F8F519@AM0PR04MB6289.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR03CA0094.namprd03.prod.outlook.com
 (2603:10b6:208:32a::9) To DB7PR03MB4972.eurprd03.prod.outlook.com
 (2603:10a6:10:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR03MB4972:EE_|DU2PR03MB8123:EE_
X-MS-Office365-Filtering-Correlation-Id: d397c17a-62d1-4a81-8863-08da9d819181
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eUo+jRIz7kY+lv0LpGBSzY4TUIP7QZejdtRqE8bh7aBbjpzG489IpCZqfqadpvMI28nxbogHMnZHz4NNJf9GJC74hlL/Ok1uAlUL/LqMIzMqXErV+FZ2Ibj1yrLUcRDDQrezxdNgBdSEcEMoqktVjg4+qDcbNI2I3F9rli4KIqd6GTYpACvFO5YOd3M7Q0sNDiCufpW8cbdotfB5aB9e3gKiPmmiEazPiy+fLBw8/fcpdYh4D26KG/5XgpQEkM+LuCn91/DEzVUky+XqTr6jLPL5btGE45kgIC2jFcV2hlhF+RltJ6UhwFpNmGhAyt+dlqiDLQybysoeGcSbMXXYtHvQUm9yvQTFkKS7pARKv9Itor2Q+jRzVlKPW+TOxwblFFei1pKzzKnlDesW/5suTfXPwUCbd+uy4GihUV7kh7P5SQcssie6Hio43ETcllfLw9gIQCfJbVgI96oVMCWPqJLGSBf30RMNIVJGofcVfH9QohsdJy6wx+CFUeEP+cTztD25OLOIwlDbyI01poTeHSejI9uAOmRzD48IfeMQ7D2H11Sx11oMz4sEP579pbKtOfwa7dWTEPh4C5qtVfylgmgJqh5o/x5lINA3Dd+EINIK1gjq3jejiNp8gjov+5gxuNfWLjtQkBPdOw+lQk9PBXrgSGFGmODwKpIp+f6DYWt9mBl52VicnniuIwzHxJ34yT9lAJtjGtH5kL0lssgSCCmScGk8PZxpC/TCv0JybUt1KQqvB9ea60TYyf32bnJIerAz0edpGPjMn4O7g1yZYwMHRp3Bj9M2R4M0uZuEsybNnmRx7f5miT8Pwxn/cfvCIupzv1XjFCrbDIRFrMjBEg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4972.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(39850400004)(136003)(366004)(346002)(376002)(451199015)(110136005)(316002)(54906003)(66946007)(6506007)(83380400001)(478600001)(6486002)(2616005)(36756003)(38350700002)(44832011)(6512007)(31696002)(2906002)(5660300002)(8936002)(52116002)(53546011)(26005)(186003)(38100700002)(4326008)(8676002)(66476007)(6666004)(66556008)(41300700001)(31686004)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M0Q0aTF4WmdodDVvT24rZjVQNjRzRlh1dGdsbkZmaDBSQkdPbGJBQjlJbzBZ?=
 =?utf-8?B?VmJlWS9Ud3U1K3FjVTBFTmZwMmU4SXhmOEllZTdWN3BxN1Bzajl3Sjc3Z1pu?=
 =?utf-8?B?L2UwKzc3SzhxZW9obUFMMlBkRndaVk53R0tBUE9EUjFCZnZTN1lpMXRVaC9D?=
 =?utf-8?B?Qlh1YVJoeWkvY3hxK0RQNWhxd2pjNTBxYUhYaTFUK3JETWxYME41aFFEU0ht?=
 =?utf-8?B?cUZIREpwa0EyTzdrSU8xemJ3dks0TS92TWFuWUM2TUZYNHJycVVxY0ZqMlZW?=
 =?utf-8?B?NlIydTVIdi9vdmluOGhnOGg4QjNwNU10ZnB5VmU0eGhvTmVkNzJMVGVIMWh2?=
 =?utf-8?B?dFptRml6N3lUVUw2VjdBMklwKzBpclRVb2czQnBIeUE2UEE3MjhNRWQ3TDhY?=
 =?utf-8?B?d3FCTGw2UmQ2eXFodEF6R211RERxeUwvMHJYSTd2WWorWHlmRGszMXF4WUhR?=
 =?utf-8?B?SGIwMmVYN1JjR1ZvY0hTbHFBWmgzZVczVjFPY1ovMlNXVHlvN0o2Q0JtY0V4?=
 =?utf-8?B?cjFRcWlSMXpBdmxOeXVkQ0hEbmluS2lDUkxlNGlua3M5NjkwSjZlK3hyUnhP?=
 =?utf-8?B?dVdobzhmTktCb0p2VTF2Q0cvM0RTczlvUXMzY3VCZVhrVk5jdWt5K1YwWHNK?=
 =?utf-8?B?R0JZMy9lclpOcmJNOVNMNk4vSFFiY3JDaVZCN01ndEtrTVJtRzhkaW1tV1Fp?=
 =?utf-8?B?V2ltdmplZ1BpUm04RjNRcXR2SU40YXlLMWVwQWZOaTNQMVFqWC9pUSt5YlVK?=
 =?utf-8?B?aEJTSnJVc2xJaHlIMURFUWlEMWZsRXhxVFFLWUpFVmxSZmtSeTdaR3NCcTcv?=
 =?utf-8?B?T2xuSjZodnJwWWtKbnN1TVBDOG5GbG9oNmxVaGtNTTJhNGFWaFZRclFZK3Fs?=
 =?utf-8?B?VS9HQTkvOFlLUDNwcHZoUHFQUXNVS2FnL29SOThSVTVvdjdzWkVXZXdwYXZJ?=
 =?utf-8?B?ZzVaMFJzV1RXM25obHhWaUg0eExGbUVHcWY0TVBTMU85Vyt2aTlNenFMdGp0?=
 =?utf-8?B?TEFKL2ZzZnFlQ2RjMmpSY25zUktoYjlndDdPWXZNVlhtRUlQbzAzNGpqcUlO?=
 =?utf-8?B?RzN2bE9YK0RNakMvcStIRno2Q3BYNC8vTjQvQjNuRkwrTzZoTEh2UVJvMVFr?=
 =?utf-8?B?cWNjMmRQUzJGSCswNEoxZHJTNDdsVVhFNkxOOWRHZTFzTnJic3J5WkN3S3Vv?=
 =?utf-8?B?WXBsZTZmbU8zbTIxWEsrejBERjBTMzNoTzNDK2NJT3I1RmJlMVlBbTVjV0Nk?=
 =?utf-8?B?VkgrNml6ZkVwbnBJU1VxaHl6RldreHpYa0xjV2VXcXFmTk0rRmFuT3gvZzVp?=
 =?utf-8?B?RmdvMWpuUjJBMFJxcFo3dWtsbnR6NWhCREF6MDBjYm1OZW9pbWlvUm12bFMw?=
 =?utf-8?B?UXdYNFhjelJIL2JvQ0d4bk9INkVnRHdocDdmeWFlR3M1eExxeVdkdnM2eU9Y?=
 =?utf-8?B?R3lYdFhQQWJDSEFscncyczMyOGZ6bVF3SDNxUVNFcEVObXlCRmJNVXBnWExr?=
 =?utf-8?B?THNmb0tsTEhhdDNIbEo2UXYzZVl2NFhQMzdZb3U5WXNxNnZuSmw1dWw4eGcx?=
 =?utf-8?B?cUVPRUJHNXVvL2g0eHZHWFozMnY3cmlCVXZiby92Vit2bDY0V044cXRsN1c1?=
 =?utf-8?B?Y0xYelpBclJzNDh4ODhNOGRQemFRQU4yODFOa3F1TzdMWEZGVlVySGhrV01B?=
 =?utf-8?B?M3NoUVZSaklkQm0xYzR4MkRIamo5OXBCbUlNQlg1NGl1N2w5R0ZFOVltT3pm?=
 =?utf-8?B?M3RBZGVrSktDMHZEMHhmTXUzaXNva25uRWZ5dkNGN3dldkdXR2VxeG5mUm1D?=
 =?utf-8?B?WWJGYWdhdjR3SzZuRmN0dUVBbFNFZFR0a2xTM3o4UjJGdXJQaVVndGZlQUMz?=
 =?utf-8?B?T3pGMGtPUXV2aG83K0YyWkN5M2IzYjNHb3dVTngzTklRUXdlSzh3YnBLNTBC?=
 =?utf-8?B?Qi9kSGRkV2RYZEtBckZ1UWtlMGRTL2E5bWdmNklzd3FPM016a2ovclU5NjQ2?=
 =?utf-8?B?d2NobFB0OXVHMDFuVGtsZVp2RnBjSk5hNkVEd2ExWGF5Ym1MZ0R6OUNVcWhr?=
 =?utf-8?B?b3lwY0dwTHdZYWlKV1BPQ0NzZHZEc3NHQXZ1QVBDOXJSTGEyRzNkeXVIUCtn?=
 =?utf-8?B?c3Y3dW1EN1JMTVFVUWVYVFNseGVLN0FaaUpJell6UkYvd2xNTmM4WEFhMU45?=
 =?utf-8?B?THc9PQ==?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d397c17a-62d1-4a81-8863-08da9d819181
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4972.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2022 16:35:04.4967
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fCffODS3kAaFCcpk/dbTTbiXc5DwM5GXf8CSQ9AVEoUTexRfLZJyIYl3PoDPTv557sCFdFX6zWGZ+zQ11VNBrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR03MB8123
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/23/22 12:26 PM, Leo Li wrote:
> 
> 
>> -----Original Message-----
>> From: Sean Anderson <sean.anderson@seco.com>
>> Sent: Friday, September 23, 2022 11:11 AM
>> To: Leo Li <leoyang.li@nxp.com>; shawnguo@kernel.org;
>> devicetree@vger.kernel.org
>> Cc: robh+dt@kernel.org; linux-arm-kernel@lists.infradead.org; linux-
>> kernel@vger.kernel.org; Laurentiu Tudor <laurentiu.tudor@nxp.com>
>> Subject: Re: [PATCH v2 5/9] arm64: dts: ls1046a: make dma-coherent global
>> to the SoC
>> 
>> 
>> Hi All,
>> 
>> On 9/15/22 7:34 PM, Li Yang wrote:
>> > These SoCs are really completely dma coherent in their entirety so add
>> > the dma-coherent property at the soc level in the device tree and drop
>> > the instances where it's specifically added to a few select devices.
>> >
>> > Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
>> > Signed-off-by: Li Yang <leoyang.li@nxp.com>
>> > ---
>> >  arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi | 5 +----
>> >  1 file changed, 1 insertion(+), 4 deletions(-)
>> >
>> > diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
>> > b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
>> > index 27033c558e3e..e406499a26b4 100644
>> > --- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
>> > +++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
>> > @@ -273,6 +273,7 @@ soc: soc {
>> >  		#size-cells = <2>;
>> >  		ranges;
>> >  		dma-ranges = <0x0 0x0 0x0 0x0 0x10000 0x00000000>;
>> > +		dma-coherent;
>> >
>> >  		ddr: memory-controller@1080000 {
>> >  			compatible = "fsl,qoriq-memory-controller"; @@ -
>> 355,7 +356,6 @@
>> > crypto: crypto@1700000 {
>> >  			ranges = <0x0 0x00 0x1700000 0x100000>;
>> >  			reg = <0x00 0x1700000 0x0 0x100000>;
>> >  			interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
>> > -			dma-coherent;
>> >
>> >  			sec_jr0: jr@10000 {
>> >  				compatible = "fsl,sec-v5.4-job-ring", @@ -
>> 794,7 +794,6 @@ pcie1:
>> > pcie@3400000 {
>> >  			#address-cells = <3>;
>> >  			#size-cells = <2>;
>> >  			device_type = "pci";
>> > -			dma-coherent;
>> >  			num-viewport = <8>;
>> >  			bus-range = <0x0 0xff>;
>> >  			ranges = <0x81000000 0x0 0x00000000 0x40
>> 0x00010000 0x0 0x00010000   /* downstream I/O */
>> > @@ -834,7 +833,6 @@ pcie2: pcie@3500000 {
>> >  			#address-cells = <3>;
>> >  			#size-cells = <2>;
>> >  			device_type = "pci";
>> > -			dma-coherent;
>> >  			num-viewport = <8>;
>> >  			bus-range = <0x0 0xff>;
>> >  			ranges = <0x81000000 0x0 0x00000000 0x48
>> 0x00010000 0x0 0x00010000   /* downstream I/O */
>> > @@ -874,7 +872,6 @@ pcie3: pcie@3600000 {
>> >  			#address-cells = <3>;
>> >  			#size-cells = <2>;
>> >  			device_type = "pci";
>> > -			dma-coherent;
>> >  			num-viewport = <8>;
>> >  			bus-range = <0x0 0xff>;
>> >  			ranges = <0x81000000 0x0 0x00000000 0x50
>> 0x00010000 0x0 0x00010000   /* downstream I/O */
>> >
>> 
>> I'd like to summarize the conclusions of [1] below. This patch breaks I2C0,
>> which is the only user of eDMA at the moment. eDMA is noncoherent
>> because snooping is not enabled for it. I have submitted a patch [2] to U-
>> Boot to enable snooping for eDMA. For now, this patch must add dma-
>> noncoherent to the i2c0 node.
> 
> I have sent a V3 yesterday to set dma-noncoherent on edma node.  But are you saying that the dma-noncoherent need to be added to the i2c node to make it work?

I believe dma coherency is a property of the consumer, not the provider. See
e.g. really_probe/platform_dma_configure/of_dma_configure/of_dma_is_coherent.

> For the u-boot patch, I will check with the hardware team to see if it is safe to set the reserved bit for edma snooping.

Thanks. I'm curious as to whether this omission is intentional or not.

> There is a problem with this is that it breaks the i2c for older u-boot.  Probably the best way is to make the default to be non-coherent in dts and update it in u-boot when snooping is enabled?

Yes, that is what I propose.

--Sean
