Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 691A8607B6A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 17:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231277AbiJUPmp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 11:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231294AbiJUPm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 11:42:27 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2114.outbound.protection.outlook.com [40.107.255.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B39A04D27F
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 08:42:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z0g2mhDDNBq7IzSoulfI3sgMqXs8NXzZCS11KzsY9zKl6fl3wax5N3G0MEA0tmAbDHjp/QqfkXlbdP1ANy4JMUcevYssysiFryZVioOzvaWWL/Scw50BRWG7j9/kqYz2eWDS65m52tjwdauQXq24jPz+ZmDa4saqO92pFCoeSmoQAqhkhCT/+Ub8pMhE7ZN98RDSr+caIpICA1/b/OEn85T9Q6Md+zU3KKCVlfaVwwxtHAGfH9e5OgmkvHT7+3+VScNHp87pZblVei/JLfgt/WOiXVt6+NibXSjP+ZOnVsK8TYJpaOWKj7qA5pBb9ghc0VDmGuwEPxy8B7ejHy4jaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NExT4FRkyZFUrxhZxtNCHOqS0EYUzyU7WXYao/CG5tY=;
 b=Sx5LN7QKB8LcumrEq9dnyBFZ6k0EEXR9ImmQQV9elNT0jh/51sQbaVQjsdK+c7Bb1LQCToB+3gMTw1kbvY3tZKejVBug/XlFkfSBNTxpJumwN5nNOooVSTshv0SHe5s2lliz2zo3tqZn/n5GS4MSAOsRcWBzdSoYdeKLhsrS6BFJ6OFqM7vqUPRmhuGvEiSm7Io/KyEkkSTfDMo6ZdP6wncU1CG8hllWuZoMiRbxP993dRqDpLLZH45873WOI54qTuJgVWqx1aO/4L5WwOMttcHnODz9YX0b/r17BUTOINJMvqxcxozxtfIpDZ53RijchXOxUDDuJGORIalwz+jv6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NExT4FRkyZFUrxhZxtNCHOqS0EYUzyU7WXYao/CG5tY=;
 b=h3bheJ8O46av3eTi09NvVm6kW5YS8qnHMhnC0N1B5CDWuw3k0sBw517savtmKD9ITVwueWnFqrKL2a8ltqS1mYG/6Tua/EGrSPmdASkQ9hWxYY4A/PPx5lwtKe+c53slCOtzma957ja+tv5mHLMwULFoPH5/3vQCKazoNdTDcyMD9zBetyos6D1UA+j1KR4l77y3d3TeGzwTA/vygSUG48fsv2XwYW9vUEqHHA6FidXjKcLHS2coPWcdTMN3ohHSldbCfzU846zf+HS41eMgYPmq7o/AT9OK4K8UG7aKJfE//35ZGi9ejUH6Kvio0QPNfAhYVI/MF1yarEyVRzbh0w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEYPR06MB6035.apcprd06.prod.outlook.com (2603:1096:101:d9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34; Fri, 21 Oct
 2022 15:38:39 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::c84b:5a6c:d66f:c0fd]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::c84b:5a6c:d66f:c0fd%3]) with mapi id 15.20.5723.034; Fri, 21 Oct 2022
 15:38:39 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Yangtao Li <frank.li@vivo.com>
Subject: [PATCH 2/2] f2fs: remove batched_trim_sections node
Date:   Fri, 21 Oct 2022 23:38:25 +0800
Message-Id: <20221021153825.79614-2-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221021153825.79614-1-frank.li@vivo.com>
References: <20221021153825.79614-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0006.apcprd02.prod.outlook.com
 (2603:1096:3:17::18) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SEYPR06MB6035:EE_
