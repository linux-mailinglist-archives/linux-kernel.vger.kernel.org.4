Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB84265CDBE
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 08:41:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233315AbjADHlT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 02:41:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbjADHlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 02:41:17 -0500
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2084.outbound.protection.outlook.com [40.107.13.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23BCB109E
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 23:41:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jXePlQDNLD+KpKs+hC+i4CrcNP5sbZE0vyukJe3QASmlMRrGX/TGV61BZMPdykj1HtJO/SaKn3WVhi99UFtsUCpFJPiatyvpnIhjGnUiqsQ6YtgnL//mkoP8g9wbBD5KnzRsfD+0eVJSLSQT650JPQbHkG5anHsDeXG7gfYO0vgcQ2+uwGPaoozhv+DAhI/rIw4olmcIR76VTFi570xmzwJmKP2/kadcxeMaO61CceCkOsvN+/GuIZ6E6yngBwtG3iZm57x9a+9M9pht8Plfd7sRGLpgSuxwuHFt43j0sFvOnhkQsSG9Ai9tw1t3XKIc1SxvPQ02f0BCCFm+66YfxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WPsUv0hdeXobl/MHOYuB8r7mwyQ9gdSIR5qNlZuXkJk=;
 b=KvaZIzoS9nNBl5SVn83lYC/43Yz85CeeMuCDZqnPJC1EcOXGpOxIxaYUxWXd9He+2m3JWk+yiXQPlreZHNLt0EgcD2hqItAv7AEM0TBMR3rRFH163Wgr6E7tDOpXqcAhBPc8EzAsFKhnSpFpffYi0k8jr/gKeYffN/3TJilktb7ljU+S+muZPe8mmKxIzpf3DTdYgZ8s963S+Hmi47DkMq65JNIK9VNDGjrMXDCzqLXPfFgCfQ1a6o3ZDBe9a+WVZz5pSQoTUdqaFMT4UWNVhDWit5DVUOOulh0uledgfIXimh2U4iMTJIDK3/rTIlyyNYAlWbhy2XxtJ0oZyMnVSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WPsUv0hdeXobl/MHOYuB8r7mwyQ9gdSIR5qNlZuXkJk=;
 b=CLi8jFzM/0bgouLW1YI4zlFPIBX/35887ZrRGgDTl6JIqt/LPTV3k9ZFcu2Dz3MeIXvlJFDaamqjThFBscbzHF8pT28iZuahEnIDGKBhmpbow7u+jk+T0stGlBlGaIuz9V219R68RzkHvdp9yHRTZelY1a6AolaWuWa4amewG2VCl6nbuOncn4mWPMQT/yi9u1AJHaieRyvfV92vRB2MyjgKQhFwN2bcSqP++PWY9gSkMHVtSPxXdCcoc2+yVz9RXpi0BR9BOXqga/wzlARKGr+PU9sQkKlDzalES9bBP7mWFO6Hq6Xay5xs+HxSruhqa2s2WeulQ1kJfyIYS3m7Yw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB8PR10MB3321.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:f8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Wed, 4 Jan
 2023 07:41:13 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2957:50e8:8ce6:124a]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2957:50e8:8ce6:124a%9]) with mapi id 15.20.5944.019; Wed, 4 Jan 2023
 07:41:13 +0000
Message-ID: <daaf8c33-a981-25c5-2b23-38c59fd20ae2@siemens.com>
Date:   Wed, 4 Jan 2023 08:41:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [RFC PATCH 20/25] kvx: gdb: add kvx related gdb helpers
Content-Language: en-US
To:     Yann Sionneau <ysionneau@kalray.eu>
Cc:     Kieran Bingham <kbingham@kernel.org>, linux-kernel@vger.kernel.org,
        Clement Leger <clement.leger@bootlin.com>,
        Guillaume Thouvenin <gthouvenin@kalray.eu>,
        Dmitrii Bundin <dmitrii.bundin.a@gmail.com>
References: <20230103164359.24347-1-ysionneau@kalray.eu>
 <20230103164359.24347-21-ysionneau@kalray.eu>
