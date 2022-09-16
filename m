Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89EAB5BB387
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 22:32:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbiIPUcv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 16:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiIPUcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 16:32:48 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BF1C2C101
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 13:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663360367; x=1694896367;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Le8RBW6C1UW7xP5w4oKM/fotBaS7L7EfAgqpB6er4MA=;
  b=CnKC5kgWqIRqJM2nfxbF+7+R2gwPymQEUvkeqM8S/Lfw1uSNQQPA4pa4
   yoOvN9WVSRjMFuDvbPWVD1LIq44u698DTstF4NZNAA+xMhiZNpc7DHD8o
   CD4WVhrjOS00i2QfaXe8mLBKSKSXVzUSMJZ9RHx/7Lkt7mmCdpnh8t3rV
   22wHlQCOjj4FlVtQPeNZJwHcE6sjErniNWF024/TkxcyoN69uB/Rd7qf1
   iz2Xuh9lTLV8y2hJ8tO1rrBQ5ic++KVD2OmLPXHEOzF3x8xLyDlwVwKD4
   lXLPSeE3VyWy4xFi42NSWhz168ikKSvtQ5XhXoR56XrXNtLtTbji0vgAA
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10472"; a="299065470"
X-IronPort-AV: E=Sophos;i="5.93,321,1654585200"; 
   d="scan'208";a="299065470"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2022 13:32:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,321,1654585200"; 
   d="scan'208";a="650986877"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga001.jf.intel.com with ESMTP; 16 Sep 2022 13:32:46 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 16 Sep 2022 13:32:45 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 16 Sep 2022 13:32:45 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 16 Sep 2022 13:32:45 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 16 Sep 2022 13:32:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AxkjpR2mLZyvpzByMEzklx3OVrgNkNf+gU6qWZTrYKwZ5RmxvV5kYG28MqHjWjyM8FurWk6tIoMFUUXyFTkPZJJuK+a/awYtJI4iV3BJjl64ZxK10Wz+0pSzrbZbvINajRw9hbN7rG4M4Kx7E3xZeFOXgoJdSumNLL5WI3oBkhxkvqyzk6JEWx14+4+4mZpUq9xWXNtmKBzhKySMEzWdWSUgwSbO5/hvhp8Gp0FB5SWwyF6uPGXnPld3iYM7wDmgoBEZrSZ2+w4dnD1LtknL4gl5yevom0d6opnA0Ip32kpTW/oLe9GrXXzJtTCQfbN98dseZXz4kqAw00eQ2g9nHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zLtVejqY+Kao0I10Q8TMHB7SuEqRRVCkMJvW539KlG0=;
 b=aletDMxs67IDE1W48Y8Kzz3oCI1AuNsy9v9Oioru+8YSzUNR8mNzzu+U//NWcqwfKkEg9e5XjtCWtw7yvmHzMnOgauX1GCqWKL26W0waQJod58wcXhhBHMq5Cc+ure51mVglklmams4t/yeAKQk6EOvyQBrtjZ4bsIra/4jzcw48RIKO2ZyOzD1kfatj5pO0Myv2o7fVT+vrzhIZkkr7jGYEWOtceGRpwNTkocPVfhqWwaClig4+AUBc3L2s3kgYhF3dnk/v9Njm0xz5scKnLa/ONFf4XYELC6dureBGB7vWZ1/rERuhJ981OeYsxDLpZkkCuOx91wApkpyUwO9Aww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by DM4PR11MB6549.namprd11.prod.outlook.com (2603:10b6:8:8e::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5612.22; Fri, 16 Sep 2022 20:32:40 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::b80a:cf49:9118:24e7]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::b80a:cf49:9118:24e7%6]) with mapi id 15.20.5612.022; Fri, 16 Sep 2022
 20:32:40 +0000
Date:   Fri, 16 Sep 2022 13:32:38 -0700
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     Karolina Drobnik <karolina.drobnik@intel.com>
CC:     Robin Murphy <robin.murphy@arm.com>,
        <intel-gfx@lists.freedesktop.org>,
        Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
        Yunfei Wang <yf.wang@mediatek.com>,
        Ning Li <ning.li@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        Joerg Roedel <jroedel@suse.de>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [topic/core-for-CI] Revert "iommu/dma: Fix race condition during
 iova_domain initialization"
