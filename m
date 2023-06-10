Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFD7C72A77B
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 03:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbjFJBhB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 21:37:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjFJBg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 21:36:58 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 267AAE46;
        Fri,  9 Jun 2023 18:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686361016; x=1717897016;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=3BowEMM2wl1tDNEQhOhS1IYCVfHLb5i8AhuHgAXgbZU=;
  b=n+NK9T1wZEl1QEIkqQQLnAAXUaTAHrXn+pEj8w9XjM4UP6hnlKPbWptl
   sBUEidmf764wVdWHdAydZL4cmQCc/opgS/6kBcTbPI5Zje2mK9jOmP4uH
   YhCul2CIxuEGu5ZTgGHm46gP6GBoIOtLIzPyXzIV0UsVmceTvElmIpv2a
   GIY3pViH8iA0OSb7BP0OP7KpTjuhYxJpk7twKMjpS7R+jGCpvAaMfxKkv
   W2DaS7povBoLYxyxWRyt7TZ0CTz16Pt9vxsNSSrApL9prtmd2F5WROpXB
   +2sS5CD46P8l6JLqf+MU2T203G3cf8g/wCPxojS57yKd3hpBT5MRJWX77
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10736"; a="347364407"
X-IronPort-AV: E=Sophos;i="6.00,231,1681196400"; 
   d="scan'208";a="347364407"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2023 18:36:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10736"; a="713709924"
X-IronPort-AV: E=Sophos;i="6.00,231,1681196400"; 
   d="scan'208";a="713709924"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga007.fm.intel.com with ESMTP; 09 Jun 2023 18:36:54 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 9 Jun 2023 18:36:54 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 9 Jun 2023 18:36:54 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 9 Jun 2023 18:36:54 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 9 Jun 2023 18:36:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=demtfmVHtDyqnaI9z220gvVNmQUcLJNhvLwW+dPX1OcXir1xzPX0F+2Hqv4UpbgRiKpstE4iBphSlpGRYGkD9fh6RrFWpOhuOXC2K3FafW3cvHOys2L/TVKHX/u66vshAnG1DQ8UCJYHBa0z2y3/vj9+x2PJYMBqUniKP+b77rae9+c9uzh2mRQz4WGlwVhMTfqzqC9/NrRiX5Jpdx02zmg/SN6gxli8qUPlR3vHacrEfOOyLvOonl/rWATMBEiNidFj5K9w+BBOoTjEcDKK0CWplLrm4IDZeHW4ERgIYpCRx8rVQsG/sccxKDammn3zHH8Xr26IWWsJwjTPakZ/vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FvMN8FbFm3AU99LwicOOtaDWR64FP4d+JzwiaAGtYvI=;
 b=LlbfIMCMLyPBKk2udbIxtrYGDJpb2gG8Fc/GfhPnSPpdlR7fi3qlStfTk6/xDmc/QFTpZP4P1bpDHB3vOARb1xLqw4RGxZibh7uu3GH2t/HvNZlYzCW3M0sS+2MemgybHuvglpFbs0svdM0mSo1XxJKs8EL6j4E/MUfa0eOGUA8SOhPdMau0ObfNTMKFjTu49OpErwFggNhxqWBhpxilZyiYB2AHz7KoiFexdmg128RSWYA701S/OtHa5vAHQAKNo6zGuND/1CwXEVQMxFuBQFA5OJ8HDFtWMmoe+/faY1AdLrwJhfdPIfCtU34zXseAkbroqoQ2WsznQ1z17toKWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB5796.namprd11.prod.outlook.com (2603:10b6:510:13b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.39; Sat, 10 Jun
 2023 01:36:54 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5%5]) with mapi id 15.20.6455.030; Sat, 10 Jun 2023
 01:36:53 +0000
Date:   Fri, 9 Jun 2023 18:36:48 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Terry Bowman <terry.bowman@amd.com>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        <bwidawsk@kernel.org>, <dan.j.williams@intel.com>,
        <dave.jiang@intel.com>, <Jonathan.Cameron@huawei.com>,
        <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: RE: [PATCH v5 11/26] cxl/pci: Early setup RCH dport component
 registers from RCRB
Message-ID: <6483d3b06bef6_e067a294ea@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230607221651.2454764-1-terry.bowman@amd.com>
 <20230607221651.2454764-12-terry.bowman@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230607221651.2454764-12-terry.bowman@amd.com>
