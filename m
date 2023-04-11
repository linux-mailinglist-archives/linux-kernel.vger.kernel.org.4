Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF32A6DDA46
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 14:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbjDKMHi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 08:07:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbjDKMH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 08:07:29 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3268E2683
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 05:07:29 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id DD8FA21A25;
        Tue, 11 Apr 2023 12:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1681214847; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZY9sxvj6D4iXpgx1qxODzCgmh0MIsy7/YXUSzF3Zq2Y=;
        b=gBCkQ4ZLZxayb71eCIDQnysn6YnItRU6c27BhG6V5/G/PeoLnTkGWDyGHjQhPbnXETEMNG
        zqyFTIH3Z3uDw3wYlfwOJaskNwIaSRB42y9EYj93Wo+TTKLNItgGu2YFfz/s2+0+Vj6ro2
        qkvCGiKrtZIZaWZvyFGgrY8pANtXd7w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1681214847;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZY9sxvj6D4iXpgx1qxODzCgmh0MIsy7/YXUSzF3Zq2Y=;
        b=xMyg7CATI2PxiwVfoaahdv9aFMKEKhDvu+p4Ra3nm/+sg4nwuhgU5cEAQtmCSSQrkKSzxS
        VvaXSuLVm1Nq6eDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D265A13638;
        Tue, 11 Apr 2023 12:07:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id JVtcM39NNWSABgAAMHmgww
        (envelope-from <dwagner@suse.de>); Tue, 11 Apr 2023 12:07:27 +0000
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Sagi Grimberg <sagi@grimberg.me>,
        James Smart <james.smart@broadcom.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v2 4/4] nvmet-fc: Release reference on target port
Date:   Tue, 11 Apr 2023 14:07:18 +0200
Message-Id: <20230411120718.14477-5-dwagner@suse.de>
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

In case we return early out of __nvmet_fc_finish_ls_req() we still have
to release the reference on the target port.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/target/fc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 1ab6601fdd5c..df7d84aff843 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -359,6 +359,7 @@ __nvmet_fc_finish_ls_req(struct nvmet_fc_ls_req_op *lsop)
 
 	if (!lsop->req_queued) {
 		spin_unlock_irqrestore(&tgtport->lock, flags);
+		nvmet_fc_tgtport_put(tgtport);
 		return;
 	}
 
-- 
2.40.0

