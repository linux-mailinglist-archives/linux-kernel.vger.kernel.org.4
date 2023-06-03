Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 205E2720DBC
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 06:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232993AbjFCEMC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jun 2023 00:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231367AbjFCEL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jun 2023 00:11:58 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B22DE135;
        Fri,  2 Jun 2023 21:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685765516; x=1717301516;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=nR5jwlH5oGUcqCVJHtPafzQjebkeGA2BmXTPoU8NGyI=;
  b=A3ReQOJ3KeUbWxgk8BSavdA96newRhxZXvXu2bk9E02QDrXAJvbFNreE
   TehvMs256qiY21igOZeC8eDB3AqDkQduEd86N3ZI6N8ugqiyXsIYHtMUI
   lRGdBxkNJofjBWhEDgGYKBHlY/jfVSH5UWtDognQZ3SiikTGHDPrqzizD
   ZhfhesLochaMsUwCEs+YDj6dB9v27JNh1CyA4pGQNw6IQnzZjcDaM2Uia
   vk+1Qo8kHvjGlw61XHNB2sjJicrxYwgvuL4SMZx0cwKSKVal/uTsqld3+
   pOLhzfUPJD6wf/WCL+Wi00X/KcIz+6fYIzxGGGBSjo3YtLjdxGxeTHHCD
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10729"; a="345615362"
X-IronPort-AV: E=Sophos;i="6.00,215,1681196400"; 
   d="scan'208";a="345615362"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2023 21:11:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10729"; a="711189871"
X-IronPort-AV: E=Sophos;i="6.00,215,1681196400"; 
   d="scan'208";a="711189871"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga007.fm.intel.com with ESMTP; 02 Jun 2023 21:11:55 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 2 Jun 2023 21:11:55 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 2 Jun 2023 21:11:55 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 2 Jun 2023 21:11:55 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.176)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 2 Jun 2023 21:11:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dcgNvfRrQOpPybBKJT1zBk+/+6bcDI0kT87QtcsyEmHlmfrdVXNRb9S35BK21FdEwxFORY18f2lQvFYz8u9WDOK551LzkKYvryFJLCjdtVhLPlb86A2ATr75v2mJFqw9c0XzKxn1AwEdba55uKEL7XJpN9BmCx9QaWZdGs7nllNG48BqgxLigtEd3EvRzMbJTLe8SBfrN0JV63Y8lVGO+aLERmy7VZ3Jl7Qbi69fs0hHDiko+sASjY9pmvUd3CeUlkiICg7uAWH4wYsL3vGfefvZ6p/b3wvHLOPrRk3jlYixts65UA6olfr1IRZ8dbjhU8+NCbaD2TDK6V93F/O3Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=btWtzUffq+HPwt+b06xLfCKCRG8Mce+aAtfJ/Qyoiek=;
 b=Bc9rEOQme37lwfGnwxZdm6pWLG6PZwDZpJeFOj0QPA+blp44UdzYbe4vimbqaOiPiDncNfBRAI4cs0phnaaq5dYbH3OTJ7zE8FOFWmTa0J4mFchPbG/HdVvJOK9ePgEkCUyKXHXYhFXZFI1Y7hx/kCsnqKPIzSk7185YJ5ahNTEE0gaqGHu9zrAIO+eGHE1XOFQEud6tZC1+xnKWgwY47gQNNcbYLWQlSlbk7JkueS+X0zJkZWHF87F6CfDPlCJlQVTeL0tYDuLQnFD46Fc8N53RcTRAoz5SsHmyRPJPnt/Pou0QhjUUvLQRCCH8cLHnOlvpwmfT8SPvufwygM+8lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH8PR11MB7045.namprd11.prod.outlook.com (2603:10b6:510:217::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.22; Sat, 3 Jun
 2023 04:11:52 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5%3]) with mapi id 15.20.6455.020; Sat, 3 Jun 2023
 04:11:51 +0000
Date:   Fri, 2 Jun 2023 21:11:48 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Paul Cassella <cassella@hpe.com>, Ira Weiny <ira.weiny@intel.com>
CC:     <dan.j.williams@intel.com>,
        Yongqiang Liu <liuyongqiang13@huawei.com>,
        <linux-kernel@vger.kernel.org>, <nvdimm@lists.linux.dev>,
        <vishal.l.verma@intel.com>, <dave.jiang@intel.com>,
        <akpm@linux-foundation.org>, <joao.m.martins@oracle.com>,
        <zhangxiaoxu5@huawei.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH] dax/hmem: Fix refcount leak in dax_hmem_probe()
Message-ID: <647abd845bfac_142af8294a0@dwillia2-xfh.jf.intel.com.notmuch>
References: <20221203095858.612027-1-liuyongqiang13@huawei.com>
 <Y4u2TK4yPU9dfiDr@iweiny-mobl>
 <d0819e2a-f584-3287-61ba-88ea78a9885b@hpe.com>
 <647a384743e5d_c35b294af@iweiny-mobl.notmuch>
 <3cf0890b-4eb0-e70e-cd9c-2ecc3d496263@hpe.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <3cf0890b-4eb0-e70e-cd9c-2ecc3d496263@hpe.com>
