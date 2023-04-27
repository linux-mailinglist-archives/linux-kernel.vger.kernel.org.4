Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C9DF6F0821
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 17:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243909AbjD0PVT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 11:21:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244156AbjD0PVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 11:21:15 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2057.outbound.protection.outlook.com [40.107.104.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04C5E46AE;
        Thu, 27 Apr 2023 08:21:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MKUWlYUrp+BCvA2tFuLg4Yoff2Mzp6YKiy4HKzSHoOuju+j24pXvvT9TK8wJvqCMr3yXXcVYaAESiknCfFktCr/29Txw8RF6/wu6Ir4yK1P/lWGUnivYkSHyLVTMyV9Ni9rY21820x+3FGApHAujsFHNolxkMe/eo9Or07bGhckxxu1pnfOMhsIjwrpTXBGd/f9pkyH01KDs2glwx8IEn0T97lbT6XJEbReDFSRE+0PM4stXrAzCS5gV+3zTCRaHQu1LM74z998x7e56bsxShFTwN3rO4MoECFsS9YYTtDs5Cu7J1P10rt+bvU+6scPqn9b8VU6nkysmfAGfscZU/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0dwYpn2Z2butA1Uiew4PUrm2yy50DF4/E+u1RjesvAM=;
 b=BI2dNWv5FrmkB53XiXXtU7s9QMLEp7sv/xspl6SE0OchLCnydS1ZfJmuZOd7FAGoguG/rCxNGv19HrvfsUI7rnLFPYOMPRZqtuLticVV3LdEplI5pKV61UvFYxNOyRZoYc6tonl8XAOLXsEL4fe6OFeC8beMkaag9d463QCGIFYJEPuZy5hcdhrXB+QMi7v6ErqA8FfltgOb+5AcEZa20s9WNmLpek1ao0EyQcec06/ORBEg3TcLF1mUD4H1ekDchCSZizWubbBF3My58VdYbzwedEB3dcAWDe53MGu5j1o3/MMLUEC4yFvPiySJ0z8O9huq2fa5+s+CeP/ajG22Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.74) smtp.rcpttodomain=linaro.org smtp.mailfrom=siemens.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0dwYpn2Z2butA1Uiew4PUrm2yy50DF4/E+u1RjesvAM=;
 b=H+ht/6Vg9356XuLzyWVa/Hk8LcQIJhhgbWpvnGQXxqnzpoZBaLFTI8Q+l30SqLVrBkBei1u/HPbejdsCD/gM+xDr8XKZDYhQkHk11RvtLyi1o56Jw8IjbdgfMjs0+iuVKYoOlhpL+rD8guNfzTwGFU2Xl6zDH5oTT4Y/kLs1kp9XNW2IeK5Q3jDudbEInAMxNgW+74A4HrP0fTh5Zk4ETcqZoYSOYiK+1XqcrLnQqQBX7lATljvxATQFa68yeBHHvqYL65wD9lILdrvqBxk4bMSlN8NHRNSAQ6lOJweI5miipcXzSv7Tz4M/oy8305Rz5NWG27T8SG5zTyzB7/scNg==
Received: from DUZPR01CA0170.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b3::28) by VI1PR10MB3694.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:800:135::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.22; Thu, 27 Apr
 2023 15:21:08 +0000
Received: from DB5EUR01FT096.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:10:4b3:cafe::dc) by DUZPR01CA0170.outlook.office365.com
 (2603:10a6:10:4b3::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.22 via Frontend
 Transport; Thu, 27 Apr 2023 15:21:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.74)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.74 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.74; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.74) by
 DB5EUR01FT096.mail.protection.outlook.com (10.152.5.170) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6340.22 via Frontend Transport; Thu, 27 Apr 2023 15:21:07 +0000
