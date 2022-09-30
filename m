Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 611205F0B13
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 13:53:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbiI3Lws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 07:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231443AbiI3LwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 07:52:19 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90D43640F
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 04:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664538731; x=1696074731;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=nkISd0vieIFymhuXRDTWNlHxhoEDRuBLYyPMxSXKH3o=;
  b=Rttg1CFzSey9K+L4Jl39XfDOFU4JvPu7LdiScbU2uTJViEcu2b/MG1/2
   suOBK7XP+rlZ/zMfaI6tfh9AcxR8C1805lrBr5J3vLwklQv2ipBfH1AwK
   Ga3+947hXj569JfNLRBs1MvTwy/2J4Bcc4lzJQDS1Te3hFtkwtEulIocc
   gWxQXSyKHbhT8QqVU3Hda7cBmeenlce+QsXe+xOI5zfxTum7ELMSX7JGg
   Wuf2wM/fEyRxL2jZF+lkyiwxRVw+IPUzrow1MeKv+yBG2ZAbRWTfaPMBb
   c+pRadIUeQzYdmtVLjS3gCwfD0drv8Jvcxrz9gqyYmVnKqEHwTLZOARb4
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10485"; a="328554793"
X-IronPort-AV: E=Sophos;i="5.93,358,1654585200"; 
   d="scan'208";a="328554793"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2022 04:52:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10485"; a="691224498"
X-IronPort-AV: E=Sophos;i="5.93,358,1654585200"; 
   d="scan'208";a="691224498"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga004.fm.intel.com with ESMTP; 30 Sep 2022 04:52:11 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 30 Sep 2022 04:52:10 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 30 Sep 2022 04:52:10 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 30 Sep 2022 04:52:10 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 30 Sep 2022 04:52:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BgbKurZs1d72Hzq8zEnJYBQZkSezQNF0E9pd2lslPyjwV8aj+yWEo6MRTsNutHBwPZ5bOMkpgA3Z8tg7iofoIm3I/bvVuRD/qAuWzLfXGBRvUbecAabdbNg8SKNMOS5IwZEAHNRum9+vrANlIYPrbSqcAeGWHAmNvRdJeECcOP3sZ1nP/bVaxWmgjZ4giIGXIiaTfvmNGtMLvQCLZ/IeopzXs3gpb0DzdrkmEN46UW/oSdqSeKWTKYyHsurF8DESD6PPcTtJN5qp5H2lnxZbpqin5mdDiANPPRyBZEmACu4QdP2FLTVLiu98IpeBXHfbmDKLwdxtlVznOGhu+a5ibA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ie/tAsrnMlbeZQTiBXoM1AfXg6TAsP8JN2ig49s526g=;
 b=YElu1SIjOaHQu+tKsjAuLFzLlzW1KkFu+Ig0wPFj9V/OIKUYue4zSgJTXp19OsVccWxz+aVYZKp8u9kDDkUTFnZR1lpwQKY63yA3LR02uyVv+zN+zQ3X/Vejp74EGHSzJnb+DD7IbpZQfw9oQiXj213NgrOkywx3/TesSAoQ3+yOuL3GYKqhqhPie8Z+lJJDSOsTGEuAidMsaAs7x9f7vkZxaRqkRpGqmpzeBfhLR8lCWVOgFSC2s2R9lRqykgTtoYA421Jcork8V5Du1FLKXSWO5XC0sEMG3jDMAfYIAaJy6/HMQx4/0rpW7Ot1QjaU7INL1nEyXwMiLOO7BaSpIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by SJ0PR11MB4911.namprd11.prod.outlook.com (2603:10b6:a03:2ad::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.23; Fri, 30 Sep
 2022 11:52:08 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::ccec:43dc:464f:4100]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::ccec:43dc:464f:4100%6]) with mapi id 15.20.5676.017; Fri, 30 Sep 2022
 11:52:08 +0000
Date:   Fri, 30 Sep 2022 19:51:46 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Vlastimil Babka <vbabka@suse.cz>
CC:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next] mm/slub: fix a slab missed to be freed problem
Message-ID: <YzbYUo1EpYzd4jtw@feng-clx>
References: <20220930100730.250248-1-feng.tang@intel.com>
 <13417330-2a81-e775-8875-fb31a5d5e078@suse.cz>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <13417330-2a81-e775-8875-fb31a5d5e078@suse.cz>
