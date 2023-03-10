Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A64CC6B38D1
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 09:35:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbjCJIfY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 03:35:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231158AbjCJIfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 03:35:12 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2092.outbound.protection.outlook.com [40.107.92.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45ECC5AB77
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 00:35:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pg/9mmMMd73/u92uTkD5PQ8/JKaNLHguugGYB2RWvgpVr7zhCHWdFXFDYpuiP5fvoWdXHUwAwVaUCsbJ7M8sfrsy3Oec7+B6M0R1Ce16N5X9vSHhu1viq1oWuM/nuTvOXw2phBWiPoQaYCFKgMYm7w5Y93xu+4KKv4IspG95xi6W84xjglYWtzJCymmtoR8RvUrzquAbBXazHXdZaKsG/WQ0UMAB0AyDLedck5FpkDqyyfxeU1K3+Gnx/apgcYbYYE+lh1U8XCCvgrbgv8fYozSWCWBQ3tf8qKOKLSMPltlFEt73IAwNmI0F1zTaJ8YnNT/fWSXg5k2OsKOBzdpeZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FnhBdbDz3cV2lUW7lqPi1e6JU52JQC6kMKIpCJIbwPY=;
 b=dR2k4zyqMVuaTO0AdfbSPay0TzQW3gFq9MMBSoLyy1TTEvd6Put3maQhLLWtMjvwb4yok82nOluh7zF7vUJRMsiAcBgImj/uYqEh56PLe8TDEGHkUMNEGEx+CszkcizCh64RhTjTa/LbRDzRQSJ2RJYwUPQdEy2Js8TX95B/aw7VraUPCjcllzIELijIFOJB001gt64KLf1QiJjHy/kTXxQSleF5hLPCueLkV90omJG48lXyjyf7UhZjb8GjdtgXzYAmFYXNQxRyNDLuNOqNtoHoCecHJP3KD8QHEoT6M0VU+edP18fa+3nwnDCmkjChp8voDhs7ySWrFEumXnqh4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FnhBdbDz3cV2lUW7lqPi1e6JU52JQC6kMKIpCJIbwPY=;
 b=H+WyhxfvZ30ue4+GdshL6C5QWoGnLlrrKeqi7LmBmtzIkH0nXp9GM0r9kibSrHyMdi5yTDMs6z9sghPmwJSycoKUQSKALbNU4SrJKUntJovYqpuigFyB15mWiRJQLI4vabGMBn3atRMvpTL8BSEW6K6aeumhUl/3RSStwhIAwHk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SN4PR01MB7455.prod.exchangelabs.com (2603:10b6:806:202::11) by
 MN2PR01MB5917.prod.exchangelabs.com (2603:10b6:208:194::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.19; Fri, 10 Mar 2023 08:35:06 +0000
Received: from SN4PR01MB7455.prod.exchangelabs.com
 ([fe80::ff57:42f9:7d6d:de10]) by SN4PR01MB7455.prod.exchangelabs.com
 ([fe80::ff57:42f9:7d6d:de10%3]) with mapi id 15.20.6134.028; Fri, 10 Mar 2023
 08:35:06 +0000
From:   Quan Nguyen <quan@os.amperecomputing.com>
To:     Quan Nguyen <quan@os.amperecomputing.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org,
        Open Source Submission <patches@amperecomputing.com>
Cc:     Phong Vo <phong@os.amperecomputing.com>,
        Thang Nguyen <thang@os.amperecomputing.com>
Subject: [PATCH v3 1/2] misc: smpro-errmon: Add DIMM 2x Refresh rate event
Date:   Fri, 10 Mar 2023 15:34:15 +0700
Message-Id: <20230310083416.3670980-2-quan@os.amperecomputing.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230310083416.3670980-1-quan@os.amperecomputing.com>
References: <20230310083416.3670980-1-quan@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0055.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::16) To SN4PR01MB7455.prod.exchangelabs.com
 (2603:10b6:806:202::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN4PR01MB7455:EE_|MN2PR01MB5917:EE_
X-MS-Office365-Filtering-Correlation-Id: effe5eb7-26f1-49c5-eb8f-08db214259e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kB9NUc1KGNlvVdYmvVj9iIcxk0vv5KGKrxVULCuR+oKHOck4DC8kKv9JQysEKRAN2jGFUJy/4Ow6CJpmFrKM0vdTfJhcDGe0ZoAA50EdYOD1/sLuIcwqfv99m0Ylo3ytjDYLwA/1/JMta6ZJo9QqETZfuxWTuwVmZf4USaq6DVR1gukjtG5/pg4Ql4wxHhx2SYIyHvw8RsmERax/gAIE0nBRt+ndm4VXPXm5EIZWe+T82MipTSe4M8CIytDRgiEZAYvcgn/A6mnUCmNgJH04eTAqn6iSU7HsdE5Zc4MbpDB8KDuYOUrilAUFKbEdIcYWIL737kb3ZSHSDlqAwO0Nf2QzjwGP3BAIDNWVPYGdwRWWYuh4p3x84WsSryEZeE19U/2JDpgYWOq2hazLNqWaUvP0YH1YfeGoW8YNkt7Am6FbZmMbQXB6NMuI9FLB6k29bHObUDkQYbTBdgjl2hO+eBUj2Gz4uFlwnhg5tPYcNykRCYHPjvBkXml/xD+NhvNzZhbWiPlZCPglunT737ZEthe9ivByMx6EsbVXJu+xVWd+WvVEGVDAAXq9C3hX7RJtAD9ZTDjacQlKLBeMiXu9QYJDTWaJveMMBC7j7WBqnsxhKDzlmAfklg6D7eBW3oeeTisaOYc2/uuR2zcdnhtdkyRX3CtU2F3ae+ivxHtKfRALT6fMQwpZe9PvoAHp0fTMBG9S3d2Pyrd/Q0TUuMUHKw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR01MB7455.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(346002)(136003)(366004)(396003)(39850400004)(451199018)(54906003)(110136005)(6506007)(38350700002)(38100700002)(86362001)(1076003)(2616005)(6512007)(26005)(107886003)(83380400001)(6666004)(186003)(316002)(52116002)(5660300002)(478600001)(6486002)(41300700001)(66556008)(8936002)(2906002)(4326008)(8676002)(66946007)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3qiuL/NZVeATkP3owOJwLHUfgSlCjh+YKTilJxM/V33i4E51pTR5TvrtnoYj?=
 =?us-ascii?Q?g3PO+Ux3ynvX3w5OPge3s61mbKcuUFE+JBuMiq5UwlKo+cqUL2hLNr5FqCks?=
 =?us-ascii?Q?tkOVouHuHkb6tCZILrXVIdDFMYGaUnM1EptSwwhbl7X83Ewh0SJACqFkBbxv?=
 =?us-ascii?Q?ifRZbD36mw2482ppIpC5TiqWGObMgl7vT7DRP3AUsj6IEzStGQb80Tr+yULL?=
 =?us-ascii?Q?iyxS1Tlg4WZr8t6D9RPI2u9o+uUpgelaijvAD+UyT5i4nZhGjXBQt82LnBPq?=
 =?us-ascii?Q?YqDitkgz+mqTRoYoF9e1qD9CF0mZJUmevq2HXpY54J3UomEtO1LUOqj8uTXY?=
 =?us-ascii?Q?fI8YCbSckR9mAhGdaOJ9Fei5WfOWE/erL0KYHcoy+E62Jo2g+i83NkfTrtMG?=
 =?us-ascii?Q?KzYYcA9iWf0DMvVU/3TS5C3x+GcxBcPdc90T1StltUQiiy3wnmaFmo6PNfdH?=
 =?us-ascii?Q?yWd5Tu2oQUtGs9JVXfOYiYcqdK4SF02/Ddsp11qV+fF6leGU1LYM5UnPz5l2?=
 =?us-ascii?Q?wiC1GKdskYiVIKW1Jvu95NrM/5AcMQ3lEmtp2Sxqu8NrnwPPz7AuybcHhUB7?=
 =?us-ascii?Q?eUfzgdNIehg53Qm+mRhp4uUUlhp7YGVKnDKkzVszS2mfm/tn9JLzpADWuqgG?=
 =?us-ascii?Q?wVr2ZN549CfSxdJVG6MkFR/fihe/dig5E00n0IVxjFO1uWsu5aC7K3KVDyMz?=
 =?us-ascii?Q?2g8pghYSf1Zq3KE7AyKJMQ7xSgFmRoyPgYrAqmrSui3y0H9u9P+Em5m23Vru?=
 =?us-ascii?Q?nIGda7HhvmflVygivTaZRsR1pszaJ/oDn7QkMqTYHwHUwTpL23sLWcVI+fPz?=
 =?us-ascii?Q?xKDcRsNY283uwyPsv2AsP9Qqr+hxVK6UbKP4CWwks2S6atTLrH15DIfPtmcn?=
 =?us-ascii?Q?EQodKxUh3ZofagXm3PPVZNfTzVtH+fhzc0vN7fmPRqXYtMb+l3r9Qe65EIs0?=
 =?us-ascii?Q?euKEo6YZ1U9N5oo8fRty2BuHZT2d8zAkkGcBC/epKi6naD0VzswuwyAI02nf?=
 =?us-ascii?Q?IuRW6HAvzwXu9IR/4bfjr4wdv7bwudfjT5t49rvTnRZOU8fhB7qJusFs7Koz?=
 =?us-ascii?Q?NZxQnuHawmg/FzU3kc3kLgfkWpm49gd24I8MtTzAM6wxvqmTJ8edPL79JGnV?=
 =?us-ascii?Q?OyA0pqNK+aNqe0fQSIaYplWqxG3BBM/FS5WXikx8+9Yzk7nwB+kBcbcmuzWK?=
 =?us-ascii?Q?rT1BvW3M8ZFp6UZxJ3lz3jo5uG4n41kTNZzfqntmEIHuYNbYE0Abuagueb7x?=
 =?us-ascii?Q?6L3KA53RCZW5u2oO1MasYl87LuxOjepJ1ZoaVjyW1+eL9A1XvV9EkFdxQWT2?=
 =?us-ascii?Q?+KBGk5Nx1KSaF9sYagyumDz7OJa7989AuSFVXHqDE9f4WvN53fN6r7zwZKRj?=
 =?us-ascii?Q?p9GqRfbT+v2IR6mIK8605aENJFm5vcFmfuj1GllFBZPSQZ3MRc2btUDvWCUv?=
 =?us-ascii?Q?IgP0p2knMoZFmw5v7uUCbsxBySu6jeKB7ejscZJ2aFVCUWJB/kl+Tzd0qr4y?=
 =?us-ascii?Q?6Tf2N33gn/AsdSS/NpY8+b5vFTqlH/mRlcnnsDxGqi6SXUVSQrEJ1B9ormju?=
 =?us-ascii?Q?lIcKQw/+gzmDtuqsk8BCwjAx/JjtJjHXaH/bgP60em667qcYkSKGCZ4rk94P?=
 =?us-ascii?Q?PgC/MKB+Bvoz7VkoF4gJ8C8=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: effe5eb7-26f1-49c5-eb8f-08db214259e7
X-MS-Exchange-CrossTenant-AuthSource: SN4PR01MB7455.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 08:35:06.5798
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QakyP60e/OVJVFBszOqYUiA7t45waouTUCU+npUewCuGOLi4JTI8U6N89KzFB4o7uPzmLpQpBBeIyNhqzCu1detTMp29meCd++Df7Ukh65g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR01MB5917
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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
v3:
  + Corrected kernel version to 6.4                       [Greg]

v2:
  + Corrected kernel version to 6.3                  [Greg,Paul]
---
 .../ABI/testing/sysfs-bus-platform-devices-ampere-smpro  | 9 ++++++---
 drivers/misc/smpro-errmon.c                              | 5 +++++
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-platform-devices-ampere-smpro b/Documentation/ABI/testing/sysfs-bus-platform-devices-ampere-smpro
index ca93c215ef99..14b58c893df5 100644
--- a/Documentation/ABI/testing/sysfs-bus-platform-devices-ampere-smpro
+++ b/Documentation/ABI/testing/sysfs-bus-platform-devices-ampere-smpro
@@ -234,8 +234,8 @@ Description:
 		For details, see section `5.10 RAS Internal Error Register Definitions,
 		Altra Family Soc BMC Interface Specification`.
 
-What:		/sys/bus/platform/devices/smpro-errmon.*/event_[vrd_warn_fault|vrd_hot|dimm_hot]
-KernelVersion:	6.1
+What:		/sys/bus/platform/devices/smpro-errmon.*/event_[vrd_warn_fault|vrd_hot|dimm_hot|dimm_2x_refresh]
+KernelVersion:	6.1 (event_[vrd_warn_fault|vrd_hot|dimm_hot]), 6.4 (event_dimm_2x_refresh)
 Contact:	Quan Nguyen <quan@os.amperecomputing.com>
 Description:
 		(RO) Contains the detail information in case of VRD/DIMM warning/hot events
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

