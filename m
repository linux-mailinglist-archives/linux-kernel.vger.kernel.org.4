Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C42AC5EF957
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 17:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235677AbiI2PoJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 11:44:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236137AbiI2Pnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 11:43:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E875C143286;
        Thu, 29 Sep 2022 08:42:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 67E7261484;
        Thu, 29 Sep 2022 15:42:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3D56C433B5;
        Thu, 29 Sep 2022 15:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664466172;
        bh=uPktMUziO/YzOBeOf2VL4KS14Twdh9RsOWpZpq0ADzE=;
        h=From:To:Cc:Subject:Date:From;
        b=rYho3yZMmDE1EAhunn2zhbn26c4F1gcOcyhBjWbQbZRvsZQRR9Eyg6/c7mMpK4u9V
         GpxJ0leGw0v6z0PtezGpmG/PO4bWpM0rQFKXI0L0mVERSMgZhWDS1w/M/dr9r5laPz
         4yQR61HCpSkPRhKrkpeF51Y0qgkSskzliqg42EwTbfxRa5Cen1xx9X+ktQMzmPSeS4
         hYwP0UhRq7Y0d+K0Rte32Ge6naM8FaA8v7uZP+pK495ngEzQ9nLf4BZaYPtnHFNQiW
         i4Ff1/2ICbF73vrUgYVMUiZ8y+VaoPlfz+XltS/wAf7APDuUz1XhZkj/C0E8Tkxu2C
         Cm2ZBD746Xlzw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1odvgg-0001uA-PA; Thu, 29 Sep 2022 17:42:59 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Kaehlcke <mka@chromium.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH] PM: domains: log failures to register always-on domains
Date:   Thu, 29 Sep 2022 17:42:14 +0200
Message-Id: <20220929154214.7305-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Always-on PM domains must be on during initialisation or the domain is
currently silently rejected.

Print an error message in case an always-on domain is not on to make it
easier to debug drivers getting this wrong (e.g. by setting an always-on
genpd flag without making sure that the state matches).

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/base/power/domain.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)


Both myself and Matthias have hit this with the Qualcomm GCC drivers
when updating static genpd flags directly instead of using/adding driver
specific flags to propagate the setting.

Johan


diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index bbfbf05b3446..7200e307effb 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -2087,8 +2087,10 @@ int pm_genpd_init(struct generic_pm_domain *genpd,
 
 	/* Always-on domains must be powered on at initialization. */
 	if ((genpd_is_always_on(genpd) || genpd_is_rpm_always_on(genpd)) &&
-			!genpd_status_on(genpd))
+			!genpd_status_on(genpd)) {
+		pr_err("always-on PM domain %s is not on\n", genpd->name);
 		return -EINVAL;
+	}
 
 	/* Multiple states but no governor doesn't make sense. */
 	if (!gov && genpd->state_count > 1)
-- 
2.35.1

