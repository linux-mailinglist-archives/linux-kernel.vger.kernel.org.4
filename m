Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E3126D3422
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 23:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbjDAVvh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 17:51:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjDAVvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 17:51:35 -0400
X-Greylist: delayed 534 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 01 Apr 2023 14:51:32 PDT
Received: from valentin-vidic.from.hr (valentin-vidic.from.hr [IPv6:2001:470:1f0b:3b7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E9021E73D;
        Sat,  1 Apr 2023 14:51:31 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at valentin-vidic.from.hr
Received: by valentin-vidic.from.hr (Postfix, from userid 1000)
        id 0877329434; Sat,  1 Apr 2023 23:42:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=valentin-vidic.from.hr; s=2020; t=1680385342;
        bh=p0z/ZJqhKUHoyak5dnyx8/dbEjE39Lo91Du95hLyoCA=;
        h=From:To:Cc:Subject:Date:From;
        b=D8DrBlTWXxx/fzhpOfHWF3y8cbHGIrgZjr0t0NqkgbYYXgqMTHiJY9eD1KlWO6E9L
         NDSXetZq9gDTNyWphtgBJExdBHTnVk5Vpl4N/uUVOcWlCLhknZ8+vFti5RJh+79ZJo
         kFxPx/sqjjx4yImoJdJIsneZqb+pLRzPsjRdkkOlUmGnJKVi4kRn4k0qIN1+EliH/1
         CwMXTBzSu8Hb9/LuZwXfjO5WfaE3FZ1DDpK6OamJsdysBbTcKG4tc6T8i/TmBtYNcN
         0lkhDUGYPiVO9Y9but8frXxs8D+Pe9K1KUEM/y0kMRVfy2EeONQQCehS7yWRiOCgap
         1hhc9kA2WNHa4u5NB05hfb4Ps1rYMfa2BwsooE7iErCSJmZUecvQYK29lli14dLSc6
         ONixSX2QxSrHtSztExxiML6r9W+xq5ce1tXsz6/HVAPRWZ4XjiyTpV/HFY1dAAYDi2
         YCZ+W4RSIOM0wkVH3KLh/shfPVw/ks/cc3s+Zr5d+YtAcf9W1FB2aX4MNodqO+6QU5
         52V/kkkRgkXgp/L3qnlCYJhawTwtHcK3LtzgsjUgo0Vy53a+ujdxQU2E8XzCfYAPwy
         IZcV9DgQBA5cjTy8wDb8OFfRxYH3whjwdKSOp8V2a0YZQQy2wticHXOO9w/4vx2F4V
         dU5/FRNHuqB5a6acD2T9Z/3Q=
From:   Valentin Vidic <vvidic@valentin-vidic.from.hr>
To:     Paul Moore <paul@paul-moore.com>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Christian Brauner <brauner@kernel.org>,
        Dave Chinner <dchinner@redhat.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>,
        Micah Morton <mortonm@chromium.org>,
        =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Valentin Vidic <vvidic@valentin-vidic.from.hr>,
        =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Vivek Goyal <vgoyal@redhat.com>
Subject: [PATCH] security, lsm: security_old_inode_init_security() Handle multi LSM registration
Date:   Sat,  1 Apr 2023 23:41:51 +0200
Message-Id: <20230401214151.1243189-1-vvidic@valentin-vidic.from.hr>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Copying files to an ocfs2 filesystem causes a crash with NULL pointer
dereference in strlen.

[   27.386786] BUG: kernel NULL pointer dereference, address: 0000000000000000
[   27.386818] #PF: supervisor read access in kernel mode
[   27.386832] #PF: error_code(0x0000) - not-present page
[   27.386844] PGD 0 P4D 0=20
[   27.386855] Oops: 0000 [#1] PREEMPT SMP PTI
[   27.386867] CPU: 0 PID: 1792 Comm: cp Not tainted 6.1.0-5-amd64 #1  Debian 6.1.12-1
[   27.386887] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
[   27.386904] RIP: 0010:strlen+0x0/0x20
[   27.386928] Code: b6 07 38 d0 74 14 48 83 c7 01 84 c0 74 05 48 39 f7 75 ec 31 c0 c3 cc cc cc cc 48 89 f8 c3 cc cc cc cc 0f 1f 84 00 00 00 00 00 <80> 3f 00 74 14 48 89 f8 48 83 c0 01 80 38 00 75 f7 48 29 f8 c3 cc
[   27.386966] RSP: 0018:ffffa33340e4fbc0 EFLAGS: 00010202
[   27.386980] RAX: ffff8b578c3b1800 RBX: 0000000000000001 RCX: 0000000000000000
[   27.386996] RDX: 0000000000000100 RSI: ffff8b57843d86e8 RDI: 0000000000000000
[   27.387012] RBP: ffff8b57849ca608 R08: ffffa33340e4fc7c R09: ffffa33340e4fc84
[   27.387027] R10: ffff8b578f1e6000 R11: ffffa33340e4fc80 R12: ffffa33340e4fcb8
[   27.387043] R13: ffffa33340e4fc84 R14: 00000000000041c0 R15: ffffa33340e4fc7c
[   27.387059] FS:  00007f7b36d50500(0000) GS:ffff8b57bec00000(0000) knlGS:0000000000000000
[   27.387077] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   27.387091] CR2: 0000000000000000 CR3: 000000003cfe2003 CR4: 0000000000370ef0
[   27.387111] Call Trace:
[   27.387130]  <TASK>
[   27.387141]  ocfs2_calc_xattr_init+0x7d/0x330 [ocfs2]
[   27.387382]  ocfs2_mknod+0x471/0x1020 [ocfs2]
[   27.387471]  ? preempt_count_add+0x6a/0xa0
[   27.387487]  ? _raw_spin_lock+0x13/0x40
[   27.387506]  ocfs2_mkdir+0x44/0x130 [ocfs2]
[   27.387583]  ? security_inode_mkdir+0x3e/0x70
[   27.387598]  vfs_mkdir+0x9c/0x140
[   27.387617]  do_mkdirat+0x142/0x170
[   27.387631]  __x64_sys_mkdirat+0x47/0x80
[   27.387643]  do_syscall_64+0x58/0xc0
[   27.387659]  ? vfs_fstatat+0x5b/0x70
[   27.387671]  ? __do_sys_newfstatat+0x3f/0x80
[   27.387684]  ? fpregs_assert_state_consistent+0x22/0x50
[   27.387698]  ? exit_to_user_mode_prepare+0x3c/0x1c0
[   27.387712]  ? syscall_exit_to_user_mode+0x17/0x40
[   27.387726]  ? do_syscall_64+0x67/0xc0
[   27.387738]  ? exit_to_user_mode_prepare+0x3c/0x1c0
[   27.387752]  entry_SYSCALL_64_after_hwframe+0x63/0xcd

Similar to security_dentry_init_security fix in 7f5056b9e7b, the problem
is that ocfs2 checks the return code from security_old_inode_init_security
and if the return code is 0, it assumes everything is fine and continues
to call strlen(name), which crashes.

Typically SELinux LSM returns 0 and sets name to "security.selinux" and
it is not a problem. Or if SELinux is not compiled in or disabled, it
returns -EOPNOTSUP and ocfs2 deals with it.

However if BPF LSM is enabled, it registeres every hook and returns the
default return value, in this case 0.

This patch copies the behaviour of security_dentry_init_security() to
allow only one LSM to initialize security context (or return the default
value of -EOPNOTSUP).

Signed-off-by: Valentin Vidic <vvidic@valentin-vidic.from.hr>
---
 include/linux/lsm_hook_defs.h |  2 +-
 security/security.c           | 16 ++++++++++++++--
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 094b76dc7164..ea152b6da56b 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -111,7 +111,7 @@ LSM_HOOK(int, 0, path_notify, const struct path *path, u64 mask,
 	 unsigned int obj_type)
 LSM_HOOK(int, 0, inode_alloc_security, struct inode *inode)
 LSM_HOOK(void, LSM_RET_VOID, inode_free_security, struct inode *inode)
-LSM_HOOK(int, 0, inode_init_security, struct inode *inode,
+LSM_HOOK(int, -EOPNOTSUPP, inode_init_security, struct inode *inode,
 	 struct inode *dir, const struct qstr *qstr, const char **name,
 	 void **value, size_t *len)
 LSM_HOOK(int, 0, inode_init_security_anon, struct inode *inode,
diff --git a/security/security.c b/security/security.c
index cf6cc576736f..a25d84950a97 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1164,10 +1164,22 @@ int security_old_inode_init_security(struct inode *inode, struct inode *dir,
 				     const struct qstr *qstr, const char **name,
 				     void **value, size_t *len)
 {
+	struct security_hook_list *hp;
+	int rc;
+
 	if (unlikely(IS_PRIVATE(inode)))
 		return -EOPNOTSUPP;
-	return call_int_hook(inode_init_security, -EOPNOTSUPP, inode, dir,
-			     qstr, name, value, len);
+
+	/*
+	 * Only one module will provide a security context.
+	 */
+	hlist_for_each_entry(hp, &security_hook_heads.inode_init_security, list) {
+		rc = hp->hook.inode_init_security(inode, dir, qstr, name,
+						  value, len);
+		if (rc != LSM_RET_DEFAULT(inode_init_security))
+			return rc;
+	}
+	return LSM_RET_DEFAULT(inode_init_security);
 }
 EXPORT_SYMBOL(security_old_inode_init_security);
 
-- 
2.30.2

