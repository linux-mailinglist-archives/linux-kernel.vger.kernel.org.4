Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A3FD6770E6
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 18:07:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231484AbjAVRHw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 12:07:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231269AbjAVRHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 12:07:44 -0500
Received: from DM4PR02CU001-vft-obe.outbound.protection.outlook.com (mail-centralusazon11012002.outbound.protection.outlook.com [52.101.63.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 008472108;
        Sun, 22 Jan 2023 09:07:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NJ8IkvuyuOP+KNpkcjx9A3IbLl5fh/sOG1Xi/tzW+54oaY6p+YfdMUwUJxHqYsKbEC36/4ZcL/fkG4cKfSEbtbZVS8bwiprpDQpPyX7wLvAyIgjbFHD78HGuAQ54X+opvNGaCXWnkoZUm/GWvDhGUQVmDYSgUWZrUYrZum+JYoMGIaBMVqRo+uSRcHR0KAJug2C0wTmi+Z2wC1ytx1aUqW3RSvj0Xngp+KS9BRVWaAqmfOiHhOnV8t1ZwK/w/aA5PpPp5KYUizbTnfBVEDaRMMiI0ppL24tN/REOHDmEKUe5T7LcMZ0/VKms1i3Da+/I5Hr53MhkmQL4fNXj344inw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jyDNKM3Qh6uMTvjpuakktS3MnTqjCFxaQhzDiFnt/eQ=;
 b=cI6Mvy9ug2WtjXqI1s4asoqb0CTWBhXKI+kxUj3t3iLQ95wddtEDogS0mhuUGXVkCQtzqegiLRhlowQ87QR93I/m2i22Ki2ADf43sStEsOUOdiCWWvDCFCVPnwpBlByZr8PhV7yoFRXAO4OSJYUNDxcVT3r6CYlp9P9uY9hw9qvOC8B5tFyVmmuCZsGbg7gKx2tj26yl2mcoJcSEHY2NY/l2j6YL3wBD11u9Ami1bCRYAvLwOsrQidlUu14zdZ5YGlbABo69BonxyGXXG3PT7hfXdPWNdMxDjpwZEMXbR2x2qjc7ZK9RE5Zgw2TTk1ZB4dN9P7i7pvGYlRslFUxyaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jyDNKM3Qh6uMTvjpuakktS3MnTqjCFxaQhzDiFnt/eQ=;
 b=GBIMQ9jdKVSohdjSdEmZNfKTj0fkKlcDobY6n79Q9ZGGZZhc9QS2m++Lj/pyih27UO+YEmGZ0IXDjc3dcZRabg106BOQ0bEprZ9qtwVf3OKyO4N7K8AIiTBPIEw7DwvF313rQtxMu1Qcb5tqyrdQoSv3Uoexjam0aArwsLXKqkw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
Received: from PH0PR05MB8703.namprd05.prod.outlook.com (2603:10b6:510:bd::5)
 by MW4PR05MB9322.namprd05.prod.outlook.com (2603:10b6:303:1ec::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.25; Sun, 22 Jan
 2023 17:07:33 +0000
Received: from PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::e710:a9a8:3bc8:d0b0]) by PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::e710:a9a8:3bc8:d0b0%3]) with mapi id 15.20.6002.031; Sun, 22 Jan 2023
 17:07:33 +0000
From:   Ajay Kaher <akaher@vmware.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        chinglinyu@google.com, namit@vmware.com, srivatsab@vmware.com,
        srivatsa@csail.mit.edu, amakhalov@vmware.com,
        vsirnapalli@vmware.com, tkundu@vmware.com, er.ajay.kaher@gmail.com,
        Ajay Kaher <akaher@vmware.com>
