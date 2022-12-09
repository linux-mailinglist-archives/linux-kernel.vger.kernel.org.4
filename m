Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 829F7647CB1
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 05:05:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbiLIDdl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 22:33:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiLIDdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 22:33:37 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (unknown [IPv6:2a01:111:f400:7eab::624])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF2DE13E23;
        Thu,  8 Dec 2022 19:33:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QeIYDrdsZPFxvCapbjiAAIr7Y78WhZMIn8yQmxu4oaZ39KrKDC2nnThnve9e2lg9s/RyIuuE27Dt1YkPx1V485YvcvvBRPZFTDR43+Icqa9kiBJDR6zphUfsaqBKEGeHb67tZH0wgxBVGGQHPA19htz9PDRxVJpmhXFixO75i2GX73gPXXKbPoQRkuRAbrqYdsPVgiQPQgmebNKLS1gn5bG/EBaxyMvyWcu2BvBRRNeToQ6+jbIoJQLyUkJYXMnbrwDvcFKIZzHVeVSezk8B5iaz1sHD+z5T84OaU1sVs5t/3a5zdXQTUIRA7obzC+5/IZ4SQlVlMvVzyNwaydNUEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xRvpQVwkAiONTai1ONBnQLvAP2WMsDYIht4PsKZfG6A=;
 b=dsKnBJyZDkQb2d36kd/hnOYCPtrsk1oNvv/8h0hzZhhYweg7mAi7CRPjEePzBJ4fKPe/uXtEXSbMMEWB4SxHWO44zUYnhcNZqsTqbJt6afeD0PETxk41ZgxalmX85rraoCo6jFMiUXo86t9AhKwYXDCtv4zMLecS/rfLcnLwcC2ldQ6YA2PAYYugHlc93hgskgqtp9jONnLjbPtvAtb4DPY+EUcqTQAOSn1c6VcCyOrn9B37iGX4My6bhJcSh7a/0H9m+O+XdXq6GuKzuqhffTLqUX+WKEm0ntDYk0ZUMFXhvJh7o4zMtfz2EgH0A20RnR+5xmat9wxGPn1JX7PyLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xRvpQVwkAiONTai1ONBnQLvAP2WMsDYIht4PsKZfG6A=;
 b=U1nHu7abpCOoXc/33Wa7ePFE/YWW4fN+Z8ETynRWb5LAl4tUOsGN6Vj12iVKXo1qwaFPumvPHYuNqnjklbgZIZuoaMfNajKTKa82uk30+4g5/vg7IPdZWICFubS/bAVE9YunBpmIab72xTc+LAfO7iIyISoQkfycYnnO0jaMH+I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by LV2PR12MB5775.namprd12.prod.outlook.com (2603:10b6:408:179::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.16; Fri, 9 Dec
 2022 03:32:42 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::aa5f:5f2c:4143:f981]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::aa5f:5f2c:4143:f981%9]) with mapi id 15.20.5880.016; Fri, 9 Dec 2022
 03:32:41 +0000
Message-ID: <f8fe9862-45e1-6557-8944-1319258ed625@amd.com>
Date:   Fri, 9 Dec 2022 09:02:28 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [tip: perf/core] perf/amd/ibs: Make IBS a core pmu
To:     Borislav Petkov <bp@alien8.de>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-tip-commits@vger.kernel.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ian Rogers <irogers@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Ravi Bangoria <ravi.bangoria@amd.com>
References: <20221115093904.1799-1-ravi.bangoria@amd.com>
 <166929138346.4906.10749574210524260976.tip-bot2@tip-bot2>
 <Y5IAi/fgbJk1/h2L@zn.tnic>
