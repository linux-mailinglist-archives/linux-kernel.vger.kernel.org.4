Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F50A7317B6
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 13:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344355AbjFOLo2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 07:44:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344466AbjFOLn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 07:43:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47A8544A2;
        Thu, 15 Jun 2023 04:40:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 53FA96396F;
        Thu, 15 Jun 2023 11:40:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3CFBC433CC;
        Thu, 15 Jun 2023 11:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686829210;
        bh=iH5sptddWZcnlTxUPs2tB+BDolK9udB4DIFGmPbcGAE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s598S/hnWBUsTkw0cWXHYvhUpguVGXK1+OfFd7q0ZUAu5QTCmTv8xURl62xxgth+H
         Qxbmyo31AqWpcKEd46sNMv0aSfoQQgRru6BcMT/Rek5XStWxXBTPrbr1V724q+3+FW
         rb0WykTHD0OGZwkGfKxyRYd13CSeWc4P+InAXoE5h9eIxoexJzbdWLqf3bMDFseBZ1
         5yaMIbhuB7Ayjr7XwO/GXF7T/tpdRI6jiM18ffOLml9EhhjoX8mfVr0yv17MFquXA4
         XiWOH0wriS6QL8ks3egGbfkF103aULDKnWkul2dmZb1V3oNggqCntYGNy++2pm2BMG
         TPCVsE6rpq4Yw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Osama Muhammad <osmtendev@gmail.com>,
        Simon Horman <simon.horman@corigine.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>,
        krzysztof.kozlowski@linaro.org, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 7/8] nfcsim.c: Fix error checking for debugfs_create_dir
Date:   Thu, 15 Jun 2023 07:39:55 -0400
Message-Id: <20230615113956.649736-7-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230615113956.649736-1-sashal@kernel.org>
References: <20230615113956.649736-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.286
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Osama Muhammad <osmtendev@gmail.com>

[ Upstream commit 9b9e46aa07273ceb96866b2e812b46f1ee0b8d2f ]

This patch fixes the error checking in nfcsim.c.
The DebugFS kernel API is developed in
a way that the caller can safely ignore the errors that
occur during the creation of DebugFS nodes.

Signed-off-by: Osama Muhammad <osmtendev@gmail.com>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nfc/nfcsim.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/nfc/nfcsim.c b/drivers/nfc/nfcsim.c
index 533e3aa6275cd..cf07b366500e9 100644
--- a/drivers/nfc/nfcsim.c
+++ b/drivers/nfc/nfcsim.c
@@ -345,10 +345,6 @@ static struct dentry *nfcsim_debugfs_root;
 static void nfcsim_debugfs_init(void)
 {
 	nfcsim_debugfs_root = debugfs_create_dir("nfcsim", NULL);
-
-	if (!nfcsim_debugfs_root)
-		pr_err("Could not create debugfs entry\n");
-
 }
 
 static void nfcsim_debugfs_remove(void)
-- 
2.39.2

