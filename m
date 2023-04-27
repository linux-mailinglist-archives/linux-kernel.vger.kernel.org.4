Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 977BD6F06E1
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 15:52:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243417AbjD0Nwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 09:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243218AbjD0Nw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 09:52:28 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2085.outbound.protection.outlook.com [40.107.92.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84C543C1E;
        Thu, 27 Apr 2023 06:52:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GfUnzI4N/6xMMe74YWCEoz0LFyPrMYghE8E+EF6GAo0TCw3bCu/rqWja+u/5yd/FIReOrcx01Pm6GnQBtpSjTDMFH6t1LNq3wjWfUYF3tWS/Yg9fSUfe0BT0VHluTgmLuBVd+a+qA7DrElEqt+mmB7xJbp29p1f8TU2vQt1bbxRBjm4ibO8orG8TyU8/sLcyAHXbzijkUN0OZFy3XrzjCm/z0sa8Bih+HXICULhTpQFSCWUtmlPuzWqhDsr3Tt9A9GO8wvhB7V3aPETATQ2GW73DqJZHFemGma8HSSwgyi4/xYk7XVmRmBiGlZelCruRH4htBcLRI05sNYGEUA3bIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cM3ROL/OoPRJwMfOLPjsCqhMihmmfuYUoYrdDPaK6BI=;
 b=lhoCOv83rl6+tqZEXzMpOoy8Br0lpm4h9yy0q3fQMQNiD28cPxOxnI2z3g/8HyRA5yXGwx1zKzpnQEKJWCmvs8J3W9v45DuPkOD83j+7VapZ1wYIa6mTlEv+jqjdI9+cOdifCS0gBjlHB8E+wx0IL1M3okvXWUvhTpXOv5GHvw2hVlrdri0Mj9ILN02vXefR6lH7notSx/6zCIRi3Ls/pnmDPrz23qC3KMP+xjK6btHASWkaxouqUHsyN1CUoNQ+PhIRu6K9/m2i2uBxF7mbCzath86m9nKKVT5XNWn6L99OFCCju1jFrKIA7C3QPjY8i9N0P4b22Zron2GSMbB/3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cM3ROL/OoPRJwMfOLPjsCqhMihmmfuYUoYrdDPaK6BI=;
 b=cdTPuIA0Khro5+ySWmMHBj+3/PCOnVixBbiB+ZY94WvxFB6wuJMTGutClUHaaUhi4hZNct6ag8wOeQp1Up3OC1Gb1h6/Ojt+/MwZKgRxhp7rRJqGBETTvyzvU/gRekJ3xX3VBFRdQG5RV2x8mizWzj0QIC34cAcmS945AAGRMRM=
Received: from BN8PR15CA0066.namprd15.prod.outlook.com (2603:10b6:408:80::43)
 by CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.22; Thu, 27 Apr
 2023 13:52:19 +0000
Received: from BN8NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:80:cafe::ad) by BN8PR15CA0066.outlook.office365.com
 (2603:10b6:408:80::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.22 via Frontend
 Transport; Thu, 27 Apr 2023 13:52:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT067.mail.protection.outlook.com (10.13.177.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6340.22 via Frontend Transport; Thu, 27 Apr 2023 13:52:19 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 27 Apr
 2023 08:52:16 -0500
Date:   Thu, 27 Apr 2023 15:52:13 +0200
From:   Robert Richter <rrichter@amd.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     Terry Bowman <terry.bowman@amd.com>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        <bwidawsk@kernel.org>, <dave.jiang@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: Re: [PATCH v3 1/6] cxl/pci: Add RCH downstream port AER and RAS
 register discovery
Message-ID: <ZEp+DcHrHS+06RE0@rric.localdomain>
References: <20230411180302.2678736-1-terry.bowman@amd.com>
 <20230411180302.2678736-2-terry.bowman@amd.com>
 <643dcf9eed443_1b66294b5@dwillia2-xfh.jf.intel.com.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <643dcf9eed443_1b66294b5@dwillia2-xfh.jf.intel.com.notmuch>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT067:EE_|CY5PR12MB6369:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bf05a9a-252d-4d15-108e-08db47269e5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IV9w9QT1k2f6wJLXVILFP0txf63IDxWEm3UG+N66V8CUT1a8IXV5ksslnNF+3h3E3g9uF8ofwKXj28g9up2YkKFxj8vi7rEfcgCNN9Ry7kY681QZmEj8LMEZDeZ7eWv4ori4/aFsN68I2CKxvEdUuGq2P8wJAstY76O0OIcmsw9FWtZVgyVyWYgeGrjCZG6FWHsg7XHtFcE7AJxUAU1PBzzcx4/+d/s+Mum9GjzXMLK2FbqNSrHFRFMFCIYGpIpsAlNc7KaHQ3NzQbzuDld9fBaxuxutshFr9vgs9mYCdoWXAbTxS7ybbXGP//e2AFib1K+N2urd1bF2kHYqcAf0afVu7kbdyErnhwttG3HrY3wNHmINmvo1cmnNvN9PBgNWziJc+6UnQqX//XU8+lqjNJbBjaScc6tXcdwuVYU6y6XQn/eZhpum7Z4LHZffdsE36/X7KP+vL149uWbOOxUKOgmNr7o0NwXM+BKBza+BHiWdaljqYOdVF62tT8QwQDp9DLUli8jt5YgkAjbwsVcImb/8SWGdNu57LwSEZUIEOFXPlWb7o0k/M4nlilEDHz4rfDT4ONo4mkstBxcX89xA6b3ponLVQQcTu0/JRWHR6GKVnYOzF7HWFNVDRg0C/3Kl0EIzGpinlcWr2qrHM7TqucyR1r4+W/rjPyYI9ahPT0A8xB+Tbmj5TR9Dp5bzgAhSJzv3omu9W2plh+auXR71kz0Fe/yMt0x1RezzjvC3peI=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(396003)(346002)(376002)(451199021)(46966006)(40470700004)(36840700001)(36860700001)(426003)(336012)(47076005)(83380400001)(478600001)(7696005)(6666004)(54906003)(26005)(186003)(16526019)(53546011)(9686003)(7416002)(30864003)(2906002)(40460700003)(5660300002)(70206006)(70586007)(81166007)(6916009)(82740400003)(4326008)(356005)(82310400005)(41300700001)(8676002)(8936002)(55016003)(40480700001)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2023 13:52:19.3685
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bf05a9a-252d-4d15-108e-08db47269e5b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6369
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

see comment to your patch below.

On 17.04.23 16:00:47, Dan Williams wrote:
> Terry Bowman wrote:

> > +	/*
> > +	 * The component registers for an RCD might come from the
> > +	 * host-bridge RCRB if they are not already mapped via the
> > +	 * typical register locator mechanism.
> > +	 */
> > +	if (cxlds->component_reg_phys == CXL_RESOURCE_NONE)
> > +		cxlds->component_reg_phys = cxl_rcrb_to_component(
> > +			&cxlmd->dev, parent_dport->rcrb, CXL_RCRB_UPSTREAM);
> > +
> > +	parent_dport->aer_cap = cxl_rcrb_to_aer(parent_dport->dport,
> > +						parent_dport->rcrb);
> 
> Hmm, how about just retrieve this as part of cxl_rcrb_to_component()
> (renamed to cxl_probe_rcrb()), and make an rch dport its own distinct
> object? Otherwise it feels odd to be retrieving downstream port
> properties this late at upstream port component register detection time.
> It also feels awkward to keep adding more RCH dport specific details to
> the common 'struct cxl_dport'. So, I'm thinking something like the
> following (compiled and cxl_test regression passed):
> 
> -- >8 --
> From 18fbc72f98655d10301c7a35f614b6152f46c44b Mon Sep 17 00:00:00 2001
> From: Dan Williams <dan.j.williams@intel.com>
> Date: Mon, 17 Apr 2023 15:45:50 -0700
> Subject: [PATCH] cxl/rch: Prepare for caching the MMIO mapped PCIe AER
>  capability
> 
> Prepare cxl_probe_rcrb() for retrieving more than just the component
> register block. The RCH AER handling code wants to get back to the AER
> capability that happens to be MMIO mapped rather then configuration
> cycles.
> 
> Move rcrb specific dport data, like the RCRB base and the AER capability
> offset, into its own data structure ('struct cxl_rcrb_info') for
> cxl_probe_rcrb() to fill.  Introduce 'struct cxl_rch_dport' to wrap a
> 'struct cxl_dport' with a 'struct cxl_rcrb_info' attribute.
> 
> This centralizes all RCRB scanning in one routine.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/cxl/acpi.c            | 16 ++++++++--------
>  drivers/cxl/core/port.c       | 33 +++++++++++++++++++++------------
>  drivers/cxl/core/regs.c       | 12 ++++++++----
>  drivers/cxl/cxl.h             | 21 +++++++++++++++------
>  drivers/cxl/mem.c             | 15 ++++++++++-----
>  tools/testing/cxl/Kbuild      |  2 +-
>  tools/testing/cxl/test/cxl.c  | 10 ++++++----
>  tools/testing/cxl/test/mock.c | 12 ++++++------
>  tools/testing/cxl/test/mock.h |  7 ++++---
>  9 files changed, 79 insertions(+), 49 deletions(-)
> 
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index 4e66483f1fd3..2647eb04fcdb 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -375,7 +375,7 @@ static int add_host_bridge_uport(struct device *match, void *arg)
>  struct cxl_chbs_context {
>  	struct device *dev;
>  	unsigned long long uid;
> -	resource_size_t rcrb;
> +	struct cxl_rcrb_info rcrb;
>  	resource_size_t chbcr;
>  	u32 cxl_version;
>  };
> @@ -395,7 +395,7 @@ static int cxl_get_chbcr(union acpi_subtable_headers *header, void *arg,
>  		return 0;
>  
>  	ctx->cxl_version = chbs->cxl_version;
> -	ctx->rcrb = CXL_RESOURCE_NONE;
> +	ctx->rcrb.base = CXL_RESOURCE_NONE;
>  	ctx->chbcr = CXL_RESOURCE_NONE;
>  
>  	if (!chbs->base)
> @@ -409,9 +409,8 @@ static int cxl_get_chbcr(union acpi_subtable_headers *header, void *arg,
>  	if (chbs->length != CXL_RCRB_SIZE)
>  		return 0;
>  
> -	ctx->rcrb = chbs->base;
> -	ctx->chbcr = cxl_rcrb_to_component(ctx->dev, chbs->base,
> -					   CXL_RCRB_DOWNSTREAM);
> +	ctx->chbcr = cxl_probe_rcrb(ctx->dev, chbs->base, &ctx->rcrb,
> +				    CXL_RCRB_DOWNSTREAM);

Let's just extract the rcrb base here and do the probe later in
__devm_cxl_add_dport(). Which means chbcr will be extracted there and
we completely remove the cxl_rcrb_to_component() here. The code here
becomes much simpler and the ACPI table parser no longer contains mmio
mapping calls etc.

>  
>  	return 0;
>  }
> @@ -451,8 +450,9 @@ static int add_host_bridge_dport(struct device *match, void *arg)
>  		return 0;
>  	}
>  
> -	if (ctx.rcrb != CXL_RESOURCE_NONE)
> -		dev_dbg(match, "RCRB found for UID %lld: %pa\n", uid, &ctx.rcrb);
> +	if (ctx.rcrb.base != CXL_RESOURCE_NONE)
> +		dev_dbg(match, "RCRB found for UID %lld: %pa\n", uid,
> +			&ctx.rcrb.base);
>  
>  	if (ctx.chbcr == CXL_RESOURCE_NONE) {
>  		dev_warn(match, "CHBCR invalid for Host Bridge (UID %lld)\n",
> @@ -466,7 +466,7 @@ static int add_host_bridge_dport(struct device *match, void *arg)
>  	bridge = pci_root->bus->bridge;
>  	if (ctx.cxl_version == ACPI_CEDT_CHBS_VERSION_CXL11)
>  		dport = devm_cxl_add_rch_dport(root_port, bridge, uid,
> -					       ctx.chbcr, ctx.rcrb);
> +					       ctx.chbcr, &ctx.rcrb);
>  	else
>  		dport = devm_cxl_add_dport(root_port, bridge, uid,
>  					   ctx.chbcr);
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 4003f445320c..d194f48259ff 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -920,7 +920,7 @@ static void cxl_dport_unlink(void *data)
>  static struct cxl_dport *
>  __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
>  		     int port_id, resource_size_t component_reg_phys,
> -		     resource_size_t rcrb)
> +		     struct cxl_rcrb_info *ri)
>  {
>  	char link_name[CXL_TARGET_STRLEN];
>  	struct cxl_dport *dport;
> @@ -942,17 +942,26 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
>  	    CXL_TARGET_STRLEN)
>  		return ERR_PTR(-EINVAL);
>  
> -	dport = devm_kzalloc(host, sizeof(*dport), GFP_KERNEL);
> -	if (!dport)
> -		return ERR_PTR(-ENOMEM);
> +	if (ri && ri->base != CXL_RESOURCE_NONE) {
> +		struct cxl_rch_dport *rdport;
> +
> +		rdport = devm_kzalloc(host, sizeof(*rdport), GFP_KERNEL);
> +		if (!rdport)
> +			return ERR_PTR(-ENOMEM);
> +
> +		rdport->rcrb.base = ri->base;
> +		dport = &rdport->dport;
> +		dport->rch = true;
> +	} else {
> +		dport = devm_kzalloc(host, sizeof(*dport), GFP_KERNEL);
> +		if (!dport)
> +			return ERR_PTR(-ENOMEM);

I think we can simlify the allocation part if we just move the struct
into 'struct cxl_dport', see below.

> +	}
>  
>  	dport->dport = dport_dev;
>  	dport->port_id = port_id;
>  	dport->component_reg_phys = component_reg_phys;
>  	dport->port = port;
> -	if (rcrb != CXL_RESOURCE_NONE)
> -		dport->rch = true;
> -	dport->rcrb = rcrb;
>  
>  	cond_cxl_root_lock(port);
>  	rc = add_dport(port, dport);
> @@ -994,7 +1003,7 @@ struct cxl_dport *devm_cxl_add_dport(struct cxl_port *port,
>  	struct cxl_dport *dport;
>  
>  	dport = __devm_cxl_add_dport(port, dport_dev, port_id,
> -				     component_reg_phys, CXL_RESOURCE_NONE);
> +				     component_reg_phys, NULL);
>  	if (IS_ERR(dport)) {
>  		dev_dbg(dport_dev, "failed to add dport to %s: %ld\n",
>  			dev_name(&port->dev), PTR_ERR(dport));
> @@ -1013,24 +1022,24 @@ EXPORT_SYMBOL_NS_GPL(devm_cxl_add_dport, CXL);
>   * @dport_dev: firmware or PCI device representing the dport
>   * @port_id: identifier for this dport in a decoder's target list
>   * @component_reg_phys: optional location of CXL component registers
> - * @rcrb: mandatory location of a Root Complex Register Block
> + * @ri: mandatory data about the Root Complex Register Block layout
>   *
>   * See CXL 3.0 9.11.8 CXL Devices Attached to an RCH
>   */
>  struct cxl_dport *devm_cxl_add_rch_dport(struct cxl_port *port,
>  					 struct device *dport_dev, int port_id,
>  					 resource_size_t component_reg_phys,
> -					 resource_size_t rcrb)
> +					 struct cxl_rcrb_info *ri)
>  {
>  	struct cxl_dport *dport;
>  
> -	if (rcrb == CXL_RESOURCE_NONE) {
> +	if (!ri || ri->base == CXL_RESOURCE_NONE) {
>  		dev_dbg(&port->dev, "failed to add RCH dport, missing RCRB\n");
>  		return ERR_PTR(-EINVAL);
>  	}
>  
>  	dport = __devm_cxl_add_dport(port, dport_dev, port_id,
> -				     component_reg_phys, rcrb);
> +				     component_reg_phys, ri);
>  	if (IS_ERR(dport)) {
>  		dev_dbg(dport_dev, "failed to add RCH dport to %s: %ld\n",
>  			dev_name(&port->dev), PTR_ERR(dport));
> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
> index 52d1dbeda527..b1c0db898a50 100644
> --- a/drivers/cxl/core/regs.c
> +++ b/drivers/cxl/core/regs.c
> @@ -332,9 +332,8 @@ int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_find_regblock, CXL);
>  
> -resource_size_t cxl_rcrb_to_component(struct device *dev,
> -				      resource_size_t rcrb,
> -				      enum cxl_rcrb which)
> +resource_size_t cxl_probe_rcrb(struct device *dev, resource_size_t rcrb,
> +			       struct cxl_rcrb_info *ri, enum cxl_rcrb which)
>  {
>  	resource_size_t component_reg_phys;
>  	void __iomem *addr;
> @@ -344,6 +343,8 @@ resource_size_t cxl_rcrb_to_component(struct device *dev,
>  
>  	if (which == CXL_RCRB_UPSTREAM)
>  		rcrb += SZ_4K;
> +	else
> +		ri->base = rcrb;

For upstream ports nothing is written to ri, allow NULL pointer for ri
then but check for NULL here.

>  
>  	/*
>  	 * RCRB's BAR[0..1] point to component block containing CXL
> @@ -364,6 +365,9 @@ resource_size_t cxl_rcrb_to_component(struct device *dev,
>  	cmd = readw(addr + PCI_COMMAND);
>  	bar0 = readl(addr + PCI_BASE_ADDRESS_0);
>  	bar1 = readl(addr + PCI_BASE_ADDRESS_1);
> +
> +	/* TODO: retrieve rcrb->aer_cap here */
> +

Yes, very good. The aer cap of the RCRB would be very early available
then and independent of of other drivers than cxl_acpi, esp. the pci
subsystem.

>  	iounmap(addr);
>  	release_mem_region(rcrb, SZ_4K);
>  
> @@ -395,4 +399,4 @@ resource_size_t cxl_rcrb_to_component(struct device *dev,
>  
>  	return component_reg_phys;
>  }
> -EXPORT_SYMBOL_NS_GPL(cxl_rcrb_to_component, CXL);
> +EXPORT_SYMBOL_NS_GPL(cxl_probe_rcrb, CXL);
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 1503ccec9a84..b0807f54e9fd 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -267,9 +267,9 @@ enum cxl_rcrb {
>  	CXL_RCRB_DOWNSTREAM,
>  	CXL_RCRB_UPSTREAM,
>  };
> -resource_size_t cxl_rcrb_to_component(struct device *dev,
> -				      resource_size_t rcrb,
> -				      enum cxl_rcrb which);
> +struct cxl_rcrb_info;
> +resource_size_t cxl_probe_rcrb(struct device *dev, resource_size_t rcrb,
> +			       struct cxl_rcrb_info *ri, enum cxl_rcrb which);
>  
>  #define CXL_RESOURCE_NONE ((resource_size_t) -1)
>  #define CXL_TARGET_STRLEN 20
> @@ -589,12 +589,12 @@ cxl_find_dport_by_dev(struct cxl_port *port, const struct device *dport_dev)
>  	return xa_load(&port->dports, (unsigned long)dport_dev);
>  }
>  
> +

We will drop that.

>  /**
>   * struct cxl_dport - CXL downstream port
>   * @dport: PCI bridge or firmware device representing the downstream link
>   * @port_id: unique hardware identifier for dport in decoder target list
>   * @component_reg_phys: downstream port component registers
> - * @rcrb: base address for the Root Complex Register Block
>   * @rch: Indicate whether this dport was enumerated in RCH or VH mode
>   * @port: reference to cxl_port that contains this downstream port
>   */
> @@ -602,11 +602,20 @@ struct cxl_dport {
>  	struct device *dport;
>  	int port_id;
>  	resource_size_t component_reg_phys;
> -	resource_size_t rcrb;
>  	bool rch;
>  	struct cxl_port *port;
>  };
>  
> +struct cxl_rcrb_info {
> +	resource_size_t base;
> +	u16 aer_cap;
> +};
> +
> +struct cxl_rch_dport {
> +	struct cxl_dport dport;
> +	struct cxl_rcrb_info rcrb;
> +};

How about including cxl_rcrb_info directly in cxl_dport? This
simplifies dport allocation and allows direct access in cxl_dport to
the cxl_rcrb_info without a container_of() call:

struct cxl_dport {
	struct device *dport;
	struct cxl_port *port;
	int port_id;
	resource_size_t component_reg_phys;
	bool rch;
	struct cxl_rcrb_info rcrb;
};

I know you were complaining about to many RCH dport specific details,
but all this is kept in cxl_rcrb_info and the struct itself is not too
big. The flat structure allows quick access, like:

	if (dport->rch)
		component_reg_phys = cxl_probe_rcrb(..., dport->rcrb.base, ...)

> +
>  /**
>   * struct cxl_ep - track an endpoint's interest in a port
>   * @ep: device that hosts a generic CXL endpoint (expander or accelerator)
> @@ -674,7 +683,7 @@ struct cxl_dport *devm_cxl_add_dport(struct cxl_port *port,
>  struct cxl_dport *devm_cxl_add_rch_dport(struct cxl_port *port,
>  					 struct device *dport_dev, int port_id,
>  					 resource_size_t component_reg_phys,
> -					 resource_size_t rcrb);
> +					 struct cxl_rcrb_info *ri);
>  
>  struct cxl_decoder *to_cxl_decoder(struct device *dev);
>  struct cxl_root_decoder *to_cxl_root_decoder(struct device *dev);
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index 097d86dd2a8e..7da6135e0b17 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -71,10 +71,15 @@ static int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,
>  	 * host-bridge RCRB if they are not already mapped via the
>  	 * typical register locator mechanism.
>  	 */
> -	if (parent_dport->rch && cxlds->component_reg_phys == CXL_RESOURCE_NONE)
> -		component_reg_phys = cxl_rcrb_to_component(
> -			&cxlmd->dev, parent_dport->rcrb, CXL_RCRB_UPSTREAM);
> -	else
> +	if (parent_dport->rch &&
> +	    cxlds->component_reg_phys == CXL_RESOURCE_NONE) {
> +		struct cxl_rch_dport *rdport =
> +			container_of(parent_dport, typeof(*rdport), dport);
> +
> +		component_reg_phys =
> +			cxl_probe_rcrb(&cxlmd->dev, rdport->rcrb.base,
> +				       &rdport->rcrb, CXL_RCRB_UPSTREAM);

This could overwrite the dport's contents with the upstream port info.
But since we only need the info and write to it in case of a
downstream port, let's set that to null here (plus adding a check in
cxl_probe_rcrb()).

Similar to the host case (cxl_acpi driver) where the rcrb is probed
early, this code should be moved to cxl_pci. But since RAS does not
use the upstream port's RCRB it is subject of a separate patch not
part of this series.

> +	} else
>  		component_reg_phys = cxlds->component_reg_phys;
>  	endpoint = devm_cxl_add_port(host, &cxlmd->dev, component_reg_phys,
>  				     parent_dport);
> @@ -92,7 +97,7 @@ static int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,
>  	}
>  
>  	return 0;
> -}
> +	}

