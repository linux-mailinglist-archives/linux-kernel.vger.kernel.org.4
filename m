Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E22D62FE6C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 20:55:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233548AbiKRTzP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 14:55:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235327AbiKRTyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 14:54:43 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2056.outbound.protection.outlook.com [40.107.237.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA062B97D0;
        Fri, 18 Nov 2022 11:54:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VwjCswUuuwf/7EBr/1sg0IfneaYKWBqYA6n71pfS23GGEeUGxY50x2XBjYZVZxcEA+NZq5iTZkgOrZz+uxZxxxrNfgtr1nWTFOYzg9vV610FCX7Yq4ZM/Ss9+iA+u4g1Z5VKnjXnVFPS3P7uB0gjeZxsMSVoDznk4bndTndsMcU/5TWfSlRnuGoX8mrlHOuNwv2f6dShebiPvj128kqvXjcBetOH2Wo7g/P99yLlExJDWVNCu6UmYGs6o3jCiew36YwBnuQrzu7eM8fd1wSgt7rlxoRSEwvowr2H1f45Q5vQgBxeIPV8eqzSPtVJJ2ntH2rJdgiBysYIs8oi1E7NgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BctSm0Mo3RU+gErGoQIbc1ZegNgjvQsU1U2fBBSCy8U=;
 b=IqhPXJIO2GN0KX17h/3Jp8s6zX7VSsRyYxkiRsD3xZqiloQKzYqMte8ZFFhh9Z16ZruzXCsoRKyIP3WZ1c4tmmLZvj9RQHal0uMgU03vUPEFSU4bWIEVDCDEYt2qKmpVPBiwA1sLmfNx47FQzbLp+iRmrA16rpNXC9KhiLfJ5/7olQcUCq5engRDUGM6CSLPNjohFjH+p7fdFSDiZvM7BsAGi6yz2SoHq2jDzWqZcgD6QZvyf0O/GjQiuCP/Hxf81qmvw/TFJzVMnNDx4cwx6OoW3osJgub8dKdyAVjFwzzi/Q6QijS0rWHCaNr0zDm5OGe29uE+R3skPYIIcMj7Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BctSm0Mo3RU+gErGoQIbc1ZegNgjvQsU1U2fBBSCy8U=;
 b=ZUFkgClVpc7Yr17+I8QDaIBwY8rijjW84yr36R0fXxFpemupKGXoyXN80zWowG12+GVIHcewWuqll6SCnVReR/0Zk7G7aCyTmMRHYPVvj5uUUL4GmzKG+WxNeohnPbbFa5g0WjdC18lAt0Wh2LvFa4sj9UaxzbA1/cxzv6kLoT0=
Received: from DS7PR03CA0264.namprd03.prod.outlook.com (2603:10b6:5:3b3::29)
 by DS7PR12MB6310.namprd12.prod.outlook.com (2603:10b6:8:95::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Fri, 18 Nov
 2022 19:54:07 +0000
Received: from DM6NAM11FT110.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b3:cafe::8) by DS7PR03CA0264.outlook.office365.com
 (2603:10b6:5:3b3::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.20 via Frontend
 Transport; Fri, 18 Nov 2022 19:54:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT110.mail.protection.outlook.com (10.13.173.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5834.8 via Frontend Transport; Fri, 18 Nov 2022 19:54:07 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 18 Nov
 2022 13:54:04 -0600
Date:   Fri, 18 Nov 2022 20:53:49 +0100
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
Message-ID: <Y3fitR3+8SvErb9v@rric.localdomain>
References: <20221109104059.766720-1-rrichter@amd.com>
 <20221109104059.766720-6-rrichter@amd.com>
 <63753900717c6_12cdff29439@dwillia2-xfh.jf.intel.com.notmuch>
 <Y3ZZqZ2kPS1yyOtd@rric.localdomain>
 <63766efb7ceac_12cdff294c3@dwillia2-xfh.jf.intel.com.notmuch>
 <Y3dB4quvaSzRzsT/@rric.localdomain>
 <6377b8f1be5e5_12cdff2941d@dwillia2-xfh.jf.intel.com.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6377b8f1be5e5_12cdff2941d@dwillia2-xfh.jf.intel.com.notmuch>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT110:EE_|DS7PR12MB6310:EE_
X-MS-Office365-Filtering-Correlation-Id: f59bdd4b-da4b-47dd-d001-08dac99ea75b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MP8Yf3NdsJ91MFfJ/PGuVD1vzqRTRkW6fh5oHrL3d63FGGRzD7MxIHUuhyKEKYoov8cuhv1A34iskF+t3VHhFG109a7PxFrTpxaLPfNf1Aud2AQuEz7IuDgHLy/6iIRx9QiHai074qepIzjwLhb+0hcbX7+xi6PJZT9GWM3/eqy+qz3O/3ZVoqb3vW2cut4zy/Nkd6ATWJVKzKYcAKqzpAR6h2G1GmrViJGXGc2WCeslsKyRJNrFW4j4wjszzkRUAeNst6U3ujO31adCruuX7t0YsS+5yibLwc8gvHjX6h0mgh8rdWMDtnNwDI5CuvwPsjDQHapIt/Fo2dF/67QzUFWlBavOGNcnO22XUREeQ/0jGt/e5GOW+isVRqPJzryl/7lker17oomnxfCMBpSeUko4HjEP0ljyAjjZq3XiZHvcuR2SoBl/pHNNxoSXK/Fai2oco7ThA/zzvlDfHfyvOPLJr/+/3Jvfn33bA+8MbVYKxLgt68eElmgTKn4x254CMz1vEMhtNbv7MflKZKOoDum3mIUlhkZpSMAqgSPTjykesN77wi14pvtWdTlvA1Ns/A70e3H6uueIXFPhn4Vqtz4EyWVE8O/AoVI1R6zMsjouxTgqGF+pw8xZq4+uZKKU0IVPPM5GFQrXOCrWuQkv486PIwNJo1ded1G7j6XnGRDDeQl2LAkKd0Z2QoE8Olma5RcpxjQbIU5M2oxK6Kcic2s2je/a4bA014ATPr7s8RYDpO0IxxGgkC4hggladdB7V3gmm09tP+kLYiHGrZSnLg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(39860400002)(376002)(136003)(451199015)(36840700001)(46966006)(40470700004)(36860700001)(70206006)(81166007)(70586007)(186003)(7416002)(26005)(16526019)(8936002)(47076005)(82740400003)(6666004)(426003)(6916009)(40480700001)(40460700003)(336012)(4326008)(8676002)(356005)(5660300002)(54906003)(7696005)(316002)(9686003)(53546011)(41300700001)(83380400001)(2906002)(478600001)(55016003)(82310400005)(67856001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2022 19:54:07.5236
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f59bdd4b-da4b-47dd-d001-08dac99ea75b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT110.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6310
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.11.22 08:55:13, Dan Williams wrote:
> Robert Richter wrote:
> > On 17.11.22 09:27:23, Dan Williams wrote:
> > > Robert Richter wrote:
> > > > On 16.11.22 11:24:48, Dan Williams wrote:
> > > > > Robert Richter wrote:
> > > > > > The Device 0, Function 0 DVSEC controls the CXL functionality of the
> > > > > > entire device. Add a check to prevent registration of any other PCI
> > > > > > device on the bus as a CXL memory device.
> > > > > 
> > > > > Can you reference the specification wording that indicates that the OS
> > > > > needs to actively avoid these situations, or otherwise point to the real
> > > > > world scenario where this filtering is needed?
> > > > 
> > > > CXL 3.0
> > > > 
> > > > 8.1.3 PCIe DVSEC for CXL Device
> > > > 
> > > > """
> > > > An RCD creates a new PCIe enumeration hierarchy. As such, it spawns a new Root Bus
> > > > and can expose one or more PCIe device numbers and function numbers at this bus
> > > > number. These are exposed as Root Complex Integrated Endpoints (RCiEP). The PCIe
> > > > Configuration Space of Device 0, Function 0 shall include the CXL PCIe DVSEC as shown
> > > > in Figure 8-1.
> > > > """
> > > > 
> > > > """
> > > > In either case, the capability, status, and control fields in Device 0, Function 0 DVSEC
> > > > control the CXL functionality of the entire device.
> > > > """
> > > > 
> > > > There are some other occurrences. I think this is even true for VH
> > > > mode, as multiple CXL devices on the bus are exposed through multiple
> > > > DSPs or Root Ports.
> > > > 
> > > > Anyway, I limited this to an RCD only, esp. because its counterpart
> > > > would be missing and thus port mapping would fail otherwise. See
> > > > restricted_host_enumerate_dport() of this series.
> > > > 
> > > > > 
> > > > > > 
> > > > > > Signed-off-by: Robert Richter <rrichter@amd.com>
> > > > > > ---
> > > > > >  drivers/cxl/pci.c | 25 +++++++++++++++++++++++--
> > > > > >  1 file changed, 23 insertions(+), 2 deletions(-)
> > > > > > 
> > > > > > diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> > > > > > index faeb5d9d7a7a..cc4f206f24b3 100644
> > > > > > --- a/drivers/cxl/pci.c
> > > > > > +++ b/drivers/cxl/pci.c
> > > > > > @@ -428,11 +428,26 @@ static void devm_cxl_pci_create_doe(struct cxl_dev_state *cxlds)
> > > > > >  	}
> > > > > >  }
> > > > > >  
> > > > > > +static int check_restricted_device(struct pci_dev *pdev, u16 pcie_dvsec)
> > > > > > +{
> > > > > > +	if (pci_pcie_type(pdev) != PCI_EXP_TYPE_RC_END)
> > > > > > +		return 0;		/* no RCD */
> > > > > > +
> > > > > > +	if (pdev->devfn == PCI_DEVFN(0, 0) && pcie_dvsec)
> > > > > > +		return 0;		/* ok */
> > > > > > +
> > > > > > +	dev_warn(&pdev->dev, "Skipping RCD: devfn=0x%02x dvsec=%u\n",
> > > > > 
> > > > > s/0x%02x/%#02x/
> > > > > 
> > > > > > +		pdev->devfn, pcie_dvsec);
> > > > 
> > > > Ok.
> > > > 
> > > > > This looks like a dev_dbg() to me. Otherwise a warning will always fire
> > > > > on a benign condition.
> > > > 
> > > > I have chosen dev_warn() here as this is a non-compliant unexpected
> > > > behavior of the device. There are no (legal) cases this may happen. I
> > > > suppose you are worried about spamming the console here, but that
> > > > error should be reported somewhere and thus being visible.
> > > 
> > > There are so many spec illegal values and conditions that the driver
> > > could checki, but does not. The reason I am poking here is why does the
> > > driver need to be explicit about *this* illegal condition versus all the
> > > other potential conditions? What is the practical end user impact if
> > > Linux does not include this change? For example, if it is just one
> > > vendor that made this mistake that can be an explicit quirk.
> > > 
> > > A dev_warn() is not necessary for simple quirks.
> > 
> > This is not simply a cross check, the driver prevents enablement of
> > CXL mem devs other than PCI_DEVFN(0, 0). It shouldn't silently drop
> > out then. It's a device malfunction which should appropriate reported
> > and not only visible if dbg is enabled.
> > 
> > As written above, the check is necessary as the counterpart is missing
> 
> It is only necessary if this condition happens in practice, not a
> theoretically. So I am asking, are you seeing this with an actual device
> that someone will use in production? If so, that's what pci quirks are
> for to keep those workarounds organized in a common location.

I can make it a dev_dbg() message. But I do not understand the ratio
behind this. This is not a quirk nor a workaround or a fix for
something. The likely paths are the conditions checked that return 0.
Only if the unlikely case happens where a CXL mem dev is not a dev 0,
func 0, a warning is shown to inform the user that this dev is not
enabled. So yes, this might be theoretical similar to that a driver
cannot allocate memory. But why not print this as a warning message
then?

Anyway, let's make it a dev_dbg().

Thanks,

-Robert
