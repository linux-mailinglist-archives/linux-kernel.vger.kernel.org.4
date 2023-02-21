Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B88E769E04F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 13:25:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234517AbjBUMZU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 07:25:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234414AbjBUMYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 07:24:37 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2087.outbound.protection.outlook.com [40.107.20.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1A5E9038;
        Tue, 21 Feb 2023 04:24:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WojV+bsU85wiJf6AI1Z8xh2RaF0vFBrD9YvagYbkrDbTGXfH5jmS+lTg/02Wzh06n6rhgRg/4EgGcbyDvEzvEdYH6dtuILPQOzz3HZTEOL8sYui0h6KoRrp4pMMQFNRuWeVivZnj/z63R+BoABlffpspjlFFkO0euBeOihTrDabsdQOR2tBWHPbzHR9gTWV2AkmmPhL5a6zXCYWTcRz8+aZFulDVzH4OYiYQqCpf9h9bc+gG48eVlJcfk1wbrMpD8DYEjBEr1CTh2629zR5rW2epJJuTxfDD/88Gz4NQ1/e2S7YBQMDY5Do5FPIYrDVrt3ycBJ/G4khfJe88DFHGVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NaqfGC53vn9TVWXcSR2TsnSs8FqewvevEhXwe2ngRk4=;
 b=PHVGJd7ysD06341ggs+1CL/ska51NOKeqPgqv96A/Xpan7swGftsEM+PhIWniHyWd4w/FTKSNMDJF5QG7QfX8qg24/vBb+gKOovS22TbytxMBRB3XeM6NwyayH/tkZ+x4wNmPMhPWR/IDeZfAfv7q4dMF/5JFJoqrEml5CVUtvCkijsJWhONF8U4TJHpe3T2VHAjS3wLP2LAG3peGdAuouXgkyG9WGENB2BeHIDg/cOMUXj5XGAkc2ztDMPnoE33/Tthk4l9K3AqE20T9fqc/SSXOY6IzYlIl1toZ2V2pjNmwnM74IMl3FggbJGTuKcmZEDKgsWCfVGbgJCklP6I+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.76) smtp.rcpttodomain=ucw.cz smtp.mailfrom=siemens.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=siemens.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NaqfGC53vn9TVWXcSR2TsnSs8FqewvevEhXwe2ngRk4=;
 b=dyhLC0DbkiUnMoPosZvVM2EQzB9wbll9TdUL+ifPeCMzG+oHuIUqrY+lSnoO+INGKk2HcypI1ov9pxL5aWUKHxL6e38aX8/V4xPCzx9H0Dw3ixWurvGqk3KMDJJOkPd56aeWWYkQNRcxkop1nWxzLs8eXdxoauobl9xC4Cb1mU/WbRnorVLoeWxahKE4Mre/tJhoDAI5bdKdvY/jlVXPvlSgSKqRY3cvTYsonJ+uZGY1/Sx04nxHPhcvyFlFUing566YjoxTEnEOv6MEhKfvpQpTgvKb2CJ0Ctj3F1mTbhJLUu+4mXGKc9KbP4fnU2u3x3r9gKlIcERQWFzJaAC+2A==
Received: from DUZPR01CA0178.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b3::20) by VE1PR10MB3869.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:800:164::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.21; Tue, 21 Feb
 2023 12:24:30 +0000
Received: from DB5EUR01FT094.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:10:4b3:cafe::35) by DUZPR01CA0178.outlook.office365.com
 (2603:10a6:10:4b3::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.21 via Frontend
 Transport; Tue, 21 Feb 2023 12:24:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.76)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.76 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.76; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.76) by
 DB5EUR01FT094.mail.protection.outlook.com (10.152.4.184) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6134.17 via Frontend Transport; Tue, 21 Feb 2023 12:24:29 +0000
