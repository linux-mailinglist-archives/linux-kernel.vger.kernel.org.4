Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2614672E1E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 02:30:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbjASBaj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 20:30:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbjASB3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 20:29:14 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21C6574EAA
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 17:24:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674091473; x=1705627473;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NcpKU4DO1qeHVmC5Ge/uyDgvNlUBDRpQODToPqswDsw=;
  b=BLp7Dr7nY9WxdqIzZGVBwCS0AMvsMFCGCxT+lc/qG2DQzCEKt9rMe0ye
   wyrTePzHZfuRcHXIxjcOZ38/K763eXc7e92f8vhGWvdSiSTWYvFkPgWLo
   ktmLzyHO23ZHMgE/yUjIfjy9wk7G/RGDomd8Iey0/JFvhzW4qKPQHGypM
   NNs9D7cxEqBBXB0jScrwOEY01oHnKlfHVXO6KkKOCs4Jk+ScvrmrG8fTR
   C3DrYSCNKYAIyqDj3qjohsYYZ7cUs/usHoF8onDTQDG/Z4h2g7F/6r88Y
   oyj7Ch5QLz7lcUUACd6i+MfI/1iMmrdXi5mHY0YkgNY9Wri75TcvtqBrU
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="305533939"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="305533939"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2023 17:24:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="802443554"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="802443554"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga001.fm.intel.com with ESMTP; 18 Jan 2023 17:24:31 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 18 Jan 2023 17:24:27 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 18 Jan 2023 17:24:27 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 18 Jan 2023 17:24:27 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.106)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 18 Jan 2023 17:24:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nPpYg2DdAFZ2honM3UN1lCGHEQa4apPKO5HQrwWBu7xR/yG9kilST1GLZKGQqUy5eWEfDuilN5mbZiUQF6UHTt+eLjDBA8KSBhDXXj97/aBn5ZAz15jnfW+Pb0d99mmrkEtTmbO5Chd6YxxDm6Cmi9rH03+6e1FxXOVf2s2Ppduo802nY/X9eYOe1FS+/ZnaO2PgNCPUnT3IaKnXIg2JKXoMsyq8YwlQ4wU8hpFw5vqsVRxJ5oSa5cAUXm26PVOBn0ottQKX4V/VVS+tN5AXeaFSBhas4j7qIa+XuEIXyaAnmRkQOng+JRCbir0gkkX82gfIXYKQ0mDJUHU3+UAoCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0MWVTaKTOX2N5oQ+uvp9DTT5+T6VOl4MQCQFgoLSBfQ=;
 b=DaRqe14WwrwN74aHGOV8q87nYsRpTSACKiARdDcF8GvnVZToAFG/ea6qAwJS+UdB482p4Yg8jtnu0LrTzI2Ajd9wDk7tuyrxshSe9oojYA7zapOBz3XyMvwQo2qi6471AooJiqV326li4F9sQB1uUokokerLZrfQMxggavMLdvfCh1UckuWSlGOHJhhpqmWMbdD32X1/I3avde+FQpq/TMlBCahIQMtdltGhoJEAvg/kzOSzCDISSsNZw1xmnR4Np4sB0SNQl576TJSaP7AzoPcXr9hltJZ5832I+q7UfN/xRGW+5jFAsZEo/v9Vks9Pj70jpLYUc3whhz5F5vTAMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by CY8PR11MB7361.namprd11.prod.outlook.com (2603:10b6:930:84::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.25; Thu, 19 Jan
 2023 01:24:25 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::1531:707:dec4:68b4]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::1531:707:dec4:68b4%3]) with mapi id 15.20.6002.024; Thu, 19 Jan 2023
 01:24:25 +0000
Message-ID: <4dd1a4f4-4da6-8079-a8de-bea7d8c18681@intel.com>
Date:   Thu, 19 Jan 2023 09:24:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.1
Subject: Re: [PATCH mm-unstable 5/5] mm/mempolicy: Convert migrate_page_add()
 to migrate_folio_add()
To:     "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
        <linux-mm@kvack.org>
CC:     <akpm@linux-foundation.org>, <linux-kernel@vger.kernel.org>
References: <20230118232219.27038-1-vishal.moola@gmail.com>
 <20230118232219.27038-6-vishal.moola@gmail.com>
Content-Language: en-US
From:   "Yin, Fengwei" <fengwei.yin@intel.com>
In-Reply-To: <20230118232219.27038-6-vishal.moola@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR03CA0131.apcprd03.prod.outlook.com
 (2603:1096:4:91::35) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|CY8PR11MB7361:EE_
