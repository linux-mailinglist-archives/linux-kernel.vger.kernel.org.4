Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89A016C96C8
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 18:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232018AbjCZQVY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 12:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232693AbjCZQVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 12:21:12 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10olkn2036.outbound.protection.outlook.com [40.92.41.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F197A1
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 09:21:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VJ1Pe0snTT3l5GaA0qgl2nUfevsa6K/3JL/tS4sSNySoaJFQBHgRQ7WKCpNjpVIq9zOeafO7bgzG25Ccqsw5YewTEd87wZlxEyhiinJiPXaTDcfD0ShRomPuaJrwro448fpHQPjBmwycE5bfBIaJPpmNMoxo1L9RSfZ78I2Vo87ctHMzye7y4nDVUACLgOEXIhsPZCjxjOY4yiQhbcp5GFZAxa00kYD7u50K8jreA9LRk/tm1VrebQorqgW/KJxdlBESttJbzs3ABarO74VE/fEVL+sfgXogtxaq27/jUacaX3cfukmsHtADTNpXVdE0A5qKHiTJnCbGNYGJj7Jlkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pJncayPM773g6lEyOCy2FiaMNuDMyO0260X+wesolUY=;
 b=WzQZ3LokVL8s3u+aLYK1Kz3bKaraO7pRo448Ubkw7CQyjhbxGmoQseC0GH6MyZUo1l6gHYf1E3tt9ZB/YowiUk8E1ia1DuxF19NRmLcW3s+EUUmXdfm29uxMbJ+b3UlsrxA4LZwcee8laEZY1b71pwfLsFR5zXn7lsAKug+g/3vA8sJ4+aSkYhYLiiUcPqawKVKWrOVSaz5L5fu0Kv20Hfe2LGoHRC6oRc7gJ5jmTotLvAKB341e84jJj5Oq1Vm6TuJd2JnMIeD0dOZeWj6irHndCXyDMJHyXwG+Vmj/44H1mZF3taTTBer/e4Mb/aU+wFFPJPsZ7eO95hKohu+MYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pJncayPM773g6lEyOCy2FiaMNuDMyO0260X+wesolUY=;
 b=LTJylkmj1+jWxxf9j7aRV9JXtPQorb4+pV/Jr/F+8L6RBWvRO3tGpLpanTUgS4dscTv+0UGPSLezm/WA3ql/6RGotatNtYaSIajExQCnVFhawy43PaNg3iYb9uF4D28dKqKIaup4/HCxA9gA9KfAyWvu0RJcxpzDuJ9t/zZZ0XFQwi6og7ayNwTGND0Xcywl9BQp5PXYJ0AxO7X1YhB8kCerlizl+depeS4GYkJGmwIQLMnpNJwNBMdvoKWBrIY2c1hzeKsRUEPLpK+4hNYE9EfeWyXvbKuOx0VvyRPIyasgmC4peDTG/EqCu3QpYbfl3zFGH7zo3oAsQH1lubPMvA==
Received: from CY4PR1801MB1910.namprd18.prod.outlook.com
 (2603:10b6:910:79::14) by BL1PR18MB4261.namprd18.prod.outlook.com
 (2603:10b6:208:308::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41; Sun, 26 Mar
 2023 16:21:09 +0000
Received: from CY4PR1801MB1910.namprd18.prod.outlook.com
 ([fe80::f14c:2cc1:ea8e:642a]) by CY4PR1801MB1910.namprd18.prod.outlook.com
 ([fe80::f14c:2cc1:ea8e:642a%7]) with mapi id 15.20.6178.041; Sun, 26 Mar 2023
 16:21:09 +0000
From:   mirimmad@outlook.com
Cc:     mirimmad@outlook.com, skhan@linuxfoundation.org,
        Immad Mir <mirimmad17@gmail.com>,
        syzbot+f1faa20eec55e0c8644c@syzkaller.appspotmail.com,
        Dave Kleikamp <shaggy@kernel.org>,
        jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH] FS: JFS: Fix null-ptr-deref Read in txBegin
Date:   Sun, 26 Mar 2023 21:50:30 +0530
Message-ID: <CY4PR1801MB1910F3DE3B29710C1D7A9226C68A9@CY4PR1801MB1910.namprd18.prod.outlook.com>
X-Mailer: git-send-email 2.40.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [o3pDGM7JWlZ2ADCdmNjQmzGyAEw7D2eHJac1pTODES7fOp/hMhHzF6pDPs9Gm6gN]
X-ClientProxiedBy: PN3PR01CA0116.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:96::6) To CY4PR1801MB1910.namprd18.prod.outlook.com
 (2603:10b6:910:79::14)