X-ClientProxiedBy: SGBP274CA0008.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::20)
 To MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|SJ0PR11MB4911:EE_
X-MS-Office365-Filtering-Correlation-Id: 88017534-04aa-4efb-a137-08daa2da33c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UWSk/7IpOb82bmmwXLXB53MOljjXpboFPXjT9vzTP3z2SP2NFsWxz1Qb+E6oKWUcHyJQx0jT8sFyIrMLN1QcqYzdytExMCOgCG59EbV3C+rvpqgDU4PKb4ZxWjDLJN4ZTX+llddl9dWml+CCu1TJOHb3NfrdB6Y5bKQys9s8wS89jUfYO36IRbSA/3wKeckYrlMErlQB11ykn/bEb6xIg0XTmhffbrLPJuXh80ceyBuRkB0H3ncTeMssQMbNxQR0nd9fo+QL9qP6u0DwlLWLDUEH4OPFW39jc+1qxMgPoWgobhJC90qVgq/6eX6Rhz7ALysd8xwHIhbHYyNkjKBkk4qcIkdYraeTjCCxAvSRoqk0biNIw3Gw1Ci7b0QISM+sTTFJqoYXDAN/hgE3YHzHEpdSbs6T/idAuznCMAckSKGI8v7ha63SRLeZknmTv2UqWZEmmWNSAy0mq4EV6tdHpVtqHG4R4Vth0BrsAb8OP7gnZZYFGJBt0/F2SbMySpuAwMHG6KGHDmvZytOuDZqlRPT2uhQtYVMno7GPF2dWr7onuzsAkmY8ToDgxgqecaHNr41gwMkM/Dyi5Oa/jmuQ71HsHa7Z4CmwCsA/bUSNnv6uXPcQVccRvAXsHmuOStscuXDKbb2V5TOtERbcpwd8BNSMteS8KhPYxq8lbPC5sisB/wHSzpumyUuEeL6aqBc+JlSlFtt+7LKrhX3Tly4fvw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(396003)(366004)(39860400002)(136003)(376002)(346002)(451199015)(33716001)(83380400001)(478600001)(6486002)(82960400001)(6512007)(26005)(8936002)(2906002)(6666004)(45080400002)(38100700002)(5660300002)(186003)(41300700001)(66476007)(44832011)(316002)(54906003)(66946007)(53546011)(8676002)(66556008)(4326008)(9686003)(86362001)(6506007)(6916009);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hWwR+rLjag0pv/puE3zhsDVU47NB8WJFLRUSvnVUmkpGBrzAV1GF6X5+meQz?=
 =?us-ascii?Q?6MofPDPLAKh1OZew7yx0kwD9HugYU49R5+XXLRtVmlYTS9D7LCLXiS4NpUCb?=
 =?us-ascii?Q?0+2wmF/B+x12r3i+nMbfew6jjVOHITK3VJ0XOwOYi1chysyQ/2NqBojG03oI?=
 =?us-ascii?Q?iuznybiDCv/B6ZPDRX1FKPeDcCSSwoxOpeMy6/W9RCT+2k3SGM0V3ygAROR7?=
 =?us-ascii?Q?XISYINRLDek/cjkYVe+5dQ2kKEMbUET3zmg/l9v6sT2A+jKuiXQ8jzPAo0DR?=
 =?us-ascii?Q?RTxJcu0Rv0ybyp6B48w2N6AIk2Wywx8wKbCfdaX2hXi5HlPTYef2X5wPLSxA?=
 =?us-ascii?Q?qbKDQ2yD/dRl9i0X+kdrRRW2uDXXGDhfoAUHqL5VwvQrc7o2rOvrQct15dUj?=
 =?us-ascii?Q?RELJPHtHYbaZUtTK88aF0GknDUqw9bfmGUaxb4CTMd07d2fr7Fu5kLCyLdKJ?=
 =?us-ascii?Q?kg8b7pWL34RKuRfWBTUvf1F91bixThYK53LGxfmTvkqvtfr0AWETeOxDuCLD?=
 =?us-ascii?Q?Lgxw7SigaO+7nxbPj3MZ+IheGsq8vUoakMrkuQjCWGVosdm6r3qrkDiEs8m8?=
 =?us-ascii?Q?sC+GMu+WcwYEz0X3JLR6w47tzAAlLZ6QOsDzaZthsyqELg0BpEWWXEgflyul?=
 =?us-ascii?Q?ziGeqqe7hm/qJHLvodp4+anTpj0CbIOCQszTZFDDLpKxyTiFGD1EpdzAWrhE?=
 =?us-ascii?Q?HpRJpvOP62GfZthzAep6cFQGCbjGB715kaK2kxRAQNTMCW/0P5Ip/XDfRTj5?=
 =?us-ascii?Q?6XVqE95ILq7HkiNoM50wkhQHzZSM9FIBM/aG8SH/aFwfW9uA8uZWZulZLKiM?=
 =?us-ascii?Q?H6eJuq2EyR6FFW34GawUfj8bA6LPt7o2r/GHGeuLD/CZdU2ljRKvZrzbmgkc?=
 =?us-ascii?Q?9gK7DK2nPsXErC20zGKjBK8x591Xb4KgU/tvpmTV/Kiodg0SIzg3bZHSkxUY?=
 =?us-ascii?Q?Exng6qqG7G3sgfT5B6fOW6iJ0zvonDc5b6F1Kcb9HPASgkg8Eo98i9EoBrNm?=
 =?us-ascii?Q?2WkkQe8xvRJvMVNqO2xERpjkKG9IFhupTCzRi95LvSmTp7edZg4sNgKsjeuY?=
 =?us-ascii?Q?dxNgwni5u0f5hDsfhaWyinwC8vX1naCDAnZGv3waiHci50vno1L4SSKODixc?=
 =?us-ascii?Q?clgRoIv7yh0blXl6DUqAYpXQJSnFzbXzj0LA5dm1InMcmIheuT7EeqLViR07?=
 =?us-ascii?Q?UtYwXAczcw5y3nUkb9O/KaQ2Hp7z/WVkn9HPO9E8FMfKBucYNe/atrWUdopd?=
 =?us-ascii?Q?yHHmAcdmu4GCNgAKQ7j8ukWFwCvgZGjCvJUgdbulK1V+vVn++bYQVRL7z//P?=
 =?us-ascii?Q?nrl5Ptqo8aE0+j15Tp5T25qwrHA9pkok65sWnNkVpCyYasdIOQ5D7GrzwxnY?=
 =?us-ascii?Q?ku5WZKWHdszNPABQgJGRrUKVaIzhF7Sc6BP0zRlW9+guCC8eNszq6+n/kwAF?=
 =?us-ascii?Q?a0AT5s5/pSx7+pHN+kRBjsLJMe9mDsDxnBTdpz3QkjU+qrZNnhymJgXQt8es?=
 =?us-ascii?Q?dfgk3BoDfpyT9R3Z/MYyb4qNo4/CU/5t+y7vcO7p1RYSUZLzhRIl/tBcwn/L?=
 =?us-ascii?Q?u9xGXvtGvRtp453ZuO6yaOIQ6+jwqujZ9TnFjD1w?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 88017534-04aa-4efb-a137-08daa2da33c4
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2022 11:52:08.4736
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PJ6JEb8cTfg2Oj7sih01UXtFinzJXYIU29moS9Pr0dfACPDqUaZq2iZTu+8y3akVMycLQgCMLdmq99awoeoUsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4911
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 30, 2022 at 07:25:54PM +0800, Vlastimil Babka wrote:
> 
> On 9/30/22 12:07, Feng Tang wrote:
> > When enable kasan and kfence's in-kernel kunit test with slub_debug on,
> > it caught a problem (in linux-next tree):
> > 
> >  ------------[ cut here ]------------
> >  kmem_cache_destroy test: Slab cache still has objects when called from test_exit+0x1a/0x30
> >  WARNING: CPU: 3 PID: 240 at mm/slab_common.c:492 kmem_cache_destroy+0x16c/0x170
> 
> Assuming the warning was preceded by some kunit test failures?
> I don't see how leaving more empty slabs on free list than needed would
> cause this warning, the shutdown should just drop the empty slab.

