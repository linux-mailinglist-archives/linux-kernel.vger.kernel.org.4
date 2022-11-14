Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA649628A65
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 21:23:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237545AbiKNUXD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 15:23:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237459AbiKNUXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 15:23:01 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10B04E24;
        Mon, 14 Nov 2022 12:23:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668457380; x=1699993380;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=66jGHX3fGIs15O1tMn+IrmyvFYoU+y7elfnlx0fsTzI=;
  b=dtBeS8JVrO45A6vkxyjxFwu8z294GTXgWOIhmJdJJHXMAINBzxpNH8HZ
   GieR/PlHcrAK/qGoVQtHz4Wbf3WBV7XBgFvPdaoZDnGEnsJXICHAO3OTZ
   fwPNVvMWH0xXyKHSZNVo1787HHNREub6dCDLoxjcdv3XOBGICVI30B2Sn
   1CQ+141ovqo9sQtNlO8dAbuZd4Rmb+FkdJzREvyMYGB/PRGlewEsJ6KPL
   8lzbdoAsx/z2E1urz67bo+NOUU5+7pLfbM/qXWFmU3/3OKypltSTeh9zm
   gDRbco3uCl0mOYS2b4xCwDa2u6nDMZNpB8fcaF6h0XmKT0cOpUQh4AZdW
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="295437715"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="295437715"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2022 12:22:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="632947055"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="632947055"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga007.jf.intel.com with ESMTP; 14 Nov 2022 12:22:59 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 14 Nov 2022 12:22:58 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 14 Nov 2022 12:22:58 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 14 Nov 2022 12:22:58 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.102)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 14 Nov 2022 12:22:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NKaB/sVIi9xFHVgZYYmItesq2Pu3ku/jNRcvTexDCz4VOIMi8BxtUgofFCcDaqHO6pxi2OFE6ik5bttJX/ra7IRU0y8I0nSSBBjQBJDKRWCn5s1R8ShWK1yePWgvB+ht3gZlIsqM57/IHGgolSJ/zz3VWHwQEcnOZ0XneGTr9/9OEFspNjRt7pOvpfYVE45ELe5L7TXUJo7XJZnyQpBBMk3kX0D+T31B/Uet3x5VCf+usq8RIiWV6lRMBs1TmUM0cbI581RR7z2bt02q9fMgNBaJ1mOLWX8rTG7I13V23F3U0Zb0/wOHUAwM3b+AbskUm1qeOQuwJTchJWKLg0f4UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=slJbT3s16AVxyjHPF/DY1sDe4ABSjWnf97sw3SJbL9g=;
 b=C3U80Ygwr1xYD2ZO7hITWeBOMXoDBoWIQ/hQxDjtj9IqNElfI25Bq+7pG3xmvDb1bLuWoUi/9Dt/GAfBmT3PuJcotwqZkad5YSdBgLgFLuFGbG346VypeqLo00/afAI8NOXBdVLiTprwYjy1KGG8XObty05fA+NciseOpmY6VPITx7bgvVSS/+lD9AJUYhW7KhLHwzDryle2f64r5w27xg0tJQmhlv5Qu7PM7Z6C11ae8yDagKNMhXLurDtPmkqucAMgasDFccwhhHKYOwCOkLrK3WK9rJaHvjNeJkyBYhiQk3oYqmsEzSmWabhHpCXMpu4BQp9ibEQsl8vvxhZmGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by SA1PR11MB6614.namprd11.prod.outlook.com
 (2603:10b6:806:255::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.25; Mon, 14 Nov
 2022 20:22:55 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::b058:673:c228:3e95]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::b058:673:c228:3e95%8]) with mapi id 15.20.5813.013; Mon, 14 Nov 2022
 20:22:55 +0000
Date:   Mon, 14 Nov 2022 12:22:49 -0800
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
        Dave Jiang <dave.jiang@intel.com>,
        Robert Richter <rrichter@amd.com>
Subject: RE: [PATCH v3 1/9] cxl/acpi: Register CXL host ports by bridge device
Message-ID: <6372a399b3400_12cdff2945b@dwillia2-xfh.jf.intel.com.notmuch>
References: <20221109104059.766720-1-rrichter@amd.com>
 <20221109104059.766720-2-rrichter@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221109104059.766720-2-rrichter@amd.com>
