Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01E696DDA43
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 14:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbjDKMHa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 08:07:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjDKMH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 08:07:27 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3393F2D48
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 05:07:27 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D467021A47;
        Tue, 11 Apr 2023 12:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1681214845; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NfxBQ+YwCQT4C500tsTvYDqFoF6jclwkqD6YJhX2o+Y=;
        b=K2o6RKqoXbIRqvLQ6ms4tAYt3tGPge1LW+XGpeyYNhhwqPzdArhN6/F3MnL6zVvfehSubm
        ND0+AMAxECFBLQzvPbOkFyhqM3OHkp+Aw2GdDTHe6JwYuEs7p4W7xfRN6wJG/5due289zq
        hKC1Ejf+zYVQ6qn7uU0zf5UVjjzMqbg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1681214845;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NfxBQ+YwCQT4C500tsTvYDqFoF6jclwkqD6YJhX2o+Y=;
        b=sY0Uc2g6d18FdMSnd04E+yW9xydSYI6kfSSY7gk/t2eOtbrnREBHE9ONU1Gh7M+InxjOtw
        2WITr9fAddjJzMAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C76A013638;
        Tue, 11 Apr 2023 12:07:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id NVmqMH1NNWR5BgAAMHmgww
        (envelope-from <dwagner@suse.de>); Tue, 11 Apr 2023 12:07:25 +0000
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Sagi Grimberg <sagi@grimberg.me>,
        James Smart <james.smart@broadcom.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v2 1/4] nvmet-fcloop: Remove remote port from list when unlinking
Date:   Tue, 11 Apr 2023 14:07:15 +0200
Message-Id: <20230411120718.14477-2-dwagner@suse.de>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230411120718.14477-1-dwagner@suse.de>
References: <20230411120718.14477-1-dwagner@suse.de>
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

