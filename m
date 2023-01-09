Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8C18662803
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 15:04:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236594AbjAIOEB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 09:04:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232809AbjAIODP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 09:03:15 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81DFE1CFF7
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 06:02:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673272936; x=1704808936;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=uRdptGWNLp+tc9pk4FUUO4bJ1ExS3CLgxLSUYeBbL2g=;
  b=UluG7sogXwHLjF/Z3J9tsC4DqOCSkkYMZajnd9OdRfnIKc509ZFVZzsF
   1sB1l687BwaxPw7fQOJ0ioZ7CNP7zcEMK3DRpxmG+VLxZB2XO7YnLA7QN
   brVhivAH8v+2o99RMJhQZTa6g5Vs3gePyBtHR/YdaWtNPEqa/bXQFTB56
   EPiT2+r08BjxXe0BJaaKR3nasOn2aaKnxJjFFOIc5LRPQIFxLSkqqZchl
   wzSlOT6yxIFD1Np9H78/aYQxoHp1j+eLbeDHVqStkN5AsJfWWrBuXWBRl
   1zMMLm4wx2D2OZNAZ4L0JnoAc01CExWw0IMVSSnhxz1oLAN+touTWsUa2
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="385178621"
X-IronPort-AV: E=Sophos;i="5.96,311,1665471600"; 
   d="scan'208";a="385178621"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2023 06:01:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="689034288"
X-IronPort-AV: E=Sophos;i="5.96,311,1665471600"; 
   d="scan'208";a="689034288"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga001.jf.intel.com with ESMTP; 09 Jan 2023 06:01:29 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 9 Jan 2023 06:01:28 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 9 Jan 2023 06:01:28 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 9 Jan 2023 06:01:28 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.48) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 9 Jan 2023 06:01:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I1IjuKSanuZD5dJFpttrLqpZQGzAgZ8c3i14oCHwS+n/PLuJvwLCM0ODi/rU8l/pqbKybpqJjSG1sfZHBdcxZMDQAvvnhJHcoV0M+SpsGaSwLJFwBuOqyK3VWYLhXppYVIypuml8Kuoy3VoSYzjBLtzkap05beO7/xIiVuCcH2xfpaNgiD+1jdHxVh9sr3rLmE+JQs7hHjEj4RoO8HrdmYyh0ZIxryQes4U018ZVAZkcpVQLgMwo9fQosocxNvQMpQtd/34Sf6DS2SIyOEgDA1Vcmbe0HjQxv40/NIj9RxDuZGmD9GTmsGdrqbbHQ8JMhEbHIZHzqh8c/KFtpv0wbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hZ0UJZQbcXfqjmTiMI07qjSL9mydwSD3a0T4o8q3ipQ=;
 b=PCOZMUZ7oCwqNicWSh8RL9z6gmOaJOqF+KDhMPunndlgM1wUtwNZPjdW8IhLi+XcDSvGcYButK+RpMLE5Llw9GJl2npU/0EqVBpn+JsmKryMApO4pfpNFNx0eIfPAIqfVjTxIT6RiTwMyWLOSIImUqZxk8udMo79qTXHvvcyUQVT8CIynYsvYaYuVi/63tWPQkyq7eWE4UWt4R4h9i9k72PdsXzzUugVHi0ziSmFw0Yg5IzC4m7nn9dnWQ2zJNbJKoqpiglLQqg4T6NjkoxMngEBIK/d6rwDZCfFcWHke1b5lmH/APeeINIoX5AGO42HVpkfmoyJ6fPTtwipQMWW8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by DM4PR11MB5501.namprd11.prod.outlook.com (2603:10b6:5:388::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Mon, 9 Jan
 2023 14:01:25 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::878d:c56c:28fd:e1cd]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::878d:c56c:28fd:e1cd%4]) with mapi id 15.20.5986.018; Mon, 9 Jan 2023
 14:01:24 +0000
Date:   Mon, 9 Jan 2023 22:01:15 +0800
From:   Oliver Sang <oliver.sang@intel.com>
To:     Vlastimil Babka <vbabka@suse.cz>
CC:     Hyeonggon Yoo <42.hyeyoo@gmail.com>, <oe-lkp@lists.linux.dev>,
        <lkp@intel.com>, Mike Rapoport <rppt@linux.ibm.com>,
        Christoph Lameter <cl@linux.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [linus:master] [mm, slub] 0af8489b02:
 kernel_BUG_at_include/linux/mm.h