X-MS-Office365-Filtering-Correlation-Id: fbd19ac1-a05b-4313-18d2-08daf9bbe674
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mPv8Xc7dTfq6beifHovJaD2Qedj6XOIN25F4RH2b7neHb9+PUFs5UCznKbCxKiIKAsLkupc/k/f/3WIsukroNMQ+w2gULNVUoEeklmP4e4iM1TXfCLjUphnwM5Xz5EFtxA2B+IjFRC1+Mi2cFb9muP1P6ft1a0VaKdtBSgjXYCV5/U7ibblU6vsIy5zfVj8+YLOysCK4mtXrdSuFzMGckXxj3xQucStTr1tNsC+RPkZO8PWBwhOMPen+cxeqFWJs9/c0uA/xxKuM84L0kvIGwu2+Jh4KzJ7i82ig4D1+csvXgrKRyg5jSA1qB7Oby+578eVLGJSpdDpEJRK5tUh55/AmkRAK2qnyBylqWTnTgM4T2dV3UW2dqUZjAgKiTSzGFj7w5BKB6vHzHAe0UjPPlhZH/xGxav5vHDXH1sITEEK6kvfdN1eDUKLlkq6Lu07+s+cwcl8qF5EQ6dh3yfWBc+q2v59iJ/P6wlQKZrwgD7Mha1WPGRAoYNbdQnY1Ek4XBd+X4TXeTIL5orMyvjbFtmxcg/qSKO9d0nLgxuy71l2MDAN4HXRQG64Tta9dLmbuqoTq9ywjU3DpW0QNx51h258MVosDGSxMqIbzD18iH66oynjme65BHn5CxWFW8PShBkEDIhhiLbCYNeOpU4AHkePv1aGmcxlH/6icwah3by51eN+3e6NTb2oeQl9u+x3C94hYEgUcORTTg+hcMn4uPoxW/CNxusQTqn1DXizJ2vA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(366004)(376002)(346002)(39860400002)(396003)(451199015)(31686004)(86362001)(31696002)(41300700001)(5660300002)(8936002)(38100700002)(82960400001)(36756003)(6486002)(478600001)(83380400001)(6512007)(6506007)(53546011)(26005)(186003)(6666004)(4326008)(8676002)(316002)(66556008)(66946007)(66476007)(2616005)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QW5uWWhrUzBQYS9iS2N3YjNReE1QeXB6RjJZZjdnQVRrWG5DTXZGWUpUVzJU?=
 =?utf-8?B?VVJpWkNXdXB0N2Y1a1kyaE83eW9zOE9IajJsK0ZRME5hcktpN05lcEVmU1p5?=
 =?utf-8?B?TVFkM01YcEZDeHRmREtjVWc1RFVvOXpSS3h1TVNlUytmSkhxMHNvc0pOc1Fl?=
 =?utf-8?B?cmFyVHZyVWN0bEpqTk40V0pGckF4NUxCdnNSOEMzdWZCVnphWW4zZVJ4WXl0?=
 =?utf-8?B?VVVZMDJ5MVRIbHFEQzhnL0RrdkFKR0JtR0RscGMvcTlRNFhLakxwM1NPWG1X?=
 =?utf-8?B?bU1vRDcxc1paRFF1VFI5RkZJNTFzTEZ3Z095YzJDQVE0eG9BZDE3Unp4ZTBh?=
 =?utf-8?B?Z1dpemEzTXVmM0VEYVEvN1N1czdoYkFyWkdTeHdPYmRkZEIxSDNGTGFuT3lJ?=
 =?utf-8?B?bjF0MGpReWxWUFdBbldVa3c0cDFqakQ1eWNOU3pjYkhVR3liZm4rUGFtdzNF?=
 =?utf-8?B?MjBtb0MwTGVrNWRuYkM2a0FlVEJNaDFickh2N2syY0pWWXNrOW9IdEFycFE3?=
 =?utf-8?B?aTZTa2lJVWpIdXQ2bFUrQkI0UlIxbERqbkw5NTZ6L3VqSThEOFBXUCt3Vjht?=
 =?utf-8?B?L0tyWGp2RE1IeWpGb3prS3BOYnljYjFWT1grdFd1Znoxc0xCOVlwbituNFhr?=
 =?utf-8?B?aU0wUTB2bzJUV2hQRW9GeUhYUlI2UGREVEp4KzhxNTR6WTZyd1oxUE55WHJ5?=
 =?utf-8?B?cUlqYXNCY3NIcU1pclJtdG00TDVsK3duTHZ0ZEhTQ2pxNDRuZTQyakdHYWpC?=
 =?utf-8?B?eml5SENyY3EyeURwQVBCMG1IYVpIL1ZJWXlMQkxMWXBUdE80SkxKbUZnQnlv?=
 =?utf-8?B?OThYR2haWW42ZGVEUzZ4NXc1dzlNL1duUmQzeWVVWXpmZzlvVGg1ZzdZWUhx?=
 =?utf-8?B?eDV4S3BoaEZvSXJYN2t2UVBoVUZKMTNjTHhUY1hmR2JzdHVQL3paMi91MEZG?=
 =?utf-8?B?amdDSEFhcEdjSXlrMmdsWEJkeXdCTkdJVXBIS1kvaEtTWXA4Z1UvVVNnWEo0?=
 =?utf-8?B?ZzBWYzJVRzJYSlk2SFh0ZUkzalJ0dVI4U1NSS3Y3Q3RsRHB2d0MvTDVMUlU0?=
 =?utf-8?B?cy93YTRFVzlLNFlYeW1OamUxNEYvVzJmbHdJT2t4cE9pVzgvVFAwbkZGejI1?=
 =?utf-8?B?UG9zUnhvWm4xakl0NXhuS3k2ZVAza3BmcVdENGRnN0dpanZkdmhEQzE4L0RL?=
 =?utf-8?B?ZGp6Wm13WEoycWZxdTNjRnlQTUU1bXphU0pYYUVTYU45d2NFZ2kvMXBmdlFY?=
 =?utf-8?B?Y2xUbGE4U1NwUUtwYnQ4OWdmWVI1ZlJpbXJUSlF4MHNTaFpZS3pJeFZ5Tks5?=
 =?utf-8?B?eTdxUnlOQzRSdGZLV0RjeGNtdllqbTRGcERpM2lhVXB3RlV5d1RQWUdMd0R0?=
 =?utf-8?B?ajJ6cFVLR3RScERETFBKVDNPbTZ1c0JaaVBOTE0wMVFWSGtFNzZIZmNEQTdt?=
 =?utf-8?B?SzNWS3VDellZc2RSVVIzS2d5RTZTaVZYMnpEZUFpVDlzK0VWYXNnaS9NTUJB?=
 =?utf-8?B?Sk1odWFWeW1xVjVKZStXN0kxTWJIanR2ZDUwZHZaYW9lVHZpN2FjZVBucytx?=
 =?utf-8?B?WGwxZ3ZJUFprbTJNRjhXZFhNTFZyVENpVy9LdWxBd08wQUg0MzFxalVsUVo3?=
 =?utf-8?B?Sy9TQ245N1Fza3dCdytCbms2SXFhTjR1QXV5Zi9mbGVIYkJqSG9SOEpoQTJV?=
 =?utf-8?B?cDNrdHN2bk5QS0lCNFk2ZTBhNk11OHFhaDNWdDhwZ1FGTHdQSW96STNvMmZy?=
 =?utf-8?B?M2hPY0VrUC8yVWl3czJpbW1DZXJzN0pYYlR2Znp2MjNKWW5GNUNESDN0aEZG?=
 =?utf-8?B?UUIwQ091Z3lyUDNTZjBERnZ1VGJUeTJZR05VTXdZTDlRY0d2eWhWa3VnLzNI?=
 =?utf-8?B?ek9PUCtRQkFUWUxCbUVISEhjM0hXRFVGaUVBaHZpKzhhU1draHhkUDFzU3VO?=
 =?utf-8?B?Vjltd21pb2VWMSs1cEtUSnZldjBKTkQxQzFtd3R1dmNwSmd1cUd4SjYwQUlv?=
 =?utf-8?B?UW9tOEphNVBab3pqL2Q5NEtid0VFcWhlVHhBblNabk5xSzBmZmhHdjR5RHEz?=
 =?utf-8?B?aXRMS013dHk1NWtIckhWMWw0U2JHaGpNd0xqMk5NWlNSUEdpU0x1YzI0T1pI?=
 =?utf-8?Q?M8SgLjbkIa6RJZ8ZceKpWnu1G?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fbd19ac1-a05b-4313-18d2-08daf9bbe674
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2023 01:24:25.0824
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M2Q+SCyXOoXNKY++dR6GHipR+DqKsbJDUEeTAop5bVYrFguty5rfyPMlBvhKcz/N1WtilmDCBj35SMxGxkYwTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7361
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/19/2023 7:22 AM, Vishal Moola (Oracle) wrote:
> Replace migrate_page_add() with migrate_folio_add().
> migrate_folio_add() does the same a migrate_page_add() but takes in a
> folio instead of a page. This removes a couple of calls to
> compound_head().
> 
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> ---
>  mm/mempolicy.c | 34 +++++++++++++++-------------------
>  1 file changed, 15 insertions(+), 19 deletions(-)
> 
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index 0a3690ecab7d..253ce368cf16 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -414,7 +414,7 @@ static const struct mempolicy_operations mpol_ops[MPOL_MAX] = {
>  	},
>  };
>  
> -static int migrate_page_add(struct page *page, struct list_head *pagelist,
> +static int migrate_folio_add(struct folio *folio, struct list_head *foliolist,
>  				unsigned long flags);
>  
>  struct queue_pages {
> @@ -476,7 +476,7 @@ static int queue_folios_pmd(pmd_t *pmd, spinlock_t *ptl, unsigned long addr,
>  	/* go to folio migration */
>  	if (flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL)) {
>  		if (!vma_migratable(walk->vma) ||
> -		    migrate_page_add(&folio->page, qp->pagelist, flags)) {
> +		    migrate_folio_add(folio, qp->pagelist, flags)) {
>  			ret = 1;
>  			goto unlock;
>  		}
> @@ -544,7 +544,7 @@ static int queue_folios_pte_range(pmd_t *pmd, unsigned long addr,
>  			 * temporary off LRU pages in the range.  Still
>  			 * need migrate other LRU pages.
>  			 */
> -			if (migrate_page_add(&folio->page, qp->pagelist, flags))
> +			if (migrate_folio_add(folio, qp->pagelist, flags))
>  				has_unmovable = true;
>  		} else
>  			break;
> @@ -1022,27 +1022,23 @@ static long do_get_mempolicy(int *policy, nodemask_t *nmask,
>  }
>  
>  #ifdef CONFIG_MIGRATION
> -/*
> - * page migration, thp tail pages can be passed.
> - */
> -static int migrate_page_add(struct page *page, struct list_head *pagelist,
> +static int migrate_folio_add(struct folio *folio, struct list_head *foliolist,
>  				unsigned long flags)
>  {
> -	struct page *head = compound_head(page);
>  	/*
> -	 * Avoid migrating a page that is shared with others.
> +	 * Avoid migrating a folio that is shared with others.
>  	 */
> -	if ((flags & MPOL_MF_MOVE_ALL) || page_mapcount(head) == 1) {
> -		if (!isolate_lru_page(head)) {
> -			list_add_tail(&head->lru, pagelist);
> -			mod_node_page_state(page_pgdat(head),
> -				NR_ISOLATED_ANON + page_is_file_lru(head),
> -				thp_nr_pages(head));
> +	if ((flags & MPOL_MF_MOVE_ALL) || folio_mapcount(folio) == 1) {
One question to the page_mapcount -> folio_mapcount here.

For a large folio with 0 entire mapcount, if the first sub-page and any
other sub-page are mapped, page_mapcount(head) == 1 is true while
folio_mapcount(folio) == 1 is not.

Regards
Yin, Fengwei

> +		if (!folio_isolate_lru(folio)) {
> +			list_add_tail(&folio->lru, foliolist);
> +			node_stat_mod_folio(folio,
> +				NR_ISOLATED_ANON + folio_is_file_lru(folio),
> +				folio_nr_pages(folio));
>  		} else if (flags & MPOL_MF_STRICT) {
>  			/*
> -			 * Non-movable page may reach here.  And, there may be
> -			 * temporary off LRU pages or non-LRU movable pages.
> -			 * Treat them as unmovable pages since they can't be
> +			 * Non-movable folio may reach here.  And, there may be
> +			 * temporary off LRU folios or non-LRU movable folios.
> +			 * Treat them as unmovable folios since they can't be
>  			 * isolated, so they can't be moved at the moment.  It
>  			 * should return -EIO for this case too.
>  			 */
> @@ -1234,7 +1230,7 @@ static struct page *new_page(struct page *page, unsigned long start)
>  }
>  #else
>  
> -static int migrate_page_add(struct page *page, struct list_head *pagelist,
> +static int migrate_folio_add(struct folio *folio, struct list_head *foliolist,
>  				unsigned long flags)
>  {
>  	return -EIO;
