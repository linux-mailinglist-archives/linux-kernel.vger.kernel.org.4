Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EC606BFAF8
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 15:46:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbjCROp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Mar 2023 10:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjCROpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Mar 2023 10:45:55 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2092.outbound.protection.outlook.com [40.107.117.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE4336594;
        Sat, 18 Mar 2023 07:45:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IKTUk+X/BjFJOoEimfc9mMFdIazg9Fe/ELw1dGH4IoSa7Q30CWm7YdYSQpwwoNBjGeX6otQcjxciE3YYAi5g4GvRr/J0wByxuLB7kvuXYxPVdGFmpNX08nZjvOxokM7+4dvy6xctvm9KK6HlxaXNtJFX/d6o80sXXwWHNOOqwjRWke/oA7Sv+T82EdrODvc+iZnTo/+by2mfjTgvFulOoL/khCPW+IXqL1n2hLW4IgqYRk5S6riF/E9ix9/vYnpw0wxLvaSMbu+pZpmRysJuXaOQNuxl18rRRja7RqI+qj42Y+QUQxDiWAX7hsG1ghC2QGJ9li5DUP4K5/O9aW5oCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FPgjRdTG+hMN7F7k8sc0g+Xv0vuUpY8TpbDOsACKB94=;
 b=QNw1wm1LbtnXxU29C8q9WJ3JXWsTcTvReShEaAkmAZlf6uB++ZD0/EQdR0PmXz8HibZ1MpWTVCn4s5WIMoZo7PyrER/iJClFZTO6J0xqE8A++YNfb8eaIiNW3eD34K020NGG6bqA0Vk12kp+aTXg9KEXJOtPQsooteH6lYqgLR5PecNB0PRWlvFs+RhLaOz61UcXbDvy4St7w8srtqjrkBzM09yEgM14PYLWhDTlCHqiqlp4XiFvml/5x+ewIV81iKiK8x66bWXgxCWo2Rg+JDWu/q5SFyBNS3mPGdIFsLrl9xI0yN+F3Dd7ye1l3S3haeH5k88i+RQY+sBw5oCu0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FPgjRdTG+hMN7F7k8sc0g+Xv0vuUpY8TpbDOsACKB94=;
 b=ZuTZRbPsKkbMlUfaHM5T/IsB+90Jzvx0puwxB1Xizfp2bwFmeLzPdDG4QVT34u0xZ9T1cs6UK6M/alTU5DDoqVQae+0shhiEYGnNwfxQ7bfhWRYproCJwapaXBI4xmUJrYfM7HFQy41O46RnI8Meo878/wF9n/PuJC6rDda812xWp80IOsMS3beylQB4TcpAgVT0ktveO7lYa+sAU7XMz8Lu/6JO+b+BpzBG5dskM6TE4ksJlRlLPhpRoemwFaBKi0Rx+hnk3ofOy/u2688G7qOO9ag11JJjCj2V0bu4wcSY1qYWQjdM+Jb2IPPb/+SRB6gPrjaJ488WoWal63hMhQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TY0PR06MB5283.apcprd06.prod.outlook.com (2603:1096:400:210::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.36; Sat, 18 Mar
 2023 14:45:03 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869%9]) with mapi id 15.20.6178.036; Sat, 18 Mar 2023
 14:45:03 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/9] drivers/thermal/k3: remove redundant msg in k3_bandgap_probe()
