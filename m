Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A46265FD5AE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 09:42:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbiJMHmo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 03:42:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbiJMHml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 03:42:41 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1431A12587D;
        Thu, 13 Oct 2022 00:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665646961; x=1697182961;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=5ngiLCBusBT3theecGu7GGer3u5eG0nBJ6ePgW6ByF8=;
  b=dAEWI4zDK0uW8/mqT3heX6/Q/Au3nSAX4ovmWSRjuJ4hfSCaISlRLR/L
   PlOmoyPMTDbCTViiZ8PNfT6KUhBK7dGVXDC/ftY8OnanQlCGddxahXG+R
   l49YR5qxvOT/5IJ1EYsIWEfpRC+sZHNzzcJzrWAagckxGSdRCHUKvuHV3
   M/J1ahoUG1lJxNKJpHRP57s7EQrgO7XpFYgIvBGKr5HCY8oqDfcwo3VMV
   sOWmsPLgDisavagzguckVf4RmGybiqQrjAc7fV9WKdjBjaQIReohOEI8I
   jzHLslL8ovANXFoLxssjYiOSxGIQTR7jmW9v0IzJ88m2yVaMIaUu8n5uP
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10498"; a="304999838"
X-IronPort-AV: E=Sophos;i="5.95,180,1661842800"; 
   d="scan'208";a="304999838"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2022 00:42:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10498"; a="956064753"
X-IronPort-AV: E=Sophos;i="5.95,180,1661842800"; 
   d="scan'208";a="956064753"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga005.fm.intel.com with ESMTP; 13 Oct 2022 00:42:40 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 13 Oct 2022 00:42:40 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 13 Oct 2022 00:42:39 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 13 Oct 2022 00:42:39 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.175)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 13 Oct 2022 00:42:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RqLO749dLqq2ddqvRGoK3/HATUYHhTTMPCbwtWN8KX09b2b+TtNIgZReSIhG7bKZ73sh7ZWFPFWaN1UY1GtYNhvwV0Gzx2ofH115Xdz/FnEyUuDJXOAp5f+iY1QBopxnJZgW4o85wePtnchJlI2nihc4GwPu+VvrMJJpTOAGRfV672dtmNjWtfLMISZYGcrQ6c7eGeKzW/SHiSj6MKWu68iw6MCm2fiyLpV4A3d8R1QqLse6fF9o7fFTq64jwVVbKtU9uWmEPxB0++v2/DZ5vI8nozOA6xdjm4Cs161J+4x4/rWopDYLX5cuBvZ4wjt6maV4J5hyVH3pbXY4EG9LfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X49wQdXQSEMP2v2lCGIhjK/awws2cv5/19lzwFdraxY=;
 b=g6FzQwp97gmyn9mp1X/V9VnH82fh6IFGh6AUNpYbCfyoN0w6dmDSwb01QJ/eb9JtjdJKhP44rT7L3LcuZOYdkeqRN0OGMTX0vPzhL19GysMUS8FRYTi5ck6xr9XgX6Ac0HCx7ivSoqm9YLMNIMneOv+S3vCXaayCxJgvIdcZMESgK/uKhAuTqgjRh8+nvh6lTfdVepmbh+SMVY4kJ32KMDRQYFf7EFJpUid7+VtgGVN/wPloJ4rPOeTvFE6tTO6DtCxfvWxCNCHGYr6DRgoiYtSpc3Yf9JvqB/uyq71cpflLkaBhLYL9J5cD59wNRUGBUgjCsZXnnSK7jvguDRzBIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by IA1PR11MB6442.namprd11.prod.outlook.com (2603:10b6:208:3a9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Thu, 13 Oct
 2022 07:42:18 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::3f8d:1406:50e2:7bcc]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::3f8d:1406:50e2:7bcc%3]) with mapi id 15.20.5723.022; Thu, 13 Oct 2022
 07:42:18 +0000
Date:   Thu, 13 Oct 2022 15:42:00 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Yu Kuai <yukuai1@huaweicloud.com>
CC:     Ming Lei <ming.lei@redhat.com>, "Liu, Yujie" <yujie.liu@intel.com>,
        "lkp@lists.01.org" <lkp@lists.01.org>, lkp <lkp@intel.com>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "Huang, Ying" <ying.huang@intel.com>,
        "zhengjun.xing@linux.intel.com" <zhengjun.xing@linux.intel.com>,
        "Yin, Fengwei" <fengwei.yin@intel.com>,
        "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [blk] 8c5035dfbb: fio.read_iops -10.6% regression
