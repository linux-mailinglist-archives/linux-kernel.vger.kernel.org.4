Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2C6960FBE8
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 17:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235870AbiJ0P1r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 11:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236091AbiJ0P1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 11:27:31 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C6C417F2B0;
        Thu, 27 Oct 2022 08:27:27 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2F4DA1F8D4;
        Thu, 27 Oct 2022 15:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1666884446; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=7dilkeeD3yQznVgJ3+I76aEgJ3V5a++o4EZ+mgwBG+Y=;
        b=BT9oE+5V2zCpXzACKAiaPX0rkoZKGyjcPYDENdrGZMiN3M1m1mdlCRc54UU+O+vA7wv8A0
        cEnk3VCPew5F0GY16P4ZYkglxwhTY7P5BlFOExGmKie4hs+BPvMfkzhC/YvVTMEUKp2Jlu
        AY8O9tSh1bjOLSIAVIsTDbwH5CPXc3E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1666884446;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=7dilkeeD3yQznVgJ3+I76aEgJ3V5a++o4EZ+mgwBG+Y=;
        b=aRcG76IXMmksZ+LQtirWkZwiIckXajtOtqAAL9vvP6YS13M7iuYGaH47fFsgL0JJ4aqEIG
        XX8wf/imgddPLZAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BC9C4134CA;
        Thu, 27 Oct 2022 15:27:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id jjIUK12jWmMzMwAAMHmgww
        (envelope-from <lhenriques@suse.de>); Thu, 27 Oct 2022 15:27:25 +0000
Received: from localhost (brahms.olymp [local])
        by brahms.olymp (OpenSMTPD) with ESMTPA id 816b825f;
        Thu, 27 Oct 2022 15:28:23 +0000 (UTC)
From:   =?UTF-8?q?Lu=C3=ADs=20Henriques?= <lhenriques@suse.de>
To:     Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        =?UTF-8?q?Lu=C3=ADs=20Henriques?= <lhenriques@suse.de>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ceph: fix mdsmap decode for v >= 17
Date:   Thu, 27 Oct 2022 16:28:11 +0100
Message-Id: <20221027152811.7603-1-lhenriques@suse.de>
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

Commit d93231a6bc8a ("ceph: prevent a client from exceeding the MDS
maximum xattr size") was merged before the corresponding MDS-side changes
have been merged.  With the introduction of 'bal_rank_mask' in the mdsmap,
the decoding of maps with v>=17 is now incorrect.  Fix this by skipping
the 'bal_rank_mask' string decoding.

Fixes: d93231a6bc8a ("ceph: prevent a client from exceeding the MDS maximum xattr size")
Signed-off-by: Luís Henriques <lhenriques@suse.de>
---
Hi!

This inconsistency was introduced by ceph PR #43284; I think that, before
picking this patch, we need to get PR #46357 merged to avoid new
problems.

Cheers,
--
Luís

 fs/ceph/mdsmap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/ceph/mdsmap.c b/fs/ceph/mdsmap.c
index 3fbabc98e1f7..fe4f1a6c3465 100644
--- a/fs/ceph/mdsmap.c
+++ b/fs/ceph/mdsmap.c
@@ -379,6 +379,8 @@ struct ceph_mdsmap *ceph_mdsmap_decode(void **p, void *end, bool msgr2)
 		ceph_decode_skip_8(p, end, bad_ext);
 		/* required_client_features */
 		ceph_decode_skip_set(p, end, 64, bad_ext);
+		/* bal_rank_mask */
+		ceph_decode_skip_string(p, end, bad_ext);
 		ceph_decode_64_safe(p, end, m->m_max_xattr_size, bad_ext);
 	} else {
 		/* This forces the usage of the (sync) SETXATTR Op */
