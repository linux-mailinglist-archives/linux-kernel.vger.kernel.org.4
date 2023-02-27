Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78BE36A4156
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 13:02:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbjB0MCe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 07:02:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjB0MCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 07:02:32 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2121.outbound.protection.outlook.com [40.107.255.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A09A1C5B8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 04:02:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lhx1uityMvJGDPiVSri+G3HQNzQuSR02zHBagdUscamCZK2duTsHxfPytwj6z8zokLj1NZNBtUHSbVbK6ap+nNaOkM+Cjc48hiEgdw2zMLmjWLgHE6gZhoVXHUWP7kE6fSkLzoZ3tEBpqlT9c5bYk78ROEkLRcI4M8ueoeCI/BNJYSlRsYxKR0IqohT/VjATRS9/TAwXaqGqhSsg0WkUppHTIrdM/80rClDQwIlUU2kLBC8Wy/aKHm2dDGgR+Wiwwj39DeSLlFkX44cEwa/QvdtZjwxvGDiZBirOEQPAVfBhkMXViK0fESX3PHLwZ+SaSej/rFTIWlsQwcNzNpU5EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NxvD7HiNvijWP3w1rJaVseNLdT2rfHfGcXROHXNjTxw=;
 b=ZLou9WuE4/ocHE7DZZL1T9FWyGu7SNbWe+DOEXY3X3RSPu6S7g70kOXUSkTs5kHlAA5tPAbFiDfPWeOPMuTUIsY54ur0smnDhJKuMRRjtrkbkcuXG3nZGA4E25Qmd2KLgTGcz6kkqlXgqzEEbpGRYnoN+QuavugluMAIrCR9s0QD5+T+hHwuj25kVXOogwZeLx5hW8/g9LBGT/HlN7mu+24ulgD1q0X1sLMeZVzmVE2j0VuiQZqcHvw+HVGK6fMyddqBpV4ZvSNza/ktdi5KBrehyvJmZXKNfdryfCQbW06GpWUHhiDa6ti5r5n4l9Zjsr6mg4g6Vb3aUrjHJ3ATPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NxvD7HiNvijWP3w1rJaVseNLdT2rfHfGcXROHXNjTxw=;
 b=m8EOnYUGIEDunKi9hKKCV7k/xo97x4fWrI63+pwTvdhj/6en9+gnubKrezWv0Gyrph7K6yw5WAR7xjvpCfDU0/sRRbKdSi8L5Fv5+yN4+AG73y2c0Y/MebgW3o+gYe57fktesGaJBI0TSTJdgkMODeMMZsQxEV0PRMh4q4Js7U1kHvSOLjknadD5TmN9lE+pTkRnNzMK4tAfnxqCWgI0y5D3QR/JRWd1cyMf0itH3/FiTaQEzBsQT9SMbK5Q+fjSfoKcvN+BShbZGRtLlXxHWKy4ts5UTZisy6Nh6NO04TOa7fyWMQFUbk8q8xTIy0layTFofWkERENpRsFMLTB/uw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB5275.apcprd06.prod.outlook.com (2603:1096:400:1f5::6)
 by KL1PR0601MB5728.apcprd06.prod.outlook.com (2603:1096:820:b1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.12; Mon, 27 Feb
 2023 12:02:27 +0000
Received: from TYZPR06MB5275.apcprd06.prod.outlook.com
 ([fe80::a2c6:4a08:7779:5190]) by TYZPR06MB5275.apcprd06.prod.outlook.com
 ([fe80::a2c6:4a08:7779:5190%4]) with mapi id 15.20.6134.019; Mon, 27 Feb 2023
 12:02:27 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     jack@suse.com
Cc:     linux-kernel@vger.kernel.org, Yangtao Li <frank.li@vivo.com>
Subject: [PATCH 1/2] quota:  fixup *_write_file_info() to return proper error code
Date:   Mon, 27 Feb 2023 20:02:15 +0800
Message-Id: <20230227120216.31306-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0120.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::24) To TYZPR06MB5275.apcprd06.prod.outlook.com
 (2603:1096:400:1f5::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB5275:EE_|KL1PR0601MB5728:EE_
X-MS-Office365-Filtering-Correlation-Id: a4178da8-61c8-4991-f063-08db18ba7e7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vJsWgjRQ6Pe78amWMPhdPTtzf5zM3lc3mcIoMaDMmkyTQYs5ILz6NJ5MXZIYUdvyZwl0UI/cC8Fk6g6uPZMhoaCVO16/+jpCK6WoFxmIwIimSjTr7Iw0xSr7MHGRQCL5q48KysSUAA+i8CVtiAxIxA0f5Wrr5FWSoOlYR5QiAcmOgzqwwGGnnAdkl/v9JKOs9rpflvZZVZhVZ/8hdiMK3hUu63QbpIVzswHcmeJaySpPK2pNEToZtSzmyZv/AURITrBDofV8oJ805gAlic4V89t7OsIWNjXH3nbWmp2F+0WakawaGPEI8aj5k1Yj6f/doEL8cCyVk41MDYWdpZg8fy/9XxqaVe5qSesQ4M/obFfWNwV590904KCI0xEgom12H3Sg2rKJ1eVmHvvQRLceoMMwADfl1x6oxT+HJpYQdqaiRFh+MY/sT4+N1caV7flBAZmAtZxbGHVqx9Q7pp282d2aFKxWr5Fhq2+KsWdDKgG2zDUhHTfRrU4/Yie3sNw3oQI75ij7adMBA1O1Ji3JAn5qRxIO1NmT0mzoCamfVNxNYmMpUUVlQkriSoUytlW11BRuh6VHWQfdkMm9R0nNuaVgMFMI5v7SNLHZwJ80HlQ5mjX4KMr69cLQkxEdn9/yGdci/qROjoJZnmU3/1YQfZkozKEulNqjqWJGRdLSGYiGqXaLKDjcCvVIRKUIoaODgJ10ZNQK6fwXD+w+54j/Cg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB5275.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(346002)(39860400002)(396003)(136003)(366004)(451199018)(6486002)(36756003)(86362001)(186003)(8676002)(2906002)(5660300002)(4326008)(66476007)(6916009)(8936002)(15650500001)(41300700001)(66946007)(66556008)(26005)(6512007)(1076003)(478600001)(2616005)(107886003)(6666004)(52116002)(6506007)(38100700002)(83380400001)(38350700002)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?e9X82ulYgKUUmQ28sd86JmSolHk96moYbYlzP/PqM+S/7Sxsb2XSAA/mwuar?=
 =?us-ascii?Q?F0ccyfTQbDvPbQtJnxWqZOXE/EV5hK3fzwksQ9T4sCXpnH0xStMNAraWPHtA?=
 =?us-ascii?Q?C4pTE13Pb0icZG7krd1aYgE9Y3TGSxGeBH19qVUO1byLiIM/wEQI0cXEqzJu?=
 =?us-ascii?Q?qDQqUt7ZL7SSplwejGUold1sUKLj0cO3dqyPRrHQvV00DGtD/TzEtaYTjAdt?=
 =?us-ascii?Q?jEF9aeO16GYnUpNKa/IO5cSIKg9KQ6m8JncikJwx340je5+BhGNRCDsKEXlo?=
 =?us-ascii?Q?5hv1RUihisnNxmug9kX89Jcwti9OwHJFNIgI3St+ekJrnQKLObiGRj8W4pqc?=
 =?us-ascii?Q?iO/bJRLdzpwL7eUjrVg6+xgrw4lFQ8C/JQWrgvNomqqe3PVNpmsWxFZmnvJs?=
 =?us-ascii?Q?ZgQSxGkkWxbh7vsxr3OAZnFXaZlbqCECNiXOdZ6wY1gR8h9KK68TkWCH7dmL?=
 =?us-ascii?Q?X0kMN+AX352+rDgQOcWV8smdS5+Q7JDaf0nvoAbYZTlk4GSMHBCMGOQh9CMe?=
 =?us-ascii?Q?w1VGtvdznS1f6ZYwp/g66L/sows9Ec7Gwq/im/mLp5IwuyDj89XDSaQoz4Pv?=
 =?us-ascii?Q?BeZxM3/lAIEg+JYapJkDO7+WmDt/QsXgvcIttwsOwGW6rcPa88Z8U2vygbxv?=
 =?us-ascii?Q?AX+tG1UF1FWwEvr2DtqrnrcxLWl7IWlGd0FqasJg+7f+GIyP/aop0KoxkCGi?=
 =?us-ascii?Q?5JQv6bZ1LCCOLek8NReLXZ0u4OkHOGVjhBolT4H8sT0HPHTUqmx5R11p6r8v?=
 =?us-ascii?Q?4PukZ6U4IrVrRyF19/5VgjsJ0CBJDXUr3+UYIOiq1YJkaJ35Fyc7i7pLxLIA?=
 =?us-ascii?Q?WRQ43b0uJk1uFDygZXaGwMSr6DRDcApYLEhMEI/3GSlTZ+YdXpf4CY/E8Qor?=
 =?us-ascii?Q?v0CnAyrh2SVraLNg/bF+hl/f+NkxKHWXzwO4/KZbpK28TTQpyF3qfF617y6k?=
 =?us-ascii?Q?SB/TukFGTQb9KctL0pXo+PDSBAkir/jWHwmlYrWLwpQz7IiZNcaz2zxSp9uD?=
 =?us-ascii?Q?cZRBUiinixe+YMwFsW3rKOe7/z9eVpHiG/6aAxdchxdJnsWvFu7OStvW5gGS?=
 =?us-ascii?Q?/6vn88Q+mHl7DVydTi/GX4QzsNLheFuvfEAuy7uXEXg357pvgeNpalFO+37z?=
 =?us-ascii?Q?uI45pa4mymU0dkfQtEaV5dfuUFmbIj8UkIGY3ZtHXF3Gxf4fa9SiKyzDp+Ey?=
 =?us-ascii?Q?aBxDgnPo4prrO+cDXTvpxpJbYgvyEPK+Ikrzcpgfwe9E9h+mEM8KbqVM/jDn?=
 =?us-ascii?Q?KcVFTv5vSnFG4H6wwQlsqqpQ+TJ169cpRMH0MzP0q2hG/BuBYPa1Bp8kPTOl?=
 =?us-ascii?Q?fI1WSdYSFUxDJ9CjMub1ydDF23riT+zgr6e3esjJfyfAYHIaM9T4UatWefmE?=
 =?us-ascii?Q?uDDbN8ntoxeJq7exohtv4vWwOxqEyV9egDUrK0kjZAVvhoGmvUBXWuAZO+So?=
 =?us-ascii?Q?gb2QjCuMxTGRoqG4AY+B2nNuBiEJ1JzCukeXMFdPR2k0OAddRQeOy6Og4Euj?=
 =?us-ascii?Q?F9oC/fbSbDG8qY9RicCIxO/9WjpiCSq8nDqrEyk/QjCzCwj9bOf9NTkbKHhq?=
 =?us-ascii?Q?vgWXbEz1NlA8DnDuTz8Up8/lPi3nWczkmxefo2va?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4178da8-61c8-4991-f063-08db18ba7e7f
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB5275.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2023 12:02:27.0385
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fqfUZgCfPT8OQveDz7q65ZZHfQKiNsMZ29838+zOTtFW5zhIe1KgCd/SKEEX5zuP4Y0nB1xOp8wACEV7eULSMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB5728
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For v1_write_file_info function, when quota_write() returns 0,
it should be considered an EIO error. And for v2_write_file_info(),
fix to proper error return code instead of raw number.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/quota/quota_v1.c | 2 +-
 fs/quota/quota_v2.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/quota/quota_v1.c b/fs/quota/quota_v1.c
index cd92e5fa0062..a0db3f195e95 100644
--- a/fs/quota/quota_v1.c
+++ b/fs/quota/quota_v1.c
@@ -206,7 +206,7 @@ static int v1_write_file_info(struct super_block *sb, int type)
 	      sizeof(struct v1_disk_dqblk), v1_dqoff(0));
 	if (ret == sizeof(struct v1_disk_dqblk))
 		ret = 0;
-	else if (ret > 0)
+	else if (ret >= 0)
 		ret = -EIO;
 out:
 	up_write(&dqopt->dqio_sem);
diff --git a/fs/quota/quota_v2.c b/fs/quota/quota_v2.c
index b1467f3921c2..ae99e7b88205 100644
--- a/fs/quota/quota_v2.c
+++ b/fs/quota/quota_v2.c
@@ -212,7 +212,7 @@ static int v2_write_file_info(struct super_block *sb, int type)
 	up_write(&dqopt->dqio_sem);
 	if (size != sizeof(struct v2_disk_dqinfo)) {
 		quota_error(sb, "Can't write info structure");
-		return -1;
+		return size < 0 ? size : -EIO;
 	}
 	return 0;
 }
-- 
2.25.1