X-ClientProxiedBy: MW4PR03CA0175.namprd03.prod.outlook.com
 (2603:10b6:303:8d::30) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB5796:EE_
X-MS-Office365-Filtering-Correlation-Id: 9107af96-caae-4396-a5fb-08db69532b52
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GUJsTHhek02zKnrLR+QZNzgB0qLTCet2oX2ArtD5aYZdzwsB9LCsPfSd0Fwzu2orLiufR5iU4e+jp60DRxHIBJypvZyz+AUmiA70yCGGPm2hPyCdBmjtQbCDh1DTu2oXNz1RBys0x1EgjSE9m/eCGrk7QEltpI38dxZA8RuGFNXgX07Sxa76cWxKe/7lrbF0wJ9qwvIb9+f9gAHjsz1tb5yn4ISzNgzKWO1dCTr3LROe2BXF4aRuq9+EOETAM9+gUi7Qmm7M2dSHglalfHRigm9TUhoYn6ppXZizccpKprj+vLKIKNNy6QOnlLw3g/moGNtPs0xKdCyxZLuSP4wC0jo+ec41kxKYsK9+BVO3m/uaedtxb1kdLTrKfAipTz8plvNWtfQ80zGN0jKz6agk6mioj4nmhJ+/vjk7PfaIOGzFVQh8jeyjJUjmTpQNHsrJuDqExVNgk4qEq/UsgL3WP0t5j0TKsomR8K0IXoC23LScmvo//cjxA1swqrW4ZBRR9MKIiZ9Dl3Ix+j6osGiIHlPb2OpgQmZmLWTIw+qgHUXkf/53s07dc6eL4fnWSMKO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(39860400002)(376002)(136003)(396003)(451199021)(316002)(6486002)(41300700001)(83380400001)(186003)(86362001)(9686003)(6506007)(6512007)(26005)(2906002)(82960400001)(38100700002)(5660300002)(8936002)(8676002)(66476007)(66946007)(66556008)(4326008)(478600001)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NJIr365izWxErZniwHdE2ZGGlZXjY8nXdEAqytpQmGouYGIUFRRpLCfpLDqx?=
 =?us-ascii?Q?PkJ72Tn0JtTwB9iH+cwzZIepORcUwfgEEmae9HgDKjWsRQWw34m42ELnMcFE?=
 =?us-ascii?Q?m8nMnp/ef7BtyKnd5oXTWBn2kQos62chmFQk+9NbkroTUD/aFSCkVIFSoqej?=
 =?us-ascii?Q?ip4ZPpIWsr/8voctoRlXuCmHAsraqY+RQjCiJzqf7HOtO0V3YppWHRQVzm7x?=
 =?us-ascii?Q?QUwtpBQf5yzesu6DgM2nuVzWLTQDKtsnCZjv8jxcvpeGfXgC2DlX6cyGO4L7?=
 =?us-ascii?Q?C1nJExmUflEmeSFAR/q2gvqU4V0LiYfzyrMY59tXKQ41W+VqQtRnUUGdiduU?=
 =?us-ascii?Q?t+wlR4b9qo7pVFT4pxPCCzm46hQ27dpy0c3GGw+s8IQSbl/6ZysfaZndJOuv?=
 =?us-ascii?Q?QA5D/YSEJ3JastkqaGHWn5SfD9AlOFLBklOvZlfuWi8b4sCOikXMDMUdm1GH?=
 =?us-ascii?Q?SPTyKvXettOeJDe4gsddCOcMKFL/FAVlP0r5x8HDLBGb+QoxQXGOR6xEfOEK?=
 =?us-ascii?Q?4t30dD4HwcqYNdyf9oPhjHomlc/h0QGv8e5JkBbMJlc2vBJiHy2ap15VPXB3?=
 =?us-ascii?Q?n05dRFcVrDzWTMpSKXGR0ovV7mJS7Xh00Ppd0j6jLGw/ChEiDg8f8IWWBzr0?=
 =?us-ascii?Q?kIib6c0fDpFFNWaDPc9h7eD+XDJPvhkNKSX4QWr9nYUtSMCsLN9V/ieEjR7p?=
 =?us-ascii?Q?wsqnhPTKbOXefC3Gj5+Tq1mBoTjpUv+TStRzXc+LnBvwFdsEfjhbnmd8RCty?=
 =?us-ascii?Q?bVMwqLBoXqD0rTYAMTD0Nc6jdckST1ZhNjRKJZPzXusc82T5gSmcie2fcrqE?=
 =?us-ascii?Q?OLRKhgR8vBDhOlF/xPWRmfGVzlSKT00kpWoHk1n4yvcmD5KLhwYtKtu6nzwF?=
 =?us-ascii?Q?+axatpZI9+3+7cMpydQHoVrGkdPoEdiX5xvosEUJPjpUch0+41k+/xBspAj6?=
 =?us-ascii?Q?ZxOpy3N7z/78M785G47E0Ifb1nflTGs3OFEUSr7LWmgaRsetS/yoKbKFb9gA?=
 =?us-ascii?Q?vYGRnHIue+jbVCGWImj+/4YY8P57iwDEITfis1FzLl8JW2Fu1hGc4FQBtJmz?=
 =?us-ascii?Q?EPjVtUTtWqundnKC7ZAPldIfFgFnSrivF+0I4Q3Q9hvJEAy+j+yOV7jGw791?=
 =?us-ascii?Q?nhtjRYF+WVRJzHV/8vacDzyy49T3avKVbNko7vyfMmWIhXpElu+nEZ5VFrhs?=
 =?us-ascii?Q?z04wtkNFv9BZrfrAMeSgUGQqN9SiyjbCSAl6MWSJcIgZwehmeghozSAC7Y+j?=
 =?us-ascii?Q?9vWewnZgtKeq3uHyw+wIlkWba1TzsXa3pa2PkmDyHfW3N+cdyj4C0Jc1FW8N?=
 =?us-ascii?Q?XGHnrXoFy/VZ7hg3b3zl75JnblNyhPeSljnWpHy294qZD982QIsqjlEjZ9/G?=
 =?us-ascii?Q?D1evmqttWxVIOrNQzV1bNXpkhp62ryv+s3Vzvmn80m7PIV6IIpdxivIgypLQ?=
 =?us-ascii?Q?UW75BfcOmHh+Tx3vpvg0JZxgWA5DU6eBIX/pQzsBQIsql8wBZtnif89YuzM9?=
 =?us-ascii?Q?iGEfqyzMUx+tHaH5fYVqBNnKWtEIL/lbyqZFjgayV30Jq309G88tgv19FnYQ?=
 =?us-ascii?Q?YTVKYeRnGbgtaE6zjnqiQ+AfSYRcMIhkuwWcjeEzTjzFrP3AZwpNNC6dHUAh?=
 =?us-ascii?Q?yg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9107af96-caae-4396-a5fb-08db69532b52
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2023 01:36:53.5807
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z0QE2XKXkFwRZCg7OTJcL1Dp33mD9158UKoNFaj5J7SvM23nqQf7b+6YN/TD3QPrN0P6NpsunuMUxFEkYt0FGAGjT1bhWkrY1QT8mjuvGeU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5796
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

