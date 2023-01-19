Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2B85673048
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 05:29:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbjASE26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 23:28:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbjASEUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 23:20:15 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2061b.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5a::61b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC74F6F8A3;
        Wed, 18 Jan 2023 20:07:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AwuI53ndLNibQmgGKs+5S70k3BOezATqj1qtTRe1Lf9f8o8nbaXKahAGxhrp0+CKtCVb7COsRh33RzzG2g8jteVnseqlseL7HHHvProIA0PuBwZRe+l6+QlpgpKHJOcW5nrSTALWkdi/qwssHPd0HkhdJm4Y/DTCE9CfTwKQtRd2ojDiKKHB9xRSEVEsi0y31obB1n/2XmXeAItD5Gyp9/tW6I4nDDMMZnjAqm2aPKtWYprVL+QfVH0Ix7N6DfwNHwv+9SKMqGZ561p4iNHR4MyxLzvJ6chthyvJQaiOw5eTwlMYeNdMaeZ8/wyu21ddTBwDpybq3+EOoDDqTP3YBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tADwm89Gw7MGE41VA3P+RoXDG7EzxPQzvrjTbcPBP9M=;
 b=kDP7MmlH2Fbz7bbgNn/4pAa0O+bG5WlwCqUIfvGH/s3AmQJ+LQL3GyeN20SU0j0o8DrikVosDq+BB688w6bltw0Oz1Bgs8iWt5yXxIH8xwBV9WLMt0Z8HwMHRC/v/IgY7Io9WxRSFpjzPvKgSmJANbyNO+5PRQxvR8HldtZJlbU6P7ukgNlJbVCTGotZ0NTNmQo6BGKG+rpU8r/UtSEe+76TJ2gxYV14Eg+3dt+RIwUtBQDQvOM0zCtAfYzuIUaBlvTXAtnnhqYL/pwlhgeXGVolIQGpDenp2wWbjxD4NYf8gml4gTySDLS/DfRjwCN22/6C4BHNK38YA2U43+lj4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tADwm89Gw7MGE41VA3P+RoXDG7EzxPQzvrjTbcPBP9M=;
 b=OiXjiS0KEogEecmWmiGoNF6iWqmon8v7RUOz2tCq+f6qHZULHER5ndW+fI86h+CP0px0Cua5fGqNwl8OR9EMv/AFI17UEIN1JlnQe0CqL7vFgVJJGiceYkA0ShE9n/yht98ilzWwxIX62nXKZ4xrouI30MMHIZ5wEwx9VOIG+U4=
