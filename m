Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E23C6633B76
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 12:34:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbiKVLez (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 06:34:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232509AbiKVLeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 06:34:18 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2066.outbound.protection.outlook.com [40.107.237.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E501713F2C
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 03:28:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FSPLW32N6Xlqil0UvyOUHIaCXK1YGzjEGyZpq09kzvbSrwe/io5J+PEwPw/RAfcEx83pE5ju97AqsNJNekc//4zI7xr02stPZDzHqHoO7dnBS1QAUVGgIAW3xQ6vJ2sKT0mdHN3T1Dk3bdlr+ct2/k9A3p4yUhQZm2eQDDXrtJ0aXs/2rr8HUU185beH5WVWQ69OEHAZ5oEWXLPvgzNqnYk50MTTehELJ6HH/nnMZ04dVrXrzsX7snY23VLxLowd9ieAgBsrbMw7OhF7n9sWuwG58sYepf4jPD82i46SnPY1FlXk6mmYmWFNy8cRCWPyFKMm4wWmd0GTLK2wnI/CLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2mGOT++ALgUZ7rfo369yT6cKO/iTwL1QYOOUsNvjKMg=;
 b=Fw3Q4CRuc5rai2PA31cVJBN4fHViTN6T5phAfcRjPGbJzwHVhbnhyWzPDkWDVjh6gwqo3fdKNe/nBd+flZAvcFF8hJqb4ut+BtJ0AftXv8jjVRuVD4gCVZdARTSaTrk14in+rtDuuOU4hSc72Qf9tWbsxCMBiFEoAlub+Gg5fZGHzycUN9zaUBGolTEES5py7xdpY9gSPT0xny0ILCzKOaIDnfTYxUQYrf0ko8FRzhsRZ4Qxh12FDiRfjxFqmudxlJ+nV5gELLh6NM5+vTupy+A6okRRSQtXUTPmzjSeW7NfO2Qbvcjjojzym/RsJzw7ugrbEWthp0uXvUvNFy2Vrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2mGOT++ALgUZ7rfo369yT6cKO/iTwL1QYOOUsNvjKMg=;
 b=1c2v3dF+VdkingMoGTnr7EUiFqbzgOdsM7O7uIOhm1xZOWq9hRR9Xk+Ol0Jt6iJ+aG0HOSDKjds+yOpCylKPUH7k2Zz60+y7zRkpyzy4UbUDVA6aEcjv/kmshV5uEuX1MPzxf3nxYQLv2y7OGD7M6Bcyh5lXmvGHSnqBLSt8WYE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24)
 by DM6PR12MB4297.namprd12.prod.outlook.com (2603:10b6:5:211::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Tue, 22 Nov
 2022 11:28:31 +0000
Received: from MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::d9a6:6f94:8e92:9e20]) by MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::d9a6:6f94:8e92:9e20%7]) with mapi id 15.20.5834.015; Tue, 22 Nov 2022
 11:28:31 +0000
Message-ID: <b8eb593a-cde9-bb23-2092-6b563ce814c8@amd.com>
Date:   Tue, 22 Nov 2022 16:58:17 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v6 0/4] sched/fair: Improve scan efficiency of SIS
Content-Language: en-US
From:   K Prateek Nayak <kprateek.nayak@amd.com>
To:     Abel Wu <wuyun.abel@bytedance.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Mel Gorman <mgorman@suse.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>
Cc:     Josh Don <joshdon@google.com>, Chen Yu <yu.c.chen@intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Aubrey Li <aubrey.li@intel.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Yicong Yang <yangyicong@huawei.com>,
        Barry Song <21cnbao@gmail.com>, linux-kernel@vger.kernel.org
References: <20221019122859.18399-1-wuyun.abel@bytedance.com>
 <c7c5a654-8d26-28d9-7b33-e7b2b7bf2401@amd.com>
 <2a049755-57cb-4943-0850-cbbf2537c97e@bytedance.com>
 <906747ff-148c-f058-dc94-7a9225125f52@amd.com>
