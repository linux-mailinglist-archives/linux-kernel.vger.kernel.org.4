Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9738473F813
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 11:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231191AbjF0JD7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 05:03:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbjF0JDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 05:03:55 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2095.outbound.protection.outlook.com [40.107.117.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9FF799;
        Tue, 27 Jun 2023 02:03:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b5Ta/SVxfVHuktLAOrWHo15vSLnxMlIkor5tYTyLeWZb/72tPG5a0cOJyyUZojFDM6WjSVoIfp846JR4Q4e/oZvUk+3ph0/2Pd5aZCAkp4Ik5aPEJbinCNcjyJ0ALtASNS8lpTRxE5zr3nJOUunBVBaALecAjURvXSmxBlJ7UOu/9XxIMIRXd7DoTTRyhoXFvA7DjIjzqLrPdZ5le0D7vDMRjGlHbiJIvoAjDTrp+eo1Phv45D5wC4w2tPizfrpDDyMQ/6hNU+jJi3WgHLw8ErbNLT09a0XdAFB2IvZfvICFb0LO766z2yrU33XiVPXq3+FFB1c6bvV40UmPhZgUhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oe+DX559Lvj9hJld1PPKWW1PUGNt89CYhAKnvZmA6vU=;
 b=e5cEmdXaVwaD64+YZbpmO7zWPp07AMrojMVhJYLg/Hbr9JEBxcXPPRIXRE3ZDXNkZ6l4hGqXI62RpgcB322ZYpTnW9cOn5KH7Ugd1uwIOQzNWUFIPFiz9Z4cES50wzI4dDj3e+mM1S01Mg4bFJ9WFzMpQgJABK6KX+AxgrUYXG364m9jNXvoasH2fG0OZtEXOVTKkNzAUJswI8dzLROMR2qomQZWv+JdTS2IEXtCxdApadASAmhR5yYogmZLbscT5H5/SFstPGU+VzIQ9Hh9v4MVOcn27mr7K7eKT2PkPBfDeO2IkuX6hzcm4tIUM0/ipEdlSm6PnD1OxeDh0S1RBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oe+DX559Lvj9hJld1PPKWW1PUGNt89CYhAKnvZmA6vU=;
 b=G4Kfz2D0Je3rfdzzUvSHBp3nZxsSL0zVsOkYw5vV64k0JKFJEqwSWaSrEeYSri3dFzxF2f2QE08h7h92GekNMXulMIHyE4RBBSDcmjk7LD0a/AZkyVawuV8r08uhFV6ZeM6RQsWGTMPoVuRdW3x/LZ18PVB7gZ2/gr54BWUdDgJP9m4NhvmRDRUgv+y5RiuSXh04wTxc9LIfMUiK61sEeQoJJSSPCIXz7iPbRfXZzeZYvBdfM1QeMcrKqTl25mvKjcfpsEIAU+hcnLUDwM3WWFYp+arwE7+z7gWRFEf/sFTWghuLHYJGF+94dLCYCpGtPP+11yoaK6xRvUy8KxqThg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com (2603:1096:400:289::14)
 by SEZPR03MB7401.apcprd03.prod.outlook.com (2603:1096:101:124::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.36; Tue, 27 Jun
 2023 09:03:05 +0000
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::e659:543b:2ac9:8fd7]) by TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::e659:543b:2ac9:8fd7%3]) with mapi id 15.20.6521.026; Tue, 27 Jun 2023
 09:03:05 +0000
Message-ID: <d33f35f2-d8ac-7b8d-6f23-e89cb8636109@amlogic.com>
Date:   Tue, 27 Jun 2023 17:02:56 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/2] dt-bindings: arm: amlogic: add T7 based AN400
 bindings
Content-Language: en-US
To:     Christian Hewitt <christianshewitt@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        AML <linux-amlogic@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
References: <20230626095223.721011-1-xianwei.zhao@amlogic.com>
 <20230626095223.721011-2-xianwei.zhao@amlogic.com>
 <94551B90-19E8-49C7-90FC-FAFA5E5E2D9C@gmail.com>