Message-ID: <20220916203238.g364hpyrcuoo4h5m@ldmartin-desk2.lan>
X-Patchwork-Hint: comment
References: <20220914124045.903883-1-karolina.drobnik@intel.com>
 <20220914150121.y6ucj4mav65mt7we@ldmartin-desk2.lan>
 <c539a4fb-795b-0b33-2543-6a3e94164676@arm.com>
 <fbca082a-7fb1-bdb5-af93-69061e597b34@intel.com>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <fbca082a-7fb1-bdb5-af93-69061e597b34@intel.com>
X-ClientProxiedBy: MW4PR04CA0279.namprd04.prod.outlook.com
 (2603:10b6:303:89::14) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|DM4PR11MB6549:EE_
X-MS-Office365-Filtering-Correlation-Id: 37b7f86e-497d-48a6-10fd-08da982299ef
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4Er9Sg65OaVLb4wtyQi4D1SH4Be1L14C60hJ1zzf84zwTjv7DvSR5/8HrVW8Naajr8F/3kodCxP+82aEuTFkMBqFRGh7OOnA4Jag78XBYRZdu6sDtkO/x690VpLZ1c2p8GRGnWLib4CGSH4xMGKCj/oEeNiNSTBuR46M/fb0Lf2WsPour9ytyLX3YpTH6ZjM5+TxqbBwQr49OWIUWjsfYwbgn4ptJzDeZyGGs8Z2rDRIQIYmVE4TszNzCDjqV0tkolpJbr2fF7x5YtP+dp3QCsQHXAedtnP6qzsq2kCWM0hcr9YhOC20wd3+A0R8dX4YqwLZh6yxAhS8QNcFe17kblvq9wtiSSNZb7MuXyEqU4UZkjXYCHa7LoLuCrAi9vvKotV/qgArPa+S3Xff8djIKNONCIF48R9fMlkljlsK2K4Vfk0q5X1hNBtgEnBPMeSYcK6lZK6ZCx4nOoBHdwMfP6OLoMRB5tYlcjcNrFg1L9c4DIJhgyYh+gm4RhU0equw2zffkSyA5IEU+oBQrGH69y4bqhArH6PyWLLIWWHf7OLC+giIX/3ZrWJ9q42QQLQ5gfFgWaD/SrbcrsslxE7CtXS+9s6KiuJepd542api3fkbpIUXBaadkzkENQhGsX6Om1yXZEolk8OIqvwAJH+62pugakr1tEfX7HBOix/2WLuBW4y1NC24MRDyp1jO9b9Dp1NjLsG5fTE+u6F1dr6IWfB3ViHU7Kd0PTAzQWUHw0FaAjBtnf5Y5MVnxSTACIURTXtVsMhyp4LOgw1mqOAwvA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(396003)(39860400002)(366004)(136003)(451199015)(26005)(86362001)(9686003)(478600001)(83380400001)(186003)(5660300002)(8936002)(6636002)(38100700002)(54906003)(8676002)(6862004)(6512007)(6486002)(2906002)(36756003)(66556008)(41300700001)(66946007)(82960400001)(1076003)(4326008)(6506007)(316002)(966005)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sk7BwUtKF5hAiLAzonvwCs7tDBYI74GcxbCyPTntyC9lp8802E8bu/kL0yQf?=
 =?us-ascii?Q?FPBRVT1aEKhMVtsiCkB7h8mmaMf8kbFJ3hXX9Z2Hiw6Bq+kKG3e/J9YiwLpL?=
 =?us-ascii?Q?s0IWE21A6pZFjKADI3dRBxicdXtg3OVkMjYMyNbcWcbM12RPe3ZbXdGGP5E4?=
 =?us-ascii?Q?Bimg2X6jlcDL+pWa0xl3+Ur1ZZ8cPJD2r/Qu3USKBYQ+SCnaW48KrEmkOdFQ?=
 =?us-ascii?Q?/o7bdWLEU/CU3U3BfpRyezkWoQuJ4cfOdkTIm2OHvUCnZpc9w9JJo2wKtJM2?=
 =?us-ascii?Q?pTMRF5xLhtIbnUNk4T92VFLpZi8808IxqHUIMykhnaGsvHuNRLdW65DJi4eD?=
 =?us-ascii?Q?Y1vago63UAM42DcNPA8OoopglBo/b1bqldacxmfQn4LyHlZMkiazR9mBIlXH?=
 =?us-ascii?Q?yHMS/J491R6ybE4dOjNm7TgkqQhil5Mhk5s3hGIjt+jemPBmNjXD273sKR8u?=
 =?us-ascii?Q?HgJRHDTesLCuEU3I7o+XPaqABr70j2fqnUwi18KM6YzB+7glSPECx9vLBJyD?=
 =?us-ascii?Q?Q2W7bvWcXAuL6WhI13QwY3hle3G99bba9C4CfR77VqFYcHL1BD8K99e+8i9m?=
 =?us-ascii?Q?Umwz/mT3MslndsKlqhcO4/P1+6h6Pq2p+Oz+oKJ4WbuEQSCHqPpYaqfwrjOH?=
 =?us-ascii?Q?UsmXw3V/rlpPX3fa/HVqAgBa7VNxXqgxIksJ484iwOeMbUSpp8l6mpIuIg/4?=
 =?us-ascii?Q?5cwbe4rzBOV0HDBVXDtldSmH7bc9qW+QLLaY8Y/+g5P4u72xSe5jvOtkdDtq?=
 =?us-ascii?Q?DIwe0hJABSCA572bkTrEjuGBDrqmgbdfp8Sjd3dwJvW966yV7wUdDgUKsu2b?=
 =?us-ascii?Q?a6D3mRtr2VkCsMculIearCTRAD9Rbc8tQidLD5MCmLKbkxfvQ9PeSbYbzsSx?=
 =?us-ascii?Q?O5R/3onZ9QOFQw+zdhKSljbDInNfaVwpHSU0+LMKVsfybstp0cnhzlIA9Hx1?=
 =?us-ascii?Q?WFFB88aCAqnVxIsZQYeXIih/jkUXbKxfmEHY5qij6ccJN3lk25yVPXHQF10k?=
 =?us-ascii?Q?ljXKCZegvfhdM2biBOFqimZjQxoN3sTlRSpD52vOogEjgulLBkDtwdq05sV9?=
 =?us-ascii?Q?n779/IVr4bxQI6SyZToacp2DbcmgzVIBsDtczksUNaRWpR58eETJoYdZU2S7?=
 =?us-ascii?Q?hNLy7XcF2JMzaxzw94pMIbuSdHypKsBu5W8pbKcFYA4yhihUfCnihNPV6E1l?=
 =?us-ascii?Q?BVk1S11NVlD1wgT4n5ogkEzE50soKLhg3TZCUtx7RtCXr9IGiIZk/qKnWZAI?=
 =?us-ascii?Q?VuZbgiPh2HrGia3ob5pfqct5kk956jDoY58MB6CWM9ZN5+WzbRNp6DCL9R8B?=
 =?us-ascii?Q?BgdqJQ8XiGd+ZsTdPYHNkfSVHr57/TgmBFf7kEDSvbfu1GPVWpfTb05HXBTn?=
 =?us-ascii?Q?N5cNSYFWPJltN/k3ZKGJZMpcaBBIhGvp19IG1mNwbVz0gHgcZJ2Ed0ClVHlr?=
 =?us-ascii?Q?z6+SJ0sxX9nVFdL5ThjRgDKXneV/cXjAoBEr0Qz4Mouo9XktH85NUWJzqre8?=
 =?us-ascii?Q?iIxHIM0f5EE+8nfTiRSpNwHj3R6gLDGQTgQ+KQr2ZzEyGtv2ieaaMLIfWMFb?=
 =?us-ascii?Q?T56UrtiIlIJLHGS4YfVGHWWnNvkwkfqQ3iOYF9ULgsXYLyqzEvld7i48R7hi?=
 =?us-ascii?Q?kg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 37b7f86e-497d-48a6-10fd-08da982299ef
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2022 20:32:40.6800
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hP+LSUYDH5m++Kn7KwhlW1Vg9BmEren28lvCfSq1nB3PoAPM1tPakGiAF1mDj4Ay18MginhBHu0OVNaGoRmYTiUXPngWXevRdkiRgo9dZXM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6549
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 16, 2022 at 02:24:00PM +0200, Karolina Drobnik wrote:
>On 14.09.2022 17:54, Robin Murphy wrote:
>>On 2022-09-14 16:01, Lucas De Marchi wrote:
>>>On Wed, Sep 14, 2022 at 02:40:45PM +0200, Karolina Drobnik wrote:
>>>>This reverts commit ac9a5d522bb80be50ea84965699e1c8257d745ce.
>>>>
>>>>This change introduces a regression on Alder Lake that
>>>>completely blocks testing. To enable CI and avoid possible
>>>>circular locking warning, revert the patch.
>>>
>>>We are already on rc5. Are iommu authors involved aware of this 
>>>issue? We could do this in our "for CI only" branch, but it's 
>>>equally important that this is fixed for 6.0
>>>
>>>Cc'ing them.
>>
>>The lockdep report doesn't make much sense to me - the deadlock cycle
>>it's reporting doesn't even involve the mutex added by that commit,
>>and otherwise the lock ordering between the IOMMU bus notifier(s) and
>>cpu_hotplug_lock has existed for ages. Has lockdep somehow got
>>multiple different and unrelated bus notifiers mixed up, maybe?
>>
>>FWIW nobody else has reported anything, and that mutex addresses a 
>>real-world concurrency issue, so I'm not convinced a revert is 
>>appropriate without at least a much clearer justification.
>
>I'll share more background on this regression. We've noticed that no
>tests were run for Alder Lake platforms. This may happens when, for
>example, there is a kernel taint or lockdep warning.
>
>Links:
>https://intel-gfx-ci.01.org/tree/drm-tip/bat-adlm-1.html
>https://intel-gfx-ci.01.org/tree/drm-tip/bat-adlp-6.html
>
>The CI logs (which can be found for example here[1], boot0 file)
>revealed a lockdep warning. One of the recent changes in the area was
>commit ac9a5d522bb8 ("iommu/dma: Fix race condition during iova_domain
>initialization"), and I sent a revert patch to test it on CI[2]. This
>proved to be effective, as the tests started running on Alder Lake
>platform:
>https://intel-gfx-ci.01.org/tree/drm-tip/Trybot_108474v1/index.html?hosts=adlp
>
>To be clear, that revert is just a way of unblocking CI testing, the
>problem requires a specific fix.
>
>Lucas, would it be possible to merge this revert to the topic branch to
>unblock Alder Lake until this issue is fixed? I'm afraid that some
>regressions could slip through the cracks if we don't do it soon enough.

Yeah. Let's have CI running with the revertt so we can see if on next runs
it will really show it was a regression or if it's something else. I
think it will help us understand why it's failing.


Lucas De Marchi


>
>Thanks,
>Karolina
>
>----
>[1] -
>https://intel-gfx-ci.01.org/tree/drm-tip/CI_DRM_12145/bat-adlm-1/igt@runner@aborted.html
>[2] - https://patchwork.freedesktop.org/series/108474/
>
>>Robin.
>>
>>>thanks Lucas De Marchi
>>>
>>>>
>>>>kernel log:
>>>>
>>>>====================================================== WARNING: 
>>>>possible circular locking dependency detected 
>>>>6.0.0-rc5-CI_DRM_12132-g6c93e979e542+ #1 Not tainted 
>>>>------------------------------------------------------ 
>>>>cpuhp/0/15
>>>>is trying to acquire lock: ffff8881013df278 
>>>>(&(&priv->bus_notifier)->rwsem){++++}-{3:3}, at: 
>>>>blocking_notifier_call_chain+0x20/0x50 but task is already 
>>>>holding lock: ffffffff826490c0 (cpuhp_state-up){+.+.}-{0:0}, at:
>>>> cpuhp_thread_fun+0x48/0x1f0 which lock already depends on the
>>>>new loc the existing dependency chain (in reverse order) is: ->
>>>>#3 (cpuhp_state-up){+.+.}-{0:0}: lock_acquire+0xd3/0x310 
>>>>cpuhp_thread_fun+0xa6/0x1f0 smpboot_thread_fn+0x1b5/0x260 
>>>>kthread+0xed/0x120 ret_from_fork+0x1f/0x30 -> #2 
>>>>(cpu_hotplug_lock){++++}-{0:0}: lock_acquire+0xd3/0x310 
>>>>__cpuhp_state_add_instance+0x43/0x1c0 
>>>>iova_domain_init_rcaches+0x199/0x1c0 
>>>>iommu_setup_dma_ops+0x130/0x440 bus_iommu_probe+0x26a/0x2d0 
>>>>bus_set_iommu+0x82/0xd0 intel_iommu_init+0xe33/0x1039 
>>>>pci_iommu_init+0x9/0x31 do_one_initcall+0x53/0x2f0 
>>>>kernel_init_freeable+0x18f/0x1e1 kernel_init+0x11/0x120 
>>>>ret_from_fork+0x1f/0x30 -> #1 
>>>>(&domain->iova_cookie->mutex){+.+.}-{3:3}: 
>>>>lock_acquire+0xd3/0x310 __mutex_lock+0x97/0xf10 
>>>>iommu_setup_dma_ops+0xd7/0x440 iommu_probe_device+0xa4/0x180 
>>>>iommu_bus_notifier+0x2d/0x40 notifier_call_chain+0x31/0x90 
>>>>blocking_notifier_call_chain+0x3a/0x50 device_add+0x3c1/0x900 
>>>>pci_device_add+0x255/0x580 pci_scan_single_device+0xa6/0xd0 
>>>>pci_scan_slot+0x7a/0x1b0 pci_scan_child_bus_extend+0x35/0x2a0 
>>>>vmd_probe+0x5cd/0x970 pci_device_probe+0x95/0x110 
>>>>really_probe+0xd6/0x350 __driver_probe_device+0x73/0x170 
>>>>driver_probe_device+0x1a/0x90 __driver_attach+0xbc/0x190 
>>>>bus_for_each_dev+0x72/0xc0 bus_add_driver+0x1bb/0x210 
>>>>driver_register+0x66/0xc0 do_one_initcall+0x53/0x2f0 
>>>>kernel_init_freeable+0x18f/0x1e1 kernel_init+0x11/0x120 
>>>>ret_from_fork+0x1f/0x30 -> #0 
>>>>(&(&priv->bus_notifier)->rwsem){++++}-{3:3}: 
>>>>validate_chain+0xb3f/0x2000 __lock_acquire+0x5a4/0xb70 
>>>>lock_acquire+0xd3/0x310 down_read+0x39/0x140 
>>>>blocking_notifier_call_chain+0x20/0x50 device_add+0x3c1/0x900 
>>>>platform_device_add+0x108/0x240 coretemp_cpu_online+0xe1/0x15e 
>>>>[coretemp] cpuhp_invoke_callback+0x181/0x8a0 
>>>>cpuhp_thread_fun+0x188/0x1f0 smpboot_thread_fn+0x1b5/0x260 
>>>>kthread+0xed/0x120 ret_from_fork+0x1f/0x30 other info that might
>>>> help us debug thi Chain exists of &(&priv->bus_notifier)->rwsem 
>>>>--> cpu_hotplug_lock --> cpuhp_state- Possible unsafe locking 
>>>>scenari CPU0 CPU1 ----                    ---- 
>>>>lock(cpuhp_state-up); lock(cpu_hotplug_lock); 
>>>>lock(cpuhp_state-up); lock(&(&priv->bus_notifier)->rwsem); *** 
>>>>DEADLOCK * 2 locks held by cpuhp/0/15: #0: ffffffff82648f10 
>>>>(cpu_hotplug_lock){++++}-{0:0}, at: cpuhp_thread_fun+0x48/0x1f0 
>>>>#1: ffffffff826490c0 (cpuhp_state-up){+.+.}-{0:0}, at: 
>>>>cpuhp_thread_fun+0x48/0x1f0 stack backtrace: CPU: 0 PID: 15 
>>>>Comm:
>>>>cpuhp/0 Not tainted 6.0.0-rc5-CI_DRM_12132-g6c93e979e542+ #1
>>>>Hardware name: Intel Corporation Alder Lake Client 
>>>>Platform/AlderLake-P DDR4 RVP, BIOS 
>>>>ADLPFWI1.R00.3135.A00.2203251419 03/25/2022 Call Trace: <TASK> 
>>>>dump_stack_lvl+0x56/0x7f check_noncircular+0x132/0x150 
>>>>validate_chain+0xb3f/0x2000 __lock_acquire+0x5a4/0xb70 
>>>>lock_acquire+0xd3/0x310 ? blocking_notifier_call_chain+0x20/0x50 
>>>>down_read+0x39/0x140 ? blocking_notifier_call_chain+0x20/0x50 
>>>>blocking_notifier_call_chain+0x20/0x50 device_add+0x3c1/0x900 ? 
>>>>dev_set_name+0x4e/0x70 platform_device_add+0x108/0x240 
>>>>coretemp_cpu_online+0xe1/0x15e [coretemp] ? 
>>>>create_core_data+0x550/0x550 [coretemp] 
>>>>cpuhp_invoke_callback+0x181/0x8a0 cpuhp_thread_fun+0x188/0x1f0 ?
>>>> smpboot_thread_fn+0x1e/0x260 smpboot_thread_fn+0x1b5/0x260 ? 
>>>>sort_range+0x20/0x20 kthread+0xed/0x120 ? 
>>>>kthread_complete_and_exit+0x20/0x20 ret_from_fork+0x1f/0x30 
>>>></TASK>
>>>>
>>>>Closes: https://gitlab.freedesktop.org/drm/intel/-/issues/6641
>>>>
>>>>Signed-off-by: Karolina Drobnik <karolina.drobnik@intel.com> Cc:
>>>> Lucas De Marchi <lucas.demarchi@intel.com> --- 
>>>>drivers/iommu/dma-iommu.c | 17 ++++------------- 1 file changed,
>>>> 4 insertions(+), 13 deletions(-)
>>>>
>>>>diff --git a/drivers/iommu/dma-iommu.c 
>>>>b/drivers/iommu/dma-iommu.c index 17dd683b2fce..9616b473e4c7 
>>>>100644 --- a/drivers/iommu/dma-iommu.c +++ 
>>>>b/drivers/iommu/dma-iommu.c @@ -65,7 +65,6 @@ struct 
>>>>iommu_dma_cookie {
>>>>
>>>>/* Domain for flush queue callback; NULL if flush queue not in 
>>>>use */ struct iommu_domain        *fq_domain; -    struct mutex 
>>>>mutex; };
>>>>
>>>>static DEFINE_STATIC_KEY_FALSE(iommu_deferred_attach_enabled); @@
>>>>-312,7 +311,6 @@ int iommu_get_dma_cookie(struct iommu_domain 
>>>>*domain) if (!domain->iova_cookie) return -ENOMEM;
>>>>
>>>>-    mutex_init(&domain->iova_cookie->mutex); return 0; }
>>>>
>>>>@@ -563,33 +561,26 @@ static int iommu_dma_init_domain(struct 
>>>>iommu_domain *domain, dma_addr_t base, }
>>>>
>>>>/* start_pfn is always nonzero for an already-initialised domain
>>>> */ -    mutex_lock(&cookie->mutex); if (iovad->start_pfn) { if 
>>>>(1UL << order != iovad->granule || base_pfn != iovad->start_pfn)
>>>> { pr_warn("Incompatible range for DMA domain\n"); - ret = 
>>>>-EFAULT; -            goto done_unlock; +            return 
>>>>-EFAULT; }
>>>>
>>>>-        ret = 0; -        goto done_unlock; +        return 0; 
>>>>}
>>>>
>>>>init_iova_domain(iovad, 1UL << order, base_pfn); ret = 
>>>>iova_domain_init_rcaches(iovad); if (ret) -        goto 
>>>>done_unlock; +        return ret;
>>>>
>>>>/* If the FQ fails we can simply fall back to strict mode */ if 
>>>>(domain->type == IOMMU_DOMAIN_DMA_FQ && 
>>>>iommu_dma_init_fq(domain)) domain->type = IOMMU_DOMAIN_DMA;
>>>>
>>>>-    ret = iova_reserve_iommu_regions(dev, domain); - 
>>>>-done_unlock: -    mutex_unlock(&cookie->mutex); -    return
>>>>ret; +    return iova_reserve_iommu_regions(dev, domain); }
>>>>
>>>>/** -- 2.25.1
>>>>
