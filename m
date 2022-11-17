Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B00762DBE7
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 13:47:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239572AbiKQMrc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 07:47:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240307AbiKQMrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 07:47:12 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2056.outbound.protection.outlook.com [40.107.244.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C81F74CC0;
        Thu, 17 Nov 2022 04:44:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lEBfbCItdR0evu0NiJlWdrZrVK/ALQIuvbAOx/QOq95suJGiegLL2kIwewztOF2+hx9KZU8PzwfKMVVIvCUxieabNi6mdzYL21TvuWL0iXjuUVT5YYUB8cs4bTh9OGQ4vVARjotMEYWIAj1pPHAcVeiR1lhwkuWWpmtD1y5Ode90Whk6ciT0w8jPABTHIi2wm0/pNfgtc+F7kz7L6d17cyLIr5PvA3cPvXcE3oVe9Xf2FwxyLULytv9IMUSFizSVoHAfR5Y5rR7J8OqSF5kKMWogLlaufEpfllm7gO7FwwGHgvfni+BkkGiyQ1VmauFCQpD2tzh1KQXg62zLOhoHPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qzVSVHJjD87v1GYXFZ7p4Znu0AqFaVbaUa99N9wB6wk=;
 b=f9PO4bmRmEkaNs8Z4bWIm4mQcmvkJz4HGjp2fdPYvNaVicn8kI6d7gMdpAC9Shjkw8eB7A6fJQARHB7CvgPmdttXqsjpg2w3qpHz2oqxeumIHajNI2AKsi7V+QQ2JjBlBVIY0F1xn4HeBskcK5+zeagNvY2OrhXzjRk7r/o2jsiEpW/15UfhgAmKw3VStkyGtgRyDpoe7y+xeT92ia6rBrDh8zMn20TtPmW0dml/uK9w97Ra9I1+O8jnA8wy4rv/gJNFDBCn92lQp1ekYbffgrDFlVKSc9fPYp/laXy3Ie4I5v+nNOKLOB9MYgUEaewxWv3Hp00vnkYMufue/iBkMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qzVSVHJjD87v1GYXFZ7p4Znu0AqFaVbaUa99N9wB6wk=;
 b=RzSJVjVJznIDvUZd5CU2NyWC4YYPtULUSY7N4pytaXvQ8H/uftQOUJSebBsAQTP7AHJWaDdoHRx1ifCv6jol8U+PzLbPhuL9BDT53joIZ3NLMb65vLi2c9a0GbCtH0kApY8GL+6mESORBaOxD/gm4tSDHOkDj0R8wmh8WpvNOBA=
Received: from BN7PR06CA0062.namprd06.prod.outlook.com (2603:10b6:408:34::39)
 by LV2PR12MB5725.namprd12.prod.outlook.com (2603:10b6:408:14c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.19; Thu, 17 Nov
 2022 12:44:07 +0000
Received: from BN8NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:34:cafe::8c) by BN7PR06CA0062.outlook.office365.com
 (2603:10b6:408:34::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.20 via Frontend
 Transport; Thu, 17 Nov 2022 12:44:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT049.mail.protection.outlook.com (10.13.177.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5834.8 via Frontend Transport; Thu, 17 Nov 2022 12:44:07 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 17 Nov
 2022 06:44:04 -0600
Date:   Thu, 17 Nov 2022 13:43:52 +0100
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
Message-ID: <Y3YoBpIsgRRbRyLk@rric.localdomain>
References: <20221109104059.766720-1-rrichter@amd.com>
 <20221109104059.766720-3-rrichter@amd.com>
 <6372b35953580_12cdff294b7@dwillia2-xfh.jf.intel.com.notmuch>
 <Y3ODbwk+12JvWyhJ@rric.localdomain>
 <6373d24866bc9_12cdff294e3@dwillia2-xfh.jf.intel.com.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6373d24866bc9_12cdff294e3@dwillia2-xfh.jf.intel.com.notmuch>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT049:EE_|LV2PR12MB5725:EE_
X-MS-Office365-Filtering-Correlation-Id: 4aec258c-e5ca-409d-d655-08dac8996ac5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XY8Oi1actovMHr7hRc4utmhUEUbCAGJ1pPdwKXyq3HHIZYODuE64sYA2tt6tcMP60NajT0usTOhXDn9snyT98YxRoRg3o8WPCJhmWHiqk9gpBnkz8VZ77FBtftl4U/4D6AOX1fXHTSwRYgdR09nMCnDAQ1tot36xKrqaVjljwUNoODhhtrdvX+aaKftN2tPS3UpBeumqCs2Aq6Z/up7JeWGRmknjDlELh37d/6hiYc7gIVr1EzCsarnjv5kAeW/2/p2kAPM6sRi0a8pvf3/32r356p35W/WRUQaJGP5UZmJqT2f808A0ZvRS/IuRwtUdYg5CzhTA2GR1e5xzJ2Rw1ZNnSU4hFcYrTI8TsWX651kUocjTMHnX49nnI73vFYudJTf4YA89b3rEf1mxeEkstw5+IBMknK0N9kcTX+VvmDx30FeRFdPPiXirvdIYd6WOLCNPQCbmzFYZLKjjJonwOSSi5DFaBW4Ldlb6VuZUTedHwknbTIgbJLs5djfPGSlud6Xz1Zd8T87bPeTcKY5K7O0f1z6eaWNz/pQJuX11Jx7RBTCh88E6rDXufC/g/NYleEMuE6HKR9yGUqNhGVFDHPmUJBF8wvOrg4dmCr4/KhJB5u0D09xGFr/7/Bcf4h0NeSgssolZ8RumabY6YteClqsD6CfeuM3gAk2+is3zERC14OcghtGHDVoLBsbm0C+qx5Htc4GqXoXPtyToxpPcabV/f+3E7IBwz5uRXLFThOU=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(346002)(396003)(136003)(451199015)(36840700001)(40470700004)(46966006)(186003)(16526019)(7696005)(356005)(81166007)(82740400003)(36860700001)(82310400005)(55016003)(7416002)(336012)(426003)(40460700003)(53546011)(9686003)(26005)(2906002)(47076005)(8936002)(5660300002)(6666004)(478600001)(40480700001)(41300700001)(316002)(54906003)(70586007)(83380400001)(6916009)(70206006)(4326008)(8676002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2022 12:44:07.2779
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4aec258c-e5ca-409d-d655-08dac8996ac5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5725
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.11.22 09:54:16, Dan Williams wrote:
> Robert Richter wrote:
> > On 14.11.22 13:30:01, Dan Williams wrote:
> > > Robert Richter wrote:
> > 
> > > > diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
> > > > index ec178e69b18f..7a5bde81e949 100644
> > > > --- a/drivers/cxl/core/regs.c
> > > > +++ b/drivers/cxl/core/regs.c
> > > > @@ -307,3 +307,49 @@ int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
> > > >  	return -ENODEV;
> > > >  }
> > > >  EXPORT_SYMBOL_NS_GPL(cxl_find_regblock, CXL);
> > > > +
> > > > +resource_size_t cxl_rcrb_to_component(struct device *dev,
> > > > +				      resource_size_t rcrb,
> > > > +				      enum cxl_rcrb which)
> > > > +{
> > > > +	resource_size_t component_reg_phys;
> > > > +	u32 bar0, bar1;
> > > > +	void *addr;
> > > > +
> > > > +	if (which == CXL_RCRB_UPSTREAM)
> > > > +		rcrb += SZ_4K;
> > > > +
> > > > +	/*
> > > > +	 * RCRB's BAR[0..1] point to component block containing CXL
> > > > +	 * subsystem component registers. MEMBAR extraction follows
> > > > +	 * the PCI Base spec here, esp. 64 bit extraction and memory
> > > > +	 * ranges alignment (6.0, 7.5.1.2.1).
> > > > +	 */
> > > 
> > > A request_mem_region() is needed here to ensure ownership and expected
> > > sequencing of accessing the RCRB to locate the component registers, and
> > > accessing the RCRB to manipulate the component registers. It also helps
> > > to sanity check that the BIOS mapped an exclusive range for the RCRB.
> > 
> > Right, that is missing.
> > 
> > > 
> > > > +	addr = ioremap(rcrb, PCI_BASE_ADDRESS_0 + SZ_8);
> > > 
> > > That PCI_BASE_ADDRESS_0 does not belong there. It ends up being benign
> > > and forcing ioremap to map 12K instead of 8K, but it is a
> > > config-register offset, not part of the RCRB size.
> > 
> > Note this is BAR0 + 8 bytes, not 8k, and it does not map the whole
> > RCRB region but instead the first part of the config space up to
> > including the 64 bit BAR.
> 
> Oh, sorry, yes, my mistake. However, there is not much value in mapping
> less than 4K since all ioremap requests are rounded up to PAGE_SIZE.
> Since an RCRB is only 4K per port lets just map the whole thing.

I was going to keep the ranges small to avoid conflicts with other
requests for the same page (though request_mem_region() was missing
yet).

> 
> > > > +	if (!addr) {
> > > > +		dev_err(dev, "Failed to map region %pr\n", addr);
> > > > +		return CXL_RESOURCE_NONE;
> > > > +	}
> > > > +
> > > > +	bar0 = readl(addr + PCI_BASE_ADDRESS_0);
> > > > +	bar1 = readl(addr + PCI_BASE_ADDRESS_1);
> > > > +	iounmap(addr);
> > > 
> > > ...corresponding release_mem_region() would go here.
> > > 
> > > > +
> > > > +	/* sanity check */
> > > > +	if (bar0 & (PCI_BASE_ADDRESS_MEM_TYPE_1M | PCI_BASE_ADDRESS_SPACE_IO))
> > > > +		return CXL_RESOURCE_NONE;
> > > 
> > > I would have also expected:
> > > 
> > > - a sanity check for "Memory Space Enable" being set in the command
> > >   register.
> > 
> > Ok.
> > 
> > > 
> > > - an explicit check for 0xffffffff for the case when the upstream-port
> > >   implements "no RCRB" mode.
> > 
> > Yes, I left support for this to a later patch, but it's better to
> > check it here already and possibly fall back to reg loc DVSEC then.
> 
> Yeah, I think simply failing on 0xffffffff is sufficient for now.
> 
> > > 
> > > - some check that BIOS initialized the BAR values post reset given these
> > >   BARs are invisible to the PCI core resource assignment 
> > 
> > What check do you have in mind here? There is already the NULL check
> > which would be the out-of-reset value.
> 
> I was thinking more along the lines of sanity checking that the
> programmed RCRB range falls within the assigned MMIO space of the
> host-bridge, but perhaps that is overkill since it would just be
> validating self consistency between 2 BIOS provided values. Robustness
> principle would say try to continue if those disagree.

Ok, will drop a check here.

Thanks,

-Robert
