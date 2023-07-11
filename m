Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5969D74FA29
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 23:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231454AbjGKVzQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 17:55:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbjGKVzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 17:55:14 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB7BBCF;
        Tue, 11 Jul 2023 14:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689112513; x=1720648513;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=D/Ts5nrpq8GBNM3LDRZFnXa/W1BY3y3nZe/BxlIz/+I=;
  b=Cgc/0agpe+6TUdEjwyNwEF1/6VZmCNDMl3Yy8dxmf3E+9YvTRKXOqqr+
   1YLsaqVIsk4WPblorWafp36NAWb0KHF0uoHv693j5I/WFQ0kRrBpdERpX
   BDiWJkXege8VMLrahuQuMYo8Y19GQJMEKLR5LH9o1DNIzz7S2eVsWqOCi
   BUVBXe8DASz0S+2V3XoVUhXwcLUkzzZPUGCq6m7SOZ7xpeKEUCEAD0h9X
   ab6PRbemLQADXdriEW9ELC6HMK6qqHyNpdoa6LgVja9yzWxdzASDAw0NV
   AiF+73gx3ZC1BnQKOLui9OBpzUYdDprjceJiXHd1muk0qUsxG+SzqDtIs
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="451107700"
X-IronPort-AV: E=Sophos;i="6.01,197,1684825200"; 
   d="scan'208";a="451107700"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2023 14:55:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="1051949602"
X-IronPort-AV: E=Sophos;i="6.01,197,1684825200"; 
   d="scan'208";a="1051949602"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga005.fm.intel.com with ESMTP; 11 Jul 2023 14:55:12 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 11 Jul 2023 14:55:12 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 11 Jul 2023 14:55:11 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 11 Jul 2023 14:55:11 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.175)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 11 Jul 2023 14:55:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XtiBObMDnUYVdizw4dr8pgOLnvlQJypg73Qq0ZQefDBIGqYhNkbgS2y0tt93wsKxJIjMRFyHrdLc3LqXIv61M35cFtWipglGGKtMmk55S1axhKuiDspi6qAI/OESz1eb5CAaRpTxE38XWFZTdvIjdWt84dzTObqfq+uWU2TWnvbK1ThVG07eEtOWf7rn5EFZ+vnOVAA8kauSJ0npfU2ykmOw+I8/ptFlb0Zk2J5N4kRJHIMriAd+hnf6rnE93LkROqdl5B5ijertIPf5yy7kyk5VfaaanTii0gzylB34OxpLb9dLvqsbmVq+281EtxfPZDB5U393YCYPbdIrpFDZKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XV/mNE1p5Nn5GLuwCt2bqfpT/JgBZtPtcc/KxEfy5nE=;
 b=UpQROAGVEg+G2tj/K3iJg/YuBO8Qh+XeV1y4oP9RQaf9dcndxhb3ycOU+QKBiCF5WeYy83RNKLrl8YFR1ybS0YWJdRGXbYZ8BTX9vNq0xaWPdXpxTmu12CK0Zq0Z3bpqbESn3bR9p3jVSLh3QBn5xbVdfAz8+S9d3PLES5+MLSDWF/YcS5rzHQDkrlO79l5xAWdgiW1AMki5v792zzU7cekICO0Qsr57TwK5EEBR0dEZl108ON8c3Azc07lIGSxXEvYVByE3FBOhF7UzVdinoa/kJgJLYoj9dUSl9dCYxcVU5jc4JF1lpsY5JZHe2Wn/KNGyK1q6l6Hc3af18P/Zfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA1PR11MB6968.namprd11.prod.outlook.com (2603:10b6:806:2be::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Tue, 11 Jul
 2023 21:55:06 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::3b1a:8ccf:e7e4:e9fa]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::3b1a:8ccf:e7e4:e9fa%4]) with mapi id 15.20.6565.028; Tue, 11 Jul 2023
 21:55:06 +0000
Message-ID: <50b1402a-7b3b-d775-5cbc-ca25cf821ae9@intel.com>
Date:   Tue, 11 Jul 2023 14:55:03 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH v2 0/7] x86/resctrl: Add support for Sub-NUMA cluster
 (SNC) systems
