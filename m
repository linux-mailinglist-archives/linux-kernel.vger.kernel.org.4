Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99D106E7FAB
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 18:31:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233618AbjDSQb4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 12:31:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233639AbjDSQbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 12:31:52 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2120.outbound.protection.outlook.com [40.107.117.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B84072A4
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 09:31:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lYVEzbng1D5dYKc5pRIdMSfstMmD2TqYZm01Uo8Yn+ip09bZ/3k9tcU4XoHiIZbFdTxDnJisunAVjSdKRiss2mXpWsDsrQpQSFHio/fbBuBGFCjc/aGV/OiC5FYKfLNiUPlI5kMGAE98kLWLEawQJsBUXyMuVc+q3+ZQyGxPBbu3bgTxqxgWMqnwUNRKxTQ9rHcNqewh9mrgxLKJgkWvv8OTlwCX3gpwILULTvF6wBwKLEgXlIhYsLyAdkuwUbfYfBIAby+emnTX/eyH4RHIKvjNoWm7zDi7JasW4LsmuS6rQU/HSo0ZiX+5NGuMB93Q/7uH+EdBwYFgexLHZTJmHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hsDVv1QyUDWIKAkxYo0tiCKgpgQh5t22baLlA02c5Ek=;
 b=jYed7I36vADq/OkWdLvD5nBTCHpWg1PqkCUL8i9UAjMhgEk0SXsywwT9/vpX0rvgxUEsJLhoXsaoTtVItzhCG16RAPisxBROP2YS+rdVRvumpq5lmPr+NrYnRPLtjLmQYF1MWEb+7asu6rVCHc3gjn4CXWu5PxIjrk8f4WEO+LcCmuVzfALBPgvrwbGnDLB9HOwzJSWJjoWl/+x/3cv/cdA+Si4UReJGEwZW70DQy8rS1cMiIfsQzXsT8BqzmWBFsisKUHwstC2jQVdq0oELH0M9vrpiEHfgyCuJFpmlTNJCS71F2q7uHvHQydh6qludIfxg2wzF+hEOs2q0HzRXIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hsDVv1QyUDWIKAkxYo0tiCKgpgQh5t22baLlA02c5Ek=;
 b=qrik65swx+p2LB76QOjkQAkak5mktzGqIQDXPZ7/DAcJBiaL/cIZvjIv7EOe4RdcJi4+QOUF1JS/dbiwO5jsUelBj58Q73fLepv3/NyIlaOxjfk32thP5hJeFfsH37p9vF7UvNXICOOHvfiQ7l1OMefueDizr1ddIZ4QpouJhXNJCZgeOLjbhoQ2qZiRhzAf9p194tJHnmzZ3cJ+dWKwOb1okYWRvmA3FPsgaloJ7WPNS6PRiUVUPp2hqzeLWQnJfdgt87ju2LVDP56OQedzdCxbqrKPtc+YwseME1bP6fhQiQolK5ZyhZaXmIIACvHe9HY+37RVwa+MIoRuyXdAYA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TY0PR06MB5188.apcprd06.prod.outlook.com (2603:1096:400:21c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.20; Wed, 19 Apr
 2023 16:31:41 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::76d6:4828:7e80:2965]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::76d6:4828:7e80:2965%6]) with mapi id 15.20.6298.045; Wed, 19 Apr 2023
 16:31:41 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Yangtao Li <frank.li@vivo.com>
