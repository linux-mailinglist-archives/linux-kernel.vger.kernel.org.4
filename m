Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23D1760310B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 18:51:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbiJRQvm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 12:51:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbiJRQvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 12:51:39 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2040.outbound.protection.outlook.com [40.107.94.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED3D15FD2;
        Tue, 18 Oct 2022 09:51:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kJXgrnDEnq192B7qDn0gWmS1sXvgiWOLapvalcQ9UMpS51SA/eG7QkG10y0fis/bsAP8IhE+BCrSKvFWmEkWenZibTfrJ9db1H6mkH6wYle1Y2gWMGwyTBN4vh2atBefKCm+3SddlnaXsbQX8BlZtiotmhIWS+CCjeXkVK6fZDwTl+Wj/I8zr8NSub1qcMftbmZIz2dCY4RrCYGBKkU4A95AOIx4Rpzlx4+0BqwYvXnMyWqcWcjf6sVvxWc7V1wYiU0czVY90cZ734CcprJdRL92KaQfVd1AhaJAqSZyTw8sa7oCtNnclu+MNc+UaHh0XzQwTUKVqxjvMS5lFCKu8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sYevjcgDBB1A2YA642PTe5sPCv/P3D8BmdhA+vmpyRM=;
 b=DnFxg8Lh95xxDtOtxn1arKNNwcgquhkHqKbsJs1jdID0Q2yQBNRsC2HRFfjp5p0roXcQQm7uuYFOaa70K1A7a7OUCfq/ihRB1SCXTKb/VuDzXjqqtPxvWk9lO1GY3k6ZRH7KEHTKawjwBBLPXl2HszlfFqbESoCr0lLy999gd/nwLTrVligbua0gcoQcqZoY6tJaHGkhZZ3pRmQjs9bJuLqxqXoUzCBWpCzocCljFE3G/sbrhDXO1fB8vXy+tGUujOGdYLuU+kEpBEnc9a0kem/ZWOCjxCDNGJ+qxFcb/WrrwkrlVCjcPE/bswIVlRs9TiMo0s0CcgrWtcVlGXzBnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sYevjcgDBB1A2YA642PTe5sPCv/P3D8BmdhA+vmpyRM=;
 b=RiLUY4bHgYspUTlP7x9t/9FfK7UPqR6MbhHDY1KZMsGNsZDGPij003qAM0oxxdzMpu9A6z+Q19QOeBszPcMQZgETEdOIwaNggeG4/46Gk5EmRICx9jJX64N652FHLigfIle6tgfpJ8q5VGQzKkZ+hajNn8WN4hNVlzSccwqXjwQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by PH7PR12MB7140.namprd12.prod.outlook.com (2603:10b6:510:200::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Tue, 18 Oct
 2022 16:51:35 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::2d5:77ac:6d39:e57b]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::2d5:77ac:6d39:e57b%7]) with mapi id 15.20.5723.033; Tue, 18 Oct 2022
 16:51:35 +0000
Message-ID: <8e663956-53ef-5c2a-b970-c39b446a1140@amd.com>
Date:   Tue, 18 Oct 2022 11:51:30 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v5 0/2] x86/resctrl: Fix min_cbm_bits for AMD and code
 cleanup
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>,
        Reinette Chatre <reinette.chatre@intel.com>
Cc:     tglx@linutronix.de, mingo@redhat.com,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, fenghua.yu@intel.com,
        hpa@zytor.com, paulmck@kernel.org, akpm@linux-foundation.org,
        quic_neeraju@quicinc.com, rdunlap@infradead.org,
        damien.lemoal@opensource.wdc.com, songmuchun@bytedance.com,
        peterz@infradead.org, jpoimboe@kernel.org, pbonzini@redhat.com,
        chang.seok.bae@intel.com, pawan.kumar.gupta@linux.intel.com,
        jmattson@google.com, daniel.sneddon@linux.intel.com,
        sandipan.das@amd.com, tony.luck@intel.com, james.morse@arm.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        bagasdotme@gmail.com, eranian@google.com,
        Jonathan Corbet <corbet@lwn.net>
References: <166430959655.372014.14294247239089851375.stgit@bmoger-ubuntu>
 <703e6dfd-68d6-6def-183d-fb99b39692b3@intel.com> <Y07VzWTRpSnpbuc2@zn.tnic>
 <fe3baf5f-1536-46d7-9472-5ab908b8f4f2@intel.com> <Y07Yp4C6Qkk8lt/b@zn.tnic>
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <Y07Yp4C6Qkk8lt/b@zn.tnic>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0034.namprd03.prod.outlook.com
 (2603:10b6:610:b3::9) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|PH7PR12MB7140:EE_
