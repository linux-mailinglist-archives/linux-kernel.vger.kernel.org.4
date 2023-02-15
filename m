Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A92F6980FC
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 17:35:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbjBOQfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 11:35:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjBOQez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 11:34:55 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2049.outbound.protection.outlook.com [40.107.244.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2782D234F9;
        Wed, 15 Feb 2023 08:34:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UYNikLafGcQd4R8RhDpd/vhHaa0YhxsISgwaYDVUa5YO2kNBgFghYfJVp1U2dCJEZQjIb/Llu7Ng0DttPkmMhBJxmui5P3iD0foIQ5YJKhtTMYqQCmAceEbyeDvJOqoOpi2bOyQQbS2A1lN0ZYuwJ8dbOyIL3Abub+Tgfek6EpasRCft4S5JpI3u0Hr3qyi3MbdfoyuFxd6maTZ7joQYcfvd46Mo8QKOrwF94Vc2kYxcCfrH4f2nRxw32VKb4m4w7u4zWDYtTWqeNowncpglV9+gtuwsCrUnNVlma6q4Sic0lbeQMcRLEeLBqHjHyNMpvmMjFe5ByQj9cXc7sfIJgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+ltj7ElR0IG0wFFmRnEmMIjZYCRi/ECWZbU6thqgmHk=;
 b=dbzPhrRiPU0MTr8Yrh3gYquyWmRT+3ZypwBhsVE+Y1ftfVzuTGK+95CtDZ4m4RXypYMzpHHYkj0fIbMrjfRvHnT4zCawYVuvH6iBLblwy3rUHql9QRAaXlXAHId4Gm9xqpdnwaf2IPwgvoBtvQ7sD370yhJ2pKGMDS8JFnt2MB3gzoyDpBAEjUBsBHdtLOfkv78WgWBL3tDfpTz15C2EI8TFP2Gw9zN1OnS9LxgKpvoI78qFbG2tQc13jP3DnjZirNjnYbzdKlXGt5Avy5/CBjRnFVnAMmCT5bQd+2G0d0dG/yFBJrZz9+f3FrDlj1kEigmbJtmvU2xTMkUfp/KWxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ltj7ElR0IG0wFFmRnEmMIjZYCRi/ECWZbU6thqgmHk=;
 b=xLtKfvOUgG3mGJjRFoeGzMQccyKbuZdapxidEVv3hXg7ihgww2Sm7uYWtLz2PbIbLVyJg134USmA4xYzfzBN2tpPl/CpUI/odIF53QTL19JVDd6UJpZ40AgjCPUbY7QX663AiuEFB/htR6Muarl1IgTbdP3k/Q9TeaZCnsgXbpM=
Received: from CY5PR14CA0016.namprd14.prod.outlook.com (2603:10b6:930:2::22)
 by SA3PR12MB8000.namprd12.prod.outlook.com (2603:10b6:806:31f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26; Wed, 15 Feb
 2023 16:33:05 +0000
Received: from CY4PEPF0000C971.namprd02.prod.outlook.com
 (2603:10b6:930:2:cafe::7a) by CY5PR14CA0016.outlook.office365.com
 (2603:10b6:930:2::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26 via Frontend
 Transport; Wed, 15 Feb 2023 16:33:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000C971.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6111.8 via Frontend Transport; Wed, 15 Feb 2023 16:33:03 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 15 Feb
 2023 10:33:01 -0600
Date:   Wed, 15 Feb 2023 17:32:58 +0100
From:   Robert Richter <rrichter@amd.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cxl/port: Disable decoder setup for endpoints in RCD mode
Message-ID: <Y+0JOrdGxaNJ1MvW@rric.localdomain>
References: <20230208071758.658652-1-rrichter@amd.com>
 <63e52846175ae_36c729428@dwillia2-xfh.jf.intel.com.notmuch>
 <Y+pOD5+DAsm3IKup@rric.localdomain>
 <63ec0b2370e46_32d6129434@dwillia2-xfh.jf.intel.com.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <63ec0b2370e46_32d6129434@dwillia2-xfh.jf.intel.com.notmuch>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C971:EE_|SA3PR12MB8000:EE_
X-MS-Office365-Filtering-Correlation-Id: db061c2b-3a0f-4208-5657-08db0f724fb0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3iTtfYO9O6ijMTrdz+BfYNUtS+RXUMDNZPak/5A9IUHyNS1/unykiAX0B07k0EkEjn6wt9E5RaCp05C30JrsqxLply8ejlZZMALTptrrYxlscLxA8na/DvD6OONqMLloa8+YzHVtNkOPhjG19m9jYS7TPY3psIQU2eAo2LIUeL3oGDsyWCtXcVeD4tj1e1sYcIowU+itV7tvWjy7TOS/DrIvZTzp4lGbtW0X+5kcUeDUTMmRam5Ilwre5OwRjK3z6VjUIvqfG5hI4kq7edt8aFSzrt6sK21aXg/IV608ArgmKGWDeWbMjRTm+yrQQNoS7CgwDZZEJ2FguJH/BUSt4r13wBQAEcnckU3KuQdnXmwk/c2UAabk45GFD3i1T4C6ABkF0cPccAZoryYZgkDfzgm/EXqf87TNyzwWp+viX8aut+lZG5C+n407o4EpNubGk0KsPSbxiRPOcHgG1s2c+K31HYa0xJUMt7VMSH2TR1V3UU9osYajQZMUp9cCTr/aQcYnkJ2ra6yiYllLxMG5RsQ4f6eAHR7iBEHXK22YDHeaUDgCGcCzpMYR5U97QBEu8GU2COHx9DjB3bq9fo/Gy01hiTf0DJRNzJkmkPC/DZWcEhTaseldIE2x6VCBr0aNG+VJqCwrZJybEXB4euYef+l+i9SKeaxlkv+mTCF9cQQeUZGPROb/V85LGyn9ZSdvCRgLrbkbVYPbzI6rrXkS4tUhiUfb1+Kv+hhUL71jSxSdv9NdIWl1ts9kTnr+1/6Z
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(136003)(346002)(39860400002)(376002)(396003)(451199018)(36840700001)(46966006)(40470700004)(6666004)(478600001)(966005)(36860700001)(47076005)(426003)(82310400005)(83380400001)(40460700003)(55016003)(356005)(40480700001)(81166007)(82740400003)(9686003)(16526019)(53546011)(26005)(186003)(336012)(41300700001)(70586007)(8676002)(70206006)(6916009)(4326008)(2906002)(5660300002)(8936002)(7696005)(316002)(54906003)(67856001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2023 16:33:03.8201
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db061c2b-3a0f-4208-5657-08db0f724fb0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000C971.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8000
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.02.23 14:28:51, Dan Williams wrote:
> Robert Richter wrote:
> > Dan,
> > 
> > On 09.02.23 09:07:18, Dan Williams wrote:
> > > Robert Richter wrote:
> > > > In RCD mode the HDM decoder capability is optional for endpoints and
> > > > may not exist. The HDM range registers are used instead. Since the
> > > > driver relies on the existence of an HDM decoder capability, its
> > > > absence will cause the initialization of a memory card to fail.
> > > > 
> > > > Moreover, the driver also tries to enable or reuse enabled memory
> > > > ranges. In the worst case this may lead to a system hang due to
> > > > disabling system memory that was previously provided and setup by
> > > > system firmware.
> > > > 
> > > > To solve the issues described, disable decoder setup for RCD endpoints
> > > > and instead rely exclusively on system firmware to enable those memory
> > > > ranges. Decoders are used by the kernel to setup and configure CXL
> > > > memory regions, esp. to enable and disable them. Since Hot-plug is not
> > > > supported for devices in RCD mode, the ability to disable that memory
> > > > by the kernel using a decoder is not a necessarily requirement,
> > > > decoders are not needed then.
> > > > 
> > > > Fixes: 34e37b4c432c ("cxl/port: Enable HDM Capability after validating DVSEC Ranges")
> > > > Signed-off-by: Robert Richter <rrichter@amd.com>
> > > 
> > > Does Dave's series address this problem?
> > > 
> > > https://lore.kernel.org/linux-cxl/167588394236.1155956.8466475582138210344.stgit@djiang5-mobl3.local/
> > > 
> > > ...that is arranging for the driver to carry-on in the absence of the
> > > HDM Decoder Capability.
> > 
> > it might only solve the missing hdm decoder capability. I need to take
> > a closer look if that also solves a system hang I was debugging which
> > is caused by clearing the memory disable bit in the hdm dvsec range
> > register. So the best would be to use this patch now to fix decoder
> > initialization in RCD mode and then have Dave's patches on top. I am
> > going to test the series too.
> 
> My concern with this patch is that it skips HDM decoder enumeration
> entirely in RCD mode. The CXL cards I have seen are CXL 1.1+ and do
> export the HDM decoder capability.
> 
> The driver turns off mem_enable in a few scenarios, one of them indeed
> looks buggy, but does not seem to be the one you addressed. The driver
> should only disable mem if it was also the agent that enabled mem, but
> looks like it does not always do that.
> 
> Can you confirm if this fixes this issue?

I have tested the HDM decoder emulation series (v5) and it fixes the
issue. Looking into the paricular change for that, I hope to get a
condensed fix for stable.

Thanks,

-Robert