Subject: [PATCH] f2fs: add a tracepoint for discard thread
Date:   Thu, 20 Apr 2023 00:31:31 +0800
Message-Id: <20230419163131.7682-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0013.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::7) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TY0PR06MB5188:EE_
X-MS-Office365-Filtering-Correlation-Id: 3054f174-e770-4df2-d5c3-08db40f38e07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nwJhV38ilMsZrbujMQeWvqvb5ZK1cePimToR7hQsRMI9XgomvloMrzUd2WoTgzSodgwJsFm/TY7opnH7eLpKcmtuE8mATNiUMVEnOmkjwCjEp+eyYFjBF3LAPf32/FXq4/V7oXok+usnuGL7vqRsvxf3Hn4QhJLC3osujHsDqIxh6fZKIjSs3qRunReqtmu/icuobY6s92aMPaXTO4rNS506ZiYBRieMDPHgBgTx0eliLOmh+imGPV3AYMGauMhKAhsr4ZD4O3RJMbpYS2XDjOwmHA2gXjcWUa4ppF6StWE+PqyrWdhzL7zcRCSOERXU2TtJj3FiFh2FSEVm1dWGpeQtxcyVcD2ntk8+eBEPrhYeMeNcwR8Xtp/G7mjK0L/Y3f+HXgUK9DQVopOkMU55arml0kMuL6bGam7S65FTeZNGIktIw5YQjmW8s/gpjEn52S80/HH5gL/w0beAai1sOPPBJ4FjyJkNnVLKxB/m/y9TTGOFDM2dMMM3kCNsMU8sPmPuDgtDq6tlgb/vmQioVkM9uzL1CevySppkhlwmfVYFQWy0NGd/3lbYg4KJaZ0Md5Tt54AaKNr5CW1mhuPUfmzRGZ+cupvWC6A01Zltu2aP1eAFLQqVLlOmOTMcMTab
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(39860400002)(366004)(346002)(136003)(451199021)(6666004)(6486002)(478600001)(86362001)(36756003)(2616005)(83380400001)(107886003)(6512007)(186003)(6506007)(38350700002)(26005)(38100700002)(52116002)(1076003)(316002)(66946007)(66476007)(66556008)(2906002)(8676002)(5660300002)(8936002)(41300700001)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Wa+NrcAVUSZBp4HX82p+It/esj8CPspfdadc+s8DDBdsLvEX3B1R6PyRhC9Q?=
 =?us-ascii?Q?VhogllHX2kfjlYUV70P0VA+ILKoCfbabD0YTwcsGZuxy5lcJnOYYJOS5KO33?=
 =?us-ascii?Q?8tqWQmEcUpzxaRYUm2AR/OjLp95H9Lln30Y5ttJ0UTST/RJl+0V8YK3JtdR9?=
 =?us-ascii?Q?5AGYAnC74UuuhsWRe/SwxA9foZubCxsz5LrE7BxEhoSouOZLt2OY1tMBIM8Q?=
 =?us-ascii?Q?MSfM+t62DZunGZP07EFlkNBFPuuYK4feOKlM5p9L1lZoL2wbLdopRqlaHmkN?=
 =?us-ascii?Q?Ll4Nx9EByIG4oS1zXpduhB4rsgxcAY82swEsC8uuGSMOWzGtJ3GhNy+Q+64w?=
 =?us-ascii?Q?e+nVhD5f4IcywAbBMucF8DtjyBy2XPMFlxLcYDA3aFhkNZMU6Jx561bz6l7H?=
 =?us-ascii?Q?f0mRATQxFngdx0J40REHXTlBD8jD4Mrzw+Hmpjz78o5JL7Ty/7M3VDCK++rN?=
 =?us-ascii?Q?S/XT3JAsHXk6fer6CbeGXxQkgfnL83qv3YXQhyDWhNOTv/g3OMZTktRGUoaC?=
 =?us-ascii?Q?jSygFNTJQxy+es59SVtyhpqFVA7Vn7x9sa6hKNu9hwpVSxnr6mD1BqKyu6AD?=
 =?us-ascii?Q?jEKf0F+vWZViT+hPXgIfebWCrrIY0BekmvXZtB5db7mYJr9fbd4N8a89euQk?=
 =?us-ascii?Q?ODKkQ/KopNaJQ55Ja3+zEl9TIpJCG4g9bJsJJUvVGUJ4zLG6O/gszEq2KOwE?=
 =?us-ascii?Q?iSd4xYYRHdt2pNY9WIJs51SW3dxTsq1t4fcPCLXVGAYap46KWVVvtmJ00exZ?=
 =?us-ascii?Q?TDv6cSZkwUKtvhNj7VhS8J7LsocHlyne2bRw0dsJb16dD8f5SYAOvj7u3lSE?=
 =?us-ascii?Q?R0IjVDX2NOeWwvvFNH8dIgA4vM5hpgP80RulEeS6clpLsDvibGvnWmHmfmgQ?=
 =?us-ascii?Q?IBvim+TKpMCfQrtNNtT7l7iktqvrSPbAP1Z2gl8hDnpDqRACekXpyduXthls?=
 =?us-ascii?Q?T2jISbBCKABYkEJSk5WIpVDyFZNNREhCGIGdgqJjTmUDulbpU243LkdZevke?=
 =?us-ascii?Q?Zwo8quEmptbDEB9ledZsJ4OOiU9G2KAwSWXad055w/cWZ5QeC+h4u6DrxWKB?=
 =?us-ascii?Q?1NdFdb1mKHa2fJqIaBRaSPYkaYwPD9eoFvC7L/mrdx356uPae71IDcrAD7dJ?=
 =?us-ascii?Q?MhSsDwPqX1dejAmYVj50jGzNwkXg2WqVwlMDuesfQvrwxGZgolumL1N4C0op?=
 =?us-ascii?Q?5MwOk4zWfB9sIq5TJRAEQFP+3YjYd/UuDiuwx9oBHaw/CocH2a3q24xaZheC?=
 =?us-ascii?Q?qox/xihXLZlKCcj+ziwlsMmJM9+gRHmPmTwlGYrFoBiR9IfK4DhSjgvUmzqp?=
 =?us-ascii?Q?9AmHJO09QsABYcxjv0mJxuHqeMyxi0oXrl5xwDL1D7dwiuSutwFGsWj3w1hK?=
 =?us-ascii?Q?j132nLtlESJz7nd7uJLK4SbloPyyZXZK45fFpzVPcZcYsm0u7wUk3NQhl2g1?=
 =?us-ascii?Q?YOPHQwdaGbZuajHBB3w06PfM+N6Vf3ySFKhKrSqm4PZZLAjJLcOsdYby4LqU?=
 =?us-ascii?Q?xrcjp9x67x0w4KETSTqBXbA1i3wJOmSC5pxGsjhXfDhzE70IjX078KuLSzbF?=
 =?us-ascii?Q?F/ZoboTqSTBmlazyB/K3YU8V/rvgaLd8vD104ol/?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3054f174-e770-4df2-d5c3-08db40f38e07
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2023 16:31:40.8625
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gF6PCBoSaIAO/E3jv4IIJi1/6Z90+RI3hdYybNLNyOl9a65+KlCQ5fmxrkmaOlmRqh5j/Yfq7AIgQ1geafaoxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5188
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces a tracepoint to monitor discard thread behaviors.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/f2fs/segment.c           |  3 +++
 include/trace/events/f2fs.h | 28 ++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 641bd8cc54da..e27ad310186c 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1839,6 +1839,9 @@ static int issue_discard_thread(void *data)
 		if (!atomic_read(&dcc->discard_cmd_cnt))
 			wait_ms = dpolicy.max_interval;
 
