Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC3F6259E7
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 12:57:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232963AbiKKL5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 06:57:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233529AbiKKL5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 06:57:03 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1B6A5D686;
        Fri, 11 Nov 2022 03:57:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NaOEn0BAtvmrqey1yOS5Xe87mE7MtRwvlysihgzp2VpY3UChgw2nf0o0POXxapf9X9fDr8zlF8C6eMWBCLGLv2RIzvIdMudS/2FWOn4dp1k+B4C11cTuRKW++JoKm1c3Gbn712wFQCnbkZM1Y66cb01pQV/QoBM1sLDkHY+5hXHlQyk1EBT3EZLrivy28LeKlzMQYTRGY3ujan6sB//Pd5N9W5nbdzQ9xiAgBaex8mZJ2/1QDY1ErrgxATc44rsO6nC/pL69+lIpd2OykwwlXuT4WdeNFbKWqvvXhmXfdnXCg7p0GwJwu7feb+h9+81+6dguoG5P4nLya/qRgvF/hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D/K/r2FdJFCkgvMJOD90d9Z/UxRBEFk9r0PilrbX9ZM=;
 b=CJPPwPAgjY7DZxyYwt2VE1HwaSSJKxEJFIRIfd+J/39Xe7blLSotsSY5ePPRYZUrZXoSM4pf84I9rqpTZ56kBAaamHnZiU8vxn5zWqm45g3iJG8G9rm6sEf5+stcoRjEql9GWRSrZlby04Dti9xAmFH5MDUZKof+TCVkiIPAFGTAn32Yqgzo6zABfCM7mBoJ7kcKzyr+oK6lx4Ylvdse0WVH6VIFAu3KUNyVWyo87LcVzQtLA3Uj144SiUXbJaor8ZAIak/5oAzkpA4Zttm1aA8TbWBoLTFEOUUpjxzoS9cKMdr1c0E2WMy0pwQMPEOQPrz4nfPL6CkKd/H8XYDETg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D/K/r2FdJFCkgvMJOD90d9Z/UxRBEFk9r0PilrbX9ZM=;
 b=AjmbtcqhrT3tTQG8HXALACd/H+BHxfoPlhUNdjROot4pHtY8sA6a9D5aHVaI2YB2a9TqArkWTsv0ECsJbVXH9XGF644i3lKAZvl8udg/OZe6ld+yV5ZOdnh2cg31V3mH8TidxUJWcxRV9c7+4uuyLy19Z1LRv2unrKhHDwGQZMU=