From:   Xianwei Zhao <xianwei.zhao@amlogic.com>
In-Reply-To: <94551B90-19E8-49C7-90FC-FAFA5E5E2D9C@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0029.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::20) To TYZPR03MB6896.apcprd03.prod.outlook.com
 (2603:1096:400:289::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB6896:EE_|SEZPR03MB7401:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bd986a5-4c16-4953-f274-08db76ed516a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zt+SLERtf8AS5QNfEz4rkasjps5CKxj5v366qJFZHOS/UJZvx5sKnNmqzNwZ5NMiZF4fnNtuwZhZhuhoSygU0Rf+aF/aao4cxSx7NI8rV5nIul3i1LdDY2co3x8Oc8Tz9nAwB76gzByuA0cbpW8uzvR2KSRUDVkZl3vnxOHphyyioPN64NLSvWMsHpEY6Z++UcFOAk+tQMl2CZvtSMj5gE04aRmpyG4ToWJpUG0bKV19QmXYold8ips0/d6E1lPhFMmb6hRkjlq6nrHe+7x6GRQWnibsuBsV7Bs6wYGmHlla5nmyJH/K1Y1UYzHcIRvc9O2vEDiK+4A93cJGtBvtvlfrH/pF5rixb3Qjk4pg9QgDxBA/JK1mGYOxOgKN48ydI55762jUX0KSnyePaffDvyOBlD5xKw6Nz3rNevkg/G93ycl+9eBzfebRjl0mWslEMRmDLwfOt6v7i3fCfYzK/8Vc6R1TBEECkwyGt+amIXCPQavK2KCJLJR0g82b7x5CNa++3KiJV8oz49nOxrX/DaQhQiKJWaIIxA/IYP1+FnojY2eSdXGd1WZfPZVWt8pqOx1sBluR/MdhvFK89zc1xybhlmu0u9EO5lv7/ZGsX+q2j4aP9jy/Z7n9CeIGipEsvkOZAc60oF8fYnW60xyw6p57wZlw3zyLxV28nOTpXwmcMAOcQc2upG802/5fwlDU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6896.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(376002)(39850400004)(396003)(346002)(451199021)(2906002)(186003)(6486002)(38100700002)(2616005)(83380400001)(6666004)(6506007)(6512007)(53546011)(26005)(966005)(31696002)(41300700001)(54906003)(86362001)(316002)(478600001)(36756003)(66556008)(4326008)(66946007)(66476007)(6916009)(31686004)(44832011)(7416002)(5660300002)(8676002)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VitiSE1HZUR3bm8zQmUycUMyQlBaSzZKcWtGK1owVWpPRCs3Q2tWa1NMNkxs?=
 =?utf-8?B?NFZBM1hsZTh4ZXBQK0dPWjNaU1RzRGhrOStpbXdHdDZNRm9Ma05yVXorMmtE?=
 =?utf-8?B?RXRvZnJSNjBrZEVWUlA3Q25uNzJzYjI3ZGNqY2QrNWUxQWliU0hpRStzSUpl?=
 =?utf-8?B?TkhzRTM4N3NEM0NONnBsNkRFc2pGWitoVHc4MHQyZUJwUjZuZng0Q0UyeFR0?=
 =?utf-8?B?TU00U1V5eE1idllrNVhTcGNDc2FUaUwrZ3BjS0V0WHBlNzZtT2ppYldJZmR5?=
 =?utf-8?B?cG8xaTIzdHlCS0pXL3Z2Z3JReUxRanA5LzNYTVF3cEtPT2tQL3U4V3IzcXhs?=
 =?utf-8?B?Njl5emZkTzY4cyt0K2ZpMEpRVmV5cFBXM0k3bU1CWGkxRThrOWFjS1doSlJF?=
 =?utf-8?B?b25FNkpnSU04Q0cwWU4rdzBIc3pSeWZrdGdpRzViRUlJRmZtTXhmbFdUWGlI?=
 =?utf-8?B?MDkya0hReFU0eHYreW5EZy9KWHFtdHBSaWdhT2VINHVMb2dpM2NCYWQ2Tm9n?=
 =?utf-8?B?TU1RYVFaY1hLRG42eHFneUs3SThCU1ZDODhRK3RHejFVKzF5aUZRbDBzSXFo?=
 =?utf-8?B?d0oweDladnF2RUNuMDI1TVRLWE1vUTBCa0xYUWpnZjJwZHlUZHQ4K0srYTNR?=
 =?utf-8?B?TG5VdWJyeGJEMEg2OGhPMTBSUzJXNjJ1K0hBUGZTWDhRMlNuWG9QVW90REQ1?=
 =?utf-8?B?cWE4M3ZWMGpSQXFzaWJHYXp0ZCtsYjBLZ3MxQUhrSVBvWU5qS05va1FCaGlU?=
 =?utf-8?B?NDRkci85Z3lyRWVLTEZpVlg0bFFTWWVzWmlLZlNqYklTL2NqdDF4R0xjSzlN?=
 =?utf-8?B?TVNNMUZRWG9TU1hGbEtld0RYVGN4MG45QWV2d1Q0djZyUVBwaVdSVWR5NXVy?=
 =?utf-8?B?OXpNSlFGUjMxV3VxYUM2Nm1BUCtxWm8wbkdiSzN1YWlsSUZGQ1JTZHBScVpH?=
 =?utf-8?B?OHc2RHN4YXdUSkpwSkRwYXhJRUZ3VHpRbUduc2RVSmxGVkhVY2xVTTJidHZj?=
 =?utf-8?B?Sy9RMVRsR2RidERFTC9CTnpUQzJONmYySk03Smp0dlMxaHhHZEI1ck1Qalo0?=
 =?utf-8?B?QzRLTFdNRlEwdTE5NXVIQ3BESTZrTCtIbDl1YjRBMHB4Z1BtM1hRS3lGRUdX?=
 =?utf-8?B?bkh6OURaQWNXYnh2TlFudHA5bUpDRVhodVpvclloS0ZleWFlbDRBS1YwVHJF?=
 =?utf-8?B?cGdCTEJjazlrK2NlckprMTFnZXllbmFuSittOS9Lb2dHQ2owbVVKbWpYS2tj?=
 =?utf-8?B?Q3d5QlRQQXdMMzdabjJwSTNLbnJUeGxHQUp4dmUwakh5K29VOFJQcUFxUkJL?=
 =?utf-8?B?MWdhWENidHJuMWhDdy9nTThLODJXUkxvQUtMNEcvdUZ4Q01HVjlCamc2WjIx?=
 =?utf-8?B?bW8zSHFKRFc1VHgvU1pUblAyOTErSmUySTVGd0hHSUZGdUcxM2ZHYkhXUW9Y?=
 =?utf-8?B?dTdsaG9EYVJjS3ZzRmc3NGZ2VGFjTU9DSmd2S1BQMlpydjBkbDZDRHV6ZUFx?=
 =?utf-8?B?c3U4N0xHM3ZkZmJZVnBsOUNLbzVxOVdES3krWXFNWk5uUEl1blc3Njh4M3ky?=
 =?utf-8?B?UWRzWEpPelVrcS85U2ZBNHUvWER2OFNLaXBkYTYvc1dVY05pUCtWVHJibHF4?=
 =?utf-8?B?b1daM1NCeUZTelRPUkJ2U01NYVEwcUg5UjBlS3J5QXJyMTFzRndYQloyMzMv?=
 =?utf-8?B?Rjh3M25ITFRqbkFlSmJQODRJckFjY2V0dzhycC9JeDdOdGhsSVRQa3RFbkFM?=
 =?utf-8?B?KzdPMkZQMVJ1bW5oRkVNMFpsdHV4YUZ6Uy94NHV3L3BqVldVQkNTelJyZDZH?=
 =?utf-8?B?dHM3dkR2YklrZlJ5SkJTRklrd0tKZmp5Sit4OWcwOWdlMnVBNmEvTXpvT1FS?=
 =?utf-8?B?V3BlTDRxUkJVVHExTDhMR3o3SzM0NkVLaGk1TExLZi9tR3BqVis4R1F3RCsw?=
 =?utf-8?B?TlFGYjNNTFFRWTlXUjhTZGw5UlMwTUNLQTRlLy9ZcVpORnd2MXdQbWE3SGNL?=
 =?utf-8?B?Wkx6T3dlUkhRT1JFcUxTeERsR0swbW1DUCs4aWxDTkVIQTZLS2dIK1B1MVZS?=
 =?utf-8?B?T2FvdFgxTEt1S2IyR0JqbEt5NTRDT1hqVEViV09nUjhyYkFEeGVCWWp3MzBy?=
 =?utf-8?B?b2wxMFpYempLUVFHRGVodTZZUy9mZmVsVTdMenBrMnl1eklXemRMVGhpMDVM?=
 =?utf-8?B?d3c9PQ==?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bd986a5-4c16-4953-f274-08db76ed516a
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6896.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 09:03:05.0446
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A8c9GjSxsVBRDZ83ogArxIPcuBGl7Ft6U+ErX2v2cqSKoEQnC0cQXIj7IlXRnKgCCJxnGsBBhIobMnE/oLXrWFFDhTW4FPd+7TUVgfUPYMo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB7401
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christian,
       Thanks for your advice.

On 2023/6/27 16:56, Christian Hewitt wrote:
> [你通常不会收到来自 christianshewitt@gmail.com 的电子邮件。请访问 https://aka.ms/LearnAboutSenderIdentification，以了解这一点为什么很重要]
> 
> [ EXTERNAL EMAIL ]
> 
>> On 26 Jun 2023, at 1:52 pm, Xianwei Zhao <xianwei.zhao@amlogic.com> wrote:
>>
>> Document the new T7 SoC/board device tree bindings.
>>
>> T7 is an advanced application processor designed for smart display.
>> It integrates a powerful CPU/GPU subsystem, a secured 8K video
>> CODEC engine with all major peripherals.
> 
> ^ please avoid marketing text in commit messages (and same for the
> other commits in this series).
> 
Will do
>> The main system CPU is based on Big.LITTLE architecture,
>> with quad core Cortex-A73 cluster and quad core Cortex-A53 cluster.
> 
> “T7 is an Amlogic SoC for smart display applications. The main CPU is
> based on a big.LITTLE architecture with a quad-core A73 cluster and
> quad-core A53 cluster.”
> 
Will do
> Christian
> 
>> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
>> ---
>> Documentation/devicetree/bindings/arm/amlogic.yaml | 6 ++++++
>> 1 file changed, 6 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/amlogic.yaml b/Documentation/devicetree/bindings/arm/amlogic.yaml
>> index 08d59842655c..79a8b44ffd03 100644
>> --- a/Documentation/devicetree/bindings/arm/amlogic.yaml
>> +++ b/Documentation/devicetree/bindings/arm/amlogic.yaml
>> @@ -218,6 +218,12 @@ properties:
>>                - amlogic,aq222
>>            - const: amlogic,s4
>>
>> +      - description: Boards with the Amlogic T7 A311D2 SoC
>> +        items:
>> +          - enum:
>> +              - amlogic,an400
>> +          - const: amlogic,t7
>> +
>> additionalProperties: true
>>
>> ...
>> --
>> 2.37.1
>>
>>
>> _______________________________________________
>> linux-amlogic mailing list
>> linux-amlogic@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-amlogic
> 
