Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B7BB5B404B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 22:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231810AbiIIUBe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 16:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiIIUB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 16:01:29 -0400
Received: from CAN01-YT3-obe.outbound.protection.outlook.com (mail-yt3can01on2041.outbound.protection.outlook.com [40.107.115.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C8FF94EF2;
        Fri,  9 Sep 2022 13:01:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TOEZqz2pEj+4JMcUnb4i3YQfLqh+KpGNFI5pzl2xh2b2jUl6NogIsD0mGojByKDfaiTDm/9KNmxbQO5g5re05iZD53aRPeyhqywhLedjnGPO8dUETSui2ohlkUZzoa0aAW/EZsk0zIoZlTKs7Xqhn92Ghjm2camF0u2yi+0DZxYgnmLWh3pqGmrRsQW0ognOWqbl09rmt9EAyvRQ0ju5AxlC8Kz4ZDvzZb+DHJN8y8FP/qePUBdEeExCVrLYiMJbaHRJ4S2NUAo2eIrXz078bbBaAD70ZZoSCtN1ieHliRaxKilZsMouglb3/ns9TQt7lz29UTT/PTDtx7v1t/orFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ZwehLCZjZXL25QXRvAOfVe6E9tR3VlZ3H7PnX543aw=;
 b=UN0TRFpyTL4sNPI/GqzfBbggpBEqCTNHcEZ6KAJvwcJXI+zHnyrsQDA5V8OMfi79TbdkIr6/dhVeWyQdomO3uHx1fTQYlBqWPT6+mMbnpbYeSqewhHfpFwit2rCWA7u54XLBb9D4qqchmP8z7wBGCnMZK2/BDO5sKcEIUWOw3pC5JBCC8cs2g1VznjbUpNMzbRneXGJ/xgbqac91dF7hFkfCSd3zJ7JOxcVcA1f388ALiFTIwP2sXohPd6qQb7vsN/LuRgufm1nXfBdYK2v9jF8YDXHfNINup2E0I9jVAUk9sD6se+6qcf9UAqJjNIsJD9liKhkE3iRZ5hbg+crPkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ZwehLCZjZXL25QXRvAOfVe6E9tR3VlZ3H7PnX543aw=;
 b=OM2RHXykAqTcyaGhvFADrRHdeJDKqqfzSy5oF+E+DpCJiybxk79CPh3V4+46O6Aho4Cxtkteuhze9K3Pm2+tNABHTQyczqzOOWhVtLEnyjb6b8P1SUQbKPbS8U7aGFZGhWoT2sSr/xmtbQy7baiyeGMmBjMJWiweg1DOCbhIPN7h01kEcjuKgZ/oIpuDYfhodqIaZFtRj0irvhSeNm/2ZU/MoPiIhmw5h4xCG7CHpQR/i2aVWjsdHxBC8aqy5DvOGEtVg4yMLIiI9cXp8HE8qr7K9Xff/qPvI85t8H/SIdrNYDOyCd/6JB+J1pa3wAqz2MWtp0Vi268E5Dh4Slxyjw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YQBPR0101MB5481.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:44::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Fri, 9 Sep
 2022 20:01:25 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::bc70:d4be:bdc3:4607]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::bc70:d4be:bdc3:4607%3]) with mapi id 15.20.5612.018; Fri, 9 Sep 2022
 20:01:25 +0000
Message-ID: <cbd08ae8-4558-60e3-17e4-988e625984a1@efficios.com>
Date:   Fri, 9 Sep 2022 16:02:04 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [RFC PATCH 2/2] Revert "csky: Add support for restartable
 sequence"
Content-Language: en-US
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Guo Ren <guoren@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
        paulmck <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>
References: <20210723161600.19688-1-mathieu.desnoyers@efficios.com>
 <20210723161600.19688-2-mathieu.desnoyers@efficios.com>
 <CAJF2gTR9_SzAm2kPXyP+xJDVmdvM=XSm7kJn_eNq-wQmhLqTeg@mail.gmail.com>
 <2070284546.6496.1627316900287.JavaMail.zimbra@efficios.com>
