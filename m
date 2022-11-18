Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5527D62FAE4
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 17:55:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241560AbiKRQzf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 11:55:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242417AbiKRQz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 11:55:27 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F1127C02E;
        Fri, 18 Nov 2022 08:55:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668790521; x=1700326521;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=QZkc7d2JG1BkMYXs8O0XsKIoddHIvgliMezR9LxeOow=;
  b=lWesH2GGmpXKqG6uUq1Qj2dBhJxv7T4xSgZlbtOQo1gTR8nOfBVJ8ZFN
   0FFv/+wXReHyWJpSlXw6CoFDov3t8wu6ejB18ITE9+lOpAZPzGTrn4iTg
   arPKlM3uYh0DfTjfXBF+S0ttwOLFCNoKaR86lG8GoAuX+kjVuwffjfq7m
   FixgW/UwTHE4cShXo7ndYr/emcsE6DBYyPO/If9FxiFHKaXeW4NQ0czVr
   RJszo0HHHYoEaG1+HVkaaQ+9lZl8O9BLC4FfQXQds+dc3ekACPk1UEeaF
   VNb5pDHUxDhUutBfDwP2Ra/7Hh4wXRFWRqEAe0vNjTQIyOsQU7ioa1k5r
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10535"; a="313191650"
X-IronPort-AV: E=Sophos;i="5.96,174,1665471600"; 
   d="scan'208";a="313191650"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2022 08:55:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10535"; a="782707795"
X-IronPort-AV: E=Sophos;i="5.96,174,1665471600"; 
   d="scan'208";a="782707795"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga001.fm.intel.com with ESMTP; 18 Nov 2022 08:55:20 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 18 Nov 2022 08:55:20 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 18 Nov 2022 08:55:20 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 18 Nov 2022 08:55:20 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.46) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 18 Nov 2022 08:55:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F8xLpXLPPv+s9BXaFWhj8rsrglaDgma+6eYLZl/wdR4J4IigUWqzdcsCBOHC+4Ej845m5wW+wqiR9GtYMTAAW+arQvwtTWJLR2GM972g5u0P2mIhoA8tNOjU4DIy3p8nThmSYiTc6kqCBy/IimAZBqL4km1ityiEUdIKeWH8fABxcme1nhRKd+CipUZmAEv3JKT7LTSIb96LJlMQ8vnn3GQuPFzmK+lpYcbtwgdItw34agHShBvIaAf4CDlnn9p8ivQczruPSwXxXd8Gkd3GbWZ4SSQ1XMrmQ52wog9h7+FM8rYZNcnj1ddO0UHDUU0AsF2QEe7exqrAKLv17bLeZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y8vXnHoBTUvN+uDvfVpXxYuRwbhvuobfGpuKupPB1h4=;
 b=ZnaQW9sJjDmPTOpBv52M9puc40OcFUlhfYfvZn/Td/I93oAeILK6CgCc8S/XvRFkCTAWXd5W8xKQYolog3W9MCT4GTZJDyISEcRRFqy63J5mbQI6L+Zfb7uMwT+xnuXuwwISPvf90PGTAY19itB/USJ2Dc3X4CPwN3H5moUDgr/U6PVCgZ41Q6rgWDFh4vUCooGeIVhg5b2AJb6eaSIj5IWAXBPyinNvp/ZqYdSxq9z4LI5lcXVxDsNKN1OMQYTHN5UFj+AlGZylsI12TMUJr66ktfykODF0S2oQxzK3N2yMhFi9B/2wEQtVYg/cdDP4k5I61XKAllNn8c/Fn/7b4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by MW4PR11MB6570.namprd11.prod.outlook.com
 (2603:10b6:303:1e3::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.9; Fri, 18 Nov
 2022 16:55:17 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::b058:673:c228:3e95]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::b058:673:c228:3e95%9]) with mapi id 15.20.5834.009; Fri, 18 Nov 2022
 16:55:17 +0000