Content-Language: en-US
From:   Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <Y5IAi/fgbJk1/h2L@zn.tnic>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0135.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::6) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|LV2PR12MB5775:EE_
X-MS-Office365-Filtering-Correlation-Id: 556e7a71-2205-4290-3da4-08dad9960707
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A5nOxm/xpCLvF4ZHJoOA9E+/vCjxwaKk5pMzX9hOm+3pK9n9+KCUN0jlPDdCIOF2ESXoQn6ueiKKb4RtluXcE+5YtA9lZiKJHHBGXR8GR8gLNWynXtf+mpP3kLfdZx6iBKqB5AbfcpC2Y7PUYrtZB6m7g4ebwcLb/8mE6ch8XjINozjDK8O8XWYyL3fw8qNlF6kATyoVkGceDfd/exZ4vdF4I+VJfnFCN7rWtn6/RAO8Kzj6i/aU08Mqp0u0z47YyEMRG2x2AiQTnoDmNygGpbPnJcMnPQutplBL8bp2SDnYk+Tu/+DhIQkLvODnEz8r+O3fBYphRhEpqe6fV+oAeE1+7x+ZbX+q5JPOskYV7LgxSzaIQzw7ZleiB+6C59qx3rfgUsVSQEfkMmwNwiAt4xDhXIPjokZ8baC8yp8UcIl7hF/Q9DXSL+VQMfg9ff//leFh4vgkQd0zQEL6EYxJ6LVMZht+hu1nQx54Zgz+9piOe4TogFD24VLmFK7CTbNrUERPYOoplV8Q5S7NDsegs0lly3ZRACZF5vqnoA3KddrmizJkx2JvsGCIxkT4bUM0e0R/zEUP6xGp/JlaqS5IzvxVXVxZSODGOyGkSc98pLMtiyj2CaJZMJmbSN/r3j/qugnKgoqrKomE5Ye7lFg61UOlQxExYLn32M2J7J3PHfq65DpjBLkyY+NXaH0va5/NF7kJhE4L8Zs8LOnd1NbB4NxyqM88BKWvGXHD//TyhPBzV6QKYywBJDwI9ZJt5rn1QgHHt6aa02Kpdum+UpU5PzadBD5+2e9YeH/ep9wR1PSUWn8gZdNF6kbYeVe3n+Rl
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(136003)(346002)(376002)(396003)(451199015)(6512007)(26005)(966005)(55236004)(36756003)(6506007)(53546011)(6666004)(478600001)(6486002)(38100700002)(2616005)(186003)(31686004)(44832011)(86362001)(2906002)(8676002)(66556008)(66946007)(66476007)(110136005)(54906003)(4326008)(316002)(31696002)(5660300002)(4744005)(41300700001)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dFBkZzZvdTJocnZNYTd1THRGTGQvalNMNnUwWnVQWDlONGlONWNES2wxNnBk?=
 =?utf-8?B?V3hGNnRrbGVwam5BY09DamwzUyswLzZUQm9GWkM5MHlobVJkcUptcVpEOUhS?=
 =?utf-8?B?d3BhL0ZmcGhxL1pWTC9KTGg0OGdPOXJEcnZoclpFSUlYYm5jNUw2Y1p6OVJV?=
 =?utf-8?B?enZUYkF6L2Y4dUVzb01LV1dDLzRSL0J4N01reHkxNy9Kamt2dkY2Qnd2azRM?=
 =?utf-8?B?c2xybWpJUXNBMnNTUmxMeWZXc0NGYlBpZXA0a3dTSURmNi9uK2thWG4yd0Fv?=
 =?utf-8?B?U2Z4VFIyNVJac014VDAxbzcrcXp2b3NWR3FTbkhGMFZYdFNFS05rUEVEWVZv?=
 =?utf-8?B?R285d0tlcTloa05XYTNZcmc5dngvd1J2eE1uUWlqck5IWDN5ajUxV0V0S0Vy?=
 =?utf-8?B?eUtMV1NzTTk4T1k5aFlMSEhYWVFheHNIMDBrenZGaG5FaFpUdXY2WEdsTTI5?=
 =?utf-8?B?SHFyU3RFRmVDdllXS3U5V1J3Q0ZNRXZrN3ZzczM3bVpON0xWOFVXR2hDcTBE?=
 =?utf-8?B?N3dGL3dTampTWS9rb0Y5blM3cTlXdXdJQlBMRmtXTjN4TUhvdjMyMkZHMDNT?=
 =?utf-8?B?eWdla2FuQVpzYVNKMWFObnA0NHpJbUNuRWh6V0dNem1UaEp5c0k0Q1l1MTUy?=
 =?utf-8?B?ckgyZll5WHUyWiswOVFLOThlR3BXRVVlOXlpUDZZdFgyaXJ1RldBNFVyNm1n?=
 =?utf-8?B?cW1FaUdIQi9ONTA2SGlldGY5bWgzS2ZnNGJPajFCditvNUVPU0ZVVkkvUHdZ?=
 =?utf-8?B?Q0FoYW1qMEt3T3A4SDhwUW0wcTJXN3djSkZOOVFmYzg5UVhsRnB1US9BVmc3?=
 =?utf-8?B?M1lPSFA2NTBwRWFTVEpFeSsrV3BILzhWd2g4eUdZTWtLZ2trcW5VaVlqMEtC?=
 =?utf-8?B?SlduL2JpbnE5aXlNQlB6aXNxVGJGbGxGVUxzYlVpSE9mUHp5L09tZHA0ZEtz?=
 =?utf-8?B?Ym5VZjFuNXNrZTFBVVBBMnZtdGtkaDFKZjJJMndqN2FiNmtPUEE2VFFwRUlI?=
 =?utf-8?B?alh5L0hONmhqN0RNSXlJL2JQUzFrcUNPZFBJZkEwN1pJdm1ENTVPVGg0N01v?=
 =?utf-8?B?bHZacnFDbjkyWG9OVGc0ckwvdGNmV0dXaXNLeEkyRElyR09hdy9Cb1J1azdj?=
 =?utf-8?B?WXhPaXBUREI2TWlxb2N1ekRGZ29RWjFCcEV0Q3V2aTFMUVNlK2JMTGx2ZjRZ?=
 =?utf-8?B?RHY4b3VMNWdlQm03eDZNWjFIOE9oaWN0WHJIdWhnU1l2bE5mYU9NLzZSaVRp?=
 =?utf-8?B?dTRhOEM4RXJMVS9jQlI0SmZwcFdlM1Q4d0pERlF6U1JMWDBDTWtKTnl5VG9C?=
 =?utf-8?B?czNYU25nbUo1YTBFdVkwSzY5c1k3T2ljQ0Y2NFBBbzhoS3FLSEt4b0xkVEsw?=
 =?utf-8?B?RU9oU0RVZ0JqZllrYTdBQ2RMNzRJYU1UVGJId3FkYkpuc0RXaGFieVBqMWRH?=
 =?utf-8?B?Q21WejcxbGNHdzdzQ0VGQVVGZTFDSnNvSnZSOXQ3bFpxQjQ1b3BUVGlVZWww?=
 =?utf-8?B?dXBVdytSK1pBMUhwaGFwNXZKQnJHRFIyN0ZDOXpDc05MdDJlalpvKzJKd2Vl?=
 =?utf-8?B?V3ZFbFBmN1pMYlJrRDVHb3d4Zkc4czFxc2pmS3ZiamdzNExyek5HMGZ4Q1kz?=
 =?utf-8?B?OHlaQWZVN05lYUg1ZS9xTUIyM1NRekZOQ1UyRWFnY1RvZXdkQ2lacDlVTmdE?=
 =?utf-8?B?OHNkUzhXUWhCZGVQY05zUlJtdmtuWElnWnMyekY4ekRlY2YzVXVnLzhrajJ6?=
 =?utf-8?B?QTg5VUp2a2xvL0todndteHp5aXZ5bUtITXV1dVBXSUp3cWVIaWtnNmU3Ymx3?=
 =?utf-8?B?ampUNmRtNTVXSFk0WlhvQVFxWVlPVkZXWXEyaU9yQytyWkVqdXhDaENjWncw?=
 =?utf-8?B?ZDJCZXA1K0t6WmpMR1BFbFdtM05OaUJDZWdnREY4RnAzZ3FzcUxvdWtEeXhU?=
 =?utf-8?B?ZzJiV1grM2pYRE9RYUhSa2l4amRYWXUxTHNDWnpubWY2UW1uNk8vZ0FZZ05s?=
 =?utf-8?B?bisvNmcwdXhNUWpzdDdTayt6N0d3cXRYV0dmUWN0R043VU5meEU2S25jdnJr?=
 =?utf-8?B?Rk1pQ0VUM1hId3dvZkY3YWxxRmVKMVpFbU1ZRmYxVE9LbkdzSWkyZUtCZXk2?=
 =?utf-8?Q?m76dfINWM2OOXWLOESMmkZJZJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 556e7a71-2205-4290-3da4-08dad9960707
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2022 03:32:41.6645
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YGosClvZCR3HfM/P1bj62gBiq7CH/du7RfXtvcBawsVQfQo/UNUXtjMVpC0UfxIRm60f1GphBtrFjtioddx5qA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5775
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08-Dec-22 8:49 PM, Borislav Petkov wrote:
> I believe this is one of the things Linus wanted to have on AMD hw.

Yes, https://lore.kernel.org/r/CAHk-=wgRm26_oT-JR+TRzDsfhD1TRxfWDM=j6kJerv+m=NU-yQ@mail.gmail.com

This patch solves per-thread profiling issue. However, -e cycles:p is
still root only because IBS hw does not support user/kernel filtering.

Thanks,
Ravi