In-Reply-To: <2070284546.6496.1627316900287.JavaMail.zimbra@efficios.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0149.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:7e::13) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YQBPR0101MB5481:EE_
X-MS-Office365-Filtering-Correlation-Id: e4228b19-b35a-4ce1-b5c3-08da929e1360
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w50/tjI+3aGGvLyh22r+biVOMDzHIHnpjKFX2OPYuLg6d0Iu2E5yMgGVouN//oJYoHbmXpTqzg1cet4WkiYSg3eX8FA4IY4kneLpZ9qbGVck2z2Gn4tpOWPpHhJUHpb7L0PPmszBzVKNHXDebC0lQq8RbTK+Isw3rH8QV7Sx7QjeqBf6G8EfRmWil7KMYbrobrG46JSxxV2DL7qXFhCJb45D4z+5GdzBcfogs6jXCeQSUTRw9uzVtrsTUlkNxsfuwV9xF/lXQpquiOGS6ujkF4dF8WGmwg4Etgpn1emysVD2cpYcizodCc2cryG+ILB5eFjzYfYEeO42qZHDMF5tEZOcHVP3C9UKzDi78byykSf2ZWLz+YnT0IeTnCNXwe39fTMVWUYr3O+5lcgz0O4aMSeAQxeOc7HOXKSrAiqA577lsk3Drf6eySM7ylb7962ZJ49pa1fOF74tUk/K7qQoxicga0c4P/iz5ImRovnyQTdtTr0jZ2Tomd+3QUfkujrPizlce4YdGR31S5crM1FVKvfhgxcM1W3WEh4i4+O1QygQpZMfKSaBRDJiWGNiQ1rPskKFNQGA3ds0uGQt/4VRC96XhdMCN+pOFmj+ONycRdYt6ISZolFyVjIX7rkxkyoEDOUMie0TCDDGB+jtUZg0GagdKW+rsVvMIe7/0tQvnxX6rauQnCROJv9jnYiwZpKBQupOCPuc51Dq4hy3PW5IFokQAjYlrJYySsf3bvw/Ah4PcLebvYpK8v4nFnW8bcubWVIp0wTDDI8oIvrAaHW/2ABk7Cz34kL9ao0FCh5U8NxvKF0JkR/K8cVmiMgNHyyE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(376002)(34036004)(34096005)(366004)(136003)(346002)(39830400003)(396003)(31686004)(4326008)(66476007)(8676002)(66556008)(36756003)(66946007)(5660300002)(54906003)(8936002)(44832011)(26005)(38610400001)(6486002)(966005)(2906002)(41300700001)(498600001)(586005)(6666004)(41320700001)(53546011)(6512007)(6506007)(86362001)(2616005)(186003)(110136005)(31696002)(38100700002)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Skp3bWtFbDBhVVdMcXl0b0xqcllVZUlsREZMbnpMUjYwdTJVM1o0MTAvVExi?=
 =?utf-8?B?RG9VN0R6MWdicFp0dWt5NVVMaHlZTU40bmxnK3JiRGJYSEVxMXJYU1hYdnlG?=
 =?utf-8?B?WGt6MkZ6ZXYwek9iWkdUVHRzTkpEMmVRY0ZIYklTT0hQMnZpUkh2REVTUVJT?=
 =?utf-8?B?S244RXFsZ1ZaRXZnZTQ0NGhTNXZCZGpxcEwvTGhEaU1xOE1HRXJzWHdQNHBL?=
 =?utf-8?B?bWgzSjhPem1KeGhFYVB1Z0xYQ0QyK1VnVjhjSHBjWEJSNkJQMkE5MHZvVVZk?=
 =?utf-8?B?M1d1WkgySElXVUlUSm85U3FvNFhlaS8xbThZdEVXS1VHWXplTUhDZlhnUmcw?=
 =?utf-8?B?VllqM1FMSm1IeFB1QVpZeWpNRXZPLzY0VDFGdnkzOFFoVzRXazlGdzY1Wlda?=
 =?utf-8?B?RW11S2FPNW1SVWZDYzFnYzFxaExBYkZnMGtGci8xb2hQSGduK0RBMnBWRlhJ?=
 =?utf-8?B?aUptL1VUb3pQb1p5bE5MUFZ2QzEwNnBzWjBGK0x0eUpJcHpIdG9KWVpXdWxm?=
 =?utf-8?B?K1NGUDlNS2FnODB0d1BOM3hTc01YRGlvZWpURVJTejhGYllncDZQU2FaVk9x?=
 =?utf-8?B?Z0ZieXI5dHVsUXQ4bHE5bllsT2l3RFBPdEk3dWJvL0dXMVF5clduNUxJZjhs?=
 =?utf-8?B?Y0dlVEtHbXRiamVGbXlsSWl0NVRUMTRLRmxwMnFrTDlHZWNCdUlpRWxqVFA4?=
 =?utf-8?B?eEJzZXJCVkdHa2VINHpUNU1oVkxjRWVVYnlsN0tQczdwT21oREVFTFR4anZs?=
 =?utf-8?B?ZUhpeWVndmZzQnZzRmJjWmpxNlhpb2JmNTNwU1E0S3FrVGd4SzhnL1ZhUkc3?=
 =?utf-8?B?OUt3SUJjTWsvL3ZyUWx5L0Y2b2JTUzNKOXpLREFLL01WSjBjdUF6ZHNqN1Zz?=
 =?utf-8?B?UCttNFp6dk1iSXN6UTJ6azBSSzNLRWhEdjVRb0s3ZDJITXRTaTJoNVQ4L0VO?=
 =?utf-8?B?d29IU1dBSDFvaEtSbmg4bWxmb2ZoSWl5bFNzSnhtYnNhRlVOY1VrbnhlbVFp?=
 =?utf-8?B?VzBEN3V3b3RKTm5HYUhLaTA3SkNwSDB3eHQ2OCsrcXlRS3FodEVPT01sRkdy?=
 =?utf-8?B?bWUzUmFQRGlleHQwL2d2OTZhS1IrVjc2TDJmRWl6NFk0SFhtdWVwQ0hXc21U?=
 =?utf-8?B?MkFJNGpzQ3J0WU8wcWVCTWY5TjlYWjlhRzhxQkVEbmVpeTVQRGdnZERiVnVQ?=
 =?utf-8?B?U2JoZGkzTkJQbk43eXQxNmNXOStoQzNHRHp4R0ErMFFtSk54ZnNoZWxzdU1k?=
 =?utf-8?B?OEhJWlp4OUxxb2NYUnVVN09lWVFNMjk2dmpaTFowZHcxRVdwdEV5WVZVS1NO?=
 =?utf-8?B?OUZoWi9ZRCtWVzVXek5xaW5tS1RRVWpFTjBzZlNtRzVPMnU2SmZzZ3BBeGF5?=
 =?utf-8?B?MGM4QkFpYWl6RHJpSG5YVFVVNXdYZnB2MmdlaVZjNERsR3U4SVJnMDdxZzZI?=
 =?utf-8?B?L2NYZjVuT1ZUVngxN2FydjhXSVJvQWN1TGJNWWUzdGJGcDFpQ3NvNUhiWW5x?=
 =?utf-8?B?NTRsV0xMa3hSNkhGSkdpUDUvdElyNzNSYmFmSDA0UG1pbjRzcFA0b2IyenA4?=
 =?utf-8?B?UlhGYkJndmZ6UkN6OHRoL0VCMHFOV3Q4T2ZoOVIybnl6QSt2YnhnT1R4SHFT?=
 =?utf-8?B?aWlqY0hWYmRLRk5QMjJ3TThyMHF3NzBicEE0UkVrdG16UERGSjk3YXdpaTZl?=
 =?utf-8?B?R0kyR0k3VDBkVU5IZnc1eVNlZ3U1SnFjTnVHQlpDMlZNZEx6WVh5QmFUVEJQ?=
 =?utf-8?B?dHJmUE1xbDFmcEthRmdhZ2RGaWV1bGNQTTdwT1NmTmc5aUk0S0xrUVdWVC9p?=
 =?utf-8?B?NG9Mdm56K2pmLzBUZEM3UVlUVUxXelgzdkVBdmMwT014VkdFL04zSEtIVEll?=
 =?utf-8?B?aGNUZ3BxVHRwOGNzeDlqRmNSV2NLZGtYMVNxL09pRDFGL0FVL0h5WkFYd0Vj?=
 =?utf-8?B?c2lpYUlNa2h0cVBCejVTbS9DZ1d4dFBpU1JXVjRub280c3RISCttY3ZSa3M2?=
 =?utf-8?B?WHozUEM4cXRyOEZrbXIvMm84L29Ma0t6ZjllOWswN0xVLzVlYk9zNVhNSHBa?=
 =?utf-8?B?anZqellSN1Rua0dpRXEreE9LNE5wY1ZSYW1SaXhZVW5rK2k0VW1GbVdWQUFh?=
 =?utf-8?B?THRrUy9ORi9nMGtEb3NHMEtmU2RnU3NJRlhNbmp3K2tuQkd0UXZWYjZuY0Ny?=
 =?utf-8?Q?Fby/z5WTXrY5uY/KV1O2GmE=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4228b19-b35a-4ce1-b5c3-08da929e1360
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2022 20:01:25.5022
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5/2bRCzxW0pNDHve7mY7xjZn1/hmozxQ5wt/LCx6DHwDY8J24F6LjAfhGNh6mWdeGPNKRTmivEU/WZV90p2waz3npcSaZHS78v+xNJuz+p8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB5481
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-07-26 12:28, Mathieu Desnoyers wrote:
> ----- On Jul 26, 2021, at 12:10 PM, Guo Ren guoren@kernel.org wrote:
> 
>> Hi Mathieu,
>>
>> Sorry for forgetting to CC you in the last patch, and that patch has
>> been merged into master which has the problem of syscall restart.
>>
>> I still want to keep rseq feature for csky, and implement the
>> RSEQ_SKIP_FASTPATH for self-test, it that okay?
> 
> No, the RSEQ_SKIP_FASTPATH is the one special-case of test build which
> skips building rseq critical sections entirely. This leaves out any
> relevant testing of rseq per-se. With what we have in the upstream
> selftests, I expect this test configuration to abort at runtime because
> no slow-path fallbacks are available when the fastpath is disabled.
> 
> The asm glue to test rseq user-space really needs to be implemented
> for any useful testing to be done here.
> 
> Unless that asm glue is contributed, none of the rseq logic is actually
> tested on that architecture.
> 
> Considering the extremely-hard-to-debug nature of races with a broken
> rseq kernel implementation, proper testing coverage is paramount, so I
> still recommend the revert unless the selftests user-space asm glue is
> contributed for C-Sky.

Hi Guo,

A friendly ping after 1.5 year about the fact that the selftests code is
still missing for the csky architecture. So there is no way to validate
that the kernel pieces that were merged actually work on that architecture.

What is the timeline for contribution of the missing bits needed to enable
those tests ?

Here are the required header files:

tools/testing/selftests/rseq/rseq-csky.h
tools/testing/selftests/rseq/rseq-csky-thread-pointer.h (only if __builtin_thread_pointer is not implemented by gcc)

I'm open to suggestions from other rseq co-maintainers on how to best address
this situation.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