X-MS-Office365-Filtering-Correlation-Id: 78260658-d8be-436e-7895-08dab1290467
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wjhqp5BKNLzLmoYcBRl+Frl1iIWJfQHela+55yuCStbe/8Qmu39n4ticvBUPR8WV2tZBKe0lTy9oBPIkiBa1+nTYgzYLLRXtKWmyh6LG/LdMY/wJUwZ0uzCQPWmtD1/VBFU0FwXOyIDpVP7uZvcI4Q53mYMD+AoFWJO2wnzfQaQMr0SDLKMm2SCjcZanzUuCyAKm52B6qtT/Y6649gzE5TBoidXkTJnXNg2v62s7S+N27FZcendb95211kAbLN9exW4PyTglx8sBVGTclTw83eGihEb/bxXsxNo1KDB+p7Ahuv8tQvxcR0CCm4x2evlDaFnCEDUR87XeU/24ELo5DJdFuEv7uouo00xsoFeeavB2SQj18SoV5bVSnIzm8VVs1kyCgY6GZj4asL1IHNwAcwP4j8/ZwNBhk9fu/PeKLA3FmGRrpxsXClXG7EyrZ5CyiQTWIwWER9965dUDlqUFNN3z0ObuDW00TCTmuZ8OG5bV1YWMJ7gHBtChNm7H6cujgKRLmPanRhS1f0r9xH/D0l6hp5M3AI6qwgWTYR471FJp9sarsSu9WR6SSjGitbRjF/dMducGlqdkJ5NKK7pEiK8zte+rsE0NwVPKKCKbiFpgnnqf/82s2iNzrC7a8uBJePnvTZgHbE8zMtqcA6pFiubt2gqu7Lfl6ho6HLrt5URmCrYXTbJrDeGA9lSblChwjYXUH7Xr7VQyAvs8nluRt4FchtVQJnbjTakgokZkVx3gI3nXgdsVuCjWh7hLdRp3K0oIwq6S0MbQiZregZMBG3UZKxq9Llv8BmZheveBJI8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(366004)(376002)(346002)(396003)(451199015)(36756003)(558084003)(31686004)(38100700002)(86362001)(31696002)(5660300002)(3450700001)(7416002)(2906002)(2616005)(186003)(54906003)(53546011)(316002)(6506007)(6512007)(478600001)(6486002)(26005)(110136005)(41300700001)(66556008)(66476007)(66946007)(4326008)(8936002)(6666004)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eThjS3lxbnNBV1FzdVFYMDVkdEh5ZXNERUNoUzJndTJrdnd1TDYvMXdXbG5C?=
 =?utf-8?B?Tm9MUWdPL0E0OHEvbHdOeHRnOERON0V4aE5WdU0yZ1NMWlBrWVpFVStNYlVw?=
 =?utf-8?B?N2UzWWJaT0lLUmtIek5URllWcitFdFNMR21EZ3BXSUJqZENuY3Rab2sxK2Rj?=
 =?utf-8?B?ZU5lLzdIODRwRlBaMXpMcW1Na2FzaFlhS21jNTJVVkw4UmFEcXZJc28ya1NF?=
 =?utf-8?B?bkhENWVQYmtTdVpvcnVDanRMOEo2S2VlQnhOazEwNDBkVkVUZllTTitIL3Rq?=
 =?utf-8?B?VURtY0cxZzVGZHhZOFB2bDVhbjY4cEJKbWFBMlRxbGxXa0lPL3htdUt4b2lj?=
 =?utf-8?B?ckw2V2tsNjByTmk5TlBXSjROQ2hMNHFFRDlEOVNzaFg3bVVZMjJiaUUxa1Nm?=
 =?utf-8?B?ZXlZZWxKMTB1VHRtYWRGUHErWnNheFQzdmppVHp4dzZXaGVBL0xETmV2YnAr?=
 =?utf-8?B?bENXR21GdW9Qc2RVbUU1dytUcFpseVZTQ0g4OGhUTTJoMUFSQ2NZaVpBTGMw?=
 =?utf-8?B?bWtxaDdKOGdqWU55aWdwZzNMTHAybE40NVBMZkU3N0tLOHlKV0RaT25RTk0y?=
 =?utf-8?B?eERqbEpqamVUb2JnYTh6QzNmYUtpWU1ISS93TVBRSFE0RVpyZGNVbitVaVJj?=
 =?utf-8?B?K2RUbWtvdzIyQU5EVXdEcFE4N2JydHF2L3RVeWwrV1lhVEp5T2hMbzhVdkNB?=
 =?utf-8?B?QTQ1eEEzVGg5d0Y2ZkoyUis2OFZGbUY2N2VFNlhWNENYTTdUVXIrWlpnbHl2?=
 =?utf-8?B?cFFIMVN3anJJU2NuZnYwN214S254L2NaV1hoNTVtL3o5dWIyTi9nb3F5cUhh?=
 =?utf-8?B?UmpqUGtkd2ZIVGVOeUtuajV0cmdWZjJHRkUvckdSUERFeGQzcEVYOHdkbjBw?=
 =?utf-8?B?TWRaLzZjd2pLdHhaNnlDb011Z25EaDd3OWtRTjJkMmpnY2E1SisxeGhQd1VX?=
 =?utf-8?B?Vlhnek9wVDZyckI4S25NbVlaeWZucjN2RWZ2TEY5MG03R0hpNzJBZW80WUtk?=
 =?utf-8?B?VlFOUDRnUUlvaXJLMkRIY0FBYWlWaGJsd2JUS1RBZjZvV2pEaXNpOHZYNjdR?=
 =?utf-8?B?MERFcm1FcklnQTVmeUFQZFBKQ0ttS0g4blltVi9GakRjV2UvVXZ3bEFRdGNn?=
 =?utf-8?B?S2pIU2NNelVwbXZvb0wwYjNNQXJybDRudC95cmFOSlBISmZCYXpOSXNuY1ZM?=
 =?utf-8?B?M0pJb3E5d0JkMHdMbzNUQm11cHdLY2p0RFVQMkx4eTZWSDI0d1R2VWpraTNT?=
 =?utf-8?B?Um5ET0F0L1JNQVVEdkdmUVN0TkZiZExvL014UmNEVXZtbDBHTE56N0ZXcDRF?=
 =?utf-8?B?ak9rRUFEYk4xUThoeDJNT3lFOWVJa0crZ2ZvR29ndXNIR2VxK0x3d2RrTC83?=
 =?utf-8?B?dzBDS0pLNzR1aWtLNldrODNYWjNhTWNIaG5kYyszWVJIY0FqQW5PV0xsQmNt?=
 =?utf-8?B?OXRIYWR1Y2hkK0R0UXN0WXRaZ1lBWlJyeTRGMzBFaSszQVp1dGduMmJDUlBK?=
 =?utf-8?B?N1FwL0JWV3FNR3ZyTmlLZEtOTy9ScDlmNXcrL29jMUtyN0sxYWdxdW9yeVQ0?=
 =?utf-8?B?MzRkK2krcjZtMDFtMU5ZQkVaOFVkWHNmakxYUUQ1Ym1UZWFWSmRDS3NpNGFC?=
 =?utf-8?B?Sk55K0xON01MVmRRYXFrOS9TVlZ5K0FUczVkVVkyUWZVZkhkb0M4dXgwZk8w?=
 =?utf-8?B?S3JIaklpWFNPNld3b2dPSGZZbHJlbFBWemptREVCYUpuaWM2NVNKQTZuZHh0?=
 =?utf-8?B?WmRSR2h4Zk45MmhQOVkzam1WbldzdFdMZEk4K3NGS2JydEV5OGl4U3lVSGpz?=
 =?utf-8?B?L0xtUU1hWmFUd2dCYVRJaU5Gek42ck1BU2hYUzU2azdwQVp2NTFya3NvYWJq?=
 =?utf-8?B?VWR3OGFRNEtncUpXNno5cktHMWpoS3lzc1hkSUxLT1hzbUFGTXBNakUrdE03?=
 =?utf-8?B?T3V4UVUvMTBrUE5LcmhWd08wTDY3SWt6N0k2QXFZOHBiQ0lJajVFMkh4NWV2?=
 =?utf-8?B?V2c4bzdvbXU1VXZROCt3SmxEY0NEZE9IUmsvUStVbVNleUpqYUtmWWVJVDZG?=
 =?utf-8?B?OVJOWGljVXdCNm5sZmVPenRjMUpNdUFrYTcvWVRTaWtWbkVNU0JuaVp2OVl1?=
 =?utf-8?Q?J2Gu0op8ha+3kB+2xULV7fijq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78260658-d8be-436e-7895-08dab1290467
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2022 16:51:35.5136
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v0F4Nmdt6WDnL+KplDGm0lw/6EZJN02ZqNshom6Y7DP4UMcGYGRi+9ZAXgvguCX0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7140
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/18/22 11:47, Borislav Petkov wrote:
> On Tue, Oct 18, 2022 at 09:43:15AM -0700, Reinette Chatre wrote:
>> Correct. Apologies for missing the "Cc: stable@vger.kernel.org" in
>> that one.
> Nothing to apologize, all good.
>
> Lemme take care of them.
>
Thank you Reinette, Boris.
