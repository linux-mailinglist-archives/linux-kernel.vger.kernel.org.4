Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B41A5ECF44
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 23:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231688AbiI0V0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 17:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231292AbiI0V02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 17:26:28 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D43F146F9F
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 14:26:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gKnXsAu9iN6zPSfuJRBCuI3+KkDHfrW96xFpBv1wLP2vUOERPrV9KO1BvNU3HakzgSARN17sjZShRm0YTsuSefTKw1mxKz1NOE8z4OeNBrf673GOqLg3OC4tuT3+SS0BhLFo6mhclBbf0yt9XOzvCbJPIwpoO42Z/5CJjFCSm/Lp/+BwoqZgNt9pIavbi2BeW06GN7CAVr7PjBIjdbqMngSAjAY57YNFVsVOvz8FCBNOIT7ZuVAVxnEAMueGiTmxCIt9XebIQ0XOmjt0nE8FCo8CedsodFl8tpzLEBJhdimn9Q6RpbwY1O2OyDf0qzx4V6eq9Ge4wuQWH/AGt3IkZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jdxjecUQY0H0y2FcBCvFO2zxeoUScTB+0m1HqOi9TkA=;
 b=LgBnQ1hlnViwKJox9Aoq5knQw/HstF3ckJVqHd8Pq/9RCXHLa/6ZKjwzTXgozOFl+HO++EOeWGePzZU3gxx+dn5ebCJ6svXa5zozf2s+rEWj7Fnk8q4owftU84gNGIZo/gWLVcQ3bHcC//5fzupjPBMhN28JjSwP+0xakt2TTCvFJFYqToiEandubMyOvvHZhD7ujxRvsrtT/vURyRxvsrm9QaGJZWgXQSo6AhEQmzGZzYaBOBVwKykkw2+RFXifB/0sDm3zJEzzdPaRV0nrxz7XVm3PfHnD4/KAX0GeeRx7cYsjJkBFKvFPvfuQNdTemcPqcaGmSWFdqIwie7qWcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jdxjecUQY0H0y2FcBCvFO2zxeoUScTB+0m1HqOi9TkA=;
 b=Ami/fylZE9nmUvtZ3itMd370lmKDAfITtBgav7C/yTt7nuEwTApVcrMGkhkX7+zff9VgTlR8hoIiJvtgTUentT4GIUWWhg0d7cLtwbY3ct8FYz+JRHSin6OKKogVWrqn4n1HpW1lkyZE+eLN0Jen9HM/53Jy/fFzHG8wseexyARqmX1SabdL+c0cH+VJjZ0uD670T8UAr8APN/FkkTJwDnfFF/WsfCKo/3/4J6Bvq+ZHJVt/S02vJABqRY0cnNMbl2DSsuLxqmXg+7yxrigX4IIKeE/pnE3JeR7sXIcWcw6QPjcm3WhdCEAK0PhhfX6/b5bBzV12KgT7meU81Kv+GA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by BL1PR12MB5970.namprd12.prod.outlook.com (2603:10b6:208:399::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Tue, 27 Sep
 2022 21:26:22 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::51d9:c02b:e5a1:254b]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::51d9:c02b:e5a1:254b%5]) with mapi id 15.20.5676.017; Tue, 27 Sep 2022
 21:26:22 +0000
Message-ID: <10594124-b6b7-d202-d90b-72ac9d8bc9dc@nvidia.com>
Date:   Tue, 27 Sep 2022 14:26:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [RFC PATCH v2 9/9] mm: Introduce Copy-On-Write PTE table
Content-Language: en-US
To:     Chih-En Lin <shiyn.lin@gmail.com>, Nadav Amit <namit@vmware.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Peter Xu <peterx@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Tong Tiangen <tongtiangen@huawei.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Li kunyu <kunyu@nfschina.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Minchan Kim <minchan@kernel.org>,
        Yang Shi <shy828301@gmail.com>, Song Liu <song@kernel.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Dinglan Peng <peng301@purdue.edu>,
        Pedro Fonseca <pfonseca@purdue.edu>,
        Jim Huang <jserv@ccns.ncku.edu.tw>,
        Huichun Feng <foxhoundsk.tw@gmail.com>
References: <20220927162957.270460-1-shiyn.lin@gmail.com>
 <20220927162957.270460-10-shiyn.lin@gmail.com>
 <3D21021E-490F-4FE0-9C75-BB3A46A66A26@vmware.com>
 <YzNUwxU44mq+KnCm@strix-laptop>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <YzNUwxU44mq+KnCm@strix-laptop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0017.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::22) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|BL1PR12MB5970:EE_
