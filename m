Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C20DD72DAD1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 09:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239741AbjFMH3f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 03:29:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234924AbjFMH3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 03:29:31 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2116.outbound.protection.outlook.com [40.107.117.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86122CC
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 00:29:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Csw9+B+DuFsYnKeOwK7eeef8pST37svNrqoIWbjpbQ/Wu2+5ogdD+VyRUpltrY7NBTJSATS2K7sJZn0E5Z2+ZejPtbY6tGj4F/nQpFhS8sairGKh324REXTL85xCFkxYIjTHrmF7y3wXBZTWjRbqJdhXXRpOA5TBddt45hRo+AEAcI9tSx1Wfefgc5ft3rtjzE3ntPBDAQEA4yl/HSSQVBbboZ5rpZSXm+mMMz56e5kknt+SvGbhZ2k6peIZN5HQ0NweYNeEr6SjD1A+YYEKT40fnZpX+wwGRwUMnf3WWCYi1Y+KVKDWtZPpHKGaSS/8lg1t8t4dtDPM1ZkVf3rylw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wgfGUgMLPbn3yETy3LvqPKYO0xZz4w00oyVUCiwb0XM=;
 b=O808E58J5de5rByGdyuzw1ELDyKlYgo7TFsBS5D3crnrhoFRk/Q59hShSkGnoeHqJRq8gmar1YQ3YIwpJbnSb/x069eHWSALT5ZRnTe3jfrHUJKT4mW/fuUpsrNe+83s7THyCdT2zotkgC6MerHc+5Q9fHX9/yf4pcq6rMbhBFo6pfMT20lKDBwOJCwv8gRJZwA2mc1+RtnA4Jyx72arG0ydzmcy/CkYmWuynl1BCcrOqRnpkp9yMJbapegGUUzJv4qAQ+LJ9XqD9jHwY7Qf3UweOdTM+368ARnSeWbzujI8Hvwoq9lqXqPpiiqzRgZUHH0yjk4TmyP37oMGryfw4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wgfGUgMLPbn3yETy3LvqPKYO0xZz4w00oyVUCiwb0XM=;
 b=WYVM3QGGiiITKmQxfBJkheC38pEUBtV6R17HVOl9M2iZ+O2ULBzRhupslVtFTB27tChzljqGl/2ArRJWQivnKzT95DcFhmUfZ6J5qfs0REzETZCbeUquqlBwWh460M+d4gYZrzgItgfpukhf/kHZW+CfOhusFkINXfIbgyabuVec0R/v3wkoqzL2KXPObBORLpzS1iMVXufkcUdLL/qAAQuCE/2YmbfWmra9JZ37YKavX4Oi+lyejtff7bnf61G6ojO8+y7soLfuWfS2LNdkggrzl2OhkBkGLQkAiHrUdAu43y5EEHec841SbJg3TOK5F1LQdI8priNJxv63mrwngQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR0601MB3985.apcprd06.prod.outlook.com (2603:1096:820:27::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Tue, 13 Jun
 2023 07:29:25 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::76d6:4828:7e80:2965]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::76d6:4828:7e80:2965%3]) with mapi id 15.20.6455.039; Tue, 13 Jun 2023
 07:29:25 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>, Lu Hongfei <luhongfei@vivo.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] f2fs: enable nowait async buffered writes
