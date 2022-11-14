Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA3C6628B44
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 22:22:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237714AbiKNVW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 16:22:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237699AbiKNVWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 16:22:24 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2138.outbound.protection.outlook.com [40.107.94.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F3491838D
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 13:22:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vi+8KnV94aNhRp0vliEc9KCid9A+467yEMqddFeep6QDEznQf9+RY6JJBzfu+qA9BAWoi7EEROg3wGFe7ZlGAtfi8QQ3gLVK7+VACYTB4uC2Pp0vmJ+Q9JA9mtEYEE4M0XtPfvtU1e6sOc60Yg65QV6085JOy0tfeSx971mHx7VMm8JvkFPBlQwtAkWgOR9/J7CLZmhsPwm8eUuB45BlE2wXjBn89/FD15vkvOSwsES+LDLc6BhN/hzjEg+8EfEWD11XZuxk/xBfaUduGSZFIMY5Eo9TKPEO0ROjsn3bRDsLt8NC+FdaDUd8sXYbgWL3K/oJ38Il2x7c8bRxGWBXRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dH8A+1gqy1jb3HGugI28RnU1rHFaW9kH6j/2+B4d1Cs=;
 b=NrwtJbnjOHM7vojl0Z14y9RLakmO/6JHB9EsHFYRIOr56XC2fIck+yuD86362n09XF9vougns2VDIJu80Zztbmvtsn8HcXjPNu7akw0xcJXusuPHzlTeTrItYuJUkarlCeg0EfJpS3fFxyAZdrRi6Ucuq9S1A9ccPIyhnfAk0aYOi+nF8QFTm6DNiKDdOHRFhbH11Up2hAr1sU2jQw+j/rkbmz8dgPU9eK8Xp9H86GXIFwJzcF4hA4R5PFmcolp1kpRILlyBR4tjgPzP8xxlxAVKUollO5kLw77VYJ8xVfHHS61A37oMbWhwK3ecf2w8s+I9aKFHTKnBnFKfGSOPfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dH8A+1gqy1jb3HGugI28RnU1rHFaW9kH6j/2+B4d1Cs=;
 b=ZS4SLDgiVq7w8MX4KxOxDo50fkzUb2ci03OoKU1hNRI+3VGQf/uuzezqoSvi5a+07JHOrwG8Dty/lPxKCgMygqZ+kwtDjj7ReuDGErvQvksi5CiFNoIh2DOj6Bm/Z/7xE9mN5x1b65f1tH5+Y6WKBwML3oDDmBgW8GDgUuCmigA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from MWHPR0101MB2893.prod.exchangelabs.com (2603:10b6:301:33::25) by
 BL0PR01MB4290.prod.exchangelabs.com (2603:10b6:208:40::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5813.13; Mon, 14 Nov 2022 21:22:15 +0000
Received: from MWHPR0101MB2893.prod.exchangelabs.com
 ([fe80::cc4b:db2e:5a6f:c4cd]) by MWHPR0101MB2893.prod.exchangelabs.com
 ([fe80::cc4b:db2e:5a6f:c4cd%6]) with mapi id 15.20.5813.012; Mon, 14 Nov 2022
 21:22:15 +0000
From:   D Scott Phillips <scott@os.amperecomputing.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Darren Hart <darren@os.amperecomputing.com>,
        D Scott Phillips <scott@os.amperecomputing.com>,
        patches@amperecomputing.com
Subject: [PATCH v2 RESEND] char: misc: Increase the maximum number of dynamic misc devices to 1048448
Date:   Mon, 14 Nov 2022 13:22:12 -0800
Message-Id: <20221114212212.9279-1-scott@os.amperecomputing.com>
X-Mailer: git-send-email 2.37.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR18CA0013.namprd18.prod.outlook.com
 (2603:10b6:610:4f::23) To MWHPR0101MB2893.prod.exchangelabs.com
 (2603:10b6:301:33::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR0101MB2893:EE_|BL0PR01MB4290:EE_
X-MS-Office365-Filtering-Correlation-Id: 994d19fd-1d98-43d2-d04c-08dac6864d3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: prCl7wB6GHPGYZP8mBxMdlbNBnH9lo4hjnzvC4tVwhDF5MsM6HAGw+Bg+NXKlIZv7yirgMUR3mJd8cBnC+qBhbgLVrbIbKqYt/zb1o9nw5z5rzT2ztqmm7KgRaPd+G7lEDFTf2+wz51bYEF/+KmCZ7NZaSAqB3Bg40112xrV+7S/rgBoDJoBMunJIYjJrvF3lwS5rUekATmnDvgXzFr4G9WBQi68WfCsC76R069A2xYj4xP/7r0BEo1XXCwFWgQssFNyG6FJuoTvAhj7wntX0/uyh9DkiB3yl2uXuUqsAAYp3yaDQLF8euWLLfKa2Jq2wDjwRf4adPBYzmh7ECGs1+OkC1gJajlE8I+OMU8dC/hmlbCuVkgO8n5Dtno86qPXNiqZK1sfkAj8N77zlFcMn8AQrOYfrEbP43jG2+SnmZ9q8T8o2I7zC4Q1/ccIWN4A7NGBHf+HMrlHH8kMZATifwM9foY/4z9jY+zVooz2i1XB3zISy8MRqjS5Yo5m6Xg6gj3yyZ0Jxn4IgHcSEHV+eqANjqsux0Sjq/m8W6YFHnv2GNVKpCuh86y+V9HEEHvDXvlJ23fQ5reqTA54kUBu0WqnnpbN1O4ziNcVo5FoPDf2547a2AR4OeaiZDHgwlhBhs7qpyypk1FACW3kehU1HdLCzc3yg6q/tW+XNVSCZDy0nITskgdHk722lVVQvSZ/tMDzz5sooR1POFqBHiCvlwcnz/ahpFUZpjJ6kE3QDUjQwmjG4uzFdNOxd42Hlyc7vnm952viqFtoPL4q9zIR0oonrkpH7AWPBrof8jF4umE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR0101MB2893.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39850400004)(396003)(346002)(136003)(376002)(451199015)(52116002)(6512007)(6506007)(6666004)(26005)(107886003)(6486002)(110136005)(316002)(54906003)(478600001)(83380400001)(38100700002)(38350700002)(1076003)(86362001)(2906002)(2616005)(186003)(8936002)(41300700001)(66946007)(66556008)(66476007)(8676002)(4326008)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Xv94dBKRTu7zHQadDS23a1f19JI+vZJCHGTvvr4dPxCWdoYHDk/dkGsD1ndp?=
 =?us-ascii?Q?fJKXbBNUjrCAUMN8avf8/UUZUaIUNrz2AvwoeCsBekPeXXxT6yOWMBGnOUgF?=
 =?us-ascii?Q?hoiVZal1e0cwEEia7rlisyc1vjUc6dURs6mUA69mj/sJFzXf1lBZ+ms7ovNs?=
 =?us-ascii?Q?J0Obtg/ux3qCu/YAYeKL0YQb3l/9w524o85y3yOwQXOEuOLt31qi4PzIL9EO?=
 =?us-ascii?Q?JnRFakLiHmAXisEnJRbnp9TzoNrumnzqoFYPhvIsFkclKaxv0Ex5Ph4gUr35?=
 =?us-ascii?Q?jnyX3ckgeYU1kQqVV9IxgpTTFsXWf1h9FNPvi4gT1QFlmayc6cWc4YdwoEZX?=
 =?us-ascii?Q?VBuJfzIWYggz54vgT1zRuuKLM9WgS9PzeS5aLTJTzYFyskbRnJjZTSgyeWIW?=
 =?us-ascii?Q?kCkoTVHDqNmASARXWCUXn5RL0SyxB/2jEB30M2zxbCjW4PjM12DJZG/i8vUz?=
 =?us-ascii?Q?+8Hp3u1AOb8nKEMirkaHnwN4xNmdPZcapBXiYaBmPRE8yd9NiIWRvMG9CBA+?=
 =?us-ascii?Q?hz7DJ53IHWUu0Cp7H0sCbWFNGczYV/NUrygOpwLKfny+6oaRKbu+3gk65n4Q?=
 =?us-ascii?Q?6h3dSZs5LbRID6F/GxzZ5MhOU7MvtmkDOLx3R9Xi9lbCSrdGMT2QTOzhWFyK?=
 =?us-ascii?Q?BU5fBe0jshV1z9mSjQ08dUbj2iWi7f6dNTAF0/bC/6Y2CO/kC29EUzfJzQeY?=
 =?us-ascii?Q?qhX/tvAHJBCcrH3qG16e0/135cu7P9AUle785qWorbVAumkP+p794VRMHdvf?=
 =?us-ascii?Q?5EQTvoOrrQlsuLjBL4/zuqBMMJjOwf5yHTPOHI2rPFVc8TB0zuiK93n/AOtu?=
 =?us-ascii?Q?srjr+qz1DJlYvhv3pZ2Wr6sfmG0znltBXHzJwJzKBJrMPp4FTgwKU6VlICP0?=
 =?us-ascii?Q?p7YtmdPnH5hyVa4yuMxeiSRkHiZp6LT2EeyAtZSoQv2rsCFo7CEkBPaw9Br9?=
 =?us-ascii?Q?/8CUTPy22Lf4sRYcjG/kGOcTvr/B637M5o/QaQKHMlGPk6g+52qaUUJHTP4G?=
 =?us-ascii?Q?VNLVDZ76LyNKYWi7pe9r6kp5wDvqdV4oeyrGYZutdLGkjRP/jZA5t9XArRes?=
 =?us-ascii?Q?vP0XWksuA9GlpR/UtgAGS9DXph9xbSPT7UHiri4ZudPx0DIhnYe34FG3OMOq?=
 =?us-ascii?Q?2Tvxqi/jo5pWSaktOSELUzTgmXXcEDywfOMomUe7zTCGECiUKpRB7t+QnmIA?=
 =?us-ascii?Q?hORG2D6OTDa12w487abdSFkYwhvgg+yePYN/KbitG1ehDpqvhY8+Th+p1MH+?=
 =?us-ascii?Q?0+8KKOfCn255FCxvzzp2Lo0yefjrit4ognw09GciiRxlZMqm9KekydAl3Fub?=
 =?us-ascii?Q?vENtzWPGcbHLDaeuLKjhEqyoXWsOHMo9be9j5uradPWuBAYhUZ2aI2Nj0ZIl?=
 =?us-ascii?Q?3vjlwVZhoKxg7QAQnUwy4H/uCFr5UZZGrzCGPi5o4OJUfrxNpHu4lHZ6lgX0?=
 =?us-ascii?Q?vT+Xf4lEVtVXvlpxn3BrXe9ZCJWzh9e05/OvrVNVMl7gaqWA9lfEQ42NTspt?=
 =?us-ascii?Q?2CyhXBBiw89CEoQq+KziJZ4Mf+9Gt1w/w9CeGaH4c8j9FROgIu/8DQOovAgj?=
 =?us-ascii?Q?RFy80skKKa1LMAWYGP3qpQdE7gmVFrczMUiDZMirJX0EvOnQ2mZ/Cw8SYjvC?=
 =?us-ascii?Q?9Q=3D=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 994d19fd-1d98-43d2-d04c-08dac6864d3d
X-MS-Exchange-CrossTenant-AuthSource: MWHPR0101MB2893.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2022 21:22:15.3753
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TKyZ1HZ4xhxRT2yU1Mcs94OMqIKX49NI4dVlqrRVXwepkWQG+R3bsUgRk5rIzHdYOlj4H+wYaha1ELgBlp2PJR+BTm5UghMNrphY6bQD1ZjnNfi7nFlrB4pIk+46srip
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR01MB4290
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On AmpereOne, 128 dynamic misc devices is not enough for the per-cpu
coresight_tmc devices.  Switch the dynamic minors allocator to an ida and
add logic to allocate in the ranges [0..127] and [256..1048575], leaving
[128..255] for static misc devices.  Dynamic allocations start from 127
growing downwards and then increasing from 256, so device numbering for the
first 128 devices remain the same as before.

Signed-off-by: D Scott Phillips <scott@os.amperecomputing.com>
---
Changes since v1 (https://lore.kernel.org/lkml/20220906195213.2370775-1-scott@os.amperecomputing.com/)
 - Update the commit message to better express the intent.

 drivers/char/misc.c | 41 ++++++++++++++++++++++++++++-------------
 1 file changed, 28 insertions(+), 13 deletions(-)

diff --git a/drivers/char/misc.c b/drivers/char/misc.c
index cba19bfdc44d..05727f0daa6b 100644
--- a/drivers/char/misc.c
+++ b/drivers/char/misc.c
@@ -61,7 +61,29 @@ static DEFINE_MUTEX(misc_mtx);
  * Assigned numbers, used for dynamic minors
  */
 #define DYNAMIC_MINORS 128 /* like dynamic majors */
-static DECLARE_BITMAP(misc_minors, DYNAMIC_MINORS);
+static DEFINE_IDA(misc_minors_ida);
+
+static int misc_minor_alloc(void)
+{
+	int ret;
+
+	ret = ida_alloc_max(&misc_minors_ida, DYNAMIC_MINORS - 1, GFP_KERNEL);
+	if (ret >= 0) {
+		ret = DYNAMIC_MINORS - ret - 1;
+	} else {
+		ret = ida_alloc_range(&misc_minors_ida, MISC_DYNAMIC_MINOR + 1,
+				      MINORMASK, GFP_KERNEL);
+	}
+	return ret;
+}
+
+static void misc_minor_free(int minor)
+{
+	if (minor < DYNAMIC_MINORS)
+		ida_free(&misc_minors_ida, DYNAMIC_MINORS - minor - 1);
+	else if (minor > MISC_DYNAMIC_MINOR)
+		ida_free(&misc_minors_ida, minor);
+}
 
 #ifdef CONFIG_PROC_FS
 static void *misc_seq_start(struct seq_file *seq, loff_t *pos)
@@ -183,14 +205,13 @@ int misc_register(struct miscdevice *misc)
 	mutex_lock(&misc_mtx);
 
 	if (is_dynamic) {
-		int i = find_first_zero_bit(misc_minors, DYNAMIC_MINORS);
+		int i = misc_minor_alloc();
 
-		if (i >= DYNAMIC_MINORS) {
+		if (i < 0) {
 			err = -EBUSY;
 			goto out;
 		}
-		misc->minor = DYNAMIC_MINORS - i - 1;
-		set_bit(i, misc_minors);
+		misc->minor = i;
 	} else {
 		struct miscdevice *c;
 
@@ -209,10 +230,7 @@ int misc_register(struct miscdevice *misc)
 					  misc, misc->groups, "%s", misc->name);
 	if (IS_ERR(misc->this_device)) {
 		if (is_dynamic) {
-			int i = DYNAMIC_MINORS - misc->minor - 1;
-
-			if (i < DYNAMIC_MINORS && i >= 0)
-				clear_bit(i, misc_minors);
+			misc_minor_free(misc->minor);
 			misc->minor = MISC_DYNAMIC_MINOR;
 		}
 		err = PTR_ERR(misc->this_device);
@@ -240,16 +258,13 @@ EXPORT_SYMBOL(misc_register);
 
 void misc_deregister(struct miscdevice *misc)
 {
-	int i = DYNAMIC_MINORS - misc->minor - 1;
-
 	if (WARN_ON(list_empty(&misc->list)))
 		return;
 
 	mutex_lock(&misc_mtx);
 	list_del(&misc->list);
 	device_destroy(misc_class, MKDEV(MISC_MAJOR, misc->minor));
-	if (i < DYNAMIC_MINORS && i >= 0)
-		clear_bit(i, misc_minors);
+	misc_minor_free(misc->minor);
 	mutex_unlock(&misc_mtx);
 }
 EXPORT_SYMBOL(misc_deregister);
-- 
2.37.3

