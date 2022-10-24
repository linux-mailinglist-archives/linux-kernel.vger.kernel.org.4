Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB59860BDAC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 00:43:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231948AbiJXWnq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 18:43:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231842AbiJXWnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 18:43:22 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on20601.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eae::601])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF1A4B5FD3;
        Mon, 24 Oct 2022 14:06:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QdOV3AsM/nTbvhiPmBywfZMLEKEMqafvVgcz3RbM9Ev+Ttu8nGxM2x8ZKSoTw680kgkQaAipx0torlLUBHN7FMLkOm9w0+kIkQkIo0RFx1znnMj+12AGVNCu+7LZ1tVAcHdrV3HRT+HIukd2XQKed/4P98Ib3XVIU2rKeBO35WE1jlBZocgVr7LcMBoiRi8dXHSUsYpSRDXOneAk9mY1JFXs3GTfk94OlNnuz3IZCbNSslF+GTRgjF0Evbw9wpSkB42q5R6U6Hg87VgL7MvfDTLA8o8b3X7JeqD7zYMzC1/1KVS+biAMi/3sVksaeZO43uKNuf5MKAsvpQWtxnwIGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CcBksUrEDbt98zAkV7BZQkw2tz6NaOzRF2+CfN641Fc=;
 b=g882jRs6trGpVxPMRT/xCzHYr41ChPMdgrr1/aVYXGf8MXwy8lHasTVpsMb25RVcSMekezi8V3rVrSWmijDcLRq+81sE81OwrifJ8NyMjhSIm4u0dZrBT/pN3yVPiAs41RoOlOyegCowpUDNTx6X4MnIUZbflZAf73Y2R5rky9T0wYH0A1B3FZWAfc4ulTSXCtcCWzOGQkQbdZlXdM0OKVCpz8+8Jyy5I85RGU3HOFqi5UScPt2xXUQOH4RGAG5YXdCu7nsZjg6aSEOkEHAyrRVxZPlC2GqqBvcUq50wY1cFxDh3opBtA77pV5iLt9QpwTgJ27L0VXRDiRpzFh9gGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CcBksUrEDbt98zAkV7BZQkw2tz6NaOzRF2+CfN641Fc=;
 b=dllk8+R9lz5ZJ9BXLuMkPeJwhekQ9VVI/Hnn2UswJoo6kI0eP/qAKQP8fIYO9bPj+WFX6TjVN8/WZqyviqpoSNzBGfGb5O+ueRn4n/lwgT8e43I4M3QoRgcqvgPhVufJuHXzqAmiirHj4jU5jtozD/32+AlnfHZppXILLIpfcOg=
