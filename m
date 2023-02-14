Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4828696486
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 14:21:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232586AbjBNNVR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 08:21:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231834AbjBNNVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 08:21:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F5EF279B7;
        Tue, 14 Feb 2023 05:20:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AFE1B61637;
        Tue, 14 Feb 2023 13:20:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1588DC433D2;
        Tue, 14 Feb 2023 13:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676380856;
        bh=9m8ZbKJsD+az2elSMPiB/zCuKKeWwdmecOz4rRFlokw=;
        h=From:To:Cc:Subject:Date:From;
        b=BM5Iz0iwcVDt6wMsJwSQqIgE769d6X+hnI4PuaEX4j/mDAXprrZJCBYjc49bgctp2
         5AgbRg2mNfecieyWcPOz7FfuAEJ6jKznh9yFsaCG8fQC7uaGLhh25LTSOEVcu4bnNr
         Dwo588zvSBn/mojAkTU9P6Vc4OlzY4CSEVQyF4r/Fj3y7Aes9IJa+okDwm0fuCOaeH
         Eez00iOt94mjXZTDhGcC1QvpSXE+GvU811v+G+B5P2+j/rpt8Tt1Cm9+h8WJ2GXarK
         hszGdJV/dWlMpc94Au/83/mGc3pX7mAm07FIg6/MJOwQk58h3dH5G13qp+i319IcOi
         1XHGvdaNI3+8w==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sebastian Reichel <sre@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] power: supply: qcom_battmgr: remove bogus do_div()
Date:   Tue, 14 Feb 2023 14:20:42 +0100
Message-Id: <20230214132052.1556699-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.1
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

The argument to do_div() is a 32-bit integer, and it was read from a
32-bit register so there is no point in doing a 64-bit division on it.

On 32-bit arm, do_div() causes a compile-time warning here:

include/asm-generic/div64.h:238:22: error: passing argument 1 of '__div64_32' from incompatible pointer type [-Werror=incompatible-pointer-types]
  238 |   __rem = __div64_32(&(n), __base); \
      |                      ^~~~
      |                      |
      |                      unsigned int *
drivers/power/supply/qcom_battmgr.c:1130:4: note: in expansion of macro 'do_div'
 1130 |    do_div(battmgr->status.percent, 100);

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/power/supply/qcom_battmgr.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/power/supply/qcom_battmgr.c b/drivers/power/supply/qcom_battmgr.c
index ec31f887184f..de77df97b3a4 100644
--- a/drivers/power/supply/qcom_battmgr.c
+++ b/drivers/power/supply/qcom_battmgr.c
@@ -1126,8 +1126,7 @@ static void qcom_battmgr_sm8350_callback(struct qcom_battmgr *battmgr,
 			battmgr->info.charge_type = le32_to_cpu(resp->intval.value);
 			break;
 		case BATT_CAPACITY:
-			battmgr->status.percent = le32_to_cpu(resp->intval.value);
-			do_div(battmgr->status.percent, 100);
+			battmgr->status.percent = le32_to_cpu(resp->intval.value) / 100;
 			break;
 		case BATT_VOLT_OCV:
 			battmgr->status.voltage_ocv = le32_to_cpu(resp->intval.value);
-- 
2.39.1

