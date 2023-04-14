Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CDB56E194E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 02:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbjDNAp2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 20:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbjDNApN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 20:45:13 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12hn2220.outbound.protection.outlook.com [52.100.167.220])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85F9226BB;
        Thu, 13 Apr 2023 17:45:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZFv7EXk+kblIrBWLnG/Keen7q/KqQaJo8LCS+TUZJFtSUokbzkNc+7XsUW3gMiqoudRYLf0mOTE6alNHDJqXFdJ7ioEIjrAhFbnHIa6BSOr6hZln6pEmbIbeETdFRci9pwp/BxiYmmxvj5YrMOWjpQq59RLomUwqnZ02S5USETUZVlfscy9dDNfy8RwYcrMPQHQ8O1KGEmCxm3Y8fWbtB+1znIoiQkam54xWtgfgElPk9VoeMuCENSuYLEGw7dwl1fl+wEgDfetFFSSBdP/ooLzcfZkKKHxhO8gT/LpLdCGVCMN+xcnDFUEGuJxMwuLoi7606QayfqIynKnumNtmAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kStb/h2bxxTnpUoG8mlerqt8YY7TMtzqPvYaHaQ0ccE=;
 b=lcpEOchOuPMhogs4ZueieS6IGcbcDrFJhgsQESkrc45HDdU5cX59n/kygycygb8eo9jR2PaG2BkLrLaYw9J/2Iz8NamYOV/f9Z3YCYopIYUrdHj0cErrhgtZrMLUe67Iqhip2B3+pyZhXprwShbOBgdgxAXFfLvJqTTveN2C4YlmqLDz6nzzk5ZZVMuyFQ/H5DQQS87jT3XdNbYP0/u6SvPl9sjhEIFe3wQGblAKCftUUlAa0Cz9+1d/HO5uz1toqhdYh8l5Ml/pcVZKbAkSL1qS/4k5kNs2vq+9NC1tBwBIcfxL+sZFJtIK4rTwgER7p8QprVSpR17IBc98X+arxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kStb/h2bxxTnpUoG8mlerqt8YY7TMtzqPvYaHaQ0ccE=;
 b=ldZKBYfrEDDJqhfMBKtS1mkEf51Xlt6yJaWWc9yNmiDzsDtTC49eQ7fq/GqsbiM01PaTDEfJQQJGg2aCWtcJ8buMVMU55IWumUc2QKcG28Ug8IMb0K1hGK+t3XmNF41QIbOjpgYWCEMFhI/HRGA6fKPw7Qx+xPtyL3QiI9gj79lRpJxw4igqd25lv4PltGA+j9gnguk5a3AS+yUu1ly6w1/viYM/aGGy7iq6KLIsQjES7GPSkPXopmYtqzbgr3fyJT+g7dFDHjoiOST6x4JZI9py8l6C2J3Gb0z0AKQ/8schUHf9g1tHyPGUNjeao/xAq08YA73LHoSNRzccvkG8/A==
