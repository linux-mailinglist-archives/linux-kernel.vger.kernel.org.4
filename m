Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A67C172365F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 06:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233863AbjFFEjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 00:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjFFEjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 00:39:03 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on20622.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8b::622])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E1FE99
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 21:39:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uh3LVP7g8I59u4YAml/23vRMOsCbnQ0Ptv9IFYfRDunPBeYdP6TOBzSluEs52q4jrW6ae7uyfIyunaF/DQtOxExjAvDISGpForpjZ+QoI9UpoA2SCgMQip5DIy/BVi/f3JrRMmtD9VzUUa+51lz6GqTN4CgBtcJld03grq2kg3nd17aqtjBq0UwRPrlUXpylGFtYQ+5mCfj6ophLnoEhVFqkjJfSn9vRmjmi0JpJtm2ON426r64TnifSYAq9LvYaUmIo/w8QOsQt8x/IrzwZfnk9Tpm+/BtymGOf0azwTPOw0Cbdo0r1sAiT+BSVKBe5bVlRsXD5CTMC5rV0FqrHvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ywyyze8il4Kky1mTZ5yNEfJIHVKdmS2jgGg5n0bV59k=;
 b=JntEII09cf1EXnOdcKGrzJlMC69dF9QC9i4IvmNXsvNoiGeibAKAyus3VB5fVK0quPQEnZJBBkn8KsQUdpcs6ujX3CbS67C6BZssVOupQ6n2f0n7Vy11E5gZT164YWNbVpIGzPDZZPxlubtKgHsl7VMnRyDMNY+XoqRNJckKrBlbZJsfDOiy/EqrDSujrk9MuU1ZEe5zCuixJ9b1m504gIJylk3lt72nAAJkuv1PJW3cliaipUOcg0g7qOEOGIqOTKZpKdhX1X0JtQ95uG+PI0apHwaKA1wcIJkQvtc1m78leMhj8xo1TsCL2Sat3h5L1aF7+kgOHs7AZfVMHPgW4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ywyyze8il4Kky1mTZ5yNEfJIHVKdmS2jgGg5n0bV59k=;
 b=FlSY2vzHrK857UdFsS9cPQMRxWQSc3zW0NTmMvcD0lpN29OvFcatfbz/S6L4p9NCAy5EE46p5lbrnWvOSi1TBmH0XnWnBBUpEeRPxPkjfNn+3RFe5i4M6Vgg+89EK1UcNm4+t1bYfs4jhqqPvQTMbl/hsTHOGYkfS+cb59x1tUU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by MN0PR12MB5763.namprd12.prod.outlook.com (2603:10b6:208:376::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Tue, 6 Jun
 2023 04:38:58 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::b4a6:94bb:6895:645]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::b4a6:94bb:6895:645%3]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 04:38:58 +0000
