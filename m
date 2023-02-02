Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8CA8687642
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 08:09:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231733AbjBBHJV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 02:09:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231673AbjBBHJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 02:09:19 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on20628.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e88::628])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5CD026AC
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 23:08:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EOFdjkaffo5oY79cXujI8sGJrzcu0VmBheLUNjpht2JVbFpL0T8M2u+OPxQNHr/vCxXSmdrIPhieELpG2bNWXZv4McqmLMq5HdY8S+J4+09JOV9BeI6Hfew2zbspR36zssfxdZAg5NXG3Jm9vuMLe/WzwYOi+NiN++SUFvJHoQxWn4Z7TiT+7fg1rVFt9CyOYlb/arTKTcJHtrXDWKbRlfXn+N3niBdY505KjRNFHZ1J6QefCZ5rQnzJ5x5b0s7IsfluNpKREz3KQd73eukUyKkKVq1NHn4ZwcozOcDmgpGgL6O8kaIVwV1gzNZHwGUL3ad+L80F0uqjrYgiWpVDTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ppIae5IBTTglfauzoAaIpc4AJk2kUCFj8uS2HMLcfF4=;
 b=NlAAgNAEPhmKSmjHesfMKH8d5omuLvrqVPebiFPXSefPE9zdb7VWo5XUuQry2EjpSaZ1Vvz6TtAnAJgInpeZoxY7w6xsufJpRn0gXKkq7oe0kV4rTngHykbTZYTRaPHUl7oMzdubAwWHvlwF1xHr/7RoX9W51e/avTYPOWfBCVApvsC04oIAgcpdTv4hjYGwcbMZiJiubXszVIxID2JFkA0mp0yU8A0NItY44UhpZ6/qKae2wln7NEOPr/q9sOeO5Z+qA/GYN+3g1ZhmMqsTzrY/eXNG7I7U/d9b58oiyoGjFsInu+mi6ZdCt0nhapnRJlhdkeSV7AujqWALTmPEqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ppIae5IBTTglfauzoAaIpc4AJk2kUCFj8uS2HMLcfF4=;
 b=mx1kDfvEywsMqbH+A2nejPgSKMykIGxNaHT5jP3v14EQB8yu29KkxQ2vYDzH7Izv0D3AqTOIMVo1JTMu60B2MctiefqcaLDt1SnQCfTdJuSUvpOOHedNeY7EeVJ4sKKd1slEVKSrSBWFBReRds93vCQ87t+R9X1kWhzTe4pU1dmpYgS0kWueRl+E54kQRpFCuVJskMeg2lOk05IufVdCaR0riuKrrbcJq2odv832bNle18Elvs8XD7C5LUXYomEyVtYBvTGFmpDIhrZ/K4Uot8iG9s3z9z2ZYzpIQ3iwbMHCkF9ZXDxkFu/1ZsRUYRBkRG/V9hXpPYcj5nHUjOoalw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by CH0PR12MB5107.namprd12.prod.outlook.com (2603:10b6:610:be::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.24; Thu, 2 Feb
 2023 07:07:04 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::465a:6564:6198:2f4e]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::465a:6564:6198:2f4e%4]) with mapi id 15.20.6043.023; Thu, 2 Feb 2023
 07:07:04 +0000
References: <20230131063206.28820-1-Kuan-Ying.Lee@mediatek.com>
 <20230131151742.df43c3fd11bda01b613234ef@linux-foundation.org>
User-agent: mu4e 1.8.10; emacs 28.2
From:   Alistair Popple <apopple@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        John Hubbard <jhubbard@nvidia.com>, chinwen.chang@mediatek.com,
        andrew.yang@mediatek.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] mm/gup: Add folio to list when folio_isolate_lru() succeed
Date:   Thu, 02 Feb 2023 17:09:02 +1100
In-reply-to: <20230131151742.df43c3fd11bda01b613234ef@linux-foundation.org>
Message-ID: <87a61wmtpq.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: SYBPR01CA0193.ausprd01.prod.outlook.com
 (2603:10c6:10:16::13) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3176:EE_|CH0PR12MB5107:EE_