X-MS-Office365-Filtering-Correlation-Id: be9bda02-b75a-4d61-82f2-08dab37a53af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8XVLlaKityQdEo5PXLw7W8/KYJIP3id1F+MeCCh6mS0HbwKh+ONCBJ4v1Tmfwgy3mDm1ZpH071ZfsAsNlZh2C0t2M+BopGJQPycQlVFxAhCFyJTp4R6NT6IS10P17F75Jy5phomEG/+3dVkzTIUoAX+i5TnIxLD0CE+XH8oQNH6juR5omLN/y2+70oiee2WNO9rUDb/kthTBPIjHu49zB/0068IYIHyih1I36q0N/x/mCy4bQiAtiX88bQfpJsbXKUElknwqBhzAcaC+hiYP+AdvN8k/lA5bSfsJPMKw6mDrSxHhqm+OZz6NofmrJwWrDJnpTNu+ONors0XZrJyg++WFnAlUpXH/BGRl2cnuX3UIbdYOe3a2do+JXpZJPKeUwvPAGOL08exB9DAQ46W7tqu3eaM3a6vDJHJ9zFXCfbHNCSwlw81O2ukqP0rKQN8qhR/poKbxdFfrXyLV6twOLXapyb+e/ctvVRGK55QYcdXsGR3mFYSNv7uKr+xOOBw8lx7yUuHHh9dUGyCmMpTNU+sZYXPxygZEDQIErlfqo5U+grIlY0b7Ht8ofAFLQYVOng69+nVO9ioNrHCfd2s+9fMoBwSXPI6Jk65jaY3V0DguWOd6m5bPAII79Q2nnOJgVWPVsSZAGN1xjDFF1/73D5DZTzjc2EzvOX1FV6ckHGf+Dhqb7Se6epdTo8wAm9nklrEGG5tkaJSvkZTGQoLsWIKYAWP8fdV8dDuaxj7yE5E9kDG7Mj/Sj5CwHTtsdbPmeAV7HhIx20VFDtd89wfPMA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(376002)(136003)(346002)(39860400002)(396003)(451199015)(26005)(2906002)(6512007)(8936002)(6506007)(1076003)(36756003)(38350700002)(2616005)(83380400001)(38100700002)(5660300002)(41300700001)(186003)(478600001)(6486002)(316002)(6666004)(107886003)(52116002)(66946007)(66556008)(66476007)(8676002)(86362001)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gqCjYoy/zu8y1U7AgYXMHJNt67nZnudb4RpAPKf4UHJVHE+2AbPNwVOKVPUL?=
 =?us-ascii?Q?whDhhMta2JyfFrdcclNgS+Rgys9gV/MZBDh5cKw7lqUOjiUpwRs3wMDWUMYc?=
 =?us-ascii?Q?XouQgzk3FtOujriDn8uZBwO6Rc3y5gdFnuD8+/wraw+FfvPgTR31QAIDtkvM?=
 =?us-ascii?Q?UKKQ8ZKnzJnr++DOZ539mjLg2WBdXHIB2JuGERf5iLpoDzTUHYBjjMaE65yQ?=
 =?us-ascii?Q?f9E0sqB2BZabg7xCejEKyx13vshDVQEjP07dsrTIVEEQPSd9lhOkYUVCNc+b?=
 =?us-ascii?Q?tiPS+C7BO3dwmUgDJVAkielji3mUPJgHvjhEaiVF2++kaPMJKSTXtSJyU5ic?=
 =?us-ascii?Q?filfAjAzeeSJai3+ZAYcKCxIaUPD3y7hz7MbHVSN9GSk01EDgfOiGVNIZeEA?=
 =?us-ascii?Q?1X8ExeVWpiOS87CIKzKVfk+20OrBu+oMt/1i73vK0e4ynoyERl+z5x/7IAhL?=
 =?us-ascii?Q?Bd39mdiT444Yg03NYJ9tH2BxuKUAIBQy7fh+gFmbDpjJBN+ZBTFA9KZq+Mdc?=
 =?us-ascii?Q?GGqvIgMkCDKgj84oiK9jTGfDlagIxtiIkdgABSjXrR1nBPrg6vhhLmlRiI9A?=
 =?us-ascii?Q?zzthe5SLELRrSGQdDbDGPJNeK2sgL7b7EFhFd5lm5NmOkUyrulZZXaQNjful?=
 =?us-ascii?Q?gvfGEwIbw04Ix3OKqhJBSTEYIEH1BgzyZ3d/Wp46wBUA7mA79lG5NHN0GYB+?=
 =?us-ascii?Q?pYTGgQzs+L82etNFL90gvXQDEFgChuQphPMffYs96tSgvjDpm1Qz6ki39eqq?=
 =?us-ascii?Q?q650irK30foD4bPl/vvn15FwB+Lt59jfHkxTteAdbFsZFN8T2WmUkjnXFy8u?=
 =?us-ascii?Q?Im6JdMwitNOIxUXWvSxMbqUDbAxRo0VD0JSg8BVpY12QdLNjZsFYjE9rsxNw?=
 =?us-ascii?Q?ttootoXGTnI696GFgZrH3pXWniMc/xegGpvPkyxvqbCAnpm3ylvJEmCPfnFU?=
 =?us-ascii?Q?L1ExUgSa8qphux9Aoe36JLzFbv4i5seaWqlMhxNv5Or9kEQ1OhtoYbQm36Zr?=
 =?us-ascii?Q?8gLZqGI85BfucjA8u4MmS7gev/4f7pEULyMt/7jrdocvYZ9T2fTgH8iRn4M9?=
 =?us-ascii?Q?zdUE/CrmC0V11pxkHg8cgjI15lQjW+vbNfHt0YmHsubImW0mTuTeSjCXqPF4?=
 =?us-ascii?Q?PHpSKiA1wzyzc6jREa0icFUHbsFfYTIjqIT//ophSI0/9gUr+x09oOx9WfI+?=
 =?us-ascii?Q?w8M8up+X5wYlCJTTtGSM8ubMhJjV8e7UiMIZ2OkVSqL/r8g2fI7pKcDcjiik?=
 =?us-ascii?Q?taM4X1o+FYcAk4MyCbT4OVTlfpDSqWSrAx0LWEXvf++TD99c5m/5UJom2tQg?=
 =?us-ascii?Q?+def8joh0oS15WL6A2xMlgEEEfdTyXc+kJrNyv9Q7vp9Lu7+GdZxunDVMrZx?=
 =?us-ascii?Q?M48lgyxYTzvSgoh5J8HenFZau9qWmIEOLrJ5V3yNyyiLiJqI/QUjVV0lxLpf?=
 =?us-ascii?Q?xJ0N/ioTBaWIwhUkkHRSGTEUkLxjCl1DkAkzItyGjnVZpIV4C56b1ZsOz4qD?=
 =?us-ascii?Q?55ho+Imwxx7QFopbxSrF63XRh3/YaiqIZBzAzradtQBYFjaItGgPW9WSYzf3?=
 =?us-ascii?Q?MfOZN8CYy1o+L4i9wi847ONbyYMZqsSoBEsauNCa?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be9bda02-b75a-4d61-82f2-08dab37a53af
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2022 15:38:39.8520
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: snBhESYUWPRWqqHKKLKNQBgLA4pjG98ezrBg+ppQ/O1zftWWRCIoRBrzohu70ekHtI1o0hheegpLt2Gs5cfWqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6035
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This testing sysfs node has been deprecated for a long time,
let's remove it.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/f2fs/f2fs.h  | 3 ---
 fs/f2fs/sysfs.c | 5 -----
 2 files changed, 8 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index e6355a5683b7..9c480835adab 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1062,9 +1062,6 @@ struct f2fs_sm_info {
 	/* a threshold to reclaim prefree segments */
 	unsigned int rec_prefree_segments;
 
-	/* for batched trimming */
-	unsigned int trim_sections;		/* # of sections to trim */
-
 	struct list_head sit_entry_set;	/* sit entry set list */
 
 	unsigned int ipu_policy;	/* in-place-update policy */
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 3005e2783a25..926b7a844362 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -488,9 +488,6 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
 			return -EINVAL;
 	}
 
