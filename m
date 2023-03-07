Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 056CD6AF666
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 21:07:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231735AbjCGUHE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 15:07:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230460AbjCGUGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 15:06:47 -0500
X-Greylist: delayed 930 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 07 Mar 2023 12:06:37 PST
Received: from mail.vukad.in (mail.vukad.in [134.209.187.160])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C19C899D65;
        Tue,  7 Mar 2023 12:06:37 -0800 (PST)
Received: from kreator.vukad.in (dh207-125-167.xnet.hr [88.207.125.167])
        by mail.vukad.in (Postfix) with ESMTPSA id 5707B160081;
        Tue,  7 Mar 2023 20:40:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=vukad.in; s=mail;
        t=1678218047; bh=vo3sVDOx/JkAqhi7qGWauEgDUk5ce+94wjbTjZGEpM0=;
        h=From:To:Cc:Subject:Date;
        b=aMcWaM4Hvqel5L5QeIMqdNGjegztyXTkQCVn6v5YMT3+eWBzKgo0San2jKL3QC2Bt
         7HsEq3ZvwpQbVOyRESs+KQMdgZCyuGubrM2Rg1/e59uIsljaHuaOVpuoyaoPqFMjup
         Kaw7wyh9Li7FiFWr8QyBWU1KRVEgCrWiB8r8W9cIzamnm5wyBhE0ptFfXR6ThN2So6
         1oTHev4uQJH9j58gezEb3CBK3COq4ZdaqsXRYMzy/nLfqe4Kz1dwjzuJ+ovFmUulXQ
         0aEsUBxtZz3IGqPmwnCflbu+kJvOJerGomOGnwLLBvV47tcE8WycSL1zgtXSORl/NI
         FIC/Wi3WAu40Q==
From:   Jurica Vukadin <jura@vukad.in>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jurica Vukadin <jura@vukad.in>
Subject: [PATCH] kconfig: Update config changed flag before calling callback
Date:   Tue,  7 Mar 2023 20:40:39 +0100
Message-Id: <20230307194039.8825-1-jura@vukad.in>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_05,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prior to commit 5ee546594025 ("kconfig: change sym_change_count to a
boolean flag"), the conf_updated flag was set to the new value *before*
calling the callback. xconfig's save action depends on this behaviour,
because xconfig calls conf_get_changed() directly from the callback and
now sees the old value, thus never enabling the save button or the
shortcut.

Restore the previous behaviour.

Fixes: 5ee546594025 ("kconfig: change sym_change_count to a boolean flag")
Signed-off-by: Jurica Vukadin <jura@vukad.in>
---
 scripts/kconfig/confdata.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/scripts/kconfig/confdata.c b/scripts/kconfig/confdata.c
index b7c9f1dd5e42..992575f1e976 100644
--- a/scripts/kconfig/confdata.c
+++ b/scripts/kconfig/confdata.c
@@ -1226,10 +1226,12 @@ static void (*conf_changed_callback)(void);
 
 void conf_set_changed(bool val)
 {
-	if (conf_changed_callback && conf_changed != val)
-		conf_changed_callback();
+	bool changed = conf_changed != val;
 
 	conf_changed = val;
+
+	if (conf_changed_callback && changed)
+		conf_changed_callback();
 }
 
 bool conf_get_changed(void)
-- 
2.39.2

