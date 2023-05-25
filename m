Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD9037119FA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 00:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241863AbjEYWIq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 18:08:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbjEYWIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 18:08:44 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2054.outbound.protection.outlook.com [40.107.237.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BC3212F;
        Thu, 25 May 2023 15:08:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NDzxEvsaO1TYPrpNnTtYfLF1Pozi+1+aPaOvygUHd87o6RkgWw0KSnW4nC/c7vFEcJsrrb+KuIiyHKcJQrucvtUEaCxCIBlSD1phsjzdBOTHms/icPoPey1kAO3cAVtv2ILqvkU0BEa/1y7m2gzVudVCMFeEwyw2ijCUiZCLINalbCNB89IVw2TOt4WNcKysI7dxy0KMyrT5yO9DfPla6KarF6QbQMUgGW6lggdND3y4zmWv+QYzqVcRsHOcY1bkMoslyhhDVR9jB+8QyHC/kCKta6DMI5RA1hxuSA16/skYp6HgvxPtLhRhxkZexvthNSgTJJ4C7Duy57TBcDWFLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4a+A/4ThqnVlDpA0b1fzwp7FliSiM0jlWfYiPGJjuww=;
 b=SnM4rp5zF3sY8gn1jbrATBQmr9CD35Zr5xfznU8pKe8vmPn1OiJFXg7+ejvDE+DAS5EKhmqA1PA7gVaikHxT2Hist4HtZcH26xcy0PxSDhtcNtabd/PJxfLJDjhWvc1IfJm73EVmFUNQ2Gf9KGupvFBWNzGko7k0Mcbt505AAIcUHYBYP6636ohik/RzRx/DfVd58oVCZwOMJdqfS9s2Tq4pd64DyR6c/9UL1P0hvq+0kYEGD5nuLMr35XZO+CTkggyhWtdk6qRd6Fv6bRfgLWEUS/DoE+7VGEhT1aCLXJbsAz8C9vBdeNh2FxRnOe7p3FT/KGGSTM24yTPrNKtnzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4a+A/4ThqnVlDpA0b1fzwp7FliSiM0jlWfYiPGJjuww=;
 b=I+bv1Bnur/60EfMScVRjlNWz/8sKJx3gk71ped9Kbiwtll0T+NPOFY8TFHzIr4HS2TWlc24ZS2/jlMD1wCycpLuQAOA2H1CUqVTT8KBgxzwrbWihcdNBq6ZLkAX3K3G+1ZpegEKADVF7tjv6fP4bLpwLrjBFtmQkcn3a0vzLSOo=
Received: from BN0PR04CA0137.namprd04.prod.outlook.com (2603:10b6:408:ed::22)
 by SJ0PR12MB5673.namprd12.prod.outlook.com (2603:10b6:a03:42b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.16; Thu, 25 May
 2023 22:08:39 +0000
Received: from BN8NAM11FT102.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ed:cafe::f7) by BN0PR04CA0137.outlook.office365.com
 (2603:10b6:408:ed::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.17 via Frontend
 Transport; Thu, 25 May 2023 22:08:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT102.mail.protection.outlook.com (10.13.177.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6433.18 via Frontend Transport; Thu, 25 May 2023 22:08:39 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 25 May
 2023 17:08:36 -0500
Date:   Fri, 26 May 2023 00:08:33 +0200
From:   Robert Richter <rrichter@amd.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     Terry Bowman <terry.bowman@amd.com>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        <bwidawsk@kernel.org>, <dan.j.williams@intel.com>,
        <dave.jiang@intel.com>, <Jonathan.Cameron@huawei.com>,
        <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <bhelgaas@google.com>
Subject: Re: [PATCH v4 23/23] PCI/AER: Unmask RCEC internal errors to enable
 RCH downstream port error handling
Message-ID: <ZG/cYUaZerXNqqJl@rric.localdomain>
References: <20230523232214.55282-24-terry.bowman@amd.com>
 <ZG6FYhegl3+UlX76@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZG6FYhegl3+UlX76@bhelgaas>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT102:EE_|SJ0PR12MB5673:EE_
X-MS-Office365-Filtering-Correlation-Id: 6014c13a-c813-4512-757f-08db5d6c9806
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HHd7g4RtjBhLGkNQ604IWoRg9wKlJpceJPwMFEHfsJEZgz6Tarc0AtRckihy0MEXYese6vOsUWsJcg+9qcnvYJ7idAQta1C/dpWiExtOfb7OsGSTQz1UadIV/mXQlk2qmWPNX3+dFJlMsP0BdEtQAxy+9k5OWiUD/ukygsfUOhOvN/hGjOL0wyAdP8sHbPefAPWhg8tryDGQKcoL/YofYrU14MLZmcxtSzWHs5zY1USqM46Korhg4Gchnujao392dO1VHzjSSa4rorLA/qdM/5NV3uXFBcILRL83u99GfBfAFtSXmomQbi6CFEjjDrjPfwrc/mpyD+t1c71TGO7OcEyJS9S7EhapTNL1kmUspxtHyg0Owjv70PPpgV5DZc5pTV8Vr+IesUZCglSlGBhtkHVVE9xL6+EgzlngQR3SGhUbrbGjWV6mv2L7nyX3SGI2VYK0wwLSKVKBkK5lC1tI2xX9nZRO1aWuejy310l2ABrjdepZsIFF/2TA4Sog0ewkgaQKmnw0wzIKpy+mkhXPxffBtJBvDXV4OB9u1ryEjcrXZbTC96K9ex3AZcql84x5GqAx4eR3L8cd4NukVP7C423xx/+sglSM7i0Npzl8wrSnPHDsufqgkyhu+pTSFYIwyi6IX6b7dgjWv86wWOwEubcgqo4lDfUOoF38SX/dopeEUQ1SNpMmq72uR3/H1YK4sQ3mvVwmDPZE4EzPVyytc8N0ETo3FyNHRaJcPP/6aQLgcV3hAAqL4eVb3muBq1XtNse4jYpehMqfLdIUs6N29Osxoa/sv+K9K/8uvywbvHM=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(396003)(376002)(136003)(451199021)(36840700001)(40470700004)(46966006)(70206006)(4326008)(70586007)(6916009)(7416002)(8676002)(8936002)(54906003)(478600001)(5660300002)(41300700001)(7696005)(6666004)(316002)(40460700003)(40480700001)(55016003)(82740400003)(356005)(81166007)(186003)(2906002)(16526019)(53546011)(9686003)(36860700001)(83380400001)(336012)(426003)(26005)(47076005)(82310400005)(36900700001)(309714004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2023 22:08:39.0999
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6014c13a-c813-4512-757f-08db5d6c9806
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT102.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5673
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

On 24.05.23 16:45:06, Bjorn Helgaas wrote:
> On Tue, May 23, 2023 at 06:22:14PM -0500, Terry Bowman wrote:
> > From: Robert Richter <rrichter@amd.com>
> > 
> > AER corrected and uncorrectable internal errors (CIE/UIE) are masked
> > in their corresponding mask registers per default once in power-up
> > state. [1][2] Enable internal errors for RCECs to receive CXL
> > downstream port errors of Restricted CXL Hosts (RCHs).
> > 
> > [1] CXL 3.0 Spec, 12.2.1.1 - RCH Downstream Port Detected Errors
> > [2] PCIe Base Spec 6.0, 7.8.4.3 Uncorrectable Error Mask Register,
> >     7.8.4.6 Correctable Error Mask Register
> 
> I use "r6.0" to make sure it isn't mistaken for a section number.
> 
> > Co-developed-by: Terry Bowman <terry.bowman@amd.com>
> > Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> > Signed-off-by: Robert Richter <rrichter@amd.com>
> > ---
> >  drivers/pci/pcie/aer.c | 64 ++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 64 insertions(+)
> > 
> > diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> > index 2e3f00b6a5bd..c5076ae4eb58 100644
> > --- a/drivers/pci/pcie/aer.c
> > +++ b/drivers/pci/pcie/aer.c
> > @@ -948,6 +948,32 @@ static bool find_source_device(struct pci_dev *parent,
> >  
> >  #ifdef CONFIG_PCIEAER_CXL
> >  
> > +static int pci_aer_unmask_internal_errors(struct pci_dev *dev)
> > +{
> > +	int aer, rc;
> > +	u32 mask;
> > +
> > +	if (!pcie_aer_is_native(dev))
> > +		return -EIO;
> > +
> > +	aer = dev->aer_cap;
> > +	rc = pci_read_config_dword(dev, aer + PCI_ERR_UNCOR_MASK, &mask);
> > +	if (rc)
> > +		return rc;
> 
> I don't think there's much value in checking all these config accesses
> for failure.  A failure return really just means you called it with
> invalid parameters; it doesn't tell you whether it was successful on
> PCI.
> 
> > +	mask &= ~PCI_ERR_UNC_INTN;
> > +	rc = pci_write_config_dword(dev, aer + PCI_ERR_UNCOR_MASK, mask);
> > +	if (rc)
> > +		return rc;
> > +
> > +	rc = pci_read_config_dword(dev, aer + PCI_ERR_COR_MASK, &mask);
> > +	if (rc)
> > +		return rc;
> > +	mask &= ~PCI_ERR_COR_INTERNAL;
> > +	rc = pci_write_config_dword(dev, aer + PCI_ERR_COR_MASK, mask);
> > +
> > +	return rc;
> > +}
> > +
> >  static bool is_cxl_mem_dev(struct pci_dev *dev)
> >  {
> >  	/*
> > @@ -1031,7 +1057,44 @@ static void cxl_rch_handle_error(struct pci_dev *dev, struct aer_err_info *info)
> >  		pcie_walk_rcec(dev, cxl_rch_handle_error_iter, info);
> >  }
> >  
> > +static int handles_cxl_error_iter(struct pci_dev *dev, void *data)
> > +{
> > +	int *handles_cxl = data;
> > +
> > +	*handles_cxl = is_cxl_mem_dev(dev) && cxl_error_is_native(dev);
> 
> This effectively only looks at the *last* RCiEP associated with this
> RCEC.  I would expect a logical OR of all of them.
> 
> I see this is another use of is_cxl_mem_dev() and
> cxl_error_is_native() that really requires them to be in this file.
> 
> > +	return *handles_cxl;

If this is non-zero, the iteration stops. So as soon we find a cxl
device we can stop the loop. Else, all devices are non-cxl devs and
the last return is zero too.

Now checking the code, pci_walk_bus() works that way, but walk_rcec()
does not break in all cases. I think this function not working as
expected. We would need to check if pci_walk_bus() stopped the
iteration, e.g. with a return code.

Alternatively we could add this check:

	if (!*handles_cxl)
		*handles_cxl = ...

> > +}
> > +
> > +static bool handles_cxl_errors(struct pci_dev *rcec)
> > +{
> > +	int handles_cxl = 0;
> > +
> > +	if (pci_pcie_type(rcec) == PCI_EXP_TYPE_RC_EC &&
> > +	    pcie_aer_is_native(rcec))
> > +		pcie_walk_rcec(rcec, handles_cxl_error_iter, &handles_cxl);
> > +
> > +	return !!handles_cxl;
> > +}
> > +
> > +static void cxl_rch_enable_rcec(struct pci_dev *rcec)
> > +{
> > +	if (!handles_cxl_errors(rcec))
> > +		return;
> > +
> > +	/*
> > +	 * Internal errors are masked by default, unmask RCEC's here
> > +	 * PCI6.0 7.8.4.3 Uncorrectable Error Mask Register (Offset 08h)
> > +	 * PCI6.0 7.8.4.6 Correctable Error Mask Register (Offset 14h)
> 
> The spec references seem superfluous here.  The PCI_ERR_UNCOR_MASK and
> PCI_ERR_COR_MASK in pci_aer_unmask_internal_errors() are pretty good
> pointers.
> 
> > +	 */
> > +	if (pci_aer_unmask_internal_errors(rcec))
> > +		pci_err(rcec, "CXL: Failed to unmask internal errors");
> > +	else
> > +		pci_info(rcec, "CXL: Internal errors unmasked");
> > +}
> > +
> >  #else
> > +static inline void cxl_rch_enable_rcec(struct pci_dev *dev) { }
> >  static inline void cxl_rch_handle_error(struct pci_dev *dev,
> >  					struct aer_err_info *info) { }
> >  #endif
> > @@ -1432,6 +1495,7 @@ static int aer_probe(struct pcie_device *dev)
> >  		return status;
> >  	}
> >  
> > +	cxl_rch_enable_rcec(port);
> 
> Could this be done by the driver that claims the CXL RCiEP?  There's
> no point in unmasking the errors before there's a driver with
> pci_error_handlers that can do something with them anyway.

This sounds reasonable at the first glance. The problem is there could
be many devices associated with the RCEC. Not all of them will be
bound to a driver and handler at the same time. We would need to
refcount it or maintain a list of enabled devices. But there is
already something similar by checking dev->driver. But right, AER
errros could be seen and handled then at least on PCI level. I tent to
permanently enable RCEC AER, but that could cause side-effects. What
do you think?

Thanks,

-Robert

> 
> >  	aer_enable_rootport(rpc);
> >  	pci_info(port, "enabled with IRQ %d\n", dev->irq);
> >  	return 0;
> > -- 
> > 2.34.1
> > 