Message-ID: <Y7weKyxIY+QFYq6j@xsang-OptiPlex-9020>
References: <202212312021.bc1efe86-oliver.sang@intel.com>
 <41276905-b8a5-76ae-8a17-a8ec6558e988@suse.cz>
 <Y7Qxucg5le7WOzr7@xsang-OptiPlex-9020>
 <Y7VBFLHY/PMbb4XS@hyeyoo>
 <Y7Yr3kEkDEd51xns@xsang-OptiPlex-9020>
 <3f7fa3b3-9623-5c4c-94b1-a41dea6eaaf2@suse.cz>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <3f7fa3b3-9623-5c4c-94b1-a41dea6eaaf2@suse.cz>
X-ClientProxiedBy: SI1PR02CA0005.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::13) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|DM4PR11MB5501:EE_
X-MS-Office365-Filtering-Correlation-Id: b2eed51a-ade7-433b-650d-08daf249feb9
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K3JZCR8YUSraP2CZGKOOv99ER0iTFGmlAHs3PEA+aw5bTMNcD+2BLYCZE8lfuQptkHVzqXJ9uo7MNaPDvIbfUAfQ0XCukTKWWG78TjxndydEOCm81OVocKiHISEYQvHi1HVjGoVQIwIgIs9UqowwIeTdCGWevIpYi9/HQ2wjxnAi7lf/fzx6ygct1G4m6UKWuiZx0nB5lDm1zOMGaHH8mjYcLrh+6Roq0TLLYfUDEdpW92vo4yo9/xmt8cwQKr+cXcBU8fYShKT7LYSEMmo7ajhP2Ylzd4tz8EqzfJ/FQWBid7qnJ0Qt7sNzBKfcgzV0OqkFtg5woXdIK9+hhZRk3BECUG0d65iq7HPlQJD2zVD4x6hmSxWZxQVPhbCLuPHMD96+axTA+RXQVmXfUztL0EtsiEVTFb+v0B8/yF9W2BGug8MpsAEEeiO6tdSXzdchuToofnZ1khc+FLweAEKr7qHDFyAnYKMyiVy8sZXkl+oMEP9Ac93ygyeVdQxrNKBr0nY/5ZLTY0Wg8wtZ67C03uxv5s3eRJrFBJNRWdE9hudcd8upgaPw35v3kxnbwnMy8li2id2V+uQvr+uitIxZt9g5Qf+2m7WpOKXJ4Ld6j6q3BtU7DGoJaju8S/DkrdvJJQ/heWm8z28sPQ7yyGW6BKg0lDB/X18RoT0bKRFx7mTXPyPLXO/+wB8uA7xldFFa
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(136003)(346002)(39860400002)(366004)(396003)(376002)(451199015)(2906002)(8936002)(44832011)(5660300002)(66556008)(41300700001)(6666004)(66476007)(66946007)(8676002)(316002)(54906003)(4326008)(6486002)(53546011)(26005)(478600001)(6506007)(9686003)(186003)(6512007)(6916009)(86362001)(33716001)(83380400001)(82960400001)(38100700002)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rxz9NenbtJfcQC6HWl2NRVF6CiVJRTWK1FkbbFyoDmwVj3matAIraF8qO1hX?=
 =?us-ascii?Q?UYzr72aUur2tYB2pgbes9xgyarRrq37zcBNd2AzIllo6D17yxnhI/sjCLEAA?=
 =?us-ascii?Q?SwsOFs8/nRLaR+fqAQxyGUaTO+oyXzADKl0+ErjgEZMd9eiqRPKzKb3+Qra2?=
 =?us-ascii?Q?sSOhz+D4Z9T3IYvudQqVbygfCz1rz4VEepr5/qYYttkckFtrXn5O0Tr3a6cU?=
 =?us-ascii?Q?pdflmzSb74Ez34KqsGRxK3cMmdxEo6645WFpYZEDfTVtrpheC4i8Jtw9U0e9?=
 =?us-ascii?Q?eUUscumfswNeJ7I3OYbZ6SlhTGLloJhTYCjuy3zWRIrQ7pOnyFbWeJSflIVa?=
 =?us-ascii?Q?+iCxP3azFT3EHaPDZVUa4FxNOBvWn5TZMDGUmjXYWDEMuHY73cu1yfLgLTf+?=
 =?us-ascii?Q?HSjjHU9K/W1K99+gqCCzqebtOmGGCUnHqmlVzEpOrL0T7jW89NOMcts6/dmL?=
 =?us-ascii?Q?yFHX3pYPoJ5Bmfyd7MUIcJynQ4oDOJLY/LHWTWATU3X3DQn309Wx0uFXFGzM?=
 =?us-ascii?Q?+4sM/wQKNVwsjMyuqKMvIY758wvPzfbiiwvmcp/KC2jKI/6kCzysa0eJ5XzC?=
 =?us-ascii?Q?V+UlXbOwAP7T6pxByr1nyqbB5xYYp74IXD2cAjxB1i18qnbeptf9314IxKq+?=
 =?us-ascii?Q?x5DbXfDv6oEz6lSltwdtXQ0JKWUmotah06yxuaLahID+hPBzGXUT1j+kKmyS?=
 =?us-ascii?Q?hnkFmQI2fkNi/TFOPHQuVMpiryDV77ILArLTOAjYfHVFz+QnhomZ270Iztoj?=
 =?us-ascii?Q?WLItxwXCEBRijI5Tmu4peG0cUfHSaeFnMULH4W6pcq9FmhItJMWQJvye4HFw?=
 =?us-ascii?Q?NXzPSGgvJ0RtesDi/vSsSMntq1yC0sjxnOBcDuNn44b+uqOVIP1uJpWeQVVM?=
 =?us-ascii?Q?GTDs4JMz73+d+sT9vBUoHaolzGucFiwO2HMLy3Z77w1L/PgJBd8fEeCcsHOu?=
 =?us-ascii?Q?Njx3yVO12CT3qgP3v9u7RUHw2sqff2WtJ94N9ZxkABxNn4pG73Bgt4Yi0mb9?=
 =?us-ascii?Q?0i4udfOE5zhLLr/lrja5weol0PH52/hIs/IQzEOJI5ALbDs7HN9sfo1uFcuM?=
 =?us-ascii?Q?L+/zC2ACj81chwTW2Naj5yO6FxaR6ohaydMCJZyUlfF7LpNta1P7wEdkZ8FC?=
 =?us-ascii?Q?cvd8uAdRQpd8zXXyQeOjZixZXPuG4J1SzVUrK0r3baJp7W4Nqpes0cVBIaRy?=
 =?us-ascii?Q?bm/WTmbHfY0SQg3Uh2hCR5KFB6AKHCPpbW6u2kmL3UVZYszK+fLdw77wQi2C?=
 =?us-ascii?Q?gZN1r4+xnFBPCp8Ldy1B0659rbzUZ/CcF5HeYAZP9BTJJ6/SFJTWK6MJQMef?=
 =?us-ascii?Q?nQ8oyT0l9kpdeh+OhTsDpU/CEsxqWxcuMDUtvG6C6ib7y9tEOSC5qx/lYXK+?=
 =?us-ascii?Q?Zj2iuG+/fNivP7FhKSu5tV61lxglL55ipr31S/T+QlJBlOTtYJ8vHc1unISK?=
 =?us-ascii?Q?tsc1VUt1nzBFOy6f2Am3yKAymvAmnSpaco/YSDCHTCNaF8QSJWuyNEXbbjbV?=
 =?us-ascii?Q?fWUXiSriYTzlGD7nHTYfvOws79HgsSp6Ww7LTwXirjwwAVDcC53QrwznZMkk?=
 =?us-ascii?Q?Z4ajMrFBJPJMINxdqAlY0vgYXG+9/VT6d9U/9u812D57lsbMytKLN3r8tu9N?=
 =?us-ascii?Q?aw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b2eed51a-ade7-433b-650d-08daf249feb9
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2023 14:01:24.8630
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pG7pVnd5MWZGUhWL+kpHzSSOcQF9P/ThXt2i/6Q3sVJyXUOBQVDl576nmgPfbgG6j7Lno4d7zud5lz/P0hE9CQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5501
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi, Vlastimil,

