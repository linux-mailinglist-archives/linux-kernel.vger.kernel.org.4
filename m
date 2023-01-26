Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8B0E67C15D
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 01:10:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235099AbjAZAKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 19:10:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231360AbjAZAKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 19:10:37 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B35AE62D00
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 16:10:36 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id e184-20020a6369c1000000b0049de6cfcc40so65072pgc.19
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 16:10:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BXpxJ/jbcvyMd+P9jiaU10HhqC92uEGESAwYhx1FRLY=;
        b=LGSriV6i/FAV2GN1qSVyVIDxZXjMaJDIX+9hAke6OjeokFvcsb+lcbcJwQz2O30YmH
         Ze5aAi82YHHe0Kk2fEYMBKiTullT8U8Qb40sCp9f2qF7xNVhXj5ChW0VlPsPOF817Uuw
         qGwbVAs/UBC7DiIlMbdi9dLoOIoL3nCXBkrltW0jltIsCXM4fhDqVkIiIXHAdYGgdoZS
         p6Yn0FWvPisRffv1E+IbU3Uow+Od3BGTinhI8Jj9T8MBgc+JxCklGf+RxMnWM9iJQWC4
         TKg649XjSLuqnzKE1kUBDFfbphs6FzSKxEpFqb8oV3I0IjS5a7brn7RoqCjOUp4OUtt6
         g7rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BXpxJ/jbcvyMd+P9jiaU10HhqC92uEGESAwYhx1FRLY=;
        b=v9gHXviEqdh/Qqo6RrjELJtbKZJFzbRELkKrlSOffJ2E+jOQ53iZTgPCTbTlDjx7eq
         Gjg9XpLn8uJn0PzRPgmPGsDZfgneRR96tjH70slU7UQU9TomVXMYQZJW8S0LAyhztdYm
         hI6flc4JMfEQ2IzjpOvtVhQ1tEqkEayz5hQDOM6aGn5L52hoT0GtTYFRMKTfLfgxrdZj
         JyxU96YCB7gNNt1M0ohq/zEAZ3iYrnf/67/3efqocpkfBOtq0gDrzRtt6sr+/MBSdizq
         qO1hekU9wgbZ3t69x9AC1cFUVZUWNwMbTzrCHbYBFSfu3e4fJGhuZutg5uyArJ2+J52E
         Vm0w==
X-Gm-Message-State: AO0yUKWPIzyik9CYX+J2KSmCApiY2egxYx5Tl7LDGNHcNSVcvYqiz51D
        NYzUjan6mI+o1vu6F1R8YaULr3hlUFnV
X-Google-Smtp-Source: AK7set8B8E3fmnllqM8DrY2qc/F6EEcW02sUUpIGpo7TosdonTAJaQZVfkJhnKaMZZ+vp49dDVhT1jhaNYZ8
X-Received: from nkapron1.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:5b62])
 (user=nkapron job=sendgmr) by 2002:a17:90b:fc7:b0:226:9980:67f3 with SMTP id
 gd7-20020a17090b0fc700b00226998067f3mr944pjb.1.1674691835992; Wed, 25 Jan
 2023 16:10:35 -0800 (PST)
Date:   Thu, 26 Jan 2023 00:10:12 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
Message-ID: <20230126001013.3707873-1-nkapron@google.com>
Subject: [PATCH] phy: rockchip-typec: fix tcphy_get_mode error case
From:   Neill Kapron <nkapron@google.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Chris Zhong <zyw@rock-chips.com>,
        Kever Yang <kever.yang@rock-chips.com>,
        Guenter Roeck <groeck@chromium.org>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        Neill Kapron <nkapron@google.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The existing logic in tcphy_get_mode() can cause the phy to be
incorrectly configured to USB UFP or DisplayPort mode when
extcon_get_state returns an error code.

extcon_get_state() can return 0, 1, or a negative error code.

It is possible to get into the failing state with an extcon driver
which does not support the extcon connector id specified as the
second argument to extcon_get_state().

tcphy_get_mode()
->extcon_get_state()
-->find_cable_index_by_id()
--->return -EINVAL;

Fixes: e96be45cb84e ("phy: Add USB Type-C PHY driver for rk3399")
Signed-off-by: Neill Kapron <nkapron@google.com>
---
 drivers/phy/rockchip/phy-rockchip-typec.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-typec.c b/drivers/phy/rockchip/phy-rockchip-typec.c
index d76440ae10ff..6aea512e5d4e 100644
--- a/drivers/phy/rockchip/phy-rockchip-typec.c
+++ b/drivers/phy/rockchip/phy-rockchip-typec.c
@@ -821,10 +821,10 @@ static int tcphy_get_mode(struct rockchip_typec_phy *tcphy)
 	mode = MODE_DFP_USB;
 	id = EXTCON_USB_HOST;
 
-	if (ufp) {
+	if (ufp > 0) {
 		mode = MODE_UFP_USB;
 		id = EXTCON_USB;
-	} else if (dp) {
+	} else if (dp > 0) {
 		mode = MODE_DFP_DP;
 		id = EXTCON_DISP_DP;
 
-- 
2.39.1.456.gfc5497dd1b-goog

