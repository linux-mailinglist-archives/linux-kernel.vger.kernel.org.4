Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD75962E2FE
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 18:27:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239529AbiKQR1i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 12:27:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234725AbiKQR1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 12:27:36 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A08E4C252;
        Thu, 17 Nov 2022 09:27:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668706054; x=1700242054;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=m09pYM0vIwKCde/uOMoBhe0JSc5RHrEZy/WEROXwzwU=;
  b=TEtDr8QojpLdhYaZFm26p33BsstqN32VnzsbIkquRh4dmhFYU6aImmuG
   OskrA6wUnxiTu+wzxxcq8vWyAhRoElqCshNDQzGU5rNpjJQX43D2MNh41
   ziDEVBedSYqJ/KX5n/U8zLxROoHGGnRQTgZhEGnDocPndfBCHuUCCBm35
   Sb4hgtIKKe+mDRSPgtAQp91xbO2ubXkkLbCCsmaCdSa8rudKjxsxO+RLC
   orxxH37SX3GLeGjZMWRj3N/hptOJ31MY6gF92PTs/hRTC+HN714KtETwh
   bHsWA77w+9inQv+GLfpDT6H6bcRoLwIp4w2j58ef9/3LJhDCwZcr+b6Sw
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="314067738"
X-IronPort-AV: E=Sophos;i="5.96,172,1665471600"; 
   d="scan'208";a="314067738"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 09:27:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="634132840"
X-IronPort-AV: E=Sophos;i="5.96,172,1665471600"; 
   d="scan'208";a="634132840"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga007.jf.intel.com with ESMTP; 17 Nov 2022 09:27:33 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 17 Nov 2022 09:27:32 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 17 Nov 2022 09:27:32 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 17 Nov 2022 09:27:32 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 17 Nov 2022 09:27:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RGwYouq/p4Q3hjyHEtwd2GR4CjxI2PMJX6M6z34HUwBI4IKAmgn2/vm2yqvdRfzQJNlV8GRC9oSd36d8yESssRrFAxICJKpj49noJBIQkT26HWq1Ekqy3Qr5MWmMciHxzKSMF3/O8E7mmNd4GPgRNtWM3OGaf36k/nkjGMXqMHVy49WCz8/LwOGt3WHydvXoWS7M3x1cTrlnB9NwmP/EqnboZ+qWPU74CHGhQKJc00E9wUJpMNpz+7wqmOC1DtZMsvYuRsGhd6d84LKXUrB5IfvQe9bxdA+GeE8CEMnmqehsP8DP27nkJNHmYUvZKTDbU8RK0EXGwmcNd5v5esIjGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tv8Dj/hWac/bdvqLkR2JP05tv7XVBJgKt0KjRE7VbVY=;
 b=QT5bExP5mgGOkV6QZ5Yerytg/Rtfdgn5WFLeqz76SVnk1mLuGrNrnBYAOFz1LesXI15NdbV7MiL12t7IfvPmk1s/bp8rjG+Q+25M+5Kxtz//U9aipURE8JKa2j/rNmnAs6NkdH6AS6BSH9E+or0G26Ju1MRi5iVWi1ibHXZ0GAma/ZdnNZN4mcQV0c/onqgMdQsjOK4Rzfmq41AG3BQ5Tc037mXRFBAIU14n7JitCUHH5BLHPPWyieIwjwE7h7av9rQO5zxyHQFY2az4d76lfor5d0QO3xA9yq8ixjcNmY+CLtz7jIv9uFggjBmol1nCWqrhGRmq94ygFkW7iNqpzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by BL3PR11MB6459.namprd11.prod.outlook.com
 (2603:10b6:208:3be::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.20; Thu, 17 Nov
 2022 17:27:26 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::b058:673:c228:3e95]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::b058:673:c228:3e95%9]) with mapi id 15.20.5813.019; Thu, 17 Nov 2022
 17:27:26 +0000
Date:   Thu, 17 Nov 2022 09:27:23 -0800
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
Message-ID: <63766efb7ceac_12cdff294c3@dwillia2-xfh.jf.intel.com.notmuch>
References: <20221109104059.766720-1-rrichter@amd.com>
 <20221109104059.766720-6-rrichter@amd.com>
 <63753900717c6_12cdff29439@dwillia2-xfh.jf.intel.com.notmuch>
 <Y3ZZqZ2kPS1yyOtd@rric.localdomain>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y3ZZqZ2kPS1yyOtd@rric.localdomain>
X-ClientProxiedBy: SJ0PR05CA0100.namprd05.prod.outlook.com
 (2603:10b6:a03:334::15) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|BL3PR11MB6459:EE_
