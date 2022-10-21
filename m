Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18D85606F86
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 07:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbiJUFiT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 01:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbiJUFiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 01:38:13 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E97E21C77DF;
        Thu, 20 Oct 2022 22:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666330692; x=1697866692;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=qsijm1nWAYB0hTEPPXkclxCCdJ0IA1yPqNt83wkUHOM=;
  b=fWcqrYIEgynHlDI9aYlMP05Ix/6snbQv2z/l+BWylFmX5xS4eC77Z0GN
   BLS7WpdrujKDOeRQvQagzO1tVDi3aBoxrIG6bR8B1Cdv1mNi903YSuEpF
   HRpMFTq2Bc1Mj37vQ2Z/b3g1Pf1uojhdiAq2DFIVyFQj3OYFjvPvu9I1r
   0koHtf4G9L9GAFfzyFhmW0WZ0xTExMGDDH1bngU7rKrbjNuZnnr+cxv5F
   6cAFqqeGdQkf6YOSVA1Bn085tPOox4h4teV44k2nWpWPiuHBtO6q1V3/N
   t2ZXDJAxOJsNK5oCth1FDGh+V46wiN4Uz/7aU09kQnuzv5fLa3bIg5Vrr
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="371131186"
X-IronPort-AV: E=Sophos;i="5.95,200,1661842800"; 
   d="scan'208";a="371131186"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2022 22:38:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="875474329"
X-IronPort-AV: E=Sophos;i="5.95,200,1661842800"; 
   d="scan'208";a="875474329"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga006.fm.intel.com with ESMTP; 20 Oct 2022 22:38:11 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 20 Oct 2022 22:38:11 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 20 Oct 2022 22:38:10 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 20 Oct 2022 22:38:10 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 20 Oct 2022 22:38:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ev86lcvcUfam4D3nlPZrbqKqe2CfxLkFlavtHiTf6yu8L9FtAoWzpA2Ag5philsS56VjUmfEZpoE9vIoVpbqzXo82IzjhYjDFb3j2LuBf+nnIV/+O29hhp6uM4gwkTkX9MaG1X+1etJT7a95vo+FungXUJDgiXH0HbspQnEp3ZjK5pfB8cd7J2AaLtnHWXvXDkvwYxqx/FVZ5bQhJevOs/VWDeBeBlk10M+R5CaBvYxdajlFqlNo3DXLKnqGRMfZ19AlvMsOFNk+2LcDZzeXMm0jYsdt40/xI+dFKAG+C8DGcQmAGix2w9afClTiVwi+laDyF9bRjnHcDj0KA8ktgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q6RLynEOtWNkBS94SamNfOjXAnvgrbkBoWt+ildnxEs=;
 b=MrOYc5NeuOQv2x7oohLsvBDAh0E2n573NIkoS/b89X2SpgYwhXCUb66G+kqxKXC9INmEJes6Tpf7byVSbu8iolmB+ypLlUnjJ+PP/bvRcsyGc21HZsnx4r8XtcslZOapMiTetZiFTxvw6PtyqSezPhm7ombfgwlq4+L/DokVehHqi7Q8PqoM0izv7nprFbvfLk2pMjdr3dUeftfavJdF6VAAVxszh5U4Hh3KBLHBoZGqjLAUhdpAAU0yIDsg8msYGH724U22/KTeQXYN4M+bk0t98A32QDeZfmvFg8RvbYlcBDpRv+HAmhJVstsQepPnjyjK8ib6zyWqx98igGVDvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by BL3PR11MB6362.namprd11.prod.outlook.com
 (2603:10b6:208:3b5::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Fri, 21 Oct
 2022 05:38:06 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::7d5a:684d:99f7:4e83]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::7d5a:684d:99f7:4e83%12]) with mapi id 15.20.5723.034; Fri, 21 Oct
 2022 05:38:06 +0000
Date:   Thu, 20 Oct 2022 22:38:03 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Robert Richter <rrichter@amd.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ira Weiny" <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        "Dan Williams" <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "Davidlohr Bueso" <dave@stgolabs.net>,
        Robert Richter <rrichter@amd.com>
Subject: RE: [PATCH v2 07/12] cxl: Remove dev_is_cxl_root_child() check in
 devm_cxl_enumerate_ports()
Message-ID: <6352303b266c_24ac29423@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20221018132341.76259-1-rrichter@amd.com>
 <20221018132341.76259-8-rrichter@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221018132341.76259-8-rrichter@amd.com>
X-ClientProxiedBy: SJ0PR03CA0094.namprd03.prod.outlook.com
 (2603:10b6:a03:333::9) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|BL3PR11MB6362:EE_