X-MS-Office365-Filtering-Correlation-Id: 70680a7f-8772-4e99-5ebd-08db04ec1688
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L8Q1YgwkFrU3nTTtfB74A/x4Lil1yhEhvOmx2wnVutZbs5OsQMibSbuXEqM8/icUi4RojAtyzw8mC4CNoAFoX5/iFGkwWgzU2jtcHjw34/P/3DzEz/3uSYoCCYRJ+gtnVM2vGFvC7GA+u7n6b+T3jnuoaUvZ6Bn/r3sZ0ieqMjiVxxq4FqhGoFEAJGjzy4Pfz8kS7//BBR1+wcXZBe/GH5UfJoc8M1Be+XP7EcRvAAjzmyVPBZs5O91+BjD6h4+Vcv4eaAnqq+YdkCe0GonuxDlDFSvcxvvc4NV3Lw4Y9BBKixsLtoB/uwlwXrgQjE65EMvr7q8MERQlmWfN5q+s6UvhcLKhMmJjK3on5KK+2/1ImYz3TJ3d6I8i2FgDjQlgpqqJwZeciJnhzalLziT7/xWyitFmmtnMKnHuYpU7znjmBZ2NfJhDB9+thMpZOgIAKQAxzjEFuLCdvV+XLF2jCW02FPfd63rbQum6PtL+wQV2XIQ9y52gJ9x6Tus3fUKor3PswTT1zcurgzTiVpgtUNGzeq99pMUAl7mpYTZfVeI6Lm/i2uR/xVOjGr8zynqxWry1o0v3tTrPkCgMrxghL3nTRNGz2VI9rpo5LcUdI9Dp2jhwTOVw07fNZ3Z7uWvUHtZSAGjaAKt88EDq16EZzg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(366004)(346002)(396003)(39860400002)(136003)(451199018)(6506007)(6512007)(5660300002)(26005)(186003)(6486002)(316002)(478600001)(2616005)(54906003)(83380400001)(8676002)(4326008)(6916009)(41300700001)(8936002)(2906002)(66556008)(66476007)(66946007)(38100700002)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NVuhIST1PbW4XJIU0HJzxmcgnsS4EGOeOQlgvlwjQDoSTv74H/J68tvfLEdR?=
 =?us-ascii?Q?m3rWWYE+2a//AsDCQ8gn7qmgbr29K+EoXfaarALgq+cFA89+N4Dcqb3/qu7A?=
 =?us-ascii?Q?GtRk53Z2RJb0CTzIkBNLLCFwV3J5dejCDOl6dBymLQuV+/O6/VA+iikr1Kmt?=
 =?us-ascii?Q?FYI2cOcr+vOp2b5B0xkBaaduYfJZWXE7irVvRaetPUakc7pCcNGqhMVeS/II?=
 =?us-ascii?Q?rkB1VhwLHOieKfVWhwK5uhkrGrv+Ep0SxC1IQ5KzyXCRsq0PORdneTdH+0ma?=
 =?us-ascii?Q?zBY5ucgLXqnH4QpSOW62pZsyeRFzUdbhY2Gr3BAXxl2ehQoYhRJzlCyu+Hxh?=
 =?us-ascii?Q?Tw5EcbOTtK1JjWMGgjAcIdkUzQs0sho13RgAI3RwEJgNINbX11jNHjM0dMqE?=
 =?us-ascii?Q?BOj2RHxr8ZqnzgvlDeeh/e1mHsGXzwO9PeVgsjd/qVWwldwj3J3TN8FiGiPq?=
 =?us-ascii?Q?42sZEsQ/0ZEtx2nynWpy62GeidVDv5m31iwJG0QdTaoVDHHmLpU9DesKe0jI?=
 =?us-ascii?Q?2wp1N2+miGs8t4p31TiifcTmuQVaewRQsqdr202w4azOW9r7MZ1y3+hUaQDi?=
 =?us-ascii?Q?ETlTuLBIsCgr1puGjcEOEJa58a2joOoq3mWhsv8D4LIxQzXW2HOkLhulsI2V?=
 =?us-ascii?Q?5YZj0+ooFZro1MzsMP4up9nd6K1heCefNKU7HKarsB7aBnbCX97Z3lYpB1bD?=
 =?us-ascii?Q?lgWSpIREIbfSN+JNm07qWYMNLILatw59jYOXhEPT1y5IiXpYmaHa1/dmi9oY?=
 =?us-ascii?Q?X1Bd4n3oahRJKy/93xL8qdSYEc8NAvU9DIfLkz0nDaYT76fQa9B/PdgnXo+p?=
 =?us-ascii?Q?Qtz3vZndTHPKqSwWz9HdVOIcdWGGJ3OE4+h2EH6cXX10WMafsVKHQpFeiML4?=
 =?us-ascii?Q?1ctlX+BrtLX+X64EW3VOvjGmNc9TECN+1gzZPYxu5ZJ1vlm9Sj3P0CFvfURX?=
 =?us-ascii?Q?v8CPIbyAlHRdrPo1vscyEwBnntp4PIFH2TGUgHFv2eDBxsSJlcFSHLc4F5gJ?=
 =?us-ascii?Q?ierVfBWuOTduvPdTKsvsAv3i9go4rM0w48QGFOruO/CU0OWb9qhm+nVykHtZ?=
 =?us-ascii?Q?ghn7ES9Oo+LWwURh3PwJHdODp6EWlDrNpSqlAnCDJGpNDEj0kiEBpdIXWV+3?=
 =?us-ascii?Q?af6InV8FmQqXIHzout4zhroL13yAwQNDN73QiA83r0D6LApMiLfvSkighQw3?=
 =?us-ascii?Q?yTqsmsrS+eEXy15nuBanJgAuXkLGSlE4WKs+2CKBpR7LcoYKgs/ziVhsP3e3?=
 =?us-ascii?Q?eT1QVlGEiu9sE1OJNnt1v0f8EzKveym5HgxhXdgGoIOQmyAlMs3R0UhgbbZ6?=
 =?us-ascii?Q?yXzmkBOyFpxKCap0GvrmQQSDic+m+bmefVnWWcgy+DUWWlQhNDvqHJrVZKwY?=
 =?us-ascii?Q?Uui6hoaxN76J7lMqWPeLDWOPCeg6dvrEzuJfbpsBukeONWeR9DeRh0m1Q9pI?=
 =?us-ascii?Q?ldBPGeDX3ZNSek0SdlAdlpSSSn+/SZBvHEXfgarvFFZleq6IpmXz4PyUYY0F?=
 =?us-ascii?Q?xOvfLInCUELYSDR5XKkHoqDjpfSXII/eDFcnJReejfKnaNli5OE55xp+y6Eh?=
 =?us-ascii?Q?QUpGkKHy+MBJ1dmd3YiXysGffKOgqg3CRE50Zo0S?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70680a7f-8772-4e99-5ebd-08db04ec1688
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2023 07:07:04.1917
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NSsfzmj0Lqd77SQjmGVMknLLzvrfjILonPyT37/PWXBfS9XMZHcP733lnchvEEd72ej7nYyjsBbdbV0wdJd8RQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5107
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Andrew Morton <akpm@linux-foundation.org> writes:

