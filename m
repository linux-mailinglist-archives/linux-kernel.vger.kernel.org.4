Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 586ED720674
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 17:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236282AbjFBPpv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 11:45:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235166AbjFBPpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 11:45:46 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2077.outbound.protection.outlook.com [40.107.95.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8657519A;
        Fri,  2 Jun 2023 08:45:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nB5Eb0n4gJDE/urKB5UGGKcN4J5kvzi6klfQtU/1HzrqyyQD6AwC/ASZk6AhgUsWqINAtfee2X6jOJIFgg03oRME0J/VOcTsStpZvOEaU3uTcax+IcUt5iPysQT56YfwwaK3QfDzcix3Bfh2DADd058cB7zwpegOgrrI7zFAPF/FKb6fkVsBc8grsQN/a+qACm1sJ1t6pyfLZn/33xbAwaqPv/5pFHm9TGL4Kx+jed7jW3/IylDaMfd5kZtORqO4U6vNpwPJ2GV2Wum6yqbd5SxKGm6EIan5mfMjnH9nQbBj1KO11gRJiW7PVl8zpLINQhrhaSpQ8rORwpcSoqtNnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2yOL3M+ATmAegNLp72f9zE3I4JU9w8TNwLRNs7rql1o=;
 b=V+q/8u624luLvNq1yq96XooUjmKo597i81YTloJBi+0TsprSdwXy8A8M04g7l6ELmGZa9PuZgUy5YiGoBcuNolj7gPSIdlEEdT+h3OttKhUr/MPdUXAtDcdilU0eMMzw3YG5O5j7RfsrRNrX226eHEHLmzPEgy/qjJPQyjkLbQuXDTHeyNWpzYzuTMiOYsJIAxy1BO7qJkow+kUDbDIKaELPJgX0jfw1yc9NCMVJrFbjEb0aK9VFgTU2j3CfofeiYurEAY51AX+iTGaqi3Smy99wp1sq6Yi/McxFLbWD57Y/+xtmsLpX90mIs8/SwMjim0NOXTQBZqLle9Vns8TZqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=huawei.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2yOL3M+ATmAegNLp72f9zE3I4JU9w8TNwLRNs7rql1o=;
 b=Yt4QaT6m6Lt72eFdtdM0mxFp7KqaZrpn+eBY5FoCCbxc1PAFrpRF8Dkeu4rG1/9At50aEklNLyYRcZAMkFSLkaEguV8Dn/F30AbSBCXCQT8da8VjKY/2i4HSv75UDcWLF4dO65agq+3bmhtd0gS2Qa4fPRf2fMag5AR2jBLLlb8=
Received: from MW4P221CA0024.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::29)
 by MW3PR12MB4489.namprd12.prod.outlook.com (2603:10b6:303:5e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.24; Fri, 2 Jun
 2023 15:45:42 +0000
Received: from CO1NAM11FT113.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8b:cafe::fc) by MW4P221CA0024.outlook.office365.com
 (2603:10b6:303:8b::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.24 via Frontend
 Transport; Fri, 2 Jun 2023 15:45:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT113.mail.protection.outlook.com (10.13.174.180) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.28 via Frontend Transport; Fri, 2 Jun 2023 15:45:41 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 2 Jun
 2023 10:45:35 -0500
Date:   Fri, 2 Jun 2023 17:45:09 +0200
From:   Robert Richter <rrichter@amd.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC:     Terry Bowman <terry.bowman@amd.com>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        <bwidawsk@kernel.org>, <dan.j.williams@intel.com>,
        <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: Re: [PATCH v4 09/23] cxl/pci: Early setup RCH dport component
 registers from RCRB
Message-ID: <ZHoOhdiCu5O/C+TV@rric.localdomain>
References: <20230523232214.55282-1-terry.bowman@amd.com>
 <20230523232214.55282-10-terry.bowman@amd.com>
 <20230601135931.000046fa@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230601135931.000046fa@Huawei.com>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT113:EE_|MW3PR12MB4489:EE_
X-MS-Office365-Filtering-Correlation-Id: 08c30f4f-bfc9-40b3-023e-08db63806b8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NcLYL1Rf2pRo0Vj4XwJyS0zdPbYzrFXmwkXKUj66GsUYNPTu3rfpQIRkanRmKxy6Qs0K+5FRP5yateKWc2f2Z3qd1ECPyfddtR9biyi6OslyOtikG6h70JRCvDHcXx5o4JmAnPVG9CL2Q4ExwfphxSPdT9j0iG1gyfmlNASqxLm1iOpnC3q8bY0RnusAkm0fp97gKeo2QBl09dYsIwTP+YMv14WAH604uGDmnt7haQQv7zyDjXvtwZdNTpZAIi26ln2n6FQ+k3AzOc9uO/whEdp3MXqUgimYY3KntBx0dhTJSNQhTefDqXHhVUe5rtXiT+ctXas5ydI0srHHhViZLzjRKlXOEsXy4DGqHeETvd4YnMvfsMimMOqff5eO0U8bstDNtS8PRGi2KiMprhs6I0jU8SYLR39Zq4qvDQPWUSNCXXep6fA33u3FbtWbkQchFSgWyTKso/aEeT+Mt5NbWJxs9D6QVtz2iZPwYUwC3z9b5hpZI5xyizjah82a8G+H4B6WyRo0WlsquyfQ3ZBKIPfePUgj64zdXSa6sbKut/ICXZ317Gmedu7KsxpthSrKtobslqkGdQ/yeG1ad3ht7lwAMsQR8GK7fYWBf5qRdGodhDw7c/w9dudiT4yHyCfGa5L16wQPbUCyiStGByfSQVfVVVhFDBNSs7zwhZG78sydAvCt8XK/JSg+K+vXAj8LycyJxx/00T6mH3jGPj1AbqTFSQ4lcNWU5Py1L249rHC9FQ92HCyCuZZ4NtBva0VMWA/Ne3HOZURyoirCONKF9Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(136003)(39860400002)(346002)(451199021)(40470700004)(36840700001)(46966006)(53546011)(9686003)(70586007)(186003)(70206006)(16526019)(6916009)(4326008)(7416002)(5660300002)(336012)(426003)(8936002)(47076005)(8676002)(478600001)(83380400001)(2906002)(7696005)(82310400005)(36860700001)(356005)(82740400003)(81166007)(316002)(54906003)(40460700003)(26005)(6666004)(40480700001)(41300700001)(55016003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2023 15:45:41.2992
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08c30f4f-bfc9-40b3-023e-08db63806b8f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT113.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4489
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

On 01.06.23 13:59:31, Jonathan Cameron wrote:
> On Tue, 23 May 2023 18:22:00 -0500
> Terry Bowman <terry.bowman@amd.com> wrote:
> 
> > From: Robert Richter <rrichter@amd.com>
> > 
> > CXL RAS capabilities must be enabled and accessible as soon as the CXL
> > endpoint is detected in the PCI hierarchy and bound to the cxl_pci
> > driver. This needs to be independent of other modules such as cxl_port
> > or cxl_mem.
> > 
> > CXL RAS capabilities reside in the Component Registers. For an RCH
> > this is determined by probing RCRB which is implemented very late once
> > the CXL Memory Device is created.
> > 
> > Change this by moving the RCRB probe to the cxl_pci driver. Do this by
> > using a new introduced function cxl_pci_find_port() similar to
> > cxl_mem_find_port() to determine the involved dport by the endpoint's
> > PCI handle. Plug this into the existing cxl_pci_setup_regs() function
> > to setup Component Registers. Probe the RCRB in case the Component
> > Registers cannot be located through the CXL Register Locator
> > capability.
> > 
> > This unifies code and early sets up the Component Registers at the
> > same time for both, VH and RCH mode. Only the cxl_pci driver is
> > involved for this. This allows an early mapping of the CXL RAS
> > capability registers.
> > 
> > Signed-off-by: Robert Richter <rrichter@amd.com>
> > Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> 
> One minor wording suggestion inline. I'm don't really care
> that much about it though, so.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> 
> > diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> > index 945ca0304d68..54c486cd65dd 100644
> > --- a/drivers/cxl/pci.c
> > +++ b/drivers/cxl/pci.c
> > @@ -274,13 +274,48 @@ static int cxl_pci_setup_mailbox(struct cxl_dev_state *cxlds)
> >  	return 0;
> >  }
> >  
> > +/* Extract RCRB, use same function interface as cxl_find_regblock(). */
> > +static int cxl_rcrb_get_comp_regs(struct pci_dev *pdev,
> > +				  enum cxl_regloc_type type,
> > +				  struct cxl_register_map *map)
> > +{
> > +	struct cxl_dport *dport;
> > +	resource_size_t component_reg_phys;
> > +
> > +	memset(map, 0, sizeof(*map));
> > +	map->dev = &pdev->dev;
> > +	map->resource = CXL_RESOURCE_NONE;
> > +
> > +	if (type != CXL_REGLOC_RBI_COMPONENT)
> > +		return -ENODEV;
> > +
> > +	if (!cxl_pci_find_port(pdev, &dport) || !dport->rch)
> > +		return -ENXIO;
> > +
> > +	component_reg_phys = cxl_probe_rcrb(&pdev->dev, dport->rcrb.base,
> > +					    NULL, CXL_RCRB_UPSTREAM);
> > +	if (component_reg_phys == CXL_RESOURCE_NONE)
> > +		return -ENXIO;
> > +
> > +	map->resource = component_reg_phys;
> > +	map->reg_type = type;
> > +	map->max_size = CXL_COMPONENT_REG_BLOCK_SIZE;
> > +
> > +	return 0;
> > +}
> > +
> >  static int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
> >  			      struct cxl_register_map *map)
> >  {
> >  	int rc;
> >  
> > +	/*
> > +	 * If the Register Locator DVSEC does not contain the
> > +	 * Component Registers, try to extract them from the RCRB if
> > +	 * it is an RCH.
> 
> My instinct here was to wonder why having said 'if it is an RCH'
> you don't seem to be checking that first.  Perhaps
> change this text to something like.
> * Component Registers, assume it is an RCH and try to extra them
> * from an RCRB.
> */
> ?

Will change that.

Thanks for review,

-Robert

> 
> > +	 */
> >  	rc = cxl_find_regblock(pdev, type, map);
> > -	if (rc)
> > +	if (rc && cxl_rcrb_get_comp_regs(pdev, type, map))
> >  		return rc;
> >  
> >  	return cxl_setup_regs(map);
> 
