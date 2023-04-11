Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E87536DD680
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 11:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbjDKJWQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 05:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjDKJWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 05:22:15 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C70601BF0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 02:22:14 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 78E511FE0B;
        Tue, 11 Apr 2023 09:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1681204933; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=NfxBQ+YwCQT4C500tsTvYDqFoF6jclwkqD6YJhX2o+Y=;
        b=aRju6PIFPD3pKpR8tDbD5zDwBZFsBMOLD46J7nUJ83WcKTvPzhX+FRxqLDqBfdkdCw7g1C
        BZZwYti1Q+tIFdUQCA0T/DworpqkvztHLXTOi+vuH+D/T+CP08xL0h0MRqZfdLNlYnLjt7
        PvUIqeZJcRsaZ1LpmwnpZzNleaC2hwo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1681204933;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=NfxBQ+YwCQT4C500tsTvYDqFoF6jclwkqD6YJhX2o+Y=;
        b=SFje4ilRGflBpNnPl4rhLMeUVaOidFApoeujep2m/O+pCxCYiLs65d7nOEVXdsLvh58Ghd
        1+eekIchjOkpVVBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6A97D13519;
        Tue, 11 Apr 2023 09:22:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id EsEGGsUmNWQQJgAAMHmgww
        (envelope-from <dwagner@suse.de>); Tue, 11 Apr 2023 09:22:13 +0000
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Sagi Grimberg <sagi@grimberg.me>,
        James Smart <james.smart@broadcom.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Daniel Wagner <dwagner@suse.de>
Subject: [PATCH] rvmet-fcloop: Remove remote port from list when unlinking
Date:   Tue, 11 Apr 2023 11:22:09 +0200
Message-Id: <20230411092209.12719-1-dwagner@suse.de>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The remote port is never removed from fcloop_nports list. During module
unloading it's possible to end up an busy loop in fcloop_exit, because
the remote port is found in the list and thus we will never progress.

The kernel log will be spammed with

  nvme_fcloop: fcloop_exit: Failed deleting remote port
  nvme_fcloop: fcloop_exit: Failed deleting target port

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/target/fcloop.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
index 5c16372f3b53..1e53c8fe4b95 100644
--- a/drivers/nvme/target/fcloop.c
+++ b/drivers/nvme/target/fcloop.c
@@ -1352,6 +1352,8 @@ __unlink_remote_port(struct fcloop_nport *nport)
 		nport->tport->remoteport = NULL;
 	nport->rport = NULL;
 
+	list_del(&nport->nport_list);
+
 	return rport;
 }
 
-- 
2.40.0

