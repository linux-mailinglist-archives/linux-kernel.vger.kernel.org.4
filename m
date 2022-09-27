Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6B455EB6C8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 03:23:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbiI0BXe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 21:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiI0BXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 21:23:31 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B91B2A220A
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 18:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664241809; x=1695777809;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=etqFYmOWnb/0NwM20dV67j7IF0zYvly2dsWqwKJVv4I=;
  b=XUSFn/RpfwQT1cZxkdqAbidrWNguJWww5SlZ9LzXQRQwh8Ijacl7+xaY
   6vngl54U5lChM89Quwas1b0kiDGv8j9PfEJCR5tGWQLQ2Ryy9BgKgVED5
   uHoa8B4lVeKhygMHKU2oezMIe5yOWPOjmE2tZKw+jCIWfNrLoIY1BdbEl
   8tKiDfUAZiOIhOrlwx7M3ZZDl9Ofl4dEBI30rgAA3A9YUrC0f0zMGozKs
   PfUTgQnqbREQVHZd90drzG9Z45MDtVDY77EADoX/pmMNtlUZTXi1j4wNN
   ivX4w6OwT0K01eDolky48OWfVgyjyw/1L/miXsSanv1RpfA7AmVhRxCcT
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="363016601"
X-IronPort-AV: E=Sophos;i="5.93,347,1654585200"; 
   d="scan'208";a="363016601"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2022 18:23:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="950090891"
X-IronPort-AV: E=Sophos;i="5.93,347,1654585200"; 
   d="scan'208";a="950090891"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga005.fm.intel.com with ESMTP; 26 Sep 2022 18:23:25 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 26 Sep 2022 18:23:25 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 26 Sep 2022 18:23:24 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 26 Sep 2022 18:23:24 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 26 Sep 2022 18:23:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BZx1E6xWDtcQ1JX1rn7yb1zcVR5nPd+gRIReTYoyFDZ77VxC9VPWTqhdqrMyxbvu70Ql+xtnCkc4w2YdTvn3y8cON+vV7tcEqPWsMa3B8eYaooRfDre/rVmXrHa5NhClt6R8cbSTyqhmZ/Toq96vS+OxlmLJQ7/AnWfqLCSr8eKIj3K7CMsMDQ6+abEqcayHw1vP5syIcu24ZdGpIENEGJR2QU1hq04oUS3BSMqtxGJwunquByz6eGBXgbuT6czscQj43F5L/RlEH1r2KVQpkbhRuPczKAURrRMt/Ugm+xrs0KmFxlLUBXAARGNpghANTMCwLJslAMPkyNw9tHYFIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4DR855aNl5Ve/EkPQjXh3JlHJt98MMVHtafRKeMx3qg=;
 b=Y5/zUmfUBX9rOtw7TnqwvnM/zBoZKv4WoaLcQQ+vTshc0ZYntvjdnRI8ykMA5FIdUERiEkWyEkDdNKMD5kD9vFfoZ0h99zrLOe0FlbR6MqOOxqif7sCEJxhRjliK89+7GCgm0vqu/p+WgbeODotah9DDBrFqBopa/ZEvuPrV9sCPzjXPhjvtP4YXztOC+hNi+UASFOxn01bfY3GyBkfNMoWUiq5xUSiNuy8aSDwkV2pvj1wlu/TYMGfuzxkzlWSTqaOePg8WzCcx0GxGz8P2v099CTdOL3h2hrh1Qfh4GxdMmaxnPj51YsQANVA6iT9vjSXBE/VoBazT3/CeYNN+jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by SJ0PR11MB5663.namprd11.prod.outlook.com (2603:10b6:a03:3bc::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Tue, 27 Sep
 2022 01:23:21 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::ccec:43dc:464f:4100]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::ccec:43dc:464f:4100%7]) with mapi id 15.20.5654.025; Tue, 27 Sep 2022
 01:23:21 +0000
Date:   Tue, 27 Sep 2022 09:22:55 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Kees Cook <keescook@chromium.org>,
        Andrey Konovalov <andreyknvl@gmail.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>
Subject: Re: [PATCH v6 2/4] mm/slub: only zero the requested size of buffer
 for kzalloc
Message-ID: <YzJQb2znPB1fDjVE@feng-clx>
References: <20220913065423.520159-1-feng.tang@intel.com>
 <20220913065423.520159-3-feng.tang@intel.com>
 <CA+fCnZfSv98uvxop7YN_L-F=WNVkb5rcwa6Nmf5yN-59p8Sr4Q@mail.gmail.com>
 <202209261305.CF6ED6EEC@keescook>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <202209261305.CF6ED6EEC@keescook>