Subject: [PATCH 4/8] eventfs: adding eventfs file, directory remove function
Date:   Sun, 22 Jan 2023 22:37:03 +0530
Message-Id: <1674407228-49109-4-git-send-email-akaher@vmware.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1674407228-49109-1-git-send-email-akaher@vmware.com>
References: <1674407228-49109-1-git-send-email-akaher@vmware.com>
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0074.namprd05.prod.outlook.com
 (2603:10b6:a03:332::19) To PH0PR05MB8703.namprd05.prod.outlook.com
 (2603:10b6:510:bd::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR05MB8703:EE_|MW4PR05MB9322:EE_
X-MS-Office365-Filtering-Correlation-Id: f4d02316-262a-4a93-749f-08dafc9b2712
X-LD-Processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RkUCLZxFI7SqXsqoB/20ZFobNzYVBa5UXm6yIU2iAzFeUeRffuHERPKCqwj//AEjXXB6UXY1wuGiSt/3ouInBLZchP9XUSrxxKqhKE0qzIzKSdBlcw9Ni3Vad9ZweOp+a0ecB8OY+Ip4MbO/QBi0H5ZIlPft1hRlodW5MTd4ax4COUyKIwvAKxTJ2tVdgsz0xWZgag6n+PZUSL1BJDaRX0Y77FjoLfkJPypGdIUshK3a40ZVi5B+NM9P/B9BSgmRoQ2MStUBgfKCk+1d+DajS3zZHVHB8Zb6xwafz57Dt/clusEdgfnUlTvZjag8U9s9jwJ/TpCPvVo4dZ6wtUNyBuUtQmofFPk3tP3Is7mVBXuoz0eIayJ2lMLgnrY7MbLAa7tDJfgRf1kZeqzkj1vChMy1LzVYotwN1PwvdEdPART1U3WeDUdh1b7DssNmher2TVmg2oZz0rBgyg+kid4hVCzKXJX7D6/ydud8l3XgLruRL37fjvLbcggonDbTNwKqGKrk+T91LAn7Dxh2tobt5tSdMwe08ILTTmKB2xArp4bwK2Q/ocjDsxiIc0VeyPoLeUpcOJC0Hc/9sjd+WjClhh85jssBkB+jaKZQwYtlk8TmM9q64nwpnmSZwD5e6rVbY5ObTdR/LEQ4FOaAcPbxfGG6lGZeD6K89xif7RswZzSr6ajBuMCy/n8u/3tESw5WgcKDWsS36L6FjYrGMT5hbQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR05MB8703.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(136003)(346002)(39860400002)(366004)(451199015)(36756003)(8676002)(478600001)(2616005)(4326008)(66556008)(66476007)(6512007)(41300700001)(186003)(66946007)(26005)(2906002)(86362001)(6506007)(107886003)(316002)(6666004)(52116002)(6486002)(5660300002)(8936002)(38350700002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ys1VBaf8zlOAbJDvXn2Vwbd/uuyjF5rn0gCvKJC8JrSkz6LGJQzs6//znfSk?=
 =?us-ascii?Q?Dh1itiZD6B5tZiRlpZ1KfKcdggL6qrq3tv9dP7sOhjvyt3n92roQnb1JmoRG?=
 =?us-ascii?Q?2ANS3/GlBp2b8C8MBFQm0De95UfCd82eQ3BNDZDaHbKvVDyw0n4NKRyNq0If?=
 =?us-ascii?Q?uk2MeTr/KExUs2ek69SHeR13bcaYL4HnKZ+dIMH3k1YI40BzwOXSdeRxWQc8?=
 =?us-ascii?Q?59D6CDOonExseK0F+ZYDA8O53Ui8RC6f+nVqo975XSptBPZZqqeVM/LreV2R?=
 =?us-ascii?Q?H3wWA9Dnl/+Yk0DwpjueF4dus8gpp9UWexZaR01jowE3jLzoyqgLPXMh31DK?=
 =?us-ascii?Q?2dQrVYJv1YSWZNUSco9PbNprnf0UQ2l7rFMNSOyxToqEOfqChvpN25CowhmD?=
 =?us-ascii?Q?UNYjaguyTwzCwRToQgntrfocWjhiN1j/OIIAlAuiXgGrUz5BwxECBCZ1/g8+?=
 =?us-ascii?Q?OugE/lbk4sQN0lHU+czcGHq/LclY7nIAtoPwkjKQ47Ec0bhUHyAnkDai5gs2?=
 =?us-ascii?Q?oYOUoCiavlSHg61coc5lr/aojd+rYqzSolhBy3yCC3JsTyCJaaYxS60rr7rw?=
 =?us-ascii?Q?M440zQUx/YstcMBGUqgR6qW5prdlTYqkBSNGiBGCUHOstYCmjdH0fgB2oKe7?=
 =?us-ascii?Q?KR2CzjJTb4ncoRtHxGg3sDHaY5BssPWJsoTeRtbfwUTdSZQjGbAY0wQx0puW?=
 =?us-ascii?Q?yUQMKmBslWSl1YmgNQxL660gjeyd4zcEUG3fYjU2ZMP1KRIZXJHQ+CHQ5p7G?=
 =?us-ascii?Q?nKHdjUcPXaOA+o9iNNrFcJdO3mhNaduMiRt07FbbeG7Ht5MSpmK73jVDND57?=
 =?us-ascii?Q?mMTi6AGjC3Bux/7kGHiDx0b40d65VI3n8pHaSfn2ePW7E/H8UeFVRX4Dh8Vl?=
 =?us-ascii?Q?ReqZuXpFoE6Irto61kmpVlJQz64UsrG1suOEYHjy202uUEClNe1CERlmxkiG?=
 =?us-ascii?Q?kZdxTOL0SIx4ojkiSm0hYXhLD56CG31xSDWNDVUhHoRZqp5MheRE0vW9Tg/W?=
 =?us-ascii?Q?WtjvQ2yIc2B8j33fvWBcXG1wCAtBqfgnNtqV4qjhcqkss6JyFde7YN+E5q+h?=
 =?us-ascii?Q?pX45BK/McNdR294arCykMSl8jwLzsonX7eqKUyoblUp7++ZnZ+x56lvcmKJ9?=
 =?us-ascii?Q?gSbyuJweYSJBNKNiuWmIRUEiuXkvYXhudh/6Q5ZQG/g10f9+ccfxHeQTOD8S?=
 =?us-ascii?Q?Z3TROvUSLxvxAaoxeqwsQstiK21FuEPWLSmg7NiMNY0+qM/+7KWSeeyPAiE8?=
 =?us-ascii?Q?3ZvEF1Sl5EZXv+zhwZ7t0fbjd+YMSW6aOfo6GN7QUMa2EgrhfbY4z6stDdmC?=
 =?us-ascii?Q?DDE1eCLdvM6cNkBSpbX1lBFzlSDL/4dPSRobRJ46Iv8HMYsrJDpgplaQQJbm?=
 =?us-ascii?Q?PWqYeAnNkzWvLiRRNcya/4Eyr0EDVe0mlI/dRkRFT5Uh+pFWDfzucrNYTZA3?=
 =?us-ascii?Q?BDNeuD0WQm4DldXVgmS/N8rScVySXx+96DpcrXCh0Z8giU05MySl0arHTXXw?=
 =?us-ascii?Q?DsyroHUeBfncLOMdGE9eUEaI2sE4z5+hBd1lPSddpq/vAfEGYS0DloM/zmKF?=
 =?us-ascii?Q?nyQ/njavj9gHNaYLFFfDjh236L4REQ5sBerD82Ib?=
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4d02316-262a-4a93-749f-08dafc9b2712
X-MS-Exchange-CrossTenant-AuthSource: PH0PR05MB8703.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2023 17:07:33.3383
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jkqwtsL/RwGvuqCXVy8EmaeE+61BujO4FSk6AIUylfaJ02pdio9s0OyZRkri5AVGQhF1jkdkrHiuP1kjTX5C6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR05MB9322
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding eventfs_remove(), this function will recursively remove
dir or file info from eventfs.

Signed-off-by: Ajay Kaher <akaher@vmware.com>
Co-developed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Tested-by: Ching-lin Yu <chinglinyu@google.com>
---
 fs/tracefs/event_inode.c | 26 ++++++++++++++++++++++++++
 include/linux/tracefs.h  |  2 ++
 2 files changed, 28 insertions(+)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index e479712..4d47da0 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -279,3 +279,29 @@ int eventfs_add_file(const char *name, umode_t mode,
 	list_add_tail(&ef->list, &ef_parent->ei->e_top_files);
 	return 0;
 }
+
+/**
+ * eventfs_remove - remove eventfs dir or file from list
+ * @eventfs_file: a pointer to eventfs_file to be removed.
+ *
+ * This function recursively remove eventfs_file which
+ * contains info of file or dir.
+ */
+void eventfs_remove(struct eventfs_file *ef)
+{
+	struct eventfs_file *ef_child, *n;
+
+	if (!ef)
+		return;
+
+	if (ef->ei) {
+		/* search for nested folders or files */
+		list_for_each_entry_safe(ef_child, n, &ef->ei->e_top_files, list) {
+			eventfs_remove(ef_child);
+		}
+		kfree(ef->ei);
+	}
+	list_del(&ef->list);
+	kfree(ef->name);
+	kfree(ef);
+}
diff --git a/include/linux/tracefs.h b/include/linux/tracefs.h
index 7d390d2..b02cbba 100644
--- a/include/linux/tracefs.h
+++ b/include/linux/tracefs.h
@@ -55,6 +55,8 @@ int eventfs_add_top_file(const char *name, umode_t mode,
 			 struct dentry *parent, void *data,
 			 const struct file_operations *fops);
 
+void eventfs_remove(struct eventfs_file *ef);
+
 struct dentry *tracefs_create_file(const char *name, umode_t mode,
 				   struct dentry *parent, void *data,
 				   const struct file_operations *fops);
-- 
2.7.4

