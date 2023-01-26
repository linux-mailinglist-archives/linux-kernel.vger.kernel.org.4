Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC89567D1B8
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 17:35:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbjAZQfi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 11:35:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjAZQfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 11:35:36 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C572016AE3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 08:35:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 69CD4618DF
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 16:35:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 646C4C4339B;
        Thu, 26 Jan 2023 16:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674750934;
        bh=VEyIuxq4/HnzUlfKxp7Cc3nHkN3P8XRucXSnM9flciE=;
        h=From:To:Cc:Subject:Date:From;
        b=D7DN2wVWJXBcp6XKikYWoetVepShwy6VodFAAikSII9PrlOr0IK+KvEjtxf4d8iF8
         HSfspmfHaFD/jxPdfTLx7KDDUSnLHFYV1Syp+RsCBJl2D++4OxyNYC4dLpEQYDR56v
         vOJsj7o703g1wJXlwHYDgXmN58PoC+tQKlTPvay7aTTwmRiDQmSTlNu5aijugNz3Cb
         3L4+APgrrqLqlM8ZQmlbirlmNe9bzW3I7i6g1JEbl7BcD44Ej4CX+6ZXJ5+bmlRyq8
         hs6xLNGwRUhc4Qe4/5MiQIJoRWCHu6ZgFvZY/t7vF90Z1PfRp4lmAe8IkvWaK7SFWZ
         AwVYX2Q4g5gZw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Tao Zhang <quic_taozha@quicinc.com>,
        Mao Jinlong <quic_jinlmao@quicinc.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Coresight: tpda/tpdm: remove incorrect __exit annotation
Date:   Thu, 26 Jan 2023 17:35:14 +0100
Message-Id: <20230126163530.3495413-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

'remove' callbacks get called whenever a device is unbound from
the driver, which can get triggered from user space.

Putting it into the __exit section means that the function gets
dropped in for built-in drivers, as pointed out by this build
warning:

`tpda_remove' referenced in section `.data' of drivers/hwtracing/coresight/coresight-tpda.o: defined in discarded section `.exit.text' of drivers/hwtracing/coresight/coresight-tpda.o
`tpdm_remove' referenced in section `.data' of drivers/hwtracing/coresight/coresight-tpdm.o: defined in discarded section `.exit.text' of drivers/hwtracing/coresight/coresight-tpdm.o

Fixes: 5b7916625c01 ("Coresight: Add TPDA link driver")
Fixes: b3c71626a933 ("Coresight: Add coresight TPDM source driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/hwtracing/coresight/coresight-tpda.c | 2 +-
 drivers/hwtracing/coresight/coresight-tpdm.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tpda.c b/drivers/hwtracing/coresight/coresight-tpda.c
index 19c25c9f6157..382d648529e7 100644
--- a/drivers/hwtracing/coresight/coresight-tpda.c
+++ b/drivers/hwtracing/coresight/coresight-tpda.c
@@ -174,7 +174,7 @@ static int tpda_probe(struct amba_device *adev, const struct amba_id *id)
 	return 0;
 }
 
-static void __exit tpda_remove(struct amba_device *adev)
+static void tpda_remove(struct amba_device *adev)
 {
 	struct tpda_drvdata *drvdata = dev_get_drvdata(&adev->dev);
 
diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c b/drivers/hwtracing/coresight/coresight-tpdm.c
index 349a82bb3270..9479a5e8c672 100644
--- a/drivers/hwtracing/coresight/coresight-tpdm.c
+++ b/drivers/hwtracing/coresight/coresight-tpdm.c
@@ -223,7 +223,7 @@ static int tpdm_probe(struct amba_device *adev, const struct amba_id *id)
 	return 0;
 }
 
-static void __exit tpdm_remove(struct amba_device *adev)
+static void tpdm_remove(struct amba_device *adev)
 {
 	struct tpdm_drvdata *drvdata = dev_get_drvdata(&adev->dev);
 
-- 
2.39.0