+		trace_f2fs_discard_thread(sbi->sb, wait_ms, dcc->undiscard_blks,
+				atomic_read(&dcc->discard_cmd_cnt));
+
 		sb_end_intwrite(sbi->sb);
 
 	} while (!kthread_should_stop());
diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
index 99cbc5949e3c..e1939427deb2 100644
--- a/include/trace/events/f2fs.h
+++ b/include/trace/events/f2fs.h
@@ -1512,6 +1512,34 @@ DEFINE_EVENT(f2fs_discard, f2fs_remove_discard,
 	TP_ARGS(dev, blkstart, blklen)
 );
 
+TRACE_EVENT(f2fs_discard_thread,
+
+	TP_PROTO(struct super_block *sb, unsigned int wait_ms,
+			unsigned int undiscard_blks, unsigned int discard_cmd_cnt),
+
+	TP_ARGS(sb, wait_ms, undiscard_blks, discard_cmd_cnt),
+
+	TP_STRUCT__entry(
+		__field(dev_t,	dev)
+		__field(unsigned int, wait_ms)
+		__field(unsigned int, undiscard_blks)
+		__field(unsigned int, discard_cmd_cnt)
+	),
+
+	TP_fast_assign(
+		__entry->dev = sb->s_dev;
+		__entry->wait_ms = wait_ms;
+		__entry->undiscard_blks = undiscard_blks;
+		__entry->discard_cmd_cnt = discard_cmd_cnt;
+	),
+
+	TP_printk("dev = (%d,%d), wait_ms = %u, undiscard_blks = %u, discard_cmd_cnt = %u",
+		show_dev(__entry->dev),
+		__entry->wait_ms,
+		__entry->undiscard_blks,
+		__entry->discard_cmd_cnt)
+);
+
 TRACE_EVENT(f2fs_issue_reset_zone,
 
 	TP_PROTO(struct block_device *dev, block_t blkstart),
-- 
2.39.0

