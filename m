Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A682702A32
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 12:14:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240847AbjEOKOa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 06:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240832AbjEOKOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 06:14:21 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2119.outbound.protection.outlook.com [40.107.215.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27D13E4;
        Mon, 15 May 2023 03:13:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iq6IJzbMsCxM/SFR54seqKoZSbArFzgQIHmj+gN+EAS8rrEuicLlVR+NfUey4mAHkcPICqdQtn4lT/B+vpTVDOhrJ/gs5DBjARHZUDWi3y8slU5Y3YglhdXPCYwvVWzL3kZj3hXKlzFx5bCTZtpCuJy/V3l4s2U9xOmTQpxlo77QjL3bpq/EeFPJR/SdpfrD/YuADdn6GtxODP7NQ9/rgfaMGUsswoQapwQiXDDFak+1fhVGz6kQlMjexfxG7cwdKlXhcFUAwUUn3/iCh34cVzDnw6ff9fIORDJzBbsItN22MvPpehjUJVhczw8xqbjxryw6Kz6Us9FTXo0as22W+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BHwazPUNWXjg+hntrO+2kOX64lw/zMGjREXV4tIDIGA=;
 b=dw6Zcr1iWOhXZC4lERgI4Ak+w8TVYBCEbrzsbN5dL1yX2hj4LKEZtkoVWtPishru5OabM/lpQzc/5Iedtqc2lhyAv2ax2CXIR5KUxgYzsTZqCC2sX546NT6AL/bphIx5+uta1AUmPqW03WW10E9UfYC3YZAPIon/rVLKQeq7GVdXTMkSmWRAG6cpuQoJSb8lzXDQD/YZr99sceRA8ye9cH92Tq3yLVEBUiEZVVwDHP0Qw7/Eq27uSfFdQjrJumF3MDnwHU2K35gWregGV4CdKM3t8QGCb7Dq1glc7c29sr8v5MvaqNKC4RITKPrHn1/7SiQMhqSzZoJJ7SDAIs0dBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BHwazPUNWXjg+hntrO+2kOX64lw/zMGjREXV4tIDIGA=;
 b=gStxhDCeu+GfOXFusU+oTcusKbmxB0APNsLq0zWRbW8Id8meTJbrvexUaw4iGRqVDUVoxl2yHINm5OLIStdzCWGV0PFL51iV4swdgPy0dJ5/B3d7U8PCGNnYRGwJRzmLVPcS/A7egD64c8aZ0VhQSiRv6Q+IYBBd4lds0DLhL3JYgcURAFeF40Figwt6Iv1u1Ynbt11XOED6g1x4gR3Aba5jkxGfDSk6OckSRQ3salnN/G499uSOD3nqk51QukBXwoAaQd8OYvyMHw1KtpATcSDB3Q637i0eKbTUDZP90a9hMu0ReEPq1A0bA8ALeV344ue37n1cU1fDaenmvjmnRg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from SG2PR03MB6730.apcprd03.prod.outlook.com (2603:1096:4:1d5::9) by
 PSAPR03MB5574.apcprd03.prod.outlook.com (2603:1096:301:4f::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6387.30; Mon, 15 May 2023 10:13:29 +0000
Received: from SG2PR03MB6730.apcprd03.prod.outlook.com
 ([fe80::e116:7d2a:af78:fcf1]) by SG2PR03MB6730.apcprd03.prod.outlook.com
 ([fe80::e116:7d2a:af78:fcf1%5]) with mapi id 15.20.6387.023; Mon, 15 May 2023
 10:13:28 +0000
Message-ID: <74531faa-a583-03ad-b8e2-83799ecbfa6c@amlogic.com>
Date:   Mon, 15 May 2023 18:12:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH V8 1/4] dt-bindings: clock: document Amlogic S4 SoC PLL
 clock controller
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
References: <20230515031557.31143-1-yu.tu@amlogic.com>
 <20230515031557.31143-2-yu.tu@amlogic.com>
 <590560c9-4da6-bbd4-6aac-de57ab5403ba@linaro.org>
 <8c6ad0a9-7820-c7a2-bd3b-1eee87d96728@amlogic.com>
 <33f5ff59-db7b-7576-64cb-972c0dfb0f7b@amlogic.com>
 <4a04ef11-d87d-4464-a907-badc920d595d@linaro.org>
From:   Yu Tu <yu.tu@amlogic.com>
In-Reply-To: <4a04ef11-d87d-4464-a907-badc920d595d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCPR01CA0082.jpnprd01.prod.outlook.com
 (2603:1096:405:3::22) To SG2PR03MB6730.apcprd03.prod.outlook.com
 (2603:1096:4:1d5::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR03MB6730:EE_|PSAPR03MB5574:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c4e5ef8-812c-4b8b-d2a0-08db552d06ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: slvKdTNMCSkwgOAciC58rVGo/S6LLNBzHXOLzZad6fVhGVi9onDWUrY9Uv4DmW4Igsc9Pj6SbveJcC2s4MXOaMBd2o3TNF8PG3RUWT05ERzwevglpso2mEj8rzacL/BxQLYdlpnqu598zEH8FW24eeEHEo7O4bxoOfVsHvPs9m6JEt5nsMw3g9IYfi1Cx/DptqMo6a4Jn0bgLHg7nj9l7gRRrfW2i+gfv+3U5UVQTcf+9h2G7MzeiUpDLbIfnQhTfT97HJWEvZ7qGJiaQBWAevfoBIhpgvVfNupUxn1tp1MJLcoECMBwu27FLnTS3T7Ku+9IyT+CMFwxPLrXQVRCJhII5wCRWzy+1X0Nuf0Ok7EqJMfvh6KUR4zBwO+qQQ5i9Luk9mLUuX7djl3GmddkXgxpDC32e6BcEPcbsEvnYO/J3sUntoY4NmFa3ARXCJxODdSIr2zBUl+hDbCPcCkQZ2RmnZNnIzIFtTEIhmR1uHYD/uIitNPIVi8WWT2umbVrzAI+NmbH7Ax2D9l8p9CO/bmteuC3JRXr9UmzJzjDfN8ccQ8MeoneqxMBd/NC2vPpWY5FGzFDXAduvi52T9jGm/7UpLEQmFKnVoGTYQbaqKddqRqW/re9Tw+/CwLNgb3TTqagf0GjooIZmGKghDBahy7sdy7pUM1bJE2rIlVN+GhDcthKGwmpFjswU/2Z98EzR31pXvDHsxwQgBuUiWwGCQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR03MB6730.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(39850400004)(366004)(346002)(396003)(451199021)(6486002)(83380400001)(966005)(478600001)(110136005)(6666004)(2616005)(6506007)(26005)(6512007)(186003)(107886003)(53546011)(44832011)(2906002)(7416002)(36756003)(4326008)(38100700002)(66476007)(66556008)(41300700001)(66946007)(8676002)(8936002)(5660300002)(316002)(921005)(86362001)(31696002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SXNTa0dEemVpeUtDeWhyMFpsai80bjlQdkxFOCszZmxUaXZEVHVReVMxR21j?=
 =?utf-8?B?L1NxVVd3dzBoNWZuQkUyOTRWd3RKbXE2d2RzSW9zMTZOZE5seWpTVldxQjdh?=
 =?utf-8?B?dm9vNWV6Z25PWEtob2QvbWt6WEtSb21TQkt1c2h1YjBRWHJkYnU1Q3ZaSDJU?=
 =?utf-8?B?NjJyV3pHWWcwNXNnQWYzNmJlN2VxVDNHaWFab08rS3dNeWo0RlJFWnJJdW9I?=
 =?utf-8?B?bDNrNjlzaTB6UDdZakxNdWE3MkZnc2F5dW5XV3NLT2pNbjFWYm1CYkcvV2dh?=
 =?utf-8?B?L3l4dm1wd2JqdnYyNi9iSVFZRjdaczhvRzh4Zm4vU1QzTVFtVC94YllrQzhD?=
 =?utf-8?B?aWRZcHRiUmltSDFvMDQwRDZCNDB6bUFsKy9abUc0SXNEd0gwZkRYL1Mzbkxx?=
 =?utf-8?B?eTl3THdMTmtvVkdyMDVFODJzbWFmRnFQdzhHU2pHbUcyUjE3M0JOdHVKTHZS?=
 =?utf-8?B?cEIySVNmWDF4YXhVdHlaTXBWUlRLZEg3ZWQ1Z0d6TTQrUmtTa2dOM2J2Qkxv?=
 =?utf-8?B?YmgrMm5YU1pNRHNiOHltR3hSU1BTdUE5RWNndEduY1dYdXNUcGFJTmVyanNV?=
 =?utf-8?B?c1NWcERtU2R3YSt4YXllWFYxbEo3Nk1idFovQ0cvSjFYaDlhWmNiVmFFUzh5?=
 =?utf-8?B?QXpTUFQ5b1ZZa2czeWJ6Y2pNcCtHaFdCR2Nyc0tlNlE2bVJmUG9ReVh0WlR6?=
 =?utf-8?B?ZTRaTENVd2xjRlhtWCtGYmJXSG44Z1c5TS8vNTA0RnpNWW5hOHI3a3dOeXkw?=
 =?utf-8?B?YThpUFErK0gzT0JFbXRNaWlqSkx3K0VWaEh0OWFsd01GeDl1MVVoWmQ2dzJM?=
 =?utf-8?B?WWVudWVNVnoyNERjM1FSZzNUVnZSSXUxdTd5MGVKbmx0RkZqTy9aMHlIRlhj?=
 =?utf-8?B?czFic3ZpcWx2K1dpWjVLT2JSMHRVNFVQakMwNitxYld2ajlWOGhkZCt6bzJI?=
 =?utf-8?B?cmEvZ01QZ2JWZkFjTHp2ZWZxUU1vZzEyanpSY1A0Uy8rZ0d2QjRadlc3a3dS?=
 =?utf-8?B?YldKakJkZWJHTHZWMzRVQytISU9rNDdUYlhBZnVieWVTK3EyeTA5TDNEdXJK?=
 =?utf-8?B?TERkR3gyNjM5U1dONTJFSnJVdndvRmFpVXprdUJHVkplNGJ2aDRwaXRJemFu?=
 =?utf-8?B?cHFYT2tTaVM1Y2RRWldmMTNJT2ZCS3BTM2ZiTDJISXNCSXpkTWpBaEg3NXEz?=
 =?utf-8?B?N2QwbVJVQ2tiR0tNZkZRdXd1RVNESkllVGNKUDVrTmgxRmh6Z1dYZmRpWUVH?=
 =?utf-8?B?cHYxbVhWOFFDRHRIRnZoci9IdTNkRnNyWGVCbmJPd0JmM0xkR3p5NGF6ak5L?=
 =?utf-8?B?RHI0aWxkYUdyYllrcThBTFZOeHpDelpkRlRvT3hSdHJPOExGc0E0RGxGbzdS?=
 =?utf-8?B?TEdCM1RGbk9lbTJvQ0szWWVMVkFsenJnWnB5WCtUZjRtMDNpV1hOVm9nTHdw?=
 =?utf-8?B?YStLKy9oeE5UeTZITjhudDNESU1HR25MZnVFT3BRSzlBU1dNNEVuYkZvYmlX?=
 =?utf-8?B?bFdwZ3IwSVN3eEh2S21BeVlsTHZvb0YvQjI3ZHBpRkl5TlNocExMc1hMRTFR?=
 =?utf-8?B?NTJBeVcyd0pNWlJXQlduMmJWcnBPRjZEMld6OEZablhpQWxraElJK1M1Um1J?=
 =?utf-8?B?dUtwZG96WnB5TjV4bzVtTVhsU3RzMmNBSjBkaVdZdUtwVjY1YU02SWRXQjlz?=
 =?utf-8?B?cmV0RHdjdG5xNnVFZUs3dGFya2VzdktXVUs0UjFKMEJaYjRQcjlDL0JXWkRG?=
 =?utf-8?B?clRkNGF1NzFudWd2cHE0YlBHTEtsVXA1RFViNWFkbDl1UHZaVFNaU09TbzRU?=
 =?utf-8?B?QmNqbGc5bnBGb1U1OFNBbVpDR3VFbkMzOFZoWlhZc0tFNjRkenJOYjlSQlJU?=
 =?utf-8?B?MXdCMEYvZ3cwaVVsSko4QVNvTi9NV1ZSbkVJWTNSQkxBVkdYUU9jKy9OZWhP?=
 =?utf-8?B?OFZUSC96RlhwajBueCtuVUN1RURDeEZYeEN3MU91M2hzUzRVdE8vMGlkbWFX?=
 =?utf-8?B?dzU1QUFqTXZnR3lJOGVoYnhpRHJrQkdHRzZCbDdpVnBQc2l4U1J2a1A5K0Ra?=
 =?utf-8?B?d0lyRFhXbVNjc0JpbnUzbldaeUc1MkM4dXFPV05rRmhra096OTRWMWtLNWo2?=
 =?utf-8?Q?jP2gaGGocaK5uzWQV/3qN/rVI?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c4e5ef8-812c-4b8b-d2a0-08db552d06ec
X-MS-Exchange-CrossTenant-AuthSource: SG2PR03MB6730.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 10:13:28.5522
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xbm/e0INf4NEAXJCH/1vNZLiKO/Kvj2My2dRw78iliP2A5MFDNWHTJCy8S0WnupJB+nD88FWOw5dD/EJZc97BA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR03MB5574
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/5/15 18:06, Krzysztof Kozlowski wrote:
> [ EXTERNAL EMAIL ]
> 
> On 15/05/2023 09:57, Yu Tu wrote:
>>
>>
>> On 2023/5/15 15:35, Yu Tu wrote:
>>> Hi Krzysztof,
>>>       Thank you for your prompt reply.
>>>
>>> On 2023/5/15 14:32, Krzysztof Kozlowski wrote:
>>>> On 15/05/2023 05:15, Yu Tu wrote:
>>>>> Add the S4 PLL clock controller dt-bindings in the s4 SoC family.
>>>>>
>>>>> Signed-off-by: Yu Tu <yu.tu@amlogic.com>
>>>>
>>>> This is a friendly reminder during the review process.
>>>>
>>>> It looks like you received a tag and forgot to add it.
>>>>
>>>> If you do not know the process, here is a short explanation:
>>>> Please add Acked-by/Reviewed-by/Tested-by tags when posting new
>>>> versions. However, there's no need to repost patches *only* to add the
>>>> tags. The upstream maintainer will do that for acks received on the
>>>> version they apply.
>>>>
>>>> https://elixir.bootlin.com/linux/v5.17/source/Documentation/process/submitting-patches.rst#L540
>>>>
>>>> If a tag was not added on purpose, please state why and what changed.
>>>
>>> Yes. I don't know the process. So I need to add Reviewed-by: Rob Herring
>>> <robh@kernel.org>. And resend V8?
>>>
>>
>> I would like to ask you again by the way. I'm not sure if I can just add
>> the TAG. Because I actually changed the V8.
> 
> Your changelog in cover letter does not describe it. It only mentions
> vaguely "change patch series". Describe exactly what changed.

Okay. I will correct and resend this patch.

> 
> Best regards,
> Krzysztof
> 