Date:   Fri, 18 Nov 2022 08:55:13 -0800
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
Message-ID: <6377b8f1be5e5_12cdff2941d@dwillia2-xfh.jf.intel.com.notmuch>
References: <20221109104059.766720-1-rrichter@amd.com>
 <20221109104059.766720-6-rrichter@amd.com>
 <63753900717c6_12cdff29439@dwillia2-xfh.jf.intel.com.notmuch>
 <Y3ZZqZ2kPS1yyOtd@rric.localdomain>
 <63766efb7ceac_12cdff294c3@dwillia2-xfh.jf.intel.com.notmuch>
 <Y3dB4quvaSzRzsT/@rric.localdomain>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y3dB4quvaSzRzsT/@rric.localdomain>
X-ClientProxiedBy: BY3PR04CA0025.namprd04.prod.outlook.com
 (2603:10b6:a03:217::30) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|MW4PR11MB6570:EE_
X-MS-Office365-Filtering-Correlation-Id: dc3acf1e-34fd-4755-6646-08dac985ab1d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zv3+TgEYDgCsZeQUOnQOf12gLDCW1+dGg0YXy3cCMUvdpF+t4kxNHpWBlu+Q+PIEQxFUc+67G1KWO79UaHpPtB3KpGm1y2zdPXNjYnzpgdcRYhZM2+HRUY7+JlU5RD4zMhBsAZe6+mDflxXkuD5+gQziINOZbtElIttejxnB4Y0xNSJ9RxCUJ6AFF8eUHyDvXvhOethXahnAQr8INT38UuXY9Do9IZHWAyfg5wcS7PCpLeYTuFwtnUwK1yBRb/hriXeqtlYBQ0fUHwiAK9NmAXATRHVMsrE0AwPA2WNg0ymhkeTswhVM4mv3iPiamV2aHLSqx6EPkNGwHZ9dGN9JvAX15zV+Bybon5auS7QyGi2Tw1byUh+4cIfW7dhHTOqaMOxX122qBFIocP1eEYoUPRo86Qt6yjdtZVQK5HgRuU5bsexNi2iRZaCSdFphdmE7kt1gSWR5G5w6WwX942oBTgIxxvWg2+fKhBpst3M+rrMtog57AMrb/uwFLJb8Leu7mHaKziCpd5bx58s7DhNBj+nh9disCFuX/U97cF/dG6dRL3lENK9Jbp8LukfbtMUxtzsBo2bTMivb+yIjSEMVB+FsKToKxqKN6C6k07g9vYiCpIhdrdoR9fFhWkle1xtUOMpbOQGbTy9g8MtEtM0GbA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(136003)(376002)(366004)(39860400002)(396003)(451199015)(86362001)(2906002)(8936002)(5660300002)(38100700002)(83380400001)(186003)(107886003)(82960400001)(110136005)(54906003)(316002)(478600001)(66476007)(66946007)(8676002)(4326008)(41300700001)(66556008)(6506007)(9686003)(6512007)(6666004)(6486002)(26005)(53546011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JGzHzETHG8qqfV1DDAF+6sJftypz1mT0YX3wzKvQLd/uaYwSDT++5cOZ6jOx?=
 =?us-ascii?Q?BnYsyo9/7CdEJLvX0R7kJ6n+6zIo0zAksxmZ6QCHpYrd5kDSelrKhwS9GDcU?=
 =?us-ascii?Q?gBY1Xpv2qd6pmSolo4sc6pGJ7+3jtD87kbkIJESEtCWW70/Ii8vhF2KebTYP?=
 =?us-ascii?Q?E+6WXS4AiLwsmHyiHVoLlF6hBS+0vMr331KSnWuPuOEWOpzNUvIadsowSTm2?=
 =?us-ascii?Q?n1Gf7PofeN0X6CUqqB8u4CcZqiOZ/5YayJ/V1yBkqyfmAVGZEQBGdhK2tLD8?=
 =?us-ascii?Q?83M0qtKrj9r6awCcpsMA8VI4oOr1zG2CUDhoYWle97JIQTR4Br1j1E/wtiNK?=
 =?us-ascii?Q?53TWrHioNr/ZaPF/JiqKV3tUM+2c7N2hCbG8Sx/GamOGJsTvACDs9oaKU5Tl?=
 =?us-ascii?Q?uLxAiYCdyC9o9gwgt44Ujld7QR+eg8/BDvuaTH4SszBO7tQqZiIBKnKVy7k7?=
 =?us-ascii?Q?x7Cb4NcxB2qmRBz7KA1QnKy+9uI3LSleeJtVj8V79w+S/+xTBKmxQBUKYK2U?=
 =?us-ascii?Q?JrHyvJMn12K4isiYOYm9c1mWJAi0mas+ZqMKcPpGGBHxqAKSLhHI7iOiRJ6p?=
 =?us-ascii?Q?qNuMPODfzPfoORnpSdLtkhQI4iaz1S0kVMD/TQ11KQy6KQTOPwhUaplHTVd6?=
 =?us-ascii?Q?lOtjGICtPLJMqLLpAdOSBThdi4++ck97t+0wgQcPTBD9OGyR/Z3IyMmJL8Rj?=
 =?us-ascii?Q?rtoH5Auu24+/tOXbWtkXlr7qWz54LNE0IlTE5tQP1I86sm6qymLDL4Hl6Zuy?=
 =?us-ascii?Q?lgSQd2ucWVhCGLdgIYlC6w14UzVeYyeoyrlbKiuUL00uo+qMCFR+QY9PDFT0?=
 =?us-ascii?Q?waGTBGowO3mQlP7MtwxR49Oj1qkfgVxxkyllqxcns8bZYfQhVgsae11zfxcx?=
 =?us-ascii?Q?ZgrWIBCHNcQXYFxhKOLUR58J2G8BztoTN6qCRKPVMZwzhtEYMZvWsxMOvEhn?=
 =?us-ascii?Q?/LuF1rOgOKuEQDd7MuLUR7vNubvwsn94eKIC1uSuKNbiKe7k/wm7N0VSeCFG?=
 =?us-ascii?Q?xxk6u4D81dtnfwEz2NgMAoTYTTXpgnPSz3pDPmvmP59+HQPxfYGEfwUGAm0s?=
 =?us-ascii?Q?GVIbBF5xbbZzUEXV6qQ2FaTdsnUTLXt+J2YcJINvbknomj9L/Lmx93AaHSuO?=
 =?us-ascii?Q?69+6qq4tkoDilV7ortiEC0f1y0GcpH6PKavTPCt8+sBp4EqVEtaGCl30n24e?=
 =?us-ascii?Q?zCCUnlKjtlX3GsB5I0gi5oqNVXQTfW7H40lwzIucGEavbMZuvtqLaELBE8Hi?=
 =?us-ascii?Q?RHp+A8rpwDihvDHrOzot4MK+oPsGdgERg4jycETHeyeYE/cootOZ19ygzVGZ?=
 =?us-ascii?Q?viLWCJdn9xhiKB/X7T6VAmjr0zqbHPeTplS7NHlbxHt5UFgStzRrLi5CN8Ar?=
 =?us-ascii?Q?uIFcMPX4ALGdDtGJR00rhXx0oklR0+zSOFtWCSZcve5y3eUiQNPwzMY9nrZC?=
 =?us-ascii?Q?JBrbR3Mwa6dxFcvnrq32WXFjngsebESblFsTvvB0mDGylJeyxc/0X9n2vx5W?=
 =?us-ascii?Q?efJ4M75x5D5PLGUlD24sFDKBKM/IgFMpjcGULk+Wd7kyL+3V7LVjSpxR+laz?=
 =?us-ascii?Q?KPrY8kSQaDrxPJqoOgmqq6bq4htbmfPMcKdFZrb27t2iUsiJu75nmgmpw0UH?=
 =?us-ascii?Q?PA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dc3acf1e-34fd-4755-6646-08dac985ab1d
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2022 16:55:16.8760
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /aweTTgG0YII3NRZHhokatVWqTbQyO7pECquWs1r7dNWtovJNjTifGsGf98SJ6xr7Iw5tLhF6F2Ry7YpEx5D+oiC4ErH5JVO3WpyMOIcj+A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6570
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Richter wrote:
> On 17.11.22 09:27:23, Dan Williams wrote:
> > Robert Richter wrote:
> > > On 16.11.22 11:24:48, Dan Williams wrote:
> > > > Robert Richter wrote:
> > > > > The Device 0, Function 0 DVSEC controls the CXL functionality of the
> > > > > entire device. Add a check to prevent registration of any other PCI
> > > > > device on the bus as a CXL memory device.
> > > > 
> > > > Can you reference the specification wording that indicates that the OS
> > > > needs to actively avoid these situations, or otherwise point to the real
> > > > world scenario where this filtering is needed?
> > > 
> > > CXL 3.0
> > > 
> > > 8.1.3 PCIe DVSEC for CXL Device
> > > 
> > > """
> > > An RCD creates a new PCIe enumeration hierarchy. As such, it spawns a new Root Bus
> > > and can expose one or more PCIe device numbers and function numbers at this bus
> > > number. These are exposed as Root Complex Integrated Endpoints (RCiEP). The PCIe
> > > Configuration Space of Device 0, Function 0 shall include the CXL PCIe DVSEC as shown
> > > in Figure 8-1.
> > > """
> > > 
> > > """
> > > In either case, the capability, status, and control fields in Device 0, Function 0 DVSEC
> > > control the CXL functionality of the entire device.
> > > """
> > > 
> > > There are some other occurrences. I think this is even true for VH
> > > mode, as multiple CXL devices on the bus are exposed through multiple
> > > DSPs or Root Ports.
> > > 
> > > Anyway, I limited this to an RCD only, esp. because its counterpart
> > > would be missing and thus port mapping would fail otherwise. See
> > > restricted_host_enumerate_dport() of this series.
> > > 
> > > > 
> > > > > 
> > > > > Signed-off-by: Robert Richter <rrichter@amd.com>
> > > > > ---
> > > > >  drivers/cxl/pci.c | 25 +++++++++++++++++++++++--
> > > > >  1 file changed, 23 insertions(+), 2 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> > > > > index faeb5d9d7a7a..cc4f206f24b3 100644
> > > > > --- a/drivers/cxl/pci.c
> > > > > +++ b/drivers/cxl/pci.c
> > > > > @@ -428,11 +428,26 @@ static void devm_cxl_pci_create_doe(struct cxl_dev_state *cxlds)
> > > > >  	}
> > > > >  }
> > > > >  
> > > > > +static int check_restricted_device(struct pci_dev *pdev, u16 pcie_dvsec)
> > > > > +{
> > > > > +	if (pci_pcie_type(pdev) != PCI_EXP_TYPE_RC_END)
> > > > > +		return 0;		/* no RCD */
> > > > > +
> > > > > +	if (pdev->devfn == PCI_DEVFN(0, 0) && pcie_dvsec)
> > > > > +		return 0;		/* ok */
> > > > > +
> > > > > +	dev_warn(&pdev->dev, "Skipping RCD: devfn=0x%02x dvsec=%u\n",
> > > > 
> > > > s/0x%02x/%#02x/
> > > > 
> > > > > +		pdev->devfn, pcie_dvsec);
> > > 
> > > Ok.
> > > 
> > > > This looks like a dev_dbg() to me. Otherwise a warning will always fire
> > > > on a benign condition.
> > > 
> > > I have chosen dev_warn() here as this is a non-compliant unexpected
> > > behavior of the device. There are no (legal) cases this may happen. I
> > > suppose you are worried about spamming the console here, but that
> > > error should be reported somewhere and thus being visible.
> > 
> > There are so many spec illegal values and conditions that the driver
> > could checki, but does not. The reason I am poking here is why does the
> > driver need to be explicit about *this* illegal condition versus all the
> > other potential conditions? What is the practical end user impact if
> > Linux does not include this change? For example, if it is just one
> > vendor that made this mistake that can be an explicit quirk.
> > 
> > A dev_warn() is not necessary for simple quirks.
> 
> This is not simply a cross check, the driver prevents enablement of
> CXL mem devs other than PCI_DEVFN(0, 0). It shouldn't silently drop
> out then. It's a device malfunction which should appropriate reported
> and not only visible if dbg is enabled.
> 
> As written above, the check is necessary as the counterpart is missing

It is only necessary if this condition happens in practice, not a
theoretically. So I am asking, are you seeing this with an actual device
that someone will use in production? If so, that's what pci quirks are
for to keep those workarounds organized in a common location.
