Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55B0F73F449
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 08:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbjF0GNy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 02:13:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbjF0GNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 02:13:51 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2097.outbound.protection.outlook.com [40.107.215.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90E4F10DA;
        Mon, 26 Jun 2023 23:13:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J/vFo5tLzYaEXfPBSFvm95f3rLeGoiFkTMTlEfu5Wh5g75nZdtM+t7IIv7pLpxdLZym98X09wZGE68XKYkmkBtWWO4s1zNZ1Z5M9R53fGJZglNuJzmrYFmIIrhXN0M+R7M2WnRXH507jfVgJixlcQ8V9nwe5Qlz8HMFNGnqqv1Rbe43zTyiZnJ/nbfBoCxSPDGqOYZUqwfDulm05OaeNGi19R6rA3t/KAj/+bziahi4zoR0Mju5bhFAylywyyfh1tRWp8ib8RQ/9zzyC9PCNybWK/uWOInGFLdfvJkq3rITJ0weutaGbGHi7DpuSZlXSv+HNWXVhddIwJkTaQLzsEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ht4upb8gJ+rQSGKzS0kgkYxjcmvJuEWtML6mTgDgCns=;
 b=jANuyYiIgu4JBDywicS67k10W1KKvao7xHO2PEpRvj8BrtUcu62XwesSuSPD5Ujc4sYrdWPDleN6bt0e3hk2qA2I+HR5c56UptlC45Mtn5YcJFaBGcjowyHC9aznA4WxRbkNRkskPHW6RU7iQ+l7ErDInu0w3dqUB1/idjSq+hcR4qnTQME+MMsB2RRG+csxM1CXzkTPe3d6gKozdcnx2brVqMHJ1K7gw/aJfEJLROgQpgR7ZYUDk/nWQxKZuiJMEgKOmhrPSsb45Z2baTCoQ34HMtuWYPAcg72PnASIQ7Ddkrywexg1WXMfYcIcYNVhnlxOVmugtuR5CJVtLjyUhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ht4upb8gJ+rQSGKzS0kgkYxjcmvJuEWtML6mTgDgCns=;
 b=f5tgiGxgcM4AN+EqnqWf2eNI4AwCMNf7P2AasFaW4PSaQeOtpWE9iydkygr/3ufJfg4tyK4Ae600nifoKXqXLvaZndIBVc/UqIOY4c82aYrr2ITJKnd7aazqkQJAYn7IDTHvhkEPwAXFE7oN5cDD22rpG7Ox8ZYIqRtbNaEOmTsbKdCDH4TdUOHTCmDh4wboEQRRGWMH3z6vLPhCJniMUfgk86s0tp5XddDZYgTfvb+Qcd6hbWAzze50laK7u3hto5m2ZasHeV5p1eHGsGd0IsMJM63ljdQ5zl/lYtMjMZCA26ONQg4cFXX9PmYD3zaDB9vHFutS8P/TB7XXjWdjIQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com (2603:1096:400:289::14)
 by KL1PR03MB5807.apcprd03.prod.outlook.com (2603:1096:820:80::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Tue, 27 Jun
 2023 06:13:45 +0000
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::e659:543b:2ac9:8fd7]) by TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::e659:543b:2ac9:8fd7%3]) with mapi id 15.20.6521.026; Tue, 27 Jun 2023
 06:13:44 +0000
Message-ID: <676db602-54d8-d6b0-274f-365e65a2102c@amlogic.com>
Date:   Tue, 27 Jun 2023 14:13:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 0/2] Baisc devicetree support for Amlogic T7
Content-Language: en-US
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Lucas Tanure <tanure@linux.com>
References: <20230626095223.721011-1-xianwei.zhao@amlogic.com>
 <20230626-viewless-marrow-17838c2172f6@wendy>