In-Reply-To: <906747ff-148c-f058-dc94-7a9225125f52@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0031.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::20) To MW2PR12MB2379.namprd12.prod.outlook.com
 (2603:10b6:907:9::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PR12MB2379:EE_|DM6PR12MB4297:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ef67521-2f41-41b1-81b9-08dacc7caeea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KD1csC+ourc2V8TvJtLygW6tNKPXbxSoXZ+JA/8mYX7cUSY+wOvAOpbGjeQ16nwBomds45uwfEivvO8fBBjxax/Ey+/wVPIE/ZbDgFgdQKoEvVreJNYweiylDA9XLD6qVpjbmhPTxgU2k3MPQsp7KT3Ow6dhYSZX932bCzdL/hfG/YQ1eGZOu16NPvKPQiuYuWp8Vory80pb+xAxBsYLVMTJt4lv7etIZkh0tmqajeoyviEjK4HQrvjzFiTZQySolFrDiqszu3HWS/9W3yzh54pyLOcyy/JhHVcm25aviYTXvqKvzs4JQzIK5fSO4Bgg+Bx/l0+g5VNJo3ApExi0IyswJa1tuA8OS4C8msGq9KNZptLVEQguN4aRvWjYHizgJx9eYF/JU7Emf73ynEmcwdtjLNFi6LtA316hlJNffKfgQD5B4p8jfP1LOZZWsK316YD+mL12x0DNWil5Y5rnBOLduKCB8dQlFyl+Jo0YKf4FceBDbmFbuHJSn2MIqa3030Axx3mYqzv1833IleZ5bI+SgKeV9skEkcLXrxDh4svOEUM/2dbh+o+qAvdgWUYmk87uUwVZK+uv2GW+844x41X96oVP7l5ViDnMtyHBCbkjENzqusgH52WblyFUVRB1BW8x1pD9ewwS6vsNvU88w4Ita5nU4FIRQEy9FZhzCAnvTonQ0BAuLs2991V7n5ZIVYmX2ATznY0+3EjaHE4FnZUrnRqrKGh9ETtdI0WgQME=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2379.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(376002)(396003)(346002)(39860400002)(136003)(451199015)(6486002)(26005)(2906002)(110136005)(6666004)(6506007)(31696002)(86362001)(36756003)(83380400001)(478600001)(38100700002)(53546011)(6512007)(2616005)(186003)(30864003)(7416002)(8936002)(41300700001)(31686004)(66476007)(66556008)(4326008)(8676002)(66899015)(66946007)(5660300002)(316002)(54906003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bFlVTFpWWUpKSWFaTkl1RzRJVGttVElWWUk4SmNUd0ZFd0pMUnFnQzJkSnpC?=
 =?utf-8?B?N3hvYnVGSWFSWTVZaVQ3Z2pqMWp6THlKL3h5bXFUaDZkK1NxNXYzZEJWaVd5?=
 =?utf-8?B?dFVKdHBrNXVSbjhzbDJvMTdyc2xQV2l0dGVmWDdybjRUL2dKUHVKcE93QVhh?=
 =?utf-8?B?Q2hOZFJtQlF4VGZVZEN2cVNCYnhFWXFGUVJjOVRVL0Fmb1lJa0pHOTVhQ1ZW?=
 =?utf-8?B?VE5IbUdSRkVPMFljb0VnTy92MmZ3TEpYR3ZUclU3clcyUHdTLzFwRjluN1Rk?=
 =?utf-8?B?SzNXUURjcHA1dWlnWWJZTXZlWUNCK2JKWkEvQ0NzdVpYNkVhNGZKOTFrc0ZE?=
 =?utf-8?B?ZWJPZFphTFg2eGNoeUtnelpZNklQRkh2RjQ1N0xwcm5ER0U2bWJqK1pnY3Br?=
 =?utf-8?B?aHc3L253Sllmc2FkYkZ3WHBCdlFoMHBkRTFoeUJNQjhCR3Z3d2QrT1R1ck5i?=
 =?utf-8?B?MzN5OEpzTjg0SElnblVFVlVHcUUraU15bitTcTNnSHYxSTU2SFp6V09zQWZn?=
 =?utf-8?B?NmlsTWRvWDZka2lkekhHUFo2V0VWYlJ2bGlzdFVLTlR2SWp6VnEwWXBxcUVx?=
 =?utf-8?B?ZTd6VGh3S2Q4TWxyZlZub1VId0c4Si9wK0lkRnk2SFp5cWJmYXcvV3F0U28y?=
 =?utf-8?B?VHdkU1N2S3AxNEV2b1hXdFRSZkhRVlEvKzBjTjJvNkpuS045KzZ0elF5WGlh?=
 =?utf-8?B?cXR2Z1laT1FRQXIxa0w4dEM3NGpGZjFrWGtkazhENHRQTlhjd0ZWQm9OTGt5?=
 =?utf-8?B?NlBrYWVhS0ltcGVvaml6anlhMHl1VWdDWS9EV2VPbEtaS3lpRnNzSkZDNkFB?=
 =?utf-8?B?bk1zMHpncE5qZ1pZOFlFWDFvN3lDVHNSOCtiMitBWjlnd2FZcEszSEJxTXR0?=
 =?utf-8?B?bEZWdWd6eWlXdngwMGJvaURua0NMSmw3VlFsM1RVNkQ2QVRtUUYxYnd6MWhC?=
 =?utf-8?B?YlJUakx6YTQzMGJEQzBldDd4V2NvVlhtQ2RkaEk0bHoycldLcGprUXQzdXQ3?=
 =?utf-8?B?TElCNnQ0QVVlbVJJYmlCWnA2UGc0NXBTbmRpQ3RPSnkxUUt3dmtKdDF2c2dN?=
 =?utf-8?B?RHBtWG05SkRmK1ZvY1JoSzY3eURqb3dWTjFmNm1sb2FSQ1RqcFNqbkZiVjJi?=
 =?utf-8?B?L2pLSjlEcXV0dVhOT24vSldkZXY5VDQ2QzlhNlZmZzV2U2NrWWZCV2E1MEdH?=
 =?utf-8?B?cTMycjNJb1ljWmlacXVWNy90QTZ3SDdEcitzSWxNUkZzVHQwd1hTZThGNkNF?=
 =?utf-8?B?Q0FMb21VUVVRM0ZFNGd3QVVua1NlNmRMelhpV0tLQmsrOTNvaXd6LytiNUVP?=
 =?utf-8?B?YXBMdVluTWttU0dMeU9jallGNVc3VC9EU0RobjBLc3RyMFJXY1d0L3NBZ0g0?=
 =?utf-8?B?TDljWTRxY1BnSXF3alViZ3o4Ymx4VkpxM0RjSE9zd0VHRm94VlNjSm1Wb2xi?=
 =?utf-8?B?Rndkb3FTRnc3RzkvYi9jZDJXWUlXMnE3MU9JMk9KSGx1U2tEZTlNd20wcmoz?=
 =?utf-8?B?RE9jZkxDUnEwZTY2bjNaelRxdndLbUlCQzU1T3N5OUdUVDhYZzRUeFp5QzI5?=
 =?utf-8?B?NDd3bHRmbFR6alZZK0lVbldxTlJlWE5TempibmpKZUk5Rm1VNC9seWdnaHlM?=
 =?utf-8?B?STRSZjJQSHJ5a2xXbzcrOGlXdXptUFhBM0NvRVB0Uy92aXJyV2FCeFlQbHV0?=
 =?utf-8?B?YnpwUnRzKzdWaVFLeUpqbzY4VGNHYTNoK0ZCU1BKQWdnZHhTSEoxQzNPenFS?=
 =?utf-8?B?bExTR1ZXcGFUK1h1VDBvRUtqRVIxZGkvOUI5Y2lTbEVySkh2ZEdoenY4eVNR?=
 =?utf-8?B?Qk9YR05hZDNGRnFLeElqYThJeVVGMFlHRStxbkdXb1FVeXRWNnZLOHBJY2Mv?=
 =?utf-8?B?WVZOTUJLdmVWaXhEM1dEWDJwTlhYcXVlRnVabVduLzBNM2NiUFBIam1tZjUv?=
 =?utf-8?B?YWRENjc1dHB3YmdUaDc3UkVqc0psQk5CSy8zVHNzK0hTSDBCRGt2UFozQ3dM?=
 =?utf-8?B?bm53emRYdUl3N1dQN09uRlVWb2RWVGdxV3RROG5jYnRvSE9BQzVma1lnM08x?=
 =?utf-8?B?OXErSTJQdU9NdnFpd0hTeUpvdmRUb1lrRUFjZ3RGTkV5cnIzdjFOY3RFNjhG?=
 =?utf-8?Q?BTzl57EsognhP6NV6Olo2dG4k?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ef67521-2f41-41b1-81b9-08dacc7caeea
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2022 11:28:31.2867
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P/VFRgfnuXNdI6tUhrpSr02adiPYKu0NebgBowQsfU9kzTEcq09Uczy0bH7JUz0eSNcIbgyluDO0T8E4jPacww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4297
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Abel,

Following are the results for hackbench with larger number of
groups, ycsb-mongodb, Spec-JBB, and unixbench. Apart for
a regression in unixbench spawn in NPS2 and NPS4 mode and
unixbench syscall in NPs2 mode, everything looks good.

Detailed results are below:

~~~~~~~~~~~~~~~~
~ ycsb-mongodb ~
~~~~~~~~~~~~~~~~

o NPS1:

tip:            131696.33 (var: 2.03%)
sis_core:       129519.00 (var: 1.46%)  (-1.65%)

o NPS2:

tip:            129895.33 (var: 2.34%)
sis_core:       130774.33 (var: 2.57%)  (+0.67%)

o NPS4:

tip:            131165.00 (var: 1.06%)
sis_core:       133547.33 (var: 3.90%)  (+1.81%)

~~~~~~~~~~~~~~~~~
~ Spec-JBB NPS1 ~
~~~~~~~~~~~~~~~~~

Max-jOPS and Critical-jOPS are same as the tip kernel.

~~~~~~~~~~~~~
~ unixbench ~
~~~~~~~~~~~~~

-> unixbench-dhry2reg

o NPS1

kernel:                                        tip                          sis_core
Min       unixbench-dhry2reg-1            48876615.50 (   0.00%)         48891544.00 (   0.03%)
Min       unixbench-dhry2reg-512        6260344658.90 (   0.00%)       6282967594.10 (   0.36%)
Hmean     unixbench-dhry2reg-1            49299721.81 (   0.00%)         49233828.70 (  -0.13%)
Hmean     unixbench-dhry2reg-512        6267459427.19 (   0.00%)       6288772961.79 *   0.34%*
CoeffVar  unixbench-dhry2reg-1                   0.90 (   0.00%)                0.68 (  24.66%)
CoeffVar  unixbench-dhry2reg-512                 0.10 (   0.00%)                0.10 (   7.54%)

o NPS2

kernel:                                        tip                          sis_core
Min       unixbench-dhry2reg-1            48828251.70 (   0.00%)         48856709.20 (   0.06%)
Min       unixbench-dhry2reg-512        6244987739.10 (   0.00%)       6271229549.10 (   0.42%)
Hmean     unixbench-dhry2reg-1            48869882.65 (   0.00%)         49302481.81 (   0.89%)
Hmean     unixbench-dhry2reg-512        6261073948.84 (   0.00%)       6272564898.35 (   0.18%)
CoeffVar  unixbench-dhry2reg-1                   0.08 (   0.00%)                0.87 (-945.28%)
CoeffVar  unixbench-dhry2reg-512                 0.23 (   0.00%)                0.03 (  85.94%)

o NPS4

kernel:                                        tip                          sis_core
Min       unixbench-dhry2reg-1            48523981.30 (   0.00%)         49083957.50 (   1.15%)
Min       unixbench-dhry2reg-512        6253738837.10 (   0.00%)       6271747119.10 (   0.29%)
Hmean     unixbench-dhry2reg-1            48781044.09 (   0.00%)         49232218.87 *   0.92%*
Hmean     unixbench-dhry2reg-512        6264428474.90 (   0.00%)       6280484789.64 (   0.26%)
CoeffVar  unixbench-dhry2reg-1                   0.46 (   0.00%)                0.26 (  42.63%)
CoeffVar  unixbench-dhry2reg-512                 0.17 (   0.00%)                0.21 ( -26.72%)

-> unixbench-syscall

o NPS1

kernel:                             tip                  sis_core
Min       unixbench-syscall-1    2975654.80 (   0.00%)  2978489.40 (  -0.10%)
Min       unixbench-syscall-512  7840226.50 (   0.00%)  7822133.40 (   0.23%)
Amean     unixbench-syscall-1    2976326.47 (   0.00%)  2980985.27 *  -0.16%*
Amean     unixbench-syscall-512  7850493.90 (   0.00%)  7844527.50 (   0.08%)
CoeffVar  unixbench-syscall-1          0.03 (   0.00%)        0.07 (-154.43%)
CoeffVar  unixbench-syscall-512        0.13 (   0.00%)        0.34 (-158.96%)

o NPS2

kernel:                             tip                  sis_core
Min       unixbench-syscall-1    2969863.60 (   0.00%)  2977936.50 (  -0.27%)
Min       unixbench-syscall-512  8053157.60 (   0.00%)  8072239.00 (  -0.24%)
Amean     unixbench-syscall-1    2970462.30 (   0.00%)  2981732.50 *  -0.38%*
Amean     unixbench-syscall-512  8061454.50 (   0.00%)  8079287.73 *  -0.22%*
CoeffVar  unixbench-syscall-1          0.02 (   0.00%)        0.11 (-527.26%)
CoeffVar  unixbench-syscall-512        0.12 (   0.00%)        0.08 (  37.30%)

o NPS4

kernel:                             tip                  sis_core
Min       unixbench-syscall-1    2971799.80 (   0.00%)  2979335.60 (  -0.25%)
Min       unixbench-syscall-512  7824196.90 (   0.00%)  8155610.20 (  -4.24%)
Amean     unixbench-syscall-1    2973045.43 (   0.00%)  2982036.13 *  -0.30%*
Amean     unixbench-syscall-512  7826302.17 (   0.00%)  8173026.57 *  -4.43%*   <-- Regression in syscall for larger worker count
CoeffVar  unixbench-syscall-1          0.04 (   0.00%)        0.09 (-139.63%)
CoeffVar  unixbench-syscall-512        0.03 (   0.00%)        0.20 (-701.13%)


-> unixbench-pipe

o NPS1

kernel:                               tip                  sis_core
Min       unixbench-pipe-1        2894765.30 (   0.00%)   2891505.30 (  -0.11%)
Min       unixbench-pipe-512    329818573.50 (   0.00%) 325610257.80 (  -1.28%)
Hmean     unixbench-pipe-1        2898803.38 (   0.00%)   2896940.25 (  -0.06%)
Hmean     unixbench-pipe-512    330226401.69 (   0.00%) 326311984.29 *  -1.19%*
CoeffVar  unixbench-pipe-1              0.14 (   0.00%)         0.17 ( -21.99%)
CoeffVar  unixbench-pipe-512            0.11 (   0.00%)         0.20 ( -88.38%)

o NPS2

kernel:                               tip                   sis_core
Min       unixbench-pipe-1        2895327.90 (   0.00%)    2894798.20 (  -0.02%)
Min       unixbench-pipe-512    328350065.60 (   0.00%)  325681163.10 (  -0.81%)
Hmean     unixbench-pipe-1        2899129.86 (   0.00%)    2897067.80 (  -0.07%)
Hmean     unixbench-pipe-512    329436096.80 (   0.00%)  326023030.94 *  -1.04%*
CoeffVar  unixbench-pipe-1              0.12 (   0.00%)          0.09 (  21.96%)
CoeffVar  unixbench-pipe-512            0.30 (   0.00%)          0.12 (  60.80%)

o NPS4

kernel:                               tip                   sis_core
Min       unixbench-pipe-1        2901525.60 (   0.00%)    2885730.80 (  -0.54%)
Min       unixbench-pipe-512    330265873.90 (   0.00%)  326730770.60 (  -1.07%)
Hmean     unixbench-pipe-1        2906184.70 (   0.00%)    2891616.18 *  -0.50%*
Hmean     unixbench-pipe-512    330854683.27 (   0.00%)  327113296.63 *  -1.13%*
CoeffVar  unixbench-pipe-1              0.14 (   0.00%)          0.19 ( -33.74%)
CoeffVar  unixbench-pipe-512            0.16 (   0.00%)          0.11 (  31.75%)

-> unixbench-spawn

o NPS1

kernel:                             tip                  sis_core
Min       unixbench-spawn-1       6536.50 (   0.00%)     6000.30 (  -8.20%)
Min       unixbench-spawn-512    72571.40 (   0.00%)    70829.60 (  -2.40%)
Hmean     unixbench-spawn-1       6811.16 (   0.00%)     7016.11 (   3.01%)
Hmean     unixbench-spawn-512    72801.77 (   0.00%)    71012.03 *  -2.46%*
CoeffVar  unixbench-spawn-1          3.69 (   0.00%)       13.52 (-266.69%)
CoeffVar  unixbench-spawn-512        0.27 (   0.00%)        0.22 (  18.25%)

o NPS2

kernel:                             tip                  sis_core
Min       unixbench-spawn-1       7042.20 (   0.00%)     7078.70 (   0.52%)
Min       unixbench-spawn-512    85571.60 (   0.00%)    77362.60 (  -9.59%)
Hmean     unixbench-spawn-1       7199.01 (   0.00%)     7276.55 (   1.08%)
Hmean     unixbench-spawn-512    85717.77 (   0.00%)    77923.73 *  -9.09%*     <-- Regression in spawn test for larger worker count
CoeffVar  unixbench-spawn-1          3.50 (   0.00%)        3.30 (   5.70%)
CoeffVar  unixbench-spawn-512        0.20 (   0.00%)        0.82 (-304.88%)

o NPS4

kernel:                             tip                  sis_core
Min       unixbench-spawn-1       7521.90 (   0.00%)     8102.80 (   7.72%)
Min       unixbench-spawn-512    84245.70 (   0.00%)    73074.50 ( -13.26%)
Hmean     unixbench-spawn-1       7659.12 (   0.00%)     8645.19 *  12.87%*
Hmean     unixbench-spawn-512    84908.77 (   0.00%)    73409.49 * -13.54%*     <-- Regression in spawn test for larger worker count
CoeffVar  unixbench-spawn-1          1.92 (   0.00%)        5.78 (-200.56%)
CoeffVar  unixbench-spawn-512        0.76 (   0.00%)        0.41 (  46.58%)

-> unixbench-execl

o NPS1

kernel:                             tip                  sis_core
Min       unixbench-execl-1       5421.50 (   0.00%)     5471.50 (   0.92%)
Min       unixbench-execl-512    11213.50 (   0.00%)    11677.20 (   4.14%)
Hmean     unixbench-execl-1       5443.75 (   0.00%)     5475.36 *   0.58%*
Hmean     unixbench-execl-512    11311.94 (   0.00%)    11804.52 *   4.35%*
CoeffVar  unixbench-execl-1          0.38 (   0.00%)        0.12 (  69.22%)
CoeffVar  unixbench-execl-512        1.03 (   0.00%)        1.73 ( -68.91%)

o NPS2

kernel:                             tip                  sis_core
Min       unixbench-execl-1       5089.10 (   0.00%)     5405.40 (   6.22%)
Min       unixbench-execl-512    11772.70 (   0.00%)    11917.20 (   1.23%)
Hmean     unixbench-execl-1       5321.65 (   0.00%)     5421.41 (   1.87%)
Hmean     unixbench-execl-512    12201.73 (   0.00%)    12327.95 (   1.03%)
CoeffVar  unixbench-execl-1          3.87 (   0.00%)        0.28 (  92.88%)
CoeffVar  unixbench-execl-512        6.23 (   0.00%)        5.78 (   7.21%)

o NPS4

kernel:                             tip                  sis_core
Min       unixbench-execl-1       5099.40 (   0.00%)     5479.60 (   7.46%)
Min       unixbench-execl-512    11692.80 (   0.00%)    12205.50 (   4.38%)
Hmean     unixbench-execl-1       5136.86 (   0.00%)     5487.93 *   6.83%*
Hmean     unixbench-execl-512    12053.71 (   0.00%)    12712.96 (   5.47%)
CoeffVar  unixbench-execl-1          1.05 (   0.00%)        0.14 (  86.57%)
CoeffVar  unixbench-execl-512        3.85 (   0.00%)        5.86 ( -52.14%)

For unixbench regressions, I do not see anything obvious jump up
in perf traces captureed with IBS. top shows over 99% utilization
which would ideally mean there are not many updates to the mask.
I'll take some more look at the spawn test case and get back to you.

On 11/15/2022 4:58 PM, K Prateek Nayak wrote:
> Hello Abel,
> 
> Thank you for taking a look at the report.
> 
> On 11/15/2022 2:01 PM, Abel Wu wrote:
>> Hi Prateek, thanks very much for your detailed testing!
>>
>> On 11/14/22 1:45 PM, K Prateek Nayak wrote:
>>> Hello Abel,
>>>
>>> Sorry for the delay. I've tested the patch on a dual socket Zen3 system
>>> (2 x 64C/128T)
>>>
>>> tl;dr
>>>
>>> o I do not notice any regressions with the standard benchmarks.
>>> o schbench sees a nice improvement to the tail latency when the number
>>>    of worker are equal to the number of cores in the system in NPS1 and
>>>    NPS2 mode. (Marked with "^")
>>> o Few data points show improvements in tbench in NPS1 and NPS2 mode.
>>>    (Marked with "^")
>>>
>>> I'm still in the process of running larger workloads. If there is any
>>> specific workload you would like me to run on the test system, please
>>> do let me know. Below is the detailed report:
>>
>> Not particularly in my mind, and I think testing larger workloads is
>> great. Thanks!
>>
>>>
>>> Following are the results from running standard benchmarks on a
>>> dual socket Zen3 (2 x 64C/128T) machine configured in different
>>> NPS modes.
>>>
>>> NPS Modes are used to logically divide single socket into
>>> multiple NUMA region.
>>> Following is the NUMA configuration for each NPS mode on the system:
>>>
>>> NPS1: Each socket is a NUMA node.
>>>      Total 2 NUMA nodes in the dual socket machine.
>>>
>>>      Node 0: 0-63,   128-191
>>>      Node 1: 64-127, 192-255
>>>
>>> NPS2: Each socket is further logically divided into 2 NUMA regions.
>>>      Total 4 NUMA nodes exist over 2 socket.
>>>          Node 0: 0-31,   128-159
>>>      Node 1: 32-63,  160-191
>>>      Node 2: 64-95,  192-223
>>>      Node 3: 96-127, 223-255
>>>
>>> NPS4: Each socket is logically divided into 4 NUMA regions.
>>>      Total 8 NUMA nodes exist over 2 socket.
>>>          Node 0: 0-15,    128-143
>>>      Node 1: 16-31,   144-159
>>>      Node 2: 32-47,   160-175
>>>      Node 3: 48-63,   176-191
>>>      Node 4: 64-79,   192-207
>>>      Node 5: 80-95,   208-223
>>>      Node 6: 96-111,  223-231
>>>      Node 7: 112-127, 232-255
>>>
>>> Benchmark Results:
>>>
>>> Kernel versions:
>>> - tip:          5.19.0 tip sched/core
>>> - sis_core:     5.19.0 tip sched/core + this series
>>>
>>> When we started testing, the tip was at:
>>> commit fdf756f71271 ("sched: Fix more TASK_state comparisons")
>>>
>>> ~~~~~~~~~~~~~
>>> ~ hackbench ~
>>> ~~~~~~~~~~~~~
>>>
>>> o NPS1
>>>
>>> Test:            tip            sis_core
>>>   1-groups:       4.06 (0.00 pct)       4.26 (-4.92 pct)    *
>>>   1-groups:       4.14 (0.00 pct)       4.09 (1.20 pct)    [Verification Run]
>>>   2-groups:       4.76 (0.00 pct)       4.71 (1.05 pct)
>>>   4-groups:       5.22 (0.00 pct)       5.11 (2.10 pct)
>>>   8-groups:       5.35 (0.00 pct)       5.31 (0.74 pct)
>>> 16-groups:       7.21 (0.00 pct)       6.80 (5.68 pct)
>>>
>>> o NPS2
>>>
>>> Test:            tip            sis_core
>>>   1-groups:       4.09 (0.00 pct)       4.08 (0.24 pct)
>>>   2-groups:       4.70 (0.00 pct)       4.69 (0.21 pct)
>>>   4-groups:       5.05 (0.00 pct)       4.92 (2.57 pct)
>>>   8-groups:       5.35 (0.00 pct)       5.26 (1.68 pct)
>>> 16-groups:       6.37 (0.00 pct)       6.34 (0.47 pct)
>>>
>>> o NPS4
>>>
>>> Test:            tip            sis_core
>>>   1-groups:       4.07 (0.00 pct)       3.99 (1.96 pct)
>>>   2-groups:       4.65 (0.00 pct)       4.59 (1.29 pct)
>>>   4-groups:       5.13 (0.00 pct)       5.00 (2.53 pct)
>>>   8-groups:       5.47 (0.00 pct)       5.43 (0.73 pct)
>>> 16-groups:       6.82 (0.00 pct)       6.56 (3.81 pct)
>>
>> Although each cpu will get 2.5 tasks when 16-groups, which can
>> be considered overloaded, I tested in AMD EPYC 7Y83 machine and
>> the total cpu usage was ~82% (with some older kernel version),
>> so there is still lots of idle time.
>>
>> I guess cutting off at 16-groups is because it's enough loaded
>> compared to the real workloads, so testing more groups might just
>> be a waste of time?
> 
> The machine has 16 LLCs so I capped the results at 16-groups.
> Previously I had seen some run-to-run variance with larger group counts
> so I limited the reports to 16-groups. I'll run hackbench with more
> number of groups (32, 64, 128, 256) and get back to you with the
> results along with results for a couple of long running workloads. 

~~~~~~~~~~~~~
~ Hackbench ~
~~~~~~~~~~~~~

$ perf bench sched messaging -p -l 50000 -g <groups>

o NPS1

kernel:               tip                     sis_core
32-groups:         6.20 (0.00 pct)         5.86 (5.48 pct)
64-groups:        16.55 (0.00 pct)        15.21 (8.09 pct)
128-groups:       42.57 (0.00 pct)        34.63 (18.65 pct)
256-groups:       71.69 (0.00 pct)        67.11 (6.38 pct)
512-groups:      108.48 (0.00 pct)       110.23 (-1.61 pct)

o NPS2

kernel:                tip                     sis_core
32-groups:         6.56 (0.00 pct)         5.60 (14.63 pct)
64-groups:        15.74 (0.00 pct)        14.45 (8.19 pct)
128-groups:       39.93 (0.00 pct)        35.33 (11.52 pct)
256-groups:       74.49 (0.00 pct)        69.65 (6.49 pct)
512-groups:      112.22 (0.00 pct)       113.75 (-1.36 pct)

o NPS4:

kernel:               tip                     sis_core
32-groups:         9.48 (0.00 pct)         5.64 (40.50 pct)
64-groups:        15.38 (0.00 pct)        14.13 (8.12 pct)
128-groups:       39.93 (0.00 pct)        34.47 (13.67 pct)
256-groups:       75.31 (0.00 pct)        67.98 (9.73 pct)
512-groups:      115.37 (0.00 pct)       111.15 (3.65 pct)

Note: Hackbench with 32-groups show run to run variation
on tip but is more stable with sis_core. Hackbench for
64-groups and beyond is stable on both kernels.

> 
>>
>> Thanks & Best Regards,
>>     Abel
>>
>> [..snip..]
>>
> 
> 
> --
> Thanks and Regards,
> Prateek

Apart from the couple of regressions in Unixbench, everything looks good.
If you would like me to get any more data for any workload on the test
system, please do let me know.
--
Thanks and Regards,
Prateek
