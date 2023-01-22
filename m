Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 143296770E7
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 18:07:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231487AbjAVRH4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 12:07:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231383AbjAVRHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 12:07:46 -0500
Received: from DM4PR02CU001-vft-obe.outbound.protection.outlook.com (mail-centralusazon11012003.outbound.protection.outlook.com [52.101.63.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4304CEB44;
        Sun, 22 Jan 2023 09:07:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZZXEUT3egUPRvDrBDe6rzdV1r5r3V3eyhQCX0SvScopxSSOLe7McM5cvJdJ33gaZmAa9XTBAr/ahwlsVFOtjtsZ/nq/5toL8CckQ0RneBDD/F/iYMmU5og3ju8RJcZE7F9gbffyraY9iMXvyhOI+Q7a+vM4cAIKcpOp9aqvTmOmvqymoIf8FovFhrDWf4kO+1557zFGImisYUrbut/h4roXxxa9cBxNn2tbhgcJmkie3uZJdyYlllDVGsZYsdKuEXCXdsp9RhmKP+c3iNvaQbMrU1rRR7yjwgIse9Ixci7xx3JQIlsB7X9O/YQzHYKvs/+lqJbPkJSvDuXMpv7CX/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F33NeSakApfkP80lHUYIJtHnBNU8aDyUnI8b3FY0DHg=;
 b=nVWXUs6n5HD2ht9Ma4bw3BLeLarcWMpkh1t1Srf+5CsxeTrabBlCECekZ0RZrukAEbSpiphnjLRRvcp/61sjDfnB5PZM3LrsioairzO21KopgmzETsMJs0NZNFB6PZcJNaT2VvbMF4CKeoONgOG8D9YuDEYqZqs7hQm3us2jGDy+FbsB6sXiLwcf6E5zjeuC+BfDIspZTQMHIR31HctsV3VAPaEnfp+LewciZ40R1RNmhtFkkoqQWh5Jcg+B63kWLqvd1RCOUIRhCV8efx03Aw2u2IeH8jFlf7HXwqfZAqDtwljhb2MtOffPanP8eiOLtF2JbVxGXlh1EYWHmsTvZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F33NeSakApfkP80lHUYIJtHnBNU8aDyUnI8b3FY0DHg=;
 b=XvLFERo6ZlRiJhOiG3ns+bk1scnRxPtUKOLhgPFN/tMhA6XKOcbKJl4Pg8qAgCb4VlIp9r2CgULFRLFWIq+CfyL5AH6qqo292jRb/qHOp9TkZr8qOtzpj8STfCEjni1dYGMzA/1oSoWem1sVp0ggLj8F1ABK72bWcGzROY53aEw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
Received: from PH0PR05MB8703.namprd05.prod.outlook.com (2603:10b6:510:bd::5)
 by MW4PR05MB9322.namprd05.prod.outlook.com (2603:10b6:303:1ec::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.25; Sun, 22 Jan
 2023 17:07:36 +0000
Received: from PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::e710:a9a8:3bc8:d0b0]) by PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::e710:a9a8:3bc8:d0b0%3]) with mapi id 15.20.6002.031; Sun, 22 Jan 2023
 17:07:35 +0000
From:   Ajay Kaher <akaher@vmware.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        chinglinyu@google.com, namit@vmware.com, srivatsab@vmware.com,
        srivatsa@csail.mit.edu, amakhalov@vmware.com,
        vsirnapalli@vmware.com, tkundu@vmware.com, er.ajay.kaher@gmail.com,
        Ajay Kaher <akaher@vmware.com>
