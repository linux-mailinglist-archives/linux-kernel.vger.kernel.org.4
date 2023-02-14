Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6082695808
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 05:55:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbjBNEzk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 23:55:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjBNEzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 23:55:38 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2040.outbound.protection.outlook.com [40.107.243.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B3A2B457
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 20:55:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iaHMQfcU+xGW1QNTdtbqFAFTZvkIRzCNCTbZyQQlE4hKQZdT+f9wEaKDzOimy93/40f3/1k8b8+gsSG7reFwBwiMwCv0L1FlH2OHIiwKC9XB9pau1NfpdvZWoo0MunI/TW61yrC5tsDOF7atbtE8Di00+K3ilznKYXNwnWjZsF4KTZWboz7xJsj5EKsOA0MnW9MKCwZwyn32gaUj63k6XjcmkFMoXl+59vWt99c2gzyplzQcjMAZpFMzOhnEbPIg4YbC59BFSp7R6dbff8pvC6uWmzLeAz2z2cuqC54Lhq+BFyJ7OLt2ksteLkzLBROn0VWiSoO54VUiPtHgM15Dow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r6fYPt1zSrgnBaW+gaxJU/otgbmy180qcEN6wAFPkWI=;
 b=ch7Cd92jAUP7h/uzfbA4butRpL1z49lQLhZUOM7vXuuIyHxM4xqLh3MRYRGS4qcUpptP32t+K+FUdEZ8ihCu6Z/gFIHwVUVrmTEYVYi5Gv1cKO2IhF9KUZTWipF1I9082HVtVHikgmeNCutKJDdeKnPwCvMAGHmSij4NXacUMZyryaNAPMxEIFW5LvSq7KJiXKc7Rn6UzQlzSf+NrEYP/KbWRdlhBnzL8oQxBMtoHMQvllc+NdjR6XD7eXBypmp3PYzK0NnEIKyUcCMQXWwkRPdn9myKHhzxcoyZxRGzWpXbet5B1U3RC3gNCo7CoizTR0oZIJ4bo3R3Phlhw7iFCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r6fYPt1zSrgnBaW+gaxJU/otgbmy180qcEN6wAFPkWI=;
 b=LhZNj2FlfJs3XiwsGMhwiMOImi6/aSqKrRbPvWJvroPSmZXJqYp/2b4RZvll/YrOHmFwBJXe0bImUVMxxnehusX2g3OToyz4QzgQpUizMCMYXsRP+vA95pKwNZqtsjUnlTOd0lZGhCfsHNtXNKr9o0fHfMtbuiWtVvryYmvOGRk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6434.namprd12.prod.outlook.com (2603:10b6:208:3ae::10)
 by BY5PR12MB4968.namprd12.prod.outlook.com (2603:10b6:a03:1d2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Tue, 14 Feb
 2023 04:55:35 +0000
Received: from IA1PR12MB6434.namprd12.prod.outlook.com
 ([fe80::422f:19e8:faa4:eb05]) by IA1PR12MB6434.namprd12.prod.outlook.com
 ([fe80::422f:19e8:faa4:eb05%9]) with mapi id 15.20.6086.024; Tue, 14 Feb 2023
 04:55:34 +0000
Message-ID: <1547d291-1512-faae-aba5-0f84c3502be4@amd.com>
Date:   Tue, 14 Feb 2023 10:25:16 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [RFC PATCH 0/5] Memory access profiler(IBS) driven NUMA balancing
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, mgorman@suse.de,
        peterz@infradead.org, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org,
        akpm@linux-foundation.org, luto@kernel.org, tglx@linutronix.de,
        yue.li@memverge.com, Ravikumar.Bangoria@amd.com
References: <20230208073533.715-1-bharata@amd.com>
 <878rh2b5zt.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <72b6ec8b-f141-3807-d7f2-f853b0f0b76c@amd.com>
 <87zg9i9iw2.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Language: en-US
From:   Bharata B Rao <bharata@amd.com>
In-Reply-To: <87zg9i9iw2.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0167.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26::22) To IA1PR12MB6434.namprd12.prod.outlook.com
 (2603:10b6:208:3ae::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6434:EE_|BY5PR12MB4968:EE_
X-MS-Office365-Filtering-Correlation-Id: 8526d525-95a7-41e3-9310-08db0e47b4f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vtKpf2TFyNerQH9E4bgmF+NXmVhELoLsaGES81DRr6jvxtlW8WbMJe/hJ3FukUnDNlREKvFf/KEb5jWAXV8iFoRMsCqnWWsisOiJqzvx02fliCAtPeWekFUPWZowdh31LpC4lEM34HA4ODIm+OIhuNt2+nkB2DennbrtHJC2LysIZSXJUAVKpy2GdgVny6ADy6/DtSrx2pqe4NxM84mDBAa2qfAA9k95NcJ1bP0rzY1WEP8zA9nwamiaJRaj6YkqQ2Oy6SFJ3DzrKTZBScjgxGQklZG8aTvU1nHTfEtaN6ZLw0joi6TzD1yUxK6i0OCp9hqQRwxRzUTHcb224dsnPt8CX+t4YFM1V2YUjgwtvrNGm5dhS7vO1qYpzOpX9e7QLWk5Y4taPgDN6H/C6O/DRIzEFm9d1MQh/7a2higjUawAgCJmGVjlxHY8xPa10SSkgMmT4JPGrTmdxtYTGrzT0g83MArcqRD0kIw8CCC7SNcNTHP5kXMcy9lfpTL12wJQJs16zirmScKbSkRUDLAjJTUeN1ZCrZnywOtKF23zWGWoGSLjs06eItHgAN+uD4UOvVk5YAhbZaHDIbTaqeTqV8ARsu5Ve6ZIL/tjY2nDcQn+iGgdrDYw9OWOil2FrMjzDelhBxVNnfvXPX9hPvKM4mbZuH8IStM/amF6qvcNLSae2MoxKTG0M7+NnVWqSVY76TMh5zrymzAiFqVbcdp3Z8nti+BAiQgCSLziH97Uu7M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6434.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(346002)(396003)(136003)(376002)(39860400002)(451199018)(2906002)(7416002)(36756003)(5660300002)(6512007)(83380400001)(186003)(26005)(2616005)(38100700002)(6916009)(8676002)(4326008)(66946007)(66476007)(316002)(8936002)(66556008)(6666004)(41300700001)(478600001)(6506007)(53546011)(31696002)(86362001)(6486002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dHBaSHdEYXN2eEVsV0J5M2xTejhKTS91eXlPaTcyM1Z5bXp3QVpvd29ySCt2?=
 =?utf-8?B?L0xlcEpuUWs0Y08xMW04OWlVRXlFNUZhbXZhR1k5T0M1azlaeUY4ekNhSkpB?=
 =?utf-8?B?SVpLcTlqT0JhT0h4REtSYVJCUTVtbEFLRnFFd2VxQUJQckRmV3NSUWxrMTlS?=
 =?utf-8?B?eDQ5QmdzNlF6S3RLblU5ZTFpa054VFZRVVpheFBFeVRsYndGZXB0SUlERXcw?=
 =?utf-8?B?UXhsb1lOV1dydFhrV010Zk05bkVtZmhlczJOV25qRFQ3aDFRZnFSUEsvTG1t?=
 =?utf-8?B?WDU5R0p1bE1WQlEwRUJMWlRMR2h5S3ZVdnIwM3VPMVBRQ2I5Q1UySkdTbnVG?=
 =?utf-8?B?VUtHUWRLakpNMmZLdVJnNlVSRStqZi92eGd6V3FvTk94NG9xUWQvWXFWNlNn?=
 =?utf-8?B?d3FNSTFnVWJqREhLS20yWmQzaktUMGl1TjlVTzFxQURlR3E0ZVFpSm12Nm1H?=
 =?utf-8?B?VHNsYWhPUFNUcXhWNDd2c2N6ckNOYW5GVDRZeVhQb3hyQlFldnduNlBoblFq?=
 =?utf-8?B?VGVvbys4bDFzN0k5TG1Da0syeGFsVGdOYmxGd1hxQkJ0amdWNWNka3BpRXhj?=
 =?utf-8?B?YTYyNDIxUWIrQnhoekV1cVNhQXNsMWZLdEM0dUdCQ1g3MWlGWFJDMWtlWWU3?=
 =?utf-8?B?Um5nRXJaM1piMVAwOXVCaFhqaVRYTTJNdklJV1dqdG1nVEUxNkxaVG1KUTVr?=
 =?utf-8?B?TCtLZWo1eHYxTmJYbitwUUFuSWdVSUtoNktieG5Jem82NCtrTERDNjdOOXEw?=
 =?utf-8?B?ZHhrbUZ6YkxOdmVKLzRTbncreFdsNHRDdlBQL1R0U1AzK1pDanZjTXlWSjZm?=
 =?utf-8?B?aG5rR1dONnNrb3QxTUxUYmJzeXk2VlRGT01rd0FDN2ZXNGFKc3g2MWgvVGM0?=
 =?utf-8?B?N0tXeHdCYWNJUXU4TSs0UDdKdkpoRFkrVlRmMyt6Zlp5YzZsSWF4REhrcWNP?=
 =?utf-8?B?cGkyWnRWaHpROUNoeHFEM1pPaUhoTUgzKzgwTndLR2h4VWJWa2RRZXdkeUpH?=
 =?utf-8?B?ak1KQk5mMjBTSEo0c2IxTkFFK1NZZGJNZTNqbFpkOENweCt5R2pmQjRHWlVq?=
 =?utf-8?B?Qnk0aTBlcWhrQiszaUZMMC80MG9vc3pUUWNCRHBBZDFpNHNtZGtybnA3c3My?=
 =?utf-8?B?a3BtTkpLVTFSRElhTnlrbmwrUlVZVW9zOWJwWlJQTnhSQXlyb1p4Nk9VWnpm?=
 =?utf-8?B?U3hSUzFKTDJ3ZEg2MDVqNnpQaFVGY3lzZFk2c0tuTXQ0SHZsWnhHUnBvRDc2?=
 =?utf-8?B?U0ZCQVBuSVdoekh0eFAvV2owT2pUK3dxL0ZILzdsYXZXVFZjSnJ6VTVZNmFl?=
 =?utf-8?B?WUxpZFA0bEtUQTBIaTlmTThxdDlxSVR4bDFHbERQekpXNGJXZVRqM1ViNXVq?=
 =?utf-8?B?MytnWHhPbldCWkdIbFBqVGN4aFVvMFpvQ3YwemxyOWlWc0NCMlNGczVaMlpa?=
 =?utf-8?B?bVRhTHV3MkFoZldnLzVmdzc5Z1MrV1ROODhJdm1Gc0NUK0hUUkx5N09WVHBU?=
 =?utf-8?B?dk1wU1RrSUFlRmt4M2pNS0Yra0Jtc3BERU1kTmxzcDM0SXR6Z3FnbXZmTmtn?=
 =?utf-8?B?VlU2MWE3UDV2MDVYOFhXcVZaQUUzalBNUXIwNUtVS0dIalh1Vmp5UWozc1dj?=
 =?utf-8?B?aEhHSUJJTFkrN0t5dWx1NVFDNTh4TlZwdFRjSkFMYXQ4clhxY3pUeWEvVlpy?=
 =?utf-8?B?OTNqeHRXTTZyOEdHNkRLWVQzTjh6ZXVYVEZDTGVsSDdWc05YOTQ0dS9RVU9E?=
 =?utf-8?B?Sk04V3RMMEZ2blo0M0xaNWtua0k3OFJmMEZxVnl1YSt1bFNueEl4R0d3STJC?=
 =?utf-8?B?R0lHanZUUmNZSlEzTWZIcUNncGMrVlNnNGdBYnF1cmV5N2VZVUx6eGZCRlJt?=
 =?utf-8?B?cUNFa0xmUUs4T0NmRUtkY2NTUjZsdVk5VytFeEVUN1pTdndxb0ZXWkk4S0dr?=
 =?utf-8?B?bnpjK3dsSEZWMlNaWjBMZ3F6ZHovTnRhK1NmOHRRVmRvQjI0L042NWhOc0xv?=
 =?utf-8?B?R1VkMm94YkRzYkVaSkU2aVplOUZjREczcDRnbDdJaS9jYWNJdEdvQThacVAy?=
 =?utf-8?B?b1E3WSt5TGR1aDFXaStXN0R2dW42N243VzEzRFh2aU9oc3hHNlcwdlpOMWtD?=
 =?utf-8?Q?GlIzptxmVk9hyEx325E3H0zK3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8526d525-95a7-41e3-9310-08db0e47b4f2
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6434.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2023 04:55:34.7600
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ljyJGnZ3Oh+QgUYsbHXPhsrPvhgWL4vo1wDjuNEFgyfzd5+KA9KC1cdM7ZOH0o8nh2al3MHeXfDONjGXOiCS4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4968
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13-Feb-23 12:00 PM, Huang, Ying wrote:
>> I have a microbenchmark where two sets of threads bound to two 
>> NUMA nodes access the two different halves of memory which is
>> initially allocated on the 1st node.
>>
>> On a two node Zen4 system, with 64 threads in each set accessing
>> 8G of memory each from the initial allocation of 16G, I see that
>> IBS driven NUMA balancing (i,e., this patchset) takes 50% less time
>> to complete a fixed number of memory accesses. This could well
>> be the best case and real workloads/benchmarks may not get this much
>> uplift, but it does show the potential gain to be had.
> 
> Can you find a way to show the overhead of the original implementation
> and your method?  Then we can compare between them?  Because you think
> the improvement comes from the reduced overhead.

Sure, will measure the overhead.

> 
> I also have interest in the pages migration throughput per second during
> the test, because I suspect your method can migrate pages faster.

I have some data on pages migrated over time for the benchmark I mentioned
above.

                                                                                
                                Pages migrated vs Time(s)                       
    2500000 +---------------------------------------------------------------+   
            |       +       +       +       +       +       +       +       |   
            |                                               Default ******* |   
            |                                                   IBS ####### |   
            |                                                               |   
            |                                   ****************************|   
            |                                  *                            |   
    2000000 |-+                               *                           +-|   
            |                                *                              |   
            |                              **                               |   
 P          |                             *  ##                             |   
 a          |                            *###                               |   
 g          |                          **#                                  |   
 e  1500000 |-+                       *##                                 +-|   
 s          |                        ##                                     |   
            |                       #                                       |   
 m          |                      #                                        |   
 i          |                    *#                                         |   
 g          |                   *#                                          |   
 r          |                  ##                                           |   
 a  1000000 |-+               #                                           +-|   
 t          |                #                                              |   
 e          |               #*                                              |   
 d          |              #*                                               |   
            |             # *                                               |   
            |            # *                                                |   
     500000 |-+         #  *                                              +-|   
            |          #  *                                                 |   
            |         #   *                                                 |   
            |        #   *                                                  |   
            |      ##    *                                                  |   
            |     #     *                                                   |   
            |    #  +  *    +       +       +       +       +       +       |   
          0 +---------------------------------------------------------------+   
            0       20      40      60      80     100     120     140     160  
                                        Time (s)                                

So acting upon the relevant accesses early enough seem to result in
pages migrating faster in the beginning.

Here is the actual data in case the above ascii graph gets jumbled up:

numa_pages_migrated vs time in seconds
======================================

Time	Default		IBS
---------------------------
5	2639		511
10	2639		17724
15	2699		134632
20	2699		253485
25	2699		386296
30	159805		524651
35	450678		667622
40	741762		811603
45	971848		950691
50	1108475		1084537
55	1246229		1215265
60	1385920		1336521
65	1508354		1446950
70	1624068		1544890
75	1739311		1629162
80	1854639		1700068
85	1979906		1759025
90	2099857		<end>
95	2099857
100	2099857
105	2099859
110	2099859
115	2099859
120	2099859
125	2099859
130	2099859
135	2099859
140	2099859
145	2099859
150	2099859
155	2099859
160	2099859

Regards,
Bharata.
