Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19FB367EE00
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 20:17:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232147AbjA0TRN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 14:17:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232132AbjA0TRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 14:17:11 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79BDB7BE5A;
        Fri, 27 Jan 2023 11:17:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674847029; x=1706383029;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=9YUO/twDytjEVRv6hm5dusdJMxrf2XeEBR+MHfdz/i4=;
  b=iY5hS9A9GZq12qd1yRlWd0KO53UeG4cwa0w6mpTjPf1QjhsFnVAc3ero
   WtGdNVsfPbpkwDlwHDiZ0N3lV5XicwPjvAwGC5lAu5wqQXwMMPjmIshPV
   bqJWtVG098nz3d3FKK75w0HJT/+v8FwMBlrPV1hBWl5zIun4x7pTvOiUC
   4RP9Au2QwToMo3v8SqxNszTmmQ7yxobXzaa4M52ZNqJ6o5hrkyqMecIck
   M1WDm+7PwD2Gk5sflPia5OhCwIyief/MbI2hEniiBYcfAZ0QowI2KeGyH
   xR4LBpVJih0L3+fhn0zaoaHoiL6Ooa/txm9Pl8vYsuiici+VXgOv7md0E
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="329293330"
X-IronPort-AV: E=Sophos;i="5.97,252,1669104000"; 
   d="scan'208";a="329293330"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2023 11:16:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="805921612"
X-IronPort-AV: E=Sophos;i="5.97,252,1669104000"; 
   d="scan'208";a="805921612"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga001.fm.intel.com with ESMTP; 27 Jan 2023 11:16:56 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 27 Jan 2023 11:16:56 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 27 Jan 2023 11:16:55 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 27 Jan 2023 11:16:55 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 27 Jan 2023 11:16:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WFhujgCY+2klt4B4dgx209cuXM6kgXRdzz7Qw1ab+Y/ZxxRdhGYq/viEc4S6rPrOuDx3FqSELR2nAcgbQLzk/oXDs6T7FbdTaFMDePgaQyyvLyKSt+FiKyRCH9UG3Pbu7i+CTDCtOsfy0yHSmOBDVaZE91izf7PhbDX9rMnTRzqCJwVnSOocZpPVgejxrlcNScZ2a9TsAQEJty79vzEaCdc1UVzhjqfptzFNKjXqqWihazu49sV0iQQmidkMZabYpISs9U64NeRP9g7yhOTbmtMZuMlwSlDX6DavBm6tS7yi0gW7JYKlyzWpYxXo+mlnFlkuL0jm5EPkabx/RLioxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NCJ+yLSwB5GdkMBT6WBErA/mGk9AeF1AUG+djnGEA20=;
 b=IRaBK6K5L4E+gbrZTOwjuID5X+f/dtBSnJBc1Bvkahcnp9ZUtjnCKSQ+rvrjh3X4ZaMXotQdI0voe/byhfuLLjVa+zG/aqKWhVZbTet4QZZctgdffeO1M7xbh/F9kbP7qunvBToKYPlLChD9rG5LeN+kI2ajK2dDpAxr3V0PVgGIF8XJ2aWmaHMssrFREl4G1+miKxKrK/81APBBvoFnqzuLM+ErGyXzBeTfqctqgnMsZEWvEW8s2v7TEBSpaUbqpEepD6NRm4yyoVo/qx0bhWDO3yAhSs49QvK4MzS8ls5Yo/NXEOHF9gbZqg2bnB9bTjE5KbB1a6inv0Wbo4rULQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ0PR11MB5895.namprd11.prod.outlook.com (2603:10b6:a03:42b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.21; Fri, 27 Jan
 2023 19:16:52 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc%5]) with mapi id 15.20.6043.022; Fri, 27 Jan 2023
 19:16:52 +0000
Date:   Fri, 27 Jan 2023 11:16:49 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re:
Message-ID: <63d423218e854_3a36e5294fd@dwillia2-xfh.jf.intel.com.notmuch>
References: <cover.1674070170.git.alison.schofield@intel.com>
 <63d32fe783ee2_ea2222949f@dwillia2-xfh.jf.intel.com.notmuch>
 <Y9P3ipL28W7N1bLm@aschofie-mobl2>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y9P3ipL28W7N1bLm@aschofie-mobl2>