Content-Language: en-US
To:     Tony Luck <tony.luck@intel.com>
CC:     "Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Peter Newman <peternewman@google.com>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "x86@kernel.org" <x86@kernel.org>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Babu Moger <babu.moger@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
References: <20230621174006.42533-1-tony.luck@intel.com>
 <TYAPR01MB6330B9B17686EF426D2C3F308B25A@TYAPR01MB6330.jpnprd01.prod.outlook.com>
 <SJ1PR11MB608331B7F85320DD4CD93448FC25A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <30b63f35-1839-6870-d81b-1e8bff88dc70@intel.com>
 <ZK3IQj6+eVAeaNY1@agluck-desk3>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <ZK3IQj6+eVAeaNY1@agluck-desk3>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0253.namprd04.prod.outlook.com
 (2603:10b6:303:88::18) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA1PR11MB6968:EE_
X-MS-Office365-Filtering-Correlation-Id: d672f014-4b45-4e80-f1fc-08db82597cda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n6cnIqqiMAmo/sRr44qvCgUC/DZo1zAtRAY+Ug+K/RH6FKn+FnS52k51hjYndN0aVIXvHcZZDDXhLL2/PAtOKrIy61180lJtwWwQhqz5i88mf1nXLxEfUns5BRvcen9Vip7uy6XNGitMM/6dJW4zsPTOX6iENZa7H29S/UfO+I+0S9oGN1Q1paKbrNejbfSA2QRiDkfocHCfpL4Pq12XV40nvrgqkBIeDtZTSp1PPMBgS4JVBNm53cIAjsAlWMWWgi2n5gOsVjZk1VhFWg67JQwqhONi66pgtSsEsB2QH+C7UGGVopK2swojEn5CDecpW6OfWvQlWzrTMHC9/OE+RgDj2AG6Povd1YQMGq9QiNgzUFQGIetdjFfX5g4RpY5fPt32LUOH8fBT9tmw191XX0VAfL2EHGhq2b4KeEb8xc4wvJN0m8xNSBGwOjqvvQrKnk3Au6zT4VwBaLw4ur+u6+CHaQ+wxT1TnAhWkx9TOvQpFNjGZZLK4VAGCpFPNtigDOoUhADxMCJIkcupuiLLtNcFpmeHHK38aenT0vqVQ94guJXnN2QbtlpaswW4Oxh8wctEK7LafzjWslx909WXC+BQhTU+6DWi8VmhuqbkgpxKY2aymTlzZQaYVMLu7pIXZ9D7zhEcK/PKTiKb6F/AGg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(136003)(396003)(346002)(366004)(376002)(451199021)(186003)(6506007)(2616005)(6512007)(53546011)(478600001)(26005)(83380400001)(6636002)(41300700001)(44832011)(4326008)(5660300002)(66556008)(2906002)(7416002)(316002)(6862004)(8676002)(8936002)(66946007)(66476007)(6486002)(6666004)(54906003)(37006003)(36756003)(82960400001)(38100700002)(86362001)(31696002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dU8zV1hCcis5cEJnRjZPYXplQWt5U2Y3RFFTdHBrckFTUEUwTjd0d040enZL?=
 =?utf-8?B?VENQR0g3QVpWRGR1eG5aaXBmQWZrVk8vV2tISUxiVUFpdUZKWWRRanp6RjE3?=
 =?utf-8?B?UXJtalZoT0s0L3Nid3RIZ2lMVjN6Q2VkNzJ0RlpPVitNUWExYkN3V0RIVjhQ?=
 =?utf-8?B?aGpqOW95YkdyRlJZNnRkcjVlbHJBTk5hb3MrZSttcHFuUnByc3drRVltdUMx?=
 =?utf-8?B?bnMxVC9oSlpmbGI0TkRzUE41NGlMdG5BTzByZEZjUUkzTXFNZDZDYytNYlZS?=
 =?utf-8?B?ZE56NlJJMi9qNVFiQ2NldTIwTEtQRE9mUGx3NGVRTG1XemNyUmpSNWZ5SmZp?=
 =?utf-8?B?ZHlDd3ZleHhmbEpTM0xGY0kvR0NjM1JtWkVCVU54eTdmakpGdTRkZFVHajVw?=
 =?utf-8?B?R3pneGY1Qks4MmVVODVycUVQYjI0dm51a1J5OG1NdDIwVnhjT3pSR0ZtVk95?=
 =?utf-8?B?WjAybVhSYWV2czlJZnMwc2FZMVJxWFZlWHdIa0FOeXNwVGJjZUdXeGM5S2lx?=
 =?utf-8?B?bmJxTUNoMGZOWlkwR3pOeXFCUG1obTJTNGxNa2pTL2VaSXN0cjBsUXF6dWdT?=
 =?utf-8?B?MVpFRDgrUExvbzhlYnhrUVM1c0ZZNm5UdjlIalQxN1ZVYks4Y3lpT0pGcEpR?=
 =?utf-8?B?cE0zZDFWeXR0Z0FnMGhYaW94TGoyZmc4a1lsRVNGeGVmbm1PUmtpZ0gzQkQ0?=
 =?utf-8?B?OVA5VmRJckxMa3RVOTAxM0xKS2hjUnRyajY3bi8rQ0dJMmhybXFLRFBmQy9E?=
 =?utf-8?B?eExzeU1HRnljZGs5b3RuV1ZoOGJLZk1VZ3gzRkNzTHJ5K3dmZmVkZjh6R1lT?=
 =?utf-8?B?QlZCQ3lWeVpuVTIrbUdLdjczdjhXWEdJUjEyUDgxRVhmaTF6TVdCeVcvOTBL?=
 =?utf-8?B?dUd6anFnaWFSTmtUaUQzRndJZlRUOUE4MGZ2YWlpYnpYc1N5VUprejZyaHNC?=
 =?utf-8?B?WWI5dzZTN3A2dG5QaWlvTkZjL0ZQNUw4SWpTTkptRThjTWozUnlyY3BCdkdN?=
 =?utf-8?B?cHJCVGRXek9KbnU4RmJUVXYxNnJibmMyUG1ycTlQR0pqZW8vY1hPWDJQUXdj?=
 =?utf-8?B?T21RZElVcFVGYjV3Q2JlcUVvLzNaem9FVHFtNjVKWDN6aHZFRk93YVhuc2VR?=
 =?utf-8?B?MHVpcEpUYlNMVG1sd1RNU3RDMUc4TGNVSWtpMGZ2b3lBOGt5ajV0aldKZUox?=
 =?utf-8?B?aldTMzBueitxRndBY2NhZjVGZzhDdkdmbnRqMFFkQWlCL1dUazFmeW5VZGtr?=
 =?utf-8?B?QjdqbVQvNnhpb1BZM2hZaEJ5S3FxWWtaZEtUVTlVN0pRWWRBekNpdThBaGph?=
 =?utf-8?B?MzMrUWN2U0FMWUFJdHVBUkpHZ0dtYzdaQ1M0REp5L3JZS3dFUGVaMGlHMnh3?=
 =?utf-8?B?THRSOTJ1d0czc096MWFmd0NCSlVPSkFuUW9xLzRyb1JoR3g5ODZrZXRpT0xu?=
 =?utf-8?B?MGRLbGVoUDFCdzVoZzZ1b0pBZGg1cHRvMXlJSlpRUVlzRmRjYXkxMlUyTVFV?=
 =?utf-8?B?LytvaG53NVd4L3gzSjU5d0xRcWdWbUU4Q25CZGw1aTdiMGVJdE95WFQxVnlk?=
 =?utf-8?B?SzFsbEptRHUzYTNhWGZlVnVTZUU0WU9ZQWR2THpaWDY2TzVCanJrR3JQWllr?=
 =?utf-8?B?OFZDUER0YldRRnd5K2F4L01WMmtNakZuQjZHMWlVT1B3akZHTGx1REhGdFAy?=
 =?utf-8?B?S3puWE5ZamFmMFVQblRmbTBGTEtPaTdBUFFwbWl1WU9YcmU3SWdiRkhBWUQ1?=
 =?utf-8?B?RW15QWVEdlhNYmVhQ2UzOWExWDlOOHMxV1BUZkZ3L21hb1NaT3pIbStMeElF?=
 =?utf-8?B?Y1BpS0Rlekc5QWZNQy9nYmlEeHlpdkZxSnQraXdtSUxEU0UyTTRnWFJ4TUkv?=
 =?utf-8?B?NzBXSnFRZjV0MlkrVEVyRFY2NHpwSTM3VkVTWDhRSmFmdTZ5UUFjMlBWMUt2?=
 =?utf-8?B?UFoxNVV0V0ZBUWxpdTkzQ3hoTlh6bWxKSklEWnJvb2JFWDRvM2NZVTNWM1Yw?=
 =?utf-8?B?RlpmaldYQzFIdWF2WFBPY09TYzk4QytXOFg5OEgzeEU4ZHp4SGE5ME9WUW1a?=
 =?utf-8?B?ZWlML3JYTUJkYzBERXVRZXFMbDY5SFFNdzRVVGQxYmJibmRJdlFJaUVzL1Nl?=
 =?utf-8?B?NHByd0txc0lheHlFUW92Nk5PSzk1MTRVZDhPOFpyUnFnUVpMczAxUnBxZnlF?=
 =?utf-8?B?ZHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d672f014-4b45-4e80-f1fc-08db82597cda
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2023 21:55:06.3226
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qJrk9A9hlFFFEGgBQcJRF3RTAabOrOvE3FVcC/7+5QZ7fSfEBPtWUr2GoMYLvDOTMIQw8Gfz3Cf9z+ahKdK1M92sDL6rG9Qot64mkRw5qm0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6968
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

On 7/11/2023 2:23 PM, Tony Luck wrote:
> On Tue, Jul 11, 2023 at 01:50:02PM -0700, Reinette Chatre wrote:
>> Hi Tony,
>>> This is expected. When SNC is enabled, CAT still supports the same number of
>>> bits in the allocation cache mask. But each bit represents half as much cache.
>>>
>>> Think of the cache as a 2-D matrix with the cache-ways (bits in the CAT mask)
>>> as the columns, and the rows are the hashed index of the physical address.
>>> When SNC is turned on the hash function for physical addresses from one
>>> of the SNC number nodes will only pick half of those rows (and the other
>>> SNC node gets the other half of the rows).
>>
>> If a test is expected to fail in a particular scenario then I think
>> the test failure should be communicated as a "pass". If not this will 
>> reduce confidence in accuracy of tests. Even so, from the description
>> it sounds as though this test can be made more accurate to indeed pass
>> in the scenario when SNC is enabled?
> 
> Hi Reinette,
> 
> Yes. This could be done. The resctrl tests would need to determine
> if SNC mode is enabled. But I think that is possible by comparing
> output of sysfs files. E.g. with SNC disabled the lists of cpus for a node
> and a CPU on that node will match like this:
> 
> $ cat /sys/devices/system/node/node0/cpulist
> 0-35,72-107
> $ cat /sys/devices/system/cpu/cpu0/cache/index3/shared_cpu_list
> 0-35,72-107
> 
> but with SNC enabled, the CPUs sharing a cache will be divided across
> two or four nodes.
> 
> It looks like the existing tests may print a warning. I see
> this code in:
> 
> tools/testing/selftests/resctrl/resctrl_tests.c
> 
> 123         res = cmt_resctrl_val(cpu_no, 5, benchmark_cmd);
> 124         ksft_test_result(!res, "CMT: test\n");
> 125         if ((get_vendor() == ARCH_INTEL) && res)
> 126                 ksft_print_msg("Intel CMT may be inaccurate when Sub-NUMA Clustering is enabled. Check BIOS configuration.\n");
> 
> but at first glance that warning doesn't appear to try and
> check if SNC was the actual problem.

Your first glance is accurate. This message was added after finding
tests fail on SNC systems but not finding the correct way to enumerate
whether SNC is enabled. At that time it was still recommended that
SNC not be enabled and thus test failures continued to be accurate.
This work changes that.

Reinette
