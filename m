Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71CC6629292
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 08:37:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232487AbiKOHho (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 02:37:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231704AbiKOHhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 02:37:37 -0500
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-eopbgr140042.outbound.protection.outlook.com [40.107.14.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E7AC15FF0;
        Mon, 14 Nov 2022 23:37:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cJSxTI+7WJfIi+oX0THFolw8CrCpQ9wGy0mdHBuBZs4OOKQS983RxzLlqVPktPExIl51P8y41JKYcLJ+PGPDPmD+36DiWaMl30GleLNjFo0i9tatne5s+TS6x2Ry1UN5N/Dw84bNBm9nP4jyU9ydelyb2qcJmQt4H2fYzPQYlkYyzttfToQTBhBgxFoKyIJK3e/1yn9oKI82TUpZgWVJF5cuChg2Il8d98jBgp6l2uifD9KPw5KBx63uDoPIqtkWNzseA2au3w2D6E5ZJqNejgWemen8mwB+MwdWIolkx2Sk77vtChqOcLKCUs89CZVtY1tTPNNhyxU6EoCBOCLPJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O3d2K41pgbG8Y8xNbHJEpFCvani6aC85biLB9tbv2Og=;
 b=lk6AND06/LlogFPCJWaAoI1Q2GoyumLVoTcUi/hmOMObljUrDFkE4DwYabxThH3N1JJOWvnq2fKWMcXuZT7bBwwhAFrVQoTVIvn27KOkU1z3X0EsysJ2+Kbwv4u6JPIzUehPEb2BZG+dA2UjnhKRpkIEO9gyqS62blIADHs6O0yXvdBxis7d3nvL5s+XW3ME47x+S8vO6NWJjXbtFd34e2oBpYFOcwKvwJ5nyemSYX9LbHxRBAoa9+B3b98yXFcnwgBQQrv2jQbTAq7vY9PVMEZxs/uRfsjfFXq+joveRhEErd2phFukcWw9EoSbSK1NlX+9Acq3H9kB2bb9r+sllA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O3d2K41pgbG8Y8xNbHJEpFCvani6aC85biLB9tbv2Og=;
 b=QTjVibRpoNmxh7sE3H+KtX4aIks28kD8c0ecxx3xvubhdRppKlJAx0MAoWZ8tTbjGnh4ngf8TQJKMchVTytQAC3zZCvosLdHG9K71/isuHr1dGID+0pehUijg7+HFAIg9Oa5XDz7iApkBvXrcpjC88A/DnZtQIPOWaZNFPimsKc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VI1PR08MB4544.eurprd08.prod.outlook.com (2603:10a6:803:100::13)
 by AS2PR08MB9572.eurprd08.prod.outlook.com (2603:10a6:20b:608::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.7; Tue, 15 Nov
 2022 07:37:34 +0000
Received: from VI1PR08MB4544.eurprd08.prod.outlook.com
 ([fe80::bcc7:bc51:bf44:1454]) by VI1PR08MB4544.eurprd08.prod.outlook.com
 ([fe80::bcc7:bc51:bf44:1454%6]) with mapi id 15.20.5834.006; Tue, 15 Nov 2022
 07:37:33 +0000
From:   Gerald Loacker <gerald.loacker@wolfvision.net>
To:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Jakob Hauser <jahau@rocketmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Gerald Loacker <gerald.loacker@wolfvision.net>
Subject: [PATCH 0/2] add ti tmag5273 driver
Date:   Tue, 15 Nov 2022 08:37:16 +0100
Message-Id: <20221115073718.2377311-1-gerald.loacker@wolfvision.net>
X-Mailer: git-send-email 2.37.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VE1PR08CA0017.eurprd08.prod.outlook.com
 (2603:10a6:803:104::30) To VI1PR08MB4544.eurprd08.prod.outlook.com
 (2603:10a6:803:100::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR08MB4544:EE_|AS2PR08MB9572:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c3a44bd-bfa7-4e31-d4e3-08dac6dc4283
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RA0TpmozRsGYmjTUzJlp6HgRaUhnSFa42PxyJVtMF245kkku2WfppOL5r0ggSy/1r1/HK89VAkmpU11Sa/nbkIPMEPnh2+JJsU8yuGOCE090RUjRqOBtKrGVEd0JR5LyFkp2BBwaYZYhfZp01bWGA48QWDDrCyPhrUqe33LTXcsJEZFERdmMLHqHYYumn04FTbzUfKpA6A8+JcEVt1N6Puev/sRDEXKQe0FYGA+7mconiFTiOttsmw0mZIc9HMX3lI0A+y8jV4T7mH68AwvGMIdSFivyeDOcL4n20ftc8ElBoclCY9cXHC7D2NuIiZYUnRESZTvK4tYmuDYVEoqHRZbqR/FwoyUMHk29aSJ4nF8fpqGtUuKpljS9WyUF4kfvEwid9FdDSpytHB9J3V7Ah8b7i3MtQItdTQn9ySLwenJ9BdrHXQwxbRwpC4a8rfeVtj47/bmTFqqdsw3R9RPnXHobMtu4GyBRZZGhIqOensmJ99B2Bswug4xBev5mXE7+0dPb+XWdrdOL4Yol0NaSyEC4SNNEOeVaPbrr4NgUzCRatX77PWSfzC854mXvDanmjpVb+APbK7Q3nwwY8U5FreF+hICQicWYnQBPwM9E2TVlILla4tbcDIBkRyGmO0m1/ERywEovHX2khlqK/SkX5qwW5HPer2mUgKUFvd8+11ZidB5mZeqGp0ZQPiLHLEOr70jx7ZwK/iA0itvPylVhYN0O15u0PUkcW2WDmldjG7aKcD8wDeQEGrGgv+Zl8lDt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR08MB4544.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(136003)(346002)(39850400004)(376002)(451199015)(186003)(107886003)(86362001)(41300700001)(2616005)(26005)(6512007)(6666004)(6506007)(38100700002)(4326008)(8676002)(1076003)(54906003)(38350700002)(66556008)(66476007)(2906002)(5660300002)(36756003)(66946007)(6486002)(7416002)(316002)(8936002)(52116002)(478600001)(4744005)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EMdwwUGPInk8nNsYon16Szp+7xj/2IyIyxQv3QkrETHTJIuY9laZyW1jrcFY?=
 =?us-ascii?Q?D/LxIfGlANJ4ilw/GQzLTeq82FpgW1JNlgMJSrqNgshVr07OSXaUiqFr0g+z?=
 =?us-ascii?Q?SYbA795sYK92l2y7EhzgRG2EB69Lo0pEEqGq0nXzOHx1rsISba3u2sSHBXAB?=
 =?us-ascii?Q?CMwFzl3rmxCs3isWW/2wKf36jYDgq7z6qe8WZM3xg+DEfgMA5U+zMGirSJ7B?=
 =?us-ascii?Q?1BETsnLD+0jgsmcR/bCRmp6Jdq6dg/cYtO1Mlug7jEGCckEze9Q/JseqSG3b?=
 =?us-ascii?Q?tWtQwwJU0vNiKAhTLAI0q20fb0O3ZCoxOIoTMST/lPW0Qbr1dAsM9gg5kED3?=
 =?us-ascii?Q?WhGpdkE3X9U8m+Rv6tdGSPhWwdvbmdAzS607ReVr1gHF4E1A8jtHqELrgfC4?=
 =?us-ascii?Q?oCLd0O5lua11LZymTXnn4ftHJFM75W9Ekg5gKL3O9qvkssskQq3e91LeeY9q?=
 =?us-ascii?Q?kAX0VI2zZxmM1JciOmZV0oKB3prDJfBsfv4bc+lGi/HQMS0YbdRZiD+MB4qu?=
 =?us-ascii?Q?QArOYGQPA25ZE826IdIwevg7g5jOkJ8H8hPppstMGjtdF8uAaEPmguv3pdiP?=
 =?us-ascii?Q?8Svu5yADR9VQd6IAS3vfzYUCCTSuwZl5rBxl1lWqgKjZyc53l8YbMpf4IEed?=
 =?us-ascii?Q?57O+nbm5IOCpxBeRTbAiCihPu6CXZ8AUyvGTXaUBXjyBZoRoqiwAQ2YGL1s6?=
 =?us-ascii?Q?v2DNSxa1Hq/kvyk7Fb4poGgGv/TIhkMc27v+BTt14q86tgvCbF+f61nIpS6B?=
 =?us-ascii?Q?m7wf27nKC7WKOJqtpHJT2mSHvY3lricsAIYBH9gLeWZtnQjZ9fDNj7Hqg/Yc?=
 =?us-ascii?Q?o0C/yejO0bIYe6L/j0h9H/SnuoS9a5mA4+eKlEj4ft6aXGeOt9QN0/PcG1xt?=
 =?us-ascii?Q?kfXro+TAbkhHHqS+4tIes5hJFD4mDHuV3F6ZSP7C3UMxFF01mZZPU4mBrWIJ?=
 =?us-ascii?Q?f62zvqT7U4t7n1WvYp7JcDxYipCdeQ4Epn/yKub+NzHSMfqrdH+2EDbAmQKy?=
 =?us-ascii?Q?APLlFcoiUNzBmu1YUM47Ec4Ao/UxVQS5ntpG3Qz9vrVLKu+jlwSkk6c+2Bsq?=
 =?us-ascii?Q?cYxOtN/3C3T9Gh2ltd1BGk0SdPGVd7OnOKvNcpqQdmZdPFvGxiI/MJIJ9nmm?=
 =?us-ascii?Q?aENUNZvUSrk6zyDbr9OPXfY4JWW/4/BGrGORknF8vy7wUVJfBDT+3W9nDXFg?=
 =?us-ascii?Q?R6II4mlxJOTk10Xs34ZuoUFlRqDgCwwBpp7UBHWpelAdfi/QiLokEAYwzwdg?=
 =?us-ascii?Q?vQVTMXjbLthWGiOMvS2OH+YLfSh7nolCP8cFyCX7LX4FhLsSSrjTmk/wheQ6?=
 =?us-ascii?Q?sJf5+/FodP5JnhJ2miXlx9GcwNHkdPbLp6wdse7DwhAeD/WD8Nv8+f5Iuyuv?=
 =?us-ascii?Q?LuKhdPwMpOslHYpwhYZLCNIiK8YLqSrPSzMjp8SKUsGZ1bPramzg8iJ4m8fv?=
 =?us-ascii?Q?FsxCs/G2DGRm/XM/2t/1yknAKcodf1+p2KujWlXYwqQXyoKbBYKgGoxfuDTw?=
 =?us-ascii?Q?4PExL/yMJonBSMWMnw0QwnTS1CytFCU7YC31/5yYDf6B4llrnAOSgMQQoxi2?=
 =?us-ascii?Q?A0viGw/Lz2JHoM9nreEdUyEUG1hYGGHe3bzsGwVt2HwwoA42JPpxXdgY5cWh?=
 =?us-ascii?Q?9g=3D=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c3a44bd-bfa7-4e31-d4e3-08dac6dc4283
X-MS-Exchange-CrossTenant-AuthSource: VI1PR08MB4544.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2022 07:37:33.8637
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tr61gAzv2aWhW3NeyTcIOyLR3sGQuAOaQPudaJq1w+JT1CHFz8+Y5idh080CUJ6GZHz3Djg1JsZgTWI2tiGJuax+iNd4hIb8B730tSFnVaU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB9572
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This patch set adds support for the TI TMAG5273 Low-Power Linear 3D Hall-
Effect Sensor. Additionally to temperature and magnetic X, Y and Z-axes the
angle and magnitude are reported. The sensor is operating in continuous
measurement mode and changes to sleep mode if not used for 5 seconds.

Tests were done on a ROCK3 Model A board using the TMAG5273 evaluation
module.

Regards,
Gerald Loacker

Gerald Loacker (2):
  dt-bindings: iio: magnetometer: add ti tmag5273 documentation file
  iio: magnetometer: add ti tmag5273 driver

 .../iio/magnetometer/ti,tmag5273.yaml         |  72 ++
 MAINTAINERS                                   |   7 +
 drivers/iio/magnetometer/Kconfig              |  12 +
 drivers/iio/magnetometer/Makefile             |   2 +
 drivers/iio/magnetometer/tmag5273.c           | 809 ++++++++++++++++++
 5 files changed, 902 insertions(+)
 create mode 100644 .../bindings/iio/magnetometer/ti,tmag5273.yaml
 create mode 100644 drivers/iio/magnetometer/tmag5273.c

-- 
2.37.2

