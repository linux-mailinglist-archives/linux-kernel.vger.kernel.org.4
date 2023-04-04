Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 964696D5657
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 04:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231552AbjDDCAD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 22:00:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjDDCAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 22:00:01 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A95391734
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 19:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680573600; x=1712109600;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=lz+cFgiNl2jmsg/ioGi4kX3Tvi9jBjkmgO6ufsahHCQ=;
  b=UsWIVhL0WHXrFjrPQZZ79HEg8b3FDyQ3xDWGhNHkwz3Es9ajMYzKmoeH
   CVPWQFFjKVB0WYzMImYqNwtMlnX9JIw2r6qTCy6DDGhO1aD6RR1AFbJiN
   5W/gz4A3nfhOC2+VSJkq8stw/n/HauaowO88DW6p4KgsxTs4miyIowIJ/
   NPZY0z8iW6I5Ai/1gVYn5LqU5kEF5u/E9CURv5aA6BZqkM0LNJtESxsmm
   MDnbGDpA4Ued+M1/98BevWVlN8rdrQBHC/mvIETfvaDZ9Q3Z3XTE6aPmV
   dT2mq1BR7gnns4LljjBV6hiayZZzgrTamfyqY9fN+bGkMQSElJfgB7jfB
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10669"; a="326083352"
X-IronPort-AV: E=Sophos;i="5.98,316,1673942400"; 
   d="scan'208";a="326083352"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2023 19:00:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10669"; a="686184670"
X-IronPort-AV: E=Sophos;i="5.98,316,1673942400"; 
   d="scan'208";a="686184670"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga002.jf.intel.com with ESMTP; 03 Apr 2023 19:00:00 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 3 Apr 2023 18:59:59 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 3 Apr 2023 18:59:59 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Mon, 3 Apr 2023 18:59:59 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.108)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Mon, 3 Apr 2023 18:59:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nDTrY2gMZ07xjXE195mq+SvopS/163r09F5ucMMqkydBNsTxG0XinG/G8QzKIlDoXUI+f0XMZifu0fzyEP3RrIE1kdVOYJzuV76oFl3AvrGzT748eUyksj0i+nLiLZ79ZUCKrpuWNomnfMGPJZM0iqFM6gauNCchfNtei6eMRUBkznEoUOc5jjphINtac8P8RoxqqSycsQFrY4+tUj+iQLuzaEge2L3hZxx2B1SP1HPY9G+7+REuQWwv0QmE14+70qextSrxJLfUO7izM8O9wdPjwH4Vw3Wjxz/T9U2F12OfyUKHkDnzf3weBfy2R76ENp5EbrLGky2vQSdH1evo1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AuYtkkN5+S31W+0OR635lU5SiURXXAQtgAETYxRwDvc=;
 b=fIfKSBziID7mws8JUFontJiz60/4MV0H2p6uh+ji78AG5k8tlYOK4iLsWNUg77j72EU429uETQBQ8Ao2TK3F+DMHby6PUlPosV/RIirlbogqR61/Reaul0hIGlAKE8e8kHn+JbwnzcSCtSbjyWqHX4sxuYsgx/gloNRmi0e6MGAwswmzU5c5MTO8ZMZ2dwqLMtUrH+pOWej+kHmX9XRE8Bm0LTVaBXccH0zAK461J1M49eeR8ZyLnOdCabcKn0dwuAVTXCBO3TCMVWuj8QKc0KOGAfa4JOUE59n+xYLLu98j+ZrNHUG+FZXdTeeKbpK7WUhMcAGa/SrW4Igxjh53Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18)
 by MW3PR11MB4537.namprd11.prod.outlook.com (2603:10b6:303:5d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.29; Tue, 4 Apr
 2023 01:59:57 +0000
Received: from BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::78d1:41fe:eae2:1f6d]) by BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::78d1:41fe:eae2:1f6d%7]) with mapi id 15.20.6254.034; Tue, 4 Apr 2023
 01:59:57 +0000
Date:   Tue, 4 Apr 2023 09:59:49 +0800
From:   Aaron Lu <aaron.lu@intel.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] sched: Fix performance regression introduced by
 mm_cid
Message-ID: <20230404015949.GA14939@ziqianlu-desk2>
References: <20230403181342.210896-1-mathieu.desnoyers@efficios.com>
 <230301bb-58db-650d-8eb3-8915151685d1@efficios.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <230301bb-58db-650d-8eb3-8915151685d1@efficios.com>
