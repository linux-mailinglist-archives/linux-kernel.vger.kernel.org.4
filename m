Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E80666C5BE7
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 02:29:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbjCWB3n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 21:29:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjCWB3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 21:29:41 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2058.outbound.protection.outlook.com [40.107.243.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FD7B2D56;
        Wed, 22 Mar 2023 18:29:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A8Eu00o1g8L4SOMqGnBGgn/eBXMZhgF7Q8PXfPhMMcuv+MUcfwvlmt+aHQJkv4iAKE2xmgoJCfiUkPnEV4QnsoEqcGoKqGfqiq2YzZ3ci5UQrioFSvwZClHsPeJzd0iVkxgANcvPpbeZ7vuM01dIC4h+UWBC+5NVazOFZXVvSxecOHWjiVH1K/qI/y2LOKc1ix3poWYj/fW77+m1KOoY99r0fQHfxSEW5lRjei6ob9kHZ8RzPXHjWRiOfBqBBF4MvsEZ0tpDQk1VBkLie3B3IIyKxT1LL55+sdn6NRIAXg9NwmjnGTIebH5nF8LO3eT0+lKk4wqRusgU3ynyNiufWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kStb/h2bxxTnpUoG8mlerqt8YY7TMtzqPvYaHaQ0ccE=;
 b=Rr2QlQqSFjmaxt0/SsDdXSL6AySWQzD8mvFSmDdaQd2zWUMxI/SobPvHKV+UkYeVfT1u9h2ChqV1YnAr+R1uODBfDzGYOJbX4Lo+IW3FcAVhmCM0iime1WJNwqafw0PjJWBcwaKqhLqNUxxBWCrmIu6cAroCcFkWlguhOz2Ck77m2OiS/knWIJ1DDsSFiWyVPu7YfIMU57zqg2o52SDu8bAmb2839Zoanb15ddiVeRUbo59cQBk7Yb7qzU5ZNXKx1bSQTG3u0N5mchrcFjXR8ejh17c/Qxu3gMf1Ji/9BD0Ri6NMU6RYp1AfexcP0caIa+foa3YjS+fWE8kDXz8jnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kStb/h2bxxTnpUoG8mlerqt8YY7TMtzqPvYaHaQ0ccE=;
 b=mlUuHUAH1VAQmAEA0qPBB8iTehzOWYPBT+4P9CfpLuPc7HenovVZQeN04kMrNLVnV7FEzXQh8fXukQaInCmrqQ2RZr18wvBgf5CxAWrO6vUz0kyZojN6Q0TnxVwceWoG8ZCYyFcKKdhl0YFAJFXFjNIrkq2IGDIlvEVIMt43oep61Kg2SwgWQIGVFgAwLdyudwZzAD5znAPGoPGfSMhrHWH20Zq+T0ZLjH2SSv33m5ftNnfLHIXJXs4xr1qMQE0DlT9Et1+Cwl9de4VbNNQecNWZWZvrH/JY1E2k2gnGSeJyoreeBk/UXWDOUVKE/FcreogsusQtco3lha4W1ZJP9g==
Received: from DM6PR06CA0010.namprd06.prod.outlook.com (2603:10b6:5:120::23)
 by DM4PR12MB7743.namprd12.prod.outlook.com (2603:10b6:8:101::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Thu, 23 Mar
 2023 01:29:38 +0000
Received: from DM6NAM11FT096.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:120:cafe::12) by DM6PR06CA0010.outlook.office365.com
 (2603:10b6:5:120::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37 via Frontend
 Transport; Thu, 23 Mar 2023 01:29:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT096.mail.protection.outlook.com (10.13.173.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.17 via Frontend Transport; Thu, 23 Mar 2023 01:29:38 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 22 Mar 2023
 18:29:32 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 22 Mar
 2023 18:29:32 -0700
Received: from dipenp.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.5 via Frontend
 Transport; Wed, 22 Mar 2023 18:29:32 -0700
From:   Dipen Patel <dipenp@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linus.walleij@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <robh+dt@kernel.org>, <timestamp@lists.linux.dev>,
        <krzysztof.kozlowski+dt@linaro.org>, <brgl@bgdev.pl>,
        <corbet@lwn.net>, <gregkh@linuxfoundation.org>
CC:     Dipen Patel <dipenp@nvidia.com>
Subject: [PATCH V4 01/10] MAINTAINERS: Add HTE/timestamp subsystem details
Date:   Wed, 22 Mar 2023 18:29:20 -0700
Message-ID: <20230323012929.10815-2-dipenp@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230323012929.10815-1-dipenp@nvidia.com>
References: <20230323012929.10815-1-dipenp@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT096:EE_|DM4PR12MB7743:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e760af3-047a-4311-ab61-08db2b3e1193
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ac06nvqAjwLcnnJxcAsVPEcuoxKriXu4+4qeYgroJyiN1nVNQDLzA4WmxnoyEic2c31nhElT7wYuzJWFpUoSY+P/17D6Oybq4IFUQdM5DUCKgmIsu7VHjzQXdbq/r9JWMvNb5aK97/9rQ7+3/YRSnFQ6iFGMGSGyeMywuR0R3XO9Kn5Tz0K5bTUh9kUGjGhiSKBw+qmIWMOgCTODsw1mil+at6uQgcozO+osMH27SiOPPGY4s1kIvShqprUmoFixAjiNyp7H/HALf1npImx1UA+RB0wF/UHXfnoAVA9sctgekl/BBIHeHcWYLivxQC6OHn0O1PDm7K0ybOdQMdBOBTbUNbpeHTsy2qv60uiV69iH2oT/wwZDqhTx8J2mnh35CVHdyVuj2EWSFXl6+Xj4PZxk7UygDPu9TraMS1diJRCeb9uWU8XInisKLkBVCUGdCS2XZSB0NdhGhhLINrxFCBfbySUbQLvCsTFYRlKKXlXMkzO+mF0IwT0t2Kv4AQuL/wIKpfYpYOkJcUn8SJrR74RRIpboBmooe8o2JkeR2zWMcnqz/yfp3R+LXP+CwotmxtF7nFjqpikxPG2ggbv+NcKem7X/Ysd+S9D3zsjeVbxLWFnywl+dAySfe24uT4HR3TCXtAvhBojC+VXrf0+GnonbUQ9fpJxRt+WLoFJhHeJpvlcKoOoy/GjTiUuchP9dGU+GkEXyV32pQ57nRBlR3hKd6wd24taMLdFcy8QWr5lM1hdUv56yoGXqIxuNvY0hvwZWx5WWj5akFqU49YDy9EGEsQqGUVpVkxoSSuttz7kIn/EgY8+J0yitDKV1iNPWheVUv8N9rc4+/e3SQFod7OxhSAP26s5Q5da1YDP3NxM=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(376002)(396003)(346002)(136003)(451199018)(46966006)(40470700004)(36840700001)(7696005)(7416002)(41300700001)(40480700001)(6666004)(107886003)(966005)(8936002)(47076005)(5660300002)(426003)(36860700001)(4744005)(40460700003)(336012)(921005)(186003)(2906002)(82310400005)(7636003)(478600001)(356005)(2616005)(316002)(110136005)(86362001)(26005)(4326008)(1076003)(36756003)(82740400003)(70206006)(70586007)(8676002)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 01:29:38.4508
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e760af3-047a-4311-ab61-08db2b3e1193
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT096.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7743
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
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