X-Microsoft-Original-Message-ID: <20230326162030.11605-1-mirimmad@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR1801MB1910:EE_|BL1PR18MB4261:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b970c0b-5035-4979-eb39-08db2e161b9d
X-MS-Exchange-SLBlob-MailProps: ZILSnhm0P3mq4FuOKlDrBXqb0NGdLOSyDSbCmXrRIeEL8lXtRJpgOUzHzx2bH021EHAWYTB7TYcKPTH0PlndwgLANeFvIe6TLFJoqNfhSSTAlnno1ytmRyWgKLA/8lXF/IhXqw7UnLNLQAO93hoAiiPVRgH0MWGM/uibGG+BQ3K2KaP8OXMo8Thr5iXXj+5O/gU4lxWQxKlStjb9ziQ4484LysJVgJ4WG3HZQuFxejGICORmiN0ZSo4vrwWufHjU3WUbttL1Az8GFMt5tojMoSaMKhO7L+POfxs2UqzR2qrYXK+JhUHo8boriXQEiZV1SDolJspvJoIqMRt7Ub+sqz1cmQLYUKybgkVoQ1pjmHo5T+l/9b4xMF+vEZJMTTzYI4XkCvnBRNANEt4nUE0tK5YOtZhMAAIuDG1XT6Xp4+CPmMgOPWkMDsTQ85FLTJCVqYA2RT5tKHhvAOBTNWiIS6GtyQYUCtu0iLewWyff8BsWYuP7kSq41EDlzJ3hd7PdVeFM6bQdMCEzNgrjTRjntwSWTRNfz5sMO1n4PNLQWf0bHCBc264LJfuIN3pkcNwJ8t1YyljaFllS7AiozItUYiTZEdf1I0mclDbGMKDYprNyPLk2pL3wr/9Nu6hQX3v/aHglZtm7WsHl1mmj9BBevQRVII9u5b20BhDNUkIP9X/qcjMoM6p7kzQKrKFxpkeE2CU4Kr2cPUy9FJNX84133vai9EHDse/DQ6405ngrCUulqbKUahSV9fjxeuvinxsWFzaXlXmrGEdiBF+cpqAJE8XovIOAQaSx
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NcTLud064CJCtx2f2C8nnMtTdwbZ37zGTXfWVLWz52nLDWiXBey3cMZw9ehFiVMUHMZd9uaQ4lKb2PfMH0DoIPpAudJ+Ax0Vza9j6QokPMZW33Ey8VB0ctwA97XRKzF7pYvlhnth5Y1w6IofJTKHouL2adfP1+nSRdWPNURK/cY5qZDiE9DBVmwsIXYMPiji8Qe2NbKfigMkm/8MR8Ij3o39JNonbJnKqIf8SQTf0B8TvZquK6AJ1j1gf8WogmiHPYT1JI4h0UmRVgrQ5iWtQdN0DooL6wck0caIzyLjN1YuFSZietQrhIxVOsn5sLFhyo6uYIFPCHKNyrg9OWZ9PiiyH2lfO8Nc6fQNcK2TcrMDVBNhkW8xIGBRgEyCkVIG8YtgDHrGF2FBvh/svCqJTrVc/m5L2DmNJ8wAQO0jRgJq0rkhlKcAlL1keHOZKbCYJasRfHdCXNkN8/ZIcHKVayl5CupGRlDvNL0Cb/6W3/ZPqljNrX2uTIIgqjKUpY1/jkAfz76Y/TSe+/1LGYrKobLUdSlNBQKrgVqBpFnobhRbVXFki3KbO8RPhnl3TMAQxnAMNCJwxBKh97OTNsofRbeoWmZmxxfSXJbUwIxcj4k=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9GhfN0MToIry7q6dWBNtmD2jdi7/mHRyMnmDPnTRdlPl3S+ptZvJkMII4lx6?=
 =?us-ascii?Q?yk9MUosdH0fo+cJPgeSZgMCOk0vE0lH5C5pnX4VoHM9QBerL1fDXpt/OxK4Q?=
 =?us-ascii?Q?UCqVm1S+sFVEc8d0dBoZLpfzg5GqFy8JgP2vQj4q9hjLoqJhsMhWpQnF3QVV?=
 =?us-ascii?Q?89ej/c9YBCLuyx9DYTKPOYCXBJcDPxRoWpHvsxPQacTwn3DVRD/od9fpP52I?=
 =?us-ascii?Q?S/JsUUFQiyVgAepKeTSN5a/wx+7W66D/VxoxNvaM3jsn/8xc0oFQeFOOSbd4?=
 =?us-ascii?Q?xgKNuOGUVdeyLRW3k6oCOvcaCPKs3CFqh/dR+G5t+vp+w51GauAL5Ozp8yeB?=
 =?us-ascii?Q?UhSPrLjdG1WAN9n7zxKcSbUubGEkxfT5hJokQ6iAn8AX9TKJAvH2AtmQ+GeW?=
 =?us-ascii?Q?udzXbOmtHe3nGT11K0UN2uTnzlLvuhcsuf3KbMxZ5L8SjCMo8uMRstUeUku6?=
 =?us-ascii?Q?A2JDUzEKXItAtsA20a1CGLqpFVSE5TjyWr87xRyuHCwLdkq0FZJMKAu81La7?=
 =?us-ascii?Q?9NXzs+d3+Gg4cpcYCcozHlRTQ1bjL/brO2Eh0dkaoPYrB5RxFJQm8zvgrlCN?=
 =?us-ascii?Q?M4L0Zmk3H8Qmz2NMXi3+GceXv8st6Ek/i+5Oxq9EhXyF5nbljt4gIxeaNpyV?=
 =?us-ascii?Q?8/kLKb/v7axTf3gbEI15K2mDWjfmwLH+3FuV0iCjb8NAr8602q51C64Cw2di?=
 =?us-ascii?Q?8sqWa2XcCejzaPx/gGHQphbbFFkairPvza4E8LcaWr2RxZRxxs6PC1Pgdgdr?=
 =?us-ascii?Q?hQsymUxQ/rgIP3EALNESsbnXupvAcI7tmv7BJhoQV9z7NplHmaMc1kOner5A?=
 =?us-ascii?Q?InqTP1xleey3P5rLGSq0bhYmycPdEk7AC69fIqfp4xiHGXhrOvgrSI4DyN7z?=
 =?us-ascii?Q?6wWtpBKp4i2V8hVrxrv9AU0nrYNwMN3EFVpKbvUkPvl5J7ULTueeyj6g/Clx?=
 =?us-ascii?Q?C5EUi4UmBDh/Gay+s4VGSHVa1ObTgey49tjJiJKgCOqKyYksCzRe+z0a8RFc?=
 =?us-ascii?Q?TmCFH6PncwNDGKasw48Rn62RhfAwmIibKQ9XIjpacLkBHdeytjkzovKwTJV+?=
 =?us-ascii?Q?Z8h0QxFZlDBsDp/YAPw3XKEY1TY8GcKYxlrYl8VY7tvAF4ESs1yK1a5Yl6D9?=
 =?us-ascii?Q?0SwrvR/7y3yJr8nAyK8ofjBySQbG/N2eiYEBZW6A+wW2tib7QFO9JF8IoPMm?=
 =?us-ascii?Q?/OwlYB2PlKk57EwSH9n+98d3eRTakbc7hFutRzTg4bLpC1UC8/3M2L1ueLmu?=
 =?us-ascii?Q?aQ2YmGIAZmxEBiu5du35zfr3t9eYrAvOIP2M/0o81A=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b970c0b-5035-4979-eb39-08db2e161b9d
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1801MB1910.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2023 16:21:09.2893
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR18MB4261
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Immad Mir <mirimmad17@gmail.com>

