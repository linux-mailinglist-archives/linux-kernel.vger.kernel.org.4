Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8094A724204
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 14:24:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236669AbjFFMY1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 08:24:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232356AbjFFMYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 08:24:25 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD7D010C7;
        Tue,  6 Jun 2023 05:24:24 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5A2321FD69;
        Tue,  6 Jun 2023 12:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1686054263; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wb/zjNGR8vZ6lz2lsTJaQdU6G03xji6YZEjNm9p9xpM=;
        b=XbRAzKIk+8BwZMJqCTkROBCnYCApL5tn3HVK3mLxE01nMJ13uoOtRVNt7R452KNNNUiXNz
        CP85SeKxXqHb1GIMAWU+Z+jF8oTf/FjHldEzmA42cnXvMU7brPyiAX8CgoWEwLy7uIHc8Z
        g8jX2KkCSzVJTw+ufERjCA4U8dZe84k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1686054263;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wb/zjNGR8vZ6lz2lsTJaQdU6G03xji6YZEjNm9p9xpM=;
        b=cqVAqDwKfn7FglB6pJlPli5dVhc49ugHt/54UYqQV+sO+PsyKWwb/p5I0iUShcsrNtIjaU
        iUVuONkOQcHmTWBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4CA9E13519;
        Tue,  6 Jun 2023 12:24:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Rw6PEnclf2SDOAAAMHmgww
        (envelope-from <dwagner@suse.de>); Tue, 06 Jun 2023 12:24:23 +0000
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>, Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v4 1/1] nvmet-fcloop: Do not wait on completion when unregister fails
Date:   Tue,  6 Jun 2023 14:24:11 +0200
Message-Id: <20230606122411.7972-2-dwagner@suse.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230606122411.7972-1-dwagner@suse.de>
References: <20230606122411.7972-1-dwagner@suse.de>
MIME-Version: 1.0
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

The nvme_fc_unregister_localport() returns an error code in case that
the locaport pointer is NULL or has already been unegisterd. localport is
is either in the ONLINE state (all resources allocated) or has already
been put into DELETED state.

In this case we will never receive an wakeup call and thus any caller
will hang, e.g. module unload.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/target/fcloop.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
index 1ab3d900f2bf..c65a73433c05 100644
--- a/drivers/nvme/target/fcloop.c
+++ b/drivers/nvme/target/fcloop.c
@@ -1166,7 +1166,8 @@ __wait_localport_unreg(struct fcloop_lport *lport)
 
 	ret = nvme_fc_unregister_localport(lport->localport);
 
-	wait_for_completion(&lport->unreg_done);
+	if (!ret)
+		wait_for_completion(&lport->unreg_done);
 
 	kfree(lport);
 
-- 
2.40.1

