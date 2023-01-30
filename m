Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82DA4680AF6
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 11:35:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236412AbjA3KfT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 05:35:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236338AbjA3KfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 05:35:16 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2067.outbound.protection.outlook.com [40.107.93.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB6675279;
        Mon, 30 Jan 2023 02:35:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AiMff9enSF+EpPDqBeRwIy//jn0isW/DldpE5QCoC1GLUO2Dr95IMh7QkvszR4DPXi2rscnghP71TfRfKksS1ELhCDVq5FuYnEGN2cammOuPDiXxewWeEmI3yrR4wT3AqT/fTbzOavrQs9C7VUHVkO63jpMyCJxpp24V4M75Jsx32oMNpHOCkcmSgO8gc/zPA8wLnMh7ABveggq1JaXe/AHg5hSi9jQztURC1RcDiI1jBsnXx3B9mY0juQh0gtT+EAOVpzR5ja77eYg00OhatrdhV+1zFtEBY12iHxY2Hd4NWo9p43w7JWcKdReiCbvpGpzHTHPcUjtNCkeHBlmQtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jHA4oOJc/kK+Q8zXYnkafNCUrlsob5GpLZXCCH3bcq0=;
 b=fCUVkkQmzGg0WXFmGpx2a6PfX47QK3GTTkTfecpqvkG88VSI1ut+KnBeFFcCc6R8b9JV7hr0MYpFPJonSAQ3gbJVhFIcgyT8u/DzFqihrg0Gtl5b2fscye3nNmMIz1429YIf0QtIMGipH7xOZecycoZ44585jR7LrLrucHjRcPFhTg3EbWF+SKSZgHkPy6WtDsUWcZjivegOm2oigTL1RO0Aws4+MGH/IOHTOwlkpOp5FJFqB0tNfKCSjNkig4S56brM5Dx8Jq/aiVkd/QXwtxXqceZX+MJNaMVN6lY2T+SxBp9aMa/WRkPb4pOtvHICEziSRMOu2fiXQ/rmQ59MEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jHA4oOJc/kK+Q8zXYnkafNCUrlsob5GpLZXCCH3bcq0=;
 b=OI1o0XCjJQ3mDwgWekroxCEDK5D++0s/+HBHQeMrKQqZtv1Qh108RLZX6kr+F9gH/etFK5waudvKZJlXGyfqEEb1LOldzA2OdvLI3Z7f66mIyyAemcgqhhG/6NgL9KLEuBhDsT6NufWs0YxdwohZ1rLJpRi5PWKu+PDbr0eGHJY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5712.namprd12.prod.outlook.com (2603:10b6:510:1e3::13)
 by SN7PR12MB8057.namprd12.prod.outlook.com (2603:10b6:806:34a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Mon, 30 Jan
 2023 10:35:13 +0000
Received: from PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::5593:9517:a2e9:1b6b]) by PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::5593:9517:a2e9:1b6b%8]) with mapi id 15.20.6043.036; Mon, 30 Jan 2023
 10:35:13 +0000
Message-ID: <08385b8c-0fae-3249-3dfb-5a7800928213@amd.com>
Date:   Mon, 30 Jan 2023 16:04:58 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v3 1/2] perf script: Show branch speculation info
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        x86@kernel.org
Cc:     peterz@infradead.org, bp@alien8.de, acme@kernel.org,
        namhyung@kernel.org, jolsa@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, dave.hansen@linux.intel.com,
        james.clark@arm.com, irogers@google.com, eranian@google.com,
        ananth.narayan@amd.com, ravi.bangoria@amd.com,
        santosh.shukla@amd.com
References: <cover.1675057032.git.sandipan.das@amd.com>
 <87c48949f5a442dda6d4dc75d4a4303973eb04b2.1675057032.git.sandipan.das@amd.com>
