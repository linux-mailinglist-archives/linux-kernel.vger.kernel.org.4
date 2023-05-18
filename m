Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB4870789F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 05:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbjERDxz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 23:53:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjERDxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 23:53:52 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2049.outbound.protection.outlook.com [40.107.215.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88155114
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 20:53:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ijNyvoPXcGecojHNcmSPWyCgnIfY+rY25hLMm9ENwj//6SQY2rI8RsKRbxyPKgQy+KASsCWCK186pfnhkDgAUoipOTuqoGZ7tZVCCkuEHUFbb9xHwqm8txRMscIndDG97V5sB0rXYaUx0F9iImGwvDH2Z3AMOBCK1Mn5KPATQtyhcA7lxd8WImCeX/Z1igDx4YJRAdBJhAHXvgHHadGnQdjxRUzL2fb4Oq9H9BXlWleyfewyPQ1K5dztHJ4VxUGFMdLClAgzGAPxuNjbXm9z8VEJ8KYrySSfT5Uk0R3BpK1t0nqxL2UwuvVRGDcKCzYYKSVIa27GS1VBYc7N/aYgig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rfo9BwZDSB8wEkd/tbDRwidgAlKEn+jqibGMr02NvzA=;
 b=K0Q9bNSm5A/37PdNQcxQkVlduydCDv2SBzJ2uLCApEcnc8qssh16G/ExUfHneN/kDsosjeIvGJN8beLbjxtbRXPtouOXPThL39wf4KzEJF8IhpJd7j9WKkrTrcgCKCxB6EsT5eIky4VDIXDd3WEZuCyPsy7m2b3paxggdtn+xsf8IBj0MQfHYoe/SmzrupW24VnjAbaN81/epetICGG86GXCT3V66KY8x2bKX/av+UJwg1Yri+Xc+xBSbsdQnoEQ5zBaxI0nfjT4tWJt6KgjSE6sg8GhrS9VJxSdZu5kPMdp4iG6McdTTd76tBEXxoIZ9yEHkqJCn3c2VOWtgXHSfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rfo9BwZDSB8wEkd/tbDRwidgAlKEn+jqibGMr02NvzA=;
 b=ZbdqC5eGDFP5OnGwzIF08dA6w+H5QjZX/rtaNYTdfJqio5Rro4nGN157Y55WJHOZdyjl/N+GLisx6mVH1WwcfLxJpdylu4r4UdTnKH6xAOaHrhwp7/kzX7DNx0UHW6C9Wx+1yNNIHrSgFsHHIFQEaAUBHxZpihTdBCIZDGqOO/cqE+NyMlGHBqevnIWcgn5AIVruYZZ4erS62UTWe2moSzD1HjT7d1NjQ7t2X06lcN0zaPmN0AwUNqzJgj10zhz6/wW2BMOg6nj8Tt9QZf0VQtTiiNujGOpB2nqTVnnLgVBcvyzEdtxUvj3u1e+b0vLxhLVC5yY0oiLWeA60iyXG3A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
Received: from TY2PR06MB3424.apcprd06.prod.outlook.com (2603:1096:404:104::19)
 by PUZPR06MB5451.apcprd06.prod.outlook.com (2603:1096:301:eb::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19; Thu, 18 May
 2023 03:53:45 +0000
Received: from TY2PR06MB3424.apcprd06.prod.outlook.com
 ([fe80::60d6:4281:7511:78f7]) by TY2PR06MB3424.apcprd06.prod.outlook.com
 ([fe80::60d6:4281:7511:78f7%6]) with mapi id 15.20.6387.034; Thu, 18 May 2023
 03:53:45 +0000
From:   Angus Chen <angus.chen@jaguarmicro.com>
To:     akpm@linux-foundation.org, masahiroy@kernel.org, vbabka@suse.cz,
        peterz@infradead.org, ndesaulniers@google.com, paulmck@kernel.org,
        rppt@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Angus Chen <angus.chen@jaguarmicro.com>
Subject: [PATCH] init: Add bdev fs printk if mount_block_root failed
Date:   Thu, 18 May 2023 11:53:21 +0800
Message-Id: <20230518035321.1672-1-angus.chen@jaguarmicro.com>
X-Mailer: git-send-email 2.33.0.windows.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0029.apcprd02.prod.outlook.com
 (2603:1096:3:18::17) To TY2PR06MB3424.apcprd06.prod.outlook.com
 (2603:1096:404:104::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PR06MB3424:EE_|PUZPR06MB5451:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a690bd9-aa3a-471e-ab4b-08db57537a82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sctlxkwXRPF6iQFwzecxOPqoHn1dDiVJTqS2a0eK/H9h7W6QPU+ECJdtf11jUD9Lk+M9kEjBJ+Qgzm6cj7s+/IWVbpiK8TMqZ4p73lR8MBnF1vJ8gA/AVNwK9pDFVt3JhzufeQ6T9Zd3Xez9bVt7cux8SQVfi2Iq5yM8FXzUyv4GYcQge0So1x5CRJFcr8KF8IwwFrJxstVDhCtWGEidNZ5nqivOUxVQ3Xhne9oqXtUDiRZshz3S+NEK+2YcUFTo24BX7jeSQT8+ZloKls5Uxl91+eptT/qT+MP2i0D19ZHCB8RwhZW7Ct0qu+FEIKjWyQ6m46bWcjWCLunaO5l8q+w3EghDTvjJ6jmg1knd574smo+bPsU0AGSdDHpPOAsiYXsmnEctuZ3ZiwfCY/z3Oc78UrbMfwrrFMR+yMUCZ9Dq+ZDoeAGGN7tJzXxEiA3W0M3APBct3wIDZqNOXu8i5iXC+qRn0gHaxOIZ5Ll0f/bzmEQdCpSU1dZCTzPErSYz2RG/UvP6hXLxSNCZwVSb+nhqIddwSu6f0ON5yUlws1EGrUsLSjPIrLFS/fIU4KgP1qvREkhuzhneMPsVQLClTUFNuy5gdNsqy+HR0PUL+mzVjqXvo7fn1I1S8wzGZ3uL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR06MB3424.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(396003)(376002)(39840400004)(136003)(451199021)(66556008)(66476007)(6666004)(66946007)(107886003)(52116002)(6486002)(316002)(4326008)(478600001)(41300700001)(5660300002)(1076003)(186003)(26005)(8936002)(8676002)(6512007)(6506007)(44832011)(83380400001)(2616005)(36756003)(38350700002)(2906002)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TxyNJMDnOFDxpN5KQoSThWRdwFMeWL+8J+hRVXfjXOLS6q5TJWQe2ulQ3OKr?=
 =?us-ascii?Q?0DL5l4oqOeU5a/MRvvZo1UQKmvwxWh9Av2XOyqCoqUaY99nYK8jqtX+hgJJn?=
 =?us-ascii?Q?Ij+VYJGwG7UKcYS8/2l8VYsdyRJ+iVPvX1jm8hWG5mhsXKZ/RLG2cjNP7XwW?=
 =?us-ascii?Q?dVjA3RgkFJ6HJi5hjDZF7S9t+90HqXFMs/CQfDdfiTpoQmAD2zKCg0Gbx505?=
 =?us-ascii?Q?/PDVPxH1R8X7tLyyJVTq0vYO9RhOXhT5b+cAIG3SdsdBYZsgPUuPdWpFPPXT?=
 =?us-ascii?Q?gCKpzMNMXxsJCFKTN/ondcY7kE46CSlqpjM35tbqA/pAcZgLXeLtCXQxzHdx?=
 =?us-ascii?Q?5yMoN9AfqKSkwG5jAQoOzqo5vAMn/q481M9J2YQE71CLGi5hIvzcAS7ggCTy?=
 =?us-ascii?Q?jfVqKiZo39oMElqjZqM7c1M2yDORpDd0BThRWNGWzijMNUxZRZ+ZgPnBaRHv?=
 =?us-ascii?Q?zr1W7lGeGFmguYMnw8+E7Q1fFx6y0T0sMQzk1lraTNAwx98ddwShiT1/OhJd?=
 =?us-ascii?Q?HcA6m4LAEfgCYU8NkOQDo/NXL42l4LNeo9tLZoFSGvLMazMRGLHdoZmmsap9?=
 =?us-ascii?Q?NFCtRnmyj/1VZB3ijCq91CLpeKuTA6AL9qCrCCwz7h4FcE2D32ZVBB6HYtoi?=
 =?us-ascii?Q?jWZStQTFmwryKSem7lntcIZut8ZidQaWYbC3TB5cd2pSkkjM5EY9Gl29n5jE?=
 =?us-ascii?Q?MiUjngRlSSCEACb0PWhNxlFpJTBoZIKvamRCDU6hGuRY+xAJb0auASjnEzA+?=
 =?us-ascii?Q?ZyVWJ/UiGzbVIVJiQf+HXWvuJcri86mW/QyyzoCtVDJmPFfXWviTqCAuoaMD?=
 =?us-ascii?Q?McjF1UBrtUgFLgSxq/V+PTU5WAlv/tiGmfSQhdfQR4+nT3X4ogWL6cbS1foh?=
 =?us-ascii?Q?Cd5oxmpwY6F9iu0GLrrDdSLsVaFqFm61HcIl5vDp+5u/+H7W69fCKirs+bbQ?=
 =?us-ascii?Q?fg09TL2thJtuYKV9mEz3ZYplOhATolsZmmEpbZlRbCsDgMYFoD4SH7rm1dOP?=
 =?us-ascii?Q?O3UR7AQNbcWQjkbz0cxgf1MYahJPEnluYJYK+3NGQpktOrk3po4bLm2NLoJ1?=
 =?us-ascii?Q?bf/puIgCZXiM+HWEwOv092smPH04V8pfLBFIqwVWJK9z6SfakCMJ6XMnF+3y?=
 =?us-ascii?Q?4cvmjrp92hmIMFcDQfnjegnXKHYMEe1rxVaH1HadxK0NydkYZA33/cdhbpxK?=
 =?us-ascii?Q?v1EydIHlNPL9n9ihKljiOp6H/0BuqEugtrkQSgZoFkVMIP62ex53m2cGQs6m?=
 =?us-ascii?Q?HO3WM0vQ4BFqcoR5Ucp9/5FD9QuAwdgp8G3hi9Wrc/AGDmU4H8bXo/cQfocV?=
 =?us-ascii?Q?APJf/0zKC0a28PnmWKmNfBiLr1S6Dl5YKqaUYu39ZGIbuC4vctiZO0u6zyI6?=
 =?us-ascii?Q?gqCDkXauFO7+8kTZ6y4t6hnP3nYo9KXWsZwuFYa84WXokTxNL7v75wsN+D09?=
 =?us-ascii?Q?1eu2hsdq0OD5cIxcDbmPy3rzI89xjzID+83Fvc3UjbBDOHtfImqJNdIZecnL?=
 =?us-ascii?Q?kTlx3SOzbpnTX09K8m8QHwRE9hTs56O8t/afEFiXEPOSUd8Id5OGA3GVfXFQ?=
 =?us-ascii?Q?8l7PIrVHIBuGAxWSc1nHi1mjS71KpCxdjsvVyJJ6oUjIofN3gTYlSjoRyILU?=
 =?us-ascii?Q?Rw=3D=3D?=
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a690bd9-aa3a-471e-ab4b-08db57537a82
X-MS-Exchange-CrossTenant-AuthSource: TY2PR06MB3424.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 03:53:45.5445
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e5IlzbKWIO83ZJQHJfpgSjx/vVnSlHTw1Fd7oiMTOsAISiOar+TQpA/UdoBi1nEwCPBjvbPQ4Ie4HURtbHpINY+ycnGQnKXZFEKQja1q1HI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5451
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Attempt to printk all bdev fstype as root gives the following kernel panic:

[    1.729006] VFS: Cannot open root device "vda" or unknown-block(253,0): error -19
[    1.730603] Please append a correct "root=" boot option; here are the available partitions:
[    1.732323] fd00          256000 vda
[    1.732329]  driver: virtio_blk
[    1.734194] Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(253,0)
[    1.734771] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.4.0-rc2+ #53
[    1.735194] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.10.2-1ubuntu1 04/01/2014
[    1.735772] Call Trace:
[    1.735950]  <TASK>
[    1.736113]  dump_stack_lvl+0x32/0x50
[    1.736367]  panic+0x108/0x310
[    1.736570]  mount_block_root+0x161/0x310
[    1.736849]  ? rdinit_setup+0x40/0x40
[    1.737088]  prepare_namespace+0x10c/0x180
[    1.737393]  kernel_init_freeable+0x354/0x450
[    1.737707]  ? rest_init+0xd0/0xd0
[    1.737945]  kernel_init+0x16/0x130
[    1.738196]  ret_from_fork+0x1f/0x30

QEMU command line:
"qemu-system-x86_64 -append root=/dev/vda rootfstype=ext4 ..."

This error is because ext4 is not buildin and request ext4 module fail.

As a hint, printk all the bdev fstype available for prompts.

Signed-off-by: Angus Chen <angus.chen@jaguarmicro.com>
---
 init/do_mounts.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/init/do_mounts.c b/init/do_mounts.c
index 811e94daf0a8..7fa48590c681 100644
--- a/init/do_mounts.c
+++ b/init/do_mounts.c
@@ -427,8 +427,19 @@ void __init mount_block_root(char *name, int flags)
 		printk("VFS: Cannot open root device \"%s\" or %s: error %d\n",
 				root_device_name, b, err);
 		printk("Please append a correct \"root=\" boot option; here are the available partitions:\n");
-
 		printk_all_partitions();
+
+		if (root_fs_names)
+			num_fs = list_bdev_fs_names(fs_names, PAGE_SIZE);
+		if (!num_fs)
+			pr_err("Can't find any bdev filesystem to be used for mount!\n");
+		else {
+			pr_err("List of all bdev filesystem:\n");
+			for (i = 0, p = fs_names; i < num_fs; i++, p += strlen(p)+1)
+				pr_err(" %s", p);
+			pr_err("\n");
+		}
+
 		panic("VFS: Unable to mount root fs on %s", b);
 	}
 	if (!(flags & SB_RDONLY)) {
-- 
2.25.1