X-ClientProxiedBy: BYAPR21CA0017.namprd21.prod.outlook.com
 (2603:10b6:a03:114::27) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|SA1PR11MB6614:EE_
X-MS-Office365-Filtering-Correlation-Id: 4581e03e-8df8-4a32-f8f9-08dac67e0212
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YH3kZapPwmlr++M/RDiGr2CsDFEGGN7VQjYLTQT4yB4q7DpJDW/1FNbgZ1lQ0/Be2cRCi/fyVnVhBzfkYQjA2wEKc+ZZI9Z5HLPUnbST5ntk70etWZaVXqRPsT5lRMDORH5MzpZGlC7Dv4OdyaSxENoZci3cpxvY2E3Af7CXc98A2Xx4P0H6Bwz3MJA3aWqk88VbhQajjCC+L3oQhdPHBqzMLWob6l4AmrI5F0KCIRk7taywCVIFlGuSOiASS1upMYT6AQksV9PSyB0Jl2vdJkAtxH3SyGGRC7wAj8xcIUGkELzz6GX8z0g0/TL9796xBpsL4U9KPgv5is1mPjXTSGPZ+iE0JKf3oL6wWFE/XK2V8t4sN77/R0k9F2c+SOlG8tYrSoNXR2xq27T23CXB33/MMZ4S/jXiLW9WnZRfdQQGpjT5+k1RpyxVxHPVNLygf+HiRluwwxJlbuc+FZQBdyTSMwLnKh/A3zjIVDJsEXg/QCyNwsy1OfyQdx0K8LdnyXFPnQKVvURClnFY80se9Iz9rzD0PZcF16hUOEkSsdAl8D7V3eFzQLHGRFmmIavdaz7jQC+Fkfv2+om5zs/7bvIdeFgu+eZrZ/wSWeCt08PH7hUrC/GRRWfI12eWGMn9AAhWCQUQc5xwtP47M+dwT372gtj+YQsVJfRQHgcqPsngZ76KZqO16Ch0Gsp8hCmAcg9/d9aW1HIv2Eiqxkbtc90WUbU9kxNI1K5ylTuss4g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(376002)(136003)(366004)(346002)(39860400002)(451199015)(26005)(83380400001)(6486002)(966005)(478600001)(6666004)(53546011)(6506007)(9686003)(6512007)(2906002)(54906003)(186003)(66556008)(66476007)(110136005)(41300700001)(8676002)(4326008)(316002)(5660300002)(66946007)(86362001)(8936002)(82960400001)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WdjlZvxaGrIB6Du+Dihq0wQ/3IfnWVkS4lJzN5yPm7fx9jsZsLqGlkKKJR4t?=
 =?us-ascii?Q?W5mBuUKjv9dB5zNZ1Dv0ZmTYRhZXLir5bBYEYYe5V9QYNg54g+dXGcQbxFZM?=
 =?us-ascii?Q?qjSOYpd7oGxBP9aqQrEzeMS5wxz4vKncJ1482NeR5sPHu8D7BGytEWSS6ted?=
 =?us-ascii?Q?9QVs8B+iSHKvjdNwfuGoxRdk+EXhalSoaU/ZjhU2fQaok1KcA3eyw9HeQ49A?=
 =?us-ascii?Q?Ansyt02ODkiTzcGH9SFDCgngf5JxvIrd5Zo4hK/jrM/JEm0s3JqffvUf5wo0?=
 =?us-ascii?Q?BGRIGCABuPwVpnmqXXPHolZyAJySn347G9UWBO/DxgFKePMvXHb3rOCPrdwV?=
 =?us-ascii?Q?GVE4RDGl38JPav45tsyuY0XEgPKr0d+E19h+CPy+pex1bMD7dRh5n4u8S/oX?=
 =?us-ascii?Q?S0qkoT/rm//nUaXukaLfGSJLLhoC1wfWb4NVdfPJFKYAcyPYLZrsNFvIJWEu?=
 =?us-ascii?Q?C22f6InvaeOkbvWfk6oGgVlwYYFvHZUs/B1HUz/A/kwh8cPBsJ3OrA3K5HWr?=
 =?us-ascii?Q?uubY3n8CsZvmmYfWrlYF3eT6XBWPGfROphA69EiS5vP1RQm4yllE2hX6SPo2?=
 =?us-ascii?Q?Fdmz5TbjaiIhvURv6abzpnTEexEXaUcRCuO81kk+undoEYMTKjIPeJkQiFU0?=
 =?us-ascii?Q?2/f5xCI0/G0W6Pq+yiWe8/srgskzXqtlhGy79n2KAnCsD4mLn0Wui/q0Zy1b?=
 =?us-ascii?Q?oJuwAd1eqUOkLNOPV34L3egmgo5vQeHABFQByACxLdHjZCQfS56bzoIcbqzX?=
 =?us-ascii?Q?e38SaYfKDiVbKQDEIHCisQrk3VKtXvHBK6ZlDOC8wCA6GejstIUpvnmK5wxH?=
 =?us-ascii?Q?u2tx2ylOkQWi3+Fs54v1i6jttFF0wAbYCHc6gVYLwBK5td/RbrZA3FUBuPYI?=
 =?us-ascii?Q?OffvPt/EV8ySxXuMn1ReDueG3EMyTuJSmYWjUOvvnLAeP1dZdY1vjOhFIitG?=
 =?us-ascii?Q?7z7zIuJ3LIOyk4WgeS6d5g7pD3Jj59XJhJvcoTU2+prKTMJPQsb/gJMXJOO/?=
 =?us-ascii?Q?2slPc6czu1kJhBWN8IUjiqUObG3VE2TW0IhPpBDd1conjwR2G9uTHd5WLItI?=
 =?us-ascii?Q?GB8aAYobisesIGrWawZCIlPKTFDdEhQgsFLigfkPTiAiLOmfj+zvsCY/IRxn?=
 =?us-ascii?Q?amMjj7WBr8wW0xw301KZRPIarCbV2zQEXXQxW88FzzHnfAmRqlPQxq9/go7R?=
 =?us-ascii?Q?sx7uStI2p/yInJt3/D0ViR6V42iPvU/MDFYyfvyKlqwRO01mAKik+0C6kHX3?=
 =?us-ascii?Q?q5S9ktJP7PAbKM7Qszb6bg0I9RBfg6U4J2VWemP6jIdrioOJq13H4vK69ELb?=
 =?us-ascii?Q?0WS/sZXxyABmLElxKc9pxkyct0v3Exztjwahegk6uJ27Ogqg25w/YJbsrEid?=
 =?us-ascii?Q?MTeYo0YmOCxX3t4l84/DxOiowsUqk803DCWnQYDMIOdHYIBjTU6fH85otyxq?=
 =?us-ascii?Q?mMCY4k0RfPGf0ja7LghruD0Sbb8Qs3vz0ecQCJRoguFm4BSdtQAI7/sMdktO?=
 =?us-ascii?Q?i7nabYG9yFipTFTtorAyC3E6jb1kJqg4gl4tEgmg7puI+Y7CEPwzA6SAvJ88?=
 =?us-ascii?Q?fjjhMEiVdorAswzxHeIo0BLgiRIuaL2dRG68tgFOCPRyRLsQULCYI8IPeafe?=
 =?us-ascii?Q?pQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4581e03e-8df8-4a32-f8f9-08dac67e0212
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2022 20:22:55.4320
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l/6mrgSY0yLFe5ieI8MtLGg9oFjSEmZykK8rrSAtcV2uujMkqOQ/LIS62IJj8atr77bB/8rMfxtlAdKK80QhAiw5nwSy4A9D7zoe6qYRsbw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6614
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Richter wrote:
> A port of a CXL host bridge links to the bridge's acpi device
> (&adev->dev) with its corresponding uport/dport device (uport_dev and
> dport_dev respectively). The device is not a direct parent device in
> the PCI topology as pdev->dev.parent points to a PCI bridge's (struct
> pci_host_bridge) device. The following CXL memory device hierarchy
> would be valid for an endpoint once an RCD EP would be enabled (note
> this will be done in a later patch):
> 
> VH mode:
> 
>  cxlmd->dev.parent->parent
>         ^^^\^^^^^^\ ^^^^^^\
>             \      \       pci_dev (Type 1, Downstream Port)
>              \      pci_dev (Type 0, PCI Express Endpoint)
>               cxl mem device
> 
> RCD mode:
> 
>  cxlmd->dev.parent->parent
>         ^^^\^^^^^^\ ^^^^^^\
>             \      \       pci_host_bridge
>              \      pci_dev (Type 0, RCiEP)
>               cxl mem device
> 
> In VH mode a downstream port is created by port enumeration and thus
> always exists.
> 
> Now, in RCD mode the host bridge also already exists but it references
> to an ACPI device. A port lookup by the PCI device's parent device
> will fail as a direct link to the registered port is missing. The ACPI
> device of the bridge must be determined first.
> 
> To prevent this, change port registration of a CXL host to use the
> bridge device instead. Do this also for the VH case as port topology
> will better reflect the PCI topology then.
> 
> If a mock device is registered by a test driver, the bridge pointer
> can be NULL. Keep using the matching ACPI device (&adev->dev) as a
> fallback in this case.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> ---
>  drivers/cxl/acpi.c | 48 ++++++++++++++++++++++++++++++----------------
>  1 file changed, 31 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index fb9f72813067..06150c953f58 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -185,6 +185,17 @@ __mock struct acpi_device *to_cxl_host_bridge(struct device *host,
>  	return NULL;
>  }
>  
> +static inline struct acpi_pci_root *to_cxl_pci_root(struct device *host,
> +						    struct device *match)
> +{
> +	struct acpi_device *adev = to_cxl_host_bridge(host, match);
> +
> +	if (!adev)
> +		return NULL;
> +
> +	return acpi_pci_find_root(adev->handle);
> +}
> +
>  /*
>   * A host bridge is a dport to a CFMWS decode and it is a uport to the
>   * dport (PCIe Root Ports) in the host bridge.
> @@ -193,35 +204,35 @@ static int add_host_bridge_uport(struct device *match, void *arg)
>  {
>  	struct cxl_port *root_port = arg;
>  	struct device *host = root_port->dev.parent;
> -	struct acpi_device *bridge = to_cxl_host_bridge(host, match);
> -	struct acpi_pci_root *pci_root;
> +	struct acpi_pci_root *pci_root = to_cxl_pci_root(host, match);
>  	struct cxl_dport *dport;
>  	struct cxl_port *port;
> +	struct device *bridge;
>  	int rc;
>  
> -	if (!bridge)
> +	if (!pci_root)
>  		return 0;
>  
> -	dport = cxl_find_dport_by_dev(root_port, match);
> +	/*
> +	 * If it is a mock dev, the bridge can be NULL, use matching
> +	 * device (&adev->dev) as a fallback then then.
> +	 */
> +	bridge = pci_root->bus->bridge ?: match;