Received: from DEMCHDC8WAA.ad011.siemens.net (139.25.226.104) by
 DEMCHDC8VQA.ad011.siemens.net (194.138.21.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Thu, 27 Apr 2023 17:21:07 +0200
Received: from md1za8fc.ad001.siemens.net (139.25.69.115) by
 DEMCHDC8WAA.ad011.siemens.net (139.25.226.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Thu, 27 Apr 2023 17:21:06 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Simon Guinot <simon.guinot@sequanux.org>,
        Henning Schild <henning.schild@siemens.com>
Subject: [PATCH v2 0/1] fix pin count in gpio bank and chip name
Date:   Thu, 27 Apr 2023 17:20:54 +0200
Message-ID: <20230427152055.18380-1-henning.schild@siemens.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [139.25.69.115]
X-ClientProxiedBy: DEMCHDC8WBA.ad011.siemens.net (139.25.226.105) To
 DEMCHDC8WAA.ad011.siemens.net (139.25.226.104)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5EUR01FT096:EE_|VI1PR10MB3694:EE_
X-MS-Office365-Filtering-Correlation-Id: b44124cc-ea8a-44b1-3813-08db4733066b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8TFgVTeWg+eYBAqbhIVznDNrmMh/gogPhnN24Vv43JVbpx29XM1YRfqAXnemPMJC/popGgipGMabIZnWr6/TCkrYU1bztZQ1bMZi0D7+sQ83r6hJpkaEsra2zQQic21v2ybUt0P0/pr5s8n2xUv6GOlFyaqwN+XaTG+WGh94O9YAjioScctm7T1rGUKoJtDePm3dikXESPalFImbGNPE9wZzLTgPXLhrcyPt4oIPO5ai19cdn1c7iySW6YEYQFaTiHS5D4DXJ1tvMfzAi9eHt78x1l7xdn5KnaRdcUuQSCUlYmj3J/IMMQl8JfkA8R9D66hxL/0/CP+FQeG/B0tYXKT1epWy8kfe3ULbH1tW7yONq+jhYyryaLos3zONyPuCF6QOjJuzdhNg71Rnjcxqv3o4Nre1eGP/fT3tINfc5GkEXcDoxIIIl2uoN4DJ7spL5s7bWl1D1aLqcZmPKuVmyEepMu0gVVFuzCDd1ArFOXfeiFMpP7v4xS1rBRNQyMmvfhiIxM6uw0k7XhjvsjhKinKtJ3IlyWQ6KoqHqnVOA83i9SYpr4Dvhn7mC2NjZkpVW3p2WpzFM9DUBlSfnl6KFeBDFroAftN/vWZv/ICCrGe6JwDwTYrbravbrH2xLLN1TqxBrmFu0ME/IQkZbgeslqcBotUaGxAz6wxiklgJe10vlCkWSje3oD/aZTEgU76Bx66k4WeZjfhewypaaP4wyA==
X-Forefront-Antispam-Report: CIP:194.138.21.74;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:hybrid.siemens.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(136003)(396003)(346002)(451199021)(36840700001)(46966006)(40470700004)(336012)(1076003)(956004)(2616005)(26005)(41300700001)(316002)(4326008)(70206006)(70586007)(40480700001)(7636003)(356005)(7596003)(107886003)(82960400001)(82740400003)(47076005)(83380400001)(36860700001)(16526019)(186003)(86362001)(82310400005)(40460700003)(36756003)(478600001)(110136005)(6666004)(5660300002)(4744005)(2906002)(15650500001)(54906003)(8676002)(8936002)(44832011);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2023 15:21:07.9026
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b44124cc-ea8a-44b1-3813-08db4733066b
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.74];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR01FT096.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3694
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

change to v1:
 - rename the chip in the code

When first writing that code i looked at a spec that was only describing
a similar chip. Now i have access to the specs and found that i got the
name of the chip for my given chip id wrong, and also the pin count on
the 7th bank.

I added a "Fixes" in the hope that this can be backported as a bugfix.

Henning Schild (1):
  gpio-f7188x: fix chip name and pin count on Nuvoton chip

 drivers/gpio/Kconfig       |  2 +-
 drivers/gpio/gpio-f7188x.c | 28 ++++++++++++++--------------
 2 files changed, 15 insertions(+), 15 deletions(-)

-- 
2.39.2