Date:   Sat, 18 Mar 2023 22:44:08 +0800
Message-Id: <20230318144412.75046-5-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230318144412.75046-1-frank.li@vivo.com>
References: <20230318144412.75046-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0032.apcprd02.prod.outlook.com
 (2603:1096:4:195::12) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TY0PR06MB5283:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c621cc5-0c95-4004-860d-08db27bf5b9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Maz0YcsY0ElucPBxGmetD+ghWKUyp5M4ksj++Eub3axULCaUQrf5UH07BYca2mMC9GhxCHOWuzAe7jBf5P/a90MuwKqmmyGev3/lBqd4SoLcuiPQPtiwepyG1B5W76rd7SLQYroOCUaAM/6ucGfpC1v7T0/f41O0y9wGsAF7waj3PcDL3dgBtXzzEPGZg6FMa+Y1d2jZ5tcStY9pmUu9gIX2qanKtHjR2RLO3j+cPEW052V2IHw1xxETLu3fAoO+Am0SNZcB1uJBxZnWT3pmJTtU1LpydggBM+ruFKk6sc9/4YeA8mHWSGkW3OuvnqI4pKc/lUEeEdQD0GJRcfN4IVkdmJYSZ9zAg0OatNz5GJ4bruAe9wGTF5cphbq0ogrN6jCcT70kYSxVTuewLZsaIj8PKZRJnlJQkkmbHTl2KKUnDOFVC626y6pZqU3rLXpzIl5BQn7FKwpaV+ZDZopN4c0t1wdbOsBynrAFiPHCDW6CDe3HJbqgAkYfn3kewvMwjLO8miNQXeLytA1SCx/DthXUDNpNNdtV4eF/thdcUtXV4DEf9f3kQs/Y2tyagOyJ6E3WSWZj1Qx+dHp2cpAq7RsymOBMyKa+PqTw6hmnGbicAPNDnjn69AR7kSK5frKdI/exQrxtJFDjEne4g+LRjFAZhOChWtyCpnZ9r22y0akfY7lZT3zslYdhHdGgthT5iIutmYusa9gmB+15PVsA0A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(376002)(366004)(346002)(136003)(396003)(451199018)(86362001)(36756003)(52116002)(316002)(66946007)(66556008)(66476007)(8676002)(4326008)(83380400001)(478600001)(110136005)(186003)(6512007)(6506007)(1076003)(26005)(2616005)(6486002)(38100700002)(38350700002)(8936002)(41300700001)(4744005)(2906002)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?U6rloF2b8++ZCerWclkgfbv2gcrYqv4OSElxViD3KzVUw0R+RZo0h2tSGfuH?=
 =?us-ascii?Q?SrTMmnlpZucK9QNd7koMWFKPDJNo7dFuZ1a8Bd5H4HQXXrWYnD0+SAJhKZw4?=
 =?us-ascii?Q?5C7aAGcUnwPMnpIEO5cEG1bOqxQ0b6rtQtSMR7Z7J0Stp7oZLCob/o0b3H4U?=
 =?us-ascii?Q?zkI5g1jLTf4hCTaH+I7irTouqdh7nfRbWohlAGqaCt82mf99JEkGJCpi3JQ6?=
 =?us-ascii?Q?4+LkpF8FVOrsxSp/AG7W74KgLWy8cK8OKEmjaAQsBMwgA6jmuD3ToW/6keqq?=
 =?us-ascii?Q?T8T9f6vXJ9J5kKgT39FTMR14u+vnPf/7dUl/KzDJ23ghXAXFOUTSDnW81sim?=
 =?us-ascii?Q?IQeYkLZKZYfIO6rsB6vJWoY6cOC5SChrmdaGdASSFMqibwlK2so3605AHvva?=
 =?us-ascii?Q?C/rgpdRQg3TjBVRzlKdqpYvEiFREWXIVnGNhjR3XXdQmir0TLM+/tfDmsHwh?=
 =?us-ascii?Q?Jnsv8Wht2h5vWYL3wFMupioKAbZRcQH+A2qwr/ehyT56IBTfIgC+RY1X/DFy?=
 =?us-ascii?Q?E9hzPLSphKtHP3Ilj1Bo14FZI8SWTbQqr9M2rngTDeSK+iXody2z2yIJkSub?=
 =?us-ascii?Q?BzTbtu8zsAyPe5cifMZyxgh1lDisCehSUqggtc11Ij976siJM3Fo/76uP9qa?=
 =?us-ascii?Q?jHrBRQU2qPPP980mjvdSiYPy6jyhEhOq67qh7rLCXIJ2cqjzWy+ZOypH5i5S?=
 =?us-ascii?Q?52FRensZVPvuprKFd2370XQz8Tqpc3P8KRgw3JETYuHeZDRI0pk24OG9oAb9?=
 =?us-ascii?Q?39KSvcHdqH2y6RFg/FTvUEi8HNkZCAP7ZnbtcTaSSvDWWRQlGzdvGUq8Gepc?=
 =?us-ascii?Q?VrCcQxeELr5GMb+VboxciY9/WwF9qHqhafsjc0qmx5kPGQcHp7aBIZ0/bdU5?=
 =?us-ascii?Q?vh0do1LvUkHoDTEeegwepkVB7EtacDx59zXbGPxz/tdZ9N3RgN7v/r5NdWIH?=
 =?us-ascii?Q?kwtx49oN13oeqfK7+UhGPPJgrpohw2GE8YNIvTCDBz7lrj2ysw3s5azKHrWS?=
 =?us-ascii?Q?HEpqrAs8LE8Fk5oV/L+T7YCrUipRCk0u4gPUgV0iiIvNP0XVpCpHOZamkq6d?=
 =?us-ascii?Q?dC+SgziBqUxkbVUQRtWLW2/jvfn2Zcgt9swcqzJH4IA3ZVT+zGGMsclVS3Tr?=
 =?us-ascii?Q?Rokfmc5CNO/DHWphjNJyGTP0XIuezg7d4f3/lyn3j68OzZnaSvWxVNAMx8Pc?=
 =?us-ascii?Q?Ql6GKptiJlOqDdmYHiKft8B/XTH8LXaAxDvIMvzK1Zecfno0G9YDnR61ZXmb?=
 =?us-ascii?Q?2BuxcMbZdZIB629B1CY83M0elk+b5iW9ZmDoMMEMPtUMhYF6VI+0JE9xTrch?=
 =?us-ascii?Q?N3K4p2/oiUIgKRbUi2B+/RfVRme4FVYPzgjF1vaQXRWIW7RCSizgdi2LnSMv?=
 =?us-ascii?Q?8ydWIP7/ghaqPVtH/9RKAT/DNt3CwiE+OcODsLq62LQvcruhXlsSX0HpEY8Z?=
 =?us-ascii?Q?eLneTPk3SS7gELum15cAH/f0xq8u/8HtmEES71o5wsWicpjP3XwZ1MiAJQ4K?=
 =?us-ascii?Q?DSmputdtteb2yj6uPRtc/gTatFwiiqkjwNo0CgXV6OfP9l7MN0igbFxRM3k1?=
 =?us-ascii?Q?uQqe+erhNIKMI1eKnRfJYBI75WcqdHFzsjJMMJl6?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c621cc5-0c95-4004-860d-08db27bf5b9a
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2023 14:45:03.4178
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6grQPsNCjCpO02mZBylzxTuwrqCAQnZ36Bb+uRfy4W6nUzAOdN1k4emllD9oHJE4PewOPo2EMZWadma5Qkjl9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5283
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The upper-layer devm_thermal_add_hwmon_sysfs() function can directly
print error information.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/thermal/k3_bandgap.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/thermal/k3_bandgap.c b/drivers/thermal/k3_bandgap.c
index 791210458606..1c3e590157ec 100644
--- a/drivers/thermal/k3_bandgap.c
+++ b/drivers/thermal/k3_bandgap.c
@@ -222,8 +222,7 @@ static int k3_bandgap_probe(struct platform_device *pdev)
 			goto err_alloc;
 		}
 
-		if (devm_thermal_add_hwmon_sysfs(dev, data[id].tzd))
-			dev_warn(dev, "Failed to add hwmon sysfs attributes\n");
+		devm_thermal_add_hwmon_sysfs(dev, data[id].tzd);
 	}
 
 	platform_set_drvdata(pdev, bgp);
-- 
2.35.1

