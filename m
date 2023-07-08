Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CA9574BA89
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 02:27:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232735AbjGHAXk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 20:23:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbjGHAXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 20:23:38 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B293C19B2
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 17:23:36 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 367HVe0s027773;
        Fri, 7 Jul 2023 17:23:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=8VfJaoTD3S6riNrU3eHMIoOoOKuPOlxtYX8oiRRzVSo=;
 b=Znfud+jXlR9PGAslk4XCexgNtOpPSbjONsd+SOnCAukP+HKfFM0ZF7Jtu6joC4t2OtA3
 tJnHhLSOyNd4l+g3S75P6QGvBOmzga4a9hu+/jUjEc8s3F5CKnUq1mDwYFzZK2H27Eyh
 B6ETFTXGQfzTDysIlTUJyK9eJd1a05il0cPv2UFdaYKis1UHrjZojuJLmyykiRVPa/tv
 SWyzeM6jnhIkvhJRzZKIqG6wauQAHiVD0cGNgfsXfYvlryabU5sJXEioQA10eB8dc4xK
 2rg7t6ibBDh7ETwzDn/NRW67MP6FRqMSuH49wGDWp6NvJT4F2y6PgXCT7EznL7Uj9+2t iw== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3rp07s63sf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Jul 2023 17:23:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PqH3xtWi3qvzR9QQakKnZuu3SK6XU1149i72T/cwZXtOudUmNM/3B879pJqmcr0sq76gzgs1PlQVQnVI/4nXC9G2SYhe7n1BqYgvKJFMThndaFh/noN1heCeIm8jVobN6MpmkRgwIuvJONSb42f+NkrI5PtHHmhpu/6E2P63ZZkNuBrBwow5o0Q6h36T30eEREuSW96eYBQvdvKhX/ty/kSALYW/9jOww7oWYDVaRr2gPLHwv6oa9xnvhkNvBWQCG0lCWL4hjFne337CJCg2VHwxmer1sIqIj2P0GGCZb+z8KndbMadDujQXCI2QJMfOlXpnEZ4oCmVVrLfbcqZKfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8VfJaoTD3S6riNrU3eHMIoOoOKuPOlxtYX8oiRRzVSo=;
 b=EwlKortSkI6WUo7Y+DkihUednggDsjaNutLAxqlbhv3jK/9/9VFv0Pjxe0NXJc0FbE5JvmuwZoNK+MHrdBixz/VGaIjEdcRb/FK/oRAtv4fqTCeddoGN4EGXcm5hkE+p9ANICXN+z7Ec4rh1JQ7U8LiX99t7V760wiyPplM2brPZC+6JN4wtIbmw5lcor8FN5YugpqiA0cFrqktoiqS6gM9nuQ3v/dTmYGhmPW462XGG5O5Qp0uLegJJHXUIFynhwdbbLS074Uxow3m/23e9slWcIklQgLUrrYVgXw8w5O2y64dj0lBSQi00DkjHJiKD/zvmL3lN0VgTr6P13nhYRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by IA1PR15MB5893.namprd15.prod.outlook.com (2603:10b6:208:3f6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.24; Sat, 8 Jul
 2023 00:23:10 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::428f:acec:2c1f:c812]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::428f:acec:2c1f:c812%7]) with mapi id 15.20.6565.025; Sat, 8 Jul 2023
 00:23:09 +0000
Message-ID: <233802b0-7404-1f79-39ae-385da567f657@meta.com>
Date:   Fri, 7 Jul 2023 17:23:04 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v2] kallsyms: strip LTO-only suffixes from promoted global
 functions
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Yonghong Song <yhs@fb.com>, Kees Cook <keescook@chromium.org>
Cc:     Petr Mladek <pmladek@suse.com>, Song Liu <song@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Fangrui Song <maskray@google.com>, kernel-team@fb.com,
        Leizhen <thunder.leizhen@huawei.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Sami Tolvanen <samitolvanen@google.com>,
        "KE . LI" <like1@oppo.com>,
        Padmanabha Srinivasaiah <treasure4paddy@gmail.com>
