Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4888E6F2E24
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 05:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234084AbjEADUy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Apr 2023 23:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233153AbjEADRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Apr 2023 23:17:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9DF33A84;
        Sun, 30 Apr 2023 20:07:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AACB961831;
        Mon,  1 May 2023 03:06:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34015C433EF;
        Mon,  1 May 2023 03:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682910412;
        bh=GEC0UqnWm8e/URfsSrjeYYJ3rNGLEBmmEMv61vf3ze8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=grrILO0zGXnlRe9s/Pl7+oC6EjrgyzUZX8/k0kzWjslP32T7W6voXDEQOhY50FcJ/
         6HyoTACXzcZOEoUIwD65LzpsIAWG++SoB6ee6yzyJ03e6pDluctUSzl5lfGXzfj15C
         SnZn12V4k0HzhZWrYiGJzTyi+KDMm90V+mwgep2geVYuzD3+WgQsi5GvxpUzMG93fv
         YuernrxYuh65E6DYxEH2FYd9MJ5ExdEorTWY9uzMYCAeEv7Z3kfemEkwWvuipGFv1I
         492AkM9g1ErQrKCq5Uz0hLXckW6oe5dn6ydat8Q+VvQ6EITLq7K+uoXyAtgw5Qu/4X
         8hs9tE3raZe7Q==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sasha Levin <sashal@kernel.org>, mchehab@kernel.org,
        bleung@chromium.org, linux-media@vger.kernel.org,
        chrome-platform@lists.linux.dev
Subject: [PATCH AUTOSEL 4.19 9/9] media: cros-ec-cec: Don't exit early in .remove() callback
Date:   Sun, 30 Apr 2023 23:06:31 -0400
Message-Id: <20230501030633.3255202-9-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230501030633.3255202-1-sashal@kernel.org>
References: <20230501030633.3255202-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

[ Upstream commit 0ff7aee24e47beb4306ce050824b54147f2fabfa ]

Exiting early in remove without releasing all acquired resources yields
leaks. Note that e.g. memory allocated with devm_zalloc() is freed after
.remove() returns, even if the return code was negative.

While blocking_notifier_chain_unregister() won't fail and so the
change is somewhat cosmetic, platform driver's .remove callbacks are
about to be converted to return void. To prepare that, keep the error
message but don't return early.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/cros-ec-cec/cros-ec-cec.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/cros-ec-cec/cros-ec-cec.c b/drivers/media/platform/cros-ec-cec/cros-ec-cec.c
index 1f35770245d1f..d273e1a23227b 100644
--- a/drivers/media/platform/cros-ec-cec/cros-ec-cec.c
+++ b/drivers/media/platform/cros-ec-cec/cros-ec-cec.c
@@ -315,14 +315,16 @@ static int cros_ec_cec_remove(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	int ret;
 
+	/*
+	 * blocking_notifier_chain_unregister() only fails if the notifier isn't
+	 * in the list. We know it was added to it by .probe(), so there should
+	 * be no need for error checking. Be cautious and still check.
+	 */
 	ret = blocking_notifier_chain_unregister(
 			&cros_ec_cec->cros_ec->event_notifier,
 			&cros_ec_cec->notifier);
-
-	if (ret) {
+	if (ret)
 		dev_err(dev, "failed to unregister notifier\n");
-		return ret;
-	}
 
 	cec_unregister_adapter(cros_ec_cec->adap);
 
-- 
2.39.2