X-MS-Office365-Filtering-Correlation-Id: 82df6124-f3e6-47ed-f66f-08dab3266db1
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ny5K6NvWLENpGP43yQdWEMzmuUYA5+HoV89A3E0krOPIWe4xWE9JumBdeTklVs6UgeuDtMZMIOKarI1PVyK0D/mYn75N9UWGnQbGNd9Zhw058IwcVfgphCbIEn8Zgq/DD1bKj9Bi7oA2FKcX4ulXbN1zyq8721eJzupaDFUhr5IITMOfAH3i7ixuu5hOORMiGRGaVNOT8fmIQubAkcFrIINYSSodmVxjDtH1Uu1l7fCbmPJAIXrmSN6ftVo2lC6HCz4vnHkkYS5xDC7BJvDwtpWsx97IIB4+QdLabMciuT3u5czVaGjoV7engMpWRm60b5qqrmlLPfFyaltab1R/2KEBPw863w5npHBJT8o6G3zg3+qbVUZodxG9JzwwWw8NBG9npckCFMFzxW6FiMdwsk0Iaz6foVriPlKpWBUoAf7W9HgXiBIJOR6nRyDfo/o25kqB/TfQQ5zAcwiVVz2mxKsvgbyYmWOnYXMGTO4laQZA99kNUPywgaf0XHQusbwWb7rRqpRcAIJYv72iGB89TrZrhgv01QLXGWNU7hRRoCL/d/s9czrLRcHiGq2TGfSWeYA4ovvbe2kxWV6pr+8f4XTiQAoODxA96EjZmXUPdyb43sCQMsG1dv0VB4jx+l/Fp/b3tAmuAk6CBTl+fIiz0F1OxxD+ka1JKz7fDiEwpxgG5icRyrT4t/e0CSc13I4UGZqFj1d4e/CHyfF8W0eCTg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(39860400002)(396003)(366004)(136003)(346002)(451199015)(86362001)(82960400001)(38100700002)(6666004)(6506007)(5660300002)(9686003)(2906002)(26005)(6486002)(478600001)(186003)(6512007)(110136005)(66556008)(316002)(8676002)(8936002)(66946007)(54906003)(4326008)(41300700001)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pNyR4t0Yk6R7REVp5K4bb/Q5xB77tXoMu45b4N0xjtr1F3FEIqkNMOffoqcq?=
 =?us-ascii?Q?DfPut21yZnG+MyJMQkyvZ5XYa4syb9SHnFcUbIGWTLpjDXlA24azrqcLtvDM?=
 =?us-ascii?Q?oj4Qrd0/SnJCL+aNwevIkjG7AwWEZkykN8uEMeKlYt9T2uHkwltnTpx+Qwpk?=
 =?us-ascii?Q?5627G1iQNXAbN1tFQuFpdIHJTCELaXliz6mN71rCwzQD6yNYumEqhEEUxHa4?=
 =?us-ascii?Q?/kgcCndEqPHFEk49x/wIpGCwgHrE6tmscp78ZIRThbEyFv2qxoNo81BfBNZx?=
 =?us-ascii?Q?bGAMLK6abrIF/UHC1YoTrOEjHYUkoW2Y+Z2TldhlejYjH9UM8dzE4dAll6Hn?=
 =?us-ascii?Q?C18n6tjed6N3zcJMkefueE1PThAlGBJlvZ+MvrzTuapAnsq8KegFLFeZRU81?=
 =?us-ascii?Q?koanSL+uocKkykwcdAPu5n9FiqGO2SQsll58P/kr6EhJRODZiVbgjR+n9fFL?=
 =?us-ascii?Q?LG7lCiFQ+4rfvFSme/yEYIL9CeBJ6xfa37I8Fj6oiD82V7KygLBgUAnH823h?=
 =?us-ascii?Q?Kr5Gf7dqzX+ZZ86zzSyN+bKOQ6EFz3g5HX0rU8xzKoUDElqHJxVRQq5Eea5t?=
 =?us-ascii?Q?9M0N+INonxQDRdywNZ0xUENMDVWn7ZqLbqvOc4AL4P/OLIXUJdHGfB8A+uA5?=
 =?us-ascii?Q?nRyKtxgRRk4opORUqvx376WuRxHnz5UNbVVmWtRDYjbilO10UAL71y03PDM8?=
 =?us-ascii?Q?Iv2M7D7rBLzTeiKLF047ZZx0/B5BH8mZi6wA+pTqqzNG0d1lhr9uGs3lxTkk?=
 =?us-ascii?Q?VDTTEUavDV6+IdbuYLMxWITQDlyft9XYKaJR5gISmiKB3yW2/hDo7oIGuOSD?=
 =?us-ascii?Q?cLQCpxyS5agFNGXcvhawZl0wNgKboYQBGY5Ic1+eFxHHQnRPsvKT79ikK4Oq?=
 =?us-ascii?Q?e0wHHhzaSh/fsE0yxbKYeB0tnj3WOSyKThOhpRYnvwjVH/xette7UCopcej2?=
 =?us-ascii?Q?Lzj5AzqoohNyUmUaUl3b38OXXljAnTHAFUTC9OupUtT/TJf5N2rOWZwykPAH?=
 =?us-ascii?Q?QtUJGcF6BBuonLchtUJL/Kr33sjUxzxx8u6saFcRXFWuLCd3tQaelJI6DODe?=
 =?us-ascii?Q?n8OTF/KAeLHF+RZ0pIzdhajQTmc1QUI28LMZdp6WuNviZ12ormBlZynnSz7U?=
 =?us-ascii?Q?R3Q9VM16Q4VQuqhr4qljNDMGb9M2MD4SCZ2A8X5cv0Dyfq3fbZVNlLMA4Ofc?=
 =?us-ascii?Q?eI6C6S0rkHvevmH4moY1PFxFLgs9ZJ8ScrGgU4kob+5LmlwcLgKMD0GyIU8C?=
 =?us-ascii?Q?LIIAGZ43tzeh7lHyClDY9pR2LPXBpeUimX0N7JLG9WuXQTluooVa/+IrHstD?=
 =?us-ascii?Q?7AR1ImHa/o3YtmXHW2ZKyLEi8ooHVoJI4OT6HUyq6c0qUy+9uQ3rnqPEpoYv?=
 =?us-ascii?Q?G5S36MtnDu+endAIf1toDU2HdPj8nRWtbsxsSst8YanJQ7R6eBpSMYYr6h1I?=
 =?us-ascii?Q?yEJmhxzRXEQK1VG3tL1QWYvanM6p8c0V9F81RFNS7/MzpZPA0A2ZSjVAxPDW?=
 =?us-ascii?Q?/7bFhZotRZOX7ndImrl4FmYiZeUEqh6TMkz6Ai+ONQolhY61aSKWGzxmp71O?=
 =?us-ascii?Q?l0zBryC0nwpr3qVDf99VpdwQg5IrlnUtmFAhXgjl7emkW//98/RG5NJbSBMJ?=
 =?us-ascii?Q?2Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 82df6124-f3e6-47ed-f66f-08dab3266db1
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2022 05:38:05.8886
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +ZyiM2eIpq5AZUmjrdWY5RO1saPL0zLP8IIEVHWRlXEHCvGurkKpZt/ljmLaOtW3XIMpNIfnXv9oFFVn9YrXlPUy0gUEzf5tSrA0pOs9IMw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6362
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Richter wrote:
> The dev_is_cxl_root_child() check adds complexity to the control flow
> of the iterator loop in devm_cxl_enumerate_ports(). This check is
> unnecessary and can safely be removed: If the port of a dport_dev is
> connected to the cxl root port, the grandparent of dport_dev will be
> null. This is checked early in the iterator loop and the function is
> left in this case.
> 
> Drop this check to ease the control flow in devm_cxl_enumerate_
> ports().
> 
> This change is a prerequisite of factoring out parts of the loop.

