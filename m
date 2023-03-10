Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BFB16B5164
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 21:06:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231254AbjCJUGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 15:06:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbjCJUGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 15:06:36 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BDB9126993
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 12:06:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678478790; x=1710014790;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VooavCjZPtcMMVkl868qhFauU6Lzygckir4hPcCYQz0=;
  b=Hfk0XpEMhMy87FPWEtHbUIjShOyhHnPW7cUhCYBGOp3J1rnKjbcliOQC
   6umtZt5IWub755uvF+z0LZP9zuv8H/APTIldjE3NO6QIkEBpps/Z6jSIp
   bEUqU4jckUAQC0wc3ZKdE+AHkbmp4PWyi+SOoXShkLjzpwMi3v13pOhPo
   jy0VXF1qIcMi/hINh1tisr0XlqObIavyWwppKEbMw5AO6/14sAMCP079w
   QH8e+NsS/LA/ZYQ4Ho6LjAFCJu5jK+m2Hlh9b34sKc1eCvMI1OrY01/i4
   dQNhDaaHfFEKrwj8OYEDKwqU+CF639/plCets6uutqVcFAeLrKe8AD+Ug
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="336840503"
X-IronPort-AV: E=Sophos;i="5.98,250,1673942400"; 
   d="scan'208";a="336840503"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2023 12:06:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="746845310"
X-IronPort-AV: E=Sophos;i="5.98,250,1673942400"; 
   d="scan'208";a="746845310"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga004.fm.intel.com with ESMTP; 10 Mar 2023 12:06:23 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 10 Mar 2023 12:06:23 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 10 Mar 2023 12:06:22 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Fri, 10 Mar 2023 12:06:22 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Fri, 10 Mar 2023 12:06:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DmKSE34ery/FmF82emrzB9YZnazdM0Qw8ESJuhokVV48eGvOHqExFTLIaLkH3oN/08mXdCICFrALKPqswEtSkAt3KgF3A3p6LP0sP/2Gxq1fNmXarKuysuFDiy723Mt6VaOKG3JIfIfRrMZsqNaa1FOAUocI2pMo9F9LI1/MtqIFlDSzTgwFOUmUq8SZ1cEF0Y3knJMerJkhQda3tECnjXB+y+xK2nwIa/sfCbzmuD1Os+kqQCIigo8G70sEbiayEG9aeqc6NavUwLrqTCFGXEO6ibOIlSRSxQKH2fYm7Hve9bJB976b/+nTC+Le9vsrpnbXCnZJzgWobVSJyHnyzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r05zYTLUfcIHtkkSs2vbwsevtEo9+Qw4BuMK9DokSQk=;
 b=fDA5h2gSL6SSdx6eKlXunyz78f+SHr0FIqwAvH4vX2XkvRnlHydz8bUObq9HEfetXJFtj+/nkqj5+LYJFpwsZ5FyDGpHept/71iTie9XxDxPx9951OofXEeo+69C9ViZX3Q2FDJ1+uW6+iIDPZdqO5gVVQBMD1MXH6axznAOwPUt343vjhv9Ds9FJt792qfhNjxXdD4jcBBoBZw3WfY/EJ+9G2pZnIMpsIlmAQxROUls3saB+dBSdUvaiunJ8QDz4Tu2VHxtPIjC8KfbOUqT22PJuvRYJhGtP45I7nql7f4S1m8cwLl8TcdLsBQfy9QKpS/d4yKICZ2DS58H6ESpfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by PH7PR11MB6353.namprd11.prod.outlook.com (2603:10b6:510:1ff::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Fri, 10 Mar
 2023 20:06:20 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::d651:ac39:526d:604f]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::d651:ac39:526d:604f%12]) with mapi id 15.20.6178.019; Fri, 10 Mar
 2023 20:06:20 +0000
Message-ID: <0814c380-b5f1-be8b-f03f-e6fcb8fa0821@intel.com>
Date:   Fri, 10 Mar 2023 12:06:17 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.7.2
Subject: Re: [PATCH v2 08/18] x86/resctrl: Queue mon_event_read() instead of
 sending an IPI
Content-Language: en-US
To:     James Morse <james.morse@arm.com>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        <shameerali.kolothum.thodi@huawei.com>,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        <carl@os.amperecomputing.com>, <lcherian@marvell.com>,
        <bobo.shaobowang@huawei.com>, <tan.shaopeng@fujitsu.com>,
        <xingxin.hx@openanolis.org>, <baolin.wang@linux.alibaba.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>, <peternewman@google.com>
