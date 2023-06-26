Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3BBE73E048
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 15:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbjFZNOq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 09:14:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjFZNOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 09:14:43 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFE5EB9;
        Mon, 26 Jun 2023 06:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1687785282;
  x=1719321282;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VmaH0b65Kf0qEg0ODA4895oiNlqW5xbjx1QUDorqsC8=;
  b=EsizbPxuNxk7GuxnyQGyUMAZ4ExhJ435iaF4RH9HndVcjJ43WkoJTUMA
   KSZ4V43M2Od3AyuURWpgiB3kG6wWUTWVkgMXP2H90mKvnYYmj6/vTFZIX
   k77t9CBBKCVKTj5Ez4tDmwtdqa4KxJ7nob4nfsGFv181Y8uWtuWCkHjo/
   4KKSqblSqMmLBE0UpIJrI1IJTZwLHS6AsKjYsWQ6KJqpVyyGpCc+GbfOh
   O+/TvmJLbgwMuYbrCILuZ+AWcKGHrvAaaGu8wYkxt0/BRawmE+MJqTNn7
   9rmlunrSfK+TqcfDk63An5LDN2H9owt5bYWfBuvLBBtHUh8EmZBpD678A
   w==;
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PLiVmrLHyySTgIdWyhtXz+xz/qw8hXq2T42F6SE4/ClTyUXsoqDT7zMZH36HMQqwHOfUy15zFfCD4sBctIswak5fUN2Fv6//7k4iLoUwayHkxguzMYS9+YARauP1vvivBxLuOCCTNhMCYPckSKrndwGPxiYmmEuW95neKVLH/EJZodHqKyfLqF4zCHxjwqHUwvvVnGbLtOdmAGLcayOqi/ZY3V7juzh1FUVpcfJVW+y/6k6wftX3ERzCix556QQWzlfSx1D6na7jZdFMy2ZUjs3sEAonzJmdejxkLCAeM0xhPDxjP175m2KGy25Wi8VbwDhUOA/pPH+mxlb6kq0V/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VmaH0b65Kf0qEg0ODA4895oiNlqW5xbjx1QUDorqsC8=;
 b=ZqKe1Ik3JnV/srQwEQX3bew40suGOmftrKxKezy8fsTAfhfCS5B3PGe99ey6zR4upTBtXA09IaY0JXEP4MR6npLlyHnrIYvw22G2Rm/Kug2ko304RHbpvsmAAarJy5vrq0uS/KqlRoPCKxvyTo4f17YpiQEQSs0UT6mT+67UowpN7sIkfKubl8h0vsjStWvByXmDRlMP6XzigAXVVzBE7/xgK4H37ASHKQ7+9MAfESfn8x9OqgFjJnHEG4MZWv4OqCTIFoazmixh+FC0WUYrn2b6Y8w48mzxSTLvQIcm38a/OTtNze78/3KP246h65NdFx7ixKWgn3U+rC3+rQtbRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=2n.com; dmarc=pass action=none header.from=axis.com; dkim=pass
 header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=axis365.onmicrosoft.com; s=selector2-axis365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VmaH0b65Kf0qEg0ODA4895oiNlqW5xbjx1QUDorqsC8=;
 b=HVTELrTOeMLGoAY8Aj+txVUR9ET1VdV318wMrZPeHJeeBi+HtbQDOI6YYYRagXzY040Sgp8RrojsBQtK1uk6y5vph2tHfyA6iXBKYzpy94JzvlLREwMddjNs5vH8tdlqfQd8GaqUeHvgJ/LItVN00+FeYiYuDLOXp6J3JAxtNc0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
Message-ID: <a6d6e4cb-b4d1-8ef3-31ce-2d09c9535dc1@axis.com>
Date:   Mon, 26 Jun 2023 15:14:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 1/2] dt-bindings: input: microchip,cap11xx: add
 advanced sensitivity settings
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <dmitry.torokhov@gmail.com>
CC:     <devicetree@vger.kernel.org>, <linux-input@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        <u.kleine-koenig@pengutronix.de>
References: <20230626113740.809871-1-jiriv@axis.com>
 <20230626113740.809871-2-jiriv@axis.com>
 <0503b8fd-e8ce-ffda-577a-b851a9eebb07@linaro.org>
 <cd833975-7dd8-95a5-4bde-3dcdf9cf65a1@linaro.org>