Received: from DEMCHDC8WBA.ad011.siemens.net (139.25.226.105) by
 DEMCHDC8VSA.ad011.siemens.net (194.138.21.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.21; Tue, 21 Feb 2023 13:24:29 +0100
Received: from md1za8fc.ad001.siemens.net (139.25.68.242) by
 DEMCHDC8WBA.ad011.siemens.net (139.25.226.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.21; Tue, 21 Feb 2023 13:24:29 +0100
From:   Henning Schild <henning.schild@siemens.com>
To:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-leds@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>
CC:     Henning Schild <henning.schild@siemens.com>
Subject: [PATCH 0/3] leds: simatic-ipc-leds-gpio: split up
Date:   Tue, 21 Feb 2023 13:24:11 +0100
Message-ID: <20230221122414.24874-1-henning.schild@siemens.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [139.25.68.242]
X-ClientProxiedBy: DEMCHDC8WBA.ad011.siemens.net (139.25.226.105) To
 DEMCHDC8WBA.ad011.siemens.net (139.25.226.105)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5EUR01FT094:EE_|VE1PR10MB3869:EE_
X-MS-Office365-Filtering-Correlation-Id: 490ef573-85fa-4749-cc56-08db1406949f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c5AR498rjoqHdc/Mx5iHI/wn2XoU5/SsMCW/JQpR4R8Y6R2xOPJ9IF4AxMUMF68IBN2lgdAe9M2fd4WIZFBq4ELlKYGHTsMCBTh9Rws8/D8croYE5J9ck9ClYkLmArOU1705/l317l/k3omdxIxdExSwHi5Ob0TJB7hvP5smu47v3UCMbCE4dQ+YSJ4JTblafruPnU3dYMwO7IAKhTbGXPFqJ/yyv7QiMgwwaRFVYRnrN53lYl/xHD1H5dRXv3Xy0SGh8wrusYi2CihVeJVaPMIz9/9YDGmgLwOpkJFesSI3ksap1BCdi5pC4adqFS+dKctMxFMa61o3z4INzoF9lR6VVQGIvLTDWqDzLiTfcFrkZ6sNs21cPOdE868/ZkRzX1K1KFbuPWwe8jAOOe0lj/xUZ79dkF7CsXpb8q8CNeXyrvLvfuF2ajSMMM57nG+ln6fq1d+xrT7pKsHc8AZGjiM6aL/YiWuITNWLpDfxjQP+ue4myqyPHSGUTZXdiPVFzR+9WL6EyPbIByVCEOg5t63t/1Xj07m/9yfXCQb42VhTP9bWXSmWMZQsTYovmouKlAZNQUuOMLPdRRReNLr8v+8RLd0ypYKUnxXr9Od1+v02BRQVv7vr63gsP1R8nJJzKhP9PiwpWKtOf+UhlaIulF9CpEzG/WdgsP+fqMir8WwjyIYL7F4k7zTT2tfDsv6y9+7l47USjUwovqXMU7E14O6GiryGB39MBiuaZQx49qY=
X-Forefront-Antispam-Report: CIP:194.138.21.76;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(136003)(376002)(39860400002)(396003)(346002)(451199018)(40470700004)(46966006)(36840700001)(81166007)(36860700001)(82740400003)(2906002)(82960400001)(66899018)(8936002)(5660300002)(44832011)(82310400005)(16526019)(26005)(186003)(83380400001)(41300700001)(336012)(8676002)(2616005)(956004)(36756003)(356005)(4326008)(47076005)(70586007)(70206006)(40480700001)(6666004)(86362001)(478600001)(107886003)(40460700003)(316002)(110136005)(1076003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2023 12:24:29.8292
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 490ef573-85fa-4749-cc56-08db1406949f
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.76];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR01FT094.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR10MB3869
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series mainly splits the one GPIO driver into two. The split allows
to clearly model runtime and compile time dependencies on the GPIO chip
drivers.

p1 is kind of not too related to that split but also prepares for more
GPIO based drivers to come.

p2 takes the driver we had and puts most of its content into a header,
to be included by two drivers.

p3 deals with more fine-grained configuration posibilities and compile
time dependencies.

It is based on
[PATCH v4] leds: simatic-ipc-leds-gpio: make sure we have the GPIO providing driver

Henning Schild (3):
  leds: simatic-ipc-leds-gpio: move two extra gpio pins into another
    table
  leds: simatic-ipc-leds-gpio: split up into multiple drivers
  leds: simatic-ipc-leds-gpio: introduce more Kconfig switches

 drivers/leds/simple/Kconfig                   | 31 ++++++++-
 drivers/leds/simple/Makefile                  |  5 +-
 .../simple/simatic-ipc-leds-gpio-apollolake.c | 34 ++++++++++
 .../simple/simatic-ipc-leds-gpio-f7188x.c     | 34 ++++++++++
 ...pc-leds-gpio.c => simatic-ipc-leds-gpio.h} | 67 ++++++-------------
 drivers/platform/x86/simatic-ipc.c            |  7 +-
 6 files changed, 123 insertions(+), 55 deletions(-)
 create mode 100644 drivers/leds/simple/simatic-ipc-leds-gpio-apollolake.c
 create mode 100644 drivers/leds/simple/simatic-ipc-leds-gpio-f7188x.c
 rename drivers/leds/simple/{simatic-ipc-leds-gpio.c => simatic-ipc-leds-gpio.h} (51%)

-- 
2.39.2

