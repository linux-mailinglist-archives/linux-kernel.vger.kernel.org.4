Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5B3E5F0567
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 08:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbiI3G5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 02:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbiI3G5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 02:57:46 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2086.outbound.protection.outlook.com [40.107.96.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50DC514AD63;
        Thu, 29 Sep 2022 23:57:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VzrjTlOi9n13q9ZbYMR72r5mqW5Fu724P6dOT4womqXS1iFETHqX3sbYKeiauZQmcx09wTOgqRGJmyVsMZVYjXxNz5buCS+e+8cflJParpW5oxtcCToG5FETXTNJQEWEp6kFTJ/aDHXc8ic+kxhysqRGpXluoXtOrMkIk1KriBdehMyprYKw+3gNSVQq5MAOUj3nL1bgjSDGFMWBBn7YBujFF/Z9DJiE836zrhzS4zfw9YU0k1BujqoRJRLW1FtNNwOqzYd9+zHJr5K9X3NMjNsEz33r8fnLaysOmMG1b62oQh3iD+6ZaWL93EmT6reDRGCxs/Q/GvcrEPRpNgiuZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=01UZalLi/HuYoDrKN3aAIsBkyv/yLVmNZ1h1PqF6GAo=;
 b=RSqMUPGnPuMoxs+cCscQQeJPg4ndapE94/VNLt3LKVjMGFv2ETc0Oxj0vnpJbnBeSyplQ6+rqEPcft1NVPldWQDLV5fRdcJiI8CJyKjfsD4r0HDWnXOnBORxt+enYQm+RdsGXnCzCiX7eMSCBEYsBlx4kBK9LP+8G9d/prVS6RjQCThdFCCT32zOOV9ZnIfTbt7TwHWFUHjg2xcFwm/LvKKK9hhJpwbz+HttO3hfA7/N6LtUP3fv+HanS6Q9hvzNgEeGGMEpdBWIQ7R5GxkAPQu1khvGaHWDWOpUCXnn0Le+C5aJW1KXjmufujy5iFRG6TF9l8zPaZ8ZlzUvoPoTGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=01UZalLi/HuYoDrKN3aAIsBkyv/yLVmNZ1h1PqF6GAo=;
 b=X4vwG/2NX9v5LXKtWgOKYAgE7ll0oU7bAhPdVTd6RF1h89wqDNp6x9jk8rqh+rHTDSQO7fwJE3E7/zd0Lw/CqTk0D3HmuP48wo3/oQ3pT5LrzcETOKZgcG4nhwnyZHOAUvGm1h0cHv80wCivyP1Mh+/XgX97TsKzJ50g+GS0oE0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by DM4PR12MB5165.namprd12.prod.outlook.com (2603:10b6:5:394::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.23; Fri, 30 Sep
 2022 06:57:31 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::3c18:7a48:4291:c9b]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::3c18:7a48:4291:c9b%8]) with mapi id 15.20.5654.025; Fri, 30 Sep 2022
 06:57:31 +0000