X-MS-Office365-Filtering-Correlation-Id: 6add3759-2a59-46f5-53db-08dac8c0feea
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: khAUh/Anaevs0fwwEjseRJLHeLVSqexD7ZPUt2FrOqxEXlzLSkpUZFb4Z0UBehndiiGgpBl4ghCCFy9b6Ijx2tloNxbGqFfU6yJx0SRYDJwKRoVY4dVzEMY9211MjxOisc+Vh8Fhn90o24a/wIp4mimXp9rHK3NFmOokoynXCdrU41TLxtDfBnqez8VvRWQhQYWN/AIjc8+IY0Tva2xPd66P31ypdAO7JLoS7EvfQS2VXXhw0p9J7VpSz7mLVI+FAGJ6DkUUAX1isuY6+iBnBZDu2O6Off9LfZQyM3KO6jEL4siJLpLODrMuer1/qdQ1awNaMvM+eaz8iJ3a2B803PGai7LMIe9wH+bN8M9g0u/cXE7uYBDY2+lzV4JxsDoN7qGgJpAmpxdvW4lWwjpv01433UrpSvTS7xrjcLTod87OMPW7NhhbNO+br2989u14ROKgjoxUsfxQWHP/dZSoobFsx7MzViqXPO1Lp9VscAgI5Sldg/kgn1CAH7gaMOr4sP7sAzjZ0Iu09VDoMSmq82g9F3hDx3lr7sebtBeQz1NqVmI8MdJmdqVqzrIXvAdPYmp9Jxxo0K58C8l1qshGdwnm5luaSlP9jrPa936pKKELAcpE882t8C9KOC9xsUE3zh/KVqT9DQPsR9BgKWmcxg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(136003)(346002)(396003)(366004)(39860400002)(451199015)(186003)(5660300002)(110136005)(316002)(6506007)(54906003)(53546011)(41300700001)(9686003)(6512007)(26005)(8936002)(8676002)(66476007)(66946007)(66556008)(4326008)(38100700002)(82960400001)(2906002)(83380400001)(86362001)(478600001)(6666004)(107886003)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RQw4dn3ythFcWMzEZBFIrRWhLUVK9cYlRlUBDFOqH4ehboX9RACxl7tqiWtv?=
 =?us-ascii?Q?wZeCEdIsJO0QdMZns7mMsx/UBLxoLDuooHYXEwVClj+bOVrZofg6n8GgelmV?=
 =?us-ascii?Q?8XgmwdsIQ6HS3Yjr4Sk6lVspOLABjjKk4wRebMkU5bdicYkyeHf3PnZcMqnD?=
 =?us-ascii?Q?3mhuUDLa35Vtk9eQFn+bSwltsFth9Rtn3EsXX9M5STtmovgrr5DR3jO6K+9S?=
 =?us-ascii?Q?kTpk7dQ5Oo7Hy7oTKK1eEozmZjrUWJvHPz4uOh4+oBsDLtSjOlVRJ4j1+vyH?=
 =?us-ascii?Q?izvWvyyWVISpBk8r7QxCuQLQIyl0mEPpKvaD4C+IheOarB9R4Up9MSAKFU9s?=
 =?us-ascii?Q?KzJMMXBx1IzjoJkrQLm7dXqUicWjBH3DCCcnQ992R+tFpdjVlxJJ+e2MmWIe?=
 =?us-ascii?Q?U4sx6frUxj7mvENNrZEgEYkXaKn5+eRbqkK6pWv3oYRMg1mDv+ij55ARyabE?=
 =?us-ascii?Q?AumzmRpCsS0zBpKjmC2VRat9M0+Ta0Wy0qtAJjQ3zko9pkpaw/10wMcNX0yy?=
 =?us-ascii?Q?S15NkCdyZoZwdSASnJB5SjW5TrKNmJ5fe7D5sAMJo7dWD9Gai5yfliSjAL2H?=
 =?us-ascii?Q?BXr9j6hPGzswCzy4DmNUaXCdiUe6oju7qcepxnSjsOsAob9i5nDc03nI2X+/?=
 =?us-ascii?Q?WYMKsbuOsYMwC3lBgcnlhNUmkNXc3E2hCc7eAoY4gL1aYduWoZOzB0vkxpXD?=
 =?us-ascii?Q?OXsU8QzmEmCJ4GDr90JMNZfqzjdPdfVRjBOqtOVzcE91kpvc6p6GSpsqyQBS?=
 =?us-ascii?Q?Tsx9acRWuKcGQdoP7xvGfkvxr+jFv0xJZ0KnZk/OXXHVSly6+Zb8aTl8yWNo?=
 =?us-ascii?Q?ckxUM7NVep0k5OfkBYitjOP1eHv1+sTMFxMjl5d1+qOQ9ClwKqwVSX468WZu?=
 =?us-ascii?Q?smEdYFbYP/ww8MCi/kQovckl1zDP85oOA9U29zzUB2Ub9RF+7V94AT9n8F8c?=
 =?us-ascii?Q?YkbEjHjeSYVriQuk5NyRBA9kduEzaWEuJ7GY080J3W4DQS3X90gi7PMVoe79?=
 =?us-ascii?Q?CA9QskwTeWfnG0ZQg0E/6+UZGLHnGlL3o0XNSL35h9qYMXFM6uKInLC7hWGf?=
 =?us-ascii?Q?6T5kGtX7cICjGG1jO8UJ9tgKraX4feuE/NO2mhH3kQjLMPCen/EDjfElfeYa?=
 =?us-ascii?Q?yEu8yjOOYsYffnGPD+dUUUzQkhZPfsB53fcHRR2VlcbFDKE1qJJ6r4LYHYWU?=
 =?us-ascii?Q?oVB4hFMcyZ7I9yTk25GtqmsBuZ+7jXkFBVFcsdZk+dGfVhon/EozzeJ39tan?=
 =?us-ascii?Q?6oUolqrtQg/3E7LJWFGpYvwkT71TS3hGLySXGfnWDX9qVFZf7Jayc/Yb33Om?=
 =?us-ascii?Q?mul1UWdKpy14PU37bpRnD03/SnHyu7piFe/JBJoSI4fXAnJnhjn1dgvA7haA?=
 =?us-ascii?Q?Dtm45qai5IeQ29pCKGL7Bh8Ghducsuob3ET1qHMHbh5l0eCHmNFQElBLWlhd?=
 =?us-ascii?Q?K2Pzx9A3EI9CaDKP8Kj2+RO7HQNTIzde3ThOoS2qv+duiQv/HU2vj4f7ReWz?=
 =?us-ascii?Q?4t+RVsHkJchTCpFqqx9JV+J7Ukm+kTsITy6sTqYONqPTmOHVScp23tVIOUmR?=
 =?us-ascii?Q?PPftN06HKa3fvl4VGlcM7c/RS3ebx/p4NBzXmcuvsri6Nde2Wg0LMx4e/o/B?=
 =?us-ascii?Q?Mg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6add3759-2a59-46f5-53db-08dac8c0feea
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2022 17:27:26.4735
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sw5vAWMTiqXxCRa2MiBZCG4Bdf0IvvNfEI1CIHXmjq6DPKZtgIAgJuwX2yL1rW1MY9SxF92IJNVOKMJlZr59s5c0C8KJNwH0m44TkVVl9fI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6459
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Richter wrote:
> On 16.11.22 11:24:48, Dan Williams wrote:
> > Robert Richter wrote:
> > > The Device 0, Function 0 DVSEC controls the CXL functionality of the
> > > entire device. Add a check to prevent registration of any other PCI
> > > device on the bus as a CXL memory device.
> > 
> > Can you reference the specification wording that indicates that the OS
> > needs to actively avoid these situations, or otherwise point to the real
> > world scenario where this filtering is needed?
> 
> CXL 3.0
> 
> 8.1.3 PCIe DVSEC for CXL Device
> 
> """
> An RCD creates a new PCIe enumeration hierarchy. As such, it spawns a new Root Bus
> and can expose one or more PCIe device numbers and function numbers at this bus
> number. These are exposed as Root Complex Integrated Endpoints (RCiEP). The PCIe
> Configuration Space of Device 0, Function 0 shall include the CXL PCIe DVSEC as shown
> in Figure 8-1.
> """
> 
> """
> In either case, the capability, status, and control fields in Device 0, Function 0 DVSEC
> control the CXL functionality of the entire device.
> """
> 
> There are some other occurrences. I think this is even true for VH
> mode, as multiple CXL devices on the bus are exposed through multiple
> DSPs or Root Ports.
> 
> Anyway, I limited this to an RCD only, esp. because its counterpart
> would be missing and thus port mapping would fail otherwise. See
> restricted_host_enumerate_dport() of this series.
> 
> > 
> > > 
> > > Signed-off-by: Robert Richter <rrichter@amd.com>
> > > ---
> > >  drivers/cxl/pci.c | 25 +++++++++++++++++++++++--
> > >  1 file changed, 23 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> > > index faeb5d9d7a7a..cc4f206f24b3 100644
> > > --- a/drivers/cxl/pci.c
> > > +++ b/drivers/cxl/pci.c
> > > @@ -428,11 +428,26 @@ static void devm_cxl_pci_create_doe(struct cxl_dev_state *cxlds)
> > >  	}
> > >  }
> > >  
> > > +static int check_restricted_device(struct pci_dev *pdev, u16 pcie_dvsec)
> > > +{
> > > +	if (pci_pcie_type(pdev) != PCI_EXP_TYPE_RC_END)
> > > +		return 0;		/* no RCD */
> > > +
> > > +	if (pdev->devfn == PCI_DEVFN(0, 0) && pcie_dvsec)
> > > +		return 0;		/* ok */
> > > +
> > > +	dev_warn(&pdev->dev, "Skipping RCD: devfn=0x%02x dvsec=%u\n",
> > 
> > s/0x%02x/%#02x/
> > 
> > > +		pdev->devfn, pcie_dvsec);
> 
> Ok.
> 
> > This looks like a dev_dbg() to me. Otherwise a warning will always fire
> > on a benign condition.
> 
> I have chosen dev_warn() here as this is a non-compliant unexpected
> behavior of the device. There are no (legal) cases this may happen. I
> suppose you are worried about spamming the console here, but that
> error should be reported somewhere and thus being visible.

There are so many spec illegal values and conditions that the driver
could checki, but does not. The reason I am poking here is why does the
driver need to be explicit about *this* illegal condition versus all the
other potential conditions? What is the practical end user impact if
Linux does not include this change? For example, if it is just one
vendor that made this mistake that can be an explicit quirk.

A dev_warn() is not necessary for simple quirks.
