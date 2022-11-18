Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 751E862FED9
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 21:30:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbiKRUap (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 15:30:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbiKRUai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 15:30:38 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE94863C7;
        Fri, 18 Nov 2022 12:30:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668803435; x=1700339435;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=2MOniT3KmmDf4AkjAlZ9ABEtQs1y+PpwAWSKB1KDvSg=;
  b=Gz+p/NjQVB/672yHKN23BvzwBuPOJzlcxw47DG9HyyHgxxvMNSxd9QM0
   nfglDO+2qhktJ5/Ha65CDNuIPjb73VG/uyuoHIIZa28m4M9AhyTs94N2Y
   Y9bxerYdmCg7ujrPiCprmWUrEzn/Z6h5GKtl+Kqvtr3T5/WM9orhdNvTQ
   MszCwq299CJQH68fBZlb6J6oPtdSwnrTvMFzr650sDHCWWT//X39kKPXH
   PusfgDujrNECzggclD+NJ51a1rjWVUAWI++4J6sYsLy19SdAcWcvJPW5d
   uUiyJNZEssUlP7hYyNK+QOduPeIxjT3F2pc619oYixjjZbvvFt0/i1fJW
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10535"; a="292935693"
X-IronPort-AV: E=Sophos;i="5.96,175,1665471600"; 
   d="scan'208";a="292935693"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2022 12:30:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10535"; a="671441190"
X-IronPort-AV: E=Sophos;i="5.96,175,1665471600"; 
   d="scan'208";a="671441190"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga008.jf.intel.com with ESMTP; 18 Nov 2022 12:30:34 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 18 Nov 2022 12:30:33 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 18 Nov 2022 12:30:33 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 18 Nov 2022 12:30:33 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.177)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 18 Nov 2022 12:30:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GnLRc/X81KwXuxOPHXcqjgSgSH68LmD3l3CvG+wA2s0grZLkDZthQq0J4PmPuhoWVLoWt5+0WyOq/+21/VM3su/wi8ZzuPijMGk6PFhjjtLz98BOm1oTfW2ezabWry64b4hYsPQOw3otDCUmDmjLkQ3FBDofvtXNEf8lwWCHCRWUbEhJqvUG/+hmseOp6eZtmr7wKKHal4zMTlEqYxWgSrwPFNlEPm+PYA4dq6OG5RTfawlpLtLCFCxyaamSgA2yvKI537bQ0XPXe1yMEmNlnurR8J080tats4bLWZMLIRxarBIpQv5sxXaGvbXskyuv2q5SXL8RtKJjJpHCtHLE/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DdIubOJkv90hMRjVnZYDa67oBPWhysC48ZWTzLzSO6w=;
 b=UIBnKcVrlp5SUn/6BI9xeOzbOjKMSYVkaE/fOxAvgfpcO20Lpy4EUjBfsJbvpRXoHNieXA1z+gCe/+WGEric6r1IjS4hdwk+4cVNubGzljn2g73WVj2GKSGwmLzmKP28K+7sUNPnhiZYxRnO/QL2dqN3py3mf9ndocmNqof3ZgubRN78Lu2VEkqmIqOdVgIQrKoTm6+qepqv5L+1+feuAA+yZTx0QVYJqcUOUEmx2rXx1HRzbYS1tKDnbJudX8tKbSFdYLXPQfiCW19fjmvZaEElJW9zIZamLrQBsDfWJJOtK5tUwBDSm2kM0LlQXwuvm6Tb8FOTyIKC2o566E+Big==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by MN0PR11MB6011.namprd11.prod.outlook.com
 (2603:10b6:208:372::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.18; Fri, 18 Nov
 2022 20:30:28 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::b058:673:c228:3e95]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::b058:673:c228:3e95%9]) with mapi id 15.20.5834.009; Fri, 18 Nov 2022
 20:30:28 +0000
Date:   Fri, 18 Nov 2022 12:30:26 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Robert Richter <rrichter@amd.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        "Jonathan Cameron" <Jonathan.Cameron@huawei.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>
Subject: Re: [PATCH v3 5/9] cxl/pci: Only register RCDs with device 0,
 function 0 as CXL memory device
Message-ID: <6377eb624380a_12cdff294a2@dwillia2-xfh.jf.intel.com.notmuch>
References: <20221109104059.766720-1-rrichter@amd.com>
 <20221109104059.766720-6-rrichter@amd.com>
 <63753900717c6_12cdff29439@dwillia2-xfh.jf.intel.com.notmuch>
 <Y3ZZqZ2kPS1yyOtd@rric.localdomain>
 <63766efb7ceac_12cdff294c3@dwillia2-xfh.jf.intel.com.notmuch>
 <Y3dB4quvaSzRzsT/@rric.localdomain>
 <6377b8f1be5e5_12cdff2941d@dwillia2-xfh.jf.intel.com.notmuch>
 <Y3fitR3+8SvErb9v@rric.localdomain>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y3fitR3+8SvErb9v@rric.localdomain>