Message-ID: <f54b8720-2282-f4fe-fcb4-881562118eb5@amd.com>
Date:   Fri, 30 Sep 2022 12:27:22 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
From:   Ravi Bangoria <ravi.bangoria@amd.com>
Subject: Re: [PATCH v3] perf test: Introduce script for data symbol testing
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Ian Rogers <irogers@google.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>
References: <20220924133408.1125903-1-leo.yan@linaro.org>
Content-Language: en-US
In-Reply-To: <20220924133408.1125903-1-leo.yan@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0033.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::8) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|DM4PR12MB5165:EE_
X-MS-Office365-Filtering-Correlation-Id: 211303fe-b691-44bd-ade3-08daa2b10b45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: erMlOJJnkJHV/3yfcolD2OPRa71UEPyeN8ETU21M9q8+LFsC9a6uSJ42r1/Ad/++FAxqWWo27/H6yOV/AuXyv2dPO0sGuBo7vOfkDluRqFAWSQgziDxIALp+j0qzU+y1EDctGDlWmiRsmqgcyRjOviVitifDNopJiY24i/s4/CCuWC4+a201AxuuiBoGqszGQIHy1/NAlrN0FF4Ctfcqc+cJQkj2Lc/9ER2cXk4GXgAfzS7KTgp8mfirGa9rwh8/NosILh/w1rP1D2pwPd60JocB0ZHZpsRyKJZ22defoU30IMAjWcJp9jWWfQ/IKhS2abiqEb4Ui1NJb/YY0jaXa2EcMirU0g8icGao+yTbv+LNFkI7F4+iapCoVx3H21bDEj858URXjR/y4IE+YPv84CefWRkfZjIi4cf3QiT9t7pUXs8JznJ/+utXuDhO4BQA6PfGDYcINYcNZz9jPdowhJ/clvjjr58sJRIis3fs15apxiaQ3rur5VlxMNQYroD/AScYE9GG1UDGnMaSO4v4E1sh8KzaRNAOSYY3z+htZPtqzTpyf8WBK2P5UhCkG5yHNdvqCbffozsQy09ooAbqlqMly0dhAa2j/78TfXY6scJTr8EuH3Xh2hvtPwIP+g1wcr6JbXFDSo0E5CqmpIh2XKAuTVm7O+Sg2LAvh8yIRV+FQ7Mq0N6P289m/AkGap+YexVLBuHTPJv2YgM+TU9iKCJFaUYCpOyI4bsy2eFaDwSUFTftfRATWPbDsP4HIziLKEc+u2/Ou54d5a/6LRYozoLv8xgi7rEk1MBExEX0xrcuBxAhKCUep3ipQf3sKe0tPe0nIZkS/E+cZkVoUXqNoQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(366004)(39860400002)(396003)(346002)(451199015)(66476007)(41300700001)(83380400001)(8676002)(66946007)(66556008)(4326008)(5660300002)(36756003)(7416002)(8936002)(86362001)(53546011)(31696002)(6506007)(26005)(186003)(6512007)(6666004)(966005)(6486002)(478600001)(2616005)(316002)(6916009)(54906003)(31686004)(44832011)(38100700002)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cUpEWmpWb1BydERnK0gzLzk1TXBrRGVYZG56WG9vd003ZldaQWhYK01PMFY4?=
 =?utf-8?B?RjFUbGFtTlJ1bVpweFNLd2Y2cGxSTmxTVzloem1VM2tMKzdKRFVrK0hkc04z?=
 =?utf-8?B?NFRUT0c4bnRUekNjNGZoYVltWEQ5YTJIUC9oRE5tQzA3WUpXQmhtWHN4cU5V?=
 =?utf-8?B?d21SVGY1eWFpOWVGQkVnRktKSUk2b3BwQnFpN21hZDJiRGlvZWdCK1YrODU4?=
 =?utf-8?B?aU90MWw5SDRxR01wenlqWHo2WlFSNUpaMkJwb0Vka1lPYkhnbFlyZ090UTBm?=
 =?utf-8?B?dnAvL1R5UGJDYzVuZ05WMkNPaHZMZzdCOTZLZncrWTVodldPM0x5KzFMckJ3?=
 =?utf-8?B?Zzc5cThFeTZXRllWUnRwQUlTc25oTHAxUzlnS0JKOWI0b21rMWZ6UzEwNjZQ?=
 =?utf-8?B?cXg4aFdjODRCcjEwOXA0aUJvcnd0ZEp2cHN2MU1MTjFGWDAvSGIvRWRCb2N2?=
 =?utf-8?B?TnZWYmJSMWVjU0hhaE5FcGRaRHpNTDlTZ0RIc29kaHhWUi8wSnlzKzdVdC9j?=
 =?utf-8?B?aGNPL29oRzBZZUk0amJ2Yk1HSWJmK0NpNW5IaEExT092QlloenZnVHpMTVZy?=
 =?utf-8?B?NVRQOWNSUDFiS3lmTlJsYWx0eEhrMFJUU0l3Z052TFZvUU02cnhPdUpMOW5C?=
 =?utf-8?B?WXFYWXR3UnJmVmNzdzNzNVlpcm1jM0pJUFM2ckxJeVRIY1lISnlnNHlvb2JT?=
 =?utf-8?B?eW5mWFZXdWQxUXYxWkVHTE5BaEJvaEJjS1pjd09yaTUyamhuQnpaa3prcUFs?=
 =?utf-8?B?T0UrL0dETFh3SE5LS05KT0pxN2REVWJQeSs4c1hZdWIrWU5SaUdWRGFLTHNh?=
 =?utf-8?B?R2JRcitSa0N6dWZjWEhVMTYwbWhadHl1VWhyN3E2a3RzRGRlVGgvY3d0SkRX?=
 =?utf-8?B?NVhOaE5uTjVLS1pSdzFvMXMwNUVrYWZDMDBqUkY5R2J0S3VkbWFQb3RLM0FS?=
 =?utf-8?B?Q3B1TXdNZjBCdVk5UHh2RjhORmtubmdCRkM5R0NFbE5NYldlZHkyaHJRaGlO?=
 =?utf-8?B?MHpJdm9aa250RXF3MlQ3VVZJMVZFajEvSDd2VlhNdk9IZGlIay9EY1JvNzhh?=
 =?utf-8?B?RUtHVVo4cnZMN2FhTHBwYkdHY2RkNmF3MkdTRVNIOTM5MU1uVDFONElGVDNI?=
 =?utf-8?B?QjIyamJuRmw5Y0xSYzJHNUVYOUtKOHdnYUcvaEE1M2VDWVVXazVhNDhRNm1K?=
 =?utf-8?B?NStCbHMzY1B0YTN2VWMvTktGY2E5VTJkakZQTmlVbDZjRmYwc2tGQSsySWZw?=
 =?utf-8?B?c21MbHV1UWtEbzh4RnBMYm9YRTRncGVxeDRKT1U4UE5jNCtRK3hjKzM4V01k?=
 =?utf-8?B?YWptaDI0NUxkdDVmY1pnZ2RqUW12VXQzNjJKVlA2eHMvb1NZTTBJVWF5Ykgx?=
 =?utf-8?B?d3BselRZN0xjQk9PajZqVDVnODlGbGx0WHJxYk1nZUQ3ZEFibHNJMWx3blZ3?=
 =?utf-8?B?SUU4a2RaUExUc0VDa1V4QmF3UTgrUFN5bnU4WTMzMGpNellCa05GZURTRGtD?=
 =?utf-8?B?Ym1QdTNQYzUwdjNUMTdPUlBGRk0wNU9EaWFDbUZjbEF5aWdkRm5RV1A1MjYy?=
 =?utf-8?B?MFZwbEd3ZHlWYUtRM25jWXBqSERGT09FZmlmOWNyTW8vU08yWXhmVjVFTndV?=
 =?utf-8?B?UndDeVBtQzl2UjBMWUd6bTVMcGVLVklXNVUzNFZwNmNUOGZ1ZlFDL0MrVHlV?=
 =?utf-8?B?aVI5RzdpRkxha1RnQTljZ20veXRmT2NVV3lzZjZ1YzhPSStBUFRNZ1VLdkxy?=
 =?utf-8?B?Q012UVYraHpZSnBnd3JLaVpqa2ZJbXkwRldxNXdpS25pQTBwd1JaVXoybms3?=
 =?utf-8?B?dWlwOVdIbWJCL3B5RkpBSFNnM3ExYkdDWUszeitsZU41K1dtekFyK2NFQVcr?=
 =?utf-8?B?VEpkcHRkQ2xobjUzTjlrYkVnVTZrQzg5bWcrdzhCRWwzb1hPOVgzOWhJc1Vh?=
 =?utf-8?B?REpIVFlKNVM0eEhyUHBKejB0N1dUS2JmalFlejZ0TGVZYzFac21oM0IvZjdy?=
 =?utf-8?B?Mjc5ZUMvMDFPZ0ZNa1BOTmM5bzNKVGt1ZWM1RG80cTNKWWdSZGUremxtVDBu?=
 =?utf-8?B?ejc2bDFxcFdkck9HRDhWZHFuSjNPK2JVdHBCajU2UlQ1T2dPbi9QR1FoYkp2?=
 =?utf-8?Q?d2rApvYmCdrCaIx3k1XyXCCWx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 211303fe-b691-44bd-ade3-08daa2b10b45
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2022 06:57:31.1497
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hj86qMzRqDLNPwJtbbgEEuEI8FIuppQGYluZbpmmxgWEBK+38SeRKQLdb26l+HnXUioV6o/mUmVI0D7fAhZuWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5165
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Leo,

