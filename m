Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96B9274A1DB
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 18:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232079AbjGFQLA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 12:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjGFQK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 12:10:56 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2070.outbound.protection.outlook.com [40.107.8.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC4169D;
        Thu,  6 Jul 2023 09:10:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W9pU1Kwfpr1rSvtsgd9oTZm5R/tNxcE2UKsPf1TvI+ua35rW9zMNCsZw2VYNpk5oIQCaF4n/tQgbo0rFB3plo/SkWya4FyjAYEWYS+OQGqp0PhdH0ayqCBgstp8ryzfO07Q5G5Tf+zDcPE7+FflH93EFUTIaP4N7xkG1BznKbcUWxN8LeGJWTXhQvFbpwzgjf0WYLMlQcosHCp5cZemqXUs+3O2vK9NYoYwbcQCRMmStg9tLIo2ppvQj2Y74micNQeAca+c/pZ0aoiVesG4fY/Fbs+JDNlw2XMIjURv1JfKKnao9F9QI1VkAvjJicHos6mpwcD+Q0JhbAFmkfjrUXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OHl5gCy06aztuWLShnGsR/ZoXATEE1MOohP7pjPGx3Y=;
 b=d4EdwKm/Af5CWoaPPXux9gPfL/Dkdot8CVcy3tqYmxwsovcBswRMFvdY7nkPvoK3+Ch1COHaptXcRnI4lpi36XbrrdnVgaNaTk+penCdeZ5hxWAGpnqDxeOIhpiJKF45YO50cogZW15yoOU+0fvGrxI679fCg5o2fDzDxvhfVZ8oK3kXAT2xnFdGbn9EOjiYdEhX7tgxfZ3N7kY3gIeIY2J/7x03i0A2tgn2xodbJnAo3LroTT9FsDooej9DMvTBSUz6wtTlYpPygLJsbbOYprGzURubKDPnOPE0w64kzCAwXqfD90RdxW0mNxVDFnbFU/KFBYjifV7LL73zRIv33g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.76) smtp.rcpttodomain=ucw.cz smtp.mailfrom=siemens.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=siemens.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OHl5gCy06aztuWLShnGsR/ZoXATEE1MOohP7pjPGx3Y=;
 b=NpMzWGV9e56k0LhACnP+8Iy9hDZUh4gaRjUZlHXFiobOUcLZH+bGY7ORUqF3Mkvwc3AWiCZZBl8/Y2IwjRCmwOeIayZ63MPAWRjKgKwyrRO1vvOJhwv3QXn6crewd9wkjiQqLdLJhcV1AztJX628g0ojUpPwbcWIiHZ2mn0xW5Hg6Ha/wazElDKzQUUXY1eFX/1K/jHaZSviWaJh5sf9QRTZkuNNPErDbxw9Cvt6hqiHVy6xli6LIIcV6GfqWaAKs6YjGx0wNpCgJWtj9aDhjPGCSJPcH29Zam0BU9Ep5LAaH8R3uQ8J2VJsB9btPX9isvkTmJ/1eu3+wmfl7eUA9w==
Received: from DB3PR08CA0001.eurprd08.prod.outlook.com (2603:10a6:8::14) by
 VI1PR10MB3198.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:132::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6565.17; Thu, 6 Jul 2023 16:10:52 +0000
