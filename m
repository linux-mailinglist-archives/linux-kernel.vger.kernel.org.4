Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FE33629A2D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 14:28:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbiKON2U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 08:28:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238130AbiKON2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 08:28:12 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2081.outbound.protection.outlook.com [40.107.102.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACCD714038;
        Tue, 15 Nov 2022 05:28:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IjKr2VbO2GnT+u6bKBLQiPHaNkyeJkCfrmj4rNH9Ny+cVW3JeyKhuVE1qgjqG7wj2ckxRD6P8PIZavAt7nqTmljNnJvx2PWH86s7JqX1ckXF+NlnS+NJ9qG1nHhdg22kWL1JW90GwTEjIQIS7K4oq8gPmAtUTJ2AMx8u/ps676ktuBvtsAsjdws0+TtdQ74rPyOOE+1YuAMEnQBumHYU5B5Y6rUPOSz5sRcClPNU63pSFaZYnETW1ZojxRNV2YDyZszQr1HcJd5Cmo5+isHWvDIfDEMODbv/ZASkRZxzRj/3X9UmH0K5dPeBYpTRf70rt/41SR5yuCjAecyGmIs4JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=INi1Ik1Y3bUiC4Q+FXbZDcftOmmCWIgJnxrhJxYp1iQ=;
 b=XGu4unAO4lTfVJf0HEdorP5Bo4n+pEDt1lYpTKiPiQxtk+gOe9bHUQ1MESo3CB46JoNNhar/7z5q8dvQM86FcrUA/KHNDQ8bPEL4TEGfzCoED2VSRv707tigr2+QIwWSIYpUBmpJC0NxIuRBnvX6nlhaV6paR8weyxIQWeUBqhfGGctAQPQwU4JZlitEWKQ/UHPS22V9OsfEPTO60q9vB9iJ86VRvMGN5aMKh3g2cCOg8Tlj3pkhgDKDplXYSNYVaIk2efufP1vIuoenmM4i1qznPoqQxhMhKFDwge4EIg1q7ZbHlAuQpV4n640O/h4gTCBqlpj2c98TePRo5N0jFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=INi1Ik1Y3bUiC4Q+FXbZDcftOmmCWIgJnxrhJxYp1iQ=;
 b=OWQW7jWZJssutAHp4OLacYHIMN5EpJR2QMN8+zaMBp/00E0evE9GGyqv36tKRRqN+G5klx2jONvkd0KskhTDwMth2wNuAsJg4d6vrHWqDomOdIcDD0DWT1wLVGeOtZeb0waWm0nV0IdpPi1+nVYvsCe8xzIsVtk9qD52Z/pEswI=
Received: from MW4PR03CA0123.namprd03.prod.outlook.com (2603:10b6:303:8c::8)
 by SA0PR12MB7002.namprd12.prod.outlook.com (2603:10b6:806:2c0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.16; Tue, 15 Nov
 2022 13:28:09 +0000
Received: from CO1NAM11FT077.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8c:cafe::98) by MW4PR03CA0123.outlook.office365.com
 (2603:10b6:303:8c::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17 via Frontend
 Transport; Tue, 15 Nov 2022 13:28:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT077.mail.protection.outlook.com (10.13.175.55) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5813.12 via Frontend Transport; Tue, 15 Nov 2022 13:28:09 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 15 Nov
 2022 07:28:05 -0600
Date:   Tue, 15 Nov 2022 14:28:02 +0100
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
Message-ID: <Y3OT4oz6aR6hyvSt@rric.localdomain>
References: <20221109104059.766720-1-rrichter@amd.com>
 <20221109104059.766720-5-rrichter@amd.com>
 <6372dc26c8f2f_12cdff294e4@dwillia2-xfh.jf.intel.com.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6372dc26c8f2f_12cdff294e4@dwillia2-xfh.jf.intel.com.notmuch>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT077:EE_|SA0PR12MB7002:EE_
X-MS-Office365-Filtering-Correlation-Id: fcb4ca7f-2750-4312-90d5-08dac70d3cb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i77lxq8PaNFmtAAcA0ZSzKYTIFXwTT4GKg3YxM7lQR8vBS1AAq/Us8XPQoDikTLPllgOWylt315zabjCQl8Qptned/klGQZcVsyDSMqdeRVhPHL69asTxoeNin9OlStDyRZtcRJ+3THWSFcdX5KIPzM2/2nmxP9ycKKSsgUkQRipFu5xJtW+za5+570og/vhrx/0amVOE7oozVK9JBIhPPjdLSmB/Icm4PQljorz8EmfKFw8emDqp07GR3968NScrR0zu3gIideu06y20+1uQ0+Ar+dfX6CJrw33fEdhux1FXM1RK2bDOInM8l8dzfPVIIKwpBQc1GOSnid1xbh4aUrCSk+3KZsuSb7hvmObfku4o3Al4XzqugKODqWZkDQRFqlmoEAYqv3S7c9CRJ3X+gTZ/0uk7B1nldfzmL43Oi4fOLCSHqJnsgmttucaaTXke7J9auIam7yPv6j3WHCdp1rfmjCuzlofmbAb0/9i61GXrUot2aIk4OCxXLAc8cy5UYlmDSR3R40C5G/w70S1bA9RX99w/5qbPdPAJBBcYGHKxs28yuzCUThfpA71DdjgbyEsFI6loVHIzxkJdWAvdppDY5e+o256VVZWBfVDoTeMPAB0Nb2Aihn5KfaBRGMxtlCr4ctDCxQMCNWTsZQL2lV9g7MMRjnJpJgazY0Tb9HWj5/OjTQrP2W3BmVvnWjwTvAEZWJj8m7rvGSpF5AfdXrphkvOrW4pR+zoURT/puexYS/UZVlnfmBaZlIsMUafnBXTGsJWhvkB+8Tjy/S5pBI/BXEhRCVA/5av1qag5IUn8Ilx4Ub0F6V+UrBak7CS
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(376002)(346002)(396003)(451199015)(36840700001)(40470700004)(46966006)(70206006)(82310400005)(81166007)(2906002)(36860700001)(82740400003)(8936002)(70586007)(7416002)(356005)(40460700003)(8676002)(4326008)(5660300002)(83380400001)(41300700001)(478600001)(40480700001)(6666004)(9686003)(7696005)(53546011)(26005)(55016003)(336012)(186003)(426003)(16526019)(6916009)(47076005)(54906003)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2022 13:28:09.1687
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fcb4ca7f-2750-4312-90d5-08dac70d3cb3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT077.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7002
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.11.22 16:24:06, Dan Williams wrote:
> Robert Richter wrote:
> > When an endpoint is found, all ports in beetween the endpoint and the
> > CXL host bridge need to be created. In the RCH case there are no ports
> > in between a host bridge and the endpoint. Skip the enumeration of
> > intermediate ports.
> > 
> > The port enumeration does not only create all ports, it also
> > initializes the endpoint chain by adding the endpoint to every
> > downstream port up to the root bridge. This must be done also in RCD
> > mode, but is much more simple as the endpoint only needs to be added
> > to the host bridge's dport.
> > 
> > Note: For endpoint removal the cxl_detach_ep() is not needed as it is
> > released in cxl_port_release().
> > 
> > Signed-off-by: Robert Richter <rrichter@amd.com>
> > ---
> >  drivers/cxl/core/port.c | 18 ++++++++++++++++--
> >  1 file changed, 16 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> > index d10c3580719b..e21a9c3fe4da 100644
> > --- a/drivers/cxl/core/port.c
> > +++ b/drivers/cxl/core/port.c
> > @@ -1366,8 +1366,24 @@ int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
> >  {
> >  	struct device *dev = &cxlmd->dev;
> >  	struct device *iter;
> > +	struct cxl_dport *dport;
> > +	struct cxl_port *port;
> >  	int rc;
> >  
> > +	/*
> > +	 * Skip intermediate port enumeration in the RCH case, there
> > +	 * are no ports in between a host bridge and an endpoint. Only
> > +	 * initialize the EP chain.
> > +	 */
> > +	if (is_cxl_restricted(cxlmd)) {
> > +		port = cxl_mem_find_port(cxlmd, &dport);
> > +		if (!port)
> > +			return -ENXIO;
> > +		rc = cxl_add_ep(dport, &cxlmd->dev);
> 
> On second look, this seems problematic. While yes it will be deleted
> when the root CXL port dies, it will not be deleted if the cxl_pci
> driver is reloaded. I will code up a unit test to double check.
> 
> I note that cxl_add_ep() for the VH case is skipped for the root CXL
> port, so I do not suspect it is needed here either. Did you add it for a
> specific reason?

Yes, all endpoint iterators need to be reworked. Also true, the first
endpoint is skipped in the chain. So only intermediate EP structs are
touched by the loops actually.

In particular, cxl_ep_load() returned NULL for the first lookup if the
ep is missing. We could stop the iteration then. I tried to avoid a
rework here, but maybe it is not too extensive as I expected first.

-Robert