On 24-Sep-22 7:04 PM, Leo Yan wrote:
> This commit introduces a shell script for data symbol testing.
> 
> The testing is designed a data structure with 64-byte alignment, it has
> two fields "data1" and "data2", and other fields are reserved.
> 
> Using "perf mem" command, we can record and report memory samples for a
> self-contained workload with 1 second duration.  If have no any memory
> sample for the data structure "buf1", it reports failure;  and by
> checking the offset in structure "buf1", if any memory accessing is not
> for "data1" and "data2" fields, it means wrong data symbol parsing and
> returns failure.

I'm working on adding support for perf mem/c2c on AMD:
https://lore.kernel.org/lkml/20220928095805.596-1-ravi.bangoria%40amd.com

And this test fails on AMD because perf mem/c2c internally use IBS pmu
which does not support user/kernel filtering and per-process monitoring.
Would it be possible for you to add below (ugly) hunk to this patch:

---
diff --git a/tools/perf/tests/shell/test_data_symbol.sh b/tools/perf/tests/shell/test_data_symbol.sh
index a153b0d84dc0..212082951b12 100755
--- a/tools/perf/tests/shell/test_data_symbol.sh
+++ b/tools/perf/tests/shell/test_data_symbol.sh
@@ -71,7 +71,12 @@ int main(void) {
 EOF
 
 echo "Recording workload..."
-perf mem record --all-user -o ${PERF_DATA} -- $TEST_PROGRAM &
+is_amd=$(egrep -c 'vendor_id.*AuthenticAMD' /proc/cpuinfo)
+if (($is_amd >= 1)); then
+	perf mem record -o ${PERF_DATA} -- -C 0 -- taskset -c 0 $TEST_PROGRAM &
+else
+	perf mem record --all-user -o ${PERF_DATA} -- $TEST_PROGRAM &
+fi
 PERFPID=$!
 
 sleep 1
---

Thanks,
Ravi