X-MS-Office365-Filtering-Correlation-Id: c1ef87c5-356a-459a-1bd9-08daa0ceecbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mP/n0Gz0wjWCbwSgFD6Gt5Q6bkrgxaNHIQDGnGO2TuM8wT39WOMj6BoM4F3qdp9UR/wfE0Le19un2GCpDVoirHFt3FtLgmRNcd4gX8M9WeViDQW5Wob0fjgSrXhZEiiJabkicgmP6YzBEW8V3YGjxKBioN29AooLeSqldqGLBjekyO36p95wiHaEbLUqGSbKTeP8F7uMbvT1VN5A6gyfnjRJk9eulwOwfQ5xvSOLhTQ3mgxXrbnFBESx8YFhC9ZCHNENMQmJCL4f67M2VtQwc8O/CxvI8T2g/oyExh4GB80CqaH3LvgNdIxZRU2sbHqDzF5VlNeULW1uw93tw4xolTy1FcVbAI6Y8RmhG3QRzOZPUFA0DyvnSWChs2rV2aF6x+u/L8W43yg/N1pL64zSfuHwXpJ4CM9Ify7anHKkvThxSuptNcFqKrjD8HJigDUyxEaKKOegnWBoqyZpVt4wZ2jixwt0bub9EQn7c4dcBmzWTrSOgU+O8qSwr6O5Y/ncXSTkiUyJP37DefmX9U65pIO4fs1ZzelMNBX1DPdN0WnqW8tQPzVsW0ya3JtiOWMc7rfoNDgCUykuelxOn3skrA3Zv4tDYW4vfbHrPBxaMb8wKUosm/+VSwGgMa/yIBvxpwK9xi/wgkp7D0ru5Uh6scfR4AJtlq1arDuKbAIEYF0Chbnad1hcPCK1NScQF7LLYAUimALS/dpCAUvF4OkKOzA5qpIMzkLJzR79CGjq7pg+t+vMaUGLT2mZ7e9FdgdmeOs+JqX+BhfXEeAo0QFIJ4krlLzJ1gnYy+iRYVZdp3w=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(396003)(366004)(346002)(376002)(451199015)(2906002)(66556008)(66476007)(7406005)(53546011)(6666004)(83380400001)(6506007)(41300700001)(4744005)(66946007)(6512007)(5660300002)(478600001)(38100700002)(36756003)(8936002)(6486002)(26005)(186003)(110136005)(4326008)(54906003)(31686004)(86362001)(316002)(8676002)(7416002)(2616005)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T0dqRFhyc1I1MDdpNy9HamIwMERraFlIeTFFbDlDaWZaSWQ5czk2c3BnbUdz?=
 =?utf-8?B?YmVzb1pGYUt0RjVlaXdXM3BjR2I2TVNOWkdWYUJwZ1lCUXBrTWNCU1F3MEdU?=
 =?utf-8?B?Mll2TkRYTUw3eVE3SnNPcjhOTTM0Q1phdTEwOGNURWdWbmEwdE56ZElaeFlJ?=
 =?utf-8?B?d3Awckdxa0g5andkZ2VXbEhtRk51SDJ6QkYxenVRbFQ4VmxsTE1UOVZtcHpC?=
 =?utf-8?B?ZlN1Wjk5cDJSNlFGWmUzVnczbjJzUUtWRG9IRTZtcjRYWXZoZWlYQkhUb0Rw?=
 =?utf-8?B?VFhDMDVBWUg5dzVoVGdGWEhQTVNhakwwMEdOSTRLTU5hcTVDREx3OHNkaTdK?=
 =?utf-8?B?dnVxTjdDYmx6eHcxKzhPS3ViU3EyNnFabEhKbmwwL0h5NDNQQ29DV2p3MVN4?=
 =?utf-8?B?MmNNaWMyTmsxYTRLRDZiUTdZNHoyOHc3a3Zmdk4zNXFVR3RBUWdPNGFyUUNY?=
 =?utf-8?B?ZytMVm5JenVCLzBkYXZvRW5IU25nVVM0Vnl4aXk5eDBzQXd3d0FZK1JkQisy?=
 =?utf-8?B?ZTJZYmpuY1hjdUl3bUlDZmFYTFJSUlNRb1ZIOExVT3FzRkRZT0tjOUxzcEts?=
 =?utf-8?B?aHNlK2tKQXp6a3Mwb0NTSzIyelR1S29HajV5Q09nNERoNjIxWjBoZHZjVWlE?=
 =?utf-8?B?Yytmd1VLVTJ6UDBTQjdtUVZ2dFJsUlZBUllOUE5LV3duZExOblYwVzZZdW5a?=
 =?utf-8?B?UnAvSTJjQ1JrUW9KSWJjRnp5OTRueXJKMEtWTVA2US9tSzdVTmd0V01WK253?=
 =?utf-8?B?TEdZU3ZhMm1VRElmWlUxeFRab1BPUVJKRFluREZpOHRYbldYWEY0SEkrb0Zm?=
 =?utf-8?B?ZWI4WFNMcjAvSnU2N0sxT09ic3g2M2VFQnVHNGg5SWpRUW5TWTBhcXY0Qnoz?=
 =?utf-8?B?UTZjSFpCdUluMi9WS2IxNmhwTE5jam80WmZNelVESG82UFJkNFh6S0QrbGMz?=
 =?utf-8?B?MnpuYUEzUzlVbHhPckJCZEZwckZyNjcxQUlVM2x5RDBRNi9UUGJiV1pqQ2pV?=
 =?utf-8?B?SWIwMGlZU1Y2S0YyZWN0M2lncXZFVWNtSERqd1RtSnduL05XWTZLS0NLeDZL?=
 =?utf-8?B?U1d5aDlHSnRpNnNnZ1BoK1RLMVcwT1NOWlkzdlRlbTh3cmIraUhjYVVXcDQ1?=
 =?utf-8?B?aDZHTWJsNGhlRkVjZmNVenZTZXFlQk5sWldwMFNYYVlXMUJpNVVNYjZxVVpV?=
 =?utf-8?B?SEdtc2dhd2xaNnN4Tlk4dnpaM0JtejMwcVkxemtQZ2MxdkpYT2VYZ0pFMWNi?=
 =?utf-8?B?NThTbDNZdmpJT2FKM1FPT0Q1MzRCNGtIOGFiUlFOTkhpUERCVFhXVzBUSHJj?=
 =?utf-8?B?SmJyVDNCR2UrMzdtdktya0hyRzF4dDdIOEhUR2V0VVh5TndsaHJSMXY0Q1Fm?=
 =?utf-8?B?eTdLejIzSVNTTzcydjlCU2R6VFNGRTRQZTRISVhJUkMyQUI5Mk9pZ05LRTZj?=
 =?utf-8?B?QktENjFtWG44aS80c0d2b2l5aUlFYmp0bW5qOTE2cW1taUdVMUh6LzNyaE82?=
 =?utf-8?B?MHJOLzl5aXVib2VvNlR6dkV3TktTK1F1Vm1sc2RZS0oycmdYVkFYd1lSMVFI?=
 =?utf-8?B?dnlFenN6Q1d4WEFvdytsaEVrS2RQai9Ra1R6SXVvem91NEEvNmdhNUYrUmRp?=
 =?utf-8?B?b3VDWkhYazdmSFAyS3d3TjlTSERhMTNHUWZ4V3JJMSsycUovaFptU25Qck8y?=
 =?utf-8?B?Z0FTZjNSMXZqcmNHNW1RYkpXWm4xUXZYVS9JN1pkVk5lQkRtaVZ5ZXFVL1hM?=
 =?utf-8?B?b0FxY1AvRUFCcDRrVVcxRjhhZllwU2hVd3MrL3A4UFNXS3BkeDgxZmZkZjB5?=
 =?utf-8?B?aVVqMk5aeTJlTVM4TnBNVVpFbXltQWo2cVJkVStlT2xTVVFNbjdCOWVXOTVV?=
 =?utf-8?B?ODQxbVh2L0xrdmdsMnA2UG1SazROTWJsTERuZWdqcFkzd09wOHFmbXVyWFdX?=
 =?utf-8?B?M1pBZHljWm9wL0EwUVlpSG1WOElvUHhKMXIxbzc1R3lnRlQ3M1oxN3EvSWFF?=
 =?utf-8?B?eU15NzFsTFBlaWEwRzFtT1dRY2VoYWcrQXIybE1XRFVBa0h5ZmpXdzhhd0Ry?=
 =?utf-8?B?VmhyZElvWGoxemFkb2N0dk05ME1FUjJHTGx6MlUzdVhoREhHakdSaENhQm1m?=
 =?utf-8?Q?KL1zB+teLtqCtBFCZTzwXOoLe?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1ef87c5-356a-459a-1bd9-08daa0ceecbc
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2022 21:26:22.3522
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JKnrQVCqirwH9IfM7nRcnYxbG9xXAYM3HJPDg6TXdi29fOd0NetefEdxVvV2q8uOkr76iGQsWumf4wOYlel+sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5970
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/27/22 12:53, Chih-En Lin wrote:
> I'm not familiar with THP right now. But we have a plan for looking
> at it to see what will happen with COW PTE.
> Currently, I can only say that I prefer to avoid involving the behavior
> of huge-page/THP. If there are any ideas here please tell us.
> 
In order to be considered at all, this would have to at least behave 
correctly in the presence of THP and hugetlbfs, IMHO. Those are no
longer niche features.


thanks,

-- 
John Hubbard
NVIDIA

