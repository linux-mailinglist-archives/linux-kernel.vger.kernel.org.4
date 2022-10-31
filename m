Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE4C06134B5
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 12:43:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbiJaLnP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 07:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbiJaLm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 07:42:58 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C17F0E0B6
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 04:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667216576; x=1698752576;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=BpXNseflnZKXinntPP48e0st74V/fXanAjSTVERBoIw=;
  b=Xtrx7EgXwX/2SN2FQs0Q1aJentHptyjlOD7EiowAnETcIduweR39btNm
   nGDSYztirjOaOT4n43snkcsC9Mro+cjudsjyCG9MO+eKGqeJxJ/7+BCV3
   IRJaeiRsUryhS3c5jk7om6h8O238ObpGsXzR9H86qPWbdamdlLZt1LmoF
   hCUXbS4std8aQFzhf/1u57z4oE4LFS4hAZXn793pA5DONt3i85QkgTE+u
   7wr52NyCOGXbcjpSIbkaM8z/+3SSN++wtXevwYVDrD5VexUaOi/YsE3i5
   f6OkXnjMp4axBJqi9yCS3TRW1KFaOVxw4/0cjwxrdYC8alD3JPpIzg+Vb
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10516"; a="289267862"
X-IronPort-AV: E=Sophos;i="5.95,227,1661842800"; 
   d="scan'208,223";a="289267862"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2022 04:42:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10516"; a="636025013"
