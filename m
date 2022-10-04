Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49CC25F3C08
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 06:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbiJDENG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 00:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbiJDEMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 00:12:55 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on20600.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eae::600])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8727026555;
        Mon,  3 Oct 2022 21:12:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XmciiDgSgkDr7Uaum82RGzwAKITJ7zE7gzxOSBmK2KsGFsPPE6apKXTX2IgZY4JMR59t23paeE7neh5s48FXzciNX/gWLPWMJ375VbS9xnDjUezuoCf/ZtODEfBDUQ32+pLXl9uPrYsWWx51PHJ0+OnLBTzzpLd7/yq7xZQtUITXIc0aroenD+wNbEVL2UbMUrL9UaShfy6DOa4ZSzuwVuVy2ccDPtQje+ZUSEv9UDBIYXc6qomQ/rMYDlFHZoIhZjGZoIaGOgRXiEsu4rPFklF1IaoaorhvhlT3LvuV75MGEv526PiVLdh5hVg78JvroRZaNTXyrnNRrutVzWjo3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qi7i829oiHFBcyPE1g3ojmpjvAbPixBVfUWwMJ9Ic98=;
 b=j20w9iQpgBRm0GtUQXsZKcLOfwKn3aw6lhPylt07DHd6vh5ik8aDhGoKukMZ3WKxhOA0dZExv8Ih7m1zujrVJcYOcOKM+NXTJjVTLR/TVlXd9Qb7HI7pMTOiQakkP8po811A3xFLy9Y7GIDTBhRpDx7O5TBA3zYCo+EJh8SHWwp/2bpFdLyiyo/5P6mDxnL/PLpHYCNuc96wk0LXSCL+G/34VMNNcp+i5BOcFAea03+1GHANFk1RftywBD7TexTZzcQGrQ3QYut2ltJD3/Wb+cGKyd0yjhk3pZn3yAnp580hePi5v7Lo928qKEI4vI7c4Rhxji5AkxAOiK+P5rMdyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qi7i829oiHFBcyPE1g3ojmpjvAbPixBVfUWwMJ9Ic98=;
 b=SPEpqhOP6BFj6WoTXMhL8G22QCWLivFQgtKOhmTMud+fRtoasGZt4eEZb1UlV+5w31MuEylaLyHzSMGnp/Q1Jrqio4atUjHty4qAwARfpvCHqPbJSPw0lRyZ4/0AXt00i1bl7helN9Bi/Dkh2mrMhnFKpU2BgOIdz6HLTPEk53o=
Received: from BN9PR03CA0140.namprd03.prod.outlook.com (2603:10b6:408:fe::25)
 by PH7PR12MB7140.namprd12.prod.outlook.com (2603:10b6:510:200::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Tue, 4 Oct
 2022 04:12:45 +0000
Received: from BN8NAM11FT080.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fe:cafe::74) by BN9PR03CA0140.outlook.office365.com
 (2603:10b6:408:fe::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.30 via Frontend
 Transport; Tue, 4 Oct 2022 04:12:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT080.mail.protection.outlook.com (10.13.176.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5676.17 via Frontend Transport; Tue, 4 Oct 2022 04:12:45 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 3 Oct
 2022 23:12:42 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
CC:     "open list:THUNDERBOLT DRIVER" <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <Sanju.Mehta@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [RFC 0/3] Enable runtime PM more broadly
Date:   Mon, 3 Oct 2022 23:12:22 -0500
Message-ID: <20221004041225.1462336-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT080:EE_|PH7PR12MB7140:EE_
X-MS-Office365-Filtering-Correlation-Id: 0511b7c1-5d63-4119-3b38-08daa5beb0f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SVlqrUVKaFiIsMlTTAUzUd2XLv1N+OFLdpCp4wRpTUdyNt5Ks3HBaBKt4IH9djtCkPRl6s1gn/M2HMaP3urcuQY++KZ6rkK9znL6F5YgwlCbktWpEBaRymqTKXibGfmf4qM5aXiL9B9ko3cuwNwjLpg12c14IGsaKOuPOlnOEPb6XILd2CAx/s8yCSlKhPoS/a9PYceXpTw8HPMLc+FoAJyiO0r7PJBXCt7qTBIFsJpmiJ4NuMUZC1+yYVFC8/nnP8yxebEQ5k1UVVqeqQvkGyZYKeR3ZhlGrlk5yeiLK3Sr5lMQkfliKdt/xuo1mGwBWvXrKZHkq1ZoXO4UosmZ9FIemd97T7kGowRfTTJpjUgT2Dn796kH1s4+bxw1CU1LOFWNkP2p26l3v034BVtVwyPNT9IgocQB8J3sQLobrk5LhQPrpsmd0XaWZHyMvhJLUnRD2PlTohGSyPSd5v69P8Z1fWKQ7QDgyMPYL0t6tiAQaOS3l4e6LxxCtg9HYxfj1CbWFXIUfTsp5jqatUI3oZt/6cyHR7xgLfNj+IM+Qe/4Ojcm4H/450fdiem7n8fb16oxeMYaZPpwXf64A6qPMhWDCOAhj1N891aiIc7bC7mWN8wUouVyJCy2IhgM0/J+vpnOVyglhQYiqTRE1xfmmPs3xGZtp7ROTXyua6iH7q/5B1qsXjRRKgdXX03NwtW5SB8Zxfb5/9ZEznyEXRPcAucpnG8LSy29GYNN2WrS8Tb56LSDnEPKUyHqEl6TOd30/PsA1zqv5FS+IrWrcWFNm0ng/qo5uwmt6XOvpzKVqArsJ+O/czvpVi97nqL7ErO4
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(346002)(39860400002)(396003)(451199015)(36840700001)(40470700004)(46966006)(40460700003)(82740400003)(36860700001)(16526019)(81166007)(478600001)(36756003)(82310400005)(40480700001)(4326008)(41300700001)(8676002)(356005)(6666004)(26005)(186003)(5660300002)(70206006)(86362001)(54906003)(8936002)(83380400001)(70586007)(2616005)(316002)(1076003)(6916009)(44832011)(336012)(426003)(47076005)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2022 04:12:45.6730
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0511b7c1-5d63-4119-3b38-08daa5beb0f4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT080.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7140
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently every time a vendor introduces a new USB4 controller changes
need to be made in xhci-pci to add the PCI IDs representing the XHCI
controller used for tunneling.

Due to low power management needs every single integrated Intel and
AMD controller have needed to be added.  As we already know which
controller is used for tunneling by the device links specified in
ACPI tables, this is a very good heuristic.

This series uses that as a heuristic, pulls out all the IDs added to
xhci-pci and then adds the new IDs for those *not* used for tunneling
on AMD's Pink Sardine (those are covered by patch 1/3 in this RFC).

If 1/3 and 2/3 are not agreeable, then instead patch 3/3 can be re-spun
to explicitly add the PCI IDs used for the XHCI controller used for
tunneling on AMD's Pink Sardine.

Mario Limonciello (3):
  thunderbolt: Allow XHCI device links to enter runtime pm
  xhci-pci: Remove a number of controllers from the runtime PM allowlist
  xhci-pci: Allow host runtime PM as default for AMD Pink Sardine

 drivers/thunderbolt/acpi.c  |  3 +++
 drivers/usb/host/xhci-pci.c | 26 +++++++-------------------
 2 files changed, 10 insertions(+), 19 deletions(-)

-- 
2.34.1