From:   Xianwei Zhao <xianwei.zhao@amlogic.com>
In-Reply-To: <20230626-viewless-marrow-17838c2172f6@wendy>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0004.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::22) To TYZPR03MB6896.apcprd03.prod.outlook.com
 (2603:1096:400:289::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB6896:EE_|KL1PR03MB5807:EE_
X-MS-Office365-Filtering-Correlation-Id: af5c54d6-ca40-435c-5a3c-08db76d5a8d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fzFfHYNZyVvVsyjBS0XhZlGfbGvGVZJke+w8UYVFERxjON2NpQjR9h8E7arXhWSXJoMZh0n4syiEbiZxHKp6kIN9zXOcQMb/R5YbWcg82/g+rQIu+J8iMJBei2KtR6wnE6ofagulvB7vjwP2ZxJqujzyYL10gD7HfNdIroOr7Wmq0CqSC5/7zwphijXGHrgN19CugmwqfCuBxZUiPOLoXOms8P3DND5AYiARU52IBswY7tp8qWTFqtJ6iBUvYwognUIc3Ly5FLDv/CsqVoRy8Of/nAn0ZbLhBsgOw8Go7g1RNQgV1IAb5ThGzo0xOVpnOXufefZTUrRhwfxloD5EILJBlw32d3nUugIQHwRUz7fA/AzEot0x3EXEruOAQrKWVL4250HOZ7k0IerGx4wc+PVQfe6xZyZylzocUIAL6Uz9dY99ZOpDvIII/R+Y6lCnvYbu7wit6RCOgwcXE0ZVOLHn8mvDb7Ff7ho6MQT+1ggrtHTETzHhE5Rdrp+9bR0AH6bUF3apJvkvlIlUaiSKcVMTA7gI/m7FqZftavUAYOpu0si36YKInE9g4ZGGpZUXA5kY07Yk0aK1nulcX6R8iyO3oOTGJ4Jy5T1VAUMgeMuyCXv6/cWAmCrbJCzipI8oGK2z+EQKhWcoaQ4xUswqTTSwTHaNXN2ZM7s8c3IzLwqt1sSoxWm6wec7H2gW9pL3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6896.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(396003)(346002)(376002)(39850400004)(451199021)(31686004)(26005)(36756003)(6916009)(44832011)(5660300002)(7416002)(4326008)(41300700001)(8936002)(66556008)(66946007)(66476007)(86362001)(38100700002)(31696002)(316002)(8676002)(966005)(6486002)(6506007)(6512007)(53546011)(186003)(6666004)(2906002)(54906003)(478600001)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UzN0bkhzVUMwYUptS0s2Q3p3YkpqRXBvVjlIM1J1YWtXLzB1U21kSFZyZytG?=
 =?utf-8?B?aG52WEVWdGZaK0tVbldiQVRIcW9zdHovYjIybVBYeVhnSkZGTno2ZTNNZ1Qw?=
 =?utf-8?B?S2ZoRTFXQkdCd2IwWTdqQ0V6UFgwYkdFcWwxMFpwNjR4NTMxREtsTWNmWVVE?=
 =?utf-8?B?TmI1elVuVCs0bWk2bk5WalVNeU12UTJnODFhM1NucXZzTFJZbTkvSksvaDIy?=
 =?utf-8?B?UFIvNXJSTnVHVFBwbkgrMUhEaXlZVml1RzVNN2xFVnBRNDdxMkV0RFVtTXRK?=
 =?utf-8?B?VzNyZm9hVlNDb1Q1VkpXU2JlSVJJaDBEQmNZMnYxbHdtREltVzFyRHRSaGZH?=
 =?utf-8?B?cmxwT25GK3p6Q28xTXpBUFZ0enpFVndXZFBNdU5lR0NJSkl1dkt5c0xPZkNM?=
 =?utf-8?B?S2lRbEtPVUZOMEdhTitHb3gva01KdVVJWllpS2dEalB1cGg2VCtnZXRjVWgz?=
 =?utf-8?B?SUJ2U0sybzV4WXQ2RnZOMDY4WUg3ZlZBY1lFMlJNU3ByZDBtdTNlVmdJeWpJ?=
 =?utf-8?B?emllUTFEdExsMkswS09rYmhiOWgzTFBOQ1Q1UVRUekNqTlkyZEJuMzR2MExL?=
 =?utf-8?B?OHphb3FIQlZCSkhTNDVJZWNlTDNiMVVLYlZxZWZhWHFBSTVhQWQ5UTMvOUxX?=
 =?utf-8?B?U1BXMWtQUURYekQ1dFlBekd1UmlZKzNlN1RmRUorbm1zc29WQU1YUDVtREta?=
 =?utf-8?B?aGNhZmQ1YWFnVThQc3pqSjU1ZzJPY0NoSXJSNkprK29hbzMyTDA0TDRzWEZ5?=
 =?utf-8?B?Q1RuWFJuUmFDY3c1ZWFId2ZrZEVqNjhjRDJBR2ZXV2xWZEhFMmJnbVd3V1ov?=
 =?utf-8?B?RUJ5Uk92RHdiVkt0c3JWN2ttRFhodXloYmNlay8zOGwrRHNBZmpnNlJFL3Rj?=
 =?utf-8?B?VTRFN3hPZXQ5NkdTTUNYaXI0Zk1YWDBNejNEQVhkRWx6OXhBejRLYmdJS2tK?=
 =?utf-8?B?RWttbFhvRVBOTG04ajBMTnp4cFY5bzZ5SWNRQU9TcXgwWWwyMXVaZ2o2UWtk?=
 =?utf-8?B?UWpwd3BjNHVJR2pNeEowV1dRRXdwOVIvMUJkckx4eGdmcTRNalRMM2JlUUpM?=
 =?utf-8?B?OXJBSnA3cW84cUNvblZuL3RFY21kdVl3S0REVDEzdkNTb0pWSTNITkRYaTlk?=
 =?utf-8?B?UnVEU3VHZVNKMHNqejhaMERvampWV21tc0JWcnR5ZGpvcC95djJUYlJkTGdo?=
 =?utf-8?B?TE9PQ3Q0c3F4bjF1R25zMGJxYTlMYW5YZFMyRzNBR1lkaU5nWTVNZitaQU5v?=
 =?utf-8?B?bWppd2kxZGFvcU53VWd2SFN3K1Y4cVJlZmxaMW9CZkhWVnJVYy91VEEwcnI5?=
 =?utf-8?B?aGxFc0dTZHlVNjdmVnBEMDc3bDFMa2NDWEliZEFVY3hLVjdOYlgwbzNEdEln?=
 =?utf-8?B?Y2R6YW95enp2bmEyUjRRY2lHSFZWUjdmWTFJNG1BeitrSkRBemxZamdWc0Uw?=
 =?utf-8?B?Q1ZiYmsyL2JPcE0wTFhaNHAzUkllWjRNRmlvOUREb1c4eXRWSmYxTmN5LzVj?=
 =?utf-8?B?RDRPUkhRQzN5MWtFK0N6WW1abDVxVUpoc1FGU1drM2xJNEZxQjZQaUF2WGxS?=
 =?utf-8?B?UEYxMUYwUy9JcG5DczVyWE9iazlFa3NWSzRNdlpqL1dpaVg5UjZ2bnZkMHU5?=
 =?utf-8?B?QzZkSFNHRXNvK3dkU1M4Z0NIKzRBVlE2Z0ZjbTJzRXZ3NlcxRXBwRUd5WDA0?=
 =?utf-8?B?UTVPMVVWUml3OUpyVkZUaWVsdmRkM0ZmQTFFN3U3NWFCTlpURTZCQ2JHaC9G?=
 =?utf-8?B?MW95S1BGMnN3SUlKaXVPV3ZvOFNURmhWa1pWYTdtRktWZ2JGM0QxckhrSm9O?=
 =?utf-8?B?dGZRblovTmpSSHZZSVF6TzRFQXVVa2xzSWNZeEpJU1B1UmY3Z3hCZ1c4UzIx?=
 =?utf-8?B?QzBZd1Q4TjU0eVZKTm4wTE01UVBhbWRkcDlqZjYycWlGMk5kZ0NERGlzcStG?=
 =?utf-8?B?OGRjZUtMY2ZBbGJTL2dsV2t5RHVpdkoxeU52WUlpQnV1aUZoOTFBaWtnWnJy?=
 =?utf-8?B?N2VCZHpSNndTY0NHWmFjZXl0SzNoK2pKNUtiSkpZV1dQRWFPTkEycjQ2NU9w?=
 =?utf-8?B?RCtHbzRLWW1pcUdJUnpCN252UjVRaURNdzBKWHMzMUU4VFI3WHV5NHZmYTZs?=
 =?utf-8?B?SFNESzJseFFWdGhqSVNTTkExMHh2aEgwb3lBN0RrdXRTSWVBUWh3cjJOQUlZ?=
 =?utf-8?B?YlE9PQ==?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af5c54d6-ca40-435c-5a3c-08db76d5a8d2
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6896.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 06:13:43.9409
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /MGhE0SzyWdKl/ffMmP4f93fop5eJ4M7WF2J6R5KYAlZAEauQbTVbc6DeAqUBJpV6VDbdkIu3JIIFqMJIHeGhIeUWtY6scmlUO/TCwQh/JQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB5807
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Conor,
     Thanks for you reply.
On 2023/6/26 18:02, Conor Dooley wrote:


 > [ EXTERNAL EMAIL ]
 >
 > Hey,
 >
 > On Mon, Jun 26, 2023 at 05:52:21PM +0800, Xianwei Zhao wrote:
 >> T7 is an advanced application processor designed for smart display.
 >>
 >> Add the new T7 SoC/board device tree bindings.
 >>
 >> Add basic support for the T7 based Amlogic AN400 board, which describes
 >> the following components: CPU, GIC, IRQ, Timer, UART. It's capable of
 >> booting up into the serial console.
 >
 > Lucas has already sent patches for the T7 SoC & is at v5:
 > 
https://lore.kernel.org/linux-devicetree/20230623081242.109131-1-tanure@linux.com/
 >
 > There's been a bit of discussion there, and there serial stuff in
 > particular is different in his series (it doesn't use always-on for
 > examples).
 > Could you please go and take a look at his series?
 >
 > Cheers,
 > Conor.
 >
AN400 is the reference board designed by Amlogic, which is different 
from Khadas VIM4.
And T7 serial is the same as S4, so I follow S4 serial.

 >>
 >> Xianwei Zhao (2):
 >>    dt-bindings: arm: amlogic: add T7 based AN400 bindings
 >>    arm64: dts: add support for T7 based Amlogic AN400
 >>
 >>   .../devicetree/bindings/arm/amlogic.yaml      |   6 +
 >>   arch/arm64/boot/dts/amlogic/Makefile          |   1 +
 >>   .../dts/amlogic/amlogic-t7-a311d2-an400.dts   |  30 ++++
 >>   arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi   | 156 ++++++++++++++++++
 >>   4 files changed, 193 insertions(+)
 >> create mode 100644 
arch/arm64/boot/dts/amlogic/amlogic-t7-a311d2-an400.dts
 >> create mode 100644 arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi
 >>
 >>
 >> base-commit: 057889cb4244096ea5abcbe76ffd4d311c3078fe
 >> --
 >> 2.37.1
 >>
 >>
 >> _______________________________________________
 >> linux-amlogic mailing list
 >> linux-amlogic@lists.infradead.org
 >> http://lists.infradead.org/mailman/listinfo/linux-amlogic
