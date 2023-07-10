Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEA7574D222
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 11:50:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232050AbjGJJuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 05:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231976AbjGJJtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 05:49:10 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EF2B49EE
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 02:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688982254; x=1720518254;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xLQ5RRf1dtd6e0LsggSDMMm/SohvJB/8pRAdnzuTvJQ=;
  b=E3OBQ59y8RdTzVW/awA5XRrIzsGDy8+HJ08o5N4uh7GdbFH1MI64ZIKh
   +HYrvHFIjhHQqFkX2CWrn9uN7Ups3WY+cUyFJdDjj0hhcDwMGzgYoy1J+
   kLZ2M3YauWpDXuMFZo4PU+ayr+issuQvXTGf3uI2XpJtuq3z+NdvQ83Qn
   aaoPsDvI4Ii7cMa/vEXd6kgcMJtMcOMw1cBQVUMjHDzgQIE31YJLdnimo
   GjukMedjXZzTKFSqt/JSCEgveo/v1u4yKffOMSCA1wpeOMyFd/TNcfhBF
   LvX2rg4twAnWAM2zU3Lcs9l5IVyRjJo1RoKzUntAznMRGEpqolfx1uWAY
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10766"; a="450658715"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="450658715"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 02:44:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10766"; a="967369491"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="967369491"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga006.fm.intel.com with ESMTP; 10 Jul 2023 02:44:13 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 10 Jul 2023 02:44:13 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 10 Jul 2023 02:44:12 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 10 Jul 2023 02:44:12 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.49) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 10 Jul 2023 02:44:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DhqPJtqfPxXXYfB7Tu9iAI6ORs1EtZtCwgZNVy5AE/rs2j6BTdznXLXqlL0YJzBLgB/9Ra9PPIPkhq3hcas+pMZctuLAPKEKxUKJhWJghkbNWrkpCVgbEAlhcps0+msG8T3z3FvBSu5G5DKRdE+Op9zsDnMR76OXAPgkI2Jj+S/m767lZ0oEu5NSKQOHOczFP9EIZWZXQ2sFHZhNx3lj1Mj9jfZBj8ZQzfLHHeoQorpW/euKD0QOOZtIGFwpbHZ7FYXIg4/cJgAgW2zS4Xrll6q6A6rLZx6Fhklz/9p9i5/yJ9GAwA/ZnBn1nS/UvZRCdbppTQi28q08Yyvp1JaLxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kXFTvAaI0VkNPH5Og2naOFZMWjknXftJ9BYSykiix2A=;
 b=RjaCejCrqFqeK+0msBvkpWMKzvjTHHnsSSW9nIBmrfeuAyt/EK4shdfN5Nxluomod5wrmHt1IdqQvBRNEzjs3T39OY6aelqE3Lv7M51VixtWoDIjcdCR04iDV4w1IXsRZxemL2M45rqx80ri0nfLY/yiNjr8UBSUkwBOSID7V8qGwLn0IjrnlHhdCIODGGnGpwzl6636OHW5C4zbhu3GSm8B8L+ZTQeBunr48IxT3gfR0stWSQ02z1X7xPpkbUJhvir7RbTO04r0vvSbi9z0ZChJsoc2sa59fcSRZkzTUQ0VB6iZfDCvarfJNPJCQZ/4awB87vGSpZejH/uNlX3PUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by CH3PR11MB8155.namprd11.prod.outlook.com (2603:10b6:610:164::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31; Mon, 10 Jul
 2023 09:44:06 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::e6c7:a86d:68d6:f2f3]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::e6c7:a86d:68d6:f2f3%5]) with mapi id 15.20.6565.026; Mon, 10 Jul 2023
 09:44:06 +0000
Message-ID: <b598c796-7bec-5ac7-9e7e-9a8b5d9ecba2@intel.com>
Date:   Mon, 10 Jul 2023 17:43:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [RFC PATCH 0/3] support large folio for mlock
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <yuzhao@google.com>, <ryan.roberts@arm.com>, <shy828301@gmail.com>,
        <akpm@linux-foundation.org>
References: <20230707165221.4076590-1-fengwei.yin@intel.com>
 <ZKhK1Ic1KCdOLRYm@casper.infradead.org>
 <4bb39d6e-a324-0d85-7d44-8e8a37a1cfec@redhat.com>
 <ZKhiGLpIWi5Z2WnY@casper.infradead.org>
 <436cd29f-44a6-7636-5015-377051942137@intel.com>
 <ZKjfwYWh/n/LbTZv@casper.infradead.org>
 <676ce1b3-6c72-011e-3a4f-723945db3d31@intel.com>
 <04efd5eb-06c2-d449-8427-d7c30df962d1@redhat.com>