Content-Language: en-US
From:   Sandipan Das <sandipan.das@amd.com>
In-Reply-To: <87c48949f5a442dda6d4dc75d4a4303973eb04b2.1675057032.git.sandipan.das@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0192.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:be::16) To PH7PR12MB5712.namprd12.prod.outlook.com
 (2603:10b6:510:1e3::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5712:EE_|SN7PR12MB8057:EE_
X-MS-Office365-Filtering-Correlation-Id: 464fdb62-ad7a-47c5-71e7-08db02adab6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JItmQqA6gaHUOzMSoEdEkInb+z6XMcxFDgbaMV5yy2vd9wPrsgya5ebS1Rq3aHP/5GAzcIcTq/au5DH/M/ScpBAHH1REhOX/2u0COsB5sRrLgdGj9llXnEWRh+N5JHF6DDlxOAoigJlR5cqwXUoJuA2tY9Gjbk529Q+eou/Hn1E+P+IEv3gckq7NA61jDs5Ncku3jYdJftL03sm5cVAOXUjpnE8y9tx4/mjLcIJ1Rdvp7nsJbG0+rzrscyxL1V8FtRFRrJvT+DA7sWw7LjpY6M1lg0aXvqak83wX2RjDpcWyC3u4XmWcqDOGlokA+ryRMEj5caZVW9I6GAYXXYM8MXfX+FeD9VV+uYMHDtoRknDVwf8Vm/jTaAjQgY8DO3g2VqbEUjPMl8Gbrm/qs7623XSRdXrbpA8fydI8uvqs03Wogmte9S7YjTsLOOIGfTH6uwytH0b/Qpgcw1EZtQAGYsCqtEJVQ4WCRt1GTK/+Ni0vOdY3krf+iy9P663SRVZVBx5IF/QjZhaKK6nFeNQCy597G0d1TpJaJ7vBXgjxOu7ikMBSZqie1bN+gsfhyTCh3wFhiR+5IzWP3BZSg8LQkbv6Hpnm8j4Y4pHaXXIf0Zq2ZH3ljWrrKSH8BenVyiD49WSgkNDDHaYEccoSyK+NcsDz7ALbv88VuSgXj5eEDjS/+EcabGiIaSFhC1qqIrKAmOYe46lzyh9sw44Pz7VpEYS6ymwwFWW650RAkWfAKYg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5712.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(396003)(39860400002)(376002)(346002)(366004)(451199018)(2906002)(316002)(186003)(44832011)(6512007)(5660300002)(26005)(6506007)(53546011)(36756003)(7416002)(2616005)(6666004)(38100700002)(6486002)(31696002)(31686004)(83380400001)(86362001)(478600001)(4326008)(66476007)(66556008)(8676002)(66946007)(8936002)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dk4vR25VZkhqU0VZOGZmOGQ1eEpRZHBjOVF1TzNBRDRGenRlN3lZdmpVSkJY?=
 =?utf-8?B?cWlKeCtrZkE2NE5JdWJUeENGSGVxTlFFK014VS8wY25Zb1d0SGttTGZvZkdY?=
 =?utf-8?B?VWVwblMvczFubG9mTmFoYkJHT0hxaG9pTzVCMUQvaHJXeER6T3lOYXduWTlw?=
 =?utf-8?B?eDFZT0NRQ2dNVVFmVXpvclZhVGJHMVVPM1N6SlZLT0IrMWZ5SmJiNlVjdEdT?=
 =?utf-8?B?cEZIb3NYWjB4TEsrMEIvb1dvR0JQbWMyUUE1QzM5SUlRVkFCVndrNkl1bjgv?=
 =?utf-8?B?emZGVEs2T3BrOHdqR3E3T0UweHh6aE1nS1lKMTNjdElUVjBQWitKNkZXYndB?=
 =?utf-8?B?dzJrandCVlVMNzNuR25RbnUwamRiaFRCdEJRSnpBdVNhNXF4c0drTTZBRDZD?=
 =?utf-8?B?dHkyeDM4cFpBd20rdURPOUE1alJIR3EzdDExVmdWZ3AveFNKRDB2NUNVU0Ir?=
 =?utf-8?B?WDc3THpxdm1KL3hrdGhHcWxIdkdwUEsxMW02dzNPU3cwekwvSVpIeE02eDdy?=
 =?utf-8?B?NW9BQkdZbGVPN3BKUDlBRGJSWmNhZHdmN1g3YXZQdUhqaFpSTEg2Wk9uTjdO?=
 =?utf-8?B?YWJsUEtLSldTNDdpc2pVNmNMUm1NYWZLUXEyclR3djJrS2ZVaHZHZnViRG9n?=
 =?utf-8?B?WWY4ZWNmbW9tRkh4M1paUzZQRUFISVY5Mm9ScGVWL3RPemF5VnplQ052emdQ?=
 =?utf-8?B?bnRINkZUVFNGTjIyRXIzM1ZleUlzcG5OUk5hbGlpSlgwYUJmd256OE5OTmo4?=
 =?utf-8?B?T0RaNUpWdzlHdFFiVHBQRXI5Q1FQY3BQQ0kyMkNPRFFGM1BRemR6TkNOc0NP?=
 =?utf-8?B?L0xURnJxWkFpcjdtekhnRFg5eTVCcCtsVVE0cEVyQzdUWDk1MWs4dUtnd29M?=
 =?utf-8?B?VXJXOE1qaDhVSUp3cDhCVGl4WTVrSlpMd0Z4THVSUStwVllMMVRONmlxTXdC?=
 =?utf-8?B?RGlxUVAySElUd2EzQm5XVjBPbWtqR3JJZkpwcUV2bXYxTW5XdGUwL0pYMGd1?=
 =?utf-8?B?eUFMN2tmTDI5dW5YczM2cWk0QVI2eXl1WGlzS0owMEtvZTZBK29QOUlPWUp6?=
 =?utf-8?B?bG11U2huWGVmMDJ6RnVaV0loWWtKTnU0UkQ4akgySWdmSmVFbzRIeUhHdWp3?=
 =?utf-8?B?THhzRGlEdlU5MmFsNnlZRGpWUWdqSzdsNUxCNTM3cCt1RkZSdUVVeUZWdDdq?=
 =?utf-8?B?QjN1Z1Y4ZWNtRnJBNDYvTzBTOFc3QlZQRk5xMWFKVTlvT3lLZGJkMHJOQUh1?=
 =?utf-8?B?eTNEZHV2bU5MQVhkOXVIK2Jheklnelp5TlZianJVeDZ6bjY0OFdtUkpHMXdQ?=
 =?utf-8?B?dEJ6OHNtSFBSd0ZJOWV6WTNOdDU0eGk4Z0gvYVplNXBJOEdiWnh1L0RtNmkx?=
 =?utf-8?B?K05DcGxsazZheTNkTUlxTTZ5TGRsejRENXM4cGRzMzFNOW8xVGVUUnQwRVRz?=
 =?utf-8?B?dFpvekFGaHBsR1hEL2YxdmZNbWxKSHVVRk4wQjhVWjd2MDFvOFJxbHFhOGxz?=
 =?utf-8?B?UVJSRU5ZVG9BMHRhb0p4QmhjSkxqSEcwWTUrS2t0MVBJandUdjdZSXRqc0Ey?=
 =?utf-8?B?eDRNL2h1WEZUQzFXbW04SVRBa2J1M1dFeXZ2UTZWRDdTM0VDdThmUEFGbFFP?=
 =?utf-8?B?b3RjSGNsdk9zUkhtaERNNnRPRitDam01czNvZk14MUR2Q1hkcTY3TE9heTRt?=
 =?utf-8?B?aFhMcU9abTMya1k5Mmlnb3ZidDJnTnJRblQxNUNSUXBkSnpaa0R2U1NVWm5L?=
 =?utf-8?B?NHVJWllnZW56MmRaOVJBYnlXdmN0bEFHYndMejVjalVUY2dkQi9GQ1RTUm5N?=
 =?utf-8?B?cGU4emJ2SnJ3YURwL0ZXQSttT2tnV0Rid09HTTNkTVUvYjBZdGsza3owSDhI?=
 =?utf-8?B?YlZrUnRUWlE4WUJkNlUrMk1oRUs5aWRVdzhrNzlCR3pUajFpYzl5VW5xcEIx?=
 =?utf-8?B?eGhVTVRIeGRidEVoc3I4YUJZT0t1SWZ4T2FMVzQ5TXBZNXgvYlF0WU1yWWR6?=
 =?utf-8?B?R0g1djFkNFlzaUlzMU5tOFR1WTlqSEUrb2hWSHVKdGFDd0hHc0E3eWJVUFND?=
 =?utf-8?B?QmRVUDMyOU8ranpmSXVaanE0SmU5OFkyL21LeWpUdkhiZXNCY1RORUd4eU14?=
 =?utf-8?Q?D3ODkwdPKakQLExE6SGwUVW8Z?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 464fdb62-ad7a-47c5-71e7-08db02adab6c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5712.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2023 10:35:13.3227
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L8xtGqMM4Q+dFkkkvEe1bhJq6rUwN0VK9aVh3nNoS1ZHBzEi3/V00EmOkDshSkwiHWksioOxjpu2N5p5mxG/6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8057
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/30/2023 11:29 AM, Sandipan Das wrote:
> Show the branch speculation info if provided by the branch recording
> hardware feature. This can be useful for optimizing code further.
> 
> The speculation info is appended to the end of the list of fields so any
> existing tools that use "/" as a delimiter for access fields via an index
> remain unaffected. Also show "-" instead of "N/A" when speculation info
> is unavailable because "/" is used as the field separator.
> 
> E.g.
> 
>   $ perf record -j any,u,save_type ./test_branch
>   $ perf script --fields brstacksym
> 
> Before:
> 
>   [...]
>   check_match+0x60/strcmp+0x0/P/-/-/0/CALL
>   do_lookup_x+0x3c5/check_match+0x0/P/-/-/0/CALL
>   [...]
> 
> After:
> 
>   [...]
>   check_match+0x60/strcmp+0x0/P/-/-/0/CALL/NON_SPEC_CORRECT_PATH
>   do_lookup_x+0x3c5/check_match+0x0/P/-/-/0/CALL/NON_SPEC_CORRECT_PATH
>   [...]
> 
> Signed-off-by: Sandipan Das <sandipan.das@amd.com>
> ---
>  tools/perf/builtin-script.c |  5 +++--
>  tools/perf/util/branch.c    | 15 +++++++++++++++
>  tools/perf/util/branch.h    |  2 ++
>  tools/perf/util/evsel.c     | 15 ++++++++++++---
>  4 files changed, 32 insertions(+), 5 deletions(-)
> 

Sorry but I realized later that this change breaks the builtin branch test.
The additional change below fixes that.

diff --git a/tools/perf/tests/shell/test_brstack.sh b/tools/perf/tests/shell/test_brstack.sh
index 59195eb80052..1c49d8293003 100755
--- a/tools/perf/tests/shell/test_brstack.sh
+++ b/tools/perf/tests/shell/test_brstack.sh
@@ -30,14 +30,14 @@ test_user_branches() {
        #       brstack_foo+0x14/brstack_bar+0x40/P/-/-/0/CALL

        set -x
-       grep -E -m1 "^brstack_bench\+[^ ]*/brstack_foo\+[^ ]*/IND_CALL$"        $TMPDIR/perf.script
-       grep -E -m1 "^brstack_foo\+[^ ]*/brstack_bar\+[^ ]*/CALL$"      $TMPDIR/perf.script
-       grep -E -m1 "^brstack_bench\+[^ ]*/brstack_foo\+[^ ]*/CALL$"    $TMPDIR/perf.script
-       grep -E -m1 "^brstack_bench\+[^ ]*/brstack_bar\+[^ ]*/CALL$"    $TMPDIR/perf.script
-       grep -E -m1 "^brstack_bar\+[^ ]*/brstack_foo\+[^ ]*/RET$"               $TMPDIR/perf.script
-       grep -E -m1 "^brstack_foo\+[^ ]*/brstack_bench\+[^ ]*/RET$"     $TMPDIR/perf.script
-       grep -E -m1 "^brstack_bench\+[^ ]*/brstack_bench\+[^ ]*/COND$"  $TMPDIR/perf.script
-       grep -E -m1 "^brstack\+[^ ]*/brstack\+[^ ]*/UNCOND$"            $TMPDIR/perf.script
+       grep -E -m1 "^brstack_bench\+[^ ]*/brstack_foo\+[^ ]*/IND_CALL/.*$"     $TMPDIR/perf.script
+       grep -E -m1 "^brstack_foo\+[^ ]*/brstack_bar\+[^ ]*/CALL/.*$"   $TMPDIR/perf.script
+       grep -E -m1 "^brstack_bench\+[^ ]*/brstack_foo\+[^ ]*/CALL/.*$" $TMPDIR/perf.script
+       grep -E -m1 "^brstack_bench\+[^ ]*/brstack_bar\+[^ ]*/CALL/.*$" $TMPDIR/perf.script
+       grep -E -m1 "^brstack_bar\+[^ ]*/brstack_foo\+[^ ]*/RET/.*$"            $TMPDIR/perf.script
+       grep -E -m1 "^brstack_foo\+[^ ]*/brstack_bench\+[^ ]*/RET/.*$"  $TMPDIR/perf.script
+       grep -E -m1 "^brstack_bench\+[^ ]*/brstack_bench\+[^ ]*/COND/.*$"       $TMPDIR/perf.script
+       grep -E -m1 "^brstack\+[^ ]*/brstack\+[^ ]*/UNCOND/.*$"         $TMPDIR/perf.script
        set +x

        # some branch types are still not being tested:
@@ -57,7 +57,7 @@ test_filter() {

        # fail if we find any branch type that doesn't match any of the expected ones
        # also consider UNKNOWN branch types (-)
-       if grep -E -vm1 "^[^ ]*/($expect|-|( *))$" $TMPDIR/perf.script; then
+       if grep -E -vm1 "^[^ ]*/($expect|-|( *))/.*$" $TMPDIR/perf.script; then
                return 1
        fi
 }


- Sandipan