Ok, so this seems to be where we diverge on how an RCH topology maps
into the CXL subsystem object hierarchy. The main observation going
through this with Dave before this set came out is that
devm_cxl_enumerate_ports() is a nop and should be skipped in the RCH
case. devm_cxl_enumerate_ports() is only for discovering intermediate
ports between a host bridge and an endpoint.

In a CXL VH topology a direct attached endpoint is downstream of a
host-bridge's root port. In the CXL RCH topology the
Root-Complex-Integrated-Endpoint is a *peer* of a host-bridge's root
port. So one level of the hierarchy is removed and
devm_cxl_enumerate_ports() can be skipped.

The proposal is to have cxl_mem_probe() do something like:

       if (!cxlds->is_rcd) {
               rc = devm_cxl_enumerate_ports(cxlmd);
               if (rc)
                       return rc;
       }

The existing:

       parent_port = cxl_mem_find_port(cxlmd, &dport);

...should do the right thing as long as cxl_acpi registers the host
bridge as a dport with this change:

-       dport = devm_cxl_add_dport(root_port, match, uid, ...
+       dport = devm_cxl_add_dport(root_port, pci_root->bus->bridge, uid, ... 

That way the dport device is not the ACPI device but the 'struct
pci_dev' for the host-bridge.

With that scheme in place and some cxl-cli fixups from Vishal we are
seeing:

# cxl list -BEMPTu
{
  "bus":"root0",
  "provider":"ACPI.CXL",
  "nr_dports":1,
  "dports":[
    {
      "dport":"pci0000:38",
      "id":"0x31"
    }
  ],
  "endpoints:root0":[
    {
      "endpoint":"endpoint1",
      "host":"mem0",
      "depth":1,
      "memdev":{
        "memdev":"mem0",
        "pmem_size":0,
        "ram_size":"16.00 GiB (17.18 GB)",
        "serial":"0",
        "numa_node":0,
        "host":"0000:38:00.0"
      }
    }
  ]
}

Does that make sense? I think this patchset gets a lot simpler if it
does not try to make devm_cxl_enumerate_ports() understand the RCH
topology.
