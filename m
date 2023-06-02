Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E20367205A1
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 17:13:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235991AbjFBPNS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 11:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234446AbjFBPNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 11:13:14 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2083.outbound.protection.outlook.com [40.107.243.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7870E50;
        Fri,  2 Jun 2023 08:12:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hT9WqqqolP25bIziq+hpSbv/lIynwGtKps5WPGD/Q4b8FLy0LfbOlwt49xPD6pYnxvr/6IaSz5wyd4PnPbh1PB5fl0WW/DkaUD8I22HcZsqTTyG+vP+WdtKpO2bVe0EORRd5I8uU+Uf+LPfQ25/OqUMSmhpAl9BuxnVVlwfaK4Hei+3B1zxF8WJiSfrRWwuMWRl1F4tSY+PG/9xoJjJWcNj+jC5mO0wfZLcokM6dFtgAksDcoX3frGIf7TQ46boVnWfEyqNLMxOcdW8MBCi+whDfqMUbZCZi87goI/7aeFylLsT4gd2svF/gKZWcIqMlukYSCmtKe5P70wJ9heNxcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qN7zVxJ8fMqVwEBoRR5vOMhdpds97ccfFeuTIZUaHAM=;
 b=gk3dLhAwmtlO0IY72j7XDjnIyK0y9yzPinH1iSe6ID6KZ76jWhhVdyXS8pHKM7QZE46wJQ+p6nYlncLELN8YPss8lxVskNpI8Jmql1/AUXXExFCTFFwnOErVwwVWDcrI3srjZCa7+ZUyUlvcMqAJaQhwWwLaDLAew9zNEn7tTkzAyhpNGq3d4+uOi/A02oL9oU1XcPt4r5mhNl3ZjdpRryiNDxNGX2Ha7BytC8qpatrQpfsTpiTl9ikcsdmtBDIiFmCuUoD3Wdi+oC9iZpi2J7tGiFWb3dOHq6/bBe576AVsiGx9rcjvJc8BrJbHjaFl06xrn68m6x6WYH/c+NXLVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=huawei.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qN7zVxJ8fMqVwEBoRR5vOMhdpds97ccfFeuTIZUaHAM=;
 b=l1uE8YQB8+Z4xjr1syxyxJqiiJobcGH86kYqEVLOJr4iVud4m6q3m+8w5W6F1S5h4T1A5+2dRfTBWEx84eO+v2s6vM9TQYG43T1MiYkf51cc3pdX5iVlJUV58jri4MF/X2HzbqxwqVwmfGJkDBgbwuXNxsgffYQ1IsaAhHyeQ8I=
Received: from DM6PR02CA0099.namprd02.prod.outlook.com (2603:10b6:5:1f4::40)
 by CY5PR12MB6346.namprd12.prod.outlook.com (2603:10b6:930:21::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.23; Fri, 2 Jun
 2023 15:12:23 +0000
Received: from DM6NAM11FT102.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1f4:cafe::fe) by DM6PR02CA0099.outlook.office365.com
 (2603:10b6:5:1f4::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.26 via Frontend
 Transport; Fri, 2 Jun 2023 15:12:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT102.mail.protection.outlook.com (10.13.173.172) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.26 via Frontend Transport; Fri, 2 Jun 2023 15:12:22 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 2 Jun
 2023 10:12:04 -0500
Date:   Fri, 2 Jun 2023 17:11:47 +0200
From:   Robert Richter <rrichter@amd.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC:     Terry Bowman <terry.bowman@amd.com>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        <bwidawsk@kernel.org>, <dan.j.williams@intel.com>,
        <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: Re: [PATCH v4 04/23] cxl/core/regs: Add @dev to cxl_register_map
Message-ID: <ZHoGs9vB+RQhnCUr@rric.localdomain>
References: <20230523232214.55282-1-terry.bowman@amd.com>
 <20230523232214.55282-5-terry.bowman@amd.com>
 <20230601114930.000065ad@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230601114930.000065ad@Huawei.com>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT102:EE_|CY5PR12MB6346:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c3d8685-3c55-4ead-72c6-08db637bc3f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SIzgyxbnpJyDfdqSqquSW5fB/GToDzgbK/k9GaVqjByuvQa/8M6M1iS95K/GCPPqoDhuCIR10f1DW8jBtJ6Z2HYrN/tLgTtS/P1TKOi7DtN9Y9oH03hxf9xXD60GfXQ/85F+bFJZ7pQPQdGwcaAaRIS8woEStBulZOiVg19XoaUsePtbBY0fG6J057wETqQdQvDA+p6YZYtpr8kpOW9goWoFSzCq03DUZkSCxB95rP3bVxk28+z7qhN+YwLI7wjR/cClkdcucoJ/NTocE99kZeExltTRtkMwpxlNn2yHmj8vpVn3eFYX5twLeRoz5OvC/vujbVw6BP+d9mxKHaZ9T6K6fvibYl+eeOtqhXqHDE+JycLxPL9Y5QdRlp8fj5/qdFd21QEWa9rrQ/d/Btv8CGQxa7UqhF95fXC05RcC3FI9WG6niH1JRKBMXs4MRQGg3J60bmDmRN6BHTITu7NgiJM1yga1qdMxyxAnTOVYGxwkqDzE5Jp+xs4bypsve9ySlOj3uJZm1KGHndI0Cj2KFhjZPm8+6qkie6ei3mEcunPAsrbPlQtBCslAH8+yvlZiPDfqj8Vd5hS6pui8ec6axAkgnvLi74bATEhVHcRVuOHWatpW4guW28zMqx0RQJYo0tlLVU9sd53y4oXRSVAfH1vug18ja1nyOzPGF6S9hyQDKAWavrlWpJErd2eiFbBDrCB0CiMbhs0XHC9u5dGK9/F/uzCiSqHoA6CwJndT4C6DJUYSTLC1IfFdgyK1aeQXsQx/hH2DwJNkpMoT+MDOO7uHvC70ChAL6Fl8hvh121s=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(376002)(136003)(346002)(451199021)(36840700001)(40470700004)(46966006)(81166007)(82740400003)(356005)(82310400005)(40460700003)(7696005)(41300700001)(8936002)(7416002)(26005)(5660300002)(9686003)(53546011)(55016003)(40480700001)(186003)(426003)(16526019)(336012)(83380400001)(47076005)(30864003)(316002)(478600001)(70586007)(2906002)(70206006)(6666004)(54906003)(8676002)(36860700001)(4326008)(6916009)(67856001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2023 15:12:22.1940
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c3d8685-3c55-4ead-72c6-08db637bc3f1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT102.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6346
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

On 01.06.23 11:49:30, Jonathan Cameron wrote:
> On Tue, 23 May 2023 18:21:55 -0500
> Terry Bowman <terry.bowman@amd.com> wrote:
> 
> > From: Robert Richter <rrichter@amd.com>
> > 
> > The corresponding device of a register mapping is used for devm
> > operations and logging. For operations with struct cxl_register_map
> > the device needs to be kept track separately. To simpify the involved
> > function interfaces, add @dev to cxl_register_map.
> > 
> > While at it also reorder function arguments of cxl_map_device_regs()
> > and cxl_map_component_regs() to have the object @cxl_register_map
> > first.
> > 
> > In a result a bunch of functions are available to be used with a
> > @cxl_register_map object.
> > 
> > This patch is in preparation of reworking the component register setup
> > code.
> > 
> > Signed-off-by: Robert Richter <rrichter@amd.com>
> > Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> > ---
> >  drivers/cxl/core/hdm.c  |  4 ++--
> >  drivers/cxl/core/regs.c | 22 ++++++++++++---------
> >  drivers/cxl/cxl.h       | 10 ++++++----
> >  drivers/cxl/pci.c       | 42 ++++++++++++++++++++---------------------
> >  4 files changed, 41 insertions(+), 37 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> > index 7889ff203a34..5abfa9276dac 100644
> > --- a/drivers/cxl/core/hdm.c
> > +++ b/drivers/cxl/core/hdm.c
> > @@ -85,6 +85,7 @@ static int map_hdm_decoder_regs(struct cxl_port *port, void __iomem *crb,
> >  				struct cxl_component_regs *regs)
> >  {
> >  	struct cxl_register_map map = {
> > +		.dev = &port->dev,
> >  		.resource = port->component_reg_phys,
> >  		.base = crb,
> >  		.max_size = CXL_COMPONENT_REG_BLOCK_SIZE,
> > @@ -97,8 +98,7 @@ static int map_hdm_decoder_regs(struct cxl_port *port, void __iomem *crb,
> >  		return -ENODEV;
> >  	}
> >  
> > -	return cxl_map_component_regs(&port->dev, regs, &map,
> > -				      BIT(CXL_CM_CAP_CAP_ID_HDM));
> > +	return cxl_map_component_regs(&map, regs, BIT(CXL_CM_CAP_CAP_ID_HDM));
> >  }
> >  
> >  static bool should_emulate_decoders(struct cxl_endpoint_dvsec_info *info)
> > diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
> > index 08da4c917f99..9888bdf43e55 100644
> > --- a/drivers/cxl/core/regs.c
> > +++ b/drivers/cxl/core/regs.c
> > @@ -199,8 +199,9 @@ void __iomem *devm_cxl_iomap_block(struct device *dev, resource_size_t addr,
> >  	return ret_val;
> >  }
> >  
> > -int cxl_map_component_regs(struct device *dev, struct cxl_component_regs *regs,
> > -			   struct cxl_register_map *map, unsigned long map_mask)
> > +int cxl_map_component_regs(struct cxl_register_map *map,
> > +			   struct cxl_component_regs *regs,
> > +			   unsigned long map_mask)
> >  {
> >  	struct mapinfo {
> >  		struct cxl_reg_map *rmap;
> > @@ -213,16 +214,16 @@ int cxl_map_component_regs(struct device *dev, struct cxl_component_regs *regs,
> >  
> >  	for (i = 0; i < ARRAY_SIZE(mapinfo); i++) {
> >  		struct mapinfo *mi = &mapinfo[i];
> > -		resource_size_t phys_addr;
> > +		resource_size_t addr;
> 
> This rename not mentioned in the patch description. I guess it's
> stepping towards consistency between the different paths, but
> in this patch it looks like noise...

Haven't added a comment in the description as this is a local change
only and right, also for consistency. But the original intention was
to shorten variable length here to keep the 80 char size limit for the
line.

> 
> >  		resource_size_t length;
> >  
> >  		if (!mi->rmap->valid)
> >  			continue;
> >  		if (!test_bit(mi->rmap->id, &map_mask))
> >  			continue;
> > -		phys_addr = map->resource + mi->rmap->offset;
> > +		addr = map->resource + mi->rmap->offset;
> >  		length = mi->rmap->size;
> > -		*(mi->addr) = devm_cxl_iomap_block(dev, phys_addr, length);
> > +		*(mi->addr) = devm_cxl_iomap_block(map->dev, addr, length);
> >  		if (!*(mi->addr))
> >  			return -ENOMEM;
> >  	}
> > @@ -231,9 +232,8 @@ int cxl_map_component_regs(struct device *dev, struct cxl_component_regs *regs,
> >  }
> >  EXPORT_SYMBOL_NS_GPL(cxl_map_component_regs, CXL);
> >  
> > -int cxl_map_device_regs(struct device *dev,
> > -			struct cxl_device_regs *regs,
> > -			struct cxl_register_map *map)
> > +int cxl_map_device_regs(struct cxl_register_map *map,
> > +			struct cxl_device_regs *regs)
> >  {
> >  	resource_size_t phys_addr = map->resource;
> >  	struct mapinfo {
> > @@ -256,7 +256,7 @@ int cxl_map_device_regs(struct device *dev,
> >  
> >  		addr = phys_addr + mi->rmap->offset;
> >  		length = mi->rmap->size;
> > -		*(mi->addr) = devm_cxl_iomap_block(dev, addr, length);
> > +		*(mi->addr) = devm_cxl_iomap_block(map->dev, addr, length);
> >  		if (!*(mi->addr))
> >  			return -ENOMEM;
> >  	}
> > @@ -302,7 +302,10 @@ int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
> >  	u32 regloc_size, regblocks;
> >  	int regloc, i;
> >  
> > +	memset(map, 0, sizeof(*map));
> > +	map->dev = &pdev->dev;
> >  	map->resource = CXL_RESOURCE_NONE;
> > +
> 
> No comment :)

This logicaly groups the setup of @map in a code block.

> 
> >  	regloc = pci_find_dvsec_capability(pdev, PCI_DVSEC_VENDOR_ID_CXL,
> >  					   CXL_DVSEC_REG_LOCATOR);
> >  	if (!regloc)
> > @@ -328,6 +331,7 @@ int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
> >  	}
> >  
> >  	map->resource = CXL_RESOURCE_NONE;
> > +
> Not here either.
> 
> White space changes go in a patch on their own - not mixed in!

IMO, once touching a function coding style changes can be part of the
whole change. Splitting this in small trivial patches a bit too much
as long as the patch is still readable.

> 
> >  	return -ENODEV;
> >  }
> >  EXPORT_SYMBOL_NS_GPL(cxl_find_regblock, CXL);
> > diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> > index a8bda2c74a85..095b767c21e9 100644
> > --- a/drivers/cxl/cxl.h
> > +++ b/drivers/cxl/cxl.h
> > @@ -231,6 +231,7 @@ struct cxl_device_reg_map {
> >  
> >  /**
> >   * struct cxl_register_map - DVSEC harvested register block mapping parameters
> > + * @dev: device for devm operations and logging
> >   * @base: virtual base of the register-block-BAR + @block_offset
> >   * @resource: physical resource base of the register block
> >   * @max_size: maximum mapping size to perform register search
> > @@ -239,6 +240,7 @@ struct cxl_device_reg_map {
> >   * @device_map: cxl_reg_maps for device registers
> >   */
> >  struct cxl_register_map {
> > +	struct device *dev;
> >  	void __iomem *base;
> >  	resource_size_t resource;
> >  	resource_size_t max_size;
> > @@ -253,11 +255,11 @@ void cxl_probe_component_regs(struct device *dev, void __iomem *base,
> >  			      struct cxl_component_reg_map *map);
> >  void cxl_probe_device_regs(struct device *dev, void __iomem *base,
> >  			   struct cxl_device_reg_map *map);
> > -int cxl_map_component_regs(struct device *dev, struct cxl_component_regs *regs,
> > -			   struct cxl_register_map *map,
> > +int cxl_map_component_regs(struct cxl_register_map *map,
> > +			   struct cxl_component_regs *regs,
> >  			   unsigned long map_mask);
> > -int cxl_map_device_regs(struct device *dev, struct cxl_device_regs *regs,
> > -			struct cxl_register_map *map);
> > +int cxl_map_device_regs(struct cxl_register_map *map,
> > +			struct cxl_device_regs *regs);
> >  
> >  enum cxl_regloc_type;
> >  int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
> > diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> > index 0872f2233ed0..2a9f65be148b 100644
> > --- a/drivers/cxl/pci.c
> > +++ b/drivers/cxl/pci.c
> > @@ -274,61 +274,59 @@ static int cxl_pci_setup_mailbox(struct cxl_dev_state *cxlds)
> >  	return 0;
> >  }
> >  
> > -static int cxl_map_regblock(struct pci_dev *pdev, struct cxl_register_map *map)
> > +static int cxl_map_regblock(struct cxl_register_map *map)
> >  {
> > -	struct device *dev = &pdev->dev;
> It think equivalent is still a nice to have + smaller diff which is nice.

I see your point here. Will just reassign @dev.

> 
> 	struct device *dev = &map->dev;
> 
> > -
> >  	map->base = ioremap(map->resource, map->max_size);
> >  	if (!map->base) {
> > -		dev_err(dev, "failed to map registers\n");
> > +		dev_err(map->dev, "failed to map registers\n");
> >  		return -ENOMEM;
> >  	}
> >  
> > -	dev_dbg(dev, "Mapped CXL Memory Device resource %pa\n", &map->resource);
> > +	dev_dbg(map->dev, "Mapped CXL Memory Device resource %pa\n",
> > +		&map->resource);
> > +
> >  	return 0;
> >  }
> >  
> > -static void cxl_unmap_regblock(struct pci_dev *pdev,
> > -			       struct cxl_register_map *map)
> > +static void cxl_unmap_regblock(struct cxl_register_map *map)
> >  {
> >  	iounmap(map->base);
> >  	map->base = NULL;
> >  }
> >  
> > -static int cxl_probe_regs(struct pci_dev *pdev, struct cxl_register_map *map)
> > +static int cxl_probe_regs(struct cxl_register_map *map)
> >  {
> >  	struct cxl_component_reg_map *comp_map;
> >  	struct cxl_device_reg_map *dev_map;
> > -	struct device *dev = &pdev->dev;
> 
> Same comment.  Keep the local variable and this patch gets
> smaller.  I guess there might be a reason for this later in the
> set though.  If there is shout about it in the patch introduction.

I don't think the change is later needed. Let's see.

Thanks,

-Robert

> 
> >  	void __iomem *base = map->base;
> >  
> >  	switch (map->reg_type) {
> >  	case CXL_REGLOC_RBI_COMPONENT:
> >  		comp_map = &map->component_map;
> > -		cxl_probe_component_regs(dev, base, comp_map);
> > +		cxl_probe_component_regs(map->dev, base, comp_map);
> >  		if (!comp_map->hdm_decoder.valid) {
> > -			dev_err(dev, "HDM decoder registers not found\n");
> > +			dev_err(map->dev, "HDM decoder registers not found\n");
> >  			return -ENXIO;
> >  		}
> >  
> >  		if (!comp_map->ras.valid)
> > -			dev_dbg(dev, "RAS registers not found\n");
> > +			dev_dbg(map->dev, "RAS registers not found\n");
> >  
> > -		dev_dbg(dev, "Set up component registers\n");
> > +		dev_dbg(map->dev, "Set up component registers\n");
> >  		break;
> >  	case CXL_REGLOC_RBI_MEMDEV:
> >  		dev_map = &map->device_map;
> > -		cxl_probe_device_regs(dev, base, dev_map);
> > +		cxl_probe_device_regs(map->dev, base, dev_map);
> >  		if (!dev_map->status.valid || !dev_map->mbox.valid ||
> >  		    !dev_map->memdev.valid) {
> > -			dev_err(dev, "registers not found: %s%s%s\n",
> > +			dev_err(map->dev, "registers not found: %s%s%s\n",
> >  				!dev_map->status.valid ? "status " : "",
> >  				!dev_map->mbox.valid ? "mbox " : "",
> >  				!dev_map->memdev.valid ? "memdev " : "");
> >  			return -ENXIO;
> >  		}
> >  
> > -		dev_dbg(dev, "Probing device registers...\n");
> > +		dev_dbg(map->dev, "Probing device registers...\n");
> >  		break;
> >  	default:
> >  		break;
> > @@ -346,12 +344,12 @@ static int cxl_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
> >  	if (rc)
> >  		return rc;
> >  
> > -	rc = cxl_map_regblock(pdev, map);
> > +	rc = cxl_map_regblock(map);
> >  	if (rc)
> >  		return rc;
> >  
> > -	rc = cxl_probe_regs(pdev, map);
> > -	cxl_unmap_regblock(pdev, map);
> > +	rc = cxl_probe_regs(map);
> > +	cxl_unmap_regblock(map);
> >  
> >  	return rc;
> >  }
> > @@ -688,7 +686,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> >  	if (rc)
> >  		return rc;
> >  
> > -	rc = cxl_map_device_regs(&pdev->dev, &cxlds->regs.device_regs, &map);
> > +	rc = cxl_map_device_regs(&map, &cxlds->regs.device_regs);
> >  	if (rc)
> >  		return rc;
> >  
> > @@ -703,8 +701,8 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> >  
> >  	cxlds->component_reg_phys = map.resource;
> >  
> > -	rc = cxl_map_component_regs(&pdev->dev, &cxlds->regs.component,
> > -				    &map, BIT(CXL_CM_CAP_CAP_ID_RAS));
> > +	rc = cxl_map_component_regs(&map, &cxlds->regs.component,
> > +				    BIT(CXL_CM_CAP_CAP_ID_RAS));
> >  	if (rc)
> >  		dev_dbg(&pdev->dev, "Failed to map RAS capability.\n");
> >  
> 
