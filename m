Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5AB76299E1
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 14:17:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236982AbiKONRO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 08:17:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbiKONRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 08:17:11 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2072.outbound.protection.outlook.com [40.107.244.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C8852D4;
        Tue, 15 Nov 2022 05:17:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZOC+2h7u+r7l9ej7CqT3+3yZFUV6xECfMHrohai/sBPoe+xX5iZTRJOEUuIAbcuHJ0IpUUJX73Hi7Ja2zRJVpGREPsaFuNAoeAchFTk27Gi7xvioXQ9xL7toXCsfJGk8HE3EgdfXtufBrdLNeihmeacac3NBff5jZmRgEoOgI8Wy/HcdcUx9ZzjcHf6rkjj4ct6bZwefmUETrRu5mC5qa8P1A1wE+uX7Mcp13T1jf/PaUPwQXy2KW3D6FerTg+/NbEXxuwILVwD1ZOv46XjsXjzYv5hEhgf5FJHF27GgnU7pa5W4ccIWVvH8DFScNBGdYqoq0wQP/NmzrxTyson8wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/CkHGiuMGfsyWQZN7ajbK7a0DHD+clc0/kQD4EaVk3g=;
 b=YV6Y456qrujsMGL10LOfUuYLaPQvGwIl+thEPZmO5XdRD92KmmN+pm9ft+NsDwFwsqryGK0ppgWT/F8KpIMCA1CXh1lPcFbvKG6Eur/sjtzHai51SeM3V7VZ3wqV1hhXR7lqNwnMK86I6aMmU4+9rMCGxFLsz2CiNJzJxGuHUo3ywDTyM3MW8iUMsPvXSQz96aeER26Qr9AEKnJVmQudJchU7hTauM1F+22x1453HIU+C2GUpHk3x7xWjA7u3DekAqlyE54grRgbT7vkX30pFpL4Usd77lEMWC8eeGOtz+HrY7Mee7l6yJgAP1MH4OfJoYl7baN7FTczvgC0QLfZqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/CkHGiuMGfsyWQZN7ajbK7a0DHD+clc0/kQD4EaVk3g=;
 b=5tPw9f2s9PPPCLnjF41/aH7vt5ZesacwHsBtShlzMV/f52lXi3pqmI1MOn9d1s/Duucf7dOWoXMtaInaFcWMizirqIIacHXQpAXCqVKZ4cZF+j+J9CfXHhreM0rslivX/wYL4JdzZeWfVYQbWnGY+P41DZ/oV0q7Obw1N0YoUpk=
Received: from MW4PR04CA0090.namprd04.prod.outlook.com (2603:10b6:303:6b::35)
 by MW4PR12MB7143.namprd12.prod.outlook.com (2603:10b6:303:222::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Tue, 15 Nov
 2022 13:17:07 +0000
Received: from CO1NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6b:cafe::53) by MW4PR04CA0090.outlook.office365.com
 (2603:10b6:303:6b::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17 via Frontend
 Transport; Tue, 15 Nov 2022 13:17:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT038.mail.protection.outlook.com (10.13.174.231) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5813.12 via Frontend Transport; Tue, 15 Nov 2022 13:17:07 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 15 Nov
 2022 07:17:04 -0600
Date:   Tue, 15 Nov 2022 14:17:02 +0100
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
Message-ID: <Y3ORTv/1YbTFJQzq@rric.localdomain>
References: <20221109104059.766720-1-rrichter@amd.com>
 <20221109104059.766720-5-rrichter@amd.com>
 <6372d85ed793f_12cdff294f@dwillia2-xfh.jf.intel.com.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6372d85ed793f_12cdff294f@dwillia2-xfh.jf.intel.com.notmuch>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT038:EE_|MW4PR12MB7143:EE_
X-MS-Office365-Filtering-Correlation-Id: 93d3dbaf-ab4b-4569-900f-08dac70bb275
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vbQMbnQnuEFSHcGe72w/4ssl9OYHl0HRU/b3/tnjE4LHOPAMDgESSftLw+u/25+BPgSn0nv1bzDPPouEj++4UZId/4mSQX9mNMnCJeHGsFx3Gv8oB+hoNpsVYJSfuACgpR4ww4V022SCGoUgvPdImV/rsLuv9yG5t0Nx0LuXfurEcpghNth0o5F9Jiktoo4y6OdRIoOqVbSHFKcEd0D63mMS6sacTRyhc/ntToqZ4lCJ7JD5mYagzRSg3h+DDNq0YzoOpTwkCwleuQfQoO2GtESBeTbWtcMjH87ZCedwM3iJ9dY5JK2EZPoMcIisfC0atfZuzXMj+HJQJhwF3pSwP/cT7kUTXQRxmoyhTdRAP1jOnejn8zY8ey6JbW6aVkG89kwcHx4S7fMjasYPvmxKSMDf0QKltFJQOUALnFL+kLFbAeZIHDLGlrxclpYx04593d2sSv/9TSqcmFx2d73UrQErYIt6MXRKp6+rqBn4UGkTJB+o2aRkqef1yWbBLnZn3u+bhCoyawuyAk4/8n1KHL511/CSRGptorPlkXhqmb6Qz0KAPRyrRJlxKj3P48nDqYpCGdyyO4JoQjkJ4hGlyWTjv4M/X4vdQve4cAfKTnEVIj5yNRYA38qwwFiKEJNE1P2d2Bda3ypPzhfz4N5o6tKbEJ4xKMknFbxRYsbeFqVOzSUIJiXoJMD8KmmDt30Fm5vyBrrVThu3plymrzRM6lpt9F3nEA/aD9YTgaRXonXn2dASVonn4YyVrQp5T2dhrj+i+8AEtqbreraiFfH/MVNji+73U+VGiLgLqldGLHWqggKlWQ6LBKQENfot57wD
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(376002)(39860400002)(136003)(451199015)(46966006)(36840700001)(40470700004)(9686003)(55016003)(70586007)(6916009)(70206006)(81166007)(356005)(40480700001)(40460700003)(82740400003)(36860700001)(16526019)(41300700001)(336012)(186003)(53546011)(26005)(478600001)(7696005)(316002)(82310400005)(2906002)(54906003)(5660300002)(426003)(4326008)(8676002)(83380400001)(7416002)(8936002)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2022 13:17:07.7400
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93d3dbaf-ab4b-4569-900f-08dac70bb275
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7143
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.11.22 16:07:58, Dan Williams wrote:
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
> 
> I changed this to:
> 
> 	if (cxlmd->cxlds->rcd) {

I a mail to Bjorn I suggested to have cxl_dev_cap and a cxl_port_cap
in the pci_dev struct that could be looked up too including RCD mode.
Checking the pci_dev looks more reasonable to me here, though we could
have a flag of it in cxlds too.

-Robert

> 
> ...where the cxl_pci driver sets that rcd flag. Aside from keeping some
> PCI specifics out of this helper it also allows RCH/RCD configurations
> to be mocked with cxl_test.
> 
> > +		port = cxl_mem_find_port(cxlmd, &dport);
> > +		if (!port)
> > +			return -ENXIO;
> > +		rc = cxl_add_ep(dport, &cxlmd->dev);
> 
> Ah, good catch, I had missed this detail previously.
> 
> > +		put_device(&port->dev);
> > +		return rc;
> > +	}
> > +
> >  	rc = devm_add_action_or_reset(&cxlmd->dev, cxl_detach_ep, cxlmd);
> >  	if (rc)
> >  		return rc;
> > @@ -1381,8 +1397,6 @@ int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
> >  	for (iter = dev; iter; iter = grandparent(iter)) {
> >  		struct device *dport_dev = grandparent(iter);
> >  		struct device *uport_dev;
> > -		struct cxl_dport *dport;
> > -		struct cxl_port *port;
> >  
> >  		if (!dport_dev)
> >  			return 0;
> > -- 
> > 2.30.2
> > 
> 
> 