Received: from DB5EUR01FT037.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:8:0:cafe::83) by DB3PR08CA0001.outlook.office365.com
 (2603:10a6:8::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.18 via Frontend
 Transport; Thu, 6 Jul 2023 16:10:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.76)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.76 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.76; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.76) by
 DB5EUR01FT037.mail.protection.outlook.com (10.152.4.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6565.24 via Frontend Transport; Thu, 6 Jul 2023 16:10:51 +0000
Received: from DEMCHDC8WAA.ad011.siemens.net (139.25.226.104) by
 DEMCHDC8VSA.ad011.siemens.net (194.138.21.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Thu, 6 Jul 2023 18:10:51 +0200
Received: from md1za8fc.ppmd.siemens.net (139.25.69.40) by
 DEMCHDC8WAA.ad011.siemens.net (139.25.226.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Thu, 6 Jul 2023 18:10:50 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        <linux-leds@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>
CC:     Henning Schild <henning.schild@siemens.com>
Subject: [PATCH 2/2] leds: simatic-ipc-leds-gpio: fix comment style in SPDX header
Date:   Thu, 6 Jul 2023 18:10:40 +0200
Message-ID: <20230706161040.21152-3-henning.schild@siemens.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230706161040.21152-1-henning.schild@siemens.com>
References: <20230706161040.21152-1-henning.schild@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [139.25.69.40]
X-ClientProxiedBy: DEMCHDC8WBA.ad011.siemens.net (139.25.226.105) To
 DEMCHDC8WAA.ad011.siemens.net (139.25.226.104)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5EUR01FT037:EE_|VI1PR10MB3198:EE_
X-MS-Office365-Filtering-Correlation-Id: dbd4fa5e-8373-4c5e-d66d-08db7e3b91b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MzdM4a3CYQGxBiOxgaAivVt3B2g60S3j9mNeyrKunKQA/B93G2C3hLkma+lK8U+mZXg8roAz4sS7BbJ0eaXaT7JAjc7fWzUBTPDUn/631cqQobcZeWW3UxFzC6XOjF2mLtGh6cnypzWwr54VkbFvBAktyy2vmue6NzcattyJlhvgvkLHzWym6HmyUmX6qJLBVwv9QBUdrYy47aQsMMbvy/cjd/z8cIlPwyVCbIJv8az6i7VDeT82uhnMQcw3zBFK0wofQw1zrPQKVdwyC5JboLoogkiAG2fopuRMx0EAc0kdnTDGgsZSR6528YXQU+KJ1miweFdT2Qi2FecVigAG08A/zW21kMUSgOcu9B7KJkj6gS8jb9E4GMQoonkSMHuMz/876Gfj5EPrrBV26VFMvEddhcbwzW8+wqBb9YgRkDYHX1g7LrV/YOU4HqMB4ulfJr/qIZQFsR9xN3zPfkAaT7DBiklh8nNgqznXq3vC0LwhcO3nnVEReR+MV2G8+k82gERKaJrZ0ZNM+WrvcgVzDYBDuu1CC3u9HnBXL7HRQQxZWGsh7ETc1zpvOA8C4xVAY0KC2Do8/u7wO17vFAJ8HsvsJW3Njn28VKXr98U+tMVsmotO7oZLhn0wOLZbxZSyKJP/9ZhvX/utVQB4/MisXe3r3+tLtdgvy78mXoY7JAdtgEYGRMESa7XfaN9ljI0LhBk3nIzFaYMy+JDNyQcOVh/a6CDt9YWS+cbYOpZpQbj03QTbRPnG/Y4492ezJWge
X-Forefront-Antispam-Report: CIP:194.138.21.76;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(39860400002)(346002)(396003)(451199021)(36840700001)(40470700004)(46966006)(336012)(186003)(16526019)(40480700001)(40460700003)(6666004)(356005)(110136005)(82960400001)(81166007)(478600001)(82740400003)(36756003)(82310400005)(8936002)(8676002)(44832011)(2906002)(5660300002)(4744005)(4326008)(70586007)(70206006)(86362001)(41300700001)(316002)(26005)(1076003)(107886003)(83380400001)(2616005)(956004)(36860700001)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 16:10:51.5321
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dbd4fa5e-8373-4c5e-d66d-08db7e3b91b9
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.76];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR01FT037.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3198
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This was found with giving the file to checkpatch.

Signed-off-by: Henning Schild <henning.schild@siemens.com>
---
 drivers/leds/simple/simatic-ipc-leds-gpio.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/leds/simple/simatic-ipc-leds-gpio.h b/drivers/leds/simple/simatic-ipc-leds-gpio.h
index bf258c32f83d..3d4877aa4e0c 100644
--- a/drivers/leds/simple/simatic-ipc-leds-gpio.h
+++ b/drivers/leds/simple/simatic-ipc-leds-gpio.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Siemens SIMATIC IPC driver for GPIO based LEDs
  *
-- 
2.39.3