Message-ID: <c5a40920-0b14-b9b5-19ee-48c965bd12e3@amd.com>
Date:   Tue, 6 Jun 2023 10:08:43 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] perf/x86/amd: Reject branch stack for IBS events
Content-Language: en-US
To:     Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Ravi Bangoria <ravi.bangoria@amd.com>
References: <20230602194513.1589179-1-namhyung@kernel.org>
From:   Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <20230602194513.1589179-1-namhyung@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0055.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:99::10) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|MN0PR12MB5763:EE_
X-MS-Office365-Filtering-Correlation-Id: af35dafe-35c0-4e14-10b7-08db6647f160
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hHI+9g3f4RYlI+czlZCfnGwGE1q+XHfzSzaww29dsLnfv8TrEDBPXIcONPuKQQB8nAfJF0RUbEqIuq2h/5kC6aMcz2ycZ0cRW5OgFCzfuW5LcZfnEQEfxG/htwoHEeNZi3+GNqAYpkxOxWeDVDd6KpGQFezNpQTn7dk76VZMIPOTYVqEVIAtl9ksRcAciVXN34CmV6dJUfJ2yrNResRhwvopWdD6GSyIpi57TO/lynOsheR8Ri7b/KHj2G8+yB7TMhPeoEhe5PaATx9DzYXqs0S9PZBr8hFsvyAaaxPQ24SbufxoiOLJGtsmFrO3vPURH5jYUQQS9ge+1XAZoYnY/r4qF/lqF1gxNQwCFL5D67+jQX0IXmxQVtIQ7VICAd2mmUrAws2Dn3BmZ+8Km7iO4wBQeQqFMzXhdnJTYQZrgPvlugER6dht+ucWFnmEYe7KsEy44TG34kno+huD/lXQZp/Rg3wcCqK4sRgyZlT9isVt/Iz2dKbbH6lt6Q8wgSBoouw041jRPC7G5rTjvITI0t9B+K+rA8WtK8356K+swxprsTyWBV/Qju7qFpbXosDYRAJ2NwyGpN2p/oFRw4tEv7kjABkpdEWusx4L8strKWTAfWMnwoQewjU3Th/osboZBkrYLPsILgy6mYlRyYFWgA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(39860400002)(136003)(396003)(366004)(451199021)(478600001)(2906002)(36756003)(6486002)(6666004)(558084003)(2616005)(26005)(6512007)(53546011)(86362001)(31696002)(186003)(6506007)(38100700002)(316002)(31686004)(41300700001)(8676002)(8936002)(66946007)(4326008)(66476007)(66556008)(5660300002)(44832011)(110136005)(54906003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TWxDK09xcDVBcndobGUrVHpGSmMrS1MzSXRsRXR1cGdqMVBCeHZhSXlIYUNR?=
 =?utf-8?B?YjRvWlZBUUNaQm1RcXB3R2V5VTE3M3dEL3VtRW1BTGw1ZGRZZDlGY0pnbVFF?=
 =?utf-8?B?cnFJUHFoUlVpeXNabm1Eejd4YVBTSDJGUEFKRkMzbmVFblNudk5wbC96Ryt5?=
 =?utf-8?B?eVdBWHBOQmt0aExHalB0WlQyTXEwRzhxVGhmNU0zNXNWdGRPKzluWlpGOGNW?=
 =?utf-8?B?TnZLMWdhd2JwYmFPMllVQ1dPRU9JS1VVTGdOUzFQV2VRTVhsV29HTjZCU3R5?=
 =?utf-8?B?S2hseDlDQkVPVjhudVVjYWxldDdIcHBWZ05YSzZRM28xRCswT2FvektpZW5L?=
 =?utf-8?B?MExUTzA5ZHpLZy9iOWptS29sa3VWODJ2dVdLWXVGYmZQWGg1cHoyMjBrZUdF?=
 =?utf-8?B?clNFUWdyek0rV1V6UWZyaUpyWEFERlNreEN1aDMzNGxlZUFGS3E0MDQ1YnB1?=
 =?utf-8?B?VUZrcnNhY05Oc05kcHE2bytoelNpTWpLcTZXY1J0bUFzdWZZcU5wams5enNs?=
 =?utf-8?B?QTdYenVIVmFMTElhQ09mdVBQM1FvQkpPYTZTc2lGc3E5K0VCRU83WkRSM3kr?=
 =?utf-8?B?SEFUQWo2WEIxbWhSY3VwelFVMjhrQUp2YVI3Rkh0bENJTGlRMXIwUjBvOWQ0?=
 =?utf-8?B?WDZNa0JndWIzUEpVUWU3L280cStTK3JpRFFOMFBNdEw0NG9GMWR2UXR1dW8v?=
 =?utf-8?B?MjhwRFJWcWt4Qm9wREZ4UVpwS1EyVCtBQTNxcUVKdXozY2tFM1NacFlPQ1dZ?=
 =?utf-8?B?cUVOdWVIRlNGL2xnejdOcDNjclRVSWxFdzlaM2VzK2ZheVNvWjU5bTBNRFVM?=
 =?utf-8?B?NStSZGNFTk9iMGtsQ2kxSEJYTDNidW93QXNjT2xxRjVnZGpycnhLQkZKcHBs?=
 =?utf-8?B?Y25TYnB1L2w1LzY4ZGNRdi9Xd1picUhkbW1iRzBGRjkxYk5tUjNZK1pRSis5?=
 =?utf-8?B?Mkx4TVlrT3doSGd6MXg5UzkxeXU4YnU4T0pIU2xiQVBacEJGTGR1ZmNoS2ZX?=
 =?utf-8?B?NnpCZHowNDhrbWQyeGtqZDRyellmN0RscGNXcUhzeWc4Yy9mdG9hWXYwejFq?=
 =?utf-8?B?Y0xEMHk2OGJYQU9RTmV2MTNKdWU2dkx2ZW40RThCSHdrUllMeDM1NGp6elJt?=
 =?utf-8?B?N1NaNjlDZ2VTWnorRStTakNlNHBhTkk4cThSMUsxNzhxZEdmbnNOTW81NGtx?=
 =?utf-8?B?THZsakkyVWF5SVhVeTNqZ20rQmNqaDZBbjQ0SWk4NndxNWs2ME9ReDkxdVBy?=
 =?utf-8?B?aTUxWGI0VlhwUHhHQzJ1NTh5NjZocXowcjJCckZiMHlJR3dlQTExN0ZpbFJF?=
 =?utf-8?B?eWl2Z2JPcTNiTG5halB6M3gva1NWditvMGp0RUVuZEtNOGZLSTBiZVg5ZlhQ?=
 =?utf-8?B?ME5vU3pQUzNMSnJieklGbEFMTTFmZnBkVXJHRjR4d202TUhrVXVGYlpBTWM5?=
 =?utf-8?B?S3JqcGJCTkJOaGpHeVVkQkU0eGpRWXBMTEgxVUN0RTdYWFZ4UkJIVzNvcUww?=
 =?utf-8?B?U1JIdnlrU1dHM2NKbHY2M1lWckJGM1RGT1ZxVUpUeEZERU1MUENpakNSVGZP?=
 =?utf-8?B?SGo5Q3FuNjNPRDB4bW9UNzNGRkppUFc4U0gyV1lKL3VNQXB1cElEeGx2bmFN?=
 =?utf-8?B?eXpmRVhYdFpiek5WSTlOV3R5OGk2UWZUNzRvRTNFSnZEQnJRVmRtcXhWUUhy?=
 =?utf-8?B?M09oaGFCeGsrbVlyYXdkNmIrUS9ZNzY4K2NPR21ySWNmYUo1UE5TTnUxMVoz?=
 =?utf-8?B?K0ZqeGhpV2hMdmFVUlR2aTU2UDVlM0wxbE93eEpZUEdYWGFLa0FDTUcwYm5F?=
 =?utf-8?B?UDZpKzAvWVdJOUNoQm9WcEx3TE1TM2lzZjVOSTdHRUY3a1lsbHRHQTdYakNT?=
 =?utf-8?B?TjRSWGtSeE1KMjBCT1VNaTlWRUc4R05DVmYvbHRTdjdxcWtvay8zY25reVVH?=
 =?utf-8?B?czh6b1Qyc1ZGUVdENGtsL0d5dk1GaHJrSklmckFLK3RBcTdYSDB5RGozNDJu?=
 =?utf-8?B?c29oRlJyaktaSXg0WWRQUDFEM1g4TzlLS1QrZk9IZFJpcnkxMkdKWDdEazRC?=
 =?utf-8?B?WVpJNjRPcmpxa2o3QVNUZTNQaVFXekdkZmRnQVRJaHdPVlkzODIwMFAwNVJC?=
 =?utf-8?Q?44r1gN71uRzEtyReyQJKWo/Dg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af35dafe-35c0-4e14-10b7-08db6647f160
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 04:38:58.5466
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KuzzTWe7TFCLcVeeZvSiHglUZSKAIchIWdrFe0caw9onr6QCylK+KqT6aV5FGhJ8WQwQk7xaSu4O4Yi7eNGdEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5763
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03-Jun-23 1:15 AM, Namhyung Kim wrote:
> The AMD IBS PMU doesn't handle branch stacks, so it should not accept
> events with brstack.
> 
> Cc: Ravi Bangoria <ravi.bangoria@amd.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Reviewed-by: Ravi Bangoria <ravi.bangoria@amd.com>

Thanks!