X-ClientProxiedBy: SG2PR06CA0183.apcprd06.prod.outlook.com (2603:1096:4:1::15)
 To MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|SJ0PR11MB5663:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c9afb2e-51f7-40f7-f1d1-08daa026dda7
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5+KAMJKBayON7KiIVEORAY5EH1JDGc61lEdgs4U7fkkRHKeFW9nIh1N3jGIXFZ/aWLYCcqY70HCsWJyE8TI97fwViEoA1XTL5c4UQWzLd4s1bkk2zwVHSmwNwbsqkGtl6qk87WbVBAhwoQltZ94Km1tk75cww3MWQIUlrny2d+s/K7AEXrGAOZKEmh0NkufRymGI0PSbS260DNlH8FTh9iN96jWF/BMkz2AO/bo3pLLS6vlKQsDsN8AwrjXidRZNGBXIgBQSbtr5ontTNrIh4SE3/YluVbrdc4u8NqonJYGlyHOCb+l6lUG81RIohDcQOKIu3lB6CW3kfvbVuoe6we3zuk9YfKVFqjUyYXFn/G2O7lGavG8UCa4JDUpo77e5csJ9s6BfU8i78AkEQPRFO/0p/y8PpRpr1Yu96VqmSm8yJr/wqF4AY7wjEZUKuA+eYNLzQGPXJSTjNb3VjOSLa060R2TMnEJ197+xvQgdTqvT1oVcGx3WQyIfvtSOqm8csHAAES3HgXzWekhQJ/0dz/NtR1k1dxY9ZdyPF3R7A1t2ULtavpgJrSzTHNIM9SsD3Eo8JU53loF6LX1z+y82CntWJZ7fK3pSdwIwAOHdVsUJonSrUH6EvVmL9RiVeL7pjWgRCsRSP0ptG2G6qg2YZoiNUvpNIeO8XnlULrgl2OOPi5awPeB32cPO7N1PFt/MQQ3OhMpO7UWkAEWn/Gl6CQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(39860400002)(376002)(396003)(136003)(366004)(346002)(451199015)(6486002)(110136005)(478600001)(54906003)(316002)(86362001)(8676002)(66946007)(4326008)(66476007)(66556008)(9686003)(26005)(7416002)(6506007)(83380400001)(53546011)(8936002)(41300700001)(6666004)(44832011)(82960400001)(186003)(5660300002)(6512007)(33716001)(2906002)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Lgx/XuE4rVBtCMpKCGZV6/8Q1GIEhAfkMp7j3UCSnketLRQc5s4n7P1Pza85?=
 =?us-ascii?Q?EO542c5244e8VXjzUPB48qJmJ/Yg/wHmwcfAqKdhlg3ct1nCSw7dyiDL8jgd?=
 =?us-ascii?Q?Po25hmbAhCxPSziaxTVjTCJSSZzTcdSH3rfr5Q6SZQeD1JznuAwabkSKXWfl?=
 =?us-ascii?Q?H3ka92d55NO6XKNXCmmWCXnXznnYbzfBewnokVBkacUN5Tj1pv+prLRvST1p?=
 =?us-ascii?Q?dTtJVQ0FTQxguGIW4jNDldwhrwER4+pbzk/QrkZzTI45jYdaTpdoL+90svwV?=
 =?us-ascii?Q?n/1SQZsBX3QwLY6afwTs4vNEqgFLLNU6TcsjhY4n0fqW2bum54wMQdaFhihn?=
 =?us-ascii?Q?sBU0dmDh4u2o9rQyZT9MnEMyIvglIpolKl23S34exEhi4dp6NoRmDjEsYgCW?=
 =?us-ascii?Q?8S8hLBg1tReUMcwmyyNb/NoUoYLUDJJBUbRmgaqiKnJuzx7zA4io1p5K4jog?=
 =?us-ascii?Q?fQjPHALrVuNukIkYiP+zb9z0MShFL8gXzVdcM7z9MSUgNN+fFekK7/wbihbA?=
 =?us-ascii?Q?rL3Fhg2z5tmCtmfBdE8E/ruVfBfbI/EFAo0x1fjkYR6OLs93XHpDfjtSHgl7?=
 =?us-ascii?Q?xtpDj8weEBUejP/UdlFaU4x+pVXTl3TQmR7bn34hDEPpCcK71sfS6vsb3tlI?=
 =?us-ascii?Q?1YTWUi0yOwvwcOH13LGiNDeb8pvvDc7hLo8+ab5b0tjpwXPrEFl8GSbuE9Bb?=
 =?us-ascii?Q?9JMAOiHVFSjo58x31ObHnHzSpBXPrmjCXPiXWYHnHPcfyjvSnjL4EGVS+dFK?=
 =?us-ascii?Q?XxYSBsH2ZKpJm4WLUBY/exoH+tyXKDBSdvrW+iVVlR3j6EvHuLbISOUonWTa?=
 =?us-ascii?Q?1vj4ozNt5DgzGhokTukQdaKQ1zi9c/XoeWlVcC+U28aAB4/gnA83MyeS95kt?=
 =?us-ascii?Q?S6vQs/38Cnd8X4OSLfugVFtuLBzgft1s2f3Gdo1o4yO6XrFky1HEPgmuesRE?=
 =?us-ascii?Q?SKoG8rDrbAqvMZ3dgGB2TbmAngl8ESYLtbmM9PbR8goq09X2s9AvUrXU9+8d?=
 =?us-ascii?Q?O+dOwpGgPQsi38FEXX7YbUymObhJqtULexGvcxKRR4d5QocnooLstAY+mYkb?=
 =?us-ascii?Q?tIY4rLm9tA+EcyiHB5QpmdDVd9u020Czg7zUZ/EPsxT+QNydPD1/Ggr6ag7J?=
 =?us-ascii?Q?h+raPAcHtQqIZoT884ve6sHl4/ju7E8Qk5Rjj5f32I3kcA5mUBab4QDso59A?=
 =?us-ascii?Q?+JgRnO/UUWaFxFGw6NdTpkFoon6zm4Tx8Higo0JrbAZ+dGQg3xfWEPvZQI3b?=
 =?us-ascii?Q?xohiA2TOlMDxAH8LGy7B2VtjEnzwiIABybDoYNfRj0N2HqrPwRNVzI5J7jLU?=
 =?us-ascii?Q?HQtewcDMfIGxC7gCLT8DQA377NK9oDn7XyNLtYunQ9ip4J1uZcsrSyQzcuhu?=
 =?us-ascii?Q?1swyuajmjcy5K2ede7FtQEAPfiJcrUwMSQM0PsDAYORm6DrsRak9nm/TXL/L?=
 =?us-ascii?Q?CGAWA9vvnudhMcfFjP9Re+/pa1mX6nr5+c5aigGGmz8005kwKfRBu2gbYqHb?=
 =?us-ascii?Q?95myTSe9wHZ/032cGVK8Vl08TIqj67QH9YdzO+JLOP3QtTKA46iPy1x2fUMJ?=
 =?us-ascii?Q?2YvPkEwMOUO6GbLhHK+G2/LQWbpQjDVJ8g8ELXIv?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c9afb2e-51f7-40f7-f1d1-08daa026dda7
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2022 01:23:21.4943
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PpqWUXhL6YfTg1JBetOC5Io6+vTpnHXqvks4d4ksOPh7qYMbdmqh7tycklM0wQDERAF5YwFCjRUXBaPw81Ylmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5663
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2022 at 04:15:02AM +0800, Kees Cook wrote:
> On Mon, Sep 26, 2022 at 09:11:24PM +0200, Andrey Konovalov wrote:
> > On Tue, Sep 13, 2022 at 8:54 AM Feng Tang <feng.tang@intel.com> wrote:
> > >
> > 
> > Hi Feng,
> > 
> > > kzalloc/kmalloc will round up the request size to a fixed size
> > > (mostly power of 2), so the allocated memory could be more than
> > > requested. Currently kzalloc family APIs will zero all the
> > > allocated memory.
> > >
> > > To detect out-of-bound usage of the extra allocated memory, only
> > > zero the requested part, so that sanity check could be added to
> > > the extra space later.
> > 
> > I still don't like the idea of only zeroing the requested memory and
> > not the whole object. Considering potential info-leak vulnerabilities.
> 
> I really really do not like reducing the zeroing size. We're trying to
> be proactive against _flaws_, which means that when there's a memory
> over-read (or uninitialized use), suddenly the scope of the exposure (or
> control) is wider/looser.
> 
> Imagine the (unfortunately very common) case of use-after-free attacks,
> which leverage type confusion: some object is located in kmalloc-128
> because it's 126 bytes. That slot gets freed and reallocated to, say, a
> 97 byte object going through kzalloc() or zero-on-init. With this patch
> the bytes above the 97 don't get zeroed, and the stale data from the
> prior 126 byte object say there happily to be used again later through
> a dangling pointer, or whatever. Without the proposed patch, the entire
> 128 bytes is wiped, which makes stale data re-use more difficult.

Thanks for the details explaination, which is a valid concern.

And Andrey's suggestion is a good solution: only reduce the zeroing
size for kmalloc-redzone enabled objects, as the extra space will be
redzoned, and no info will be leaked.

Thanks,
Feng