Received: from BN0PR04CA0082.namprd04.prod.outlook.com (2603:10b6:408:ea::27)
 by SA0PR12MB4447.namprd12.prod.outlook.com (2603:10b6:806:9b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Fri, 14 Apr
 2023 00:45:09 +0000
Received: from BN8NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ea:cafe::d7) by BN0PR04CA0082.outlook.office365.com
 (2603:10b6:408:ea::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.32 via Frontend
 Transport; Fri, 14 Apr 2023 00:45:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT024.mail.protection.outlook.com (10.13.177.38) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6298.32 via Frontend Transport; Fri, 14 Apr 2023 00:45:09 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 13 Apr 2023
 17:44:58 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 13 Apr
 2023 17:44:58 -0700
Received: from dipenp.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Thu, 13 Apr 2023 17:44:57 -0700
From:   Dipen Patel <dipenp@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linus.walleij@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <robh+dt@kernel.org>, <timestamp@lists.linux.dev>,
        <krzysztof.kozlowski+dt@linaro.org>, <brgl@bgdev.pl>,
        <corbet@lwn.net>, <gregkh@linuxfoundation.org>
CC:     Dipen Patel <dipenp@nvidia.com>
Subject: [V6 1/9] MAINTAINERS: Add HTE/timestamp subsystem details
Date:   Thu, 13 Apr 2023 17:44:47 -0700
Message-ID: <20230414004455.19275-2-dipenp@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230414004455.19275-1-dipenp@nvidia.com>
References: <20230414004455.19275-1-dipenp@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT024:EE_|SA0PR12MB4447:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f2fafd5-cc6b-4a2c-a400-08db3c817fd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dtvK7lrHedLlSn2CQq3DykfaVuGR6cYsZa3JFUdzRJKRZJItsvauMoXG/TD5iMaHL7S0u9GoLDwK/i35tPtOS0IbdzjjBPiTfM84963T8kaJGpbQRUfpSrl//LbudraA62R0KoS30JLjvJEMHwx0tP2YjNHOawUnQe3pTcB+3Pthds3Mye2ZVSLch1OyJQsTEtM+oKgSQ96rA5P6x+o4vvm414YREJ4VhP5EWdLMjtRrwza2JQgBfabIwTTwNCJd2UNZNh1vpSlQq0t0zje8meikemyk0rGKQ+RbRx3uZ5JCrz2/3J4qtuJer0Yx6w9/ZUKMYC9oUI4l6TMiOF0aV/KyzuAHgRCuxu8AjcLwRrhzTCmaMJKGnUjh5CW3ZfFR4LCXnQtWDLFGVrw0AYaZ/pu51Fypqt1C+WRQVGexDmuDe+6z2TEWNsQy7e+c8WLZoBko/qGkqj/1bfOJJ3H792rwmBDaDochxymrJhNfySRUKG6KlS9QeohH9qj+9uqfzpJ2Peu8vScAKaZmZvzcMV4CogJbVz+YanuVVRCsiejoX9VFhr6IzVw52UigwSx5vS0A2Gv+xQUzydx5j+Y2NtxyOU49Y0f6q8XmS5A8lAITzLhNkfkMKtF+Dap3xq0X729T6GAg/EWobAg6aMbyROaWulp+YLPA8Xjfg2e7U+R/e0FgtIzcmF+aJN1LSnbRz2pAVoZY2DjHrgWxFF7yW1GVR7Ku/aKRARCpQNSp+TF4SUPs8wtMNgebXgvl38eJO77O/42k85of2kCmj6fbWS21xhs7IrTfh4yDUssQ2lPrm+MynrIBTFNuO7q68xjS4bNME6pUjtmIcr4WAo1Rstm85VqDMAHbjSa9Qo9fE1tagNVOxm3Ciy5e+njyLW7XUI7dtzVJh0mEq5j1vTPin0NDyZ12Ft7b/2aii/Cc66Q=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(346002)(376002)(136003)(451199021)(5400799015)(36840700001)(40470700004)(46966006)(70206006)(8676002)(4326008)(70586007)(2906002)(4744005)(41300700001)(316002)(5660300002)(7416002)(8936002)(478600001)(110136005)(966005)(7696005)(40460700003)(82310400005)(1076003)(2616005)(6666004)(26005)(40480700001)(36756003)(47076005)(356005)(336012)(426003)(107886003)(36860700001)(82740400003)(186003)(34020700004)(921005)(7636003)(86362001)(2101003)(83996005)(12100799027);DIR:OUT;SFP:1501;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2023 00:45:09.4312
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f2fafd5-cc6b-4a2c-a400-08db3c817fd7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4447
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add tree, mailing list and patchwork details.

Signed-off-by: Dipen Patel <dipenp@nvidia.com>
Acked-by: Thierry Reding <treding@nvidia.com>
---
 MAINTAINERS | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8d5bc223f305..65b58963f0d2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9425,6 +9425,9 @@ F:	drivers/input/touchscreen/htcpen.c
 
 HTE SUBSYSTEM
 M:	Dipen Patel <dipenp@nvidia.com>
+L:	timestamp@lists.linux.dev
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/pateldipen1984/linux.git
+Q:	https://patchwork.kernel.org/project/timestamp/list/
 S:	Maintained
 F:	Documentation/devicetree/bindings/timestamp/
 F:	Documentation/driver-api/hte/
-- 
2.17.1

