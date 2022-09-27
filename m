Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A98C65EB857
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 05:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231224AbiI0DLm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 23:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231211AbiI0DKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 23:10:41 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D109B3F30F
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 20:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664247859; x=1695783859;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=uaPcHPTilp8O2BL8QJZmJr89QOaWfqVxKMnLlwNJ3yQ=;
  b=DSysgW9XnbU+lyglhbt9gkKjrJ0TsmuS+65/XE/mmt1S6RN1OIL80+QY
   18U4dqLM1l66ENXWx0Ak31H6H0lI6c0gthYoh8Fzqb8xWIAx3+3SPYw+H
   Oh1vMC64DpHu5v8lLC9hBy57IgsL7zsSr1zmyZ1FzHx9NLCYXIhe4gqGR
   Fs9QTm5VZARTmUUg6LYYIKRRUSk1i2I7LMvip03lmvft22PNXnrgko1oP
   URP/3Z7zLaSgujb6mt0Mq7qeHgdcraZwIVCZtfde5vQDhEbIdzHrp8IHN
   n5ZkvK4pAQQ2depeVgT+TOLjMAeKG6D7pCbLPkglJQBac1e21DXCD4frU
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="298799668"
X-IronPort-AV: E=Sophos;i="5.93,348,1654585200"; 
   d="scan'208";a="298799668"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2022 20:04:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="621347151"
X-IronPort-AV: E=Sophos;i="5.93,348,1654585200"; 
   d="scan'208";a="621347151"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga002.jf.intel.com with ESMTP; 26 Sep 2022 20:04:18 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 26 Sep 2022 20:04:18 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 26 Sep 2022 20:04:17 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 26 Sep 2022 20:04:17 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 26 Sep 2022 20:04:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nyk3C8oisTw5cuiEGgxhH/bHPAep8SDakJy/AavfPxXCXxP2PfH92sLD6cxZBrnu9W/HNZj+TP3K3WiomboBrzvvCn8isXLLcJa+1/u7v5yUsCUyZLU2KbwSpmQqMf1QLcbsvj84RRhqSPpxeKKGQqgoVP/dEbboWCuT0CvCPQR53Vd3Mg68EVDDmMPK+Ta5qoLbYeX0C8iqpK7fAyv3QS2z8bXYDZolnH2cc57UMEyZ7kAzDtAAHQvl0dgLkl2aU7wCzxT8EcUHWpo9WMHCjbhUsyzE2/TwaSRvtVVBxFOHQNLh32xXS/iszxUOjbPmO+vj6WXs0kzrI+fPOORTZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JYNywAhiHNg/H9rXQvueIznLWc9QKsiLPJCoqvKn22s=;
 b=GHPHIl99ENiSYGeh8kwPiB4mF7KJiKY2JmNjUQKryFZh45Fz68+QPJnkwKptTw0fSLg21nBICwwkSV892k6Z9PJUokqAGv1n8mNG89QRiVGw0KIyJTm+up86Mmj/yl2tveT2gDjtwsjLi36XHZUS11QGnkCbGdGKWMyuvqC89CYLdSahDPVZMWzd9t2Lzxu/UqnvksS2hYQrkK29RajG3M5E53vv2fZkvqVmHPS2TF0td3rHOKr0Oo0sI+1A2M8gxsJJGGKfpiyxV+z64ZSeFXyGQiV5sSFh9tjhh5L/wdVvARvTl1Db48TUEVvL6hWQOrwcNwvssjyumWyx5L+VWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by SN7PR11MB7042.namprd11.prod.outlook.com (2603:10b6:806:299::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Tue, 27 Sep
 2022 03:04:14 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::ccec:43dc:464f:4100]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::ccec:43dc:464f:4100%7]) with mapi id 15.20.5654.025; Tue, 27 Sep 2022
 03:04:14 +0000
Date:   Tue, 27 Sep 2022 11:03:49 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Andrey Konovalov <andreyknvl@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>
CC:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Linux Memory Management List" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        "Sang, Oliver" <oliver.sang@intel.com>
Subject: Re: [PATCH v6 3/4] mm: kasan: Add free_meta size info in struct
 kasan_cache
Message-ID: <YzJoFZ8u7eTIJWVW@feng-clx>
References: <20220913065423.520159-1-feng.tang@intel.com>
 <20220913065423.520159-4-feng.tang@intel.com>
 <CA+fCnZdFi471MxQG9RduQcBZWR10GCqxyNkuaDXzX6y4zCaYAQ@mail.gmail.com>
 <Yyr9ZZnVPgr4GHYQ@feng-clx>
 <CA+fCnZdUF3YiNpy10=xOJmPVbftaJr76wB5E58v0W_946Uketw@mail.gmail.com>
 <YzA68cSh5Uuh5pjZ@feng-clx>
 <CA+fCnZd4SD4rSD5yWogwvYm0h7YZ73CXFNCSd8PVOSeNXdWR1Q@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CA+fCnZd4SD4rSD5yWogwvYm0h7YZ73CXFNCSd8PVOSeNXdWR1Q@mail.gmail.com>
