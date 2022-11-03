Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9626617EE1
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 15:05:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230520AbiKCOFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 10:05:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231134AbiKCOFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 10:05:49 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FCC212618;
        Thu,  3 Nov 2022 07:05:45 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B344B1F45F;
        Thu,  3 Nov 2022 14:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1667484344; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Fxpd7kxoSr8KWDfsjl//BZAba+zNFtzbzoF5WTUFBKE=;
        b=0FgPSi+DP3oQ7CgQ3OCCIhjphmWDt45Uyt4wN3v4IxYg7Jsfl8F2gbmjicvqTo+dqOQ7KK
        1SGZeRB7+mWMDqgPJhMOh+v+j+0YsAu5PLDpQtahdQnMiHsPW+3uqy3kIvNOkAa1ZIhQaE
        kOUeprt4dUxR73R4iydOyefBkx7HUFk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1667484344;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Fxpd7kxoSr8KWDfsjl//BZAba+zNFtzbzoF5WTUFBKE=;
        b=pL9+WARWuc7ceYqPLP5dHowmR3egROw1IXDBjtk2pniDt67T/ETqVA30cs6qE6faPw+9I5
        5CTKHohVXmH92wCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5361713480;
        Thu,  3 Nov 2022 14:05:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 9B2UEbjKY2OIcQAAMHmgww
        (envelope-from <lhenriques@suse.de>); Thu, 03 Nov 2022 14:05:44 +0000
Received: from localhost (brahms.olymp [local])
        by brahms.olymp (OpenSMTPD) with ESMTPA id 2b58f16e;
        Thu, 3 Nov 2022 14:06:42 +0000 (UTC)
From:   =?UTF-8?q?Lu=C3=ADs=20Henriques?= <lhenriques@suse.de>
To:     Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Lu=C3=ADs=20Henriques?= <lhenriques@suse.de>
Subject: [RFC PATCH v2] ceph: allow encrypting a directory while not having Ax caps
Date:   Thu,  3 Nov 2022 14:06:40 +0000
Message-Id: <20221103140640.30850-1-lhenriques@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
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
ci->fscrypt_auth if we have Ax and ceph_fill_inode() won't use the
fscrypt_auth received if the inode state isn't I_NEW.  Fix it by allowing
ceph_fill_inode() to also set ci->fscrypt_auth if the inode doesn't have
it set already.

Signed-off-by: Luís Henriques <lhenriques@suse.de>
---
 fs/ceph/inode.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index fb507d57cb26..c7831f801911 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -1016,7 +1016,8 @@ int ceph_fill_inode(struct inode *inode, struct page *locked_page,
 	__ceph_update_quota(ci, iinfo->max_bytes, iinfo->max_files);
 
 #ifdef CONFIG_FS_ENCRYPTION
-	if (iinfo->fscrypt_auth_len && (inode->i_state & I_NEW)) {
+	if (iinfo->fscrypt_auth_len &&
+	    ((inode->i_state & I_NEW) || (ci->fscrypt_auth_len == 0))) {
 		kfree(ci->fscrypt_auth);
 		ci->fscrypt_auth_len = iinfo->fscrypt_auth_len;
 		ci->fscrypt_auth = iinfo->fscrypt_auth;