Date:   Tue, 13 Jun 2023 15:29:11 +0800
Message-Id: <20230613072912.52249-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0010.apcprd04.prod.outlook.com
 (2603:1096:4:197::11) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|KL1PR0601MB3985:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ffdcffd-8dd5-45e7-7c1e-08db6bdfea08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IAj2/DN59uG/rgBkNAf19INQ1qzZtOEOnhii9/+VeHmFAay4Db9TnCq6ff4LFUlLg179Ue64HAdzXtZ+dJyz8iV4iCepjEjxVyC/BRvxM+B9hS0FKp4zC0kwADQ5xEeDxDAMvJOyEZz56QB7Yv+sVHar//9mui1J44R87bCHdGXdaQfH+NPhv2hyNWCpEP33HajSd83NDIJbjFv/UdzxhMjGzkeB8RnsHgCldRND6eHWRm20ipzXmJf/W6H5zSMflpaJURhsdm7UTObxqgciod8MuciRlPgRE/pyIX9Ql6uRMpJYx+KMG0Xrq07P92W5V23oKBqbnJ5zGS5c1CA9QOs0/q115xANMX4XeVdWKs6fkJW0yb+pZiii5Wjezo+sO5O7uXBj21OVis9Mg1CuCwCax0BfWaj93kvEk94X9HOcln4gDj8fSFBf2+RMQUTPYmfhFmzu9qoATTyDlNdu5NznbSugj4bJLQkOXyjG1K4Nk4V72DsqoiQ8/ksw0SduC9J4yVkqMtFsLLEMRCJuDWZjN7KdUCxOh05RapdBo3ZN3m0mnzus1sxOIODdlUCR0KeFjpOyfqFuNPwsOqEArYok6jXA/WkVDjJoEGKjUnwa4oZ+rTtdIfge/XcpqU1C
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(136003)(376002)(39860400002)(366004)(451199021)(5660300002)(8936002)(8676002)(2906002)(4326008)(66556008)(66946007)(66476007)(52116002)(110136005)(54906003)(6666004)(6486002)(1076003)(26005)(6512007)(6506007)(41300700001)(316002)(186003)(83380400001)(2616005)(478600001)(38100700002)(36756003)(86362001)(38350700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?U6DNsgTEJFgJnwgkGrVgga9FuiRZ6fdtEtW/uuQs5pYWtWNXkLJAbb2LwPLK?=
 =?us-ascii?Q?aXjxsgau2c4I18b4XgpzRYj/FFBvIJi52jsn4QuFwcImIJbFu6mnwSniQ2HA?=
 =?us-ascii?Q?rPn0Iten/NEBroVrdlTLGsCjDEg3mBqq5yRrn7Mcq5o7Hv3X+AVH1+FKhbCi?=
 =?us-ascii?Q?3nM84D+wiWU+IdK74YbFWZSB4GBATN/Md3KntWfqS3kq/in6WSHfV+NBLWnx?=
 =?us-ascii?Q?LO5z7L8g5M32HknrJgK1Ura9HTOVYvwy8l0AIeLHH5938/hJFKIdeMXCYVvh?=
 =?us-ascii?Q?bcqH4GiEQET3zRvVWAJMRJSos8f70950cZAL/AoQE7ndeRvUcuSife1i5fki?=
 =?us-ascii?Q?I3GHakTPAvDPsH5+hmNhtmjY0+XrIQQkV/cAAikvI4MYu5Klan0STcmM/hnZ?=
 =?us-ascii?Q?nKS3oWnC9tcHXQRe1Y5+XAbnKi1cQgiiioPIRZEcolgum9xB1mDOwSHkyFuH?=
 =?us-ascii?Q?WGrRiV3M9lwqiU0oOMwZPF1qQ0zEfDHxsoPWcxoF2B/wq4ZXhLe8wfWJgYR8?=
 =?us-ascii?Q?df0ocpsBXOrpQJ/gqtMmNNm7ypiWU8V5oFbuwEVsBo/gq2mFjJBUBIAidi3w?=
 =?us-ascii?Q?jyj2jRsO5GGdsCpzFTZLGD8dBx6zPXKHo4ErCnrmjpCuSZMYEl385ZcF+zMo?=
 =?us-ascii?Q?yXjoEh0VXAgpqFHis881lBCrOe41aMwlBPBiZSmQN0HuNqOuyNP1NQyR887Q?=
 =?us-ascii?Q?cLVBWPtZ9jWECuJjNog1mbgLVcWK8t61yxvKXvNLv1Qzy/5rsXJygxa1YxDV?=
 =?us-ascii?Q?FQ53C2NwXuEnDIm+0TxALWCMIDSM5U15U2fKIJTpGx26b+JTjEr7yVjHkp4G?=
 =?us-ascii?Q?0HJMdNbVZaV1G+uSeva9AqjJSTpi7F+CxnSzs3iAn8xsaEfwWCSLx5SOOTHv?=
 =?us-ascii?Q?3CLz391an6omPYPLI6PmhYFHQwRkeF+k59A+T2fE5frx/WGzjWPPXwZnsLzy?=
 =?us-ascii?Q?TQLjl1Rx0Ycls1ezMBSn3an6vR0GPJa/WEvpyzpVv5IrvBI6wmSWrMRcgPMF?=
 =?us-ascii?Q?jcS0ZEMTFJRYTq5A7P5vZOmILuy+40IXCHZdmrV5ohqlYeGpF7uWV9rcNiOs?=
 =?us-ascii?Q?oOE+LQwUnN6muVt7g4hQZR+oTSEdDViz4W9mCG8m8XGxUWeks39YLcT/oGi+?=
 =?us-ascii?Q?iGX0tFtgCiYIcMWm26QHi8Evveo5bDbEVjrVM41iRXhrJtrLLnAJoFN2/h7X?=
 =?us-ascii?Q?6lRjqDLiWKQccZuFrD45JiO6rfB9DYW2Kc8UomKNFou/7F7R71wguVbrUWRf?=
 =?us-ascii?Q?Z+Kvk622Qgzl6X+trJkTrv+cY8+GUoG9d0V3/iaPlqRun0bYPEricMgwBRiE?=
 =?us-ascii?Q?2dSBWVvOEbcPBVz+vHnRxM8u3GEcUTSLwD+l+gwe/iBeyKfFiil9o3w6HRRH?=
 =?us-ascii?Q?6fDAXX7YcyuaxY/kdGv3KasR7Bf/LIhp6B5CzzZAdpK5aQmkcV4Ha8NHG8wO?=
 =?us-ascii?Q?dNNZtXtlh/Qsqm56oDZt270y0ilY5rdsXNkd2Pdm7DoJbJDaK/lxIQOcn141?=
 =?us-ascii?Q?wB/URxCaVVcpZLRCPZR9AbDLRAowCeBBeKY8SA6RgIiJPC5BEe47GlGTyu8X?=
 =?us-ascii?Q?fvXki/IqALzGPDMwSXLxEDxk6cqF+8WQCs2KErzS?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ffdcffd-8dd5-45e7-7c1e-08db6bdfea08
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 07:29:25.3222
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EnBa1cRz4k7hfwNxxuCldEN8pyLjr9ego5PBV1Q0cTfEDRuV0ufex2QXG0XDrG4yPT9IB0AC5NWtuoDQri9tQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB3985
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the async buffered write support to f2fs,
the following is the relevant test data.

iodepth      | 1    | 2    | 4    | 8    | 16   |
before(M/s)  | 1012 | 1133 | 894  | 981  | 866  |
after(M/s)   | 1488 | 1896 | 2081 | 2188 | 2207 |

The following is the fio configuration:

[global]
ioengine=io_uring
sqthread_poll=1
threads=1
iodepth=32
hipri=0
direct=0
fixedbufs=0
uncached=0
nowait=0
force_async=0
randrepeat=0
time_based=0
size=256M
filename=/data/test/local/io_uring_test
group_reporting
[read256B-rand]
bs=4096
rw=randwrite
numjobs=1

Signed-off-by: Lu Hongfei <luhongfei@vivo.com>
Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/f2fs/file.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 4dd4e2bd000a..74ecc9e20619 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -554,7 +554,7 @@ static int f2fs_file_open(struct inode *inode, struct file *filp)
 	if (err)
 		return err;
 
-	filp->f_mode |= FMODE_NOWAIT | FMODE_BUF_RASYNC;
+	filp->f_mode |= FMODE_NOWAIT | FMODE_BUF_RASYNC | FMODE_BUF_WASYNC;
 
 	return dquot_file_open(inode, filp);
 }
@@ -4523,9 +4523,6 @@ static ssize_t f2fs_buffered_write_iter(struct kiocb *iocb,
 	struct inode *inode = file_inode(file);
 	ssize_t ret;
 
-	if (iocb->ki_flags & IOCB_NOWAIT)
-		return -EOPNOTSUPP;
-
 	current->backing_dev_info = inode_to_bdi(inode);
 	ret = generic_perform_write(iocb, from);
 	current->backing_dev_info = NULL;
-- 
2.39.0

