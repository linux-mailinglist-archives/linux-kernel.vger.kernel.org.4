Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77016604321
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 13:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbiJSL0g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 07:26:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230419AbiJSL0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 07:26:09 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2062b.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8c::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6501D164BE9;
        Wed, 19 Oct 2022 03:58:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z4BnCBImDs8qZy9LZ1I+Bnk0zMEBq3UBlxW2lmwb1FudAyvh7OTyUXOWksLdFtoZalOzpx9Ssx+R/v6yOo7c9RrJbNw3BXzz1TDhzdiVo5K7nw/r6r+8+uthYbIZz2UrvFr1XKT9kxSDzNz09SPE3NI4a1TZtpfVVGoTQa7I67tH2fnrt2rh4EQNc/XLG0JOl8T4EXXd+katiMUs13czfBGOM7dLThOlQWiku3ntNoP7PSvNg6uh0PJychCyjFtxMZnripzmnxswsNI/6BZ2hFTfIvEdriGySEkx8kz8gQBdpT93z6umd/Ws6di3jrmg4UvDSwnsnBQMIJBDkNTd0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VzqKeBqnZMIFlWKtPnbBGELKbK3ES/LDsDXh2ImIUqs=;
 b=JTgjT0UPKSmbrGD/NrkbaDAMZAahWH6A40hWxfmEsY3PDrUyt9hwaNaN2rVsF2LIAN0tvECIs3vSFKgY/3QTHfB0wKqV3ilodAxLBb+6hRqPb4tKE1RMLefKTieQ2Jd7EkzdVlNFJ5rpuDbCczGMkG8JO9fENXJuK9ojaynrWscnw+KbgPEajinfLmyL7Vm0GEXYjhKghXQAjw6B6dsgRXbLhOEn4NkW/7+9dknNX/YnbxH+forAfOngrrv8YnxZB1+1J5sN5139CGLzDxrPUGPmonfO+UwmS3EHngjHcVmsrMHJGtyIg8YDT2CE3IWlw/YFL8eSgQKmaEaQOtMUPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VzqKeBqnZMIFlWKtPnbBGELKbK3ES/LDsDXh2ImIUqs=;
 b=Y0p634MRygdhjj9BoCDiA5kz4x6Oz0Ipbf8VmX8yVGm/OCUQkOhz2gTi1kUUiwVMVjp3cP4WwlRE3+2Zc2UDbcUmk0OCKfPjciVssk/LyfP1CbuJeslb5piLvx13bJMdRvJiYaFs/WlL6Mz4nCX/gBtdCdHvn07e9Gq6Y71xXl8=
