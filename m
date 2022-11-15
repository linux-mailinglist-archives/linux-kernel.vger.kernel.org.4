Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DB9962960F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 11:37:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbiKOKhg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 05:37:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232786AbiKOKhf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 05:37:35 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2054.outbound.protection.outlook.com [40.107.237.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A5F865B8;
        Tue, 15 Nov 2022 02:37:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yb5SwGiv8oj7qVhsfMxAzMZeS0jhXUmfU4SdD0/Gcj1d6SE/k+bjelQ2bNZGwVXQwTMo4jG4AsnCwOhfs0gGMjTvN69nSncLgUQs3n2Uedy3PHCOiSMBJ/ZQmkw2f3EvLyj7Snv7orAk7MDBNWp/q0hcecUQO1EFUYJQuAgqmPWP55Jg42eFmGfASGs+ZJMzxwVx+oPWonggMRFvTxKeBloBuBdrLakdCF565tZd8aGhGIYnyaCr8TTI4Fjy+6GLDHRzEyXYg8J+d777Zr9cNnksWBsCU+m/XnA6mbET6X0rdvy7vtVrGAj1THXjLOlBH6pgq2W6Gy2P86vflGxfqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cytf0qlk7TSUvZrbe16FzvUPaOeW7sNJpLVyKBA4dWI=;
 b=da2QFZKyV8RrhNM8Q5EDklTpGWCAX6uDoHH0n0cw1cOvKdX19OusOBoamonoYOq2tWpYTFXRR9earMFMU8BAur2iMd7jFdXpDy6v35+kf16KOjRvQ6v+36svULmQFCqC4vKLbfI/tjOnNEHpeMqZRdc+AxSC0J1FmP97h8EhgY2qsBkSopAHyUw/5NR0iTrwZygQM3Ixg8H71ZdyRuhChTNj9PnXc9vIdCaaL5Vhutq7vr5Hs304AED0X28MRde2MsyJsJNrbH/XoLmJqPhV2tKGpdh6xq5gwOFA+H6gMz2ijtrU5sI6q3sZZkUy6qKQnzm6scKgy9iq1Iyb6yT6DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cytf0qlk7TSUvZrbe16FzvUPaOeW7sNJpLVyKBA4dWI=;
 b=1ABc7GYSPttyEtyumLQzdfSZdawekP6dEwbs/VLfUsy5M3eFREbo+yzqDY0bqpWtO9ejMejFjnp4Oc28RFLGFG/7pnEVAGFsE56j/TT4XHvN25Ik0dzBS1VEclQ8aZzLO9UonUUUdM9tDn+OTZIy+m8Q1LKpMcWssstii1RzwMo=
Received: from MW4P220CA0006.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::11)
 by MW3PR12MB4522.namprd12.prod.outlook.com (2603:10b6:303:5f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.18; Tue, 15 Nov
 2022 10:37:31 +0000
Received: from CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:115:cafe::78) by MW4P220CA0006.outlook.office365.com
 (2603:10b6:303:115::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17 via Frontend
 Transport; Tue, 15 Nov 2022 10:37:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT064.mail.protection.outlook.com (10.13.175.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5813.12 via Frontend Transport; Tue, 15 Nov 2022 10:37:31 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 15 Nov
 2022 04:37:28 -0600
Date:   Tue, 15 Nov 2022 11:37:26 +0100
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
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>
Subject: Re: [PATCH v3 1/9] cxl/acpi: Register CXL host ports by bridge device
Message-ID: <Y3Nr5t2XpK8Ek0as@rric.localdomain>
References: <20221109104059.766720-1-rrichter@amd.com>
 <20221109104059.766720-2-rrichter@amd.com>
 <6372a399b3400_12cdff2945b@dwillia2-xfh.jf.intel.com.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6372a399b3400_12cdff2945b@dwillia2-xfh.jf.intel.com.notmuch>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT064:EE_|MW3PR12MB4522:EE_
X-MS-Office365-Filtering-Correlation-Id: 999e62d0-d0b0-42c3-df72-08dac6f5669f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: loJcBQ9rfE1GSMfeDj84pQLRLLOP6CMahTIyaNofEDOYX/8/UCCcqpu4MwAmftMGPYsvIkpAG2W923sTi5qpyEYaoeMVd+re5MUqPUH6R/qudgrD0X5PkDn9yFU3Bs6sv9tJ65x8OamqoPKwqYRqmQb5Q7pcLjnAU6wObdhGY0cRctkptSRfKWTqSisKJflPkpPlC8nqla/glHjOGXI/7guvk62KoXjc2d6mlQnV37sL8b7zvoPzwDAow6nlbXTstgH84XzoiiWHQ1TWhk91hIFgjkzx4/jfJWCNdqgd90GNgOjwFpzRRTcR9nGvTwPlUHu+2UTGYTg25RE7AaKvNsSXgrlPVB/l4ihZEjSd6/f1aH4HpzBA5MfOnnYuf4PVd9ehGnmXAh/YNdEiIpDFEzJ4XvD45IbISELYLY8QbI2Ek2ixzUTevsnSgDlVsZ9VYOLJ6cr8Dhajd8B8IImRM3Zsz8E0+vV6O1Zjprhi2PzmvGoPwqWUh8m5JRFAd9eTvUou17w5mNOM7FKSCDwvAGyL56XWYqChp33u4l5HoWZJxun4Psf4yirj59AhsD9AbcSPR+R7t0nGEqPcuPEGZbdQQ/uSGgw9dZAri/SEO+zHUaR5MrdWsrhowiEVbw6XWu29d+o+aY/1oBPOgcBnOZS4alRs7ix4AO9p60L31XzOflQE+binkDdPro40lED2O6NcCaexSqWiuMWgixRv0G6ljGXo6dBGAwNFt3gVR3wpROANfvF96od+lF5I1dR6KzcHFtmyVOed07yOmkPjbNg0fFFgowoe3dXODkJS2pxVQggT2IRUzqV1DYtvdkyIzfSQwaTB1a5dhBf1ujWTLg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(396003)(39860400002)(136003)(451199015)(46966006)(40470700004)(36840700001)(82310400005)(336012)(478600001)(966005)(83380400001)(36860700001)(426003)(47076005)(40460700003)(82740400003)(7416002)(5660300002)(8936002)(4326008)(70586007)(70206006)(8676002)(316002)(6916009)(81166007)(356005)(54906003)(41300700001)(40480700001)(2906002)(26005)(16526019)(9686003)(55016003)(53546011)(186003)(7696005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2022 10:37:31.5668
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 999e62d0-d0b0-42c3-df72-08dac6f5669f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4522
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.11.22 12:22:49, Dan Williams wrote:
> Robert Richter wrote:
> > A port of a CXL host bridge links to the bridge's acpi device
> > (&adev->dev) with its corresponding uport/dport device (uport_dev and
> > dport_dev respectively). The device is not a direct parent device in
> > the PCI topology as pdev->dev.parent points to a PCI bridge's (struct
> > pci_host_bridge) device. The following CXL memory device hierarchy
> > would be valid for an endpoint once an RCD EP would be enabled (note
> > this will be done in a later patch):
> > 
> > VH mode:
> > 
> >  cxlmd->dev.parent->parent
> >         ^^^\^^^^^^\ ^^^^^^\
> >             \      \       pci_dev (Type 1, Downstream Port)
> >              \      pci_dev (Type 0, PCI Express Endpoint)
> >               cxl mem device
> > 
> > RCD mode:
> > 
> >  cxlmd->dev.parent->parent
> >         ^^^\^^^^^^\ ^^^^^^\
> >             \      \       pci_host_bridge
> >              \      pci_dev (Type 0, RCiEP)
> >               cxl mem device
> > 
> > In VH mode a downstream port is created by port enumeration and thus
> > always exists.
> > 
> > Now, in RCD mode the host bridge also already exists but it references
> > to an ACPI device. A port lookup by the PCI device's parent device
> > will fail as a direct link to the registered port is missing. The ACPI
> > device of the bridge must be determined first.
> > 
> > To prevent this, change port registration of a CXL host to use the
> > bridge device instead. Do this also for the VH case as port topology
> > will better reflect the PCI topology then.
> > 
> > If a mock device is registered by a test driver, the bridge pointer
> > can be NULL. Keep using the matching ACPI device (&adev->dev) as a
> > fallback in this case.
> > 
> > Signed-off-by: Robert Richter <rrichter@amd.com>
> > ---
> >  drivers/cxl/acpi.c | 48 ++++++++++++++++++++++++++++++----------------
> >  1 file changed, 31 insertions(+), 17 deletions(-)
> > 
> > diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> > index fb9f72813067..06150c953f58 100644
> > --- a/drivers/cxl/acpi.c
> > +++ b/drivers/cxl/acpi.c
> > @@ -185,6 +185,17 @@ __mock struct acpi_device *to_cxl_host_bridge(struct device *host,
> >  	return NULL;
> >  }
> >  
> > +static inline struct acpi_pci_root *to_cxl_pci_root(struct device *host,
> > +						    struct device *match)
> > +{
> > +	struct acpi_device *adev = to_cxl_host_bridge(host, match);
> > +
> > +	if (!adev)
> > +		return NULL;
> > +
> > +	return acpi_pci_find_root(adev->handle);
> > +}
> > +
> >  /*
> >   * A host bridge is a dport to a CFMWS decode and it is a uport to the
> >   * dport (PCIe Root Ports) in the host bridge.
> > @@ -193,35 +204,35 @@ static int add_host_bridge_uport(struct device *match, void *arg)
> >  {
> >  	struct cxl_port *root_port = arg;
> >  	struct device *host = root_port->dev.parent;
> > -	struct acpi_device *bridge = to_cxl_host_bridge(host, match);
> > -	struct acpi_pci_root *pci_root;
> > +	struct acpi_pci_root *pci_root = to_cxl_pci_root(host, match);
> >  	struct cxl_dport *dport;
> >  	struct cxl_port *port;
> > +	struct device *bridge;
> >  	int rc;
> >  
> > -	if (!bridge)
> > +	if (!pci_root)
> >  		return 0;
> >  
> > -	dport = cxl_find_dport_by_dev(root_port, match);
> > +	/*
> > +	 * If it is a mock dev, the bridge can be NULL, use matching
> > +	 * device (&adev->dev) as a fallback then then.
> > +	 */
> > +	bridge = pci_root->bus->bridge ?: match;
> 
> While I appreciate that you ran this against the unit tests, production
> code should not know or care about the presence of mock devices. So,
> this was showing a gap in the mock implementation, now addressed here:
> 
> http://lore.kernel.org/r/166845667383.1449826.14492184009399164787.stgit@dwillia2-xfh.jf.intel.com

Yes, with that update the above check can be dropped and the code can
be implemented now without the helper. The patch below looks good to
me. Going to run a test with it.

> 
> With that, this approach can be simplified to the following:
> 
> -- >8 --
> >From 3cb7a46e100d016132727ad32904b629061e40d5 Mon Sep 17 00:00:00 2001
> From: Robert Richter <rrichter@amd.com>
> Date: Mon, 14 Nov 2022 12:20:27 -0800
> Subject: [PATCH v4] cxl/acpi: Register CXL host ports by bridge device

Thanks,

-Robert