From:   Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230103164359.24347-21-ysionneau@kalray.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0119.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB8PR10MB3321:EE_
X-MS-Office365-Filtering-Correlation-Id: d91c9376-595a-44ca-65c4-08daee270e0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x0eSphG2X2X1kKnJr/i3BfHTXjZWhTov++7NdhG98C2vFFB7/P2d8Bskat8JOpSm6xbcMX4P8gtRX36Q+kBp2WdK44di+KPPNaT98R2F1M7BRS+z+ZPmw9KioZ+QpppfskzuGpzsCDKm2eBKOOKB/K4yEjf10pT3tT8UYdFb7TZZccggw4eovZg+SHEt0q5XvanvIRfHENAA+ztQGCyECFOwVMZEkGTsrGZFaNxZi3vgF+5LB5MIuJNgrceIloD2zujDx3YexUarWTjSOSn4Eps7QEUKw5Mk90tEiJsfoLaTOVHkGJ4mTsM4wCPCopCN2ebc+qWnP6NLSnaEc74xY+ibkrca4gTKpe7TVAKSe4oWleBtcOPkwlURBMkBwcgnZrR/OD7HKt8IIbylkvDGdQowSKcrtraQvXdUASBUGdEO9Mk13WjIwEwiG/LitZEbrkteQJ3Uhul6hYEbw+tHDwtEX7p8YonsNNNGs7zWU5GCoZZJsS+bqzTeEuC5LvW4CYJBshTIShCk1EIey8a+uSxVUBG+7VCKyvgf+xt6JZxN+ujEB/CC+zbTY6CrmjnYj9C4JdyQUYjPQQOn3PagCQi5KKISE93LCxR7O7yqHZM8hmekb+DwVvPfbr0TxTGYieT1KL3IBfUaaJNsYhAtZAwSe5w77CU7gbdoIe3DVOR8OoIDnEpmpjgQsvdBGrUOZaHoWdHta1r7FiRzB3FRCj8S7mIm5Ux4N3V1Cp9g2Dw4lVArzUlRUiUdRZhJsQlmdudsKTly4UWrQ58s8Ejq9A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(366004)(39860400002)(346002)(136003)(451199015)(38100700002)(83380400001)(86362001)(31696002)(82960400001)(5660300002)(4744005)(44832011)(2906002)(66556008)(8936002)(8676002)(4326008)(66946007)(66476007)(41300700001)(2616005)(6512007)(186003)(6506007)(26005)(53546011)(6666004)(54906003)(6916009)(316002)(478600001)(966005)(6486002)(31686004)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L1dvYXlXdElUdFRlMzEyRm5OcGdQc0ExNjkvUTRJWGFsd0VWcThZRFA5Q3FJ?=
 =?utf-8?B?dHBIVFpENXNDUnF5OGNLNkFoNGdXOW8vOWJoMTVRY09wZ0RZbWl2dHhNaTlE?=
 =?utf-8?B?cEo2cXBIcWtoNGliRFdkK1VtOWlOZG9tcitKRzEvNDBlMXBwYVRUNW9DREtq?=
 =?utf-8?B?ZVRqVnEwZHIyYUhoRmliTW1JdkdnSktCcGw3Q2ZIOHhRdlc3VVZrbDR1MS9R?=
 =?utf-8?B?UUQ2VFJBS05kek0wMDFwWnAvaS9OREFSVVNGL29VUjhITlhKV3NJMGdodmVF?=
 =?utf-8?B?aEluKzdnL1YwMG9zeUlLc3BDSXRBRTJIWWJzSktwbllpVnRiRysyeFJwR0x2?=
 =?utf-8?B?eEhKT2dEUnY1QjlRYUNtYXFLMEdob1hwV2hia0FtQWVJOEIwTFVjUzV2aTJJ?=
 =?utf-8?B?Ny9YendqTmhpVkFhaUJOVDBpckozbU1lMFVBTlNNQVRQaGl3TWtldkpxdXZz?=
 =?utf-8?B?dHRyNlJhOWxpN3AyaWFibkxPY0U0SjNzdkQ3TjlqSXlwT1NTdkNwbXJ3S2Yr?=
 =?utf-8?B?Z1ovZUEzUWZHa2NNSmQ1Y0REazUycDl5dExmTWdFa3UvaHl5OUovSHlMcXA1?=
 =?utf-8?B?TVZaSWo1S0M1b1RaOTJEWDMyMDdvTkdndXMxdEVONWovR2dWMDUrYmV3aXJp?=
 =?utf-8?B?S0lzYmc4cmpVeS9UWENhTzFGcjZNZm9lWDRrQVl4d0hoY1lEVENWYkRocDJp?=
 =?utf-8?B?THkybDhtTzIvLys4RW50N0RvTVArbTBQaEhUWDNFRHBsbzFNa201SkJ6bFNG?=
 =?utf-8?B?Y0tLb2Nma2RWQ1pzUkNXbVA0a2JGUjArc2ZMTkV5Qis1SkNEQ3hncUowNDNr?=
 =?utf-8?B?ZSsveDl0TU93STlZb1NlRE43ZFlGcWo0Q08rTmwraHFMSlFpK0g0VTErak4y?=
 =?utf-8?B?OTV2SnQrV01FTDhYakVwQnBySmRma3ZZbFVJWm05RVY5ZjliQzU1Z1FtbUZE?=
 =?utf-8?B?YU1OVFQ0djEzKy82c1RZNU1aSFVuSk5yRDZDMWM3RmpPUmtKRTFaQUYxeG9X?=
 =?utf-8?B?em1iWGVBMXRTdERMaW03aWRQOVM2UVkvcUtYS2FmSHhBNktlYnR0N080UEp6?=
 =?utf-8?B?SkR5ZGFab1ExbXpPaFQ2RmhrbXFIUTFJWEVLcGdIdHdnTDFJTDBMTWNXWE1H?=
 =?utf-8?B?cjRLcndiY20wRDIvSWF4end1elpLbkt3bkV3ditUZ0N5ai84ZHpOWHcwejdD?=
 =?utf-8?B?RVhUSjZON0hjRDNYRVR0dlpNeG9wUURvbVAvNHNUcEZkMWk2V0djZVFCUzBC?=
 =?utf-8?B?MHlrZFBHZnRGdWcyK25oMUJ6eDJlaDA1QVZNaiswMkFZNkZ3N3BvU213M2Uv?=
 =?utf-8?B?UWIxc0RnWHJaTHhCWUY3b3VJaGF2SkVjSEZGSEtaR0QyVExRT0dkZHJjL0Nx?=
 =?utf-8?B?UnNTRC9QZUdWcnhTM1BHWDRIelFmS1VTYVpvOFVETlpJbG5iUVFEczZZdi82?=
 =?utf-8?B?STN6N2k1cC9DQ2h1YjViRGJSYXB1UjFDbXpFUWh6U0orOFcySGxHWit4RTVL?=
 =?utf-8?B?aW9JbmtycW1VYjd2ZEJja3pQSHZMOGgrVGMwUVNiQlBTSFU5U3BucUpmOFl2?=
 =?utf-8?B?ak5kRUdvaTB5VTNaN1dtSUhyYVR4WUJKdzMzbDM3K2R3cTZKeHZBZjl3eHAy?=
 =?utf-8?B?UXpEOE15cEVuS3VaUStjNmtENS9qaUVYWmpHdDlMam5saldXSmpsVmR4ekFG?=
 =?utf-8?B?T1pCWU1IeXNIRk5QQU1vekJWbnZIYWpYNkpDODZLR3FvbmcxYzVpSDlWR3pK?=
 =?utf-8?B?Z0MvSXFnVURWeUNHMHNlQmdNK1BxVkpJUXdZSzVzdWVBbnpKKyt5NFhCS0hG?=
 =?utf-8?B?enJLc254TEk2NGlQNHg1Wk11RTVidEYvcHBUalIrM1VFY3R0SkpNQXJSMlNT?=
 =?utf-8?B?OWI0ZC9nVE45c0ttUkFVSjBFZm02TUd5d0xRWGdoNFVlLytuelNPU3VQa0dw?=
 =?utf-8?B?b21IZ2ZpOTdpTTVZcjROQnV4T3U2eWo4ZXExZGUxMHVnN1FFYlhqQjFkeG5w?=
 =?utf-8?B?c0JwU0FuYXFzUkJFeGh5Y1hTSzFLcWVWSDlGUzNzNVRhamNlQkdVZzE4UTc5?=
 =?utf-8?B?SnFlS0xWQUdzdWZPWWt4czMzbWNySjBmbkhTNmgzeXA1OUlWWkhaQ3lhdldO?=
 =?utf-8?B?QTM5S1g3d3lsUGNuL1RGM0Z3NWJhWnNLbUw5WE1sY0FkdnFta2MxS2N3UlNW?=
 =?utf-8?B?Wnc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d91c9376-595a-44ca-65c4-08daee270e0b
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2023 07:41:13.4671
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nk5Mi5f1Zdx5SEcMX75ZgDJIJanNIYGnSrgDZ6SoBOKPabmZk+exTym4TwnQR6LEQNvvi+OSoJvSLWS46V+PbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3321
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03.01.23 17:43, Yann Sionneau wrote:
> Add kvx related gdb helpers:
> * lx-kvx-tlb-access
> * lx-kvx-tlb-decode
> * lx-kvx-page-table-walk
> * lx-kvx-virt-to-phys

Dmitrii just proposed translate-vm [1], just x86-only so far. Would be
good to use that scheme, maybe even watch out for chances to factor out
arch-independent logic if there is any.

In general, it would be good to define helpers that can be implemented
by other archs as well and stay away from "lx-<my-special-arch>-*"
unless there is really something valuable to add that only makes sense
for that arch.

Jan

[1]
https://lore.kernel.org/lkml/20230102171014.31408-1-dmitrii.bundin.a@gmail.com/

-- 
Siemens AG, Technology
Competence Center Embedded Linux

