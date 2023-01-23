Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26835677711
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 10:09:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231521AbjAWJJD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 04:09:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbjAWJJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 04:09:02 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2124.outbound.protection.outlook.com [40.107.8.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2407B1E1D0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 01:09:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ML2ohVUovlP9TDbUSanChxO5iEvgvBT/2Sc21XEBKfZs3NWwCdnO99Aq9brK1tSa3bfxNj32/4XEEWQaKtzSzQJU6gmuGld8dHLHa68CzYIXh3HasMKwn0G4cmcwPzQG7o5o7/VGa4eq8UJwRDQlCosGumKwIdMEYU7ALRxIGCfz/aJMrbW8xd7OSKyqeCLIb5bxw29iy9o2XBF4Qdv/P6lC85mxI+b3Zf+YJfMAUlM8mwNvmdp+ttUP+wrOA9E0ELCB5LJtIDtNKJiYD/kHqoqdxTMI9srBLitVLh9E2L0vYM8KgSyphKC7rd4kfUwSA5iH8yc6Uij9y/6/Jt5PSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZI6t4B0i9f21IeEh+PeKD3Owu6iDdaFGE+CaKtPP2lQ=;
 b=KChtfd4zITbVJvcMT/CQn4KqiPNnmCXheXHRN5CH02HW02BhoAdZIAnglq3Hj2kchfuRcBc0Sngw38MbS49uQNeJzbyS/GlxmuBrhLaBLR1THBDqkqzJHLhYN9n7Tr/zNS5nHCH/3mK6tI9qzcRTJ4r2hcT3WXB3dndaVheRP8my3bg/yClh1982hLXHFcWbCX5d96KIXBni2EoAh9OIng4hb1vO82lKLLaLYnogpX2O3BBu17TxHT3RStTTSmzkNejE6ls1KcqMS1K6ShFuPvX2B2njRZOqfEDhmpqV+YfjrIB5EID3h12YXnMa9guQiE7T765prbgknoan2xZmiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZI6t4B0i9f21IeEh+PeKD3Owu6iDdaFGE+CaKtPP2lQ=;
 b=qE30QdYuIo6eEBVN6N88KeHLFCZt89QzIeJ6FnJze/LEhAM3OouxKsUxOnPhyGptqtEM/mrWRO6cCboGpiQ0qW173vTiZsyLrb42IxOY6h8tGPtTHDPN6is1lidG1qSawZaofmWx3d1PWHhf6jV3RqlLYPDfuvtkGxhLxgSSs2ZTEzTRxuZ3gg5wjp5uZ/4qN/MjXmXI4SQXAhNlRUqJoSxeYCchGJ/C9jpQAP0gyAHFkSqOMdzMyxtyoVK2y8LT7ZoMOBBkcLkAuGIUBs36tarHFa/KqGrSXUWmWysZRMyYM6MUtlx7URZWFHc4LwAzpOTLTmTT0XIpg2WQYRJJ5Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from AM7PR07MB6705.eurprd07.prod.outlook.com (2603:10a6:20b:1a2::10)
 by DB8PR07MB6314.eurprd07.prod.outlook.com (2603:10a6:10:13a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Mon, 23 Jan
 2023 09:08:57 +0000
Received: from AM7PR07MB6705.eurprd07.prod.outlook.com
 ([fe80::b583:2fdc:e02f:77d2]) by AM7PR07MB6705.eurprd07.prod.outlook.com
 ([fe80::b583:2fdc:e02f:77d2%6]) with mapi id 15.20.6002.033; Mon, 23 Jan 2023
 09:08:57 +0000
Message-ID: <bfdea5aa-13d5-338f-bb5d-c05df45f7859@nokia.com>
Date:   Mon, 23 Jan 2023 10:08:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH RESENDv2] arm: topology: Consider clock-frequency property
 from parent /cpus node
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221216124157.13270-1-stefan.wiehler@nokia.com>
 <Y5xqVmO9ZHWYW3Du@shell.armlinux.org.uk>
Content-Language: en-US
From:   Stefan Wiehler <stefan.wiehler@nokia.com>
Organization: Nokia
In-Reply-To: <Y5xqVmO9ZHWYW3Du@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MAXPR01CA0110.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:5d::28) To AM7PR07MB6705.eurprd07.prod.outlook.com
 (2603:10a6:20b:1a2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR07MB6705:EE_|DB8PR07MB6314:EE_
X-MS-Office365-Filtering-Correlation-Id: 65095188-7d4b-4e13-6d1b-08dafd2175a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n99Mv9UM/rtO+xTZcDDSTOOyD/P3u2jhsNI4SIcEITC3lERDhHnMOxMr0GjZEH2a0ldLVP7Itlq0q0zw8IYvzv5LLdSx62/Yc9j5acpcwMSzTWjFenamlX0nYINH/Q1DRQi7nnqlEphGgqEkyaDZ9HAe5iIjd2kplCaJZu08HcG3JsLmtYUVsjFkk72ByHngvXZeYv0SSfpXf7w4p4/pWite/R5kNvzdyuwHhw81yG0hKT9XAwtJH4axol0yHzywUENwN54fiqAdj2eLmIJXqeNUIiKe+qAeFTErzw1AKWBy9mPBHKp6y+7B6ILV1MLiIc1eaW+LCGmm4k1fvvtpTZMlfc5/NW5UjLAup0MS8XtULWYD/A1r1woaKeqcS1RIx66mx+OInwklrcnBJ7HY8H9aEeGazaHY/Wg4HV+pJvIyfelbpP3KtoZopsI6d3VrIq/tiJAunRGusxTgSQkWwpCg93VVcogVWR62QAYCayQf3yyStxTzK7EekT2H8Aut7YZDgO/ftSgncQRBMasHaOOJMx2EX51IJ2L0VPmGpfH+p9FNRoqE9qYDW6Xg/5zki5wOXCPdeMto7BzoNIQ4xwfh1h//isOC1gX/hmQhNSlx+nGOUdd12Ij8ySBZH2rSgt8OlLqDnTDHbyGm7Io2oCWoGv0Mb42+JPgJnZJPdtoBEQhw6GanwXj1D3WVVaQ3OvwIR9Jix2iZtzMXpUPZhhUM66ncyAvC0lgpIee/Ir5ynh/UxtK6UxZ1WZGKOqF1rkdW1KKPUdAQkdf/01dKag==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR07MB6705.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(396003)(366004)(346002)(39860400002)(451199015)(36756003)(36916002)(31696002)(41300700001)(86362001)(82960400001)(5660300002)(8936002)(2906002)(44832011)(4744005)(4326008)(83380400001)(38100700002)(966005)(6486002)(478600001)(31686004)(6916009)(8676002)(26005)(6512007)(6506007)(186003)(316002)(66946007)(66556008)(2616005)(6666004)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZUhCeFNuNm8zNERmUEM2K05obmZkZTBra3ZQTlRzQzlXRDhXYUU5R2dHdXJt?=
 =?utf-8?B?UVdGd3l3cTZRNzBCWEhLUlVGZjN6b1V2TStYQ1I2Q0hqNkZLbXFpa2JRdlpo?=
 =?utf-8?B?VUhQYTUyZW1qaVBacFMrTHV5ZDRLaDFTeW0zZ1hTUC8wbUtmcitrS3Y1NU9K?=
 =?utf-8?B?U3dyMXg3cEtwRndRYkdMdzJ5KzlOVzRYOFU5SFpwWUMyRzN0dk1vYXVvK3BW?=
 =?utf-8?B?aTZ2NmRzcEI3SE1PL00rWWh1NmpqRXNoa2wwQ3NkQ0RlUmxwRENpYWdGSlpV?=
 =?utf-8?B?cHJYKzJOeDZjMS9JTE1qS0IvU3dFU0Q4MDlUczNIYmFvZTFjdHZLMDZuRGNx?=
 =?utf-8?B?TCtpeVVMc2VvdkdFYXV1LzhrZEFoMEdURWZwMHVkZm95UnVaa0szSmF1Qzk0?=
 =?utf-8?B?UnV5cHBDa2RCOHRicFdDMGM0YzMyT0RtRzFidmhnR2txclZkNkNkT3YyRE14?=
 =?utf-8?B?eldwRzI3emVHNEtpaWtkMzAyKzZVZldYMDBGNFQ2Q2lMZTYyRHFmMnR6NkI5?=
 =?utf-8?B?SmNod3NkSHhzY25GbTd5QWtEbUY0Zm1NeDN0NG0xTEE1eWFJWVBxcjIrV0Za?=
 =?utf-8?B?dVNNc1RQcE4xVm9wSFpjUVQ1NCsxVTl4SnNOclIyLzIvODNsM1hGeWlXNWY0?=
 =?utf-8?B?NzkwN0p2VmQvdUc1Z3Iya3FIYlpJTUE3Kytoek5leG5HOGVwdEpXWTlmZnlM?=
 =?utf-8?B?SGZjZnd3eHFmMGw0aE1lNk1yREpkcHEvK3NkeTdOQWlyb2lmNXJicjVhdUxH?=
 =?utf-8?B?QlFidm54amJUdm1oelVnbjVNcWphUldOV1UreE9qTjJzN1hXTHZCTC9NNGFr?=
 =?utf-8?B?TGROOGlEYVpVdHN3ay9NMHI4dm54Zjd6dnFML1VzdldLRnhkbkVFVWRsdzRZ?=
 =?utf-8?B?b0VtTGxtdHlvVTFNOEtBTzZxbEVEYitSUmRwVmVyR3pvRk95djVlOGJGN0U2?=
 =?utf-8?B?WXorZjJjTVhISWZxTUZtZmtENFBEUTNvM1hMTXk3NWJPemxrRS9tQUVzclFL?=
 =?utf-8?B?bmhvMkVvcW1qVFFpODFjUm5KTHE5WXN1RzRkTVhQR0dPYkg3NHk5bzVPeHgr?=
 =?utf-8?B?SXE3ZHA5dmhLS2hPVktIdmJXOGtWcERVcWVsS2ovSWo4N2VuUUljU3E0OGtT?=
 =?utf-8?B?aHg5VHNxU2s4RmxGK3AvQkFQL0RWanExS3JPaVovbXR5QjNzNDZSZ2c2SWV1?=
 =?utf-8?B?ZkxwcThndEpIb3JrekR6TEJVdlhnZnl3VmlLRTVvWUhjekJGdFNWaWg2SHF3?=
 =?utf-8?B?ZWU0REh1NEhIMWhxTmk0UGk0NEFNaFF0VjcydGlqenBpMm1EUENxeVdIMmww?=
 =?utf-8?B?QndRZFhiUThUMXNiTlVvRUFMbWJ5cThVL29xcURMTE4wRUhTdnZBWnhNZ0w3?=
 =?utf-8?B?NGs4TXFqckhwOVBuYTdkak1KaXNISmFDWFJRd3o2clViWXBwUDZSa3FINlpa?=
 =?utf-8?B?SGZMOFNrdEViTmRkWnZpN29OUnVwOWZYbUlUd1FicDZ1ZUZERVRSeEt0Wm9o?=
 =?utf-8?B?SDYvKzZaT0p2RjR0d00yVWFPdlZjNlhwUEx1UjJpbFZyVXUwTUJyY2ViZzNt?=
 =?utf-8?B?YnBCOEx3OWYvUm5ZWmZ3d1BCU2p5SzhpK04vQnRBNXl3WFdUZVZEZzZTVTdT?=
 =?utf-8?B?YmJZeFdnNEE3a1FCSkVKY3JaNkxTMng1Y3h1N3FRVUI2SUYyRUF4L0t1d0ww?=
 =?utf-8?B?aTJuRTFLNW1EbG0ydDRVbmkrWDB4SGJzT3RoVEdFeDI2amJwRXE4RFhMQzRz?=
 =?utf-8?B?azJkK0JvZUI1WmhOdDQzMDJqU1ZWRjVhamwrU2VsRnUwc1paN2JQdmRkMXBw?=
 =?utf-8?B?NjVBTlVHQTUxQXBEZWJiclU1ek96NisySWdwbDFVTWxpNFkvbUZLWWFOMG5k?=
 =?utf-8?B?VEowejNBcTl6bElzYUQ2TlVUWXdOb2V5amErVm81NmU5UzRmSDk3eWVNYnE5?=
 =?utf-8?B?VXR1cW8rNHBiU2U1RGNhb1NsamM2TmZSZkpnUHRWV2VrWjRBaURDNGZCbzhr?=
 =?utf-8?B?YkhhNjYrbGV4NzlHZUlvT0FBbGNBbTZWVksxVU1YUU5aNTU5ZEdjZ2gyOTBX?=
 =?utf-8?B?Vm0vQThoZnJUNlBFN05hSzVnWS9LK1Faa1RmQzN0bFA3M3RkTUU0aHE3bXho?=
 =?utf-8?B?NHVteTdaR1JjTk1Dd1BNcVpXMzQycVhPcGp3RnlPWHpWMndPMmF6Wnl4U01T?=
 =?utf-8?B?VEE9PQ==?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65095188-7d4b-4e13-6d1b-08dafd2175a4
X-MS-Exchange-CrossTenant-AuthSource: AM7PR07MB6705.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2023 09:08:57.8616
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yHNFBeru8SZl2YdwGj4bETWvL1EhRMOZLKARlW6qF+L7UtU7IOjH4Ld3hdsqGRn60bfecM3YaFyOzNNfXo8XbdQHg59bzPmtgfDTMwY2ExY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR07MB6314
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Russell,

 >> +	cn = of_get_cpu_node(cpu, NULL);
 >> +	if (!cn)
 >> +		pr_err("missing device node for CPU %d\n", cpu);
 >> +	cn = of_get_parent(cn);
 >
 > Doesn't this need to do an of_node_put()?
 >
 >> +	if (!cn)
 >> +		pr_err("missing parent node for CPU %d\n", cpu);
 >> +	common_rate = of_get_property(cn, "clock-frequency", 
&common_rate_len);
 >
 > And here too?

I have sent v2 in the meanwhile where I have refactored this part; 
please review:

https://patchwork.kernel.org/project/linux-arm-kernel/patch/20221221154213.24382-1-stefan.wiehler@nokia.com/

Kind regards,

Stefan Wiehler
