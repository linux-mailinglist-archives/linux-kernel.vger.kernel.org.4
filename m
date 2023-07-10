Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD3FD74E071
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 23:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbjGJVuo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 17:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjGJVum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 17:50:42 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2074.outbound.protection.outlook.com [40.107.94.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17CB4F4;
        Mon, 10 Jul 2023 14:50:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UuOBKGxXqHguSfzLCLhHqTo1bNDaWtHnbSUhrSRIWAlL51m1WuYzZ6tr8wWgQwydjnKZ5+QtNBohzyRFygmOaGYdk/kZzx4OJDrql+es7IvhOHig6uZCa1aSujrhMBVfIbYI5ghCkZYWAnwemDOh7s1UssALo7ZwQwsOCig69BZ0ZuzJPRtD8N2RTNC642JfGlSxaa90CHuxka9kZeB3MJt3C+aaIdRXeoC9g0xcGcjinQzi8KdBJunzgSbwsf+7SU27bmko1eKYTb9bJW4F9TDGrROs8IwjXNYZ05vw7TbBkD4F5w7QZ1c22K6+AOg9uD/g/xv7aCfh8EsR+Tv4FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VxwxI3FRDYrBtr1PjrLBWHJB78rDVxOpMoI1t4n5p4Q=;
 b=NaPZ3/AioXxWiJcVLfdsofoWwoo9X1i1tgDSicUbxWxUzTyG4qgsl/omIGrlVuZMcGU2veDsRXWtB1Fqo2vxl2ONY86c4GD3f/CyOQ6koRz//NQIyg6U4YA5xD/L/TNgyUftvBetgLW0zO5gWwZB2tMIBAxh573PSkLnbj29Mnh9lECc1ES1KO9SPeK6V5Y9HhYT2F7UskGzbOCL8lMrFRxqakbAnnSZQqYO0uqF/iQ/du6QvAszcAYk5POsJvqAVmLBP31WomS37+w+fjFhFVeYVERRrFvhqFmE8HIli8rQ01DR5SvPk6Cq0VLDosbRRY7/whUHb6CL+uWOhL7QZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VxwxI3FRDYrBtr1PjrLBWHJB78rDVxOpMoI1t4n5p4Q=;
 b=lXk0q96ydqMwRyxSDkeDZAedS2j4Oa7OH0gE25LsYrM17fKWalnnNAS+GqzjhkG12pf0CBoTdraOEv9HfoDqDAc2fB1QxELphSAoH2N4X2u835Q8QsXQ5aMDn4D58goVV28jeFcXen8FrhtrR1ie/uOghNS508u4dqi0OgmW/RZuwP3itToqBhdv/LfA3ewot9f84qu3zOaFRzvhY+D5d7/5vyZDz15V3dY9OHcFAiWcVoFA2XevTRBCAC8U8mRbRuEBwO4gepZslxAvucFHzuEcJJidX83Z1vMyJ4nyI3vvnXzbqeGbhZ71RUMzZAV+kuRAN8cgkEO456xuKH4fWQ==
Received: from BN8PR07CA0036.namprd07.prod.outlook.com (2603:10b6:408:ac::49)
 by CY5PR12MB6251.namprd12.prod.outlook.com (2603:10b6:930:21::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.29; Mon, 10 Jul
 2023 21:50:38 +0000
Received: from BN8NAM11FT100.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ac:cafe::b7) by BN8PR07CA0036.outlook.office365.com
 (2603:10b6:408:ac::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31 via Frontend
 Transport; Mon, 10 Jul 2023 21:50:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT100.mail.protection.outlook.com (10.13.177.100) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.18 via Frontend Transport; Mon, 10 Jul 2023 21:50:38 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 10 Jul 2023
 14:50:27 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 10 Jul
 2023 14:50:26 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.986.37 via Frontend Transport; Mon, 10 Jul
 2023 14:50:25 -0700
From:   Asmaa Mnebhi <asmaa@nvidia.com>
To:     <andy.shevchenko@gmail.com>, <linus.walleij@linaro.org>,
        <bgolaszewski@baylibre.com>, <brgl@bgdev.pl>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Asmaa Mnebhi <asmaa@nvidia.com>, <davthompson@nvidia.com>
Subject: [PATCH v2] gpio: mmio: fix calculation of bgpio_bits
Date:   Mon, 10 Jul 2023 17:50:23 -0400
Message-ID: <20230710215023.679-1-asmaa@nvidia.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT100:EE_|CY5PR12MB6251:EE_
X-MS-Office365-Filtering-Correlation-Id: be2f2d3b-2f62-4b15-de57-08db818fb2c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dqgeZdQyK/UVUvnpNKEP+PF0rVUfSvdzUBLnngc8ZhJ/oShPn7FlThumJDWD6DsgVNpV4cgMvn2xOG+tk4Pri7Vyeeik1lPQ7tFp8tMk4wTsgHPOkaGKglmHOb46or3646KWfCBOhP4Gd1FHSg6hdhys0lNKtkL7z1ZaN1bHlSYTdgoRD/bfS9KOEnJerb0PYVFX9uIlDA59T0YmG84BBoPHTEisdCjjdYCr8ktVUVK8tz50XnfsD2LeeJso4P6AnKlc5QGgcmPFVFPcu+kpzJZc8TEhq0FdfH16dcg71cUdFdKavszqhAvaHGxexyTmEbNs3Lo1OcF6ogHLsyJ5xk19e2YLaoLz/AzBXoADBxyJg7gb0aZS2UCfOOGY9VpkdoiV25/tWoq5gnG/OjkqmCxdi88JYmWakrL0ZFGzZ6CHQJkmoGTSuL4DqtiKs/EvmMckihDLvDy+2aPvIp5kFyOB30EpmNHD3Wd2zbQNUqB7yaiS0iv6KqI8X6UZe+Oc0nhRvKN9sPhqmy/do+05HNPIZV41+0laBMvU9TQ/I02yUiicjkR7E8fLEwPMjrAYa9eRhleE2m/ushLOIGrePRqgrIGDEWRMLP6bWL41sPiA79p2f2imKlAe6yA3dY6SwYBWr0y2TxLbeH27MlpW9vTGB8+tvcQB2Qk16SOh2l9eRjUYnV/92eItrc97wk7IYiB7DngSFGp9MatQXpcjVBAdeAqPkgkiBMJMPUdn6UJRR7j4n/izvN6ISW4ugfQKTB8bYprU2RlF8bQoRhGaFQ==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(376002)(136003)(346002)(451199021)(36840700001)(46966006)(40470700004)(40460700003)(186003)(2616005)(26005)(36860700001)(1076003)(107886003)(426003)(83380400001)(336012)(47076005)(4326008)(41300700001)(316002)(2906002)(8676002)(8936002)(5660300002)(478600001)(7696005)(110136005)(54906003)(70586007)(70206006)(40480700001)(36756003)(356005)(7636003)(82740400003)(86362001)(82310400005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 21:50:38.0775
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be2f2d3b-2f62-4b15-de57-08db818fb2c7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT100.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6251
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
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

