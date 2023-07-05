Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79437748698
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 16:42:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232608AbjGEOmk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 10:42:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232600AbjGEOmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 10:42:38 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06BDA1709;
        Wed,  5 Jul 2023 07:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688568157; x=1720104157;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=aeyGmCu6oRADhuKpnzSobnSs+iMboZlfPGYBg0HUc98=;
  b=EIbY4XZAnrZnCf/58vOssTPmKdT9L+AFrObali3YUZcDgeDZvMgSv7BR
   X2yFRzxYkSuyGJpThCFOWqF6LBwBJ7/bqIfaDolzvJeXuD8H1PruEs1kB
   yCos0/lpxVQ+ofGjjlbqz4dR8xBLJ/eqg3pz+SRJXC/TaHFeJWRVgnbWc
   MqRh6Fu/ibH0ML4/FCtAzcyyrVbqseEBftsFTfwtrI1AzE94EWsDzA0a7
   aOlUa2iFUh6E0b3wct/1/mBBD0snsyd3rJUcWRNUtHnplfFiQdnGK2KtM
   oTM9ODHxSKXfJP7ymVqriZFufrWywalF9DbwOZZeoZz7XCbK4I91AgdJt
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="365928623"
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; 
   d="scan'208";a="365928623"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2023 07:42:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="719259853"
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; 
   d="scan'208";a="719259853"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga002.jf.intel.com with ESMTP; 05 Jul 2023 07:42:35 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 5 Jul 2023 07:42:35 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 5 Jul 2023 07:42:34 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 5 Jul 2023 07:42:34 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.104)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 5 Jul 2023 07:42:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BypMbRWeCXzzdEhLYc5R0a7lWzj4iYStVwhckhgGqVgi/MKmYAHrMyquDaVgKOj40K0aFq7AJBrGWqjrGjHUsUlHJDtNf0s7etP4n7csf6kx7lVE7xrnfwIL95y2STMQyk0RF24NUq84hGsXosI/XRka8MMV17y3lwO7RHhxrJkoT1KfaD8P0wpAWk/hBN7RpJzz4L8+bgrPxNFR55XDYE6pQpJ4GcMF0viCa1EgYmmMnMZqLbkipHTDuvrg22mrIP/RjC6qdQWqBer7xcgcpjZcKvxdQW3XvDLNEAemq+53f/4u/BzMtZPud8ZJMCkMl6KW3kfT4kryAee2iTUobg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sil9xiPwYgg8KcIM/8JQn25tc12MWLox8h56F2pWFNs=;
 b=eihN6ys/HGFrRNZeAaJEIZd+loohSkef1OA7DpMkbbx57QyWOi5XJ0WevOdHSwkvWGRN/gbiRDK8bywNLoVjx21/3B2O/wCuYHuva2CE95PUq4uVUmi3QZY0rtZl2g7VfyOLcCozYIlfeY0RJ5EBFtaOPcdp2gKzpdIbsKC/E227zTFhzLXE56dOnlOB0SqKF3EDX4AL4IbGjXp1LmyVeYI1AW26AJ4nwW7dPARx7/9qAANa9CuJl9VEM3uc9R9rgqyMtUtcJFH9hShkHHTHtYEFSOicWayIc+GZWum2mGQu8wRMI+IK+tfvU24N13Da7Lt//HbEr941hcwyJrsYwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by MW4PR11MB6618.namprd11.prod.outlook.com (2603:10b6:303:1ec::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Wed, 5 Jul
 2023 14:42:32 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::1ecd:561c:902a:7130]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::1ecd:561c:902a:7130%4]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 14:42:32 +0000
Message-ID: <24583594-4ccc-48aa-d468-9325c97df9a4@intel.com>
Date:   Wed, 5 Jul 2023 16:41:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH RFC net-next 2/4] net: page_pool: avoid calling no-op
 externals when possible
