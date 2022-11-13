Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE88626F18
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 11:59:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235231AbiKMK7z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 05:59:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231694AbiKMK7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 05:59:53 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62FBCE0DD;
        Sun, 13 Nov 2022 02:59:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F271E60B7E;
        Sun, 13 Nov 2022 10:59:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AB80C433D6;
        Sun, 13 Nov 2022 10:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668337191;
        bh=ytDEwh2p3/GmsjCAZeZF4oTa+RhN2V2CD/3qB3C74Eo=;
        h=From:To:Cc:Subject:Date:From;
        b=qwYrk9K1L17SBP+99+zmlOZg0mbYvo/82xXoOOa/n7AsCpdS9cXFEUFl/4+8+1m0F
         eZ7DmUo5aqAsHGitWtKnyFHH/vin3DTw4JGeURCfFxqyg4XKfIH08FzQJXUuCwgQyq
         Pe1cJ/iTcPwKSxhAO9idhzEoLJ9YNxl0IqxAdssVn0PlmWDOIylkxZl7CftkHN8C5U
         CubPxXdp++GiM6U9i9VKGqlSAAGgCvVun4D9WcYVp5+gjMVSKueApnM1Z82oJ69+4L
         zw3UNQiaiSHp3Rb4FpsK0YGplOLVvip0FGN+HhmXXjczw6hSDAEbyTh77zpWPFFTuO
         MhedfUO+cDCRQ==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] kconfig: remove unneeded variable in get_prompt_str()
Date:   Sun, 13 Nov 2022 19:59:41 +0900
Message-Id: <20221113105943.3753945-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
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

The variable 'accessible' is redundant.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/kconfig/menu.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/scripts/kconfig/menu.c b/scripts/kconfig/menu.c
index 109325f31bef..b90fff833588 100644
--- a/scripts/kconfig/menu.c
+++ b/scripts/kconfig/menu.c
@@ -724,10 +724,8 @@ static void get_prompt_str(struct gstr *r, struct property *prop,
 
 	menu = prop->menu;
 	for (i = 0; menu != &rootmenu && i < 8; menu = menu->parent) {
-		bool accessible = menu_is_visible(menu);
-
 		submenu[i++] = menu;
-		if (location == NULL && accessible)
+		if (location == NULL && menu_is_visible(menu))
 			location = menu;
 	}
 	if (head && location) {
-- 
2.34.1