> On Tue, 31 Jan 2023 14:32:06 +0800 Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com> wrote:
>
>> If we call folio_isolate_lru() successfully, we will get
>> return value 0. We need to add this folio to the
>> movable_pages_list.

Ugh, thanks for catching this:

Reviewed-by: Alistair Popple <apopple@nvidia.com>

>> Fixes: 67e139b02d99 ("mm/gup.c: refactor check_and_migrate_movable_pages()")
>> Signed-off-by: Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
>>
>> ...
>>
>> --- a/mm/gup.c
>> +++ b/mm/gup.c
>> @@ -1914,7 +1914,7 @@ static unsigned long collect_longterm_unpinnable_pages(
>>  			drain_allow = false;
>>  		}
>>  
>> -		if (!folio_isolate_lru(folio))
>> +		if (folio_isolate_lru(folio))
>>  			continue;
>>  
>>  		list_add_tail(&folio->lru, movable_page_list);
>
> Thanks.  What are the user-visible effects of this bug?

In the common case none other than an extra loop through
collect_longterm_unpinnable_pages():

1. First call to collect_longterm_unpinnable_pages() will increment
   collected and isolate the page but not add it to movable_page_list.

2. migrate_longterm_unpinnable_pages() will return -EAGAIN and unpin all
   the pages but they will remain LRU isolated.

3. The next spin around __gup_longterm_locked() will re-pin the pages
   and re-call collect_longterm_unpinnable_pages(). As the page has
   already been isolated folio_isolate_lru() will return -EBUSY which
   will add the page to movable_page_list and complete processing as
   intended.

However this assumes the page table still points to the same page when
__get_user_pages_locked() is called the second time. That may not be the
case in which case we would leave the page LRU isolated forever
effectively leaving an unmovable page in a movable zone which is what we
were trying to avoid in the first place.

So I think Cc: stable is warranted.

 - Alistair
