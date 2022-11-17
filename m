Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 714D862E071
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 16:56:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239820AbiKQP4o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 10:56:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239817AbiKQP4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 10:56:37 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2078.outbound.protection.outlook.com [40.107.92.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 137D4786CB;
        Thu, 17 Nov 2022 07:56:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cZDu0eQJJCqz03ckBLa322fq6ZobUJLav+QjCvs2Km5OH/lC5Yg17HPxcI6F+klDPqAtTovbWa0fW7BgRtjMnejr6XoA5UgvPSWtovBN7TgIN17p2zm5PtdWjh05RcVzo1h4cXnGLy48dg/drghdH8pBZ7bSw4gj9gDOYPJ11Rb7Tuw6V43v+Hd1JYCfYnUYSlXepD0x0THdSaHZo1c+SAm8WEp0tuVvUpxmTzLWbQBQwq+Ff7Rp2mkIYZNHmMRiQDdO/x60rZ2nZvLWIK0KAKYug815UntOTkTqgJtKq25RD9sWljJWqALQYo4Ko2hrizK4fJGfhJAGzj6yBHluhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kvP7lDK1pbEE5yE4tHrZzhBUKUawPRBCBkLw1Zvgtv0=;
 b=ANoYcOQTh3TuG0mo1NbB3IUFsC6CMAF6MZOiou3Ol4YA2g+2sOFHMBeMUvdeu35wAtXaADMdr2Kqht4xaj/PszL2Gs36xZz99iwEewuGl3SHF+psIWG6leIFJEKuqpQKfDVWzP7kxyg8/OOyqTi9AYrikp9JF8zavtrPRG3EUi+xRfMHfXuVbYKXP4bb5vRJbg2N4CLL6X6UUq9yMEwYlYH4/bEI+1ko/h/zMsn9znpn4ZXiAuu2A2R8YaT/skpWCI/S8/KKdAP1ag9XcrzVrYcPIC/n97iQE95aBphtpqlZdNrZzMiHN45xCUKetR7aIx6XMfjfuEvmo+OcbLn9DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kvP7lDK1pbEE5yE4tHrZzhBUKUawPRBCBkLw1Zvgtv0=;
 b=0sZE3l6nkTcJnErxcykBkh0Q+9b0/ulk9E2jyr4Oyb5BYe9143q7P9yLy5NCxKEPL4BQB9ZJz2RWXyQa6CKZ0KEwAW01Nv3pykHN9qFNqgiddYIW5VcQq5x2YEirrHoQBdX0XB+8wuLmQJQwaHPxv89xAzSZjJrVLWK9XFFS/co=
Received: from DS7PR06CA0024.namprd06.prod.outlook.com (2603:10b6:8:2a::8) by
 CY8PR12MB7098.namprd12.prod.outlook.com (2603:10b6:930:62::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5813.18; Thu, 17 Nov 2022 15:56:32 +0000
Received: from DM6NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2a:cafe::3a) by DS7PR06CA0024.outlook.office365.com
 (2603:10b6:8:2a::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.20 via Frontend
 Transport; Thu, 17 Nov 2022 15:56:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT024.mail.protection.outlook.com (10.13.172.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5834.8 via Frontend Transport; Thu, 17 Nov 2022 15:56:32 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 17 Nov
 2022 09:56:28 -0600
Date:   Thu, 17 Nov 2022 16:56:25 +0100
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
Message-ID: <Y3ZZqZ2kPS1yyOtd@rric.localdomain>
References: <20221109104059.766720-1-rrichter@amd.com>
 <20221109104059.766720-6-rrichter@amd.com>
 <63753900717c6_12cdff29439@dwillia2-xfh.jf.intel.com.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <63753900717c6_12cdff29439@dwillia2-xfh.jf.intel.com.notmuch>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT024:EE_|CY8PR12MB7098:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b0cd3c0-895c-4440-b01a-08dac8b44c0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b5N47htmdSd8apjpA51a2mroqzA/QVwS45NkWa4FyxmFrVJcCtmmWSNu9KCoEae5jkND9gk0OIL0lRt0D668WePY1ytTlCpvhTDjA1WBxRHTMoq1yR8/ySEPStRgRstO+sNS5wjV3LByL/tzCIy9CnqhWXS8z0zTNWp5U8WBcRbu4YfSN+ktU2/4TrgtNs8WBGwOnP105LAKYvnN858UI0AlFg79JMmPDSUhCmD+KGVYL8pYVPugeXA5PUrOLHRSDBZ7PhxVCKTNR0Ap58I3KaCqNbPAQP+cYE/QlC5TOjjKb3lijlwNlYXyOziD3gQVnkw9jHbYiPwRALySirr7r92t1bfE1R+KjOyYq1Wy9P4V7Nps4rxYF8VOT9tM1ol5KxTyoq6H82DhJ1IGZlqrOM82wrtnGEBwX0G1sRgjeCDv3492vybT2BItawNjqUJM2ZcWvVBak/wasz5CgCt37ofqTg59oYgunKsKoLj82xsTXUTkD0KvBJM/jMUmWgVKU15CkUc/Db5xuUXLX6dxMwQ0iadsIiBDqY7a2Wz+ef5JrtDWDccau3inh8F68V6AvbPTSPWtSAC68+gGXegPmlE7o9bEU+W/jGmio3D7M1UBRyTNks6+eFO8fxUtpGVPopbUh7YcXi68AdKCwEOP4+lzzGWYlCOTOfnW1LFuCc2ldv4WM2IPCVvHxBYVh6YKw5CxrNL6ia5bMWA/3tNaabopnqSNvOqlaQ4u9lto0jY=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(136003)(39860400002)(346002)(451199015)(40470700004)(36840700001)(46966006)(16526019)(26005)(8676002)(53546011)(41300700001)(9686003)(316002)(70586007)(70206006)(4326008)(40460700003)(186003)(81166007)(8936002)(6916009)(54906003)(7696005)(83380400001)(2906002)(7416002)(82740400003)(5660300002)(336012)(356005)(40480700001)(82310400005)(47076005)(6666004)(36860700001)(478600001)(426003)(55016003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2022 15:56:32.1199
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b0cd3c0-895c-4440-b01a-08dac8b44c0d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7098
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.11.22 11:24:48, Dan Williams wrote:
> Robert Richter wrote:
> > The Device 0, Function 0 DVSEC controls the CXL functionality of the
> > entire device. Add a check to prevent registration of any other PCI
> > device on the bus as a CXL memory device.
> 
> Can you reference the specification wording that indicates that the OS
> needs to actively avoid these situations, or otherwise point to the real
> world scenario where this filtering is needed?

CXL 3.0

8.1.3 PCIe DVSEC for CXL Device

"""
An RCD creates a new PCIe enumeration hierarchy. As such, it spawns a new Root Bus
and can expose one or more PCIe device numbers and function numbers at this bus
number. These are exposed as Root Complex Integrated Endpoints (RCiEP). The PCIe
Configuration Space of Device 0, Function 0 shall include the CXL PCIe DVSEC as shown
in Figure 8-1.
"""

"""
In either case, the capability, status, and control fields in Device 0, Function 0 DVSEC
control the CXL functionality of the entire device.
"""

There are some other occurrences. I think this is even true for VH
mode, as multiple CXL devices on the bus are exposed through multiple
DSPs or Root Ports.

Anyway, I limited this to an RCD only, esp. because its counterpart
would be missing and thus port mapping would fail otherwise. See
restricted_host_enumerate_dport() of this series.

> 
> > 
> > Signed-off-by: Robert Richter <rrichter@amd.com>
> > ---
> >  drivers/cxl/pci.c | 25 +++++++++++++++++++++++--
> >  1 file changed, 23 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> > index faeb5d9d7a7a..cc4f206f24b3 100644
> > --- a/drivers/cxl/pci.c
> > +++ b/drivers/cxl/pci.c
> > @@ -428,11 +428,26 @@ static void devm_cxl_pci_create_doe(struct cxl_dev_state *cxlds)
> >  	}
> >  }
> >  
> > +static int check_restricted_device(struct pci_dev *pdev, u16 pcie_dvsec)
> > +{
> > +	if (pci_pcie_type(pdev) != PCI_EXP_TYPE_RC_END)
> > +		return 0;		/* no RCD */
> > +
> > +	if (pdev->devfn == PCI_DEVFN(0, 0) && pcie_dvsec)
> > +		return 0;		/* ok */
> > +
> > +	dev_warn(&pdev->dev, "Skipping RCD: devfn=0x%02x dvsec=%u\n",
> 
> s/0x%02x/%#02x/
> 
> > +		pdev->devfn, pcie_dvsec);

Ok.

> This looks like a dev_dbg() to me. Otherwise a warning will always fire
> on a benign condition.

I have chosen dev_warn() here as this is a non-compliant unexpected
behavior of the device. There are no (legal) cases this may happen. I
suppose you are worried about spamming the console here, but that
error should be reported somewhere and thus being visible.

Note: There can be multiple devices on the bus, but those shouldn't
have a CXL mem dev class code and the devices shouldn't being probed
by cxl_pci_probe() which contains the check and later creates a cxlmd
dev.

-Robert