X-ClientProxiedBy: SG2PR02CA0129.apcprd02.prod.outlook.com
 (2603:1096:4:188::19) To BYAPR11MB3062.namprd11.prod.outlook.com
 (2603:10b6:a03:92::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3062:EE_|MW3PR11MB4537:EE_
X-MS-Office365-Filtering-Correlation-Id: f8bdecd2-5643-46d0-ff2f-08db34b04a05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EPtdaURZuk54unZ24HpqqnJ20dSI3yiUaIH8JWooMhmnYiIe4Nk4n2VwDiJJVZqHt/Y4ARLG8YyEnrC8jw5SURh/MMe0s6j6xyktngB4CPw63oO+f3i/uprAecPbKz9gnPuoeVUIfdqm6cOr+AfmGJwF2QjkPAtEcoukxT0r0h9sgUbXil7JxIuOpeVaZi15AnviK1MCARjLSD4TEiqlKdiDyfOHEQKCxImRBo85QT84LqhYtTlXv56B46DtaCSeZ0c0xuNhbxE/zi1I5xIYylFeyIketGDWEBLpPim0j4UBy+RaVSjNA1+XL6tS4zwjPJCxGtjsZz92kNN0Bw7StGKZo6xYialbRiLC1xLfEapuIDvZ5YuFS6e4wkoU9CjyY2F9xeCE43AfSx/dJhmh5rAySkapBPF1f1muZisYW1wxAJB469X3/x+4dXyl7BZoH93FlYbHk10rutf6pghQCrkvbGicae2oKAps+lGqUMzacTGqesRbDcW4IeMbkNjAmsuuf4GYPoHta1azKNmG2l+JIhzUCP/675IfE5v5H5V/hP3GoFCnAVYOpx5YpjNg
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3062.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(136003)(376002)(346002)(39860400002)(366004)(396003)(451199021)(4326008)(33656002)(6486002)(66946007)(66476007)(316002)(66556008)(8676002)(41300700001)(478600001)(8936002)(33716001)(2906002)(44832011)(82960400001)(86362001)(5660300002)(38100700002)(53546011)(186003)(6666004)(6512007)(6506007)(1076003)(83380400001)(9686003)(6916009)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?i6JeqnUU+V8dOS1EHCd8XRXqwwMQRBd9yvR0dhGh+HW2MBAFdaEjDgwN+DOc?=
 =?us-ascii?Q?/D/1LCupi0AjZ4GrtgzW+aLcKd/cGSEBAqaMQUUzWMicV/l620dbDaYuv4Be?=
 =?us-ascii?Q?sxeIm9QrqohAVVW6O/04wrn2YhiH4/4hMnKslQCuToX3N+hPeTY4itI5cv6U?=
 =?us-ascii?Q?dzpr2tlTtO3ezj/OVKSsvMAsr8XcQf+yW7oy42FGFGs88yN91AkDd5D8B6Fm?=
 =?us-ascii?Q?H/S4uOOiJa5E8q2Jb8fpiboZVeN+7EiRUkk8oZIDh5C3Vw4920PdhaRx3zJk?=
 =?us-ascii?Q?ZcrcU0RNkNyABRzm37fjEjPYB4nCkNZAnuH9QSqob7ON0scQ0We4ybpAmDBK?=
 =?us-ascii?Q?FxjqFcsdHF3I7dFi9TApxyfAGsb7VDN2Mf/ayAUy8NHdKET+V0OWxEFJGw8y?=
 =?us-ascii?Q?Z9wk7xwUgWdg0ZBoCNzS5dXyyVYIYlj3UKcpnJcXH4aQavnWjxZtIpd8fmM/?=
 =?us-ascii?Q?oi0FGpYyfiOqF+OrXjY373a+1GKWdmlWNvbprmjLk0pD1ydF9Pj1iCBAxelv?=
 =?us-ascii?Q?4wkZUzN7bYFKJjCmAdpfwpjpG3+p68/4P0HS3cqC9qVTA8fXSMRE1oMpbAZu?=
 =?us-ascii?Q?9bSvx+SiIPINIQpEsuW3FUzL0Dd7AsbKgXtj0oWDJU46RzQIHr8foI2Yybya?=
 =?us-ascii?Q?rbAJTZRUKd6sGPrRh8Nw1roHgdrqaWAoOUZnp9gr1lavwiK+8i+yFyk3VsYE?=
 =?us-ascii?Q?pC3nzWlTBOL0k5gbMhvqXxo7lE0+2YHzU097EBmQtMc74vlwNifqL0rPJ/MT?=
 =?us-ascii?Q?TAmuV/B8bTTwgxpiQkeWnkcRfV60mnx8W9QLkwqvmxeCTxNaDOKPk88CECdR?=
 =?us-ascii?Q?te1F9tC0ao4dG7px2uIOzzAuNGDrCi/5srylC/o09CMKmZpTdLtCUNe88nYw?=
 =?us-ascii?Q?LOpirP83vZN4Y0I2XH2pNo2sJRpDl/qLPMAZ6gBUN4+FSK38AOyBOgWxK5tF?=
 =?us-ascii?Q?OSAItOkHDenNTFPI2NP/coJKKq9pcc6ut2gA9tjqJTZpMrVA3AOVVefkaBdS?=
 =?us-ascii?Q?Y8S3PoIRnzQA1nNVkWD0gMvFTUTQNK5l139RqHf0ig/Es62WmrQZu/TYHK2S?=
 =?us-ascii?Q?o2Q3qXxvym6QC4ZUPKqFUV+2Yvz86G/F1Mf9Nb3M3kmxRKowr1fl1gFB14qv?=
 =?us-ascii?Q?KbL7R3XFjia82n6WZl3zIeTZktm1OQ6OLCjX1zva+CPRso9z12YlKhREed1H?=
 =?us-ascii?Q?ABvBiBqBxIfF9iGskvbi8JpRZv6RBYrSkZH+ZF0Ow+OyOPk9wmq2LvYM1ips?=
 =?us-ascii?Q?8YEt8eCWQk2UXFVDiIUC4mt4wPjQQBSCbSKxnVnkR97BpJIaHWPr9CGXgHbI?=
 =?us-ascii?Q?WUbMA3EVI7DiSQlmF15YZp1k+6Utqy8jMrM7kshCtb2FI7LIL2KQXxMfFl1h?=
 =?us-ascii?Q?33k/qh+TR1GjMCuchNMhjgpVjTtww7TdsUd63v8nUlG9ZFVa1C1m6Tjfe5FO?=
 =?us-ascii?Q?YlOEI54YEBOtuO9kIfv5UiRrze5SdnOyM5jXftxSMYYh4E7HMBNUqRqltrlh?=
 =?us-ascii?Q?7lv3fsJMSekjfGhire92svfOwJNM3WsmhLCfJjds74KBSl5yDgwv0MGnNCq2?=
 =?us-ascii?Q?ff9tJTOpTvYOJ+PF4ZgksWxp8iEfLiodJNWoBJfS?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f8bdecd2-5643-46d0-ff2f-08db34b04a05
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3062.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2023 01:59:56.5979
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GA5DGNNeVjfllJ5WqxXjS//4Ugh8u3pmrEJTRcrrY3LdjBSkIRelLktJNHh3UWyLapmXZUcEjnSBPdIsyarDVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4537
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 03, 2023 at 08:13:08PM -0400, Mathieu Desnoyers wrote:
> On 2023-04-03 14:13, Mathieu Desnoyers wrote:
> [...]
> > +/*
> > + * Migration to dst cpu. Called with dst_rq lock held.
> > + */
> > +void sched_mm_cid_migrate_to(struct rq *dst_rq, struct task_struct *t, int src_cid)
> > +{
> > +	struct mm_struct *mm = t->mm;
> > +	int dst_cid, *dst_pcpu_cid;
> > +
> > +	lockdep_assert_rq_held(dst_rq);
> > +
> > +	if (!mm || src_cid == -1)
> > +		return;
> > +
> > +	dst_pcpu_cid = per_cpu_ptr(mm->pcpu_cid, cpu_of(dst_rq));
> > +
> > +	/*
> > +	 * If destination cpu cid is greater than the source cpu cid, unset it
> > +	 * so it can be reallocated.
> > +	 */
> > +	dst_cid = *dst_pcpu_cid;
> > +	if (dst_cid == -1 || dst_cid < src_cid)
> 
> Small detail: I plan to change this from "dst_cid < src_cid" to
> "dst_cid  <= src_cid" in my next version of the patch to handle the
> unlikely case where a task would be migrated back and forth between
> two runqueues without being scheduled. It would be possible that the
> task's last_mm_cid is equal to the dst_cid here, in which case it
> would be better to leave the mm's destination cpu cid set.
>

This patch is still good regarding lock contention.
(I applied the above small change while testing)

> > +		return;
> > +	*dst_pcpu_cid = -1;
> > +	/*
> > +	 * Put dst_cid if it is not currently in use, else it will be lazy put
> > +	 * on the next context switch.
> > +	 */
> > +	if (dst_rq->curr->mm != mm)
> > +		__mm_cid_put(mm, dst_cid);
> > +}

Thanks,
Aaron