X-ClientProxiedBy: BYAPR05CA0081.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::22) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ0PR11MB5895:EE_
X-MS-Office365-Filtering-Correlation-Id: d890e6c5-0be9-4193-5355-08db009b0b89
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pC4enOAGg3zswEoo1KETbw9e5eErPhKwKhgBcdFz5a7hr9yEU9ngXz2oMD0vui0hDWbVn1kM3koMdoh1M1JM7jkXfRtweI6aAV9EDchPg1KXw4IEvM5p3dsFzuzN5gTpjTAirS72iaymxO2cBS/tVtRkooyNzE4b6sKGY2L5iOi1NaDsJr/jK3qyZpe3g0t1/q/JDLgVNyI3/DTS/cX9ZVgypP/3K9ofgfPwyn1BqwMZk1FSWkqURlYfz3vaYZoJBir1G8YxCmW8+px68FYZUKQ3UwOY9ozYoOEoIQv/AKJPjPwBTri8A825LBqpRF/88LdfZ8fDaAqMsK2o/98J/9MBhJQOkNbPd+KG40s2uNi0Xja+urlDfvvpyaQ9AOTzVZYLMQOtuXmvbioCeJHsOq1YxqJ4O2JvyDlOXtq7AIUT6abzyVadSPA1SotKg/dmy2RDwQMpk0lAgkf/mXSizidNbYTrjtE6HJujxiI44O1U3XRiOQXdN5rHyKUAMUzq81L20u7dHml+5n5NtVE7LmVAofoNMMKVzEMqD/k4F+U9iQ8sUHlirlsBp4H9HIktrqGfCKm85m1xPH+LdKHXa16S2peLzjo/+PTaDPWG7pscdEnUW+5VNs79Gl5z6vU3JJHj8uro8V+/vIssd1SUA8D6YmdsSTpDKPR6P2Nv0bmWNo24BwnitQnJg2rM+J5B0EpPqRbuFhqQ11RLNkeMWw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(346002)(39860400002)(136003)(396003)(366004)(451199018)(5660300002)(7116003)(6512007)(66476007)(2906002)(66556008)(186003)(8676002)(66946007)(4326008)(8936002)(41300700001)(83380400001)(478600001)(6666004)(966005)(6506007)(9686003)(6486002)(26005)(316002)(38100700002)(3480700007)(82960400001)(110136005)(54906003)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?B3ibo1qVYS79091GjyFex0R8DhjxCair9DETpKNMTZXkgdmWSvCn6BVDGSRv?=
 =?us-ascii?Q?YajtpOGcP8pJNCFLcBJzaCUiHa7UFmwwMDYLXG3HEts9nDTCF4V836S8lMHE?=
 =?us-ascii?Q?Vk7xa/DSgq5hyhEykjvkAsGcsSXH+iubEdnc4Wp+iCByUMfjl9tw1OyVkX5m?=
 =?us-ascii?Q?mD3rSdnbjnHaZyhBcqO/eOWj0Tjx1WNJwsTEyKBnGyA8PaFJqBChdxdS+pwc?=
 =?us-ascii?Q?dA4CSen1y5YIx/jETZec3H08GsFbfHQaIE/5HUMwaZ4qbR3UeHqq0xkfcyjy?=
 =?us-ascii?Q?s+h6hBc9wRmJD3YBF/OwO8NqQh2JXtTJpGnq3vJPLW/P1oAy9ZJmR4qdj5WN?=
 =?us-ascii?Q?pYZmzS7lyYl4xCFeSEwzIn4jb6y5tx4mvl3i/iKdSF4QlM4mIo5cbPOlzWPd?=
 =?us-ascii?Q?OiOsk7WcAFqA0kONuRC08uyA+OViqtVMzZKK1HUKsF4Uuld5BS0VOTLenMCj?=
 =?us-ascii?Q?if9gzWWyUugroQr2yLtNTY/SCJr9Yx/l4+h0YOIUIxZP3XYtz92fEFYfudtR?=
 =?us-ascii?Q?kFtJlf8oUi85dZlD9Jt5RE/M04ITcdR0VubqmvUNwW0HpBg+s/XJu1Cc2wmR?=
 =?us-ascii?Q?j6UQmszOPUA4roixxpc3bdekGoYMW+g6Hi7Zf+R9GksYPWB97gnTakWZ07Zm?=
 =?us-ascii?Q?v1CuT0JqJ2ix8pp9fftT8Uy1YIblpSbj3KxxLGa3AdM8BIXusZXhOtWYiCYL?=
 =?us-ascii?Q?cz4ROwicY6JTENQKm/S3RpDjNH7TVubAexyhPQU/whWCSRRxjaqwIcEMo4R5?=
 =?us-ascii?Q?EvQUv+iW+zsWQkohgrD1SjJZOcHLDrUWz8R2soBY/WBInXnqypud1lFIexIG?=
 =?us-ascii?Q?6kpklb8vHW6kEvh/Up9E+iP0tmZAMWi0vC/q0ydSTthnZ5JniWXmORmR84CK?=
 =?us-ascii?Q?nyTk6z1Nt81VDtlMcbhO9Ag/oeq5mb94foPwGwRP9qBTg3vvze4rNDhunWjk?=
 =?us-ascii?Q?rxBHBEdvQkTh5jIfi/IJG3T20cx8IDTEqNQJ4KW8t+23R6VpP0ZdDRdH99DA?=
 =?us-ascii?Q?KHIc+fisiPuvgl7wWT//43126JET+yKS/b48MxMTJ/XkgXgHQj+wzubl6g/w?=
 =?us-ascii?Q?p+FxkxMXcbNSczRiUG5yL4IwgxPJk8XDCtkDfphS7bYJdzvojZMwjXdX/jE2?=
 =?us-ascii?Q?XH+7d1bG/1G2ZH3urd5HH4HNneiwSuh/iciPCsuKO1WcFgLh8a6GeaIMXH2m?=
 =?us-ascii?Q?81kKl3wbYFI9AnSns9XN57fOXUJCj8F+SLLx5RiB/qfT5JOo4kHfFwq7CcrU?=
 =?us-ascii?Q?USq3fFxInjaMRdOfXe5ew6kIyj1EhTlhoY3B5gWYyloTDHbNDU+sxkdzC65b?=
 =?us-ascii?Q?pyOPdPgs10eK3orFrvk/5DkquH36UOY9P6TZcBXjWCcQnLFXoIHcfd1og1tO?=
 =?us-ascii?Q?lZOcgK34ngukTU2fIpDbLYADkKHoOO9QEV0i3dleAsQvPCegq6QFNpP44ZQ7?=
 =?us-ascii?Q?wE8ITRe5B/WSytRLLwAdBtbFXaI3CL/cOHZyGjl8NkTyvV/9QK6D/Ir5RN7r?=
 =?us-ascii?Q?0cBbtSlF4bDnYYypJgPpOicNEF6RxR0GC+R6hm0VYxENQgeqUmqPz7iCgVnA?=
 =?us-ascii?Q?Lkyd/0B/teQZ//ehog2Q6HJT9uJBHbHN+UkacYwX0nAblLImyG4P5g/K2dix?=
 =?us-ascii?Q?Zg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d890e6c5-0be9-4193-5355-08db009b0b89
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2023 19:16:51.8256
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tqucZS1S1lpls6/jB7dCLiC5Es5xq/EsRFgyeesCtu5hgrTrW9Sf7rzR0dh2SZhKNX81NvGpt6aDYKDQ2eOO6we9CKhwhXPku+lO9n+t4kA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5895
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alison Schofield wrote:
> On Thu, Jan 26, 2023 at 05:59:03PM -0800, Dan Williams wrote:
> > alison.schofield@ wrote:
> > > From: Alison Schofield <alison.schofield@intel.com>
> > > 
> > > Subject: [PATCH v5 0/5] CXL Poison List Retrieval & Tracing
> > > 
> > > Changes in v5:
> > > - Rebase on cxl/next 
> > > - Use struct_size() to calc mbox cmd payload .min_out
> > > - s/INTERNAL/INJECTED mocked poison record source
> > > - Added Jonathan Reviewed-by tag on Patch 3
> > > 
> > > Link to v4:
> > > https://lore.kernel.org/linux-cxl/cover.1671135967.git.alison.schofield@intel.com/
> > > 
> > > Add support for retrieving device poison lists and store the returned
> > > error records as kernel trace events.
> > > 
> > > The handling of the poison list is guided by the CXL 3.0 Specification
> > > Section 8.2.9.8.4.1. [1] 
> > > 
> > > Example, triggered by memdev:
> > > $ echo 1 > /sys/bus/cxl/devices/mem3/trigger_poison_list
> > > cxl_poison: memdev=mem3 pcidev=cxl_mem.3 region= region_uuid=00000000-0000-0000-0000-000000000000 dpa=0x0 length=0x40 source=Internal flags= overflow_time=0
> > 
> > I think the pcidev= field wants to be called something like "host" or
> > "parent", because there is no strict requirement that a 'struct
> > cxl_memdev' is related to a 'struct pci_dev'. In fact in that example
> > "cxl_mem.3" is a 'struct platform_device'. Now that I think about it, I
> > think all CXL device events should be emitting the PCIe serial number
> > for the memdev.
> ]
> 
> Will do, 'host' and add PCIe serial no.
> 
> > 
> > I will look in the implementation, but do region= and region_uuid= get
> > populated when mem3 is a member of the region?
> 
> Not always.
> In the case above, where the trigger was by memdev, no.
> Region= and region_uuid= (and in the follow-on patch, hpa=) only get
> populated if the poison was triggered by region, like the case below.
> 
> It could be looked up for the by memdev cases. Is that wanted?

