Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38FAA67F219
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 00:13:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231681AbjA0XNT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 18:13:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbjA0XNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 18:13:17 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 763AA7E6B4
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 15:13:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674861196; x=1706397196;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=NljfdYgzpuoniqIFIcAmhXjYlwwYTMl1vwjgR+7r4K8=;
  b=nvQD/xX3LxziCNVFD/QJl7hscCO34YoB6AZkGJ8X8P+hmtnjwc3yohXS
   BTv0roJeFgVfYLe4UemGLfz1lWMZrWKnQ24LCY7Q4yFUvBlh+4ApxiQEY
   0Ao/qxmrslY4vADPJGwCyZBzCHqZA6N33INypdi0i/Md0H6xR/U/vQdrH
   z7J23EZLBoajXFkk9cMM2E4sRixeUOLBEfwovX1WuX8kXkxFBCLLW+QwX
   LVWKb5vdgRY3KVM73WB88QrHJ6AIlEGo/EJgVXFJBli11d47/6ykZMnNE
   LrVn5qWZsrnrAwhNdadXAu0l8K0vICjafj0b+eYQZPTVhSC7m68lJ2FRk
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="391770561"
X-IronPort-AV: E=Sophos;i="5.97,252,1669104000"; 
   d="scan'208";a="391770561"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2023 15:13:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="726840658"
X-IronPort-AV: E=Sophos;i="5.97,252,1669104000"; 
   d="scan'208";a="726840658"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga008.fm.intel.com with ESMTP; 27 Jan 2023 15:13:15 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 27 Jan 2023 15:13:15 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 27 Jan 2023 15:13:14 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 27 Jan 2023 15:13:14 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 27 Jan 2023 15:13:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RSX/gXrJhL+RP74HA0l8iE0ITr7oney3kWCBPh21mJubUaIyZQGtxc2m9R5AqaUCV+t40OLLVBi+1f1rdelMxFFQOko+zF2Fm9eChtgn7+JwZCpZxTcQojhL7QMCzt8HSl4fc/sGkKmlPnJos9lyo+3tuMrBbeS6GCUbww0esmFUBBuc4oZPMD62jwF5jkwIPrexjqQExIXRtmMFkSAsjS+Tip71lIhgHh+lHtOrrhWZ3K/ceSSfdwK4GGIvuRRpwkB8SoVwnApU41j1umUSShu35aVVhJI4l3LzxQmG44nY1WdEMFD24T+EevbzxPSCRqgUjXReKS2gt6vnbtjH8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YIEZpVQVWFcyEvZJuPu5HyAzoBXPAtjkRaY+ZMq70IM=;
 b=gOnCQqtAHCztVaOuwxT3d7KMBC92Kic+7Bly07vmJR6ELYJXPF78uBK8er7BF3ysidg41NeBW8a4lNuEHKYBGYUh+M0trg7YBFGijqWmePomYg6p/2l5T0fhNXvypBn33DReDdEaZqbtoSx/pim+GRQOOGbw+J662hB5/AKe7IoGdJG8kKAkzVAtey4bVpvJUoj4u8lQAt1F7JywdrumxKjoW0tE3pyhAmrF4cer1zzikJDvLFMCm1Q1N91iU9wpWFTXy/DgekvpWkOSOIUwI4pFSgNA4gTKzPZ4KxTgO3Uu23pq8qMQi28v+qM74G2igj+5tOYCvoZyg9wiEzBcCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by PH0PR11MB5644.namprd11.prod.outlook.com (2603:10b6:510:ef::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.23; Fri, 27 Jan
 2023 23:13:12 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6851:3db2:1166:dda6]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6851:3db2:1166:dda6%7]) with mapi id 15.20.6002.027; Fri, 27 Jan 2023
 23:13:11 +0000
Date:   Fri, 27 Jan 2023 15:13:07 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Ira Weiny <ira.weiny@intel.com>,
        "Sebastian Andrzej Siewior" <bigeasy@linutronix.de>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Tony Luck <tony.luck@intel.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        David Sterba <dsterba@suse.com>,
        Kees Cook <keescook@chromium.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Helge Deller <deller@gmx.de>
Subject: Re: [PATCH] mm/highmem: Align-down to page the address for
 kunmap_flush_on_unmap()
Message-ID: <63d45a837b15b_7f63c294a2@iweiny-mobl.notmuch>
References: <20230126143346.12086-1-fmdefrancesco@gmail.com>
 <20230126123858.42d9377ad6e352a58c81668b@linux-foundation.org>
 <Y9LnAzUP2K/cmqa5@casper.infradead.org>
 <Y9LqwvXy+gpFBerE@ZenIV>
 <Y9L291ySSSRHD3uB@casper.infradead.org>
 <Y9L7/b/33mXvRsyX@ZenIV>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y9L7/b/33mXvRsyX@ZenIV>
X-ClientProxiedBy: BYAPR08CA0034.namprd08.prod.outlook.com
 (2603:10b6:a03:100::47) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|PH0PR11MB5644:EE_