syzkaller reported the following issue:

BUG: KASAN: null-ptr-deref in instrument_atomic_read include/linux/instrumented.h:72 [inline]
BUG: KASAN: null-ptr-deref in _test_bit include/asm-generic/bitops/instrumented-non-atomic.h:141 [inline]
BUG: KASAN: null-ptr-deref in txBegin+0x131/0x6c0 fs/jfs/jfs_txnmgr.c:366
Read of size 8 at addr 0000000000000040 by task syz-executor.0/5098

CPU: 0 PID: 5098 Comm: syz-executor.0 Not tainted 6.3.0-rc3-syzkaller-00005-g7d31677bb7b1 #0
Hardware name: Google Compute Engine/Google Compute Engine, BIOS Google 03/02/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 print_report+0xe6/0x540 mm/kasan/report.c:433
 kasan_report+0x176/0x1b0 mm/kasan/report.c:536
 kasan_check_range+0x283/0x290 mm/kasan/generic.c:187
 instrument_atomic_read include/linux/instrumented.h:72 [inline]
 _test_bit include/asm-generic/bitops/instrumented-non-atomic.h:141 [inline]
 txBegin+0x131/0x6c0 fs/jfs/jfs_txnmgr.c:366
 jfs_link+0x1ac/0x5e0 fs/jfs/namei.c:802
 vfs_link+0x4ed/0x680 fs/namei.c:4522
 do_linkat+0x5cc/0x9e0 fs/namei.c:4593
 __do_sys_linkat fs/namei.c:4621 [inline]
 __se_sys_linkat fs/namei.c:4618 [inline]
 __x64_sys_linkat+0xdd/0xf0 fs/namei.c:4618
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

The issue can be resolved by checking whethere "log"
for a given superblock exists in the jfs_link function
before beginning a transaction.

Tested with syzbot.
Reported-by: syzbot+f1faa20eec55e0c8644c@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?id=be7e52c50c5182cc09a09ea6fc456446b2039de3

Signed-off-by: Immad Mir <mirimmad17@gmail.com>
---
 fs/jfs/namei.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/jfs/namei.c b/fs/jfs/namei.c
index b29d68b5e..cd43b68e2 100644
--- a/fs/jfs/namei.c
+++ b/fs/jfs/namei.c
@@ -799,6 +799,8 @@ static int jfs_link(struct dentry *old_dentry,
 	if (rc)
 		goto out;

+	if (!(JFS_SBI(ip->i_sb)->log))
+		goto out;
 	tid = txBegin(ip->i_sb, 0);

 	mutex_lock_nested(&JFS_IP(dir)->commit_mutex, COMMIT_MUTEX_PARENT);
--
2.40.0