References: <20230628181926.4102448-1-yhs@fb.com>
 <CAKwvOdm_Cp9dF1yseTXvOOtFMsOPzCBWhfszAt0k5SXXyFyjtw@mail.gmail.com>
Content-Language: en-US
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <CAKwvOdm_Cp9dF1yseTXvOOtFMsOPzCBWhfszAt0k5SXXyFyjtw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: SJ0PR03CA0239.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::34) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|IA1PR15MB5893:EE_
X-MS-Office365-Filtering-Correlation-Id: 54ac6b94-9af4-4ec1-4368-08db7f4981ae
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Be68G6VAVHoZHcI6ZEBflXWgSA5q3Uvl4q7fNoi4bMZiQaSpO+wFbGJuA4M5xZ2w1sFXU/h3IUveS2kYrOvVsXosMEfoCRhjueTrBLZkGaG/1AsAhiwazGnnVL4zMf8wmjLxPIo/GwwIvrUczR5+zFPvwNwmAjiGAzhx9/gc/Dl8QakJmR/YpjKCWG6Wm5H9jUsyIBEK26u4FwQsexKvEwnkZqorutQ0SXnrVLcrFcosm05Wl4PjM8ELHxW71OWpiNZF1vVAUuZ3Y2UfnfZB99JIMcYpVW9dnEUTFn1sMg3MhZJb8R0tqA2IJ5JoUMcsvGCjHBgOv1Vn8rTrUBNCTlnPgBq+0n73gzLlZEBRs6Ig5ujCBbmxLrZSSjjzKX3lL3wBdNCXXsZrc5h8JHKkeeib8xjlQankQJrY+Osx2g+7Q7u63RKpnCXyc4CLQhDC528yup0ZKiI8Vnlt9CqoGFPmlhUh860D5jzqX52nTCroo8vSZeYWli9L16N082LGsbzU2vNHpJEl1ZZqbkm/LP7+B8a+dxJq6xJ3pt5k5UyrJMTk1uSRK+etC6kKRbuxkSjDe7DBEXZxCd70V8oEIj9T3JzrqBKnYvW+mUxaNo4jjd/Hi9u9YEQN6wbv6be7aVGtBRHAV7PYEBVmmIGEFg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(376002)(366004)(39860400002)(396003)(451199021)(186003)(6506007)(53546011)(83380400001)(6666004)(6486002)(31686004)(54906003)(110136005)(966005)(478600001)(2616005)(6512007)(316002)(8676002)(41300700001)(5660300002)(7416002)(66476007)(38100700002)(66946007)(66556008)(4326008)(8936002)(2906002)(86362001)(36756003)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R1VYMURUVEpDZGVUZWFHTWlPSnpVb3MwZlZ3eVVZeit0SEF5Z3VvRUF5Ylkw?=
 =?utf-8?B?UmdkT0YyYXNHZ25wbVZ5SUs2QWU1NXZVVVVZdWllQXh5NHJmZ2lKbFgzcnh6?=
 =?utf-8?B?b2JVVFB5N0N4dmszeXRVRkFHUG1nSFhVaDNwWllEL0JYQUhwNGJyT29UeWk2?=
 =?utf-8?B?L1E0NTlEeFZBL05uTzNwWjdwOEhGd0JDYmk3UU9naWRjdUlGbFdKTTNoOFRy?=
 =?utf-8?B?bXZqRytKRWZBUTlzQm03L2V6dy9VUkMyaHZWREw1bUpqNUJjMjA0Q1pZbmpD?=
 =?utf-8?B?UFlzbkc2YUFzVVRUdnR1bzV3STR2YXVBRm1FYlRpVHlyQ29WMlMwcjNnYnda?=
 =?utf-8?B?K0FVUE4vRjZUVUVLUmFQV1RXT1gxUzJsbEZNbm1DQ280NzB0NE1nWXNpUnkr?=
 =?utf-8?B?SWd6NHVYMUwrVlh5Q1daQkRzY0xWRTBnTTVlRG9jVEkvTStkR0l3aFFFZ01t?=
 =?utf-8?B?OS8zalhqUjBUc1VTYS9LVDFEMDVaUlowNmZDMDdFOTl1Nmk2Q1hsei83THNn?=
 =?utf-8?B?dGFMWDVaTEJKWjlKTFI2bmdxeWs4enhIR2o2cTBsT3VVVFM4ZVV1WU0vQTBw?=
 =?utf-8?B?U3NTdEZYMVFycTlGUkk1S3JHZzF3TEpJU0ZRY3hpR0FxOGlFVDlyaEpac09o?=
 =?utf-8?B?dlZzSjBEaEltZnE5azE5UWkvc1RRdTZLQWZqS3E5TkM1MnpmaWpNZHVmZ3Iw?=
 =?utf-8?B?VWlqRFlQcklsTHdLUDVNdVN0MDZkd2F6Z3hLa0V6U2lEcWY3NFNLWS9Cdi9Z?=
 =?utf-8?B?bWEwSVVjTFdtTFdmK2FnY2FkZ0hrMUowYXpUQWdWbm1kUkZobElrM0tvSUFT?=
 =?utf-8?B?eVpKRjhpYi9vN1VIa0M4cUpCdm4xemQ2bzZzbTJVeFFZY01iZHlQVzJLL2l0?=
 =?utf-8?B?OWVTL3BTaGVVNktZMDlQbGdsZWRNSi9IRWorMnhKVDlUeENnM3IvQXUwWmc3?=
 =?utf-8?B?MFFJR2Y5ampvMUYxbXE1Z1AyR0VSTHYwWjU2SHI3VDMyN0doaHNoUWFubk1i?=
 =?utf-8?B?MWdFdVlMcEhVdHN3d0xIVk5ST3hCbXFwcWxVTE1lWVl0MFBWYWwxam5ZVmcz?=
 =?utf-8?B?d05FRDFXbFE4NTdkQ09NbmhaYWtuZlo1QW1IZXhWbFowSnZENnk5WDYvcGpm?=
 =?utf-8?B?TFJsK3IrZmRGVGc2ZDlGZThBbEU4MnEyTTdsMlBrbTdMbGU2eXBwbll1TG5E?=
 =?utf-8?B?VnQ2OHFzTG1LRkMwQTZaVFBtM2Z4WkVVaHp5MFF5ZkZDQ2hkSGdVZitNM2FZ?=
 =?utf-8?B?d2NpdDBUcUIxWitmYzNDWTVhMUFLbjNBcUs1NEdmcHF5V1ZVamRSdlNwYXV0?=
 =?utf-8?B?MlZWSVAxOGxhMmVnbEpRWTJmYklnNTgzV0IxSU9tUHUzZnNqSkFIZFJaVUdq?=
 =?utf-8?B?VDZ6UnloMEJSRjU3Z1ZRcVREcnpqcG40azJGMnpoelpXR09acDNsTDZ3WWo2?=
 =?utf-8?B?eE4vZ1hXY3labXI0VFd1bmkyTmQ2TmJYR0tIMTdrT2dSOFJYajJXQzFvelJH?=
 =?utf-8?B?NWdjVWdiS2hoQlhLWXZsZlhnWDB1K0RidGhneUVLZERUVnhlbDRGcnBmN3Zp?=
 =?utf-8?B?cm9XaXNSWTRaUTVtckErNXVvYkxTbzVEMWtaQitqSDI2ZTJVdDZSUm50MXlj?=
 =?utf-8?B?U25OUEZqSWExdWt5SEloajBjb2R1bUcxbFFOcFQ3MWk0ZTVlV2ZhTzBGbEN0?=
 =?utf-8?B?TFRnSGlGMndNQ251Z0FrUlF4WHJRNnFJQnEvclhPRGlUT0lwTGJNcHo1d242?=
 =?utf-8?B?M1E0WExlS05GVSs0ZTU1TzkybjFMeUI2VUVUdGMrc0hSL3BnUXQvNndaUmNB?=
 =?utf-8?B?bFJqUERXZlBrVkMzNCtwZkV1eGxZNHZOL2hOeXRTbEVsOGk0OGRCN0kwdnBH?=
 =?utf-8?B?anJETmdLUDNSWno2OUtTNlg2cWROckxxbG4rYUNPWTJyOW1mcDFDSnBZMVQ4?=
 =?utf-8?B?enNHUFZTcjhYanlScm1zM0M0NU5DWEpMcGxIOTczRldmek8rdTJ4VnBDano5?=
 =?utf-8?B?SDBLOVpNWVZsYkNOQVNxU00yVzVkT3h4d1AxZTZvMTNwUlRTL3JjcUl4aEVo?=
 =?utf-8?B?M3pHdjhtbENJVzhqK1RnU3FDUTUxdE45aFJNSmlDOGl3RzVKQlAxb21LTm5k?=
 =?utf-8?B?VUg0ZVBsSGVXRHFscHBhdkFoU1VXUzRIdGNaMmJYOUxlaGE0WTdVRHNBb3c0?=
 =?utf-8?B?NVE9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54ac6b94-9af4-4ec1-4368-08db7f4981ae
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2023 00:23:08.9610
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cXgqTBOs6zBBVTDlWJtFhsDkMrABe+Dd8M3EcamXnSNkMDvunhIr4IxCuRHgmjg6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR15MB5893
X-Proofpoint-ORIG-GUID: qgs8qjMnYUeQHsp19hODxO1Yqfp8hhk_
X-Proofpoint-GUID: qgs8qjMnYUeQHsp19hODxO1Yqfp8hhk_
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-07_16,2023-07-06_02,2023-05-22_02
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/7/23 3:27 PM, Nick Desaulniers wrote:
> On Wed, Jun 28, 2023 at 11:19 AM Yonghong Song <yhs@fb.com> wrote:
>>
>> Commit 6eb4bd92c1ce ("kallsyms: strip LTO suffixes from static functions")
>> stripped all function/variable suffixes started with '.' regardless
>> of whether those suffixes are generated at LTO mode or not. In fact,
>> as far as I know, in LTO mode, when a static function/variable is
>> promoted to the global scope, '.llvm.<...>' suffix is added.
>>
>> The existing mechanism breaks live patch for a LTO kernel even if
>> no <symbol>.llvm.<...> symbols are involved. For example, for the following
>> kernel symbols:
>>    $ grep bpf_verifier_vlog /proc/kallsyms
>>    ffffffff81549f60 t bpf_verifier_vlog
>>    ffffffff8268b430 d bpf_verifier_vlog._entry
>>    ffffffff8282a958 d bpf_verifier_vlog._entry_ptr
>>    ffffffff82e12a1f d bpf_verifier_vlog.__already_done
>> 'bpf_verifier_vlog' is a static function. '_entry', '_entry_ptr' and
>> '__already_done' are static variables used inside 'bpf_verifier_vlog',
>> so llvm promotes them to file-level static with prefix 'bpf_verifier_vlog.'.
>> Note that the func-level to file-level static function promotion also
>> happens without LTO.
>>
>> Given a symbol name 'bpf_verifier_vlog', with LTO kernel, current mechanism will
>> return 4 symbols to live patch subsystem which current live patching
>> subsystem cannot handle it. With non-LTO kernel, only one symbol
>> is returned.
>>
>> In [1], we have a lengthy discussion, the suggestion is to separate two
>> cases:
>>    (1). new symbols with suffix which are generated regardless of whether
>>         LTO is enabled or not, and
>>    (2). new symbols with suffix generated only when LTO is enabled.
>>
>> The cleanup_symbol_name() should only remove suffixes for case (2).
>> Case (1) should not be changed so it can work uniformly with or without LTO.
>>
>> This patch removed LTO-only suffix '.llvm.<...>' so live patching and
>> tracing should work the same way for non-LTO kernel.
>> The cleanup_symbol_name() in scripts/kallsyms.c is also changed to have the same
>> filtering pattern so both kernel and kallsyms tool have the same
>> expectation on the order of symbols.
>>
>>   [1] https://lore.kernel.org/live-patching/20230615170048.2382735-1-song@kernel.org/T/#u
>>
>> Fixes: 6eb4bd92c1ce ("kallsyms: strip LTO suffixes from static functions")
>> Reported-by: Song Liu <song@kernel.org>
>> Signed-off-by: Yonghong Song <yhs@fb.com>
> 
> Thanks for the patch and improving live patch with LTO.  Looking back
> at the internal report that resulted in
> commit 6eb4bd92c1ce ("kallsyms: strip LTO suffixes from static functions")
> your version was what I originally had.  I did not leave a comment as
> to why I changed it when I sent it 2 years ago, and no longer recall
> the reason.
> 
> 
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