The previous code only call remove_partial() to dequeue the slab from
partial list, and miss to call discard_slab() for it.

From the debug dump, the n->nr_partils stays at 5, while n->nr_slabs
keeps increasing. And during shutdown, the free_partial() only free
the 5 slabs on partial list, and n->nr_slabs still has a big numbers
of orphan slabs

> >  Modules linked in:
> >  CPU: 3 PID: 240 Comm: kunit_try_catch Tainted: G    B            N 6.0.0-rc7-next-20220929 #52
> >  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
> >  RIP: 0010:kmem_cache_destroy+0x16c/0x170
> >  Code: 41 5c 41 5d e9 a5 04 0b 00 c3 cc cc cc cc 48 8b 55 60 48 8b 4c 24 20 48 c7 c6 40 37 d2 82 48 c7 c7 e8 a0 33 83 e8 4e d7 14 01 <0f> 0b eb a7 41 56 41 89 d6 41 55 49 89 f5 41 54 49 89 fc 55 48 89
> >  RSP: 0000:ffff88800775fea0 EFLAGS: 00010282
> >  RAX: 0000000000000000 RBX: ffffffff83bdec48 RCX: 0000000000000000
> >  RDX: 0000000000000001 RSI: 1ffff11000eebf9e RDI: ffffed1000eebfc6
> >  RBP: ffff88804362fa00 R08: ffffffff81182e58 R09: ffff88800775fbdf
> >  R10: ffffed1000eebf7b R11: 0000000000000001 R12: 000000008c800d00
> >  R13: ffff888005e78040 R14: 0000000000000000 R15: ffff888005cdfad0
> >  FS:  0000000000000000(0000) GS:ffff88807ed00000(0000) knlGS:0000000000000000
> >  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >  CR2: 0000000000000000 CR3: 000000000360e001 CR4: 0000000000370ee0
> >  DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> >  DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> >  Call Trace:
> >   <TASK>
> >   test_exit+0x1a/0x30
> >   kunit_try_run_case+0xad/0xc0
> >   kunit_generic_run_threadfn_adapter+0x26/0x50
> >   kthread+0x17b/0x1b0
> > 
> > It was biscted to commit c7323a5ad078 ("mm/slub: restrict sysfs
> > validation to debug caches and make it safe")
> > 
> > The problem is inside free_debug_processing(), in one path, the slab
> > on partial list is missed to be freed when partial list is full.
> > 
> > Signed-off-by: Feng Tang <feng.tang@intel.com>
> > ---
> > 
> > Hi reviewers,
> > 
> > Sorry for the late reporting, but it's curious that this problem didn't
> > show up in my earlier test (which caught some other problems).
> 
> I think we can reuse the slab_free and don't need a new bool?

Yes, much simpler!

Thanks,
Feng

> diff --git a/mm/slub.c b/mm/slub.c
> index 5c3c31a154ba..a63953f649ed 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -2886,22 +2886,25 @@ static noinline void free_debug_processing(
>                 set_freepointer(s, tail, prior);
>                 slab->freelist = head;
>  
> -               /* Do we need to remove the slab from full or partial list? */
> +               /*
> +                * If the slab is empty, and node's partial list is full,
> +                * it should be discarded anyway no matter it's on full or
> +                * partial list.
> +                */
> +               if (slab->inuse == 0 && n->nr_partial >= s->min_partial)
> +                       slab_free = slab;
> +
>                 if (!prior) {
> +                       /* was on full list */
>                         remove_full(s, n, slab);
> -               } else if (slab->inuse == 0 &&
> -                          n->nr_partial >= s->min_partial) {
> +                       if (!slab_free) {
> +                               add_partial(n, slab, DEACTIVATE_TO_TAIL);
> +                               stat(s, FREE_ADD_PARTIAL);
> +                       }
> +               } else if (slab_free) {
>                         remove_partial(n, slab);
>                         stat(s, FREE_REMOVE_PARTIAL);
>                 }
> -
> -               /* Do we need to discard the slab or add to partial list? */
> -               if (slab->inuse == 0 && n->nr_partial >= s->min_partial) {
> -                       slab_free = slab;
> -               } else if (!prior) {
> -                       add_partial(n, slab, DEACTIVATE_TO_TAIL);
> -                       stat(s, FREE_ADD_PARTIAL);
> -               }
>         }
>  
>         if (slab_free) {