Received: from MW4PR04CA0121.namprd04.prod.outlook.com (2603:10b6:303:84::6)
 by CO6PR12MB5489.namprd12.prod.outlook.com (2603:10b6:303:139::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.12; Fri, 11 Nov
 2022 11:56:58 +0000
Received: from CO1NAM11FT108.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:84:cafe::6e) by MW4PR04CA0121.outlook.office365.com
 (2603:10b6:303:84::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.14 via Frontend
 Transport; Fri, 11 Nov 2022 11:56:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT108.mail.protection.outlook.com (10.13.175.226) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5813.12 via Frontend Transport; Fri, 11 Nov 2022 11:56:58 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 11 Nov
 2022 05:56:53 -0600
Date:   Fri, 11 Nov 2022 12:56:50 +0100
From:   Robert Richter <rrichter@amd.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>
Subject: Re: [PATCH v3 6/9] cxl/pci: Do not ignore PCI config read errors in
 match_add_dports()
Message-ID: <Y244ghE6SVZKWu6v@rric.localdomain>
References: <20221109104059.766720-7-rrichter@amd.com>
 <20221109230956.GA581201@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221109230956.GA581201@bhelgaas>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT108:EE_|CO6PR12MB5489:EE_
X-MS-Office365-Filtering-Correlation-Id: b6cec223-3834-4c46-bd54-08dac3dbd618
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rWD6cR0R3lQ54mzZD6xxfefpx7iM5z8jGy5/Ma0EHWZQd9K97VAKe3DEp8UOhsdCWKdGvAE63AKlmbbcoiwEAFcBBkxuIajsPporY51Y0n3GeY8oEbOAlhRJpM8e2dzD2qr1h3g2klxTSJFf8Y2dzlBuyqCueW5tgXs9BQOvq3cNo+b3C3sHsOYhz6onjs0ztBCYOkPXeC4ABnKBtEbUHrK+7kkuWp1Tk1BGXgX/UDnFZ+KXWzWIEx9NiaQrmPJ8qkVVPki9afyvfrFfxGWzloUKW/peZlJM0j4PgC7nfNmxWNIRKGK0ufs86vUjgm3nP4NRuEdy0+uv6DmNmKlLTCfcY68fyvYpfVGZ+91WsKAlSMakKqY2WBahJng1wGFZ4ETuavwsSUYuFx1Cj4nqZ9ORKKasNOXF16qLwiMypOvq7PIIXRVVUVdCnRwKstHrtVzq2ZSuaXgIN8owYEW3FFIMp+Wa0jU/QQbJNE+lM7k6dD/qZu482E7UzE9U77ACSp7MEFymKrNylFNl+x+4Vsi1Mcs5qnZo1ev9v32hUhRAqpTXMbzdLIy9uDi59bb5s4C7uD1rSNbJdc4QAxCZDN18jrLMaxi58F+AHvq0peqQWbd6a4Gwcl2v8ygWDIDS9853nc++C6tunP6aCGXZ9G/n0CigjZRubo7NIR68qK/FESrg50oVGTgGU1cBRZgjTzkl1LatSLhBG0VX33qFTfQ94QJU34qRdi1AeiIRYLXYXempS37Uy+t2euSx7SxUKtVZdl7x4ESQ3g2A+gRwMABVCLMt1QVjlVBznS3airPGGgda+VTC9Vmp/347eRbk
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(396003)(136003)(39860400002)(451199015)(36840700001)(46966006)(40470700004)(7696005)(82740400003)(81166007)(40460700003)(356005)(82310400005)(36860700001)(2906002)(16526019)(54906003)(186003)(26005)(9686003)(53546011)(83380400001)(426003)(47076005)(6916009)(40480700001)(7416002)(70586007)(336012)(478600001)(8936002)(55016003)(70206006)(8676002)(5660300002)(41300700001)(4326008)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2022 11:56:58.2140
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6cec223-3834-4c46-bd54-08dac3dbd618
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT108.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5489
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bjorn,

thank you for your review, I will address all your comments you made
also for other patches.

On 09.11.22 17:09:56, Bjorn Helgaas wrote:
> On Wed, Nov 09, 2022 at 11:40:56AM +0100, Robert Richter wrote:

> > @@ -47,7 +47,7 @@ static int match_add_dports(struct pci_dev *pdev, void *data)
> >  		return 0;
> >  	if (pci_read_config_dword(pdev, pci_pcie_cap(pdev) + PCI_EXP_LNKCAP,
> >  				  &lnkcap))
> 
> You didn't change this, but I recommend using
> pcie_capability_read_dword() when reading the PCIe Capability.  It
> takes care of some annoying corner cases like devices that don't
> implement Link Cap and the different versions of the PCIe Capability.

This is a good hint, I looked into pcie_capability_read_dword() and
found the function is checking the pci_pcie_type(). For CXL VH it is
ok as the type is an endpoint, but for the RCD case it is an RCiEP.

Two issues arise here, there are those options:

1) Device implements CXL UP RCRB (3.0, 8.2.1.2)

The link capability must be read from PCIe caps of the UP RCRB instead
of the RCiEP. The implementation of pci_dev_add_dport() and
restricted_host_enumerate_dport() in a later patch of this series
("cxl/pci: Extend devm_cxl_port_enumerate_dports() to support
restricted hosts (RCH)") is not sufficient and must be changed to use
RCRB to determine the port id if it is an RCD.

2) Device does not implement CXL UP RCRB (3.0, 9.11.8)

The RCRB reads all FFs and CXL DVSEC 7 is accessible through the
device's config space now to avoid register remappings. Since there is
no RCD UP type 0 config space any longer, I would assume the UP's PCIe
caps with the link cap would be also made available through the
endpoint, but now it is an RCiEP. This violates the PCIe base spec
which does not allow to implement the link caps (PCIe base 6.0, 7.5.3
PCI Express Capability Structure, Link Capabilities). This makes sense
as an RCiEP is not connected to a root or downstream port and thus
does not have an upstream port. Strictly looking into the wording of
the PCI base spec, Link caps are not required for RCiEP and thus is
not prohibitedi and could be implemented optionnally. But CXL 3.0 spec
is more explicit here: "[The Link Capabilities] for an RCiEP [...]
shall not be implemented by the Device 0, Function 0" (CXL 3.0,
8.2.1.2).

I think, the spec's intention in 9.11.8 is to reduce remappings and
the device should just pass through the Link caps as there is a hidden
upstream port the RCiEP connected to it. Anyway, a CXL spec
clarification is needed here and pcie_capability_read_dword() needs to
be adjusted then for the RCiEP/RCD case.

Which raises another question to extend struct pci_dev the following:

#ifdef CXL_PCI
	u16	cxl_dev_cap;	/* CXL DVSEC 3, 8.1.3.1 DVSEC CXL Capability (Offset 0Ah)*/
	u16	cxl_port_cap;	/* CXL DVSEC 7, 8.2.1.3.1 DVSEC Flex Bus Port Capability (Offset 0Ah) */
#endif

Note: At least one cap is mandatory for all kind of CXL devices, see
CXL 3.0, Table 8-2.

There could be a helper then for a CXL check:

static inline bool dev_is_cxl(struct pci_dev *dev)
{
	return dev->cxl_dev_cap || dev->cxl_port_cap;
}

Thanks,

-Robert
