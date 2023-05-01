Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB6F86F2E01
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 05:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233461AbjEADSQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Apr 2023 23:18:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233728AbjEADQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Apr 2023 23:16:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0A05618F;
        Sun, 30 Apr 2023 20:06:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 712B26179B;
        Mon,  1 May 2023 03:06:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8665EC433D2;
        Mon,  1 May 2023 03:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682910363;
        bh=pFbDP6UlpYSrP0iKGq40NRahiU810/SYBYS0pTCxdBE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IxrWJR29jIZhmKgr5AHSoL4g5aYmVhqQa0ptNHAdLz38bGXG31/AC2IJJGf6eawwL
         2uXl5wvDCDb20yFtX9Sp8csiPlCeLxMoBfTzsZsBcbt0//ULtzsG9lzFqEuXjeoy0f
         140mU6rZqrSo5kcOctJ1M+7yNJ8/VeRWpV/pGx5Fh48UZ/zow1NCsW9oJpXi/A2spf
         HR5Z/ehwH28OR7uGyY1i2FEauYlsKLrVZEOVdG9dt1VjSk6Y6TGwflbVc5kfEvENZe
         4bwvmRyrHFvRiara0Lh+018vIcRkC9eBGrYqVR9d6exN4Ljr6H2y53/elIzjRDi+dY
         slIM2goCkMVfA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sasha Levin <sashal@kernel.org>, mchehab@kernel.org,
        bleung@chromium.org, groeck@chromium.org,
        zoey_wu@wistron.corp-partner.google.com,
        ajye_huang@compal.corp-partner.google.com,
        hellojacky0226@hotmail.com, kevin.chiu.17802@gmail.com,
        linux-media@vger.kernel.org, chrome-platform@lists.linux.dev
Subject: [PATCH AUTOSEL 5.10 11/12] media: cros-ec-cec: Don't exit early in .remove() callback
Date:   Sun, 30 Apr 2023 23:05:37 -0400
Message-Id: <20230501030540.3254928-11-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230501030540.3254928-1-sashal@kernel.org>
References: <20230501030540.3254928-1-sashal@kernel.org>
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
 drivers/media/cec/platform/cros-ec/cros-ec-cec.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/media/cec/platform/cros-ec/cros-ec-cec.c b/drivers/media/cec/platform/cros-ec/cros-ec-cec.c
index f66699d5dc66e..8bf34620db5fe 100644
--- a/drivers/media/cec/platform/cros-ec/cros-ec-cec.c
+++ b/drivers/media/cec/platform/cros-ec/cros-ec-cec.c
@@ -324,14 +324,16 @@ static int cros_ec_cec_remove(struct platform_device *pdev)
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
 
 	cec_notifier_cec_adap_unregister(cros_ec_cec->notify,
 					 cros_ec_cec->adap);
-- 
2.39.2