On Fri, Jan 06, 2023 at 11:13:15AM +0100, Vlastimil Babka wrote:
> On 1/5/23 02:46, Oliver Sang wrote:
> > hi, Hyeonggon, hi, Vlastimil,
> > 
> > On Wed, Jan 04, 2023 at 06:04:20PM +0900, Hyeonggon Yoo wrote:
> >> On Tue, Jan 03, 2023 at 09:46:33PM +0800, Oliver Sang wrote:
> >> > On Tue, Jan 03, 2023 at 11:42:11AM +0100, Vlastimil Babka wrote:
> >> > > So the events leading up to this could be something like:
> >> > > 
> >> > > - 0x2daee is order-1 slab folio of the inode cache, sitting on the partial list
> >> > > - despite being on partial list, it's freed ???
> >> > > - somebody else allocates order-2 page 0x2daec and uses it for whatever,
> >> > > then frees it
> >> > > - 0x2daec is reallocated as order-1 slab from names_cache, then freed
> >> > > - we try to allocate from the slab page 0x2daee and trip on the PageTail
> >> > > 
> >> > > Except, the freeing of order-2 page would have reset the PageTail and
> >> > > compound_head in 0x2daec, so this is even more complicated or involves some
> >> > > extra race?
> >> > 
> >> > FYI, we ran tests more up to 500 times, then saw different issues but rate is
> >> > actually low
> >> > 
> >> > 56d5a2b9ba85a390 0af8489b0216fa1dd83e264bef8
> >> > ---------------- ---------------------------
> >> >        fail:runs  %reproduction    fail:runs
> >> >            |             |             |
> >> >            :500         12%          61:500   dmesg.invalid_opcode:#[##]
> >> >            :500          3%          14:500   dmesg.kernel_BUG_at_include/linux/mm.h
> >> >            :500          3%          17:500   dmesg.kernel_BUG_at_include/linux/page-flags.h
> >> >            :500          5%          26:500   dmesg.kernel_BUG_at_lib/list_debug.c
> >> >            :500          0%           2:500   dmesg.kernel_BUG_at_mm/page_alloc.c
> >> >            :500          0%           2:500   dmesg.kernel_BUG_at_mm/usercopy.c
> >> > 
> > 
> > hi Vlastimil,
> > 
> > as you mentioned
> >> Hm even if rate is low, the different kinds of reports could be useful to
> >> see, if all of that is caused by the commit.
> > 
> > we tried to run tests even more times, but with the config which enable
> >     CONFIG_DEBUG_PAGEALLOC
> >     CONFIG_DEBUG_PAGEALLOC_ENABLE_DEFAULT
> > (config is attached as
> >     config-6.1.0-rc2-00014-g0af8489b0216+CONFIG_DEBUG_PAGEALLOC+CONFIG_DEBUG_PAGEALLOC_ENABLE_DEFAULT
> > the only diff with previous config is
> > @@ -5601,7 +5601,8 @@ CONFIG_HAVE_KCSAN_COMPILER=y
> >  # Memory Debugging
> >  #
> >  CONFIG_PAGE_EXTENSION=y
> > -# CONFIG_DEBUG_PAGEALLOC is not set
> > +CONFIG_DEBUG_PAGEALLOC=y
> > +CONFIG_DEBUG_PAGEALLOC_ENABLE_DEFAULT=y
> >  CONFIG_PAGE_OWNER=y
> >  # CONFIG_PAGE_POISONING is not set
> >  CONFIG_DEBUG_PAGE_REF=y
> > )
> > 
> > what we found now is some issues are also reproduced on parent now (still by
> > rcutorture tests here), though seems lower rate on parent.
> > 
> > =========================================================================================
> > compiler/kconfig/rootfs/runtime/tbox_group/test/testcase/torture_type:
> >   gcc-11/i386-randconfig-a012-20221226+CONFIG_DEBUG_PAGEALLOC+CONFIG_DEBUG_PAGEALLOC_ENABLE_DEFAULT/debian-11.1-i386-20220923.cgz/300s/vm-snb/default/rcutorture/tasks-tracing
> > 
> > 56d5a2b9ba85a390 0af8489b0216fa1dd83e264bef8
> > ---------------- ---------------------------
> >        fail:runs  %reproduction    fail:runs
> >            |             |             |
> >           8:985         19%         199:990   dmesg.invalid_opcode:#[##]
> >            :985          5%          51:990   dmesg.kernel_BUG_at_include/linux/mm.h
> >           3:985          4%          41:990   dmesg.kernel_BUG_at_include/linux/page-flags.h
> >           4:985         10%         102:990   dmesg.kernel_BUG_at_lib/list_debug.c
> >            :985          0%           2:990   dmesg.kernel_BUG_at_mm/page_alloc.c
> >           1:985          0%           3:990   dmesg.kernel_BUG_at_mm/usercopy.c
> > 
> > however, we noticed dmesg.kernel_BUG_at_include/linux/mm.h still have
> > relatively high rate on this commit but keeps clean on parent.
> 
> Well that's interesting. As long as any bugs happen in the parent, it could
> mean the commit we suspect is just changing the circumstances and creating
> conditions that increase the bug happening - e.g. because it causes slab
> pages to be always immediately freed when the last object is freed.
> 
> So I would be curiou about how some of the reports from the parent look like
> in detail.

since now we have below 3 also for parent:
           3:985          4%          41:990   dmesg.kernel_BUG_at_include/linux/page-flags.h
           4:985         10%         102:990   dmesg.kernel_BUG_at_lib/list_debug.c
           1:985          0%           3:990   dmesg.kernel_BUG_at_mm/usercopy.c
I pick one dmesg for each case from parent commit (56d5a2b9ba85a390) as
attached:
  dmesg-parent-bug-at-page-flags-h.xz
  dmesg-parent-bug-at-list_debug-c.xz
  dmesg-parent-bug-at-usercopy-c.xz
FYI

> And if the rate at the parent (has it increased thanks to the
> DEBUG_PAGEALLOC?) is sufficient to bisect to the truly first bad commit. Thanks!

got it. Thanks for suggestion!

since 0af8489b02 is based on v6.1-rc2, we will test (both rectorture and boot)
with same config upon v6.1-rc2 to see if it's really clean there.
if so we will use dmesg.invalid_opcode:#[##] to trigger new bisect.

will keep you updated. Thanks

> 
> 
