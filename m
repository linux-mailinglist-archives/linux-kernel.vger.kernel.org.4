Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8285F72FEA0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 14:28:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243973AbjFNM15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 08:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235751AbjFNM1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 08:27:55 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E7641FD0;
        Wed, 14 Jun 2023 05:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686745674; x=1718281674;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=ksvfg2EIa9Hdb6X2ZcJHdTZc/sfxySJTCIyJTHIxMOk=;
  b=NxbTaifJ2YjWzR4hxvpEY7lLDPZAmZ7w9jzQ15yeGnaEBnqCI/da4v64
   nVo8Zw4O7Vh7xN2x/hp8q1DctyaGLArK+SkA4VTFROeLgLfNqc1S3q2Mm
   Owfas3PLn9mAVzuMfFx310tJjeAGO9x4+MGiGs+3zBg5NTXhed1yxiEcW
   5tkb2BEKJa6+vGdhy+V3zvdpAk0+BFdmD2crI81p2qWKIX2u3I8KfVjbr
   XSZJCg5fcpeQ9N28gR0NvO7pf5ZZ2fx0OJOAudefTGVLm1EPttVMniw0B
   Gqbdh0hgqlS9VTOGod5hJrmf2KhNpT11mTzG872c15FehEBmtStqRaPrN
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="361077486"
X-IronPort-AV: E=Sophos;i="6.00,242,1681196400"; 
   d="scan'208";a="361077486"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 05:27:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="1042191526"
X-IronPort-AV: E=Sophos;i="6.00,242,1681196400"; 
   d="scan'208";a="1042191526"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga005.fm.intel.com with ESMTP; 14 Jun 2023 05:27:47 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 14 Jun 2023 05:27:46 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 14 Jun 2023 05:27:46 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 14 Jun 2023 05:27:46 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 14 Jun 2023 05:27:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YVZDeQiUc03bixQdWanmZ1ExggW3N0b1SReHbXbleolkhQENMkLm21y6DDeT0WOc6OWGWE1/hBDJZqtmYCJtnJPMBNQH/Izl7wSaxyyEyFvXVomNOZIPbmA53O2SzscgQviGPVq+OmIaru+FV88NNRLjxs4uyGRz0MKYj6V5j5A0K9Byyxk+JiPgV3Gceb8iq5x97vs9vtVLPB5Bbd+OV4f5GWE44ZY48cdFS/RarMclEPd9EPYsLGfGSwhTM+1Qt3RUW1l0Cz0XzUytDHrOmi+E0XgEEJ8rz5s+XmF/IDyUHhEe0HifsVSdXYclcfaIqcfIgiXxElInKiUiaASnnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YW0YoBrW0q7W8R33LOsC644Y2aabUdQ3n5/VedGqFxU=;
 b=GD+wX9AmlWsLLEP2Zth5qPtK1Hj5up/gIxFRNTw5H65blz9Rym9Zt0e2fH6Edc/bgs8XHXG2xWt0mkWwA2NNSIQ5B7RUIG48gwnmqMzUhzYGVA0dSjHtrGw5euJGKzru2ARzimTPSe9a5SlOeOUg7u92O2hAVeXROcaXZST5jw4Vc3PdPw5tPWaVjKrOLjgxBBqWLdIyZCBi+E/INYt9eLWEtuWQ99syLrGvNudMx68HH9xdD3piF8pp2JOLvHmixvQKBT2J7J8dg+JGdyelxp7mx0cyY88rJpg0iuNLHqZTCJU70gtZJjdjgKeyIbzesZkTNNpa8zaZTDMYEWGYrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MW5PR11MB5931.namprd11.prod.outlook.com (2603:10b6:303:198::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.46; Wed, 14 Jun
 2023 12:27:43 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5%5]) with mapi id 15.20.6455.030; Wed, 14 Jun 2023
 12:27:43 +0000
Date:   Wed, 14 Jun 2023 05:27:39 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     "Wilczynski, Michal" <michal.wilczynski@intel.com>,
        <alison.schofield@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Len Brown" <lenb@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "Borislav Petkov" <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Jonathan Cameron" <Jonathan.Cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Mike Rapoport <rppt@kernel.org>
