Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB63662EF39
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 09:28:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241366AbiKRI2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 03:28:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241358AbiKRI2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 03:28:21 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2072.outbound.protection.outlook.com [40.107.93.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41789682BB;
        Fri, 18 Nov 2022 00:28:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iwL7lhcXBc81QhmVO70S7jbHKAbhSOwWPWvtXrWZQKKc1fABvS2t7qvIN/4lQB0aV6AKSCdUTFE2MzUcCM3Vdd/wc2baftt3XY6f3yFJauvzBzmwSDBGqnSzfJqBZGv9h2WZo9Bykr+e6I7TuJCsMr8I+Hc8JoR4ftZqbYftzLdPHfNgVrNTxnqDtC2UP9SbXKQ3kvK72wcM73K7R/of5B2oh9QY/FNX24Whjn9IuC9QN4T5RMyvbV7JTJwcXIshHC9drk0qKt9m22+46bAoGByZPPlsgemz43prnY1mCFaFIMqZMp8D/IUulRxMISD0y4n7YLcpv3CX9jortP4UTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7//Q5+RMPbDX0kEd/rAdw1EZsTnMG6y4PY/ik7Rht5c=;
 b=a5tauBNR8jcPoYCsNIsVk88Uv8QsDHpiKp8tpRnosz6YDOiGO8Vy26O3yAW+64nrcP0uJNLBQrEhkZRBk9DDtjLXdNjlQbV9r7999oRqcW2AoTxRaP6PnGuynZjQ/jLsj81RVBu1FJh6U2h11UD0BTjHb54wiLqup3lbU7FQXv2skJa0Zo/mdYv8NKnwuhp8N6/U772+9vV0q1aP9Yrc8Jc+OUVDkvtl3v0NOX4hjNl0nXPElcN0suj5KF3Jl2/LzEeAQanScxgq1RmupxcsJLdP1/+CiEurX6DWQqM4hDb6YDEHxPNo18gqsnZnobgUB2wHhYHcs/lBR0TcDOGZWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7//Q5+RMPbDX0kEd/rAdw1EZsTnMG6y4PY/ik7Rht5c=;
 b=wU0u6CocuAQYNCGaNz1RVyMr8+EkE8tykn97nmsFTcpEjtrg9HWBMGe3j0YZobOPkv7IGAaTSJJ4iFcAmYA2LCW9kAjXYc4n61vZz4czftfwI538JUzN7180SeKn+eOAJ9aIftm36AXk+mHC1/udPu2+ZI7xRTVfrs32+zrGuKw=
Received: from BN1PR12CA0011.namprd12.prod.outlook.com (2603:10b6:408:e1::16)
 by IA1PR12MB6386.namprd12.prod.outlook.com (2603:10b6:208:38a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.20; Fri, 18 Nov
 2022 08:27:57 +0000
Received: from BN8NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e1:cafe::4) by BN1PR12CA0011.outlook.office365.com
 (2603:10b6:408:e1::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.9 via Frontend
 Transport; Fri, 18 Nov 2022 08:27:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT067.mail.protection.outlook.com (10.13.177.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5834.8 via Frontend Transport; Fri, 18 Nov 2022 08:27:57 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 18 Nov
 2022 02:27:24 -0600
Date:   Fri, 18 Nov 2022 09:27:14 +0100
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
Subject: Re: [PATCH v3 5/9] cxl/pci: Only register RCDs with device 0,
 function 0 as CXL memory device
Message-ID: <Y3dB4quvaSzRzsT/@rric.localdomain>
References: <20221109104059.766720-1-rrichter@amd.com>
 <20221109104059.766720-6-rrichter@amd.com>
 <63753900717c6_12cdff29439@dwillia2-xfh.jf.intel.com.notmuch>
 <Y3ZZqZ2kPS1yyOtd@rric.localdomain>
 <63766efb7ceac_12cdff294c3@dwillia2-xfh.jf.intel.com.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <63766efb7ceac_12cdff294c3@dwillia2-xfh.jf.intel.com.notmuch>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT067:EE_|IA1PR12MB6386:EE_
X-MS-Office365-Filtering-Correlation-Id: 12c20c1b-c779-47ed-eae6-08dac93ecc06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YGujR7rgPbiK9xocem8ckt1heXQWM8uV+1zNFqVmb7QSMkyYwi/v20KHcYMQjFM1CnvdRqfaDJHEMd9YO2oUosLC0Cpv7dBb0ECIkhPXXXb3ztfYaqJVtOnyud1uTMLCZtExvgT3IxI7R1N7XLT0IC0k7wtNUy9TYAHdzo9z8P6D9dix/Slrt8fxOooAvh0hlxUW5tig/4dWIimX1EnBFf8HwVILbICb7psZ1HbkVdmw6Qam/iRQAmJMO2iadngW3vNps169J562gW4S2ODHTNIPyACmBZtEKBwbq/7YGTnU2ync7tcLQ8d7VBS6GXIdcUeDcTb8rtqFd332FCcYFRekwPvS46Tv5DkG3nkeTvTjYb1bligkWAX0I4PBuMnKG4AOW6XiO09e00bDoOo0b2m8aSqv0k8pUaxQ6+2rstlcOFnxGZd6PicrhwczIeD/yCfVyRYPYNIazmS38ikVNKrkI6EbP/uiyfLyOE700O9YbgGRCu2/EcM0UhX5XjNEhA8BGu1j64kjuSQzGRJuKbrCq+EWSnN8xy8HrV3/Hdku6PjBbxuoHpgsdg/nzVyCGioyug/dqc6BZdXTf7B20M6WZzF4LKU/+BrvfXx7tady8qdaRwNW1c0XI5MCM8rjWFHH9jf8/3EA0CLc3X8mTmb0lXsD8Q0VQ0epmqe3hRDCwtuOHw8XrkT7rnlHd+twPAOg24Rp5GuT5Za6So8jgkCrP2FbPIEkJhelY1HFyXg=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(346002)(396003)(376002)(451199015)(46966006)(40470700004)(36840700001)(2906002)(36860700001)(83380400001)(40460700003)(40480700001)(41300700001)(70206006)(70586007)(55016003)(8936002)(82310400005)(6916009)(53546011)(7696005)(54906003)(81166007)(356005)(26005)(186003)(5660300002)(7416002)(336012)(16526019)(8676002)(426003)(4326008)(47076005)(82740400003)(316002)(9686003)(478600001)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2022 08:27:57.3257
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12c20c1b-c779-47ed-eae6-08dac93ecc06
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6386
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.11.22 09:27:23, Dan Williams wrote:
> Robert Richter wrote:
> > On 16.11.22 11:24:48, Dan Williams wrote:
> > > Robert Richter wrote:
> > > > The Device 0, Function 0 DVSEC controls the CXL functionality of the
> > > > entire device. Add a check to prevent registration of any other PCI
> > > > device on the bus as a CXL memory device.
> > > 
> > > Can you reference the specification wording that indicates that the OS
> > > needs to actively avoid these situations, or otherwise point to the real
> > > world scenario where this filtering is needed?
> > 
> > CXL 3.0
> > 
> > 8.1.3 PCIe DVSEC for CXL Device
> > 
> > """
> > An RCD creates a new PCIe enumeration hierarchy. As such, it spawns a new Root Bus
> > and can expose one or more PCIe device numbers and function numbers at this bus
> > number. These are exposed as Root Complex Integrated Endpoints (RCiEP). The PCIe
> > Configuration Space of Device 0, Function 0 shall include the CXL PCIe DVSEC as shown
> > in Figure 8-1.
> > """
> > 
> > """
> > In either case, the capability, status, and control fields in Device 0, Function 0 DVSEC
> > control the CXL functionality of the entire device.
> > """
> > 
> > There are some other occurrences. I think this is even true for VH
> > mode, as multiple CXL devices on the bus are exposed through multiple
> > DSPs or Root Ports.
> > 
> > Anyway, I limited this to an RCD only, esp. because its counterpart
> > would be missing and thus port mapping would fail otherwise. See
> > restricted_host_enumerate_dport() of this series.
> > 
> > > 
> > > > 
> > > > Signed-off-by: Robert Richter <rrichter@amd.com>
> > > > ---
> > > >  drivers/cxl/pci.c | 25 +++++++++++++++++++++++--
> > > >  1 file changed, 23 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> > > > index faeb5d9d7a7a..cc4f206f24b3 100644
> > > > --- a/drivers/cxl/pci.c
> > > > +++ b/drivers/cxl/pci.c
> > > > @@ -428,11 +428,26 @@ static void devm_cxl_pci_create_doe(struct cxl_dev_state *cxlds)
> > > >  	}
> > > >  }
> > > >  
> > > > +static int check_restricted_device(struct pci_dev *pdev, u16 pcie_dvsec)
> > > > +{
> > > > +	if (pci_pcie_type(pdev) != PCI_EXP_TYPE_RC_END)
> > > > +		return 0;		/* no RCD */
> > > > +
> > > > +	if (pdev->devfn == PCI_DEVFN(0, 0) && pcie_dvsec)
> > > > +		return 0;		/* ok */
> > > > +
> > > > +	dev_warn(&pdev->dev, "Skipping RCD: devfn=0x%02x dvsec=%u\n",
> > > 
> > > s/0x%02x/%#02x/
> > > 
> > > > +		pdev->devfn, pcie_dvsec);
> > 
> > Ok.
> > 
> > > This looks like a dev_dbg() to me. Otherwise a warning will always fire
> > > on a benign condition.
> > 
> > I have chosen dev_warn() here as this is a non-compliant unexpected
> > behavior of the device. There are no (legal) cases this may happen. I
> > suppose you are worried about spamming the console here, but that
> > error should be reported somewhere and thus being visible.
> 
> There are so many spec illegal values and conditions that the driver
> could checki, but does not. The reason I am poking here is why does the
> driver need to be explicit about *this* illegal condition versus all the
> other potential conditions? What is the practical end user impact if
> Linux does not include this change? For example, if it is just one
> vendor that made this mistake that can be an explicit quirk.
> 
> A dev_warn() is not necessary for simple quirks.

This is not simply a cross check, the driver prevents enablement of
CXL mem devs other than PCI_DEVFN(0, 0). It shouldn't silently drop
out then. It's a device malfunction which should appropriate reported
and not only visible if dbg is enabled.

As written above, the check is necessary as the counterpart is missing
otherwise and init would fail later with a more obfuscating error
message.

-Robert