Content-Language: en-US
To:     Jakub Kicinski <kuba@kernel.org>
CC:     Alexander Duyck <alexander.duyck@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Larysa Zaremba <larysa.zaremba@intel.com>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        Alexander Duyck <alexanderduyck@fb.com>,
        "Jesper Dangaard Brouer" <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230629152305.905962-1-aleksander.lobakin@intel.com>
 <20230629152305.905962-3-aleksander.lobakin@intel.com>
 <69e827e239dab9fd7986ee43cef599d024c8535f.camel@gmail.com>
 <ac4a8761-410e-e8cc-d6b2-d56b820a7888@intel.com>
 <CAKgT0UfZCGnWgOH96E4GV3ZP6LLbROHM7SHE8NKwq+exX+Gk_Q@mail.gmail.com>
 <413e3e21-e941-46d0-bc36-fd9715a55fc4@intel.com>
 <20230703133207.4f0c54ce@kernel.org>
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <20230703133207.4f0c54ce@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0112.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::11) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|MW4PR11MB6618:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ccb7fca-8f3a-4dd4-2008-08db7d661055
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N5Nia9zgUCdo/yAYSpGFuvBZH9iPCS4RvSl95hxwlYGqlDr2CtnBSHwZU3cgh9J/zE/5TdnzlVNwxL0bQO9f4+xHG0jhnW1cAOvOYLrCJ9lq7mKjQ6C3pMM1pZCfCmAdPKnv786yjgRUdTmITiAfzzI+4j76xNdUVR1MA9bprn29CMRYDKpqKVy34jbkDkGIHg9eQ+EJ8ByErPJbVtLGGBPOf8DjjJQniR3fngAlIViL9mybJp0Z4S2igLFXKb1P2zFibHdUu6reAyo+by1w5uMy7OezaD0jV9PU+d3Avp6eBqOEqmwtFYlvJpXBeib0OTbyLuSXfs1amX+ciD+25QZTVjwPefE3BwmLcBtgvW9ylk0j3GJLgojlYNf0Id45O+pNIBoL8fb5qV0Mb9TaEq1ZBhgEtzThWDnWvkAkkE0Arago0L9uywmMNlbKj98M0GGHCYWvhJGEDner8mLlrfQgNNFsH3qIp8Me/2htsWXln+l0dlBdBJxGUqHhAePd9wFb3EwS1d3jNqKzPtTLHjcnBbC0Ve0NvYMyYBYCFAwDyDSanoQ00sXUOCEKtFKp+sllq8y4ytAaLNoUjNnDG+LpYozjEWxR+PJIKG2uneJgQaeijx2kvyr3NSgs+O08IRAqoMiJ8keoNt5j+FPyWg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(366004)(376002)(346002)(136003)(451199021)(186003)(82960400001)(478600001)(6512007)(6506007)(26005)(31686004)(86362001)(2616005)(6666004)(316002)(54906003)(38100700002)(6486002)(66556008)(6916009)(66946007)(4326008)(66476007)(7416002)(5660300002)(8676002)(8936002)(2906002)(41300700001)(31696002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d3pvL0xsVHFWWmhtNStrNWc0QnpDckZWVFM4aDlPc0w0TEd4aWxxUkRrRUh1?=
 =?utf-8?B?SWFaMzlYR1o0S1IrS3NNMzZlWjNwekFiVUplRUZFZ3FtRHlGZGFmU20ya1NL?=
 =?utf-8?B?RUkzSmlLNlB1RStiazVHWk82bGhEMDFXamliYlZxSUpTNlRzSGg5dExGemE0?=
 =?utf-8?B?TFRTTXN4Vkk5YXdtbmREQS9NUVdVRWV2L3pYS3RqSC9DTzk3ZXFxWUphaGR1?=
 =?utf-8?B?Zk9SUzhHbTBSMDdFbCtYTVdqTElUZXJ5b2hjZE5DWTA5VnlMSEMxSkh4b2FQ?=
 =?utf-8?B?UnpHVjBKenk5NDBBekVwSStXa1pyYkZFdThzMFFOb2k1WDUwc3IvcWhlZ0JE?=
 =?utf-8?B?UDhsU0ZQRkhTVS9LZTVUM0tJQ08ybW15cDgxQzJiUW13NDliSWxrVTVCalBU?=
 =?utf-8?B?VStZLytpYnBIZ2hpVzJHME5MNjhlQUxnYnM2dlJWaTBIMzEwWGxPbE40aTFH?=
 =?utf-8?B?dUtwSVdxRkhKMHBkTUtZb0RHRTVRQUhpYXJpUHRXejJiaXRiUEJpRnJ5RkNL?=
 =?utf-8?B?eWd5Vk40d0xQNWlzclY1eDR1UmhyZmlQdm1BUU4zd0RSOENyejlLQWl6UEpt?=
 =?utf-8?B?N1NVQjU3ZExxc3dITDJHNkRadFhrYW5Gd0ZpdS9UckFlNzRna3h2ZDdxNm05?=
 =?utf-8?B?SjBDZ0FpeXBnc1NsMzBaMGhJV09kTHhsenduajNWYm9MYUp5ZEdrbUZFR2c3?=
 =?utf-8?B?NkpMZ2Y1RnB5N1l0MGFXSFhlQ1p3bklrY1Facy84RHFQWTdkaTl5WVVoR3hW?=
 =?utf-8?B?c3ZyMVFHSWZZWlFvQVNkZ1VFem1nNmMybkxRK2hxaVhLUmZXNTAvZ0NPaE5F?=
 =?utf-8?B?TDVla1dvMUFqYWVibit6UnlXcnF6V1VNakozelhmbllBcUZNUytKRC9jQ2ll?=
 =?utf-8?B?SDUvL201UWxHYTkzVk5ISkduVUJSY013bjNYYVBzZHEvZEtLMmtBcHZkZVV5?=
 =?utf-8?B?M1p1WEQrZE9IVkltckRKSU1IQmpJRi80VVAvWHMzY1MxbnNKekJzSFF6eXNa?=
 =?utf-8?B?S1p2UkdsSzFSWTFzSVROalVVS2pKU01IYVRXZENCT1c3cFljaXlwREkzUGZ3?=
 =?utf-8?B?UGRXaHAvcWlFenVkSC80ZytUVmtOSko1UG9MNDM2VDhlV1ZNbXBEaU16ZklX?=
 =?utf-8?B?ZU9TWVRlM0hNYXhNV1BpZlhhQXZkL3FNZ1hCbjNPZEs0OThDank5TXFUSWVR?=
 =?utf-8?B?bDh2K054bko4L2s3d2lxUEFHS0sxbXBFSGJFaFRhWVRhTi8xQ0tud0NpcjlH?=
 =?utf-8?B?b29oM2JIZGZyZlY4SHJsQkh1Z3R1bjljc25vbHVYMFhGRE9Ec21ZUVRJNXRh?=
 =?utf-8?B?Q3IzeXlpLzZ3VEd5aURsTXozS2E3anRuMjUrSW1JZitPT2pMb1B6ZkYzRFZ5?=
 =?utf-8?B?S21QOEdxY2I0WTl4QU0wd0dEVW1vSkZzRFFzMHdXVTdGWEFUYnNDOXEyY0x3?=
 =?utf-8?B?SmRveVpqUk5XQ0M5NUJXUDFYTS9PaDI4RUNRNGpvblRkU2V6QjdBYWQ4Y0l6?=
 =?utf-8?B?clk5d0VFWDRnR2pOMGtURFpFdnlrdUhXcmtaZ1dEMEp6Y2NZeVlYdG01VGlo?=
 =?utf-8?B?UGc4V1BDMDJ1Z05heDR4QXF1VGoveUpBYWE1WkUrTkdIYWNHVVJHaklOU0wz?=
 =?utf-8?B?Umdtbi9WNGdoNHNXZzhndFhZakZxV0dOeFJKOERQUmZMV2FiRTFFc3Y2YW15?=
 =?utf-8?B?UVpqZnJmK3cwaGVMTXVZSDNlNXc4YVl5YXhiYWdSang4dWtpQVhXdXNxMTJa?=
 =?utf-8?B?bG9qTkJHR3E1emtqeGIvR3d6TXhONThJWm9FY2hSVXcyNDhoWDlxakFDSHFU?=
 =?utf-8?B?cko5dHF3WFUwZGx6eGpXNGdySzlIV3FzWEdBamZtMzQ5cjBZMFFRMEU5aEt5?=
 =?utf-8?B?QVI5Vlo0clJieGZxKzMvL3B3N1pCNGdJNGY1TlZzenBDVUp4Q0gwNmxvb0FB?=
 =?utf-8?B?SC84OWcxOFRrb2UyMU1DODRpREczTkhFOFpXbjdCSVI1eVZZNzFiTTU5Mnov?=
 =?utf-8?B?QXBDbmYvOTdtcEQ3RHJIRW94ckhKUDFjQzJzTkxLa3pJZkxnSEh3ekJHUzIr?=
 =?utf-8?B?UXJCS0h3WW9JOUlhTVNuSnRDbWVrenV3bDNKSmNjQjFxU0xSS0R3QUFDZlRQ?=
 =?utf-8?B?ME16WVhHYmVtMDRJUnA1bmdyeUJyN0ZCdlhmMVFtcEZ6U1FmcUE5QnNGWmsw?=
 =?utf-8?B?L3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ccb7fca-8f3a-4dd4-2008-08db7d661055
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 14:42:32.0052
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZhNKqdgyKtXLdHIRl/cELFl/DtmsHJ5/N8e5VTGuSuAUgsrDvBPZaUgfPwCREr+YRXOrhHoF4Iiz1ugTxb3DRU4yTzqjTUqkIkKqG7XAvW8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6618
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jakub Kicinski <kuba@kernel.org>
Date: Mon, 3 Jul 2023 13:32:07 -0700

> On Fri, 30 Jun 2023 17:34:02 +0200 Alexander Lobakin wrote:
>>> I am not a fan of having the page pool force the syncing either. Last
>>> I knew I thought the PP_FLAG_DMA_SYNC_DEV was meant to be set by the  
>>
>> Please follow the logics of the patch.
>>
>> 1. The driver sets DMA_SYNC_DEV.
>> 2. PP tries to shortcut and replaces it with MAYBE_SYNC.
>> 3. If dma_need_sync() returns true for some page, it gets replaced back
>>    to DMA_SYNC_DEV, no further dma_need_sync() calls for that pool.
>>
>> OR
>>
>> 1. The driver doesn't set DMA_SYNC_DEV.
>> 2. PP doesn't turn on MAYBE_SYNC.
>> 3. No dma_need_sync() tests.
>>
>> Where does PP force syncs for drivers which don't need them?
> 
> I think both Alex and I got confused about what's going on here.
> 
> Could you reshuffle the code somehow to make it more obvious?
> Rename the flag, perhaps put it in a different field than 
> the driver-set PP flags?

PP currently doesn't have a field for internal flags or so, so I reused
the existing one :s But you're probably right, that would make it more
obvious.

1. Driver sets PP_SYNC_DEV.
2. PP doesn't set its internal one until dma_need_sync() returns false.
3. PP-sync-for-dev checks for the internal flag.

Although needs more lines to be changed :D

Thanks,
Olek
