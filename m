Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 789B369595F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 07:45:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231656AbjBNGpn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 01:45:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjBNGpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 01:45:39 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2098.outbound.protection.outlook.com [40.107.223.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 656DBEF87
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 22:45:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QNVmHuiccnC+unjkSce/1jvZxyX5HeSVn2NQr23Tq5MDPeTTDn0zbN2FTPnaN3UqQjbDChC0Z+JZGQCw7O5B5BHNE17pxHm5/fxSzE3XWZbZhgUBEsPKISkQtCMfoW8XZC9k03pXkezdXgnFxGbQBOl9bLSYQGmMN1s8cV4pT0iuwk0XUpFzLYC6Ywfvi39Q6KLvi62MeI3EZWa9xNJOTcQ+5KQHKD64sL7T6vZ0sg05Q5+LG0FMGoECm2qe50zhMwIj8I6g5RyJNY0QJwWays7jlI9UODY1PohiIMEQvbvDnDmPjc1RSbMcIzTz6lPCks2AGOu+D31xciZZllY1yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W6L6CtaOM6lsMUx2LLXya/oWRSGMEm8r5r/tiVclN+0=;
 b=PeSOQE4U9H7L9M6b5T4SVYGxsTkL1lBz7ov317XtGDQ0eA9AJCwFkLr1RvUg5/PtkGB6hpHzz4LYlaQH/rHUF5Dc73XQgsxHgApWVd+9lC3KT6u3txlp16tytw+8yacWj4nGpS1/bjQo7ZVdLeUFlAZrDBUXVURRGz5ODE1TpB2NTIzFHuiqZlWnyrn4tkBvPsFBbLbEK/wCbdYqMcCobftmLGx4TcQbmM+k+53gxRL/uszpPoWWOffdyZL/c4+bjUJj4WcXtDWnHu49yebqiUQKwOVxV6Gi9tmdsXfIcMjBWic+2WyYkNq2TTZVPr/rBOngMls7Cx7PWSW9K1uUkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W6L6CtaOM6lsMUx2LLXya/oWRSGMEm8r5r/tiVclN+0=;
 b=krkB+ZSvE/523qTW/KCUF53IH1nNMDedFDQpgmAY1g5HEO0kYDg3jQnm3/0VNGJDMPZCX+651it1Fkn5/Kk6I/vJRUUyX2p6rQ/B7Mt76UM7RMTJAioP9P/anUi/xe5cLWS+j9NJLIDY1jFTf9ojTzCDyk3UFEftBhCgr2vxKR4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SN4PR01MB7455.prod.exchangelabs.com (2603:10b6:806:202::11) by
 DM6PR01MB3962.prod.exchangelabs.com (2603:10b6:5:84::11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6086.21; Tue, 14 Feb 2023 06:45:34 +0000
Received: from SN4PR01MB7455.prod.exchangelabs.com
 ([fe80::bf6:8038:9fe8:1588]) by SN4PR01MB7455.prod.exchangelabs.com
 ([fe80::bf6:8038:9fe8:1588%4]) with mapi id 15.20.6086.023; Tue, 14 Feb 2023
 06:45:34 +0000
From:   Quan Nguyen <quan@os.amperecomputing.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org,
        Open Source Submission <patches@amperecomputing.com>
Cc:     Phong Vo <phong@os.amperecomputing.com>,
        Thang Nguyen <thang@os.amperecomputing.com>,
        Quan Nguyen <quan@os.amperecomputing.com>
Subject: [PATCH 1/2] misc: smpro-errmon: Add DIMM 2x Refresh rate event
Date:   Tue, 14 Feb 2023 13:45:08 +0700
Message-Id: <20230214064509.3622044-2-quan@os.amperecomputing.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230214064509.3622044-1-quan@os.amperecomputing.com>
References: <20230214064509.3622044-1-quan@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0023.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::17) To SN4PR01MB7455.prod.exchangelabs.com
 (2603:10b6:806:202::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN4PR01MB7455:EE_|DM6PR01MB3962:EE_
X-MS-Office365-Filtering-Correlation-Id: a53bc5a0-acca-48a6-ab27-08db0e5712df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: spi8ogUJzctBKfsSVgPv/m3gOu+XBqsJVfvmnErFDsDCCeZgLjr6dVQk9RAQYuPkxfj7FJVXTnG5AqqLe7Fr2IxmXXXIvlDokjabnXA/FoAOWrm6T1WbpYcO9eooBxkrh3BXTAmURc7Vh2CxvOERX8ZGqzfMw/i/Tejpsb+UaZkTXe3JOrnFvKj2oNFf6yEfOrX/TvGux7iMz0n7eZh4dQnYPgbR3wNgAmn7a974xnHOX8G1RqfKXSF22WhealPesouM7NQ2ilUGohOKwiUpt5s9BLJw5Wy6ZBEBkIxJUMZ9M5b95eaVLUEHQr8bVb8WYcu2TdB7ly6we5xrkowJxn6/YG5OaIvrQ1JOBfVECGkPA62mGcd6DwdqlaTtKS5FSWsf05vLmcPSeIJRhVXDX3+DUkKusUasNYvGGcI1fbXeqpawt2elxbOOjbxH3saYnra9J3aKBOXldBX2I7NfMpf63OnCE7CP+m++iMEYaKT+pa4FnpZD+VGoGoua7vjeNTNI1caJ9TriNF6ggaSnWM+69evKbwAYZWUX3UX6+bF3XxDVjCnhkbYd/uQivor4Fu51r2romcr4aarT6T44IeVMJ/AI/ZSz6zZiVvwpi/hvgGS/x92j3VwrXwBbLqJg+k1zzwYClzHMj2EFCB3dQkv9ulY8XgHnYhQu7RCWU8VxMfTli6wWvASLKHj2os9TPpn1ptukeqgXg6MjkQHCmg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR01MB7455.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(346002)(376002)(136003)(396003)(39850400004)(451199018)(8936002)(5660300002)(316002)(2906002)(110136005)(41300700001)(2616005)(66476007)(66556008)(4326008)(54906003)(66946007)(8676002)(38100700002)(38350700002)(1076003)(6506007)(6512007)(86362001)(6666004)(52116002)(107886003)(186003)(478600001)(6486002)(26005)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yrzQ+ihIbteokA8wV7/DYHa0Jz2PfwUWDqrj04RKv1q9gBn6+ARTc5aw4dNw?=
 =?us-ascii?Q?qe3nTLPbaGYs6WwyHHLve44ZHf34XyCJ8frfOZbGhILuTq6ydtC06oL0R5KG?=
 =?us-ascii?Q?QOesa3HNUFRCIS2Sb2sBw28ANW4qiLQfDKRNG3fSbsBUpmJ/cgLIsmMqpyd1?=
 =?us-ascii?Q?d3fU3dNfyjifAZcPAvsKuEhcYW1hSP2YHM5Fx8LTfQwxtfBscPlkbGu5lHCD?=
 =?us-ascii?Q?Z04LFU1vZI5+9qlqqUwP9plumqLUgjZpcycnfNe9yd6FicpSROXbYPXnv/Wm?=
 =?us-ascii?Q?Tt/EqLwHAYmtoDneUoEP16RRgY70YO6HogAczv84egZ8HWwmU4YH7AUBqohc?=
 =?us-ascii?Q?9UT0mBY2JYTj9ZRNWoTOPYzpFgjCIUs1EL9+MIDSQ7JvMysyb3QOyvK4EDYr?=
 =?us-ascii?Q?ouHiwWWG3G8ijG+9+YO7fBSbN2uh8zX2/b+frTGQ0i6ixxv6Mnz1gO3zpcwR?=
 =?us-ascii?Q?rnlMHeeydAiGFhdShgzxi1xFJojB1PKY4wbRJThu5nzVGAowvAU9amI+2C1S?=
 =?us-ascii?Q?W/xf+hnU2bWaPvM85wEwTV+HCwAysKmeznlDc0O/W1wh6M5Ak04Op6vRVlsl?=
 =?us-ascii?Q?Tx3Df8NBPEb6o+cg6fWO3IMm89LUHA618iwHSb69TxrrFsBjbVZ3bDMUPO8W?=
 =?us-ascii?Q?BfIWPgFx2x8Ee/kCky35J3zNzSEt93IJlHavVMrS56OlbUfH/OiKQVGWaDqW?=
 =?us-ascii?Q?Uz/r/uWam+f9Z1yBMvKGYEXOWkT+n8eIHnTnWY/tbC57ws1IocH/wnLtQXAJ?=
 =?us-ascii?Q?kItaRRUOin2/IsafInzIwMcer9mUSK03MfADGGd0NR9+VXBxptYKI4b9NwSp?=
 =?us-ascii?Q?z0VXl0rtn6dFddl98bwU5Lw/Hwf4/A5W1Ab21vDw3O3HcdQP6wNRX/6qHTPp?=
 =?us-ascii?Q?HyoOv/QnWWw4h/wwn2F6ny6+nnwzXYDfI+8mJwqHow+iSoynRp4J+W8LyX3N?=
 =?us-ascii?Q?q/LGVfr1MJ46lGOiSKavx6LcbTGUtb7/1lm+2F6L+LT/ZmiOHIJiQejNnxdS?=
 =?us-ascii?Q?8xvp+iJNXRYv3ioQNpwQv4NJSkP/YlmOGIvcJtSSXiS7wF89w+ldUwsMAlRZ?=
 =?us-ascii?Q?k851lBKmJ78BVpYa+4C1SBx0yap0zFAhCUFMRUvcmOE2EG2GC37oCIxKQczm?=
 =?us-ascii?Q?PZUlTS4hWUqdMowp6KGbcVf5XDsAy4bKspYpfeRN1/6vjOXVSEsk0dnzt6NS?=
 =?us-ascii?Q?mlGwVfk2zoJra07ZNKjSTuWBE+5uZfM6oN9+qg4bYwCOvTKh23Yd2RfY/5kN?=
 =?us-ascii?Q?ks2lNKmR0cHh4UuJIjfB3h20yCw1o5ukhVAU0/xFjWcYoFczujRvveTolDPK?=
 =?us-ascii?Q?IZhGOPvq/7mQpydFMPhYVOGmVK4tVwvbZeEBbv/f7Kyv+2bOWh3EzL18lHSo?=
 =?us-ascii?Q?9ILV1GZk3+HOSYgYkYU/ysZGk7qyuhuyxyKckasPdlQC8m4bpQfD7w9Wgagd?=
 =?us-ascii?Q?FWMEKQL2uCaXdR88kU30iuwcVR6wrdTCx3rLpzA36mMXF25C9wAga9NRjuAN?=
 =?us-ascii?Q?ccb3r2LbRbBWZkAT5UkInOmOZ5pu0/+I1CQ7Rj4wrXofxUtIbI8a5vOPn6H1?=
 =?us-ascii?Q?2wLXiH0VwWGrFmVKwg95ZiIDtin2lnaVhpWDQ0rJNLKgESgCX7jJNA7dv7Ae?=
 =?us-ascii?Q?SjfzhRQ1h63wP0j8ZCBJpxw=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a53bc5a0-acca-48a6-ab27-08db0e5712df
X-MS-Exchange-CrossTenant-AuthSource: SN4PR01MB7455.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2023 06:45:34.7461
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5D1GRCRK1mnGB9J0Gf95QjyPMjcUtYCKDNwtWe/ihv7aNp7i9mgAlSFwKUddQB8UcSIeCJNGB9dvfcAyJQYhH7b/+Hdu0wikqlJTCK8TrTw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR01MB3962
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In high temperature condition, JEDEC spec requires memory controller to
double the refresh rate. This commit adds event_dimm_2x_refresh sysfs
to report that events for all memory channels.

Signed-off-by: Quan Nguyen <quan@os.amperecomputing.com>
---
 .../ABI/testing/sysfs-bus-platform-devices-ampere-smpro      | 5 ++++-
 drivers/misc/smpro-errmon.c                                  | 5 +++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-platform-devices-ampere-smpro b/Documentation/ABI/testing/sysfs-bus-platform-devices-ampere-smpro
index ca93c215ef99..d4e3f308c451 100644
--- a/Documentation/ABI/testing/sysfs-bus-platform-devices-ampere-smpro
+++ b/Documentation/ABI/testing/sysfs-bus-platform-devices-ampere-smpro
@@ -258,8 +258,11 @@ Description:
 		+---------------+---------------------------------------------------------------+---------------------+
 		| DIMM HOT      | /sys/bus/platform/devices/smpro-errmon.*/event_dimm_hot       | DIMM Hot            |
 		+---------------+---------------------------------------------------------------+---------------------+
+		| DIMM 2X       | /sys/bus/platform/devices/smpro-errmon.*/event_dimm_2x_refresh| DIMM 2x refresh rate|
+		| REFRESH RATE  |                                                               | event in high temp  |
+		+---------------+---------------------------------------------------------------+---------------------+
 
-		For more details, see section `5.7 GPI Status Registers,
+		For more details, see section `5.7 GPI Status Registers and 5.9 Memory Error Register Definitions,
 		Altra Family Soc BMC Interface Specification`.
 
 What:		/sys/bus/platform/devices/smpro-misc.*/boot_progress
diff --git a/drivers/misc/smpro-errmon.c b/drivers/misc/smpro-errmon.c
index d1431d419aa4..1635e881aefb 100644
--- a/drivers/misc/smpro-errmon.c
+++ b/drivers/misc/smpro-errmon.c
@@ -67,6 +67,7 @@
 #define VRD_WARN_FAULT_EVENT_DATA	0x78
 #define VRD_HOT_EVENT_DATA		0x79
 #define DIMM_HOT_EVENT_DATA		0x7A
+#define DIMM_2X_REFRESH_EVENT_DATA	0x96
 
 #define MAX_READ_BLOCK_LENGTH	48
 
@@ -190,6 +191,7 @@ enum EVENT_TYPES {
 	VRD_WARN_FAULT_EVENT,
 	VRD_HOT_EVENT,
 	DIMM_HOT_EVENT,
+	DIMM_2X_REFRESH_EVENT,
 	NUM_EVENTS_TYPE,
 };
 
@@ -198,6 +200,7 @@ static u8 smpro_event_table[NUM_EVENTS_TYPE] = {
 	VRD_WARN_FAULT_EVENT_DATA,
 	VRD_HOT_EVENT_DATA,
 	DIMM_HOT_EVENT_DATA,
+	DIMM_2X_REFRESH_EVENT_DATA,
 };
 
 static ssize_t smpro_event_data_read(struct device *dev,
@@ -463,6 +466,7 @@ static DEVICE_ATTR_RO(warn_pmpro);
 EVENT_RO(vrd_warn_fault, VRD_WARN_FAULT_EVENT);
 EVENT_RO(vrd_hot, VRD_HOT_EVENT);
 EVENT_RO(dimm_hot, DIMM_HOT_EVENT);
+EVENT_RO(dimm_2x_refresh, DIMM_2X_REFRESH_EVENT);
 
 static struct attribute *smpro_errmon_attrs[] = {
 	&dev_attr_overflow_core_ce.attr,
@@ -488,6 +492,7 @@ static struct attribute *smpro_errmon_attrs[] = {
 	&dev_attr_event_vrd_warn_fault.attr,
 	&dev_attr_event_vrd_hot.attr,
 	&dev_attr_event_dimm_hot.attr,
+	&dev_attr_event_dimm_2x_refresh.attr,
 	NULL
 };
 
-- 
2.35.1

