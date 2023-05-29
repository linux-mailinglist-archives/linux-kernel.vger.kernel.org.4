Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53C0B71427C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 06:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230318AbjE2EG7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 00:06:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjE2EG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 00:06:57 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2067.outbound.protection.outlook.com [40.107.95.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 112DFAF;
        Sun, 28 May 2023 21:06:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MWQSHSdIPNJX3wd288uu/PDnpXn8ByAOiy1fjZIVdho9F+n1igHgJ9aAUDM6/EwycGg6667yhGMVEkk7F+Pz1G6AdYuD/EgabOexvIUK9qtb5dCFBwxv0bCRsoy5XIxGh9pJge+uIz2GQHYlTVhXQf5CnzfJZO2ZQdNgiptkMyjxYVNUyT+t4QTBUG00NlWreGA1Z3x4rBpnWi+WQQN1GTcZrKdlS0yWxNQOjQ5VUmAsFIeaI4S3H8c+Ncv7fazDU3OEgcBJVPimDrdb7VQ+wOsdzJJciHgz2uEpqQk2QXYJz4YZlKuSjRRiRXdnPkZywBGCJxNc9vs61YGR37tgfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dqioSkpthudVGWcEWEVgzrjltDFwqNZjNxqAD+uJCfo=;
 b=LR6OY4I5zh69pWg7SnzJJ83HwYZaWaIXF0CZW7pb7O7xRAO9ir3OC8HW/agqdskowUUi3og1yDDU0BD7mbM5FCH2e/ooafLTC/37Z+E9AknE/yTlLqNXLjCPf/91Dz9Z7nd+XpdRlUFufrhzDmgC7qQzwHXN4KPPb92JIxzl7a/tPyNcI2CwMHy+wsLU+Y52SeM++us7/mChTVwY94P4p/I+kwME36hCHR3OkE79XOGl6jqBT8QgrfdWJaNDBZRy8N5I6cFYp4iDyJs5eKmbB6q88vF4jopIOaMC6J6ydpbQbSfdm9I63Jm8d4H1IlkrBCr7j6HCkwcAMoRGGULlWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dqioSkpthudVGWcEWEVgzrjltDFwqNZjNxqAD+uJCfo=;
 b=vL9hrFpkozQlrop9pxjynBIjuHIGc18PJoMj4x7tld8pIhM5/DI6UyOYELuC9mhGE1ehnA5bxbj80PnV/Ljbei9mln3p79Yl3T6dWULhl5bFdDcctBqRqnyxtv+JkkEHhAikAcC+TmsUnZujQE1LPqDjCpHHyXc6Zc4QskhbV8s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by DS7PR12MB8345.namprd12.prod.outlook.com (2603:10b6:8:e5::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6433.22; Mon, 29 May 2023 04:06:53 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::b4a6:94bb:6895:645]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::b4a6:94bb:6895:645%7]) with mapi id 15.20.6433.022; Mon, 29 May 2023
 04:06:53 +0000
Message-ID: <cbca803c-c9b2-f851-6cf1-f9ed0223de13@amd.com>
Date:   Mon, 29 May 2023 09:35:37 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 0/9] perf/mem: AMD IBS and generic tools improvements
To:     peterz@infradead.org
Cc:     mingo@kernel.org, eranian@google.com, kan.liang@linux.intel.com,
        jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
        leo.yan@linaro.org, kjain@linux.ibm.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        sandipan.das@amd.com, ananth.narayan@amd.com,
        santosh.shukla@amd.com, Namhyung Kim <namhyung@kernel.org>,
        acme@kernel.org, Ravi Bangoria <ravi.bangoria@amd.com>
References: <20230407112459.548-1-ravi.bangoria@amd.com>
 <CAM9d7cijvZBsaXTMm8d=sxUWy6s+umCCnWhunD3KVhKbpVp_-A@mail.gmail.com>
 <631876a2-5946-82d5-6f70-bf7734db3992@amd.com>
 <bd4f84ff-640d-02bf-1abd-58bc8362edb8@amd.com>