Terry Bowman wrote:
> From: Robert Richter <rrichter@amd.com>
> 
> CXL RAS capabilities must be enabled and accessible as soon as the CXL
> endpoint is detected in the PCI hierarchy and bound to the cxl_pci
> driver. This needs to be independent of other modules such as cxl_port
> or cxl_mem.
> 
> CXL RAS capabilities reside in the Component Registers. For an RCH
> this is determined by probing RCRB which is implemented very late once
> the CXL Memory Device is created.
> 
> Change this by moving the RCRB probe to the cxl_pci driver. Do this by
> using a new introduced function cxl_pci_find_port() similar to
> cxl_mem_find_port() to determine the involved dport by the endpoint's
> PCI handle. Plug this into the existing cxl_pci_setup_regs() function
> to setup Component Registers. Probe the RCRB in case the Component
> Registers cannot be located through the CXL Register Locator
> capability.
> 
> This unifies code and early sets up the Component Registers at the
> same time for both, VH and RCH mode. Only the cxl_pci driver is
> involved for this. This allows an early mapping of the CXL RAS
> capability registers.

This is problematic because it creates an implicit dependency between
cxl_acpi and cxl_pci. More comments below:

> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/cxl/core/port.c |  7 +++++++
>  drivers/cxl/cxl.h       |  2 ++
>  drivers/cxl/mem.c       | 10 ----------
>  drivers/cxl/pci.c       | 37 ++++++++++++++++++++++++++++++++++++-
>  4 files changed, 45 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 82de858506c7..8b688ac506ca 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -1476,6 +1476,13 @@ int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
>  }
>  EXPORT_SYMBOL_NS_GPL(devm_cxl_enumerate_ports, CXL);
>  
> +struct cxl_port *cxl_pci_find_port(struct pci_dev *pdev,
> +				   struct cxl_dport **dport)
> +{
> +	return find_cxl_port(pdev->dev.parent, dport);
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_pci_find_port, CXL);
> +
>  struct cxl_port *cxl_mem_find_port(struct cxl_memdev *cxlmd,
>  				   struct cxl_dport **dport)
>  {
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 1c6fe53e9dc7..e5ae5f4e6669 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -670,6 +670,8 @@ struct cxl_port *find_cxl_root(struct cxl_port *port);
>  int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd);
>  void cxl_bus_rescan(void);
>  void cxl_bus_drain(void);
> +struct cxl_port *cxl_pci_find_port(struct pci_dev *pdev,
> +				   struct cxl_dport **dport);
>  struct cxl_port *cxl_mem_find_port(struct cxl_memdev *cxlmd,
>  				   struct cxl_dport **dport);
>  bool schedule_cxl_memdev_detach(struct cxl_memdev *cxlmd);
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index a34d6560c25c..0643852444f3 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -65,16 +65,6 @@ static int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,
>  		ep->next = down;
>  	}
>  
> -	/*
> -	 * The component registers for an RCD might come from the
> -	 * host-bridge RCRB if they are not already mapped via the
> -	 * typical register locator mechanism.
> -	 */
> -	if (parent_dport->rch && cxlds->component_reg_phys == CXL_RESOURCE_NONE)
> -		cxlds->component_reg_phys =
> -			cxl_probe_rcrb(&cxlmd->dev, parent_dport->rcrb.base,
> -				       NULL, CXL_RCRB_UPSTREAM);
> -
>  	endpoint = devm_cxl_add_port(host, &cxlmd->dev,
>  				     cxlds->component_reg_phys,
>  				     parent_dport);
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 945ca0304d68..2975b232fcd1 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -274,13 +274,48 @@ static int cxl_pci_setup_mailbox(struct cxl_dev_state *cxlds)
>  	return 0;
>  }
>  
> +/* Extract RCRB, use same function interface as cxl_find_regblock(). */
> +static int cxl_rcrb_get_comp_regs(struct pci_dev *pdev,
> +				  enum cxl_regloc_type type,
> +				  struct cxl_register_map *map)
> +{
> +	struct cxl_dport *dport;
> +	resource_size_t component_reg_phys;
> +
> +	memset(map, 0, sizeof(*map));
> +	map->dev = &pdev->dev;
> +	map->resource = CXL_RESOURCE_NONE;
> +
> +	if (type != CXL_REGLOC_RBI_COMPONENT)
> +		return -ENODEV;

Why would a function called cxl_rcrb_get_comp_regs() need a type
parameter that only takes one acceptable value. I would drop the
parameter and move this distinction to the caller.

> +
> +	if (!cxl_pci_find_port(pdev, &dport) || !dport->rch)
> +		return -ENXIO;

This should return -EPROBE_DEFER in the !cxl_pci_find_port() case to try
to await cxl_acpi initialization.

> +
> +	component_reg_phys = cxl_probe_rcrb(&pdev->dev, dport->rcrb.base,
> +					    NULL, CXL_RCRB_UPSTREAM);
> +	if (component_reg_phys == CXL_RESOURCE_NONE)
> +		return -ENXIO;
> +
> +	map->resource = component_reg_phys;
> +	map->reg_type = type;
> +	map->max_size = CXL_COMPONENT_REG_BLOCK_SIZE;
> +
> +	return 0;
> +}
> +
>  static int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
>  			      struct cxl_register_map *map)
>  {
>  	int rc;
>  
> +	/*
> +	 * If the Register Locator DVSEC does not contain the
> +	 * Component Registers, assume it is an RCH and try to extract
> +	 * them from an RCRB.
> +	 */
>  	rc = cxl_find_regblock(pdev, type, map);
> -	if (rc)
> +	if (rc && cxl_rcrb_get_comp_regs(pdev, type, map))
>  		return rc;

I am not a big fan of just assuming this is an RCD, especially when
there is the is_cxl_restricted() helper just beneath this.