Message-ID: <Y0fBSDv96boXmfB4@feng-clx>
References: <202210081045.77ddf59b-yujie.liu@intel.com>
 <d5279fc2-38b3-6d20-4404-604d5c7277e2@huaweicloud.com>
 <Y0KJmODYOh83OtGa@T590>
 <e81ea0fe-dcd2-1e5d-9b78-3c79751b3097@huaweicloud.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e81ea0fe-dcd2-1e5d-9b78-3c79751b3097@huaweicloud.com>
X-ClientProxiedBy: PS2PR04CA0022.apcprd04.prod.outlook.com
 (2603:1096:300:55::34) To MN0PR11MB6304.namprd11.prod.outlook.com
 (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|IA1PR11MB6442:EE_
X-MS-Office365-Filtering-Correlation-Id: 6916c643-4bf1-41c7-7b8e-08daacee73eb
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BKdtfDTpnTbfJRJFZT/j1xxYJO+LpkCNlXe8czOEURrzavJvwD9uSzYeDMtbYEJXtTK0MLM9WyvjZFDsAkCrxNSyxXUvjdB8EFH2RDSoDs99bpRDty7xrfU173ZlyLGLsMeqGo6yTd6+YDMeZ3hu1sg/MhmEp9FBKFlMbFPBKSTx4L36WIa1P0Q1IOe+RkuJGwKJZrjYN3ei77IWoFoBvbYZB2QPN+jUQoolRZaR6qIySXSCC7huXRa5bkLTVCPT1SgqRlhYl36eYXIT+R2LEkYBeXherTEUPofXvUHs0twNWY6bP7lNqfH/RW0JZX5myihAhCMTZEb4BAHiJEaQs7+rX9v8gPcX8MGFVBUbbdkoOriDPDbXJEOfqVJ+hrylQKYSstc/tG5JYebfphPJ5WigO0ltAQq/vcvWKGYL/FHOQfG6UrjCDCxTwqLqx4cqXq0KNKkYgboa1+/8UNhIuX8Fj+pT0sSQ1prOwaV4Y8fkyRkEx8oUrzCrAQtqW+wgWYo2uDnmPT9HLO5yznY6JtP2BQtqxA1aFWIQDSGV95EqyJbyLvzdV3kcT2axT6OanPmVNdrrhoi2kNwWmXW91a8TeEODwYgx9sKTVCHtGtlgIgXXUhgv7hpmpwnaVDO0rZNpYWeUMb9HjAFoZ/VmGvkHE9wwt+OzrAiAz1M0hjhnfoyHL/lsVFNtF/33Ma28VP1pbZvhP8u/s29zF814nA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(39860400002)(396003)(346002)(136003)(376002)(366004)(451199015)(54906003)(38100700002)(33716001)(5660300002)(6512007)(6486002)(6916009)(82960400001)(2906002)(186003)(478600001)(83380400001)(6506007)(6666004)(8936002)(41300700001)(66476007)(26005)(9686003)(4326008)(66556008)(44832011)(8676002)(66946007)(86362001)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bFRVbDBORzFXdnViQlhhb1Z4cTFENTAwRUMxZy9RWUVScTVBVkp6bmlRQVhS?=
 =?utf-8?B?ZWt2YTBoZTRReVFvdTJVZWRDNHMwSlFkRnBqSE1rQk11YXhKOUN5Z0I0M3lC?=
 =?utf-8?B?b2x5c2pCTHVCWXFZSnM2V1BEUGtWNGg4NHRKeWx0dmJickdHZmRKUEVhZVlz?=
 =?utf-8?B?bE1BU2U1RGNJUVNIRHU1Y2M2eEx6azJTU25iWmEwTEtmZzI2RWhqayttQkZV?=
 =?utf-8?B?VzdxbE5RT2FSRFdacElqTTZGMHkrVWJJQWMvK1ZHSXRXQTczZ0djbS93STJQ?=
 =?utf-8?B?MXIraFYwM2R3cDdOcStqOGJ5NC82c0NGbUhYeTdTYmRYUjBoTW9uaWpXeXBE?=
 =?utf-8?B?dmlGNWswK2J4eGNNemVZZklKM0w1dVRBU3c0SGhTeE9Hd1RlUXdXUGIxQzdL?=
 =?utf-8?B?UTBSdUJtWlM1QUN4NHlmZHlhWmtYS1Nyc3Iwc3NqWDJpVjh5VG1ZUnlpSG9m?=
 =?utf-8?B?Y3RCRmo5RG5PWU1GOUZYWnZBWE8xV3lxZkQyQlVEb0VuUXJ6bnllVDk1bDMv?=
 =?utf-8?B?QWhCUDduWTA5czRXdDBnR0NrcWtGdUFPQ3ZFbzJjZ0lJMjZmUEJOQkZxWitw?=
 =?utf-8?B?TnF2NG90cTJLaFB2Z0J1OEZFY2dTb2g3TjY4RHlKUGJJVk5nK2VsV1hnckZD?=
 =?utf-8?B?VXdMRGQzZTV6WTdhKzF1Vm9ERFpKZ29odDh0Njgxai9ibzVQYzN2eTlqMkRT?=
 =?utf-8?B?YW41WVRNWlVVenNvdDJmcS9kT1ZpMEFJUmdRTmRaNDl6dmZBNlB5ckhjMEVk?=
 =?utf-8?B?SmJOY1dla3hXMHVmbUYvUXVWVUNJQk5XOEhtOXE1S1ZYRE9aaEtOZzQ5cXRx?=
 =?utf-8?B?MnkrWUNTWVVKUEp6UUhWMjhjdVdXNVV2R3kraFdWZDd6VUg0bGpvMUUrRlhq?=
 =?utf-8?B?OWh4VmJwNDIzT3RrYm85WG9qVG9oNk5Wd2RmRXVOMnlMbUJCeFJVNnR6bHN0?=
 =?utf-8?B?UnFjaG1YQjIyZldFNkl5Y0RtNGFTSVlWK2NoVUJRL2xqWmlPUUsyQmFDTEt1?=
 =?utf-8?B?aHBTRnRZOTFsdHdrQ0R1dDJaQ0FCMlRTWUtPVG9qZzAvOW02Q2JPeVd2QVZh?=
 =?utf-8?B?RlVrRENPaVVFckRIMVArS29lK3UrUWNSWGl5OGg4QnR2VHZoU1ZXYUM1VnRF?=
 =?utf-8?B?WWxHT2p6bGtON1VjSEpUamQ2VzdKSDlCeHdTNjhjNDE5N1BDNG9JdC9HRzZy?=
 =?utf-8?B?WnEwTStqZG9ITm5SUUdSUnNMbzVwZy9udDVOZFJFMi9wcWZtOEZ5enIvdjBn?=
 =?utf-8?B?cHVseWV4WmgrMmoyN2MvYmxIYkJ6eVFrTlRJZXVkRmhRY2ovYnk1MStYc1Q5?=
 =?utf-8?B?dzRiUjdPclFrNjJQaUFrUFkwQUg4MUVyK3hLcExsdUVLalhPM1BWVWVBSXJD?=
 =?utf-8?B?eUJJMnh3S3d4OU5TbFpwZWVleXcvNStNV0UyWWtHRndkQ29DNEExNkdETk1n?=
 =?utf-8?B?V0dYUHdHOTFTUnU2T1lncndkRFNYT0Q2djRleUVZNElhTzFwNWFMVDhhbUsy?=
 =?utf-8?B?SS9VV001RGloUVoxdnFqK3RBcVBBS0JaaUtZbFU0UE9iakMvNWpxL1g1eU0w?=
 =?utf-8?B?d0dMNkFNeEhJTnppb0w4N1ZZNGQ3V3A2QzNLSGRvUzR3MGJncGt3dFFnZ0ww?=
 =?utf-8?B?TytNNW8wN0xVb0VLWjZkbnEwTnhqTGZaSmxyaVVEczdkdzljWG1qVktwWWxO?=
 =?utf-8?B?RTRQMzRyRHViUlBkSGJzOFBEL0lGRmVTNUMrYmNhMXJIWG5Oa1ZxbXc2NWcr?=
 =?utf-8?B?anFkcHFyWTFPa0ZjZnppcEZ3NXNpZ2ltckpVVzhIL0Y5cEVyWnBhTndTa09w?=
 =?utf-8?B?bGFIMklvbklweUZmNnN5YUJKd2xYcnYySGg5ZEw2YlRHOHhwemJxMnY5cXVY?=
 =?utf-8?B?YXJBK3pkamd2M2JRSFBEbGZ4YVE2YTVlY3NYRUlENzhsRnpmSVJDNWFsa1RE?=
 =?utf-8?B?anlYR1VYenZGLy9NR3BvcjBML0xIL2ErVS9ZNWFFTUh1NnR2azZkRFNhcjlV?=
 =?utf-8?B?YVk5elg0M3NxZHc3MmpSZEFpNFJUVTRhRElUK21jWTROU09zWEtwMjNDa3pR?=
 =?utf-8?B?ZmRLM3ZrUlNxTXVUSGRTUk1DVmhRc21md256K2ZPV1M2RWo0RmFsa1ZQMklQ?=
 =?utf-8?Q?uEq1gCRjPXQjoMkk0Q8sr60zI?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6916c643-4bf1-41c7-7b8e-08daacee73eb
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2022 07:42:17.6789
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LVsZzvmQi4Cv/Nk8L1urhldj8Dl0ixkIBfS+frrbRxt/LdIoEkvyhxr/RNWFFtlV2pdaGpfEl2hP6CpBvLejPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6442
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 09, 2022 at 05:32:34PM +0800, Yu Kuai wrote:
> Hi,
> 
> 在 2022/10/09 16:43, Ming Lei 写道:
> > On Sat, Oct 08, 2022 at 04:00:10PM +0800, Yu Kuai wrote:
> >> Hi,
> >>
> >> 在 2022/10/08 10:50, kernel test robot 写道:
> >>> Greeting,
> >>>
> >>> FYI, we noticed a -10.6% regression of fio.read_iops due to commit:
> >>
> >> I don't know how this is working but I'm *sure* this commit won't affect
> > 
> > Looks it is wrong to move
> > 
> > 	wbt_set_write_cache(q, test_bit(QUEUE_FLAG_WC, &q->queue_flags));
> > 
> > before rq_qos_add() in wbt_init().
> > 
> > Without adding wbt rq_qos, wbt_set_write_cache is just a nop.
> 
> Yes, I got it now, I'm being foolish here.
> 
> I missed that "rwb->wc" is got by rq_qos in wbt_set_write_cache(), which
> is NULL before rq_qos_add(). By the way, it's interesting that how read
> performance is affected, I still don't know why yet...

Indeed, we are confused too. So we did some further check, and found
it could be related with the less calls of wake_up_all(), due to the
'rwb->wc' value changed. 

I'm not familiar with the block layer and VFS, and just checked the
'blk-wbt.c'. Before commit 8c5035dfbb, the 'rwb->wc' is 0 in 0Day's
test env, while it's 1 after the commit.

Inside wbt_rqw_done(), 'rwb->wc' be used to judge whether to wakeup
other waiters in system, so we add some debug code to check the
wakeup and skip-wakeup counter:

  ----------------------------------------------------------------
  @@ -130,6 +130,8 @@ static void wbt_rqw_done(struct rq_wb *rwb, struct rq_wait *rqw,
   	/*
   	 * Don't wake anyone up if we are above the normal limit.
   	 */
  -	if (inflight && inflight >= limit)
  +	if (inflight && inflight >= limit) {
  +		skip_wakeup++;
   		return;
  +	}
   
   	if (wq_has_sleeper(&rqw->wait)) {
   		int diff = limit - inflight;
   
  -		if (!inflight || diff >= rwb->wb_background / 2)
  +		if (!inflight || diff >= rwb->wb_background / 2) {
  +			wakeup++;
   			wake_up_all(&rqw->wait);
  +		}
  ----------------------------------------------------------------

And after the fio task, the 'skip_wakeup' number is much bigger
after the patch:
  
  before patch:
      422.274394: wbt_rqw_done: wakeup_skip=19408 wakup_all=1944759
  
  after patch:
      433.753345: wbt_rqw_done: wakeup_skip=2090585 wakup_all=13630

Hope this can help the root causing.

Thanks,
Feng