Received: from MW4PR04CA0203.namprd04.prod.outlook.com (2603:10b6:303:86::28)
 by CH3PR12MB8307.namprd12.prod.outlook.com (2603:10b6:610:12f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Thu, 19 Jan
 2023 03:52:40 +0000
Received: from CO1NAM11FT099.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:86:cafe::e9) by MW4PR04CA0203.outlook.office365.com
 (2603:10b6:303:86::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.19 via Frontend
 Transport; Thu, 19 Jan 2023 03:52:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT099.mail.protection.outlook.com (10.13.175.171) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.13 via Frontend Transport; Thu, 19 Jan 2023 03:52:39 +0000
Received: from platform-dev1.pensando.io (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Wed, 18 Jan 2023 21:52:34 -0600
From:   Brad Larson <blarson@amd.com>
To:     <linux-arm-kernel@lists.infradead.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <adrian.hunter@intel.com>,
        <alcooperx@gmail.com>, <andy.shevchenko@gmail.com>,
        <arnd@arndb.de>, <brad@pensando.io>, <blarson@amd.com>,
        <brendan.higgins@linux.dev>, <briannorris@chromium.org>,
        <brijeshkumar.singh@amd.com>, <catalin.marinas@arm.com>,
        <davidgow@google.com>, <gsomlo@gmail.com>, <gerg@linux-m68k.org>,
        <krzk@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <lee@kernel.org>, <lee.jones@linaro.org>, <broonie@kernel.org>,
        <yamada.masahiro@socionext.com>, <p.zabel@pengutronix.de>,
        <piotrs@cadence.com>, <p.yadav@ti.com>, <rdunlap@infradead.org>,
        <robh+dt@kernel.org>, <samuel@sholland.org>,
        <fancer.lancer@gmail.com>, <skhan@linuxfoundation.org>,
        <suravee.suthikulpanit@amd.com>, <thomas.lendacky@amd.com>,
        <tonyhuang.sunplus@gmail.com>, <ulf.hansson@linaro.org>,
        <vaishnav.a@ti.com>, <will@kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH v9 07/15] MAINTAINERS: Add entry for AMD PENSANDO
Date:   Wed, 18 Jan 2023 19:51:28 -0800
Message-ID: <20230119035136.21603-8-blarson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230119035136.21603-1-blarson@amd.com>
References: <20230119035136.21603-1-blarson@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT099:EE_|CH3PR12MB8307:EE_
X-MS-Office365-Filtering-Correlation-Id: f871b305-0398-468f-cfc9-08daf9d09c6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c4VYyP0fxtsfu+ZKZ+FcfKu96NVTmgzmCmCktpO1/m2I2DmxAAfRKvDw2lVlhFifqadjd60OJPQbqfVXToXDisu0xRa1ys0Kzi5hByxRIMUdf7f2T1BYjz4Jbgv5dGw+WF2zLaX8LGpjf6zzBc9bGRXed3teAgdLFkQUHCwgI2TQHqF1sQA1K3sdt32YC4kQdYsRdWyacZFDyYFS6wfunT4ak25cdZfJKQCJ6XusVXX4MdKeMix7BFFn5yYM9uj0SZFF6TONgyBdJoQsdtP6c+xBNp9fg2AIkCzraQOsKr58Aq0vvXzJTbk3URxo/uaq9ITh85ym+RxemC7hjA8/L0QLu7sUBDKOXuUmKUesjtK5pn25Ysw56sIEzjrB78TI8pmexbKbLxMPkpyDskCrwevBWtiniSdHnP0TXIb/TGLUo/x+CD6qgl6oR+siVspAu/eoV5E34AMQMQ0s+FYXoHM2StAFnENpQbl+Nl9Bku75S4ezdYS5hF6LouUOufRrmsVSzVbiopyxwgcWz/qrVwO401wNG7LAhCiGV/LbaFK62CXbH0i3KIsvpHVtMGTSZhxo6qUH4RxTpMa2qi7ZHVeRUwFOzK8qJ70K+S4JRkiwZmrR+/wwn91uh9+WZMDPlEfJ73m/SmFch7SVrahqSwfaTr5kvZ6nh5IhQaoPzxyBlSeSKvY/XdRuYoILPWqUwQuNFTm/ggWgWTkRajZhGeeWshr5vSo0CSHO+BFBZE8=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(346002)(39860400002)(376002)(451199015)(40470700004)(46966006)(36840700001)(2616005)(6666004)(316002)(336012)(54906003)(26005)(186003)(478600001)(1076003)(16526019)(7406005)(426003)(47076005)(5660300002)(8936002)(83380400001)(4326008)(6916009)(8676002)(41300700001)(4744005)(7416002)(40460700003)(2906002)(40480700001)(356005)(81166007)(82740400003)(70586007)(36860700001)(36756003)(70206006)(82310400005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2023 03:52:39.7543
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f871b305-0398-468f-cfc9-08daf9d09c6a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT099.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8307
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add entry for AMD PENSANDO maintainer and files

Signed-off-by: Brad Larson <blarson@amd.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f61eb221415b..74eb977badb4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1890,6 +1890,14 @@ N:	allwinner
 N:	sun[x456789]i
 N:	sun50i
 
+ARM/AMD PENSANDO ARM64 ARCHITECTURE
+M:	Brad Larson <blarson@amd.com>
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
+S:	Supported
+F:	Documentation/devicetree/bindings/*/amd,pensando*
+F:	arch/arm64/boot/dts/amd/elba*
+F:	drivers/spi/spi-pensando-sr.c
+
 ARM/Amlogic Meson SoC CLOCK FRAMEWORK
 M:	Neil Armstrong <neil.armstrong@linaro.org>
 M:	Jerome Brunet <jbrunet@baylibre.com>
-- 
2.17.1