Received: from DS7PR03CA0088.namprd03.prod.outlook.com (2603:10b6:5:3bb::33)
 by IA0PR12MB7649.namprd12.prod.outlook.com (2603:10b6:208:437::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.33; Wed, 19 Oct
 2022 10:46:34 +0000
Received: from DM6NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3bb:cafe::7) by DS7PR03CA0088.outlook.office365.com
 (2603:10b6:5:3bb::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34 via Frontend
 Transport; Wed, 19 Oct 2022 10:46:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT017.mail.protection.outlook.com (10.13.172.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5746.16 via Frontend Transport; Wed, 19 Oct 2022 10:46:33 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 19 Oct
 2022 05:46:30 -0500
Date:   Wed, 19 Oct 2022 12:46:28 +0200
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
Message-ID: <Y0/VhNAzmZOcUT01@rric.localdomain>
References: <20221018132341.76259-1-rrichter@amd.com>
 <20221018132341.76259-7-rrichter@amd.com>
 <CAJZ5v0iweDu6imi_P3eRTTk0Xpzv-swB05fYxmTMAHAjCN2tiA@mail.gmail.com>
 <Y07wfi7XSxHWr7LD@rric.localdomain>
 <CAJZ5v0gtbzD9H9OEWS1X5OnFCntFTAnNbxwrU3FpZbnR5rQ6fQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gtbzD9H9OEWS1X5OnFCntFTAnNbxwrU3FpZbnR5rQ6fQ@mail.gmail.com>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT017:EE_|IA0PR12MB7649:EE_
X-MS-Office365-Filtering-Correlation-Id: 263a91f0-0e10-46e4-6196-08dab1bf30a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M68Bup2fu3CtVLXIxZaDM3/fs54PchPpuRHJXtNeL6qJ1sJhxpUgUgLK1u5vgXMW6Wame90kKHFCxb9ybB5mh0sVTVvQJxqeoP+zzutCAuCfC/+abYNX0iVIR39THUSewggxKOn2Ia1bClu2RDnfUBgoPrXOPiKXAh1i/W2Ojx5go3/30aBZ+4ZCh4WgCBGiLQ32e1rn/eZFbOGUlAbxixiQ5tZzqowkRCfKFvf9rpta3Tstkd6kffA9L98NKefajTfvp5YM7aySY4l17HAu58K23PHz1Sp40nK2H1dbVViHIE3aD/BoKNrex5FO7yRjVYmAh/SMV7h7iYcXc9kK7VsMCsKjHdiaJwoyWVcP0JVcilH8S1bR74H1t/p0Mwi0rzcIclx7VCj4NHUhGSziG8P1pHhRmVTBs2uLZUQ3IQnkx2WkQi7v2LgyIJXXbdGuC7frhitUOTx0QGJg1eaS/ZI6McyUXcxXT4e2Mm+CXcOTB5hDqbwmI4sGgFU6bMdccUzL6JCSrUEcJZWI2KPbNrlhIqEN/2e4eiB1Ns7XBs10XsWhxaiZQuNw6zWsbdIq/xt4U29rEgVgiGGbgBL/LoAms323GeDn7Os7skWaJ97Br5PsVAebtj2L6dvOp3DCeHTX4sR/yThbgPyyFZImE/7dkYDnUApPs6Tz1gwDlGVUz4RtwUVKswW4QKMl6Zrip8GFE2QrXusiNapXUH5u/aZ9x6vBEFmAv20EZ8G+1qdQqpDciYySPXsba5i9LDXD1mKz5goajBt1wUx7HIRhbsVBShc/Xc9ump0FzS39l1M=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(136003)(346002)(39860400002)(451199015)(46966006)(36840700001)(40470700004)(316002)(6916009)(8676002)(70586007)(70206006)(4326008)(7696005)(54906003)(8936002)(5660300002)(186003)(7416002)(81166007)(356005)(41300700001)(16526019)(2906002)(9686003)(53546011)(478600001)(47076005)(26005)(336012)(426003)(83380400001)(36860700001)(82740400003)(82310400005)(40460700003)(40480700001)(55016003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2022 10:46:33.8358
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 263a91f0-0e10-46e4-6196-08dab1bf30a4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7649
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.10.22 20:57:02, Rafael J. Wysocki wrote:
> On Tue, Oct 18, 2022 at 8:42 PM Robert Richter <rrichter@amd.com> wrote:
> >
> > On 18.10.22 15:31:16, Rafael J. Wysocki wrote:
> > > On Tue, Oct 18, 2022 at 3:24 PM Robert Richter <rrichter@amd.com> wrote:
> > > >
> > > > A downstream port must be connected to a component register block.
> > > > For restricted hosts the base address is determined from the RCRB. The
> > > > RCRB is provided by the host's CEDT CHBS entry. Rework CEDT parser to
> > > > get the RCRB and add code to extract the component register block from
> > > > it.
> > > >
> > > > RCRB's BAR[0..1] point to the component block containing CXL subsystem
> > > > component registers. MEMBAR extraction follows the PCI base spec here,
> > > > esp. 64 bit extraction and memory range alignment (6.0, 7.5.1.2.1).
> > > >
> > > > Note: Right now the component register block is used for HDM decoder
> > > > capability only which is optional for RCDs. If unsupported by the RCD,
> > > > the HDM init will fail. It is future work to bypass it in this case.
> > > >
> > > > Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> > >
> > > What does this S-o-B mean?  If this person is your co-developer, you
> > > need to add a Co-developed-by tag to clarify that.
> > >
> > > > Signed-off-by: Robert Richter <rrichter@amd.com>
> >
> > I picked up an early patch and modified it significantly, so I just
> > left the S-o-B.
> 
> In that case the right thing to do is to mention the original author
> in the changelog instead of retaining the S-o-b.
> 
> > I could change this to a Co-developed-by tag.
> 
> Co-developed-by should be used in addition to and not instead of S-o-b
> when one of the authors is sending a patch.  However, all of the
> authors need to be familiar with the patch in the form in which it is
> being sent then.
> 
> > IMO, the S-o-B is ok, but could be wrong here.
> 
> It isn't, at least not without a Co-developed-by tag.
> 
> There are 3 cases in which S-o-b is OK AFAICS:
> 
> 1. When it matches the From: address.
> 2. When there is a matching Co-developed-by.
> 3. When maintainers pick up patches and add their own S-o-b.
> 
> This case is none of the above.

Will add a Co-developed-by tag in my next version. Thanks for pointing
that out.

-Robert
