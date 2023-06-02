Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DE127204E9
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 16:53:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235965AbjFBOxb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 10:53:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbjFBOxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 10:53:30 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2087.outbound.protection.outlook.com [40.107.96.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BADAAE7;
        Fri,  2 Jun 2023 07:53:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CoGcUJn/Z9iQQMFnpp3hDj+wQel5ArmZWSJc4Yk6wzmWcy2K1iLnI/ZLdwnkh0Ca4c6dZpnPhdecCPHy8PSbvcLybYtZx0T62SWQOFsv8nlq/oryK78GPtzb0yZpbBZFfpHWoFwXrpBVP2hwy14yTfjoN9V+Gvwezxvxmp9ozUwV5bHr7KJXprIRCUdgYfvrf564MBgbqSerG+/ZaQJwH0ovSnOgdmM2mO4gtuvuSqUDem0xRQnHLCffKqgTEQISIFdhGWZrScw1MdY9sUAtOiX1cJG3SdmkwpHmr8BWSWM6rxoFNo02QtxvG6fAfww8mWyp8t4D5bVcb/BX44pgDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DltpAT3RdFVNdUpx492pedzQ1cdWNt1+L/Fc7B/ZxbU=;
 b=jn/v8mp3HFi6sppmCsUMCEhiQJihwvObr8h44e8V3lHvI7YY9HLKF/dUBhOzJimbo1ZBvwDgWWFyZ2fQoFaEvAp16/wIavUlRORRCTTYlunIml3tJHYZlBjvjKkrCM7d5HoRDiepC3a8HhFj//r7Wk4O6N8k8s2vZ7EJCbuH2BD29G4FUwtwREzxo3sAdORMiKwS+3sU5t7eb2cKtub7YPOfX78vHYCptHISExsQTgxjoxpuCRzdwxIDdBRDVjZ3zGhZkgoKBLKHDNDIvROdG05Z5EQ6fpMu14uixC0g29VoY3d4TQS10qoASxQEijqmGgKDJGJDRkJCTbbn1ZoBQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=huawei.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DltpAT3RdFVNdUpx492pedzQ1cdWNt1+L/Fc7B/ZxbU=;
 b=WM4O6QIlp+7LEzdKHgqQLL+zccJ1AHg0DHZmyPRH+jWqGjvOQDMTnSby9kaPbD7QrHFEbtpxSyirC+JV1UPKfMMsL3+l4ZlSi4eDGTWT+RnUU7UDJAUQVyo66N1ZsbxECaX+Tfgtm2IJcdM6wWD75mzxBFJceeu0Rj4ULvpUESY=
Received: from MW4PR03CA0298.namprd03.prod.outlook.com (2603:10b6:303:b5::33)
 by BL1PR12MB5336.namprd12.prod.outlook.com (2603:10b6:208:314::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.24; Fri, 2 Jun
 2023 14:53:23 +0000
Received: from CO1NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b5:cafe::9f) by MW4PR03CA0298.outlook.office365.com
 (2603:10b6:303:b5::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.25 via Frontend
 Transport; Fri, 2 Jun 2023 14:53:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT031.mail.protection.outlook.com (10.13.174.118) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.26 via Frontend Transport; Fri, 2 Jun 2023 14:53:21 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 2 Jun
 2023 09:53:18 -0500
Date:   Fri, 2 Jun 2023 16:53:15 +0200
From:   Robert Richter <rrichter@amd.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC:     Terry Bowman <terry.bowman@amd.com>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        <bwidawsk@kernel.org>, <dan.j.williams@intel.com>,
        <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: Re: [PATCH v4 02/23] cxl/rch: Prepare for caching the MMIO mapped
 PCIe AER capability
Message-ID: <ZHoCW9DsUwGQVKpB@rric.localdomain>
References: <20230523232214.55282-1-terry.bowman@amd.com>
 <20230523232214.55282-3-terry.bowman@amd.com>
 <20230601113811.00006cd5@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230601113811.00006cd5@Huawei.com>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT031:EE_|BL1PR12MB5336:EE_
X-MS-Office365-Filtering-Correlation-Id: 76c587e7-a9fe-4477-db2c-08db63791c5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N60QBTkg333uZMbu4D/TSam1dkM/LfCOlMv4hJKVveQcvdg4HNIN6yMmZI37dus+8a7eB0g3t7MdS0+IDyau/ZwM5R4obY3/Dv0+eN4cthMC5YGZCLLYqQJsziffVdJtGs9WLtklSOKzUtdgZ/j8P6/pn6M/VAXXli5EY77XAudBJuWbaXBtU2gZo5b1uy0y29kmUWfanFtg/nmJ9EO2CnAZGuvTwxgPXCeHs1tF6zTuH62Azo4dZv9sguMLpEqhFvRNDC42Tfc46TAH2+uqv1DJaiOOdBdB5xkHrjucVkn6uUaxlo4GAaSd5rkziB09G/KuSfqNS4ZYc6CeXOlHqce1X6g73gs0HGYl7fma6UHrNiFK52W4yLohcMzpicZ9rNx5WU9ilw0dakCQBnu1xQXSB/wisha1plXwAqmr81ytxRlbM0lo8lZvn+jM0DIr1zoeEpWOCogEG5Hn9Hq3KEn6J2gKxzh1SWiX16v0k0qHu9w+aOj82u5NYYB376nW+5PKJv9ypVNtVEiQHHZLTrSjFxznX8upLv1ZFxtiytHd195Qcu8rX+tpuVAXL5ARJJyOGqKSqMILrnce908FV4J8yaPCL642cMnHxAqo7KDEQeN3w1M/6qzmFtLzrB3LRpCkSKvudBcWTym+P6lBNP6FJaBuOrujJn9tN4LI7LxnDOGVuhGNB+WhuNPJOzxgilFcNvsr4Pj6ckDMqzP09yGK81BPxlbEX05/REGXssRAKM9DP8yYGUjYMOUhJZuXCz5kvpbJT8g+1M6wd6urvg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(346002)(39860400002)(396003)(451199021)(40470700004)(46966006)(36840700001)(82740400003)(82310400005)(356005)(81166007)(66899021)(40460700003)(8676002)(54906003)(6916009)(70206006)(70586007)(4326008)(40480700001)(55016003)(6666004)(7696005)(478600001)(53546011)(26005)(186003)(16526019)(9686003)(316002)(7416002)(8936002)(5660300002)(36860700001)(41300700001)(47076005)(2906002)(426003)(83380400001)(336012)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2023 14:53:21.9106
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 76c587e7-a9fe-4477-db2c-08db63791c5f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5336
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.06.23 11:38:11, Jonathan Cameron wrote:
> On Tue, 23 May 2023 18:21:53 -0500
> Terry Bowman <terry.bowman@amd.com> wrote:
> 
> > From: Dan Williams <dan.j.williams@intel.com>
> > 
> > Prepare cxl_probe_rcrb() for retrieving more than just the component
> > register block. The RCH AER handling code wants to get back to the AER
> > capability that happens to be MMIO mapped rather then configuration
> > cycles.
> > 
> > Move RCRB specific downstream port data, like the RCRB base and the
> > AER capability offset, into its own data structure ('struct
> > cxl_rcrb_info') for cxl_probe_rcrb() to fill. Extend 'struct
> > cxl_dport' to include a 'struct cxl_rcrb_info' attribute.
> >
> There are several other refactors going on in here. I'd rather
> see it broken down into a few separate patches. See inline.

I didn't want to split Dan's patch here and just started with it as a
base.

>  
> > This centralizes all RCRB scanning in one routine.
> > 
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > Co-developed-by: Robert Richter <rrichter@amd.com>
> > Signed-off-by: Robert Richter <rrichter@amd.com>
> > Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> > ---
> >  drivers/cxl/core/port.c       |  7 ++++---
> >  drivers/cxl/core/regs.c       | 10 ++++++----
> >  drivers/cxl/cxl.h             | 19 ++++++++++++-------
> >  drivers/cxl/mem.c             | 16 +++++++++-------
> >  tools/testing/cxl/Kbuild      |  2 +-
> >  tools/testing/cxl/test/cxl.c  | 10 ++++++----
> >  tools/testing/cxl/test/mock.c | 12 ++++++------
> >  tools/testing/cxl/test/mock.h |  7 ++++---
> >  8 files changed, 48 insertions(+), 35 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> > index 1a3f8729a616..618865ca6a9f 100644
> > --- a/drivers/cxl/core/port.c
> > +++ b/drivers/cxl/core/port.c
> > @@ -939,8 +939,9 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
> >  		return ERR_PTR(-ENOMEM);
> >  
> >  	if (rcrb != CXL_RESOURCE_NONE) {
> > -		component_reg_phys = cxl_rcrb_to_component(dport_dev,
> > -						rcrb, CXL_RCRB_DOWNSTREAM);
> > +		component_reg_phys =
> > +			cxl_probe_rcrb(dport_dev, rcrb, &dport->rcrb,
> > +				       CXL_RCRB_DOWNSTREAM);
> >  		if (component_reg_phys == CXL_RESOURCE_NONE) {
> >  			dev_warn(dport_dev, "Invalid Component Registers in RCRB");
> >  			return ERR_PTR(-ENXIO);
> > @@ -957,7 +958,7 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
> >  	dport->port_id = port_id;
> >  	dport->component_reg_phys = component_reg_phys;
> >  	dport->port = port;
> > -	dport->rcrb = rcrb;
> > +	dport->rcrb.base = rcrb;
> >  
> >  	cond_cxl_root_lock(port);
> >  	rc = add_dport(port, dport);
> > diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
> > index 1476a0299c9b..08da4c917f99 100644
> > --- a/drivers/cxl/core/regs.c
> > +++ b/drivers/cxl/core/regs.c
> > @@ -332,9 +332,8 @@ int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
> >  }
> >  EXPORT_SYMBOL_NS_GPL(cxl_find_regblock, CXL);
> >  
> > -resource_size_t cxl_rcrb_to_component(struct device *dev,
> > -				      resource_size_t rcrb,
> > -				      enum cxl_rcrb which)
> > +resource_size_t cxl_probe_rcrb(struct device *dev, resource_size_t rcrb,
> > +			       struct cxl_rcrb_info *ri, enum cxl_rcrb which)
> >  {
> >  	resource_size_t component_reg_phys;
> >  	void __iomem *addr;
> > @@ -344,6 +343,8 @@ resource_size_t cxl_rcrb_to_component(struct device *dev,
> >  
> >  	if (which == CXL_RCRB_UPSTREAM)
> >  		rcrb += SZ_4K;
> > +	else if (ri)
> > +		ri->base = rcrb;
> 
> I'm struggling a bit to follow flow, but I 'think' you set this to the same
> address here and at the end of __devm_cxl_add_dport()

Yes, that is a duplicate assignment, good catch.

> 
> >  
> >  	/*
> >  	 * RCRB's BAR[0..1] point to component block containing CXL
> > @@ -364,6 +365,7 @@ resource_size_t cxl_rcrb_to_component(struct device *dev,
> >  	cmd = readw(addr + PCI_COMMAND);
> >  	bar0 = readl(addr + PCI_BASE_ADDRESS_0);
> >  	bar1 = readl(addr + PCI_BASE_ADDRESS_1);
> > +
> 
> Trivial but I love to moan about these :)
> Stray change that shouldn't be in this patch...

I think it is ok to also add such trivial changes in a patch like
this. A separate patch for trivial things (to improve) like this would
just spam the patch queue and isn't it worth.

But, there are no other changes in that area, so just keep it as is
and simply drop the change.

> 
> >  	iounmap(addr);
> >  	release_mem_region(rcrb, SZ_4K);
> >  
> > @@ -395,4 +397,4 @@ resource_size_t cxl_rcrb_to_component(struct device *dev,
> >  
> >  	return component_reg_phys;
> >  }
> > -EXPORT_SYMBOL_NS_GPL(cxl_rcrb_to_component, CXL);
> > +EXPORT_SYMBOL_NS_GPL(cxl_probe_rcrb, CXL);
> > diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> > index a5cd661face2..29e0bd2b8f2a 100644
> > --- a/drivers/cxl/cxl.h
> > +++ b/drivers/cxl/cxl.h
> > @@ -267,9 +267,9 @@ enum cxl_rcrb {
> >  	CXL_RCRB_DOWNSTREAM,
> >  	CXL_RCRB_UPSTREAM,
> >  };
> > -resource_size_t cxl_rcrb_to_component(struct device *dev,
> > -				      resource_size_t rcrb,
> > -				      enum cxl_rcrb which);
> > +struct cxl_rcrb_info;
> > +resource_size_t cxl_probe_rcrb(struct device *dev, resource_size_t rcrb,
> > +			       struct cxl_rcrb_info *ri, enum cxl_rcrb which);
> >  
> >  #define CXL_RESOURCE_NONE ((resource_size_t) -1)
> >  #define CXL_TARGET_STRLEN 20
> > @@ -587,22 +587,27 @@ cxl_find_dport_by_dev(struct cxl_port *port, const struct device *dport_dev)
> >  	return xa_load(&port->dports, (unsigned long)dport_dev);
> >  }
> >  
> > +struct cxl_rcrb_info {
> > +	resource_size_t base;
> > +	u16 aer_cap;
> > +};
> > +
> >  /**
> >   * struct cxl_dport - CXL downstream port
> >   * @dport: PCI bridge or firmware device representing the downstream link
> > + * @port: reference to cxl_port that contains this downstream port
> >   * @port_id: unique hardware identifier for dport in decoder target list
> >   * @component_reg_phys: downstream port component registers
> > - * @rcrb: base address for the Root Complex Register Block
> >   * @rch: Indicate whether this dport was enumerated in RCH or VH mode
> > - * @port: reference to cxl_port that contains this downstream port
> > + * @rcrb: Data about the Root Complex Register Block layout
> >   */
> >  struct cxl_dport {
> >  	struct device *dport;
> > +	struct cxl_port *port;
> 
> Why the reorder?  It's adding noise we don't need in this patch...

There is some rework of the struct anyway. @port is essential for that
object as it reflects the hierarchy. Also, having 64 bit pointers in
the beginning improves padding of the struct. Not a big deal but good
reasons to change the order.

> 
> >  	int port_id;
> >  	resource_size_t component_reg_phys;
> > -	resource_size_t rcrb;
> >  	bool rch;
> > -	struct cxl_port *port;
> > +	struct cxl_rcrb_info rcrb;
> >  };
> >  
> >  /**
> > diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> > index 519edd0eb196..7ecdaa7f9315 100644
> > --- a/drivers/cxl/mem.c
> > +++ b/drivers/cxl/mem.c
> > @@ -51,7 +51,6 @@ static int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,
> >  	struct cxl_port *parent_port = parent_dport->port;
> >  	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> >  	struct cxl_port *endpoint, *iter, *down;
> > -	resource_size_t component_reg_phys;
> >  	int rc;
> >  
> >  	/*
> > @@ -71,12 +70,15 @@ static int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,
> >  	 * host-bridge RCRB if they are not already mapped via the
> >  	 * typical register locator mechanism.
> >  	 */
> > -	if (parent_dport->rch && cxlds->component_reg_phys == CXL_RESOURCE_NONE)
> > -		component_reg_phys = cxl_rcrb_to_component(
> > -			&cxlmd->dev, parent_dport->rcrb, CXL_RCRB_UPSTREAM);
> > -	else
> > -		component_reg_phys = cxlds->component_reg_phys;
> > -	endpoint = devm_cxl_add_port(host, &cxlmd->dev, component_reg_phys,
> > +	if (parent_dport->rch &&
> > +	    cxlds->component_reg_phys == CXL_RESOURCE_NONE) {
> > +		cxlds->component_reg_phys =
> > +			cxl_probe_rcrb(&cxlmd->dev, parent_dport->rcrb.base,
> > +				       NULL, CXL_RCRB_UPSTREAM);
> 
> This use of the component_reg_phys pointer in cxlds isn't closely related
> to the other changes. This patch would (I think) be more readable
> if that change was done in a precursor patch.

This is an intermediate change and removed later. I will check if the
local component_reg_phys var could be kept here until removal.

Thanks,

-Robert

> 
> > +	}
> > +
> > +	endpoint = devm_cxl_add_port(host, &cxlmd->dev,
> > +				     cxlds->component_reg_phys,
> >  				     parent_dport);
> >  	if (IS_ERR(endpoint))
> >  		return PTR_ERR(endpoint);
> 