Nick, thanks for the review. I am not sure how this patch could
be merged into the mainline. I checked your patch
    6eb4bd92c1ce ("kallsyms: strip LTO suffixes from static functions")
and it looks like the patch was merged by Kees Cook.

I added Kees in the 'To' list. Kees, could you help merge
this patch if you are okay with the change?

Thanks!

Yonghong

> 
>> ---
>>   kernel/kallsyms.c  | 5 ++---
>>   scripts/kallsyms.c | 6 +++---
>>   2 files changed, 5 insertions(+), 6 deletions(-)
>>
>> Changelogs:
>>    v1 -> v2:
>>      . add 'Reported-by: Song Liu <song@kernel.org>'
>>      . also fix in scripts/kallsyms.c.
>>
>> diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
>> index 77747391f49b..4874508bb950 100644
>> --- a/kernel/kallsyms.c
>> +++ b/kernel/kallsyms.c
>> @@ -174,11 +174,10 @@ static bool cleanup_symbol_name(char *s)
>>           * LLVM appends various suffixes for local functions and variables that
>>           * must be promoted to global scope as part of LTO.  This can break
>>           * hooking of static functions with kprobes. '.' is not a valid
>> -        * character in an identifier in C. Suffixes observed:
>> +        * character in an identifier in C. Suffixes only in LLVM LTO observed:
>>           * - foo.llvm.[0-9a-f]+
>> -        * - foo.[0-9a-f]+
>>           */
>> -       res = strchr(s, '.');
>> +       res = strstr(s, ".llvm.");
>>          if (res) {
>>                  *res = '\0';
>>                  return true;
>> diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
>> index 0d2db41177b2..13af6d0ff845 100644
>> --- a/scripts/kallsyms.c
>> +++ b/scripts/kallsyms.c
>> @@ -346,10 +346,10 @@ static void cleanup_symbol_name(char *s)
>>           * ASCII[_]   = 5f
>>           * ASCII[a-z] = 61,7a
>>           *
>> -        * As above, replacing '.' with '\0' does not affect the main sorting,
>> -        * but it helps us with subsorting.
>> +        * As above, replacing the first '.' in ".llvm." with '\0' does not
>> +        * affect the main sorting, but it helps us with subsorting.
>>           */
>> -       p = strchr(s, '.');
>> +       p = strstr(s, ".llvm.");
>>          if (p)
>>                  *p = '\0';
>>   }
>> --
>> 2.34.1
>>
> 
> 