X-ClientProxiedBy: BY5PR17CA0031.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::44) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|MN0PR11MB6011:EE_
X-MS-Office365-Filtering-Correlation-Id: f6e02695-a02a-459b-0820-08dac9a3bb3a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +/vUbm5xIsbuWkLsStIYQwvNb6vIyvvLjQjNBFSGOXqV/YIYdg3cVPBVVuZ0hti5J3Lqg+9B2/RU+MuXps447ATNIpTk5QzHGwusiep4p+ZHoKhuqqplrMyN7UNDoiazvOo5Afh6TUX61zGyWIB6GhMwj1XQHLMwT9VPphSeMxi1m2mB90Fjq+GB2UZnhLOzr3N8oxheKsVy7FAz7MFCRWw/onZLrbh8lN6phqDSs7St7Iu9BdnyvBZPIGSt+cLEAPsL3tnfsWaIyDZ9j776AmDFZIewOP8FA3C1sGbXZTmcdwTgYA0yqYLFDdUPlKGi3+B0LVptkUa6cbaxhRT/5lOuLQPniWBtLVYZq1CLEzUcvk6flXErbunkuUV9Vd/tSMIhFe8kge+mMmI/LynpfqscZqoLUBKATSgnFjTCxBMA5JWkDjz8Mnqg1oBfizLxFP0452GFJm8VTqb+Pss3H9/auRhwiyVZoqHuW+cf2lNBDyrEY6TZjo5tXrrYnxP4NuXx/DEG0VLi3AT1MhLexr6Pl5/WeiaWk8DXP6qX3Dh/+33zpC8sMk5LUgBUHAmOS/5OlmP+ilMiq29aYQKj0koE6KoFYPK7o8Fgk5fblez6QPft7fNEcPYup8YO3ZcML2i5zQLMazWSxSR54S0EPQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(346002)(376002)(136003)(396003)(366004)(451199015)(82960400001)(86362001)(38100700002)(9686003)(6512007)(107886003)(8676002)(186003)(6506007)(26005)(54906003)(316002)(478600001)(53546011)(110136005)(83380400001)(2906002)(66946007)(66476007)(4326008)(6486002)(66556008)(8936002)(41300700001)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tMK48YXG9ytGiVBKd7t09DK0TrGPNDaVu2WFo4tE/+NjAsUqkDIlVvhGZY2w?=
 =?us-ascii?Q?LK0xN2nkPWJtLrN5bYiSt17c9j/qsFJZKnDvd6JE1DqrgeXYwk6w6scy8mKD?=
 =?us-ascii?Q?cb4AEQhCwmJ9nj8HVwrVjV/NQOSCj8b0SMMF7ZXgH1JdbcMCRsp8RhAWwy26?=
 =?us-ascii?Q?zrr+ac0z1ZLW2M0Fg19tr6WiNDj7x81UbpBpUfv7E//Btp+5lcM3r7lvLMqh?=
 =?us-ascii?Q?YT8i5ntbVAoNZQClo+Y+lKT8hIqS+T2E/FHxgLLHd+3Wfdb+D6Y1JsdAzU4y?=
 =?us-ascii?Q?dhTLXumKHuxAeOb9D3t+HYNPK98BVowUJf0MxCKsGb6dnDaPQGXS/i4bWb46?=
 =?us-ascii?Q?W5+C/s2FvY0pMkUr8sHTT/4uaRVzjWyHbPoyU0bM5bi8qDSQh6CcrpZmBJaQ?=
 =?us-ascii?Q?ivl0/O+4DUaNFMRI3uLvPlfX3jI9rxb4KUKw8LrWWmyTOGBRIFIHgmlRrvdX?=
 =?us-ascii?Q?yO45+W2NxYuKo/YqY/UdSlOujWQdZhj25HYNlorgTvSUOvnrTULzPudZ8b/s?=
 =?us-ascii?Q?3QD/2yApxkM4eNBx7sxjYXON2bu7H+Jjbr2r/fOlvMc9MryXEoOGx8pvhOwE?=
 =?us-ascii?Q?5dhhj0M8xeWE1r2XVv55MDNBfomtRHDqr7BYDU7dj1I8lpoT1tSyvlX6gEIm?=
 =?us-ascii?Q?uO3SkBZ8BkacoZwQYg2LYeJAAxMPTlR6Z7f0isrEUBBveSvXYv11DwyummjD?=
 =?us-ascii?Q?d3m/O7vdOLHy3K9Y7kDQTQ+ayJBMr9G+6cxa0KuNYqDdsk9n3gjINIwL3H/q?=
 =?us-ascii?Q?FQtBR3Os1pl5+LKESYDVNX9xXpZwHVuJkPntlcjjUfagiwMnwTikefZui9TJ?=
 =?us-ascii?Q?wqhAgBqS6Xd2yRILHI5nIUfeftm0NzyjXI+W57p2FIMq+ZmbuKz4PW6rPjK6?=
 =?us-ascii?Q?UyS2/C/eBcLR6dhKOvK50symbjXY4Vp+3MpLnOct9aj9Ehu9cpGe5lm+WRUT?=
 =?us-ascii?Q?KWtEvvzaMl8M4rU4b11tMcTmxVzmTlFKPkBmLLor5ihc8AmJ6iBWpg324XsC?=
 =?us-ascii?Q?8iz6sYPnYE1YmRSqmZ0hsUpjRHR/OJa+YZ5jzY0I9dTY5qgwkrilP3E5BrMd?=
 =?us-ascii?Q?jpgPIHrTaLOLrK7hCJqigd+b1SxC4woe//nk+BU01CAbpYo8RKVa5fU8dHlp?=
 =?us-ascii?Q?/aFbNvm9HsWMT30tj6q68mF00vYuexoampTcSkEsCccnrul/zui6DPOoQ0/Q?=
 =?us-ascii?Q?nYCPazaFfo9iTvtcVDDG2dlUVsFSLueO6qc0Q/tXHenmJ2PqaXHStAyihP7Y?=
 =?us-ascii?Q?feka0wHb8rpYNf+1h7wKzt4Ez8SSudWFEEb7NS7O7+xEehDQKTu3tzHfElLn?=
 =?us-ascii?Q?p4jukknH6aEHcfeDjdSVrk2+TK+giWHsucuSJ5XROP2g+b0R50iolbVdJTle?=
 =?us-ascii?Q?8Zp9P8Z/vnZ4wQPhybajdS7fpyQVMl9ixpL7Mbh6Fv8BGZ+OZFRGb1NcAhsK?=
 =?us-ascii?Q?hP0/jtAh6L2sK120UgjU0H/iGgZdccsRt9giv8R6kFZcbuv3Rjv582+b1VWC?=
 =?us-ascii?Q?04bXIMm870Xf74mKGQW7JELG4/Qb+0nmuKivb08US8H5czD1Mxd7DerSAyRW?=
 =?us-ascii?Q?GSkWCSKfVkJEdWdEPyovU83yQwAENFDB0aMlk9NYBAyuJHigy1fy6HyjQiDV?=
 =?us-ascii?Q?tg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f6e02695-a02a-459b-0820-08dac9a3bb3a
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2022 20:30:28.6059
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3M7yD2KYddWj0QMPQdsZJo75sg3bAscxnROcqPkJrHEj4L9dJeKvvMHB3vO87tUD0UIN8bM3+m5PKxED9FlDK4Ymr4rkFHYOdWuC1GihhUo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6011
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Richter wrote:
> On 18.11.22 08:55:13, Dan Williams wrote:
> > Robert Richter wrote:
> > > On 17.11.22 09:27:23, Dan Williams wrote:
> > > > Robert Richter wrote:
> > > > > On 16.11.22 11:24:48, Dan Williams wrote:
> > > > > > Robert Richter wrote:
> > > > > > > The Device 0, Function 0 DVSEC controls the CXL functionality of the
> > > > > > > entire device. Add a check to prevent registration of any other PCI
> > > > > > > device on the bus as a CXL memory device.
> > > > > > 
> > > > > > Can you reference the specification wording that indicates that the OS
> > > > > > needs to actively avoid these situations, or otherwise point to the real
> > > > > > world scenario where this filtering is needed?
> > > > > 
> > > > > CXL 3.0
> > > > > 
> > > > > 8.1.3 PCIe DVSEC for CXL Device
> > > > > 
> > > > > """
> > > > > An RCD creates a new PCIe enumeration hierarchy. As such, it spawns a new Root Bus
> > > > > and can expose one or more PCIe device numbers and function numbers at this bus
> > > > > number. These are exposed as Root Complex Integrated Endpoints (RCiEP). The PCIe
> > > > > Configuration Space of Device 0, Function 0 shall include the CXL PCIe DVSEC as shown
> > > > > in Figure 8-1.
> > > > > """
> > > > > 
> > > > > """
> > > > > In either case, the capability, status, and control fields in Device 0, Function 0 DVSEC
> > > > > control the CXL functionality of the entire device.
> > > > > """
> > > > > 
> > > > > There are some other occurrences. I think this is even true for VH
> > > > > mode, as multiple CXL devices on the bus are exposed through multiple
> > > > > DSPs or Root Ports.
> > > > > 
> > > > > Anyway, I limited this to an RCD only, esp. because its counterpart
> > > > > would be missing and thus port mapping would fail otherwise. See
> > > > > restricted_host_enumerate_dport() of this series.
> > > > > 
> > > > > > 
> > > > > > > 
> > > > > > > Signed-off-by: Robert Richter <rrichter@amd.com>
> > > > > > > ---
> > > > > > >  drivers/cxl/pci.c | 25 +++++++++++++++++++++++--
> > > > > > >  1 file changed, 23 insertions(+), 2 deletions(-)
> > > > > > > 
> > > > > > > diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> > > > > > > index faeb5d9d7a7a..cc4f206f24b3 100644
> > > > > > > --- a/drivers/cxl/pci.c
> > > > > > > +++ b/drivers/cxl/pci.c
> > > > > > > @@ -428,11 +428,26 @@ static void devm_cxl_pci_create_doe(struct cxl_dev_state *cxlds)
> > > > > > >  	}
> > > > > > >  }
> > > > > > >  
> > > > > > > +static int check_restricted_device(struct pci_dev *pdev, u16 pcie_dvsec)
> > > > > > > +{
> > > > > > > +	if (pci_pcie_type(pdev) != PCI_EXP_TYPE_RC_END)
> > > > > > > +		return 0;		/* no RCD */
> > > > > > > +
> > > > > > > +	if (pdev->devfn == PCI_DEVFN(0, 0) && pcie_dvsec)
> > > > > > > +		return 0;		/* ok */
> > > > > > > +
> > > > > > > +	dev_warn(&pdev->dev, "Skipping RCD: devfn=0x%02x dvsec=%u\n",
> > > > > > 
> > > > > > s/0x%02x/%#02x/
> > > > > > 
> > > > > > > +		pdev->devfn, pcie_dvsec);
> > > > > 
> > > > > Ok.
> > > > > 
> > > > > > This looks like a dev_dbg() to me. Otherwise a warning will always fire
> > > > > > on a benign condition.
> > > > > 
> > > > > I have chosen dev_warn() here as this is a non-compliant unexpected
> > > > > behavior of the device. There are no (legal) cases this may happen. I
> > > > > suppose you are worried about spamming the console here, but that
> > > > > error should be reported somewhere and thus being visible.
> > > > 
> > > > There are so many spec illegal values and conditions that the driver
> > > > could checki, but does not. The reason I am poking here is why does the
> > > > driver need to be explicit about *this* illegal condition versus all the
> > > > other potential conditions? What is the practical end user impact if
> > > > Linux does not include this change? For example, if it is just one
> > > > vendor that made this mistake that can be an explicit quirk.
> > > > 
> > > > A dev_warn() is not necessary for simple quirks.
> > > 
> > > This is not simply a cross check, the driver prevents enablement of
> > > CXL mem devs other than PCI_DEVFN(0, 0). It shouldn't silently drop
> > > out then. It's a device malfunction which should appropriate reported
> > > and not only visible if dbg is enabled.
> > > 
> > > As written above, the check is necessary as the counterpart is missing
> > 
> > It is only necessary if this condition happens in practice, not a
> > theoretically. So I am asking, are you seeing this with an actual device
> > that someone will use in production? If so, that's what pci quirks are
> > for to keep those workarounds organized in a common location.
> 
> I can make it a dev_dbg() message. But I do not understand the ratio
> behind this. This is not a quirk nor a workaround or a fix for
> something. The likely paths are the conditions checked that return 0.
> Only if the unlikely case happens where a CXL mem dev is not a dev 0,
> func 0, a warning is shown to inform the user that this dev is not
> enabled. So yes, this might be theoretical similar to that a driver
> cannot allocate memory. But why not print this as a warning message
> then?
> 
> Anyway, let's make it a dev_dbg().

Sorry for the thrash, lets set aside the the dev_dbg() vs dev_warn()
issue. It is minor compared to *why* this patch needs to be applied. I
would expect all production devices to be spec compliant and not
advertise the CXL memory device class code on anything but function0.

So either, there is a real threat that someone will build such a mistake
and Linux needs to take this action to protect itself, or no one will
ever build such a device and this patch is not needed.

Basically I read the changelog and it answered the "What?" question, but
it did not answer the "Why?" question.
