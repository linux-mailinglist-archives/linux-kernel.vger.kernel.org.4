Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4D6262C2B6
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 16:36:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232785AbiKPPgN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 10:36:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbiKPPgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 10:36:10 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D66A514D0C;
        Wed, 16 Nov 2022 07:36:09 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8F7731F94F;
        Wed, 16 Nov 2022 15:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1668612968; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=dXEbhPN++fKE2vgAqmHjFf/FhFXA2Mf+lSNZdDPIEpM=;
        b=do6TaNFxSrVKbQKNRcNQ4tb5s4GHUZ/m4Ig6UqPJVDrW+Gv7/+glG/zrWCkpiZ7xL4cVz9
        ItHgbOnlgqgxP5JgoiPz84jv2tan0bvQOCailaqzwuF769tmf6FQRI9ujOhfkAxsKhTMaP
        JPXooClhyHefw5M8ad6P5wyTrWweLVc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1668612968;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=dXEbhPN++fKE2vgAqmHjFf/FhFXA2Mf+lSNZdDPIEpM=;
        b=AWWQ7AITmGeDBUCEwyA24p/ifT98EBITIaVfLuUNrQ7T6V1TFPF4cicxqiXD1dBmqlZ0xn
        JVImG02lsWbdMrDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 23BE913480;
        Wed, 16 Nov 2022 15:36:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id hldKBWgDdWMJcgAAMHmgww
        (envelope-from <lhenriques@suse.de>); Wed, 16 Nov 2022 15:36:08 +0000
Received: from localhost (brahms.olymp [local])
        by brahms.olymp (OpenSMTPD) with ESMTPA id 576d7e49;
        Wed, 16 Nov 2022 15:37:07 +0000 (UTC)
From:   =?UTF-8?q?Lu=C3=ADs=20Henriques?= <lhenriques@suse.de>
To:     Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Lu=C3=ADs=20Henriques?= <lhenriques@suse.de>
Subject: [PATCH] ceph: make sure directories aren't complete after setting crypt context
Date:   Wed, 16 Nov 2022 15:37:03 +0000
Message-Id: <20221116153703.27292-1-lhenriques@suse.de>
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

When setting a directory's crypt context, __ceph_dir_clear_complete() needs
to be used otherwise, if it was complete before, any old dentry that's still
around will be valid.

Signed-off-by: Luís Henriques <lhenriques@suse.de>
---
Hi!

Here's a simple way to trigger the bug this patch is fixing:

# cd /cephfs
# ls mydir
nKRhofOAVNsAwVLvDw7a0c9ypsjbZfK3n0Npnmni6j0
# ls mydir/nKRhofOAVNsAwVLvDw7a0c9ypsjbZfK3n0Npnmni6j0/
Cyuer5xT+kBlEPgtwAqSj0WK2taEljP5vHZ,D8VXCJ8  u+46b2XVCt7Obpz0gznZyNLRj79Q2l4KmkwbKOzdQKw
# fscrypt unlock mydir
# touch /mnt/test/mydir/mysubdir/file
touch: cannot touch '/mnt/test/mydir/mysubdir/file': No such file or directory

 fs/ceph/crypto.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/ceph/crypto.c b/fs/ceph/crypto.c
index 35a2ccfe6899..dc1557967032 100644
--- a/fs/ceph/crypto.c
+++ b/fs/ceph/crypto.c
@@ -87,6 +87,10 @@ static int ceph_crypt_get_context(struct inode *inode, void *ctx, size_t len)
 		return -ERANGE;
 
 	memcpy(ctx, cfa->cfa_blob, ctxlen);
+
+	/* Directory isn't complete anymore */
+	if (S_ISDIR(inode->i_mode) && __ceph_dir_is_complete(ci))
+		__ceph_dir_clear_complete(ci);
 	return ctxlen;
 }
 