Dropping that change.

>  
>  static int cxl_mem_probe(struct device *dev)
>  {
> diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
> index fba7bec96acd..bef1bc3bd912 100644
> --- a/tools/testing/cxl/Kbuild
> +++ b/tools/testing/cxl/Kbuild
> @@ -11,7 +11,7 @@ ldflags-y += --wrap=devm_cxl_enumerate_decoders
>  ldflags-y += --wrap=cxl_await_media_ready
>  ldflags-y += --wrap=cxl_hdm_decode_init
>  ldflags-y += --wrap=cxl_dvsec_rr_decode
> -ldflags-y += --wrap=cxl_rcrb_to_component
> +ldflags-y += --wrap=cxl_probe_rcrb
>  
>  DRIVERS := ../../../drivers
>  CXL_SRC := $(DRIVERS)/cxl
> diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> index 385cdeeab22c..805c79491485 100644
> --- a/tools/testing/cxl/test/cxl.c
> +++ b/tools/testing/cxl/test/cxl.c
> @@ -983,12 +983,14 @@ static int mock_cxl_port_enumerate_dports(struct cxl_port *port)
>  	return 0;
>  }
>  
> -resource_size_t mock_cxl_rcrb_to_component(struct device *dev,
> -					   resource_size_t rcrb,
> -					   enum cxl_rcrb which)
> +resource_size_t mock_cxl_probe_rcrb(struct device *dev, resource_size_t rcrb,
> +				    struct cxl_rcrb_info *ri, enum cxl_rcrb which)
>  {
>  	dev_dbg(dev, "rcrb: %pa which: %d\n", &rcrb, which);
>  
> +	if (which == CXL_RCRB_DOWNSTREAM)
> +		ri->base = rcrb;
> +
>  	return (resource_size_t) which + 1;
>  }
>  
> @@ -1000,7 +1002,7 @@ static struct cxl_mock_ops cxl_mock_ops = {
>  	.is_mock_dev = is_mock_dev,
>  	.acpi_table_parse_cedt = mock_acpi_table_parse_cedt,
>  	.acpi_evaluate_integer = mock_acpi_evaluate_integer,
> -	.cxl_rcrb_to_component = mock_cxl_rcrb_to_component,
> +	.cxl_probe_rcrb = mock_cxl_probe_rcrb,
>  	.acpi_pci_find_root = mock_acpi_pci_find_root,
>  	.devm_cxl_port_enumerate_dports = mock_cxl_port_enumerate_dports,
>  	.devm_cxl_setup_hdm = mock_cxl_setup_hdm,
> diff --git a/tools/testing/cxl/test/mock.c b/tools/testing/cxl/test/mock.c
> index c4e53f22e421..148bd4f184f5 100644
> --- a/tools/testing/cxl/test/mock.c
> +++ b/tools/testing/cxl/test/mock.c
> @@ -244,9 +244,9 @@ int __wrap_cxl_dvsec_rr_decode(struct device *dev, int dvsec,
>  }
>  EXPORT_SYMBOL_NS_GPL(__wrap_cxl_dvsec_rr_decode, CXL);
>  
> -resource_size_t __wrap_cxl_rcrb_to_component(struct device *dev,
> -					     resource_size_t rcrb,
> -					     enum cxl_rcrb which)
> +resource_size_t __wrap_cxl_probe_rcrb(struct device *dev, resource_size_t rcrb,
> +				      struct cxl_rcrb_info *ri,
> +				      enum cxl_rcrb which)
>  {
>  	int index;
>  	resource_size_t component_reg_phys;
> @@ -254,14 +254,14 @@ resource_size_t __wrap_cxl_rcrb_to_component(struct device *dev,
>  
>  	if (ops && ops->is_mock_port(dev))
>  		component_reg_phys =
> -			ops->cxl_rcrb_to_component(dev, rcrb, which);
> +			ops->cxl_probe_rcrb(dev, rcrb, ri, which);
>  	else
> -		component_reg_phys = cxl_rcrb_to_component(dev, rcrb, which);
> +		component_reg_phys = cxl_probe_rcrb(dev, rcrb, ri, which);
>  	put_cxl_mock_ops(index);
>  
>  	return component_reg_phys;
>  }
> -EXPORT_SYMBOL_NS_GPL(__wrap_cxl_rcrb_to_component, CXL);
> +EXPORT_SYMBOL_NS_GPL(__wrap_cxl_probe_rcrb, CXL);
>  
>  MODULE_LICENSE("GPL v2");
>  MODULE_IMPORT_NS(ACPI);
> diff --git a/tools/testing/cxl/test/mock.h b/tools/testing/cxl/test/mock.h
> index bef8817b01f2..7ef21356d052 100644
> --- a/tools/testing/cxl/test/mock.h
> +++ b/tools/testing/cxl/test/mock.h
> @@ -15,9 +15,10 @@ struct cxl_mock_ops {
>  					     acpi_string pathname,
>  					     struct acpi_object_list *arguments,
>  					     unsigned long long *data);
> -	resource_size_t (*cxl_rcrb_to_component)(struct device *dev,
> -						 resource_size_t rcrb,
> -						 enum cxl_rcrb which);
> +	resource_size_t (*cxl_probe_rcrb)(struct device *dev,
> +					  resource_size_t rcrb,
> +					  struct cxl_rcrb_info *ri,
> +					  enum cxl_rcrb which);
>  	struct acpi_pci_root *(*acpi_pci_find_root)(acpi_handle handle);
>  	bool (*is_mock_bus)(struct pci_bus *bus);
>  	bool (*is_mock_port)(struct device *dev);
> -- 
> 2.39.2
> -- >8 --
> 
> 
> > +
> > +	parent_dport->ras_cap = cxl_component_to_ras(parent_dport->dport,
> > +						     parent_dport->component_reg_phys);
> 
> Since this is component register offset based can it not be shared with
> the VH case? I have been expecting that RCH RAS capability and VH RAS
> capability scanning would need to be unified in the cxl_port driver.

I have a modified version of your patch with following changes:

 * cxl_probe_rcrb():

   * Moved cxl_probe_rcrb() out of ACPI CEDT parse to
     __devm_cxl_add_dport() (separate patch).

   * Set cxl_rcrb_info pointer to NULL for upstream ports including
     NULL pointer check.

 * Integrated 'struct cxl_rcrb_info' in 'struct cxl_dport'.

 * Adressed comments above.

 * Dropped unrelated newlines and whitespaces.

We will include the patches in v4.

Thanks,

-Robert