X-ClientProxiedBy: SG2PR06CA0238.apcprd06.prod.outlook.com
 (2603:1096:4:ac::22) To MN0PR11MB6304.namprd11.prod.outlook.com
 (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|SN7PR11MB7042:EE_
X-MS-Office365-Filtering-Correlation-Id: c74fc780-4772-4a3f-5d1a-08daa034f579
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xs+f/+e3BZ43LSc2+HZwLcN6VoqPfdZBKzRE5lwA57ah6SrCUSTc425Smg1qNfByzl2YcJZnPlfF9vfHH1OcyT0Epd6m3SOVwP9oIbBEesxD6TUyyTGy1CUfmU59TvRqzBFV0PJ7PFb1FP5oQTrJRa3SXmOU2JuWNry0eqQ16AvsPozuChpayJRoOPlQI4fXL833D25AzBAzSeKhgxILWBLl5ezx4Sbk+K/Th7iFhlz5Ap/5vlgmcmNT8NpZtUb8Po+PQEc56JgsJ84AX3sLuYRnuJx36XFDZoldGFcDmHFJxhm79n5/1o2fnKl1WAwwTJCRwqWmtH8Kb9fVpRryItZZAnEtZnzjJ59X30R9v2d2+1YOQ3LvM6guET8wGVNprpnVslskYf0kSFsByIRAruk8Q21TPZwQwRcWs1s30HQeEL3lHrsxMoFT53GBrUpr5MEJW7gZuBSmz49/D3d/qZ87PvsJ7LVFU6ys9G9GngkeeQaJ7YdiiyGXbtMs9kO7RVt81QZ+uJxFsrfuQLTMPKPsxX2y9zKm/Vdmm5yM1Xt0xGqPRv3YzKlkWoX7AzGP5L/hQQOAG1CKL+taNmzAP52/N35/i8QhNgzZKoAl2htwPM3s0GVol/R/4a8DzGSzAtxypj/UaGbDVrWDJaGqbAbMkaoJHt5ToH5jdL/xiXegszKja/NoUR8ooaGf2kXUkqiIag62sWzWrQC4tKAgZK+n/n9KBGqdqk+ZBzDtAHK73hMBrCtXg7uzDQNjBLO0IVinZgjQtbgfFqBcVWNyUQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(366004)(39860400002)(136003)(346002)(396003)(376002)(451199015)(33716001)(7416002)(41300700001)(5660300002)(2906002)(8936002)(44832011)(66476007)(38100700002)(4326008)(66946007)(8676002)(54906003)(110136005)(478600001)(316002)(66556008)(6486002)(966005)(6666004)(186003)(107886003)(6506007)(82960400001)(86362001)(9686003)(83380400001)(53546011)(6512007)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XFsyP1iPrjyuMBGFPA+hoS8ucrtRcigeM8RVL3v2+wh4tZweA47TiSUWOLkX?=
 =?us-ascii?Q?ESnYraHhBnqyd5W3cg8zshm/SMCCAejoeKRayVWH56fQGNMjJtkH5lfiXat8?=
 =?us-ascii?Q?87iPeRKEPRIFE6UjjtvkuXWlmqOKrgdBQM14PFgfKjKHqC8oJnFjgjQsRvi3?=
 =?us-ascii?Q?JkqPHoj5p8MmZ80fvdEyaSnQeSZsuO9HLiH+S++1C/2+jcTxPJhYSuDzDgLh?=
 =?us-ascii?Q?JaF0RwFgSob6qV4bKDzI9FgwE9H4uSswSDBf15vAbhkxeJHwd4wTpKfvkfQt?=
 =?us-ascii?Q?s5dS81nWfKHqEL1Le1ACyTzKt+rIEBYTSzPczq/C/zLFL0gk1TSewxyp9DAs?=
 =?us-ascii?Q?8kALZtKnuRdRrxBFIMUebkMaTRAfv0LxwUfOWwHmNG8SNp1/4t/r+vUhbHcB?=
 =?us-ascii?Q?2mHR/feOjN3BpzwKhT9DhN4h6c+lFlIqSmfvr2OoiQVIz5D9ERnLOK99hrzx?=
 =?us-ascii?Q?2SgoEciuVIGPL5LdibhFVE8RnkKAhxXpYGYbAd0r12ZsMm3FY9XzSSNhBVW0?=
 =?us-ascii?Q?4Kbj+pWjJLntKQPC4UisNZHJe/bV4CFFVGqzZtYOlMJ61cqRRIXSIibUMlzm?=
 =?us-ascii?Q?ml6G+A1I5EHschPsRKqkRTw+woRisGuIcCwWrT0+ICSSsiHJogjUDxyYg1Zs?=
 =?us-ascii?Q?a8Ufr+sFMhKUg2//RJKmq8SjDLOsMbtKa/1RUj/5P+nmC6OS8knnm5pIK/hE?=
 =?us-ascii?Q?uARsdlIOewxNlNIwWRmof38Z11PovCbjU9otfDo2iFdwtb/IRWpwe8qsl6zN?=
 =?us-ascii?Q?tIa6xjWCCc6+DeW1GqqaM429dgu+WsAvx+2nddZA9Gzy6h4JYS/wSMSfiqCu?=
 =?us-ascii?Q?6mmdPOz8RPzMZnBgtylVFfEqLK/O8aTaSBUpbGOwCnxGqCnDeQaKvVcaHpRj?=
 =?us-ascii?Q?eoMKF+1JUlEGhZD7BT6uobtd+aLKev0bPZV/9HtuMP1ex2JBo7a+fr8Unnmb?=
 =?us-ascii?Q?nWRpLOQJs+LmSU2yGswwC4rHENMpc3G9wSSqkFYuesySBQ8wC3DbyDoUKXG5?=
 =?us-ascii?Q?ubpEf97N10MehimppmWeAMKBnbHxiCFPkvWQTy9zwDvASH5mKbUlIlXZjHD5?=
 =?us-ascii?Q?yiTuDxwUy9/uoalMpcOrOlBODNuxwPWEc3dWGkwNzgC1uUkhWsDYg/MQ0Xqg?=
 =?us-ascii?Q?iOcsWDP/d5WXHlz2hPlvp3BvcKI5c/xWN4n37/+hiFQNhxU9ygAzeuoClSw+?=
 =?us-ascii?Q?YB9wqQYpTaQo80PaPBwF6oFAlmiizcPYN1zb3vqxdaU1D06wimNgIk39APfo?=
 =?us-ascii?Q?yOEDMSPhFvbp+TWbQOiJbfw3xpxeNLhfkJUVR2anrN+lplIC8+RQEBOrRIGP?=
 =?us-ascii?Q?IPnZTUV4jmEM4rNH7eUiAGNSzuaQM+uj1JHWfZUSKJM5La037MuYlD0mJHd4?=
 =?us-ascii?Q?OiuOzHRFHEXlhN2nZk54cF9pjtEz64BVkWDdQjvtjFdLWlDfPkFOJmad5SHB?=
 =?us-ascii?Q?jYdiMJgBk6wKImt5fnoGNhGRfQZTbKuMa0cdDh/zL65qCiVepsElM6LJg+I/?=
 =?us-ascii?Q?k0N6Kq95JI1sULALQK3P5Sa7xkQJOac2BZY80Rf7apGGa+dKwevr46jlFDiJ?=
 =?us-ascii?Q?vVBlT9VApsu6YomSt/LAm5FO/QIbgF0NCJsRgane?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c74fc780-4772-4a3f-5d1a-08daa034f579
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2022 03:04:14.5023
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WXcSYqjJNYb9BXMUus3zMXGljp0zkmxg+QxSjgll4l3zTrItyAliCi/wrvIbkJN6fWEdRpHjz6D9QKquYrIcCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7042
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 26, 2022 at 12:31:37AM +0800, Andrey Konovalov wrote:
> On Sun, Sep 25, 2022 at 1:27 PM Feng Tang <feng.tang@intel.com> wrote:
> >
> > > [1] https://lore.kernel.org/linux-mm/c7b316d30d90e5947eb8280f4dc78856a49298cf.1662411799.git.andreyknvl@google.com/
> >
> > I noticed this has been merged to -mm tree's 'mm-everything' branch,
> > so following is the patch againt that. Thanks!
> >
> > One thing I'm not very sure is, to check 'in-object' kasan's meta
> > size, I didn't check 'alloc_meta_offset', as from the code reading
> > the alloc_meta is never put inside slab object data area.
> 
> Yes, this is correct.
> 
> > @@ -1042,7 +1042,7 @@ static int check_pad_bytes(struct kmem_cache *s, struct slab *slab, u8 *p)
> >                 /* We also have user information there */
> >                 off += 2 * sizeof(struct track);
> >
> > -       off += kasan_metadata_size(s);
> > +       off += kasan_metadata_size(s, false);
> >
> >         if (size_from_object(s) == off)
> >                 return 1;
> 
> Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>
 
Thank you!

I made a formal patch, which is based on your latest kasan patchset
in -mm tree

Thanks,
Feng

---
From ba4cfd81b86c3339523b467451baa5e87ca1c9f8 Mon Sep 17 00:00:00 2001
From: Feng Tang <feng.tang@intel.com>
Date: Sun, 25 Sep 2022 15:37:31 +0800
Subject: [PATCH] mm: kasan: Extend kasan_metadata_size() to also cover
 in-object size

When kasan is enabled for slab/slub, it may save kasan' free_meta
data in the former part of slab object data area in slab object's
free path, which works fine.

There is ongoing effort to extend slub's debug function which will
redzone the latter part of kmalloc object area, and when both of
the debug are enabled, there is possible conflict, especially when
the kmalloc object has small size, as caught by 0Day bot [1].

To solve it, slub code needs to know the in-object kasan's meta
data size. Currently, there is existing kasan_metadata_size()
which returns the kasan's metadata size inside slub's metadata
area, so extend it to also cover the in-object meta size by
adding a boolean flag 'in_object'.

There is no functional change to existing code logic.

[1]. https://lore.kernel.org/lkml/YuYm3dWwpZwH58Hu@xsang-OptiPlex-9020/
Reported-by: kernel test robot <oliver.sang@intel.com>
Signed-off-by: Feng Tang <feng.tang@intel.com>
Suggested-by: Andrey Konovalov <andreyknvl@gmail.com>
Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>
---
 include/linux/kasan.h |  5 +++--
 mm/kasan/generic.c    | 19 +++++++++++++------
 mm/slub.c             |  4 ++--
 3 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index d811b3d7d2a1..96c9d56e5510 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -302,7 +302,7 @@ static inline void kasan_unpoison_task_stack(struct task_struct *task) {}
 
 #ifdef CONFIG_KASAN_GENERIC
 
-size_t kasan_metadata_size(struct kmem_cache *cache);
+size_t kasan_metadata_size(struct kmem_cache *cache, bool in_object);
 slab_flags_t kasan_never_merge(void);
 void kasan_cache_create(struct kmem_cache *cache, unsigned int *size,
 			slab_flags_t *flags);
@@ -315,7 +315,8 @@ void kasan_record_aux_stack_noalloc(void *ptr);
 #else /* CONFIG_KASAN_GENERIC */
 
 /* Tag-based KASAN modes do not use per-object metadata. */
-static inline size_t kasan_metadata_size(struct kmem_cache *cache)
+static inline size_t kasan_metadata_size(struct kmem_cache *cache,
+						bool in_object)
 {
 	return 0;
 }
diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
index d8b5590f9484..b076f597a378 100644
--- a/mm/kasan/generic.c
+++ b/mm/kasan/generic.c
@@ -450,15 +450,22 @@ void kasan_init_object_meta(struct kmem_cache *cache, const void *object)
 		__memset(alloc_meta, 0, sizeof(*alloc_meta));
 }
 
