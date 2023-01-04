Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 517D365D149
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 12:22:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238938AbjADLWX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 06:22:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234599AbjADLWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 06:22:19 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2115.outbound.protection.outlook.com [40.107.255.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 888991B1CB
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 03:22:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZmX4pPpAjnJYPoiApretbi1LvnwCAaw6PGzZ5kOEfXhDa0yrzSWxdTjVVzPJ5LpKN4utOfOTrRg5RxYE2xz0ERg5GwXtTqxRZP2hTncaVRVqUWVw3A5wP/Hq7uwoT8ZxHy97pcmgUj1n4HRtyNjse12hthsJ29AeU0CfBDa/or2yo3F8IN4ZY67DVpRMRDtpeZ0Rgw5giHeLBHSGkRyJ9wM8EbKH2yeiye535cNMd/JTESLOgh62YObSo2I2XHWl9np0590pZqLSYcwzF2bYMmQQPzvPvzR3kTaW+o4ziJxGkNF5ZdOatDqTiL0sGmE4rgzY5Exz/ZDF4HJXrZlUnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=71nsvQsvnmS4DY1mivaFbSp5zykYRpJPABqQ4hhf7Q0=;
 b=XQ4E7w+yLafwZO2S/P2h3VCf+woror0Bfvy30JcVhdfZcK6YunL+gDZpCLmZ7kDx/xmi2u2zWkLGh399zNqg3HTZhMd3xLAYEPeVKsDL1RoR+3iyNWtVRkxpkOCPZC2wiJ7JOcEp/M/B36XH7jExvh1AnqJw45c+4F9Fd1w5SIhT08y+SKom1gbGQmtSRIGEexBFb0SEaGUlpHIUCqAB4RkMJMMfF/7g+WzieII/I3oHgh0uFFP737Oyi7/m6T+oyoTDz60kl4klq0JdBA7UJKTK+8aDs8Fr0wcLOdGDFyGuw+I317bV2fW799Gw1ZwXQleLoZIoeXKZ3GCR3//jWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=71nsvQsvnmS4DY1mivaFbSp5zykYRpJPABqQ4hhf7Q0=;
 b=mieebBRtYzM7lZeTb9iKiPEothINfnz1ydPW8mn/YJjZ5A0gZ46ndXHvk6HrhQOKYKGH/PrIMmvE5IUGk4kl2WeSQHan6d3HHpcJxR1fR3RzkvO1v7UVOSZbsmMVahISgFCRJszEggnbIO8Ukqv7fZrbwL/hMbqNVjdtm/o0sHGq3up9/hbFQvOGq3lOn02kWSfhMarRCkAq+oWTkUP6cooW5oRAWD1Uh3LIorKmRJoJ75fCkLrv4ravH5HGEvGCVvBAUh1uP9X/qOcTlxv4/vlp7EFt6ZLfkIEkSlAf2sP0p4C8x2cmCyIAVB2igyLiwYv1sd4KLZ1i3v95Cr6olg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYZPR06MB5844.apcprd06.prod.outlook.com (2603:1096:400:284::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Wed, 4 Jan
 2023 11:22:15 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::7969:5a45:8509:7d80]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::7969:5a45:8509:7d80%4]) with mapi id 15.20.5944.019; Wed, 4 Jan 2023
 11:22:15 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Yangtao Li <frank.li@vivo.com>