CC:     <x86@kernel.org>, <linux-cxl@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Derick Marks <derick.w.marks@intel.com>
Subject: Re: [PATCH v2 1/2] x86/numa: Introduce numa_fill_memblks()
Message-ID: <6489b23bc67e0_142af829456@dwillia2-xfh.jf.intel.com.notmuch>
References: <cover.1686712819.git.alison.schofield@intel.com>
 <9fcc548a6b4727cb2538e5227d7bad2e94e6adaf.1686712819.git.alison.schofield@intel.com>
 <03945e1f-caf6-3e5c-babc-d30e4e02b65e@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <03945e1f-caf6-3e5c-babc-d30e4e02b65e@intel.com>
X-ClientProxiedBy: SJ0PR05CA0038.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::13) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MW5PR11MB5931:EE_
X-MS-Office365-Filtering-Correlation-Id: f30adaa9-3250-4ab3-513f-08db6cd2c047
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KlCKtUvEgchaPmxgn3l1pCNipN2pK+aTUrKwjwfiNeZ523UQteDPGjX9M7dIXzmsQvpbw0KjpGkBSCO+FkWBvy2TibXcjGsEw9/3tDgASA6a0rf4eUcLy145yRAGexDMmqcr9tKxsEgP76LksKtJYpyrpBktE4p05Oz59A9uV/DBXZ2xNbQy7+qeKOWt6KsmQ9HQimRfhSX3YsnIArEhWc5+PmBycIe6Eg2uIYHZ3kkvRGVmAhRh1w34hI4ua3ROrew0boK3tyMeaFs55A+mC3vPiUliZ0ypFyy0OWohWCMAlmbEm2kAwmYHqZ5Pm903vcRph9UPS2CAOXDQi/CWQMDWGidjmp4vl/DCDkwx+zduiAL0QfsO9OZVmJXqCflyg2qyGPOQmoXwVakVWAELvJBTZmQc2ysOQR9KYjUyPxTmikWNpZCLCHLI5630+30AibJxq7u2wOnG/K7USPjqzDhSzLXfaDXRxKjBYnCEFwNrU6FleP/OgcZURh+PmRKylCuDqBIbAhUG7qxdml7HjYhuzuMpXv0j8G+FoE5xUdTN5JayZ9+u3RzHM2IXhfG6v6jnv5OWMN2BtvpBYB4jx4H5L+uQJia5Rumr7GYCyWY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(376002)(366004)(39860400002)(396003)(451199021)(66946007)(66556008)(66476007)(4326008)(316002)(7416002)(478600001)(8676002)(5660300002)(8936002)(41300700001)(6666004)(2906002)(26005)(9686003)(6506007)(6512007)(186003)(53546011)(83380400001)(110136005)(66899021)(6486002)(38100700002)(86362001)(82960400001)(921005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?lxn/UoDpKcJ3n8mrF6Zut83e+f7AN83sLtN9yKCjza5UbmMmHv9PsxjW0D?=
 =?iso-8859-1?Q?0XtT80H55FV1elxXA7UYjdm1Pdyx3mCmxES+pYOU/mGngeKAvA1KuIMRs2?=
 =?iso-8859-1?Q?L4K8XDh21eglXQHwSnThkFfKsdbLOQdKz+fuUQ8c05aQFl9OBsxax/sEvK?=
 =?iso-8859-1?Q?Rab6SZJ1ORqgMUSq17hV2WB/T1ncyJQKRACHpcq/Fk9/4y6/nys/lCWaWZ?=
 =?iso-8859-1?Q?0qI5jD5aq6Xsk91WUEISo0IQrBWDC4dYC2Ps/XZCpl8MoWUZShyzw+79ae?=
 =?iso-8859-1?Q?By84ULV6avERn8AxxXB9WziyLjYxXYbHHgWYQeEb8BLXvAwkvDZCs915E5?=
 =?iso-8859-1?Q?pnmEXmrhL9wB5ljZ+1YPIPsPyaCpBg+2LS/cxieVVYakd60DQmBooy5McY?=
 =?iso-8859-1?Q?vgw+Iw8oHQe4tqXFUfdO3fxymbASSZMWIsjiVom1Xw54QB2mkpWnZKxTMG?=
 =?iso-8859-1?Q?njIFSoZnYQRAAwfrIwusc1ZbY2OOsKET8PHFp2PBqsWNToX1lgp2GG6Ast?=
 =?iso-8859-1?Q?8yvpdIqXA3yUdDAIQC599H49UdGmTBWk1yC9pCxEWBHRi8CSTon3lq/GTj?=
 =?iso-8859-1?Q?XjeGOURTTqxkr1lOJIYSPk37ZssoJzEA3vdGg70L9rq3n590v78+/i0Bvf?=
 =?iso-8859-1?Q?QcC4KARZjmSw4kt2ogBh41NvyKFmvhff0CTvowDmTKJ1J3YjBaA8Ob7Qjq?=
 =?iso-8859-1?Q?62gSoemqxOQvtoqUmzwSYJKYjK1KcpqTUZfcTsURi6n4D8ZdRkw5d0WEXU?=
 =?iso-8859-1?Q?vWqpXUp4lZehSObK9KQhMnlvwf5rBFYYki858NPQRsbjnmfXftu9yef+sd?=
 =?iso-8859-1?Q?eeYVhzZK0B1tatKS2f3Vq5+tvJRW4ojaXUaqIVGKDumu9oDg2UGzGAOxDk?=
 =?iso-8859-1?Q?6ncEU/rWDVJMS5xrWg+ovE/jl/3EsOPxwNWDfBTCbNaLKZfwmWvBgXb/wh?=
 =?iso-8859-1?Q?zugtzuPpJmVaBjkvalB5ypZLzl7lvjyOkxL/vA//wqbMj7jcmtvLej4YK5?=
 =?iso-8859-1?Q?96e5/YIBvjfPpf6U8KLc4LoKcQN7fSrhIb30wmheV0kTRuo8C7G/S0fjCQ?=
 =?iso-8859-1?Q?KTcDH4DjHs8edyctxmKKRrlQWN/s/GQdhsp0Luj4ZtjVY63qLGzu4W3Ccv?=
 =?iso-8859-1?Q?1oTucbjBUlMhgRpXfmYW5DtadrhKpb6uLq8Dgo/v2lmkh94JPfw1QvG08I?=
 =?iso-8859-1?Q?dDEYXYz7h7pQr6X+O0iORUIKemXsrqEKMRnrtyrtvGtdEtOxnCjGonWwnD?=
 =?iso-8859-1?Q?cF6ft4QFM2Cp4K7r29Q88BeohoxIipTefzDIOl0jaCb6UP52xjqmUIJHMf?=
 =?iso-8859-1?Q?/82Wfs3+f8sKQ2BDk2cUXFS6+WzsHO8GZfT/y/+c0RlRRZNzqlOMrkLrb9?=
 =?iso-8859-1?Q?uNwNJxXgxjl/QQuCBeZhAhyL2xXE6GfkKCO855aB8t7WJtgdhXAXY5a+y6?=
 =?iso-8859-1?Q?YdEhvz2c3lH1ax4MxBAwO/2Dgfqwnlfycmm32NUd1E2szaen3qDIAHEh6n?=
 =?iso-8859-1?Q?DA8BnagL0Z6dkYxFh/YL8u4p4S17xgxIuMTzOcuCn5L/82ZdxkcVm2XGgR?=
 =?iso-8859-1?Q?fojEcDzyijxhs5movEfIu57FcgKfN3euzKSWYetidsvoirr0QsSvGgi7Uz?=
 =?iso-8859-1?Q?jGI/9bHfNHEUmCUhsROvVAKfUyouosW4xkd5PKheTU+PucQ4zzR+L2rw?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f30adaa9-3250-4ab3-513f-08db6cd2c047
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2023 12:27:42.9756
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LWFT8aa6pfRTIXjesyOPE3iByaPOq8vTFPHwCQinQahc9k1RjATMFxxVvuzDhscBvnu0zIL0qSfda4mpMhwqaDucUyNZwZS4/2OWI4WKtH0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5931
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wilczynski, Michal wrote:
> 
> 
> On 6/14/2023 6:35 AM, alison.schofield@intel.com wrote:
> > From: Alison Schofield <alison.schofield@intel.com>
> >
> > numa_fill_memblks() fills in the gaps in numa_meminfo memblks
> > over an HPA address range.
> >
> > The ACPI driver will use numa_fill_memblks() to implement a new Linux
> > policy that prescribes extending proximity domains in a portion of a
> > CFMWS window to the entire window.
> >
> > Dan Williams offered this explanation of the policy:
> > A CFWMS is an ACPI data structure that indicates *potential* locations
> > where CXL memory can be placed. It is the playground where the CXL
> > driver has free reign to establish regions. That space can be populated
> > by BIOS created regions, or driver created regions, after hotplug or
> > other reconfiguration.
> >
> > When BIOS creates a region in a CXL Window it additionally describes
> > that subset of the Window range in the other typical ACPI tables SRAT,
> > SLIT, and HMAT. The rationale for BIOS not pre-describing the entire
> > CXL Window in SRAT, SLIT, and HMAT is that it can not predict the
> > future. I.e. there is nothing stopping higher or lower performance
> > devices being placed in the same Window. Compare that to ACPI memory
> > hotplug that just onlines additional capacity in the proximity domain
> > with little freedom for dynamic performance differentiation.
> >
> > That leaves the OS with a choice, should unpopulated window capacity
> > match the proximity domain of an existing region, or should it allocate
> > a new one? This patch takes the simple position of minimizing proximity
> > domain proliferation by reusing any proximity domain intersection for
> > the entire Window. If the Window has no intersections then allocate a
> > new proximity domain. Note that SRAT, SLIT and HMAT information can be
> > enumerated dynamically in a standard way from device provided data.
> > Think of CXL as the end of ACPI needing to describe memory attributes,
> > CXL offers a standard discovery model for performance attributes, but
> > Linux still needs to interoperate with the old regime.
> >
> > Reported-by: Derick Marks <derick.w.marks@intel.com>
> > Suggested-by: Dan Williams <dan.j.williams@intel.com>
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> > Tested-by: Derick Marks <derick.w.marks@intel.com>
> > ---
> >  arch/x86/include/asm/sparsemem.h |  2 +
> >  arch/x86/mm/numa.c               | 87 ++++++++++++++++++++++++++++++++
> >  include/linux/numa.h             |  7 +++
> >  3 files changed, 96 insertions(+)
> >
> > diff --git a/arch/x86/include/asm/sparsemem.h b/arch/x86/include/asm/sparsemem.h
> > index 64df897c0ee3..1be13b2dfe8b 100644
> > --- a/arch/x86/include/asm/sparsemem.h
> > +++ b/arch/x86/include/asm/sparsemem.h
> > @@ -37,6 +37,8 @@ extern int phys_to_target_node(phys_addr_t start);
> >  #define phys_to_target_node phys_to_target_node
> >  extern int memory_add_physaddr_to_nid(u64 start);
> >  #define memory_add_physaddr_to_nid memory_add_physaddr_to_nid
> > +extern int numa_fill_memblks(u64 start, u64 end);
> > +#define numa_fill_memblks numa_fill_memblks
> >  #endif
> >  #endif /* __ASSEMBLY__ */
> >  
> > diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
> > index 2aadb2019b4f..fa82141d1a04 100644
> > --- a/arch/x86/mm/numa.c
> > +++ b/arch/x86/mm/numa.c
> > @@ -11,6 +11,7 @@
> >  #include <linux/nodemask.h>
> >  #include <linux/sched.h>
> >  #include <linux/topology.h>
> > +#include <linux/sort.h>
> >  
> >  #include <asm/e820/api.h>
> >  #include <asm/proto.h>
> > @@ -961,4 +962,90 @@ int memory_add_physaddr_to_nid(u64 start)
> >  	return nid;
> >  }
> >  EXPORT_SYMBOL_GPL(memory_add_physaddr_to_nid);
> > +
> > +static int __init cmp_memblk(const void *a, const void *b)
> > +{
> > +	const struct numa_memblk *ma = *(const struct numa_memblk **)a;
> > +	const struct numa_memblk *mb = *(const struct numa_memblk **)b;
> 
> Is this casting necessary  ?

This is idiomatic for sort() comparison handlers.

> > +
> > +	if (ma->start != mb->start)
> > +		return (ma->start < mb->start) ? -1 : 1;
> > +
> > +	/* Caller handles duplicate start addresses */
> > +	return 0;
> > +}
> > +
> > +static struct numa_memblk *numa_memblk_list[NR_NODE_MEMBLKS] __initdata;
> > +
> > +/**
> > + * numa_fill_memblks - Fill gaps in numa_meminfo memblks
> > + * @start: address to begin fill
> > + * @end: address to end fill
> > + *
> > + * Find and extend numa_meminfo memblks to cover the @start-@end
> > + * HPA address range, such that the first memblk includes @start,
> > + * the last memblk includes @end, and any gaps in between are
> > + * filled.
> > + *
> > + * RETURNS:
> > + * 0		  : Success
> > + * NUMA_NO_MEMBLK : No memblk exists in @start-@end range
> > + */
> > +
> > +int __init numa_fill_memblks(u64 start, u64 end)
> > +{
> > +	struct numa_memblk **blk = &numa_memblk_list[0];
> > +	struct numa_meminfo *mi = &numa_meminfo;
> > +	int count = 0;
> > +	u64 prev_end;
> > +
> > +	/*
> > +	 * Create a list of pointers to numa_meminfo memblks that
> > +	 * overlap start, end. Exclude (start == bi->end) since
> > +	 * end addresses in both a CFMWS range and a memblk range
> > +	 * are exclusive.
> > +	 *
> > +	 * This list of pointers is used to make in-place changes
> > +	 * that fill out the numa_meminfo memblks.
> > +	 */
> > +	for (int i = 0; i < mi->nr_blks; i++) {
> > +		struct numa_memblk *bi = &mi->blk[i];
> > +
> > +		if (start < bi->end && end >= bi->start) {
> > +			blk[count] = &mi->blk[i];
> > +			count++;
> > +		}
> > +	}
> > +	if (!count)
> > +		return NUMA_NO_MEMBLK;
> > +
> > +	/* Sort the list of pointers in memblk->start order */
> > +	sort(&blk[0], count, sizeof(blk[0]), cmp_memblk, NULL);
> > +
> > +	/* Make sure the first/last memblks include start/end */
> > +	blk[0]->start = min(blk[0]->start, start);
> > +	blk[count - 1]->end = max(blk[count - 1]->end, end);
> > +
> > +	/*
> > +	 * Fill any gaps by tracking the previous memblks end address,
> > +	 * prev_end, and backfilling to it if needed. Avoid filling
> > +	 * overlapping memblks by making prev_end monotonically non-
> > +	 * decreasing.
> > +	 */
> > +	prev_end = blk[0]->end;
> > +	for (int i = 1; i < count; i++) {
> > +		struct numa_memblk *curr = blk[i];
> > +
> > +		if (prev_end >= curr->start) {
> > +			if (prev_end < curr->end)
> > +				prev_end = curr->end;
> > +		} else {
> > +			curr->start = prev_end;
> > +			prev_end = curr->end;
> > +		}
> > +	}
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(numa_fill_memblks);
> > +
> >  #endif
> > diff --git a/include/linux/numa.h b/include/linux/numa.h
> > index 59df211d051f..0f512c0aba54 100644
> > --- a/include/linux/numa.h
> > +++ b/include/linux/numa.h
> > @@ -12,6 +12,7 @@
> >  #define MAX_NUMNODES    (1 << NODES_SHIFT)
> >  
> >  #define	NUMA_NO_NODE	(-1)
> > +#define	NUMA_NO_MEMBLK	(-1)
> 
> Same error code as NUMA_NO_NODE ?
> 
> >  
> >  /* optionally keep NUMA memory info available post init */
> >  #ifdef CONFIG_NUMA_KEEP_MEMINFO
> > @@ -43,6 +44,12 @@ static inline int phys_to_target_node(u64 start)
> >  	return 0;
> >  }
> >  #endif
> > +#ifndef numa_fill_memblks
> 
> Why not just #ifndef CONFIG_NUMA_KEEP_MEMINFO ?

This is due to the fact that multiple archs use
CONFIG_NUMA_KEEP_MEMINFO (x86, ARM64, LOONGARCH), but only one supplies
a numa_fill_memblks() implementation (x86).