Received: from DM6PR07CA0075.namprd07.prod.outlook.com (2603:10b6:5:337::8) by
 MN2PR12MB4256.namprd12.prod.outlook.com (2603:10b6:208:1d2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.23; Mon, 24 Oct
 2022 21:04:30 +0000
Received: from DM6NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:337:cafe::fe) by DM6PR07CA0075.outlook.office365.com
 (2603:10b6:5:337::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.27 via Frontend
 Transport; Mon, 24 Oct 2022 21:04:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT017.mail.protection.outlook.com (10.13.172.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5746.16 via Frontend Transport; Mon, 24 Oct 2022 21:04:30 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 24 Oct
 2022 16:04:27 -0500
Date:   Mon, 24 Oct 2022 23:04:24 +0200
From:   Robert Richter <rrichter@amd.com>
To:     Dan Williams <dan.j.williams@intel.com>
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
        Terry Bowman <terry.bowman@amd.com>
Subject: Re: [PATCH v2 06/12] cxl/acpi: Extract component registers of
 restricted hosts from RCRB
Message-ID: <Y1b92DF0c36/QDbo@rric.localdomain>
References: <20221018132341.76259-1-rrichter@amd.com>
 <20221018132341.76259-7-rrichter@amd.com>
 <63522b53321e1_24ac29467@dwillia2-mobl3.amr.corp.intel.com.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <63522b53321e1_24ac29467@dwillia2-mobl3.amr.corp.intel.com.notmuch>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT017:EE_|MN2PR12MB4256:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f584453-a3a8-4d1a-f22e-08dab6035821
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dCsgRSsZ2XtHD1xOQP8+u8U29nOcgU1M76ZYWmBNzcJxETqD2OvEP8BdYwia40DtEyBicvQaOMxX2Tk8ItqNguhLzXftSDaBNlDOMJP3zQKTxEf0+QEJaql4rABIHuv8x9XOfRNcoZn64i2vSinSyC9YOWhkepABY1QY6frlZbCBebX9pdYyEVMi24jK8jQnh6XJ8Dsisc7j+7Yu4zsII4KzbqkP7K+syuZx9qGOzwzHio3+RSydoRBkuQ6z6kFi334RE68lZl+LUGXo9qX558BRqEreEWbXx7XfwWrfcrT11Jrf1PASjFF8pPMMs13v+k+3wQ03hdJip9M5OJpkwRTp6RGm5pSXcpdkrW/5lHwlbF2VLawuimMf4XNWqY2Il23Mu/8VDj8WcFnxQyBiN5IS9+k0Qrlkssi5fuEFZbjJrEny33nA9M3WL/JlwtyW3TR+0SgG1DczvqZPfUJqUrZqVN5nDvn7x2X22os00Bmag2AmCgLYmps0q+v6vOkQV4O70xn16ROTuQwxgsYtD8Y9HU4d0O9ESIJByey2JbNVKYQRmBvAVdq7p1CwlRkjoyplP17KTr2cD4+Vw0GE0vA9f9nhlL6gJngqRO2kF0/VQlR7bbPWdlHUCcDm41iykxPxqZrXtGeCem240RTBz7XbKHulHljEtUM9CHeHFqhiAp4LIbrqnrERbYm3W7TEQResgCbGHADmrYLrbXuj6ADOI/CvGlvjSPYCH0c4YPZmgjxWWfR/GNr+FeCxoAQ37SguWfgU03hZj9QOJIyA2vS6B76K7WAXTRtPuVXY63XzOWvHOLvp26C4+FB6VAarAgG4LaeRw8rhQp5D6HI6oA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(39860400002)(136003)(376002)(451199015)(46966006)(40470700004)(36840700001)(966005)(83380400001)(426003)(478600001)(53546011)(5660300002)(54906003)(6666004)(9686003)(4326008)(70586007)(7696005)(7416002)(26005)(41300700001)(8936002)(6916009)(8676002)(55016003)(336012)(47076005)(82310400005)(70206006)(40460700003)(186003)(16526019)(2906002)(36860700001)(81166007)(316002)(40480700001)(356005)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2022 21:04:30.5342
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f584453-a3a8-4d1a-f22e-08dab6035821
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4256
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.10.22 22:17:07, Dan Williams wrote:
> Robert Richter wrote:
> > A downstream port must be connected to a component register block.
> > For restricted hosts the base address is determined from the RCRB. The
> > RCRB is provided by the host's CEDT CHBS entry. Rework CEDT parser to
> > get the RCRB and add code to extract the component register block from
> > it.
> > 
> > RCRB's BAR[0..1] point to the component block containing CXL subsystem
> > component registers. MEMBAR extraction follows the PCI base spec here,
> > esp. 64 bit extraction and memory range alignment (6.0, 7.5.1.2.1).
> > 
> > Note: Right now the component register block is used for HDM decoder
> > capability only which is optional for RCDs. If unsupported by the RCD,
> > the HDM init will fail. It is future work to bypass it in this case.
> > 
> > Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> > Signed-off-by: Robert Richter <rrichter@amd.com>
> > ---
> >  drivers/cxl/acpi.c | 79 ++++++++++++++++++++++++++++++++++++++++------
> >  1 file changed, 69 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> > index fb9f72813067..a92d5d7b7a92 100644
> > --- a/drivers/cxl/acpi.c
> > +++ b/drivers/cxl/acpi.c
> > @@ -9,6 +9,8 @@
> >  #include "cxlpci.h"
> >  #include "cxl.h"
> >  
> > +#define CXL_RCRB_SIZE	SZ_8K
> > +
> >  static unsigned long cfmws_to_decoder_flags(int restrictions)
> >  {
> >  	unsigned long flags = CXL_DECODER_F_ENABLE;
> > @@ -229,27 +231,82 @@ static int add_host_bridge_uport(struct device *match, void *arg)
> >  struct cxl_chbs_context {
> >  	struct device *dev;
> >  	unsigned long long uid;
> > -	resource_size_t chbcr;
> > +	struct acpi_cedt_chbs chbs;
> >  };
> >  
> > -static int cxl_get_chbcr(union acpi_subtable_headers *header, void *arg,
> > -			 const unsigned long end)
> > +static int cxl_get_chbs(union acpi_subtable_headers *header, void *arg,
> > +			const unsigned long end)
> >  {
> >  	struct cxl_chbs_context *ctx = arg;
> >  	struct acpi_cedt_chbs *chbs;
> >  
> > -	if (ctx->chbcr)
> > +	if (ctx->chbs.base)
> >  		return 0;
> >  
> >  	chbs = (struct acpi_cedt_chbs *) header;
> >  
> >  	if (ctx->uid != chbs->uid)
> >  		return 0;
> > -	ctx->chbcr = chbs->base;
> > +	ctx->chbs = *chbs;
> >  
> >  	return 0;
> >  }
> >  
> > +static resource_size_t cxl_get_chbcr(struct cxl_chbs_context *ctx)
> > +{
> 
> The core logic of this looks good, but this wants to be shared with the
> upstream port component register discovery.
> 
> Full disclosure I am reconciling these patches with an attempt that Dave
> Jiang made at this topic. Since your series hit the list first I will
> let it take the lead, but then fill it in with comments and learnings
> from Dave's effort.
> 
> So in this case Dave moved this into the drivers/cxl/core/regs.c with a
> function signature like:
> 
> enum cxl_rcrb {
>        CXL_RCRB_DOWNSTREAM,
>        CXL_RCRB_UPSTREAM,
> };
> 
> resource_size_t cxl_rcrb_to_component(struct device *dev,
>                                       resource_size_t rcrb_base, int len,
>                                       enum cxl_rcrb which);
> 
> ...where @which alternates when called by cxl_acpi for the downstream
> case, or cxl_mem for the upstream case.

Ok, I see where to go here. Could you point me to Dave's postings you
are referring to? I checked linux-cxl and could not find anything
related to RCRB or that changes regs.c.

> 
> 
> > +	struct acpi_cedt_chbs *chbs = &ctx->chbs;
> > +	resource_size_t component_reg_phys, rcrb;
> > +	u32 bar0, bar1;
> > +	void *addr;
> > +
> > +	if (!chbs->base)
> > +		return CXL_RESOURCE_NONE;
> > +
> > +	if (chbs->cxl_version != ACPI_CEDT_CHBS_VERSION_CXL11)
> > +		return chbs->base;
> > +
> > +	/* Extract RCRB */
> > +
> > +	if (chbs->length != CXL_RCRB_SIZE)
> > +		return CXL_RESOURCE_NONE;
> > +
> > +	rcrb = chbs->base;
> > +
> > +	dev_dbg(ctx->dev, "RCRB found for UID %lld: 0x%08llx\n",
> > +		ctx->uid, (u64)rcrb);
> > +
> > +	/*
> > +	 * RCRB's BAR[0..1] point to component block containing CXL
> > +	 * subsystem component registers. MEMBAR extraction follows
> > +	 * the PCI Base spec here, esp. 64 bit extraction and memory
> > +	 * ranges alignment (6.0, 7.5.1.2.1).
> > +	 */
> > +	addr = ioremap(rcrb, PCI_BASE_ADDRESS_0 + SZ_8);
> 
> No failure check? This also only needs to map 4K at a time.

Right, will add that.

> 
> > +	bar0 = readl(addr + PCI_BASE_ADDRESS_0);
> > +	bar1 = readl(addr + PCI_BASE_ADDRESS_1);
> > +	iounmap(addr);
> > +
> > +	/* sanity check */
> > +	if (bar0 & (PCI_BASE_ADDRESS_MEM_TYPE_1M | PCI_BASE_ADDRESS_SPACE_IO))
> > +		return CXL_RESOURCE_NONE;
> > +
> > +	component_reg_phys = bar0 & PCI_BASE_ADDRESS_MEM_MASK;
> > +	if (bar0 & PCI_BASE_ADDRESS_MEM_TYPE_64)
> > +		component_reg_phys |= ((u64)bar1) << 32;
> > +
> > +	if (!component_reg_phys)
> > +		return CXL_RESOURCE_NONE;
> > +
> > +	/*
> > +	 * Must be 8k aligned (size of combined CXL 1.1 Downstream and
> > +	 * Upstream Port RCRBs).
> > +	 */
> > +	if (component_reg_phys & (CXL_RCRB_SIZE - 1))
> > +		return CXL_RESOURCE_NONE;
> 
> This is open-coding the IS_ALIGNED() macro. More importantly, why is it
> using RCRB size for the component register block alignment? The
> component lock is 64K, and at least for CXL 2.0 devices it is 64K
> aligned (8.1.9.1 Register Block Offset Low), so I am not sure what this
> check is for?

True, this is a mistake and needs to be corrected. It is the component
reg range which is 64k. Will also use IS_ALIGNED().

> 
> ---
> 
> Given that there are actual CXL RCH platforms in the wild I want this
> topic branch to be the first thing queued for v6.2. To help us
> coordinate I pushed:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/log/?h=rch
> 
> ...with the patches from this set accepted so far. You can use that as
> the baseline for the next spin.

Yes, thanks for that branch and applying the first part.

-Robert