While I appreciate that you ran this against the unit tests, production
code should not know or care about the presence of mock devices. So,
this was showing a gap in the mock implementation, now addressed here:

http://lore.kernel.org/r/166845667383.1449826.14492184009399164787.stgit@dwillia2-xfh.jf.intel.com

With that, this approach can be simplified to the following:

-- >8 --
From 3cb7a46e100d016132727ad32904b629061e40d5 Mon Sep 17 00:00:00 2001
From: Robert Richter <rrichter@amd.com>
Date: Mon, 14 Nov 2022 12:20:27 -0800
Subject: [PATCH v4] cxl/acpi: Register CXL host ports by bridge device

A port of a CXL host bridge links to the bridge's acpi device
(&adev->dev) with its corresponding uport/dport device (uport_dev and
dport_dev respectively). The device is not a direct parent device in
the PCI topology as pdev->dev.parent points to a PCI bridge's (struct
pci_host_bridge) device. The following CXL memory device hierarchy
would be valid for an endpoint once an RCD EP would be enabled (note
this will be done in a later patch):

VH mode:

 cxlmd->dev.parent->parent
        ^^^\^^^^^^\ ^^^^^^\
            \      \       pci_dev (Type 1, Downstream Port)
             \      pci_dev (Type 0, PCI Express Endpoint)
              cxl mem device

