Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3434C622290
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 04:26:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbiKID0B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 22:26:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbiKIDZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 22:25:57 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42FAE192AD;
        Tue,  8 Nov 2022 19:25:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667964355; x=1699500355;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=np72QuD2aQVLd37R2Ad/q1YqAUsv3mUfXdk92iAO4yw=;
  b=dGwvLpT6fQs3bJ+yeXJAZTr0zkplIWFUVeTZvwCa4saST+rZ/ZZYyx70
   NbFWVD0QCX0NnxaIBA2sU0R/sJj/3J9Tv+/TtwEbxG5oL+pndlIM+GTUP
   +DIRlPqc8ySMN2Z11nZYI/uIysDv5gNEzN7PDcY0jaKo4K9Tm1Up5/1Ym
   6B2/YCmpCXkfhmrbCKccpjdjott29c4g14chcnAlUCpxla3VVOp0/h1/8
   PmJweOS3iTpEoEzjY36KRXI+HGiH94Djq+HqJDtsnqo0rt46G0DbaQyS0
   PNXEw9CzEIkcv1Fmy3cEqpdtVG+Ahdm+0Agn5ldx2QT5TPHeUfZOkhrQe
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="337607235"
X-IronPort-AV: E=Sophos;i="5.96,149,1665471600"; 
   d="scan'208";a="337607235"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 19:25:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="614519133"
X-IronPort-AV: E=Sophos;i="5.96,149,1665471600"; 
   d="scan'208";a="614519133"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga006.jf.intel.com with ESMTP; 08 Nov 2022 19:25:54 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 8 Nov 2022 19:25:54 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 8 Nov 2022 19:25:53 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 8 Nov 2022 19:25:53 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 8 Nov 2022 19:25:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NcqmVPNyYBrLLvbQMieFVjmG2Ng7Tp05DnaI1HeVhx/+Q2xypuAXN3dAevFCHjAvOciIWeHj0iH7/lTDODHK5N5K1WNnwJXB4bDUAuFVV3E17wWHTIZsk2UcMTWk438LQBn24SoYVk7rT9bm2mcfF2//NLFb8uUNo/XDS0NYvmLKgl5fTPxhY9iWSOElLUu28HULMYC4czNXG9PGLxrfmAA6F1mQeeJnJ8Tz8k3rsSYGsCwOLpHtZx0sjeY2HSrzuhgjIO08y2JadeYe+7xiSawx08x4aOl7qoIG2W3sHgSzw/XjRQQZQg6Y5e5N9s718GM96QIosz2HLV32lds2kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=19VwoC+cDSO9Nmel70C/1Kqc7Zd/Rwp1kMPnYptPG4w=;
 b=LM32FZa1e06bUlgAsKP7KSW0WMxGIRIyYjjSajOAL/1jEUpz3SNKylIDn87GnEtKMoQch3AR6UNXhP9LOquFq6AZnZ++rYG6uN+cvX2Rn07C//DYh49WVmpVGIdTlIxnImII9Wyu5BUWBowJFqKMMOR409+BZPLKurQxlmrAcIKP1hLX/zROLvhyOxvSAZPSfbF6/LT2A0K1mkvfGMM15+a2/qtf1xcYdrPiJhvxLDd3O28GcWJbpcflJIAMgoV3whfvJjeAIM2zFea2O8Vv1DbsCA/isUHNBQidK1aGTdsHu0s8o/CTIGUcdBQvhsYV+2gkfl0cchctoZ/r0bSdTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by DM4PR11MB6528.namprd11.prod.outlook.com (2603:10b6:8:8f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Wed, 9 Nov
 2022 03:25:46 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e475:190a:6680:232]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e475:190a:6680:232%7]) with mapi id 15.20.5791.027; Wed, 9 Nov 2022
 03:25:46 +0000
Message-ID: <0a73766a-893c-3336-9043-a813b80de6a5@intel.com>
Date:   Tue, 8 Nov 2022 19:25:44 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v2 08/14] platform/x86/intel/ifs: Add metadata support
Content-Language: en-US
To:     Jithu Joseph <jithu.joseph@intel.com>, <hdegoede@redhat.com>,
        <markgross@kernel.org>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <gregkh@linuxfoundation.org>, <ashok.raj@intel.com>,
        <tony.luck@intel.com>, <linux-kernel@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>, <patches@lists.linux.dev>,
        <ravi.v.shankar@intel.com>, <thiago.macieira@intel.com>,
        <athenas.jimenez.gonzalez@intel.com>
References: <20221021203413.1220137-1-jithu.joseph@intel.com>
 <20221107225323.2733518-1-jithu.joseph@intel.com>
 <20221107225323.2733518-9-jithu.joseph@intel.com>
