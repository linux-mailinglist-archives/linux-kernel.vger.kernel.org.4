Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24ADA60F628
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 13:26:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235231AbiJ0L0E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 07:26:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234874AbiJ0L0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 07:26:01 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CE12AE85F;
        Thu, 27 Oct 2022 04:25:59 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3A0F12251F;
        Thu, 27 Oct 2022 11:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1666869958; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=3p3rnTGQGMUuJC2g4FPdqKLLvoOr0ndD88Zj59SSr28=;
        b=kT2DqU9JTulQesICc/QKp3fKjxPZVkVcB+ZPC6sBW88mLE/mJD9VlxzS0R45ZnqFMOBzom
        ShITtwxXAw52zsve0yev+4jgwwVLZbVLiI2BtHxSbWiJUrp6M39+lfCmUcAtYfiOGj9w1I
        SsMvYJCrs+2DijDFnU6iCzR3KeXL0s4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1666869958;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=3p3rnTGQGMUuJC2g4FPdqKLLvoOr0ndD88Zj59SSr28=;
        b=sxK6FwoHx2Qv21Dz+SKevO2k3kB4Y25bR/vHM31SC+QRVLh3yfrWCXpayBrMKIwOvsMKXg
        cKuOehcu04dHTRCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BA57813357;
        Thu, 27 Oct 2022 11:25:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id kqV8KsVqWmNKIwAAMHmgww
        (envelope-from <lhenriques@suse.de>); Thu, 27 Oct 2022 11:25:57 +0000
Received: from localhost (brahms.olymp [local])
        by brahms.olymp (OpenSMTPD) with ESMTPA id d41acb50;
        Thu, 27 Oct 2022 11:26:56 +0000 (UTC)
From:   =?UTF-8?q?Lu=C3=ADs=20Henriques?= <lhenriques@suse.de>
To:     Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Lu=C3=ADs=20Henriques?= <lhenriques@suse.de>
Subject: [RFC PATCH] ceph: allow encrypting a directory while not having Ax caps
Date:   Thu, 27 Oct 2022 12:26:53 +0100
Message-Id: <20221027112653.12122-1-lhenriques@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a client doesn't have Fx caps on a directory, it will get errors while
trying encrypt it:

ceph: handle_cap_grant: cap grant attempt to change fscrypt_auth on non-I_NEW inode (old len 0 new len 48)
fscrypt (ceph, inode 1099511627812): Error -105 getting encryption context

A simple way to reproduce this is to use two clients:

    client1 # mkdir /mnt/mydir

    client2 # ls /mnt/mydir

    client1 # fscrypt encrypt /mnt/mydir
    client1 # echo hello > /mnt/mydir/world

This happens because, in __ceph_setattr(), we only initialize
ci->fscrypt_auth if we have Ax.  If we don't have, we'll need to do that
later, in handle_cap_grant().

Signed-off-by: Luís Henriques <lhenriques@suse.de>
---
Hi!

To be honest, I'm not really sure about the conditions in the 'if': shall
I bother checking it's really a dir and that it is empty?

Cheers,
--
Luís

 fs/ceph/caps.c | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index 443fce066d42..e33b5c276cf3 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -3511,9 +3511,29 @@ static void handle_cap_grant(struct inode *inode,
 		     from_kuid(&init_user_ns, inode->i_uid),
 		     from_kgid(&init_user_ns, inode->i_gid));
 #if IS_ENABLED(CONFIG_FS_ENCRYPTION)
-		if (ci->fscrypt_auth_len != extra_info->fscrypt_auth_len ||
-		    memcmp(ci->fscrypt_auth, extra_info->fscrypt_auth,
-			   ci->fscrypt_auth_len))
+		if ((ci->fscrypt_auth_len == 0) &&
+		    (extra_info->fscrypt_auth_len > 0) &&
+		    S_ISDIR(inode->i_mode) &&
+		    (ci->i_rsubdirs + ci->i_rfiles == 1)) {
+			/*
+			 * We'll get here when setting up an encrypted directory
+			 * but we don't have Fx in that directory, i.e. other
+			 * clients have accessed this directory too.
+			 */
+			ci->fscrypt_auth = kmemdup(extra_info->fscrypt_auth,
+						   extra_info->fscrypt_auth_len,
+						   GFP_KERNEL);
+			if (ci->fscrypt_auth) {
+				inode->i_flags |= S_ENCRYPTED;
+				ci->fscrypt_auth_len = extra_info->fscrypt_auth_len;
+			} else {
+				pr_err("Failed to alloc memory for %llx.%llx fscrypt_auth\n",
+					ceph_vinop(inode));
+			}
+			dout("ino %llx.%llx is now encrypted\n", ceph_vinop(inode));
+		} else if (ci->fscrypt_auth_len != extra_info->fscrypt_auth_len ||
+			   memcmp(ci->fscrypt_auth, extra_info->fscrypt_auth,
+				  ci->fscrypt_auth_len))
 			pr_warn_ratelimited("%s: cap grant attempt to change fscrypt_auth on non-I_NEW inode (old len %d new len %d)\n",
 				__func__, ci->fscrypt_auth_len, extra_info->fscrypt_auth_len);
 #endif