Subject: [PATCH 1/4] f2fs: reset iostat_count in f2fs_reset_iostat()
Date:   Wed,  4 Jan 2023 19:21:55 +0800
Message-Id: <20230104112158.15844-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0002.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::16) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TYZPR06MB5844:EE_
X-MS-Office365-Filtering-Correlation-Id: 81279f4c-cbf7-455b-b6c6-08daee45ee5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SzRPpLJfn35lmAH+wsiT8w8kvZGb3TgVaw6z3V0h9lKROKdAmZaGVFLRfIgGMRjvs70AiIgLKi0ij9dN/4aRZ0MJPDD4NoSz0G17JU7xET36ErA1iLe+/u7HWGtkvJ2z7qBql5XAbPuPeSEUxikl4+0HOoZ1rGclzRVbMOB1RD/GKQxbS+CUy/ABQk81Q1v2RTuDR6qRf/VYYy28h45fXO/OwEG4Txx/kb9pRedh9MPIPOjNk/WlQWWrb7US1lcndAn00zBgV+1aprnk/Qi/B6FNnqlGop6HqPn3bgjNkmhgIfLZDG9UX544RIjR4l7hQLyhBjgaj+UNuid4ytOFpOOpPiJ+QViSDXRpSu7Zgtaosu9PDSv/2XtQyTl5baRrmyc6aZHcbYv9I7qxynglbMgkesmAZXeUZg/nlNZKmUwmnewfWBAg0Lvzsg6+hDuFZ2naIlmLV6iOaM75jD4+7nVY1/aQqDycvH2k75v91g5RRn+8DsFxFv+E83BL+zCP9K7NbOudImmDXmDyxbHOhFmFk2eLlKE0t/l0T63WmtEYkIZXbnRr/4W5AOWZ+jNdhUApaUzcxCINR27gNmemWcAtv70tBee7FA1eUkgJTmi68eTY+K+pbcWp3IA2STrC4nzfDbM9ePupdl+WM5iPfw2tteN8+5RkygKzEg2a0SeOs0pSt0FrzUDPVZGy2V0K
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(366004)(39860400002)(396003)(136003)(451199015)(2616005)(1076003)(83380400001)(186003)(26005)(6512007)(86362001)(36756003)(38100700002)(38350700002)(2906002)(5660300002)(316002)(8676002)(66556008)(66476007)(66946007)(4326008)(4744005)(8936002)(107886003)(6666004)(41300700001)(6506007)(478600001)(52116002)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rMy43p+ufMFGmGeBcoOrg6vbIJBdAKLQ7dDmu1LwZ3FXCWta5nrygEB0wTjO?=
 =?us-ascii?Q?CGNq8fHFrxeCMq+JGKxqmvmMVNP3yo7Ib/v8bkwR0RPQ5sfvvMk7Qgyb8H5r?=
 =?us-ascii?Q?pL/oS2hA6ptd82x3JkYXZwin6dAuBotGTMtlFu6wITwJoTj1v1W8Jh+m013U?=
 =?us-ascii?Q?klmzkTXCCeFEKL4uPMndEGSSoaNcSS0rFEyUgs0MNDciJ0yWqwYcSS/pbmWy?=
 =?us-ascii?Q?O9Onk9eUSKyH+KedShl3pFF2oxq4I6OpREN83YLviyeh9/yEdXPEaehnN2Qx?=
 =?us-ascii?Q?4tEl8+8A+1tf278Uh8cR9L0jG+MLD/BWDvSFdLuh0t2a2hg/RKVa6+GzMfld?=
 =?us-ascii?Q?JhB71nMCoq6iJFRhkqxnQsiEMm3c8jHJex6EB1PZpeyzrhKM0/R6mO8Dcb0f?=
 =?us-ascii?Q?zhvoKbNQTZeDUmwfuQsoUtTYNPp4tqgu0U7CCmoDGnWoNz+Gr9kPdbqrYb5i?=
 =?us-ascii?Q?9gtJr4MOBVlJt30c3FMLK0hibqFOeHbl5cEBrO14G5mnFcuTDm07VTJwS9lH?=
 =?us-ascii?Q?Ry2GlkdEtAr7hAq+3nZKIqmLvGIIpuBx3QdGPT7Zjju1iHZfD4RioNus0T90?=
 =?us-ascii?Q?FPXSTZy6bRxWXGk5jZtNfY80m2SQjl9zIFSAohG80lYfoTUVGd44ZUBp8h83?=
 =?us-ascii?Q?1wZNpZR1mFXWuPx1c0sixHb9wSP3uw5AnTgeMijYEL2ZCoSnSxE1bajBKLgr?=
 =?us-ascii?Q?CbomkzzDiolXv0qwQMPoMQ0MUVj7IQzg01f1KQ4RWYzaAmYv32Qb5l/5X+ge?=
 =?us-ascii?Q?GIzA5bGZfBUQ/1eZb7El5SVO14HZ8lwYrtoH2wR8m8kxOlSb7+2i+z/7SR1P?=
 =?us-ascii?Q?J2KC6A/SGs9IVR5kpt2IYL0m8LNC/798adSyTV0jI5jmLcBxadcu0JQgG0KQ?=
 =?us-ascii?Q?QdmJs2/cfBAs4kCMBxVVnavEOL5Nt7ndxWN/YRd2MA3hbR9n8iUPuxstjwCp?=
 =?us-ascii?Q?cdDn7SAtYkf1Ysq9KAIg//tujIRqHkrhG/EZCm5SPTx0n5mXfiIh7Niv7Anf?=
 =?us-ascii?Q?VXnop9QGf47JYwmh4pcI6AbDOtD8TfwkejJVMZUoVm9vlve3hULPqNw9YNR5?=
 =?us-ascii?Q?SjPs9C78XClSuOWbw/NfTYpc4qc3zCcXfh5+h7OeZi/gdAxLFiVnyy5xTpP9?=
 =?us-ascii?Q?yB9R37NE77BREZ0fV9flxXQB/DSaYDfdD2UrBaYyIDy9OFLQzSEUvfY5X5GF?=
 =?us-ascii?Q?EjYwrGsmKhNnVrSVtwFU8OZ2nSGP80qO7cYKOf/lExa+xSvOo8KO0jV5UT3x?=
 =?us-ascii?Q?3gGajA3fYYwfpyQ0lKNRsXGixRxOKt4GfPFefQVqtxWydSmHBhklpvoBDcyE?=
 =?us-ascii?Q?Z4VXOqqG/tU7Dg80t7cND6pOctzCnYc2XHUCscbNQ96DhNOthtZF/FUDYQU2?=
 =?us-ascii?Q?pfA/Pbgrnne0PGnq2q6cI5A9NwwM5ZQB/M5sIt+MTjPVGb0t53ATaXxKztUK?=
 =?us-ascii?Q?DrBBoxiKh1GZvphzjtLI23d7J2VJ5Eg9joD+fINKUkFhaO0ZV5B8s1h+3qZd?=
 =?us-ascii?Q?leimDLOrSq9qFMJdPCCdreN7LFH47c2tVeO7XUpgfOLkv76ttNctoklQTtYx?=
 =?us-ascii?Q?rBICygEbq5SqWgVzL5JqdvmkN1wA6bnw0zamd+KX?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81279f4c-cbf7-455b-b6c6-08daee45ee5a
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2023 11:22:14.8405
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eMQWu53Ux8Cyomj2AyKD7iTIlmrUq4Rqo4igYx+D2JaYge3Q4JGh9Nx3STPHsFqHFXTEkB+bHRE15UqOlLS42Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5844
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 8754b465c249 ("f2fs: support accounting iostat count and avg_bytes")
forgot to reset iostat count in f2fs_reset_iostat(), let's fix it.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/f2fs/iostat.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/f2fs/iostat.c b/fs/f2fs/iostat.c
index c53b62a7ca71..8460989e9bab 100644
--- a/fs/f2fs/iostat.c
+++ b/fs/f2fs/iostat.c
@@ -220,6 +220,7 @@ void f2fs_reset_iostat(struct f2fs_sb_info *sbi)
 
 	spin_lock_irq(&sbi->iostat_lock);
 	for (i = 0; i < NR_IO_TYPE; i++) {
+		sbi->iostat_count[i] = 0;
 		sbi->rw_iostat[i] = 0;
 		sbi->prev_rw_iostat[i] = 0;
 	}
-- 
2.25.1