X-ClientProxiedBy: BY5PR17CA0044.namprd17.prod.outlook.com
 (2603:10b6:a03:167::21) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH8PR11MB7045:EE_
X-MS-Office365-Filtering-Correlation-Id: ba603c4a-3800-41e6-ba10-08db63e8a817
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uxavoyexwuTsqrKF3lFU9docoWUHwIJ2i5XO3ob+A/8RFXC24/2jo0BniRyKlNt0m0gvYlTJ2anLibMm2cAOKBuN97sFNYvl5nn1XtivgnbKLPuI+4Zocq7xYQEtnty3Q/mzsnsiqAUMC399H7+gac9tBIb0DZmvPuYFl4fMCmitNS62Qqj+8HOZ9djFhn1u5kam/amwvY4WSbyfd6fPBbS9AyMjkvIFxWry4CnDV8yNEYgac/YY9nNubt+GJzyJy048/xIVHWkChp9rujgrZpvp4ZPMlirbsE+uX6Ko+tZIyzo7xHQaCNgMeFMsnOU5+XlXYa4idvG1VZ7LWEpiF/w9zs9ZgBa1HiB5ckqNPIebuHVMhkTxqdv7tn41215eYaElXw7ZxbnujsZ9tzrJUdyzoCnT43KzNUwZ/5PAdMsgIs1Mia0UnRDnpaipdc/FlU5v5WDq/velIiWxk60bxLY+nRKT6+dfe5KkDDnl6F9dJRfv8n7RSz3CAMrdornFyrAqad3oiasrVQECa8Zhdji81RNRADUN23YBD24ukIi3UFLaTx0Dd4mqRo74ov/n
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(396003)(136003)(366004)(346002)(451199021)(82960400001)(38100700002)(66946007)(83380400001)(66556008)(66476007)(110136005)(86362001)(4326008)(6636002)(296002)(2906002)(316002)(6512007)(186003)(26005)(6486002)(6506007)(9686003)(5660300002)(41300700001)(6666004)(478600001)(8676002)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qAnurm/2h7v0/ZNiIh/YUwqVE87P0/T1B4MJ4AQXZgbhq/lErnAMOnBW6k8+?=
 =?us-ascii?Q?yL+LxqBOnrFZGRbyfzg1Ho/S9f/i+lgO87sMfyWPCB/TOSBVBFNO3/LhUkpT?=
 =?us-ascii?Q?5gAQR4/U/AXzCla96cZMdqHpBEcu91JTnttqVY2IjuOWA+qRCylJVjG8IQIW?=
 =?us-ascii?Q?9djsaP7zOo3JwZ8ITH1EGaL1cV6NhQEQ7A6x0avBiOaufrtejLjRdYBGOB3j?=
 =?us-ascii?Q?UVvWot949+wPXZyD98VKXr0yic7lQsN50KWrpM5X0uCRGlVDfWsWUiO0VxJG?=
 =?us-ascii?Q?IDmn6NytpLVhjESmza40IPNDTwKcvMRNJ3I/ctarq/CrLMuKFeKmbJzuohzd?=
 =?us-ascii?Q?PR9grEjvX9+sSJEYV65gww8Uv/ttGANEnxAIh0HgA1aa6hg/Cai/KiMuvkQi?=
 =?us-ascii?Q?BSRxpKcAoaGyaTuwMriMgivrAm+xl+Y/aeqXZ3Iqus+fjtWwjt7xpAKe3FGF?=
 =?us-ascii?Q?HbwqI2yog5itDf/FqJ2HywkjOpABaFWTVLPkEUSZbBV15x0/TJu5h74GGU3C?=
 =?us-ascii?Q?+pEztMEshCou8poMifSu3baUG3cDPalMT+qdw2dQrtqf7caIRUXNHPgGTr5l?=
 =?us-ascii?Q?AaXLoTO4/S2ax2z6LwAzdFdHep3JkxRLPkMGIwZ9p96LfMI1sR1pHhmVbW+w?=
 =?us-ascii?Q?VQsRezn9ZZe0rJahG6h5SOBNCNa5mJZKimAHB9yU4jXYnqX1o1Kr9DuPlMBL?=
 =?us-ascii?Q?puFF+4ErbbVOTWhb1S932nkWmVCIBSuNCnm2dv0VCcel1dpoBoWzwCqWd1R+?=
 =?us-ascii?Q?jSi7fVqAolaTXyV/7fLaMPIp8UFg6nZCdXkVG4rE/t7igpXP4W+EsDptUqcE?=
 =?us-ascii?Q?1BCD2WTEfd+sN9gNUBHHNj/BcHvTqYXQS+XQwgOlALsW44ZC+G8lTU5zya0W?=
 =?us-ascii?Q?4JbRsagvnzYGn2FSyf4QxYIIp3L5344sTyoeR0Ah9RNNJsOHt3xDQZIuKRE1?=
 =?us-ascii?Q?YYyJWaEjMHTu4VAvNG/AI1gkSij/sBaaVfvRde8Z9MROexRCjT5yG2Rjrj1V?=
 =?us-ascii?Q?oDCnTzgbBXczvwRGNg4hkP14CAl/mEO0owaRyX9iyozu8gEN85Fze2oD3vBn?=
 =?us-ascii?Q?vUq0uKF9cWd0FzUaDF21YXcNPGows4buXDC51jyvj7AWGRLS+3KXbwrvtRqY?=
 =?us-ascii?Q?ZLlRAPsYRuEz9tK9ECLOVCt7/jpDfgPv1nqdAMRuz0SaCbaakDyeGfiXePDg?=
 =?us-ascii?Q?CZ6eu5GN/Jg5I+9jwZEjS5+qUtDSB2SPr8wLrz5MDGs11/RnZGdUefor8rSp?=
 =?us-ascii?Q?fPvqHgDDJAe41cZEwDvnrrfOIHlHxheUPuLJTkcn1Wa0OqvVZ8kYQDJSKgsQ?=
 =?us-ascii?Q?106xByUg1V7y40Ck3H3k7hIgKmN1Cxh2LhMx+EqeeD1YIjtLmz5aqH5pTMHp?=
 =?us-ascii?Q?1amF5b8EFJb2NE/DXDgIHeKHfjmfQ7g3voD6ga1WL93n+eTDdA4FBIway0V5?=
 =?us-ascii?Q?knc9f8r2rAWSEbKl6OzQFQUwTa2ZYPEBCP3p3hJsivf6wyfC8J9VlHB5MuhW?=
 =?us-ascii?Q?vTbr1Hz9HFDXq6Ef0YtBrNNwoINHOMi20dcUpVP5SG6+ab0XvjFeUgWtuGOG?=
 =?us-ascii?Q?XJplw1/SNr5+MhVYJaBjxmcoQBLZ1zBLj58eyDUUuoEHupQnmYnsvxOgJMrz?=
 =?us-ascii?Q?cA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ba603c4a-3800-41e6-ba10-08db63e8a817
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2023 04:11:50.9723
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /mEm+MwdAauX3bzzBAcU4KPAYfMff7y5bFIRuYfsiiIr0M29jECOAx7M2F5zpQgbk/UL8B0I0g9WoOrHyqaHakT5nBGpyBDVPgFa65aPhJw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7045
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Cassella wrote:
> On Fri, 2 Jun 2023, Ira Weiny wrote:
> > Paul Cassella wrote:
> > > On Sat, 3 Dec 2022, Ira Weiny wrote:
> > > > On Sat, Dec 03, 2022 at 09:58:58AM +0000, Yongqiang Liu wrote:
> 
> > > > > We should always call dax_region_put() whenever devm_create_dev_dax()
> > > > > succeed or fail to avoid refcount leak of dax_region. Move the return
> > > > > value check after dax_region_put().
> 
> > > > I think dax_region_put is called from dax_region_unregister() automatically on
> > > > tear down.
> 
> > > Note the reference dax_region_unregister() will be putting is the one 
> > > devm_create_dev_dax() takes by kref_get(&dax_region->kref).   I think 
> > > dax_hmem_probe() needs to put its reference in the error case, as in the 
> > > successful case.
> 
> > Looking at this again I'm inclined to agree that something is wrong.  But
> > I'm not sure this patch fixes it. anything.
> 
> > When you say:
> > 
> > > ...   I think 
> > > dax_hmem_probe() needs to put its reference in the error case, as in the 
> > > successful case.
> > 
> > ... which kref_get() is dax_hmem_probe() letting go?
> 
> Isn't it letting go of the initial kref_init() reference from 
> alloc_dax_region()?
> 
> Sorry, I had gone through the code a little carelessly yesterday.  Now I 
> think that kref_init() reference is the one that dax_hmem_probe() is 
> dropping in the success case, and which still needs to be dropped in the 
> error case.
> 
> (If so, I think the alloc_dax_region() path that returns NULL on 
> devm_add_action_or_reset() failure, releasing the kref_get reference, will 
> leak the kref_init reference and the region.)

Yes, *this* one looks valid. All the other patches in this thread had me
asking, "um, did you try it?".

Now, that said, the games that this init path is playing are hard to
follow and it should not be the case that alloc_dax_region() needs to
hold a reference on behalf of some future code path that might need it.

Lets make this clearer by moving the reference count management closer
to the object that needs it dax_region->ida. Where the extra references
were being taken on behalf of "static" regions just in case they needed
to be reference in dev_dax_release().

I also found a dax_mapping lifetime issue while testing this, so I
appreciate the focus here.
