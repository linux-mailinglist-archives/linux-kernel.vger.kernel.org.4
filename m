Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 955996253CE
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 07:29:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233157AbiKKG3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 01:29:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232936AbiKKG3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 01:29:16 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C799862F6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 22:25:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668147924; x=1699683924;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=fOi2Ub+Js4IQQT828dbFJtf0QImm78VF3PpU+gheIcs=;
  b=LTDhu7ehZIvjN5cwoBWaRYpTdrOgLTxqQr5r+dsdeBs9UiY9Wp1jTrPt
   nj/iRocmEwYEGEstkerDJXSKDxu1dNt6psFp4sD/r69s+0ZZsapDrAoM9
   kK5GtWiwUGobH1nt2m7wdZWtqs2phTsRh/ELUgfNRdkvEIEfAfcrzbcFo
   SHO5DSInkaR1tcPvdG1lEjMU20i82xaOHDxCQVhVv4X9HAvENc4lxoh1t
   f0YXKiWBNG44W9/FlWdXC+K8zk0WNPVX4UQrcYYMd7eH3DUjRQ7Bfs93h
   B0IdVJg54SseB0o0QDxFwWVFiDcDtdVk2EvOoZVij3gZw1hExo1wMW+Nd
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="375796569"
X-IronPort-AV: E=Sophos;i="5.96,156,1665471600"; 
   d="scan'208";a="375796569"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2022 22:23:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="762566300"
X-IronPort-AV: E=Sophos;i="5.96,156,1665471600"; 
   d="scan'208";a="762566300"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga004.jf.intel.com with ESMTP; 10 Nov 2022 22:23:07 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 10 Nov 2022 22:23:07 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 10 Nov 2022 22:23:06 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 10 Nov 2022 22:23:06 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.46) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 10 Nov 2022 22:23:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KfioNk47ZGHUI32bR6evGL8j607/yabAB6QBHqEFkSVDj1UQCoyxfqMiYrZNYNAt1LXcbc1Ne/0csm5wTGRBa7gIPKxHlmpCzjpOQcpQfmQsP1LbovnRe5AgMQ4o5fXnSRLHZUCWuejSIpGDxZwIGnG7XyC5ra1ldP6PVPTTf2fXN/7NxznsttUwEEREkzax8vreSqK9Ap/+5VBEGjpswyqgPiopRFDQeHx2NereN3/MYuhtNxAS+0CM05jRNLB/fFisemN0IdbwYXFDzRqcTYcHIWLjk9vGtuGWSHgazxmz8bqWqJGt9PYRa07NhMi3T58pNfwYhoxrYIvl94q8oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b1tUr1jO78ZQyzn4XqSHhN4BHHExwuUcafmfkS/UIOQ=;
 b=hjfDc34ZxWNSziy6ENM7aET44Sh3n58Ax0epk81nAcd/NYz+4fWQHDxK4QjhlrcfYTCAs8IIdIlYaMelQ/9LLIRaIkCDZH+7bpr01Ddna98M7EG425Mq8tnCa9tZ96k/+cpMIzz/jILUByQaqhNibsfJg4bw3OTSMvB6HhESjRecDONqyB7CrnSXFjmnm0U0Q6mqhuOA3Dc3DR21bq9Wj90MT2LFwpzVvman1PDXHeV9i97cVFD+v+UrEo0k0YzvjrVkrSFz+ERoWoheXZ+DcyKQ+dqxJTt0AeXMSvODp2iQtRm+rUwizbOkfCcLQKVdBERKD9anTqWTyut+WfBztw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by SA2PR11MB4777.namprd11.prod.outlook.com (2603:10b6:806:115::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Fri, 11 Nov
 2022 06:23:05 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::1564:b428:df98:96eb]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::1564:b428:df98:96eb%4]) with mapi id 15.20.5813.013; Fri, 11 Nov 2022
 06:23:05 +0000