Subject: [PATCH 6/8] eventfs: adding eventfs lookup, read, open functions
Date:   Sun, 22 Jan 2023 22:37:05 +0530
Message-Id: <1674407228-49109-6-git-send-email-akaher@vmware.com>
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
X-MS-Office365-Filtering-Correlation-Id: 4a47975e-5562-4199-6f4c-08dafc9b283c
X-LD-Processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wCmdregk46XGjMCnE9yb40gExWNcgPiUukMuLPZxv5foNDzCUVwCCJT1aIB9HoG9YV53s15bZUlOq+Atc5E8NNMHPqBDtofgue7TCDFi50t+eGAuuUuJzVlYKSWsBSc8qvIRkcSUhm/ans6aH3WRmAVlvOqeGFLWirkMkSSXWy+Vp1IUGzAnNg7x4ddLB7SgYKm/KpZQ7ia8yyu5pLR8j1NgCo16lnmMJRuYkIzxS7YHJmbV70e3hODXJMJZmwp601sIpHUNo48kbLCKu3ZlohlLV9bKbY5H3KH/kHYuOPHN+ioZV/7HdiTLwCP/W8RLG61umg0j4+fqf/Hp4/YuQw0aHqOqyWlaRFGB95sWA6gifhFsPrsjDqJhqCIShUtkLYJ4oWVz9YABN3xf8wKRwUOnEyDxHHVudCXqSWvtCEzIZIVu9LxRcuWRGfru3s14zqtiDWD+khv331CtFC3MIbVPJ5YjcsL9iZ53KqWL3naULbYebj7MoM31lXVka2wVZiDpqthcqQQ3WN4F9nsqu0FqEURzYE9snru9Pu8DxFtAqdyWwwlMCT9kwerxQkjszZHyEDR1n0+UQL8W3t3PPicJzz+arZkLLnhr5sJJw/gXDHY4C1kN3N9lKTWlC/zq3iv6HR3+GHx9jDhgCIyCxyOEexdq6yguwY1I28xQT17mwL5wBitrDqop8UwfvjjOSBDs+RgFpYccL5JfvGa39w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR05MB8703.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(136003)(346002)(39860400002)(366004)(451199015)(36756003)(8676002)(478600001)(2616005)(4326008)(66556008)(66476007)(6512007)(41300700001)(186003)(66946007)(26005)(2906002)(86362001)(83380400001)(6506007)(107886003)(316002)(6666004)(52116002)(6486002)(5660300002)(8936002)(38350700002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UdMM+GLL0Q0ed4SJazLtbRI4l6JqAB7P1J7U9Ezr0Iv1+MjnI3LWbs1Gr0KB?=
 =?us-ascii?Q?OBLQvPzDGKL5XU/N+vcYsCN0TX5Nr0d45a14vcFcAeA4YUQmJta4KDCnbPL0?=
 =?us-ascii?Q?ctWCgISWgB3MyMWABYswkx0hywAzSwmxhtGAFi9KI4T6ieryAxze2BIDB2i3?=
 =?us-ascii?Q?QaSE0GljiHX0Bx9F72vD1iJ9cNlHCSYI+sbjb//62Tpo//J4yaT0czkgsuzu?=
 =?us-ascii?Q?HMddAOEj2nWAAJgQt6/q67Qk2chlvBXCupRZVRmR9kmuGD0iKc9ANzFTwRNo?=
 =?us-ascii?Q?K96kdb4TxI3vZ7mlPRtcn/sdaCMaEM8378XqCtbPU87WeSyf0FV4fb4CzDzf?=
 =?us-ascii?Q?xKWGkgVY5HhiDUltiCTWm0hQ+vsNxtrLPCrX5w/x4hCjkptkFw1R9Qw3kL1y?=
 =?us-ascii?Q?4u53n8FOxxeFNSi1U/NWOuLni00YAcMjxkwO1fYZxQXbKKebBMROhR+5f5Dr?=
 =?us-ascii?Q?xbnof3ULa3GgAredsyPe8FOanofKIZFCD/IWpZG/wpZJi0RP5b/fmYXWKi8W?=
 =?us-ascii?Q?cTr9KpCbd6efBeuvLHPdUyKPBdIgwL17SMQ1AtH966iQTT98z/+r1Oypw5Kt?=
 =?us-ascii?Q?6oA5vYOZJewg2v3ybeyyWjRzi5e4vC1hh9kdYxY3Rtvr/SQ39aH3Z/xiMnOz?=
 =?us-ascii?Q?3kj3i6hr9Z1/QqxDaXIjSGotEck21gL1sLBm05DU5zami7qOJ51ASPsyQfJN?=
 =?us-ascii?Q?1XmQC75RVbvWCQmNHkNRibEUaFGCzWjXJqAV1Ih32MHEiaK3wWnFmAkyYD/I?=
 =?us-ascii?Q?LS0F2SMWU0xb02kLff+r40f+U+TynhmpX915zuRz0awzc+OLAdCpVZ+rlKBU?=
 =?us-ascii?Q?3g6WlANgvI+7Ss7VB37x6g4KlWxjiUMxz81pHfHQcV+A7Hvk79M61aTzTfyD?=
 =?us-ascii?Q?PjFZGyLoMlykb00+QBBkElDFuEWcASKJdZLzKcxSkkqRl6kg0W2rXqTlxJNP?=
 =?us-ascii?Q?wtw+y5NWK39ACHj/9tGu6bqVKXCEsq/HHc30WdIbsSgZ/XJxJCCrrVMnR2qH?=
 =?us-ascii?Q?rmRdQnc5p2MGf/OlFhGFaCFdujXwW8JKjBKagHKB7g1e8ep8HnzlNzpPkuBA?=
 =?us-ascii?Q?S2MMzSVgceFLvMbRTsGAHjntvNNqEHdxMbacQElxZ//21iF5YrxXfwXR4Bpt?=
 =?us-ascii?Q?8Nc6n+SMsLBh33iKyTu14AOZEq2k7tb+nliIjSemgL4U4VoqgVwr+sJ0zUxl?=
 =?us-ascii?Q?UlPUt9P6Cv+ChCLTsh8gkFoCgv3hfA0/jniuaayMJz6LaNZ0zxSrYRGBQA+H?=
 =?us-ascii?Q?4gxFfOKAMkMU0az4+9/JnZTCwjeo2fi5UfSli+dXoKSsrOZm/Hy8tYRaUD+O?=
 =?us-ascii?Q?i4YPnWOAgHpnKfnqOX98bmnv4i49+8STBlGZ6ThOwgcApiD62vArCBW3KFjJ?=
 =?us-ascii?Q?AdBGlKBIeQyUXnTxF1Hj3XmLa0XevkxZDXitlHpf3LLLHiXiRUen8bnWdsDt?=
 =?us-ascii?Q?o+ZRAcFlBBSqX1IXslSi7WD16ja1flGF6TWrIWUMBqFF+FpCPuDK08+RRR2t?=
 =?us-ascii?Q?NslARQ11en9O+iDYkchikXTJs1coieDMnnP2iqUqsNpUv0uaqcFkdzgYSZBv?=
 =?us-ascii?Q?1l2W85kb9tnZcy5SlIubOD1lnDoUXyK0kL2fAFj4?=
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a47975e-5562-4199-6f4c-08dafc9b283c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR05MB8703.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2023 17:07:35.3088
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W8SkbL9LW7AIQm5P1n5GIgNQuYJq3RkEJ7gGjWHufbA3gTVAROBCS0R6QZeBX+oR2B27Zkwg+gFbSrr40jA7Og==
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

Adding following functions to eventfs:
eventfs_set_ef_status_free()
eventfs_post_create_dir()
eventfs_root_lookup()
eventfs_release()
dcache_dir_open_wrapper()

Signed-off-by: Ajay Kaher <akaher@vmware.com>
Co-developed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Tested-by: Ching-lin Yu <chinglinyu@google.com>
---
 fs/tracefs/event_inode.c | 179 +++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/tracefs.h  |   2 +
 2 files changed, 181 insertions(+)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 28866c0..bcee34e 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -156,10 +156,189 @@ struct dentry *eventfs_create_dir(const char *name, umode_t mode,
 	return eventfs_end_creating(dentry);
 }
 
+/**
+ * eventfs_set_ef_status_free - set the ef->status to free
+ * @dentry: dentry who's status to be freed
+ *
+ * eventfs_set_ef_status_free will be called if no more
+ * reference remains
+ */
+void eventfs_set_ef_status_free(struct dentry *dentry)
+{
+	struct tracefs_inode *ti_parent;
+	struct eventfs_inode *ei_parent;
+	struct eventfs_file *ef;
+
+	ti_parent = get_tracefs(dentry->d_parent->d_inode);
+	if (!ti_parent || !(ti_parent->flags & TRACEFS_EVENT_INODE))
+		return;
+	ei_parent = ti_parent->private;
+
+	list_for_each_entry(ef, &ei_parent->e_top_files, list) {
+		if (!strcmp(ef->name, dentry->d_name.name)) {
+			ef->created = false;
+			ef->dentry = NULL;
+			break;
+		}
+	}
+}
+
+/**
+ * eventfs_post_create_dir - post create dir routine
+ * @eventfs_file: eventfs_file of recently created dir
+ *
+ * Files with-in eventfs dir should know dentry of parent dir
+ */
+void eventfs_post_create_dir(struct eventfs_file *ef)
+{
+	struct eventfs_file *ef_child;
+	struct tracefs_inode *ti;
+
+	/* fill parent-child relation */
+	list_for_each_entry(ef_child, &ef->ei->e_top_files, list) {
+		ef_child->d_parent = ef->dentry;
+	}
+
+	ti = get_tracefs(ef->dentry->d_inode);
+	ti->private = ef->ei;
+}
+
+/**
+ * eventfs_root_lookup - lookup routine to create file/dir
+ * @dir: directory in which lookup to be done
+ * @dentry: file/dir dentry
+ * @flags:
+ *
+ * Used to create dynamic file/dir with-in @dir, search with-in ei
+ * list, if @dentry found go ahead and create the file/dir
+ */
+
+static struct dentry *eventfs_root_lookup(struct inode *dir,
+					  struct dentry *dentry,
+					  unsigned int flags)
+{
+	struct tracefs_inode *ti;
+	struct eventfs_inode *ei;
+	struct eventfs_file *ef;
+	struct dentry *ret = simple_lookup(dir, dentry, flags);
+
+	ti = get_tracefs(dir);
+	if (!(ti->flags & TRACEFS_EVENT_INODE))
+		return NULL;
+
+	ei = ti->private;
+	list_for_each_entry(ef, &ei->e_top_files, list) {
+		if (strcmp(ef->name, dentry->d_name.name))
+			continue;
+
+		if(ef->created)
+			continue;
+
+		ef->created = true;
+
+		if (ef->ei)
+			ef->dentry = eventfs_create_dir(ef->name, ef->mode, ef->d_parent,
+							ef->data, ef->fop, ef->iop, 0);
+		else
+			ef->dentry = eventfs_create_file(ef->name, ef->mode, ef->d_parent,
+							 ef->data, ef->fop, 0);
+
+		if (IS_ERR_OR_NULL(ef->dentry)) {
+				ef->created = false;
+		} else {
+			if (ef->ei)
+				eventfs_post_create_dir(ef);
+			ef->dentry->d_fsdata = ef;
+			dput(ef->dentry);
+		}
+		break;
+	}
+	return ret;
+}
+
+/**
+ * eventfs_release - called to release eventfs file/dir
+ * @inode: inode to be released
+ * @file: file to be released (not used)
+ */
+static int eventfs_release(struct inode *inode, struct file *file)
+{
+	struct tracefs_inode *ti;
+	struct eventfs_inode *ei;
+	struct eventfs_file *ef;
+
+	ti = get_tracefs(inode);
+	if (!(ti->flags & TRACEFS_EVENT_INODE))
+		return -EINVAL;
+
+	ei = ti->private;
+	list_for_each_entry(ef, &ei->e_top_files, list) {
+		if (ef->created)
+			dput(ef->dentry);
+	}
+	return dcache_dir_close(inode, file);
+}
+
+/**
+ * dcache_dir_open_wrapper - eventfs open wrapper
+ * @inode: not used
+ * @file: dir to be opened (to create it's child)
+ *
+ * Used to dynamic create file/dir with-in @file, all the
+ * file/dir will be created. If already created then reference
+ * will be increased
+ */
+int dcache_dir_open_wrapper(struct inode *inode, struct file *file)
+{
+	struct tracefs_inode *ti;
+	struct eventfs_inode *ei;
+	struct eventfs_file *ef;
+	struct inode *f_inode = file_inode(file);
+	struct dentry *dentry = file_dentry(file);
+
+	ti = get_tracefs(f_inode);
+	if (!(ti->flags & TRACEFS_EVENT_INODE))
+		return -EINVAL;
+
+	ei = ti->private;
+	list_for_each_entry(ef, &ei->e_top_files, list) {
+		if (ef->created) {
+			dget(ef->dentry);
+			continue;
+		}
+
+		ef->created = true;
+
+		inode_lock(dentry->d_inode);
+		if (ef->ei) 
+			ef->dentry = eventfs_create_dir(ef->name, ef->mode, dentry,
+							ef->data, ef->fop, ef->iop, 1);
+		else
+			ef->dentry = eventfs_create_file(ef->name, ef->mode, dentry,
+							 ef->data, ef->fop, 1);
+		inode_unlock(dentry->d_inode);
+
+		if (IS_ERR_OR_NULL(ef->dentry)) {
+			ef->created = false;
+		} else {
+			if (ef->ei)
+				eventfs_post_create_dir(ef);
+			ef->dentry->d_fsdata = ef;
+		}
+	}
+	return dcache_dir_open(inode, file);
+}
+
 static const struct file_operations eventfs_file_operations = {
+	.open           = dcache_dir_open_wrapper,
+	.read		= generic_read_dir,
+	.iterate_shared	= dcache_readdir,
+	.llseek		= generic_file_llseek,
+	.release        = eventfs_release,
 };
 
 const struct inode_operations eventfs_root_dir_inode_operations = {
+	.lookup		= eventfs_root_lookup,
 };
 
 /**
diff --git a/include/linux/tracefs.h b/include/linux/tracefs.h
index 52201f3..952d248 100644
--- a/include/linux/tracefs.h
+++ b/include/linux/tracefs.h
@@ -63,6 +63,8 @@ int eventfs_add_top_file(const char *name, umode_t mode,
 
 void eventfs_remove(struct eventfs_file *ef);
 
+void eventfs_set_ef_status_free(struct dentry *dentry);
+
 struct dentry *tracefs_create_file(const char *name, umode_t mode,
 				   struct dentry *parent, void *data,
 				   const struct file_operations *fops);
-- 
2.7.4

