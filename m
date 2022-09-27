Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 988E85EC010
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 12:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbiI0KrJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 06:47:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbiI0KrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 06:47:05 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2041.outbound.protection.outlook.com [40.107.94.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88810100385
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 03:47:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MW0A3w5z+FW97t6XIbWSKW666qWCf/mVigTvU3XkOemQ02xZUrPG/p8RhnIg5TOswPK5pb2xPEReCodUfrjLBzOYLvbcpSSV1pjH9UOIN+rAD2smYYttoZ2SBQ0zLt9lp1VpJMuveZgjITflLRmmi272r/U02BPxzkK1jARyLRgtXohEE/HsQAsqiKMAUWlx3tpfuhWUQf/TtN3V8y46r7KcloEdpLkGXUGQHEBpqvsTTYLntv2igm8635YjBp3kKkhtgBAZKj8jyZndSHvsuBw7OzMVjTkU/2wVuhGcuT6wfyXTxe5PjRjhrMJ3F6Ur3pKg7AmElnEyrvHuhvNTCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=amXKABr1Nd8PhtLNskmC/S5S7YnNmJ6FJ8nvzQH9sMA=;
 b=G8gXx2m7zTy+LPHgpkhWJ4JbHrWrEfQIK5sM0yFAbyGkivlOaOc+GGdZfOSGTJywVT7SuaHg91gW5bABUCrx3sA0XpG5mPFK66zsSJPuRWP/8cOKtU4JeSqHTelNL4yrsiGxK62RDUC1CE3HR8Bw0FVygjz2gc48W4GxjT65FR3tvoLG1rvCQR0OcVTZlLG9/EerC58YoEmGA4/z7Lsy4GMhudURvrrfLGfVelX9R6lemFFkUOXfkQI1CwRGTFOg/fg5AcJoIJYD49Ck7+kVPrEy5n7hCnp7G094k1CI7Ze2vzk1rxqXcdnDE0QH+Tec8B+QkN7cWoKT9U5o8/jwrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=amXKABr1Nd8PhtLNskmC/S5S7YnNmJ6FJ8nvzQH9sMA=;
 b=37H7Vj98eYUOLhlvQw9zN+j8wkY3OISx2lr13lwwdZA5ZvwaNRcp/c4A/o9F6YtPIuxdTNilDctVEYTlq4vZnI8+XFQKebFXfpBRk5bgh94JkltSa30wEI/96bM6mGeb+soZllI7fLVSfi3ZvA8UvMpaybDYXs2LoUqc6/txCys=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6434.namprd12.prod.outlook.com (2603:10b6:208:3ae::10)
 by CH3PR12MB7620.namprd12.prod.outlook.com (2603:10b6:610:150::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.15; Tue, 27 Sep
 2022 10:46:54 +0000
Received: from IA1PR12MB6434.namprd12.prod.outlook.com
 ([fe80::9408:8ebe:726a:a001]) by IA1PR12MB6434.namprd12.prod.outlook.com
 ([fe80::9408:8ebe:726a:a001%7]) with mapi id 15.20.5654.025; Tue, 27 Sep 2022
 10:46:54 +0000
Message-ID: <b9fc8a52-74b5-2f78-fbf6-8b473c6a8a36@amd.com>
Date:   Tue, 27 Sep 2022 16:16:42 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC 0/6] migrate_pages(): batch TLB flushing
Content-Language: en-US
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Zi Yan <ziy@nvidia.com>, Yang Shi <shy828301@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Oscar Salvador <osalvador@suse.de>,
        Matthew Wilcox <willy@infradead.org>
References: <20220921060616.73086-1-ying.huang@intel.com>
 <477e50ab-9045-0ca2-6979-e2dca71be263@amd.com>
 <87bkr6jzmz.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Bharata B Rao <bharata@amd.com>
In-Reply-To: <87bkr6jzmz.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0052.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:22::27) To IA1PR12MB6434.namprd12.prod.outlook.com
 (2603:10b6:208:3ae::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6434:EE_|CH3PR12MB7620:EE_
X-MS-Office365-Filtering-Correlation-Id: 8246bae2-56c6-4589-1574-08daa075974a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qyyDTWYqDysj+y42hue4VBOHvdhtuJ+/8RkrcbK4cobApSArKeh/7Oxc4+LWlNty6gmhz5jB7EAXDSKda1+6xY4tBDsKW7Wzb79Mjvx358FcLPgKNyE8kO0OtxbDIM3UuQqb3ux00gVRsLnKif7lT3Ui0YP9VAdHAOORre3UwSIhfpa9cCp9pz20wKcSQaPZXHdG7+sSo+ACX5XHk0sEmaXlhgW3zMx6mPXISw/gtveDe8ZmA2OrdyaYCm25UVTDcZ2jFeHl7JxztHP/Wq52zo4nyr75Q6B97NTQFsOoxQXJYR9n6NfkezUJsy8DRUj5CAMasCVk4qBVaYmo5zD5mWApeBYlzHRhqcD75eiBoKX8LKtx5x8TvzgMMtlvJ8G16h2p2tS4Rzu3k5D++4BtB/b5ch56RqaRY+DOZ52EVxlr7aU2ev38AzsUlJHdluxfJ8GYP/Vg3G776KZx2cJmuQgBykKfuB/7KNCC6iY4g1PVWx57IDm4rkRPnHigN0UbcLa893iyDqJKZ3Cj9K690NKX5oki7D+JOACyjUN75kSr9TucgbW7bZ2JAZaqdoduGNZyvp7PtxmwsJ9Y6Tzjk1q6rk2rjkKqUS18A4JmbBCg3CBHWfLSNq5XqBHOK9U7sPTT5mjBuLKg/zDjak289D4h8MMFr/dVoFwD4rYbFmFGVyRRjHQrXloMhjvApw6HSycUU1Rp7WghPt+CUfspOTsf2c2bh5gqqgZVH5Py4H+6MHz4RBjSC7C1yHzUwfgt5OFI2A90vduod6TQPXxGZD6OaY1nDMgB0NruIEc8oqk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6434.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(39860400002)(396003)(346002)(136003)(451199015)(38100700002)(478600001)(31696002)(6512007)(26005)(83380400001)(8936002)(86362001)(2616005)(6486002)(41300700001)(2906002)(5660300002)(36756003)(316002)(186003)(31686004)(54906003)(6916009)(53546011)(6666004)(66556008)(66476007)(4326008)(66946007)(8676002)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bmxMTzhoZFI3RW9JaXpIS2c0QmpoSWUwVHJhanR4ZGQydjNrRTA0YzF4cXZO?=
 =?utf-8?B?OERzNGJWbHdCS203Z3FJVXpySXF1UVIwMmtyT01CRkRPSndxYS9UREFFU0Nx?=
 =?utf-8?B?NXBBclc2aGpIM3VydGNhOS9YcmZTbWJpcHNua1dSNzJEbXU4SVYwSkhPRlBM?=
 =?utf-8?B?K2RsSlZpVjlRMzJhM1pOL21MbStwalVuNWNiNGgra3RnbGNVdXYwSm14TUR2?=
 =?utf-8?B?NGx6eU9xRGdYU1hScm12YVA2ZHlPMVozdHZNSGdybkJsRFI4VHBibzJZbGZP?=
 =?utf-8?B?ckVKWjN0STJUQTE1clRXRHlkR0RxVWFhL0RmM3ZTUmlROXhBYmZjNUs0Wisv?=
 =?utf-8?B?Z01oN1QwSndwUkFtRkR4M3lIWVM4ejFXcUZKZXdyN0dHaHRvQ2tTWitSaDFx?=
 =?utf-8?B?bW5Wd3FUdnpWV0JvZlJEdllrbm1wdWl6RHNMd01yY01oUVI2OGx1RzBMbEhS?=
 =?utf-8?B?OUlSc1RpQk9JMUkxNTNrY2g3Ujg5NUUzZmNRVFZSaTZEVUFxbmp6dzN2eGdP?=
 =?utf-8?B?WGtCRXB6TWk0SHkwcnh2cnVuMnpBdEUyK3pxWE53VCtZVTJTU2tqMGdhRUtq?=
 =?utf-8?B?T29VM2xQeGpUUkhvMGt2cEVhazMrUG9tM3ZkdFppUG1mdnFkdE5qOTNOaDc0?=
 =?utf-8?B?TS9yL0tVcDh0YjExRlZhb3RJeGFqaUI2ZEFqekhBRVI0YnlDMnA3UzZXbHdN?=
 =?utf-8?B?WlBjUGxKUDh1NXN4TFFyZVJEWklLWGkwcGw3eEZibmlvTmd2aW52YlFsa29F?=
 =?utf-8?B?a3FSN21nYVpPNVFwVE1lcU8rUXhhd0RrNVRiT3BKMWJ4ODQyNjVob2RLUTRC?=
 =?utf-8?B?Y0RvVGxSOWYvcUJST1VtbUQ2eDhncnRvZUFxaDVIeVdJUHVWVUxzK2QwbUtZ?=
 =?utf-8?B?MVROdllFYUNUemUwdldEMENYbFJ0UHlhYS9TV1ltV2lxWG9WREZLa1BGOCtX?=
 =?utf-8?B?TGVXZ2cyZ3BrQVY1ck02RWtsTXRiU0JKZU5Uc0RVVlRMWUFHRjkvbitKVzRK?=
 =?utf-8?B?bXg0cXh5N2UxcTkrYUpMZkU2Y2xzMDRKMlZySHk3WDhpVTVHMVZDcFRhQUhZ?=
 =?utf-8?B?US9uVXdBZXhJdUVXNGhIa3p3bk9JcUxiMUtEUjNtdGRpZmsvWkxsYTFlWGVo?=
 =?utf-8?B?bktvVGRBVXNLYlFyaUJKczlRUXFxK3pFRXNuZC9TVmw3RlMzTmh1RTNvRFRX?=
 =?utf-8?B?UFQ0U1NzU1BjMXFIbCt0U2c5dkg0VFZVeDhlb0dRS250a21XT0NJd1BCTm94?=
 =?utf-8?B?ank0dll3Qk4venQ2clRKMGJ0TzA3S2Z2YlBxNEoyQzc5NDZHcTY2cUJzTU9D?=
 =?utf-8?B?SmQxMWNTdVJMMDNXK0VyT05TRmdyY3JJK3pYZ3I1V2xva1c4RnEzdEFyS1JI?=
 =?utf-8?B?eGhjTU5qM3BOYW5TS3BEL3BFUFdSRzZaZ0VYMklKRUhZQWlrdzVzRWExUHBj?=
 =?utf-8?B?WVV0NXFzUUZMbFdyTExQclN2NVRuaDA1QkhRNy9NZnBsQ2RqSk5VTS9ETUJY?=
 =?utf-8?B?eDlDeTEwOXZEdEZoYmJjSkdyTTlkNlJ0Y0ZuL0M4Z0w1R05NU0liSDYyZS81?=
 =?utf-8?B?cXZ0N1RmaHNxVGNzWloyczNWSlJ4TENBcGo3S3F1VVNJRUx0ZitwbEdkUk52?=
 =?utf-8?B?UWdKblNJWGw0RDJpWFc2Znh5WDBaSkVqRHoxRWFqOFB5MXVwMWNEWHQ1d0dV?=
 =?utf-8?B?dTlXaitSYlhQNWZWelVRRSs4ck5lVVFRSjZoamtyTWdBT2VFbE9UWlNseEJP?=
 =?utf-8?B?YTVYWEpEMGRweXVZMml6aldpR2k2N21RVm1XMGswQVF2NEhRMHpsSGRCTkEr?=
 =?utf-8?B?RS8vUmJUaHNydVNqS2gvbGd4T0lTaFdnRTFKN280MVd3OThzV0Q5MWpsRE9h?=
 =?utf-8?B?VWtaeDBhRkhzV213b2NuT3h2WldleTltUTVQRmhCWkdVR3VTN05wUHQyamln?=
 =?utf-8?B?NlFYTjl1NVlVMEZuNHVwSFJJNUdUN3VERHpRSVl1dW5hMW5oRmtZbi9MbVpP?=
 =?utf-8?B?SmRNZVorbEQxN042UEVLT3BkNm9uK3RyeVFzYjYrMVBsL1RkRmhTUWM3ajRH?=
 =?utf-8?B?LzN1MVpaNVFzc3JLSWljVkpPQVN1M0lWSVJLQ084bW5kV0VwMmx6Vk15ay96?=
 =?utf-8?Q?gi+r6ceKGaDrVuR3w+DxFNb1k?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8246bae2-56c6-4589-1574-08daa075974a
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6434.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2022 10:46:53.9772
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Q0pd8/Ier515usNJbF6VqytpTOF76rLKKWah89uUF1Dny7+ZERujVVG+szpTy6YGzKeDeA8zRTn+Ly2Yr+B1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7620
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/23/2022 1:22 PM, Huang, Ying wrote:
> Bharata B Rao <bharata@amd.com> writes:
>>
>> Thanks for the patchset. I find it hitting the following BUG() when
>> running mmtests/autonumabench:
>>
>> kernel BUG at mm/migrate.c:2432!
>>
>> This is BUG_ON(!list_empty(&migratepages)) in migrate_misplaced_page().
> 
> Thank you very much for reporting!  I haven't reproduced this yet.  But
> I will pay special attention to this when develop the next version, even
> if I cannot reproduce this finally.

The following change fixes the above reported BUG_ON().

diff --git a/mm/migrate.c b/mm/migrate.c
index a0de0d9b4d41..c11dd82245e5 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1197,7 +1197,7 @@ static int migrate_page_unmap(new_page_t get_new_page, free_page_t put_new_page,
         * references and be restored.
         */
        /* restore the page to right list. */
-       if (rc != -EAGAIN)
+       if (rc == -EAGAIN)
                 ret = NULL;
 
        migrate_page_undo_page(page, page_was_mapped, anon_vma, locked, ret);

The pages that returned from unmapping stage with -EAGAIN used to
end up on "ret" list rather than continuing on the "from" list.

Regards,
Bharata.
