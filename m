Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19D477432B5
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 04:22:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231315AbjF3CW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 22:22:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbjF3CWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 22:22:54 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2091.outbound.protection.outlook.com [40.107.255.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A1A83585;
        Thu, 29 Jun 2023 19:22:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pi36LLM5zBzQ+uUIzFLA+W5RymdovLw6+muV0CUAOTxvvGdR82/79dP5QzcoG2CNba1L4nInnyyIUS0lCo7beC2F5QtvCqZqs5Y5bIfsTOgunAklxFjFSxmW3v/LATl57/mUW1ouKObu5gEV6ef7LA6TEhOTlg2quPEQl8bShSEg/YFTEypPjr2a/Kqj46HyWLy/zhxWa0FcPPDD1GDxsmiIIM0NN1fSseYsz9qafnTbIdBg/thOK6PDFOUyIAIgexh1TMbUlF0af3zxENrY5Hvggh0HTjq4TYTFTeTlX+zmlpJhY3CzBGsmbg+ZVAjXeXlA48qullrwbUqQfCUwbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K0w9AJ2mnjEmNTjuc8SnDGhajtMJ/KdiuL/7nNAlXAQ=;
 b=A/x0hZtxfCU/Nk3lkmGDExotcs5rfKETULWjTvHhdzEPZcGI54b4V2E5sSpo48XNxZl9zzsfhg5MDqBToEtbQdUds0X0UBwGwpsXOIKFKYyQNWL8mNkO4ACl1QTB9cdY0gEh6Rs7FXqxqbqsJOc7YLDva4iQE/dTVdUt3MKDRKGzILx9vYdY4ye7CJtosYEV+cBgCPrVQ8SAN4UI/WrTt3T/9ytOQrh8Sz/aGcqlo3KnWnOvrdUCk6cNXGAGeBzYOf2vO58gJVL8+yRFx+Stl0qQGOcLNig+z9vv1dizqcf10QhB3YJ5KBBclTdPo4mZly1r/GZ0xcCqnLsXAgKReQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K0w9AJ2mnjEmNTjuc8SnDGhajtMJ/KdiuL/7nNAlXAQ=;
 b=vS3ArCQ8GipcBpXC6Emxc1JriGs97Nzu231EHAzFdjTx6I8MXzTVhQXxcBovAPjAgG6REKg57nZ+BwENuXUPHWPvjtVDxjctmUkNtgRtDzGQqEibGloMkLMrMANpq4XOEwk+w/jFVhdexp2++0s4NrmASy8+QYe9ZRXv2Kg8HKTSNjJYn+z8COZBE+AdIBNu1W7MplH3V2IyzEbOfurwBE+hZLvMabgKxkrtpgL9yH3JG454ifIbiA3IVHgIYO0HFieAf3KkTIz1IaueLGEeJOMfanXCdEuLw/deEFkj9gvforX8C+ZKXOKYD0/xu5054BVG/caP8js6d9rv5iCFJg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com (2603:1096:400:289::14)
 by SI2PR03MB5915.apcprd03.prod.outlook.com (2603:1096:4:147::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Fri, 30 Jun
 2023 02:22:01 +0000
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::e659:543b:2ac9:8fd7]) by TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::e659:543b:2ac9:8fd7%3]) with mapi id 15.20.6521.026; Fri, 30 Jun 2023
 02:22:01 +0000
Message-ID: <0b4b67aa-e8f5-2bd9-223b-0f26add687fe@amlogic.com>
Date:   Fri, 30 Jun 2023 10:21:51 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 0/2] Baisc devicetree support for Amlogic T7
Content-Language: en-US
To:     tanure@linux.com
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
References: <20230626095223.721011-1-xianwei.zhao@amlogic.com>
 <20230626-viewless-marrow-17838c2172f6@wendy>
 <676db602-54d8-d6b0-274f-365e65a2102c@amlogic.com>
 <20230627-unsure-uniformly-079cad2c26e6@wendy>
 <061bb829-fb75-d154-0c15-9f0f982fec41@amlogic.com>
 <CAJX_Q+0Kf3zFyUtkCEkm7K8zXwaovxQmo1DWFwy8y25GQ2wqXg@mail.gmail.com>
