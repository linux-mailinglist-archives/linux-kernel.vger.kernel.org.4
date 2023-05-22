Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C03A670BA08
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 12:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232661AbjEVKZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 06:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232018AbjEVKZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 06:25:07 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91505D2
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 03:25:04 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4C72A1FDFE;
        Mon, 22 May 2023 10:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1684751103; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=UWemZErlloMTCdVWorQ4/wn7rdudTuYoPoEblvyctGQ=;
        b=QQTjL4QDyHtniL9u0v5PF8UzTIRq7/2LV3NUcAlGu/utAasoDij+m+nFVURh1xBnqorVd8
        ysZmNiYmRm9FS1NmCKPmtC3YG6qH2l+dNyEepXb+jjVvN93Sb/G9X2TvM0Kz87glOyh3iy
        HYwTSyTpxMk2fpUNei4hWJ7dVdxif5U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1684751103;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=UWemZErlloMTCdVWorQ4/wn7rdudTuYoPoEblvyctGQ=;
        b=wKRzbRx5iZD1HrstnU5oYyYMA/Ubp7dh32DxMCfkugTTSs1Zldo3NqmRwC7Vs/W4c6Flok
        P4Dku6mur3JKrECw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D143F13776;
        Mon, 22 May 2023 10:25:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id iJzYL/5Ca2TFEgAAMHmgww
        (envelope-from <lhenriques@suse.de>); Mon, 22 May 2023 10:25:02 +0000
Received: from localhost (brahms.olymp [local])
        by brahms.olymp (OpenSMTPD) with ESMTPA id 6dd15e18;
        Mon, 22 May 2023 10:25:00 +0000 (UTC)
Date:   Mon, 22 May 2023 11:24:34 +0100
From:   =?iso-8859-1?Q?Lu=EDs?= Henriques <lhenriques@suse.de>
To:     Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>
Cc:     ocfs2-devel@oss.oracle.com, linux-kernel@vger.kernel.org,
        =?iso-8859-1?Q?Lu=EDs?= Henriques <lhenriques@suse.de>
Subject: [PATCH] ocfs2: fix use-after-free when unmounting read-only
 filesystem
Message-ID: <ZGtC4rS4hoASgag5@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's trivial to trigger a use-after-free bug in the ocfs2 quotas code using
fstest generic/452.  After mounting a filesystem as read-only, quotas are
suspended and ocfs2_mem_dqinfo is freed through ->ocfs2_local_free_info().  When
unmounting the filesystem, an UAF access to the oinfo will eventually cause a
crash.

Cc: <stable@vger.kernel.org>
Signed-off-by: Luís Henriques <lhenriques@suse.de>
---
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

Cheers,
--
Luís
