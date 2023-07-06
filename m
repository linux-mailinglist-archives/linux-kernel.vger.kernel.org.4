Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59B9774A182
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 17:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232970AbjGFPt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 11:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232833AbjGFPt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 11:49:27 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2085.outbound.protection.outlook.com [40.107.8.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F10581FEC;
        Thu,  6 Jul 2023 08:48:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eB8SgI4vX62yV6lebUeReXwd8qzdralAP45ZKlZNHWad8YwP4CffZdz1Uzrndc4em7okp4DPrJM9/O5hvwVOFJsJLJ1f5KEYosY155KPR4CnEBCA22LvY1Rr8rqBit0OGNM5YRWxv6LAYwZmv3MpIJRPQvV4Br/ojo21bOzOOrunKAwEEyFl/uL00gZzqSk5vAlMXE8MXpPKaxw+GPB/pyYSmnrytl0gVkBGy0WGxoMDARmQXYZxkyOp3YcArxVQaQLUzxXqWZ6LBgId9bbMOn7g9XajV3udyt5O4CToQRLJdjydi/rKJ4dd7hEdQPcsgwAMjka8bDwAye2YZK1f/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kPWxYf/1DJPIp7rYVkzJrg9tSP/HfrkNUGAVNyabubM=;
 b=GBO8Zp6dU5+DACM908SZQww8/++kOIRNrX0cFrh0cIYCqar07dtFQyh+OB+GypmO1FaeYEQs2pBeBhP/s7SMGCoplPWV7V7uy3s/hWWokB8VWvqXQqoxcbE7o1vmOKvhuJuXRrp8/qeQfe1sdCO6tgdggcHKh1nWnkO9Hao5pPLhuitl+kO24WZQ16JFa5Ui8n+vjj6kKTfFIcE6pdstJIJgzYPzD9gWKl9AOftVg/wAFeO/HzQjegsnh8tLYCjb/kA9UciwaHTeCwBUhHuyvgt/mgNtFymIRhIGP+OA7dueJhWywh6iLEDdLpwNHWB/nsRVWrChOo6lPb7nAQ4bVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.76) smtp.rcpttodomain=redhat.com smtp.mailfrom=siemens.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kPWxYf/1DJPIp7rYVkzJrg9tSP/HfrkNUGAVNyabubM=;
 b=xryD/oWCw/EAnhk70x+X8u9lmqvliJx+tJaXjjqO7bHP2iIpgsbC9m4xMDNaZc88Q9ufMCctJbDReNnrUf6hzRk02VU5xT1bxyr4FvgOzQ3c2UmJnx5bB5QQyDEcbBdniVXF9YNnGWEHI5uzYgUEi953E6Y5onv9GH7tTDCZQkiJ+yL5GzPCLDbd0BHIYbvWmGNsopKUwRB++KnTJPgxD4Cd0mxULmZzf4IIicid6yBCJRtS0C1Jq5FUzWEEUCGz4nRiWnLBF/Vqj/MTy4dGJ8ggeOPtg+1TrdOy6KILXVrtzHocsN/oKvmXxD3KbCzYzwtoIroEhd716YPA/GfwmQ==
Received: from DB3PR08CA0022.eurprd08.prod.outlook.com (2603:10a6:8::35) by
 AS4PR10MB5545.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4ff::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 15:48:43 +0000
