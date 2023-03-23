Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E39CC6C7110
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 20:30:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231328AbjCWTaj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 15:30:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230157AbjCWTah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 15:30:37 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48BE6B442;
        Thu, 23 Mar 2023 12:30:36 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C6C3A1FE14;
        Thu, 23 Mar 2023 19:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1679599834; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=HUzZ+YdgqBsEPba1gZv82s6tRaXrtHgBuVCrMt0RUvs=;
        b=oPfWJo8BQMP2bDXkj8yCk4RZz/8dJUjmcrxd1fPXcFXKcbhft+1tUJjWQ+FEZMBUAiKfla
        Q5bZOvF+fxnz54/4kxRiPZIR7tWmwGD8hB+FslCHu4Zpn2sS1XGii+T8uToFWJ/KvtwllD
        WAvIfEu6ozAdMQLADb8W9nosUsE7Xj4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 956B1132C2;
        Thu, 23 Mar 2023 19:30:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 5TdRI9qoHGRwLAAAMHmgww
        (envelope-from <mkoutny@suse.com>); Thu, 23 Mar 2023 19:30:34 +0000
From:   =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        nbd@other.debian.org, linux-kernel@vger.kernel.org,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        Michal Kubecek <mkubecek@suse.cz>
Subject: [PATCH RESEND v3] nbd_genl_status: null check for nla_nest_start
Date:   Thu, 23 Mar 2023 20:30:32 +0100
Message-Id: <20230323193032.28483-1-mkoutny@suse.com>
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

From: Navid Emamdoost <navid.emamdoost@gmail.com>

nla_nest_start may fail and return NULL. The check is inserted, and
errno is selected based on other call sites within the same source code.
Update: removed extra new line.
v3 Update: added release reply, thanks to Michal Kubecek for pointing
out.

Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
Reviewed-by: Michal Kubecek <mkubecek@suse.cz>
Link: https://lore.kernel.org/r/20190911164013.27364-1-navid.emamdoost@gmail.com/
---

I'm resending the patch because there was apparent consensus of its
inclusion and it seems it was only overlooked. Some people may care
about this because of CVE-2019-16089.

 drivers/block/nbd.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 592cfa8b765a..109dccd9a515 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -2394,6 +2394,12 @@ static int nbd_genl_status(struct sk_buff *skb, struct genl_info *info)
 	}
 
 	dev_list = nla_nest_start_noflag(reply, NBD_ATTR_DEVICE_LIST);
+	if (!dev_list) {
+		nlmsg_free(reply);
+		ret = -EMSGSIZE;
+		goto out;
+	}
+
 	if (index == -1) {
 		ret = idr_for_each(&nbd_index_idr, &status_cb, reply);
 		if (ret) {
-- 
2.40.0