RCD mode:

 cxlmd->dev.parent->parent
        ^^^\^^^^^^\ ^^^^^^\
            \      \       pci_host_bridge
             \      pci_dev (Type 0, RCiEP)
              cxl mem device

In VH mode a downstream port is created by port enumeration and thus
always exists.

Now, in RCD mode the host bridge also already exists but it references
to an ACPI device. A port lookup by the PCI device's parent device
will fail as a direct link to the registered port is missing. The ACPI
device of the bridge must be determined first.

To prevent this, change port registration of a CXL host to use the
bridge device instead. Do this also for the VH case as port topology
will better reflect the PCI topology then.

Signed-off-by: Robert Richter <rrichter@amd.com>
Co-developed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/acpi.c | 35 +++++++++++++++++++----------------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index fb9f72813067..71f8bdedd676 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -193,35 +193,34 @@ static int add_host_bridge_uport(struct device *match, void *arg)
 {
 	struct cxl_port *root_port = arg;
 	struct device *host = root_port->dev.parent;
-	struct acpi_device *bridge = to_cxl_host_bridge(host, match);
+	struct acpi_device *hb = to_cxl_host_bridge(host, match);
 	struct acpi_pci_root *pci_root;
 	struct cxl_dport *dport;
 	struct cxl_port *port;
+	struct device *bridge;
 	int rc;
 
-	if (!bridge)
+	if (!hb)
 		return 0;
 
-	dport = cxl_find_dport_by_dev(root_port, match);
+	pci_root = acpi_pci_find_root(hb->handle);
+	bridge = pci_root->bus->bridge;
+	dport = cxl_find_dport_by_dev(root_port, bridge);
 	if (!dport) {
 		dev_dbg(host, "host bridge expected and not found\n");
 		return 0;
 	}
 
-	/*
-	 * Note that this lookup already succeeded in
-	 * to_cxl_host_bridge(), so no need to check for failure here
-	 */
-	pci_root = acpi_pci_find_root(bridge->handle);
-	rc = devm_cxl_register_pci_bus(host, match, pci_root->bus);
+	rc = devm_cxl_register_pci_bus(host, bridge, pci_root->bus);
 	if (rc)
 		return rc;
 
-	port = devm_cxl_add_port(host, match, dport->component_reg_phys, dport);
+	port = devm_cxl_add_port(host, bridge, dport->component_reg_phys,
+				 dport);
 	if (IS_ERR(port))
 		return PTR_ERR(port);
 
-	dev_info(pci_root->bus->bridge, "host supports CXL\n");
+	dev_info(bridge, "host supports CXL\n");
 
 	return 0;
 }
