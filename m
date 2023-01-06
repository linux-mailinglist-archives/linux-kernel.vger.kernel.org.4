Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1607660423
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 17:19:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231286AbjAFQSy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 11:18:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235525AbjAFQSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 11:18:33 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2049.outbound.protection.outlook.com [40.107.223.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CAEE6145F;
        Fri,  6 Jan 2023 08:18:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W0hX1BeY5URmDxio4rxg4T7qz0w630Tvp8fipacn4z++EWGLnq+aWEwa0n26RWNQ0GyyOUizCJxYvP8oFALEv83y8uy3cJldwFlYnHhL8FqgMpl3aDC9D/fIAwaYFUFKpbeDt/z+dFqvi7/Ml/nGqapnGDevznQ4l93+scBcqafD9oTZv38kzvmXHOy20c/ym411GYeiPZvg2dvhvj+oUpPFWMim78I+8CEslETSSE66b3c0WcByjAzbDLA0vIVGVVp9NLvY7Ow9NkK9rUmyqxXc73LRTrfYQ2CsOsy9Ck8JlFhiTclxYO32Hs+R9ATDEeqG4pOp8YtIWEjC5opoOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sShVih3KQfymqIqjWtjwj6myY895Xu4gkssiWZLr6us=;
 b=NoyIAgY1OP2zWhauSQlmrifMpHuITEP8z/U11b1tMQo9SFlLcQR0xTcQAO0WXWLZP+n4fJ5xZGLY3C+C3q0dyOVp/HjHRuWLkVAeprg2y31mJhUdHw7RI+gRu1jdvieq9STM1l1Z/69jZoqX7d1hQQQS2YNYAJGeH1+I1trdYbdks/fYotkFLFX5/in5EeQ/U15EOLv0PxZV+xzZ9a4smy3dDLFdy+iJfAv0MSmzuABMmv/Ar7jdKxspYgYbFI+V8NsuXoax95Gfxt5vIsSzZFSAdTtc78ClYpz3PbjL8ltEGWzr8b/NvpwuPlOK15BcII8VOgRgfxD0tpo4Wgy7Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sShVih3KQfymqIqjWtjwj6myY895Xu4gkssiWZLr6us=;
 b=mXEw510zHNt6KdA1VVNXLw/Qvst3C2NdJEHEFEd8EHEQ35WvBRuIt/PUbhBN1JEzUYdkLngW/SJgbi1Rk7/d+dRAZEw9J3jNrRPTdqlWfiixkOznWf/89K0t/4pCBOUyRkr62CIXxp6pGjMnmFFrhqvM1Zbqzesv1ERfgBYVvEnJ8ETkdt8+dhpZah10WFC9XzVFicREdjw55P3FT9fVh/0nnCa9PQEsdy7dWrVE0E4PWeX8u6wOca5AEHlgJ9TgxiH056883TiXLEyvfaAmw4g6cEkuiv57MK9xCgVYwqqIdPE5hZUcSUkxgz7ft/NGnOBN0vixqsF9/3YoKfB46w==
Received: from BN0PR04CA0136.namprd04.prod.outlook.com (2603:10b6:408:ed::21)
 by IA1PR12MB6017.namprd12.prod.outlook.com (2603:10b6:208:3d7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Fri, 6 Jan
 2023 16:18:30 +0000
Received: from BN8NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ed:cafe::32) by BN0PR04CA0136.outlook.office365.com
 (2603:10b6:408:ed::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.15 via Frontend
 Transport; Fri, 6 Jan 2023 16:18:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT018.mail.protection.outlook.com (10.13.176.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5986.14 via Frontend Transport; Fri, 6 Jan 2023 16:18:30 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 6 Jan 2023
 08:18:09 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 6 Jan 2023
 08:18:08 -0800
Received: from moonraker.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Fri, 6 Jan 2023 08:18:07 -0800
From:   Jon Hunter <jonathanh@nvidia.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH] usb: gadget: u_ether: Don't warn in gether_setup_name_default()
Date:   Fri, 6 Jan 2023 16:17:59 +0000
Message-ID: <20230106161759.66019-1-jonathanh@nvidia.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT018:EE_|IA1PR12MB6017:EE_
X-MS-Office365-Filtering-Correlation-Id: 70e517be-7066-4e15-a643-08daf001a673
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: efmZWslnWJ0L3D781k0lie+KXipTt5UoOy/hWEQOZOEdCw+6ypTNVrCU/ExJwh6RQwF8CXH38dYra0sZdQz92t1cEOaWhXA0OBkA4yH53sVgcHzZDgclwVLbaLjWdopm5mRG0fljT0rwJ4j2hjzdWCD2UF0neTD9t9ABf7Boh/FmG61+nE+qwQ660K/N9s3cUF0nNjOjUpOXoHBuIz3f9s63vtPLRlJvQdjI5+vLQeexqyH1cd9FCDGLr3b28JpShfWlT/Xgp8itWTpA5c2v7Vw2B46LNkTnCvAYJ7xSIOuJbRDkLH/+Ttyf4X0aowpGDnrNcF1K+pupmoPr4JLzmIxRs+2EuB1TqjbpIO4Zpes9v8lc67n0MGj2uuwNofyDh96/LGA34Mh+fhEdIFdX5qfNiJQMAtkMQoCjD9r0Fl/mZLE7ntXVeO8B0nvl7mG3p3ebVei9NnIwKQto21wMt1gq8MvPn+euGCB+Q2lHPSc+uvQRPEYuiiIHI+2obFQiwsho74Ywq1QtTISoYeDLUeIx6vdaLEA9pCZSH9ye6US67eFDi/gkSR/sw9vJQvZDrP7wgqU8XhZuFdyNONiJ+KxIf9CONG5IAZiNZEPZbZAaMdDL2cA9oBl2OCaedHgqhSSpnDUva5jgOPA3V/jWQEEl42ZzezPDXkwpDDzTzZuWhrZ16qXszNGhehibJxoQs3TvsulyUwGbYv6OrfG4pg==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(39860400002)(376002)(136003)(451199015)(36840700001)(40470700004)(46966006)(336012)(36860700001)(426003)(2616005)(83380400001)(47076005)(40480700001)(1076003)(86362001)(7636003)(82310400005)(82740400003)(40460700003)(356005)(36756003)(2906002)(6916009)(54906003)(4326008)(8676002)(5660300002)(70586007)(8936002)(316002)(41300700001)(478600001)(186003)(26005)(70206006)(107886003)(6666004)(7696005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2023 16:18:30.2545
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70e517be-7066-4e15-a643-08daf001a673
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6017
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function gether_setup_name_default() is called by various USB
ethernet gadget drivers. This function always generates the MAC address
for the ethernet gadget device and always prints a warning when
generating the MAC address. Given that these messages are expected, make
these prints informational instead of warnings.

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 drivers/usb/gadget/function/u_ether.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/function/u_ether.c b/drivers/usb/gadget/function/u_ether.c
index 8f12f3f8f6ee..c19d66cd1446 100644
--- a/drivers/usb/gadget/function/u_ether.c
+++ b/drivers/usb/gadget/function/u_ether.c
@@ -845,13 +845,13 @@ struct net_device *gether_setup_name_default(const char *netname)
 	snprintf(net->name, sizeof(net->name), "%s%%d", netname);
 
 	eth_random_addr(dev->dev_mac);
-	pr_warn("using random %s ethernet address\n", "self");
+	pr_info("using random %s ethernet address\n", "self");
 
 	/* by default we always have a random MAC address */
 	net->addr_assign_type = NET_ADDR_RANDOM;
 
 	eth_random_addr(dev->host_mac);
-	pr_warn("using random %s ethernet address\n", "host");
+	pr_info("using random %s ethernet address\n", "host");
 
 	net->netdev_ops = &eth_netdev_ops;
 
-- 
2.25.1

