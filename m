Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E496E629884
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 13:18:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbiKOMS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 07:18:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238306AbiKOMSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 07:18:02 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2080.outbound.protection.outlook.com [40.107.223.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5232122BE7;
        Tue, 15 Nov 2022 04:18:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D+5XEWpQYlDl6ZiMt7/OGcLJFn3iqn+nj0SonF7+1yNFcLPrP7B55t5oJWGbR6NwyiL5VxcHKN9WGAqxeCy7z0iEd+wcqReWdncyEBOGclzStJ33swkzMuLr7nFfWpvFB8JKC7H/QhgSfYo8o0wYAwST5+s5m8xg3aA2gXiyajyRJyKcNajNCaRlIte/LW1MM4Yc0M759TZbpQYFa+1NkLSDaC6Z6wHyERM4i/wm76CyyAeMEg7Aa5nEwC+5aGj4VaZhw+H9WhdQ7Cv3rn7jyfd2C+yEib/I/NBIRIc1/WvI3KKG+CNzxdJ0zrVw7W2H/3UDMymg997JQJqa/5s8KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YPhzcKUQ8q5aoBwIl8+t062FIBd3QnNoHXC03T5/p2s=;
 b=c9V86INZ8ED6bdLO2b8fn/Bb8TgCSmIa9+8fJg3V8uhEnsA3N5pKquqT+Ji04zCg8/qEZ3tCYeU0XI1UwZB+UW0iauY+IB6nxvE8Ry/RuVG874oSsitVVSbaIH4Cbz+MiWNWc1J6tZwZ3pqh9p67yubCXsdRkmduJUecC+lgehQPFmtU2cVErkPyYyRJvHToBKrS6aVXoqbfkutfpPlbRyVGhyFbgQcyJ2MdF2UFeBaceGKHQAe+BdCeBHsjGm4mSPpE8rt1cwPxUTwUr9dpMSOgDZEauvvfUn6x+zVqCqNaFwHb8mnGClrlsi8Pgm69vJndg7cFc7mpsOQmClSCqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YPhzcKUQ8q5aoBwIl8+t062FIBd3QnNoHXC03T5/p2s=;
 b=Rb3myLLOeNC0InQ9oZjGzEV02yGaU05Tftvy5kAvb2ECVN4fauQjfYddxE1CcQMYCtrbXKDPHzivOL6miIE554auX66Uawdd7yBrBXgfqJdTRkuVKGyNxpYexEAMirWIw0acs5ov0wVfwYCJXL0tYl/LlZFfJ7mmAoMfSUh6lAM=
Received: from DS7PR05CA0090.namprd05.prod.outlook.com (2603:10b6:8:56::13) by
 DS7PR12MB6095.namprd12.prod.outlook.com (2603:10b6:8:9c::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5813.17; Tue, 15 Nov 2022 12:17:57 +0000
Received: from DM6NAM11FT100.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:56:cafe::60) by DS7PR05CA0090.outlook.office365.com
 (2603:10b6:8:56::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.8 via Frontend
 Transport; Tue, 15 Nov 2022 12:17:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT100.mail.protection.outlook.com (10.13.172.247) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5813.12 via Frontend Transport; Tue, 15 Nov 2022 12:17:57 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 15 Nov
 2022 06:17:54 -0600
Date:   Tue, 15 Nov 2022 13:17:51 +0100
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
        Dave Jiang <dave.jiang@intel.com>,
        Terry Bowman <terry.bowman@amd.com>
Subject: Re: [PATCH v3 2/9] cxl/acpi: Extract component registers of
 restricted hosts from RCRB
Message-ID: <Y3ODbwk+12JvWyhJ@rric.localdomain>
References: <20221109104059.766720-1-rrichter@amd.com>
 <20221109104059.766720-3-rrichter@amd.com>
 <6372b35953580_12cdff294b7@dwillia2-xfh.jf.intel.com.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6372b35953580_12cdff294b7@dwillia2-xfh.jf.intel.com.notmuch>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT100:EE_|DS7PR12MB6095:EE_
X-MS-Office365-Filtering-Correlation-Id: 179b7604-4681-4714-04e8-08dac7036e56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8TZrWDMupoKHkgqMy29aEJzeQw3X5Wv0c0qkwT1AeGYymUpFbtExzPSc0as/rGBs9um2rKOVagkRR+00v2HfwJV/VThvxY1ojVIsdqfznnNfci1Kik5Mo6s7iS9OM/9UOhl2sGPvXfJ7KhzUe1Jkxzrg9TM+DyYCyTjxciETPmT+whlIlyafeRqmdh3mOszN2FaFLVwW6PNTOFPdzNSgtZclxW0sygyRfrnZND6okGbhVQHyqLRyI7tP6zFhWZ958DSCofKB72pZDqEFs6evyeIKqgvzmBy2AQDNiGwTbWe1+FaoVlEWdJ25+4Io3cdzecIqnZ/6qqIoCJ7L1jTSXM1/ek1iGwolc2s5IZ5FyukB+mP/PYDTo7BPM5UfLs3kYUn2vNf8JEVF9A+wPIedBaIgHVut/9HFfBor9uTGxqvO+p5KZDvrZTgpmipV1G/8ziiZ18sByhESEn7tR2F24zSUDaPXJTFAAPyiaiaKb9cSAgAQXr5/en/A+LI6bVtBbqtfBgfOkpNayxqqzU1CbWgDk4WiOW86uXxqNQuTYKbDSJR5Yi1BRI/JVHwVT6B8b5FhdkJFfgf/p4PrEt93xZiddRNK5nl6u0zz3CDc+QJHJBjWPabr0XYU1oUJ0znG6nG8uUBQXxCZhCc5bQyzC2btO1lrJc8sh7sTWf7Zn91DR2GwahLgMwrR+7IBDDB3nXSy2w+xPDnGjX6T+iZFMnmHRd9HXnXm5LoZrTrajWUjd7U2m4m5ZhAesV/sn0Nw51Hx/jnP7TtzahjoIABbGrsteJREg81FtkZXgi1uxTCZ48WpidPTzJ2mXlWAMyzf4qz5tEuuTOHe9gDryizFNg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(376002)(136003)(346002)(451199015)(36840700001)(40470700004)(46966006)(82310400005)(8936002)(478600001)(356005)(6666004)(316002)(81166007)(6916009)(55016003)(40460700003)(2906002)(54906003)(83380400001)(41300700001)(40480700001)(4326008)(70586007)(70206006)(82740400003)(5660300002)(186003)(7416002)(16526019)(26005)(47076005)(9686003)(8676002)(53546011)(336012)(7696005)(36860700001)(426003)(36900700001)(67856001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2022 12:17:57.5525
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 179b7604-4681-4714-04e8-08dac7036e56
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT100.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6095
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.11.22 13:30:01, Dan Williams wrote:
> Robert Richter wrote:

> > diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
> > index ec178e69b18f..7a5bde81e949 100644
> > --- a/drivers/cxl/core/regs.c
> > +++ b/drivers/cxl/core/regs.c
> > @@ -307,3 +307,49 @@ int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
> >  	return -ENODEV;
> >  }
> >  EXPORT_SYMBOL_NS_GPL(cxl_find_regblock, CXL);
> > +
> > +resource_size_t cxl_rcrb_to_component(struct device *dev,
> > +				      resource_size_t rcrb,
> > +				      enum cxl_rcrb which)
> > +{
> > +	resource_size_t component_reg_phys;
> > +	u32 bar0, bar1;
> > +	void *addr;
> > +
> > +	if (which == CXL_RCRB_UPSTREAM)
> > +		rcrb += SZ_4K;
> > +
> > +	/*
> > +	 * RCRB's BAR[0..1] point to component block containing CXL
> > +	 * subsystem component registers. MEMBAR extraction follows
> > +	 * the PCI Base spec here, esp. 64 bit extraction and memory
> > +	 * ranges alignment (6.0, 7.5.1.2.1).
> > +	 */
> 
> A request_mem_region() is needed here to ensure ownership and expected
> sequencing of accessing the RCRB to locate the component registers, and
> accessing the RCRB to manipulate the component registers. It also helps
> to sanity check that the BIOS mapped an exclusive range for the RCRB.

Right, that is missing.

> 
> > +	addr = ioremap(rcrb, PCI_BASE_ADDRESS_0 + SZ_8);
> 
> That PCI_BASE_ADDRESS_0 does not belong there. It ends up being benign
> and forcing ioremap to map 12K instead of 8K, but it is a
> config-register offset, not part of the RCRB size.

Note this is BAR0 + 8 bytes, not 8k, and it does not map the whole
RCRB region but instead the first part of the config space up to
including the 64 bit BAR.

> 
> > +	if (!addr) {
> > +		dev_err(dev, "Failed to map region %pr\n", addr);
> > +		return CXL_RESOURCE_NONE;
> > +	}
> > +
> > +	bar0 = readl(addr + PCI_BASE_ADDRESS_0);
> > +	bar1 = readl(addr + PCI_BASE_ADDRESS_1);
> > +	iounmap(addr);
> 
> ...corresponding release_mem_region() would go here.
> 
> > +
> > +	/* sanity check */
> > +	if (bar0 & (PCI_BASE_ADDRESS_MEM_TYPE_1M | PCI_BASE_ADDRESS_SPACE_IO))
> > +		return CXL_RESOURCE_NONE;
> 
> I would have also expected:
> 
> - a sanity check for "Memory Space Enable" being set in the command
>   register.

Ok.

> 
> - an explicit check for 0xffffffff for the case when the upstream-port
>   implements "no RCRB" mode.

Yes, I left support for this to a later patch, but it's better to
check it here already and possibly fall back to reg loc DVSEC then.

> 
> - some check that BIOS initialized the BAR values post reset given these
>   BARs are invisible to the PCI core resource assignment 

What check do you have in mind here? There is already the NULL check
which would be the out-of-reset value.

Thanks,

-Robert