Just trying to understand the semantics. However, I do think it makes sense
for a memdev trigger to lookup information on all impacted regions
across all of the device's DPA and the region trigger makes sense to
lookup all memdevs, but bounded by the DPA that contributes to that
region. I just want to avoid someone having to trigger the region to get
extra information that was readily available from a memdev listing.

> 
> Thanks for the reviews Dan!
> > 
> > > 
> > > Example, triggered by region:
> > > $ echo 1 > /sys/bus/cxl/devices/region5/trigger_poison_list
> > > cxl_poison: memdev=mem0 pcidev=cxl_mem.0 region=region5 region_uuid=bfcb7a29-890e-4a41-8236-fe22221fc75c dpa=0x0 length=0x40 source=Internal flags= overflow_time=0
> > > cxl_poison: memdev=mem1 pcidev=cxl_mem.1 region=region5 region_uuid=bfcb7a29-890e-4a41-8236-fe22221fc75c dpa=0x0 length=0x40 source=Internal flags= overflow_time=0
> > > 
> > > [1]: https://www.computeexpresslink.org/download-the-specification
> > > 
> > > Alison Schofield (5):
> > >   cxl/mbox: Add GET_POISON_LIST mailbox command
> > >   cxl/trace: Add TRACE support for CXL media-error records
> > >   cxl/memdev: Add trigger_poison_list sysfs attribute
> > >   cxl/region: Add trigger_poison_list sysfs attribute
> > >   tools/testing/cxl: Mock support for Get Poison List
> > > 
> > >  Documentation/ABI/testing/sysfs-bus-cxl | 28 +++++++++
> > >  drivers/cxl/core/mbox.c                 | 78 +++++++++++++++++++++++
> > >  drivers/cxl/core/memdev.c               | 45 ++++++++++++++
> > >  drivers/cxl/core/region.c               | 33 ++++++++++
> > >  drivers/cxl/core/trace.h                | 83 +++++++++++++++++++++++++
> > >  drivers/cxl/cxlmem.h                    | 69 +++++++++++++++++++-
> > >  drivers/cxl/pci.c                       |  4 ++
> > >  tools/testing/cxl/test/mem.c            | 42 +++++++++++++
> > >  8 files changed, 381 insertions(+), 1 deletion(-)
> > > 
> > > 
> > > base-commit: 589c3357370a596ef7c99c00baca8ac799fce531
> > > -- 
> > > 2.37.3
> > > 
> > 
> > 


