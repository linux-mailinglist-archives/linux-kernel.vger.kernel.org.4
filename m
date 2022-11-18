Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D14162FB36
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 18:09:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241950AbiKRRJz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 12:09:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241792AbiKRRJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 12:09:50 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2055.outbound.protection.outlook.com [40.107.237.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B6098C79B;
        Fri, 18 Nov 2022 09:09:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RAkbMU106bs1yh91aSTt2Lpn4WSTRy31FmNGtO4YuKWDFjeduz8kTw46VblRVJhfO8AISsVOB0ZXK30ep2V20BPwfUZGett8qzEP4gJadkTcBtWKEoj37VpQNP7J+mHF0pbzWSQ0eUa7o/oBhVA9iZxFXyJTyVRuxF2bfOmsUk5G9uvPPba8Pt6jnBVLWWYLOZcWKNwGJDbzbAnf4N6f+z7LItrJDJtUCU3LBFw2np9vWAFZYtjZ5Yp4GHoktZV/KpNZETfDr6l+gxh3bOvFtffuam4M7AUnqvGQ/Eyx22pD8dR5+X42dR459Atih5rxQIc4jF2kovtS6sWeHg5j2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=23luJiCgLkeLdBq3muDDZ/QXePPd4pnAQAWcpWPnSyc=;
 b=hVajY5EXIYIdGdMxxVda11V5IPz3R1qQc9wPmZYULkigip0JGXP3PpOfj/y3BxJE2R7m3UulSwBNNpfj5DJ8puAEtzKEIY/JxSSxxxMdwLKm4YaNvUKSy0VXvImceTESeMpYyUsmqme6tkaD3aSCqmFYFY/aViKGm4UlqPqBMPCzpC8w7hBa+i3aihnwA0vTAwUfKYAWqhetuWiD7gaWQGG4X3oCILSTiuegEODDMNbr9NkOneI1E4wFUO3w7yWllJsdkzkVTvhTP1LpIp4chPwWGdrz0NrWjWahbmphQwgZSrIkgyC/shwuDdk4HpeC07ArdS8R8lANfH6d6qUMYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=23luJiCgLkeLdBq3muDDZ/QXePPd4pnAQAWcpWPnSyc=;
 b=pVTT6TwPNEihgMTtZHP6h01paN5WRR7HeFeSGtG5J/KlHwQZ4qnKo8wuzt+4mkmRlD7/V+/uWGgrdahIq7/JCprFOexRyTBB14ueTnfZ1H+dnwFA8B+yJUQu8FxSmnRC/1lDSDcyaX+qLwyRoYxhBg9ufCWB15fjOBYizlM2o+k=
Received: from BN0PR04CA0037.namprd04.prod.outlook.com (2603:10b6:408:e8::12)
 by MW5PR12MB5622.namprd12.prod.outlook.com (2603:10b6:303:198::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.19; Fri, 18 Nov
 2022 17:09:44 +0000
Received: from BN8NAM11FT116.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e8:cafe::4a) by BN0PR04CA0037.outlook.office365.com
 (2603:10b6:408:e8::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.9 via Frontend
 Transport; Fri, 18 Nov 2022 17:09:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT116.mail.protection.outlook.com (10.13.176.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5834.8 via Frontend Transport; Fri, 18 Nov 2022 17:09:44 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 18 Nov
 2022 11:09:43 -0600
Received: from iron-maiden.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Fri, 18 Nov 2022 11:09:43 -0600
From:   Carlos Bilbao <carlos.bilbao@amd.com>
To:     <corbet@lwn.net>, <lukas.bulwahn@gmail.com>
CC:     <Dhaval.Giani@amd.com>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <bilbao@vt.edu>, <ojeda@kernel.org>,
        "Carlos Bilbao" <carlos.bilbao@amd.com>
Subject: [PATCH 0/2] kernel-docs: New maintainer and Spanish translation
Date:   Fri, 18 Nov 2022 11:09:40 -0600
Message-ID: <20221118170942.2588412-1-carlos.bilbao@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT116:EE_|MW5PR12MB5622:EE_
X-MS-Office365-Filtering-Correlation-Id: 093b4516-a50a-4b9f-709b-08dac987b077
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nsE0yvfHr5RYRDRB1lqUX8FiUXCCgCe6Qv4lIiRxN2jKXzsDL0jbYe40LpmdQOZaqzLBDD4yfI5ubvRNZDkRsF/spoUAy5ymQs9ZFCerrQqi4PtLcdVwld5BPOUM+VDyVGst4Q+KFdkp6nhbW+sXHP2IVAeGU7IVfT4xS1k4PeOO0mwTTuYWTbEfeeaFZluPFAja/L9ffUehygts2YH197yhIl/lnpzBQNNOn8w5v5RjLZWmFWbiFT1Apd35yguG3eLqd+PhAOjalWuLIHfPQLu8Etx/FLaEpAc9mYQJL9idC8L2iRWqjJQfQfOa/Nd0JVmaQYg9yDMIe3NV3xfLQlzB/y+Ic7DJoSZwp4cuZSF7XzrPMRoL7joqFmS2hoeOUj5FYFU4R0MeipV12EKlCScc9eJi2SHS70chDoXdHuvTBCOhnJk2qr2CH+CQGxhlxNOvhsCNBY9KPd99rf/6mk+ZPHkXyT9kV/Fd8cVhqMsUfCGLb3wkaqi8FJLrvnRBwcTcZPNV9MIo06eEBhWFjqtUi3QAPqfo9jmZcMFbT/tW9qOwi1oRWx8a0Vc115UC/CAp/T23qT0Kl7OKQzeUij2hM7PClYe46gTgfebnL7EjCn/pFw3B16nuAMJ0J3XPH7RzGI+CRu39Q5LRPZCmMU+UZdT4+5Tzn3s6JdRs3rW1aDMwxazWcZEgXH3h6wuEjPLbK69AFeKYmlsU6C1kSF+3C9HJ6pCyWhwgV3Pn+TWfPWyaW/C4wLye7PGRhOfb2M21DLk7t9dWMeHDXH5r1w==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(136003)(376002)(346002)(451199015)(46966006)(40470700004)(36840700001)(82310400005)(86362001)(83380400001)(36860700001)(40460700003)(82740400003)(81166007)(356005)(40480700001)(426003)(478600001)(47076005)(1076003)(966005)(7696005)(4326008)(8676002)(70586007)(41300700001)(186003)(54906003)(316002)(70206006)(2616005)(8936002)(110136005)(336012)(5660300002)(44832011)(2906002)(26005)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2022 17:09:44.4263
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 093b4516-a50a-4b9f-709b-08dac987b077
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT116.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5622
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a cover letter for just two patches, but I should provide context.
I was going to translate kernel-docs.rst when I read:

“Initial Author: Juan-Mariano de Goyeneche (<jmseyas@dit.upm.es>;
email address is defunct now.)“

I figured Juan-Mariano (CCed) may keep a Spanish version of the document,
so I searched for his new email. He replied back proposing me to take care
of the document from now on. I will carry the torch with pleasure! This
should also make Lukas happy [1].

This cover letter is also a call for anyone interested in adding new, more
up to date references to kernel-docs.rst. The document has been abandoned
for a while but its original goal is still important.

By the way, Jon, I read in kernel-docs.rst, regarding LWN.net:

":Description: The title says it all. There's a fixed kernel section
  summarizing developers' work, bug fixes, new features and versions
  produced during the week. Published every Thursday."

but I don't think LWN.net is published every Thursday anymore. Let me know
if you want a third patch updating this as well.

I also use this chance to send translation to Spanish of the document.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/Documentation/process/kernel-docs.rst?h=next-20221116&id=f46b4b168cdb3b16ae8c7792c28d0b921db1932b

Carlos Bilbao (2):
 docs: Update maintainer of kernel-docs.rst
 docs/sp_SP: Add process kernel-docs translation 

---
 Documentation/process/kernel-docs.rst         |   4 +-
 Documentation/translations/sp_SP/index.rst    |   2 +-
 .../translations/sp_SP/kernel-docs.rst        | 643 ++++++++++++++++++
 3 files changed, 646 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/translations/sp_SP/kernel-docs.rst