X-MS-Office365-Filtering-Correlation-Id: 18e59d7c-ab69-4d39-4b61-08db00bc0f48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fz5p3w9QOZhZDBQGKoLmvMEXMB+F82Q60qlG/IqIni9i547tsWnlgdLN8k/VMW1H8cGDfLGJRhr12n1z1Nvq4FL6paWmeWmikB8w80OZCq/LEBpl8oYwzgboLBzY0WjWmK0uih7ZLFUbpiENz3pSxgvlNvcun7VDASvRJ1eDTM08/UZmVYUu67eqz22qk+vF40Mv2dv61YngyIob5RGBeOHtqhk4dxRFcXV9W2iniQvIf8FPDCyjlEVGszwTPfJK8fa0xP6G3vDVzxU6FsILthZxhaJm/J//vJG6HlzHQhnDh+W/2TNzFZYUzaubit+0ahSrY4AK3IMq6qejmBfP9xNp9bQVMLHBvz9DM1jLEdspXFegQm/lrvGwjWUO3QgReEvG017kKTLZQLOoPc24gjrX6F5Pw9krCBqbO1QJx8TVXRHh6Z71QFldJE6NXAXMLWLReCXFuFLw4njpyrGVxd8oPVjf52V8lnDSo5UAkRvsXbI34ozKT5esbLicyngt28ck1ayi5mo9swNet95aYfbbhRSx/KMQvnPO4OicU6bJU/E2rpT+CslDPlp2FQE1pCEpMujpD8N/olOkGK+7C8rsWYkZBYxcbu5yO8bjjNZHRwGJ+gDpDVTxIj/hd3MQ62r+MreYdJte0Vj7P09RqQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(366004)(39860400002)(376002)(396003)(136003)(451199018)(2906002)(186003)(5660300002)(8676002)(4326008)(66946007)(7416002)(82960400001)(86362001)(8936002)(41300700001)(66476007)(66556008)(38100700002)(83380400001)(6486002)(110136005)(44832011)(54906003)(316002)(6666004)(478600001)(9686003)(26005)(6512007)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DD0CuH/WbZEU6bdXA7zSH8AeqYaiJiJuJUXObamQYDOmlJSUJiDijNQxclul?=
 =?us-ascii?Q?tu915LKDKeT/Q0r9Z3WNNPm2148nXaCqA+zj73yMO+W1pnMd4IEpBBK+pCRB?=
 =?us-ascii?Q?em/WCSTZZRQETaAzFPS/mkAhS47TwpRAj2a6AKLNL2yZq//3ZrhFtFlFtnCv?=
 =?us-ascii?Q?ooflA1Yyn9gufc7TYH63EAdcLcPpoeoP7Ueao2wE5I+eyceLAAu8zNeeOw40?=
 =?us-ascii?Q?H0XpK2IBPYnCwh/smW1AgcyrywWeQSu1MVhYhp7VX11/W3z+lHcVWp7bUp4J?=
 =?us-ascii?Q?6oaqI+TWSC8vzrKTXXBz9pDHaWrdhcJPEmzn+iXmiKMCCQtm7Z3znpl9g3CB?=
 =?us-ascii?Q?6pPRkN8mA5QP9mj85OY/KHitGcmPUoeUF4TelyxmrokMwxJopY5uXCwZXewO?=
 =?us-ascii?Q?ZI5ZLrl+qy6NLllmASArroZWaPRpzjr2NLnM8Un6IrRhGfVmaYHkrgkvMDhz?=
 =?us-ascii?Q?2cNpugQ25iDcKuELst9UiUHJjSSDJG36BciaYD1ID/yNi/dOvUAs0BdL4zek?=
 =?us-ascii?Q?d2278nOkvFIDliO8Uytrfz/mvvJ2u1bxq2afQbk8MmNGu1ayyAFQ56oDKYaQ?=
 =?us-ascii?Q?mebkQRxt4YXBDCgKBXu7mplyKu+WmIwnoEOpfyhOYH+cQPlaZOW2Umv8AkLi?=
 =?us-ascii?Q?ZtA4AUwkcUsSY5kpvaKgYwOgej/5/dl7B0Vfyjhhs9Mjp0E9YkRdhlSnCRDX?=
 =?us-ascii?Q?hfOCYckZTQNF2A2HaBf8LvtoKAZNdH1AMBvOXVGHmNOE1B5ZnPHAHjLUSko9?=
 =?us-ascii?Q?Oj3g/Lik1uaa1QmkPAty+Ii1pkaj4AZjtUwzoWDna8YnV3YPyOL68frpwF7s?=
 =?us-ascii?Q?noomn/B7N+5wn2PXexxPTB4blKsjARB7V3RU9w2jEOoRd6PC1eaQNAgzzyj5?=
 =?us-ascii?Q?PmHAgvTHrYeozzH3/mcqChLO1JhN8Wo87c7V7+WHx1RMIfkMc1tXQ0EhwVBV?=
 =?us-ascii?Q?En/DVfY0sbWQDDMsPJouvY84CIHg6qryzRob6nh5lLnMkWNjTUwMoXrs745R?=
 =?us-ascii?Q?5Pme0ax8edxWdEvmN6YIvd9b4vo94JM4Q7SrRjUaLHXfJh3DXssaSIDxhHvX?=
 =?us-ascii?Q?izcPOOyVY+EkfIq4DtuDs3FrWSAfuPLFK4FnzsuO7rMbx4M2DrlW8vc/ljr3?=
 =?us-ascii?Q?Z8HniOnRYgc2hxXOAhnTXiCcS9BsFiMt+3SFoM/jfyW58TQ+p2f7pRVxoTUR?=
 =?us-ascii?Q?2xyMGFJNYkOQQTUtmtwp196higc7kDWmvD5xst0H5eUu86m971RGBs+h3ZN+?=
 =?us-ascii?Q?FvkpAgN8HqUPmBC/gRgsnQFyceBTKasQQr8h7jTlYTxc98zZd9GTg8xyF+cv?=
 =?us-ascii?Q?XNLbt+/zRRL903ozT0g8LtD96ToG/T/9dRVsb4zfSbNqnik5DinbuEjKUCfA?=
 =?us-ascii?Q?fsTAK2rwcfF8x+QSpzaAzT7qCUU8ZiAVRAwh8vEB/osLO93M355JdCQTCZpf?=
 =?us-ascii?Q?5Ci6hZJwcN6hwkXFx/GFfZtJFQLepoj2OZMaOboRQdUsGoeZU7kCp13rYIVp?=
 =?us-ascii?Q?Q/dIogUx2M2UpVL3cNAU3sfLCxYq6O0En0JrYm7KFbPvvrTrTrDrBf09IymD?=
 =?us-ascii?Q?Ko9LJjokV84MU/rEbnJtZJVdNVHYJYBnAO2VIaaF?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 18e59d7c-ab69-4d39-4b61-08db00bc0f48
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2023 23:13:11.5022
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZJS+0tLkOqydhoQGuBe2kal/4/kPhke/ZI/BQ103ITarUiIVqI2hB4XHfYaCqKihk7CkZfEiSsf6Jz8nlUhOEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5644
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro wrote:
> On Thu, Jan 26, 2023 at 09:56:07PM +0000, Matthew Wilcox wrote:
> > On Thu, Jan 26, 2023 at 09:04:02PM +0000, Al Viro wrote:
> > > On Thu, Jan 26, 2023 at 08:48:03PM +0000, Matthew Wilcox wrote:
> > > > On Thu, Jan 26, 2023 at 12:38:58PM -0800, Andrew Morton wrote:
> > > > > On Thu, 26 Jan 2023 15:33:46 +0100 "Fabio M. De Francesco" <fmdefrancesco@gmail.com> wrote:
> > > > > 
> > > > > > If ARCH_HAS_FLUSH_ON_KUNMAP is defined (PA-RISC case), __kunmap_local()
> > > > > > calls kunmap_flush_on_unmap(). The latter currently flushes the wrong
> > > > > > address (as confirmed by Matthew Wilcox and Helge Deller). Al Viro
> > > > > > proposed to call kunmap_flush_on_unmap() on an aligned-down to page
> > > > > > address in order to fix this issue. Consensus has been reached on this
> > > > > > solution.
> > > > > 
> > > > > What are the user-visible runtime effects of this flaw?
> > > > 
> > > > The version of this patch I sent out includes this information,
> > > > as well as the missed alignment for kunmap_atomic().
> > > 
> > > One point: AFAICS, the situation right now is
> > > 	* all callers of kunmap_local() pass page-aligned pointers
> > 
> > Ah, no.  kmap_local_folio() accepts a byte offset within the folio
> > and returns a pointer to that byte.  I hadn't noticed the parisc
> > case and thought it was already allowed to pass a misaligned pointer
> > to kunmap_local() since it is allowed for the highmem case.  It
> > simplified the callers, so it looked like a good tradeoff.
> > 
> > See, eg 338f379cf7c2:
> > 
> > -               src_addr = kmap_atomic(src_page);
> > -               dest_addr = kmap_atomic(dest_page);
> > +               src_addr = kmap_local_folio(src_folio,
> > +                                       offset_in_folio(src_folio, srcoff));
> > +               dst_addr = kmap_local_folio(dst_folio,
> > +                                       offset_in_folio(dst_folio, dstoff));
> > 
> > -               if (memcmp(src_addr + src_poff, dest_addr + dest_poff, cmp_len))
> > +               if (memcmp(src_addr, dst_addr, cmp_len))
> > 
> > -               kunmap_atomic(dest_addr);
> > -               kunmap_atomic(src_addr);
> > +               kunmap_local(dst_addr);
> > +               kunmap_local(src_addr);
> 
> Argh...  Missed that.
> 
> OK, then Fixes: on the patch makes a lot of sense.  And it still
> needs a chunk in D/m/highmem.rst...
> 

I believe this is taken care of because the kdocs for
kunmap_{local,atomic}() are included there.  And those kdocs indicate the
ability to use any address in the page.

Thanks for setting me straight on the parisc/highmem thing I missed that.

Ira
