Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05D1C6182FA
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 16:35:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231355AbiKCPf3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 11:35:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbiKCPf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 11:35:27 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2903A12618;
        Thu,  3 Nov 2022 08:35:27 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id DB29F1F385;
        Thu,  3 Nov 2022 15:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1667489725; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=3h//HlIguXJZhRdiiWfRY76v7ffmrOuFdbIoPsc2yf0=;
        b=vMI7YSyDMTLJWTmD4jWd5L2nt96lEOeopCxI4R38AQcxm0l7hX8wMjBKICrSJArEczGuNk
        Lc9HM8vv6+c4i+EKit6cHdgc4y6+3E9hHjOoZ4IxjjhUX+AjyPPToyyE7s/Lmnlb5hNlVD
        PytEXPlL9XQHYRObkHF/3nkn3/lWgfQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1667489725;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=3h//HlIguXJZhRdiiWfRY76v7ffmrOuFdbIoPsc2yf0=;
        b=fZ33pnkYNIh7EzdZMBC7XhcXM9L3Gw5ajU3mgQfSTDn2XyY+NIJwbocyW0MEY2ziMgCH+L
        qb16Aqp2AuSlZ2CQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 763D913480;
        Thu,  3 Nov 2022 15:35:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id JZ/kGb3fY2N/JgAAMHmgww
        (envelope-from <lhenriques@suse.de>); Thu, 03 Nov 2022 15:35:25 +0000
Received: from localhost (brahms.olymp [local])
        by brahms.olymp (OpenSMTPD) with ESMTPA id 3d1d2e61;
        Thu, 3 Nov 2022 15:36:25 +0000 (UTC)
From:   =?UTF-8?q?Lu=C3=ADs=20Henriques?= <lhenriques@suse.de>
To:     Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Lu=C3=ADs=20Henriques?= <lhenriques@suse.de>
Subject: [PATCH] ceph: fix memory leak in mount error path when using test_dummy_encryption
Date:   Thu,  3 Nov 2022 15:36:19 +0000
Message-Id: <20221103153619.11068-1-lhenriques@suse.de>
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

Because ceph_init_fs_context() will never be invoced in case we get a
mount error, destroy_mount_options() won't be releasing fscrypt resources
with fscrypt_free_dummy_policy().  This will result in a memory leak.  Add
an invocation to this function in the mount error path.

Signed-off-by: Luís Henriques <lhenriques@suse.de>
---
 fs/ceph/super.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ceph/super.c b/fs/ceph/super.c
index 2224d44d21c0..6b9fd04b25cd 100644
--- a/fs/ceph/super.c
+++ b/fs/ceph/super.c
@@ -1362,6 +1362,7 @@ static int ceph_get_tree(struct fs_context *fc)
 
 	ceph_mdsc_close_sessions(fsc->mdsc);
 	deactivate_locked_super(sb);
+	fscrypt_free_dummy_policy(&fsc->fsc_dummy_enc_policy);
 	goto out_final;
 
 out:
