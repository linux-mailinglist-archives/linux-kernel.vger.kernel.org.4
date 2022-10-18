Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 815C96032AA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 20:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbiJRSnf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 14:43:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbiJRSna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 14:43:30 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2060.outbound.protection.outlook.com [40.107.244.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E62C8E985;
        Tue, 18 Oct 2022 11:42:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Aht6fevw2IvYs1KRynYYhx583oaiC+h2WlbPwmmUNVShIqIrTfWwVm70a4SBXEBWYq0wshmE4lUp5p4K8X8lOMEOK24e+eV6fLtqdzWJac1D1h7Ahy2qn7lJYjEhWAvlI5AoBexJdoubDIU2Cnk5NeJpRMKeYbE2jEuT07NaAQavJ/S+zUZQ9+amFGdIZd63Hq6ZP/0JbMkfcLwAI0yTCvCMDDqhfJ2DXYL1eQA14gfJpvhGGhCfecnwXrVQPxsYtAUkdcMJhr7nUgqA7za6Qg9vo2dmduBIjwl2LXUBosSMaqn6ZVrdHoPpiHJvikLM1QoS/biKzXV2YOR9n8ouIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i+SG4SoMr00x1r/mjS+6pM6+7AgP2tvkcUlQW/IlE2o=;
 b=fQuFHuRiXwOTbE/OnlEcguVmjqEGcjSDK1yRrzGddsME8nXqT8sdW0Xo1HzgAJXPV+IojHDhiQDvTH04VeehNCtgRwt3lT+aiAhljZGb4R6Vs7F6Pp54CyRJAtyqhf5GzoJXsAOh+iXrCPNmL2NIPGOdSs2PqvcpsaDUDTGcYvheDF8XAcwADO9QAa9ZPjKhDz5a8o4D/+dz0sgYx+NxnXAhZd92jpMXvGfIIIhDU2oHJpElgIDoVHTGLQafH+KH+Cuf166BV4D5cYHIiKM3DjMgGdkUfF9F7JAg0v03QDlHoLltlebvFtpUp6kSMv8y6JsF5BCibDhZjKtvDPYQOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i+SG4SoMr00x1r/mjS+6pM6+7AgP2tvkcUlQW/IlE2o=;
 b=rbvjQqEcKb/mxhyAV8O/QDAFx5frtwMLuQP568GScjW/B/hCJrbiHAIJNg4vDgEdyYt8S5VeJIPQmXZADURj864dROI9TKhsj89kgZgPJ1Y72cNisxEhn74trvvGVo0HZrdLvGc6Qv7F0iLe2qfcc813Em/6Ij6i6ENfEzxP1Zs=
Received: from MW3PR05CA0011.namprd05.prod.outlook.com (2603:10b6:303:2b::16)
 by SA0PR12MB7090.namprd12.prod.outlook.com (2603:10b6:806:2d5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.31; Tue, 18 Oct
 2022 18:42:13 +0000
Received: from CO1NAM11FT043.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2b:cafe::59) by MW3PR05CA0011.outlook.office365.com
 (2603:10b6:303:2b::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.11 via Frontend
 Transport; Tue, 18 Oct 2022 18:42:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT043.mail.protection.outlook.com (10.13.174.193) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5746.16 via Frontend Transport; Tue, 18 Oct 2022 18:42:13 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 18 Oct
 2022 13:42:07 -0500
Date:   Tue, 18 Oct 2022 20:41:47 +0200
From:   Robert Richter <rrichter@amd.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Len Brown <lenb@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Terry Bowman" <terry.bowman@amd.com>
Subject: Re: [PATCH v2 06/12] cxl/acpi: Extract component registers of
 restricted hosts from RCRB
Message-ID: <Y07wfi7XSxHWr7LD@rric.localdomain>
References: <20221018132341.76259-1-rrichter@amd.com>
 <20221018132341.76259-7-rrichter@amd.com>
 <CAJZ5v0iweDu6imi_P3eRTTk0Xpzv-swB05fYxmTMAHAjCN2tiA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAJZ5v0iweDu6imi_P3eRTTk0Xpzv-swB05fYxmTMAHAjCN2tiA@mail.gmail.com>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT043:EE_|SA0PR12MB7090:EE_
X-MS-Office365-Filtering-Correlation-Id: 720f6c35-a806-43ba-71f3-08dab1387940
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XdgMuTWlbwCjY5HbZ0+vE/PYcABwQJ9UoVxCH6aidCpgqE8ECzJZxABIo4K8aiqE8Wa9XcuWxhUYGihx65pZsvq7/sKOCeQBwT2YE8gnONcv95ONx5HiqU2wad88HI+id2rgGwipPVtwlUCciFJt6oDNnRXqfhfpQ3eeXYywRvh27ke4jMUfv1UlGrfyrhIr/ujPQvEBinXiSp5+2KSUMdpJxSCQ8Tn666txLY7if9K7DfO+u2kK9Ccq6rXh6QxW9qGBked+ADsPJwKQ2OrFwJqdNIEyrk5RwYUYTDaNob48lqQCRiVT5WzcpPkLFcIWjDRJ46CGo/INRgjEb/3+f3a5bi/SD7/wFSM8GR9ZmvPMcagp2pS+KtNcbPObdFxd5TpxjTLLy+zjPNdviCg3395polKHI6uyas6e/bDFbXq9GQQdcZs0+tudsT+JinmxpncqiMTeQ7NLndLjpMIdeKimj4MRn5YwMCvIES/nEhcGNTZEc79LVTGagfc4wmxnWtejjyPyA18/HRgM+GAmgNJa51LMa7y5NLppCFhuTnjKDoaQtkPBsgOGRcF8p5xdrkCMroStEhFkFBKcugiZp+5bEudNlA5CmyX5qFKgGpkliXgjyG+ruskM1U5SuX4YtE4hF9C/t7L1z2yrWVw7uENS/u/B2f2ADx9/YeBnYUlNZevsBURms5rJKRH+SVto+HdzF5veWocf0qD9T4KAQAAd5horWUxrwTZ/RgSKO3aYbAE4PHP3Hk9rgpzS/dCK7+XpU2zRJvtg3j4aWgBpiF3HkFKm71HXhd4Cl46TWIk=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(39860400002)(346002)(396003)(451199015)(36840700001)(40470700004)(46966006)(53546011)(9686003)(26005)(6666004)(7696005)(478600001)(36860700001)(83380400001)(336012)(16526019)(186003)(40480700001)(2906002)(5660300002)(7416002)(55016003)(40460700003)(6916009)(54906003)(316002)(4326008)(8676002)(41300700001)(70206006)(8936002)(82310400005)(70586007)(47076005)(426003)(81166007)(356005)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2022 18:42:13.4398
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 720f6c35-a806-43ba-71f3-08dab1387940
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT043.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7090
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.10.22 15:31:16, Rafael J. Wysocki wrote:
> On Tue, Oct 18, 2022 at 3:24 PM Robert Richter <rrichter@amd.com> wrote:
> >
> > A downstream port must be connected to a component register block.
> > For restricted hosts the base address is determined from the RCRB. The
> > RCRB is provided by the host's CEDT CHBS entry. Rework CEDT parser to
> > get the RCRB and add code to extract the component register block from
> > it.
> >
> > RCRB's BAR[0..1] point to the component block containing CXL subsystem
> > component registers. MEMBAR extraction follows the PCI base spec here,
> > esp. 64 bit extraction and memory range alignment (6.0, 7.5.1.2.1).
> >
> > Note: Right now the component register block is used for HDM decoder
> > capability only which is optional for RCDs. If unsupported by the RCD,
> > the HDM init will fail. It is future work to bypass it in this case.
> >
> > Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> 
> What does this S-o-B mean?  If this person is your co-developer, you
> need to add a Co-developed-by tag to clarify that.
> 
> > Signed-off-by: Robert Richter <rrichter@amd.com>

I picked up an early patch and modified it significantly, so I just
left the S-o-B. I could change this to a Co-developed-by tag. IMO, the
S-o-B is ok, but could be wrong here.

-Robert
