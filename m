Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0313265E2A1
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 02:47:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbjAEBqz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 20:46:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjAEBqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 20:46:48 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D763B2F786
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 17:46:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672883201; x=1704419201;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=JhxYiLAmv3w1hMJSTb1A69TtpAwb7afjTZ+U/H2c9Nk=;
  b=faFHLzZvg+VAjrvTictCDM7N098PMj0RWcQnBOaJekr6ltIeUBbJxrdZ
   dTE9GpFMXkedzVPtAOtWe+9NINL6TOQ4JVsf0PHpC0bxsggUg6iUBELEU
   DOfaZ4h0wsyWcpx6lyj5GKQbkYeCmMySWtFsy3V9Nb1g6Ul76yG+UMoZR
   3dh+QOACy4d1ePuwk/KgAeRWJOA8kxUKR9OIx1YVR+QxUr3OHpWc194Bk
   VQWg/g4smXPnhGyfe7juM3nsWo9Z7rAaTlDQWCMyMisXrEVEmN/WiQ3eE
   uajsz9eUaDJDQ+fVB0zyM5klYvFmKTunJpR/4ZYTJjvXRgc53QMd2pz8h
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="305595361"
X-IronPort-AV: E=Sophos;i="5.96,301,1665471600"; 
   d="xz'?scan'208";a="305595361"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2023 17:46:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="657324631"
X-IronPort-AV: E=Sophos;i="5.96,301,1665471600"; 
   d="xz'?scan'208";a="657324631"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga007.fm.intel.com with ESMTP; 04 Jan 2023 17:46:28 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 4 Jan 2023 17:46:24 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 4 Jan 2023 17:46:23 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 4 Jan 2023 17:46:23 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 4 Jan 2023 17:46:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DGJAd5I+JAkSjppx31KNGHD+xS6mQwiVUsWi3FWsQe/Wg6ZfY1/bV0JkoIbvAzZaHzXGy69SxefsXGQnoChYxF0ud7ziP/omeutePPWa+NcDvbvso/eT275QXJHs1EsIEUfd+vuUPMmfmXGHsWPLjdpls5krtufsgK0RYlRf0DQ6rh/A4Q+cF+KuKKeTJZhlmhLrqk6fNz1eC6Yu7xsYFTMFKREjxFDHR2qpswO+LmAxovn7chL0EQgQPhi6h80mwMvuqPHM16CUeJcaXv8Ynucpa0SzUQzBb11yyxn8F2sDKJNDre9J1GA1/5p+uO3ZZNZCh2w7Q4viW/PZUwIDDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L70oxQ2BVBjYDvB28DvZBmeY2vGEYVs4SORjUS0WGYg=;
 b=oOLiAlIXvcrKoNs3eveWvtbDNbSb9GK0c+UtWD3+mfamm26lyz4S5PBVoUuFOXqvCy04fOsG0ndg6+A2CR8oI36cuy5HtdAPFKkaa/Fn2bxcm1A/0zfbnBj3oIbJ/ZibYJWZqnhXT+dm6mMiFa2UXyqXMoL4cEAc7EvOfYmOBwz+J7btul3BbgSEnxNPnvdfX50O/WH3vWIW3dEyIzy42OvtZPLIB9H5QMr+6oAGwfgjrRIntkRLOUCHViWlQJPbwSUmWSyNX+1gGZo3vZXJ7FvbBWIjLbwHrbHA0yTHXGtSyjpiJDtHViKm/4s7QU2yIadTtgsSic4rkCJuatjcQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by DS0PR11MB7903.namprd11.prod.outlook.com (2603:10b6:8:f7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 01:46:17 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::fce6:d181:2417:f241]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::fce6:d181:2417:f241%8]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 01:46:17 +0000
Date:   Thu, 5 Jan 2023 09:46:06 +0800
From:   Oliver Sang <oliver.sang@intel.com>
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
CC:     Vlastimil Babka <vbabka@suse.cz>, <oe-lkp@lists.linux.dev>,
        <lkp@intel.com>, Mike Rapoport <rppt@linux.ibm.com>,
        Christoph Lameter <cl@linux.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [linus:master] [mm, slub] 0af8489b02:
 kernel_BUG_at_include/linux/mm.h
Message-ID: <Y7Yr3kEkDEd51xns@xsang-OptiPlex-9020>
References: <202212312021.bc1efe86-oliver.sang@intel.com>
 <41276905-b8a5-76ae-8a17-a8ec6558e988@suse.cz>
 <Y7Qxucg5le7WOzr7@xsang-OptiPlex-9020>
 <Y7VBFLHY/PMbb4XS@hyeyoo>
Content-Type: multipart/mixed; boundary="K+KrPlbAqfTrdreA"
Content-Disposition: inline
In-Reply-To: <Y7VBFLHY/PMbb4XS@hyeyoo>
X-ClientProxiedBy: SI1PR02CA0024.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::12) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|DS0PR11MB7903:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c70a9fc-dfb8-4f95-05db-08daeebea2c2
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Be4exjhwnJxx6bo6cP8EaO4DTQek4Ap17q8wpSHXkcv3H7sOKyFBmF5EWcwGpzWZTnWlh3NpuqZ+h901HA5aYlWjqnOATSoVB/KOuVhw1PcO84xYULZo0Jap/3FsG4vQCYc1Dm3Sm+bzaF0kr72p0VkgkrEPzq94AW5HDdEwo2R5t9NxHQ2qZS8LmFcDgru7eXcqX+uuuXW1GhmXhOiIypyeyEcFWZeW51SfBbwtwuehmCDmJpMRX1C+KzULKFZeZtqatMA2SVccvtR2ACfCAjlHBDIXof4iwYrBANBxRg0rYLae6qwsBkiol+Z+jH7rCgza/t8YJy5MzTJDos7dXlgjyj3UB/LYqb6kNJ3JQe9jrbNzaD+XxQtXkCE1W4m1AmguJOvNKcH88PJbMyoeWCY1sYK9qRWv9LXR3GF9nO4AsWX+c0pNQlbmYOnFkAOcuqoSIdJeSx0IBQT9TbEbV9POKxnPH+zUwJbMXmltqok7g0pZNPpDnJ+6zUeych7burfKtxDTzFw+O0LMyY/lscaUPxSAgbz/b6a5yJenJ63qBpAzzO62ZttqIlO3Ke/GHcDnSUy8A78lOOmtSKtnL5Lymb5tLBmDnz4KxjvuKEao8dQ9OqL5qHlQuFHFkJWDHDUHrwiSOz2eO7jA0b0StwpNrhCrwTTHYt8t3oOGvCDt2JFe3h2YcSrpd+yKqK3LtZiYbfVAtEn2vTJsr6v0ig==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(39860400002)(346002)(366004)(376002)(136003)(396003)(451199015)(44832011)(30864003)(235185007)(5660300002)(8676002)(316002)(54906003)(6916009)(2906002)(41300700001)(4326008)(66556008)(66946007)(66476007)(8936002)(6486002)(6506007)(44144004)(45080400002)(478600001)(6666004)(83380400001)(186003)(26005)(86362001)(6512007)(9686003)(33716001)(82960400001)(38100700002)(2700100001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UBYnf4OhIWU8u2XoNxk9JGwchnR+v2tNl67oIF8Vg+mqk4yXueuGKtX49ixg?=
 =?us-ascii?Q?FbyBgluGoNrM7oyaQFS4CnKxn9q62tz+mwQjDN1Zq6WK5Fc8a86Wco3hlc7Z?=
 =?us-ascii?Q?6fhCddU/3Flx63PVxCSkR3x4Eg3AJacMk32rpntt7Om5k62zqrFolmLUmRb2?=
 =?us-ascii?Q?jLRMPZEzdRz0S4JsLdl3l1LC19cvPefMigs9dBvST7J5MJagNVg6hHByyjPT?=
 =?us-ascii?Q?V13zMnQtAm/wDXacfFPr6RcDVRK0aOT83cYJUSJmfnZ0KZU36i/x46mCaTQT?=
 =?us-ascii?Q?m5X6/gvYSsdLRfhzzk5Po83EXaX7l+9tp54xDjOnpZQkai6cRCnv+gZx0RF2?=
 =?us-ascii?Q?MqR3y7QWCBDs8IUq7ISQaTckN/B9Cs2L4LvzH3VDn5wOVSQ/VkyWh5VAsQ2T?=
 =?us-ascii?Q?1rEInyU36VfmA3TqgeC5yO02pXELzMxZevWzGeDKq6Z4pIv+oSVe7Mm2FDx3?=
 =?us-ascii?Q?/Q3sJNJWKMkDi329QX8ev0TkcOi2NwQWUT8Y2w1FQAlMc3m98Ok6i8lL7SUR?=
 =?us-ascii?Q?nlLh883D+918F91uEMCCbOTdFEAnzCBz5Q+s9IhbKTr7WuHJ04cczV7xba3d?=
 =?us-ascii?Q?9ydItB7Zg8EjGQykQ0JXTJrGjH6LV4f3tmLjxFCOD01flHfE9VciFkRCJfXh?=
 =?us-ascii?Q?y4TKqMtXRgMHWDAYvnAFZ6OVVRB7f1VEYgLZLF0vx4cRXkkX2rNvZpDAf2Ms?=
 =?us-ascii?Q?WdEr2o2FpywzMAGJEFfJB/qp9CbNWdKEjY6P0RUccoL9jlWub/RgDLs8BUIk?=
 =?us-ascii?Q?ctzS8DofMW//tbvj5vdeLa44TngEjrdCdODkQJkpsL6LoQ28iXEuJ8DtynJr?=
 =?us-ascii?Q?clYbfGkp9XoKaJiv2ULAyE3bCA5xrh1JbMfcvCbcfVFu7AggLzm5veDyP38B?=
 =?us-ascii?Q?r989PIdwo77eJvc65QR3Y2MfH7FLzQj2mkz7DLIFWkGAjLSb3OTPQkPDhshe?=
 =?us-ascii?Q?SVuY8779pGm9QPpctNK/aPm7D+sHPZgzriQ3cY/4NxFmNCYFPahR1UJ4hbBu?=
 =?us-ascii?Q?CM2SD88fbfkN4VgIMfEwuF0QnDLeW7m+2ny4sWRo4/6rwlCWrf80OmbI/xRE?=
 =?us-ascii?Q?J/Zs+/0/n8njxOA3lQDShivspMiVXoEquaC0HlmTLUyQKPcUsCE6Om0hF6z8?=
 =?us-ascii?Q?Pvo3VR1BY8Pcd1YhAbKjZGeN65cg+PT7gpKxFfRKTAR0XCYptHLCweFZyRqN?=
 =?us-ascii?Q?HKMzCJfO3MCzkNfO6emV6oUjLGUrE6J6EMeq0NdeSWlBGb5NM31PU0jtPu8v?=
 =?us-ascii?Q?cilo9jvWAVFniBoJ+uJAIRXaPPodxqbgT8A2lm/iJNMw5NfA5kf/OZN5e9KJ?=
 =?us-ascii?Q?7pR+VIm8UPYbfhpPgjKDholxC/dwueiGpj7XfkmDlgcuFmBRfZZCKgyS2O9Q?=
 =?us-ascii?Q?zM8XjDbRnGNLenLnsupOl66/IBRA5IS5iHurZOFF45PzGgtqHciUNBHZW55N?=
 =?us-ascii?Q?uRadPbEFks2pR3ySbjDPaKdQ9G3PGJQYNjuKqMmbJCVqJU/FncW1BcjuewjN?=
 =?us-ascii?Q?nP0Icd/vkJzIyxO7MSoTv7X4ZTfe2hqwlaUOh4nyJEgMsbVhDISAA4LMxIK8?=
 =?us-ascii?Q?ll6hkw5z2OMwLg3Gh9FteqkuJxidb98fVaH1Sh4E6P/zqi982aygNT5zh84u?=
 =?us-ascii?Q?aQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c70a9fc-dfb8-4f95-05db-08daeebea2c2
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2023 01:46:17.6305
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VDHYDJfSGcsjrJ5jaqqk0Mu6J4GW7c1UjmDo9fIrDT+e4TLFxAm2xcXOLH9xh5fGrF+TQqnRW7HB/N7bRyVZFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7903
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,UPPERCASE_50_75 autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--K+KrPlbAqfTrdreA
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

hi, Hyeonggon, hi, Vlastimil,

On Wed, Jan 04, 2023 at 06:04:20PM +0900, Hyeonggon Yoo wrote:
> On Tue, Jan 03, 2023 at 09:46:33PM +0800, Oliver Sang wrote:
> > On Tue, Jan 03, 2023 at 11:42:11AM +0100, Vlastimil Babka wrote:
> > > So the events leading up to this could be something like:
> > > 
> > > - 0x2daee is order-1 slab folio of the inode cache, sitting on the partial list
> > > - despite being on partial list, it's freed ???
> > > - somebody else allocates order-2 page 0x2daec and uses it for whatever,
> > > then frees it
> > > - 0x2daec is reallocated as order-1 slab from names_cache, then freed
> > > - we try to allocate from the slab page 0x2daee and trip on the PageTail
> > > 
> > > Except, the freeing of order-2 page would have reset the PageTail and
> > > compound_head in 0x2daec, so this is even more complicated or involves some
> > > extra race?
> > 
> > FYI, we ran tests more up to 500 times, then saw different issues but rate is
> > actually low
> > 
> > 56d5a2b9ba85a390 0af8489b0216fa1dd83e264bef8
> > ---------------- ---------------------------
> >        fail:runs  %reproduction    fail:runs
> >            |             |             |
> >            :500         12%          61:500   dmesg.invalid_opcode:#[##]
> >            :500          3%          14:500   dmesg.kernel_BUG_at_include/linux/mm.h
> >            :500          3%          17:500   dmesg.kernel_BUG_at_include/linux/page-flags.h
> >            :500          5%          26:500   dmesg.kernel_BUG_at_lib/list_debug.c
> >            :500          0%           2:500   dmesg.kernel_BUG_at_mm/page_alloc.c
> >            :500          0%           2:500   dmesg.kernel_BUG_at_mm/usercopy.c
> > 

hi Vlastimil,

as you mentioned
> Hm even if rate is low, the different kinds of reports could be useful to
> see, if all of that is caused by the commit.

we tried to run tests even more times, but with the config which enable
    CONFIG_DEBUG_PAGEALLOC
    CONFIG_DEBUG_PAGEALLOC_ENABLE_DEFAULT
(config is attached as
    config-6.1.0-rc2-00014-g0af8489b0216+CONFIG_DEBUG_PAGEALLOC+CONFIG_DEBUG_PAGEALLOC_ENABLE_DEFAULT
the only diff with previous config is
@@ -5601,7 +5601,8 @@ CONFIG_HAVE_KCSAN_COMPILER=y
 # Memory Debugging
 #
 CONFIG_PAGE_EXTENSION=y
-# CONFIG_DEBUG_PAGEALLOC is not set
+CONFIG_DEBUG_PAGEALLOC=y
+CONFIG_DEBUG_PAGEALLOC_ENABLE_DEFAULT=y
 CONFIG_PAGE_OWNER=y
 # CONFIG_PAGE_POISONING is not set
 CONFIG_DEBUG_PAGE_REF=y
)

what we found now is some issues are also reproduced on parent now (still by
rcutorture tests here), though seems lower rate on parent.

=========================================================================================
compiler/kconfig/rootfs/runtime/tbox_group/test/testcase/torture_type:
  gcc-11/i386-randconfig-a012-20221226+CONFIG_DEBUG_PAGEALLOC+CONFIG_DEBUG_PAGEALLOC_ENABLE_DEFAULT/debian-11.1-i386-20220923.cgz/300s/vm-snb/default/rcutorture/tasks-tracing

56d5a2b9ba85a390 0af8489b0216fa1dd83e264bef8
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
          8:985         19%         199:990   dmesg.invalid_opcode:#[##]
           :985          5%          51:990   dmesg.kernel_BUG_at_include/linux/mm.h
          3:985          4%          41:990   dmesg.kernel_BUG_at_include/linux/page-flags.h
          4:985         10%         102:990   dmesg.kernel_BUG_at_lib/list_debug.c
           :985          0%           2:990   dmesg.kernel_BUG_at_mm/page_alloc.c
          1:985          0%           3:990   dmesg.kernel_BUG_at_mm/usercopy.c

however, we noticed dmesg.kernel_BUG_at_include/linux/mm.h still have
relatively high rate on this commit but keeps clean on parent.

so I attached dmesg-rcutorture-bug-at-mm-h.xz
since it has
[   33.586931][  T183] ------------[ cut here ]------------
[   33.590089][  T183] kernel BUG at include/linux/mm.h:825!
[   33.591219][  T183] invalid opcode: 0000 [#1] SMP DEBUG_PAGEALLOC
not sure if this is helpful.

> > > 
> > > In any case, this is something a debug_pagealloc kernel could have a chance
> > > of catching earlier. Would it be possible to enable CONFIG_DEBUG_PAGEALLOC
> > > and DEBUG_PAGEALLOC_ENABLE_DEFAULT additionally to the rest of the
> > > configuration, and repeat the test?
> > 
> > ok, we are starting to test by these 2 additional configs now.
> 
> BTW it seems to be totally unrelated to rcutorture tests.
> Are there similar reports in boot tests with the same config?

hi Hyeonggon,

per your suggestion (Thanks a lot!) we used same config as above which
enabled CONFIG_DEBUG_PAGEALLOC and CONFIG_DEBUG_PAGEALLOC_ENABLE_DEFAULT
to do boot tests. the results have some differences:

=========================================================================================
compiler/kconfig/rootfs/sleep/tbox_group/testcase:
  gcc-11/i386-randconfig-a012-20221226+CONFIG_DEBUG_PAGEALLOC+CONFIG_DEBUG_PAGEALLOC_ENABLE_DEFAULT/debian-11.1-i386-20220923.cgz/1/vm-snb/boot

56d5a2b9ba85a390 0af8489b0216fa1dd83e264bef8
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
         11:999         20%         208:999   dmesg.invalid_opcode:#[##]
          2:999          5%          51:999   dmesg.kernel_BUG_at_include/linux/mm.h
          4:999          4%          40:999   dmesg.kernel_BUG_at_include/linux/page-flags.h
          4:999         11%         111:999   dmesg.kernel_BUG_at_lib/list_debug.c
           :999          0%           2:999   dmesg.kernel_BUG_at_mm/page_alloc.c
          1:999          0%           3:999   dmesg.kernel_BUG_at_mm/usercopy.c

here the dmesg.kernel_BUG_at_include/linux/mm.h is also reproduced on parent,
only issue shows on this commit but not on parent is (but rate is very low)
    dmesg.kernel_BUG_at_mm/page_alloc.c

I also attached dmesg-boot-bug-at-page_alloc-c.xz
which has
[   17.251777][    C0] ------------[ cut here ]------------
[   17.252218][    C0] kernel BUG at mm/page_alloc.c:1406!
[   17.252647][    C0] invalid opcode: 0000 [#1] SMP DEBUG_PAGEALLOC

If you need more information, please let us know. Thanks

> 
> > > 
> > > Separately we should also make the __dump_page() more resilient.
> > > 
> > > Thanks,
> > > Vlastimil
> > > 
> > > > [   25.804432][  T214] ------------[ cut here ]------------
> > > > [   25.804917][  T214] kernel BUG at include/linux/mm.h:825!
> > > > [   25.805402][  T214] invalid opcode: 0000 [#1] SMP
> > > > [   25.805820][  T214] CPU: 0 PID: 214 Comm: udevadm Tainted: G S                 6.1.0-rc2-00014-g0af8489b0216 #2 1c4d7707ec0ce574ed62a77e82a8580202758048
> > > > [   25.806944][  T214] EIP: __dump_page.cold+0x282/0x369
> > > > [   25.807376][  T214] Code: ff ff 83 05 e8 5d bb c5 01 ba 4c c4 2f c4 89 f8 83 15 ec 5d bb c5 00 e8 f2 92 ed fd 83 05 f8 5d bb c5 01 83 15 fc 5d bb c5 00 <0f> 0b 83 05 00 5e bb c5 01 b8 ac 85 a3 c4 83 15 04 5e bb c5 00 e8
> > > > [   25.808960][  T214] EAX: 00000000 EBX: e764d530 ECX: 00000003 EDX: 4108888f
> > > > [   25.809578][  T214] ESI: e764d4e0 EDI: e764d4e0 EBP: ed89db3c ESP: ed89db00
> > > > [   25.810168][  T214] DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068 EFLAGS: 00210046
> > > > [   25.810803][  T214] CR0: 80050033 CR2: 00616abc CR3: 2d878000 CR4: 000406d0
> > > > [   25.811407][  T214] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
> > > > [   25.811999][  T214] DR6: fffe0ff0 DR7: 00000400
> > > > [   25.812390][  T214] Call Trace:
> > > > [   25.812675][  T214]  dump_page+0x2a/0xc0
> > > > [   25.813025][  T214]  ? _raw_spin_lock_irqsave+0x16/0x30
> > > > [   25.813492][  T214]  folio_flags+0x23/0x70
> > > > [   25.813945][  T214]  get_partial_node+0x89/0x290
> > > > [   25.814357][  T214]  __slab_alloc_node+0xbb/0x270
> > > > [   25.814860][  T214]  kmem_cache_alloc_lru+0x8d/0x4e0
> > > > [   25.815289][  T214]  ? __lock_release+0x3ec/0x410
> > > > [   25.815697][  T214]  ? iget_locked+0x78/0x310
> > > > [   25.816096][  T214]  alloc_inode+0x93/0x150
> > > > [   25.816469][  T214]  iget_locked+0xdd/0x310
> > > > [   25.816829][  T214]  ? lock_is_held_type+0x80/0xf0
> > > > [   25.817264][  T214]  kernfs_get_inode+0x24/0xb0
> > > > [   25.817670][  T214]  kernfs_iop_lookup+0xb5/0x1a0
> > > > [   25.818087][  T214]  __lookup_slow+0xd9/0x2a0
> > > > [   25.818479][  T214]  lookup_slow+0x50/0x90
> > > > [   25.818847][  T214]  walk_component+0x19c/0x2c0
> > > > [   25.819244][  T214]  path_lookupat+0xa3/0x270
> > > > [   25.819627][  T214]  path_openat+0x307/0x3e0
> > > > [   25.820007][  T214]  do_filp_open+0x7c/0x130
> > > > [   25.820409][  T214]  do_sys_openat2+0x113/0x1f0
> > > > [   25.820807][  T214]  do_sys_open+0x8e/0xe0
> > > > [   25.821211][  T214]  __ia32_sys_openat+0x2b/0x40
> > > > [   25.821622][  T214]  __do_fast_syscall_32+0x72/0xd0
> > > > [   25.822057][  T214]  ? trace_hardirqs_on+0xa2/0x110
> > > > [   25.822480][  T214]  ? __fput+0x19f/0x390
> > > > [   25.822842][  T214]  ? lockdep_hardirqs_on_prepare+0x242/0x400
> > > > [   25.823346][  T214]  ? syscall_exit_to_user_mode+0x5f/0x90
> > > > [   25.823823][  T214]  ? __do_fast_syscall_32+0x7c/0xd0
> > > > [   25.824259][  T214]  ? lockdep_hardirqs_on_prepare+0x242/0x400
> > > > [   25.824767][  T214]  ? syscall_exit_to_user_mode+0x5f/0x90
> > > > [   25.825254][  T214]  ? __do_fast_syscall_32+0x7c/0xd0
> > > > [   25.825696][  T214]  ? __do_fast_syscall_32+0x7c/0xd0
> > > > [   25.826155][  T214]  ? syscall_exit_to_user_mode+0x5f/0x90
> > > > [   25.826627][  T214]  ? __do_fast_syscall_32+0x7c/0xd0
> > > > [   25.827056][  T214]  ? __do_fast_syscall_32+0x7c/0xd0
> > > > [   25.827486][  T214]  ? __do_fast_syscall_32+0x7c/0xd0
> > > > [   25.827929][  T214]  ? irqentry_exit_to_user_mode+0x23/0x30
> > > > [   25.828423][  T214]  ? irqentry_exit+0x7f/0xc0
> > > > [   25.828812][  T214]  do_fast_syscall_32+0x32/0x70
> > > > [   25.829223][  T214]  do_SYSENTER_32+0x15/0x20
> > > > [   25.829589][  T214]  entry_SYSENTER_32+0xa2/0xfb
> > > > [   25.830003][  T214] EIP: 0xb7f8c549
> > > > [   25.830330][  T214] Code: 03 74 c0 01 10 05 03 74 b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d 76 00 58 b8 77 00 00 00 cd 80 90 8d 76
> > > > [   25.831929][  T214] EAX: ffffffda EBX: 00000006 ECX: 006142a1 EDX: 002a8000
> > > > [   25.832522][  T214] ESI: 00000000 EDI: 00000001 EBP: 00614024 ESP: bff3c4a0
> > > > [   25.833123][  T214] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00200246
> > > > [   25.833738][  T214] Modules linked in:
> > > > [   25.834062][  T214] ---[ end trace 0000000000000000 ]---
> > > > [   25.834522][  T214] EIP: __dump_page.cold+0x282/0x369
> > > > [   25.834960][  T214] Code: ff ff 83 05 e8 5d bb c5 01 ba 4c c4 2f c4 89 f8 83 15 ec 5d bb c5 00 e8 f2 92 ed fd 83 05 f8 5d bb c5 01 83 15 fc 5d bb c5 00 <0f> 0b 83 05 00 5e bb c5 01 b8 ac 85 a3 c4 83 15 04 5e bb c5 00 e8
> > > > [   25.836574][  T214] EAX: 00000000 EBX: e764d530 ECX: 00000003 EDX: 4108888f
> > > > [   25.837183][  T214] ESI: e764d4e0 EDI: e764d4e0 EBP: ed89db3c ESP: ed89db00
> > > > [   25.837772][  T214] DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068 EFLAGS: 00210046
> > > > [   25.838414][  T214] CR0: 80050033 CR2: 00616abc CR3: 2d878000 CR4: 000406d0
> > > > [   25.839011][  T214] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
> > > > [   25.839597][  T214] DR6: fffe0ff0 DR7: 00000400
> > > > [   25.839995][  T214] Kernel panic - not syncing: Fatal exception
> > > > [   25.840554][  T214] Kernel Offset: disabled
> > > 
> > > 
> 
> -- 
> Thanks,
> Hyeonggon

--K+KrPlbAqfTrdreA
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment;
	filename*0="config-6.1.0-rc2-00014-g0af8489b0216+CONFIG_DEBUG_PAGEALLOC+C";
	filename*1="ONFIG_DEBUG_PAGEALLOC_ENABLE_DEFAULT"

#
# Automatically generated file; DO NOT EDIT.
# Linux/i386 6.1.0-rc2 Kernel Configuration
#
CONFIG_CC_VERSION_TEXT="gcc-11 (Debian 11.3.0-8) 11.3.0"
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=110300
CONFIG_CLANG_VERSION=0
CONFIG_AS_IS_GNU=y
CONFIG_AS_VERSION=23900
CONFIG_LD_IS_BFD=y
CONFIG_LD_VERSION=23900
CONFIG_LLD_VERSION=0
CONFIG_CC_CAN_LINK=y
CONFIG_CC_CAN_LINK_STATIC=y
CONFIG_CC_HAS_ASM_GOTO_OUTPUT=y
CONFIG_CC_HAS_ASM_INLINE=y
CONFIG_CC_HAS_NO_PROFILE_FN_ATTR=y
CONFIG_PAHOLE_VERSION=123
CONFIG_CONSTRUCTORS=y
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_TABLE_SORT=y
CONFIG_THREAD_INFO_IN_TASK=y

#
# General setup
#
CONFIG_INIT_ENV_ARG_LIMIT=32
# CONFIG_COMPILE_TEST is not set
# CONFIG_WERROR is not set
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_BUILD_SALT=""
CONFIG_HAVE_KERNEL_GZIP=y
CONFIG_HAVE_KERNEL_BZIP2=y
CONFIG_HAVE_KERNEL_LZMA=y
CONFIG_HAVE_KERNEL_XZ=y
CONFIG_HAVE_KERNEL_LZO=y
CONFIG_HAVE_KERNEL_LZ4=y
CONFIG_HAVE_KERNEL_ZSTD=y
# CONFIG_KERNEL_GZIP is not set
# CONFIG_KERNEL_BZIP2 is not set
# CONFIG_KERNEL_LZMA is not set
# CONFIG_KERNEL_XZ is not set
# CONFIG_KERNEL_LZO is not set
CONFIG_KERNEL_LZ4=y
# CONFIG_KERNEL_ZSTD is not set
CONFIG_DEFAULT_INIT=""
CONFIG_DEFAULT_HOSTNAME="(none)"
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
# CONFIG_POSIX_MQUEUE is not set
# CONFIG_WATCH_QUEUE is not set
CONFIG_CROSS_MEMORY_ATTACH=y
# CONFIG_USELIB is not set
# CONFIG_AUDIT is not set
CONFIG_HAVE_ARCH_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK=y
CONFIG_GENERIC_PENDING_IRQ=y
CONFIG_GENERIC_IRQ_MIGRATION=y
CONFIG_GENERIC_IRQ_INJECTION=y
CONFIG_HARDIRQS_SW_RESEND=y
CONFIG_GENERIC_IRQ_CHIP=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_SIM=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=y
CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
CONFIG_GENERIC_IRQ_DEBUGFS=y
# end of IRQ subsystem

CONFIG_CLOCKSOURCE_WATCHDOG=y
CONFIG_ARCH_CLOCKSOURCE_INIT=y
CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=y
CONFIG_GENERIC_TIME_VSYSCALL=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
CONFIG_GENERIC_CMOS_UPDATE=y
CONFIG_HAVE_POSIX_CPU_TIMERS_TASK_WORK=y
CONFIG_CONTEXT_TRACKING=y
CONFIG_CONTEXT_TRACKING_IDLE=y

#
# Timers subsystem
#
CONFIG_HZ_PERIODIC=y
# CONFIG_NO_HZ_IDLE is not set
# CONFIG_NO_HZ is not set
# CONFIG_HIGH_RES_TIMERS is not set
CONFIG_CLOCKSOURCE_WATCHDOG_MAX_SKEW_US=100
# end of Timers subsystem

CONFIG_BPF=y
CONFIG_HAVE_EBPF_JIT=y

#
# BPF subsystem
#
# CONFIG_BPF_SYSCALL is not set
# CONFIG_BPF_JIT is not set
# end of BPF subsystem

CONFIG_PREEMPT_VOLUNTARY_BUILD=y
# CONFIG_PREEMPT_NONE is not set
CONFIG_PREEMPT_VOLUNTARY=y
# CONFIG_PREEMPT is not set
CONFIG_PREEMPT_COUNT=y
# CONFIG_PREEMPT_DYNAMIC is not set
# CONFIG_SCHED_CORE is not set

#
# CPU/Task time and stats accounting
#
CONFIG_TICK_CPU_ACCOUNTING=y
CONFIG_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_SCHED_AVG_IRQ=y
# CONFIG_BSD_PROCESS_ACCT is not set
# CONFIG_TASKSTATS is not set
# CONFIG_PSI is not set
# end of CPU/Task time and stats accounting

CONFIG_CPU_ISOLATION=y

#
# RCU Subsystem
#
CONFIG_TREE_RCU=y
CONFIG_RCU_EXPERT=y
CONFIG_SRCU=y
CONFIG_TREE_SRCU=y
CONFIG_TASKS_RCU_GENERIC=y
CONFIG_FORCE_TASKS_RCU=y
CONFIG_TASKS_RCU=y
CONFIG_FORCE_TASKS_RUDE_RCU=y
CONFIG_TASKS_RUDE_RCU=y
CONFIG_FORCE_TASKS_TRACE_RCU=y
CONFIG_TASKS_TRACE_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
CONFIG_RCU_FANOUT=32
CONFIG_RCU_FANOUT_LEAF=16
# CONFIG_RCU_NOCB_CPU is not set
# CONFIG_TASKS_TRACE_RCU_READ_MB is not set
# end of RCU Subsystem

CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
# CONFIG_IKHEADERS is not set
CONFIG_LOG_BUF_SHIFT=20
CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
CONFIG_PRINTK_INDEX=y
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y

#
# Scheduler features
#
# CONFIG_UCLAMP_TASK is not set
# end of Scheduler features

CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_CC_IMPLICIT_FALLTHROUGH="-Wimplicit-fallthrough=5"
CONFIG_GCC12_NO_ARRAY_BOUNDS=y
CONFIG_CGROUPS=y
CONFIG_PAGE_COUNTER=y
# CONFIG_CGROUP_FAVOR_DYNMODS is not set
CONFIG_MEMCG=y
CONFIG_MEMCG_KMEM=y
# CONFIG_BLK_CGROUP is not set
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
# CONFIG_CFS_BANDWIDTH is not set
# CONFIG_RT_GROUP_SCHED is not set
# CONFIG_CGROUP_PIDS is not set
# CONFIG_CGROUP_RDMA is not set
CONFIG_CGROUP_FREEZER=y
CONFIG_CGROUP_HUGETLB=y
# CONFIG_CPUSETS is not set
CONFIG_CGROUP_DEVICE=y
CONFIG_CGROUP_CPUACCT=y
# CONFIG_CGROUP_PERF is not set
# CONFIG_CGROUP_MISC is not set
CONFIG_CGROUP_DEBUG=y
# CONFIG_NAMESPACES is not set
CONFIG_CHECKPOINT_RESTORE=y
CONFIG_SCHED_AUTOGROUP=y
# CONFIG_SYSFS_DEPRECATED is not set
# CONFIG_RELAY is not set
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
CONFIG_RD_BZIP2=y
# CONFIG_RD_LZMA is not set
# CONFIG_RD_XZ is not set
CONFIG_RD_LZO=y
# CONFIG_RD_LZ4 is not set
# CONFIG_RD_ZSTD is not set
# CONFIG_BOOT_CONFIG is not set
CONFIG_INITRAMFS_PRESERVE_MTIME=y
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_LD_ORPHAN_WARN=y
CONFIG_SYSCTL=y
CONFIG_HAVE_UID16=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
CONFIG_EXPERT=y
# CONFIG_UID16 is not set
CONFIG_MULTIUSER=y
CONFIG_SGETMASK_SYSCALL=y
CONFIG_SYSFS_SYSCALL=y
CONFIG_FHANDLE=y
# CONFIG_POSIX_TIMERS is not set
CONFIG_PRINTK=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
# CONFIG_PCSPKR_PLATFORM is not set
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
# CONFIG_AIO is not set
CONFIG_IO_URING=y
CONFIG_ADVISE_SYSCALLS=y
# CONFIG_MEMBARRIER is not set
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
CONFIG_KCMP=y
# CONFIG_RSEQ is not set
# CONFIG_EMBEDDED is not set
CONFIG_HAVE_PERF_EVENTS=y
CONFIG_PC104=y

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
# end of Kernel Performance Events And Counters

CONFIG_SYSTEM_DATA_VERIFICATION=y
CONFIG_PROFILING=y
CONFIG_TRACEPOINTS=y
# end of General setup

CONFIG_X86_32=y
CONFIG_X86=y
CONFIG_INSTRUCTION_DECODER=y
CONFIG_OUTPUT_FORMAT="elf32-i386"
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_MMU=y
CONFIG_ARCH_MMAP_RND_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_BITS_MAX=16
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_BUG=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ARCH_HAS_CPU_RELAX=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_NR_GPIO=512
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_X86_32_SMP=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_PGTABLE_LEVELS=2
CONFIG_CC_HAS_SANE_STACKPROTECTOR=y

#
# Processor type and features
#
CONFIG_SMP=y
CONFIG_X86_FEATURE_NAMES=y
CONFIG_X86_MPPARSE=y
CONFIG_GOLDFISH=y
# CONFIG_X86_CPU_RESCTRL is not set
# CONFIG_X86_BIGSMP is not set
CONFIG_X86_EXTENDED_PLATFORM=y
# CONFIG_X86_GOLDFISH is not set
# CONFIG_X86_INTEL_MID is not set
CONFIG_X86_INTEL_QUARK=y
# CONFIG_X86_INTEL_LPSS is not set
# CONFIG_X86_AMD_PLATFORM_DEVICE is not set
CONFIG_IOSF_MBI=y
# CONFIG_IOSF_MBI_DEBUG is not set
CONFIG_X86_RDC321X=y
CONFIG_X86_32_NON_STANDARD=y
CONFIG_X86_SUPPORTS_MEMORY_FAILURE=y
CONFIG_STA2X11=y
CONFIG_X86_32_IRIS=y
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
CONFIG_PARAVIRT_DEBUG=y
CONFIG_PARAVIRT_SPINLOCKS=y
CONFIG_X86_HV_CALLBACK_VECTOR=y
CONFIG_KVM_GUEST=y
CONFIG_ARCH_CPUIDLE_HALTPOLL=y
CONFIG_PVH=y
# CONFIG_PARAVIRT_TIME_ACCOUNTING is not set
CONFIG_PARAVIRT_CLOCK=y
# CONFIG_M486SX is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
CONFIG_M686=y
# CONFIG_MPENTIUMII is not set
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUMM is not set
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MK8 is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MEFFICEON is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MELAN is not set
# CONFIG_MGEODEGX1 is not set
# CONFIG_MGEODE_LX is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
# CONFIG_MVIAC7 is not set
# CONFIG_MCORE2 is not set
# CONFIG_MATOM is not set
# CONFIG_X86_GENERIC is not set
CONFIG_X86_INTERNODE_CACHE_SHIFT=5
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_TSC=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_CMOV=y
CONFIG_X86_MINIMUM_CPU_FAMILY=6
CONFIG_X86_DEBUGCTLMSR=y
CONFIG_IA32_FEAT_CTL=y
CONFIG_X86_VMX_FEATURE_NAMES=y
CONFIG_PROCESSOR_SELECT=y
CONFIG_CPU_SUP_INTEL=y
# CONFIG_CPU_SUP_CYRIX_32 is not set
# CONFIG_CPU_SUP_AMD is not set
# CONFIG_CPU_SUP_HYGON is not set
# CONFIG_CPU_SUP_CENTAUR is not set
# CONFIG_CPU_SUP_TRANSMETA_32 is not set
# CONFIG_CPU_SUP_UMC_32 is not set
# CONFIG_CPU_SUP_ZHAOXIN is not set
CONFIG_CPU_SUP_VORTEX_32=y
CONFIG_HPET_TIMER=y
# CONFIG_DMI is not set
CONFIG_BOOT_VESA_SUPPORT=y
CONFIG_NR_CPUS_RANGE_BEGIN=2
CONFIG_NR_CPUS_RANGE_END=8
CONFIG_NR_CPUS_DEFAULT=8
CONFIG_NR_CPUS=8
# CONFIG_SCHED_CLUSTER is not set
CONFIG_SCHED_SMT=y
# CONFIG_SCHED_MC is not set
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
# CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS is not set
CONFIG_X86_MCE=y
# CONFIG_X86_MCELOG_LEGACY is not set
CONFIG_X86_MCE_INTEL=y
# CONFIG_X86_ANCIENT_MCE is not set
CONFIG_X86_MCE_THRESHOLD=y
# CONFIG_X86_MCE_INJECT is not set

#
# Performance monitoring
#
# CONFIG_PERF_EVENTS_INTEL_UNCORE is not set
CONFIG_PERF_EVENTS_INTEL_RAPL=y
CONFIG_PERF_EVENTS_INTEL_CSTATE=y
# end of Performance monitoring

CONFIG_X86_LEGACY_VM86=y
CONFIG_VM86=y
# CONFIG_X86_16BIT is not set
# CONFIG_X86_IOPL_IOPERM is not set
CONFIG_TOSHIBA=y
CONFIG_X86_REBOOTFIXUPS=y
CONFIG_MICROCODE=y
CONFIG_MICROCODE_INTEL=y
CONFIG_MICROCODE_LATE_LOADING=y
CONFIG_X86_MSR=y
# CONFIG_X86_CPUID is not set
# CONFIG_NOHIGHMEM is not set
CONFIG_HIGHMEM4G=y
# CONFIG_HIGHMEM64G is not set
CONFIG_VMSPLIT_3G=y
# CONFIG_VMSPLIT_3G_OPT is not set
# CONFIG_VMSPLIT_2G is not set
# CONFIG_VMSPLIT_2G_OPT is not set
# CONFIG_VMSPLIT_1G is not set
CONFIG_PAGE_OFFSET=0xC0000000
CONFIG_HIGHMEM=y
# CONFIG_X86_CPA_STATISTICS is not set
CONFIG_ARCH_FLATMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
CONFIG_ILLEGAL_POINTER_VALUE=0
CONFIG_HIGHPTE=y
# CONFIG_X86_CHECK_BIOS_CORRUPTION is not set
# CONFIG_MTRR is not set
CONFIG_X86_UMIP=y
CONFIG_CC_HAS_IBT=y
CONFIG_X86_INTEL_TSX_MODE_OFF=y
# CONFIG_X86_INTEL_TSX_MODE_ON is not set
# CONFIG_X86_INTEL_TSX_MODE_AUTO is not set
# CONFIG_EFI is not set
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
CONFIG_HZ_1000=y
CONFIG_HZ=1000
CONFIG_KEXEC=y
# CONFIG_CRASH_DUMP is not set
CONFIG_PHYSICAL_START=0x1000000
# CONFIG_RELOCATABLE is not set
CONFIG_PHYSICAL_ALIGN=0x200000
CONFIG_HOTPLUG_CPU=y
# CONFIG_BOOTPARAM_HOTPLUG_CPU0 is not set
# CONFIG_DEBUG_HOTPLUG_CPU0 is not set
# CONFIG_COMPAT_VDSO is not set
# CONFIG_CMDLINE_BOOL is not set
CONFIG_MODIFY_LDT_SYSCALL=y
CONFIG_STRICT_SIGALTSTACK_SIZE=y
# end of Processor type and features

CONFIG_CC_HAS_SLS=y
CONFIG_CC_HAS_RETURN_THUNK=y
# CONFIG_SPECULATION_MITIGATIONS is not set
CONFIG_ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE=y

#
# Power management and ACPI options
#
# CONFIG_SUSPEND is not set
# CONFIG_HIBERNATION is not set
# CONFIG_PM is not set
# CONFIG_ENERGY_MODEL is not set
CONFIG_ARCH_SUPPORTS_ACPI=y
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
CONFIG_ACPI_TABLE_LIB=y
# CONFIG_ACPI_DEBUGGER is not set
CONFIG_ACPI_SPCR_TABLE=y
CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
# CONFIG_ACPI_EC_DEBUGFS is not set
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_FAN=y
# CONFIG_ACPI_DOCK is not set
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_HOTPLUG_CPU=y
# CONFIG_ACPI_PROCESSOR_AGGREGATOR is not set
CONFIG_ACPI_THERMAL=y
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
# CONFIG_ACPI_DEBUG is not set
# CONFIG_ACPI_PCI_SLOT is not set
CONFIG_ACPI_CONTAINER=y
CONFIG_ACPI_HOTPLUG_IOAPIC=y
# CONFIG_ACPI_SBS is not set
# CONFIG_ACPI_HED is not set
# CONFIG_ACPI_CUSTOM_METHOD is not set
# CONFIG_ACPI_REDUCED_HARDWARE_ONLY is not set
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
# CONFIG_ACPI_APEI is not set
# CONFIG_ACPI_DPTF is not set
# CONFIG_ACPI_CONFIGFS is not set
# CONFIG_PMIC_OPREGION is not set
CONFIG_X86_PM_TIMER=y

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_GOV_ATTR_SET=y
CONFIG_CPU_FREQ_GOV_COMMON=y
# CONFIG_CPU_FREQ_STAT is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE is not set
CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=y
CONFIG_CPU_FREQ_GOV_USERSPACE=y
CONFIG_CPU_FREQ_GOV_ONDEMAND=y
# CONFIG_CPU_FREQ_GOV_CONSERVATIVE is not set
CONFIG_CPU_FREQ_GOV_SCHEDUTIL=y

#
# CPU frequency scaling drivers
#
CONFIG_CPUFREQ_DT=y
CONFIG_CPUFREQ_DT_PLATDEV=y
CONFIG_X86_INTEL_PSTATE=y
# CONFIG_X86_PCC_CPUFREQ is not set
# CONFIG_X86_AMD_PSTATE is not set
# CONFIG_X86_AMD_PSTATE_UT is not set
# CONFIG_X86_ACPI_CPUFREQ is not set
CONFIG_X86_POWERNOW_K6=y
CONFIG_X86_POWERNOW_K7=y
CONFIG_X86_POWERNOW_K7_ACPI=y
# CONFIG_X86_GX_SUSPMOD is not set
CONFIG_X86_SPEEDSTEP_CENTRINO=y
CONFIG_X86_SPEEDSTEP_CENTRINO_TABLE=y
CONFIG_X86_SPEEDSTEP_ICH=y
CONFIG_X86_SPEEDSTEP_SMI=y
CONFIG_X86_P4_CLOCKMOD=y
CONFIG_X86_CPUFREQ_NFORCE2=y
CONFIG_X86_LONGRUN=y
# CONFIG_X86_LONGHAUL is not set
# CONFIG_X86_E_POWERSAVER is not set

#
# shared options
#
CONFIG_X86_SPEEDSTEP_LIB=y
CONFIG_X86_SPEEDSTEP_RELAXED_CAP_CHECK=y
# end of CPU Frequency scaling

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
CONFIG_CPU_IDLE_GOV_LADDER=y
# CONFIG_CPU_IDLE_GOV_MENU is not set
# CONFIG_CPU_IDLE_GOV_TEO is not set
# CONFIG_CPU_IDLE_GOV_HALTPOLL is not set
CONFIG_HALTPOLL_CPUIDLE=y
# end of CPU Idle

# CONFIG_INTEL_IDLE is not set
# end of Power management and ACPI options

#
# Bus options (PCI etc.)
#
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GOMMCONFIG is not set
# CONFIG_PCI_GODIRECT is not set
# CONFIG_PCI_GOOLPC is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_PCI_OLPC=y
# CONFIG_PCI_CNB20LE_QUIRK is not set
# CONFIG_ISA_BUS is not set
CONFIG_ISA_DMA_API=y
# CONFIG_ISA is not set
# CONFIG_SCx200 is not set
CONFIG_OLPC=y
# CONFIG_OLPC_XO15_SCI is not set
CONFIG_ALIX=y
CONFIG_NET5501=y
# end of Bus options (PCI etc.)

#
# Binary Emulations
#
CONFIG_COMPAT_32=y
# end of Binary Emulations

CONFIG_HAVE_ATOMIC_IOMAP=y
CONFIG_HAVE_KVM=y
CONFIG_VIRTUALIZATION=y
CONFIG_AS_AVX512=y
CONFIG_AS_SHA1_NI=y
CONFIG_AS_SHA256_NI=y
CONFIG_AS_TPAUSE=y

#
# General architecture-dependent options
#
CONFIG_CRASH_CORE=y
CONFIG_KEXEC_CORE=y
CONFIG_HOTPLUG_SMT=y
CONFIG_GENERIC_ENTRY=y
CONFIG_KPROBES=y
CONFIG_JUMP_LABEL=y
# CONFIG_STATIC_KEYS_SELFTEST is not set
# CONFIG_STATIC_CALL_SELFTEST is not set
CONFIG_OPTPROBES=y
CONFIG_UPROBES=y
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_KRETPROBES=y
CONFIG_KRETPROBE_ON_RETHOOK=y
CONFIG_HAVE_IOREMAP_PROT=y
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
CONFIG_HAVE_OPTPROBES=y
CONFIG_HAVE_KPROBES_ON_FTRACE=y
CONFIG_ARCH_CORRECT_STACKTRACE_ON_KRETPROBE=y
CONFIG_HAVE_FUNCTION_ERROR_INJECTION=y
CONFIG_HAVE_NMI=y
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_TRACE_IRQFLAGS_NMI_SUPPORT=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_HAVE_DMA_CONTIGUOUS=y
CONFIG_GENERIC_SMP_IDLE_THREAD=y
CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
CONFIG_ARCH_HAS_SET_MEMORY=y
CONFIG_ARCH_HAS_SET_DIRECT_MAP=y
CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=y
CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
CONFIG_ARCH_WANTS_NO_INSTR=y
CONFIG_ARCH_32BIT_OFF_T=y
CONFIG_HAVE_ASM_MODVERSIONS=y
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
CONFIG_HAVE_RSEQ=y
CONFIG_HAVE_FUNCTION_ARG_ACCESS_API=y
CONFIG_HAVE_HW_BREAKPOINT=y
CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
CONFIG_HAVE_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_PERF_EVENTS_NMI=y
CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HAVE_PERF_REGS=y
CONFIG_HAVE_PERF_USER_STACK_DUMP=y
CONFIG_HAVE_ARCH_JUMP_LABEL=y
CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE=y
CONFIG_MMU_GATHER_TABLE_FREE=y
CONFIG_MMU_GATHER_RCU_TABLE_FREE=y
CONFIG_MMU_GATHER_MERGE_VMAS=y
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_HAVE_ALIGNED_STRUCT_PAGE=y
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_ARCH_WANT_IPC_PARSE_VERSION=y
CONFIG_HAVE_ARCH_SECCOMP=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
# CONFIG_SECCOMP is not set
CONFIG_HAVE_ARCH_STACKLEAK=y
CONFIG_HAVE_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR_STRONG=y
CONFIG_ARCH_SUPPORTS_LTO_CLANG=y
CONFIG_ARCH_SUPPORTS_LTO_CLANG_THIN=y
CONFIG_LTO_NONE=y
CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_MOVE_PUD=y
CONFIG_HAVE_MOVE_PMD=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
CONFIG_MODULES_USE_ELF_REL=y
CONFIG_HAVE_SOFTIRQ_ON_OWN_STACK=y
CONFIG_SOFTIRQ_ON_OWN_STACK=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_ARCH_MMAP_RND_BITS=8
CONFIG_PAGE_SIZE_LESS_THAN_64KB=y
CONFIG_PAGE_SIZE_LESS_THAN_256KB=y
CONFIG_ISA_BUS_API=y
CONFIG_CLONE_BACKWARDS=y
CONFIG_OLD_SIGSUSPEND3=y
CONFIG_OLD_SIGACTION=y
CONFIG_COMPAT_32BIT_TIME=y
CONFIG_HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET=y
CONFIG_RANDOMIZE_KSTACK_OFFSET=y
CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT=y
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_STRICT_MODULE_RWX=y
CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y
# CONFIG_LOCK_EVENT_COUNTS is not set
CONFIG_ARCH_HAS_MEM_ENCRYPT=y
CONFIG_HAVE_STATIC_CALL=y
CONFIG_HAVE_PREEMPT_DYNAMIC=y
CONFIG_HAVE_PREEMPT_DYNAMIC_CALL=y
CONFIG_ARCH_WANT_LD_ORPHAN_WARN=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_ARCH_SPLIT_ARG64=y
CONFIG_ARCH_HAS_PARANOID_L1D_FLUSH=y
CONFIG_DYNAMIC_SIGFRAME=y

#
# GCOV-based kernel profiling
#
CONFIG_GCOV_KERNEL=y
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
CONFIG_GCOV_PROFILE_ALL=y
# end of GCOV-based kernel profiling

CONFIG_HAVE_GCC_PLUGINS=y
CONFIG_GCC_PLUGINS=y
CONFIG_GCC_PLUGIN_LATENT_ENTROPY=y
# end of General architecture-dependent options

CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
CONFIG_MODULES=y
# CONFIG_MODULE_FORCE_LOAD is not set
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
# CONFIG_MODULE_UNLOAD_TAINT_TRACKING is not set
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
# CONFIG_MODULE_SIG is not set
CONFIG_MODULE_COMPRESS_NONE=y
# CONFIG_MODULE_COMPRESS_GZIP is not set
# CONFIG_MODULE_COMPRESS_XZ is not set
# CONFIG_MODULE_COMPRESS_ZSTD is not set
# CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS is not set
CONFIG_MODPROBE_PATH="/sbin/modprobe"
# CONFIG_TRIM_UNUSED_KSYMS is not set
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
# CONFIG_BLOCK_LEGACY_AUTOLOAD is not set
CONFIG_BLK_DEV_BSG_COMMON=y
CONFIG_BLK_ICQ=y
CONFIG_BLK_DEV_BSGLIB=y
# CONFIG_BLK_DEV_INTEGRITY is not set
# CONFIG_BLK_DEV_ZONED is not set
# CONFIG_BLK_WBT is not set
CONFIG_BLK_DEBUG_FS=y
# CONFIG_BLK_SED_OPAL is not set
# CONFIG_BLK_INLINE_ENCRYPTION is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_AMIGA_PARTITION=y
CONFIG_MSDOS_PARTITION=y
CONFIG_EFI_PARTITION=y
# end of Partition Types

CONFIG_BLK_MQ_PCI=y
CONFIG_BLK_MQ_VIRTIO=y

#
# IO Schedulers
#
CONFIG_MQ_IOSCHED_DEADLINE=y
CONFIG_MQ_IOSCHED_KYBER=y
CONFIG_IOSCHED_BFQ=y
# end of IO Schedulers

CONFIG_PADATA=y
CONFIG_ASN1=y
CONFIG_UNINLINE_SPIN_UNLOCK=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_MUTEX_SPIN_ON_OWNER=y
CONFIG_RWSEM_SPIN_ON_OWNER=y
CONFIG_LOCK_SPIN_ON_OWNER=y
CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
CONFIG_QUEUED_SPINLOCKS=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
CONFIG_QUEUED_RWLOCKS=y
CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE=y
CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y
CONFIG_ARCH_HAS_SYSCALL_WRAPPER=y
CONFIG_FREEZER=y

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_ELFCORE=y
CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=y
CONFIG_BINFMT_SCRIPT=y
# CONFIG_BINFMT_MISC is not set
CONFIG_COREDUMP=y
# end of Executable file formats

#
# Memory Management options
#
CONFIG_SWAP=y
# CONFIG_ZSWAP is not set

#
# SLAB allocator options
#
# CONFIG_SLAB is not set
CONFIG_SLUB=y
# CONFIG_SLOB is not set
CONFIG_SLUB_TINY=y
CONFIG_SLAB_MERGE_DEFAULT=y
# end of SLAB allocator options

CONFIG_SHUFFLE_PAGE_ALLOCATOR=y
CONFIG_COMPAT_BRK=y
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_FLATMEM_MANUAL=y
# CONFIG_SPARSEMEM_MANUAL is not set
CONFIG_FLATMEM=y
CONFIG_SPARSEMEM_STATIC=y
CONFIG_HAVE_FAST_GUP=y
CONFIG_MEMORY_ISOLATION=y
CONFIG_EXCLUSIVE_SYSTEM_RAM=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_MEMORY_BALLOON=y
# CONFIG_COMPACTION is not set
CONFIG_PAGE_REPORTING=y
CONFIG_MIGRATION=y
CONFIG_CONTIG_ALLOC=y
# CONFIG_BOUNCE is not set
CONFIG_KSM=y
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=y
CONFIG_MEMORY_FAILURE=y
CONFIG_HWPOISON_INJECT=y
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
# CONFIG_TRANSPARENT_HUGEPAGE is not set
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
CONFIG_CMA=y
# CONFIG_CMA_DEBUG is not set
CONFIG_CMA_DEBUGFS=y
# CONFIG_CMA_SYSFS is not set
CONFIG_CMA_AREAS=7
CONFIG_GENERIC_EARLY_IOREMAP=y
CONFIG_PAGE_IDLE_FLAG=y
CONFIG_IDLE_PAGE_TRACKING=y
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_ARCH_HAS_CURRENT_STACK_POINTER=y
CONFIG_ARCH_HAS_ZONE_DMA_SET=y
# CONFIG_ZONE_DMA is not set
# CONFIG_VM_EVENT_COUNTERS is not set
# CONFIG_PERCPU_STATS is not set
# CONFIG_GUP_TEST is not set
CONFIG_ARCH_HAS_PTE_SPECIAL=y
CONFIG_KMAP_LOCAL=y
CONFIG_SECRETMEM=y
CONFIG_ANON_VMA_NAME=y
# CONFIG_USERFAULTFD is not set
CONFIG_LRU_GEN=y
# CONFIG_LRU_GEN_ENABLED is not set
# CONFIG_LRU_GEN_STATS is not set

#
# Data Access Monitoring
#
# CONFIG_DAMON is not set
# end of Data Access Monitoring
# end of Memory Management options

CONFIG_NET=y

#
# Networking options
#
CONFIG_PACKET=y
# CONFIG_PACKET_DIAG is not set
CONFIG_UNIX=y
CONFIG_UNIX_SCM=y
CONFIG_AF_UNIX_OOB=y
# CONFIG_UNIX_DIAG is not set
# CONFIG_TLS is not set
# CONFIG_XFRM_USER is not set
# CONFIG_NET_KEY is not set
CONFIG_INET=y
# CONFIG_IP_MULTICAST is not set
# CONFIG_IP_ADVANCED_ROUTER is not set
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
# CONFIG_IP_PNP_BOOTP is not set
# CONFIG_IP_PNP_RARP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE_DEMUX is not set
CONFIG_NET_IP_TUNNEL=y
# CONFIG_SYN_COOKIES is not set
# CONFIG_NET_IPVTI is not set
# CONFIG_NET_FOU is not set
# CONFIG_NET_FOU_IP_TUNNELS is not set
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set
CONFIG_INET_TUNNEL=y
CONFIG_INET_DIAG=y
CONFIG_INET_TCP_DIAG=y
# CONFIG_INET_UDP_DIAG is not set
# CONFIG_INET_RAW_DIAG is not set
# CONFIG_INET_DIAG_DESTROY is not set
# CONFIG_TCP_CONG_ADVANCED is not set
CONFIG_TCP_CONG_CUBIC=y
CONFIG_DEFAULT_TCP_CONG="cubic"
# CONFIG_TCP_MD5SIG is not set
CONFIG_IPV6=y
# CONFIG_IPV6_ROUTER_PREF is not set
# CONFIG_IPV6_OPTIMISTIC_DAD is not set
# CONFIG_INET6_AH is not set
# CONFIG_INET6_ESP is not set
# CONFIG_INET6_IPCOMP is not set
# CONFIG_IPV6_MIP6 is not set
# CONFIG_IPV6_VTI is not set
CONFIG_IPV6_SIT=y
# CONFIG_IPV6_SIT_6RD is not set
CONFIG_IPV6_NDISC_NODETYPE=y
# CONFIG_IPV6_TUNNEL is not set
# CONFIG_IPV6_MULTIPLE_TABLES is not set
# CONFIG_IPV6_MROUTE is not set
# CONFIG_IPV6_SEG6_LWTUNNEL is not set
# CONFIG_IPV6_SEG6_HMAC is not set
# CONFIG_IPV6_RPL_LWTUNNEL is not set
# CONFIG_IPV6_IOAM6_LWTUNNEL is not set
# CONFIG_NETLABEL is not set
# CONFIG_MPTCP is not set
# CONFIG_NETWORK_SECMARK is not set
# CONFIG_NETWORK_PHY_TIMESTAMPING is not set
# CONFIG_NETFILTER is not set
# CONFIG_BPFILTER is not set
# CONFIG_IP_DCCP is not set
# CONFIG_IP_SCTP is not set
# CONFIG_RDS is not set
# CONFIG_TIPC is not set
# CONFIG_ATM is not set
# CONFIG_L2TP is not set
# CONFIG_BRIDGE is not set
# CONFIG_NET_DSA is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_LLC2 is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_PHONET is not set
# CONFIG_6LOWPAN is not set
# CONFIG_IEEE802154 is not set
# CONFIG_NET_SCHED is not set
# CONFIG_DCB is not set
CONFIG_DNS_RESOLVER=m
# CONFIG_BATMAN_ADV is not set
# CONFIG_OPENVSWITCH is not set
# CONFIG_VSOCKETS is not set
# CONFIG_NETLINK_DIAG is not set
# CONFIG_MPLS is not set
# CONFIG_NET_NSH is not set
# CONFIG_HSR is not set
# CONFIG_NET_SWITCHDEV is not set
# CONFIG_NET_L3_MASTER_DEV is not set
# CONFIG_QRTR is not set
# CONFIG_NET_NCSI is not set
CONFIG_PCPU_DEV_REFCNT=y
CONFIG_RPS=y
CONFIG_RFS_ACCEL=y
CONFIG_SOCK_RX_QUEUE_MAPPING=y
CONFIG_XPS=y
# CONFIG_CGROUP_NET_PRIO is not set
# CONFIG_CGROUP_NET_CLASSID is not set
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
CONFIG_NET_FLOW_LIMIT=y

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_NET_DROP_MONITOR is not set
# end of Network testing
# end of Networking options

# CONFIG_HAMRADIO is not set
# CONFIG_CAN is not set
# CONFIG_BT is not set
# CONFIG_AF_RXRPC is not set
# CONFIG_AF_KCM is not set
# CONFIG_MCTP is not set
CONFIG_WIRELESS=y
# CONFIG_CFG80211 is not set

#
# CFG80211 needs to be enabled for MAC80211
#
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
# CONFIG_RFKILL is not set
CONFIG_NET_9P=y
CONFIG_NET_9P_FD=y
CONFIG_NET_9P_VIRTIO=y
# CONFIG_NET_9P_DEBUG is not set
# CONFIG_CAIF is not set
# CONFIG_CEPH_LIB is not set
# CONFIG_NFC is not set
# CONFIG_PSAMPLE is not set
# CONFIG_NET_IFE is not set
# CONFIG_LWTUNNEL is not set
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
CONFIG_FAILOVER=m
CONFIG_ETHTOOL_NETLINK=y

#
# Device Drivers
#
CONFIG_HAVE_EISA=y
# CONFIG_EISA is not set
CONFIG_HAVE_PCI=y
CONFIG_PCI=y
CONFIG_PCI_DOMAINS=y
# CONFIG_PCIEPORTBUS is not set
# CONFIG_PCIEASPM is not set
# CONFIG_PCIE_PTM is not set
# CONFIG_PCI_MSI is not set
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
CONFIG_PCI_REALLOC_ENABLE_AUTO=y
CONFIG_PCI_STUB=y
CONFIG_PCI_PF_STUB=y
CONFIG_PCI_ATS=y
CONFIG_PCI_DOE=y
CONFIG_PCI_ECAM=y
CONFIG_PCI_LOCKLESS_CONFIG=y
CONFIG_PCI_IOV=y
# CONFIG_PCI_PRI is not set
CONFIG_PCI_PASID=y
CONFIG_PCI_LABEL=y
# CONFIG_PCIE_BUS_TUNE_OFF is not set
CONFIG_PCIE_BUS_DEFAULT=y
# CONFIG_PCIE_BUS_SAFE is not set
# CONFIG_PCIE_BUS_PERFORMANCE is not set
# CONFIG_PCIE_BUS_PEER2PEER is not set
# CONFIG_VGA_ARB is not set
# CONFIG_HOTPLUG_PCI is not set

#
# PCI controller drivers
#
# CONFIG_PCI_FTPCI100 is not set
CONFIG_PCI_HOST_COMMON=y
CONFIG_PCI_HOST_GENERIC=y

#
# DesignWare PCI Core Support
#
# end of DesignWare PCI Core Support

#
# Mobiveil PCIe Core Support
#
# end of Mobiveil PCIe Core Support

#
# Cadence PCIe controllers support
#
# CONFIG_PCIE_CADENCE_PLAT_HOST is not set
# CONFIG_PCI_J721E_HOST is not set
# end of Cadence PCIe controllers support
# end of PCI controller drivers

#
# PCI Endpoint
#
# CONFIG_PCI_ENDPOINT is not set
# end of PCI Endpoint

#
# PCI switch controller drivers
#
CONFIG_PCI_SW_SWITCHTEC=y
# end of PCI switch controller drivers

CONFIG_CXL_BUS=y
CONFIG_CXL_PCI=y
# CONFIG_CXL_MEM_RAW_COMMANDS is not set
CONFIG_CXL_ACPI=y
CONFIG_CXL_MEM=y
CONFIG_CXL_PORT=y
CONFIG_PCCARD=y
CONFIG_PCMCIA=y
CONFIG_PCMCIA_LOAD_CIS=y
# CONFIG_CARDBUS is not set

#
# PC-card bridges
#
# CONFIG_YENTA is not set
# CONFIG_PD6729 is not set
CONFIG_I82092=y
CONFIG_PCCARD_NONSTATIC=y
# CONFIG_RAPIDIO is not set

#
# Generic Driver Options
#
CONFIG_AUXILIARY_BUS=y
# CONFIG_UEVENT_HELPER is not set
CONFIG_DEVTMPFS=y
# CONFIG_DEVTMPFS_MOUNT is not set
# CONFIG_DEVTMPFS_SAFE is not set
CONFIG_STANDALONE=y
# CONFIG_PREVENT_FIRMWARE_BUILD is not set

#
# Firmware loader
#
CONFIG_FW_LOADER=y
CONFIG_FW_LOADER_PAGED_BUF=y
CONFIG_FW_LOADER_SYSFS=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y
# CONFIG_FW_LOADER_COMPRESS is not set
CONFIG_FW_UPLOAD=y
# end of Firmware loader

CONFIG_WANT_DEV_COREDUMP=y
# CONFIG_ALLOW_DEV_COREDUMP is not set
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=y
CONFIG_REGMAP_SPI=y
CONFIG_REGMAP_SPMI=y
CONFIG_REGMAP_W1=y
CONFIG_REGMAP_MMIO=y
CONFIG_REGMAP_IRQ=y
CONFIG_DMA_SHARED_BUFFER=y
# CONFIG_DMA_FENCE_TRACE is not set
# end of Generic Driver Options

#
# Bus devices
#
# CONFIG_MOXTET is not set
CONFIG_MHI_BUS=y
CONFIG_MHI_BUS_DEBUG=y
# CONFIG_MHI_BUS_PCI_GENERIC is not set
CONFIG_MHI_BUS_EP=y
# end of Bus devices

# CONFIG_CONNECTOR is not set

#
# Firmware Drivers
#

#
# ARM System Control and Management Interface Protocol
#
# end of ARM System Control and Management Interface Protocol

CONFIG_EDD=y
CONFIG_EDD_OFF=y
# CONFIG_FIRMWARE_MEMMAP is not set
# CONFIG_ISCSI_IBFT is not set
CONFIG_FW_CFG_SYSFS=y
# CONFIG_FW_CFG_SYSFS_CMDLINE is not set
CONFIG_SYSFB=y
CONFIG_SYSFB_SIMPLEFB=y
# CONFIG_GOOGLE_FIRMWARE is not set

#
# Tegra firmware driver
#
# end of Tegra firmware driver
# end of Firmware Drivers

# CONFIG_GNSS is not set
CONFIG_MTD=y
# CONFIG_MTD_TESTS is not set

#
# Partition parsers
#
CONFIG_MTD_AR7_PARTS=y
CONFIG_MTD_CMDLINE_PARTS=y
CONFIG_MTD_OF_PARTS=y
CONFIG_MTD_REDBOOT_PARTS=y
CONFIG_MTD_REDBOOT_DIRECTORY_BLOCK=-1
CONFIG_MTD_REDBOOT_PARTS_UNALLOCATED=y
CONFIG_MTD_REDBOOT_PARTS_READONLY=y
# end of Partition parsers

#
# User Modules And Translation Layers
#
CONFIG_MTD_BLKDEVS=y
# CONFIG_MTD_BLOCK is not set
CONFIG_MTD_BLOCK_RO=y

#
# Note that in some cases UBI block is preferred. See MTD_UBI_BLOCK.
#
CONFIG_FTL=y
# CONFIG_NFTL is not set
CONFIG_INFTL=y
CONFIG_RFD_FTL=y
CONFIG_SSFDC=y
# CONFIG_SM_FTL is not set
CONFIG_MTD_OOPS=y
CONFIG_MTD_SWAP=y
CONFIG_MTD_PARTITIONED_MASTER=y

#
# RAM/ROM/Flash chip drivers
#
CONFIG_MTD_CFI=y
CONFIG_MTD_JEDECPROBE=y
CONFIG_MTD_GEN_PROBE=y
# CONFIG_MTD_CFI_ADV_OPTIONS is not set
CONFIG_MTD_MAP_BANK_WIDTH_1=y
CONFIG_MTD_MAP_BANK_WIDTH_2=y
CONFIG_MTD_MAP_BANK_WIDTH_4=y
CONFIG_MTD_CFI_I1=y
CONFIG_MTD_CFI_I2=y
CONFIG_MTD_CFI_INTELEXT=y
CONFIG_MTD_CFI_AMDSTD=y
# CONFIG_MTD_CFI_STAA is not set
CONFIG_MTD_CFI_UTIL=y
CONFIG_MTD_RAM=y
CONFIG_MTD_ROM=y
CONFIG_MTD_ABSENT=y
# end of RAM/ROM/Flash chip drivers

#
# Mapping drivers for chip access
#
CONFIG_MTD_COMPLEX_MAPPINGS=y
# CONFIG_MTD_PHYSMAP is not set
# CONFIG_MTD_SBC_GXX is not set
# CONFIG_MTD_AMD76XROM is not set
CONFIG_MTD_ICHXROM=y
CONFIG_MTD_ESB2ROM=y
CONFIG_MTD_CK804XROM=y
# CONFIG_MTD_SCB2_FLASH is not set
# CONFIG_MTD_NETtel is not set
CONFIG_MTD_L440GX=y
# CONFIG_MTD_PCI is not set
CONFIG_MTD_PCMCIA=y
# CONFIG_MTD_PCMCIA_ANONYMOUS is not set
# CONFIG_MTD_INTEL_VR_NOR is not set
CONFIG_MTD_PLATRAM=y
# end of Mapping drivers for chip access

#
# Self-contained MTD device drivers
#
CONFIG_MTD_PMC551=y
CONFIG_MTD_PMC551_BUGFIX=y
CONFIG_MTD_PMC551_DEBUG=y
CONFIG_MTD_DATAFLASH=y
# CONFIG_MTD_DATAFLASH_WRITE_VERIFY is not set
# CONFIG_MTD_DATAFLASH_OTP is not set
# CONFIG_MTD_MCHP23K256 is not set
CONFIG_MTD_MCHP48L640=y
CONFIG_MTD_SST25L=y
# CONFIG_MTD_SLRAM is not set
CONFIG_MTD_PHRAM=y
# CONFIG_MTD_MTDRAM is not set
CONFIG_MTD_BLOCK2MTD=y

#
# Disk-On-Chip Device Drivers
#
# CONFIG_MTD_DOCG3 is not set
# end of Self-contained MTD device drivers

#
# NAND
#
CONFIG_MTD_NAND_CORE=y
# CONFIG_MTD_ONENAND is not set
# CONFIG_MTD_RAW_NAND is not set
CONFIG_MTD_SPI_NAND=y

#
# ECC engine support
#
CONFIG_MTD_NAND_ECC=y
# CONFIG_MTD_NAND_ECC_SW_HAMMING is not set
# CONFIG_MTD_NAND_ECC_SW_BCH is not set
# CONFIG_MTD_NAND_ECC_MXIC is not set
# end of ECC engine support
# end of NAND

#
# LPDDR & LPDDR2 PCM memory drivers
#
CONFIG_MTD_LPDDR=y
CONFIG_MTD_QINFO_PROBE=y
# end of LPDDR & LPDDR2 PCM memory drivers

# CONFIG_MTD_SPI_NOR is not set
CONFIG_MTD_UBI=y
CONFIG_MTD_UBI_WL_THRESHOLD=4096
CONFIG_MTD_UBI_BEB_LIMIT=20
CONFIG_MTD_UBI_FASTMAP=y
CONFIG_MTD_UBI_GLUEBI=y
# CONFIG_MTD_UBI_BLOCK is not set
CONFIG_MTD_HYPERBUS=y
CONFIG_DTC=y
CONFIG_OF=y
# CONFIG_OF_UNITTEST is not set
CONFIG_OF_FLATTREE=y
CONFIG_OF_EARLY_FLATTREE=y
CONFIG_OF_PROMTREE=y
CONFIG_OF_KOBJ=y
CONFIG_OF_ADDRESS=y
CONFIG_OF_IRQ=y
CONFIG_OF_RESERVED_MEM=y
# CONFIG_OF_OVERLAY is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
CONFIG_PARPORT=y
CONFIG_PARPORT_PC=y
CONFIG_PARPORT_PC_FIFO=y
CONFIG_PARPORT_PC_SUPERIO=y
CONFIG_PARPORT_PC_PCMCIA=y
# CONFIG_PARPORT_AX88796 is not set
CONFIG_PARPORT_1284=y
CONFIG_PARPORT_NOT_PC=y
CONFIG_PNP=y
CONFIG_PNP_DEBUG_MESSAGES=y

#
# Protocols
#
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
# CONFIG_BLK_DEV_NULL_BLK is not set
# CONFIG_BLK_DEV_FD is not set
# CONFIG_PARIDE is not set
# CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
# CONFIG_ZRAM is not set
# CONFIG_BLK_DEV_LOOP is not set
# CONFIG_BLK_DEV_DRBD is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_RAM is not set
# CONFIG_CDROM_PKTCDVD is not set
# CONFIG_ATA_OVER_ETH is not set
# CONFIG_VIRTIO_BLK is not set
# CONFIG_BLK_DEV_RBD is not set
# CONFIG_BLK_DEV_UBLK is not set

#
# NVME Support
#
CONFIG_NVME_COMMON=y
CONFIG_NVME_CORE=y
# CONFIG_BLK_DEV_NVME is not set
# CONFIG_NVME_MULTIPATH is not set
CONFIG_NVME_VERBOSE_ERRORS=y
CONFIG_NVME_HWMON=y
CONFIG_NVME_FABRICS=y
CONFIG_NVME_FC=y
# CONFIG_NVME_TCP is not set
CONFIG_NVME_AUTH=y
# CONFIG_NVME_TARGET is not set
# end of NVME Support

#
# Misc devices
#
# CONFIG_AD525X_DPOT is not set
CONFIG_DUMMY_IRQ=y
CONFIG_IBM_ASM=y
# CONFIG_PHANTOM is not set
CONFIG_TIFM_CORE=y
CONFIG_TIFM_7XX1=y
CONFIG_ICS932S401=y
# CONFIG_ENCLOSURE_SERVICES is not set
# CONFIG_HI6421V600_IRQ is not set
# CONFIG_HP_ILO is not set
CONFIG_APDS9802ALS=y
CONFIG_ISL29003=y
CONFIG_ISL29020=y
CONFIG_SENSORS_TSL2550=y
CONFIG_SENSORS_BH1770=y
CONFIG_SENSORS_APDS990X=y
CONFIG_HMC6352=y
CONFIG_DS1682=y
# CONFIG_PCH_PHUB is not set
CONFIG_LATTICE_ECP3_CONFIG=y
CONFIG_SRAM=y
CONFIG_DW_XDATA_PCIE=y
# CONFIG_PCI_ENDPOINT_TEST is not set
CONFIG_XILINX_SDFEC=y
CONFIG_MISC_RTSX=y
CONFIG_HISI_HIKEY_USB=y
CONFIG_OPEN_DICE=y
CONFIG_VCPU_STALL_DETECTOR=y
CONFIG_C2PORT=y
# CONFIG_C2PORT_DURAMAR_2150 is not set

#
# EEPROM support
#
CONFIG_EEPROM_AT24=y
CONFIG_EEPROM_AT25=y
# CONFIG_EEPROM_LEGACY is not set
# CONFIG_EEPROM_MAX6875 is not set
CONFIG_EEPROM_93CX6=y
CONFIG_EEPROM_93XX46=y
CONFIG_EEPROM_IDT_89HPESX=y
# CONFIG_EEPROM_EE1004 is not set
# end of EEPROM support

# CONFIG_CB710_CORE is not set

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
# end of Texas Instruments shared transport line discipline

# CONFIG_SENSORS_LIS3_I2C is not set
CONFIG_ALTERA_STAPL=y
CONFIG_INTEL_MEI=y
# CONFIG_INTEL_MEI_ME is not set
CONFIG_INTEL_MEI_TXE=y
# CONFIG_VMWARE_VMCI is not set
CONFIG_ECHO=y
# CONFIG_MISC_ALCOR_PCI is not set
# CONFIG_MISC_RTSX_PCI is not set
CONFIG_MISC_RTSX_USB=y
CONFIG_HABANA_AI=y
CONFIG_UACCE=y
CONFIG_PVPANIC=y
CONFIG_PVPANIC_MMIO=y
CONFIG_PVPANIC_PCI=y
CONFIG_GP_PCI1XXXX=y
# end of Misc devices

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
CONFIG_RAID_ATTRS=y
CONFIG_SCSI_COMMON=y
CONFIG_SCSI=y
CONFIG_SCSI_DMA=y
# CONFIG_SCSI_PROC_FS is not set

#
# SCSI support type (disk, tape, CD-ROM)
#
# CONFIG_BLK_DEV_SD is not set
# CONFIG_CHR_DEV_ST is not set
# CONFIG_BLK_DEV_SR is not set
CONFIG_CHR_DEV_SG=y
CONFIG_BLK_DEV_BSG=y
# CONFIG_CHR_DEV_SCH is not set
CONFIG_SCSI_CONSTANTS=y
# CONFIG_SCSI_LOGGING is not set
CONFIG_SCSI_SCAN_ASYNC=y

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=y
# CONFIG_SCSI_FC_ATTRS is not set
# CONFIG_SCSI_ISCSI_ATTRS is not set
CONFIG_SCSI_SAS_ATTRS=y
CONFIG_SCSI_SAS_LIBSAS=y
# CONFIG_SCSI_SAS_ATA is not set
CONFIG_SCSI_SAS_HOST_SMP=y
CONFIG_SCSI_SRP_ATTRS=y
# end of SCSI Transports

CONFIG_SCSI_LOWLEVEL=y
# CONFIG_ISCSI_TCP is not set
CONFIG_ISCSI_BOOT_SYSFS=y
# CONFIG_SCSI_CXGB3_ISCSI is not set
# CONFIG_SCSI_CXGB4_ISCSI is not set
# CONFIG_SCSI_BNX2_ISCSI is not set
# CONFIG_BE2ISCSI is not set
CONFIG_BLK_DEV_3W_XXXX_RAID=y
CONFIG_SCSI_HPSA=y
CONFIG_SCSI_3W_9XXX=y
CONFIG_SCSI_3W_SAS=y
CONFIG_SCSI_ACARD=y
CONFIG_SCSI_AACRAID=y
CONFIG_SCSI_AIC7XXX=y
CONFIG_AIC7XXX_CMDS_PER_DEVICE=32
CONFIG_AIC7XXX_RESET_DELAY_MS=5000
# CONFIG_AIC7XXX_BUILD_FIRMWARE is not set
# CONFIG_AIC7XXX_DEBUG_ENABLE is not set
CONFIG_AIC7XXX_DEBUG_MASK=0
# CONFIG_AIC7XXX_REG_PRETTY_PRINT is not set
CONFIG_SCSI_AIC79XX=y
CONFIG_AIC79XX_CMDS_PER_DEVICE=32
CONFIG_AIC79XX_RESET_DELAY_MS=5000
# CONFIG_AIC79XX_BUILD_FIRMWARE is not set
CONFIG_AIC79XX_DEBUG_ENABLE=y
CONFIG_AIC79XX_DEBUG_MASK=0
CONFIG_AIC79XX_REG_PRETTY_PRINT=y
CONFIG_SCSI_AIC94XX=y
# CONFIG_AIC94XX_DEBUG is not set
CONFIG_SCSI_MVSAS=y
CONFIG_SCSI_MVSAS_DEBUG=y
CONFIG_SCSI_MVSAS_TASKLET=y
CONFIG_SCSI_MVUMI=y
CONFIG_SCSI_ADVANSYS=y
CONFIG_SCSI_ARCMSR=y
CONFIG_SCSI_ESAS2R=y
CONFIG_MEGARAID_NEWGEN=y
CONFIG_MEGARAID_MM=y
CONFIG_MEGARAID_MAILBOX=y
CONFIG_MEGARAID_LEGACY=y
CONFIG_MEGARAID_SAS=y
CONFIG_SCSI_MPT3SAS=y
CONFIG_SCSI_MPT2SAS_MAX_SGE=128
CONFIG_SCSI_MPT3SAS_MAX_SGE=128
CONFIG_SCSI_MPT2SAS=y
CONFIG_SCSI_MPI3MR=y
CONFIG_SCSI_SMARTPQI=y
CONFIG_SCSI_HPTIOP=y
# CONFIG_SCSI_BUSLOGIC is not set
CONFIG_SCSI_MYRB=y
# CONFIG_SCSI_MYRS is not set
CONFIG_VMWARE_PVSCSI=y
CONFIG_SCSI_SNIC=y
CONFIG_SCSI_SNIC_DEBUG_FS=y
CONFIG_SCSI_DMX3191D=y
CONFIG_SCSI_FDOMAIN=y
CONFIG_SCSI_FDOMAIN_PCI=y
CONFIG_SCSI_ISCI=y
CONFIG_SCSI_IPS=y
CONFIG_SCSI_INITIO=y
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
CONFIG_SCSI_IMM=y
# CONFIG_SCSI_IZIP_EPP16 is not set
CONFIG_SCSI_IZIP_SLOW_CTR=y
CONFIG_SCSI_STEX=y
CONFIG_SCSI_SYM53C8XX_2=y
CONFIG_SCSI_SYM53C8XX_DMA_ADDRESSING_MODE=1
CONFIG_SCSI_SYM53C8XX_DEFAULT_TAGS=16
CONFIG_SCSI_SYM53C8XX_MAX_TAGS=64
# CONFIG_SCSI_SYM53C8XX_MMIO is not set
# CONFIG_SCSI_IPR is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_QLA_ISCSI is not set
CONFIG_SCSI_DC395x=y
# CONFIG_SCSI_AM53C974 is not set
CONFIG_SCSI_NSP32=y
CONFIG_SCSI_WD719X=y
CONFIG_SCSI_DEBUG=y
# CONFIG_SCSI_PMCRAID is not set
CONFIG_SCSI_PM8001=y
CONFIG_SCSI_VIRTIO=y
CONFIG_SCSI_LOWLEVEL_PCMCIA=y
# CONFIG_PCMCIA_AHA152X is not set
# CONFIG_PCMCIA_FDOMAIN is not set
# CONFIG_PCMCIA_NINJA_SCSI is not set
# CONFIG_PCMCIA_QLOGIC is not set
# CONFIG_PCMCIA_SYM53C500 is not set
# CONFIG_SCSI_DH is not set
# end of SCSI device support

CONFIG_ATA=y
CONFIG_SATA_HOST=y
CONFIG_PATA_TIMINGS=y
CONFIG_ATA_VERBOSE_ERROR=y
CONFIG_ATA_FORCE=y
CONFIG_ATA_ACPI=y
CONFIG_SATA_PMP=y

#
# Controllers with non-SFF native interface
#
CONFIG_SATA_AHCI=y
CONFIG_SATA_MOBILE_LPM_POLICY=0
CONFIG_SATA_AHCI_PLATFORM=y
CONFIG_AHCI_DWC=y
CONFIG_AHCI_CEVA=y
# CONFIG_AHCI_QORIQ is not set
CONFIG_SATA_INIC162X=y
CONFIG_SATA_ACARD_AHCI=y
# CONFIG_SATA_SIL24 is not set
# CONFIG_ATA_SFF is not set
# CONFIG_MD is not set
# CONFIG_TARGET_CORE is not set
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
CONFIG_FIREWIRE=y
# CONFIG_FIREWIRE_OHCI is not set
CONFIG_FIREWIRE_SBP2=y
# CONFIG_FIREWIRE_NET is not set
# CONFIG_FIREWIRE_NOSY is not set
# end of IEEE 1394 (FireWire) support

CONFIG_MACINTOSH_DRIVERS=y
# CONFIG_MAC_EMUMOUSEBTN is not set
CONFIG_NETDEVICES=y
CONFIG_NET_CORE=y
# CONFIG_BONDING is not set
# CONFIG_DUMMY is not set
# CONFIG_WIREGUARD is not set
# CONFIG_EQUALIZER is not set
# CONFIG_NET_FC is not set
# CONFIG_NET_TEAM is not set
# CONFIG_MACVLAN is not set
# CONFIG_IPVLAN is not set
# CONFIG_VXLAN is not set
# CONFIG_GENEVE is not set
# CONFIG_BAREUDP is not set
# CONFIG_GTP is not set
# CONFIG_MACSEC is not set
# CONFIG_NETCONSOLE is not set
# CONFIG_TUN is not set
# CONFIG_TUN_VNET_CROSS_LE is not set
# CONFIG_VETH is not set
CONFIG_VIRTIO_NET=m
# CONFIG_NLMON is not set
# CONFIG_MHI_NET is not set
# CONFIG_ARCNET is not set
CONFIG_ETHERNET=y
CONFIG_NET_VENDOR_3COM=y
# CONFIG_PCMCIA_3C574 is not set
# CONFIG_PCMCIA_3C589 is not set
# CONFIG_VORTEX is not set
# CONFIG_TYPHOON is not set
CONFIG_NET_VENDOR_ADAPTEC=y
# CONFIG_ADAPTEC_STARFIRE is not set
CONFIG_NET_VENDOR_AGERE=y
# CONFIG_ET131X is not set
CONFIG_NET_VENDOR_ALACRITECH=y
# CONFIG_SLICOSS is not set
CONFIG_NET_VENDOR_ALTEON=y
# CONFIG_ACENIC is not set
# CONFIG_ALTERA_TSE is not set
CONFIG_NET_VENDOR_AMAZON=y
# CONFIG_NET_VENDOR_AMD is not set
CONFIG_NET_VENDOR_AQUANTIA=y
# CONFIG_AQTION is not set
CONFIG_NET_VENDOR_ARC=y
CONFIG_NET_VENDOR_ASIX=y
# CONFIG_SPI_AX88796C is not set
CONFIG_NET_VENDOR_ATHEROS=y
# CONFIG_ATL2 is not set
# CONFIG_ATL1 is not set
# CONFIG_ATL1E is not set
# CONFIG_ATL1C is not set
# CONFIG_ALX is not set
# CONFIG_CX_ECAT is not set
CONFIG_NET_VENDOR_BROADCOM=y
# CONFIG_B44 is not set
# CONFIG_BCMGENET is not set
# CONFIG_BNX2 is not set
# CONFIG_CNIC is not set
# CONFIG_TIGON3 is not set
# CONFIG_BNX2X is not set
# CONFIG_SYSTEMPORT is not set
# CONFIG_BNXT is not set
CONFIG_NET_VENDOR_CADENCE=y
# CONFIG_MACB is not set
CONFIG_NET_VENDOR_CAVIUM=y
CONFIG_NET_VENDOR_CHELSIO=y
# CONFIG_CHELSIO_T1 is not set
# CONFIG_CHELSIO_T3 is not set
# CONFIG_CHELSIO_T4 is not set
# CONFIG_CHELSIO_T4VF is not set
CONFIG_NET_VENDOR_CISCO=y
# CONFIG_ENIC is not set
CONFIG_NET_VENDOR_CORTINA=y
# CONFIG_GEMINI_ETHERNET is not set
CONFIG_NET_VENDOR_DAVICOM=y
# CONFIG_DM9051 is not set
# CONFIG_DNET is not set
CONFIG_NET_VENDOR_DEC=y
# CONFIG_NET_TULIP is not set
CONFIG_NET_VENDOR_DLINK=y
# CONFIG_DL2K is not set
# CONFIG_SUNDANCE is not set
CONFIG_NET_VENDOR_EMULEX=y
# CONFIG_BE2NET is not set
CONFIG_NET_VENDOR_ENGLEDER=y
# CONFIG_TSNEP is not set
CONFIG_NET_VENDOR_EZCHIP=y
# CONFIG_EZCHIP_NPS_MANAGEMENT_ENET is not set
CONFIG_NET_VENDOR_FUJITSU=y
# CONFIG_PCMCIA_FMVJ18X is not set
CONFIG_NET_VENDOR_FUNGIBLE=y
CONFIG_NET_VENDOR_GOOGLE=y
CONFIG_NET_VENDOR_HUAWEI=y
CONFIG_NET_VENDOR_I825XX=y
CONFIG_NET_VENDOR_INTEL=y
# CONFIG_E100 is not set
CONFIG_E1000=y
# CONFIG_E1000E is not set
# CONFIG_IGB is not set
# CONFIG_IGBVF is not set
# CONFIG_IXGB is not set
# CONFIG_IXGBE is not set
# CONFIG_I40E is not set
# CONFIG_IGC is not set
CONFIG_NET_VENDOR_WANGXUN=y
# CONFIG_NGBE is not set
# CONFIG_TXGBE is not set
# CONFIG_JME is not set
CONFIG_NET_VENDOR_ADI=y
CONFIG_NET_VENDOR_LITEX=y
# CONFIG_LITEX_LITEETH is not set
CONFIG_NET_VENDOR_MARVELL=y
# CONFIG_MVMDIO is not set
# CONFIG_SKGE is not set
# CONFIG_SKY2 is not set
CONFIG_NET_VENDOR_MELLANOX=y
# CONFIG_MLX4_EN is not set
# CONFIG_MLX5_CORE is not set
# CONFIG_MLXSW_CORE is not set
# CONFIG_MLXFW is not set
CONFIG_NET_VENDOR_MICREL=y
# CONFIG_KS8851 is not set
# CONFIG_KS8851_MLL is not set
# CONFIG_KSZ884X_PCI is not set
CONFIG_NET_VENDOR_MICROCHIP=y
# CONFIG_ENC28J60 is not set
# CONFIG_ENCX24J600 is not set
# CONFIG_LAN743X is not set
CONFIG_NET_VENDOR_MICROSEMI=y
CONFIG_NET_VENDOR_MICROSOFT=y
CONFIG_NET_VENDOR_MYRI=y
# CONFIG_MYRI10GE is not set
# CONFIG_FEALNX is not set
CONFIG_NET_VENDOR_NI=y
# CONFIG_NI_XGE_MANAGEMENT_ENET is not set
CONFIG_NET_VENDOR_NATSEMI=y
# CONFIG_NATSEMI is not set
# CONFIG_NS83820 is not set
CONFIG_NET_VENDOR_NETERION=y
# CONFIG_S2IO is not set
CONFIG_NET_VENDOR_NETRONOME=y
CONFIG_NET_VENDOR_8390=y
# CONFIG_PCMCIA_AXNET is not set
# CONFIG_NE2K_PCI is not set
# CONFIG_PCMCIA_PCNET is not set
CONFIG_NET_VENDOR_NVIDIA=y
# CONFIG_FORCEDETH is not set
CONFIG_NET_VENDOR_OKI=y
# CONFIG_ETHOC is not set
CONFIG_NET_VENDOR_PACKET_ENGINES=y
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
CONFIG_NET_VENDOR_PENSANDO=y
CONFIG_NET_VENDOR_QLOGIC=y
# CONFIG_QLA3XXX is not set
# CONFIG_QLCNIC is not set
# CONFIG_NETXEN_NIC is not set
# CONFIG_QED is not set
CONFIG_NET_VENDOR_BROCADE=y
# CONFIG_BNA is not set
CONFIG_NET_VENDOR_QUALCOMM=y
# CONFIG_QCA7000_SPI is not set
# CONFIG_QCOM_EMAC is not set
# CONFIG_RMNET is not set
CONFIG_NET_VENDOR_RDC=y
# CONFIG_R6040 is not set
CONFIG_NET_VENDOR_REALTEK=y
# CONFIG_ATP is not set
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
# CONFIG_R8169 is not set
CONFIG_NET_VENDOR_RENESAS=y
CONFIG_NET_VENDOR_ROCKER=y
CONFIG_NET_VENDOR_SAMSUNG=y
# CONFIG_SXGBE_ETH is not set
CONFIG_NET_VENDOR_SEEQ=y
CONFIG_NET_VENDOR_SILAN=y
# CONFIG_SC92031 is not set
CONFIG_NET_VENDOR_SIS=y
# CONFIG_SIS900 is not set
# CONFIG_SIS190 is not set
CONFIG_NET_VENDOR_SOLARFLARE=y
# CONFIG_SFC is not set
# CONFIG_SFC_FALCON is not set
CONFIG_NET_VENDOR_SMSC=y
# CONFIG_PCMCIA_SMC91C92 is not set
# CONFIG_EPIC100 is not set
# CONFIG_SMSC911X is not set
# CONFIG_SMSC9420 is not set
CONFIG_NET_VENDOR_SOCIONEXT=y
CONFIG_NET_VENDOR_STMICRO=y
# CONFIG_STMMAC_ETH is not set
CONFIG_NET_VENDOR_SUN=y
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_CASSINI is not set
# CONFIG_NIU is not set
CONFIG_NET_VENDOR_SYNOPSYS=y
# CONFIG_DWC_XLGMAC is not set
CONFIG_NET_VENDOR_TEHUTI=y
# CONFIG_TEHUTI is not set
CONFIG_NET_VENDOR_TI=y
# CONFIG_TI_CPSW_PHY_SEL is not set
# CONFIG_TLAN is not set
CONFIG_NET_VENDOR_VERTEXCOM=y
# CONFIG_MSE102X is not set
CONFIG_NET_VENDOR_VIA=y
# CONFIG_VIA_RHINE is not set
# CONFIG_VIA_VELOCITY is not set
CONFIG_NET_VENDOR_WIZNET=y
# CONFIG_WIZNET_W5100 is not set
# CONFIG_WIZNET_W5300 is not set
CONFIG_NET_VENDOR_XILINX=y
# CONFIG_XILINX_EMACLITE is not set
# CONFIG_XILINX_AXI_EMAC is not set
# CONFIG_XILINX_LL_TEMAC is not set
CONFIG_NET_VENDOR_XIRCOM=y
# CONFIG_PCMCIA_XIRC2PS is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_NET_SB1000 is not set
# CONFIG_PHYLIB is not set
# CONFIG_MICREL_KS8995MA is not set
# CONFIG_PSE_CONTROLLER is not set
# CONFIG_MDIO_DEVICE is not set

#
# PCS device drivers
#
# end of PCS device drivers

# CONFIG_PLIP is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set
CONFIG_USB_NET_DRIVERS=y
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
# CONFIG_USB_RTL8152 is not set
# CONFIG_USB_LAN78XX is not set
# CONFIG_USB_USBNET is not set
# CONFIG_USB_IPHETH is not set
CONFIG_WLAN=y
CONFIG_WLAN_VENDOR_ADMTEK=y
CONFIG_WLAN_VENDOR_ATH=y
# CONFIG_ATH_DEBUG is not set
# CONFIG_ATH5K_PCI is not set
CONFIG_WLAN_VENDOR_ATMEL=y
CONFIG_WLAN_VENDOR_BROADCOM=y
CONFIG_WLAN_VENDOR_CISCO=y
CONFIG_WLAN_VENDOR_INTEL=y
CONFIG_WLAN_VENDOR_INTERSIL=y
# CONFIG_HOSTAP is not set
CONFIG_WLAN_VENDOR_MARVELL=y
CONFIG_WLAN_VENDOR_MEDIATEK=y
CONFIG_WLAN_VENDOR_MICROCHIP=y
CONFIG_WLAN_VENDOR_PURELIFI=y
CONFIG_WLAN_VENDOR_RALINK=y
CONFIG_WLAN_VENDOR_REALTEK=y
CONFIG_WLAN_VENDOR_RSI=y
CONFIG_WLAN_VENDOR_SILABS=y
CONFIG_WLAN_VENDOR_ST=y
CONFIG_WLAN_VENDOR_TI=y
CONFIG_WLAN_VENDOR_ZYDAS=y
CONFIG_WLAN_VENDOR_QUANTENNA=y
# CONFIG_PCMCIA_RAYCS is not set
# CONFIG_WAN is not set

#
# Wireless WAN
#
# CONFIG_WWAN is not set
# end of Wireless WAN

# CONFIG_VMXNET3 is not set
# CONFIG_FUJITSU_ES is not set
# CONFIG_NETDEVSIM is not set
CONFIG_NET_FAILOVER=m
# CONFIG_ISDN is not set

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_LEDS=y
CONFIG_INPUT_FF_MEMLESS=y
CONFIG_INPUT_SPARSEKMAP=y
CONFIG_INPUT_MATRIXKMAP=y
CONFIG_INPUT_VIVALDIFMAP=y

#
# Userland interfaces
#
# CONFIG_INPUT_MOUSEDEV is not set
CONFIG_INPUT_JOYDEV=y
CONFIG_INPUT_EVDEV=y
CONFIG_INPUT_EVBUG=y

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
# CONFIG_KEYBOARD_ADP5520 is not set
# CONFIG_KEYBOARD_ADP5588 is not set
# CONFIG_KEYBOARD_ADP5589 is not set
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_QT1050 is not set
# CONFIG_KEYBOARD_QT1070 is not set
# CONFIG_KEYBOARD_QT2160 is not set
# CONFIG_KEYBOARD_DLINK_DIR685 is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_GPIO is not set
# CONFIG_KEYBOARD_GPIO_POLLED is not set
# CONFIG_KEYBOARD_TCA6416 is not set
# CONFIG_KEYBOARD_TCA8418 is not set
# CONFIG_KEYBOARD_MATRIX is not set
# CONFIG_KEYBOARD_LM8323 is not set
# CONFIG_KEYBOARD_LM8333 is not set
# CONFIG_KEYBOARD_MAX7359 is not set
# CONFIG_KEYBOARD_MCS is not set
# CONFIG_KEYBOARD_MPR121 is not set
# CONFIG_KEYBOARD_NEWTON is not set
# CONFIG_KEYBOARD_OPENCORES is not set
# CONFIG_KEYBOARD_PINEPHONE is not set
# CONFIG_KEYBOARD_SAMSUNG is not set
# CONFIG_KEYBOARD_GOLDFISH_EVENTS is not set
# CONFIG_KEYBOARD_STOWAWAY is not set
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_IQS62X is not set
# CONFIG_KEYBOARD_OMAP4 is not set
# CONFIG_KEYBOARD_TC3589X is not set
# CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
# CONFIG_KEYBOARD_TWL4030 is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_CAP11XX is not set
# CONFIG_KEYBOARD_BCM is not set
# CONFIG_KEYBOARD_CYPRESS_SF is not set
# CONFIG_INPUT_MOUSE is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TABLET is not set
CONFIG_INPUT_TOUCHSCREEN=y
CONFIG_TOUCHSCREEN_ADS7846=y
CONFIG_TOUCHSCREEN_AD7877=y
CONFIG_TOUCHSCREEN_AD7879=y
CONFIG_TOUCHSCREEN_AD7879_I2C=y
CONFIG_TOUCHSCREEN_AD7879_SPI=y
# CONFIG_TOUCHSCREEN_AR1021_I2C is not set
# CONFIG_TOUCHSCREEN_ATMEL_MXT is not set
CONFIG_TOUCHSCREEN_AUO_PIXCIR=y
CONFIG_TOUCHSCREEN_BU21013=y
CONFIG_TOUCHSCREEN_BU21029=y
CONFIG_TOUCHSCREEN_CHIPONE_ICN8318=y
# CONFIG_TOUCHSCREEN_CHIPONE_ICN8505 is not set
CONFIG_TOUCHSCREEN_CY8CTMA140=y
# CONFIG_TOUCHSCREEN_CY8CTMG110 is not set
CONFIG_TOUCHSCREEN_CYTTSP_CORE=y
# CONFIG_TOUCHSCREEN_CYTTSP_I2C is not set
CONFIG_TOUCHSCREEN_CYTTSP_SPI=y
# CONFIG_TOUCHSCREEN_CYTTSP4_CORE is not set
# CONFIG_TOUCHSCREEN_DA9034 is not set
CONFIG_TOUCHSCREEN_DA9052=y
# CONFIG_TOUCHSCREEN_DYNAPRO is not set
CONFIG_TOUCHSCREEN_HAMPSHIRE=y
CONFIG_TOUCHSCREEN_EETI=y
# CONFIG_TOUCHSCREEN_EGALAX is not set
CONFIG_TOUCHSCREEN_EGALAX_SERIAL=y
CONFIG_TOUCHSCREEN_EXC3000=y
CONFIG_TOUCHSCREEN_FUJITSU=y
CONFIG_TOUCHSCREEN_GOODIX=y
# CONFIG_TOUCHSCREEN_HIDEEP is not set
CONFIG_TOUCHSCREEN_HYCON_HY46XX=y
# CONFIG_TOUCHSCREEN_ILI210X is not set
# CONFIG_TOUCHSCREEN_ILITEK is not set
CONFIG_TOUCHSCREEN_S6SY761=y
CONFIG_TOUCHSCREEN_GUNZE=y
# CONFIG_TOUCHSCREEN_EKTF2127 is not set
CONFIG_TOUCHSCREEN_ELAN=y
# CONFIG_TOUCHSCREEN_ELO is not set
# CONFIG_TOUCHSCREEN_WACOM_W8001 is not set
# CONFIG_TOUCHSCREEN_WACOM_I2C is not set
CONFIG_TOUCHSCREEN_MAX11801=y
# CONFIG_TOUCHSCREEN_MCS5000 is not set
CONFIG_TOUCHSCREEN_MMS114=y
CONFIG_TOUCHSCREEN_MELFAS_MIP4=y
# CONFIG_TOUCHSCREEN_MSG2638 is not set
CONFIG_TOUCHSCREEN_MTOUCH=y
CONFIG_TOUCHSCREEN_IMAGIS=y
# CONFIG_TOUCHSCREEN_IMX6UL_TSC is not set
CONFIG_TOUCHSCREEN_INEXIO=y
CONFIG_TOUCHSCREEN_MK712=y
CONFIG_TOUCHSCREEN_PENMOUNT=y
# CONFIG_TOUCHSCREEN_EDT_FT5X06 is not set
# CONFIG_TOUCHSCREEN_TOUCHRIGHT is not set
CONFIG_TOUCHSCREEN_TOUCHWIN=y
# CONFIG_TOUCHSCREEN_TI_AM335X_TSC is not set
CONFIG_TOUCHSCREEN_PIXCIR=y
CONFIG_TOUCHSCREEN_WDT87XX_I2C=y
CONFIG_TOUCHSCREEN_WM831X=y
CONFIG_TOUCHSCREEN_USB_COMPOSITE=y
# CONFIG_TOUCHSCREEN_MC13783 is not set
# CONFIG_TOUCHSCREEN_USB_EGALAX is not set
CONFIG_TOUCHSCREEN_USB_PANJIT=y
CONFIG_TOUCHSCREEN_USB_3M=y
# CONFIG_TOUCHSCREEN_USB_ITM is not set
# CONFIG_TOUCHSCREEN_USB_ETURBO is not set
# CONFIG_TOUCHSCREEN_USB_GUNZE is not set
# CONFIG_TOUCHSCREEN_USB_DMC_TSC10 is not set
CONFIG_TOUCHSCREEN_USB_IRTOUCH=y
# CONFIG_TOUCHSCREEN_USB_IDEALTEK is not set
# CONFIG_TOUCHSCREEN_USB_GENERAL_TOUCH is not set
# CONFIG_TOUCHSCREEN_USB_GOTOP is not set
CONFIG_TOUCHSCREEN_USB_JASTEC=y
# CONFIG_TOUCHSCREEN_USB_ELO is not set
# CONFIG_TOUCHSCREEN_USB_E2I is not set
# CONFIG_TOUCHSCREEN_USB_ZYTRONIC is not set
CONFIG_TOUCHSCREEN_USB_ETT_TC45USB=y
CONFIG_TOUCHSCREEN_USB_NEXIO=y
CONFIG_TOUCHSCREEN_USB_EASYTOUCH=y
CONFIG_TOUCHSCREEN_TOUCHIT213=y
# CONFIG_TOUCHSCREEN_TSC_SERIO is not set
CONFIG_TOUCHSCREEN_TSC200X_CORE=y
# CONFIG_TOUCHSCREEN_TSC2004 is not set
CONFIG_TOUCHSCREEN_TSC2005=y
CONFIG_TOUCHSCREEN_TSC2007=y
# CONFIG_TOUCHSCREEN_RM_TS is not set
CONFIG_TOUCHSCREEN_SILEAD=y
# CONFIG_TOUCHSCREEN_SIS_I2C is not set
CONFIG_TOUCHSCREEN_ST1232=y
# CONFIG_TOUCHSCREEN_STMFTS is not set
# CONFIG_TOUCHSCREEN_SURFACE3_SPI is not set
CONFIG_TOUCHSCREEN_SX8654=y
CONFIG_TOUCHSCREEN_TPS6507X=y
CONFIG_TOUCHSCREEN_ZET6223=y
CONFIG_TOUCHSCREEN_ZFORCE=y
# CONFIG_TOUCHSCREEN_ROHM_BU21023 is not set
CONFIG_TOUCHSCREEN_IQS5XX=y
CONFIG_TOUCHSCREEN_ZINITIX=y
# CONFIG_INPUT_MISC is not set
CONFIG_RMI4_CORE=y
CONFIG_RMI4_I2C=y
# CONFIG_RMI4_SPI is not set
CONFIG_RMI4_SMB=y
# CONFIG_RMI4_F03 is not set
CONFIG_RMI4_2D_SENSOR=y
CONFIG_RMI4_F11=y
CONFIG_RMI4_F12=y
# CONFIG_RMI4_F30 is not set
# CONFIG_RMI4_F34 is not set
# CONFIG_RMI4_F3A is not set
CONFIG_RMI4_F55=y

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
CONFIG_SERIO_CT82C710=y
CONFIG_SERIO_PARKBD=y
CONFIG_SERIO_PCIPS2=y
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=y
CONFIG_SERIO_ALTERA_PS2=y
CONFIG_SERIO_PS2MULT=y
# CONFIG_SERIO_ARC_PS2 is not set
CONFIG_SERIO_APBPS2=y
CONFIG_SERIO_GPIO_PS2=y
CONFIG_USERIO=y
CONFIG_GAMEPORT=y
CONFIG_GAMEPORT_NS558=y
CONFIG_GAMEPORT_L4=y
# CONFIG_GAMEPORT_EMU10K1 is not set
CONFIG_GAMEPORT_FM801=y
# end of Hardware I/O ports
# end of Input device support

#
# Character devices
#
CONFIG_TTY=y
# CONFIG_VT is not set
CONFIG_UNIX98_PTYS=y
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256
# CONFIG_LDISC_AUTOLOAD is not set

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
# CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
CONFIG_SERIAL_8250_PNP=y
# CONFIG_SERIAL_8250_16550A_VARIANTS is not set
# CONFIG_SERIAL_8250_FINTEK is not set
CONFIG_SERIAL_8250_CONSOLE=y
# CONFIG_SERIAL_8250_PCI is not set
CONFIG_SERIAL_8250_CS=y
# CONFIG_SERIAL_8250_MEN_MCB is not set
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
# CONFIG_SERIAL_8250_MANY_PORTS is not set
# CONFIG_SERIAL_8250_SHARE_IRQ is not set
CONFIG_SERIAL_8250_DETECT_IRQ=y
# CONFIG_SERIAL_8250_RSA is not set
# CONFIG_SERIAL_8250_DW is not set
CONFIG_SERIAL_8250_RT288X=y
# CONFIG_SERIAL_8250_LPSS is not set
# CONFIG_SERIAL_8250_MID is not set
CONFIG_SERIAL_8250_PERICOM=y
CONFIG_SERIAL_OF_PLATFORM=y

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_MAX3100 is not set
# CONFIG_SERIAL_MAX310X is not set
CONFIG_SERIAL_UARTLITE=y
# CONFIG_SERIAL_UARTLITE_CONSOLE is not set
CONFIG_SERIAL_UARTLITE_NR_UARTS=1
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_SERIAL_JSM=y
CONFIG_SERIAL_SIFIVE=y
# CONFIG_SERIAL_SIFIVE_CONSOLE is not set
CONFIG_SERIAL_LANTIQ=y
# CONFIG_SERIAL_LANTIQ_CONSOLE is not set
# CONFIG_SERIAL_SCCNXP is not set
CONFIG_SERIAL_SC16IS7XX_CORE=y
CONFIG_SERIAL_SC16IS7XX=y
# CONFIG_SERIAL_SC16IS7XX_I2C is not set
CONFIG_SERIAL_SC16IS7XX_SPI=y
# CONFIG_SERIAL_TIMBERDALE is not set
CONFIG_SERIAL_ALTERA_JTAGUART=y
CONFIG_SERIAL_ALTERA_JTAGUART_CONSOLE=y
CONFIG_SERIAL_ALTERA_JTAGUART_CONSOLE_BYPASS=y
CONFIG_SERIAL_ALTERA_UART=y
CONFIG_SERIAL_ALTERA_UART_MAXPORTS=4
CONFIG_SERIAL_ALTERA_UART_BAUDRATE=115200
# CONFIG_SERIAL_ALTERA_UART_CONSOLE is not set
CONFIG_SERIAL_PCH_UART=y
# CONFIG_SERIAL_PCH_UART_CONSOLE is not set
CONFIG_SERIAL_XILINX_PS_UART=y
CONFIG_SERIAL_XILINX_PS_UART_CONSOLE=y
CONFIG_SERIAL_ARC=y
# CONFIG_SERIAL_ARC_CONSOLE is not set
CONFIG_SERIAL_ARC_NR_PORTS=1
# CONFIG_SERIAL_RP2 is not set
# CONFIG_SERIAL_FSL_LPUART is not set
# CONFIG_SERIAL_FSL_LINFLEXUART is not set
CONFIG_SERIAL_CONEXANT_DIGICOLOR=y
CONFIG_SERIAL_CONEXANT_DIGICOLOR_CONSOLE=y
# CONFIG_SERIAL_MEN_Z135 is not set
# CONFIG_SERIAL_SPRD is not set
# CONFIG_SERIAL_LITEUART is not set
# end of Serial drivers

CONFIG_SERIAL_MCTRL_GPIO=y
CONFIG_SERIAL_NONSTANDARD=y
CONFIG_MOXA_INTELLIO=y
CONFIG_MOXA_SMARTIO=y
CONFIG_SYNCLINK_GT=y
CONFIG_N_HDLC=y
CONFIG_GOLDFISH_TTY=y
CONFIG_GOLDFISH_TTY_EARLY_CONSOLE=y
# CONFIG_N_GSM is not set
CONFIG_NOZOMI=y
CONFIG_NULL_TTY=y
CONFIG_HVC_DRIVER=y
CONFIG_RPMSG_TTY=y
# CONFIG_SERIAL_DEV_BUS is not set
CONFIG_TTY_PRINTK=y
CONFIG_TTY_PRINTK_LEVEL=6
CONFIG_PRINTER=y
CONFIG_LP_CONSOLE=y
# CONFIG_PPDEV is not set
CONFIG_VIRTIO_CONSOLE=y
# CONFIG_IPMI_HANDLER is not set
CONFIG_IPMB_DEVICE_INTERFACE=y
CONFIG_HW_RANDOM=y
CONFIG_HW_RANDOM_TIMERIOMEM=y
CONFIG_HW_RANDOM_INTEL=y
# CONFIG_HW_RANDOM_AMD is not set
# CONFIG_HW_RANDOM_BA431 is not set
# CONFIG_HW_RANDOM_GEODE is not set
CONFIG_HW_RANDOM_VIA=y
CONFIG_HW_RANDOM_VIRTIO=y
# CONFIG_HW_RANDOM_CCTRNG is not set
CONFIG_HW_RANDOM_XIPHERA=y
CONFIG_APPLICOM=y
# CONFIG_SONYPI is not set

#
# PCMCIA character devices
#
# CONFIG_SYNCLINK_CS is not set
CONFIG_CARDMAN_4000=y
# CONFIG_CARDMAN_4040 is not set
CONFIG_SCR24X=y
# CONFIG_IPWIRELESS is not set
# end of PCMCIA character devices

CONFIG_MWAVE=y
CONFIG_PC8736x_GPIO=y
CONFIG_NSC_GPIO=y
# CONFIG_DEVMEM is not set
CONFIG_NVRAM=y
# CONFIG_DEVPORT is not set
# CONFIG_HPET is not set
CONFIG_HANGCHECK_TIMER=y
# CONFIG_TCG_TPM is not set
# CONFIG_TELCLOCK is not set
CONFIG_XILLYBUS_CLASS=y
# CONFIG_XILLYBUS is not set
CONFIG_XILLYUSB=y
CONFIG_RANDOM_TRUST_CPU=y
CONFIG_RANDOM_TRUST_BOOTLOADER=y
# end of Character devices

#
# I2C support
#
CONFIG_I2C=y
CONFIG_ACPI_I2C_OPREGION=y
CONFIG_I2C_BOARDINFO=y
# CONFIG_I2C_COMPAT is not set
CONFIG_I2C_CHARDEV=y
# CONFIG_I2C_MUX is not set
CONFIG_I2C_HELPER_AUTO=y
CONFIG_I2C_SMBUS=y
CONFIG_I2C_ALGOBIT=y

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
CONFIG_I2C_CCGX_UCSI=y
CONFIG_I2C_ALI1535=y
CONFIG_I2C_ALI1563=y
CONFIG_I2C_ALI15X3=y
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
# CONFIG_I2C_AMD_MP2 is not set
# CONFIG_I2C_I801 is not set
# CONFIG_I2C_ISCH is not set
# CONFIG_I2C_ISMT is not set
CONFIG_I2C_PIIX4=y
CONFIG_I2C_NFORCE2=y
CONFIG_I2C_NFORCE2_S4985=y
CONFIG_I2C_NVIDIA_GPU=y
# CONFIG_I2C_SIS5595 is not set
CONFIG_I2C_SIS630=y
CONFIG_I2C_SIS96X=y
CONFIG_I2C_VIA=y
CONFIG_I2C_VIAPRO=y

#
# ACPI drivers
#
# CONFIG_I2C_SCMI is not set

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
CONFIG_I2C_CBUS_GPIO=y
CONFIG_I2C_DESIGNWARE_CORE=y
CONFIG_I2C_DESIGNWARE_SLAVE=y
CONFIG_I2C_DESIGNWARE_PLATFORM=y
# CONFIG_I2C_DESIGNWARE_AMDPSP is not set
# CONFIG_I2C_DESIGNWARE_BAYTRAIL is not set
CONFIG_I2C_DESIGNWARE_PCI=y
# CONFIG_I2C_EG20T is not set
CONFIG_I2C_EMEV2=y
CONFIG_I2C_GPIO=y
# CONFIG_I2C_GPIO_FAULT_INJECTOR is not set
CONFIG_I2C_KEMPLD=y
# CONFIG_I2C_OCORES is not set
# CONFIG_I2C_PCA_PLATFORM is not set
CONFIG_I2C_PXA=y
CONFIG_I2C_PXA_PCI=y
# CONFIG_I2C_RK3X is not set
CONFIG_I2C_SIMTEC=y
# CONFIG_I2C_XILINX is not set

#
# External I2C/SMBus adapter drivers
#
CONFIG_I2C_DIOLAN_U2C=y
CONFIG_I2C_CP2615=y
CONFIG_I2C_PARPORT=y
CONFIG_I2C_PCI1XXXX=y
CONFIG_I2C_ROBOTFUZZ_OSIF=y
CONFIG_I2C_TAOS_EVM=y
CONFIG_I2C_TINY_USB=y

#
# Other I2C/SMBus bus drivers
#
# CONFIG_SCx200_ACB is not set
CONFIG_I2C_FSI=y
CONFIG_I2C_VIRTIO=y
# end of I2C Hardware Bus support

# CONFIG_I2C_STUB is not set
CONFIG_I2C_SLAVE=y
CONFIG_I2C_SLAVE_EEPROM=y
# CONFIG_I2C_SLAVE_TESTUNIT is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# end of I2C support

CONFIG_I3C=y
CONFIG_CDNS_I3C_MASTER=y
CONFIG_DW_I3C_MASTER=y
CONFIG_SVC_I3C_MASTER=y
CONFIG_MIPI_I3C_HCI=y
CONFIG_SPI=y
CONFIG_SPI_DEBUG=y
CONFIG_SPI_MASTER=y
CONFIG_SPI_MEM=y

#
# SPI Master Controller Drivers
#
CONFIG_SPI_ALTERA=y
CONFIG_SPI_ALTERA_CORE=y
CONFIG_SPI_ALTERA_DFL=y
# CONFIG_SPI_AXI_SPI_ENGINE is not set
CONFIG_SPI_BITBANG=y
CONFIG_SPI_BUTTERFLY=y
# CONFIG_SPI_CADENCE is not set
# CONFIG_SPI_CADENCE_QUADSPI is not set
# CONFIG_SPI_CADENCE_XSPI is not set
# CONFIG_SPI_DESIGNWARE is not set
CONFIG_SPI_FSI=y
# CONFIG_SPI_NXP_FLEXSPI is not set
CONFIG_SPI_GPIO=y
CONFIG_SPI_INTEL=y
# CONFIG_SPI_INTEL_PCI is not set
CONFIG_SPI_INTEL_PLATFORM=y
# CONFIG_SPI_LM70_LLP is not set
CONFIG_SPI_FSL_LIB=y
CONFIG_SPI_FSL_SPI=y
CONFIG_SPI_MICROCHIP_CORE=y
CONFIG_SPI_MICROCHIP_CORE_QSPI=y
# CONFIG_SPI_LANTIQ_SSC is not set
CONFIG_SPI_OC_TINY=y
CONFIG_SPI_PXA2XX=y
CONFIG_SPI_PXA2XX_PCI=y
CONFIG_SPI_ROCKCHIP=y
CONFIG_SPI_SC18IS602=y
# CONFIG_SPI_SIFIVE is not set
CONFIG_SPI_MXIC=y
CONFIG_SPI_TOPCLIFF_PCH=y
# CONFIG_SPI_XCOMM is not set
# CONFIG_SPI_XILINX is not set
# CONFIG_SPI_ZYNQMP_GQSPI is not set
# CONFIG_SPI_AMD is not set

#
# SPI Multiplexer support
#
CONFIG_SPI_MUX=y

#
# SPI Protocol Masters
#
CONFIG_SPI_SPIDEV=y
# CONFIG_SPI_LOOPBACK_TEST is not set
CONFIG_SPI_TLE62X0=y
# CONFIG_SPI_SLAVE is not set
CONFIG_SPI_DYNAMIC=y
CONFIG_SPMI=y
CONFIG_SPMI_HISI3670=y
CONFIG_HSI=y
CONFIG_HSI_BOARDINFO=y

#
# HSI controllers
#

#
# HSI clients
#
# CONFIG_HSI_CHAR is not set
# CONFIG_PPS is not set

#
# PTP clock support
#
CONFIG_PTP_1588_CLOCK_OPTIONAL=y

#
# Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks.
#
# end of PTP clock support

CONFIG_PINCTRL=y
CONFIG_GENERIC_PINCTRL_GROUPS=y
CONFIG_PINMUX=y
CONFIG_GENERIC_PINMUX_FUNCTIONS=y
CONFIG_PINCONF=y
CONFIG_GENERIC_PINCONF=y
# CONFIG_DEBUG_PINCTRL is not set
# CONFIG_PINCTRL_AMD is not set
# CONFIG_PINCTRL_AS3722 is not set
# CONFIG_PINCTRL_CY8C95X0 is not set
# CONFIG_PINCTRL_EQUILIBRIUM is not set
CONFIG_PINCTRL_MAX77620=y
CONFIG_PINCTRL_MCP23S08_I2C=y
CONFIG_PINCTRL_MCP23S08_SPI=y
CONFIG_PINCTRL_MCP23S08=y
CONFIG_PINCTRL_MICROCHIP_SGPIO=y
# CONFIG_PINCTRL_OCELOT is not set
CONFIG_PINCTRL_PALMAS=y
# CONFIG_PINCTRL_SINGLE is not set
# CONFIG_PINCTRL_STMFX is not set
CONFIG_PINCTRL_SX150X=y
CONFIG_PINCTRL_MADERA=y
CONFIG_PINCTRL_CS47L15=y
CONFIG_PINCTRL_CS47L35=y
CONFIG_PINCTRL_CS47L85=y
CONFIG_PINCTRL_CS47L92=y

#
# Intel pinctrl drivers
#
# CONFIG_PINCTRL_BAYTRAIL is not set
# CONFIG_PINCTRL_CHERRYVIEW is not set
# CONFIG_PINCTRL_LYNXPOINT is not set
# CONFIG_PINCTRL_ALDERLAKE is not set
# CONFIG_PINCTRL_BROXTON is not set
# CONFIG_PINCTRL_CANNONLAKE is not set
# CONFIG_PINCTRL_CEDARFORK is not set
# CONFIG_PINCTRL_DENVERTON is not set
# CONFIG_PINCTRL_ELKHARTLAKE is not set
# CONFIG_PINCTRL_EMMITSBURG is not set
# CONFIG_PINCTRL_GEMINILAKE is not set
# CONFIG_PINCTRL_ICELAKE is not set
# CONFIG_PINCTRL_JASPERLAKE is not set
# CONFIG_PINCTRL_LAKEFIELD is not set
# CONFIG_PINCTRL_LEWISBURG is not set
# CONFIG_PINCTRL_METEORLAKE is not set
# CONFIG_PINCTRL_SUNRISEPOINT is not set
# CONFIG_PINCTRL_TIGERLAKE is not set
# end of Intel pinctrl drivers

#
# Renesas pinctrl drivers
#
# end of Renesas pinctrl drivers

CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_OF_GPIO=y
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
CONFIG_DEBUG_GPIO=y
CONFIG_GPIO_SYSFS=y
CONFIG_GPIO_CDEV=y
# CONFIG_GPIO_CDEV_V1 is not set
CONFIG_GPIO_GENERIC=y
CONFIG_GPIO_MAX730X=y

#
# Memory mapped GPIO drivers
#
CONFIG_GPIO_74XX_MMIO=y
CONFIG_GPIO_ALTERA=y
# CONFIG_GPIO_AMDPT is not set
CONFIG_GPIO_CADENCE=y
# CONFIG_GPIO_DWAPB is not set
CONFIG_GPIO_FTGPIO010=y
CONFIG_GPIO_GENERIC_PLATFORM=y
# CONFIG_GPIO_GRGPIO is not set
CONFIG_GPIO_HLWD=y
CONFIG_GPIO_ICH=y
# CONFIG_GPIO_LOGICVC is not set
CONFIG_GPIO_MB86S7X=y
CONFIG_GPIO_MENZ127=y
# CONFIG_GPIO_SIFIVE is not set
# CONFIG_GPIO_SIOX is not set
# CONFIG_GPIO_STA2X11 is not set
CONFIG_GPIO_SYSCON=y
# CONFIG_GPIO_VX855 is not set
# CONFIG_GPIO_XILINX is not set
# CONFIG_GPIO_AMD_FCH is not set
# end of Memory mapped GPIO drivers

#
# Port-mapped I/O GPIO drivers
#
CONFIG_GPIO_I8255=y
CONFIG_GPIO_104_DIO_48E=y
CONFIG_GPIO_104_IDIO_16=y
CONFIG_GPIO_104_IDI_48=y
CONFIG_GPIO_F7188X=y
CONFIG_GPIO_GPIO_MM=y
CONFIG_GPIO_IT87=y
# CONFIG_GPIO_SCH is not set
CONFIG_GPIO_SCH311X=y
CONFIG_GPIO_WINBOND=y
CONFIG_GPIO_WS16C48=y
# end of Port-mapped I/O GPIO drivers

#
# I2C GPIO expanders
#
CONFIG_GPIO_ADNP=y
CONFIG_GPIO_GW_PLD=y
CONFIG_GPIO_MAX7300=y
CONFIG_GPIO_MAX732X=y
# CONFIG_GPIO_MAX732X_IRQ is not set
CONFIG_GPIO_PCA953X=y
CONFIG_GPIO_PCA953X_IRQ=y
# CONFIG_GPIO_PCA9570 is not set
# CONFIG_GPIO_PCF857X is not set
CONFIG_GPIO_TPIC2810=y
# end of I2C GPIO expanders

#
# MFD GPIO expanders
#
CONFIG_GPIO_ADP5520=y
CONFIG_GPIO_ARIZONA=y
CONFIG_GPIO_BD9571MWV=y
CONFIG_GPIO_DA9052=y
CONFIG_GPIO_DA9055=y
CONFIG_GPIO_KEMPLD=y
# CONFIG_GPIO_LP3943 is not set
# CONFIG_GPIO_LP873X is not set
CONFIG_GPIO_MADERA=y
CONFIG_GPIO_MAX77620=y
CONFIG_GPIO_PALMAS=y
CONFIG_GPIO_RC5T583=y
CONFIG_GPIO_TC3589X=y
CONFIG_GPIO_TPS65086=y
CONFIG_GPIO_TPS6586X=y
# CONFIG_GPIO_TPS65912 is not set
# CONFIG_GPIO_TWL4030 is not set
CONFIG_GPIO_WM831X=y
CONFIG_GPIO_WM8994=y
# end of MFD GPIO expanders

#
# PCI GPIO expanders
#
# CONFIG_GPIO_AMD8111 is not set
# CONFIG_GPIO_BT8XX is not set
# CONFIG_GPIO_ML_IOH is not set
CONFIG_GPIO_PCH=y
CONFIG_GPIO_PCI_IDIO_16=y
# CONFIG_GPIO_PCIE_IDIO_24 is not set
# CONFIG_GPIO_RDC321X is not set
CONFIG_GPIO_SODAVILLE=y
# end of PCI GPIO expanders

#
# SPI GPIO expanders
#
CONFIG_GPIO_74X164=y
# CONFIG_GPIO_MAX3191X is not set
CONFIG_GPIO_MAX7301=y
CONFIG_GPIO_MC33880=y
# CONFIG_GPIO_PISOSR is not set
# CONFIG_GPIO_XRA1403 is not set
# end of SPI GPIO expanders

#
# USB GPIO expanders
#
# end of USB GPIO expanders

#
# Virtual GPIO drivers
#
CONFIG_GPIO_AGGREGATOR=y
CONFIG_GPIO_MOCKUP=y
CONFIG_GPIO_VIRTIO=y
CONFIG_GPIO_SIM=y
# end of Virtual GPIO drivers

CONFIG_W1=y

#
# 1-wire Bus Masters
#
# CONFIG_W1_MASTER_MATROX is not set
CONFIG_W1_MASTER_DS2490=y
# CONFIG_W1_MASTER_DS2482 is not set
# CONFIG_W1_MASTER_DS1WM is not set
# CONFIG_W1_MASTER_GPIO is not set
# CONFIG_W1_MASTER_SGI is not set
# end of 1-wire Bus Masters

#
# 1-wire Slaves
#
CONFIG_W1_SLAVE_THERM=y
CONFIG_W1_SLAVE_SMEM=y
CONFIG_W1_SLAVE_DS2405=y
# CONFIG_W1_SLAVE_DS2408 is not set
CONFIG_W1_SLAVE_DS2413=y
CONFIG_W1_SLAVE_DS2406=y
CONFIG_W1_SLAVE_DS2423=y
CONFIG_W1_SLAVE_DS2805=y
# CONFIG_W1_SLAVE_DS2430 is not set
CONFIG_W1_SLAVE_DS2431=y
CONFIG_W1_SLAVE_DS2433=y
CONFIG_W1_SLAVE_DS2433_CRC=y
CONFIG_W1_SLAVE_DS2438=y
CONFIG_W1_SLAVE_DS250X=y
CONFIG_W1_SLAVE_DS2780=y
CONFIG_W1_SLAVE_DS2781=y
# CONFIG_W1_SLAVE_DS28E04 is not set
# CONFIG_W1_SLAVE_DS28E17 is not set
# end of 1-wire Slaves

# CONFIG_POWER_RESET is not set
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
# CONFIG_POWER_SUPPLY_HWMON is not set
CONFIG_PDA_POWER=y
CONFIG_IP5XXX_POWER=y
CONFIG_WM831X_BACKUP=y
CONFIG_WM831X_POWER=y
# CONFIG_TEST_POWER is not set
CONFIG_CHARGER_ADP5061=y
CONFIG_BATTERY_ACT8945A=y
CONFIG_BATTERY_CW2015=y
CONFIG_BATTERY_DS2760=y
CONFIG_BATTERY_DS2780=y
# CONFIG_BATTERY_DS2781 is not set
CONFIG_BATTERY_DS2782=y
# CONFIG_BATTERY_OLPC is not set
# CONFIG_BATTERY_SAMSUNG_SDI is not set
CONFIG_BATTERY_SBS=y
# CONFIG_CHARGER_SBS is not set
CONFIG_BATTERY_BQ27XXX=y
CONFIG_BATTERY_BQ27XXX_I2C=y
CONFIG_BATTERY_BQ27XXX_HDQ=y
# CONFIG_BATTERY_BQ27XXX_DT_UPDATES_NVM is not set
# CONFIG_BATTERY_DA9030 is not set
# CONFIG_BATTERY_DA9052 is not set
CONFIG_BATTERY_DA9150=y
CONFIG_BATTERY_MAX17040=y
CONFIG_BATTERY_MAX17042=y
CONFIG_BATTERY_MAX1721X=y
# CONFIG_CHARGER_ISP1704 is not set
CONFIG_CHARGER_MAX8903=y
CONFIG_CHARGER_LP8727=y
CONFIG_CHARGER_GPIO=y
# CONFIG_CHARGER_MANAGER is not set
CONFIG_CHARGER_LT3651=y
CONFIG_CHARGER_LTC4162L=y
CONFIG_CHARGER_DETECTOR_MAX14656=y
CONFIG_CHARGER_MAX77693=y
# CONFIG_CHARGER_MAX77976 is not set
CONFIG_CHARGER_MT6360=y
# CONFIG_CHARGER_BQ2415X is not set
CONFIG_CHARGER_BQ24190=y
# CONFIG_CHARGER_BQ24257 is not set
# CONFIG_CHARGER_BQ24735 is not set
CONFIG_CHARGER_BQ2515X=y
CONFIG_CHARGER_BQ25890=y
CONFIG_CHARGER_BQ25980=y
CONFIG_CHARGER_BQ256XX=y
CONFIG_CHARGER_SMB347=y
CONFIG_CHARGER_TPS65217=y
# CONFIG_BATTERY_GAUGE_LTC2941 is not set
CONFIG_BATTERY_GOLDFISH=y
# CONFIG_BATTERY_RT5033 is not set
CONFIG_CHARGER_RT9455=y
CONFIG_CHARGER_UCS1002=y
CONFIG_CHARGER_BD99954=y
CONFIG_BATTERY_UG3105=y
CONFIG_HWMON=y
CONFIG_HWMON_VID=y
CONFIG_HWMON_DEBUG_CHIP=y

#
# Native drivers
#
CONFIG_SENSORS_AD7314=y
CONFIG_SENSORS_AD7414=y
# CONFIG_SENSORS_AD7418 is not set
CONFIG_SENSORS_ADM1021=y
CONFIG_SENSORS_ADM1025=y
CONFIG_SENSORS_ADM1026=y
# CONFIG_SENSORS_ADM1029 is not set
CONFIG_SENSORS_ADM1031=y
CONFIG_SENSORS_ADM1177=y
CONFIG_SENSORS_ADM9240=y
# CONFIG_SENSORS_ADT7310 is not set
# CONFIG_SENSORS_ADT7410 is not set
CONFIG_SENSORS_ADT7411=y
# CONFIG_SENSORS_ADT7462 is not set
# CONFIG_SENSORS_ADT7470 is not set
CONFIG_SENSORS_ADT7475=y
CONFIG_SENSORS_AHT10=y
CONFIG_SENSORS_AQUACOMPUTER_D5NEXT=y
CONFIG_SENSORS_AS370=y
CONFIG_SENSORS_ASC7621=y
CONFIG_SENSORS_AXI_FAN_CONTROL=y
# CONFIG_SENSORS_K8TEMP is not set
# CONFIG_SENSORS_APPLESMC is not set
# CONFIG_SENSORS_ASB100 is not set
CONFIG_SENSORS_ATXP1=y
# CONFIG_SENSORS_CORSAIR_CPRO is not set
# CONFIG_SENSORS_CORSAIR_PSU is not set
CONFIG_SENSORS_DRIVETEMP=y
CONFIG_SENSORS_DS620=y
# CONFIG_SENSORS_DS1621 is not set
CONFIG_SENSORS_DELL_SMM=y
CONFIG_I8K=y
CONFIG_SENSORS_DA9052_ADC=y
CONFIG_SENSORS_DA9055=y
CONFIG_SENSORS_I5K_AMB=y
CONFIG_SENSORS_F71805F=y
CONFIG_SENSORS_F71882FG=y
# CONFIG_SENSORS_F75375S is not set
CONFIG_SENSORS_GSC=y
CONFIG_SENSORS_MC13783_ADC=y
CONFIG_SENSORS_FSCHMD=y
CONFIG_SENSORS_GL518SM=y
CONFIG_SENSORS_GL520SM=y
CONFIG_SENSORS_G760A=y
CONFIG_SENSORS_G762=y
CONFIG_SENSORS_GPIO_FAN=y
# CONFIG_SENSORS_HIH6130 is not set
# CONFIG_SENSORS_I5500 is not set
CONFIG_SENSORS_CORETEMP=y
CONFIG_SENSORS_IT87=y
CONFIG_SENSORS_JC42=y
CONFIG_SENSORS_POWR1220=y
CONFIG_SENSORS_LINEAGE=y
# CONFIG_SENSORS_LTC2945 is not set
# CONFIG_SENSORS_LTC2947_I2C is not set
# CONFIG_SENSORS_LTC2947_SPI is not set
CONFIG_SENSORS_LTC2990=y
CONFIG_SENSORS_LTC2992=y
# CONFIG_SENSORS_LTC4151 is not set
CONFIG_SENSORS_LTC4215=y
CONFIG_SENSORS_LTC4222=y
CONFIG_SENSORS_LTC4245=y
CONFIG_SENSORS_LTC4260=y
# CONFIG_SENSORS_LTC4261 is not set
CONFIG_SENSORS_MAX1111=y
# CONFIG_SENSORS_MAX127 is not set
CONFIG_SENSORS_MAX16065=y
CONFIG_SENSORS_MAX1619=y
CONFIG_SENSORS_MAX1668=y
CONFIG_SENSORS_MAX197=y
CONFIG_SENSORS_MAX31722=y
CONFIG_SENSORS_MAX31730=y
CONFIG_SENSORS_MAX31760=y
# CONFIG_SENSORS_MAX6620 is not set
# CONFIG_SENSORS_MAX6621 is not set
CONFIG_SENSORS_MAX6639=y
CONFIG_SENSORS_MAX6642=y
# CONFIG_SENSORS_MAX6650 is not set
CONFIG_SENSORS_MAX6697=y
CONFIG_SENSORS_MAX31790=y
CONFIG_SENSORS_MCP3021=y
CONFIG_SENSORS_TC654=y
# CONFIG_SENSORS_TPS23861 is not set
CONFIG_SENSORS_MR75203=y
CONFIG_SENSORS_ADCXX=y
CONFIG_SENSORS_LM63=y
CONFIG_SENSORS_LM70=y
CONFIG_SENSORS_LM73=y
CONFIG_SENSORS_LM75=y
CONFIG_SENSORS_LM77=y
CONFIG_SENSORS_LM78=y
# CONFIG_SENSORS_LM80 is not set
# CONFIG_SENSORS_LM83 is not set
CONFIG_SENSORS_LM85=y
# CONFIG_SENSORS_LM87 is not set
# CONFIG_SENSORS_LM90 is not set
CONFIG_SENSORS_LM92=y
# CONFIG_SENSORS_LM93 is not set
CONFIG_SENSORS_LM95234=y
# CONFIG_SENSORS_LM95241 is not set
CONFIG_SENSORS_LM95245=y
CONFIG_SENSORS_PC87360=y
# CONFIG_SENSORS_PC87427 is not set
CONFIG_SENSORS_NCT6683=y
CONFIG_SENSORS_NCT6775_CORE=y
CONFIG_SENSORS_NCT6775=y
CONFIG_SENSORS_NCT6775_I2C=y
# CONFIG_SENSORS_NCT7802 is not set
# CONFIG_SENSORS_NPCM7XX is not set
CONFIG_SENSORS_NZXT_KRAKEN2=y
# CONFIG_SENSORS_NZXT_SMART2 is not set
# CONFIG_SENSORS_PCF8591 is not set
CONFIG_PMBUS=y
CONFIG_SENSORS_PMBUS=y
CONFIG_SENSORS_ADM1266=y
CONFIG_SENSORS_ADM1275=y
CONFIG_SENSORS_BEL_PFE=y
# CONFIG_SENSORS_BPA_RS600 is not set
# CONFIG_SENSORS_DELTA_AHE50DC_FAN is not set
CONFIG_SENSORS_FSP_3Y=y
CONFIG_SENSORS_IBM_CFFPS=y
CONFIG_SENSORS_DPS920AB=y
# CONFIG_SENSORS_INSPUR_IPSPS is not set
CONFIG_SENSORS_IR35221=y
CONFIG_SENSORS_IR36021=y
CONFIG_SENSORS_IR38064=y
# CONFIG_SENSORS_IR38064_REGULATOR is not set
# CONFIG_SENSORS_IRPS5401 is not set
CONFIG_SENSORS_ISL68137=y
# CONFIG_SENSORS_LM25066 is not set
CONFIG_SENSORS_LT7182S=y
CONFIG_SENSORS_LTC2978=y
CONFIG_SENSORS_LTC2978_REGULATOR=y
CONFIG_SENSORS_LTC3815=y
# CONFIG_SENSORS_MAX15301 is not set
CONFIG_SENSORS_MAX16064=y
# CONFIG_SENSORS_MAX16601 is not set
CONFIG_SENSORS_MAX20730=y
CONFIG_SENSORS_MAX20751=y
CONFIG_SENSORS_MAX31785=y
# CONFIG_SENSORS_MAX34440 is not set
# CONFIG_SENSORS_MAX8688 is not set
CONFIG_SENSORS_MP2888=y
CONFIG_SENSORS_MP2975=y
CONFIG_SENSORS_MP5023=y
CONFIG_SENSORS_PIM4328=y
CONFIG_SENSORS_PLI1209BC=y
# CONFIG_SENSORS_PLI1209BC_REGULATOR is not set
CONFIG_SENSORS_PM6764TR=y
CONFIG_SENSORS_PXE1610=y
CONFIG_SENSORS_Q54SJ108A2=y
# CONFIG_SENSORS_STPDDC60 is not set
# CONFIG_SENSORS_TPS40422 is not set
# CONFIG_SENSORS_TPS53679 is not set
CONFIG_SENSORS_TPS546D24=y
CONFIG_SENSORS_UCD9000=y
# CONFIG_SENSORS_UCD9200 is not set
CONFIG_SENSORS_XDPE152=y
CONFIG_SENSORS_XDPE122=y
# CONFIG_SENSORS_XDPE122_REGULATOR is not set
# CONFIG_SENSORS_ZL6100 is not set
# CONFIG_SENSORS_PWM_FAN is not set
# CONFIG_SENSORS_SBTSI is not set
# CONFIG_SENSORS_SBRMI is not set
CONFIG_SENSORS_SHT15=y
CONFIG_SENSORS_SHT21=y
# CONFIG_SENSORS_SHT3x is not set
CONFIG_SENSORS_SHT4x=y
CONFIG_SENSORS_SHTC1=y
CONFIG_SENSORS_SIS5595=y
CONFIG_SENSORS_SY7636A=y
CONFIG_SENSORS_DME1737=y
# CONFIG_SENSORS_EMC1403 is not set
CONFIG_SENSORS_EMC2103=y
CONFIG_SENSORS_EMC2305=y
# CONFIG_SENSORS_EMC6W201 is not set
# CONFIG_SENSORS_SMSC47M1 is not set
# CONFIG_SENSORS_SMSC47M192 is not set
CONFIG_SENSORS_SMSC47B397=y
# CONFIG_SENSORS_STTS751 is not set
CONFIG_SENSORS_SMM665=y
CONFIG_SENSORS_ADC128D818=y
# CONFIG_SENSORS_ADS7828 is not set
# CONFIG_SENSORS_ADS7871 is not set
# CONFIG_SENSORS_AMC6821 is not set
CONFIG_SENSORS_INA209=y
CONFIG_SENSORS_INA2XX=y
CONFIG_SENSORS_INA238=y
# CONFIG_SENSORS_INA3221 is not set
CONFIG_SENSORS_TC74=y
CONFIG_SENSORS_THMC50=y
CONFIG_SENSORS_TMP102=y
CONFIG_SENSORS_TMP103=y
CONFIG_SENSORS_TMP108=y
# CONFIG_SENSORS_TMP401 is not set
CONFIG_SENSORS_TMP421=y
CONFIG_SENSORS_TMP464=y
CONFIG_SENSORS_TMP513=y
CONFIG_SENSORS_VIA_CPUTEMP=y
CONFIG_SENSORS_VIA686A=y
CONFIG_SENSORS_VT1211=y
CONFIG_SENSORS_VT8231=y
CONFIG_SENSORS_W83773G=y
CONFIG_SENSORS_W83781D=y
CONFIG_SENSORS_W83791D=y
CONFIG_SENSORS_W83792D=y
CONFIG_SENSORS_W83793=y
# CONFIG_SENSORS_W83795 is not set
CONFIG_SENSORS_W83L785TS=y
CONFIG_SENSORS_W83L786NG=y
# CONFIG_SENSORS_W83627HF is not set
CONFIG_SENSORS_W83627EHF=y
# CONFIG_SENSORS_WM831X is not set

#
# ACPI drivers
#
# CONFIG_SENSORS_ACPI_POWER is not set
# CONFIG_SENSORS_ATK0110 is not set
# CONFIG_SENSORS_ASUS_EC is not set
CONFIG_THERMAL=y
# CONFIG_THERMAL_NETLINK is not set
CONFIG_THERMAL_STATISTICS=y
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
CONFIG_THERMAL_HWMON=y
CONFIG_THERMAL_OF=y
CONFIG_THERMAL_WRITABLE_TRIPS=y
# CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE is not set
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE=y
# CONFIG_THERMAL_GOV_FAIR_SHARE is not set
CONFIG_THERMAL_GOV_STEP_WISE=y
# CONFIG_THERMAL_GOV_BANG_BANG is not set
CONFIG_THERMAL_GOV_USER_SPACE=y
CONFIG_CPU_THERMAL=y
# CONFIG_CPU_FREQ_THERMAL is not set
# CONFIG_THERMAL_EMULATION is not set
# CONFIG_THERMAL_MMIO is not set
# CONFIG_MAX77620_THERMAL is not set

#
# Intel thermal drivers
#
CONFIG_INTEL_POWERCLAMP=y
CONFIG_X86_THERMAL_VECTOR=y
CONFIG_X86_PKG_TEMP_THERMAL=y
# CONFIG_INTEL_SOC_DTS_THERMAL is not set
CONFIG_INTEL_QUARK_DTS_THERMAL=y

#
# ACPI INT340X thermal drivers
#
# end of ACPI INT340X thermal drivers

CONFIG_INTEL_PCH_THERMAL=y
CONFIG_INTEL_TCC_COOLING=y
# CONFIG_INTEL_MENLOW is not set
# CONFIG_INTEL_HFI_THERMAL is not set
# end of Intel thermal drivers

# CONFIG_WATCHDOG is not set
CONFIG_SSB_POSSIBLE=y
CONFIG_SSB=y
CONFIG_SSB_SPROM=y
CONFIG_SSB_PCIHOST_POSSIBLE=y
CONFIG_SSB_PCIHOST=y
CONFIG_SSB_PCMCIAHOST_POSSIBLE=y
CONFIG_SSB_PCMCIAHOST=y
CONFIG_SSB_DRIVER_PCICORE_POSSIBLE=y
CONFIG_SSB_DRIVER_PCICORE=y
# CONFIG_SSB_DRIVER_GPIO is not set
CONFIG_BCMA_POSSIBLE=y
CONFIG_BCMA=y
CONFIG_BCMA_HOST_PCI_POSSIBLE=y
CONFIG_BCMA_HOST_PCI=y
# CONFIG_BCMA_HOST_SOC is not set
CONFIG_BCMA_DRIVER_PCI=y
# CONFIG_BCMA_DRIVER_GMAC_CMN is not set
CONFIG_BCMA_DRIVER_GPIO=y
CONFIG_BCMA_DEBUG=y

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
# CONFIG_MFD_CS5535 is not set
CONFIG_MFD_ACT8945A=y
# CONFIG_MFD_AS3711 is not set
CONFIG_MFD_AS3722=y
CONFIG_PMIC_ADP5520=y
CONFIG_MFD_AAT2870_CORE=y
CONFIG_MFD_ATMEL_FLEXCOM=y
CONFIG_MFD_ATMEL_HLCDC=y
CONFIG_MFD_BCM590XX=y
CONFIG_MFD_BD9571MWV=y
# CONFIG_MFD_AXP20X_I2C is not set
CONFIG_MFD_MADERA=y
# CONFIG_MFD_MADERA_I2C is not set
CONFIG_MFD_MADERA_SPI=y
CONFIG_MFD_CS47L15=y
CONFIG_MFD_CS47L35=y
CONFIG_MFD_CS47L85=y
# CONFIG_MFD_CS47L90 is not set
CONFIG_MFD_CS47L92=y
CONFIG_PMIC_DA903X=y
CONFIG_PMIC_DA9052=y
# CONFIG_MFD_DA9052_SPI is not set
CONFIG_MFD_DA9052_I2C=y
CONFIG_MFD_DA9055=y
# CONFIG_MFD_DA9062 is not set
CONFIG_MFD_DA9063=y
CONFIG_MFD_DA9150=y
# CONFIG_MFD_DLN2 is not set
CONFIG_MFD_GATEWORKS_GSC=y
CONFIG_MFD_MC13XXX=y
# CONFIG_MFD_MC13XXX_SPI is not set
CONFIG_MFD_MC13XXX_I2C=y
CONFIG_MFD_MP2629=y
CONFIG_MFD_HI6421_PMIC=y
CONFIG_MFD_HI6421_SPMI=y
CONFIG_HTC_PASIC3=y
# CONFIG_HTC_I2CPLD is not set
CONFIG_MFD_INTEL_QUARK_I2C_GPIO=y
CONFIG_LPC_ICH=y
CONFIG_LPC_SCH=y
# CONFIG_INTEL_SOC_PMIC is not set
# CONFIG_INTEL_SOC_PMIC_CHTWC is not set
# CONFIG_INTEL_SOC_PMIC_CHTDC_TI is not set
# CONFIG_INTEL_SOC_PMIC_MRFLD is not set
CONFIG_MFD_INTEL_LPSS=y
# CONFIG_MFD_INTEL_LPSS_ACPI is not set
CONFIG_MFD_INTEL_LPSS_PCI=y
# CONFIG_MFD_INTEL_PMC_BXT is not set
CONFIG_MFD_IQS62X=y
# CONFIG_MFD_JANZ_CMODIO is not set
CONFIG_MFD_KEMPLD=y
# CONFIG_MFD_88PM800 is not set
CONFIG_MFD_88PM805=y
# CONFIG_MFD_88PM860X is not set
# CONFIG_MFD_MAX14577 is not set
CONFIG_MFD_MAX77620=y
# CONFIG_MFD_MAX77650 is not set
CONFIG_MFD_MAX77686=y
CONFIG_MFD_MAX77693=y
CONFIG_MFD_MAX77714=y
# CONFIG_MFD_MAX77843 is not set
# CONFIG_MFD_MAX8907 is not set
# CONFIG_MFD_MAX8925 is not set
# CONFIG_MFD_MAX8997 is not set
# CONFIG_MFD_MAX8998 is not set
CONFIG_MFD_MT6360=y
CONFIG_MFD_MT6370=y
# CONFIG_MFD_MT6397 is not set
# CONFIG_MFD_MENF21BMC is not set
CONFIG_MFD_OCELOT=y
# CONFIG_EZX_PCAP is not set
CONFIG_MFD_CPCAP=y
# CONFIG_MFD_VIPERBOARD is not set
# CONFIG_MFD_NTXEC is not set
# CONFIG_MFD_RETU is not set
# CONFIG_MFD_PCF50633 is not set
CONFIG_MFD_SY7636A=y
# CONFIG_MFD_RDC321X is not set
# CONFIG_MFD_RT4831 is not set
CONFIG_MFD_RT5033=y
# CONFIG_MFD_RT5120 is not set
CONFIG_MFD_RC5T583=y
# CONFIG_MFD_RK808 is not set
CONFIG_MFD_RN5T618=y
CONFIG_MFD_SEC_CORE=y
# CONFIG_MFD_SI476X_CORE is not set
CONFIG_MFD_SIMPLE_MFD_I2C=y
CONFIG_MFD_SM501=y
# CONFIG_MFD_SM501_GPIO is not set
CONFIG_MFD_SKY81452=y
# CONFIG_MFD_STMPE is not set
CONFIG_MFD_STA2X11=y
CONFIG_MFD_SYSCON=y
CONFIG_MFD_TI_AM335X_TSCADC=y
CONFIG_MFD_LP3943=y
CONFIG_MFD_LP8788=y
# CONFIG_MFD_TI_LMU is not set
CONFIG_MFD_PALMAS=y
CONFIG_TPS6105X=y
# CONFIG_TPS65010 is not set
# CONFIG_TPS6507X is not set
CONFIG_MFD_TPS65086=y
# CONFIG_MFD_TPS65090 is not set
CONFIG_MFD_TPS65217=y
CONFIG_MFD_TI_LP873X=y
# CONFIG_MFD_TI_LP87565 is not set
# CONFIG_MFD_TPS65218 is not set
CONFIG_MFD_TPS6586X=y
# CONFIG_MFD_TPS65910 is not set
CONFIG_MFD_TPS65912=y
CONFIG_MFD_TPS65912_I2C=y
CONFIG_MFD_TPS65912_SPI=y
CONFIG_TWL4030_CORE=y
CONFIG_MFD_TWL4030_AUDIO=y
# CONFIG_TWL6040_CORE is not set
CONFIG_MFD_WL1273_CORE=y
CONFIG_MFD_LM3533=y
# CONFIG_MFD_TIMBERDALE is not set
CONFIG_MFD_TC3589X=y
# CONFIG_MFD_TQMX86 is not set
# CONFIG_MFD_VX855 is not set
# CONFIG_MFD_LOCHNAGAR is not set
CONFIG_MFD_ARIZONA=y
CONFIG_MFD_ARIZONA_I2C=y
# CONFIG_MFD_ARIZONA_SPI is not set
# CONFIG_MFD_CS47L24 is not set
# CONFIG_MFD_WM5102 is not set
# CONFIG_MFD_WM5110 is not set
CONFIG_MFD_WM8997=y
CONFIG_MFD_WM8998=y
CONFIG_MFD_WM8400=y
CONFIG_MFD_WM831X=y
# CONFIG_MFD_WM831X_I2C is not set
CONFIG_MFD_WM831X_SPI=y
# CONFIG_MFD_WM8350_I2C is not set
CONFIG_MFD_WM8994=y
# CONFIG_MFD_ROHM_BD718XX is not set
# CONFIG_MFD_ROHM_BD71828 is not set
# CONFIG_MFD_ROHM_BD957XMUF is not set
CONFIG_MFD_STPMIC1=y
# CONFIG_MFD_STMFX is not set
CONFIG_MFD_ATC260X=y
CONFIG_MFD_ATC260X_I2C=y
CONFIG_MFD_QCOM_PM8008=y
# CONFIG_MFD_INTEL_M10_BMC is not set
CONFIG_MFD_RSMU_I2C=y
# CONFIG_MFD_RSMU_SPI is not set
# end of Multifunction device drivers

CONFIG_REGULATOR=y
CONFIG_REGULATOR_DEBUG=y
CONFIG_REGULATOR_FIXED_VOLTAGE=y
# CONFIG_REGULATOR_VIRTUAL_CONSUMER is not set
# CONFIG_REGULATOR_USERSPACE_CONSUMER is not set
CONFIG_REGULATOR_88PG86X=y
CONFIG_REGULATOR_ACT8865=y
CONFIG_REGULATOR_ACT8945A=y
CONFIG_REGULATOR_AD5398=y
CONFIG_REGULATOR_AAT2870=y
# CONFIG_REGULATOR_AS3722 is not set
CONFIG_REGULATOR_ATC260X=y
# CONFIG_REGULATOR_BCM590XX is not set
CONFIG_REGULATOR_BD9571MWV=y
CONFIG_REGULATOR_CPCAP=y
# CONFIG_REGULATOR_DA903X is not set
CONFIG_REGULATOR_DA9052=y
# CONFIG_REGULATOR_DA9055 is not set
CONFIG_REGULATOR_DA9063=y
CONFIG_REGULATOR_DA9121=y
CONFIG_REGULATOR_DA9210=y
CONFIG_REGULATOR_DA9211=y
CONFIG_REGULATOR_FAN53555=y
CONFIG_REGULATOR_FAN53880=y
# CONFIG_REGULATOR_GPIO is not set
CONFIG_REGULATOR_HI6421=y
CONFIG_REGULATOR_HI6421V530=y
CONFIG_REGULATOR_HI6421V600=y
CONFIG_REGULATOR_ISL9305=y
CONFIG_REGULATOR_ISL6271A=y
CONFIG_REGULATOR_LP3971=y
# CONFIG_REGULATOR_LP3972 is not set
CONFIG_REGULATOR_LP872X=y
CONFIG_REGULATOR_LP873X=y
# CONFIG_REGULATOR_LP8755 is not set
CONFIG_REGULATOR_LP8788=y
CONFIG_REGULATOR_LTC3589=y
CONFIG_REGULATOR_LTC3676=y
CONFIG_REGULATOR_MAX1586=y
CONFIG_REGULATOR_MAX77620=y
CONFIG_REGULATOR_MAX8649=y
# CONFIG_REGULATOR_MAX8660 is not set
CONFIG_REGULATOR_MAX8893=y
CONFIG_REGULATOR_MAX8952=y
CONFIG_REGULATOR_MAX8973=y
CONFIG_REGULATOR_MAX20086=y
CONFIG_REGULATOR_MAX77686=y
# CONFIG_REGULATOR_MAX77693 is not set
CONFIG_REGULATOR_MAX77802=y
CONFIG_REGULATOR_MAX77826=y
CONFIG_REGULATOR_MC13XXX_CORE=y
CONFIG_REGULATOR_MC13783=y
CONFIG_REGULATOR_MC13892=y
CONFIG_REGULATOR_MCP16502=y
CONFIG_REGULATOR_MP5416=y
CONFIG_REGULATOR_MP8859=y
CONFIG_REGULATOR_MP886X=y
# CONFIG_REGULATOR_MPQ7920 is not set
# CONFIG_REGULATOR_MT6311 is not set
CONFIG_REGULATOR_MT6315=y
CONFIG_REGULATOR_MT6360=y
CONFIG_REGULATOR_MT6370=y
CONFIG_REGULATOR_PALMAS=y
# CONFIG_REGULATOR_PCA9450 is not set
CONFIG_REGULATOR_PF8X00=y
CONFIG_REGULATOR_PFUZE100=y
CONFIG_REGULATOR_PV88060=y
# CONFIG_REGULATOR_PV88080 is not set
# CONFIG_REGULATOR_PV88090 is not set
# CONFIG_REGULATOR_PWM is not set
CONFIG_REGULATOR_QCOM_SPMI=y
CONFIG_REGULATOR_QCOM_USB_VBUS=y
CONFIG_REGULATOR_RASPBERRYPI_TOUCHSCREEN_ATTINY=y
CONFIG_REGULATOR_RC5T583=y
CONFIG_REGULATOR_RN5T618=y
CONFIG_REGULATOR_RT4801=y
CONFIG_REGULATOR_RT5033=y
CONFIG_REGULATOR_RT5190A=y
# CONFIG_REGULATOR_RT5759 is not set
CONFIG_REGULATOR_RT6160=y
# CONFIG_REGULATOR_RT6245 is not set
# CONFIG_REGULATOR_RTQ2134 is not set
CONFIG_REGULATOR_RTMV20=y
CONFIG_REGULATOR_RTQ6752=y
CONFIG_REGULATOR_S2MPA01=y
CONFIG_REGULATOR_S2MPS11=y
# CONFIG_REGULATOR_S5M8767 is not set
CONFIG_REGULATOR_SKY81452=y
CONFIG_REGULATOR_SLG51000=y
CONFIG_REGULATOR_STPMIC1=y
CONFIG_REGULATOR_SY7636A=y
CONFIG_REGULATOR_SY8106A=y
# CONFIG_REGULATOR_SY8824X is not set
CONFIG_REGULATOR_SY8827N=y
CONFIG_REGULATOR_TPS51632=y
# CONFIG_REGULATOR_TPS6105X is not set
CONFIG_REGULATOR_TPS62360=y
# CONFIG_REGULATOR_TPS6286X is not set
CONFIG_REGULATOR_TPS65023=y
# CONFIG_REGULATOR_TPS6507X is not set
CONFIG_REGULATOR_TPS65086=y
CONFIG_REGULATOR_TPS65132=y
CONFIG_REGULATOR_TPS65217=y
CONFIG_REGULATOR_TPS6524X=y
CONFIG_REGULATOR_TPS6586X=y
CONFIG_REGULATOR_TPS65912=y
CONFIG_REGULATOR_TWL4030=y
CONFIG_REGULATOR_VCTRL=y
CONFIG_REGULATOR_WM831X=y
CONFIG_REGULATOR_WM8400=y
CONFIG_REGULATOR_WM8994=y
CONFIG_REGULATOR_QCOM_LABIBB=y
CONFIG_RC_CORE=y
CONFIG_LIRC=y
CONFIG_RC_MAP=y
CONFIG_RC_DECODERS=y
# CONFIG_IR_IMON_DECODER is not set
CONFIG_IR_JVC_DECODER=y
# CONFIG_IR_MCE_KBD_DECODER is not set
# CONFIG_IR_NEC_DECODER is not set
CONFIG_IR_RC5_DECODER=y
CONFIG_IR_RC6_DECODER=y
CONFIG_IR_RCMM_DECODER=y
CONFIG_IR_SANYO_DECODER=y
CONFIG_IR_SHARP_DECODER=y
# CONFIG_IR_SONY_DECODER is not set
CONFIG_IR_XMP_DECODER=y
CONFIG_RC_DEVICES=y
# CONFIG_IR_ENE is not set
# CONFIG_IR_FINTEK is not set
CONFIG_IR_GPIO_CIR=y
CONFIG_IR_GPIO_TX=y
# CONFIG_IR_HIX5HD2 is not set
# CONFIG_IR_IGORPLUGUSB is not set
CONFIG_IR_IGUANA=y
CONFIG_IR_IMON=y
CONFIG_IR_IMON_RAW=y
# CONFIG_IR_ITE_CIR is not set
# CONFIG_IR_MCEUSB is not set
# CONFIG_IR_NUVOTON is not set
# CONFIG_IR_PWM_TX is not set
# CONFIG_IR_REDRAT3 is not set
# CONFIG_IR_SERIAL is not set
CONFIG_IR_SPI=y
CONFIG_IR_STREAMZAP=y
CONFIG_IR_TOY=y
CONFIG_IR_TTUSBIR=y
# CONFIG_IR_WINBOND_CIR is not set
CONFIG_RC_ATI_REMOTE=y
CONFIG_RC_LOOPBACK=y
# CONFIG_RC_XBOX_DVD is not set
CONFIG_CEC_CORE=y

#
# CEC support
#
# CONFIG_MEDIA_CEC_RC is not set
CONFIG_MEDIA_CEC_SUPPORT=y
CONFIG_CEC_CH7322=y
CONFIG_USB_PULSE8_CEC=y
CONFIG_USB_RAINSHADOW_CEC=y
# end of CEC support

# CONFIG_MEDIA_SUPPORT is not set

#
# Graphics support
#
CONFIG_APERTURE_HELPERS=y
# CONFIG_AGP is not set
# CONFIG_VGA_SWITCHEROO is not set
CONFIG_DRM=y
CONFIG_DRM_MIPI_DBI=y
CONFIG_DRM_MIPI_DSI=y
# CONFIG_DRM_DEBUG_MM is not set
CONFIG_DRM_USE_DYNAMIC_DEBUG=y
CONFIG_DRM_KMS_HELPER=y
# CONFIG_DRM_DEBUG_DP_MST_TOPOLOGY_REFS is not set
CONFIG_DRM_DEBUG_MODESET_LOCK=y
CONFIG_DRM_FBDEV_EMULATION=y
CONFIG_DRM_FBDEV_OVERALLOC=100
CONFIG_DRM_FBDEV_LEAK_PHYS_SMEM=y
# CONFIG_DRM_LOAD_EDID_FIRMWARE is not set
CONFIG_DRM_DP_AUX_BUS=y
CONFIG_DRM_DISPLAY_HELPER=y
CONFIG_DRM_DISPLAY_DP_HELPER=y
CONFIG_DRM_DISPLAY_HDCP_HELPER=y
CONFIG_DRM_DISPLAY_HDMI_HELPER=y
CONFIG_DRM_DP_AUX_CHARDEV=y
# CONFIG_DRM_DP_CEC is not set
CONFIG_DRM_TTM=y
CONFIG_DRM_VRAM_HELPER=y
CONFIG_DRM_TTM_HELPER=y
CONFIG_DRM_GEM_DMA_HELPER=y
CONFIG_DRM_GEM_SHMEM_HELPER=y
CONFIG_DRM_SCHED=y

#
# I2C encoder or helper chips
#
# CONFIG_DRM_I2C_CH7006 is not set
# CONFIG_DRM_I2C_SIL164 is not set
# CONFIG_DRM_I2C_NXP_TDA998X is not set
# CONFIG_DRM_I2C_NXP_TDA9950 is not set
# end of I2C encoder or helper chips

#
# ARM devices
#
CONFIG_DRM_KOMEDA=y
# end of ARM devices

# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_AMDGPU is not set
# CONFIG_DRM_NOUVEAU is not set
# CONFIG_DRM_I915 is not set
CONFIG_DRM_VGEM=y
# CONFIG_DRM_VKMS is not set
# CONFIG_DRM_VMWGFX is not set
# CONFIG_DRM_GMA500 is not set
# CONFIG_DRM_UDL is not set
CONFIG_DRM_AST=y
# CONFIG_DRM_MGAG200 is not set
CONFIG_DRM_RCAR_DW_HDMI=y
CONFIG_DRM_RCAR_USE_LVDS=y
# CONFIG_DRM_RCAR_MIPI_DSI is not set
CONFIG_DRM_QXL=y
# CONFIG_DRM_VIRTIO_GPU is not set
CONFIG_DRM_PANEL=y

#
# Display Panels
#
# CONFIG_DRM_PANEL_ABT_Y030XX067A is not set
# CONFIG_DRM_PANEL_ARM_VERSATILE is not set
# CONFIG_DRM_PANEL_ASUS_Z00T_TM5P5_NT35596 is not set
CONFIG_DRM_PANEL_BOE_BF060Y8M_AJ0=y
CONFIG_DRM_PANEL_BOE_HIMAX8279D=y
CONFIG_DRM_PANEL_BOE_TV101WUM_NL6=y
CONFIG_DRM_PANEL_DSI_CM=y
CONFIG_DRM_PANEL_LVDS=y
# CONFIG_DRM_PANEL_EBBG_FT8719 is not set
CONFIG_DRM_PANEL_ELIDA_KD35T133=y
# CONFIG_DRM_PANEL_FEIXIN_K101_IM2BA02 is not set
# CONFIG_DRM_PANEL_FEIYANG_FY07024DI26A30D is not set
# CONFIG_DRM_PANEL_ILITEK_IL9322 is not set
# CONFIG_DRM_PANEL_ILITEK_ILI9341 is not set
# CONFIG_DRM_PANEL_ILITEK_ILI9881C is not set
CONFIG_DRM_PANEL_INNOLUX_EJ030NA=y
CONFIG_DRM_PANEL_INNOLUX_P079ZCA=y
# CONFIG_DRM_PANEL_JDI_LT070ME05000 is not set
# CONFIG_DRM_PANEL_JDI_R63452 is not set
CONFIG_DRM_PANEL_KHADAS_TS050=y
CONFIG_DRM_PANEL_KINGDISPLAY_KD097D04=y
# CONFIG_DRM_PANEL_LEADTEK_LTK050H3146W is not set
# CONFIG_DRM_PANEL_LEADTEK_LTK500HD1829 is not set
CONFIG_DRM_PANEL_SAMSUNG_LD9040=y
CONFIG_DRM_PANEL_LG_LB035Q02=y
CONFIG_DRM_PANEL_LG_LG4573=y
CONFIG_DRM_PANEL_NEC_NL8048HL11=y
CONFIG_DRM_PANEL_NEWVISION_NV3052C=y
CONFIG_DRM_PANEL_NOVATEK_NT35510=y
CONFIG_DRM_PANEL_NOVATEK_NT35560=y
# CONFIG_DRM_PANEL_NOVATEK_NT35950 is not set
# CONFIG_DRM_PANEL_NOVATEK_NT36672A is not set
CONFIG_DRM_PANEL_NOVATEK_NT39016=y
CONFIG_DRM_PANEL_MANTIX_MLAF057WE51=y
CONFIG_DRM_PANEL_OLIMEX_LCD_OLINUXINO=y
# CONFIG_DRM_PANEL_ORISETECH_OTM8009A is not set
# CONFIG_DRM_PANEL_OSD_OSD101T2587_53TS is not set
CONFIG_DRM_PANEL_PANASONIC_VVX10F034N00=y
# CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN is not set
CONFIG_DRM_PANEL_RAYDIUM_RM67191=y
CONFIG_DRM_PANEL_RAYDIUM_RM68200=y
CONFIG_DRM_PANEL_RONBO_RB070D30=y
CONFIG_DRM_PANEL_SAMSUNG_DB7430=y
CONFIG_DRM_PANEL_SAMSUNG_S6D16D0=y
# CONFIG_DRM_PANEL_SAMSUNG_S6D27A1 is not set
CONFIG_DRM_PANEL_SAMSUNG_S6E3HA2=y
CONFIG_DRM_PANEL_SAMSUNG_S6E63J0X03=y
CONFIG_DRM_PANEL_SAMSUNG_S6E63M0=y
# CONFIG_DRM_PANEL_SAMSUNG_S6E63M0_SPI is not set
# CONFIG_DRM_PANEL_SAMSUNG_S6E63M0_DSI is not set
CONFIG_DRM_PANEL_SAMSUNG_S6E88A0_AMS452EF01=y
# CONFIG_DRM_PANEL_SAMSUNG_S6E8AA0 is not set
CONFIG_DRM_PANEL_SAMSUNG_SOFEF00=y
CONFIG_DRM_PANEL_SEIKO_43WVF1G=y
# CONFIG_DRM_PANEL_SHARP_LQ101R1SX01 is not set
# CONFIG_DRM_PANEL_SHARP_LS037V7DW01 is not set
CONFIG_DRM_PANEL_SHARP_LS043T1LE01=y
CONFIG_DRM_PANEL_SHARP_LS060T1SX01=y
CONFIG_DRM_PANEL_SITRONIX_ST7701=y
CONFIG_DRM_PANEL_SITRONIX_ST7703=y
# CONFIG_DRM_PANEL_SITRONIX_ST7789V is not set
# CONFIG_DRM_PANEL_SONY_ACX565AKM is not set
# CONFIG_DRM_PANEL_SONY_TULIP_TRULY_NT35521 is not set
CONFIG_DRM_PANEL_TDO_TL070WSH30=y
CONFIG_DRM_PANEL_TPO_TD028TTEC1=y
CONFIG_DRM_PANEL_TPO_TD043MTEA1=y
# CONFIG_DRM_PANEL_TPO_TPG110 is not set
CONFIG_DRM_PANEL_TRULY_NT35597_WQXGA=y
# CONFIG_DRM_PANEL_VISIONOX_RM69299 is not set
CONFIG_DRM_PANEL_WIDECHIPS_WS2401=y
CONFIG_DRM_PANEL_XINPENG_XPP055C272=y
# end of Display Panels

CONFIG_DRM_BRIDGE=y
CONFIG_DRM_PANEL_BRIDGE=y

#
# Display Interface Bridges
#
CONFIG_DRM_CDNS_DSI=y
CONFIG_DRM_CHIPONE_ICN6211=y
CONFIG_DRM_CHRONTEL_CH7033=y
CONFIG_DRM_DISPLAY_CONNECTOR=y
# CONFIG_DRM_ITE_IT6505 is not set
CONFIG_DRM_LONTIUM_LT8912B=y
CONFIG_DRM_LONTIUM_LT9211=y
CONFIG_DRM_LONTIUM_LT9611=y
# CONFIG_DRM_LONTIUM_LT9611UXC is not set
CONFIG_DRM_ITE_IT66121=y
CONFIG_DRM_LVDS_CODEC=y
CONFIG_DRM_MEGACHIPS_STDPXXXX_GE_B850V3_FW=y
CONFIG_DRM_NWL_MIPI_DSI=y
# CONFIG_DRM_NXP_PTN3460 is not set
# CONFIG_DRM_PARADE_PS8622 is not set
CONFIG_DRM_PARADE_PS8640=y
CONFIG_DRM_SIL_SII8620=y
# CONFIG_DRM_SII902X is not set
CONFIG_DRM_SII9234=y
CONFIG_DRM_SIMPLE_BRIDGE=y
CONFIG_DRM_THINE_THC63LVD1024=y
CONFIG_DRM_TOSHIBA_TC358762=y
# CONFIG_DRM_TOSHIBA_TC358764 is not set
# CONFIG_DRM_TOSHIBA_TC358767 is not set
# CONFIG_DRM_TOSHIBA_TC358768 is not set
# CONFIG_DRM_TOSHIBA_TC358775 is not set
CONFIG_DRM_TI_DLPC3433=y
CONFIG_DRM_TI_TFP410=y
CONFIG_DRM_TI_SN65DSI83=y
CONFIG_DRM_TI_SN65DSI86=y
CONFIG_DRM_TI_TPD12S015=y
CONFIG_DRM_ANALOGIX_ANX6345=y
CONFIG_DRM_ANALOGIX_ANX78XX=y
CONFIG_DRM_ANALOGIX_DP=y
CONFIG_DRM_ANALOGIX_ANX7625=y
CONFIG_DRM_I2C_ADV7511=y
# CONFIG_DRM_I2C_ADV7511_CEC is not set
CONFIG_DRM_CDNS_MHDP8546=y
CONFIG_DRM_DW_HDMI=y
# CONFIG_DRM_DW_HDMI_CEC is not set
# end of Display Interface Bridges

CONFIG_DRM_ETNAVIV=y
CONFIG_DRM_ETNAVIV_THERMAL=y
# CONFIG_DRM_LOGICVC is not set
CONFIG_DRM_MXS=y
CONFIG_DRM_MXSFB=y
# CONFIG_DRM_IMX_LCDIF is not set
CONFIG_DRM_ARCPGU=y
CONFIG_DRM_BOCHS=y
# CONFIG_DRM_CIRRUS_QEMU is not set
CONFIG_DRM_GM12U320=y
CONFIG_DRM_PANEL_MIPI_DBI=y
CONFIG_DRM_SIMPLEDRM=y
# CONFIG_TINYDRM_HX8357D is not set
CONFIG_TINYDRM_ILI9163=y
# CONFIG_TINYDRM_ILI9225 is not set
# CONFIG_TINYDRM_ILI9341 is not set
CONFIG_TINYDRM_ILI9486=y
CONFIG_TINYDRM_MI0283QT=y
CONFIG_TINYDRM_REPAPER=y
# CONFIG_TINYDRM_ST7586 is not set
CONFIG_TINYDRM_ST7735R=y
CONFIG_DRM_VBOXVIDEO=y
CONFIG_DRM_GUD=y
CONFIG_DRM_SSD130X=y
# CONFIG_DRM_SSD130X_I2C is not set
# CONFIG_DRM_SSD130X_SPI is not set
CONFIG_DRM_LEGACY=y
CONFIG_DRM_TDFX=y
# CONFIG_DRM_R128 is not set
CONFIG_DRM_MGA=y
# CONFIG_DRM_VIA is not set
# CONFIG_DRM_SAVAGE is not set
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y
CONFIG_DRM_NOMODESET=y

#
# Frame buffer Devices
#
CONFIG_FB_CMDLINE=y
CONFIG_FB_NOTIFY=y
CONFIG_FB=y
# CONFIG_FIRMWARE_EDID is not set
CONFIG_FB_DDC=y
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
CONFIG_FB_SYS_FILLRECT=y
CONFIG_FB_SYS_COPYAREA=y
CONFIG_FB_SYS_IMAGEBLIT=y
CONFIG_FB_FOREIGN_ENDIAN=y
# CONFIG_FB_BOTH_ENDIAN is not set
# CONFIG_FB_BIG_ENDIAN is not set
CONFIG_FB_LITTLE_ENDIAN=y
CONFIG_FB_SYS_FOPS=y
CONFIG_FB_DEFERRED_IO=y
CONFIG_FB_SVGALIB=y
CONFIG_FB_BACKLIGHT=y
CONFIG_FB_MODE_HELPERS=y
CONFIG_FB_TILEBLITTING=y

#
# Frame buffer hardware drivers
#
CONFIG_FB_CIRRUS=y
CONFIG_FB_PM2=y
CONFIG_FB_PM2_FIFO_DISCONNECT=y
# CONFIG_FB_CYBER2000 is not set
CONFIG_FB_ARC=y
# CONFIG_FB_ASILIANT is not set
CONFIG_FB_IMSTT=y
# CONFIG_FB_VGA16 is not set
CONFIG_FB_VESA=y
# CONFIG_FB_N411 is not set
# CONFIG_FB_HGA is not set
# CONFIG_FB_OPENCORES is not set
CONFIG_FB_S1D13XXX=y
CONFIG_FB_NVIDIA=y
# CONFIG_FB_NVIDIA_I2C is not set
CONFIG_FB_NVIDIA_DEBUG=y
# CONFIG_FB_NVIDIA_BACKLIGHT is not set
CONFIG_FB_RIVA=y
# CONFIG_FB_RIVA_I2C is not set
CONFIG_FB_RIVA_DEBUG=y
CONFIG_FB_RIVA_BACKLIGHT=y
CONFIG_FB_I740=y
# CONFIG_FB_LE80578 is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON is not set
CONFIG_FB_ATY128=y
# CONFIG_FB_ATY128_BACKLIGHT is not set
CONFIG_FB_ATY=y
# CONFIG_FB_ATY_CT is not set
CONFIG_FB_ATY_GX=y
CONFIG_FB_ATY_BACKLIGHT=y
# CONFIG_FB_S3 is not set
CONFIG_FB_SAVAGE=y
CONFIG_FB_SAVAGE_I2C=y
# CONFIG_FB_SAVAGE_ACCEL is not set
CONFIG_FB_SIS=y
CONFIG_FB_SIS_300=y
# CONFIG_FB_SIS_315 is not set
CONFIG_FB_VIA=y
# CONFIG_FB_VIA_DIRECT_PROCFS is not set
# CONFIG_FB_VIA_X_COMPATIBILITY is not set
CONFIG_FB_NEOMAGIC=y
CONFIG_FB_KYRO=y
# CONFIG_FB_3DFX is not set
CONFIG_FB_VOODOO1=y
CONFIG_FB_VT8623=y
# CONFIG_FB_TRIDENT is not set
CONFIG_FB_ARK=y
CONFIG_FB_PM3=y
CONFIG_FB_CARMINE=y
CONFIG_FB_CARMINE_DRAM_EVAL=y
# CONFIG_CARMINE_DRAM_CUSTOM is not set
# CONFIG_FB_GEODE is not set
CONFIG_FB_SM501=y
# CONFIG_FB_SMSCUFX is not set
# CONFIG_FB_UDL is not set
# CONFIG_FB_IBM_GXT4500 is not set
CONFIG_FB_GOLDFISH=y
CONFIG_FB_VIRTUAL=y
# CONFIG_FB_METRONOME is not set
CONFIG_FB_MB862XX=y
CONFIG_FB_MB862XX_PCI_GDC=y
# CONFIG_FB_MB862XX_I2C is not set
CONFIG_FB_SSD1307=y
# CONFIG_FB_SM712 is not set
# end of Frame buffer Devices

#
# Backlight & LCD device support
#
CONFIG_LCD_CLASS_DEVICE=y
# CONFIG_LCD_L4F00242T03 is not set
# CONFIG_LCD_LMS283GF05 is not set
# CONFIG_LCD_LTV350QV is not set
CONFIG_LCD_ILI922X=y
CONFIG_LCD_ILI9320=y
CONFIG_LCD_TDO24M=y
# CONFIG_LCD_VGG2432A4 is not set
# CONFIG_LCD_PLATFORM is not set
CONFIG_LCD_AMS369FG06=y
CONFIG_LCD_LMS501KF03=y
CONFIG_LCD_HX8357=y
CONFIG_LCD_OTM3225A=y
CONFIG_BACKLIGHT_CLASS_DEVICE=y
CONFIG_BACKLIGHT_KTD253=y
# CONFIG_BACKLIGHT_LM3533 is not set
# CONFIG_BACKLIGHT_PWM is not set
CONFIG_BACKLIGHT_DA903X=y
CONFIG_BACKLIGHT_DA9052=y
# CONFIG_BACKLIGHT_MT6370 is not set
# CONFIG_BACKLIGHT_APPLE is not set
CONFIG_BACKLIGHT_QCOM_WLED=y
# CONFIG_BACKLIGHT_SAHARA is not set
CONFIG_BACKLIGHT_WM831X=y
CONFIG_BACKLIGHT_ADP5520=y
CONFIG_BACKLIGHT_ADP8860=y
CONFIG_BACKLIGHT_ADP8870=y
# CONFIG_BACKLIGHT_AAT2870 is not set
# CONFIG_BACKLIGHT_LM3630A is not set
CONFIG_BACKLIGHT_LM3639=y
# CONFIG_BACKLIGHT_LP855X is not set
# CONFIG_BACKLIGHT_LP8788 is not set
# CONFIG_BACKLIGHT_PANDORA is not set
CONFIG_BACKLIGHT_SKY81452=y
CONFIG_BACKLIGHT_TPS65217=y
CONFIG_BACKLIGHT_GPIO=y
CONFIG_BACKLIGHT_LV5207LP=y
CONFIG_BACKLIGHT_BD6107=y
CONFIG_BACKLIGHT_ARCXCNN=y
CONFIG_BACKLIGHT_LED=y
# end of Backlight & LCD device support

CONFIG_VGASTATE=y
CONFIG_VIDEOMODE_HELPERS=y
CONFIG_HDMI=y
# CONFIG_LOGO is not set
# end of Graphics support

CONFIG_SOUND=y
# CONFIG_SND is not set

#
# HID support
#
CONFIG_HID=y
# CONFIG_HID_BATTERY_STRENGTH is not set
CONFIG_HIDRAW=y
CONFIG_UHID=y
CONFIG_HID_GENERIC=y

#
# Special HID drivers
#
CONFIG_HID_A4TECH=y
# CONFIG_HID_ACCUTOUCH is not set
# CONFIG_HID_ACRUX is not set
CONFIG_HID_APPLE=y
# CONFIG_HID_APPLEIR is not set
CONFIG_HID_ASUS=y
# CONFIG_HID_AUREAL is not set
# CONFIG_HID_BELKIN is not set
# CONFIG_HID_BETOP_FF is not set
CONFIG_HID_BIGBEN_FF=y
CONFIG_HID_CHERRY=y
CONFIG_HID_CHICONY=y
# CONFIG_HID_CORSAIR is not set
CONFIG_HID_COUGAR=y
# CONFIG_HID_MACALLY is not set
CONFIG_HID_CMEDIA=y
# CONFIG_HID_CP2112 is not set
CONFIG_HID_CREATIVE_SB0540=y
CONFIG_HID_CYPRESS=y
CONFIG_HID_DRAGONRISE=y
CONFIG_DRAGONRISE_FF=y
CONFIG_HID_EMS_FF=y
CONFIG_HID_ELAN=y
CONFIG_HID_ELECOM=y
# CONFIG_HID_ELO is not set
CONFIG_HID_EZKEY=y
# CONFIG_HID_FT260 is not set
# CONFIG_HID_GEMBIRD is not set
CONFIG_HID_GFRM=y
# CONFIG_HID_GLORIOUS is not set
CONFIG_HID_HOLTEK=y
# CONFIG_HOLTEK_FF is not set
CONFIG_HID_VIVALDI_COMMON=y
CONFIG_HID_VIVALDI=y
CONFIG_HID_GT683R=y
CONFIG_HID_KEYTOUCH=y
CONFIG_HID_KYE=y
CONFIG_HID_UCLOGIC=y
CONFIG_HID_WALTOP=y
CONFIG_HID_VIEWSONIC=y
CONFIG_HID_VRC2=y
CONFIG_HID_XIAOMI=y
CONFIG_HID_GYRATION=y
CONFIG_HID_ICADE=y
CONFIG_HID_ITE=y
# CONFIG_HID_JABRA is not set
# CONFIG_HID_TWINHAN is not set
# CONFIG_HID_KENSINGTON is not set
CONFIG_HID_LCPOWER=y
# CONFIG_HID_LED is not set
CONFIG_HID_LENOVO=y
CONFIG_HID_LETSKETCH=y
CONFIG_HID_LOGITECH=y
CONFIG_HID_LOGITECH_DJ=y
CONFIG_HID_LOGITECH_HIDPP=y
CONFIG_LOGITECH_FF=y
CONFIG_LOGIRUMBLEPAD2_FF=y
# CONFIG_LOGIG940_FF is not set
CONFIG_LOGIWHEELS_FF=y
# CONFIG_HID_MAGICMOUSE is not set
CONFIG_HID_MALTRON=y
CONFIG_HID_MAYFLASH=y
CONFIG_HID_MEGAWORLD_FF=y
# CONFIG_HID_REDRAGON is not set
CONFIG_HID_MICROSOFT=y
# CONFIG_HID_MONTEREY is not set
CONFIG_HID_MULTITOUCH=y
# CONFIG_HID_NINTENDO is not set
# CONFIG_HID_NTI is not set
# CONFIG_HID_NTRIG is not set
CONFIG_HID_ORTEK=y
# CONFIG_HID_PANTHERLORD is not set
CONFIG_HID_PENMOUNT=y
CONFIG_HID_PETALYNX=y
CONFIG_HID_PICOLCD=y
CONFIG_HID_PICOLCD_FB=y
# CONFIG_HID_PICOLCD_BACKLIGHT is not set
CONFIG_HID_PICOLCD_LCD=y
# CONFIG_HID_PICOLCD_LEDS is not set
CONFIG_HID_PICOLCD_CIR=y
CONFIG_HID_PLANTRONICS=y
CONFIG_HID_PLAYSTATION=y
CONFIG_PLAYSTATION_FF=y
# CONFIG_HID_PXRC is not set
# CONFIG_HID_RAZER is not set
# CONFIG_HID_PRIMAX is not set
CONFIG_HID_RETRODE=y
CONFIG_HID_ROCCAT=y
CONFIG_HID_SAITEK=y
CONFIG_HID_SAMSUNG=y
CONFIG_HID_SEMITEK=y
# CONFIG_HID_SIGMAMICRO is not set
CONFIG_HID_SONY=y
# CONFIG_SONY_FF is not set
# CONFIG_HID_SPEEDLINK is not set
# CONFIG_HID_STEAM is not set
# CONFIG_HID_STEELSERIES is not set
CONFIG_HID_SUNPLUS=y
# CONFIG_HID_RMI is not set
CONFIG_HID_GREENASIA=y
# CONFIG_GREENASIA_FF is not set
# CONFIG_HID_SMARTJOYPLUS is not set
CONFIG_HID_TIVO=y
CONFIG_HID_TOPSEED=y
CONFIG_HID_TOPRE=y
# CONFIG_HID_THINGM is not set
CONFIG_HID_THRUSTMASTER=y
CONFIG_THRUSTMASTER_FF=y
# CONFIG_HID_UDRAW_PS3 is not set
CONFIG_HID_U2FZERO=y
# CONFIG_HID_WACOM is not set
CONFIG_HID_WIIMOTE=y
CONFIG_HID_XINMO=y
CONFIG_HID_ZEROPLUS=y
# CONFIG_ZEROPLUS_FF is not set
CONFIG_HID_ZYDACRON=y
CONFIG_HID_SENSOR_HUB=y
CONFIG_HID_SENSOR_CUSTOM_SENSOR=y
CONFIG_HID_ALPS=y
# CONFIG_HID_MCP2221 is not set
# end of Special HID drivers

#
# USB HID support
#
CONFIG_USB_HID=y
CONFIG_HID_PID=y
CONFIG_USB_HIDDEV=y
# end of USB HID support

#
# I2C HID support
#
# CONFIG_I2C_HID_ACPI is not set
# CONFIG_I2C_HID_OF is not set
CONFIG_I2C_HID_OF_ELAN=y
CONFIG_I2C_HID_OF_GOODIX=y
# end of I2C HID support

CONFIG_I2C_HID_CORE=y
# end of HID support

CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_COMMON=y
CONFIG_USB_ULPI_BUS=y
CONFIG_USB_CONN_GPIO=y
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB=y
CONFIG_USB_PCI=y
# CONFIG_USB_ANNOUNCE_NEW_DEVICES is not set

#
# Miscellaneous USB options
#
# CONFIG_USB_DEFAULT_PERSIST is not set
# CONFIG_USB_FEW_INIT_RETRIES is not set
CONFIG_USB_DYNAMIC_MINORS=y
# CONFIG_USB_OTG_PRODUCTLIST is not set
CONFIG_USB_OTG_DISABLE_EXTERNAL_HUB=y
CONFIG_USB_AUTOSUSPEND_DELAY=2
CONFIG_USB_MON=y

#
# USB Host Controller Drivers
#
CONFIG_USB_C67X00_HCD=y
CONFIG_USB_XHCI_HCD=y
# CONFIG_USB_XHCI_DBGCAP is not set
CONFIG_USB_XHCI_PCI=y
CONFIG_USB_XHCI_PCI_RENESAS=y
CONFIG_USB_XHCI_PLATFORM=y
# CONFIG_USB_EHCI_HCD is not set
CONFIG_USB_OXU210HP_HCD=y
CONFIG_USB_ISP116X_HCD=y
CONFIG_USB_FOTG210_HCD=y
# CONFIG_USB_MAX3421_HCD is not set
CONFIG_USB_OHCI_HCD=y
# CONFIG_USB_OHCI_HCD_PCI is not set
# CONFIG_USB_OHCI_HCD_SSB is not set
CONFIG_USB_OHCI_HCD_PLATFORM=y
# CONFIG_USB_UHCI_HCD is not set
CONFIG_USB_SL811_HCD=y
# CONFIG_USB_SL811_HCD_ISO is not set
CONFIG_USB_SL811_CS=y
CONFIG_USB_R8A66597_HCD=y
CONFIG_USB_HCD_BCMA=y
CONFIG_USB_HCD_SSB=y
# CONFIG_USB_HCD_TEST_MODE is not set

#
# USB Device Class drivers
#
CONFIG_USB_ACM=y
CONFIG_USB_PRINTER=y
CONFIG_USB_WDM=y
CONFIG_USB_TMC=y

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#
# CONFIG_USB_STORAGE is not set

#
# USB Imaging devices
#
CONFIG_USB_MDC800=y
CONFIG_USB_MICROTEK=y
# CONFIG_USBIP_CORE is not set
CONFIG_USB_CDNS_SUPPORT=y
# CONFIG_USB_CDNS3 is not set
# CONFIG_USB_CDNSP_PCI is not set
CONFIG_USB_MUSB_HDRC=y
CONFIG_USB_MUSB_HOST=y
# CONFIG_USB_MUSB_GADGET is not set
# CONFIG_USB_MUSB_DUAL_ROLE is not set

#
# Platform Glue Layer
#

#
# MUSB DMA mode
#
CONFIG_MUSB_PIO_ONLY=y
CONFIG_USB_DWC3=y
# CONFIG_USB_DWC3_ULPI is not set
# CONFIG_USB_DWC3_HOST is not set
CONFIG_USB_DWC3_GADGET=y
# CONFIG_USB_DWC3_DUAL_ROLE is not set

#
# Platform Glue Driver Support
#
CONFIG_USB_DWC3_PCI=y
CONFIG_USB_DWC3_HAPS=y
# CONFIG_USB_DWC3_OF_SIMPLE is not set
CONFIG_USB_DWC2=y
# CONFIG_USB_DWC2_HOST is not set

#
# Gadget/Dual-role mode requires USB Gadget support to be enabled
#
CONFIG_USB_DWC2_PERIPHERAL=y
# CONFIG_USB_DWC2_DUAL_ROLE is not set
CONFIG_USB_DWC2_PCI=y
CONFIG_USB_DWC2_DEBUG=y
# CONFIG_USB_DWC2_VERBOSE is not set
# CONFIG_USB_DWC2_TRACK_MISSED_SOFS is not set
# CONFIG_USB_DWC2_DEBUG_PERIODIC is not set
# CONFIG_USB_CHIPIDEA is not set
# CONFIG_USB_ISP1760 is not set

#
# USB port drivers
#
CONFIG_USB_USS720=y
CONFIG_USB_SERIAL=y
CONFIG_USB_SERIAL_CONSOLE=y
# CONFIG_USB_SERIAL_GENERIC is not set
CONFIG_USB_SERIAL_SIMPLE=y
# CONFIG_USB_SERIAL_AIRCABLE is not set
# CONFIG_USB_SERIAL_ARK3116 is not set
CONFIG_USB_SERIAL_BELKIN=y
# CONFIG_USB_SERIAL_CH341 is not set
# CONFIG_USB_SERIAL_WHITEHEAT is not set
# CONFIG_USB_SERIAL_DIGI_ACCELEPORT is not set
CONFIG_USB_SERIAL_CP210X=y
CONFIG_USB_SERIAL_CYPRESS_M8=y
CONFIG_USB_SERIAL_EMPEG=y
# CONFIG_USB_SERIAL_FTDI_SIO is not set
CONFIG_USB_SERIAL_VISOR=y
CONFIG_USB_SERIAL_IPAQ=y
CONFIG_USB_SERIAL_IR=y
CONFIG_USB_SERIAL_EDGEPORT=y
# CONFIG_USB_SERIAL_EDGEPORT_TI is not set
CONFIG_USB_SERIAL_F81232=y
# CONFIG_USB_SERIAL_F8153X is not set
CONFIG_USB_SERIAL_GARMIN=y
# CONFIG_USB_SERIAL_IPW is not set
CONFIG_USB_SERIAL_IUU=y
CONFIG_USB_SERIAL_KEYSPAN_PDA=y
CONFIG_USB_SERIAL_KEYSPAN=y
CONFIG_USB_SERIAL_KLSI=y
# CONFIG_USB_SERIAL_KOBIL_SCT is not set
CONFIG_USB_SERIAL_MCT_U232=y
# CONFIG_USB_SERIAL_METRO is not set
# CONFIG_USB_SERIAL_MOS7720 is not set
# CONFIG_USB_SERIAL_MOS7840 is not set
CONFIG_USB_SERIAL_MXUPORT=y
# CONFIG_USB_SERIAL_NAVMAN is not set
# CONFIG_USB_SERIAL_PL2303 is not set
# CONFIG_USB_SERIAL_OTI6858 is not set
CONFIG_USB_SERIAL_QCAUX=y
# CONFIG_USB_SERIAL_QUALCOMM is not set
CONFIG_USB_SERIAL_SPCP8X5=y
CONFIG_USB_SERIAL_SAFE=y
CONFIG_USB_SERIAL_SAFE_PADDED=y
CONFIG_USB_SERIAL_SIERRAWIRELESS=y
CONFIG_USB_SERIAL_SYMBOL=y
# CONFIG_USB_SERIAL_TI is not set
CONFIG_USB_SERIAL_CYBERJACK=y
# CONFIG_USB_SERIAL_OPTION is not set
CONFIG_USB_SERIAL_OMNINET=y
CONFIG_USB_SERIAL_OPTICON=y
CONFIG_USB_SERIAL_XSENS_MT=y
CONFIG_USB_SERIAL_WISHBONE=y
CONFIG_USB_SERIAL_SSU100=y
# CONFIG_USB_SERIAL_QT2 is not set
# CONFIG_USB_SERIAL_UPD78F0730 is not set
# CONFIG_USB_SERIAL_XR is not set
# CONFIG_USB_SERIAL_DEBUG is not set

#
# USB Miscellaneous drivers
#
CONFIG_USB_EMI62=y
CONFIG_USB_EMI26=y
# CONFIG_USB_ADUTUX is not set
CONFIG_USB_SEVSEG=y
CONFIG_USB_LEGOTOWER=y
CONFIG_USB_LCD=y
CONFIG_USB_CYPRESS_CY7C63=y
CONFIG_USB_CYTHERM=y
CONFIG_USB_IDMOUSE=y
# CONFIG_USB_FTDI_ELAN is not set
# CONFIG_USB_APPLEDISPLAY is not set
CONFIG_APPLE_MFI_FASTCHARGE=y
CONFIG_USB_SISUSBVGA=y
# CONFIG_USB_LD is not set
CONFIG_USB_TRANCEVIBRATOR=y
CONFIG_USB_IOWARRIOR=y
# CONFIG_USB_TEST is not set
# CONFIG_USB_EHSET_TEST_FIXTURE is not set
# CONFIG_USB_ISIGHTFW is not set
CONFIG_USB_YUREX=y
CONFIG_USB_EZUSB_FX2=y
CONFIG_USB_HUB_USB251XB=y
CONFIG_USB_HSIC_USB3503=y
CONFIG_USB_HSIC_USB4604=y
# CONFIG_USB_LINK_LAYER_TEST is not set
# CONFIG_USB_CHAOSKEY is not set
CONFIG_USB_ONBOARD_HUB=y

#
# USB Physical Layer drivers
#
CONFIG_USB_PHY=y
CONFIG_NOP_USB_XCEIV=y
CONFIG_USB_GPIO_VBUS=y
# CONFIG_USB_ISP1301 is not set
# end of USB Physical Layer drivers

CONFIG_USB_GADGET=y
CONFIG_USB_GADGET_DEBUG=y
CONFIG_USB_GADGET_VERBOSE=y
CONFIG_USB_GADGET_DEBUG_FILES=y
CONFIG_USB_GADGET_DEBUG_FS=y
CONFIG_USB_GADGET_VBUS_DRAW=2
CONFIG_USB_GADGET_STORAGE_NUM_BUFFERS=2
# CONFIG_U_SERIAL_CONSOLE is not set

#
# USB Peripheral Controller
#
CONFIG_USB_FUSB300=y
# CONFIG_USB_FOTG210_UDC is not set
CONFIG_USB_GR_UDC=y
CONFIG_USB_R8A66597=y
CONFIG_USB_PXA27X=y
CONFIG_USB_MV_UDC=y
# CONFIG_USB_MV_U3D is not set
CONFIG_USB_SNP_CORE=y
CONFIG_USB_SNP_UDC_PLAT=y
CONFIG_USB_M66592=y
CONFIG_USB_BDC_UDC=y
# CONFIG_USB_AMD5536UDC is not set
CONFIG_USB_NET2272=y
# CONFIG_USB_NET2272_DMA is not set
# CONFIG_USB_NET2280 is not set
# CONFIG_USB_GOKU is not set
# CONFIG_USB_EG20T is not set
# CONFIG_USB_GADGET_XILINX is not set
CONFIG_USB_MAX3420_UDC=y
CONFIG_USB_DUMMY_HCD=y
# end of USB Peripheral Controller

CONFIG_USB_LIBCOMPOSITE=y
CONFIG_USB_F_ACM=y
CONFIG_USB_F_SS_LB=y
CONFIG_USB_U_SERIAL=y
CONFIG_USB_F_SERIAL=y
CONFIG_USB_F_OBEX=y
CONFIG_USB_F_MASS_STORAGE=y
CONFIG_USB_F_HID=y
CONFIG_USB_F_PRINTER=y
# CONFIG_USB_CONFIGFS is not set

#
# USB Gadget precomposed configurations
#
CONFIG_USB_ZERO=y
# CONFIG_USB_ETH is not set
# CONFIG_USB_G_NCM is not set
CONFIG_USB_GADGETFS=y
# CONFIG_USB_FUNCTIONFS is not set
# CONFIG_USB_MASS_STORAGE is not set
CONFIG_USB_G_SERIAL=y
CONFIG_USB_G_PRINTER=y
# CONFIG_USB_CDC_COMPOSITE is not set
CONFIG_USB_G_ACM_MS=y
# CONFIG_USB_G_MULTI is not set
CONFIG_USB_G_HID=y
# CONFIG_USB_G_DBGP is not set
# CONFIG_USB_RAW_GADGET is not set
# end of USB Gadget precomposed configurations

# CONFIG_TYPEC is not set
CONFIG_USB_ROLE_SWITCH=y
# CONFIG_USB_ROLES_INTEL_XHCI is not set
# CONFIG_MMC is not set
# CONFIG_SCSI_UFSHCD is not set
CONFIG_MEMSTICK=y
CONFIG_MEMSTICK_DEBUG=y

#
# MemoryStick drivers
#
# CONFIG_MEMSTICK_UNSAFE_RESUME is not set
CONFIG_MSPRO_BLOCK=y
CONFIG_MS_BLOCK=y

#
# MemoryStick Host Controller Drivers
#
CONFIG_MEMSTICK_TIFM_MS=y
CONFIG_MEMSTICK_JMICRON_38X=y
# CONFIG_MEMSTICK_R592 is not set
CONFIG_MEMSTICK_REALTEK_USB=y
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
CONFIG_LEDS_CLASS_FLASH=y
CONFIG_LEDS_CLASS_MULTICOLOR=y
# CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set

#
# LED drivers
#
CONFIG_LEDS_AN30259A=y
CONFIG_LEDS_AW2013=y
CONFIG_LEDS_BCM6328=y
# CONFIG_LEDS_BCM6358 is not set
# CONFIG_LEDS_CPCAP is not set
CONFIG_LEDS_CR0014114=y
CONFIG_LEDS_EL15203000=y
CONFIG_LEDS_LM3530=y
CONFIG_LEDS_LM3532=y
CONFIG_LEDS_LM3533=y
CONFIG_LEDS_LM3642=y
CONFIG_LEDS_LM3692X=y
CONFIG_LEDS_PCA9532=y
CONFIG_LEDS_PCA9532_GPIO=y
CONFIG_LEDS_GPIO=y
# CONFIG_LEDS_LP3944 is not set
CONFIG_LEDS_LP3952=y
CONFIG_LEDS_LP50XX=y
CONFIG_LEDS_LP55XX_COMMON=y
CONFIG_LEDS_LP5521=y
CONFIG_LEDS_LP5523=y
# CONFIG_LEDS_LP5562 is not set
CONFIG_LEDS_LP8501=y
# CONFIG_LEDS_LP8788 is not set
CONFIG_LEDS_LP8860=y
# CONFIG_LEDS_PCA955X is not set
CONFIG_LEDS_PCA963X=y
# CONFIG_LEDS_WM831X_STATUS is not set
CONFIG_LEDS_DA903X=y
CONFIG_LEDS_DA9052=y
# CONFIG_LEDS_DAC124S085 is not set
# CONFIG_LEDS_PWM is not set
CONFIG_LEDS_REGULATOR=y
CONFIG_LEDS_BD2802=y
CONFIG_LEDS_LT3593=y
# CONFIG_LEDS_ADP5520 is not set
# CONFIG_LEDS_MC13783 is not set
CONFIG_LEDS_TCA6507=y
CONFIG_LEDS_TLC591XX=y
CONFIG_LEDS_LM355x=y
CONFIG_LEDS_OT200=y
CONFIG_LEDS_IS31FL319X=y
CONFIG_LEDS_IS31FL32XX=y

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
CONFIG_LEDS_BLINKM=y
# CONFIG_LEDS_SYSCON is not set
CONFIG_LEDS_MLXREG=y
# CONFIG_LEDS_USER is not set
# CONFIG_LEDS_NIC78BX is not set
CONFIG_LEDS_SPI_BYTE=y
CONFIG_LEDS_TI_LMU_COMMON=y
# CONFIG_LEDS_LM3697 is not set
CONFIG_LEDS_TPS6105X=y
CONFIG_LEDS_LGM=y

#
# Flash and Torch LED drivers
#
CONFIG_LEDS_AAT1290=y
# CONFIG_LEDS_AS3645A is not set
CONFIG_LEDS_KTD2692=y
# CONFIG_LEDS_LM3601X is not set
CONFIG_LEDS_MAX77693=y
CONFIG_LEDS_MT6360=y
CONFIG_LEDS_RT4505=y
CONFIG_LEDS_RT8515=y
# CONFIG_LEDS_SGM3140 is not set

#
# RGB LED drivers
#
# CONFIG_LEDS_PWM_MULTICOLOR is not set
# CONFIG_LEDS_QCOM_LPG is not set

#
# LED Triggers
#
# CONFIG_LEDS_TRIGGERS is not set

#
# Simple LED drivers
#
CONFIG_LEDS_SIEMENS_SIMATIC_IPC=y
# CONFIG_ACCESSIBILITY is not set
# CONFIG_INFINIBAND is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
# CONFIG_EDAC is not set
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
# CONFIG_RTC_CLASS is not set
# CONFIG_DMADEVICES is not set

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
# CONFIG_SW_SYNC is not set
# CONFIG_UDMABUF is not set
# CONFIG_DMABUF_MOVE_NOTIFY is not set
# CONFIG_DMABUF_DEBUG is not set
# CONFIG_DMABUF_SELFTESTS is not set
# CONFIG_DMABUF_HEAPS is not set
# CONFIG_DMABUF_SYSFS_STATS is not set
# end of DMABUF options

CONFIG_AUXDISPLAY=y
CONFIG_CHARLCD=y
CONFIG_LINEDISP=y
CONFIG_HD44780_COMMON=y
CONFIG_HD44780=y
CONFIG_KS0108=y
CONFIG_KS0108_PORT=0x378
CONFIG_KS0108_DELAY=2
CONFIG_CFAG12864B=y
CONFIG_CFAG12864B_RATE=20
# CONFIG_IMG_ASCII_LCD is not set
CONFIG_HT16K33=y
CONFIG_LCD2S=y
CONFIG_PARPORT_PANEL=y
CONFIG_PANEL_PARPORT=0
CONFIG_PANEL_PROFILE=5
CONFIG_PANEL_CHANGE_MESSAGE=y
CONFIG_PANEL_BOOT_MESSAGE=""
# CONFIG_CHARLCD_BL_OFF is not set
CONFIG_CHARLCD_BL_ON=y
# CONFIG_CHARLCD_BL_FLASH is not set
CONFIG_PANEL=y
# CONFIG_UIO is not set
CONFIG_VFIO=y
CONFIG_VFIO_IOMMU_TYPE1=y
CONFIG_VFIO_VIRQFD=y
CONFIG_VFIO_NOIOMMU=y
CONFIG_VFIO_PCI_CORE=y
CONFIG_VFIO_PCI_MMAP=y
CONFIG_VFIO_PCI_INTX=y
CONFIG_VFIO_PCI=y
CONFIG_VFIO_PCI_IGD=y
# CONFIG_VFIO_MDEV is not set
CONFIG_IRQ_BYPASS_MANAGER=y
CONFIG_VIRT_DRIVERS=y
CONFIG_VMGENID=y
# CONFIG_VBOXGUEST is not set
# CONFIG_NITRO_ENCLAVES is not set
CONFIG_VIRTIO_ANCHOR=y
CONFIG_VIRTIO=y
CONFIG_VIRTIO_MENU=y
# CONFIG_VIRTIO_PCI is not set
CONFIG_VIRTIO_BALLOON=y
CONFIG_VIRTIO_INPUT=y
CONFIG_VIRTIO_MMIO=y
CONFIG_VIRTIO_MMIO_CMDLINE_DEVICES=y
# CONFIG_VDPA is not set
# CONFIG_VHOST_MENU is not set

#
# Microsoft Hyper-V guest support
#
# CONFIG_HYPERV is not set
# end of Microsoft Hyper-V guest support

CONFIG_GREYBUS=y
CONFIG_GREYBUS_ES2=y
CONFIG_COMEDI=y
# CONFIG_COMEDI_DEBUG is not set
CONFIG_COMEDI_DEFAULT_BUF_SIZE_KB=2048
CONFIG_COMEDI_DEFAULT_BUF_MAXSIZE_KB=20480
CONFIG_COMEDI_MISC_DRIVERS=y
CONFIG_COMEDI_BOND=y
# CONFIG_COMEDI_TEST is not set
CONFIG_COMEDI_PARPORT=y
CONFIG_COMEDI_SSV_DNP=y
CONFIG_COMEDI_ISA_DRIVERS=y
CONFIG_COMEDI_PCL711=y
CONFIG_COMEDI_PCL724=y
CONFIG_COMEDI_PCL726=y
CONFIG_COMEDI_PCL730=y
CONFIG_COMEDI_PCL812=y
# CONFIG_COMEDI_PCL816 is not set
CONFIG_COMEDI_PCL818=y
CONFIG_COMEDI_PCM3724=y
CONFIG_COMEDI_AMPLC_DIO200_ISA=y
CONFIG_COMEDI_AMPLC_PC236_ISA=y
CONFIG_COMEDI_AMPLC_PC263_ISA=y
# CONFIG_COMEDI_RTI800 is not set
CONFIG_COMEDI_RTI802=y
CONFIG_COMEDI_DAC02=y
CONFIG_COMEDI_DAS16M1=y
CONFIG_COMEDI_DAS08_ISA=y
CONFIG_COMEDI_DAS16=y
# CONFIG_COMEDI_DAS800 is not set
CONFIG_COMEDI_DAS1800=y
CONFIG_COMEDI_DAS6402=y
CONFIG_COMEDI_DT2801=y
# CONFIG_COMEDI_DT2811 is not set
CONFIG_COMEDI_DT2814=y
# CONFIG_COMEDI_DT2815 is not set
# CONFIG_COMEDI_DT2817 is not set
CONFIG_COMEDI_DT282X=y
# CONFIG_COMEDI_DMM32AT is not set
CONFIG_COMEDI_FL512=y
# CONFIG_COMEDI_AIO_AIO12_8 is not set
CONFIG_COMEDI_AIO_IIRO_16=y
# CONFIG_COMEDI_II_PCI20KC is not set
# CONFIG_COMEDI_C6XDIGIO is not set
# CONFIG_COMEDI_MPC624 is not set
# CONFIG_COMEDI_ADQ12B is not set
# CONFIG_COMEDI_NI_AT_A2150 is not set
CONFIG_COMEDI_NI_AT_AO=y
CONFIG_COMEDI_NI_ATMIO=y
# CONFIG_COMEDI_NI_ATMIO16D is not set
CONFIG_COMEDI_NI_LABPC_ISA=y
CONFIG_COMEDI_PCMAD=y
CONFIG_COMEDI_PCMDA12=y
CONFIG_COMEDI_PCMMIO=y
CONFIG_COMEDI_PCMUIO=y
CONFIG_COMEDI_MULTIQ3=y
CONFIG_COMEDI_S526=y
CONFIG_COMEDI_PCI_DRIVERS=y
# CONFIG_COMEDI_8255_PCI is not set
CONFIG_COMEDI_ADDI_WATCHDOG=y
# CONFIG_COMEDI_ADDI_APCI_1032 is not set
CONFIG_COMEDI_ADDI_APCI_1500=y
CONFIG_COMEDI_ADDI_APCI_1516=y
CONFIG_COMEDI_ADDI_APCI_1564=y
# CONFIG_COMEDI_ADDI_APCI_16XX is not set
# CONFIG_COMEDI_ADDI_APCI_2032 is not set
CONFIG_COMEDI_ADDI_APCI_2200=y
CONFIG_COMEDI_ADDI_APCI_3120=y
# CONFIG_COMEDI_ADDI_APCI_3501 is not set
CONFIG_COMEDI_ADDI_APCI_3XXX=y
CONFIG_COMEDI_ADL_PCI6208=y
# CONFIG_COMEDI_ADL_PCI7X3X is not set
CONFIG_COMEDI_ADL_PCI8164=y
CONFIG_COMEDI_ADL_PCI9111=y
CONFIG_COMEDI_ADL_PCI9118=y
CONFIG_COMEDI_ADV_PCI1710=y
# CONFIG_COMEDI_ADV_PCI1720 is not set
CONFIG_COMEDI_ADV_PCI1723=y
CONFIG_COMEDI_ADV_PCI1724=y
CONFIG_COMEDI_ADV_PCI1760=y
CONFIG_COMEDI_ADV_PCI_DIO=y
CONFIG_COMEDI_AMPLC_DIO200_PCI=y
CONFIG_COMEDI_AMPLC_PC236_PCI=y
CONFIG_COMEDI_AMPLC_PC263_PCI=y
CONFIG_COMEDI_AMPLC_PCI224=y
# CONFIG_COMEDI_AMPLC_PCI230 is not set
CONFIG_COMEDI_CONTEC_PCI_DIO=y
CONFIG_COMEDI_DAS08_PCI=y
# CONFIG_COMEDI_DT3000 is not set
CONFIG_COMEDI_DYNA_PCI10XX=y
CONFIG_COMEDI_GSC_HPDI=y
# CONFIG_COMEDI_MF6X4 is not set
CONFIG_COMEDI_ICP_MULTI=y
CONFIG_COMEDI_DAQBOARD2000=y
# CONFIG_COMEDI_JR3_PCI is not set
CONFIG_COMEDI_KE_COUNTER=y
CONFIG_COMEDI_CB_PCIDAS64=y
CONFIG_COMEDI_CB_PCIDAS=y
# CONFIG_COMEDI_CB_PCIDDA is not set
# CONFIG_COMEDI_CB_PCIMDAS is not set
CONFIG_COMEDI_CB_PCIMDDA=y
CONFIG_COMEDI_ME4000=y
CONFIG_COMEDI_ME_DAQ=y
CONFIG_COMEDI_NI_6527=y
# CONFIG_COMEDI_NI_65XX is not set
CONFIG_COMEDI_NI_660X=y
CONFIG_COMEDI_NI_670X=y
# CONFIG_COMEDI_NI_LABPC_PCI is not set
CONFIG_COMEDI_NI_PCIDIO=y
CONFIG_COMEDI_NI_PCIMIO=y
CONFIG_COMEDI_RTD520=y
CONFIG_COMEDI_S626=y
CONFIG_COMEDI_MITE=y
CONFIG_COMEDI_NI_TIOCMD=y
CONFIG_COMEDI_PCMCIA_DRIVERS=y
CONFIG_COMEDI_CB_DAS16_CS=y
CONFIG_COMEDI_DAS08_CS=y
CONFIG_COMEDI_NI_DAQ_700_CS=y
CONFIG_COMEDI_NI_DAQ_DIO24_CS=y
CONFIG_COMEDI_NI_LABPC_CS=y
CONFIG_COMEDI_NI_MIO_CS=y
CONFIG_COMEDI_QUATECH_DAQP_CS=y
CONFIG_COMEDI_USB_DRIVERS=y
CONFIG_COMEDI_DT9812=y
CONFIG_COMEDI_NI_USB6501=y
CONFIG_COMEDI_USBDUX=y
# CONFIG_COMEDI_USBDUXFAST is not set
# CONFIG_COMEDI_USBDUXSIGMA is not set
CONFIG_COMEDI_VMK80XX=y
CONFIG_COMEDI_8254=y
CONFIG_COMEDI_8255=y
CONFIG_COMEDI_8255_SA=y
CONFIG_COMEDI_KCOMEDILIB=y
CONFIG_COMEDI_AMPLC_DIO200=y
CONFIG_COMEDI_AMPLC_PC236=y
CONFIG_COMEDI_DAS08=y
CONFIG_COMEDI_ISADMA=y
CONFIG_COMEDI_NI_LABPC=y
CONFIG_COMEDI_NI_LABPC_ISADMA=y
CONFIG_COMEDI_NI_TIO=y
CONFIG_COMEDI_NI_ROUTING=y
# CONFIG_COMEDI_TESTS is not set
# CONFIG_STAGING is not set
CONFIG_GOLDFISH_PIPE=y
# CONFIG_CHROME_PLATFORMS is not set
# CONFIG_MELLANOX_PLATFORM is not set
CONFIG_OLPC_EC=y
CONFIG_SURFACE_PLATFORMS=y
# CONFIG_SURFACE_3_POWER_OPREGION is not set
# CONFIG_SURFACE_HOTPLUG is not set
# CONFIG_SURFACE_PRO3_BUTTON is not set
CONFIG_X86_PLATFORM_DEVICES=y
# CONFIG_ACPI_WMI is not set
# CONFIG_ACERHDF is not set
# CONFIG_ACER_WIRELESS is not set
# CONFIG_AMD_PMF is not set
# CONFIG_ADV_SWBUTTON is not set
# CONFIG_APPLE_GMUX is not set
# CONFIG_ASUS_LAPTOP is not set
# CONFIG_ASUS_WIRELESS is not set
# CONFIG_ASUS_TF103C_DOCK is not set
CONFIG_MERAKI_MX100=y
CONFIG_X86_PLATFORM_DRIVERS_DELL=y
CONFIG_DCDBAS=y
CONFIG_DELL_RBU=y
CONFIG_DELL_SMBIOS=y
# CONFIG_DELL_SMBIOS_SMM is not set
CONFIG_DELL_SMO8800=m
# CONFIG_FUJITSU_LAPTOP is not set
# CONFIG_FUJITSU_TABLET is not set
# CONFIG_GPD_POCKET_FAN is not set
# CONFIG_HP_ACCEL is not set
# CONFIG_WIRELESS_HOTKEY is not set
CONFIG_IBM_RTL=y
CONFIG_SENSORS_HDAPS=y
# CONFIG_THINKPAD_ACPI is not set
CONFIG_INTEL_ATOMISP2_PDX86=y
CONFIG_INTEL_ATOMISP2_LED=y
# CONFIG_INTEL_SAR_INT1092 is not set
# CONFIG_INTEL_SKL_INT3472 is not set
# CONFIG_INTEL_PMC_CORE is not set
CONFIG_INTEL_PMT_CLASS=y
# CONFIG_INTEL_PMT_TELEMETRY is not set
CONFIG_INTEL_PMT_CRASHLOG=y
# CONFIG_INTEL_HID_EVENT is not set
# CONFIG_INTEL_VBTN is not set
CONFIG_INTEL_PUNIT_IPC=y
# CONFIG_INTEL_RST is not set
# CONFIG_INTEL_SMARTCONNECT is not set
CONFIG_INTEL_VSEC=y
# CONFIG_XO15_EBOOK is not set
# CONFIG_PCENGINES_APU2 is not set
CONFIG_BARCO_P50_GPIO=y
CONFIG_SAMSUNG_LAPTOP=y
# CONFIG_SAMSUNG_Q10 is not set
# CONFIG_TOSHIBA_BT_RFKILL is not set
# CONFIG_TOSHIBA_HAPS is not set
# CONFIG_ACPI_CMPC is not set
# CONFIG_PANASONIC_LAPTOP is not set
# CONFIG_SYSTEM76_ACPI is not set
# CONFIG_TOPSTAR_LAPTOP is not set
# CONFIG_SERIAL_MULTI_INSTANTIATE is not set
# CONFIG_MLX_PLATFORM is not set
CONFIG_INTEL_IMR=y
# CONFIG_INTEL_IPS is not set
CONFIG_INTEL_SCU_IPC=y
CONFIG_INTEL_SCU=y
CONFIG_INTEL_SCU_PCI=y
# CONFIG_INTEL_SCU_PLATFORM is not set
CONFIG_INTEL_SCU_IPC_UTIL=y
CONFIG_SIEMENS_SIMATIC_IPC=y
# CONFIG_WINMATE_FM07_KEYS is not set
CONFIG_P2SB=y
CONFIG_HAVE_CLK=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y
CONFIG_COMMON_CLK_WM831X=y
CONFIG_LMK04832=y
CONFIG_COMMON_CLK_MAX77686=y
CONFIG_COMMON_CLK_MAX9485=y
CONFIG_COMMON_CLK_SI5341=y
# CONFIG_COMMON_CLK_SI5351 is not set
CONFIG_COMMON_CLK_SI514=y
CONFIG_COMMON_CLK_SI544=y
CONFIG_COMMON_CLK_SI570=y
# CONFIG_COMMON_CLK_CDCE706 is not set
# CONFIG_COMMON_CLK_CDCE925 is not set
# CONFIG_COMMON_CLK_CS2000_CP is not set
CONFIG_COMMON_CLK_S2MPS11=y
# CONFIG_COMMON_CLK_AXI_CLKGEN is not set
# CONFIG_COMMON_CLK_PALMAS is not set
# CONFIG_COMMON_CLK_PWM is not set
CONFIG_COMMON_CLK_RS9_PCIE=y
CONFIG_COMMON_CLK_VC5=y
CONFIG_COMMON_CLK_VC7=y
# CONFIG_COMMON_CLK_FIXED_MMIO is not set
CONFIG_CLK_LGM_CGU=y
CONFIG_XILINX_VCU=y
# CONFIG_COMMON_CLK_XLNX_CLKWZRD is not set
CONFIG_HWSPINLOCK=y

#
# Clock Source drivers
#
CONFIG_TIMER_OF=y
CONFIG_TIMER_PROBE=y
CONFIG_CLKSRC_I8253=y
CONFIG_CLKEVT_I8253=y
CONFIG_CLKBLD_I8253=y
CONFIG_MICROCHIP_PIT64B=y
# end of Clock Source drivers

CONFIG_MAILBOX=y
CONFIG_PLATFORM_MHU=y
# CONFIG_PCC is not set
CONFIG_ALTERA_MBOX=y
# CONFIG_MAILBOX_TEST is not set
CONFIG_IOMMU_API=y
# CONFIG_IOMMU_SUPPORT is not set

#
# Remoteproc drivers
#
CONFIG_REMOTEPROC=y
# CONFIG_REMOTEPROC_CDEV is not set
# end of Remoteproc drivers

#
# Rpmsg drivers
#
CONFIG_RPMSG=y
# CONFIG_RPMSG_CHAR is not set
# CONFIG_RPMSG_CTRL is not set
CONFIG_RPMSG_NS=y
CONFIG_RPMSG_QCOM_GLINK=y
CONFIG_RPMSG_QCOM_GLINK_RPM=y
CONFIG_RPMSG_VIRTIO=y
# end of Rpmsg drivers

# CONFIG_SOUNDWIRE is not set

#
# SOC (System On Chip) specific Drivers
#

#
# Amlogic SoC drivers
#
# end of Amlogic SoC drivers

#
# Broadcom SoC drivers
#
# end of Broadcom SoC drivers

#
# NXP/Freescale QorIQ SoC drivers
#
# end of NXP/Freescale QorIQ SoC drivers

#
# fujitsu SoC drivers
#
# end of fujitsu SoC drivers

#
# i.MX SoC drivers
#
# end of i.MX SoC drivers

#
# Enable LiteX SoC Builder specific drivers
#
CONFIG_LITEX=y
CONFIG_LITEX_SOC_CONTROLLER=y
# end of Enable LiteX SoC Builder specific drivers

#
# Qualcomm SoC drivers
#
# end of Qualcomm SoC drivers

# CONFIG_SOC_TI is not set

#
# Xilinx SoC drivers
#
# end of Xilinx SoC drivers
# end of SOC (System On Chip) specific Drivers

# CONFIG_PM_DEVFREQ is not set
CONFIG_EXTCON=y

#
# Extcon Device Drivers
#
# CONFIG_EXTCON_FSA9480 is not set
CONFIG_EXTCON_GPIO=y
# CONFIG_EXTCON_INTEL_INT3496 is not set
# CONFIG_EXTCON_MAX3355 is not set
CONFIG_EXTCON_MAX77693=y
CONFIG_EXTCON_PALMAS=y
CONFIG_EXTCON_PTN5150=y
CONFIG_EXTCON_RT8973A=y
# CONFIG_EXTCON_SM5502 is not set
CONFIG_EXTCON_USB_GPIO=y
CONFIG_MEMORY=y
CONFIG_FPGA_DFL_EMIF=y
# CONFIG_IIO is not set
CONFIG_NTB=y
CONFIG_NTB_IDT=y
# CONFIG_NTB_EPF is not set
CONFIG_NTB_SWITCHTEC=y
CONFIG_NTB_PINGPONG=y
CONFIG_NTB_TOOL=y
# CONFIG_NTB_PERF is not set
# CONFIG_NTB_TRANSPORT is not set
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
# CONFIG_PWM_DEBUG is not set
# CONFIG_PWM_ATMEL_HLCDC_PWM is not set
# CONFIG_PWM_ATMEL_TCB is not set
# CONFIG_PWM_CLK is not set
# CONFIG_PWM_DWC is not set
# CONFIG_PWM_FSL_FTM is not set
# CONFIG_PWM_INTEL_LGM is not set
# CONFIG_PWM_IQS620A is not set
# CONFIG_PWM_LP3943 is not set
# CONFIG_PWM_LPSS_PCI is not set
# CONFIG_PWM_LPSS_PLATFORM is not set
# CONFIG_PWM_PCA9685 is not set
# CONFIG_PWM_TWL is not set
# CONFIG_PWM_TWL_LED is not set
# CONFIG_PWM_XILINX is not set

#
# IRQ chip support
#
CONFIG_IRQCHIP=y
# CONFIG_AL_FIC is not set
CONFIG_MADERA_IRQ=y
# CONFIG_XILINX_INTC is not set
# end of IRQ chip support

CONFIG_IPACK_BUS=y
CONFIG_BOARD_TPCI200=y
CONFIG_SERIAL_IPOCTAL=y
CONFIG_RESET_CONTROLLER=y
# CONFIG_RESET_INTEL_GW is not set
# CONFIG_RESET_SIMPLE is not set
# CONFIG_RESET_TI_SYSCON is not set
CONFIG_RESET_TI_TPS380X=y

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
CONFIG_GENERIC_PHY_MIPI_DPHY=y
CONFIG_USB_LGM_PHY=y
# CONFIG_PHY_CAN_TRANSCEIVER is not set

#
# PHY drivers for Broadcom platforms
#
CONFIG_BCM_KONA_USB2_PHY=y
# end of PHY drivers for Broadcom platforms

CONFIG_PHY_CADENCE_TORRENT=y
CONFIG_PHY_CADENCE_DPHY=y
# CONFIG_PHY_CADENCE_DPHY_RX is not set
# CONFIG_PHY_CADENCE_SIERRA is not set
CONFIG_PHY_CADENCE_SALVO=y
CONFIG_PHY_PXA_28NM_HSIC=y
CONFIG_PHY_PXA_28NM_USB2=y
# CONFIG_PHY_LAN966X_SERDES is not set
CONFIG_PHY_MAPPHONE_MDM6600=y
CONFIG_PHY_OCELOT_SERDES=y
# CONFIG_PHY_QCOM_USB_HS is not set
# CONFIG_PHY_QCOM_USB_HSIC is not set
# CONFIG_PHY_SAMSUNG_USB2 is not set
CONFIG_PHY_TUSB1210=y
# CONFIG_PHY_INTEL_LGM_COMBO is not set
CONFIG_PHY_INTEL_LGM_EMMC=y
# end of PHY Subsystem

CONFIG_POWERCAP=y
CONFIG_INTEL_RAPL_CORE=y
CONFIG_INTEL_RAPL=y
# CONFIG_IDLE_INJECT is not set
CONFIG_DTPM=y
CONFIG_MCB=y
# CONFIG_MCB_PCI is not set
CONFIG_MCB_LPC=y

#
# Performance monitor support
#
# end of Performance monitor support

CONFIG_RAS=y
CONFIG_RAS_CEC=y
# CONFIG_RAS_CEC_DEBUG is not set
# CONFIG_USB4 is not set

#
# Android
#
# CONFIG_ANDROID_BINDER_IPC is not set
# end of Android

CONFIG_DAX=y
CONFIG_NVMEM=y
CONFIG_NVMEM_SYSFS=y
CONFIG_NVMEM_RMEM=y
CONFIG_NVMEM_SPMI_SDAM=y
CONFIG_NVMEM_U_BOOT_ENV=y

#
# HW tracing support
#
# CONFIG_STM is not set
# CONFIG_INTEL_TH is not set
# end of HW tracing support

CONFIG_FPGA=y
CONFIG_ALTERA_PR_IP_CORE=y
CONFIG_ALTERA_PR_IP_CORE_PLAT=y
CONFIG_FPGA_MGR_ALTERA_PS_SPI=y
# CONFIG_FPGA_MGR_ALTERA_CVP is not set
CONFIG_FPGA_MGR_XILINX_SPI=y
CONFIG_FPGA_MGR_ICE40_SPI=y
# CONFIG_FPGA_MGR_MACHXO2_SPI is not set
CONFIG_FPGA_BRIDGE=y
CONFIG_ALTERA_FREEZE_BRIDGE=y
CONFIG_XILINX_PR_DECOUPLER=y
CONFIG_FPGA_REGION=y
# CONFIG_OF_FPGA_REGION is not set
CONFIG_FPGA_DFL=y
# CONFIG_FPGA_DFL_FME is not set
CONFIG_FPGA_DFL_AFU=y
# CONFIG_FPGA_DFL_NIOS_INTEL_PAC_N3000 is not set
CONFIG_FPGA_DFL_PCI=y
CONFIG_FPGA_MGR_MICROCHIP_SPI=y
CONFIG_FSI=y
# CONFIG_FSI_NEW_DEV_NODE is not set
CONFIG_FSI_MASTER_GPIO=y
# CONFIG_FSI_MASTER_HUB is not set
# CONFIG_FSI_MASTER_ASPEED is not set
# CONFIG_FSI_SCOM is not set
CONFIG_FSI_SBEFIFO=y
# CONFIG_FSI_OCC is not set
CONFIG_MULTIPLEXER=y

#
# Multiplexer drivers
#
CONFIG_MUX_ADG792A=y
CONFIG_MUX_ADGS1408=y
CONFIG_MUX_GPIO=y
CONFIG_MUX_MMIO=y
# end of Multiplexer drivers

CONFIG_PM_OPP=y
CONFIG_SIOX=y
# CONFIG_SIOX_BUS_GPIO is not set
# CONFIG_SLIMBUS is not set
# CONFIG_INTERCONNECT is not set
CONFIG_COUNTER=y
CONFIG_104_QUAD_8=y
CONFIG_INTERRUPT_CNT=y
# CONFIG_FTM_QUADDEC is not set
CONFIG_MICROCHIP_TCB_CAPTURE=y
CONFIG_INTEL_QEP=y
# CONFIG_MOST is not set
# CONFIG_PECI is not set
# CONFIG_HTE is not set
# end of Device Drivers

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
CONFIG_VALIDATE_FS_PARSER=y
CONFIG_FS_IOMAP=y
CONFIG_EXT2_FS=y
CONFIG_EXT2_FS_XATTR=y
# CONFIG_EXT2_FS_POSIX_ACL is not set
CONFIG_EXT2_FS_SECURITY=y
CONFIG_EXT3_FS=y
CONFIG_EXT3_FS_POSIX_ACL=y
CONFIG_EXT3_FS_SECURITY=y
CONFIG_EXT4_FS=y
CONFIG_EXT4_FS_POSIX_ACL=y
CONFIG_EXT4_FS_SECURITY=y
CONFIG_EXT4_DEBUG=y
CONFIG_JBD2=y
# CONFIG_JBD2_DEBUG is not set
CONFIG_FS_MBCACHE=y
CONFIG_REISERFS_FS=y
# CONFIG_REISERFS_CHECK is not set
# CONFIG_REISERFS_PROC_INFO is not set
CONFIG_REISERFS_FS_XATTR=y
# CONFIG_REISERFS_FS_POSIX_ACL is not set
# CONFIG_REISERFS_FS_SECURITY is not set
CONFIG_JFS_FS=y
CONFIG_JFS_POSIX_ACL=y
# CONFIG_JFS_SECURITY is not set
# CONFIG_JFS_DEBUG is not set
CONFIG_JFS_STATISTICS=y
CONFIG_XFS_FS=y
# CONFIG_XFS_SUPPORT_V4 is not set
# CONFIG_XFS_QUOTA is not set
CONFIG_XFS_POSIX_ACL=y
# CONFIG_XFS_RT is not set
CONFIG_XFS_ONLINE_SCRUB=y
CONFIG_XFS_ONLINE_REPAIR=y
# CONFIG_XFS_WARN is not set
# CONFIG_XFS_DEBUG is not set
CONFIG_GFS2_FS=y
# CONFIG_OCFS2_FS is not set
# CONFIG_BTRFS_FS is not set
CONFIG_NILFS2_FS=y
CONFIG_F2FS_FS=y
CONFIG_F2FS_STAT_FS=y
CONFIG_F2FS_FS_XATTR=y
# CONFIG_F2FS_FS_POSIX_ACL is not set
# CONFIG_F2FS_FS_SECURITY is not set
CONFIG_F2FS_CHECK_FS=y
CONFIG_F2FS_FAULT_INJECTION=y
# CONFIG_F2FS_FS_COMPRESSION is not set
# CONFIG_F2FS_IOSTAT is not set
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
# CONFIG_EXPORTFS_BLOCK_OPS is not set
CONFIG_FILE_LOCKING=y
# CONFIG_FS_ENCRYPTION is not set
CONFIG_FS_VERITY=y
CONFIG_FS_VERITY_DEBUG=y
# CONFIG_FS_VERITY_BUILTIN_SIGNATURES is not set
CONFIG_FSNOTIFY=y
# CONFIG_DNOTIFY is not set
CONFIG_INOTIFY_USER=y
# CONFIG_FANOTIFY is not set
CONFIG_QUOTA=y
# CONFIG_QUOTA_NETLINK_INTERFACE is not set
CONFIG_PRINT_QUOTA_WARNING=y
CONFIG_QUOTA_DEBUG=y
CONFIG_QUOTA_TREE=y
# CONFIG_QFMT_V1 is not set
CONFIG_QFMT_V2=y
CONFIG_QUOTACTL=y
# CONFIG_AUTOFS4_FS is not set
# CONFIG_AUTOFS_FS is not set
# CONFIG_FUSE_FS is not set
CONFIG_OVERLAY_FS=y
CONFIG_OVERLAY_FS_REDIRECT_DIR=y
# CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW is not set
# CONFIG_OVERLAY_FS_INDEX is not set
CONFIG_OVERLAY_FS_METACOPY=y

#
# Caches
#
CONFIG_NETFS_SUPPORT=y
CONFIG_NETFS_STATS=y
CONFIG_FSCACHE=y
# CONFIG_FSCACHE_STATS is not set
# CONFIG_FSCACHE_DEBUG is not set
CONFIG_CACHEFILES=y
CONFIG_CACHEFILES_DEBUG=y
# CONFIG_CACHEFILES_ERROR_INJECTION is not set
CONFIG_CACHEFILES_ONDEMAND=y
# end of Caches

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_UDF_FS=y
# end of CD-ROM/DVD Filesystems

#
# DOS/FAT/EXFAT/NT Filesystems
#
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
CONFIG_VFAT_FS=y
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
CONFIG_FAT_DEFAULT_UTF8=y
# CONFIG_EXFAT_FS is not set
CONFIG_NTFS_FS=y
CONFIG_NTFS_DEBUG=y
# CONFIG_NTFS_RW is not set
CONFIG_NTFS3_FS=y
CONFIG_NTFS3_LZX_XPRESS=y
CONFIG_NTFS3_FS_POSIX_ACL=y
# end of DOS/FAT/EXFAT/NT Filesystems

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
# CONFIG_PROC_KCORE is not set
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_PROC_CHILDREN=y
CONFIG_PROC_PID_ARCH_STATUS=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
# CONFIG_TMPFS_POSIX_ACL is not set
CONFIG_TMPFS_XATTR=y
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_MEMFD_CREATE=y
CONFIG_CONFIGFS_FS=y
# end of Pseudo filesystems

CONFIG_MISC_FILESYSTEMS=y
CONFIG_ORANGEFS_FS=y
CONFIG_ADFS_FS=y
# CONFIG_ADFS_FS_RW is not set
CONFIG_AFFS_FS=y
CONFIG_ECRYPT_FS=y
CONFIG_ECRYPT_FS_MESSAGING=y
CONFIG_HFS_FS=y
# CONFIG_HFSPLUS_FS is not set
CONFIG_BEFS_FS=y
CONFIG_BEFS_DEBUG=y
CONFIG_BFS_FS=y
CONFIG_EFS_FS=y
# CONFIG_JFFS2_FS is not set
CONFIG_UBIFS_FS=y
CONFIG_UBIFS_FS_ADVANCED_COMPR=y
CONFIG_UBIFS_FS_LZO=y
# CONFIG_UBIFS_FS_ZLIB is not set
CONFIG_UBIFS_FS_ZSTD=y
CONFIG_UBIFS_ATIME_SUPPORT=y
# CONFIG_UBIFS_FS_XATTR is not set
CONFIG_UBIFS_FS_AUTHENTICATION=y
CONFIG_CRAMFS=y
# CONFIG_CRAMFS_BLOCKDEV is not set
# CONFIG_CRAMFS_MTD is not set
CONFIG_SQUASHFS=y
CONFIG_SQUASHFS_FILE_CACHE=y
# CONFIG_SQUASHFS_FILE_DIRECT is not set
# CONFIG_SQUASHFS_DECOMP_SINGLE is not set
# CONFIG_SQUASHFS_DECOMP_MULTI is not set
CONFIG_SQUASHFS_DECOMP_MULTI_PERCPU=y
# CONFIG_SQUASHFS_XATTR is not set
# CONFIG_SQUASHFS_ZLIB is not set
# CONFIG_SQUASHFS_LZ4 is not set
# CONFIG_SQUASHFS_LZO is not set
CONFIG_SQUASHFS_XZ=y
# CONFIG_SQUASHFS_ZSTD is not set
# CONFIG_SQUASHFS_4K_DEVBLK_SIZE is not set
# CONFIG_SQUASHFS_EMBEDDED is not set
CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3
CONFIG_VXFS_FS=y
# CONFIG_MINIX_FS is not set
# CONFIG_OMFS_FS is not set
CONFIG_HPFS_FS=y
CONFIG_QNX4FS_FS=y
CONFIG_QNX6FS_FS=y
# CONFIG_QNX6FS_DEBUG is not set
CONFIG_ROMFS_FS=y
# CONFIG_ROMFS_BACKED_BY_BLOCK is not set
CONFIG_ROMFS_BACKED_BY_MTD=y
# CONFIG_ROMFS_BACKED_BY_BOTH is not set
CONFIG_ROMFS_ON_MTD=y
# CONFIG_PSTORE is not set
CONFIG_SYSV_FS=y
# CONFIG_UFS_FS is not set
# CONFIG_EROFS_FS is not set
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=y
CONFIG_NFS_V2=y
CONFIG_NFS_V3=y
# CONFIG_NFS_V3_ACL is not set
CONFIG_NFS_V4=m
# CONFIG_NFS_SWAP is not set
# CONFIG_NFS_V4_1 is not set
# CONFIG_ROOT_NFS is not set
# CONFIG_NFS_FSCACHE is not set
# CONFIG_NFS_USE_LEGACY_DNS is not set
CONFIG_NFS_USE_KERNEL_DNS=y
CONFIG_NFS_DISABLE_UDP_SUPPORT=y
# CONFIG_NFSD is not set
CONFIG_GRACE_PERIOD=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_NFS_COMMON=y
CONFIG_SUNRPC=y
CONFIG_SUNRPC_GSS=m
# CONFIG_SUNRPC_DEBUG is not set
# CONFIG_CEPH_FS is not set
CONFIG_CIFS=m
CONFIG_CIFS_STATS2=y
CONFIG_CIFS_ALLOW_INSECURE_LEGACY=y
# CONFIG_CIFS_UPCALL is not set
# CONFIG_CIFS_XATTR is not set
CONFIG_CIFS_DEBUG=y
# CONFIG_CIFS_DEBUG2 is not set
# CONFIG_CIFS_DEBUG_DUMP_KEYS is not set
# CONFIG_CIFS_DFS_UPCALL is not set
# CONFIG_CIFS_SWN_UPCALL is not set
# CONFIG_CIFS_FSCACHE is not set
# CONFIG_SMB_SERVER is not set
CONFIG_SMBFS_COMMON=m
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
# CONFIG_9P_FS is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
# CONFIG_NLS_CODEPAGE_737 is not set
CONFIG_NLS_CODEPAGE_775=y
CONFIG_NLS_CODEPAGE_850=y
CONFIG_NLS_CODEPAGE_852=y
# CONFIG_NLS_CODEPAGE_855 is not set
CONFIG_NLS_CODEPAGE_857=y
CONFIG_NLS_CODEPAGE_860=y
CONFIG_NLS_CODEPAGE_861=y
CONFIG_NLS_CODEPAGE_862=y
CONFIG_NLS_CODEPAGE_863=y
CONFIG_NLS_CODEPAGE_864=y
# CONFIG_NLS_CODEPAGE_865 is not set
CONFIG_NLS_CODEPAGE_866=y
CONFIG_NLS_CODEPAGE_869=y
CONFIG_NLS_CODEPAGE_936=y
CONFIG_NLS_CODEPAGE_950=y
CONFIG_NLS_CODEPAGE_932=y
CONFIG_NLS_CODEPAGE_949=y
CONFIG_NLS_CODEPAGE_874=y
# CONFIG_NLS_ISO8859_8 is not set
CONFIG_NLS_CODEPAGE_1250=y
CONFIG_NLS_CODEPAGE_1251=y
CONFIG_NLS_ASCII=y
# CONFIG_NLS_ISO8859_1 is not set
CONFIG_NLS_ISO8859_2=y
CONFIG_NLS_ISO8859_3=y
# CONFIG_NLS_ISO8859_4 is not set
CONFIG_NLS_ISO8859_5=y
CONFIG_NLS_ISO8859_6=y
CONFIG_NLS_ISO8859_7=y
CONFIG_NLS_ISO8859_9=y
CONFIG_NLS_ISO8859_13=y
CONFIG_NLS_ISO8859_14=y
CONFIG_NLS_ISO8859_15=y
CONFIG_NLS_KOI8_R=y
CONFIG_NLS_KOI8_U=y
CONFIG_NLS_MAC_ROMAN=y
# CONFIG_NLS_MAC_CELTIC is not set
# CONFIG_NLS_MAC_CENTEURO is not set
# CONFIG_NLS_MAC_CROATIAN is not set
CONFIG_NLS_MAC_CYRILLIC=y
CONFIG_NLS_MAC_GAELIC=y
# CONFIG_NLS_MAC_GREEK is not set
CONFIG_NLS_MAC_ICELAND=y
CONFIG_NLS_MAC_INUIT=y
CONFIG_NLS_MAC_ROMANIAN=y
CONFIG_NLS_MAC_TURKISH=y
CONFIG_NLS_UTF8=y
# CONFIG_DLM is not set
# CONFIG_UNICODE is not set
CONFIG_IO_WQ=y
# end of File systems

#
# Security options
#
CONFIG_KEYS=y
# CONFIG_KEYS_REQUEST_CACHE is not set
CONFIG_PERSISTENT_KEYRINGS=y
# CONFIG_BIG_KEYS is not set
CONFIG_TRUSTED_KEYS=y

#
# No trust source selected!
#
CONFIG_ENCRYPTED_KEYS=y
# CONFIG_USER_DECRYPTED_DATA is not set
# CONFIG_KEY_DH_OPERATIONS is not set
CONFIG_SECURITY_DMESG_RESTRICT=y
CONFIG_SECURITY=y
# CONFIG_SECURITYFS is not set
CONFIG_SECURITY_NETWORK=y
CONFIG_SECURITY_PATH=y
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
CONFIG_HARDENED_USERCOPY=y
CONFIG_FORTIFY_SOURCE=y
CONFIG_STATIC_USERMODEHELPER=y
CONFIG_STATIC_USERMODEHELPER_PATH="/sbin/usermode-helper"
# CONFIG_SECURITY_SMACK is not set
# CONFIG_SECURITY_TOMOYO is not set
# CONFIG_SECURITY_APPARMOR is not set
CONFIG_SECURITY_LOADPIN=y
# CONFIG_SECURITY_LOADPIN_ENFORCE is not set
# CONFIG_SECURITY_YAMA is not set
# CONFIG_SECURITY_SAFESETID is not set
# CONFIG_SECURITY_LOCKDOWN_LSM is not set
CONFIG_SECURITY_LANDLOCK=y
CONFIG_INTEGRITY=y
# CONFIG_INTEGRITY_SIGNATURE is not set
# CONFIG_IMA is not set
CONFIG_EVM=y
CONFIG_EVM_ATTR_FSUUID=y
# CONFIG_EVM_ADD_XATTRS is not set
CONFIG_DEFAULT_SECURITY_DAC=y
CONFIG_LSM="landlock,lockdown,yama,loadpin,safesetid,integrity,bpf"

#
# Kernel hardening options
#
CONFIG_GCC_PLUGIN_STRUCTLEAK=y

#
# Memory initialization
#
# CONFIG_INIT_STACK_NONE is not set
# CONFIG_GCC_PLUGIN_STRUCTLEAK_USER is not set
# CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF is not set
CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF_ALL=y
# CONFIG_GCC_PLUGIN_STRUCTLEAK_VERBOSE is not set
# CONFIG_GCC_PLUGIN_STACKLEAK is not set
# CONFIG_INIT_ON_ALLOC_DEFAULT_ON is not set
# CONFIG_INIT_ON_FREE_DEFAULT_ON is not set
CONFIG_CC_HAS_ZERO_CALL_USED_REGS=y
# CONFIG_ZERO_CALL_USED_REGS is not set
# end of Memory initialization

CONFIG_RANDSTRUCT_NONE=y
# CONFIG_RANDSTRUCT_FULL is not set
# CONFIG_RANDSTRUCT_PERFORMANCE is not set
# end of Kernel hardening options
# end of Security options

CONFIG_CRYPTO=y

#
# Crypto core or helper
#
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_ALGAPI2=y
CONFIG_CRYPTO_AEAD=y
CONFIG_CRYPTO_AEAD2=y
CONFIG_CRYPTO_SKCIPHER=y
CONFIG_CRYPTO_SKCIPHER2=y
CONFIG_CRYPTO_HASH=y
CONFIG_CRYPTO_HASH2=y
CONFIG_CRYPTO_RNG=y
CONFIG_CRYPTO_RNG2=y
CONFIG_CRYPTO_RNG_DEFAULT=y
CONFIG_CRYPTO_AKCIPHER2=y
CONFIG_CRYPTO_AKCIPHER=y
CONFIG_CRYPTO_KPP2=y
CONFIG_CRYPTO_KPP=y
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
# CONFIG_CRYPTO_USER is not set
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_PCRYPT=y
CONFIG_CRYPTO_CRYPTD=y
CONFIG_CRYPTO_AUTHENC=y
# CONFIG_CRYPTO_TEST is not set
CONFIG_CRYPTO_SIMD=y
# end of Crypto core or helper

#
# Public-key cryptography
#
CONFIG_CRYPTO_RSA=y
CONFIG_CRYPTO_DH=y
CONFIG_CRYPTO_DH_RFC7919_GROUPS=y
CONFIG_CRYPTO_ECC=y
CONFIG_CRYPTO_ECDH=y
CONFIG_CRYPTO_ECDSA=y
# CONFIG_CRYPTO_ECRDSA is not set
# CONFIG_CRYPTO_SM2 is not set
CONFIG_CRYPTO_CURVE25519=y
# end of Public-key cryptography

#
# Block ciphers
#
CONFIG_CRYPTO_AES=y
# CONFIG_CRYPTO_AES_TI is not set
# CONFIG_CRYPTO_ARIA is not set
CONFIG_CRYPTO_BLOWFISH=y
CONFIG_CRYPTO_BLOWFISH_COMMON=y
CONFIG_CRYPTO_CAMELLIA=y
CONFIG_CRYPTO_CAST_COMMON=y
# CONFIG_CRYPTO_CAST5 is not set
CONFIG_CRYPTO_CAST6=y
# CONFIG_CRYPTO_DES is not set
CONFIG_CRYPTO_FCRYPT=y
CONFIG_CRYPTO_SERPENT=y
CONFIG_CRYPTO_SM4=y
CONFIG_CRYPTO_SM4_GENERIC=y
CONFIG_CRYPTO_TWOFISH=y
CONFIG_CRYPTO_TWOFISH_COMMON=y
# end of Block ciphers

#
# Length-preserving ciphers and modes
#
# CONFIG_CRYPTO_ADIANTUM is not set
CONFIG_CRYPTO_CHACHA20=y
CONFIG_CRYPTO_CBC=y
CONFIG_CRYPTO_CFB=y
CONFIG_CRYPTO_CTR=y
# CONFIG_CRYPTO_CTS is not set
CONFIG_CRYPTO_ECB=y
CONFIG_CRYPTO_HCTR2=y
CONFIG_CRYPTO_KEYWRAP=y
# CONFIG_CRYPTO_LRW is not set
CONFIG_CRYPTO_OFB=y
# CONFIG_CRYPTO_PCBC is not set
CONFIG_CRYPTO_XCTR=y
# CONFIG_CRYPTO_XTS is not set
# end of Length-preserving ciphers and modes

#
# AEAD (authenticated encryption with associated data) ciphers
#
CONFIG_CRYPTO_AEGIS128=y
# CONFIG_CRYPTO_CHACHA20POLY1305 is not set
CONFIG_CRYPTO_CCM=y
CONFIG_CRYPTO_GCM=y
CONFIG_CRYPTO_SEQIV=y
# CONFIG_CRYPTO_ECHAINIV is not set
CONFIG_CRYPTO_ESSIV=y
# end of AEAD (authenticated encryption with associated data) ciphers

#
# Hashes, digests, and MACs
#
CONFIG_CRYPTO_BLAKE2B=y
CONFIG_CRYPTO_CMAC=m
CONFIG_CRYPTO_GHASH=y
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_MD4=y
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=y
CONFIG_CRYPTO_POLYVAL=y
# CONFIG_CRYPTO_POLY1305 is not set
CONFIG_CRYPTO_RMD160=y
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
# CONFIG_CRYPTO_SHA3 is not set
CONFIG_CRYPTO_SM3=y
CONFIG_CRYPTO_SM3_GENERIC=y
# CONFIG_CRYPTO_STREEBOG is not set
# CONFIG_CRYPTO_VMAC is not set
CONFIG_CRYPTO_WP512=y
CONFIG_CRYPTO_XCBC=y
CONFIG_CRYPTO_XXHASH=y
# end of Hashes, digests, and MACs

#
# CRCs (cyclic redundancy checks)
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32=y
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_CRC64_ROCKSOFT=y
# end of CRCs (cyclic redundancy checks)

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_LZO=y
# CONFIG_CRYPTO_842 is not set
# CONFIG_CRYPTO_LZ4 is not set
CONFIG_CRYPTO_LZ4HC=y
CONFIG_CRYPTO_ZSTD=y
# end of Compression

#
# Random number generation
#
CONFIG_CRYPTO_ANSI_CPRNG=y
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
# CONFIG_CRYPTO_DRBG_HASH is not set
# CONFIG_CRYPTO_DRBG_CTR is not set
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
# end of Random number generation

#
# Userspace interface
#
# CONFIG_CRYPTO_USER_API_HASH is not set
# CONFIG_CRYPTO_USER_API_SKCIPHER is not set
# CONFIG_CRYPTO_USER_API_RNG is not set
# CONFIG_CRYPTO_USER_API_AEAD is not set
# end of Userspace interface

CONFIG_CRYPTO_HASH_INFO=y

#
# Accelerated Cryptographic Algorithms for CPU (x86)
#
CONFIG_CRYPTO_AES_NI_INTEL=y
CONFIG_CRYPTO_SERPENT_SSE2_586=y
CONFIG_CRYPTO_TWOFISH_586=y
CONFIG_CRYPTO_CRC32C_INTEL=y
CONFIG_CRYPTO_CRC32_PCLMUL=y
# end of Accelerated Cryptographic Algorithms for CPU (x86)

# CONFIG_CRYPTO_HW is not set
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
CONFIG_X509_CERTIFICATE_PARSER=y
CONFIG_PKCS8_PRIVATE_KEY_PARSER=y
CONFIG_PKCS7_MESSAGE_PARSER=y
# CONFIG_PKCS7_TEST_KEY is not set
CONFIG_SIGNED_PE_FILE_VERIFICATION=y
# CONFIG_FIPS_SIGNATURE_SELFTEST is not set

#
# Certificates for signature checking
#
CONFIG_SYSTEM_TRUSTED_KEYRING=y
CONFIG_SYSTEM_TRUSTED_KEYS=""
CONFIG_SYSTEM_EXTRA_CERTIFICATE=y
CONFIG_SYSTEM_EXTRA_CERTIFICATE_SIZE=4096
CONFIG_SECONDARY_TRUSTED_KEYRING=y
CONFIG_SYSTEM_BLACKLIST_KEYRING=y
CONFIG_SYSTEM_BLACKLIST_HASH_LIST=""
CONFIG_SYSTEM_REVOCATION_LIST=y
CONFIG_SYSTEM_REVOCATION_KEYS=""
CONFIG_SYSTEM_BLACKLIST_AUTH_UPDATE=y
# end of Certificates for signature checking

CONFIG_BINARY_PRINTF=y

#
# Library routines
#
CONFIG_LINEAR_RANGES=y
CONFIG_PACKING=y
CONFIG_BITREVERSE=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
# CONFIG_CORDIC is not set
CONFIG_PRIME_NUMBERS=y
CONFIG_RATIONAL=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
CONFIG_ARCH_USE_SYM_ANNOTATIONS=y

#
# Crypto library routines
#
CONFIG_CRYPTO_LIB_UTILS=y
CONFIG_CRYPTO_LIB_AES=y
CONFIG_CRYPTO_LIB_BLAKE2S_GENERIC=y
CONFIG_CRYPTO_LIB_CHACHA_GENERIC=y
CONFIG_CRYPTO_LIB_CHACHA=y
CONFIG_CRYPTO_LIB_CURVE25519_GENERIC=y
# CONFIG_CRYPTO_LIB_CURVE25519 is not set
CONFIG_CRYPTO_LIB_POLY1305_RSIZE=1
CONFIG_CRYPTO_LIB_POLY1305_GENERIC=y
CONFIG_CRYPTO_LIB_POLY1305=y
CONFIG_CRYPTO_LIB_CHACHA20POLY1305=y
CONFIG_CRYPTO_LIB_SHA1=y
CONFIG_CRYPTO_LIB_SHA256=y
# end of Crypto library routines

# CONFIG_CRC_CCITT is not set
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
CONFIG_CRC64_ROCKSOFT=y
CONFIG_CRC_ITU_T=y
CONFIG_CRC32=y
# CONFIG_CRC32_SELFTEST is not set
# CONFIG_CRC32_SLICEBY8 is not set
CONFIG_CRC32_SLICEBY4=y
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
CONFIG_CRC64=y
CONFIG_CRC4=y
CONFIG_CRC7=y
CONFIG_LIBCRC32C=y
CONFIG_CRC8=y
CONFIG_XXHASH=y
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_COMPRESS=y
CONFIG_LZ4HC_COMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_COMMON=y
CONFIG_ZSTD_COMPRESS=y
CONFIG_ZSTD_DECOMPRESS=y
CONFIG_XZ_DEC=y
# CONFIG_XZ_DEC_X86 is not set
# CONFIG_XZ_DEC_POWERPC is not set
# CONFIG_XZ_DEC_IA64 is not set
CONFIG_XZ_DEC_ARM=y
# CONFIG_XZ_DEC_ARMTHUMB is not set
# CONFIG_XZ_DEC_SPARC is not set
CONFIG_XZ_DEC_MICROLZMA=y
CONFIG_XZ_DEC_BCJ=y
# CONFIG_XZ_DEC_TEST is not set
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_BZIP2=y
CONFIG_DECOMPRESS_LZO=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_INTERVAL_TREE=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_DMA_DECLARE_COHERENT=y
CONFIG_SWIOTLB=y
# CONFIG_DMA_RESTRICTED_POOL is not set
CONFIG_DMA_CMA=y
# CONFIG_DMA_PERNUMA_CMA is not set

#
# Default contiguous memory area size:
#
CONFIG_CMA_SIZE_MBYTES=0
CONFIG_CMA_SIZE_PERCENTAGE=0
# CONFIG_CMA_SIZE_SEL_MBYTES is not set
# CONFIG_CMA_SIZE_SEL_PERCENTAGE is not set
# CONFIG_CMA_SIZE_SEL_MIN is not set
CONFIG_CMA_SIZE_SEL_MAX=y
CONFIG_CMA_ALIGNMENT=8
# CONFIG_DMA_API_DEBUG is not set
# CONFIG_DMA_MAP_BENCHMARK is not set
CONFIG_SGL_ALLOC=y
CONFIG_CHECK_SIGNATURE=y
# CONFIG_FORCE_NR_CPUS is not set
CONFIG_CPU_RMAP=y
CONFIG_DQL=y
CONFIG_GLOB=y
# CONFIG_GLOB_SELFTEST is not set
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
CONFIG_IRQ_POLL=y
CONFIG_MPILIB=y
CONFIG_LIBFDT=y
CONFIG_OID_REGISTRY=y
CONFIG_HAVE_GENERIC_VDSO=y
CONFIG_GENERIC_GETTIMEOFDAY=y
CONFIG_GENERIC_VDSO_32=y
CONFIG_GENERIC_VDSO_TIME_NS=y
CONFIG_SG_POOL=y
CONFIG_ARCH_STACKWALK=y
CONFIG_STACKDEPOT=y
CONFIG_SBITMAP=y
# end of Library routines

#
# Kernel hacking
#

#
# printk and dmesg options
#
CONFIG_PRINTK_TIME=y
CONFIG_PRINTK_CALLER=y
CONFIG_STACKTRACE_BUILD_ID=y
CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
CONFIG_CONSOLE_LOGLEVEL_QUIET=4
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
# CONFIG_BOOT_PRINTK_DELAY is not set
CONFIG_DYNAMIC_DEBUG=y
CONFIG_DYNAMIC_DEBUG_CORE=y
CONFIG_SYMBOLIC_ERRNAME=y
CONFIG_DEBUG_BUGVERBOSE=y
# end of printk and dmesg options

CONFIG_DEBUG_KERNEL=y
# CONFIG_DEBUG_MISC is not set

#
# Compile-time checks and compiler options
#
CONFIG_DEBUG_INFO=y
CONFIG_AS_HAS_NON_CONST_LEB128=y
# CONFIG_DEBUG_INFO_NONE is not set
# CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT is not set
CONFIG_DEBUG_INFO_DWARF4=y
# CONFIG_DEBUG_INFO_DWARF5 is not set
CONFIG_DEBUG_INFO_REDUCED=y
# CONFIG_DEBUG_INFO_COMPRESSED is not set
# CONFIG_DEBUG_INFO_SPLIT is not set
CONFIG_PAHOLE_HAS_SPLIT_BTF=y
# CONFIG_GDB_SCRIPTS is not set
CONFIG_FRAME_WARN=8192
# CONFIG_STRIP_ASM_SYMS is not set
CONFIG_READABLE_ASM=y
# CONFIG_HEADERS_INSTALL is not set
CONFIG_DEBUG_SECTION_MISMATCH=y
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
CONFIG_FRAME_POINTER=y
CONFIG_VMLINUX_MAP=y
CONFIG_DEBUG_FORCE_WEAK_PER_CPU=y
# end of Compile-time checks and compiler options

#
# Generic Kernel Debugging Instruments
#
CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
CONFIG_MAGIC_SYSRQ_SERIAL=y
CONFIG_MAGIC_SYSRQ_SERIAL_SEQUENCE=""
CONFIG_DEBUG_FS=y
# CONFIG_DEBUG_FS_ALLOW_ALL is not set
CONFIG_DEBUG_FS_DISALLOW_MOUNT=y
# CONFIG_DEBUG_FS_ALLOW_NONE is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
CONFIG_UBSAN=y
# CONFIG_UBSAN_TRAP is not set
CONFIG_CC_HAS_UBSAN_BOUNDS=y
CONFIG_UBSAN_BOUNDS=y
CONFIG_UBSAN_ONLY_BOUNDS=y
CONFIG_UBSAN_SHIFT=y
# CONFIG_UBSAN_DIV_ZERO is not set
CONFIG_UBSAN_UNREACHABLE=y
# CONFIG_UBSAN_BOOL is not set
# CONFIG_UBSAN_ENUM is not set
# CONFIG_UBSAN_ALIGNMENT is not set
CONFIG_UBSAN_SANITIZE_ALL=y
# CONFIG_TEST_UBSAN is not set
CONFIG_HAVE_KCSAN_COMPILER=y
# end of Generic Kernel Debugging Instruments

#
# Networking Debugging
#
# CONFIG_NET_DEV_REFCNT_TRACKER is not set
# CONFIG_NET_NS_REFCNT_TRACKER is not set
# CONFIG_DEBUG_NET is not set
# end of Networking Debugging

#
# Memory Debugging
#
CONFIG_PAGE_EXTENSION=y
CONFIG_DEBUG_PAGEALLOC=y
CONFIG_DEBUG_PAGEALLOC_ENABLE_DEFAULT=y
CONFIG_PAGE_OWNER=y
# CONFIG_PAGE_POISONING is not set
CONFIG_DEBUG_PAGE_REF=y
# CONFIG_DEBUG_RODATA_TEST is not set
CONFIG_ARCH_HAS_DEBUG_WX=y
# CONFIG_DEBUG_WX is not set
CONFIG_GENERIC_PTDUMP=y
CONFIG_PTDUMP_CORE=y
CONFIG_PTDUMP_DEBUGFS=y
# CONFIG_DEBUG_OBJECTS is not set
CONFIG_SHRINKER_DEBUG=y
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
CONFIG_DEBUG_STACK_USAGE=y
CONFIG_SCHED_STACK_END_CHECK=y
CONFIG_ARCH_HAS_DEBUG_VM_PGTABLE=y
CONFIG_DEBUG_VM_IRQSOFF=y
CONFIG_DEBUG_VM=y
CONFIG_DEBUG_VM_MAPLE_TREE=y
CONFIG_DEBUG_VM_RB=y
CONFIG_DEBUG_VM_PGFLAGS=y
# CONFIG_DEBUG_VM_PGTABLE is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_VIRTUAL is not set
CONFIG_DEBUG_MEMORY_INIT=y
# CONFIG_DEBUG_PER_CPU_MAPS is not set
CONFIG_DEBUG_KMAP_LOCAL=y
CONFIG_ARCH_SUPPORTS_KMAP_LOCAL_FORCE_MAP=y
CONFIG_DEBUG_KMAP_LOCAL_FORCE_MAP=y
CONFIG_DEBUG_HIGHMEM=y
CONFIG_HAVE_DEBUG_STACKOVERFLOW=y
CONFIG_DEBUG_STACKOVERFLOW=y
CONFIG_CC_HAS_KASAN_GENERIC=y
CONFIG_CC_HAS_WORKING_NOSANITIZE_ADDRESS=y
CONFIG_HAVE_ARCH_KFENCE=y
# CONFIG_KFENCE is not set
# end of Memory Debugging

CONFIG_DEBUG_SHIRQ=y

#
# Debug Oops, Lockups and Hangs
#
CONFIG_PANIC_ON_OOPS=y
CONFIG_PANIC_ON_OOPS_VALUE=1
CONFIG_PANIC_TIMEOUT=0
CONFIG_LOCKUP_DETECTOR=y
CONFIG_SOFTLOCKUP_DETECTOR=y
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC=y
CONFIG_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HARDLOCKUP_DETECTOR=y
# CONFIG_BOOTPARAM_HARDLOCKUP_PANIC is not set
CONFIG_DETECT_HUNG_TASK=y
CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=480
# CONFIG_BOOTPARAM_HUNG_TASK_PANIC is not set
CONFIG_WQ_WATCHDOG=y
# CONFIG_TEST_LOCKUP is not set
# end of Debug Oops, Lockups and Hangs

#
# Scheduler Debugging
#
CONFIG_SCHED_DEBUG=y
CONFIG_SCHED_INFO=y
CONFIG_SCHEDSTATS=y
# end of Scheduler Debugging

# CONFIG_DEBUG_TIMEKEEPING is not set

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
CONFIG_PROVE_LOCKING=y
# CONFIG_PROVE_RAW_LOCK_NESTING is not set
CONFIG_LOCK_STAT=y
CONFIG_DEBUG_RT_MUTEXES=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_MUTEXES=y
CONFIG_DEBUG_WW_MUTEX_SLOWPATH=y
CONFIG_DEBUG_RWSEMS=y
CONFIG_DEBUG_LOCK_ALLOC=y
CONFIG_LOCKDEP=y
CONFIG_LOCKDEP_BITS=15
CONFIG_LOCKDEP_CHAINS_BITS=16
CONFIG_LOCKDEP_STACK_TRACE_BITS=19
CONFIG_LOCKDEP_STACK_TRACE_HASH_BITS=14
CONFIG_LOCKDEP_CIRCULAR_QUEUE_BITS=12
# CONFIG_DEBUG_LOCKDEP is not set
CONFIG_DEBUG_ATOMIC_SLEEP=y
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
CONFIG_LOCK_TORTURE_TEST=m
# CONFIG_WW_MUTEX_SELFTEST is not set
# CONFIG_SCF_TORTURE_TEST is not set
# end of Lock Debugging (spinlocks, mutexes, etc...)

CONFIG_TRACE_IRQFLAGS=y
CONFIG_TRACE_IRQFLAGS_NMI=y
# CONFIG_DEBUG_IRQFLAGS is not set
CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set

#
# Debug kernel data structures
#
CONFIG_DEBUG_LIST=y
CONFIG_DEBUG_PLIST=y
CONFIG_DEBUG_SG=y
# CONFIG_DEBUG_NOTIFIERS is not set
CONFIG_BUG_ON_DATA_CORRUPTION=y
CONFIG_DEBUG_MAPLE_TREE=y
# end of Debug kernel data structures

CONFIG_DEBUG_CREDENTIALS=y

#
# RCU Debugging
#
CONFIG_PROVE_RCU=y
# CONFIG_PROVE_RCU_LIST is not set
CONFIG_TORTURE_TEST=m
CONFIG_RCU_SCALE_TEST=m
CONFIG_RCU_TORTURE_TEST=m
CONFIG_RCU_REF_SCALE_TEST=m
CONFIG_RCU_CPU_STALL_TIMEOUT=21
CONFIG_RCU_EXP_CPU_STALL_TIMEOUT=0
# CONFIG_RCU_TRACE is not set
# CONFIG_RCU_EQS_DEBUG is not set
# end of RCU Debugging

# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
# CONFIG_CPU_HOTPLUG_STATE_CONTROL is not set
CONFIG_LATENCYTOP=y
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_NOP_TRACER=y
CONFIG_HAVE_RETHOOK=y
CONFIG_RETHOOK=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
CONFIG_HAVE_DYNAMIC_FTRACE_NO_PATCHABLE=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_HAVE_BUILDTIME_MCOUNT_SORT=y
CONFIG_TRACE_CLOCK=y
CONFIG_RING_BUFFER=y
CONFIG_EVENT_TRACING=y
CONFIG_CONTEXT_SWITCH_TRACER=y
CONFIG_PREEMPTIRQ_TRACEPOINTS=y
CONFIG_TRACING=y
CONFIG_TRACING_SUPPORT=y
CONFIG_FTRACE=y
# CONFIG_BOOTTIME_TRACING is not set
# CONFIG_FUNCTION_TRACER is not set
# CONFIG_STACK_TRACER is not set
# CONFIG_IRQSOFF_TRACER is not set
# CONFIG_SCHED_TRACER is not set
# CONFIG_HWLAT_TRACER is not set
# CONFIG_OSNOISE_TRACER is not set
# CONFIG_TIMERLAT_TRACER is not set
# CONFIG_MMIOTRACE is not set
# CONFIG_ENABLE_DEFAULT_TRACERS is not set
# CONFIG_FTRACE_SYSCALLS is not set
# CONFIG_TRACER_SNAPSHOT is not set
CONFIG_BRANCH_PROFILE_NONE=y
# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
# CONFIG_BLK_DEV_IO_TRACE is not set
CONFIG_KPROBE_EVENTS=y
CONFIG_UPROBE_EVENTS=y
CONFIG_DYNAMIC_EVENTS=y
CONFIG_PROBE_EVENTS=y
# CONFIG_SYNTH_EVENTS is not set
# CONFIG_HIST_TRIGGERS is not set
# CONFIG_TRACE_EVENT_INJECT is not set
# CONFIG_TRACEPOINT_BENCHMARK is not set
# CONFIG_RING_BUFFER_BENCHMARK is not set
# CONFIG_TRACE_EVAL_MAP_FILE is not set
# CONFIG_GCOV_PROFILE_FTRACE is not set
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_VALIDATE_TIME_DELTAS is not set
# CONFIG_PREEMPTIRQ_DELAY_TEST is not set
# CONFIG_KPROBE_EVENT_GEN_TEST is not set
# CONFIG_RV is not set
CONFIG_PROVIDE_OHCI1394_DMA_INIT=y
CONFIG_SAMPLES=y
# CONFIG_SAMPLE_AUXDISPLAY is not set
# CONFIG_SAMPLE_TRACE_EVENTS is not set
# CONFIG_SAMPLE_TRACE_CUSTOM_EVENTS is not set
# CONFIG_SAMPLE_TRACE_PRINTK is not set
# CONFIG_SAMPLE_TRACE_ARRAY is not set
# CONFIG_SAMPLE_KOBJECT is not set
# CONFIG_SAMPLE_KPROBES is not set
# CONFIG_SAMPLE_HW_BREAKPOINT is not set
# CONFIG_SAMPLE_KFIFO is not set
# CONFIG_SAMPLE_RPMSG_CLIENT is not set
# CONFIG_SAMPLE_CONFIGFS is not set
# CONFIG_SAMPLE_VFIO_MDEV_MDPY_FB is not set
# CONFIG_SAMPLE_WATCHDOG is not set
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
# CONFIG_STRICT_DEVMEM is not set

#
# x86 Debugging
#
CONFIG_EARLY_PRINTK_USB=y
CONFIG_X86_VERBOSE_BOOTUP=y
CONFIG_EARLY_PRINTK=y
CONFIG_EARLY_PRINTK_DBGP=y
CONFIG_EARLY_PRINTK_USB_XDBC=y
# CONFIG_DEBUG_TLBFLUSH is not set
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
# CONFIG_X86_DECODER_SELFTEST is not set
CONFIG_IO_DELAY_0X80=y
# CONFIG_IO_DELAY_0XED is not set
# CONFIG_IO_DELAY_UDELAY is not set
# CONFIG_IO_DELAY_NONE is not set
# CONFIG_DEBUG_BOOT_PARAMS is not set
# CONFIG_CPA_DEBUG is not set
# CONFIG_DEBUG_ENTRY is not set
# CONFIG_DEBUG_NMI_SELFTEST is not set
# CONFIG_DEBUG_IMR_SELFTEST is not set
# CONFIG_X86_DEBUG_FPU is not set
CONFIG_PUNIT_ATOM_DEBUG=y
CONFIG_UNWINDER_FRAME_POINTER=y
# end of x86 Debugging

#
# Kernel Testing and Coverage
#
# CONFIG_KUNIT is not set
# CONFIG_NOTIFIER_ERROR_INJECTION is not set
CONFIG_FUNCTION_ERROR_INJECTION=y
# CONFIG_FAULT_INJECTION is not set
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
# CONFIG_RUNTIME_TESTING_MENU is not set
CONFIG_ARCH_USE_MEMTEST=y
CONFIG_MEMTEST=y
# end of Kernel Testing and Coverage

#
# Rust hacking
#
# end of Rust hacking
# end of Kernel hacking

--K+KrPlbAqfTrdreA
Content-Type: application/x-xz
Content-Disposition: attachment; filename="dmesg-rcutorture-bug-at-mm-h.xz"
Content-Transfer-Encoding: base64

/Td6WFoAAATm1rRGAgAhARYAAAB0L+Wj5fpv3cpdADKYSqt8kKSEWvAZo7Ydv/tz/AJuxJZ5vBF3
0cBaGDaudJVpU5nIU3ICatAOyRoDgsgw6LNN2YAnmjHhMulu5Ywxzf7vas8s7t2V+DpUP4d5lWwU
YA30GnXsyat3xOmrD33dVNgragSChaRqCdO/EewGpt56e9fi1N7q8IjoeRmz+VYH30BxPxWHcuGa
UW4AV++aBkYZdaNpTMZ0EbH+ASxNdhSvOLXnUx5HtfnOdbMHljFt86lliuX9vitJtVU8rMKQzhXK
2bfMPevXPDgOUT4Llp5LrDz2SKJfN8jngHp47lm136mLqyZ6WVA/gnVFPf12+LMu/5l7XHG+Mhxw
2NggA4FNqjRsLvqAxVEYlRMilU/INP6p2Gcvln3a/t/ZleqMkukKk8/iSpSvknzpXCsLKKJc2ZNM
sb5JqsgjR0/G0PwOIYYNGASXXNlXstMtQF4f7QKpuGH3CKZBnlBhBUBkS/4KehuJYDXKCu9LSpaA
WY8MEaTKesskPlpvvYfTMrO/HxGzbHWiRugpQnZ9+LjYr8x56U4KtXhGbvLKjEWXTwpfF11WYPC9
QzhycxtKuJQU3f/Ny7+D4enXnOWplguO2F0RgORT8OzTuK34FBCnBhRbPoYLtPPHy7GNUpojV1Ab
X/J1k8WTDoKH2yI+dHYmVRDxwU1CZEIX30zJg1iKFA3C+Kn3rONkswnvCmxFn8rJ6mhX6xFPQ2PB
ASRoA7sbetiCYEhFL79UrIH5SvGxZHIrhYHXHc/0Y3UT6SzwWomIudpmjOaK/O32sbLRCz84ZTPg
EL9iRakZpGb5Lmy9/6j6tyTS+g4DVLHkydaFfnH88y4eNlYhRFsA4EPsEBmoEC+rs8uiYl7Pizt6
sd9fDrlIPTeS2pnqoqAsw5C1XrlOvhusW8ev0N8psBbWyy6w04ZjnS/eYwDng58rtK/x+jFrBZD8
/scZym8OWe5FyiAhsiHsr9uh0omIz3jJpTijeg9K/XrdPEKQl6S5BL2Y1ShsUBHIYbkM1/X9k2c1
2xB62fV6FppsGURBCKbSOBFm5fdZfFbKtvwqfBKK/h95TBoee4c2ANVht4Iq3iIAXgVUeahMi0ES
kybD9oL7t1i8Yayme4YVrKVVxqdhn0qQk3DNkq4z1xI/SbHJz9CU3hPGml1u3VEX/3av49lcOjIO
uIDqXxXfO0yNZ/omzAPd0iEeQEE8sO1CZUJPCxix3yVGQhvxSmC47+ty2iWNvWy7Zjhku0bnCzvA
X3mgo7+AfNHt0Fotn/FxUl4yjGuKfGqWIftDPvaSjmxGOKfd1QL2+1QlBt0P/U+XCT7S9GSL6xBe
mGDLKRljNGw/VtwqWKVgEwN9U9m/PB9OzCxRDMVewdqB+KQ/ydn82ZW4T6nmiJWVGjebT55OsM8+
MUdk90pJEOF2shcdZnpYie0w07kZOFnnOrGAdZ2a5xgqcoGCYijcV2i1T+FA/mkYuQ40Vg8DnXLY
7xbQZ4OX29m2eC20+nUy7QS0MIIDKcewFFoH1N3t2w/KYDV3Pvx6I2hJ1vhlvdMMWBFgtnqUa9bo
Vb3awWuYcaAKR4gAZJdmjeW6rg/BeQQvNre9LvSnoDXvCe+iYElfIlb3FEVvBlKtx4ShcRStBYgo
2s1eeecBDNEzFqXGeiFXdJWxnWhNLLGpDo8M0MBmno+0CnlgnPVdMaFR/fz6GIViU5wGXVHrHFCh
IsQncGoEFuRONOTwWru+W/aEa7FbXJreJkXjHkf51LLk5hcodyCxA/vL8iobixz8wTaebkuF2TP/
uExPTfyTgXkctNrppK4paAFfrLDY5As4Cm0vIik1J0CMqGlTZ1GC25/CIMdTG5xv9l3E4vADCDGS
Des3VX5TNgXNc/0DQEn8b7an9HzSeB0Xkg+qbjekWOwjg9/1wVbhBnB7A47rUgqEeIqrgp1Ngf+k
24fKfbLFUc7gXjiB++g0lX2QLb4ZtUwB3hu6CqkoSdAlsZyN7AUHuRkopuPF+xLLTqjJtlqunHR+
vCrttAHwYkCblN1OEDMKxvLno9/MyDj0qWBVu2OejE8KcxAKL0oY+QzOZRu4FuzYQJLm11xlYEUw
fE/rNrFfUdmIQfFmvY+wKjD2P4KV4bOWvNFW4AVYNj5GiXdFANrLSlR7OhIv0Z6LhcieGsEP959o
EeyKwi99X1OciesG68eOpTvHWhk760Cwz3NhJ4/L+/Q31McloC/jlBWnNDODLbj5+VKmjWFlmQef
YA0olH+j98W51gO9oBar9pMQtf2ScygUSm0gfth0LVHOlNS43cn+3tOpkbyKG2KsBsUiAXZ3UNd0
3ACSgoOmaz17w5klW6qXtSBdbJZzMuV6VZx7APE/PrEMTY7Kf+oOVqHaY5ZtE94PFIlkzsdnBFlk
rS2JV+9TpzQSpU1LXIFAesKBSbV7bCeRPMa2BNXTNhQ3M61xtFvKznyuUOX4ZF4iG2yvWeEQ1K7/
mQlTXqDaBoXc+7hilc8Jq7mMkZyFWdtElogOAhFwBc6Xx7ZcSsi8qa7GEl3PLTBzywTkX6nSUZCT
ld7S63jwz2i8nDfpMC/VYxWj2KrZ7g8AegqKxR7ohBW5cEfO4wz9cHb9ADBhKBAShnIDQuras06U
43gGtdhzoBPPO3I5Q6GTwRMNFIjn9rqQySje12KRUXWye6DYVdb13PPwjOglzViaq7jAiYugOFQ+
X82pv6hl1H12VNR0DtIs8wngpzCWrSk5CNzI4267EFMwH2b1xohFG5nGWDOjgTVTWtrZn5D/fAQ+
PICRQvaLJ/gsq0ciD0BPzfkd94a4zhwjwy5Bl0pJt+btPqpWYpsxznbrTtLRRi/NiA7u2qWfGXf0
GEWCSPCo/kDSBr6gqJTlHS6oSiXHX6axthEgbOgMYDdGMloyS9TjSEvz5Lpb0YH6v3CsFKzMEcsC
EdQLBtngryAIlADekKQeTHGEaGu9AgTJGwH6WJ7OVDXZ4p94Nl3GlejGJN3qmscykBGZTUL8TS+D
GamjLVNSePVCmFxWF/vXVIx2zMdXwL4IEzXrxJ+gkzcQQCaOfBk9xktZel/0bun+woM6Sv9xZVVy
U0TXjVYSRLc/gwEXBM9OSq8OZi/d2UHo2hCD8DmUc5o4oGJTHX7tGh+mEa7ZdfNpUloZK83iXhAf
eXEGvy31yeFTz9eQhWpp85T9FaQgrVIHu4o5XmhqfmnazENdQQIUudrH1oQOoUEIVLKCbjNJp8hq
vss3h/+Ln5vczrb2ugragZT3ojSMNKGS/AYnOT8ZZROuQVKWkvjd2CFS7cg+DfVo+aukpYoWl4cE
dAiNXyC1vftpxFpRHykzGctvcef+sV7hP8LkU3L5z7gu2UpxrSe4au1zFjPkjVnLOOPZ43Esf2NC
cI0hKy5oDFgolajKbDzDEH2M+vQ2Ap/S0+MKX6soNCe5ik3k7yhBmzT3/SiPH2F8dQ7rgCZ93X9M
pDCbpkBKepEf4e3r2mUzk6N08wI7sXvVONHJo8dTAYvnPqdoJAPzIApu81TenctxC6BeESfyh/ze
4MCwYs/qfVMmT2r/gXtVdZxWJl9JKaJcOvXV0PaOLVfU88QcGvVZ1xbGaTudPKMCWfRm7fr5KGgf
GRU+3/hOcMt3rSApMbLhLC3u5kYRxtTd0ks7ANVOD2LCypODfEL3kPX2qJNPiPpJHSLyXY9M+ls6
1lWuc5BI3GvgHSgZFH+SmcfR5bqYUa4HRO1nvWWE1MrA2aAGhyJqnEJXzTQsFDj/cDLJU+saexKO
JjNiBNc/jXVgjRV08rmani557wIw0/UKdCzGAkNIvxm9C/CrulQkFScr49PIVJ/oiG2jogCjfkzE
aCo5B4AY7UXdwo5iUw6psWD+FqIP2nfUdq/08eyAXVOUoCfpPRiaXCgRJvY6UpvSeX8j3aseUO7L
04aE6yc/g/zL29dYYB/Rmthb0sn00r9CeMdWVhb1J/ETWzozbAHReBamIamhYw/SMEktkLdkjHsr
K7yHPkSel1Hdw2mKHE37okV2yQns854S0SlA1M+9G2UgZ2hXKI896ocCALw/lrwbMLFnTXdCMBdn
KClfXiVEm7L9afB5dQH8+bYhV7E0xPcPWo4rM91ibZCU8EEfZKDCB95NV9sQD9UkeJXed1gZTAQH
Hu8cct1QbodYVDOdCW47kcf8CPN4WgqDB4fUanxHQOVZ3IaGxbuQVHtnJaKb2yhh1lbkpsA5JFo5
7RQdQvwbEcl9NppALs4tfhu+F73WWBW6Oi+WfstIuUBoj+EUtkJwS6YEIYkqPyigICE6jch9To7V
gATbv1JBhMTbVAUqX3/FzPltGNqTLyJQVSZhkAvgDBcxNLTdZGBdb1Gumk+v422CGSCFjovxcnG6
+FgtmbWeCyilOWry8BVlhM44UKlbcjLs9PRxnUYV2qxvtvPBq99onJpgmGe+Tg0eeRAeDla7q2uj
MVjJck/Os1u32qzW/a9iMUulydrrIBp1LquOGPysLUXiT5x+YeJW8xYUu2tHMVK0c5oce2dhIthL
hLGforI9Q7Gi6CyOGGJeT9j9szQY39yoEXaLVI5JGym+erGfjLDJk8B40tsy112hckDE7cuiAkKR
MHXoqRqpnyXDixxV5MbeYEH0r+tGgoiw/aZg6edRg/jsz+0B9wfFEdYJ8nNKhzrDUFb65A2Sh2Bm
xSSMt2fCABi4soRMtmPnLV3k0gtLoWx2I6QXl6DAH0459dMRNYhVT9S9+ZhDThrE6v15LI2N8kF4
GBhr0UaQ9b0CjoEBJQIKiaWROV3zYbQbSIjjwhVV6ENNBH12eyKfjC+XkLoUcYpNMRtloBJqNciH
cXVojVja3Sl8BGBzaw6VydWAfoptUbHLA6VNnVZiiw8xaZoG2eJwTtRHmgpi8yoMQn7hma1HdT3s
AP6eGcTpoeyYh6tAMi1DXNJRv2Y+H9eZ7LalIJtGs5cq7/Ika2F+wP+lyQGyyfhGke6x/wquP8qC
ppuvgrEasq543+fP+/wj9nayDBlLH/lsuh0StNtOVAGxzNNeKH/1R1x3g0FoPTczN+6VUNHcMx4Z
r4WziNTZgS8bR1A65ibZRF3rboWNqkJ6ADmYeE5HUK/BNp0EfoPhhPZypLbxPed6fpouVgBTrxrs
ksiEQO6oabFDWdUa4mu/YT/3pmhMsbEPQMYTsAP4pCHqTW9lymkGPCTkJm7sny8ROP73zVfG1cTT
9/p5rrxNvJuVJOabF+Z1qUImoTPdW1PQmEyKFWsNHjbPleXcsOU9Ii/5/rcFOS8MI7Xx6VqlS9S7
1VglSL1q88ICPGCUOEg1K+SuIfB30h8MzUk4SyDq3T7O95gSD/BsjyJlPus9PqhcuSiaR2IgZtom
juYmVmCMXwLZc/awlfBBk/EZ6g2HbW7InmEYRztZfXp1aVJdVba62534qxJSpDLRuFdnNn8RkXO4
2CjSsYhmvgTd0WUPysTh1CSrogWZbSgv9xDPGsyIg7jpwom0AAqUJEP1hysn2g3r/RKibvLgymqK
DASUHbjcnDkoN6SFEZ8TY+G/6ipOARaJ+PTxVTKOZj6lfKyRO7KWY52X8GFuLXWLJ1VmiTrOIAuN
a0l2lcK40EfNYrwag4lRIdXmhEUkd6aMHpubi/uxx/t/O7FJJhTvCQ0owxJ0EknDfR+MaeBQS3G1
n1ibIS+PbROMBqT+yCgQ5zYl+xZVM701MGCreKnr4O0Q6FIVbWe907+9ea59iqw8yq2Osi+FK9rq
I6FWngMJ5vtU/oOF3DXHMC/uqvi/OVQvA8mKe22A6pBI15q65f+6pfT0eAnuH/55I31oxfnk4LH7
EPqB7TLlqbsxzjSe8xE2tJ6EmLIPs56t4om2K4Zszm2Z87nfXa+9yAl0lUgR1Dv0EKqbjV85rnPv
6SqrbMBwfeCnfNzlmD/mIDYTyMey+Z6zFTfMZtMnGVKpb4mPFmlKtxGeKPKnUf8cxBtJyANoAVu0
IpMj2byTCHswXQSOUv+2IO84DKmCXevrFBjOZ2cylS0cDqzv0TzV09W8E801EzdyXwuNTgJKCFlN
CpBtuHgZ9AHhipo4S27Y9dhCxkHxvQ2twWh9UW3DSJFuKzmPGhio5zwnNsMezMvBExbFDItvVBCH
QeRUvEoK+ySyjPLGxHlf/B+PhA/ONbf2e9W/YVik5DjxYeTNZseXplgvQ+k88WLVEYIcsypGHTPI
+kvUDDD4ubJuKR2dHwxcERoYtLg0wPxndqxXxvuzur72qZYd425mN57QS4Rh50qEqD0pssbkajtl
/np5G1sMEZg5BAG4Ca1mmnbiDxy3DPw7U0pHI4GiJFe2lWCU/3DEFVfTDoifYm6TVZcCEhk/AWE0
b83oL5Zr52e7HptPBvHORfQIo8e2V6O244MIH0DPHaQFQD1m1kN1kb3eBpJPCc+s/dAai68LR9od
DH8N9MGhIWHFqZ8YmaQqGJKcoxv/KUSLhppPhZm0mXABhIG8f1pzf3QzadvTFQuRnpUcylqi7LIv
DkxpGs7zqYSBasBdS7XRMNNtOK7dKYw3jQ+Q7LojtPrVbJ2VWmAPOwzcWMHZInwV1AVF2iBkLADN
eRzdugs2tpUEFTA1RlybfxOyzy95rGB/9uPxqX3URvSqTHUm43TRYFCLz9fPsSuEFtiPmJukG5Mu
qKhFT4c/lTYPvaTTNiTP0yIQo3sHSq1yfVJpgyvFqQrZHLKbiwqvFCSuIgB5lcqy4/QG//N9q4qy
Bkv2+hYacj+ydVFZHncU6/pHqkRMf/DlD6Nl6qmYI4QFuVYTKIIZ1s5SjEg+Jwr1O29e5r2UH1E4
YyKK8wB0QwyAP8RN8CoABcLfoLnmnmV174o7DrWsA77ba7g6YfMAkZVzlpMaZrTXnmjw9w1QkCMH
PffspPDbJ1Q4QPSTNjcFEvO2eh9jarCnd9W27fgzofgrc0rg/Nqo/WufAYKgkBpetaeCNNoCmP3Q
KVF3PNp8TIhRzksijKxZw/cQcoTZK8FyPMEbQv9Idj7ETxM/JtMk+T7tJ4oXdfu6R2hjtrpiQin+
higGNTdRL/HFD9jGeFrmrHZA6QNwd80ODSyc4J95vlbNn8lvReZ2R1sK6qOm4CRL6xPrfpddqrFe
7syfyxfjDjXSepHlVml/EcDRv7hiEupc9tqRvCHt492Bvtp0rOZEnffjzrnhARdyZV0RETRuiu+J
cTvJnAUvTHoAr7mKJO/TT1a6cuRvHx5JuzSxz4H39Lnud/bKT30oO8WbPs0l6tibvwDxpZMdOp4O
r/b//JxZXUqUCMYDcCLvbiTBBFc20tJmHgD0NRtVAg8DU/FM25aJvLKjTptMZGr+FtX1zqzuWx0S
ZFyZXpXXKizlIul5EKfXwHeZ3Sr+Oh/R2WSjvcpKOckyyj+F2gOr+71xGpWTPwykKwf6j0Mopc/3
52ik1ehK7rx+Yk2kpw5tn+hWiHgLsrVfopM5s6SBHY4jcrNIFc7WfrCKuDmjZgVDbkSkfU7KTMBv
G/dMDUNJSUyB5jzCld2YZPJnoKsqxZDaRfcFwZSUpCNCw63vCJW5vsD2/dCgDCx8r2zrcq6hokQ3
Z0a1i8CN/v1D/lHJjQWRQZdzagOPvl+TRf9iGKJdcFJEvArnOnDG8P9Feq/XaV7+3I9uWcPYRIhr
Rfo4o82UAE+/wBS1obyAkD8T7dXHHVCV8IryIvDrx7aJCU/Z1XnOyQrWHGPmvMSTj9ZkoQVnS5rv
oFgq/OTQAq+RLdQFKL2T+54JKuc4dzf1yo854DbABXYMZ50UZAAhGSUDDcsOFDYh9/qD3ADupHH5
GB1m61o6F3VLkY7oJ6w7GM7YpdvWDhksITVr8gkobdCA1953TGYB+mlihGwki9mUVfoK+M2V1qFW
wJ951mM/yDDMPUCWmv/7yy9JujiUZ9N9kmHQuwArrH3aNNBmPYQyEPkGnifPASuGM+wwDddrDF8I
xFB390sdKtwCFUF3cWTrOdoMI1Lb6qkvWPnBcD31ZEEFJqzgxR2+pBoubgKsN1fUSpyxP//mVsuQ
GtC67lx1bhkV5+I8cx7INUMoVdZyaJrAhmDkgVBLSSgu8Xd/D9PNGzWuA2kgSztQlrkM8aKrV43d
DmHni8rGLN2OeAbhWSBdoRv1edmnBxVEg9KoDx6jQVn6+7mkyDLOj3yv+qYFSFw0ND3xH5QZ3zLH
kXczkfpKEr0dzFPxH1qC/9SwXvTsPbOzoVnQ11Y1QYcnHyXfrvLjz/X1LPZSzk4YFrsinahumyuS
JIWLLCAfGYcTKVbcY7EAs5BuTW8F/Trqm+l6ayuGMtQw3XEF4/T4Fe5es2Ud2J9gXZ+Eciq8jXR0
MwfNOUoEo6hn7W64pq8l3nx5hz/QH+betQ3ED2wGPd5SFIwXiliZ/A3ioPIDRo/VIN/TzjkzD3FZ
oJ4HjqR8rpuMkMMr7CQW6tjZEAxPMc+xE9prGCMi3Q9qFXPTeXPev7xghfnLjs/1PlisxgQK0bdZ
z3UgsHdev8JlcXrROWQDX0X2Y83znkWVLnw+TrOiQ38EFdTISs6Sc/eQlDdj5zlnK/KWXgqfDZZY
A4SQNkNvSKL4bVKDvFWHPr8wYnWdLccfV1tNclVHWb25wbpYqBRjOTvfvPJb3VuZHfhsT0W2e83C
3R868uF4ReYv1Y3hJCpTtnJSaQnFv2uhrZerrf9JxF1qs1oFP8WbZq9axaX+ynVshHUdoce5Vkpv
OwPu4BCAT2zvNZYz4/HAjl2SS5MUxx1PpiTJpj4zRGHAr0EAbjVj4KAkEtMhhRaqNrbojFhxDwd9
0Ycje7XyMasGlfAuKQmFpHXViBteSuacuA66RpjPHzIDYd44XJHepVfDXn/D0AO0t6ig4qnxFTsX
9FxKRLVXkvpaWDpep8SLw4/t1LnGFMoC9VUmrc/nh33agDl3UtP0T4wKe6x1rKAmYditI3qmS6d1
u6SNMycn5llQd9Tfe8cMyVJBSGVtxnIrqzVY+jjY4JkWrivASFykLDKvyzSZ+QZLw2/wuGMY5T7U
PkBUfKRQYPLR2HjsFA1Nq2etBBRMLGKCKoMTe4jK7hRLoDWUmFQ+1LR4fERJFOBIm7RN5SpidX7f
jE1POZsTB4DV2/6QcZ6mFzW9BQIF9CTLd6zzr/5WMNcUHxKXcBzxqTXPHLmlD+XtaqlVwZS/ZXMy
A0+gUTYaOhvY2WPdoyk1bKj/kNQHiTdaPF3T9VaVQ9G7rP0Srs1HYnAfcAvwKP5fo0jGZuQiQCwP
4MQUoEJSgG7s2Tgu3UOB+vT0u49hXsvGqLAFLgEjp/yCWKr6OUpzOKs3WKHDA04E8l/LQ19Z5eRB
OUU0LyB1Rid1eQ3ukCPBLkRuat6VvEKFyuQvBFxI1CIExlVkJgcTKdKQ0TNf6Y8nGyqzgaMf3mkt
8n1t32zszKJDVW43AalML+iHOU4ANPbYyMlHHKIvgMjtR37PSs7GM016yLmIesUQ8TFS2vN5hvDa
J/hrLDBA/n4KTb26omItjwnndoUpPgdSp57y6C6CxYBzYYOaKhN2ZDcOC9XvakAmareO33ba1mt2
QnuawYbWIhCtmgMSFdb9HwdWppUnfOKLWcSzgOPOUPF9Lbk9+1eN3H2tcKmAhPOljcac0OkkTQER
5L2wchgZ3UDRu9+hUC9H1ojqMqf7ZSvcrfELHGrqgtdBmkY28NCkDpTh+rYyyDaqzZRsno3VMfnH
2mfHbVIWd7V7pwMv4DVDrgGHuH4Lx8tqLFifaddxI2wqDvXg75ZvGLg1uYwe6nEaQO1c5c5RgXaS
C4rjtsn7ObaNhpFhWUUERQfByyPSJko9RRmtRkaWpS1sk0Ot86NVyj772idMB1wndaqpvY8OVwqi
BhImJnEejUCtkDDjw5MiHsOeXeADzW0fdqSLjcbfo4iTwr5Mdse9NEsSQ9p1JwC1p2PuXaw7wU8a
Yf7r9sJTrlAphKXHojcS9HcpITs90fUWIb8+/WPlmM9rGQ8KKRfkv/5cAGTQNOKqpT5KGOpetfsV
18rWRy/uvGx1fTawCN0RhUvXiDnzYVaxhKN88mRi2Zwclfl30VW3WTTlmU4k0Xm18hrE9D6/PQmH
OyAp5KZodMHp8sUVahTi6na1pgCAGNArRXjQ9cnldQqj4/c5tDvn0ZUWOmr3c+8pzvmPpWGCJA+v
8Q8KeKYc8QQqbX2l+fsgD2cEYBOcvtjUnm5TMY3b5RD1UJLTmlbIdiMeCLEAJkgpos3Fne3TKb+6
gYuLJylDlc4ym/cw/9hl6RxW/vfGCd6EV5QGlVUA8JuO3eLUTU22vZVi1GmfRMaKobgl35fIMwz9
CMHbiss5mhdN82TF5O3pteFJsQEgDGAEvMIQt+uBHmDIDfwH/gQtgQz3O6pyahoFvsjcqX1igHh8
L3j5toit6Fp26goJOgFozVq4/BlTEql4ETLdA0IvbdKwlWnZGA129bQ96rgrVug8iL3jsCGY6QJK
3lXk1EgQiuc7g9RmG0rIojOP/1ievOl9YntJeijaV3WvQy4LdcorHJecz0XCTKdG4AFfYJJr8fxz
yZHaSt0KjH0hvIP2B34JwHz7UnWw/E9oCnIEnOjcSKFKAwCIGmgPlscgI71fd0znEsXvuuO9AFAp
mPQ6pXxxV1Vw2d1rXWRSMG/xhK9CzKH+T8AZPKrtSPI/emATz9bm0rGuavdIboRo9hI/XOnHsywV
/edZnCoB4VfLbYBy+Sm7MkAp1ahO8TTqPjTWr1Py1Q0hKavVysi2YD3VXXR3LlwXaNBJJTS3+wUB
NXF7JP8wzhBYbViOHuNZeBVUVLpf6hSJ9ciPq7nYkqUcMj7dQcgXGBNA/P3/JC2ll1FwX3uWig/n
ylQK0nw08lYdHKSlvmpCn7bslKv6MjYZHx5vEoEYYCke9SxKSAKWuu4k7wvXIkTHpcKm7lF26EUw
iHRDRUlt3vJQwwYreQJtwBjW4L9trt3FWESYFuqslkrUJdmARKb9q1wikyqXbW+jbsuHgy2fcBdy
9M9DH5E3/9+3MqGPhUJzBI/yHXnkILV4Dr9SlvJsyP4ky8j6dEwlwcFXk7FnqgOELo6bwecn4Iqj
/oe6fEAcQyg76jhzjmFdQjVeh5sf9b6lef/kdEvC6Rm9z8alBENFP4eZ5sD9dXQYzzn8qHc/GOjr
J9vtaU4/W4/3uU4CFWZ0bFEVPEBe4C/0z/BOWGhz6tQi6+lMJs+8wwgh66RNvkJqqUXtKhzgleHK
V7fkhj17YXgd038tmF5f2LepTqYC9BuWtCmzL2i0I+XtCpBLb6ggw6iCfMIQy1lZ/FpWBYhuR+JA
MAEmSl71nyWwj/YfUKKt3wMyOcZBPtR6qv8gk7NIa9UVi4EhB11JiObcM+vk8UAS6cYzWcysBYbS
IYXuzpsxBW96jsQCy/7Y176kqx28vTnEg88P/UpYUmWj7DfQvniHsaov971Ns6xIJMBoc672aCfR
/h/8OYtj3g1MlIwFCVpeUer/ObDPddMjYuHIjrpWdcDqTVHayeq7UAy/p/hwn4Ldb1hRDLiKUsY6
ZNoPMrUsB/bBFAVOZoGrMfCI9krbbC3i8hm1XoN84Cr6AXI1kGuzRJVtXbPXYxEGXWHS7tPrQBku
JVeJGhW6hwdPxnhSnSaHlA2W5JrjwGKQrMBQ62PRuiOQ3Fwj4CCSjywh8M90ibjTbgYf3TRDYCAr
c4mly/AYTJR5k0HrKR2vXL4lqOlvGFEjy3gurWXceWbAp54NHkSLZ2lUA7scd3ZczXn/mZBVP4kR
nGwiNVgGnSLVs7JDRfhvvKUnZHLeso79xZZBygPscASljsvr8SxfxrEi0dFjgXG1QzdoClMTyQc0
25LyAVf3erhpUfzEdHg92wHBbTSXP85DzujnwlMa40loq1+4Mlyf4fHjDZsOTDtB0oKrmaJUOM4g
uYM6y85EImVGukg/MqIdTAeQfFNEAdAvyshiXe5T2rDquPo3nYOtVcnc4tvcUuSqEy6wrPFkGYZY
z4Kk/EltqBFQtMU346L3qcW8MdaRkjwvXWrycmOEB3HFvHj3bqDvcpyHKdob3Hl1homa5DkjHFz5
PxdyQGHv3jLoGI+jlzmxvkcBsVM/+UH/VXPQag5kdHVKMMp9i8fTz9OkDNzVHQORa+LuqTinQ0fw
3igNi6OvK25/IFj2j49jLhFjM3qNjI1QQKvpEgF42oqXLaugVd6fa/zlb1TtrJWUC1tQ7wcumNKU
kDdtvzlr9IKv/10/qqXfduOWZ4wYwXjejxouRsrZXFwbHCUSdvVZTRr9SpDr/pMcBZ1F/yq5lmJ0
6+KnTlui50uAWYvsZ68ehyqomt0utd5cE/O96uahoH0vz0gaMZMQ3McpyMz6DQiCZ4rbEHgWsbZ6
UnTxwiB8ZSjdws+gblQddVhYZupztSOgh3Lr32L1cL4WcXlMkSjKn9n4uvU1C7V6XN0/f0B0SO+L
7cT1IGXGz6pIFVwSeIVzMgmdbYXlPvRB3a8Ai20kJa0/IoHzsV0gWCRV+7b+vwIr61V/9AN8Kc3Q
Ncty6U9JEmJhcgU0AulaAf2vd5Zg0ZpUyDPkX84Wpr7ADoBuqW0Bz4Q+sAlm4ymoRLUBgAXoIKAW
gE/hi91FVlrsJKM6VYfwPw2eODT9wEvqpZKZUQZ6LwNryy1BOM7bpdscrgw/UlTKM70cM4iKSP/5
Vno/1TFEHjRbGTohSJsLgO9yhrI/c2vk6heBtDZRdiVZpPgzhVGjNDzupti2ibo7E+lcOIxCsAA2
GLZJRdiUyk0+BRRX4RymhA7gy+KMjEEQiY5EimHeBQIGcRmUKvHTBIQFIW/ycferT8D+HcsD2Utz
YF+9JC7DukTI2kHw5sakzucAlgue2vTir0SRqf/xeS37IGBTfn4n5vrCPHwHLXDRAKETHLYe4jUn
y4Ng4Bz/AIRfDUs96Ak4A9ZPVsiiS/LwO3Dc3GNntv+93FWkdQDJIjyH2LgSMJKHii1xIhV23WA3
8JkOPYorsJtCEfdbH8tvQ1iImWtVrl5wKkPqplNr+oPmzK5xG50JSh3T/s/oBHeK0ZgW+qGt+xXB
zPH3/njGQbveGqK9u7vukNTc60IqRau49/r2+GtGFtU6ZsxGclTJCWXBiI6pHPHrs6X5SYSS1uar
1GIB5u9vKOwVkLKi0lGFdXjYBvp6VfMMYSByhL+H4M3TvQSVMWFLXUheJQphz8EII7yNR8osoIvi
vUaBy/eThMj3hjCmgxEJLfDYpUTHLHq4sW60fUDsQ0uRuXaDhsfWDE/kKSD9hVCfWI1gQjYFi2Pw
ophtYVTGfn0XrNgp/1lmsu8eXXnx8ld2QN9uJ5IQ+jlS7+6xhSegEemW2m5Km1vY4CcbZD9JTyNQ
cU4Un2HWBCZhbf3ncYoynE0f1q9a4kqOuZk/Q+s2VK8AiOiTKCZbBJfVz08mmYjro5wemMSTqRNg
ktN/GCebWj+oY7DOim0/4FelsMnthjmWPbc6pm/w1ohGK/K2J10SMCHc9G1WzWS/jOCcGTXgrMX9
md2GEL2+KDdbOkTndCoI73u3MLI0c0wG40kvLCWaz4SxEn1q9bpRqya6xoCga2NdDskA9J53qgZk
wG2TRbFFSUcyID0O1cjKJ9TmkZy3Vzka5K13912Exw6CO8vVG0SsIA5IK87d+B69CpUw6xig3+VU
pObusrh7o0Q2VB/pUr3yW2le8pOtyIVriz6mFcFH9NFUhyTwy/Vp+XFJMi/ZSv0aYdZz2fR+fxVC
RQvo29S9Htdn6BKEinb7lOJgoOV3PG21YGhz0RKoTj+BRsSchNOnFpsY+ca/DE8yzMoYRLYieMq8
u59GW5iU4SyHHlnQ+ffUcsWNY3kcArU6xbzn6EDpbkgEs2vGSAH1Uql3pdivYtdp1UzsR3o7nG00
iZrFh2HE2bemdaxKweBhlQDzreb34obsBljOFhs5h6FfvFVqv4cYP5K0OOsAls5KA8ep1bg9uJzo
wqyPgAAuBSbY59FEKRs17r7uuFq15uWpZxcp/pvKYCiOwWAgI+Sigt6X5UiTAwH3eMF1XYXDM7QY
OlQKOB3z9+Rx0sSucWNu6ctbLCtQ5k82ZnyowctciQz5Xz7UR0zxANxrNTDhcghRLukyYEA3Ukdu
auQUuDU098IIvSywnG2S1HteKSTXVQlXwv8WJtmMcmj7/lhPDzAC015vmMWLXrGJwmRrRPI1Pf65
hThQo5Uey90EbCLI7p6jG/AFZB6U0gJKEQfWbGLfmnQ3Azb1R1P9qAnM8djRRS0Tp8L3MhnbnBCp
zl1GgVkfjUVgjIxigoAW+vDnBnekU6PIbdAE9BkUXIbQtb/ZN9zBMDf/JWzI3XCpwruPxi4I1JeN
PtiWPU01oy6qmYLhEuTqodnwrCL4kUSaQGezoknLfonzGb3k9V01clsLNQy77nUW70HBRpEBUoGl
0fA54NHik0PeGiuGHCNLgZVrtXQZR0xH4lesORT2iJFAdlxD7aCTa+iHlIv8V6eOg4LqgOmVaZ3W
ZcL5UCX4th+SpJnDiepBVYfkKKbNOO6GfB712eOdNqDjIGYnFoHZLHtEPe/q9bPU65HqGjcvreql
A77oE5uSS6Z83BqNIvqA6DuNVbzqpwTnR3I9y5Vzh60TzwipveTA6ZnoOzQXE/ixiU/+riMxy855
rD/TbzUbBjOa5b+9vszogrB4ji5eDkN5ZtRmwM2pTt6fgJ+I/2KD+J1Zb/fr9BQEzvMaGStsKBA2
iPjCQi335Pc+zAdqPwi3E0+4eh4TvvgiD3PObVv3+yCarwZh18AlBOAcC2By/1A0+zmuakKRLOXd
vAB2frbnnKMmTx9/vTFCHYVpVViOLYUso4jSy6Y92i2PPSmZ0bAjz76JG1sXd8SPyAlrBgVeGe6Y
vRcRNRKP9ZA67rYYRlypwY8NpH5DTfWMycVg3GVzyjVVTuibfNrZPWF/ETzpfWu8QrNjcii0Vkr3
70FCXXbv3OsjuZ8O5eL/a0VUnjzlCFiBrNmMzCxa41nnt3o9g9asY06CzoPi6BLZxC9OmDdipWD2
bVSenbNZNP84eNut3mhBuRzsk1gazalIfct0Kq1KWNc9L7WmiQoRiRTaRT88iuYKJGY4MW73vNE7
448dgJD1szwB31RxWahZwAI/wlSdsZx59dBFw9C44it1CDwuPdBOL3dhSEswkYtjdrwFuJ2Mv7aB
436rP2I3vwCp+Ps3AxV56P+S2ieLMmwwx2ANHV4UIYOY1pdlSCzK2CrDZZwq6i1zklH9nSyVVK+p
CdXLwMjhH2DETxV3rZM4jXu8T2sBxOcsXpYla4n00tI2gZs3tA5MThTOfmSWMs6pqbo5YqwjJCXr
e47QAvhhcn+BhrwVpuUFjgkxgO5ffaVFeaOemo2mleoL5P4dFZTlECYtyNJ/M0AiFZPBLEO5qcaX
W0V2LU97+zq8rkid8KJxZAtmmnHjX1t5MLTFmLKmnjRgetMj4k6vBfOE3h1ZMzVhPVu88ux6FPte
GDXsjtj4cV+43GUh4+WSk0g1Sy1ySFOUe1qYahjb/YqANrsgrlEr9YE/6jslWNRtIHPYxnoVrwO5
MZocZSHylvO22yGFINjblRePmaC9dqvOhwTv3YjlTO0qd4gCBgKphFS5Jun0mBpiBvlSBxkokXcq
AWcWWFWKyz5KHijc+PDzlVqGM5vcYIm4JlKxG5EY7joC/bdfI3WgGtdFjI28qL6+A6iwPLshF4iJ
XlaJHLnHJYc5EqKg0S7jLg7WXwAGkBJDSN8sb7OZIc8UiRCNL6964OMRTzKNkhG1dj6p4vKkIC8O
Fw1EUT/DQ7QFdKLyXQS7yij3j4eKKp9yOHXCkCKW+8IkCjRhDkkcmeZeFTkH+mh+Kc8NKLCdkCar
MA1k5R5JLZddHC8TYuemP4xBeW+5Se7gJGvFXR/qk2FS30BVi4ifXgnSiHkwF7Z/yZv0kmk4LZol
R6jjvq2uLnPoJSXnNpekEhkAWuFEDcaR7nVAstP6OTyi/a2tNBcHytrcKxRIi/vncxZ0QVg0xt1x
IZ2S2l5uqr5DRCIqmqJZI4E74Qo5/PqmzBReV61kXCx6Rq/tNeD6n8hs7O3rSCR7Qp6xzGFOmBOC
8phqZE5NlyIMn69SK3m061x8AqvnwPPxUrNmoBZiuiuI/4sBT/zxME6u2MMbyP+ZRZLcEx04B85U
q8xVkBXybC2TUUEG/ymqyvTnQ7V2M0Gz8J7AMKGUmTPNpyrC+ZCjDaPild/ZDBI7U+tQrG/6W6KB
/NT7py2XLYBxJE6m734F5Fk1Fo46ZJvRdKBZiLfOLaflnbBG+pHa3koEw2PHFj/fWiCn9l4TgskY
hZc+YzGAEVvdXo3/ShMmly5EuwADdqLZAATzubLMTrm2afQ79V129yT4aBx3lZmEs7G6XLLs3Gs0
sRZOoQjBu+6X1y6qD4fSsdSocAqxZR1O7xnmId2SsPbVfRBzJChEZSnFuhCmLCk8d23vl6DzT7Bv
0h2tPtpacnUfj86S9dYcwmp5npxHzFC83We3P7p8121gobMbaOYYdPbkwnmh3UfGv+ug5zMNE94x
g8nIXft9XI7R957q/GJrw3Tn/HpSx/ILJE71U8zGNyoxUfckvhp57I4Pszh0zWJC9gSyE+djkzHT
le9JXwEfpGe891CMB6In4T8c2RQZkiGVTzb9EVsXfP4KQs0OYGJ1Xr6EIaL+OwLjy4umOEgGH/oQ
PWBZocHcIKoPhgzAkntgec0+ofJYdPhA5HlAymat5c73k42AHuNxgknD5osWJMZQ5OELx57o98Bl
QEVSea6P/GnRpX8O76bD8tO2K2NfEmujqAaTKA+e6/RQu9keZMtw5EevFEsYexRVxKXtgu6p5YzS
UGu7iFEi2PQphwG99CqEVpXqA5Ct33lP5kXemGznCojwi+rLPYRRfEhIHeHwGD7woXInK6LZiBHz
gmPfKErp4pY3zyd0tn9m2v6VD37uXBAjHRReX38eXmVY/+QXS1vL8WkE9xtG85MWU0JROKVFHHdN
esSx7SlyQfX7ivgUAuJ1N9bXw8wlOgXjU7CoJSdlPsghrHOI6agEtxozSa8SJp4vMzm/Jct9alLH
WQLc4tiHRijK1sVxhUO/jsBCDNsDnDPQrPqNSgo0CBdZORWDDld2s7bhmdl9xtuv/dSiKS6ulwWW
FMr9WR+yOs/Z3CNk1u3S4GGvgF75Ghnq3HB8uhpoMG0jKiHBsbhqC6+OE+OVOvWuJLy/UlnblLHL
tnIIg9qsNJ9U97mCvQ3q0U/Mr7pcoHCLGXAC6ASl5couTZY4xijio+sQryxPxegpT3MZCpGijbaE
4QrGr12wv+3CixyAfyNzLR6PWL3g5/dVP+nJL84kOUHdb8wOtW3hj5rpzrkD5y6uP1Apj0EPJRMZ
jjChAUHhL7kirj/mUznAPD5TnBE7kDs1mHEDqtFiLmdjMoTBpZrM56FBKWd2X6zaVD9huHPGBmZK
TE5BIVBmPsXkM0rbPugucrWLnFQ4CEyGICYQjxGoyr7N92fUVTwLqAy/tODzjsT0G/lnaz5d3quP
kGYyBCXs4maG6v2u53PthJEfw4hAdJvxfayDQ55P9LnT8yEaRgdG4hFbJuGIx54BEtI7V0Z9Kz1P
8tmwkVDyC7T4DsvhA0VHcEzFHcVgtmUKhvlTaLg662nENSe02XQZMPw2DBI7y6lwwlptpPiAI0d4
10X4/sp5wMbgYMydh6aRuIbs+fo1CXWlvA8iEfk+UFA7lUY3eEZRu5IbUc5p4MtWxpw9Vh/IA2gt
w6DEHPjlVu52/8R1qWwv3B7Bjm2dt4SdsZvwIZ1QGlwrAg0Rz9Z2s+dKT7SRTz6/m4k8SS+4sfJ5
txOI4p7E3hm7x33R+UzwZGTKcX57q6mr9uOmrWWWq6sliTIaqinIf1UbUwfNdo5IrfwE5CeMIO18
3Bsdx0b1fInp5N3mXmOR7fOmtCmU2ubGneBZKgyuOb/1Dd+IRVf8QO6hgHgonnycPftlHcsFgE3y
ZqAyWxEPwzbH7nWh0rkk8mOmA2ggH8Vis85S52uu7mgbX7vietCJiA3gYX/0AqU3+NXVlmi4xqFI
W2c3P8p1QFDwjoRm0WQTUjovEPZ6kprOaPBKiSOgMHQsv+fMkQDEYgvh7Kc9N6GNoGflsfFzprVh
YofMJBZ8uof/HuwpuDQgIoPi3Y2TVRmT4Ykab/r0tg+Qbotd1wmWjSWQmMSjPC70Lw9Eb1rMZOxT
z2nkGaStbMQILgNatAud+rbEqfquohut4NnfUIgfMG5vQjwyNjWQv/grD7rOCuHFTRiCsObMjNqe
+S+UELoqP/hsURdxyYpR2P99xHJdRj1XbdiuNw8lvRJkTeLy+fpaS6xG4SDWR1b04S4MxH6DOiOT
PeR7M53o0etsXlQVBcJVk9PkjS/fjfQMEkeZgQC152daSFVE4q2gTKs+OB+eO4jrNNY4jR2iwKNu
xMSUiJeXtGN+LOn/E4ta0tlcGqWl3uXlHx5EFwh2gYNu5g3+6qXGwcVsaw1d1a+dQr/Gjqt12mIG
O6CYwaqMZ6ZiC8KPGU4kVseexvg9Ie6GKyRN0q9zCHGTtW0Y3ZX75h5EXiit9b52ydXN7uCtIqph
KA1/KBLr1WcV9K8nlBfCMmrqUnc0KTPntoM2nR0oCzk8VRaS/rCekrISHKOwIFJ3t8keQiZnV8Fy
hiAQKTSd4xAbTOeiLUmQJ7GgPCVVXMOpMwiIeiBiKVXid1hB2TzINAqpX3HdVCxL1xYK35YcRBFk
BAbuEWNrkoumCe/E16tWjR1T6+bsI51Tre1TWF9VLQl3nZ3BZoVPuFR/XpHTa4CmTj6Bs3Hu/+oy
/on6V9hGfhj6wug/7z9Byb/JgU/j8Pm9S5ies3R9BT43vLHF4Wmxkif87Gh16MSwnA8dcl4Addje
5GNoIxVcy4dJYwbAXi2uw0gnDT0TY18tNUj4icSHmv2gyskhrO5mArH+z6j0gZuLDbegahN37pih
SiS7ZvFTpnj2Yr6nxTWXJvIkuO8LhncEDjY3OUz1lYIsUK2EAzP7ZvhCs24INyNeU7S4ZYuAFl7/
hbDTYzCbKgeForzdgnM6+P/K1VrDUTmuZQyPGgy2uE8P4+8QhykL7moJ4RDX0nS2Tk9i8/CNqeTQ
2UR5TEbEwT3OlpngzqoGvGNxOSfI86rK5GOhLaUgAfdsoWaHGqJTwNwB+3yxZJsMqfPSAjP1v0Mw
zNMLpME05+Sh5VhYD68ETq0FluvBAYLTfRVlTb5smdoKjQ6ZIyRxiEdV5jgkUl6TPUAFPUZlu3rG
1VWY9tzdvcKjHur+6Y4f3j+t4qGxV2EkHxlFqRZTHfCmozFpjxlp7+jNs0YF80lxyYmPKMxxJx2h
L3GErx7nwZpRtddHTY6S3/fKMY72HYC3CUKFtL1mKjQHu5o9jAHewv3okSdTS1psL8ww4DVf+ypZ
sDbeJErwGRDuGeNEwyn6SW0Z1WvhS81evFYVlx/FFXSIjzw/RgRshBrhStV1CmzBPbybr4ycE5lt
s/pHZ3u+bpIBI+XZGa2u5/Lsi528MlsJCuaq9o0sjBolBFpZxagRooEn2dtUVH8BGVN/UokvB188
RvFNm1pNrS4XUBdMahHL56hPVhFIaItk1pvFbxqSMPJqS0wTAdncgr3soIAfwaKA0fI7Ia8E/yIE
2DY1lpRgPO15hbgMPI8zOtomifM85AE11Fw/ho6P5gf82eR8QO9w0mDVJArUnEVWC372U/aOxjdy
/BdLXtMBr0jQvMR1Tfl26p/7zupA2TZUJGnDdvXxqxRfZWP+8cMXE2zyWPXUczBRbaASXnnpdfOt
j5MrP7fNyu93OUzlH+Yr2EFo6YT4Rd8AbuHkCou3GdPa/gJ6pZ+vIaY02QgBlxPtm2TFg6NWa7Gl
gMBroHCn/DmQ4WWbFnAA6YSAaVtyOUouPGIff2Ds5+gUpLMGNTdRXayuBVB3gnw9o4pgIhx/3juY
Ienp/8l14dDB7WuLs5jSNXJiqPyXzR0MfyngQCzy+Iqq0cQBPDRpE2cJ7SygePJzeUQqHcLjIzY4
uSnnsVzs1VDAtHHDyYsAXhpe81OFjYGOv+FZL4eo9gbod1hQRAbsp/uiEgWYwKNgSwDm/4/phCvj
BKPCak3ugBlmEljZCGpV8HEPjPxPvmCfjcBWczAN2hXRCcXAwF50DhofEWH6XxiFesGVX6VW44Fv
aF+sW5FBtynroWHPUKEJoiHU1zMXOhcyI0jcGAMLkbMspEuksNNbcXs1XrgZKm1zW63olqrIVGY5
jsy0i7eYd3qRK2GRkqMjK+uj+dT1wBjCQUWRyzwzl9xbcspc+0siBJKBNbcqjoSJlZ1qCxiFLL1r
O3zeLrlRW3Pz25IjNxtTn3MdEO41ipbJzrb0289q0ZGX05trxHL3hrRDhxISh4cOO9ErxiRVR/p8
Xl/IDJyCnHNi/QZmkuDJ0NOWqNDCGUxCaJPkOhU0/IBa9C78CnRfjWKItjkXaXQIatvNcHlodE2Q
gYneOI+nn9XnXYaJLUV+TXj/UZeweMmukrNsFZ4WX7YvlMYD80xq+tevN9SoJa4rpJUtSCm+fs5T
VKBBa0LiFBVFdHruTsF7DmSmP7vGFu+18scCIj0uPDrSOS9SQ74JHGvYhiiaiV+fbDD4oKEe33zl
Xyd+4aQOQQi7MgB6WOj1juEF+H25p4h5Rr+1SSi0uzv5AyPkf+WpyiTPatRlTSIDZpCAP9BmaGxB
WnPT1aBFc+/PpMIo7srp6BLvSde9Hyw5fP4E8yJZnty0SWDDuP52o2Hx24ys5RaM4zBQxuMHqF8z
kY3OvL6orK+rfPwk7+2xuTKlElV7Ou8X++zBnU7dHkVnwHgR7kn4UGGFBhDh/bwaZYmbhW7f0rdr
fzRy0wFkC6YRzTRZQMOUXpbh2lZ5m1SoCMyOWIHnbpCul+z6dVwCn5XiACSkO7InRkfFo+v+Wv9s
ZDEKpJMHymJVvLsIJ0QhqiwNebidF99/Wm884teeHCiueJL82r49gwADG7gT33o1Ju/CuaXRUjF7
run5xNdSRu1hvq+IIl67/STnf2e9zJ9NNCP3BCuJ6Wx2kKAu7HQWd8XkbOchdrOhyMy0td/Zz2AS
au6wZAyeykXoH75nlZME0uaFMkUrYJAOJEBAM5J9ROmBKJ2q2LeD8d6sr57tnW0ERw3vZ1g7h1Bp
hWcRha06k6fNuVRb8dCnDSM1bVX5ETQraORK2XvE1avh6YJTrbWOYz8CUNPfWLebwGZC80XGfbeo
Jqpy8gfhVZrF1hWU1CavYGgOgfyOmaAIDaivU9lkYbBGbnxuLHtsysxIL9U2T5Jyt46G9vMHbnKG
EC3V5gdNjXIa07pgmQ6jSqpOTv6GdrMdQrwBTi50Vl1QxWK9vYJNGtZsPVqzE+TBN5xFMhjhcmnH
dfIH8Jcg8vvb/V0cmxrVYSq6Xezt1jFn9kwbOkA5HX3PGBUShQ/Pm7tmvZNxbt1aVleQn5egGkWo
kYz1V0CGudCmqXtwxUQIj8jjzD+OwvHxqKp54dCN1GyAlbw7mXXrHM45OJXHkWzV/eitxIznD6zx
sMpUyg7fG966U2F+W0S7akmtczibLSXe27mojDB305lTef7f5pbg5bO8ksnEH+vrky9XYz4pWhun
ZcOD5b++0ux8bRf9Upd9gYGIxxJl+lTAWTyEoZ91apyh/1lLRm8tgOEVWgZ4a4j5ZCEOsJqRpmCh
Opn2kcrDKC9q4MBweqhx0dKVr2g72xzl5fiIEUSjYMOcjW/cvQgaEB/XiQZMNGHxZcZf/YMHY75I
oSEdp53R6hb+5wG2WhKCFgXc7sHRVYtapGdANNF3dVdOsilEBqxFRMLBXab6rjBPzpUGOfnYkBx6
Zy83o6LN6xjPn2vuuCJEubeWrUCWHPQcDOl5243CJ+pSOl87e4SMYtCwhmOyLu7/BaD/HkLvo5mJ
xar2KIgf2vOzJ8naS0zv2j8OBeTHr/lurWq9RZuo+WR0k2ZvH+y6F5nMSN0Mb4NLzljEAEvLzoVQ
bCoEOzM0V9+2G1XCEtstGbGoqDbiPecdMDeNIos2v47TPKUhHYWokepuYAuOsi6OaV1i/Hx/iJLD
qZW3CjuuIUr7BRnD/kNJQIU4w8TSefVKC69zrO0evIMXGyrEwYT0D/wISznCuQWewyo+u5GOrACG
Ggo1tUAq1HFtZCh12j5mB4CBY/7DqmvTAm8ie1WZWYWx/ZyQADN9Ii5gikgwnxBxxFk+feC1WUD3
xICTamzN8qRVnxU+DPuTZRsF1ssd1xIe+z51Tv+xSLsuLnmpTtm8WW+6mwxKmVhjSCkvlKCif9jO
24lY3XqhcnXEzd3PUCu7njembOoS7VoqTRWtRzA9vwBFf5OrJ4m71JonDvgNmXvqsLkFWtfgqsto
O/EoY34bko3CY7dL3DvpZFv4WMHVPGAz1ccmNFZKgduWav4vWK1YfZaLBq5N2fENzIsXDFXYz9Cy
LZUL+EddFUdAX8NPaJW/XbUc6pfaR2v7/+8qWYush4PuxWuW1SV1xzZt8fqKYuDwm82zHGPrx8+w
j7KYVUaH2sfRGiNjNubD1vC0/aLKS+IBH3DbIUeRgJXaiig9RrfrzAfVk/QOMdvDovoDxfBoNqt0
F5kmjqfJP2GwSX0PdOMuhhWNMglDagKognWlGADs3HSkgpcmXtWDxVp8KXhzfAGLSyVAhfohfSPU
+6l8YRQjIQfj9hyZHSRrE7DP+7pvy55d2W7xBV8SUKiDGDON6P7SG3gxXZAAbUpAuSnsRY5bYnt3
Wkv8DBOHKMXKdAexiYaMVf+hWxQ5pX6wQp1gD/DF8AOXzOvS/jCPnaq0bn2U+EYE4X7A8RbRllvn
LdZRsXezcwU3Gh4RLSRHeJR4C6/0NnIqAItvBFrJ2BnSIYU3vKj3GDd6xVfbD3B8rzGCa5jwHRh6
pFzrKi9103fwe1W+UA/DExNUWUVVY1rTwR64iCFaXQmuaLefMKI94F77XMNfaNR4Q4V5qg35YkEd
D3gDgDgYwdeHif+7JXLt36cXg7/lck3l5+lVqaSJ04sZr22tUEnBkkh0twgFWchQCDOjyBiqLSaX
pLkgdmyw7tkPN4NBNozu8DvaRlKxIoJwkiVgQxVhmCxoRf9IZsHnHPYX8X+ZFdsOKZ3Vt8pGGpqk
lewOuv+9nQIio0eX7wYm/YzRSn6gaqk2tENzDZVo8kWYTfUNubAspwU+fm/2fOrKHSpLRmTLbhwQ
u1+BHIWwIPZapNLvEJbgF96r3Qg2njfmMkTmEcTf30hvcB15ewY4q8lmDgh5glY4386NW/xI54cm
aDzjCHNm/069ayH/qc9WDg0WeyRS1WgFxvmwSxmUXfZzWr9EjIAkFb33sfyUuSR3JeXF6qOhdMkE
hjW2s4HGG3tslV+1We+l2Z8kZeV8XiOmf90zDXDAtc7B/uW2BdcHNXCP3Cwwrn1zZwEIPubFPY0d
MLf9NZQjEx3a7KYJYuBCS/iuojG7vbzsGb/j/dQTtluhDdfiMC/g2S11FYNKVh36BP07eLKMmxr6
yjjMOwAvhQPit/VC2GHeP383ZCJpp9aQOGrpfARv9jDiO3Spfz1Y1T7UcNvLuFgs4JaOZhR2f2xO
BiWRUQQ1dsV2HQDS6l6OYm/3+WUIBs+CSID3yLwPdh+4x9mkvsNQsuIo+6swLBix4dUCZiNjB3ma
VGYAVz/QDSJHQL8aS+KUUe1tTu7wtabJ/7A9a6+a5goeKHvcCxGbJKRn5Qyj04rPs8eGWLyG+jym
f+2Wietn633BnFxUYH7g3/pCDOilHOZFiGG+8O+7TUJ4EXQZFGWJIPvGPYIpnjEvnEnhRzP8jw2f
tops4a7WHQz+kh5+4ixpcJHcPS0e25TsbA4EKvEZ626KMXV+DtThF23MfHzWG3O5pAJ9mQIea6Mg
hSCGcxcOsv2LqEe9u6iCZD8XcAPlQxotmqF7v6tpw1r9nmxsf5xyNRD3XgOsIn5Jt53Sph7QvlCJ
GZZmwwNpa/eVhSVyudL7T66ibKFyNDKAK0VBBvCeVFeZUCi2fYWbM81wkv8uaFP0klT4Txj2idAi
luMSLwVlpNiVfa/fTR+v6Ze37WRwFUV6fvYfZiYHeUFfSwGEygzbyzrYqZ/U24sElFX1yUJVUzHx
pdGQpLawvbqiI6xkOfGNPgTeeCSbK+eEqomeqhQpDgPGGm5eR3S2dfnGYD4V0XHpeZgo3fisbbno
T9a8I1ikPHtASdLd6QPvrB6VVpcUw1ohL3iwCAtW+xI/2+39yxQvYL1Iuvd4Zk52xCevJ5hIcX4v
1NNZ4CIwW1LetffK9isKZfyF3Wf+XUAusmvAdBTVASJF+uZclBO3zibX4ymK3IDeM9omX78MoRD7
tN9Pg23Yvfj0yVpeDTJTGB/f2Nuq5JlvYkbTR9XNibMQGhN6BQneYKKXp34kOXYdn776sChkPbDq
bBoWapEboBuremNGr4lOMr3AuoTfYJjseIAmuXlhOD+zlZc9I17w26v8RLn0hp8PGvbE4qtndpAI
AEnF1PV/2OiQAlJ0Cxj2tkeYjRKz+rojt0we4Cy1WhPWvzLvBarX0Usc5Beh6pAGkDQbkwjQXln0
XRcKNAlmuqurb5jybX7p/I3XHyyFFr8kqNAhuujpcTnD8JHYvqir7kAENhpE7/hdNqVGJWVs2Z4k
vmPaitQHtfUiKvI3ksrdOjQkqSXAeP7WF9o8eqhzTsGI7izr/InBOXAdmFA/+ioTo3sBX2BiuEzz
l2saEw+9ABeMqtSqYc9Et2um7+mg8TZ62i6iiBJ85jIPeg4xiNDp1XI4V7XqTjXeFAcmaWt/NI9b
DSbLAIb4YqT7zMZfSlopx4fRiPoaAXDMgvkbDQVNbqXUTZjZ01wHT+Avz2fduxptTMUt43pKvPZC
Z1bxzsCICTbLj+9ZOM2FJ7Y064+k7g3jen/R3enf5s/+52tARsWIN8gIyAlUeFVvWGJktNJwq3cG
6cQvwPxPBNsz6ygiCiixJEeQrkpgT36G2R2ufub3r0f9vtfg7zNCz+HuM/0Wr04XKoUQAoenLddU
bUsex0hGOorMrSnsArXoYygPWSZJCHWMOGLOmLRgwrFVcNMk+tYde7s0VpLIkrRbZ15m4yGPtY3r
/fAdQ/I4Qiz/dXW0f940TUFk9Q1zL1emRCNRfgaK/N5pwBE7bRYMHbjpl1gmEmtckkpU9igHA4M1
774luCZjJDpxrLuG9KzoMBNPI3CoFkJ0S7/p4MNaYuaDjlvAqXE59ruv6u3YdqM0qXB8agvBRvwu
CGefNs8aMi1k8AAOgkhx3oASrvi3lUB3iJQoqj7OD3MsDEpK4Tuq2F4yl16X9Y91XH71+u80rm1m
gdsjfoZtfTc2/RB4X+ljvzAqhp2LRHMyK6eOjLbDktq6nvqeV5cSDfR0emadiRBECdJ3TjJ1PZkx
+N/OY3sDp6Oma05mkK8b1ymOgeeezaNbilpbwfiMQtpQ5nF6dzQJpKl4wZ+e3ZAcXPOaO5xQ6BHy
VRWdTzxqqxy4U26tlzEufTvvXjwHBThkP0MsypfIhIfek0UVrwjpt9s4F1bDAhyhodtXGZV29kZ9
pu2fazbqe6fKpnfq8TjHiQJoy5UZGmV/JfyCRbRkI27jsW5tTVGFwUXMBMgeGykH3Q79kh4phj3Y
jvCNXyYk36+JH4DAlb6iUzay8jhRax1oT7IGFXFAuuA36ezqrYWrWX+Oh4yDQT7C6V3bZOMxUhKb
BZnxChEyMYUMWXZWNikWfnNZaHv/ppS85G4tfRwjHNFZtPGhsRwFlg2iNDMGbQZBX5iNsrL1V8Ax
mx1g0OIzRTXobkZ4iQLJwfEifmupGOIfDf85E+/A/2RvyT5bdzLKf8W4M5cCliHV092U9hAMDric
aRSNOuQOIFpmacqM+e+wtw+6xKnm40McVuSSKMf3i7n3O1N2C0lXMzn2dTwQ968IBZFRYRzE0qA/
5Kg+aOGlk2V0/rh0Sw6NS104Bwjjkrxg5Nijct9r7oSVmu/avqpDkPWA5q7I6clSPqO4HUbJ+Zok
Wm1fTtFfFhqKK+NegJkRwvZSbze9i++8g8+mcSc7DtGbRL00PItX3dB2EptJOn9XRVBv4VHqoiKr
oMtYTbu8ybZT/5zy7AYsxCqmKtdY528DWFb/EmpN0cRH+RT4V1THLqOUA2M4sMwC5CnUwAhlOLq0
9sSUH77Ngq6JVfQYqhwLsksGHfhhnbQdlTbsV5oEhP45Mv0IWBa3NT0YuUwwc0A0rV6B5PEYc3D+
LC8FuP1kgpfmOiPb0Gt2r/9UflFaDjLI8HPMze6p+TArMmMqjUlfP8K3SM0AJnG4E/BQhoJdnAgL
2Y68o2W1/GW00z2Ol9pSPMIH0FT1GxYO6H3VMOs/pkWSS1Axgp0+j2//GmCbS3+vr+VNt7HtOCYR
Hv6LaeZ1Zifj4JJjHIlTSg6fcIAo/YAk6P8bDPZWGWLvPTbpUl/JYEfMbZjkn6DtwwxN5eGcdY/s
1Wkg4HalMWwhTF+z7UA85vfAx2yIpSnfg5CltJTRDJaUsRgtVM1AbXCzEPcCaQhzPsXSgq1w3/n/
+JDtS+wg/ulTK5zbkB4SZv98felhVGIE2sGFT0SnFfREGowjw+xCLNZSJgytEHDZgoKDVXEncYSf
L5zZHze7UbNV7/kwiB+QT9+STgq4uhM5zPOJtdguf/eDazoR0ZJaOKYj0aoc6nWnrZSsmDQLflEx
QhUP7KDLUv1UoktVxiDMDkFCcT4aW4NLr9LyqJHCly3jGzBuqpWgPcJssQ8zWY77AM9yBvOTjbmh
M7UfcggcP6k7NmGRq2ytOTVS43Yur+OquCht0OtaW7DnQqG/kva0kL/eEJU9uMFJetoKrsr0zKkq
Wc7wbcVpCPmhTlZS8YrlISf1JjNRU+BXIGY3UA1IRvNy3QmFY4DaxyMl4JDOheIUjyy/yTZMTbVF
Q8iL5hwJ01aCY8UrbnIXCE+dLWGK7H/II31c4/tYyQdgluuZ5tHRiLsnFnsf4SxhhYAiagI6m5ki
TrbMwsCeixuy1bKn0TYru66Kxa5ms9xrHnNjQ6SCCOO6NA/KznKmX5WF1KrCbtOXIouo9zQyc+iR
eSOrajFq86OHT/PACRgTTmpXZ2VUZ1HpQOH0/NBzOD3Ph1o75zO7mkRb3uXCq6Q+YCnFHEHKYs2n
Yh8iR7ChxkfZZWp3v7GumdGYBFdNENqdjMTJKu7CcnXeIIcipydO7YIf3SGdTumS8ed/dKInOHU4
lnAOPH033JIsP+S+YMXJ2KV+ssnNeeh+6CaCcWhN1Rz0W4QuyFBNKd8FIk8qJ5RF+tV6IEA5v08W
1lM3PC4dr4aMxIjcS/ugdvVOH0Ui7NsRLYwM/DWDohyvmfo63o/1lK9CKfnG10VD6KZiyZ2whAuN
kLtP91vRg9ac7zlX53UtTYP6+r31w9PDDW5FcnuIn0+bGQhtIXEo5fs08BU0ep13zORXOe3KF8EK
YiQT6/re4l6s4nGUeJ5vqabaKkU1RD05JKnFWV4v+f7f4njdhEStDhV/zX/vNmPCnrAYFtjAdapL
ykPKKtlgaUUbNC5EfdwZnMPac/KoEpUhTLVLGuTMjpPBJNipmCAxjGKAbEipA+JKCmbY4w1YcWa4
s42VuHurN1hBMXSewqDIKBfWEFBMZnaA3I+1R3sxgp7nO4y9fB1/0V4xAaXAZSYnQh+iXYJAORMM
dpFdLIHQjRzDo1Y0Ir1VL+OdwVm8VZiIAKhgezFrXqrSQCOjbYByt6S5y5pTgAkBPVle2969P6ps
YnM6qQ5FtV8yHurDRiiIVHFRAqOmiPl2i1Jn9ErkY/S4XB9hATLBlj7Z2PQ0t/3HDzS3ft5fW7Jf
Rcu+lxOrWYlGYRs7WBJb5iIHnJGpS/qR9HB2YpnKhA4JarqzMDBlSTYxCMmulZBwOsEOYLissLjh
2mZo+1Yq9rpBViOO57xjmenOh58IpxTR4Ow+AfWpNvFgec79ePj+fTJIA0RrzVfwacr6FwJ3xY39
qtohik9VKml33ppqNj6wD99DhHaxRB+9EcdePSHzSZNKgZm/WrJmviZhQK3virEDsqouY1WoLcY7
A3qSK6ODzZUnBayj7p0XtOZA+KH2PT1LFiZ/V2T2S91cJ+vxIiV+xeYjqOx51idK0PB7Wld2IL8K
u+lIjxr8uI7Tp8Eex1QuGh2z1DA/4/rqGpskEy3nVnRQRP7nLih2h91kwZfvMQD/OUXRW3OL+EOF
oVJLVfA6B+kQsv+ojC/+S7Wax45jwDCF4VW5faAJ6az0bwPaTDrt0mdQD0LA6wg/j7jEr8zXqV2J
LFJ3eeRkkLBgsAHAVVyqPA+ieIKdNzcrhrPycOub1kvODqPicf6O5EM8TmZtDSbsypOqaqeJo5yX
yNjnFVTAuSFwxdU+xbw5pP4VRlaGX2hykcgzgOr182TPpNKtnxYn7Bj57beGSAnNEn3Qdy6B7KC2
9/Zg6Pjc9NBrz+3+wYCmapofu6muTEP9/iGPxlKmrAwSRJVJUIy8K1GMB4VaXQTwrQhaeiPDMSY5
hcgjmMOQnriQGO3KYOBuepCugph79bEhdxOHaEsLv/+Paif5mczekifsLH1SvQVIcrsKbNe5A+PP
Y6agfw/nf9CXIIu6w316bOdIDOCI+xcY/KwuU0PnDayOC0K2/YVoWVMtNKqKhMo5Ozd2VPBDXcxN
hJ+36Sf53nytI3bfRiTVBNpO/WzTTllSzkSCP8ZSYrZHarHFgYxhJ6V23FhtKgRs2b9YRu26H6k9
oUJfY0NkI0XJVd5lDRDa+zs8SIAJjz3VGpAPBvr94d9E5TpRQH1tA72erPeV+VmaiwltTvTpCAfq
dLVEMrYNZABOKb3n0Xk6B1UAGOuMd5uHxeYzu4jByHjA2ys0FZDEIbienBqWOpxOtKxXbh/FFN69
HvW0SRpJEkBZEj1SdEGHDoF/oFlvaBJFmuDsjltNWBUH7S+x14To89o+DAtSMtG3ND1qGkCmGpx+
+lLxdSoE8MscqUosAnyBWXOZ+KQIh68L1koUhLMqYCoPuhsAknnd9qtLuZENFGEkC4m74ylsvANl
vkNJEx6qMYyyskD+vFEoc5p2tE61JZtn1imNh/4IUc8uTjMiC/D6vdmCDOXgms5tj/pDbeFqu61j
zn3jUTe8lLKOpU6oIr2n1T5EMjMQ0Yx5UOgTw5BOUZR/VIcVmMFd1mSugxIwMMu6wBIFN1xvNFuh
zy9TQv6eEvUUob63jhlkMHtDGjcRy7cKg4Uh1Jogzp39Skeg4pP7NqL3UsvxtdBYnb/k9bVIBkiX
9RxIJ9iD/2XhjEomdpSfL9tbgPhgc3noypw/sjgIoFtSC/kwD/cP3Tc6CDmBWm70QGLDmAhUmgJK
kgJ8lhLJxMCuXxuIS6Lgskcmb4QewupGuAf4FDndWvrUu7Y4ormt2o2fs3eYjb9oZdMPJTnRNE/e
Mcw0XDB3jqh4zoGmHBdjC+u5j9y+wxgb7U/DVpVgbVjnkXIuLp3kn/07lmtA1yLIFiTGzSMqFuJ5
cC/4KJKki3tDk8YtjAFVhJRuyBoQi4NC7DBcrvbCaiGePo7/MfrsxKRsD+c7JwCTi9u3/BBXjYPg
Xm8CB8ZA9vogwapNcDxe8ykCo3MRnFRtdAc/CI7G1FP8ctKyTRySkQKGkKv5m8xIBa/cu8biAbh9
zt0gdE2G2BaD1LfXvo1VdJb+Lr6auEv741rAJIPJ/HE5UPq7vhXvt++wYOAVKzlk8niL5piPK7ez
1Bl+zNa9NNLkBBdljw19B96DdlycCx3JUdFNYioAlUnEHS3v5ondwU1UHhCf/FHQjYDNl6G16zN4
jOng2lM/qq4gQQz3kwXxKIxMovSpsiiOHHsqk3m+SIV1Ge5SdXRzcR4FulmmF+NKQvj7TV9UUHpH
VuzorAuNuar7f8LSAUjg2M6cT5L97NVxXD2KwjVBUHqVQnxHFMVNp8MVMS8bJBsR9lkmSc2b/Ydb
mDbKuSYXMXxVEHqSRc3TzfgaxcVCBzwEawt0sAS4fd5JqBWpjNDX4zPIRXdnla0HY1acBhIKAXdr
iNBSr03FNO//pwOGr4RFYeG/Cuejgs4TaLRlOFqiC6vaxZG+S3pzS7sLH1SntUdY+2/1ax6CuI/a
iM+FqMPS/GPonPLjdhHBCrKXewyKoP8Lop6fWUvfuT+rXu9nSAu/vnR5fm+z5pki84jY2F2U14JN
7Fe4023VG9/K9HYpYvJVSiKfv/9+QephcL5D3EA+0TZD5rE4ZY/PXuD3gXkS/wj0nN6r6YPzLZ0T
yieGSKNDxpr5ALx2YtRF3bJkUrtgrXZqBwAdmIII6qHhgPgRMRH33KdzcWFFM3/JreIqM7uOZbWw
ZRpVdqtWKm3O/60zXujxfB/d9w0X/7KKpEZOQbHj0uo9EuKBqpK3MUEkJFLVqlzksSjUPSEfiI+f
7wrE7kyK3pVYe+7FEYcUhZr+WwbgmLgHqNW2XtwGZVMr3coeF/YAAeaiNJBm5MfbOwVfO8O4z+80
Pu+EfZp+kKEPJs55aw+PDPk77iw6gfbXm8noa9GEOxRmDaiQEsgmg1x0fFziYl/6r1WzboXKg1N0
nYGHmZ8lDGqN5VmnGmLyViMLcWWPysldghR9ONcOYCdAnudktHFiHtcJC1j4tMYWX4PZI8mKClUB
dURuK9MoOAwt8mbFO/dZtacUKLjfspYssAyOIjkS7IWHjso6W3ep9xkZ5YIeNDORti5LToYLD5Kx
901hYPpHrcjEYifLKHgja9XfvB9vDRwME6+kzjvSZUGvSsQHSZXm90EspyOTN8duycuvGFJ3o0zU
8mR9STJcdxjOXjlFSEKywfrmw6kn5R0ysJ+gWj2YC8mvlMk8bBteHwFnGhTmTse8p2UDqwUCH3Xg
sXqtEcrLv9dVJCXoz86h1WbdsNJzXXVY26LG3vlV900PT6bX5B1ebDlgSjkJ4rp3ch9dgCUcoV06
rTmbPbSqCOYxdRQ7eHxyOQ/SfujiDPZn5igYodxOcIF67j5VRYdNVRcsYJ+/NVfO3H1kobhaumDA
0gDH84VkUvsyJMoAY7GvIRx0VisHdxlM2nLsEs6ZY6duDh1iALULq83GE1DvFk3uSkU/0BCmZXbB
Ess/5fnqq1LGY6GtABwFBbpJQA1ahEPmsfkFcz+Ss1z8euQOVoDKkFsmEAaSb7eaVOYsUfLNEtS3
42GFc1XVYJUlVu7xdsFGXRJlGig1ZfMwOJXQG/6kLBpDLhQV2PO3mrjzkUsqw3rlZHQ4xoWDIYv1
NzlPkia2gpCKr9LfaO9VLUC6MRS8AG7BU+CMPilBc+LdK3eNrYkz5E4K7vOghe4uwqvRC+A/e9eg
FFzWPfYyzTAydeDwNwuYaFQzUP4cV57iI5LDdvbLu9TgMn309kuNtcZPqGo8KxggIpob8UXPJFse
VaRv8kxtxNo+BzijGqWC72ky2y/uRJ/S4Qv0tlb7ZwfZgwOl7ylGd0lttaaDVLg3NZfALCseH+RV
lv1x1Q1fAqD4Jm0Rdb4WujBSpNRkob1K83jODKNR+YRAO7c6O8zoI4OUp9MluLUVHc/0d0DLHpJW
C2TWq7StewW1q+o+pzpWmKaF0kpkq6GLTYMej4BHlmGicT+xKGJQCgXRH0SQM+/uXe5TJzEhg4vZ
DKDQpuRGsq6KSq57lk6AnMPdj42Ya2Kt+1U5D7D5DzMOhVo6kfGQZ0ZU4mO38TYfMdsEuzziBPj8
CU9xtTkXd32oTCbl4NUlE0LkXAYLqeAYuWQ1hkGVxNMYG9dt7xq3hmbhJC76ti2zYORD8J94eVvJ
jPffHkzKlh8NF4fCoUJXmG2xlaO1aO+cihDIES1mlWoG3n4g7vccS2gPE+SMA2/5vtCAx8F3wis9
2FoUxrf40KyPvHQ5rgZzTleWIyIrN4T9ypgLN4UmdKb10BrsIYNg3nwpAiL0o+q9K67/RO0GG5nd
L4cTvMk+ighyCalzQJWR/YHQOBLUNTMjeTPW6e9F9z8gvwRkvbjHYUvdHgJ7C8Z2vsqfVQ+IGLlp
6U8rNvFZgfGb4KiWnQeFtKLRxtFHn1f/WatEefNpNoB6MXxH76tIKRqM2yjtmNxOOW+tJhx8+979
dbUSY5b95TBELrLT1sZzJSFi/D+oJWlqQWn6998dlZtRGMk8gSiZc08VZ9Pc8jq3CyAOaxcWSw6+
WgwLbfEA/QISuNV4P2bi0fDIALeOuVhkJs6PROSCaH+KlBrV6WccD+o5GOD+eYCOeA4t2oAKgvx1
31zn9GwjNCUKwPvRJp8lBwbL+4/7n47M568LYLlvCt+2LE8tXtO38aOSs18u6XWkoAa8II4c8J1/
Qi0tAR8ST5+wFAEzjLUpCz8PbZNdb3cf9m4vU70WP9UAOcGk7pE5KmutYu2C8PYZsd0YOB2oiFsD
7bMM7j2/Lfay7O/axyw9Go33zOqMhvySU6Oh3OGKXMn2SUi/o6lHRt0zod9ZwLHMP4Y9v9bu5ux+
OwhcrXb5tnlwScjfVEKMZDYZeU16p+kD7FoclHZrFd5dwYp1TvaB/P8IHCtkE/jTDRo9cfj+GGJz
DIN75vVIO5c4c2dPvf37jbkp3Bn1lkHW8exER4d6btqlkJflM2D5JIDJh/Wha1A47Ja4oj9kFC3m
mjkbAMBRj8ShdxJTTdPjZgA4+1/NHWoHaJV4xwx3C8ho4e5nPV5xKOexziLTn6AnVnHsH06LZD6k
2GjMoEYVYk7O1YmpQE04L8b6fzjejD6OAF2yhfCMJB7gOaofXhoj1VKO1INJWjtjO0fGTNIQEM74
+tU4KS7HbagfWaGqc06Ofl/GUCcACreUbl4fL9fcIAbpd8GTaGVDdigum2CpYRNuKQmel5IPr/K9
S3GN6UA5ChHSI1OItw6AcKuWFvnPMwVoImNJzgaL9MiyRUudTLXslVv5OLREG4OG7YztefT9/bsx
l62ofLhEwL0zipbA+IVz20dT5/s7Ct+/OYHtK05+jUvkq+jF7sUCd39k4riz3Ovkek6e2Q8lxu4p
38WdbyjlgqR3DvmSyLQR+QIzhz/8bV/YTAdgQ6mz9MZrWATWiiHSQBeDQLpA2nlsh1X7KrRm9c/j
QsXE31T8IM03MJR74jG5b0+S4BysJlROSQQVGIR3M+wIgBC1GRqg9WyrTfY3/DeMfiZ/1yA+KWnr
R8o7+oSVCjo4ZO+YDjtjoRZ+DcDLg/8SgyTJlC8LtpqyZxGMUw6rFsozt4SLJTeAqW4tLAkOHBzl
UeNAYgTiOPWwCBcm3nAd+XUPDdiK/3I5b28mUkpjLVSZcXgxxxtNPM5wjK9TGJmL4hwttF1jm0yn
Xb+DKhMvN+pclhCasqomJIflF12k1xWmLiczA1W/xrqT/J3EaOjPNBviJqs6Ib6yfhTRU0eU3sKY
ZyhzAVNlpiR3oafQY+xp3ir8ofcJDqfE+cqIvIVn719Zns3nzKJDX2zZpbsw6Dy3lrhb4QLYFWHd
KoutNhdSsv6BkOVxscBs5N/R49K0/GXMlchUfYluNxrHr0Y2lCL0bFK9biuhmTlxsT7/7zG9zlZe
PTchRHATCQ+gcq+8rbjct0XmdWo8adY0I9iIH6vd7LcaWdWYxMnQRE/3seXYjl/u9DrAb5ezoen4
1soa/S69L7/08uCsODklfNVnRXhIgyCNj5cmnxBOgUsINVXM+8KvQKTOLw7/+zrcVArZfmjojKEJ
fnkScyDWcqJ3nMNLSu7kV7olqZWCR/ZEXOxxSSWVtlKV/LlIbvsCD5sUgLsnDFXEKnsQF9O/gVBV
KVzbu/okJO4UWI79ulOdT/iB6w5RJoFjXdOtknOeZcLy5ZAYMoDLWGqdzEfcOMleedDCVWIA5so6
8OwVfkM7D0V619tl+mft5XNGl8UQDm5GcN/dTMcXDemeFE3MjvwbCPm0T8aIokr0M77Rolpe9w1q
5WVmWdcV7L03EwcmwLTXnbT3m1YMNgw8fpnaY6vXZFDeJMxq6Noydb+Irrw9e8q3X3tE9a6ScJTb
xsmewdH3X2yzY//wxhVSbqNUc/7sldgf4/KTrB1nXUQncmo6nT+zTSaVL80wktrUTYy1cyTVbz/s
ycqaSoQy/ZB8ei04DivC+OAtFxRQlIA6LWnPCv1IxE6mK2/YSP6OFncC+/wfpGpaj9AhHVJFQEcp
KbA3Gw1shElxvsmMwg7Bw8SPuXp1Umwws5GwY9ArJQFxtCeEaVOOOrWnTBsCKEoZQe+PZ1qHPBjK
1wNdhA8TwsxCr7KfSkLn7P03EH8ucf2g1KKjPbzakwRxftnn1Bvu9xpiJvsyUrQBloy1ABiuJLTP
YRWJXSQcgygkvUKQP3rFmq5sYO8xAfzlIiI49HzcS+U61mEUKYJnQUjAX0wQ4UsGDmKk6pjd6jwe
yhBJZbxiuT52IO7bcqgtNUmIGIHinXYgvLMBlHPNpsLHsOsu19DBipbJZ9tQBHN4eN81Q73sxwa9
k/DzPsY9KzNXPg5qQHNALIMYRkLqQVYSvFmQypMLMmO+aye13Mg5s36m2f/+3Y94Qs+1e0VBpRPr
i1gRVQK3h/gi+s+z6FwoUjuGORMyGhpTPp4cb4njXGBx458hplSwRWwj45ESwK6/Sq8Ushr/SuaD
YiaZzbyN2tGmF7uAQVaWgyTmt1FM1g8GlNxBQ6+9E7FTktkNZV6eLOMFbiAhwMxqEM7fk+fz0+1o
scRjfDT5B9uNp1Bvyoi6S8ThybHbJXba366tVzUsTe3/m7x/f32sj24Arkj/nICYY5TQ4vwaFX/L
90Ul8BCgRS2rKTjOEFh8hukXWWzu4xYHm1zcA/WJbQd/c/C0fwStyl6Y9sEKoAaK45f1/n/dPyjX
oTRCA9qJkJTpySQbJ583KC+kUgg8uiROTH4Jo+ksPXbcdKKXqi+m9XU0Me8r5orcfhlRyoAiwP12
SQZgaBsKkcwAMHGxRcx2jOKaUJi7sqZzgxp6uUib2Ais/ycNxzvQstRelJxrw4i7gTSV8K+noslW
nipAFlY7EJ4OppsW9mRTFbyWB1DsxfkjofLWftynQf7oVqjLZLTZExoik4STkd6Bo0tLV0MN5Gku
aDyT2u1432f/n3RAlZ2lzWFo4BQNsE7dBJlCumfhJPp5/OGpJqDmGqn9aQYUpjsRhnKF0yvDxPX1
SZqb3ZOA9IeSddgu6M5YFv19GoryVphEzhwTgSY3+QyKOD7y6oZ/6enAxS8Bc9KBLbDlFuPrqute
72n5eu6ZvROHuXF94oiiC3lp6JXZFZx3EE9DIKeGIdyfBlPGIfljhYg2tC9NrKdhSQQdac3nu7iK
ItmQfCi0NNlKS2ZymfORFy4umZ4NeckOSJOsaPPjn2u2i2/v305kNqJ/b0JY/UBf4WpGwEv4fgvy
hNretLd8ZVsUUxQV29d33UXAfLOjjZ1fVTQY8dSmWq1FLYFFjw6VwPWgQ2F2GYJCQeJnpo9l5Svy
VZURbEoRwb/sbHSvmF38o0rfC79uoqCWr/C9tQ4Qq1NaZhsdmGqn531GNnJZ9buTXGx1RLkXmk/s
17+Qo/VDiSnYEx/n3kxDuRhwb2R6rpMvmsPvQ/Ze4WrM8dNCRjCEGPwI89KxuHwvT/Z+ZqEtrKVw
auW/vo4Y/D71orAiPV2RFHsg7W6SJpv9uqclNcXlF0VSYTry83UiXGThyDpViHY3Bq2eoDZ7eVEb
o7q8SsrhFRGYBb1AEJLnqPcD2vhwMf7w59/++fO55OFTzBeGLfMUbP/gTSgWlUWWxUebM+RY+Bpo
aRxItX6V8I80aYx0CYY24eQvr94/pkRRHu9IX+77FeyMpstlwZzVk/J/Lw9JB3iBc1f6pPh1hhsT
6/VVWhQho4j6XZVpff8Dzyq+Ir2f9ycG4CEEDOXysq1SYgubZijme10zsNc2K0oe305SvN5uxeDG
Ugjeg+MqHenOj1IbaO1yjyPC5qfWi4FQuANJOSN+E0SvNYiMJgyFABs+lILCKMYB3Rsq7DVCX+jo
EuMkibZGYtpbyN+s7J/T5O3tXTwZuL0xNUH65HxIeepZdVdXGHzVkJvoRiOeqXdtwsrs3vs74hJT
wRWBr/I2g8p2U7ySFjlf79bB4vl+sQa/y8aMxffqjNBmqUhbnb49ly0saH/9f5c4kxxShG7ngwH8
/odmepzq4LWj0jm4Ww5AHub2UgrgFnz51OsdI1AtiCYU1IndXx/Oz2StsK9EM7UeuEfVzs2dt9gk
GmgWo5dguoaJ/7bxdCva6rVCgjhfKM4ehyUxQjkl6wK3LktwbqOw2uHpzcgNI4w0BqoZeb3hGRWQ
3orkoDMHaa1xjvwIIpwPQFC0WbvOc30KT73baDjRlmK/1s7UPEfC+4gmzkbaDm8GQn24YOZ+3SOu
j51d8+QGozKAf8nRREEfuKyQs6WSegTY5/Z2vM/nDG4hS4OGN+cQpaGnS2IL0l8lUdmw/QOBbdMc
363bJbYnzrMotSgln6F5yuWv0S23ys8NLesZYcUI2YyZx9gqTapSF+7dgD1IytaIagbQdfq2oDMR
1IPo5w49yWSm2b5J7OWWB0KuGAx3F9tBV7CLX4CosOHyV6jH+eLuJ68h3m/BBLRsR0Mr37E17NZU
yb8HtYPhLPf0Xq2XDfxHZgtkhXHGdjkbAlXRws4bhVE0MN7QnwlxiTLmKfHxu0bW6ctFb48XTiha
ifeQ4Qyut8P4E9w2lCIPWJYW7nupW+/OQMs93p71mYjMaIph3tx6ZOil7BwRc0rGzf9uhUg9fq2G
pLH5NghK0yOSZKuZVKdihtvO9slY3+EUiNkODwHE/eUC7LWyHXQtjM7rpu/OYpqx1Q1aZ2kIK5hz
luhPemazDcPOzK96uiNp8mw+KTT0iMUsIyEM6vXE5Rgx6cAojiH8qM1DRyb8FIHgrciXCT9H+pXr
/pmRzO7MywQGCWB3wdqY9X39NZ30assy3vtwXG6y5bkYqc/cYkkMYsD+Jw0HCDvrlHaMQMQS0hwJ
+7N+K/zS6zbglVdwhzsPssIGYaUJglklGeYZuUNlA8wSQdsdX77Fz5BBflHLThw2dUBwGwMOBuDT
9T+otnvO4oDxzUlSqSUHLboQx8D01jR0rve/OSu8SxU0bWu0BdO+WebkuTOHwwej1fqmiVCuQU0e
HOLG4D/mrzDB7TTvyaaU+ib21zaTTZhUG7gSThhj2qaL5HGwCcL/+Hna4XmzMkvDBIbD/Tvcdz15
SZuaG7q4mMFiL8ckL/UUYziAsc9tYX8IOvLGt12j0frFbWM9+aQKnc0h5JD7ybNYBAvv+cBIaKTj
7J725IXcdfz2XDa6Su3GcsFY4v9fEaHP2rjnyRHsJbFPK6J2v+A0RSV9wIPxSiUauJ2DPtyKFieA
DmHv6pHqYEZoukx6o1luOvKzbXvX1tar1Q09ZcLzdn/BjHiwge3eAqZ+zOsZPq1bwqUptW+g0gse
+z4gmu5dCqh7KlGqyQg846lPNJRWASY0QMqIwvuj5Uebi1CkkKryj+2txTCaPKz8LI1xyb9sU/Z5
9Sc2IwnWkynK60vH6qdcCLlRAYu3gPN29qlH1Q+C2tXpDMJujEXBNzoy+b9hw83D6QYyrmESfVHw
J9oC0mn5w3MgJ0gsKdAlkEV+FlG3JxPXX7D2lfZ8u9IcL72w7Xjltwbf8vcFKNLDEtlrTqPqJJ3D
RhWDZSS6VX3Nd/xMQgYSP4qTKOZxfAjV7/muOBJHU9lOsk7KO4sddO2fzyptBQFUBoNWAWcvA5b7
NCPmfdIBhOmisDPH27bbvTX4QGs0TegHAANmLshcy0OIX7I/2E9wW3IB/NcPPE3IcOfH/SmmCd1i
xerEvRfx07c3k526B2P3qxh3Pd59/DrD16wyJVwAs7nO46jG7SdeNy/Ht2GYdEqC8aK6BfHjxsED
EWAWuefQR+Oiy07L4uZMjSxX4Bl4fCk2oRK8x2lPypMK3SNfco6ktjG59+ldyXjOXwQPVdh3osqY
RC4t0aAFr8t7l04i9UAsCcsYw2YmPbhJmNxNHtFtT6Bx9ZGTMzkaISgQ/ydSjsXzimcZYPTXWl5O
YYxwveiAxVSWV8jzIHwwu5yfFPefISKbCc1cM6TaqhjAHXBDnqsciTgyCMrK0cihpR7LhGMXDJL7
+W0O4ybJxUYIp8YujWLM5Ar2T+U9NQBsLVqz4WXVmB6kphG5tAFg4fmU9Ty0UkiXSuxUF7cvFOJi
J5Jt1YLjb3TFTd5riSnBrrTpdywhiu0939Kg74CahmlCK7m58EH5MoJJVea5Z/ePlOoqdarYtG3D
KuAA0TlY7Puy6z1LxJmJnoW4DmFTPt8YX6PcRfUKrSfPpVkNIgX/B7xhWHoeoGVRLZlVNBOh4X2M
wvP7VURt+e8DAY+jtqVaCxSnO3NtKcmWyzsyhHeM6TqaN31zMRyQJ7pkOJW7YW2KpkQsZBBBUfFN
/FHvpfAAWETgo+QdPUyqRBCK/FSL/C+QgS1k4s8xOMyBkhACKVO9kw6MsYztwtgf7jHOwlOs/tZx
yBYyLqEV/aLKTZpvSQHprkHU2Df04l0jVupx1ovN+bWXkKraYnY+KjzF/Z9gBjkTgdfKKspxA2AC
xh8XiBQsXB1vxcNut8MvZCZQcNUAzBxrjMmlW34QFIe1OaH3YJuW/fHxJwyLrC7bEceXQC9uxhpI
xpm8Gx/jbLaLOkr/90HWvlyT3Be2GGH5f7DfVGxW/Bi4jrhiKelE7xcdAbXERyqAHizHlW9NBj+i
Xjve0Kzy5Vz/kOYQ5lKhFSyo9NOjBDBLNCAJiYR8xgMmlrT6y7IaQfDea2qjGPSeoCROLz03jcov
dGbcJ4Ixp3zFeN8kH2W2sBi+HXWr6Xw7KDIm3hYEWss9Sic1xkCvIL6i7sp9XuCYHxHs20EqntlE
7BqGhM3O08uVt43dwNT/02xyH2KKjim2VgmiyMC1MPBpihDp03rwBOPyBTv98PSEDZ0vfwfpkovN
ETcsQb1IIGd49ySts9u+drmOR5HNSKw7V3C13cXq1Zyh0ZqrHid2ysdCPHsw7nd/LXch1DRjz95t
CuRO/aSHgWWzNq/zb6GF40X9ba9Hhc1c8ZKTekxjQGCLc2HWA1Roc9dPrLhCORZAfd/JpslISveK
9H4h3eKZ6jS34JF2A2BNnC96+wBRDeN/i462m8nk5AVam/SMJGdRrXc7ruvJUI8ZTOSMer2SeKRH
OoFCOAVvSuqB6M66hy+m4KW1wCKYY8aWJhPCzzQuewcRxqEB+qkRw3zD5gT7TxtgNC1sE+fQZ40M
7NsLoBiHn8yCiuA4tRArnm3KwuAY3u9wu/KBqGwHXcGAqzbE7SzYVgtMQY0ikh+qrIGyHZxIuAkw
gQNMIZHK9edRScq+SOOYXq8SO3s4aPbVL+HVv40KzJNkKPgX+lVzH+tGn/zt3rjapjd0MiJT9qTV
7vx4L10iCCoomkP6DKlQoNGQi7UomWXFg7WgBQfBrDxaP+EH15fJNrxCklN0CoWsiv0qIiqZ2P7I
u0X1d9dxSOMVNPzg13E8PqfXv/5WYs78h7OoW7Fp9TcvXKAtqkccvC18PjjED4P1qhUqrJxiJiJF
KF5apvaMQT5h0vbKluu6T9RXcFIY2GYV0XAyLbQODTwRGEVwzUBCw/n1lKW86rFyeWnQ0jEQ1G3V
ugIouIdXuy/OEtCPwacgkqfnkfV3w8YE/6PyNIxK6Bjyq/3nglXhM0U6kyFVyfqYVVCc8eCShy9r
79ShSDLFHH61vh9uEp1X4Y/K1HD+sOGmEYJLrXxMI8NwsfqUmQDcQXSvjDTf/pAJkqTTWhQGU/tc
jj+J1w0lHyvUo8TcamVD/lLNbSyuLGqblnv7y2AXutGVIYzXecocMMBWB4NovwmZzg8XvxMP8t+I
BJYXLja+2LdEGgpQqBzEtTbkQgIujw4EL0reB6j73/s7y0fndZdZSsYZ7vhw2NNNwoRhFS55w0cN
6CPXKiG/eFmQZBA3tiRrXwOqHP871MlFBDqHdLK91kEKcTLX+x/RRjHk4eoFLYbbxq68sOKfjseZ
GtUYOsseBS849eyhAhbs1K+SQeRqkoqMQgck3+3lIIpyRvq4qNK5qmI/Et54o1lZ6iUWLQ6K7i3W
+dEvzxtU6CNbA8wvNbRAzZAUMxiDqEtmpnQMQqDLVfFOePP+TJH8MkmF3qeA/Z4K1wVzB2enZjNs
oWM1qDSYJqNusQZ2vriAnY2InCgh+x0ZfEespHjtnTaGrIZUHeGBVDuA9q9xCkq/XzV9OXm3MKHM
te57uXeqkWDw7HdyAh8wEbxY/s+OmeZPOas0GJ3gMXl8BXw8yN62qUql+TLAnIW53WS3W4BThm5w
pxGduLvbVhyjtDo93rQiSQDiVyBEJ9kYPUrmaYj2hFDMnt2i0C+NeEG6D/j7JIu7v+0Q07qPH0jz
qAL73craiP7rjkSDbhoSTAXsF6P/v9TnXZslwEi2zLaNG647mgxiaUet7dstn/WzCzUHTDfUB4c/
jTPTh5Rbu2nt4Ac+ChAtxTupMAhuQO9DB3TrauaF2sIdzfQZZYjP28p5UzUnw15Tk/cfd3No/nBq
dqu3Ybe6nu5n/YFOdhdwhUOAw7WCzGNUBLkQ5N8HDg20mwN8J89YiS4aMf/RaJdW6Vr3YbQgc4a1
eugLKnpM6vcCyp36jWhQWO2nnoDr9oM/QRhhkANZsQyDfbd6mt5hGz9+/Qy1hZ+06vTsSTzROJfz
w7Y+VzLQBlzmlcbYYHxldSTxxUOUx22VsrJsPBuEIDrm4YAckSEvVRvP94Ycv7ffDLfGrlDi159V
tdqSXRVxLIx8CQpheSYlB2QeqcXb3p1aOJuB4J74iVBqANQ5MXOI3cAbI6LzJGoMnXvvviRqONRS
udc9eNpaMOFWOTmu9kQq8+yU0JZYylbWmQVuqPZNQcLWY0JHMfQTV9rrSXHoPeN26ch/8Go7xJQR
mCtZPefLUS01xWRf37JRz0dYOmRXO1W2dvYabhCUhAUSZsW41HlZTnZCEM+EL04SPUcyjaAzomDW
0q1ykRXdpxShAOCtWMIZ88kkRfjGeQuxsBi9r1DVz2Xl6F0LBt9vlxb9C2h+Dz4/OYjPPPfZcKW4
c9pFOIanomDKTHNPGOqK2HIS8Dpd3WPf4rKzvaylYlMw5RYqe0f7JdsqidsJXZnzjoa6Glzz5dTh
HGeDmLKquhpAspqgpA6ZGTQ+AJXL8HfjHCB9mxI3GH/Am2atw5khN0HcJdCY4ZAA9S36jRIsd9qe
gLyzpNzACKiUZCBg9uegnQ6JC0tVjYJ+c57iIX+ls4xAXK3jsQo+X4cxzWZzKlay2E7+pcN+hReT
4YnOWujX37nAp/gB4cM9fd9eXmJOjKzheRSD1Fgv8hYJvPZBJK9MJA5t3eah2tdHgb5q13XyjDa9
UiZ5COaoYkPJJnkynLSup0BlLuuA1/sCgO02/df2d5TsdBTFZ17hlxsakLNeQI/6Ol+JEOhTQolC
ZCut267UGdHarR39+Aco5TRZ2nRxtRg9Q7iJ1PftLZzdQpT2XBQd7muhvxTRC62jrYcZJAe9K1J/
1M0nfPKhWeS7GzjX8S9kWIG40ZkpanAtGl1D7OztfyLjVs/AghGEbJD+n/cRSkgYu+HlSNtUrPTm
CzFSkHdoAxLEyEuyUZvwxuABnTW6aUSNd4ec9bR2VBUcM9gcjCWG9Ui1RUSrsLkQxOAlM/5g8blr
0joADJAV2N1cNabSFoG6sNtVk7DNUIvEKhbQnLjAwHGRnQlYJMHSvNWn11QlN7m/BxMglvhm3+qT
Zcj0q/8hRXhIRd6Hr+y1TXZsFFqf9aiSZ9JD+VsN2skgo4A48ZFwAOxiB2Xt5TpeuiZcVM9ZQiLM
4kpuergqQec92bg2YVsga7fCvq+JiU70+hgoqFPIfKKUtq1e6zqF+1RqClsOZncLKPqfeQaTpRnb
oMKEBDZhxcoGD9+Z5KjdChWrTqQExDJXMJMWcQ6AJBkTw6porlSPoaT+9jAPnP0G5wRjQjaRXHyy
NBYviGV850uZBxRM6aCcizefMGAQDwyrJ0ms0iWZK3IhsWgufG9u25fDznJpVOR/F3N2QnWVADCE
2146ZK1GU1uyqd5Q77v75jAgWxKjiHewSht2oe7ob3bCw1cWJ7r9b0Tjd9FceFxW5tdGpk5ocxKi
hhNFlgmr9U1lwQ9Prol5lEPcfMsIBcHrT2AmJh/4Fk/m0oPp680kOeuWmL8QVTKKnbNzJRakePhs
bkhWXw+/VhiaJKFqLqrTlBtsWYbvRu8a5rMgXGcA8J6U5BjOu6KhZo4p+Byqsf5YB3Np9VnXNT7k
ASLqUcfHC9moYzZzRVVXjNyo+rVSePbtCzv66sg6Y6gV9EGWs6AmdqElh/Pd8fBaer9APHMFp9yQ
NRaFBgFHN+TNxFIA91xINXqgRanYBAeIHqe0+w1oAZ/4WKDcguuAyRnJoR/fnBiaLUrAqzmHzfDd
uSKxdXRMJL4+62Q7mdQHeXKjqsYaUV+IzurBlCzfadPn4JPwsVHGnuoTrQdiKXowQOK49DK/RS4u
kuC4TFA4cAe1dROipwWqTp4jHsnO47XVP5udasFy0fDmGo5Q+JeOGtK4Zox04AE+PP8aJrs/Gjgx
ynetjT7dnsjNXAmYO9hBxLJ5TELzhjp4XyFUfbF05I8S6j6TtmrAngEqDJ8tgcgSYwsOOFm7hDRe
Ks4U7kB9Qsfe/WHHcA5yjXOhYiwIRknVdIE3p7ChJnUQ0q5eKsRWIa6Pngb8/zUyCpyqLyaKc+Hm
XDpdGkmqmT4fkrsAteZtAOizBLY8E/+Ptb1tnHHew3p3kYBFRdleZt1XNgsmWNFrmkCunsnFo4fr
D10zqJa5fW/6IG5nqMdLsvDwNAPDfngKdeTa5aPSVB+hscekjfkxYitAra+y8GcXflClOp0XHKYg
yk27HK3toI6CsSjWtTCFroj4mTH/RNIBJ5bOgrt2Mjpk1ziVoZFiOnEMazn0eYO0dC/6ezGFAeb2
UlnoYE/h9xxTzmshR4me/fphG8tL0Vs8ArlBP1AUr7lzNGF62YxQzS3xtR1Ka1NcidsSyh0Yy06C
HxNeDsSiYZvMGBG9Dpq1ZGgY0dEb8X4I3/YfZLJp4WiafV1UM9rk4gHF0Qv5KHKggnkO9iX2/uTC
+q6260cSw1YpxAfUEKdMZhsuXOtNBxIR9Zma6vfGI0weezVuBoITEOw3qz6XX01pnZMaCohykmGO
ex+d7F604zjzrageFYkz90EJtCjpFRF8JEf/RvhBbx3DDPZ3WMStdrfsnNhduRVD3Ck92hqlm2ZU
/b6BrkYc+poHxz5TY3CyPXUNGH05v6iCXbcsepkBYvB1+JrCfrztJ7fhLRuckKZyquXla3mABi4S
MfFfYZ/lWFNUnWGIDDaT8K/Ui+s+Tuxc/l9wOAiQck+vamOdcO36PWtZbA6VhWFpdoo9UytzKQ1R
ylmRPJNonJZ38wCWiVfpi5K693CGeERf8K5dOyK7ej/sLenNKbhlnwyyigKG7z6GYdV0cT0wUyn4
JLV/euq2l/fMy3dPXbRz89MjVfRr0kr5BU+2TGGHGb2FwrpgDHZMGE9RJ8rPrnaR4ioK0lqljDdd
j0amy1zeM+n7mMjYScLv6uPL5hbOGRdFDQLgM7e93dWBVw9GDq63KbuXUzWNxioDazAs6az0lQs2
Y5wWk24wDjN5NTVffuMrlqVMXPBvTbh0BxRUNXreSMRI7Szb4Hpe4ZFysYqDxm65GqgMr/Gxfl3S
irO/6iwObjzns6CgpFnR+hUfBQD5ktAdVTY1xw+2vLVQg797K3fchmzwVYv9DLj8JgCiJmwsk2j5
9TyCI/kAoVgkJL/oAuuW9q/35GaAs+WSg9b0rd+7bdcguE5q4rBFWnxOJ3h3rfDAwjdG+3Q/kV4q
M1vzsR4B8u5sMIsLSyzzEjWTHXLCh0sClXdI0Pl3et+mnAprtAFEnX42Obi2kYgSP9brYQBABQQL
bAu1qBjc3em/FtV3lRmn+YgQQUXTxJfXjOJbBq8zQbILqDtOwTLhnzXHf/oTYC/BdXli7pg7EAy2
OiLiyzVJFGvIN4LMgG41DCrO9gFMjluJv7rhZzj5xLW3TnUYWcpCmgl97NXO7wD0Vd6p2IEyKOb5
or2LTdMRr94vRsqwQ18VswHUg8+/uqh9iNLjaNxc6xE15W6wjV4aqTKNLo4ovUG1c0pvUunMiXB4
lfUOktBWh1MvehzO3U1M36TB0DEuhsjJizYaT1UHcJl2k+gfnfAhiz3W/v8pCnHsIBJ+7svqNj/d
CFC/sEX/TlnvAcvQ2zR2GEi3qy8t598euSMbj7h+9CMs1l6cCy2qSFejgK7mPGSBBliTu/Sw4bKi
yVhqKcY2aeXG0JrUSgxAUEmOIwWdwKJjno9/VgNl6ipL5dlXS1K6h4EgJsxT8g6zH5YljYCEGvdB
SCF+PIftC93LMhkg+WLIljbwLFGE4bgAhVhuNGXeW9543TgdyKp9qV8/2G8T3tHhPf5iQqY/wgAz
kfITXCN8EaRNvasYt5KiYPDK+9qyb7T9X8lLjmuyzqHgg6gIIChdtWvcO3taB05/ea2oZ4l3rW/z
iyylIcipMLGPJu0/HdlHrW7F228ES/PVnnR0MmLRnpHN9FEm5sO54SAYsNi5ICA80XdHlRk3Oft2
DCKAVxy6GO7s+ZMoc+iYeayWJgNmOQndqmSUzL/8WGFBxuOJmKY+ePORanJFTowfgM4ShyXAmg5i
pY8yZPn6cKGY7HJR0IHJH1njTiFz9SR8ukDLQtgDYtNmAAorownZPTFKTUMhI5R0NEtk/aQA5EQq
/SeTQ+bvPaOUK5oizHysuUSU+nP5lNjlKu0lx196E+wcVBxrs7YWVtUWItqJLEXDZl2mcXxGGMBF
gyAcy5CjqGkMLSI1Bj9FgO89234U73djngcPTR4NgL/Y6MLhAynHni6EOG4cr5Lj3EjLb+8f3FUe
9m+Lh5C6lnzOxC2oHIh7fmhrlMwVp3c9+scKt6tATw/KOeuwIxT/jBqqcSlWZwEtTYZECfwxxf30
6exQIAVjKNlr/wc7N1/7e+hei87stEzBBOqeOF/42Hg9YcwSZ3ih12SbX4CZOQQFH8cjtfZ01yQk
6rBm36nUrebm3ENjcLa4P0we2MngS7ttLjDwnGq86JExO/H9tEQfhUxF4J8gJMULyOGhP35ix9l1
RgzseAfdA5zqtMb/S/pwIUiGYqkU9FEzqliBp10fP5ImAVHnIbvxJQmFPDhEzhAODYSixU24OWJC
8afU1v3U30sFGt7KqMR7ERWC3U+3wY0WhvqjI7qUlzbQ2AJ28RfOOHXG/JzN3eADVY9pjBAKEPMZ
gFzEVJx8TWahyAHArVeoH7hbFaydmLkgd7/VNpynjbrEDftgkIkZn+YR+BNlT1qncc10R1mswz2S
JJV/gy6YhhXyumZgGQ+a23PVVPv3xQCxefN+sY5hurdlhZ6mfGqmZkJ2JTuktmjiY1wULtvQMhwY
oJJC/9w2RUms3MhA23RcS4/uVaMTkuujlQoMKnWPYa8Qv14b10IhfMsWtNd+kryDp9THwX+xcYTX
S8wznV/w49L20uooHT2SCcXmu50eENgIPoxBNsVxAKHLsAjHXfRmXKPCLmAenUCLvqzxsDnV9Ow5
ZtSAZs6syuigDUn5w8UgpglI5xy5s44Jm3yzSiQ3KkLSwPuRv65FQmuUUnsfcuSW8O5iLNIEHBQi
+mjeBl9L1RwbVylqxsjAre/a0T/1hw15t09g+mbLf5Tw30ZKrpn7CeoQy2TuK3kIlsupNLTSI97g
AgEqQdccMSJUMCLFgeLZzjriWqIXkdcrDVQuBK/dcd7u4cjZ4D1HjAqrVsr0K2S30nchByTWB0q3
DeAPK6vXkaF60YDKNQDalIMV6N0sdY2CSatzZpmjC1t+T53mhDouI5sLL9WKb10xXRRjk1TJ22Ks
TvEoR0EPG48NN2cbmveLeoDHRot8n/CluHYWBzHd87J6JjPaZMiLmq5Ec6YtgwFFiCZxGNvWUO46
li7dZHTEDDj/Tezvd7zWaE6PJKTtFQ2Dm1CMOQuimrcbIF97nAqPzuk9c6NXLCAo63eJ41nNLHfo
AuVEZtzYV+mdhoX1YESXbJMlJekaJXRso+3WjJx/6JGfjvtg7QeUH6sw6DuCwSKuZY7dV7jjKkGK
pqaVMu+LGrFqPknQY2vAeQhR0yvHvrfbz+XEzKoLRTO5F/muvWXS8CoOLQYyXHqJoQIUeH1pnrMf
D/k+xiSjXkLI04idQ1ZfoZWUvHuiACdSQl32q8P8Y9sjNJyLqgy3pA5oTsTavWgT7vM4eNfQmqWq
q2CWbX/drAE7GdjJR+KPNWmKfqcyM3BkvhhnEcJP356l6B4gtQt2DVVpepduIU+k1eX2B6t9VCCn
euYE/B0cB6/6bfMA3XJYCUVyVAgMIX5vZ0686ZHaYu0vjMjN9Mku6c/K+mP/vYv805JxPd30ChTa
fRNZYhIiCkD4Wt7Kki7KYvab+9wAFAwG2KCZtWB+1v2Gk3uOvC68btgkRYkhFV9AQCs8tLjwEpf/
jcu8rrjyVYZy76eTjnTbkJgo8WJtflahWaMEyEcczoBaiKqpVeHNrbxAxr7T3CLaHQdD5yeh2xpZ
XGRkDFRJVPG/EF2GulYlSjFugykQnMtgsHzMCJvDpAeSMiyhaFulKj3TyBYUq7PZYFneF+c+lvNl
GUR+8bXIIaa2vz17FOKkz5HzOBSgbsaKc05CKQsdw5gr/ZLHaMNeDSZS3TB//r0dtBpwd/KEzjob
AdqAYuw+CR7QwRwgO/zYishpQxJGJjJ0z/PaK/DVuURJbZKWQoT1oy7sWJWrmdeT7RxcADB3Pe1U
jbnyBJK342ac251p3MIH4buExf/L42HrkNBaNRSOp4SzInDELmLBemuFQkvcxiDyBUFAK8z6tIph
obMHLz1UHOuYAwKXKbnY76rQj8Lx3vfLImD7fGdO6JQtiRBbf80EvlI8RN0TKUCZJ1qba4VZQGmJ
zBfkW+IvB99VRtVw7TNaJqIcPrz/Z3c6xbxncW9ApoleyQ1Ocm+FT77dDSzBXWGPveNUZH2Y43z3
zIWEyXdFcw8CJrDzpgMfj3dXo0moSE3+BNxtd/ZEAnY1gyBm6oD5U+kxpCdHa9YYqewF9QGCzsU0
P8skqGi95wILzU5SizoQFg2s9e54z/7StirdUzDGc7se6lwTwbIJeKfgjzoGTzf6QmHFAjmGcJZm
3jfr4ImNake03J4Gduwek5tltLrzdVHOu739ZfyofkMMbYAP2gfnpkSfrtKaMHrLGECxffqINXod
XwSAMqoyqMsMVfx4A1zW9JTlGSs9N2a7BxFgK0kHYSfU0XFHVC5Z6lwa3Xy06zp9xyU4apTFE21P
GgpgWkBV93cCtD0z1ObdgJM4nSa5V+NQ58bZm7AVOjyrOJ3XJOLIH1z6oAptD17TeVjxtWDxkEhP
CgxOvoH8zTdVynGhZZJVud4v2GceFm2aUoKfeeSZU7/TUJW+HmC/yo/ZY5fHH7TtF7vVLG7X4jm5
Qmmnq6sDJsxnVY/8Gj3D1968Rib0nfRQit/Cb0BxG/Vb6ivBTtHHPkOe8WuKzrRSwYoLoQ3faY2l
q3sjiHxncxVYXSkztDNM5XGxeYTWISBnvZ5CdRn6AjvNqOgREcDPJDUF+aGNe+eer0x5K5jHBeZU
JD2tbtNbCe3qYpIZFbLTco3OPZ565JlEFlq2l2ibVe9WMj5OT9HTOr9cjs5qIQm1YKrwR/TDwcN6
1/ewPi5l1nlFGUNvME34Ffo4YKY49YcX+cRvuYxE/f99XpdKPXaN1QqEuHJx+W7ZKpot2n7MW5fx
DDuIsMuZRSxKANd6W5e6+BRAToUVeOT3bgxhGBbO7M1WjKku6ivsthXsQsj/zsxEhRTq0XiFThEQ
LfJwwQPyCk5Xli3SVVMLC+DJRwEqirJvAekdaO9sdR/G1j3pRVxAEDYxr4MjdfrHHbw/F1flQA2I
JGP1whQefv+F//qG9ZLMiWa5Kg27s+HIZCJkVRNvoCd9i6l/8VRjKXDcuFt92TDN+ZVWfCvGv6KB
6lXyyANuLVuqXQgFRjggB6c4IUIPE9hBBpd+KOa+uGuYrAN8cW7dnmlAHWL3W0kpATD9SvR8PjFb
Ono7X2DBjTtJ2OGoQLnBKNKhFVc+FCX0v62/DCQ6Wr2XlwIJocAUmYNCBuoV0B5l0xVo0kao/DC4
NidzQxQ7lAMt2j1QOaFMNAUHY/9d4s0R+bB9d2wFO1sfqm8cUWiWRUQw1lwabtiB/8eN9MVXG4um
QmoC074H0QdDi1J0Yvo2OrhqCwGbumDnkvOhwBnJIy8qgRMDKtuKySJP+ogAZ7ljBMmboDl0fTXc
nnqp5qIbkTf6MxUjOF6GyW32r9YYUdKEqaLB2MnnRz0jpd0q18X0DCg5xjfAVtesJBuQhG2BYPjo
pAtm5Qrvlz8LMlhjHD4evyDtscAJARlliRLL0TMMbwuDxd1QF4DTnCV/ihdDN/pipoMTCHqXnQo2
TVTZL75IIwpfGY4XpZKYzg/ExFEtqzos4TWASiKXM3bES3LxSbzEeLSBAziyhEYJYGohIkmHQzdO
iOV/X6gkgTtd3WunNEZQxgxqu5nlt5b8eAMIqLrURtR46buZZ1Q5wm2oZV27WVNsK9pYO8e+X6pN
MMHwUZL0o59JpG1907mkM+NNuqPVQJzs67t5TNw9vDKRiyhrzIypqzBBgGEaPKeCAM4k1OwOS32m
Uj2H8J2KzT8+3Slw5klAswXWmm/KrdsmAmaPqcrO3BdeBod08rT/Dt6QkSeHUjiyH2kRpZ+qPkIM
c8cJkDKx/NENos7lkB8xUDQOjOp+1UCAh6FIXal4+fv5og3lg1b+H+s2EYlCIkUyYt3VGSppv0wU
P3lB7WryJIn5ldnej7/gtgI0o5nkIH6dflQzWAjaupnZxZDXXdGQLK6+5oSNLqx54q89wLfQccx8
HmwPHKhxIBALnyEALXAAxTYsXU9JpMYQIv1Q2d+AdmC/dNvyk3w9O5HSR96mhWbcSn8szL2043mP
7/E/pQ68c/NbtOkKwnA1SNh7zg1/ONI9MWds6xJ525OEU/q8CLyW0HwA0EfMfg5pGrFRjdpg0N/I
Jl9StrHbNaKJ8BM6mkm+VMmXut9V1xv7j86jKKDbL8piqZAIiBaM1vN7JwpA4siM0uHqUKEbrUFt
xSK3JxEt1DATbsOf+UIRn7qr57tj2e8ZS0UzQRNW13FVeuf9EOMOA5bg9WL5imU08uEH3HkS3FIe
7A/pQXOMMtuJZYPiYigSAfrkKB7i61NW0OjS7Cm5wfNRYT45AS+j+Da5MWK5AH/wga1MfWu2b5PF
23PiNWFFmxFzu4eU2NEFsWE/8EzlXWp81eKuojuz+N4ckXvICue1IwA69PpcntHIJ/RCwkF9s9o8
2WJDCBmunHf52dbXJvJfVB3lBIm6UxDZevW8LGaWsxXpJTO0tGXLg/wZEu0vgciGiUdrNYaY0+4C
RB2O7IXMeUCkVzgr8jnc0Ns6bIEV66BpYoIa7V3qz/zYZkTFyi2wJ3T1c6FcFH0jN1sbuP6otnfd
8meVh5wlSuJS7C1OaDveRJ30G1aYAXNcPn7W1h/hJ489cF5szdffzI4dtJNS1i5kn0XKv4XzfLuH
8IRfltDsqPXxLd32ESJ+pRD6P/+U/plcK4AKO90TSy2AeUHsDT9PAgXjS2M2GlnbKl7F3PgcKwaa
5OOptHNo3zs4SlMkelDAgAFRIRicDiy4+XyDAR6RMwsQIkyPWQ+OpwZXm5HLu39avsM3y+PdifiL
/oHqlHisMTScQ6qM/HOD5+PLRP3drRS3K7F8KKMyXyuijKRnPSg057Wm66IvwE46NdHHo7JmLm2h
1ZcoiVKZS4MNm4m/qr6a8p2pN/X9fDbdBBIdxxDSSG3MfRDsEeEKIHqVZv3mSoXQOKagUs3F/QUb
fVe0tz/qWdda7ZaEESYxrr0ADQ9emjsJr9pmbiHIJvsyv7wQTRxsilTIn0PiDXMwt9jtEzWqEqaS
q0F9pdtPD5kRCFfrgJcqg+Q/2hUIxNq3fZJ40l5I2pvKF6sm7fWieRHlwB5f3feWH4/fcPgyVvoZ
MlvEK64nKTDbOVh1eY1d9HIqKCgoT1EZ1I+THx2tcMYx/9bvqhr3OyoopTq7WG5EWyWUXbI3gcuh
6wZhZQPbH4jMDPSx7YnJwX1Sbs/S462pvZBAFf33ylVrQV9+AFJeibjhleFeobaFQK7fjjtgT6wO
IJLojt2YAa+yC/VHbIdGHJQfv52zuEf4RrA2StJEXvqYQzZiXR1NrIDBGik+NvEv/xg/JjTbL4dg
Z+S76xNO3wXft7Bih1l0JNqPb49829VNFOvEVuLfOgZqj43T6GdRZAfGjmrhj68s9qoKHAqU7yky
yETIV+rE3fqhBxugELOU1yJ/jiRHRI59ZGwCerVbmbdTkk8ezC1/t61tQHEa8goiBFB2nGwLN6CX
WJccrqZYq9HzwdwEiFlVk15EDPzl5I7Fw4UFuL00uvLPYHEpqxJgDTUc+0SBzjWYYJhKj8kbJpSp
N/tp2hkyk7XEGojD/Qa//VSbxeqGmLVts2+jeo5undseCcrR1CmZvyI04dSKvQoY3+QBLP4sfUG6
eVR6b9q+Qc4TN10sdWBXcNjUjJ09n7rDV0eA2xfnT2s1SIJCQPSEGpLqp07oqYLJt8hLf3hy8lea
RpGI7bK5Jpe7DLO1TYrf98ZL7AhkK1Ek4C1flLzevWVQTlgHabtlKHjUo+I1vUoQh/vuf/f3h7Ir
wkFfjqJFXJuIaSyGQPm4b8SWUAWcLRwV6GpC3zU7bn/q0Okb/ufXVaw7+WmjeRTRHzmJYhWzJMBT
P2meRut3eA7tNceVhyVY+WPa9mwQ5UizckYbssGwOYwqjt4Z3ZED5OONfmLh1BzV8s7zytHiTpSB
bfjSFQVMQycluW/IHU74wylbfC260r2cVfCEUrTkGB98dlDD3NGt3ZB+2+OoAC7bZhG6EKd/X5ZU
L1w2IL+nNkopJhg1GnNWDduz9gDN/GBMHN3lSGevoR8P6XrBEL6Vi9aW9j2zkWXWIW8DCmtIh4lw
ky3UK7kSakZmDkL4kfmMfr4XXvtlE3wPhCVHxqo6pnwa0wCYc5OOTgU20kkAcN4la+1H6P1UY4lD
ebPbwpNWZqn59Nq6vnZihTJ+z9Vw7s2UwpRz3I9BXpJ5aZs4HRFHQfWyH8Y4DZgo38aDhB0WC/RP
Uf7wBr84+jpPOKTkQd8T0p9JdCed+ZAvXGp5OqnMDl7GS4NX/d4IY9zQOfetyDLPQS5NRhYbSwjt
/Oyt0iKFEg6n/nD3teviN+oWSAO6CYK/9ySYvoMswKS/wBxtnBEpapyzblyFndwfWC+IgzkBUGgU
PzbI38p6s5V3HJPnfVULNBxYdL6akXl91ZfK50dAL9IQ4xeWos89Su3cjNPDM3AfaZ5fIlfQh8XB
pRFM+XxPE11whXl3iM3v3/SlLcb8R3oKFX3rczJBjrzQ1f5YyFUgaWFLFqf357R/jbGDVC1qoGxB
md2pFT3U1Tqe5YKCOOz/6IZw4+Sfe9B/X9cA/Xt2eJeV80W2ytfgYHq32rRRdekQRrRtOS/0g0nm
M3mztJXoStICY9+oHHK9uB1hFEISpTWMHdG0vKiXkv/8mvO0411brua10QHuG49kb4nmPu1VWr9H
Cd5dYdZFYGzJTP8P5h2uEdBtne/ikqzDjJMUrTMbydTVVkMma27cG2RzCZr4Xe8yyN3MlzpDXR9T
4XMqXcF9Q5OcFQz3h3Iho0Mqfqqi6KQ+iHDdKuxhbIAo2vcVIOGx2FSa1NZKsJQLXQW1uycyKnZa
TgSV0gP2o7PHLM2w4Dj/K/as7ZJrCvPo6tGp3H+715gYrpufb+qPWAW7kWH/luiNHm5iXecSZcDl
fF81dlPOocYLZv9Br/LtYxTygMydUHUxU5oCb6Ea9Wx8+2NOxu8GQ/rOKW3vzwviCK0H7MWStAo2
TpBxTuBy2VN0QxHNHy7KfimjObChA9IpYecSM/eG/qO8s01yDw3ocI0fTlrc1Ce0f/ZMX6KnQxxC
5cGHiQeJm2ee8N2C3g7b24+2CaweYR7lU7RyKFEGWGhFCkbZLxHYTkxewcTv/B7e8pQqLlllgZqe
xFBh29E7fZUbvqIwTQ+5+Zn1/YXIHqRpXBtd9ooV7kksW6x6U4mBsCVEXdWjhL5hWFYkzwKe3KzM
B5Ab3+oo6NAII/Dc5ABpJMLWPrqAroR34Pk9I2mZcXdMIHTZ0IAKeqmFgiX982KHBb3T1L1rJ73P
xAKy0LejnMN5zEX1C9q1WE0NYlQxGpuLdLJA5eSmy4O1Zl3zJpf5QLDgscQ/YF9HVTdTDO8DATiE
RuF4XXidSOV0iNiqPALrS8fOVBP/ePYHw1wwp5fIYH2VD2t3kzr6xAYxTaWNebP5sG6YSGod2mzp
9izay7Qs8qFdXrmA7coz1sgJeW7JdiVwQIRJNI/97JCZpMJr2hqQxodIsUhhmVM2hrLnuam4jf8y
7trukZZ//g2DGhNLKEY1shYX3/P7O/WkmZCZX9G/4oMPQbk/8BbXSAGSuw/rUymTFAFSik5Z5c/C
plPOzxXhsyv/hJC72RccsIdSthmaKyzvmqkNATXg2cPHTNYoMKdo8k+168WYv1vuohc1TPieQ4rj
OylwDdLn9fH96WWPX0dfGpoiQdwA3MkT19+4a2YR9/aK5LyBkcjxIHF3PUa6FCeL/cDGsZFpM8u5
UiDD5kz1ZXdApH1QANGza/20yM10zdaXYHf+3YhXfShaP3dA7kLMuifWUmtQvaYkh1jEFd4FuXJa
WVM4DuxWT4bGu4jZiuoXA6EhHMDM7cCOVx9jQTes8EShoOhw90J8Hhw4COmvBQp8VKq014zoD/s8
T31QDSh/xn8hz2J3GXhcefQjI3sRYEJMIaShfg1Nu/vd3IYyOouqWbKNIcSy78OBa43pz2twEkbn
lbvYSW101NkJUFMtIysZkw50UFTivwglEKu1iLMMCbZHb7iGkyQtZ4t8LAZOy4G37+pdmnmsivls
vu6eYwYeo5RKdHcy4P/mpy3P9diYmLphOCb3MLLipsldkaRKGpNRWzq9U6XgxtW8y7Hj7kHPLLzf
w51tZxJ1FAiyJX1B/BtzzmDm/tz5DsTMDSzzL0IdUKbw9zjCPwVlY6gUQaNxXeZGqQ3xwPgLc4hc
PtujO/jYMcetVC7zS44PRWoQRKsbLkf0lUGNP1Ak1QjSZqq25eSoGAXgKxHMRIktooSSFa0GZUCk
rTkNLy/p2XZwZSqT7nh5EBZ2HDyppnQFatN32S42dQVe3IkTH6/5gz25ehgCIzuc36NgAq2yGdQK
DMm2bK5M/j1Ll21M7ZsckkTyPxm1G/Yd84PnaSMwMrj2+I6H8Fb7jCiTMT25Wq1Yv9V8OutPmIJo
IvF16A0YuoKHo65ahi44kbHabKqef4HR1H+F5ayTPvc7H1Uos+LvSWgyDgJuXMPHpwtycJFBwWf/
StTNsk1Tn1+6P0LT21zDseSR8FJrAvOkVtRbfLmmVC067uQ8MLyV4v7StvV7xEPudNCNUpJjtvuA
cydONJWoe9Iy9VVdDMkdQn1D84yyLgN0JjUKwEnFEP2SEb3XAmx90pWw3GA7Q7U1EE6WI6u9V2K1
X4/U71c5ccixybI7avsWn172HcsmGzuY1K85Qtw2dFjpIKV+DWCfupL7eDPZzEWDSnNMiWZLnthi
Omlp5oV5OGHcBAUO6vIpdZ9vSozfUoFJx6G0G0mlDp1FBOLA4wPsMZAJLdobZ/j8cGvYJ5scE1hB
VOUSzUxQFlnTCD4TKUPYLulpDkCdC8kicKB6a4bnnaW2xDpQ5VUjr6er1flxuUI1eC6emPfkCXBq
cHbn3iroTZT4s3ISEQ76Kpc2pPX9N/XsRRaqC+MEgLh8RFRqpfx7s1U3Ue8sEPOHTtFrn4OL1HH9
2DiqyVd9t0wOkmg4o8ayGi3Pi2LK46XANSSXaYJiqSBWs4MVgkVuEwKr/+4D2PIR5M98madAaW4g
FdlbUEYA/vTV+ytos285lPMQVMwEKluPVTdV9HcJ6Biq611eITJOH1G5oKU8B9/J6AmiP1o8EXA0
/NgG9ReyPqMLUAuoH9IwYlIOTTYR+MRXvNnP2WsKnnKhZPeEbdF45fPKzRQMB3+3KN5Of7f7xIb8
7YhoNzlYQMFTICcCErTPx5/6Z5/qYVg1Zv1QeiwZz3HxLyqdRnI9hCJwEKIQHM6Wjo3XhB43OAyc
cvjcVJabZMsww+cKmMBLoDTkDmoWcobQ0uBFDeJ6dsKfEYfZscfly/olPLwKhzvIgHXcoimfjE5h
72MhXlpQoHDk2uJa8bTUOlNGF0aAGW7k+5BgmmwYwOh6we+Atl3ftt0f8tUFBP+3LQtRwmY/6TKz
kLSoxSLuRC9M0ql2J6av4Uh5gOIHSLBrr3UW98zxluI2w0NIOph6HsE4Jrht7XB506nTDtaje5Bi
bYjaal24Fgi9JegupACPjwQew3SqOwe6szu7CNbRSwg26NKGYZ04fmi4QgX9GxvvRBh18+X2Ty5y
Kvk7MoGqROGN0dShKTs/86x2lZBCnE0oOj22yA3DsEhEnxlyxqHnLxFuhrN1+7mSjImcZQfUnU2t
4iATTcPxKw50sAQ3svMNjhNb6aRnBsa8HyiS3fc2sfROS04kP8cdpc5IwtE517AovwPhzqiPzK2z
EiLWEoboR0D6kEaVUvE4eSaowUfIZc9XhVizJ2bhEBIqdx3L73TJ73m8b6I2CN1902BCYQnFjrU1
ONtxbWvB8Ll5VU/m/t1FYHbefdjYias9/ZcUb3a7vObxpw9lCjoIZCLTKL71xRqdX71Cfic/5pCX
H2LuSONlyE+J3nX0pG84FrUM7OdlZVKgwFSiZafhI3YToe9GywdZ+jC92fht3EMIeTDko603X5Sl
pPeyR2TDFMu27nhjXT4q7CWR8uCeg/056jx6t6/YV73M/0zpGoGSFbxCn+q/GZMnUCkBJRKftD1h
EGReQTOkBf7u4Clk+TYa6W9EvdUAfjBju1K3A8ZnaEeEn4SurxgoBdp5+4t6zLHTDpV2w1hGOd97
nWkRxyg3g1Zi2BVnYZvVAs3EpoxNWTkW30b14/Icu+eTdLqWcdTATs1KUsc4HHMqfzw3BVDy8XpU
idF0f9rLHecImULs84+JYw09EmvxW4RdSz4ZBGnOlKpThPNBIw2mU30uV2ohGqU9V0JwPJk2H8Vs
Yo/pNPPihYTU9JFof+xiitwNe/bu+dfl1A8W9NWUCvSZMj9Gw7YjUoT6ihlIJPA4aTEGXg09vC1c
oOwAlKxKYXyF+VSU/UcM2tS2syQFrJlGlDeamk6qOiR6qL5pYn+WDzOvk+RDKyc3LK0tpveD9Agw
2eEMmG+kYu/OBenNy+Rb9NQEa2AuJFqSVvn9DD6asMsySWMDdHNir3juWWXZhLXMFTWAS5U/1MXp
w3zXDiq7gD42OrQDHhcsSiM0ewOHVLu4oNdlXy3OEKnvEzo2P7G74+pLnKcjuEGQADct+1bhVzbs
MF3A8/GNVbR6xo5dpF4v/xniTvR5UT2sj5Ib3KasAWwSpHUOHSGjwx6KE+DRAJmJmVfgkuKjbUle
rq9J/E0OUcI5Ujbo+1YZUssk+BrKXjihswmkHfqDVncagRYaWOWrLocErmMhArG9/SqfTmQQl6w+
rj6Iks5GLwWwPStbIEBZ0fi1i0S2ThGPWffPXFGGbW/3A0MxpxQQ9K7SWv3lKV73DiZErLZPDgfk
U37jd7b7e3p6IO3WVuHnm14x/rEuXxjtP4pJdeDl/LMUBO2+gEWSIKwMPhGPLrMDuh6dgvN4nbUY
2AavpgOATLp/z7qPf9EkkeC6leoYfB8ed+fHx5aOgwHIOco1+TReh3VGFe2UzshAGOKYzzFF0q3E
7Fx1B48HkqNX46atoKATu2TcA/0b89DCLeRXsXrGxAY8MfAYayAS1Bfg55j84vFMNd3kUqjZZX9J
YwIzRuSsnsdyygwvSNSwei0IFRjIvTL/mUhcyp3AA/qiKGR1mYR48h591A4wanl5TWOZtwAbUV7k
TgIFzw/F4RtIBN0L2VuUUhWCTivCILcKiLSe3cj4zngF/fSoOtaFFgf2imupZxuFi4P5T2/C3uc2
TC5ut+Nv9o3N9oX32eYMwN06k4lP6sexKrUr/dClyQqTnezot/isQB49QdN0SCKXxIxe52Yr2q0A
hUhMWLK0OZ1NM1nNHdV5YNhk5korpYWtX1mL1w18jEohCONn/uu5IcdyXre91fLDbyaviQT4+OO0
0CPKr6gP5lREowTErUKYVGW9NGvaKO4cdLWhz7DqDwgKvaeT2ZiuErckUsi9X1kqVOcsRV8l25xo
dYOcbrBvxOR4xhcAUjFzH8eFHYkSZiVuxYyScvu8sxI66CXS5DnYICduyIOdi4NWSiB4XTncK4xP
uLOuZGhuMt4rvMVcxxatatZ/wQV9357k0gX4ZqPmN1OVx7l8KMOuaRabT70z5B49ZbJ0TLsdI0ep
w8PnhVgDWAdsccuabUOs1qcxQM854jGGFsX2uuYPlx4CVkOjAygnaBQ5UUGouAYNCTAcSI1mWUOB
PVaUDzYAYB/qPVTKLcvvF5J64RFqytDTkmByWw8ajupkbdv2VQmeYn6DKSu+yJuvvVcJdvzhlkeC
ZdnZ5U6xhjo5RoMDteuWRcwOCFCdWjuhXwWENa6VpfESO0EeDwJlMiRe9+AmZB0z171nd0GekvvX
J5Ta6FY2CvBZ0l1gQHJ6ETY8snEM5hvV/+ikFkDnne5ytJ+KB5ngHHR3tXo3KkZumdoLrJBhz7hC
wEmSMdj6NuQiwSdBLvjRDYtfBZnGSrvihxTZdWWLtZAsK3quEeqWEGMmDvSaPIPIPjwN3tsERuux
h8pgZTluW/rrVu+I9m9F3WhQl2hl41WdgitvSFjBy17E1SnN8clMEhS5kG593jSv3oMn+VkoMHOZ
8tIVCu6jVyrNLOicmmDC//oK8pTGHYhxZdhuSiMRq101Fi8cPgdNMY4Q//gAMtKpjXk7mqOU3vfd
+7R3gv4JDa/4UjgzNv9lrXSzc1EWh/h4Kx2zKZCf7JhqlxFLeM0jVgrfUZ5EY6I0PxJQNSLquLFK
8/p7Lm2cixd9y+SdQR8JCCYtqz3Z3FY7QI5/wh19PZroHt5sArpfIsbOtH/ImRkzR9zE8pmbd2Bc
57KBGLHBBlf6/bXtDMh2AwCjo+bJvamn7PhbpaPpB+7x1hpXL7KL16LmbDtx0KrM+eokI66ok9Y1
IMxDJ2dM8BFT5AO1aA7u4eCdrEUnYqFeBYzRvqDaSBdtwDqS6MbKPPbZU/AJlWG3Q4S2KDbVegzF
CyFWuoNxDbFDAOiqyheAv5iSau3HX+zjOSgiaeAPaVc7X4Sl9Fy4p8siBDQ8Fymn/unhrANQvKX0
C4119Ta1yb2Hnw38JjWocSI3GPNKSICF709Dd+0xAnBrEapnPF0sszQddrpLOKSdDwsRrBn4YTRJ
7+HsuWLaaJe07v8NWf8yLnI4P3kQbq5niCsE+mrL0+jXa7GXzDy0upDA8W3OmfR1e0mpkoEa8fMa
CV1tKACc8/JQqQLBk9/JBUCGBIEzSOwD6W+vWzwIYLd0tlBdkFP8i8Q9VtdFiqSPB2lTD+3ULS6A
myCWYR5IAR4YfioB97SJBdyKvrIEmAzCCRzH2C4tRMvehvSzpJ3YH/7LVM0lKxl9UvgQ9QCjrlpS
9uzql96DURJSu3+DXqS/+d8ejDJPxOWM8N/8RlDRCYQfqu7kVS0WZz/pob1grj9wDobeOupAT/u/
DOd8HfZPASIkThdNLWygqQticMt84MEe9E+nl6XjBKENdk1WdkCaX0bnSAKz1AQl6hSDprsATAXt
praY7OQWiKYiZqpUKJDWbIsjqdO2XTmCNrw7i6OuCAJEmVqoYGTfhxKntgOChVPmLIqTytixs+1N
pMCG1MCJTaIQQyGGWB0KqCT4LWY1A/IljCBUvfD2XdWwSMw+eLAIDET+W6kJdM3vNZwAm6nzH3sc
xd01uN/7CQQpHzZrKCqhORM8BQ95TJu+1l0opLUXTXq8f67/2E3E6BS3f7qaLvpuhyYQUSo/9GlR
gzSuagR5O0Rznc3fC7qKqcwzEx8DBpbfKnkyMo+x7Pc6dooQEGWz2YmsAJkurcAlCWJml0gTPJD1
dEv7o8YIytjQw9ogteJCAem0F2dQC4qlXpYrTyLgH5yzWdpNpFW1E/ARUD3Envo++gWh0HXYTsl8
NKRCSGkCqWjylM11SE/Lf1nOYasemxmd0OI6j7P1w/90PYussCIfAAU+1+HypyFTamDp+WCBPu1+
iBUq16wTaZc1+EYYqjvTZTtAVlmT2c318qImRs/nSj84fOi2plyktOxbmM6Rfo0AiVvJHCiUNKAm
8qv2KQxylw32QSLhNuNvaCNMkGp7eEaAxc1qjePPbJYyZM3FKL4g2mDNGCDuil6zUwW5G8u4zvZa
LO2QuFSAfBjxXLOE36vdIuQrGlSDI1wLUjCSUA8b8RwIxmRyI6xQyUB5Fs80nvDDmLMMuzv2jzTq
4K62o97PAvci4ztTV/TbP3z4dJXaJ/ckuN/MaOJGMUp5JkK9KMLjMcy3BFoBOc+kFd5SkpnIaTnk
Hgg22QZK8L/CO/1U5ME1dwGU+l5VkygSVS8IxMAT9dd5ZrGPKjZ8mlxQEH9e72jD1zlS65mGxQrk
RY5rKlN+JtHkrqGt0vTC3YBR5TeIcfXxnbh8ek2+lBeN2s2XYKHxaPTGQsYKPq+rmzZmr5CL6SRr
9t1xAlv/djoZvdMdjbfqUPizHvMj+8DExGgdSPcm9nf1k3rp6Ku6wAikOfiOY3aVC4TiN1SBBevB
5jJfMljLHktBGuThb0TAeDxUziIeL07AUz9xcuBRDjTm0F5OtdTkSiWeSfKPPogxyVoORvdrjcGt
32v3kXSx2nahgqNNK1VB3MB5P1BLTPYJaIt+kKmKkvb8q5eCf+rx8FMzU+chgeblLg4SeLBTYlox
+YuTpOpgbhS9iS1B8sCP41HJ6DnvlgNqmExl+/DbhAvD8G9dwPcqhDmyMjDch4Az378z9cScz+iU
LTzWtcVLLZRqr5IDU6B+RmUSAEBc/D4TprnUFVzYTVj6KEm033H/d1d8gG8UX1dlIIbLCNjJNSJm
7YFUBf5A7UXySzil0hHxuRP4964uytn4cMoM1ZOsbvFNwWyC/EiNzUp39y94yfRXY9fRz54aWvrz
9A2u6J3WKju54SDkS1vbQq/91crK1rhGLRccrzmXD9DHoW2o1bUX/vQxWmElPGA19r3JNCzSQiRF
73y0sck4R0nrzwqkHKC0/Dbv8kn85IsDof5OgwoReEQ91V0tMAz2WizxDuXXa6blOhGRrZNBepM0
2iR4aVyHP6KWyrs/mtdmL25DbS1iaIwo0LFPECxVrz14ejWup/Qp3qWqFDAtcv3tkuNiKp+LCdMP
FYHKYZJuXMHatvK4joYlELYkfqfWQNOowbx25vlqXeJ41ex9Dfc6bsfJECEj32nQ24kkVyqCqHn3
+F2gwMzIGOeiz22IHFo/fHP2uKqPwsV9cqxiLxvy9bV5mH2WUB+AEsNn/Sv2u9gLJtu5XZnzUK08
r8Bsj+crb6MJm0nLNi37dx5gI0R6IZgC6C+PU9Kjyq2U/gx2w1i3r2dzF3GHiRpaUsEl6AWF81L7
DqHrvV0pqTThCyrB2isJKWXPuKDAxxbhkb9IJR4By3IIhZ4xfvfCR6ShSxQJAZkQay8LYhASkYER
mIAsVvmey3x9Ov90kFngJ4CIfiFrdbxHCCl98D+Y7Lu3QBw8AjHgwF8AUTSln2vkN2d7XUAOVXnG
J/kIgIrrQkfK5GfKhMR/40rYelxbedsIkqXEFHEjpStYyyj+ztWQfTXXmZz/qTnZ7UdV/+RFLiim
XHIBtFpcBuK1q8+dCht3xYUL6G+6i5wFqE7X20kj+nynYlFr8J2JY8GZfsW59VqfUjzeTwaY8pVu
kQe79ZjiP7a5vvbE0BTr/cF7bhy2ISaZEevJAPwQLEhu1M3t0NOEE/7p1LVHJnB0+TSO4SVYmhDB
X4mVRVinu6H5jGNN8F6EuMylVRNwbvE1GbvhzE8Mj8klLDZYLZcVSyS9bf9BMGYFSHC9UY1VW640
LOpyzOZOViEuzQeXuymo4M9OsnukqqYdHpOY4Zij37ZpzEWHhymGapkfXxpEXJ+EsC36tMaUbtlE
M8tMEpfz5QGkX6Rc8hgdvRgkpjojDkfkrXOZjsPYz0P+rvNW8IXHUFAxbIqqungw3KgniF2oywGz
0BSnUCKWrT/RDOYGXpCXPFFnvVU4+3aPU44QX2rMi8EuLVMCG7VxlN1iHmvfoh1xdpUzpFVc/1eZ
A9BcNTUM+mT3JRdORulhKyVD+20idpIn5xhY/gRIfGn/t2C6hkdXgRo2J9qNtKyRG03t6pJ1/6WO
4oHzgDEBNrrRl/Tg5ypks8/5nkpACcGanoB5G/TpJWMdjXkbMItg97FIlKc7KwfqWNZwWR+bTEoq
tbuITTIZfOofV98Sf3Fy9D2chrBmfyXFqe+c+5H7swyGgxcxU+aD+950LZXyFOxnRzboFZWfFC/G
Xh+E7iK6cJQYWMC23fJE1+GY/CBIf+0CIJbeveVEil0VaJBMHn9Mgd0n7NDfmKfHRVOOvQ7tcNCV
Py+1DvJD60MBIkHlAgtUcXL9JkQDWIH3Lj01oAvPEzPzLGQgM/BSCHmwEWlh8hav8omkaaYLuMsQ
BhcuJcIuRmbQLtWsQeWAtgrun7wGsQLV1eyS8o2Uv4vrfsUi92In+nUuGwzmOyMdHZxNOGvHFz28
o9XBLVyEPAAvcgBlb7Bqk9aiiuayoKqUmihdPNxxFclsG/cM5kdCDpNAFdu+QXKh3X07LGylkdKi
Ckts7C/TXT6TwLp3mhnE08C87X/Ko/M8NzYMCZ3prOXVVz896qt6Tg+tUxFdBvvLbs3zNr/sK7rk
tpAHPsw6w3etekAUAtw7MTGl+dXcDHSl416sOcxsv+MfBPica5gmtqq8fFFsLTy7cuMTx9KYEzHr
pC05O9dMlcyQY7EEZuBZU6bvNqHxoehaExvw5AJq37jj7xCuh7h/Wey+dVRXA+VkC9OhytzWZiX9
UhQ320xMzephPCFWm7ga6mkLCKYzORPkBykVbVLVBG6yoQnAX7Jmiify+FRKxowNZYGINoepQyD9
T4rRUQ6hLWZiLVB6YBDJWOYMmkQX0VUugT82Iye07Y8f2maniXM7EI0eVx/Q9eNz3MQdkVPM/GW1
mxFwZsOdiw4pglug1B5iBwQ/+2OYmfD7U8zu6MiSEY6F0r6L5paQDn3A5D++aoLjeTOty2c0hfqt
o6g1n3sKjTUmOdyRGfxMidW4xyhbh2lspR6yk+fzsn4drI7QPkWhLyKxvBed9ej5Nu3sXwBsr5OD
aWBEBC1E4jtGDK+tjAFh3EI2jbrzevtUolDrUlYKLwXzly5/Sf9Mhe9wExc2hXzHG5Aqw75xfh0U
IgzVQyNTZXM5E6/1E/OYXjt3t9EM8idipqUaQ/5pgJYnp1cQ0TBjln3FgDe4i2OAQL2ilg6YK2PM
ORSaB2CEoGb0voY1fmIcg7V/qIh79AfYrcXy6MYDIPV2Chp1osMF3Aju9bO+z2ZUgSy8aOHW7NNi
maFabbkxZzvwuVmhO6Zf08uf8Lup5JxR0GobqBtpEdUZg+2J9IqH0NBvEDbx4RIpcPkZyNauY8ed
aNrJVgR37MUFleNJkn6F2nBvJn96ZzarHpo6C433ZEjny1h/ghW9o0Az/cEOT7HirHm4841Dj0i5
3mlC5MBgwbcaDcKI+B++Kn7xjXtPxMCYtBRDGstZjS2ez0fL9kmJHfMGhXPKwZ/0khUlxtdJgDnV
o1LNaNHmVcXBCfBiPjy9lLVFFivEQETOaiOiygmxWkIZcfiFhoj4u+guW4A/f5dXT0to+IPhwg6C
p6yF6WSj4k1gHmxNSdf0aiJLQYiLXqrzNnPUJ8gj2JKLXZ8avmR6nIaZ6wL5jsEsmvSLgKzba2/D
l9oHmvOoP/I9qpdaGfzSsnEc4eaaauu2cZvYULm06feBR1yPkkCx1DBt0nzMfn9ESPXp4UAQbk2Y
lDsu+KDbaPhZklGnR6/96Z+eOPOVDWQGoTqMaW7tWbicfa41gQ8Vym1Dd+ZDKOVTw/Vq/Kye3eV5
WSTbQLmB9XAvBCGDRTIZXRrxVOWWUCxlamz7uwPYmE1TbvLoeFsjtgEPJu53tDFEnBWNcNLAVyJV
45ineuXcReJJgw4Y9vqaSDZ2ac1j0IehT1fPMggNhUkjp/wiguAzC6VuSvKtEQECXINBni4rbZHS
HS+dx2zgde705B3zlE+QgO1Zfcr47qj0PKjPi7Qp362jcxRkulCC1o59DllGNtDcWPi+sgs08BeT
BLjqSsvJAvvj7nmByqNnigWINHadJWVib8s15B86UQE3gO3ycN8UwbYnw1NjynuzTXsOT4syfrjD
X6lqF15WRRJ3hlPBoIqX8VF/nhxmhSWdPlkKOa4bbiwEiziTuBlrdpEq6mUiqsxikitRYAbBhQEs
CgLmqEykeU2lvEpZ/Tocl/1Og+lnwnjgd8CfjZYZsnnaX6SbTBhZCzccCz0wpNFJym+vucsroybC
oHH6SrSaKL7YWzC7nabkJjjruTYFtJTNNFYfshqsaJ7VCDEf+dL/3BfaVuxp2wEuxBZnn/6YuP+H
SSbGOZ5/SBD/5d7kQUwf38u+rlZ5ikxSFPn7SIbdaX8LF1eBUrZFIJQ4enMs+00xNB1IA7FvaD6X
PrVmXkFTXFoJBzPFJpXd2Rktdj1vd5fp58s81jexE8IrrragKdvwqC2whscBrRuRdDiRIiv9zjxD
cu425WrgSQejYeg58NQbaMAI74XFDdWKwiR7SqSEAQ3wlAF7kI/BrRYnCvhP+H/sWaercl7QcsQE
oMHFPC3y4jcSJzEBV2YpIS2U5lnhD13tvW8hV/PaupyNhZdkDUho0TmAafVLTymxT3jwhhv/kvMN
iPUS3XZTyOuah1uLgiIzXmbZM3+u0wJU5DSNYGDKoMvDTBCQc+e6MB/4BWH9u4cSiR2tbbqeOksW
SPkKm1xtZR/bszwHoQiJ8cNvsv5wU4ImtPnvEkhdNh7OajzQMxLB4da7x2eTzEZx4UulIugT1wlu
46NXUpu7QR6RqohAG/fZmn1aykR5RsF75GAQiZP/i5f5mNSe6m8p8f9+KR9xNvWUjLj1aZK5cj7X
5fRmJ5Fjc8UOYv4srohGlpp1JHFbCYqmEuWryRXAlatd8THdv4785ouNGKhX5ArRbJ7+GTq2GEZq
DBG/s6+XIpbiCleF/GfCFp0S24SEv3tDzqbWI4p5J6A4K+EA2SHrVSVZY1rebk0CKLCk1G78wkrd
I8aFwZaHHKfVez92Kl2XigR4RpRpQHjOaowlmhBVVAwH0fciSzZ5M1h2yzRIvsgElffcHLSPMLdY
Mi0/OWrTnjrHT7FLS9f1UqZ0VDa4t1Otnd4JaH1bnEoMQSJaYOwMOIW++JXLvaaX+wAu9zgwCYdD
kk/oEUsxJqdMqcdTikizGB9LOSWnJrRbmzfnhCfhoRKvJkIr1jL0x55BC38+YSt0S3hbPCf/WAUt
f+NIedtCjk3tJ7T9yPN09xi6LYr1yT/zqn6rJMiWMmPbCS78XR7wdjHzsgzwAnXkpZqKkTrEdScn
VFoOFAIPLEqhD7BjQwD3xvjIHSluZb8sJvX2NSG68ta8iKyqj3s2mjgXjhfAYMkDNnWt2weJ5ZB+
YSESRPSbPfhM5/CM/6skS1nn97uL8oWFb7A6KcEWEy+v7LyPsRYttYuLnAx2QDGZg6PjkC9Ufgqp
xwy9zMd2mIshkvtF+1zHQJxDet4jwsqlOUaEl5HOq5jxXGILf7Bc2p5Qh8Tmx83nDEimHM9j3Cfr
kJUhvSNJktpaBoUUOwe8UAcUZvAiykQ7b1HxtP5jZ69z9U9c2mdSVNvOVuXeA7mALj8+TCEl/ZfX
GDGtgh0BlkFhLt8GcTt+GTw3K956FtDbuSIHIcCsQUK8BYnyjWCsREPtd/lwxjpZ39driIWyHwaP
A8cGkQTjpz5AeMtCTJ/rdypZyRYpElT4LCSniWOShPei0hMueLJhaJctfCGhF8rzdQBq3EwE8Squ
Uoh9BxOvqJMNUvMp+c2NOqnPqKwv85b1fAvOYQOcvxqa+j5OtNr5AwFOX9+Fbu/DwKz6ElRp0jR3
fLq0qBcc+2oiNYqem3GP8z2gNdUT4fdINQHKjFA2AGvn/Gng4kP3GQ/28X/Qnv9a27qtTSPpfiWD
sqHMTrWWK3ir0f8ozxjgymI4ZUOcN26YhhwIFqckW5oESXpl/2Y8EjLqbdFezFmAjgxaPlLIT34w
bAHsNDsGKXtjuNfZT89eqWYoUHkPPmHrq80vEoh6rjbGeyxdBaCS6KGFVbkEsZMvFNTtoM6IqrtM
5oPIkXovB20rkXqZXWARZmieAMaOXooKr1GXcS347DnHV2QOtZzjRocKyZKCDjQcOm4g0u/Jiwzh
s2VZsiV1BQXQggja8zXe639ASsOA2N/Pd9+ExxZVYfKWg1LmFadI69KLFLRFKcCU7JYz1wH0N2K0
fw4G8qNyqs8/qdIW3+Hox8ynm61tG/eEl/c1L/rWuVp5jErrDW/yMvipekNt2yK6Nn/BS+IUWt+V
xhyOL2Wt+qM1pi7hXrFOTIjooTBsp807DPyBWwnCqSoUt95+/2qJ0Bi4TAOVSSmf4rfLYGG+rezU
o+zC3OeC2PL7qlBeZUtjSMXV0ICv+LUhDO+Xan64ym4JpLi1Du7++EfkU73nbxHuU7XYO6zbHJgc
3H8KFGCL6LUBfntEiv3KrrhVwxurMn6UbPdYVwgO0IybCfZ5GL+zvdggDrPzLwe+TCqI+6nHNPNG
aWgw5+cGwvH1Z/1dw9FCMkF6kvCrK2FbHHNG9NwzJJrbUBfi0Oz/k7515bCKeQfUSmxRmgh80k89
82RtuPG76fafEilOhrhVV4iKhHWfdSRASDavlxlpOslHNXxCJ53UxXL2LtBv0MOGHTXZAooJsc2v
GILE0RdD1EMhJaGJE/yByCDfjlL11BTTyFT8evIVQgFpDEJXqRm94ruAx8PM+6gXXztB4uOSO0d+
ItBFi/Yh9jy6pM4u1gpHZFGI7TU218GMs+HfrfYobkxadENHOVz68SQ/R2vWC1w/eQ8LNAbQrIXN
F3dAboeV9P3F1Fa+s66T1CdMBfx9kUrA6I/tZ5P63rzjLpYmPr464Z+rin1Vm80Z0fCLn5nXynbD
TunhPi7eO1ZFD+d//lJbZsfSf9x3C5kmP1YIZas7uusqJdjosNEy/aWXI7OLoP35fIo7BrXf+34b
fHEX4AnoyUyZDWRyLo06gAkSxW7iKrRxEkO34YjFwJCNu3wsVyvg0X3JLNPs/7WMZuk1OKk/5yZ4
6ekLGWnstwp9odteDK4bxAvcfe0pVJR1ocOI0C+H1fUOaQhqWvmPfvJ09Xw/gkF2nXNaFnQam/PO
POj5HSHQ5uZ80kwRuP7zj97iejEBNEVFlMhi2q/LRgHmT31SVPQ1nDgr9N1S8hD8MdJmJaUp21av
v7He/ju1et41RHiRnk9YUkiXLCBr4wNSptbM8+2alxy2Yr7CSsHseGwccFRBIOAsowFA+GBQSb7t
PFqD7QNZtQWqLWrkLe5DAW+aZWi+z0EVOI5XfB9NUspUw2uolLlmaL+UZlTrUbTm7lZub1NMePVl
SJULwh0/OtWR4AXBIltQpgYtphsQRgec9Ieq81dF34VhSLXa2aGxCn2sE6IcRsedZ6de6Y7odxyT
/Rq/UsAE+dPLHLxPhGyhOkHMz5n+KsUN2a/fWm2xLEirJNNrVRXkYbteSIFuQixN++11gAERabWO
Niial1GixlI9wDrxHd1KHJp3DRxEmmKTxw0liLFglIpWpBpQwzN/AHCIhII+5PHcKJGIk4b/HAzw
9x/ja99UAZoJgkeqdxSK0v+Le5mzRzzC/coYhs2SBsvIIPrTKNW9xWkLEFoRhTNa2yw1Lktu5utJ
5nWl83y50pRXjDEDDN5cOcSEv6fMHyXKr2Ut/1PUCz0SOo9MA+MbikGFArDhMAsnNSj/S1LrfU95
ERj9Dlsk0ktJ3e4vgWrcSF7AJeMTnZpOJxKCM89M60LAQjNx4kWd6zG+5e8VUDyjEm3z4DiYI5Yn
kq8S4PlprfLspcyPBQ8p93b3B3ZFw1QrtMIneFgzmN8JQRr3/XyCuCztI3p51QVh2V7nJRKbH+EV
XEGtoPgBbjsqcboHVLexstLZHJVx2iTAVbB+mT7Aaab9viOY4RsJvCM6cfY/bI06BYXQ/GWTYIf0
4CvUc06EtzQlm+1r6HgFLW5YvifiWxm3qcQbFlJZyFcEDMavJUvpwHqWgm1XM6g8xugWl2+0uZ26
WvCVBf0V0R2Vj2hTJDwL2OGlYaVI9OZfWUndoCIIwxd+HqpU0jAxTinDTnk8qgtqdbxcagflB00h
AY8aaVfNpXu5QJpm9aSy4rNUOIeDPCBszqsaAPIowUQRQ4nNQqCmmeVqQX6bMwhFiCLzRBajfp6O
hP+a7Ec1EyEcS7MoxvCEd+rqJYzzy9yM+zHRuVUB3RydDk8macCJpZBM1nrFiXRqCwcVzZnjWilM
hutRLC4lAuZbvpkRZSDog68s5GhMX2sK7/Sc+0s4w81ss9+kuY4ElUYFAMsyCUk3giBUlZQ2yFAM
TmgnMx2TOonPdxoCwewRRrPiubCvps+6Af3g/yfC5Ab7RBzGP0615jWk4L41tDAvkH5A9mVgcizn
QC+DQJxjJQKEfq6T8MIOQuOONhcfj/F3z5KmzWWNt1cSX4O6a8bt4+WEK17YibJ0MNljlojplCcV
ergTuj+i6gw7wTupVItHbQJNwqCXm7OyEIuWwrHMFDdB/Dt2bxzinm7OWlcrrHWURfjDU0w1uwrh
kpD1ZEWYY5H67suZOHvcvJiZAxJxyGJzeHMCw6GpZsLh/PFaqfNiPPZ7mLfgOMixt6z0qL0RXgGj
0UWAHMVxDDYnpx7OPGvCYzIVBdL/c8u0ZZxtXj/abXPAeHvI4on3n1cuB/UGkPw4RDxHXCY1LQhi
1T2yLq9NFvWYA49T4qpdGHvRdDfxyMmadfOAusk2RrB29nHpPgtkIatKRTPu+CwxULgqpdKPoVuY
q4MPNi0f9wVzS4llIn17fUe2+zC06QHISFVtb0vux7RLFjIVaHJRoy3nphzxetVgBoBFRGmTKxbe
C/hYUJYBLDA6O66MJZk8SZdRoBOdYKz6x5EgzXYdoeErblqmhENKmQNaFq5izTkwTonNOOMLr8pa
PrqUfSRBEA81O5zjJVYQ/mzzjSEYKTg7eG2Rju3N4WAYA3vqJcB8Q9B2GWyCb8n+R7RZTwe8t+Ro
mB3VMm1JvQpzZiFiLxZeoezJCGpK3NC3DyXC7N9LcqjQWd7Bopzo5sBxd8oKLIMZuyGdbELmIlfI
E3TQZKE0zzRaDrGsoWSaNdMhe1sbJ09ejAwOsn57w5zA+9p2Uq4KsCPOQ1ADCxuiKeoGsvmsHHJR
Rh5Id/k+YNCVzpB9A8yLxKq/W67aobSSvv4pbX5tf6MZoDXvyFhOa1ay7Dqyv/AWRJ72OdFsChIT
iaP+J6N95LSkSdEt/HukmmVzSOW/Y0yjg4Sq2o7Vm4BkhM8/hCSP3fRwqYXnyKvICkWyQOW6Jh+k
uhFiEq+HL+0h0dh2EPAihAA+cVMIJSAMzPO1TBJeHYP9AUAQqA9DqjJIRju+fiwyiCq0/xEvyymG
LmPd3PJCTOD6dN0QRSE8Rk1G2Q+ys9oHRFGuCJVSVebL2j4SravOekoItUHZWFC9YoFpmXyfGAHD
U7JTHSpVGBmVIEotrnTqpqN9T/IR6uqAQBlhDJtyVXA+Oq9n7mGAkBwdhpXni7/Sofj3BDtGGWek
fqTgVMqTPmJyVJN6taE6ch7/2m2ZeAW2tqpDc/biu02K/Ymeb/BisUxrntlylgjjXPvhH1vlBDjt
OLmW3AEJia1vnziY3Lj+u2CfNVoLuNW/3dbepBn3REYNtE+ROqnKYOnL9gKJjIB/Jbh7dc9VgHdt
kxaTOuCBeeZkuDui/KNEiMkbQ5GupYGlv0D5Q+ZHmpEjpDSYHudrgIdELWaS0gxSHax/rhopvcdB
+fczjPhrzIjc+VDubiP/t6cWcul2PeeaIq156jCEqhQEwXDndC/YN+rsg3lZzVQxWDfCh25TYoaE
RCBtdYYrf3u/JxGMTT1xCeQwdeP8BruUpstycqLCyU6qkW0htWYfaZDSkFUKsfItO5GEfUUq6B5/
ZXH+p9QHKGj5hdWMGKOHn49kMb1Q0fz+8JAz3JKEQSenm9LyLTBagMLVPaMV5KLT7PWdE2ioPuQW
DOQiqXs18WoJctzcmN8ahPbYwzXAvK6F6j1BU3VFkFp56hBzao+vtn+yu3ClNSkK4dlPlkPG5W6u
8iSt9geZGwYLLjdKXFZDQN9M8mh16YHLsOIIpmkRksqMIWTS3p9jJ53QvW6MK/nf6OETM29XfIU0
FiMSpECZ+aiYYBdx5XmoR3FdbQr+xeL+ais2C9qzbbE7kpM4+7ra0S2L6QWGY92VVzpWQLY3lU0R
edc9vcWczZxTMaIhKKa4SNTiuDjfEj0jOawJFkoI+AZULd7+Fw/9CAtboVtKxp8P9HbQTdI521sG
Jp7qWnGV6llaHITe3INWjJ12FHCe15N6IUMZwhYEiCCSweFJv6Tjg/x+lc2wdfX1YTv6z4/o09vw
Q44vwFVM/5sscDI2pSslNqIyMC7Dc7euJtr7wbOJKONDCEGzRdUATgAH315p3UZ4F/fu/TDmCInZ
Rw/BwUdeFFfbUZU1P5F9qeiUfrj2DvEohoRH8NvWcnSYOZh350ff5tx/PPy1DQQYkku01bFFLnSg
qjBCkdhbbViytBpf9T415CXHzcG7afu/aa4pMDrS8tFWz4PAugSNi5tTh+VNc/KFXgFfMI5M9yuZ
Yyu5olokU6lURyr8viqM9hZ4FAKOdl5ap4UHZ3fOV8S1QlyZAqnustxff+SILyHcGj+9+mMyzZNw
e9RaF6JL/tz4CgAzAKac6Op+ZWXMGhAoeDq9CFwDb9AEnUBmEG4B6hC6r9qznEjqhu84JUJRhbR4
GQ164eCxovJijCquyIxMKrC7iOtv/GztrJ2tFe3wzEfDyMMcrE4y+0OI1LP3ZyE9cGWzhnxJJAw6
t+98w5WPVh7V0V/iBW2WdEvBYUXdelEf08B4uTYaNduLtCUc2Z2AsZvGRax6hAYE/n2hzVLvJImp
LJD0zkpbHxHnLwG0tmA1YJyclePUaKs7DKbFTVvjCnOQ/ORO6q2fyoPAmPx4m4p5W/sa1Z/bdVeQ
7fOVWpXH2t9g1ioatjDYZpTutxhlrppqThtvK5JFci2/jzhaFzeUGihUy0N0OevF2ko4xHJ6IPdm
xjwQHKBuGrYdarL6+KyKz+VQ+CGIZ96KOTVz8Jc/NwUdRwIAgy7TNZnrOY9ZhOp9toWCTrn3QkCJ
Gtz79wDk51JgETtIUZKS9tEw17rg2I6Q0PoPCZfibaxv813RGjQKO8NmsQ3NAwgFCq5k2EQZ+H1P
lWJ72wq62zQdgO5gX5aQcAQPwTX+uiUPs2+8xLAZaoRsyQfLwhKk2Tk0Orl580gqYptp7YMqOmdk
JgJWyqME2QjjNvBkFObgLSURQWG5Vx/0T5voabGjkZTelIttH8pOn6Wl3MG1P171gz+wcm3aOxsH
oSssxl8ISen0dxxeI3XOOm9qtmuFNMPUHGO/FAucSfNQEVd77GNe0GEdHeM0R6frdJGYCPapHdIk
3uBluVnWrDFUHl5RvXUkxJtsxQFBCVjYQEet0NPRQ1vIlEOj73wHfuqiE7QqXIAiVy3BIMNXB+md
X6GSvFX5/3g3jm+3Os30Tg4tSjEXKEs9vA6oC8bDFrqecW64aDU3hKF6bNGqLBLiIjHS7pR8bR90
TzTW16AhZa/fnjD0Y74fKCtiY2KVKAGJgRnFsptbUWQGE5p/W/7pYRLlwg/RKBuo65n0B5PhTSod
axKy+lRSFlkcnMl8aVy9FLe2QMwRd6SFlEnXhsFvqCSWsGyxm6T7zgb5+k9VtMx2QwXg3Ie0wYLq
9uH81CDPJj9dEUgMt0tXd/bEK4VCdrVcQrTQznjO2bJmDRDExkecpNb8AzTRIUt8c/V/fPPtWMvX
lBtKdP7j0cu8Y7AThxG/uMdVj8fxGJr995Fnw3aF/lxK+6DofFjR9OdQbHml9/PiIWPqjM62AhA3
GZOPe1Gggbj3aXtqiURxMY47JAsGj5XcmxhAvsFrG1c9NbsGUARDNsgPKfDRQzeaJpOFCv1U55ub
l540QVEIc3uKQ4ebcpO+LBjjoi8wBDKVUNFVC3bscKcX0qcn1Klq3A+gmLOABU/Fro0D8K4AUGrH
m9MZR4bfhmp4K0qYWbDgX69pzUjMsPuCLrN18S6SXWhOEd5Uj6w1HCaEhXexLUGJr5ZPHRAW/XIe
nvs7WnVaAQCEjxnWq0ApAe87pDLOHcZPZHs7fNH8hMjnS0s12vaKgXPV3nXeMUlF2BLgSNUl1sZr
RDTi/1J53MQucPgmDvIXmNCkjDNKTK+PRZ7nl9NDa3T8uOsl/pJwDq38DVkfAwRySIIUyk7tLSSs
oOqaA4OnwaGjelhmvORq4D9WAl8D3q2ANYGnpyP45nUDXjtnjN/Dg23Xuf9r/50RR/v2WMy3UPBb
r6px77C3pYpy8UO7wL4MBMBQS4au4982uCfu10GWlK1TI8RlYdngr5/4aqDPkVrITLzjkZJMCH1/
w1/tUwS4tSKL3FSexT75f91UG73fyo8C0SPY0OI8CD7WrLj4Z8B3AWqVf42MyqTWWcNRMI6PgU6E
dkFQj4jeI7KrpILbIwt3e1b4dZr+bZZAT0yQfAAKri9+K2rEbG3f7lQ2+OnHe6EugTZ9p+09k5yW
sTnSaVxnv0ypNpXKzFeb03fy0vxF2aGsm8KSZHbDBmvkI6zSss2F+ijfYGNoUvBssPVzWnAVdC97
ou2WX6VeaPwSiCtrJat106aPL9tpcUC0hRYj/dT5Ko+yxmCWVvVSjWwJG71hE3Mojxpe7twyTDNk
4n3g6RoqlmY/38DdZPgcekHvcJMWrKtUQBHE6oIlIJCYXwLs3AEkD3yoWrZKGgEJhHKtuqu/7lOr
ZeDCOqzJxe2FLT3fXm7XUDHavrdz82+14dRocDey4ZtaVIE6ce1ZgnIhBnuRHXcQOLycOXSc9L3x
eWxq8Y80N1qCSOHFRJo3jIzuLEPRq0Syyfrgs8he6CSUq7N69hddo6um5iktniH49VHWcA8NQ0YH
oIVdBR7WU1TnQrkD0ReuFU4RPl6JhRkxw12o8qRhxBWoRmWkw8PvcHepxeiPQ8EiPNZAs34Qg0Lb
iWprx8PM30As2wdhnAJrhrbW9AZjIiFhjam3xXSuk1h2RQLa2Noj5nFrk6RhAHXPkOYV4oufdaF5
86hzEY3s93gQOqE4Uy339SQTD2iyjHoTEcnOlXl72imNpfnRaSzL/B7DajpRZHruNJUaeQjNDaTi
4tEE3XNtCx3tQ15nes+dpDLPod0A3vaV1tPt2oy3STmmHDKd0FDEp4eAL5nWzhpPiYuIDRFLqeEz
Dt4TLG59koKoWe87QPzlGIwPhFP5lObZuCc0HT6zA3Cc3isQJz1teh6h9z+e8K9+Nz+EN8/btJ3Z
dfwTKyF6UIGwZpE/3Nc24bea2xf/iLENRQuBPj5ibwQ11eKHoFB4paeT8RH3RBEc/VVnLHveG9Dc
nP3/YdcB5u3BUO9MaI+D7Mmvi30vS0VqB/MZcpR6f1FpLSbmHcXs3wpmwYOrCitXqQMT5LrgX+2L
Be9n30RD3ltfE8AMuEzTzpMqTI51YecQx228M1wkvwozTPldads/l7Nki3WnUYoWdB46y08rJvQS
3tZsjKmZey13tTkNZKcFxJYgXFpW9kwezBB++n/+H57eUs9KdkP8S/li7MEbg2ejcpR0YzeUvIX+
wveJoqbriNQwYZKd3eNwS2GJEAceSeYsFTt6ZHE8xhKE+cpeqhK9uoZgNrhizohvyb8p0QecsRno
Em/CnsqzuidslgzRnp7zR8rXjUNVXIRhH2fK4rNf1jihL0Onzy7n4efVygDBZ5vIsSXbZFRAs5CU
7QT+qPKYf25vRnsqqrfVXjJI1Y1B0WUlMizoyJOZUjRE7sf6a0ccW4r2W6br0JADXzGwBUJoDA5x
dMmtWxnaNSX20htuVLoEty9RBbJvq5R8is+zVmRrPp+HGY2PSx99r7GTv6IwEqvPF5Xpzpa5OCNU
vX3Z97idjxsUNDO1cDyc+rXtmrxXU9RUQuxYAukk4D6GpqneFqC1Y7C93B0bPOkScei42bEL22RD
i9cOnKMEdCRi/czn3xAfGLKM2jaVGYbUwCAs6i30sFHHEpcfHL+ZTLh6d+tbKN59m5DMQar7uUX/
3khDIZ9UrsVc2IzVrcASVszC4edPPsVbYajOeiqe4p8YrYEgXpesUxWyJEHrgQXxeehENmT/sr0W
ntpP8d46wPZt+8el8AvAFdzI0u7s4w6J5eFUFC0BzOO48MjxuhFczFjXW+ZidpAMK/+3fUyyV5r3
S7AoI7I3YaKbC7jWV61eULYjxOtcNLOukW3oGRKiFu6z5pWgmx4AGvDdxR7R2k8TuFGTdojWKgan
JRlyMLMTaeYOT/LDvX/C7do6oMoKgmt/oTkx3ZzHeuaWZ/2r/51eXDF0t3/SUnqqNK02FlefPlwr
QCgXd8AWYc9Snf24EYT8xm9MHeEO/5La5j6g8nxZxGkG5YRySF3wMBwfkzlDQQtGSf5oEYX5Qrvn
IQNpexJ87AUBDSfSuaSLn+EBfA1AKJls2tUaMsqhyy7xhqmSi7jMPE0OVp/PokdV1wF3hUMOpOZd
e0kFUA7uIwhedDc/LgrwD3MczI6Io57W8fg9bNS58O8lgcel4+PZCsZLV405Nmvbwh5QX4UBhpHS
sMXIxGi8ndsJVcex/psq9zVbUeJxyRMS5x76hyPlm0GO/Umqq14Go71oxV/FiFFrHa3liDyw18sx
VdXlWtAzoujU24WnR3NlZRLKbn2Fnds8b9yIDD0HmPETJNkFDAAG1IofRBvWvLB/Dio8S191XzYO
9XKHkGh++gWFD2CAELt2tdzUqbBZ2p7ylk+4ZjATDVvQqhJjo8DXaDl/OaAmHBwGfHNg0N5n57gD
aXIh+h13nbQLBNxl/JHr5sZHl2ZRLoPgxRd1af6dar4Kk3C/QS+0YcQDguRiImUNAsGyt8SuCi/5
1OtlmZ1uo36rCuLUozOIpEfq+yqiWp2atjBPwIMTmbWBTeLO7cbeVtPzDKNQiXTusyZhEquh8Z1s
IQzSBftjyn9Pg6xhgKyXGF89vK225B5rd+zFHzllBgmohiFAHuP6pKlaHFMbKE2Y42sxGtoNP7lX
A0fGTyLAVjTqoXKkAN1hcQ107TvtX/4Xc4wAXqOO7nZN/tzv7kgKtAwyOcvf661usCLqPfoqHF5Q
MBE75mjDx4WDGzDG3WQFk70w8D2PWvNFRGD8TjuiO6hVlvm9XJqOiNBcIc/W+7YK2UYOxCNXFqt7
Bl0oqyJ6dKS6+s6JpvnYq1hB8edxI9/qxe/PLVkWPpwu98aPPIuxHYm5tUj1fLO+aEqBsxvrRzXU
BjuanMyEyPG8KX7pEEtDY2q6KzyO4sm7/whMaocoz6xNgqNdmqCwd0DvCoo/Au9tVSd0x2TUnwMV
K2KyTY47IYFrXkCeE1pKKjWeKUe3utWylDRXHCshdHRvRM15Lxp7ud3xzNUSZjHJXFo5Wf8E6yMo
MBIT9u1dJIG0+MiUn8vJOyQn9aPlu8TrBnu84N/QMN+sDiVnjiBDVE51PAKsOk6NbTmh/XDwQhcl
3tlvAn71ywdkvileaKubXjWPHicKGFXt0f7Jp90nKNtgLPJrogIB36kGYQO4mIwDFr8xUTXLo21W
/wwT/z5OxfHzBGbowJw2IB5UQnS+OQjm3eCKNgNrbvkiyQLjvYsaVqxr982UXOPOsVooQy9B41MP
9y8us40cmczz8hF6jGVxyk469bSetbAVWWvlR183rqWnOmCl7gYbJ4mXgiDZA27QJXpZDNraMBS0
4yriITFWpVX2EDKnhoCtTVI2RngQkMR3+eDL5L+TvqZNvHuX1AmQwq07K0NaMt/BJ9wFGG2qDxQD
XTOQ1gsGtqR/UdO3FhZ8UtY1CqmtcHxbeVMse+SMCf5Hcxyv3Cq6c6wS7Qer9jUDNYAYwXdmXN1E
7BWBpqWNjG3cJ14KHeJeKOVC2NX2ix4Ltq1V2oKfREqa9F6HeFk9j3PcAnTOQvNm1Bsy6cejur/Z
xJ124VpOCBFNQXaEOtZ6hPcox1Xq6GlyZ6kVW7d4Y7Wj/3oqOgySz1DQ57/eGKZWnxUffz4dUJmy
Aa1GBneSJChGIHzULctSg/VvcNnGnJpinmDppL5vs8A9XKHrKEeu+giR67H42onBZgDYx7Kre3Re
gf+AMDDqFt4nkOL8nPx6lXhvnZeT4pJHVG2yT4zBgx3j7e5sxVbyv+n678xR7dHg8jJqRKWWaNiD
/FZIgjGFBxDUp+NBcUkoKUyEh5pFZ2pqIm3d5llVuMrYF1Ro9UB/Im9xp5GEzn3OyUePRHrf0rlD
qfLMOBTbbxssofgODwDYscu1/yhB1nrz5WAcC3al0NuhgpTzROAoRdGtAtAv/YXFhQkiuMX3UMUN
TOkwfBxUwQAFmBZLOaI3Qb8ueKfwZRcnwWuSP7doJX7gFGJxe4W7Ym7DuwzHEinwKG77Au+FGdv6
3BZCUFx1eDPX3OLyudn5wWigzg7tSGiSh8BXa6SpOiCvoMR8H2oTk7fEqjstTRMTEWJ18uzuZ1sv
J09j8K1Dqa5IFNbKpceLpKxyHzGdDVV46Fk6YDRnrp94JWCKSVRN69yneXZRTZwmg2AZaTghHSxB
CI37g5O1EO6xViqn+dkIxtUaUZd9O1DL0ba2gQnymnoCoaJ62ZFVSFxZsQPdBbZnZ0u7tNu8r2Tn
kcNmqiu6Oj2FcruV4mxBsA//s/FGgEV6LmwBKmvPTf3xXMSE1SDwgOD20cq/Z0RXLe2aZ0OX+oZB
dXciwi1Oom0f/6zmkitAxrxtOiHIqVFSZXYs6ofwzxTQyQflUkZYMUXv1Q80kyvFsmQFixfoS+gF
vlHLIVJe9NyYkGzEnQ531lzIyA/ujPHv59Yj09smDcO2HdqyP5eW+wDyyavmU/4mvrPvjva4agrN
3P1L2EDjA7jqCs1RqTrbEypT6YKLUkmgw5CvTyoXDwUC17prnrRy6M9YS3/p/zGxoza1lHYkwSuW
2vh6heSmEdm61ind6ALTR+j+2/acqHbqC1hLA2+BoiGUaVdMSRLaUNynhQ+L5olFM2VPTGkS17kY
13fh+/TNsBKNTVei/HhwUmCeVWzyf/wCt1OBJV0IhCeo6uI+LMfEv0qSV0o1eeTOh8PRz+ypO9po
DpN76xf/u/vjwNzW9tgE0UjUBkzYi9o8eiSIh5gQC4OSTF3SMAAAAAXNvfdFfbnYAAHmuwPw9BcH
aC0wscRn+wIAAAAABFla

--K+KrPlbAqfTrdreA
Content-Type: application/x-xz
Content-Disposition: attachment;
	filename="dmesg-boot-bug-at-page_alloc-c.xz"
Content-Transfer-Encoding: base64

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

--K+KrPlbAqfTrdreA--