Content-Language: en-US
From:   Jiri Valek - 2N <jiriv@axis.com>
In-Reply-To: <cd833975-7dd8-95a5-4bde-3dcdf9cf65a1@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P189CA0033.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::46) To AS8PR02MB7254.eurprd02.prod.outlook.com
 (2603:10a6:20b:3fb::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR02MB7254:EE_|DU0PR02MB9369:EE_
X-MS-Office365-Filtering-Correlation-Id: ee900ff5-a142-4749-fd9d-08db76474ad1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GpCUW/z/GI/Zpv90bO85Ah11Cfc1lJhYw82SN8pMV94FQ1Q0p9kp4w3IJmA1U1dI9SGchnfOyZGiB9LqBLpCkFoCcSw690n37uFBhWd7uOgpO8TIcKxrBc7u0pGNRm+lUxlxrYMDYkRLyPP+HzqMOXrzo3IjOSVa2++ieAwuq1OfBYJfEO73qYKquRW0MazDB9OnH9ojiiN4ojGfwhJnu2qsF+cQhfokmXo5V9sEgTWD37p9P/JazBVXFbJ0A0LLXIANEQREBHPvGGQzW9BPJyPlgzKou3QG5cfm8mWl5x3K6jKuibiQyTACOS9h4+1GzJazN4Mxuw+AjuE7fn/r8m1AaLxcCh7ihZ8yMZfOZ/hizzfqYwTWfLrN1/W9WrVtLC+wc67eIq9iWj62J2KS7DoAGZ75saniKRKeRX7Syj+hiFlLYBxQT1umY/bdgkNguKvw/z9424PnBTCOSq9DnaM7IyRU4EqJ7SB89NL2U8b+2WNPFJa7um/eDI5v5huU9KzGFUlM8wFsjzmEUtFvV6vs7ZMlryLjjW7OafS95H1PG50/5e//s9nwF7yaT8IEX6205b0KfDE/FWqrgED8NYY5tcUs7VzyGx2/VBTVaXzB2A6I09LAMaQPCRJzB2P7+6nC07IBMRkzoeMF7Kf7vw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR02MB7254.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(136003)(396003)(39860400002)(346002)(451199021)(6486002)(478600001)(2616005)(53546011)(6512007)(26005)(42882007)(6506007)(2906002)(186003)(4744005)(5660300002)(36756003)(38100700002)(4326008)(83170400001)(66946007)(31696002)(8936002)(8676002)(41300700001)(316002)(66476007)(66556008)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dDhuemh1SHNJL0d4VHppaWpxcHY3cDRMOFFFM29OVHkxVjJCWmdQcjBRZnJM?=
 =?utf-8?B?QisxSW9EZlFCSE1HVUJGbkluVlRYMTZvbmJ0RGZTaGVzS3o3UHpnS3pTemhn?=
 =?utf-8?B?cENqOTF6U2MzNmpLNTRQNHJ3RnJMVmRMR3pWR2Q5QTE2RHpqRDdRZnRHUEE4?=
 =?utf-8?B?YWVqWnF1N3BPeVE5K01CM01BTmtuQUpHM1Z5ZnZIVnlBL2J4VXI0dlk5ZG05?=
 =?utf-8?B?K2M3bitNWUVWNU9pZjZUNURtM25mN2VpbDZFWW1wbys3b3BJWU1IbCtuendr?=
 =?utf-8?B?ZUdSOTRiMW14NVlLdzVaV3B6WFd1b090U256eVZvK0sySGdjcmZrUTdaR01P?=
 =?utf-8?B?VUVNc0RtZ1EwOHNnbldHQkZxSUM0RFA4czlJT3VnMHlqbEdWNDVHektsb1N5?=
 =?utf-8?B?bEM3MXNqSTQ0Rk5FdVF4YitKZXMvemowNlNNV1BtdW0wTUVZSU90Tkp3ZUhG?=
 =?utf-8?B?RVRHUmRLMDZwZ0MzR21vL3BqZE9aNXk5L1oyVlBVSmpBOTZ2UGF1NFFLTGJQ?=
 =?utf-8?B?R3ZiMTk0akFLWnZEd0JwNWRibjlVVEpsMDgvMnNpaVFuMG1JaXZuTkFHVWhZ?=
 =?utf-8?B?WVowbUMwTzkwOEIzTWdDR1lYcEpkRUNTbHJIaWxOcUdTanpjTFBSYlEyT0FK?=
 =?utf-8?B?bjZ4K1pSeWphMDhoR255UFVhbHdORFIzQWt5R3d1T1JONUNqajVYNDdyR0NB?=
 =?utf-8?B?amFUc21ZWnBBNHlIaVRNckZiT1FKQW55elhJdlQ4WkV0VSs0b2ZQWDlNOHN5?=
 =?utf-8?B?bmllVmhEd29mTTBWOTVuZ0pSVjI4d21zK2xKS2lUT21EVnUzeThIOWtVRTdF?=
 =?utf-8?B?OWM2UmxSY0lXYzJTejg5RWUxUGdOcFdGdlJRN29yem5KWlg4ZzZENU1FMUlG?=
 =?utf-8?B?dUdhck82clkrRFNtZC9LcHRCSzdNUnlmM0NzMzRDMkJwemwyd2lxUTM5Ri9V?=
 =?utf-8?B?M3p0MHhWeWZYYW1rR0g4SjdqZkpDOFowWkxYQnhpWDNTWWdVNXgwblRwK3I1?=
 =?utf-8?B?UkpET0Z2Qkc1dVJjTEpTOGpqZTZPUm5aam5RQ04vNTdpVE5CMW8yTHR1eGps?=
 =?utf-8?B?WnZ0dkVKeGFScm16QXZ1VnpXZmw5NmM4WDAvYVo1Y2FVNmJLempVWTA1Mkdl?=
 =?utf-8?B?RWU0NjQxb0kvS3pqTlJnb2NIT2VMV3BMWU8rcVdhTWhwS3FkdmFuNFhJVStW?=
 =?utf-8?B?ZUhTOC9TSkpzd2kwRjc3Z3VtMU41d3VLWms3c3A0ZWtnMjl4QUJFeHplcWR6?=
 =?utf-8?B?ODRWakVML25zelVBaGhzM1dNUlBrZVJ4aEtCSW9VSkxTWTZucGF6VmJhMUI5?=
 =?utf-8?B?Q2NuTlZab2E4TnExVndMZVJTUGNFa1dvb3cyM3pmamlHaEg1NWk1bXhBT3VH?=
 =?utf-8?B?b000NTBicjl0YUZseVFqSWRiTnJ6YWJiVklXRlZvdmkyditDa3VaVzJpSW5H?=
 =?utf-8?B?c2E1WFRSM0RodUhxT3hMSUlnSGdTTGM0dzk2bTUwZUdqaXE3alBJR0FXOTR2?=
 =?utf-8?B?bE9CNE54d3kvc093NEp6dSs0VndqbDdHUGRPNTVYU2t3T0Q4R1Y3WklqWVRV?=
 =?utf-8?B?Q2NiVFhuTGRlZklXalBtVm1jTWM4c243VDEzSFhiK3BtSmZPT05PS1ZjN294?=
 =?utf-8?B?SHp1RmNUWEsyNk9XTWRobTRhanpReEZLenMwbVdDS1R3M3g0S2tEWVdHbHVr?=
 =?utf-8?B?djVVamRvd0l0c0dCUHFnQlNpOE0xVFB0Zlp5Zm5Zb0NDc21MNlBxMVRlMkZl?=
 =?utf-8?B?UjdIZVo0M3ZlN0NzZ3h5NmZvN09qOHR3VmdydlJWY0FBa0hmOFgvWHhHK3A5?=
 =?utf-8?B?d0VzcWVBRlZ0cVpWWUptZ28raUdDaUNBTVlCZ1FXSjFMblFpcmx1cCsrZFgw?=
 =?utf-8?B?ODJ2RjJoMlRVQWdibXk1N0JrYkhuZ1ZtZjRHUE51SHZWUWM0bXRxZXZDNVBQ?=
 =?utf-8?B?TUplbU5ObUZ1aENlalk2V1NXeXBzOUgvSm82ZGdCMFVMczZOb2lHMnZDSTdo?=
 =?utf-8?B?MEQxYnBpbDhGa2hZRFFKaEM2RUtaVWxMeEQ3OXdxL3ZEN0NjeW9aRnhkY1Y5?=
 =?utf-8?B?SHNiRkR6clBCMVc1c1FwemExV3RDTjRWSTdsTjBxZklURUtsbEJDTG1MNFds?=
 =?utf-8?Q?ouZ0SYJpoyvXbV4F8YkBcK4Ip?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ee900ff5-a142-4749-fd9d-08db76474ad1
X-MS-Exchange-CrossTenant-AuthSource: AS8PR02MB7254.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 13:14:37.4468
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TtiqpfKnEKp/wye+5G01VEL0eNx5VzjX6eXgi05P2NlD9op20WblYP4Vh/LE7tbS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR02MB9369
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/26/23 14:41, Krzysztof Kozlowski wrote:
> On 26/06/2023 14:36, Krzysztof Kozlowski wrote:
>> On 26/06/2023 13:37, Jiri Valek - 2N wrote:
>>> Add support for advanced sensitivity settings and signal guard feature.
>>>
>>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>
>> What? How did you get it?!?
> 
> To clarify - your previous patch was not working, not tested and not
> correct. I pointed this out and I really wonder how from pointing out
> errors, you figured out that I give your patch green light!
> 
> Best regards,
> Krzysztof
> 
Sorry I incorrectly used "Reviewed-by" tag. I wanted to add you as reviewer
and give you some credits. I hope that "Reported-by" is better, but I'd
rather put no tags.

BR
Jiri
