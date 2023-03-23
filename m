Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1119F6C7204
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 21:58:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231300AbjCWU6b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 16:58:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbjCWU6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 16:58:24 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2054.outbound.protection.outlook.com [40.107.102.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 627CD211F3;
        Thu, 23 Mar 2023 13:58:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K7rqsNw1HG8KjoQWWs5Uorow4qWiJi/KaLKuHBCpijfDP3WM7aq5GPjVeQ0tobqDxOfb8vcwVr7IGREdI1boaFy2IPbjZIKzjeevUS/kze2ddwiPhLMBuWr7epuLRqeOWd4pmFgsC4F9Yg/+l9xPsJ9sAxoenmz6t2KsRRYkKHzlgqgmvfUfCVvj+ZyIh/8Ewd3iL83lyiShNVdGIEATVpx6NmbFVVwh8PWmCILHQ+84lbEwgDiTO5uTprUFQpJF8HZnbhWAEV/xid8/OL/4XiBW6PvmuGuMltfwMjwTkYeaKY3KNbrxEB/zydK8ila1UXCODYyxGwmEfkvLkexfeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Gy/49iwHAImWPsLmW8jPpDcIBB3Ap6uG5BaW/9Qya0=;
 b=AhWMLRsZepXkcK0PakzETfKWPUjo3lrWPu7KshGaP0G5+VhxxXtoF7dLiPfR1UXCu5XAtwTkwXkpKt7mZMUlJwSDSQUMqT0WJXyhfUJJVgf+aE+58cV3/7ySF9HdFTqYYT61a/K/EQ+cJjLQN1O+Tn9/kTCtkzdSKGZ/wJc4HdW2aImrNT6tZL/dZlfBQe2OL0qlfnUe6CdoDtmIP4Bzx5S/A+jQ0YOANlyvdt7lj2tCabNlsz4gdg5Jz239KbXb/M4FuJ2zPx2Z7O62SsMuCByIIvkpvYr0+2HDetgGiRmElNhTj3SiHavBztn5QEEu/Y/DhJszDblCsuiCJRenSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Gy/49iwHAImWPsLmW8jPpDcIBB3Ap6uG5BaW/9Qya0=;
 b=LnK9xHHfA7dXXmBef6SuXVd5R96ihra8RD0m8t7mc70NjeKeWoGKDuEH0toqQA+d4DuOGutTD11wJvN1CjkhAkxep02rl1jcLjChFU84pj0R1d6sp7rGM4JNw/Rw71BeKdhJ1f5keD0BQ/DaSpYB755koMq59hN7wnIKn3TEFZvwD/vqhSwbjI+wuFGuY5gKMEjqyKkt+m4b/FTG/mFttc5pgTWe2w9NH8Rg/bisHwoZJSTQbjhkHxttn6b2grVHOuJCaKlcMJYkUKsHhY/qF02fRRjdoPqSoZ/Sf98xziCftvGO1RAkUKo/4AtSc5SGZOV8hABjxQgQ6O0eG2Cc2g==
Received: from MW4PR03CA0100.namprd03.prod.outlook.com (2603:10b6:303:b7::15)
 by DS0PR12MB7534.namprd12.prod.outlook.com (2603:10b6:8:139::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Thu, 23 Mar
 2023 20:57:50 +0000
Received: from CO1NAM11FT095.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b7:cafe::60) by MW4PR03CA0100.outlook.office365.com
 (2603:10b6:303:b7::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38 via Frontend
 Transport; Thu, 23 Mar 2023 20:57:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT095.mail.protection.outlook.com (10.13.174.179) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.17 via Frontend Transport; Thu, 23 Mar 2023 20:57:50 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 23 Mar 2023
 13:57:37 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 23 Mar
 2023 13:57:37 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.986.37 via Frontend Transport; Thu, 23 Mar
 2023 13:57:36 -0700
From:   Asmaa Mnebhi <asmaa@nvidia.com>
To:     <andy.shevchenko@gmail.com>, <linus.walleij@linaro.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Asmaa Mnebhi <asmaa@nvidia.com>
Subject: [PATCH v1] gpio: mmio: fix calculation of bgpio_bits
Date:   Thu, 23 Mar 2023 16:57:33 -0400
Message-ID: <20230323205733.20763-1-asmaa@nvidia.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT095:EE_|DS0PR12MB7534:EE_
X-MS-Office365-Filtering-Correlation-Id: eccd70ed-11c0-4f13-d8c9-08db2be143ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K+0rAvllmmM/9QJeY6Lkz+OzOepVS6T7RZHJ5V+Z56Twn+k99eeeSyYpgHINlmiUpSxvldIRQvCSlqdG6i/txOYvdLEQkR7zPvVs11Yuaguh9s8YzCRc2zGer8uB1liaIABwiW18A3QWG83nkGLroQ9Z9vkXni/8t+tURN9SPP8tfhQ3Ty7ix/MeWUAchKakvNiklS/5af+26uoelISUngMM14rw+iVmBKLuNjGub6tEX3mbfE476DdBxQEszEz9nt0dwveMDmOqyNpZG15j0y5C86Ikxw0uAnDOwyJ1faSrSuUQki4T1plcxXCBPcXJCQl9CmCo9hjF7SiCi289j/vUMCFrd10hy2+OSqa8scxrySW56bPF4cWoQv3UBUh9ICE3jsXm953PGQ95WIS2cUQhfB3K6V0cmaQoBzpEwGfo0CT09bmA2kZRjW1yQHDMfCOJkwheBPBgECVp+4zend/VMCEgJOpU8Dff0FSZ1Ftbjn5nEXtEXXvYbOVyeQ77Lg0A2gES7vnuzaafyZXy+QXOOcxLuDIo/fXLdXl5Z/mbfdc2znk8EuyLk1yahARXFrHGg1jXki0copmJ5lz07NPf7MHxidVZgYHXh/Wv56HfL9T05SHgo5SXcwDeyeIB2yG1T5gAh6hSexNxzxsCO90j0KLGbOXPFwa4/3S8dWhpzwiIsUYryMBaKJrkRqnAdTqxzOAR04Xck8g8Eh8GT4N738X5yflNQXR13y8zRM3VxrT+hQ5hK9wwaGChuWsO8gBp/JaLsEDgHg34+JjBJA==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(136003)(39860400002)(346002)(396003)(376002)(451199018)(40470700004)(36840700001)(46966006)(5660300002)(2906002)(82740400003)(7636003)(4744005)(41300700001)(8936002)(40480700001)(82310400005)(36756003)(86362001)(40460700003)(36860700001)(356005)(6666004)(107886003)(47076005)(426003)(7696005)(478600001)(110136005)(83380400001)(2616005)(336012)(26005)(186003)(70586007)(1076003)(70206006)(8676002)(316002)(4326008)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 20:57:50.6760
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eccd70ed-11c0-4f13-d8c9-08db2be143ce
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT095.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7534
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the "ngpios" property is specified, bgpio_bits is calculated
as the round up value of ngpio. At the moment, the only requirement
specified is that the round up value must be a multiple of 8 but
it should also be a power of 2 because we provide accessors based
on the bank size in bgpio_setup_accessors().

Signed-off-by: Asmaa Mnebhi <asmaa@nvidia.com>
---
 drivers/gpio/gpio-mmio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-mmio.c b/drivers/gpio/gpio-mmio.c
index b52a3dd511ca..74fdf0d87b2c 100644
--- a/drivers/gpio/gpio-mmio.c
+++ b/drivers/gpio/gpio-mmio.c
@@ -623,7 +623,7 @@ int bgpio_init(struct gpio_chip *gc, struct device *dev,
 	if (ret)
 		gc->ngpio = gc->bgpio_bits;
 	else
-		gc->bgpio_bits = round_up(gc->ngpio, 8);
+		gc->bgpio_bits = roundup_pow_of_two(round_up(gc->ngpio, 8));
 
 	ret = bgpio_setup_io(gc, dat, set, clr, flags);
 	if (ret)
-- 
2.30.1