X-IronPort-AV: E=Sophos;i="5.95,227,1661842800"; 
   d="scan'208,223";a="636025013"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga007.fm.intel.com with ESMTP; 31 Oct 2022 04:42:55 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 31 Oct 2022 04:42:55 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 31 Oct 2022 04:42:54 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 31 Oct 2022 04:42:54 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.44) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 31 Oct 2022 04:42:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=adcIVdI1mbA7GREq/7zRRWQcuVFLhbH9gxKqmgUcppH/EDwnPMocBnwA7wJ99tKASp9lu7IotTwREqkqpbq7SSSP01qltQuPPEATRJMxNqKVoky6+mmZsSoi4ZqOsanlDP5IdKK1AFFDNVsW3sREQhwxOn4QsJW/IscXLdzXODo64FN+2CWitgJjs/HJqSkwIl7BPE9ZbGtbxBi9GhTm0XdN3HRd4vBkZaTyZYdOppikUq8sRHOSC7unzlp8BX78kvACIWdNexH/UBeW00/xqeLGxfrscmJYeNcRcvghFhhAA2RIu1ax3wGenbu526QMBFazzC+GORcDbtUSuA/Lzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k5Q4Ve876APzxX0VKD8ibMRB2/ex9YBHSgw0jvwSfxU=;
 b=CHySpIlFnaewPjmGD/Ggwu32ZpbVCgWdP/Fivj1ya0ln51WQ+XlGyHyq9I0tlKtBcFIod5oTmtQH5YVN8Azv5rq51QILUvQinsWhf6hrq9EGulX3tnBeU8XvmlDVW4gywXnXZxT1+51CLh80YquNMTDjOeXbzf8EJ1XUjJEfImGFJFhklfB7x8tQ6pBY4+RgLxGbvFEtKMh/NnmqFFLuoDdOtTl4u+0JOpwGn5EqGyeOww0LTHoz+iYiYAkohDTfVmmvR6fvkCHsfFfG6dedg8gp2DSNDtfVq28s7gADc311iZfI+5l9GNAQnjr/u5wJm5ZCpV5YDXVeCc7QpMo7Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6308.namprd11.prod.outlook.com (2603:10b6:930:20::8)
 by DM4PR11MB7373.namprd11.prod.outlook.com (2603:10b6:8:103::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.16; Mon, 31 Oct
 2022 11:42:49 +0000
Received: from CY5PR11MB6308.namprd11.prod.outlook.com
 ([fe80::714c:d1b1:fa93:7d74]) by CY5PR11MB6308.namprd11.prod.outlook.com
 ([fe80::714c:d1b1:fa93:7d74%7]) with mapi id 15.20.5769.015; Mon, 31 Oct 2022
 11:42:49 +0000
Date:   Mon, 31 Oct 2022 19:42:41 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     John Thomson <lists@johnthomson.fastmail.com.au>
CC:     Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>,
        Robin Murphy <robin.murphy@arm.com>,
        John Garry <john.garry@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: Re: [PATCH v6 1/4] mm/slub: enable debugging memory wasting of
 kmalloc
Message-ID: <Y1+0sbQ3R4DB46NX@feng-clx>
References: <20220913065423.520159-1-feng.tang@intel.com>
 <20220913065423.520159-2-feng.tang@intel.com>
 <becf2ac3-2a90-4f3a-96d9-a70f67c66e4a@app.fastmail.com>
 <af2ba83d-c3f4-c6fb-794e-c2c7c0892c44@suse.cz>
 <Y180l6zUnNjdCoaE@feng-clx>
 <c4285caf-277c-45fd-8fc7-8a1d61685ce8@app.fastmail.com>
Content-Type: multipart/mixed; boundary="eA2WCFFyGaggxTCQ"
Content-Disposition: inline
In-Reply-To: <c4285caf-277c-45fd-8fc7-8a1d61685ce8@app.fastmail.com>
X-ClientProxiedBy: SI1PR02CA0034.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::10) To CY5PR11MB6308.namprd11.prod.outlook.com
 (2603:10b6:930:20::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6308:EE_|DM4PR11MB7373:EE_
X-MS-Office365-Filtering-Correlation-Id: 13b801d6-6b68-4841-53de-08dabb350974
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zglYairVT11CN4OXrYFGsUVz1gkYL3N3Bb8nGRs+wi0MdKXlA4Y+mWEAWRxOm4q0/pkuvFmIXPcOtiMJ1CHpW98GjsswdHFNGFiv5hUvuEQHDd5x7sM3xE073wZS2kuCG9f7JtaXKCXLcdWsTMVC1sJ9q9D0zixs5twDD4OvLqnZeJ6epZFO96yPDlEmTHTQ+IGG+M3IfCvLlZVkm6pJfWIlmOEmQTatsA4UwsCy0qfe+fM7s6zzax1aHNFyQ/NyAyoxkIml42R4wcqpdkEtWah+EysFPRrkSNXZgwUow3XeVWCBdX5iSDmd6SzC3GGl8aishM5QqxDbVe1449/knFyf+je+d6UdMCXehSM1nSu3KP/pe4Xa6ZhKQGsfmSeKv930WIeUatoCB0qo9R8mgtR2k/TJa43ilFbSAmq1vy1a0VBkCBdznHlFw1jxihkDP0aXy9b/3QJpSuJVwdyXyiboUN2fQ+lPS75TXbhkdOAbLi5toLeSpfkBr3+5/WsDJV9M0Tue0CDigmXICsi/AU2TaPrLUB1a6ncuGj11jtWKX9qBMXLxb1joYXeYjVk2MyesoDNSJG19KDbxlLvR9FsJSWeTb7kF1ggUtWiRsChqU5VYmDD2sm4oa+DhQ07RpYvfMs/Z6hxnV2wk2pdax4fAnGh9H38kOVMOYfR3PkTCmgrYyUJLkQkeRoAIUv8a2UDCjcdYAsxpXNw+70S2RkfGEcK2fhEPDWY21mTldux6n2405ik+LaLmlLnHnZW8hpJv+psKA1t0bE1+IGG6E9qXreut4PTuDp7orkIHKcU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6308.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(39860400002)(136003)(396003)(376002)(366004)(346002)(451199015)(83380400001)(38100700002)(2906002)(6666004)(44832011)(82960400001)(33716001)(44144004)(316002)(6512007)(6506007)(186003)(9686003)(26005)(86362001)(8676002)(4326008)(478600001)(6486002)(66556008)(8936002)(66476007)(6916009)(54906003)(235185007)(66946007)(5660300002)(7416002)(41300700001)(2700100001)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zwZ30qbdCt7MWhZOxgMexsjiu2eBccVRGJyG2Th5ZU3gmX2L2S1+lxQEggrC?=
 =?us-ascii?Q?va+9AK73VN3l2+r1O5bRjruUROu3sq3/92/6POvfA47Pb0Oj79Cm9sAi0DSR?=
 =?us-ascii?Q?D+igsBm1wll6tgC+nEGxdRFFuCgs2woCd7V2Uiokm3NfCX26815Xiwm/Rqx8?=
 =?us-ascii?Q?i2FUWKeRdZ+smIXl2n0RQbFPldrAG4cOehrJimNFqX/+/7Tm2cGByIyeX49e?=
 =?us-ascii?Q?9p6AjAxdvzmPELezCa5W413ep718eAXQP7c8CaRy/FIb9GPLYmcjQVkXif1E?=
 =?us-ascii?Q?cTUaX8hqe7mCNPjqLy2qTntP5uGqRrF8FG32PazDQWv4gYnKkFjQSHonbrTw?=
 =?us-ascii?Q?xdP5sXaElwu/W2+HZBbrYOx2fxsO13ZVRk9ft0PS/znTK/hRVSW9QeM7/CUr?=
 =?us-ascii?Q?wpG9cZFCNMBTQiZ8clHFNmhB8+9JHmV7qaymo9L5vvRTsUXxGf6mBLimo5GH?=
 =?us-ascii?Q?s6mhWs9jNyLqa16lhWtiZZjFR0EO0k8mZhtBR1DgHsJmTcDdc7B0NcuvC9B/?=
 =?us-ascii?Q?uSSLg3Lun5uWqRzZMvOHLa7qwcLWAx5ZhHGUBiHSQF2daEpGrJPckCdBd6Xl?=
 =?us-ascii?Q?JvdTSlEK8D3gDrzreYXlznmupp80jTwpLK68JQBl5q0XtJEG5LTsmCmD5mss?=
 =?us-ascii?Q?JMZXMtIMDRJxhKC2Ul5mBlwd028ZenDlSX2lLbjjT1z10t7aKTaT5PMf14v+?=
 =?us-ascii?Q?9DZWoGzFKvTaLgsAHYWWMgaNaVFnhKb7j1M3lHDdEocN068ZK18iEvFvI/bW?=
 =?us-ascii?Q?n6DD+ph4IEGh8njJdJFa/cor7YC99tdZ66+Sr3NTC6suZJkY48H4niHYStMj?=
 =?us-ascii?Q?arNml4CI6FWTU96P4H6FuEneXM7MWVflPmLVKgypI2HBM++X9c5i4v21TrS0?=
 =?us-ascii?Q?tg548olS+HLrHdtUlAIMeP0gCQS5vQOeIcKk/yfp3jYgcxe3GoVErqLZQrDP?=
 =?us-ascii?Q?q60b+z/d9nPUxvXvkIbXCK298K7LvOR8I0E2ahV7zpIqkMr8aaqhmHinX1y9?=
 =?us-ascii?Q?RMXLVUXkDCD0Y9JExXxIc9SaSv0h0U6KKnrODaNeK5V0gZjq4yXjPqybAX7P?=
 =?us-ascii?Q?+t9aKFHOPbO5Wx9CMR/vXUjvwBMMt0myVsuss9ungVTiApHiSsuCLpVUMUAB?=
 =?us-ascii?Q?InfRdD54tF59MgcZg3WJB/BmGaKFpiNGE/wi2Ez3beGZD9d7qRZD2tnDB09U?=
 =?us-ascii?Q?aPdwrBD5lC/oq1v/IY/JrrZ9Rd/ZovyXjYy7irSuk3G69fgWrENbmNSzlQb+?=
 =?us-ascii?Q?UWabD3NJkGwkbssvGZ+tihuXrTQBDiMQUDftGBs1Qz6cyKbTEGkTLc8R+HrN?=
 =?us-ascii?Q?o3WlCgZNK6llHNhquUF7VV+teVAg5ra4szCRnkAr5J3IzRy+hu+fK1hfrOM6?=
 =?us-ascii?Q?aHc8w9FGJ+k7oRKES6+6HZYYO8Qy9VKrylqENCDXO+KetpTK9idROWO3Aq2j?=
 =?us-ascii?Q?2uhDJVRiDLHVlcxUUY9wtZw5eNTP8WQwtQ1epvFdBYTkM7g7YGivgElNsete?=
 =?us-ascii?Q?/98Z2WlkC94SYqSd4MZZQL2s8WMcjzNbU/VCy5POSdoWhOOfNYzgUvMAjz1x?=
 =?us-ascii?Q?qC+wN6xZIOOCHq3YsNHYwXqg0JB4rNszN6a4cb6m?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 13b801d6-6b68-4841-53de-08dabb350974
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6308.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2022 11:42:49.5281
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m4Mw7Fz2yDmJDsH5C+0VBFynN838V3Rup1bm0JXeut0lPFQoOoxw6A/upXQLoDNso/IxjdFdCTgoVoK2YVyfaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7373
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--eA2WCFFyGaggxTCQ
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Mon, Oct 31, 2022 at 10:05:58AM +0000, John Thomson wrote:
> On Mon, 31 Oct 2022, at 02:36, Feng Tang wrote:
> >> > 
> >> > possibly relevant config options:
> >> > grep -E '(SLUB|SLAB)' .config
> >> > # SLAB allocator options
> >> > # CONFIG_SLAB is not set
> >> > CONFIG_SLUB=y
> >> > CONFIG_SLAB_MERGE_DEFAULT=y
> >> > # CONFIG_SLAB_FREELIST_RANDOM is not set
> >> > # CONFIG_SLAB_FREELIST_HARDENED is not set
> >> > # CONFIG_SLUB_STATS is not set
> >> > CONFIG_SLUB_CPU_PARTIAL=y
> >> > # end of SLAB allocator options
> >> > # CONFIG_SLUB_DEBUG is not set
> >> 
> >> Also not having CONFIG_SLUB_DEBUG enabled means most of the code the 
> >> patch/commit touches is not even active.
> >> Could this be some miscompile or code layout change exposing some 
> >> different bug, hmm.
> 
> Yes, it could be.
> 
> >> Is it any different if you do enable CONFIG_SLUB_DEBUG ?
> 
> No change
> 
> >> Or change to CONFIG_SLAB? (that would be really weird if not)
> 
> This boots fine
> 
> > I haven't found any clue from the code either, and I compiled
> > kernel with the config above and tested booting on an Alder-lake
> > desktop and a QEMU, which boot fine.
> >
> > Could you provide the full kernel config and demsg (in compressed
> > format if you think it's too big), so we can check more?
> 
> Attached
> 
> > Thanks,
> > Feng
> 
> vmlinux is bigger, and entry point is larger (0x8074081c vs 0x807407dc revert vs 0x8073fcbc),
> so that may be it? Or not?
> revert + SLUB_DEBUG + SLUB_DEBUG_ON is bigger still, but does successfully boot.
> vmlinux entry point is 0x8074705c

Thanks for prompt info!

As I can't reproduce it locally yet, could you help try 3 tests separately:
* change the O2/O3 compile option to O1
* try the attached 0001 patch (which cut part of commit)
* try attached 0001+0002 patch

Thanks!


- Feng




--eA2WCFFyGaggxTCQ
Content-Type: text/x-diff; charset="us-ascii"
Content-Disposition: attachment; filename="0001-reduced-slub-patch.patch"

From c52d8c8803562dd6d1d9d57f4f6e8b7e1ddf675d Mon Sep 17 00:00:00 2001
From: Feng Tang <feng.tang@intel.com>
Date: Mon, 31 Oct 2022 16:17:22 +0800
Subject: [PATCH 1/2] reduced slub patch

Signed-off-by: Feng Tang <feng.tang@intel.com>
---
 include/linux/slab.h |  2 ++
 mm/slab_common.c     |  3 +-
 mm/slub.c            | 73 +++++++++++++++++++++++++-------------------
 3 files changed, 46 insertions(+), 32 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index f2da0df0d58d..90877fcde70b 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -29,6 +29,8 @@
 #define SLAB_RED_ZONE		((slab_flags_t __force)0x00000400U)
 /* DEBUG: Poison objects */
 #define SLAB_POISON		((slab_flags_t __force)0x00000800U)
+/* Indicate a kmalloc slab */
+#define SLAB_KMALLOC		((slab_flags_t __force)0x00001000U)
 /* Align objs on cache lines */
 #define SLAB_HWCACHE_ALIGN	((slab_flags_t __force)0x00002000U)
 /* Use GFP_DMA memory */
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 87a28e298be8..33b1886b06eb 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -661,7 +661,8 @@ struct kmem_cache *__init create_kmalloc_cache(const char *name,
 	if (!s)
 		panic("Out of memory when creating slab %s\n", name);
 
-	create_boot_cache(s, name, size, flags, useroffset, usersize);
+	create_boot_cache(s, name, size, flags | SLAB_KMALLOC, useroffset,
+								usersize);
 	kasan_cache_create_kmalloc(s);
 	list_add(&s->list, &slab_caches);
 	s->refcount = 1;
diff --git a/mm/slub.c b/mm/slub.c
index ade3e851fc65..6fa3c24742b8 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -195,6 +195,13 @@ DEFINE_STATIC_KEY_FALSE(slub_debug_enabled);
 #endif
 #endif		/* CONFIG_SLUB_DEBUG */
 
+/* Structure holding parameters for get_partial() call chain */
+struct partial_context {
+	struct slab **slab;
+	gfp_t flags;
+	unsigned int orig_size;
+};
+
 static inline bool kmem_cache_debug(struct kmem_cache *s)
 {
 	return kmem_cache_debug_flags(s, SLAB_DEBUG_FLAGS);
@@ -994,7 +1001,8 @@ static int check_bytes_and_report(struct kmem_cache *s, struct slab *slab,
  *
  * 	A. Free pointer (if we cannot overwrite object on free)
  * 	B. Tracking data for SLAB_STORE_USER
- *	C. Padding to reach required alignment boundary or at minimum
+ *	C. Original request size for kmalloc object (SLAB_STORE_USER enabled)
+ *	D. Padding to reach required alignment boundary or at minimum
  * 		one word if debugging is on to be able to detect writes
  * 		before the word boundary.
  *
@@ -1310,7 +1318,7 @@ static inline int alloc_consistency_checks(struct kmem_cache *s,
 }
 
 static noinline int alloc_debug_processing(struct kmem_cache *s,
-					struct slab *slab, void *object)
+			struct slab *slab, void *object, int orig_size)
 {
 	if (s->flags & SLAB_CONSISTENCY_CHECKS) {
 		if (!alloc_consistency_checks(s, slab, object))
@@ -1587,7 +1595,7 @@ static inline
 void setup_slab_debug(struct kmem_cache *s, struct slab *slab, void *addr) {}
 
 static inline int alloc_debug_processing(struct kmem_cache *s,
-	struct slab *slab, void *object) { return 0; }
+	struct slab *slab, void *object, int orig_size) { return 0; }
 
 static inline void free_debug_processing(
 	struct kmem_cache *s, struct slab *slab,
@@ -2017,7 +2025,7 @@ static inline void remove_partial(struct kmem_cache_node *n,
  * it to full list if it was the last free object.
  */
 static void *alloc_single_from_partial(struct kmem_cache *s,
-		struct kmem_cache_node *n, struct slab *slab)
+		struct kmem_cache_node *n, struct slab *slab, int orig_size)
 {
 	void *object;
 
@@ -2027,7 +2035,7 @@ static void *alloc_single_from_partial(struct kmem_cache *s,
 	slab->freelist = get_freepointer(s, object);
 	slab->inuse++;
 
-	if (!alloc_debug_processing(s, slab, object)) {
+	if (!alloc_debug_processing(s, slab, object, orig_size)) {
 		remove_partial(n, slab);
 		return NULL;
 	}
@@ -2046,7 +2054,7 @@ static void *alloc_single_from_partial(struct kmem_cache *s,
  * and put the slab to the partial (or full) list.
  */
 static void *alloc_single_from_new_slab(struct kmem_cache *s,
-					struct slab *slab)
+					struct slab *slab, int orig_size)
 {
 	int nid = slab_nid(slab);
 	struct kmem_cache_node *n = get_node(s, nid);
@@ -2058,7 +2066,7 @@ static void *alloc_single_from_new_slab(struct kmem_cache *s,
 	slab->freelist = get_freepointer(s, object);
 	slab->inuse = 1;
 
-	if (!alloc_debug_processing(s, slab, object))
+	if (!alloc_debug_processing(s, slab, object, orig_size))
 		/*
 		 * It's not really expected that this would fail on a
 		 * freshly allocated slab, but a concurrent memory
@@ -2136,7 +2144,7 @@ static inline bool pfmemalloc_match(struct slab *slab, gfp_t gfpflags);
  * Try to allocate a partial slab from a specific node.
  */
 static void *get_partial_node(struct kmem_cache *s, struct kmem_cache_node *n,
-			      struct slab **ret_slab, gfp_t gfpflags)
+			      struct partial_context *pc)
 {
 	struct slab *slab, *slab2;
 	void *object = NULL;
@@ -2156,11 +2164,12 @@ static void *get_partial_node(struct kmem_cache *s, struct kmem_cache_node *n,
 	list_for_each_entry_safe(slab, slab2, &n->partial, slab_list) {
 		void *t;
 
-		if (!pfmemalloc_match(slab, gfpflags))
+		if (!pfmemalloc_match(slab, pc->flags))
 			continue;
 
 		if (kmem_cache_debug(s)) {
-			object = alloc_single_from_partial(s, n, slab);
+			object = alloc_single_from_partial(s, n, slab,
+							pc->orig_size);
 			if (object)
 				break;
 			continue;
@@ -2171,7 +2180,7 @@ static void *get_partial_node(struct kmem_cache *s, struct kmem_cache_node *n,
 			break;
 
 		if (!object) {
-			*ret_slab = slab;
+			*pc->slab = slab;
 			stat(s, ALLOC_FROM_PARTIAL);
 			object = t;
 		} else {
@@ -2195,14 +2204,13 @@ static void *get_partial_node(struct kmem_cache *s, struct kmem_cache_node *n,
 /*
  * Get a slab from somewhere. Search in increasing NUMA distances.
  */
-static void *get_any_partial(struct kmem_cache *s, gfp_t flags,
-			     struct slab **ret_slab)
+static void *get_any_partial(struct kmem_cache *s, struct partial_context *pc)
 {
 #ifdef CONFIG_NUMA
 	struct zonelist *zonelist;
 	struct zoneref *z;
 	struct zone *zone;
-	enum zone_type highest_zoneidx = gfp_zone(flags);
+	enum zone_type highest_zoneidx = gfp_zone(pc->flags);
 	void *object;
 	unsigned int cpuset_mems_cookie;
 
@@ -2230,15 +2238,15 @@ static void *get_any_partial(struct kmem_cache *s, gfp_t flags,
 
 	do {
 		cpuset_mems_cookie = read_mems_allowed_begin();
-		zonelist = node_zonelist(mempolicy_slab_node(), flags);
+		zonelist = node_zonelist(mempolicy_slab_node(), pc->flags);
 		for_each_zone_zonelist(zone, z, zonelist, highest_zoneidx) {
 			struct kmem_cache_node *n;
 
 			n = get_node(s, zone_to_nid(zone));
 
-			if (n && cpuset_zone_allowed(zone, flags) &&
+			if (n && cpuset_zone_allowed(zone, pc->flags) &&
 					n->nr_partial > s->min_partial) {
-				object = get_partial_node(s, n, ret_slab, flags);
+				object = get_partial_node(s, n, pc);
 				if (object) {
 					/*
 					 * Don't check read_mems_allowed_retry()
@@ -2259,8 +2267,7 @@ static void *get_any_partial(struct kmem_cache *s, gfp_t flags,
 /*
  * Get a partial slab, lock it and return it.
  */
-static void *get_partial(struct kmem_cache *s, gfp_t flags, int node,
-			 struct slab **ret_slab)
+static void *get_partial(struct kmem_cache *s, int node, struct partial_context *pc)
 {
 	void *object;
 	int searchnode = node;
@@ -2268,11 +2275,11 @@ static void *get_partial(struct kmem_cache *s, gfp_t flags, int node,
 	if (node == NUMA_NO_NODE)
 		searchnode = numa_mem_id();
 
-	object = get_partial_node(s, get_node(s, searchnode), ret_slab, flags);
+	object = get_partial_node(s, get_node(s, searchnode), pc);
 	if (object || node != NUMA_NO_NODE)
 		return object;
 
-	return get_any_partial(s, flags, ret_slab);
+	return get_any_partial(s, pc);
 }
 
 #ifdef CONFIG_PREEMPTION
@@ -2996,11 +3003,12 @@ static inline void *get_freelist(struct kmem_cache *s, struct slab *slab)
  * already disabled (which is the case for bulk allocation).
  */
 static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
-			  unsigned long addr, struct kmem_cache_cpu *c)
+			  unsigned long addr, struct kmem_cache_cpu *c, unsigned int orig_size)
 {
 	void *freelist;
 	struct slab *slab;
 	unsigned long flags;
+	struct partial_context pc;
 
 	stat(s, ALLOC_SLOWPATH);
 
@@ -3114,7 +3122,10 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 
 new_objects:
 
-	freelist = get_partial(s, gfpflags, node, &slab);
+	pc.flags = gfpflags;
+	pc.slab = &slab;
+	pc.orig_size = orig_size;
+	freelist = get_partial(s, node, &pc);
 	if (freelist)
 		goto check_new_slab;
 
@@ -3130,7 +3141,7 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 	stat(s, ALLOC_SLAB);
 
 	if (kmem_cache_debug(s)) {
-		freelist = alloc_single_from_new_slab(s, slab);
+		freelist = alloc_single_from_new_slab(s, slab, orig_size);
 
 		if (unlikely(!freelist))
 			goto new_objects;
@@ -3162,6 +3173,7 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 		 */
 		if (s->flags & SLAB_STORE_USER)
 			set_track(s, freelist, TRACK_ALLOC, addr);
+
 		return freelist;
 	}
 
@@ -3204,7 +3216,7 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
  * pointer.
  */
 static void *__slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
-			  unsigned long addr, struct kmem_cache_cpu *c)
+			  unsigned long addr, struct kmem_cache_cpu *c, unsigned int orig_size)
 {
 	void *p;
 
@@ -3217,7 +3229,7 @@ static void *__slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 	c = slub_get_cpu_ptr(s->cpu_slab);
 #endif
 
-	p = ___slab_alloc(s, gfpflags, node, addr, c);
+	p = ___slab_alloc(s, gfpflags, node, addr, c, orig_size);
 #ifdef CONFIG_PREEMPT_COUNT
 	slub_put_cpu_ptr(s->cpu_slab);
 #endif
@@ -3302,7 +3314,7 @@ static __always_inline void *slab_alloc_node(struct kmem_cache *s, struct list_l
 
 	if (!USE_LOCKLESS_FAST_PATH() ||
 	    unlikely(!object || !slab || !node_match(slab, node))) {
-		object = __slab_alloc(s, gfpflags, node, addr, c);
+		object = __slab_alloc(s, gfpflags, node, addr, c, orig_size);
 	} else {
 		void *next_object = get_freepointer_safe(s, object);
 
@@ -3769,7 +3781,7 @@ int kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
 			 * of re-populating per CPU c->freelist
 			 */
 			p[i] = ___slab_alloc(s, flags, NUMA_NO_NODE,
-					    _RET_IP_, c);
+					    _RET_IP_, c, s->object_size);
 			if (unlikely(!p[i]))
 				goto error;
 
@@ -5031,10 +5043,9 @@ static int add_location(struct loc_track *t, struct kmem_cache *s,
 		if (pos == end)
 			break;
 
-		caddr = t->loc[pos].addr;
-		chandle = t->loc[pos].handle;
+		caddr = l->addr;
+		chandle = l->handle;
 		if ((track->addr == caddr) && (handle == chandle)) {
-
 			l = &t->loc[pos];
 			l->count++;
 			if (track->when) {
-- 
2.34.1


--eA2WCFFyGaggxTCQ
Content-Type: text/x-diff; charset="us-ascii"
Content-Disposition: attachment;
	filename="0002-reorder-the-partial_context-initialization.patch"

From 00d06db374449a3151d94d11f7c9bd62d4de0d6b Mon Sep 17 00:00:00 2001
From: Feng Tang <feng.tang@intel.com>
Date: Mon, 31 Oct 2022 16:19:12 +0800
Subject: [PATCH 2/2] reorder the partial_context initialization

Signed-off-by: Feng Tang <feng.tang@intel.com>
---
 mm/slub.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 6fa3c24742b8..4265d293f4dd 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3010,6 +3010,11 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 	unsigned long flags;
 	struct partial_context pc;
 
+	pc.flags = gfpflags;
+	pc.slab = &slab;
+	pc.orig_size = orig_size;
+	barrier();
+
 	stat(s, ALLOC_SLOWPATH);
 
 reread_slab:
@@ -3122,9 +3127,6 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 
 new_objects:
 
-	pc.flags = gfpflags;
-	pc.slab = &slab;
-	pc.orig_size = orig_size;
 	freelist = get_partial(s, node, &pc);
 	if (freelist)
 		goto check_new_slab;
-- 
2.34.1


--eA2WCFFyGaggxTCQ--