-size_t kasan_metadata_size(struct kmem_cache *cache)
+size_t kasan_metadata_size(struct kmem_cache *cache, bool in_object)
 {
+	struct kasan_cache *info = &cache->kasan_info;
+
 	if (!kasan_requires_meta())
 		return 0;
-	return (cache->kasan_info.alloc_meta_offset ?
-		sizeof(struct kasan_alloc_meta) : 0) +
-		((cache->kasan_info.free_meta_offset &&
-		  cache->kasan_info.free_meta_offset != KASAN_NO_FREE_META) ?
-		 sizeof(struct kasan_free_meta) : 0);
+
+	if (in_object)
+		return (info->free_meta_offset ?
+			0 : sizeof(struct kasan_free_meta));
+	else
+		return (info->alloc_meta_offset ?
+			sizeof(struct kasan_alloc_meta) : 0) +
+			((info->free_meta_offset &&
+			info->free_meta_offset != KASAN_NO_FREE_META) ?
+			sizeof(struct kasan_free_meta) : 0);
 }
 
 static void __kasan_record_aux_stack(void *addr, bool can_alloc)
diff --git a/mm/slub.c b/mm/slub.c
index ce8310e131b3..a75c21a0da8b 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -887,7 +887,7 @@ static void print_trailer(struct kmem_cache *s, struct slab *slab, u8 *p)
 	if (s->flags & SLAB_STORE_USER)
 		off += 2 * sizeof(struct track);
 
-	off += kasan_metadata_size(s);
+	off += kasan_metadata_size(s, false);
 
 	if (off != size_from_object(s))
 		/* Beginning of the filler is the free pointer */
@@ -1042,7 +1042,7 @@ static int check_pad_bytes(struct kmem_cache *s, struct slab *slab, u8 *p)
 		/* We also have user information there */
 		off += 2 * sizeof(struct track);
 
-	off += kasan_metadata_size(s);
+	off += kasan_metadata_size(s, false);
 
 	if (size_from_object(s) == off)
 		return 1;
-- 
2.34.1




