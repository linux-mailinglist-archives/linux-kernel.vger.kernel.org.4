Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A80262E4BA
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 19:46:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240570AbiKQSqr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 13:46:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240652AbiKQSqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 13:46:44 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2049.outbound.protection.outlook.com [40.107.92.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6680587571;
        Thu, 17 Nov 2022 10:46:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jvMw4bVZ1l+x2NZwbpP5Dflf3zpZlDCsw+3cHvcH3nSJ8AlfC48YCFGdNFTrHc0pEEMqUVjT02F+blWAW4BUaS1a3oxEP4bTgzybTvTNp+Vd5w8ZGFTE6Z15npLIdxNKdqhHoiRYl7AdYRjGZ99R2Fas3TmMqyR3JpSnQCYbucdixJsqdZmbVqpKKSfAc9E0OHqzxVr0d30JAV1Qi3yAN571Y/9qJY7EQlmbCd78xYCqNjmBXwc8PGQqXENsFhFzoiEc7f00AXf4ugbL+XgDgD9/N1h4ejtcA5YKqf8xx1tkmKtmhKCKBhgckIc9wPj6TmgKcYTZtD/2bXIghSX12w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SzDjRtF8vthBr1vLTjMNdlkq3Z20jXR/o1NiKpQUdqY=;
 b=FqTcx2rgxglPvjvvcvSJMBJ1X3EeySRR50aKNoWBS9Olfp2bZmoYX9lXWz8AoE58rgaaa3LGgq5yx8eHiQWblIg0dOWRMABA6uEY/B3YLH04UbnE7Wj5pP5wrZxrTbd2H0uM1tU5Fu+h+MX9SgSAGRaqPb0VOrhNcz9QdFtVQYbiTAr5E3zWwJfrJ0N4su+YhA52XSgrp7fUD80Z47zVSNNp+NoGAbhFSmTj50U0qPvjfQvNFieWT1Z6nldDxfKrpB4ClaEDNt62/Sz8tr8RV7YSaeWCbzT26Zc5XAAHjxsrqWyS5Jo0yYVV/Ju77Yo1fns89V790iOh/3aD28Qj3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SzDjRtF8vthBr1vLTjMNdlkq3Z20jXR/o1NiKpQUdqY=;
 b=Jq2gA7DjHS1vRektMy8INTYFAmBNf9DsXJawIvMYTkndgb/KnGhcJTNlj0hcDWzzFbAXj+ZbxnplStvILmc6d4Oh15RJCvUvIowVnXfq2pPRpDVamq06esCj0rfXYgO6NECn9PiTQvWg+iQWTXDFLOrKchFWBfmHVtccRKvgAKU=
Received: from BN0PR02CA0022.namprd02.prod.outlook.com (2603:10b6:408:e4::27)
 by PH0PR12MB5404.namprd12.prod.outlook.com (2603:10b6:510:d7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.19; Thu, 17 Nov
 2022 18:46:39 +0000
Received: from BN8NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e4:cafe::7b) by BN0PR02CA0022.outlook.office365.com
 (2603:10b6:408:e4::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.20 via Frontend
 Transport; Thu, 17 Nov 2022 18:46:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT045.mail.protection.outlook.com (10.13.177.47) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5834.8 via Frontend Transport; Thu, 17 Nov 2022 18:46:39 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 17 Nov
 2022 12:46:36 -0600
Date:   Thu, 17 Nov 2022 19:46:33 +0100
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
Subject: Re: [PATCH v3 4/9] cxl/mem: Skip intermediate port enumeration of
 restricted endpoints (RCDs)
Message-ID: <Y3aBibty5mDTSmzx@rric.localdomain>
References: <20221109104059.766720-1-rrichter@amd.com>
 <20221109104059.766720-5-rrichter@amd.com>
 <6372d85ed793f_12cdff294f@dwillia2-xfh.jf.intel.com.notmuch>
 <Y3ORTv/1YbTFJQzq@rric.localdomain>
 <6373d5b332214_12cdff2948@dwillia2-xfh.jf.intel.com.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6373d5b332214_12cdff2948@dwillia2-xfh.jf.intel.com.notmuch>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT045:EE_|PH0PR12MB5404:EE_
X-MS-Office365-Filtering-Correlation-Id: 6056b23d-b687-4aab-090a-08dac8cc1003
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TpZLokjS7jjUyyNtCWP8Ws8O1PgAadklRbtTYs+7yOG5su6gOD6rx7pune+t/EYTzWf7L38JGDvv0K06BLiBMphTzGImTQboWmat1VlsJbbNXVHnZZvhg3Ku6P7zXlmWsjeOss2CqDbrK3dz1XkgTgOmiG0QzaMWqHcsRdKKhufBGnahlS/ybLTfHqMmlQ6b1XL10am6RgbDGy3PjPpj5j/AcD9Bof5wqUu9kTrcm3D4zj719ocSxlA7+A6JccVETdDKTlDX4wlKM7QiSsVnug0tHTm0IRdVVPmZHGYddtcDFeOAqJZOXMXE7b54apzSl46FfhPCZVosanz5/PVEA4EaCDIf9OBItrkBt8060UHNJ9lP+juIS5dtx/Onlglq30BN3CexMeLd5rSoNcJd+b5wyJx7HgFohFZMGYjNgJSu3K4z0QqeiWvcJD0470I44jsvjKsS1Y6R2tiO1kaK0+U2KNTZ3lKkuwhl5LYp06sI/OFCt31RKmvXpGU3lijCLaOUyjz68lBf3D4Jt37rBIDdP0VlYgLnIMFAIyLidkDad/+RgMybeXIAmqDieCE6KOMt8bpZ8qVsD7mtzuZI7UjFvj8118Al1TlUE5muIFMs6Y0KiJKH11zU3hiSyaBjMMq9pZ2mFbwWPo0EVpTisYZC7OzdQKM2D52ZVpIhrWWl7nlW0UsAteRTLur6zQLTsuZ0aJz1UFECtQ/kJ4yLXki8fGd7Sq1u7RC+eOoMUXM=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(376002)(396003)(136003)(451199015)(36840700001)(46966006)(40470700004)(82310400005)(36860700001)(40460700003)(83380400001)(82740400003)(81166007)(478600001)(40480700001)(356005)(7696005)(53546011)(55016003)(6666004)(4326008)(70206006)(70586007)(41300700001)(8676002)(26005)(316002)(6916009)(54906003)(186003)(16526019)(9686003)(426003)(336012)(47076005)(2906002)(8936002)(5660300002)(7416002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2022 18:46:39.3395
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6056b23d-b687-4aab-090a-08dac8cc1003
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5404
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.11.22 10:08:51, Dan Williams wrote:
> Robert Richter wrote:
> > On 14.11.22 16:07:58, Dan Williams wrote:
> > > Robert Richter wrote:
> > > > When an endpoint is found, all ports in beetween the endpoint and the
> > > > CXL host bridge need to be created. In the RCH case there are no ports
> > > > in between a host bridge and the endpoint. Skip the enumeration of
> > > > intermediate ports.
> > > > 
> > > > The port enumeration does not only create all ports, it also
> > > > initializes the endpoint chain by adding the endpoint to every
> > > > downstream port up to the root bridge. This must be done also in RCD
> > > > mode, but is much more simple as the endpoint only needs to be added
> > > > to the host bridge's dport.
> > > > 
> > > > Note: For endpoint removal the cxl_detach_ep() is not needed as it is
> > > > released in cxl_port_release().
> > > > 
> > > > Signed-off-by: Robert Richter <rrichter@amd.com>
> > > > ---
> > > >  drivers/cxl/core/port.c | 18 ++++++++++++++++--
> > > >  1 file changed, 16 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> > > > index d10c3580719b..e21a9c3fe4da 100644
> > > > --- a/drivers/cxl/core/port.c
> > > > +++ b/drivers/cxl/core/port.c
> > > > @@ -1366,8 +1366,24 @@ int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
> > > >  {
> > > >  	struct device *dev = &cxlmd->dev;
> > > >  	struct device *iter;
> > > > +	struct cxl_dport *dport;
> > > > +	struct cxl_port *port;
> > > >  	int rc;
> > > >  
> > > > +	/*
> > > > +	 * Skip intermediate port enumeration in the RCH case, there
> > > > +	 * are no ports in between a host bridge and an endpoint. Only
> > > > +	 * initialize the EP chain.
> > > > +	 */
> > > > +	if (is_cxl_restricted(cxlmd)) {
> > > 
> > > I changed this to:
> > > 
> > > 	if (cxlmd->cxlds->rcd) {
> > 
> > I a mail to Bjorn I suggested to have cxl_dev_cap and a cxl_port_cap
> > in the pci_dev struct that could be looked up too including RCD mode.
> > Checking the pci_dev looks more reasonable to me here, though we could
> > have a flag of it in cxlds too.
> 
> Would that not need the PCI core to understand how to walk the RCRB
> generically? As far as I understand the RCRB association is ACPI.CEDT
> specific.

I am thinking of doing some sort of cxl_setup_pci_dev(pdev) in
cxl_pci_probe() which extracts the caps and writes them into a struct
pci_dev. Possibly the CXL 68B Flit and VH Capable/Enable bit could be
used for RCD mode. But if that is not feasible for some reason a flag
somewhere could work too.

-Robert