@@ -253,18 +252,20 @@ static int cxl_get_chbcr(union acpi_subtable_headers *header, void *arg,
 static int add_host_bridge_dport(struct device *match, void *arg)
 {
 	acpi_status status;
+	struct device *bridge;
 	unsigned long long uid;
 	struct cxl_dport *dport;
 	struct cxl_chbs_context ctx;
+	struct acpi_pci_root *pci_root;
 	struct cxl_port *root_port = arg;
 	struct device *host = root_port->dev.parent;
-	struct acpi_device *bridge = to_cxl_host_bridge(host, match);
+	struct acpi_device *hb = to_cxl_host_bridge(host, match);
 
-	if (!bridge)
+	if (!hb)
 		return 0;
 
-	status = acpi_evaluate_integer(bridge->handle, METHOD_NAME__UID, NULL,
-				       &uid);
+	status =
+		acpi_evaluate_integer(hb->handle, METHOD_NAME__UID, NULL, &uid);
 	if (status != AE_OK) {
 		dev_err(match, "unable to retrieve _UID\n");
 		return -ENODEV;
@@ -285,7 +286,9 @@ static int add_host_bridge_dport(struct device *match, void *arg)
 
 	dev_dbg(match, "CHBCR found: 0x%08llx\n", (u64)ctx.chbcr);
 
-	dport = devm_cxl_add_dport(root_port, match, uid, ctx.chbcr);
+	pci_root = acpi_pci_find_root(hb->handle);
+	bridge = pci_root->bus->bridge;
+	dport = devm_cxl_add_dport(root_port, bridge, uid, ctx.chbcr);
 	if (IS_ERR(dport))
 		return PTR_ERR(dport);
 
-- 
2.38.1