References: <20230113175459.14825-1-james.morse@arm.com>
 <20230113175459.14825-9-james.morse@arm.com>
 <b85cc905-3ea2-9f73-a592-0ebdc4240c37@intel.com>
 <4a9e4fed-c969-490c-d602-d00bcdcb5096@arm.com>
 <8d05bce5-b145-3df3-7445-02aa31ca877c@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <8d05bce5-b145-3df3-7445-02aa31ca877c@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR02CA0061.namprd02.prod.outlook.com
 (2603:10b6:a03:54::38) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|PH7PR11MB6353:EE_
X-MS-Office365-Filtering-Correlation-Id: 5989b941-095a-4276-db38-08db21a2ea4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SjzhYQuo2faoCnWmet7UNBOJViH7YKC9ja0Vic/FLmxZHW/1WekiZyXSHi/RB7ojxjZ/hl8GIBgor25QATG1bACpfdgTjDkFDfq/VzP34eSBtItxnhWC1epPpmQB0vkJmvbsCTSYS4zwY8VowlnfV1xZBEbJ2/MNelbJjEBYLQZJa1irY3B04BH4oO5ESc3Aa0biutk+sl5aniOysI6PaJQOz2AIFkHiLX/Mes8o2kfZen9/BiAqp1xpWYD550avYAeS5Iq7T8CSuanw3+SVwtsq9Ex8435A/UfZnNpO3EinZIYp/p/HgJehou2IcbCeEUwsi0nCGBa52saNcRW7nmphuGbhiTV+kKbjEnOIaPYu6T4fL/IxxAmf6zr1KRa+haoD0Oz996Bt2iJSAZT7gmdB1VUcY0MYAy0i4H1be+iAAgvL13wc3IiIKIbClKcmnVWVgs7Ayt1K4db1hN6jMg1IyyGz8WrpFSLeTMItgwhKtfQ6MxyMvQQ4lc5ysQoNjCrSrk88zpqbCphToSyj1iB84ksG0AUtXJ+MlYON41kIcPy5tkGM0P8FmAsbYrzwUTfSkj7BrsF9TqnOWAw5ybdbJ4w3wGJtzDZpw9GibSU1NTOCOgP9gAHWDR+UsS1J59CHtMmNfg1tzr7th+qLON1wOvcJjNNZ3dEB+VN57hW3o8LcdaOGfSqlZyyDGWu9qcSkYvGPEjvevj4Zjlx4eDqE8ycjwpgB0dPSp568H0E=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(39860400002)(346002)(376002)(366004)(396003)(451199018)(186003)(38100700002)(66476007)(5660300002)(7416002)(8676002)(66946007)(66556008)(6486002)(4326008)(31696002)(478600001)(54906003)(8936002)(86362001)(316002)(53546011)(41300700001)(26005)(6506007)(36756003)(6666004)(82960400001)(6512007)(2906002)(31686004)(83380400001)(66899018)(44832011)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TGpOdjQxd2JRTUxCOUlxRjNFbEZJcFFmWDI4MmZvcWpRY0xTTzhsNi9IbEJq?=
 =?utf-8?B?ZWdSSkF6Y3p4Ykx2NXh4Mitiem43dVhVV29nb0ZZamVuV2JSTGRkLzFZamFS?=
 =?utf-8?B?c3hKaGNkU3FFY2NuU0o4cUVzTGQ4bkVFZExNUEY4SHRFTklJRlREQ0VoUWFh?=
 =?utf-8?B?NCt2WXBNL1B5VFFsNjdhdHZRRWRRRzJIWU1BNFZYZE1aV3FmQ1VsSU1MZHlW?=
 =?utf-8?B?OWJvL2pXQkZ2VFFGNEZOQ0lYa2NmQ05DVXNVaW94SzdZMFludWNTdWwrcjFS?=
 =?utf-8?B?OXRMMkNaYTR4LzZvMitYa01BRHpxbE96NUZ5MTZHTUxEaVdUSkVvV1FNaFpW?=
 =?utf-8?B?T0F5TEdjTlc4L3RMRWVIcjRKWkNzNjMrN2RzdmExbytRb3FXeXpaVXIvd3R0?=
 =?utf-8?B?bVRsQndxRkVCTjZudHlKMjF2eGJic0tYTy8vak9LOS81U1FmYkphMnVINSt5?=
 =?utf-8?B?MzltQnA2aTRNc3ZYMUVEeEZSNkFvY1QwTkpvR1FhUCtabU1lbUROUnlYdXg4?=
 =?utf-8?B?ekpnZm9OQk9Ua3ZKOUo3ZlQ1WDNlalZhNlV6dkx5RmpJMk53UE9ESGV0NXYz?=
 =?utf-8?B?VHg4OURyTVBsSGp2cC9FME9YQ0VONUtDMW11TUVXb2FEdXdhRmlqVGJnMVFa?=
 =?utf-8?B?OFBjb1Q4ZnBrVWNaWDV0a0JUT1NpMmdhQVUwNnFqbTI5NkxlQS9TdU1lcGRa?=
 =?utf-8?B?NFNYZHhhcmYrUlpJSzQwclpkK0hlUlVzQk1VWEl6QUpSOGdVSzJkaS9saDZP?=
 =?utf-8?B?Mk1yZ0lURlAxTnkwL0pNNHBRY3V4ZmU4UlpmYUhleXI2b1JrdjlmNnpHR205?=
 =?utf-8?B?bmZkUmdjK1J0dmVzWnJET21RV2NiQTFPSzY0MDR3SGhLL3ViOWNuK3AwQm5J?=
 =?utf-8?B?N0p6SlNJbCt2aHdtcFpKYTg5SVdXc1FsYTlPdzN5T0FSVEVzRERqVWErSExD?=
 =?utf-8?B?RHdPOG9KVGJJZWxRUFE2R3JubXhwYXNFcU1KYTRjWWowbC9DNWxTeHVUbjZK?=
 =?utf-8?B?aUl5WVJ1YU5NNU14bHRSYzJMNUVnOWZJVVR6bmhkcEwxSlQ4cENDZTA5Yy9a?=
 =?utf-8?B?OG4rREpVWTBSdjFDWTZlVUxKTnFmZEdXRkdoNWZsa2F2SFc3T29SbzJsQ3lp?=
 =?utf-8?B?RHdxRWV3Nys3VU9BQlNtWGVnekc2WHAzTFExeklubEFEWkh1eTBMTXhTbnpY?=
 =?utf-8?B?ZzRQSlpXWkVMZGpYRURsZzlnT3JLaXhXQzlDbnBqRWhWOExnbm0wZTcrN0dr?=
 =?utf-8?B?RzRPakFlMktUb0RLQ3BDcHJ6RWQ3R203aFZHZGR4S000TXRXbWRrQ0NGRGRN?=
 =?utf-8?B?YzdVUHNjbW1MRjRqZVNYRCtjV0tOSWZYSlJBNEd2QVBpS0E5QWZIRHVqTzhy?=
 =?utf-8?B?MmlWTHhMbzI5WmQ4S2hYd0JXaVJhQi9ySk94SW9YcHd0MmRpUTdDVFg1OHZ4?=
 =?utf-8?B?TUx2dG5qTmtNTTExNU5ZQXNLRlBYNi9UL3hFU0FTNUx5QXhzWEpIRzRZOHJI?=
 =?utf-8?B?cmEwWDV4YjVTMTJDSDhGRGtTOU9BdzdSUUdIekMvUHFwb2x1UjV5ZXdGTFBT?=
 =?utf-8?B?VStoSHpKMEJxaHplVmkyRW1qTkQzS2hhN1RiZTVOYkgzQlpLbUdRV3QxTDVn?=
 =?utf-8?B?OEtHOXNrOGp2RjY4WnlyS0Qyd2t5dE1MZFRwR2VKZFdpbkFLbDBMTmgrYWZE?=
 =?utf-8?B?NzFPZ29rZEpzYURCekwzYXZHZ05EZU1TUTU0elpYbnVQNkJuUTlrS2RrZDI3?=
 =?utf-8?B?bjhCM2xZRnZaSXlzYzlNOTVhSnBKb2ZUSThZTFpvdDRzY3JCek1SeG1MNno4?=
 =?utf-8?B?N0w1d0V1T1c4ZU8yTFlocnQ1eklObnJ0UHBIeDhDdExtQlJjbTVQUVJMZ2cx?=
 =?utf-8?B?NllTdk5Fc2RISnRNdHg3YjFsNzVvUkM4Z0tBWncxSUJRTWs0V0crdDZlUDEr?=
 =?utf-8?B?VFhaMTFCOWZ2STcyNVU3UEdVd0liZlpMM2NiMkkwTzM0S3I2cFVkTHNrY1RB?=
 =?utf-8?B?Q0l3N0QwT0JwcWRjNktLejlKZ1JjSWt1TlVGczZFR0VKdzdWa0t5bEVML1Fz?=
 =?utf-8?B?bm0rYnFORnJpMnd6bzhGOEc2RVpzV1pPYU9LTkFRYVgrSXZ2ZXNWbk9ISzA3?=
 =?utf-8?B?UW1EMXh4SEVyNU51SFFnTThNcE9aa25laGJ3azl1dnVCWk42N3hSNkZoK3Ba?=
 =?utf-8?B?T3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5989b941-095a-4276-db38-08db21a2ea4c
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 20:06:20.4880
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0U7sM7puc2cB+mQYNrZE3sm7eEaPMn/CraR/xc1dOsjOknHnYitKqVDMhmRhDgJa02Z/3bEXZa4qJsEtIdLqPRMAR9Q7szCskJpvSMxBbfg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6353
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 3/8/2023 8:09 AM, James Morse wrote:
> Hi Reinette,
> 
> On 06/03/2023 11:33, James Morse wrote:
>> On 02/02/2023 23:47, Reinette Chatre wrote:
>>> On 1/13/2023 9:54 AM, James Morse wrote:
>>>> x86 is blessed with an abundance of monitors, one per RMID, that can be
>>>> read from any CPU in the domain. MPAMs monitors reside in the MMIO MSC,
>>>> the number implemented is up to the manufacturer. This means when there are
>>>> fewer monitors than needed, they need to be allocated and freed.
>>>>
>>>> Worse, the domain may be broken up into slices, and the MMIO accesses
>>>> for each slice may need performing from different CPUs.
>>>>
>>>> These two details mean MPAMs monitor code needs to be able to sleep, and
>>>> IPI another CPU in the domain to read from a resource that has been sliced.
>>>>
>>>> mon_event_read() already invokes mon_event_count() via IPI, which means
>>>> this isn't possible.
>>>>
>>>> Change mon_event_read() to schedule mon_event_count() on a remote CPU and
>>>> wait, instead of sending an IPI. This function is only used in response to
>>>> a user-space filesystem request (not the timing sensitive overflow code).
>>>>
>>>> This allows MPAM to hide the slice behaviour from resctrl, and to keep
>>>> the monitor-allocation in monitor.c.
> 
>>>> diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
>>>> index 1df0e3262bca..4ee3da6dced7 100644
>>>> --- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
>>>> +++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
>>>> @@ -542,7 +545,7 @@ void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
>>>>  	rr->val = 0;
>>>>  	rr->first = first;
>>>>  
>>>> -	smp_call_function_any(&d->cpu_mask, mon_event_count, rr, 1);
>>>> +	smp_call_on_cpu(cpumask_any(&d->cpu_mask), mon_event_count, rr, false);
>>
>>> This would be problematic for the use cases where single tasks are run on
>>> adaptive-tick CPUs. If an adaptive-tick CPU is chosen to run the function then
>>> it may never run. Real-time environments are target usage of resctrl (with examples
>>> in the documentation).
>>
>> Interesting. I can't find an IPI wakeup under smp_call_on_cpu() ... I wonder what else
>> this breaks!
>>
>> Resctrl doesn't consider the nohz-cpus when doing any of this work, or when setting up the
>> limbo or overflow timer work.
>>
>> I think the right thing to do here is add some cpumask_any_housekeeping() helper to avoid
>> nohz-full CPUs where possible, and fall back to an IPI if all the CPUs in a domain are
>> nohz-full.
>>
>> Ideally cpumask_any() would do this but it isn't possible without allocating memory.
>> If I can reproduce this problem,  ...
> 
> ... I haven't been able to reproduce this.
> 
> With "nohz_full=1 isolcpus=nohz,domain,1" on the command-line I can still
> smp_call_on_cpu() on cpu-1 even when its running a SCHED_FIFO task that spins in
> user-space as much as possible.
> 
> This looks to be down to "sched: RT throttling activated", which seems to be to prevent RT
> CPU hogs from blocking kernel work. From Peter's comments at [0], it looks like running
> tasks 100% in user-space isn't a realistic use-case.
> 
> Given that, I think resctrl should use smp_call_on_cpu() to avoid interrupting a nohz_full
> CPUs, and the limbo/overflow code should equally avoid these CPUs. If work does get
> scheduled on those CPUs, it is expected to run eventually.

From what I understand the email you point to, and I assume your testing,
used the system defaults (SCHED_FIFO gets 0.95s out of 1s).

Users are not constrained by these defaults. Please see
Documentation/scheduler/sched-rt-group.rst

It is thus possible for tightly controlled task to have a CPU dedicated to
it for great lengths or even forever. Ideally written in a way to manage power
and thermal constraints.

In the current behavior, users can use resctrl to read the data at any time
and expect to understand consequences of such action. 

It seems to me that there may be scenarios under which this change could
result in a read of data to never return? As you indicated it is expected
to run eventually, but that would be dictated by the RT scheduling period
that can be up to about 35 minutes (or "no limit" prompting me to make the
"never return" statement).

I do not see at this time that limbo/overflow should avoid these CPUs. Limbo
could be avoided from user space. I have not hear about overflow impacting
such workloads negatively.

Reinette