-	if (!strcmp(a->attr.name, "batched_trim_sections"))
-		return -EINVAL;
-
 	if (!strcmp(a->attr.name, "gc_urgent")) {
 		if (t == 0) {
 			sbi->gc_mode = GC_NORMAL;
@@ -790,7 +787,6 @@ F2FS_RW_ATTR(DCC_INFO, discard_cmd_control, mid_discard_issue_time, mid_discard_
 F2FS_RW_ATTR(DCC_INFO, discard_cmd_control, max_discard_issue_time, max_discard_issue_time);
 F2FS_RW_ATTR(DCC_INFO, discard_cmd_control, discard_granularity, discard_granularity);
 F2FS_RW_ATTR(RESERVED_BLOCKS, f2fs_sb_info, reserved_blocks, reserved_blocks);
-F2FS_RW_ATTR(SM_INFO, f2fs_sm_info, batched_trim_sections, trim_sections);
 F2FS_RW_ATTR(SM_INFO, f2fs_sm_info, ipu_policy, ipu_policy);
 F2FS_RW_ATTR(SM_INFO, f2fs_sm_info, min_ipu_util, min_ipu_util);
 F2FS_RW_ATTR(SM_INFO, f2fs_sm_info, min_fsync_blocks, min_fsync_blocks);
@@ -919,7 +915,6 @@ static struct attribute *f2fs_attrs[] = {
 	ATTR_LIST(max_discard_issue_time),
 	ATTR_LIST(discard_granularity),
 	ATTR_LIST(pending_discard),
-	ATTR_LIST(batched_trim_sections),
 	ATTR_LIST(ipu_policy),
 	ATTR_LIST(min_ipu_util),
 	ATTR_LIST(min_fsync_blocks),
-- 
2.25.1

