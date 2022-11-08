Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A25626216D9
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 15:33:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234257AbiKHOdq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 09:33:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233938AbiKHOdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 09:33:25 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6D22CEB;
        Tue,  8 Nov 2022 06:33:24 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 359631F8E3;
        Tue,  8 Nov 2022 14:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1667918003; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=bsCWcDyBc5BTfKnK5tb7UxOWSDPa58fCHAcnTLeBXms=;
        b=y+2nS0vKe7LmELq2vRSmSOEf/AMQtUENZ5rsieWBjEqNWWKUIZgnlhq6h2c3S0QX4n1Mfw
        CAOSFDuMOKWYaHURp3/q1w1cBob1r5n1jNnhkazpheK4Pdiy1DPJr63XxU4cN3ZrHvYDZ+
        KgciMrp9LQTL0cdyTC+1SRJMKiGuFiI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1667918003;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=bsCWcDyBc5BTfKnK5tb7UxOWSDPa58fCHAcnTLeBXms=;
        b=jyLT7Vu1KKl0H4Nq4QzbhAEQEx/lhP1iUiYdPGzAfLNBQkoilo1/c8RYXDq5xs+w//XF/h
        gNT7ffrXs8GE+gDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C53B313398;
        Tue,  8 Nov 2022 14:33:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id bPopLbJoamPyMgAAMHmgww
        (envelope-from <lhenriques@suse.de>); Tue, 08 Nov 2022 14:33:22 +0000
Received: from localhost (brahms.olymp [local])
        by brahms.olymp (OpenSMTPD) with ESMTPA id 59105061;
        Tue, 8 Nov 2022 14:34:23 +0000 (UTC)
From:   =?UTF-8?q?Lu=C3=ADs=20Henriques?= <lhenriques@suse.de>
To:     Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Lu=C3=ADs=20Henriques?= <lhenriques@suse.de>
Subject: [PATCH v2] ceph: fix memory leak in mount error path when using test_dummy_encryption
Date:   Tue,  8 Nov 2022 14:34:21 +0000
Message-Id: <20221108143421.30993-1-lhenriques@suse.de>
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
* Changes since v1:

As suggested by Xiubo, moved fscrypt free from ceph_get_tree() to
ceph_real_mount().

(Also used 'git format-patch' with '--base' so that the bots know what to
(not) do with this patch.)

 fs/ceph/super.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ceph/super.c b/fs/ceph/super.c
index 2224d44d21c0..f10a076f47e5 100644
--- a/fs/ceph/super.c
+++ b/fs/ceph/super.c
@@ -1196,6 +1196,7 @@ static struct dentry *ceph_real_mount(struct ceph_fs_client *fsc,
 
 out:
 	mutex_unlock(&fsc->client->mount_mutex);
+	ceph_fscrypt_free_dummy_policy(fsc);
 	return ERR_PTR(err);
 }
 

base-commit: 8b9ee21dfceadd4cc35a87bbe7f0ad547cffa1be
prerequisite-patch-id: 34ba9e6b37b68668d261ddbda7858ee6f83c82fa
prerequisite-patch-id: 87f1b323c29ab8d0a6d012d30fdc39bc49179624
prerequisite-patch-id: c94f448ef026375b10748457a3aa46070aa7046e
