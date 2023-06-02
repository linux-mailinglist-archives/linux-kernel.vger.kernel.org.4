Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 730B172066F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 17:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236432AbjFBPnH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 11:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235166AbjFBPnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 11:43:05 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2065.outbound.protection.outlook.com [40.107.244.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEAE818C;
        Fri,  2 Jun 2023 08:43:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NNSBZcbiFIzW/kZCyMeu3VUbb6tiWJ6sqIUXtZ8rF/9DhL+Oeqrg6UMztedFGUZv5lyTa1gbx6+dQUyWoBJnnmvayPxPf+hi5tPa2EOX2PqY7ie8HwPpTzlFRYcIn7vAcDyNN0uakQQeBpVJPdMtUfiM8B2Sr4gW84PzPD3wY3AD4m3OKQ4r/lIije8qqeHGKZQ7F4O0cfypcTfjuVU0U8X92fi9JhRrH3yZubmY2YxGqwP3XiSUP+g/iV7hRBZs0GrIF43Az+gS0Z8CRdAJq7tUXp5CygL4yYx1cJXcHx6kthqW442tZIKmEdStQA7c3+yrOcQOOL6U4szMMlTa4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=igCpu609BxKEN4PdzRSIyixWc1o3RZ7XvCHhR01Uh7s=;
 b=DQspBWlHUTyV8QlZH3Fk0eymJmDAXwPlcP9HrdzB/TR4Y/PXxP7HCDvr5vNWGEG2p6wur99vu98fFJKEx9mXTRZvOmqXI4Ey61UObtOpBeDNlAjO0xSAKE4kr9LfBm36FstEIMyQWmeCel49mfuSp2pBnFQ2JOOFKseM9IoM7J64mMjkwwywHDDTFYRQnopGDcwyLqN7opGomb/firVMzskzZWP7p+hLugBUmV1aOPRD+gIl+wVcWkKCJAQcfLVwiLQ3Fr5QiNLuZTMPP/tjmdXwF2n0uawpKxOgt1waXmS/67UdJ21pY5NugA2MwcJy8yopjlRsuPrbkVHFDDJCWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=huawei.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=igCpu609BxKEN4PdzRSIyixWc1o3RZ7XvCHhR01Uh7s=;
 b=wjGEKiamX6EwleNlF1JHUoESQ56FYBdZiOCcbaHIebiaA9H892tHMpBx1IrMW9aWB0oBCg8dhcrI+LqG3eujM+BU2YG61lsnZ+iRNgcnCMQ+2w8h+8xErQT3cFHf/jyxqnG5dsMo8Es8LW/0yp7HL1MpFYsfu+1ciW13aZ7vJBM=
Received: from DM6PR21CA0010.namprd21.prod.outlook.com (2603:10b6:5:174::20)
 by PH7PR12MB6883.namprd12.prod.outlook.com (2603:10b6:510:1b9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22; Fri, 2 Jun
 2023 15:43:00 +0000
Received: from CY4PEPF0000EDD6.namprd03.prod.outlook.com
 (2603:10b6:5:174:cafe::1f) by DM6PR21CA0010.outlook.office365.com
 (2603:10b6:5:174::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.11 via Frontend
 Transport; Fri, 2 Jun 2023 15:42:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD6.mail.protection.outlook.com (10.167.241.210) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.18 via Frontend Transport; Fri, 2 Jun 2023 15:42:58 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 2 Jun
 2023 10:42:51 -0500
Date:   Fri, 2 Jun 2023 17:42:34 +0200
From:   Robert Richter <rrichter@amd.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC:     Terry Bowman <terry.bowman@amd.com>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        <bwidawsk@kernel.org>, <dan.j.williams@intel.com>,
        <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: Re: [PATCH v4 07/23] cxl/acpi: Directly bind the CEDT detected CHBCR
 to the Host Bridge's port
Message-ID: <ZHoN6nsSzutBO3vI@rric.localdomain>
References: <20230523232214.55282-1-terry.bowman@amd.com>
 <20230523232214.55282-8-terry.bowman@amd.com>
 <20230601134557.0000242b@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230601134557.0000242b@Huawei.com>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD6:EE_|PH7PR12MB6883:EE_
X-MS-Office365-Filtering-Correlation-Id: 701baad7-532d-4615-6134-08db63800a92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ml0FNyGVGtK5Ivi9GagXf+8O+3AoobEuvKdgn1FpTltuRz+BFVaegGjXH2BwlsdTLIA0y6NfUWhXUeM+DkYhaE3RJPhjjNaMoUAw74yPtHozKeYR/tEJJOI/YMkUi/UrH4Ms9X9rQ3TRtKFvLLLkGp0k7wWatIgN5pW9TeRp/K5QY2iEvHTF+CYJ0dULjSABMj5FbcYAwc42uj6thWX/V9HhJhvXhAnVfZWU/YMdYMgdvinU372ffClX2PGKt+JsOYwcUdaLy1jKz93gBIsya3nx/LR7SGfZOlR82D2H60T17i8fkMFHVcrg3sIegGOiOlXSrSZm+Y7Y4iYvsAh3mh0xqQ9tEz6b23fQr+b7inXwQRLYPf+EO4GUz4qZ33XDD+53dO0IvpXWzKlZazEQd25CgQV4eSHA/M3xy+uQ/hTCel/Uw6fmU0ho5KIYG3zv4Ay3JmjzQ0s8PNaJf9PLD6nM4E7ln8N+cPB2V9D4uBfF3QuEkXKp/BY1kl7I5CY/NiFr07pZ5g8WC9uxY7E6lN/sGKOQW4DbwxYOUdZOvXIipJ32IFIPMgMSdIoEq30nHvq91IxRrhDVHyXwcdCeXGvf2UimJmGdfhUTi5q6tv+6WLvDuqIgsI1LmSFcHGzODmsvC9DVnlabZo18Hb8HkNbLbfX8AulveH1880JOuE6F+536cHwLM5BDnIWZ7LuO+kr4Be1ibUcxGXoyQjDwuERjjz+P5pnaLD2wVRqjueDBjpbsO3oFuFs6XYkWxiB3t3b4gXEZg6zqZ7krX808Rg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(396003)(346002)(136003)(451199021)(46966006)(36840700001)(40470700004)(186003)(82310400005)(316002)(356005)(9686003)(53546011)(81166007)(16526019)(7696005)(40480700001)(82740400003)(55016003)(8676002)(8936002)(41300700001)(7416002)(40460700003)(6666004)(5660300002)(26005)(83380400001)(47076005)(36860700001)(54906003)(6916009)(70206006)(70586007)(2906002)(4326008)(426003)(336012)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2023 15:42:58.6448
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 701baad7-532d-4615-6134-08db63800a92
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6883
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

On 01.06.23 13:45:57, Jonathan Cameron wrote:
> On Tue, 23 May 2023 18:21:58 -0500
> Terry Bowman <terry.bowman@amd.com> wrote:
> 
> > From: Robert Richter <rrichter@amd.com>
> > 
> > During a Host Bridge's downstream port enumeration the CHBS entries in
> > the CEDT table are parsed, its Component Register base address
> > extracted and then stored in struct cxl_dport. The CHBS may contain
> > either the RCRB (RCH mode) or the Host Bridge's Component Registers
> > (CHBCR, VH mode). The RCRB further contains the CXL downstream port
> > register base address, while in VH mode the CXL Downstream Switch
> > Ports are visible in the PCI hierarchy and the DP's component regs are
> > disovered using the CXL DVSEC register locator capability. The
> > Component Registers derived from the CHBS for both modes are different
> > and thus also must be treated differently. That is, in RCH mode, the
> > component regs base should be bound to the dport, but in VH mode to
> > the CXL host bridge's port object.
> > 
> > The current implementation stores the CHBCR in addition in struct
> > cxl_dport and copies it later from there to struct cxl_port. As a
> > result, the dport contains the wrong Component Registers base address
> > and, e.g. the RAS capability of a CXL Root Port cannot be detected.
> > 
> > To fix the CHBCR binding, attach it directly to the Host Bridge's
> > @cxl_port structure. Do this during port creation of the Host Bridge
> > in add_host_bridge_uport(). Factor out CHBS parsing code in
> > add_host_bridge_dport() and use it in both functions.
> > 
> > Signed-off-by: Robert Richter <rrichter@amd.com>
> > Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> A few trivial formatting things.  With those tidied up or
> reason given for why not,
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> > ---
> >  drivers/cxl/acpi.c | 65 +++++++++++++++++++++++++++++++++++-----------
> >  1 file changed, 50 insertions(+), 15 deletions(-)
> > 
> > diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> > index 4fd9fe32f830..78a24b2ca923 100644
> > --- a/drivers/cxl/acpi.c
> > +++ b/drivers/cxl/acpi.c
> > @@ -333,8 +333,8 @@ struct cxl_chbs_context {
> >  	u32 cxl_version;
> >  };
> >  
> > -static int cxl_get_chbs(union acpi_subtable_headers *header, void *arg,
> > -			 const unsigned long end)
> > +static int cxl_get_chbs_iter(union acpi_subtable_headers *header, void *arg,
> > +			     const unsigned long end)
> >  {
> >  	struct cxl_chbs_context *ctx = arg;
> >  	struct acpi_cedt_chbs *chbs;
> > @@ -362,6 +362,22 @@ static int cxl_get_chbs(union acpi_subtable_headers *header, void *arg,
> >  	return 0;
> >  }
> >  
> > +static int cxl_get_chbs(struct acpi_device *hb, struct cxl_chbs_context *ctx)
> > +{
> > +	unsigned long long uid;
> > +	int rc;
> > +
> > +	rc = acpi_evaluate_integer(hb->handle, METHOD_NAME__UID, NULL, &uid);
> > +	if (rc != AE_OK)
> > +		return -ENOENT;
> > +
> > +	memset(ctx, 0, sizeof(*ctx));
> > +	ctx->uid = uid;
> 
> For consistency with original code better to use
> 
> 	*ctx = (struct cxl_chbs_context) {
> 		.uid = uid,
> 	};

The memset() pattern is much more common in the kernel, better
readable (and writable :-)) and shorter. I have started using it for
all the changes. There are not too many left:

drivers/cxl/core/mbox.c:        *mbox = (struct cxl_mbox_cmd) {
drivers/cxl/core/mbox.c:        *mem_cmd = (struct cxl_mem_command) {
drivers/cxl/core/mbox.c:        *mem_cmd = (struct cxl_mem_command) {
drivers/cxl/core/mbox.c:        *payload = (struct cxl_mbox_clear_event_payload) {
drivers/cxl/core/regs.c:        *map = (struct cxl_component_reg_map) { 0 };
drivers/cxl/core/regs.c:        *map = (struct cxl_device_reg_map){ 0 };
drivers/cxl/pci.c:      *policy = (struct cxl_event_interrupt_policy) {
drivers/cxl/pmem.c:     *cmd = (struct nd_cmd_get_config_size) {
drivers/cxl/pmem.c:     *set_lsa = (struct cxl_mbox_set_lsa) {

> 
> > +	acpi_table_parse_cedt(ACPI_CEDT_TYPE_CHBS, cxl_get_chbs_iter, ctx);
> > +
> > +	return 0;
> > +}
> > +
> >  static int add_host_bridge_dport(struct device *match, void *arg)
> >  {
> >  	acpi_status rc;
> > @@ -377,19 +393,15 @@ static int add_host_bridge_dport(struct device *match, void *arg)
> >  	if (!hb)
> >  		return 0;
> >  
> > -	rc = acpi_evaluate_integer(hb->handle, METHOD_NAME__UID, NULL, &uid);
> > -	if (rc != AE_OK) {
> > +	rc = cxl_get_chbs(hb, &ctx);
> > +	if (rc == -ENOENT)
> >  		dev_err(match, "unable to retrieve _UID\n");
> 
> Why not push that down into the cxl_get_chbs() where no special handling
> of error code is needed?

All messages are generated here in this function and not in
cxl_get_chbs() at a lower level. That allows to reuse it later in
add_host_bridge_uport() there messages are different or unnecessary.

You would also need to pass @dev down to cxl_get_chbs() which polutes
the function i/f.

> 
> > -		return -ENODEV;
> > -	}
> > +	if (rc)
> > +		return rc;
> >  
> > +	uid = ctx.uid;
> >  	dev_dbg(match, "UID found: %lld\n", uid);
> >  
> > -	ctx = (struct cxl_chbs_context) {
> > -		.uid = uid,
> > -	};
> > -	acpi_table_parse_cedt(ACPI_CEDT_TYPE_CHBS, cxl_get_chbs, &ctx);
> > -
> >  	if (!ctx.base) {
> >  		dev_warn(match, "No CHBS found for Host Bridge (UID %lld)\n",
> >  			 uid);
> > @@ -405,12 +417,17 @@ static int add_host_bridge_dport(struct device *match, void *arg)
> >  	pci_root = acpi_pci_find_root(hb->handle);
> >  	bridge = pci_root->bus->bridge;
> >  
> > +	/*
> > +	 * In RCH mode, bind the component regs base to the dport. In
> > +	 * VH mode it will be bound to the CXL host bridge's port
> > +	 * object later in add_host_bridge_uport().
> > +	 */
> >  	if (ctx.cxl_version == ACPI_CEDT_CHBS_VERSION_CXL11) {
> >  		dev_dbg(match, "RCRB found for UID %lld: %pa\n", uid, &ctx.base);
> >  		dport = devm_cxl_add_rch_dport(root_port, bridge, uid, ctx.base);
> >  	} else {
> > -		dev_dbg(match, "CHBCR found for UID %lld: %pa\n", uid, &ctx.base);
> > -		dport = devm_cxl_add_dport(root_port, bridge, uid, ctx.base);
> > +		dport = devm_cxl_add_dport(root_port, bridge, uid,
> > +					   CXL_RESOURCE_NONE);
> >  	}
> >  
> >  	if (IS_ERR(dport))
> > @@ -432,6 +449,8 @@ static int add_host_bridge_uport(struct device *match, void *arg)
> >  	struct cxl_dport *dport;
> >  	struct cxl_port *port;
> >  	struct device *bridge;
> > +	struct cxl_chbs_context ctx;
> > +	resource_size_t component_reg_phys;
> >  	int rc;
> >  
> >  	if (!hb)
> > @@ -450,12 +469,28 @@ static int add_host_bridge_uport(struct device *match, void *arg)
> >  		return 0;
> >  	}
> >  
> > +	rc = cxl_get_chbs(hb, &ctx);
> > +	if (rc)
> > +		return rc;
> > +
> > +	if (ctx.cxl_version == ACPI_CEDT_CHBS_VERSION_CXL11)
> > +		/* RCH mode, should never happen */
> > +		return 0;
> > +
> > +	if (ctx.base)
> > +		component_reg_phys = ctx.base;
> > +	else
> > +		component_reg_phys = CXL_RESOURCE_NONE;
> > +
> > +	if (component_reg_phys != CXL_RESOURCE_NONE)
> > +		dev_dbg(match, "CHBCR found for UID %lld: %pa\n",
> > +			ctx.uid, &component_reg_phys);
> 
> Why not put that in the block above?  Fine leaving it here if this
> makes sense after further refactoring.

ctx.base could be CXL_RESOURCE_NONE which we want to catch too.

I stumbled over that too then reviewing my own code, but I don't see
how this could be made more obvious. Maybe I will add a comment here.

Thanks,

-Robert

> 
> > +
> >  	rc = devm_cxl_register_pci_bus(host, bridge, pci_root->bus);
> >  	if (rc)
> >  		return rc;
> >  
> > -	port = devm_cxl_add_port(host, bridge, dport->component_reg_phys,
> > -				 dport);
> > +	port = devm_cxl_add_port(host, bridge, component_reg_phys, dport);
> >  	if (IS_ERR(port))
> >  		return PTR_ERR(port);
> >  
> 
