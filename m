Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E349F74D3EC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 12:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbjGJKx6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 06:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbjGJKx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 06:53:56 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2086.outbound.protection.outlook.com [40.107.96.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 493FAB1;
        Mon, 10 Jul 2023 03:53:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kcGrVs/mRGEASESWb9escYypwIRsZKq/GApiBQ/uAvvcfYE4mPdBnFGWd45xj2WKWoLHGJkYI2XG7y5JxaiHUTcAWC5K7ACvz/8J1QnweTqGeRAp1a8SrbrBlL3XwyC+5t6fjDKJyx+aSdDzBsg2mEC2qfDCN50iRgTatLB96DrzRlvWizSaCdK8GVW+vHPrBeJrGd+8jgRJ0q1BYYxaLyZ/uyncw9PkOEd8yZu4hS1NfdfMPDMS9CI56SzntnokGeCBOo/cBhQsarE1i0horRn2GybtqGDionRteRUwmy2xXVh2HSy96cXGbYbVEMK129IHPuvuTP687PWL0zcFuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=25RgZ0RpUmZopFEx0k+0WFjBdVyXVC9kNAp+/FGUWkk=;
 b=FmXMRtWemf29K79uT+7+mcEsx0Wi/kry2mDTucyWiVCoaC5euh7gx6cYb9gNH+SBtf2ji1Io9KGDNFhnSBCuWOg1YXjB7SLUQysNMNHvOsv4VjuZ/T+SZgeIBjMTg2KblsG4jRFUlfM6BU4AUKiXe0EXpCi5wpP5QM8kuYdBAogxSMKjZx1TfknXqGcOHbmdPEt5ruCFgLfT4SYYyuwRdSiAiY/F8GsWzEIcGhcDHW5hJ1cv8luxXwly6Ta9VXdfUMPpT5PcZ8fQ02MIlr41wMyhLWz7eORCtFFGdRKETGyCza451hoPeBpFHX+hEBL7FF1PvsQqL075h9LBkcWDgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=25RgZ0RpUmZopFEx0k+0WFjBdVyXVC9kNAp+/FGUWkk=;
 b=0+G9GJAdO6kSbIjSVsVeOrExRabFBiZRQGBHgt6NKj7sP3FiyfJdAIussd5HDAYuX2a+Qu6yz9HePVcLT6C2Enh0DxwTSySeAwsOsZxkpzSEkr2NCOjw+aWm86fZRJuqZI+MqlwvZ4QFFocHBNGvA0ns0bTo0ENxlAdxKD5rA30=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by CY5PR12MB6345.namprd12.prod.outlook.com (2603:10b6:930:22::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31; Mon, 10 Jul
 2023 10:53:51 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::bb94:8eb4:943:d955]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::bb94:8eb4:943:d955%7]) with mapi id 15.20.6565.028; Mon, 10 Jul 2023
 10:53:50 +0000
Message-ID: <6eff3085-ce81-06ae-f251-f9afc66e59e1@amd.com>
Date:   Mon, 10 Jul 2023 12:53:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com,
        Conor Dooley <conor+dt@kernel.org>,
        Harini Katakam <harini.katakam@amd.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        Parth Gajjar <parth.gajjar@amd.com>,
        Piyush Mehta <piyush.mehta@xilinx.com>,
        Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
        Rob Herring <robh+dt@kernel.org>,
        Robert Hancock <robert.hancock@calian.com>,
        Tanmay Shah <tanmay.shah@amd.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <6544d13afd9f3d8f5413e32684aa16e4d155e331.1687160244.git.michal.simek@amd.com>
 <20230621141307.GC18703@pendragon.ideasonboard.com>