Date:   Fri, 11 Nov 2022 14:19:47 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Vlastimil Babka <vbabka@suse.cz>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        "Dmitry Vyukov" <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        "Kees Cook" <keescook@chromium.org>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>
Subject: Re: [PATCH v7 1/3] mm/slub: only zero requested size of buffer for
 kzalloc when debug enabled
Message-ID: <Y23pgyz32TRsAskz@feng-clx>
References: <20221021032405.1825078-1-feng.tang@intel.com>
 <20221021032405.1825078-2-feng.tang@intel.com>
 <09074855-f0ee-8e4f-a190-4fad583953c3@suse.cz>
 <Y2xuAiZD9IEMwkSh@feng-clx>
 <Y2z1M4zc2Re5Fsdl@feng-clx>
 <eaf74c95-6641-8785-61f6-c7013c2f55eb@suse.cz>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <eaf74c95-6641-8785-61f6-c7013c2f55eb@suse.cz>
X-ClientProxiedBy: SG2PR02CA0030.apcprd02.prod.outlook.com
 (2603:1096:3:18::18) To MN0PR11MB6304.namprd11.prod.outlook.com
 (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|SA2PR11MB4777:EE_
X-MS-Office365-Filtering-Correlation-Id: 13eea29d-726d-450c-0150-08dac3ad306b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8oYHwurKGem6eshPnjID1VplES5j9+qLXoL2yLHANG/IsJC7K/d5Gd3LnTb+T1Lq95GEmNziZw7R1WfEc1oi4MzR6m7uEUNGPHprThs1NOeJhxjdVw9T19dSm8d6YalRkadjk9S3qAuy7BLWO4YY/rscZfdtdvzEQ5Lqs1N1Jma3b6jPhgjkgfP0mdgaDfWQj5DnKhrOqab8Mi1WQGNciiBS3lAYOo4fUAL/0cUduOKa0DcY6sXX59m4yzYWpHdqWnrnsaXN2ZRamu6diJkxvT2dq8LKB5P4c/PTpNCmCxDPCfby2GWTmU1E6067XfhjFN8fI5nD0yOArvl0QDtSbbdgdfeaLL9lnHaBA8UDzdByFnXdYY8lS06Dv5x8ThAWdu/pt2HpURgQWwFnfYyT5+o2/BiFP7tqw3SxuETDkBqHcmYwiuTgK58H1STfo3iyM1zP4Zav6W9pYoYTEmfFJyG9hDhf8385HMfVIqVXfPYL8zWlapqoWzWKpuAX0LJaqtWSyPaQTtTQLbdCFOCggopbufi9XM5jPW6O2ck8CaS/hL3qPYdelBcKnS5et7DZeEvTRTloBt0pCUonC1SVtwdy6Lnlf7DYMdpyCOJ5v3J1D1jl3mtpVAw/3Teo3mg+WyvaCjyYGbgMfrnkcTcfwZZUXlqvwEe328Weidi80DdGB/8IC1yhYKw3VqoAlQKsOl3EIkNQjlGbFNmwAHAJnSGuW3RTLJJWn03reI6Recg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(376002)(396003)(346002)(366004)(39860400002)(136003)(451199015)(83380400001)(7416002)(186003)(6666004)(2906002)(33716001)(6486002)(86362001)(82960400001)(966005)(38100700002)(6916009)(478600001)(54906003)(316002)(66476007)(6506007)(53546011)(44832011)(26005)(5660300002)(66556008)(8676002)(6512007)(66946007)(9686003)(8936002)(4326008)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+J//X51zRmDCQC3HgBhFdXn+qAQzYzEwDcSB0VJ08r68MxsH/gTbMyae7XMS?=
 =?us-ascii?Q?dtNwtCl3gKWn2Y23FcbM6PRHgaQdj/2HO6RJEmYhaf21SB2TnfOQQVHBYl+u?=
 =?us-ascii?Q?zu0xhkyNlHZbo0odF2APFpw5WI6dUIl3OJ0Af8t4rFCcdL1/sDyC4fH4yUKu?=
 =?us-ascii?Q?zsgf82SNeA0bHp/Pn/qIUh3jwRo53jg5A4st1nhOxIN1GrkU2rTkmnWmEgXk?=
 =?us-ascii?Q?gQ+hehI8unA5bh4pzlaYUlvVTxr8OeAwY/LkzvzAiZYtiZO7+KGSu/GIV+Ve?=
 =?us-ascii?Q?XB4wkOkW/CnAF9ybLfzabVqcmt/mJH5BskDgjvHe8uINrc1LPL7UTHFtWAdr?=
 =?us-ascii?Q?OkcMlue7c7xO8AcxzwwZbTtkDxHMojndIYUna8pOczGX7+jNzFVwAByhqwsx?=
 =?us-ascii?Q?RvIZIvc1XaGpPIBMFp35c9/tKEj4UmNyY2ZZqGUXgs8ZA71DOl8NDP/ZHcJ2?=
 =?us-ascii?Q?nJOJ+niw4kIamYsMWXqcHoHoi5Hb90t49uFdWujwWjjfn34O3AumKKaU6WOf?=
 =?us-ascii?Q?Ooqq5BNWYArKf+FrV/IDe83jHz3oYW0LVjvtYxYFmLFWj2TCsPn3JdywdKrV?=
 =?us-ascii?Q?smAN+TfnZkx4nchvIjvUt3gFyr1hnXizkPTPKT+Au8J5mMiQahsIoVvgHnKg?=
 =?us-ascii?Q?5Ui+mQ1izfjeag0lpbicfy42sVJ1ZCXcs0KhM2vmbAvxsD/0QjOTLZfZNYZ2?=
 =?us-ascii?Q?qV2lxyr01OSQf/yKENLKLnxuNPm1XpUgZXs24AkJchowF16r2Rmo61iKAZGi?=
 =?us-ascii?Q?inLtPGUZXMkMsx5W1J0CDbhWGOG6NAOkNbJYs+vJikY/MstbDKbIwlQdafNr?=
 =?us-ascii?Q?4hnh3slKnGSfUZaZN/R6qM8MYLAMjZ0YgLk02EJkpssX/pcyzjbMzN2uxYhm?=
 =?us-ascii?Q?HxTLFjQnKLF6kDtgReIB/fXMIbXgGtDM2JYF06C4W4wNMdWrvavIUSPwT/DQ?=
 =?us-ascii?Q?GnqKJepxijuY2SQid3hftk0G4L9UtM2MoZ6RCy6/MPa7NFE0z2pbkAk2gMfT?=
 =?us-ascii?Q?ncN+csdeahdVb3TFlx/7cf+DGp8sWJW/2s/eVSc7OP3J4zSL+HBooQs4XEkb?=
 =?us-ascii?Q?86nj1a0J7hTNp7jqzEDTw/ar3iLPZwevA3N651RnOw4Rmt+fM6q6XRImeETy?=
 =?us-ascii?Q?Wf6f9mduDom01ktc/GDY3ZgxTHYxGxjk3Ij7Tvq+AJyr5RR1JWzx+lpgFcb9?=
 =?us-ascii?Q?V5yABheXnNVwfBSA+ZEJAqVnl4qYCjC1JqNYisoXkU832Xm81jc1z4+Hnrtd?=
 =?us-ascii?Q?HmBzyve/nb9KzhlP7zB1dz81BNIKgfCOTDfVTeaJIf8Qxedqp1BMz8cQhanT?=
 =?us-ascii?Q?G19RtNsULpsvBpyKevVTH70kb3KULu6ncVIYbyqSshdtGG+cXwzfQAhm3n3v?=
 =?us-ascii?Q?sEfu08GnY2ri/dP3XCX5Kd9Q5eKdDNjJLrkcR1Cwam4eLjU503oytuoLP3IZ?=
 =?us-ascii?Q?jLSjWYsB8hShecqwtg+JAq/wMe9BZj0jkIkASqqorhjXCvBhhWINFGKxU5e5?=
 =?us-ascii?Q?qp870sCajlw7wuZtoHKyvMmpmHXF3q7+TuBRCu49hKKSwBzIqOFJZQRA6ZV7?=
 =?us-ascii?Q?1q/tdGcmqzUFS53+C90TY8qFLIHWQgYEFe64YFa6?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 13eea29d-726d-450c-0150-08dac3ad306b
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2022 06:23:04.9027
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AAqoRC3EW+LBg3M5ZcJh7GGK2BL4WE8wVHdWprxGLJbUFxNbL5e+WsE5H4y4uKI930jiYBzmP8Ot4KOaItN9mA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4777
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2022 at 04:44:59PM +0100, Vlastimil Babka wrote:
> On 11/10/22 13:57, Feng Tang wrote:
> > On Thu, Nov 10, 2022 at 11:20:34AM +0800, Tang, Feng wrote:
> >> On Wed, Nov 09, 2022 at 03:28:19PM +0100, Vlastimil Babka wrote:
> > [...]
> >> > > +	/*
> >> > > +	 * For kmalloc object, the allocated memory size(object_size) is likely
> >> > > +	 * larger than the requested size(orig_size). If redzone check is
> >> > > +	 * enabled for the extra space, don't zero it, as it will be redzoned
> >> > > +	 * soon. The redzone operation for this extra space could be seen as a
> >> > > +	 * replacement of current poisoning under certain debug option, and
> >> > > +	 * won't break other sanity checks.
> >> > > +	 */
> >> > > +	if (kmem_cache_debug_flags(s, SLAB_STORE_USER) &&
> >> > 
> >> > Shouldn't we check SLAB_RED_ZONE instead? Otherwise a debugging could be
> >> > specified so that SLAB_RED_ZONE is set but SLAB_STORE_USER?
> >> 
> >> Thanks for the catch!
> >> 
> >> I will add check for SLAB_RED_ZONE. The SLAB_STORE_USER is for
> >> checking whether 'orig_size' field exists. In earlier discussion,
> >> we make 'orig_size' depend on STORE_USER, https://lore.kernel.org/lkml/1b0fa66c-f855-1c00-e024-b2b823b18678@suse.cz/ 
> > 
> > Below is the updated patch, please review, thanks! 
> 
> Thanks, grabbing it including Andrey's review, with a small change below:
> 
> > - Feng
> > 
> > -----8>----
> > From b2a92f0c2518ef80fcda340f1ad37b418ee32d85 Mon Sep 17 00:00:00 2001
> > From: Feng Tang <feng.tang@intel.com>
> > Date: Thu, 20 Oct 2022 20:47:31 +0800
> > Subject: [PATCH 1/3] mm/slub: only zero requested size of buffer for kzalloc
> >  when debug enabled
[...]
> > +	/*
> > +	 * For kmalloc object, the allocated memory size(object_size) is likely
> > +	 * larger than the requested size(orig_size). If redzone check is
> > +	 * enabled for the extra space, don't zero it, as it will be redzoned
> > +	 * soon. The redzone operation for this extra space could be seen as a
> > +	 * replacement of current poisoning under certain debug option, and
> > +	 * won't break other sanity checks.
> > +	 */
> > +	if (kmem_cache_debug_flags(s, SLAB_STORE_USER) &&
> > +	    (s->flags & SLAB_RED_ZONE) &&
> 
> Combined the two above to:
> 
>   if (kmem_cache_debug_flags(s, SLAB_STORE_USER | SLAB_RED_ZONE)

Yes, this is cleaner, thanks!

- Feng
