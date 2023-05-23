Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D43C970D916
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 11:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236069AbjEWJd2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 05:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235864AbjEWJdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 05:33:20 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ADB31BB
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 02:33:14 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D04A32288F;
        Tue, 23 May 2023 09:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1684834391; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=/lOsj+GiEHTCgI/sii2dYOxPg7fwJmqfZ38JOxtYg30=;
        b=MrAQpfWLUi8IpVF/ihwJRsY81cRa/l0ICrSmRAiXdf0bw6F/jxlB/xcG75ZZYbt+i/w+tE
        4U0Gak5572dT/I9Awv/hOLzFw0Pq3mou8ftOdQWICeKYkAqO0l9fBeMcsNdEZXzJLHGe1H
        /9W813DNmhVFkCQSRASut1VGW0HPlVg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1684834391;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=/lOsj+GiEHTCgI/sii2dYOxPg7fwJmqfZ38JOxtYg30=;
        b=hQaqF6vIDr8I6gzKDszU8Yir1ZU20woRIgODrQOtMrUjacCbU11TEWx1y9MWXcd1vReh3u
        VGSCYvIRftLAkxDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4EC7C13588;
        Tue, 23 May 2023 09:33:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id l0XoD1eIbGTMVwAAMHmgww
        (envelope-from <lhenriques@suse.de>); Tue, 23 May 2023 09:33:11 +0000
Received: from localhost (brahms.olymp [local])
        by brahms.olymp (OpenSMTPD) with ESMTPA id 906670e4;
        Tue, 23 May 2023 09:33:10 +0000 (UTC)
From:   =?UTF-8?q?Lu=C3=ADs=20Henriques?= <lhenriques@suse.de>
To:     Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Heming Zhao <heming.zhao@suse.com>
Cc:     ocfs2-devel@oss.oracle.com, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Lu=C3=ADs=20Henriques?= <lhenriques@suse.de>
Subject: [PATCH v2] ocfs2: fix use-after-free when unmounting read-only filesystem
Date:   Tue, 23 May 2023 10:33:10 +0100
Message-Id: <20230523093310.2628-1-lhenriques@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's trivial to trigger a use-after-free bug in the ocfs2 quotas code using
fstest generic/452.  After a read-only remount, quotas are suspended and
ocfs2_mem_dqinfo is freed through ->ocfs2_local_free_info().  When unmounting
the filesystem, an UAF access to the oinfo will eventually cause a crash.

BUG: KASAN: slab-use-after-free in timer_delete+0x54/0xc0
Read of size 8 at addr ffff8880389a8208 by task umount/669
...
Call Trace:
 <TASK>
 ...
 timer_delete+0x54/0xc0
 try_to_grab_pending+0x31/0x230
 __cancel_work_timer+0x6c/0x270
 ocfs2_disable_quotas.isra.0+0x3e/0xf0 [ocfs2]
 ocfs2_dismount_volume+0xdd/0x450 [ocfs2]
 generic_shutdown_super+0xaa/0x280
 kill_block_super+0x46/0x70
 deactivate_locked_super+0x4d/0xb0
 cleanup_mnt+0x135/0x1f0
 ...
 </TASK>

Allocated by task 632:
 kasan_save_stack+0x1c/0x40
 kasan_set_track+0x21/0x30
 __kasan_kmalloc+0x8b/0x90
 ocfs2_local_read_info+0xe3/0x9a0 [ocfs2]
 dquot_load_quota_sb+0x34b/0x680
 dquot_load_quota_inode+0xfe/0x1a0
 ocfs2_enable_quotas+0x190/0x2f0 [ocfs2]
 ocfs2_fill_super+0x14ef/0x2120 [ocfs2]
 mount_bdev+0x1be/0x200
 legacy_get_tree+0x6c/0xb0
 vfs_get_tree+0x3e/0x110
 path_mount+0xa90/0xe10
 __x64_sys_mount+0x16f/0x1a0
 do_syscall_64+0x43/0x90
 entry_SYSCALL_64_after_hwframe+0x72/0xdc

Freed by task 650:
 kasan_save_stack+0x1c/0x40
 kasan_set_track+0x21/0x30
 kasan_save_free_info+0x2a/0x50
 __kasan_slab_free+0xf9/0x150
 __kmem_cache_free+0x89/0x180
 ocfs2_local_free_info+0x2ba/0x3f0 [ocfs2]
 dquot_disable+0x35f/0xa70
 ocfs2_susp_quotas.isra.0+0x159/0x1a0 [ocfs2]
 ocfs2_remount+0x150/0x580 [ocfs2]
 reconfigure_super+0x1a5/0x3a0
 path_mount+0xc8a/0xe10
 __x64_sys_mount+0x16f/0x1a0
 do_syscall_64+0x43/0x90
 entry_SYSCALL_64_after_hwframe+0x72/0xdc

Cc: <stable@vger.kernel.org>
Signed-off-by: Luís Henriques <lhenriques@suse.de>
---
Changes since v1:
 - Fixed changelog to explicitly state 'read-only remount'
 - Added KASAN splat to changelog

 fs/ocfs2/super.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/ocfs2/super.c b/fs/ocfs2/super.c
index 0b0e6a132101..988d1c076861 100644
--- a/fs/ocfs2/super.c
+++ b/fs/ocfs2/super.c
@@ -952,8 +952,10 @@ static void ocfs2_disable_quotas(struct ocfs2_super *osb)
 	for (type = 0; type < OCFS2_MAXQUOTAS; type++) {
 		if (!sb_has_quota_loaded(sb, type))
 			continue;
-		oinfo = sb_dqinfo(sb, type)->dqi_priv;
-		cancel_delayed_work_sync(&oinfo->dqi_sync_work);
+		if (!sb_has_quota_suspended(sb, type)) {
+			oinfo = sb_dqinfo(sb, type)->dqi_priv;
+			cancel_delayed_work_sync(&oinfo->dqi_sync_work);
+		}
 		inode = igrab(sb->s_dquot.files[type]);
 		/* Turn off quotas. This will remove all dquot structures from
 		 * memory and so they will be automatically synced to global