From:   Michal Simek <michal.simek@amd.com>
Subject: Re: [PATCH] arm64: zynqmp: Fix dwc3 usb interrupt description
In-Reply-To: <20230621141307.GC18703@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0094.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::20) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|CY5PR12MB6345:EE_
X-MS-Office365-Filtering-Correlation-Id: abec5731-c27f-4fba-0e59-08db8133f1bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +qkYizpMxGx71QPpQwXciu42eKRe/SZpTjc059Fo2NS7FFPBKZfv46x4eYXYSh5jVw2GKEu5uf/Tc7GMpa+VGrJkyKEqxVQ3TidfLTnTKazNruJ0GBRdIt10xJJDMIpOKO7CLXwOh8rdnhFzgw8fTRc1tK/eli9t9NUEv1TP8pXJc4fpEdORjzXPgTG9WpgiEJcRjr5nWAtn1fNBSmk2iRKxc2h99eVp0OinU6/iw59lIWLiGRJe/Lq3LmfCsivGJei4iFyvqjykHnko4lmQ697voXTuKd9deuhjygsTgsOAFduHlDMjtqhUVy/dMnyhaAjL4o3R6uvX6XTPXztlCrr7FGQoBZ2MJFISXQWxL21z5xbmulMlq+hW1SqxAOMeMj6EYOmyuiZMv8wDW02Y1Ne2JmFT2MZLcaCxSL4YWxDieUpAeIq2tRjKEOAGEDf/eXjfbA+tfFmKHEaM5z9vK8uY+U+cXEB2W68w/mvnQENsQ3cjJyNI0hcBezt4+XwE4Se5wsNYuXf0/x0/ofEEGM+FiSdMG0xMkgor8FcNuV7LvQ7idtWKrEM/a9RaU7FsQc0gE/4qHDohArX88jkbbsGkxPd7KpirBraybJAnsJ/g0KRrvuMBPcT4z8Dno0thbUn46oihoIVg+ey9Wa08mQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4758.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(376002)(366004)(136003)(346002)(451199021)(44832011)(7416002)(5660300002)(8676002)(66946007)(66556008)(66476007)(31686004)(8936002)(2906002)(316002)(6916009)(4326008)(54906003)(6666004)(6486002)(6512007)(966005)(53546011)(6506007)(26005)(186003)(83380400001)(41300700001)(2616005)(38100700002)(478600001)(36756003)(86362001)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SmtaQTU3YkgrUFJIWG5vcWd5Q0lwWHBFd2VTYnZYQXBQWGtLWnhBdXY0VlB2?=
 =?utf-8?B?UVRDZjFtbEkrbFdtYjBVaFBaZEJjRFA1amxQMit1Y3h6bUU3b0ZGQUNHK2tI?=
 =?utf-8?B?QlhIUC8wTE9ZNXFwT3VLTTgwWHZMTy8wNldySjRRTjh4dndKWUtvRVBuMXc5?=
 =?utf-8?B?a2wxTE4rTVlDaWtJcUtKRjdCT0crVXprZ2wvVW1LRDhFbGU5WHg2VFFZWk9K?=
 =?utf-8?B?L2V6dHN1eW1kVmNmUVVoZ2VUT1lBMlBmUWNvWWJnUnMvNktOeXl4Ky9PUE9n?=
 =?utf-8?B?VkpILzdXeWlyNjBreHp5bWFtaTFGdTF3WXNBSjc3b0x4M1lKdUs3ZkphTEdF?=
 =?utf-8?B?VTJZOVc1YTA4ckdya3M4aHFvdzNhWWVYVCttRjJkSUtmalErTGRoTXYvY1Fy?=
 =?utf-8?B?WEpHYlArYnhzVGFnRVMva3g0dEMrc2hYbm80T3UzMlZDNDdLaWp3TzdHK0dt?=
 =?utf-8?B?NUNMZWdJL0Rqb05YQmtvQ2ZyNHRrTGUrSld1VEJ0WDk0aHY2OXdHTTFFN1lF?=
 =?utf-8?B?T0swTTB4Rm5Oc0FNZWpUSVlEZDFwZkhRdlF0K0w0QkNnMHlYcmhyQkwrVUNB?=
 =?utf-8?B?bnNDTERsWExOMHVkT2ZqR0Ryc0dIb3NpSEZSTDZBVXpwbGpYMkJIZkNzUnYv?=
 =?utf-8?B?TllLUmRzTDdHUkprSGhmd1BpN212Wm1Oa3R0bmVSbVVaS0pzTGYzYjF0VVlI?=
 =?utf-8?B?cE4rV3RRc0gxTWdub3pCaG9wRXFmaU5kWHhuYzhibkcyS091T25tc1RmWjYv?=
 =?utf-8?B?aitySUxjWUNKWG52VnFodVYyREhqd0QzaE1TeURabVlINE4raTJsaEx1b0o1?=
 =?utf-8?B?czBpNWk4a0xJQTRBQW1IQjlhMWRMUzl2ZEVCSGFhTitrQVI5VmI2RktzVG8z?=
 =?utf-8?B?RitUWUIyaVhDa2Nrd0hyNStKWUZqR3BsUHRkWURSWC9OclhsdGtBVXFnSFZS?=
 =?utf-8?B?KzFVNkhmdWJNdmhTNlR0UnE2OStlaE9yUkgwdmhkUCtIKzFNVnZlSFpxM2xy?=
 =?utf-8?B?akxFZ1NFL2trUFRRWHJkRitIM25XMmFDZTlOQWcyVmRzR0xKWC9KQ2E0cXhD?=
 =?utf-8?B?WjZ5M0xjLy96bnZxTzVOUVExWHJoaTJhYTRsZC9wSWhlN2UrK3pxSmpCa3Z5?=
 =?utf-8?B?N1NHSzJMNzlsajF0SktrRUdzNTNMdWFmQWxyMjJKOW8ybndXMGZkaHdkSDRH?=
 =?utf-8?B?dmJoV3c0SE9pRGg0S3lFRFFSNXI3WU1zTFJKc0FkZXR4NFJqbTJZaXd5UnNU?=
 =?utf-8?B?dk9ncW5IdWxXRlRReGJVYm0raTlyZTJQbStpU3B4VGJFdUh4VjI3V3lpOUQy?=
 =?utf-8?B?TVZrc25jSXlZSmFiL2pKbE1QTE5jZ1lJY2xEakFUVkFrb0pkOGxaenlOTnhy?=
 =?utf-8?B?MzREOHJOMWppcWlETlgyWVhXVHB3SStRbTJ3ZzBXZmZraGx2V2hSK0Erendq?=
 =?utf-8?B?TDJmVFN0WFM1cTV6ZnZxM2FSZjlpQ1h0eVFzeVlQNlpTaDl2QzBuakVyVEVv?=
 =?utf-8?B?a3JsZWp1enVCZVVyMHZ3YnFaa2xNRlptTUlaL1o5ZEpNOVVlQ1l5SWJDL09a?=
 =?utf-8?B?MnBYbUlyME5zU09XUDluMEJYbWdvTzZIZHFJZUJOTVg5R21pUzVoL1RsNDFR?=
 =?utf-8?B?aTN6VDZyUlV6OW1GRmh6RHMrdytXVFFoR3VLUVVSbk5sRlIveUNRRi85Vkt4?=
 =?utf-8?B?T0JkdUVtUUdYMVFrWTFxOTRRc3M5Z2ZwZ2NMQlQzd1AzdWRXM0lkSUUvWmZ5?=
 =?utf-8?B?UndBK2szSkxkVGM5R2ZXTUdpQ2JQYXVZbHVlSnAwSUxocGEza2dXNWYxS01t?=
 =?utf-8?B?VEtqRnl5a2M2dDFLTHRvYzZEQ0NYVUpBT0poaG1DaWdCQ1ZmZHJqenF5dnhM?=
 =?utf-8?B?SldHdVNnWEZ5SnFzSWZ4N3htaXFTY3g2VEdTS2VIWjlYUjNXL0lSSTlSUnVX?=
 =?utf-8?B?NnpvbEpDM1ViMUd5a1RNYW9RRVU4U0VXeTVjSCtrR1MxeDB5MnYydGpXaEtZ?=
 =?utf-8?B?MWVNMTRBdEFaNENkeExRa0h4VUFUVFJjMG8xYTViYS8zQzZSOWszYU5oenQw?=
 =?utf-8?B?VkRlNDlKWCtsTFRHUUpUWHVlZkVUdGZRZXprWDZPYjVwTlZuaHVzcnZFWUtR?=
 =?utf-8?Q?y4L8pu8FY2gTvG/UQaYvMys3m?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abec5731-c27f-4fba-0e59-08db8133f1bf
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 10:53:50.6171
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FdhFk1ru9eOqlUUEy5W03Vdtnl40ZnTO/h91S1JyzVB36r/XlSHQdhS+LRd9A42v
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6345
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/21/23 16:13, Laurent Pinchart wrote:
> Hi Michal,
> 
> Thank you for the patch.
> 
> On Mon, Jun 19, 2023 at 09:37:54AM +0200, Michal Simek wrote:
>> Based on DT binding dwc_usb3 is single entry without anything else. That's
>> why combination dwc3_usb3, otg is not allowed. That's why split it to host
>> and peripheral pair which both points to the same IRQ.
>> DWC3 code is reading these two properties first before generic dwc_usb3.
>>
>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>> ---
>>
>>   arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
>> index 02cfcc716936..e8104ffc6663 100644
>> --- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
>> +++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
>> @@ -888,8 +888,8 @@ dwc3_0: usb@fe200000 {
>>   				compatible = "snps,dwc3";
>>   				reg = <0x0 0xfe200000 0x0 0x40000>;
>>   				interrupt-parent = <&gic>;
>> -				interrupt-names = "dwc_usb3", "otg";
>> -				interrupts = <0 65 4>, <0 69 4>;
>> +				interrupt-names = "host", "peripheral", "otg";
>> +				interrupts = <0 65 4>, <0 65 4>, <0 69 4>;
> 
> This should read
> 
> 				interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>,
> 					     <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>,
> 					     <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
> 
> The issue isn't introduced by this patch, so it should probably be fixed
> by a separate patch on top, to convert the whole zynqmp.dtsi file. Do
> you have any plan to do so, or should I ?

I have sent it here.
https://lore.kernel.org/r/9d5bd17f37772be186cab17b06cc21351d36ff62.1688986332.git.michal.simek@amd.com

Feel free to review it.

Thanks,
Michal