From:   Xianwei Zhao <xianwei.zhao@amlogic.com>
In-Reply-To: <CAJX_Q+0Kf3zFyUtkCEkm7K8zXwaovxQmo1DWFwy8y25GQ2wqXg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2P153CA0033.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::21) To TYZPR03MB6896.apcprd03.prod.outlook.com
 (2603:1096:400:289::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB6896:EE_|SI2PR03MB5915:EE_
X-MS-Office365-Filtering-Correlation-Id: 781e95ba-6ec0-4493-b594-08db7910c8fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rlc2VKhL9Jdgnwc0//EI7HYkHMuiSK5v1bwJ5f4h96aF0CEYtQic55ldZ/3yZhK2xaYDnwzNZ6asmDt4T51LixB/fn0bWJOJ5lWbvYiz/0L7pKZPyPUBggpMkWlPgDHJaq9PW2nYhgTfWDi2CJSSE8+NZVq7p/TGT4Uc0YVsfXKNkr2P4jBRgEFCRcWwu0+NPsf3LMSwU4KnqeONucq3ipzmpUMej6xW1D04IB8ZTGJaLxBRZF4qE6G7rkZBcXiNxI/BoqJefv69wa1/wnG5xCke0N6FWCWpbE4+jSpbnoYF/ZgtRJtX9Zpx1n0BWDSVm9rMN7a4s9fIMS0efCViPt57hhopbIgUpm5Nk6+8CkkNIpPjW5GFbWPN0lWmMnd4PEjJd++xLxbXozCnSF0/8T2j6NnRz1AGG9DCwL/AR+2iRXL2pBC03ib0xQyV92ktDvzpUoqEQ+qoonRC0nBgcwKHWdwkavY1CHqMkCjWIx66tlXSs5G9JBF5lZ8b6xp50BL9JGMbpS97UW4ciAKmKtvgcYql3ynoDSj1x6tY31PDOxWmd6/ORlWK1I8UFUrzqUdDT9KVPLWNmsfs6Kfig/tOxIouuNKT/9V2Ze8J6lppoJs7Bo/S5xTq4fu+AFZetBzZmYejbksIeGCsyVhO0xxmMkEiGaPYrsbZIIszmDCw6dAefl0qhR6grUJUAScV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6896.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39850400004)(396003)(376002)(366004)(136003)(346002)(451199021)(31686004)(6506007)(7416002)(5660300002)(44832011)(6916009)(66556008)(4326008)(316002)(66946007)(478600001)(36756003)(66476007)(8676002)(8936002)(2906002)(186003)(54906003)(966005)(31696002)(41300700001)(6486002)(53546011)(86362001)(6512007)(26005)(2616005)(6666004)(83380400001)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bmRGWmJHWEF4cU0vUm5sWXlKSXVFYUp6MzByNVBRU0pWSkpkdWpmd2Z2TURN?=
 =?utf-8?B?ZDRmU1RHZ0lxaGw1Z1I3em1nZ1BpNG1LVE1XZE9XUU1SaUdRK2MweUY2THVa?=
 =?utf-8?B?ZThXK3o5SVZuLzE5TndMcm5UbHA2cHZ5UmRKV014MW9vVUZHY1pIM29YU0FH?=
 =?utf-8?B?SVY2MFdsL1I2NTFYcnBiZTM4blJ3dXkvTE5vWi84aEgzVUJ5SGd3K2RxR0w4?=
 =?utf-8?B?QkxrZjBLZVRhaldRVnduYkFkVkM0WXZGbnlrTTcvR3p1bnUvM09QQUs5MmtC?=
 =?utf-8?B?UDNQRG9UNEFXb0s0L25tQ3NXdHNWbkgzazMyREwrYmlMb3dTZURMWkU5TmZX?=
 =?utf-8?B?cnZpSVBoQW9uWVdORnc1NXptSDRDZWxYWGkyRy9pWHBKN0VUUFNQSHdJMjF1?=
 =?utf-8?B?ck96aU9LOHF5akZyMitSYWlEaHNTd2ppb3FIRlc1bm9wQkxwN2ZtWlkvQWRP?=
 =?utf-8?B?a3RzQVRrRHc3bGsrNEtsMllFdVQ4Wm9lYUZEYTY2VHpBZEJTZXhzMkJzOVJF?=
 =?utf-8?B?SzZIZU9OeWs3NDJ3VjJOdndvcnZrVTQzd3duRlgvQ0kxZWRtR0ZwZDE2ZHVr?=
 =?utf-8?B?SkkwZktxRnFiU0hwdisvc1dZZUpsSTJkNXhTYTR5NkMveXRvUS9TM1BLaFhs?=
 =?utf-8?B?cnRFTFd1L1pLNHBSSTVUVFZXUHFTcWNtdFNCdmwzbTJFSDBMbDhXc0pVRFd6?=
 =?utf-8?B?VUdXU3dDaHNrT2puMWlQa0ZOUzJPZkZzMytiZURDQWd5T0YyM3k4TVo3cjBB?=
 =?utf-8?B?bXprWUVCZTBJRzJja2dIaGh0U1JCaEZMb0JGTS9NYkNYVDJOci9Za3dZZzh0?=
 =?utf-8?B?VExwNTlpTlYybDlkNmszdTNhb0pYWUpweXJQS09MRENQa3hvaUxzeVZCN01O?=
 =?utf-8?B?ZnR2eW9UdW9sV0s0V2ZET3dkUGU2SkF4YU5mc25kdGNPaFVKZ2FhWWsxN21o?=
 =?utf-8?B?eHJDbGZoYjZrRHAySTNSTm8yVkVHOGRSQUZSTDV0Z3dDRkVzMWNPdkd5eDFx?=
 =?utf-8?B?SjQyOTR5akxSY0JBWXlCaGdkREZqZFpSaTZEWUpzZjhJeFJyYzY0eTB3Rjky?=
 =?utf-8?B?QXVYdnN5T2JoNjRLWVUxdTlZdVNNTFdmdDM0WDRTTHZ4REV5QVhKbXBaRWlM?=
 =?utf-8?B?K29oZmF1MFhjU1pQTDNDSVQ3VmJMZTRjWjZBa3krMHA5NXZpZ2tINlFDTTBI?=
 =?utf-8?B?N2p5d0M4dzl3MXQyc2MwZGEvdHZBSEtlc1pQbzVXS1pmd3FSRGZTV1FyQW94?=
 =?utf-8?B?TEMwU2pVSU9nQmNQWmdNYkp3OVNabUxTRzVsYmVOeHZnWGJEUmFNUGxFVllG?=
 =?utf-8?B?L0RON1dUNDZpbFV2MUozUmszNTJDRmhiN0JPQ04zT3IvMXE3eHNKQXRyS1Bh?=
 =?utf-8?B?Q3N6VGZrK0t5UmdmanZVZlBNK1dEV2xFbHpuUjAvUWg1RTQzL0VYeFRodEhO?=
 =?utf-8?B?bXAwNUVsUVVZMjVtWHNaWVdGcmE0WThTQ3RzNFoyTitqcjZCTGZIOVBpaGU3?=
 =?utf-8?B?M3F3eVRxdFVyYjVuUGNPRXhOVlRTM0xtNWRYb1J3S2xLNjk3RjdXNGtNYUVi?=
 =?utf-8?B?NlVCMnlMamFQSlpwTW9PVURGRlo4UmpKdmhGOUNpWnovTEF2YUdxczZYZ3lr?=
 =?utf-8?B?bjRQaWJIWW56UnZxelNGU24zckU4S1F1WTJSR1E2ZTBqNDVmSG5NSzZ3Uzlo?=
 =?utf-8?B?SWtoSWVqRzEzT2MvWjJUVTJnT0VKbEZNUXpjRmhDb2ZYR0lKNlFKL1BNY2tZ?=
 =?utf-8?B?aG1QMTJRN015NkFmMXMvQUFwSmY3WjNCV1V2d3R3UDVMaGhMT3NobEVGN0ww?=
 =?utf-8?B?MytRbDBPTDhJQk9BRndoMDFzeUJ0M3ZGcUsyV2tQMXRyZmcxWk12b2tDei9j?=
 =?utf-8?B?K3VEYWpNRTNCcHZDWHJFUjYxS1VqVDdQaitIRWNqWlg1c3JoUlF1QlIxU0dO?=
 =?utf-8?B?WkN5UzF0RlYwYlBBMmlIaDVGWkQ3bjlKY2NNeXJLUVFjTy94cDVVbUVlYlJ4?=
 =?utf-8?B?VUpYSWFtMVh1SVR3c1hJc1pIbE5ONFdSOFVwWTc1c25tNmhjOTdpMzlhVXdZ?=
 =?utf-8?B?eVhqUEZySjdZZUNpV3E2SFhKK2xSS2lRbEJ2Y3F5MXpTZXIyTHh0bXUzTDN2?=
 =?utf-8?B?MTRxTG5XazJXam9iM2pwTSszRlhqcEdnSEc4YjMxNXhtU3BVYW9ZcUxEWTNE?=
 =?utf-8?B?UHc9PQ==?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 781e95ba-6ec0-4493-b594-08db7910c8fe
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6896.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 02:22:00.5715
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /o9hsY8M4Ji4AFfRHFwdbWTMGkWFin0S0FQQ/coVJ8WpfAuLNqRZ9VvW3+qClfGEqC3QfeBlfgWCIqVlf812LGy9No3H+pClkOnRX48S9vA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB5915
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/6/30 00:33, Lucas Tanure wrote:
> [ EXTERNAL EMAIL ]
> 
> On Tue, Jun 27, 2023 at 8:52 AM Xianwei Zhao <xianwei.zhao@amlogic.com> wrote:
>>
>>
>> On 2023/6/27 15:23, Conor Dooley wrote:
>>
>>
>>   > [ EXTERNAL EMAIL ]
>>   >
>>   > On Tue, Jun 27, 2023 at 02:13:34PM +0800, Xianwei Zhao wrote:
>>   >> Hi Conor,
>>   >>      Thanks for you reply.
>>   >> On 2023/6/26 18:02, Conor Dooley wrote:
>>   >>
>>   >>
>>   >>> [ EXTERNAL EMAIL ]
>>   >>>
>>   >>> Hey,
>>   >>>
>>   >>> On Mon, Jun 26, 2023 at 05:52:21PM +0800, Xianwei Zhao wrote:
>>   >>>> T7 is an advanced application processor designed for smart display.
>>   >>>>
>>   >>>> Add the new T7 SoC/board device tree bindings.
>>   >>>>
>>   >>>> Add basic support for the T7 based Amlogic AN400 board, which
>>   >>>> describesthe following components: CPU, GIC, IRQ, Timer, UART. It's
>>   >>>> capable of booting up into the serial console.
>>   >>>
>>   >>> Lucas has already sent patches for the T7 SoC & is at v5:
>>   >>> https://lore.kernel.org/linux-devicetree/20230623081242.109131-1-
>>   >>> tanure@linux.com/
>>   >>> There's been a bit of discussion there, and there serial stuff in
>>   >>> particular is different in his series (it doesn't use always-on for
>>   >>> examples).
>>   >>> Could you please go and take a look at his series?
>>   >>>
>>   >>> Cheers,
>>   >>> Conor.
>>   >>>
>>   >> AN400 is the reference board designed by Amlogic, which is different
>>   >> from Khadas VIM4.
>>   >
>>   > Yet you share the same dtsi, which he has got through several
>>   > iterations of before you arrived.
>>   >
>> Hi Lucas,
>> Are you going to continue with the dtsi part?
>>
>>   >> And T7 serial is the same as S4, so I follow S4 serial.
>>   >
>>   > Yeah, no. SoC specific compatible please.
>>   >
>>   >
>>   > _______________________________________________
>>   > linux-amlogic mailing list
>>   > linux-amlogic@lists.infradead.org
>>   > http://lists.infradead.org/mailman/listinfo/linux-amlogic
> 
> Hi Xianwei,
> 
> I am doing the basics for Amlogic T7 A311D2, but the next step ( sd
> card or emmc, something to boot on) would be more difficult for me
> than you.
> After the first series for Vim4 gets merged, I will start to work on
> how to get sd cards working.
> But if you already have that working for the AN400 board, please send
> it. And I will look at that work and use it for Vim4.
> 
> Or, if you don't have it ready and want to share it with me, we can
> work together on these A311D2 patches.
> You test on AN400, and I test on Vim4.
> 
> Thanks
> Lucas

We are preparing this part. However it depends on clock. So the clock 
must ready first.
