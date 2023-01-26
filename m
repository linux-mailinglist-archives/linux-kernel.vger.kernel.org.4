Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D1A267D8DA
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 23:54:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231712AbjAZWyU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 17:54:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231260AbjAZWyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 17:54:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 713717AAB
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 14:54:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0A17161997
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 22:54:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECA08C433EF;
        Thu, 26 Jan 2023 22:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674773655;
        bh=7zqgF9HhfGhfdBDoO1SXEGS5u3jLBY0p2DuYRN59B5s=;
        h=From:To:Cc:Subject:Date:From;
        b=DxLcg65zkW5tnzN8kVyj3HrFnRYtv51O7/E7z9kY5c9UCqsX+adg+h9zAg7IxgaNL
         wayCl4OgygsnRNSVt9kPQl7yFxtFcUhKQfEDO2p9XQLAugshM+ixKZqq5nsBXKHWIa
         McyUDiPUZXRdoKbbdnKUDVSWMumeXTwHLYU/pbhk8FuvgQ1UpYR6pGBbcJdVI3AZz3
         b0WZrTYz0Ei0N1o4SZU5P1VT61q3LvMWuVMsRSBN42q5an2Fk0Uuxqy4foWewM3dHw
         Mb5JIecvdDErtx8YroIFJHcKLUVwddBAXaLriiRN8bxPiI7KTBU07vKvD7psznX314
         nvgoPmw3AhtiA==
From:   broonie@kernel.org
To:     Bjorn Andersson <quic_bjorande@quicinc.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH] regulator: max20411: Directly include bitfield.h
Date:   Thu, 26 Jan 2023 22:54:03 +0000
Message-Id: <20230126225403.522121-1-broonie@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=734; i=broonie@kernel.org; h=from:subject; bh=vp4DyGHwujbWePrr/OPf5iOf9LtkIaaFQ81sN3Saulk=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBj0wSHN92E6pVuicJB9/UVv3sL9HuY//vS13PfhskS 1uvrga2JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY9MEhwAKCRAk1otyXVSH0EW1B/ 0Xg6uRwOHj0u2FfLhR+qYypiEzGAXYij1rqHoqMWz2e9mygL/GLqfqLQ2K+3RY95XfDOFxb3QZAV5f ae2jEaiD0aoMxMh3OSFsxA7byMqp2Vl1Kup5Stw7hMS3afYJcGPybGQGjmudV7m+bjKINFF9Dq81zm SETxU/JEET/lCF8H06qeSmNv1fiR23tr/Y5caCRt9P0o1dSysWETatVH4WsypZiC2YYJE9a2yNI0o8 +4Dky30v4PYLNBLdZlMMk4NnQ1gsIDpq1In9Qd1qQ1KwZWWWa93nyesb0Wt23rxqVVmcen6lHVSG1C RxZgnka+a5sfmUuv0hbuIr12gXJBhu
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mark Brown <broonie@kernel.org>

The max20411 driver uses bitfield.h but does not directly include
it, add an inclusion to avoid build errors in configurations
which do not result in an implicit inclusion.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/max20411-regulator.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/regulator/max20411-regulator.c b/drivers/regulator/max20411-regulator.c
index 69f04cbe69f1..b4faad54c458 100644
--- a/drivers/regulator/max20411-regulator.c
+++ b/drivers/regulator/max20411-regulator.c
@@ -4,6 +4,7 @@
  * Copyright (c) 2022, Linaro Ltd.
  */
 
+#include <linux/bitfield.h>
 #include <linux/gpio/consumer.h>
 #include <linux/i2c.h>
 #include <linux/module.h>
-- 
2.34.1

