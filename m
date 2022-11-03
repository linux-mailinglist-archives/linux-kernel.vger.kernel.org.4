Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2413618685
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 18:46:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231931AbiKCRqb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 13:46:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231477AbiKCRpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 13:45:55 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2043.outbound.protection.outlook.com [40.107.237.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C91E31ADAF;
        Thu,  3 Nov 2022 10:45:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WRiIvY4jm7MDB+sR7gF+jT/25nQSjLh30CveR5J7EtyZePoLJ4IQnxAenjgVjmdrmUYjrG5SHLwd3F06HP7d1XdJTlV9FT8iWE6LrR+v3A1I6O4tVN+RR8tdY0LaL+CpmIiBwoGPuae5bSAKm/kJdK4ZCaHFH0WI/X9/ZkhhX9pa6cZh2t/gyL06uoqepS6sJa5SwxXPP4Kk+FAd0XqRPj3cqd6lHjJnvp1a+fXHtkvGbo9spyvdv99oGjnCwcVJDbiAbCQLd3OSB2lc3lTBl3EZbKP2iGU0udg8Ef5aRxhLcnFrWSEo4MAn7y7HUpEA6yM3rTeowQdG8gkUYxA3pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0fpcvZxqj7N5uABhbu8wuDFwEu46fGsJYV59DtpkJCg=;
 b=fQcuqt9cBjdZ5GPkJK2uIsJuLuXIKFbe7maaEpmDCB8Zi6mNTDXqJW8UQNZz7ylKWiBl5whKnvLKa7rkMV+0oQNRnbAzXlUmWxUuyaO95Gj/c3q65MghTI7xMUATdFsZvkqLTg10XpT1L9/nZ5ahfDzvzynBht6VLbWO1MxF9qpoMHLxhC/74uJnuSLzKb+1QE2nAQjxx9vWp2h6IPH1DynxUGXmjTrZTpyBi7e4XhlPoU3fJ/DA5mAJhWtjTVwF8iCEwE02MGbuV0+yQGaMJlj68RnIK1UcN3kU6ooQrOjawYbySRH3FkFzC1FveDMeul3XoVHtHJ5Ig8YUV2/WOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0fpcvZxqj7N5uABhbu8wuDFwEu46fGsJYV59DtpkJCg=;
 b=bY+ypEVtRsNTaQ+sVJcRV5dsTjRpYUp4nUb7RhsWbHY6pSBJ3SYBrpaBRkRGt+tuElYLty6WYKK7YjVM6+R3sD1Q5GXIoRgy3FZQo0QbN9He7TYLaqvNswSbx29LkfFV9gG6rC9dAYb/oRSDO+WbIuZSQrpfU7D0lItr1WRg1U748E20RXBWsDDrqnExjbK4zCsjBeaF4LGd2TE5AoQSjpFKkU99HONQH7u/et7hDeZCAWhvvGr+uYzoAS2JLFyS81WLmk7U4lOVIFPTupGunn0NcKnW/j5YvTDXWm+Bvb9JjhiA6YKP8B394E9F5KODaePQ6AxiF0oZv6e6UJTvcA==
Received: from BN8PR12CA0017.namprd12.prod.outlook.com (2603:10b6:408:60::30)
 by MW4PR12MB7285.namprd12.prod.outlook.com (2603:10b6:303:22e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.16; Thu, 3 Nov
 2022 17:45:51 +0000
Received: from BN8NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:60:cafe::bd) by BN8PR12CA0017.outlook.office365.com
 (2603:10b6:408:60::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22 via Frontend
 Transport; Thu, 3 Nov 2022 17:45:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN8NAM11FT033.mail.protection.outlook.com (10.13.177.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5791.20 via Frontend Transport; Thu, 3 Nov 2022 17:45:51 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Thu, 3 Nov 2022
 10:45:35 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Thu, 3 Nov 2022 10:45:35 -0700
Received: from dipenp.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Thu, 3 Nov 2022 10:45:35 -0700
From:   Dipen Patel <dipenp@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linus.walleij@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <robh+dt@kernel.org>
CC:     Dipen Patel <dipenp@nvidia.com>
Subject: [PATCH 3/7] gpio: tegra186: Add Tegra234 hte support
Date:   Thu, 3 Nov 2022 10:45:19 -0700
Message-ID: <20221103174523.29592-4-dipenp@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221103174523.29592-1-dipenp@nvidia.com>
References: <20221103174523.29592-1-dipenp@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT033:EE_|MW4PR12MB7285:EE_
X-MS-Office365-Filtering-Correlation-Id: 711f4adc-dffa-47c4-210a-08dabdc33fd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bih/pXl+24HmxWG3ZCyPgj2wMM49bjdQIMRhuinuNdENKzT/Ns6goH51oXGOzOJhn+CB1zbCEqOJG0OXD/owjI1VPaDY/C7iBOUuSJfBDZhB1hocd9szKwcBTxtnEEufL9j39Dyl3UetABTBaQv1rkJoqqP5QcG7oXimcP7q8t5oB2HLDKfVtDvlCROCwssDVHu7BXwOWLLURoxuQ5SmdkORry5JeWjTnktLG/vf3xr3jxjTmoAZnw+ctnPTH2+0pMNgRG07d8JHewm2bVMBSjNMs0uabyRruE6onthV60ewyXfZqjitg50tqKJi3cysXGjlIHmqzDeN0hOYB1gAX6s9Q72hDtizmm/4IKZdDqcnRNWWG6h8BeGYWsBj2i6PKyc6HoMRa2p1ZzkA4rx6O30e/1rWhe6vi/U7dhP41w3L2qOK5OTqZQibtKPGG56fxa4Vs+pWcaVLMyGt1g+Ys+oQiF5ivC/nLZgBeb7UPLUYSd6Vathlpb/6cWMT6EP2D+0o6Gxqfac9VXKquqytFsQVmgrgISjB4uftPyYGoY63Rl1y67gLimi6/cn9pRlmwTiTYGwvHQ7Q9U/Fcn8wg15LLel/iABH7pxgcehW7SLdJ/XXIROhzCc0wOSVPZtWwASeJeKwEG9eceANriaNX+PnB9KT0l2J6OQkLLewrbXNR5kYYSET0i412dzR6LcLulAp2EBqpqRnCZ77zddYhb0pHUToVylqq28od3riEUAt3y7qxO4mLfEei7ieZF+yZMpj6n/WQIX28yuUUXxfHSHbzVht6SZHqz5wrxcZ8jE=
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(136003)(346002)(376002)(451199015)(40470700004)(36840700001)(46966006)(7696005)(26005)(40480700001)(70206006)(40460700003)(6666004)(478600001)(4744005)(5660300002)(41300700001)(36756003)(4326008)(2906002)(110136005)(316002)(8676002)(8936002)(70586007)(82310400005)(356005)(86362001)(7636003)(36860700001)(2616005)(107886003)(82740400003)(426003)(1076003)(336012)(47076005)(83380400001)(186003)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2022 17:45:51.1192
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 711f4adc-dffa-47c4-210a-08dabdc33fd0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7285
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To enable timestamp support for the Tegra234, has_gte variable needs
to be set true.

Signed-off-by: Dipen Patel <dipenp@nvidia.com>
---
 drivers/gpio/gpio-tegra186.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpio/gpio-tegra186.c b/drivers/gpio/gpio-tegra186.c
index 54d9fa7da9c1..c2ccfee52608 100644
--- a/drivers/gpio/gpio-tegra186.c
+++ b/drivers/gpio/gpio-tegra186.c
@@ -1136,6 +1136,7 @@ static const struct tegra_gpio_soc tegra234_aon_soc = {
 	.name = "tegra234-gpio-aon",
 	.instance = 1,
 	.num_irqs_per_bank = 8,
+	.has_gte = true,
 };
 
 #define TEGRA241_MAIN_GPIO_PORT(_name, _bank, _port, _pins)	\
-- 
2.17.1