Content-Language: en-US
From:   Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <bd4f84ff-640d-02bf-1abd-58bc8362edb8@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0183.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:be::8) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|DS7PR12MB8345:EE_
X-MS-Office365-Filtering-Correlation-Id: b5f95de7-cd11-4d86-ed80-08db5ffa2227
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I1Hp+5JU3Lj7brC1oIkqwDkW0bXrIyf9V3RS9qfHhW69JHdAUa5Yc6V22cMk4HbhkHHjKHH5YOh+c59nSE5c6NdytGRiKhpmP2pLwqutFJkWUh+TEJa0cMQU8moa3uaFNcfm62o28iTMA69Yb6MHsmI7UvLJOurp86x3mOgYoVDWFQhPwWs6Ks3EwIczC7OGHThZO4TYMETjb5uMefYBwjIobLNbvfx+7efSxWOAKgh6ryntF5a9rGTvkpf7Kei6RD2qIzZy14FsWVyZX/FF6M40DcDe3RUHkSVf3mfuF98kyVkha4Rjnw/BxsAmfT6qB7MlJxZjS0/FoznWeKpSbhDTG4heEv+pFSYH17MehhOzQdJXBdhIpVkkXm3js9B+hf7XSw4qLXhGD9aLLmKSlzXiz7AiTCNGfi89sE6Canm3kkkAyhoeFVBL4L/rHh1yeBCgr5pSBgRSetX93JshNqGYecggFtKcJjJcRuLXwBfBDMjbMZyMgnaxtG1CXVCJsFq5LVQFYyJ+zg6JjMzPrEtGmSGdzOUCfU1kQ2VUFarCsQ+Sm6xYCYTw8xD2NgDtRwmBV7QAbwqcEV8lbd7Zl3AAHjkpl5DCdgWm9xVHwJt06gD3JM2jlF858LPtNFtALP7aJHIGOfG2025oM0dheSxyFXR591W3pdfdnU5yHOM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(346002)(396003)(136003)(376002)(451199021)(83380400001)(5660300002)(316002)(6666004)(66946007)(36756003)(66476007)(66556008)(7416002)(6916009)(4326008)(31696002)(8676002)(6486002)(41300700001)(38100700002)(8936002)(86362001)(44832011)(54906003)(53546011)(2906002)(2616005)(6506007)(6512007)(186003)(31686004)(478600001)(26005)(41533002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dHQ1OXZyNXRyVTdhQ0MzUE5GZGg3Mno3VlZCNDl2Y3lNOTNwUzZVUjhTa2xG?=
 =?utf-8?B?QldwRUhzd25BK09pUGZnL1ZmRnYxR1lIVVNKeWxFYXJpdkkrZUpORzArL2dK?=
 =?utf-8?B?RVgrenJvS09CYXgxYndFaHI5c2p3VXJkc0VQRk1UdzJ1RG4rbmQrTEVpRG1m?=
 =?utf-8?B?QlV4eDM5cG5CSkhHNlBvRWtXRW1ybTBrajZmcyt4ODRCS3dpL0phbGZmS1pB?=
 =?utf-8?B?YUpvcXYyTzZEcnVoNWNidDljeDA4ZFhrOVo2R2I3VmwySVBFQmpWdHRHMTNQ?=
 =?utf-8?B?SUdNWVdWZWtTdWZoZjdxWWpLWExENzNXQ2pjSTBKL0dGeENSNlI3a2xVVE1i?=
 =?utf-8?B?SWVPdVRER05icktmWGxtNmZDK0lRU2tRYVFEZDlDRW5rNUtCL0lBQnF5dEdv?=
 =?utf-8?B?d1FMUzNQM1dFckZpWmRNNHBxNi9OSHk3bmlXNStaei9xWEk0bmRaNlFVc3V1?=
 =?utf-8?B?cWZQVXJjRDFKNlRkbFRvY3lnM2NtOVIwK212VzRTS1MyWlIvbzV6TStZT01D?=
 =?utf-8?B?NWtTU0loakIxQTZ6b1dHTnVyK002TlRUT3ZpMkZpUXRUMkl0SzF3RWtlZjR6?=
 =?utf-8?B?VWJjZGV3bll0UUVpdDVMYzhpNFBTRmVSUEsyUlpXaEVtbkdJamRRQ0sreVFV?=
 =?utf-8?B?bllzc3oxZlg1V2xMQXZsakN4OEZsOVJRblhqd1o1VnFIRjJtMlVuU2tjd2d0?=
 =?utf-8?B?YzZkOUtRUXlhbVhsUDlrMFpPR3lIb09GM0pDRndKTlBjUUNrQVBZeS9ZakxJ?=
 =?utf-8?B?WnE5UmVKK2J4SlpRUE5adldUM2Vvbys4ekpPMVQwUTVQVm1EUEw5WWY3c3pP?=
 =?utf-8?B?VTF3VndHckFIazhsSzdjYTE1cmU1WCtpejRXN2lkaVZRMGpmU05iYkJ6ekVF?=
 =?utf-8?B?L3l0b3pRWEtLa1UxREtVdDFnbEduZ3ExNHNSTmFJTnlVSFNIMXJOcTl5a1ZC?=
 =?utf-8?B?UDRwUW9uc1Y0ekRaSVBDVkRja1lGdU9qOUh6cWJhdkpYeGhLTjJYOWJobHFw?=
 =?utf-8?B?OE90bFFyc3JsbTB5SXZGUHlrK1kxMmVDaWM2UTlINlhpRWtrQm5ucTB3akl3?=
 =?utf-8?B?SytKaG1YQmhVZE5KQTk5djFlNVViSU1Xalk1MWFlZzhXNEhVVE5aRmVPcEhr?=
 =?utf-8?B?ODBNcUJXK3IrNmhjdnk4QVdpbzhRaDRRNjducjJINkdHUHdxUGdHSERhM0dm?=
 =?utf-8?B?TFpPRFdCUmQ2bEd6UzliUkR5ZjlFL3Mya2RadjdDcy9Xb2VPSUc4aCtnZ0I0?=
 =?utf-8?B?YkxyeHV2eUZaeG81d2ZFczFKYXZpTHNNZWVLN0N3M2kxWEZyQXl5RVc2bnhG?=
 =?utf-8?B?dFFRbHB6MjI2eFVIdW9DQlVPVTNuaFR1VVBiVXlvUTBrZ1V0c3cybjVBQldM?=
 =?utf-8?B?M1JPUC9sT25uczdIODFEVXRLT0M3bDVjaDBQMGgxMG5OTzJnRUlOUGFIN0hG?=
 =?utf-8?B?OWVjblZnTFM1ZzdoMldlZVZQTHpDeG5Jd0hpUG1CYy8yWkpvSXBYZElOdHZw?=
 =?utf-8?B?YTUyT2JBVTZvTTRZb1UwT0E3RUtqM2xGTDFDY20xaERYLzNOQ2xiNS9BNmx2?=
 =?utf-8?B?b3VNV2ZTcmM5b1ljUVdXZU1XWSsxR2txZWhoaCs5enl0Vk8rSDd6RmsvdVVZ?=
 =?utf-8?B?cVBoZ1MvWWxHdHNpK3h3aUxjZnVKNHdhOHgwaHpzSlJnUDNRTEZWeE1lTkNv?=
 =?utf-8?B?Qlh1djBqU0hNc1BSWGExTW5CMFFaQytPZUx4NXFmcTF2MVFXOGQwMGZsbHdT?=
 =?utf-8?B?SzFBOXozVnVUQS9ZK1lLOTl5WnUrTzAyaFdGSjdDWFBBbFRhdmpjRFpxRUY0?=
 =?utf-8?B?QkFBZEMyTGRLOXhXTWNqSk9vRG5NZE1qdXNDRklleXdnaTdzZUFSSC9NQllm?=
 =?utf-8?B?VWxEYWtOekxmemdhY0NvdFhFbzJSZ1pSU1NIVEFobWpnakNscjRWK215ZTFV?=
 =?utf-8?B?YjlkditXVlE5MlpVRlovclpoR0xyekx0YmNMWm4zbXFXc0djUTJNOEVOUkZ5?=
 =?utf-8?B?b3RCeVR3MDJhcW1OTVVvQjgwNTFVck1wU0JMZFZscG83Qm0zV0NmWGd0OUFZ?=
 =?utf-8?B?Z2ZlUFJTVVp3KzI4RC8xYXBReXJ5WVVIQ2Z2ckFHbUpnaUtjMnpYSjZjYXpH?=
 =?utf-8?Q?mMlMKQrb4vC8jztEGNukb5Q2T?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5f95de7-cd11-4d86-ed80-08db5ffa2227
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2023 04:06:52.9495
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IBlCeJB2usxrurnD+hYFgKe1/Fu5u2vz8w6prze/pkUKsVlafE9gKsCpfsN2ofN5SISf0T/GpCJfeIdozr283w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8345
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16-May-23 8:15 AM, Ravi Bangoria wrote:
> On 10-Apr-23 7:53 AM, Ravi Bangoria wrote:
>> On 08-Apr-23 3:14 AM, Namhyung Kim wrote:
>>> Hi Ravi,
>>>
>>> On Fri, Apr 7, 2023 at 4:25 AM Ravi Bangoria <ravi.bangoria@amd.com> wrote:
>>>>
>>>> Kernel IBS driver wasn't using new PERF_MEM_* APIs due to some of its
>>>> limitations. Mainly:
>>>>
>>>> 1. mem_lvl_num doesn't allow setting multiple sources whereas old API
>>>>    allows it. Setting multiple data sources is useful because IBS on
>>>>    pre-zen4 uarch doesn't provide fine granular DataSrc details (there
>>>>    is only one such DataSrc(2h) though).
>>>> 2. perf mem sorting logic (sort__lvl_cmp()) ignores mem_lvl_num. perf
>>>>    c2c (c2c_decode_stats()) does not use mem_lvl_num at all. perf mem
>>>>    prints mem_lvl and mem_lvl_num both if both are set, which is ugly.
>>>>
>>>> Set mem_lvl_num, mem_remote and mem_hops for data_src via IBS. Handle
>>>> first issue using mem_lvl_num = ANY_CACHE | HOPS_0. In addition to
>>>> setting new API fields, convert all individual field assignments to
>>>> compile time wrapper macros built using PERF_MEM_S(). Also convert
>>>> DataSrc conditional code to array lookups.
>>>>
>>>> Interpretation of perf_mem_data_src by perf_mem__lvl_scnprintf() was
>>>> non-intuitive. Make it sane.
>>>
>>> Looks good, but I think you need to split kernel and user patches.
>>
>> Patch #1 to #3 are kernel changes. Patch #4 to #9 are userspace changes.
>> Arnaldo, Peter, please let me know if you wants to split the series and
>> resend.
> 
> Hi Peter, tools/ patches are already upstream. Can you please pick up
> kernel changes.

Gentle ping, Peter!

Thanks,
Ravi
