Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4510262E40E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 19:25:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240030AbiKQSZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 13:25:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240291AbiKQSZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 13:25:33 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2076.outbound.protection.outlook.com [40.107.243.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EB058514D;
        Thu, 17 Nov 2022 10:25:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d4VswUHbPW9PZDNE+1NzSvMMCCnPbygtxu3FhEM16UubDQevxzt5nBMlS1Tavj4r9rJ+xUUd4ijotU0mV2lIjN6H+frYs959zolLUae15psk1dHda3GenaZcRgDVhsxykQ8QhRb+e24zLEaiGZKv909iljl4EtwMv60Bz6U/IV7qEOajtl6DH37iJ/l49kFPjfhY9pK4gCaoUnBcPL9AaSPpYkIkqWQZ6qmXJs53W2d5PQnrrUq87mjFT5n+vaR7I7UCz/Tox+OdS2VW/Uq6EJNiqcIZIIUYJu/xS6kdencXMgXKXSV5jWP4VELBG+9sy2XWTb7TRbMB8YlCRFHZOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9BL1PbecmUkUq6YIxLKNsPjR07bkN1QItazwLIEv1uY=;
 b=SNMYdbQm7ONvTFaorPO6+p3KiQKlsxIgx2PSSUfjrHZ678USiHolQeBisy0sIc469FhHWI6KdlA12awsUC8oZXxcdryad10xQE1/NtVp6oia1bP5or3WzqZDrM6kPL8oNdmYuYTyA2e+wzxrU4p0o2UbP09YguwwZvv30Tu5ku3i4LAG4s/UnhZmsxkpA0IkmRmN6LlEgCz4p3RvUPAhXnXaA9apggpJqcfTYyvn0BKPL6A+zzBMqADHT2r8reSunTbW40clCN4xILkLUGswc0H7SjICTm3NvRodggUNb11OFs98dG6fC1S5PuKgY3q/pmKwrtekktmAjDjy41MIGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9BL1PbecmUkUq6YIxLKNsPjR07bkN1QItazwLIEv1uY=;
 b=VycT7lKh5yqtPJ1U0G4BzHuNp6Qf4QwBA5IGhWl20qbgqr/Bvg7jG3bz+Bvb6YCMVUP1S2xZC6+zGXsS7xophNvPT6GhNVwPFwW9zeboXAheFaPDYezyL8bXX8tBPu9yQQZdOPBdyMnVRC5IjTAZwnrfG6blqP2bymxdWk0ls84=
Received: from DM6PR02CA0079.namprd02.prod.outlook.com (2603:10b6:5:1f4::20)
 by MN2PR12MB4287.namprd12.prod.outlook.com (2603:10b6:208:1dd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.18; Thu, 17 Nov
 2022 18:25:28 +0000
Received: from DS1PEPF0000B078.namprd05.prod.outlook.com
 (2603:10b6:5:1f4:cafe::7e) by DM6PR02CA0079.outlook.office365.com
 (2603:10b6:5:1f4::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.20 via Frontend
 Transport; Thu, 17 Nov 2022 18:25:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000B078.mail.protection.outlook.com (10.167.17.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5813.11 via Frontend Transport; Thu, 17 Nov 2022 18:25:27 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 17 Nov
 2022 12:25:24 -0600
Date:   Thu, 17 Nov 2022 19:25:21 +0100
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
Message-ID: <Y3Z8kZym/37P6/yg@rric.localdomain>
References: <20221109104059.766720-1-rrichter@amd.com>
 <20221109104059.766720-3-rrichter@amd.com>
 <6372b35953580_12cdff294b7@dwillia2-xfh.jf.intel.com.notmuch>
 <Y3ODbwk+12JvWyhJ@rric.localdomain>
 <6373d24866bc9_12cdff294e3@dwillia2-xfh.jf.intel.com.notmuch>
 <Y3YoBpIsgRRbRyLk@rric.localdomain>
 <63766d77d1ece_12cdff29499@dwillia2-xfh.jf.intel.com.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <63766d77d1ece_12cdff29499@dwillia2-xfh.jf.intel.com.notmuch>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000B078:EE_|MN2PR12MB4287:EE_
X-MS-Office365-Filtering-Correlation-Id: 11acf30f-63a9-476d-00fa-08dac8c91a34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cKVxxtViTNNibrIbWf7An1MKwFmUZM0Ym/iADvEu8QTyP9ZqTHPdHZ+8AzGrjlb5Myoe+lqE7OmTYY4pzm+XeChuQoeB2rMtecqJKZdnM7gU1WM2sFJUMkVMoBtNQKEFReGv7ojliu9oZ5Pp3FiPweg4IoCcft4ep4aPkl3USy+xarwHMLkuBsviBg7Gtenhl1tM5p5XGi15ijml2e83aSLSPdn9vCLev4h5SLhHjoZGwr5Qf715db+PFUbzrJIajqxR9p/6bINBrREBUEHbpFnNuvyKKvCXygHQgEi3PtUeiq8olZrsY6CTNpksX8It+5hhOJbF+UhYY7u9otIR6SPCKfu0Ithv2M2YkcSKtH4SKOUZ5WmEnm3leBsPI7rSmV2EupAin5GHOeEJDtXA1I1Ps+OkonhpAPUiRftSyp7fEjQ+zYTxUmcm/2GyOC5Pl33dfcZCA0rXc+5TNXpMKxBC+4Y+KLxGI581u9qCK41r71ONiGPy01k+W7T7F7MYVHp2sNI+iOlALYMOC3XcAO1TqQudmm/EwNNRCDE09f4vEz/6Q1i5Rquxex4jDuT7VmLMnmbNC7f8hShj81h16VriDSlCuFwQUp7SJ5fyvO1pwke1Ruf4z4OuYSnGxUDShXclaQA0ZMzMGJsmz87KUOXOROzx6z+5aMtU6OGKujE/RDLKlO04pbuDXsJFvgLeWyv09HA+YUeeqH4PeVaDSdbj/zvRF0wBwTkZCII3uFA=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(396003)(136003)(39860400002)(451199015)(46966006)(40470700004)(36840700001)(356005)(81166007)(5660300002)(2906002)(8936002)(7416002)(55016003)(4326008)(16526019)(336012)(186003)(82310400005)(36860700001)(47076005)(53546011)(40460700003)(41300700001)(8676002)(70586007)(70206006)(478600001)(82740400003)(9686003)(40480700001)(83380400001)(26005)(6666004)(426003)(7696005)(54906003)(316002)(6916009)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2022 18:25:27.9318
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11acf30f-63a9-476d-00fa-08dac8c91a34
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000B078.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4287
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.11.22 09:20:55, Dan Williams wrote:
> Robert Richter wrote:
> > On 15.11.22 09:54:16, Dan Williams wrote:
> > > Robert Richter wrote:
> > > > On 14.11.22 13:30:01, Dan Williams wrote:
> > > > > Robert Richter wrote:
> > > > 
> > > > > > diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
> > > > > > index ec178e69b18f..7a5bde81e949 100644
> > > > > > --- a/drivers/cxl/core/regs.c
> > > > > > +++ b/drivers/cxl/core/regs.c
> > > > > > @@ -307,3 +307,49 @@ int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
> > > > > >  	return -ENODEV;
> > > > > >  }
> > > > > >  EXPORT_SYMBOL_NS_GPL(cxl_find_regblock, CXL);
> > > > > > +
> > > > > > +resource_size_t cxl_rcrb_to_component(struct device *dev,
> > > > > > +				      resource_size_t rcrb,
> > > > > > +				      enum cxl_rcrb which)
> > > > > > +{
> > > > > > +	resource_size_t component_reg_phys;
> > > > > > +	u32 bar0, bar1;
> > > > > > +	void *addr;
> > > > > > +
> > > > > > +	if (which == CXL_RCRB_UPSTREAM)
> > > > > > +		rcrb += SZ_4K;
> > > > > > +
> > > > > > +	/*
> > > > > > +	 * RCRB's BAR[0..1] point to component block containing CXL
> > > > > > +	 * subsystem component registers. MEMBAR extraction follows
> > > > > > +	 * the PCI Base spec here, esp. 64 bit extraction and memory
> > > > > > +	 * ranges alignment (6.0, 7.5.1.2.1).
> > > > > > +	 */
> > > > > 
> > > > > A request_mem_region() is needed here to ensure ownership and expected
> > > > > sequencing of accessing the RCRB to locate the component registers, and
> > > > > accessing the RCRB to manipulate the component registers. It also helps
> > > > > to sanity check that the BIOS mapped an exclusive range for the RCRB.
> > > > 
> > > > Right, that is missing.
> > > > 
> > > > > 
> > > > > > +	addr = ioremap(rcrb, PCI_BASE_ADDRESS_0 + SZ_8);
> > > > > 
> > > > > That PCI_BASE_ADDRESS_0 does not belong there. It ends up being benign
> > > > > and forcing ioremap to map 12K instead of 8K, but it is a
> > > > > config-register offset, not part of the RCRB size.
> > > > 
> > > > Note this is BAR0 + 8 bytes, not 8k, and it does not map the whole
> > > > RCRB region but instead the first part of the config space up to
> > > > including the 64 bit BAR.
> > > 
> > > Oh, sorry, yes, my mistake. However, there is not much value in mapping
> > > less than 4K since all ioremap requests are rounded up to PAGE_SIZE.
> > > Since an RCRB is only 4K per port lets just map the whole thing.
> > 
> > I was going to keep the ranges small to avoid conflicts with other
> > requests for the same page (though request_mem_region() was missing
> > yet).
> 
> What else will be conflicting the RCRB? Linux has never accessed an RCRB
> in the past as far as I can see. If there is a conflict then we may need
> to move this mapping to the PCI core so that it is managed like other
> mmconf space.

The capabilities (PCIe and DVSEC) could be used by various subsystems
and parts of the driver. I am thinking of the various RAS caps (UP,
DP, CXL, AER variants) that are accessed from different parts of the
driver. Of curse, access could be delegated but else there is the
option to directly map and access that parts. In the component reg
block we already see issues with that broad mappings.

-Robert