From:   Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20221107225323.2733518-9-jithu.joseph@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR04CA0029.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::39) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|DM4PR11MB6528:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d4cecba-64fe-454b-0e12-08dac20216f9
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZYn7Lc77dxyNPiHQ8aTriewAwelhnIcF9MFQZuaNmvjesW7hHUtrTNTjLNZm6ILavUbFfspBms7QwK3y4ourWqOWhWpTI+m9gYNUqG49/JIfBWJSl/cdEAGrG3/N200YtYMwsr/GLT6lbzuX29bJw7RtyEylrqNblRZcgnNZC4BQxTL+DQPY4BdEiMfjXoS+f1rfi6NxB1inJ/Ed8ZciWb34hP9xYeK18Zj+1liHtg08tF827tr1eJIx1IXEm3BGj/H9A8Ty570U1hcOaUSMmOLWt94s1OZl5ukWoGH45HzJ7nm2iCaSjwulLuLFq0z1/8WQxx2eJGL3et3ss0ulR/p1WOxSUcBQXyHIRM0jT9J6B4nkFJ4+Ey6XQB22gc2/ax8HisXZiyopbLYdrbG7W6ek7hwOljyaeWLCra2bVeg727TYMjnBx1vC4r5ICuOB5/2ZJYxyOxLcoS9HDTR+Ef2eWsKwSwe6zsXNK4C75S+4jNpYQZOCm2w/ApIcdZb6yxWRbC+mqIC6nOsYw6pHhIjTW5u+M591b8dFNBUbc4x3f0sqJGU7RtrbXrNzMu6rJOSkdSaBB97qkf8WIKiq2/J34azdvw9sPS6aQTm7rbn47g/8IKltt+UJ92kPgmQ1LfajgIbN62+N1n3FRyTsHow7mJ0NBl/zdLv900dNq2xr0Dz7HTKxRIsyqaRC6xA1yqBxxwYRjOxwMJtqM0RFDXsp0rPe1+/4je39uvRF/MmGUJTqZtdp4scOYFZwLCOXHdTH7Q4yMYoE8jWVFJPnBC/KznDNvG5ynoFWAbAlTyk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(396003)(366004)(136003)(346002)(39860400002)(451199015)(6512007)(26005)(6506007)(53546011)(2616005)(2906002)(186003)(6486002)(478600001)(82960400001)(38100700002)(41300700001)(4744005)(8936002)(31696002)(5660300002)(7416002)(44832011)(86362001)(316002)(66556008)(4326008)(66476007)(8676002)(66946007)(36756003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VFdBN25MOG9lRHNkMDU0L2IrL1dGREU4MWFiMDhuU1lVdUZpOEZqalVIM0V0?=
 =?utf-8?B?L0lMY1BSTVVUQW5DOG5OUTVUQVlYWnVMRVE2bXF6RU5DN0xCeDU4WTNoeGFk?=
 =?utf-8?B?cDJmd1hGdDlnVkl6elhORGZ6MWNkQ1pMdndkYUw5VmQvbDFzbmdRdUw2V3B5?=
 =?utf-8?B?ZkFMZTUzQ0FXTGNkVDRuZUJuZTVmeUpwV1BuNjN3c3NTcVlQSU1IbnFWU1JB?=
 =?utf-8?B?SDh2RzBUL2ZrMlNxTGFJUVFycUlvTTNtaC85dEJrZm9TR2h2S0drc2pGRlY5?=
 =?utf-8?B?RjJpNXBSN25Oa1BJd2FnUCs4NUtVY2U0TGt5ZHN4SXNZajRObmYvV0pBbkxJ?=
 =?utf-8?B?VlNsYVIxY0Q5a3pvaU44MThjTUJ4OGRBVkFCdFVjMEdkTStGK2tUMFN3Z0xW?=
 =?utf-8?B?UjhKMDBMR1FtcGJlUXMvc3hiZG05ZmNONUhTRGVGd2tDMWdxZjlncHJrVWpG?=
 =?utf-8?B?OGMxSjdXV0RxSVgxTFM0Q1VDNFNUY1ErTXp4VGFuM1VkWWhtamc1cWJYQ2w5?=
 =?utf-8?B?dVp1Um01SENqSTFhYjQrVE9ZZ202WU9tTEgxajJXUmxmY2dDTUZpTUxqa0pw?=
 =?utf-8?B?cks2NjU3UjVUZElCdm9JTFcrOGN1bThyMW9RYS96VCtyWnErQ0NlQUlYRWI1?=
 =?utf-8?B?d2YvVnhjcll0NHdYUmwrTnBIYW12L0Z6RGszRjBEaW9yTVFtRG5mYUlPYXRp?=
 =?utf-8?B?RFpLWWhBL0ZBQi9ZcnJ5dHhHSmNRMU5ET3dRUld2NTZtMWJQZEVEVTdZWlFl?=
 =?utf-8?B?c2JGZFMyUkFpZ1orSXRrQmpoUVVtSTk4RmRVeUpRWHluVm9QQVJaYUlGdEtI?=
 =?utf-8?B?aDBuaGZJeFNyZkU4NS90UGkyZTBYZUJ3b0ZBbUJ0UVhScWd4MEVSSmNIem9V?=
 =?utf-8?B?L0I1c1Jqejh4TGU5YVFoRDdLSlNWOXZ3cVFMR2FXMDc3dnB0dWs0a3JTK0Nv?=
 =?utf-8?B?d1ljMWc4TmV6dHZYLzdyNjRENStxRG9EU3BRSnJnY0UvTjZuRnBCMWl1VVlF?=
 =?utf-8?B?eHFGQ1BEK1pqbXR6REJNU25WTlo2dVV6aVJvWU43dGdnZDU1cW9hTWxvNU5C?=
 =?utf-8?B?UjR3OGpNd1lab2ZqdjVFVzd6cXpuWjgzWVpwVCtYVDhJanFUMFdVNkdqQTVJ?=
 =?utf-8?B?UERaOC9melN2bkMzbkZKdXNZTDBvMDNPYlUreURSZy9pWHF3TE9rM3RjYmJM?=
 =?utf-8?B?RWxMNG1NRzMrMHcyaU5ubmhTRXVxaEVpRkdKTFU3Z1ZjQ1I5Znl4ZzA0eGI4?=
 =?utf-8?B?UHhWSEJ2OFhwaDB6MmROUWZ3WFpVdUhadlgyZ1U4eExlQU5Hclh4aDhhTGJ0?=
 =?utf-8?B?MWNZSjVLc0gzbDgxdUZ2QTlIWmFqa1p3OFU2YUhrWWo4ZTBLS1BleUVvejln?=
 =?utf-8?B?UStMZFh2VGNyaDU5RGxZN0JPSlNTS2d6RlFhdDJIQVBFc044MVhuWS9iY1lX?=
 =?utf-8?B?QWtpdmFWK1NGcms3aUUrSUpWclRGNldhOVNwWjQ5K28xRUNRTm4wZEV6N2w1?=
 =?utf-8?B?WmgxWG1sMmQ5RmJ0S3AyaFZHdGUrSmhydU1vMmp4MEZaalpFeTV1N3dNUXdr?=
 =?utf-8?B?QWlpNWYwZEdPVUdROWFTRmtiNERDV3BnYkFmUGIwNlNyUEZsbENWdUxzOVdZ?=
 =?utf-8?B?QXRpdFg5Qmw2MitKaThSM2t5cTJ6WlllWjcydlFoTm1DVTduSWFlWmcyT3Fk?=
 =?utf-8?B?WkFmdWJodSthZmtTTWhWNUlIOTVtVDIrWVM0akdMNytnRXg5d2huRzVTUGdl?=
 =?utf-8?B?YlBLRTQ3ZGdYSUtGUEhuYzZRTkhkbDhudVl0Sll1RkxVQ0lmUmRUcEdXSTNP?=
 =?utf-8?B?WHRJMG8rRmN2OXQxaklvSW1xVWFRdkM2eVpwQmRSNmhLRHNrYjE0V280WFdB?=
 =?utf-8?B?WU1RRXRjcXJXdThjQVd0dUUvczczNUtMWE9aT1dkQmxRaSt5RnVlK3ZSMHlQ?=
 =?utf-8?B?WHlCb3N3aXpOZkcwK1F6WXhGSS9tQW5TS2RUa3JOVE80Mk5NeWFaQnRkcUs2?=
 =?utf-8?B?OWZNYkVGMGI4NlBUL3hTaFNCM2pXNVJVS1ZpbkIxRHAzdUc2eEdzTWxSaGxG?=
 =?utf-8?B?QldUU05seU9pMEV0Q2VkNEU5aVhQZmtFK0NBTGprMlJnT3UzcDhmQ2x3Ry9O?=
 =?utf-8?B?QWZHZG44TGJoWGxPRGRoYmlRS2E2ZFhoQiszaDhyaXJEWEl3bkhjaWErYWt2?=
 =?utf-8?B?Znc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d4cecba-64fe-454b-0e12-08dac20216f9
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2022 03:25:45.9521
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4JmgEMAqBMOs2A6Qxwq9MEJwWX8uxBkidxioHr6DQirazKkMKfmTckpjTkDhLdMurQk/B0XstuZiePEwYJvLEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6528
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/7/2022 2:53 PM, Jithu Joseph wrote:
> In subsequent patches, IFS test image file (which reuse microcode header

s/In subsequent patches/Upcoming

s/reuse/reuses

> format) will make use of metadata section.
> 
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Signed-off-by: Ashok Raj <ashok.raj@intel.com>
> Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>

Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>