From:   "Yin, Fengwei" <fengwei.yin@intel.com>
In-Reply-To: <04efd5eb-06c2-d449-8427-d7c30df962d1@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0041.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::18) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|CH3PR11MB8155:EE_
X-MS-Office365-Filtering-Correlation-Id: d6aa7774-e8b5-4250-d40b-08db812a33a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kmN+tcc/oTo45oY5W+51vw7dMadsHnN3rw2KdXLcGzD7BRtZXcTGwC0NBtmmdBTzqIligiqzMCGDb7E5Ydp1a1elRJ7Z7jtf9hvPDydfvmXckxqx2yLDyNCqm1jk8f8Tg4VZPne64E8KsQOAPb+c+ZwVJrVb44otCW7BpT4P82sGQIu9CdJM+f+vfVPvr8K00CLj7TvjdAGrsl1b5/L3v8O0TSUtpbN/fLhGInWwz5/M8Rxb80LGlPxyJC/LhhU03ThepBqS8X9Q8aorvljhqyG0rBJZzxm3kWxe9Li5ddXuRZh6ZL4UjVS3jbss/vLoKe+z0AS66JXY3tJB7Gr9z0VIx1bVwY7C96j8vgeHdZEuz8advHEaSObtLLyfvVczvHT0ZU2AgrgSKY63v5xCGXLLnHEMqmRk/Tx0Pt/2p725Gsv/vzkhsgXFZ+eqloEVVVSmxyiFCdGNyG6VZnyL01qPgk2Yf8lvAbBeoIUWqh1fpmFrkfbutaJJVkUeFzaGMdH9Y0iAVaPV3L15mt0vQSwsnXfxxhWpo1DcGj1Z0HO447DstAr6sTbSzHddZlbrFZVfvug1ldl6MkLs6AFAdfRaWArxgtrm8Cuf7J1W/h2mjQdyOh6d8NhXvX8hlZ5EDWi4b13f3LaoBT4/XQi+Vg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(366004)(39860400002)(396003)(376002)(451199021)(31686004)(6486002)(478600001)(6666004)(110136005)(2616005)(83380400001)(36756003)(86362001)(31696002)(2906002)(66946007)(186003)(53546011)(6506007)(26005)(6512007)(38100700002)(82960400001)(8936002)(4326008)(66476007)(316002)(66556008)(41300700001)(8676002)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OHZ6TWtzTUpWdldpUWV3V3ZFaU1OK21YL2pQc2x4ZDV2cW91Q2VKejlXeGx1?=
 =?utf-8?B?dWs0dlcwcCtuS3NURzZhUWxVcXVPK0o3eG9tejNWQlowWDIrRDRIR3ZyR3k0?=
 =?utf-8?B?RTlwNVVyWGQ2OUNRdFZ0ZGhYdlZaV0pNZndTV1hHcEJtTHNGNU5JbXFXcmRh?=
 =?utf-8?B?ai83RlZVSXduM3JxWmR1Tk4xNlB3ZUdGYzl5eWJmMTVBSnZ6dEJ4QWkrZ2N1?=
 =?utf-8?B?bngraU1BRlh5YXNDbGtaQkhtdDlDZmNjclUyTnZ0cEQ1R2M4NmFOcFdOSzR5?=
 =?utf-8?B?bjlDWGh2RHVoZE1Wdlg5cHhBZUJ6T2dmbW8vTDNzZTlEQVl6NG15T3RVaHht?=
 =?utf-8?B?d05NaWVkd3lsS3Zqei8rZ2pKT3A4b3NCaDdCRDI4ZzZ1RmNZRFBnUzZRc0Rt?=
 =?utf-8?B?SSs2bDVvY1hWRm5DMXA5TmljL0diYWNaaU1XYlIxNVpZWUQ1bTVGVG50QVFU?=
 =?utf-8?B?ZzFjdTN3bEhtWTV0UHVaVHVhRzVSOVRCNElRdGdLVm9OZ1htK21LMVBUUHR0?=
 =?utf-8?B?eGFsMmkvRlphUktTcHB5c29PUUM5RXF3dWVpbU5PYVdpMEQwMFJUSmQ3bkxu?=
 =?utf-8?B?MkFZckNrQlFrK3ZoWFBxYkZld1dPSUJ4MUlaQjd2d2hSWTNUNzkyTVd3NGxZ?=
 =?utf-8?B?REdnU2w4L0hhY2hxeFU0VUJjVFdldllEOGtzam5OVGJYN0k3U1dGSStxRzZX?=
 =?utf-8?B?bXhaNkpEcERtTlFKZzJkMWIyQ00zRkdCbld5ZkhLNnN4MG9kbG1PVmpvMDc5?=
 =?utf-8?B?NE85M1N3aDhoQlhZclBxZ2x5V08rVjBRcjlJNXJZSC95SndJNysxM1M2WGJ6?=
 =?utf-8?B?RlJCUXA3cjgrSWhGTmlDa0s5K1A2NktUeGxCQU5DV0RYQk5vdHZFTlltdS9V?=
 =?utf-8?B?azJUeTVURlMzU2pmSGtVN1lwOFg3L09nVElvSjlUdkNtTVIzV0RHN3N0Qmd2?=
 =?utf-8?B?S1hxaXBjZzk3Z1pKekN3bEkvcG9EZHplT1ZJN0NYVnRnNDhPbUdXSysrKzVM?=
 =?utf-8?B?L2Q3MmxjakxqOUg1RkR4L3dkd2JlalhYK0lQdjk3dG9kVGE1Nkp3NW9OUTBD?=
 =?utf-8?B?K2pMdG9Wbzk2anJ5YmJ5OFVIc3lXRVl4MFRQSCtoT2RwMThGTDh2TUpVbklu?=
 =?utf-8?B?bGxPTVRJeURrbkRka3FTejZTUm9sd3Vud0J0MHRXQ2RlNUlxeGhSYTg0cUMv?=
 =?utf-8?B?SUc1ZElqeXBHbE1PS0hvWjFONlZlMHRiaW0vZVFMbGgzWHkyZitGb0M4VlpH?=
 =?utf-8?B?ZnlEZjB4QThyeGpGS051ZUI1MUs4RXBSSnFyTzdMSXZsakpNV1FiRU1tOGh2?=
 =?utf-8?B?bHRlNlRaMGVkRUppdEMvNU1tZ2M4Rk9ZZHBZVzVJQjNOT3RvUmxmUmZFYjA1?=
 =?utf-8?B?UHpKVDNxeXdZSHk1Q0F1T0hIVEg0ZFZadWxVR2pXRnlZSTVBdFlPVGtDNHh2?=
 =?utf-8?B?d2tJb3NEREo1TkRkZEVKZG44cVRlVVFNOEpFZ2QwRzZBVmpJR21kbzhFRDZU?=
 =?utf-8?B?SnJPSkhmeDZUM1d5M0g0dmt5MSswVTlkNTczZU1IbTdUUjVJS01INGpLcGw3?=
 =?utf-8?B?akZjemdyT1F0M3BWdGp6TnV1TXRkUjd2SmtUd28xbmRPTmYxVVJBZFVSMDBI?=
 =?utf-8?B?UHArd3I4ZTM4dGwrdjMvSjY3SnhDQjE5My95TUo4NCtETnNuZ0tZQnhnTFNF?=
 =?utf-8?B?Q2RoTFRYRUh2c0taL25oR002eE5QdGxTMGZNcDd5dmlBazdQMjRFZnpGVlhi?=
 =?utf-8?B?dFVZM0xuSXcySGg1K2xSMHVHa3UrbkpwL2hFeFF1TzhpdkdOa2djSXZBUmFF?=
 =?utf-8?B?NmovL2tpdk1DeXppSTRrMW1KUE1GalRYcGZjcmtKemJ5TGgrRTcxS0x6QWlv?=
 =?utf-8?B?Z3RUZXZ6dXBmZ3BicnZDbEljbEY2SzN4UkxyWTZtdDBOalh0RmUxekdjNjJK?=
 =?utf-8?B?VWtPbDJnQVMzRkt6bzJ1VkpNRHczdDlkV21pczBqbUFFVXZSRnhHNWtXenVM?=
 =?utf-8?B?Ym1GT3NlTGRETnNIWkhJY25BMVlpRGsrU0tUVHdnVkp2MVJvc2ZEZFFUeStP?=
 =?utf-8?B?UE94UTNlSXNqeGovREJXSUFCQXhBZWlTZWxkQzRXWUtLOUQ1OUxBQXIra0xK?=
 =?utf-8?Q?MxRjNbvPoFsnu9woR4KiwiI8z?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d6aa7774-e8b5-4250-d40b-08db812a33a5
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 09:44:06.0944
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: czZaxcTYXcKP3aZxNBBNQY+2ZFG2B2Rac7+ezSw2Gwp2+kgdVSaNXyyHLeukvwN6xzPFnGWI96TnKubSwofrCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8155
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On 7/10/2023 5:32 PM, David Hildenbrand wrote:
> On 09.07.23 15:25, Yin, Fengwei wrote:
>>
>>
>> On 7/8/2023 12:02 PM, Matthew Wilcox wrote:
>>> I would be tempted to allocate memory & copy to the new mlocked VMA.
>>> The old folio will go on the deferred_list and be split later, or its
>>> valid parts will be written to swap and then it can be freed.
>> If the large folio splitting failure is because of GUP pages, can we
>> do copy here?
>>
>> Let's say, if the GUP page is target of DMA operation and DMA operation
>> is ongoing. We allocated a new page and copy GUP page content to the
>> new page, the data in the new page can be corrupted.
> 
> No, we may only replace anon pages that are flagged as maybe shared (!PageAnonExclusive). We must not replace pages that are exclusive (PageAnonExclusive) unless we first try marking them maybe shared. Clearing will fail if the page maybe pinned.
Thanks a lot for clarification.

So my understanding is that if large folio splitting fails, it's not always
true that we can allocate new folios, copy original large folio content to
new folios, remove original large folio from VMA and map the new folios to
VMA (like it's only true if original large folio is marked as maybe shared).


Regards
Yin, Fengwei

> 
> page_try_share_anon_rmap() implements the clearing logic, taking care of synchronizing against concurrent GUP-fast.
> 
> There are some additional nasty details regarding O_DIRECT. But once it completely switched from using FOLL_GET to properly using FOLL_PIN (a lot of that conversion already happened IIRC), we're fine in that regard.
> 
