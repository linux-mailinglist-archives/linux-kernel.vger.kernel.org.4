Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BECD704936
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 11:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232043AbjEPJ1l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 05:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232000AbjEPJ1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 05:27:19 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2114.outbound.protection.outlook.com [40.107.215.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 234FBE0;
        Tue, 16 May 2023 02:26:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NNP2so+EiMZR7G6+OugAyoi/GVCsCnAVX2ov2DaKJgjBrJ0eQX+cfd+o9mNp1jScAF9gAbbwens8OR86qaerp4rHozFHGmWD/ZLIhHQlQ+QPaKLvcOc4DvqDnO6ruIFNhF5PlpDqYdOq3LD0PClMhdrGbNO4QEhdshfj8rpLWturYdG91wmuulEdanoQx1BNMeRmepxtJ4RoMlOcHSHVgwj+AwxnspqRjRu5yZSGyhsvKFy1s6RucJZg1scrQ8Cw9vzJqMalcvNLTywvmCiXHu8GIuYv+PS92cdLR39QPq2FxOVr2XajxanWp2FplMpRnKbiIec5iHuXWh/HWMgUUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s0037JzJu42G1hMcV3QKXPVopEgZShFppIeJg6x7rZM=;
 b=fd62z0+siHe5I9jEEqRtbDwEnuEDwz/r1iun1Nc3xybK4kGvH9Hy5GIoHPAVTVRh/Cp0ymfTdgrhi8jIoCVz0lhpeDWclcvgQEVKoFQ9iddG6HxX7HY5n7Od6/k4NDsL2i/+zJ5lo06BPN/rtnx96vknRoAyykSR0SKh2S6Vb+2DfVhxHb5RhjU9qIgVJchNntXxl+xyTxb9mF6vctHgK0yVxFnHWxCfskLjpSkfPBIJweQh8Z88K0yeRhGC0xA8B1FH2Y1r5KtEAOioSuxjYtv9LMNjfdjpdEsyPcZ+Bwt0R0H0dxlgSp2eT0R7OjO3Olz/6NpFc+8dNyq8z6HLaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s0037JzJu42G1hMcV3QKXPVopEgZShFppIeJg6x7rZM=;
 b=bxUEw7jBWMPR5UMwQBOPhDqq4VMjbQGm7AzRpbJVegwmmF0Um8C/3zUeZCkRC3aV/I0I3MJ7k1so0ncwrOdtpVfFvHCp/CEAJqfmkFaauHck7ZE3lFCDrdAK0T8V3IK9L1AEFwaqGIevwFqmq/wLqJzz1pxT6rTWLXqMu/N6arBtpHsw73b53yzZJm4EqsOFfi5e58PwoT0fdCAW29uoGqD5z9KTaqrAPtxmtsMuW7OCLUaOYYHa0/CleInS12WGcNVxMMy2C906u40Zoal4N4YpBExl+o76H7yZfJNysBzAOuslaJhFauINuc4qzrqs08xXjjIKs0n5osRpA4cn0A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from SG2PR03MB6730.apcprd03.prod.outlook.com (2603:1096:4:1d5::9) by
 TYZPR03MB5535.apcprd03.prod.outlook.com (2603:1096:400:d::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6387.30; Tue, 16 May 2023 09:26:41 +0000
Received: from SG2PR03MB6730.apcprd03.prod.outlook.com
 ([fe80::e116:7d2a:af78:fcf1]) by SG2PR03MB6730.apcprd03.prod.outlook.com
 ([fe80::e116:7d2a:af78:fcf1%5]) with mapi id 15.20.6387.023; Tue, 16 May 2023
 09:26:41 +0000
Message-ID: <bfc27a11-9be1-2391-3d26-62aa29fac190@amlogic.com>
Date:   Tue, 16 May 2023 17:25:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH V8 RESEND 0/4] Add S4 SoC PLL and Peripheral clock
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     kelvin.zhang@amlogic.com, qi.duan@amlogic.com
References: <20230516064736.10270-1-yu.tu@amlogic.com>
 <c4d30304-08d8-6a31-8f91-7840fe2922fb@linaro.org>
From:   Yu Tu <yu.tu@amlogic.com>
In-Reply-To: <c4d30304-08d8-6a31-8f91-7840fe2922fb@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0216.apcprd04.prod.outlook.com
 (2603:1096:4:187::18) To SG2PR03MB6730.apcprd03.prod.outlook.com
 (2603:1096:4:1d5::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR03MB6730:EE_|TYZPR03MB5535:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e5a5a8c-7b69-4fc2-cc60-08db55efa86f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y+3u+3NtjHiv/WJ+eO/OF/T0UCP7IcynFyX2JoUuJ+LgPl5FOAPi2uIRF0CRhaULChooIWA2EEjL+H+uQ9ebgBYs/5Ru5tenJQe1/A/lcwOYiVkcc0G2RG5+6f3RXsFNvKvuWROZPm62mk95RipGKeahTxQsLCccXMrqiyHw8qFO4TKoi8qjvq3q5b0NRgXc7KUPaumto65mZTuC8mqOvv58WlnVvWPxDs9qcWcL/o+BQvoU3QlhzO4/b6ZK2RZR9z6bQaWKX3XnGSWz7N3k4S7JvA1hFo+C+zUAGD9h6GQv/fHMGeexQI0XWP3JxBA0FEf9o5331D+2qc2bb9wyzpkNC4HSPhHmgdyh7eGRVGyPlcRUVC0RqcwkkS/xKH9qD3sted8Znf9NLdo7EYy5DPw5JD32JO1eW4BgPCcBZposwxLqHHdmTNiVzgKD59hNvyf5YvrScqhVBuN5oGWtWrmSoEpd/EkvhkVJzg6GM23ghJki3AUuAN0AKbZzaeXkxrC5u+XQHgsOKCkvKUO159VPdk5eQZId0ItklUx5iWO2cOKQmlGzZrI7l6wwl0J5a6T7mpVlJoWa6S2DoWjg1hM/2MIqBvj1AqTezavWZjwF2UcFYLzKLKAsldJLYF2qIM1vh0FfX7fnPVMV9ZrFZB2zYzlsPHbE2J8sG6n8jSU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR03MB6730.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(39850400004)(366004)(346002)(136003)(451199021)(31686004)(83380400001)(921005)(4326008)(53546011)(6506007)(36756003)(38100700002)(41300700001)(6512007)(26005)(6486002)(107886003)(66556008)(478600001)(66476007)(316002)(66946007)(2616005)(31696002)(8936002)(7416002)(5660300002)(44832011)(8676002)(86362001)(2906002)(110136005)(4744005)(186003)(6666004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UHBPQUJZbnVVZGxwSW9mS3NQMmU0aWQ3R2QzdDhwMzlFTVpPTEowT3lhV1V1?=
 =?utf-8?B?djlVdWhtYUhBMmgxRjFZNUh3VDJoOEtKOTdGQUhleC9aOGVLbUk2V091d1h6?=
 =?utf-8?B?bXVBOVVYN2xNLzBXU1ROYU1KU3lhcUI1dEd5ZC8zTngzb1VBK0dQdDk1cU1R?=
 =?utf-8?B?dmsyWEx6blVFdmNxR2JNSDY0T25PVE5IblNzMmMrcG5DcHJjUi84OGE5dXNS?=
 =?utf-8?B?QzFORk5lQXNlS2pUakloYUxLcHdWdmNmR0xVUTczSVliejVEdlY3dzR0REVm?=
 =?utf-8?B?WVFnWGkzTVEyVzdUN0x5SkFvMWJNZTBmL3o4cHpSZ3I4d3dNK2lnTjRlM0JZ?=
 =?utf-8?B?ZTR6dmU2VlcwQjdSNkVuM0Y5UEphSGVEbkx6KzhyK0ZjWEdSNkZleGh0NUV6?=
 =?utf-8?B?c2dBVUwzT0pkaDVIeHplVmhqWW52MzkwditwQ0JpRGY1ZjdUbjFZQWVRMS9x?=
 =?utf-8?B?TXhYU0pSMEFVUDZNWVJkb08rT2Zuc2pJV2pxS1J2R3JtNmFCM2pxUHd0U0tt?=
 =?utf-8?B?R05FMjFaeGlnZ3h6SGRxSFVEY0ZPMnhLWm1xZTVyR3pGR0JCU2hHYiszKzJR?=
 =?utf-8?B?T01DUlVDZHByR08rdUpaaXp5VXFKbHFpajAxTmxyWFZCZ1pCb0dzbVNhSnpL?=
 =?utf-8?B?bndMdlBmeXNlend3YmJjZmpEYUlCY1k5blFMeUtxWDMzNFE2V0JPTEVlZ1dQ?=
 =?utf-8?B?bGx1QXgxbXFUV1Y5OHd2U1RodzhHL2oxVDFHalp1Q0RUZ3pxb3hNVk9SelZw?=
 =?utf-8?B?OERvSzF4VEloV0R6TjhLNlFETjlYVjJCMVlPNkxzQ3cwK0VMTTNxeEpiVlgx?=
 =?utf-8?B?RG95bWo3NE5QYmZXT2pQdFZzeS96dzc1N1RLRUg3Mkl3b1hHTzFqY3hVN240?=
 =?utf-8?B?VzV6NlhkcVRGR2RqWkVNTVBya3JHU2NQay9WRGN6cmxwSmlGUm9COEpNd2pa?=
 =?utf-8?B?STJPNDBnRDVLckpTaldiZTd6RGQ3cFAyMmlMVTRSNFVmWWdqME1TWHlhOHM1?=
 =?utf-8?B?T211OTJEMHVEbmdnKzczUmdwbUI5OWdCTnI1b1RVeTZjZ1pBUXFYOTVrSVUz?=
 =?utf-8?B?dGZyVEdmc2JPdlJ4S1dXenQzM1I2cWhmWUl2MG5YdW4zUC9HTzVWazVvWGdu?=
 =?utf-8?B?cEp2S0k4UGxmVUN2cUxiNHBsT2pKS3UrZmxXdTQwalA1OHRJMCtRNzhlKzl0?=
 =?utf-8?B?TW1oUVdYbUxUZDR3RHBYR3hDb2x5TytJc2FXVU1FdHdjSnZMSGlKcldyV3Nx?=
 =?utf-8?B?RE02R2FOSnlGTzVxTFRKeSsxd3p3blFpWlJyRzBDb1BrdElXMFJSb0VjVEIz?=
 =?utf-8?B?d1VNb0UzVWRqK2o5cUNsQm5abEVBakFCbExsNThPWWZHVWpRZWpEaVJ2WGUw?=
 =?utf-8?B?cUswN2RVRUtnaGxZbEZ3MjNZaENCOElDK2J4bEFHS1NkUUo5aWNTWmxKam90?=
 =?utf-8?B?TWhQVVBQMmxBR09mMWhMenp0MFlHbUQvd1JBb25FQUduMEdpdC9jdHBXK2Ni?=
 =?utf-8?B?VTRTTjE1OWZsNzhoeDd2QTBCNHNVUkpHb1JHTVR6WllaQi9CYys1bHUySlR0?=
 =?utf-8?B?MS9xSHdaOTBOQk5vdGhOcktlT3RmKy9yLzVwSXFGNXN4VGV2cDVYTW9wTUdF?=
 =?utf-8?B?WFJjQ1RmWWtsVnNHbTc3dEovL1hISUxQNVFETkVEN081a1c1NEw1WnJoZGRv?=
 =?utf-8?B?a1RqL2dvU29rNFUxV1k2R0lRSi9zbVFyd2hKc216WlRFSGpCWTQ2WEpBSzdo?=
 =?utf-8?B?eUwreU9pRXFzMENpMVRQS25LaDFXMUZNZTgvWGtEamRTNjE3N0tlQ1lNLzFI?=
 =?utf-8?B?RXJVMHZMRXV2VG95VFF1T3BPaU9kREJ4TElHeThoMnd5bXFvYXFvT0poWGx0?=
 =?utf-8?B?a2RNYnEyYVNmTWJJZDZ5dHdVTmgxZ3FWNE9kckVKOVBTbmYrN1I3Y043QzJ6?=
 =?utf-8?B?NnFOTEx5cXlidTduSUd0VEp0bGxORjFvQ01TMlZobXBtTG9VRXJZaTBJTDJT?=
 =?utf-8?B?UkhBQWFwUXlmVlFia2psZTd2NHR4VHdTMkhobkZmK2dyN09ibXFubjIrd2tS?=
 =?utf-8?B?OUJiNDZxY1J5TVdmZ05rUGpPWm5idjMycDNxU2l6Z0RLVlVhSldhV0ZzWnVT?=
 =?utf-8?Q?38jB0nQXV5y09ZkilMXTXsdwd?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e5a5a8c-7b69-4fc2-cc60-08db55efa86f
X-MS-Exchange-CrossTenant-AuthSource: SG2PR03MB6730.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 09:26:41.5778
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RJmU/FfIzdIx4EQXZ2MYH1Yz734xvdEXKFdsVlJ9Z46ineOtPKH4GMsK2nisUhMtcn9g1w3E6ZOO7XJGvFe+8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB5535
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/5/16 17:20, Krzysztof Kozlowski wrote:
> [ EXTERNAL EMAIL ]
> 
> On 16/05/2023 08:47, Yu Tu wrote:
>> 1. Add S4 SoC PLL and Peripheral clock controller dt-bindings.
>> 2. Add PLL and Peripheral clock controller driver for S4 SOC.
>>
>> Yu Tu (4):
>>    dt-bindings: clock: document Amlogic S4 SoC PLL clock controller
>>    dt-bindings: clock: document Amlogic S4 SoC peripherals clock
>>      controller
>>    clk: meson: S4: add support for Amlogic S4 SoC PLL clock driver
>>    clk: meson: s4: add support for Amlogic S4 SoC peripheral clock
>>      controller
>>
>> V7 -> V8:
>> 1. Change patch 0001/0002 dt-bindings title description, remove "meson".
>> Suggested by Dmitry, Neil.
> 
> So you only removed one word from title and description? This does not
> justify dropping review tag.

Yes. I just remove one work.

> 
> You already got a comment for this - add the tag.

I wonder what I should do next?
Add the tag and RESEND it again?

> 
> Best regards,
> Krzysztof
> 