Received: from DB5EUR01FT069.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:8:0:cafe::6c) by DB3PR08CA0022.outlook.office365.com
 (2603:10a6:8::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.18 via Frontend
 Transport; Thu, 6 Jul 2023 15:48:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.76)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.76 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.76; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.76) by
 DB5EUR01FT069.mail.protection.outlook.com (10.152.5.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6565.24 via Frontend Transport; Thu, 6 Jul 2023 15:48:43 +0000
Received: from DEMCHDC8WAA.ad011.siemens.net (139.25.226.104) by
 DEMCHDC8VSA.ad011.siemens.net (194.138.21.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Thu, 6 Jul 2023 17:48:42 +0200
Received: from md1za8fc.ppmd.siemens.net (139.25.69.40) by
 DEMCHDC8WAA.ad011.siemens.net (139.25.226.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Thu, 6 Jul 2023 17:48:42 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>
CC:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        <linux-watchdog@vger.kernel.org>, <linux-hwmon@vger.kernel.org>,
        "Tobias Schaffner" <tobias.schaffner@siemens.com>,
        Gerd Haeussler <gerd.haeussler.ext@siemens.com>,
        Henning Schild <henning.schild@siemens.com>
Subject: [PATCH 0/2] platform/x86: add CMOS battery monitoring for simatic IPCs 
Date:   Thu, 6 Jul 2023 17:48:29 +0200
Message-ID: <20230706154831.19100-1-henning.schild@siemens.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [139.25.69.40]
X-ClientProxiedBy: DEMCHDC8WBA.ad011.siemens.net (139.25.226.105) To
 DEMCHDC8WAA.ad011.siemens.net (139.25.226.104)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5EUR01FT069:EE_|AS4PR10MB5545:EE_
X-MS-Office365-Filtering-Correlation-Id: a3d8d434-4fd7-4d4a-186e-08db7e387a09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y+qlFA1ZUgfKj22K71AgU4tDGkweS7lSo1hHy7RKFwpTwxfQAy/qWktJw2XvEXEr2dTJB+xzxoelcxMVW+GTyttZW4tVMZ+te+NGQ0EVI8KDzRWoZN6nFdrmi/Rq7MWxjasliL/tFuv0XHGxXaOK13yWPCQUSYt3pNQflX6f3l1b2QyVOEOU5lf75vIMsTSfI+dt9Kokqvd2vjd7O5Q2E0Qqax5KVWJR55hqnF2qK17W0Kp3pS9OK13etW9eHXHG8TOZlYGOdmbTyT8uB65uDtYJkrIcHKHb0UlXYNynKZm/p2KjMDZh5VTY1evFsF3WBuvrP3/8xjIfSsZZkddCqp8khcmSXGJOj3O+loGLIQT5HGvunmeJYpUMzk1oFrdqJSDWhVwIyt8NfZoIS0LLyQDjbtu3cA3IVagNZON9eFFXXTPCi1woQ448M80xDx39XJs4+ScpW91uT+2fkk0I0VS0AbRKNsJuOv9TGxNUvWlcY5UxhQzVNXWBiG/tyG74HkMzuXdD0zhqpqC8n9eahY1L1uNo6O+Svi1Kg51ugWL9LjNHyyxEMAbBFKP0Horg21OCJLL5y4dIEC9oztu2cjJv1wFm2LPOSGKrNiVcdE5IhNfreyHpHJLcBrvZCS/0owub0eFh68SRszjT5VMVDhkWdeADSdkZMPz6zwGGh6nb4IrkKpnH6kq8qJ6FAkGXcj7tx7Cs1cg4QMz+O6V6TtBeBfA02J06CSrtzLyOj6HGGa0iAKHacjKIGhGXjSz6Po/+zDo93oHyobtFWqaANg==
X-Forefront-Antispam-Report: CIP:194.138.21.76;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(376002)(396003)(39860400002)(451199021)(36840700001)(40470700004)(46966006)(6666004)(478600001)(70586007)(54906003)(110136005)(4743002)(186003)(26005)(70206006)(107886003)(2906002)(1076003)(82310400005)(5660300002)(4326008)(82960400001)(41300700001)(44832011)(8676002)(316002)(82740400003)(81166007)(356005)(8936002)(16526019)(86362001)(36756003)(956004)(47076005)(83380400001)(2616005)(36860700001)(336012)(40460700003)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 15:48:43.2960
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a3d8d434-4fd7-4d4a-186e-08db7e387a09
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.76];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR01FT069.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5545
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The real change is in p2 and p1 just prepares to multiplex an IO region.
We introduce a custom driver to read CMOS battery information on several
of the Industrial PCs.

This is based on
 "[PATCH 0/1] leds: simatic-ipc-leds-gpio: add new model BX-21A"

Henning Schild (2):
  watchdog: simatic-ipc-wdt: make IO region access of one model muxed
  platform/x86: add CMOS battery monitoring for simatic IPCs

 drivers/platform/x86/Kconfig                  |  48 ++++
 drivers/platform/x86/Makefile                 |   6 +-
 .../x86/simatic-ipc-batt-apollolake.c         |  51 ++++
 .../x86/simatic-ipc-batt-elkhartlake.c        |  51 ++++
 .../platform/x86/simatic-ipc-batt-f7188x.c    |  70 +++++
 drivers/platform/x86/simatic-ipc-batt.c       | 250 ++++++++++++++++++
 drivers/platform/x86/simatic-ipc-batt.h       |  20 ++
 drivers/platform/x86/simatic-ipc.c            |  65 ++++-
 drivers/watchdog/simatic-ipc-wdt.c            |   9 +-
 .../platform_data/x86/simatic-ipc-base.h      |   1 +
 10 files changed, 553 insertions(+), 18 deletions(-)
 create mode 100644 drivers/platform/x86/simatic-ipc-batt-apollolake.c
 create mode 100644 drivers/platform/x86/simatic-ipc-batt-elkhartlake.c
 create mode 100644 drivers/platform/x86/simatic-ipc-batt-f7188x.c
 create mode 100644 drivers/platform/x86/simatic-ipc-batt.c
 create mode 100644 drivers/platform/x86/simatic-ipc-batt.h

-- 
2.39.3

