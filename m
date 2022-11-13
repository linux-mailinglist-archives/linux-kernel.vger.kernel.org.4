Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38A3F626F1D
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 12:00:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235322AbiKMLAG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 06:00:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235272AbiKMK74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 05:59:56 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EED6CEE05;
        Sun, 13 Nov 2022 02:59:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0C666B80C03;
        Sun, 13 Nov 2022 10:59:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C27F5C433B5;
        Sun, 13 Nov 2022 10:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668337192;
        bh=uVh7d1ZdBvFF5UzVDHF1tphjemQ64fS1BQIfrjzswbg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I8LeTq35nKtbls63J4g7DR4Ng1p5D+BE7tAqosrLsX0Vr3ntlNML5OnOx6jPR7muE
         h/iCUEf3E41TryKvtPDBzEDAqZH4apUy4VgHffT+AfVq4LDGDBAU6D2AIzpd12Gjex
         1stec85YCsBLyTvERfMAIWx3YYLC8jRue6p0uCnMadbX+iaAIKXN/CaEnNoGGprHI2
         Q4OOEWQdAO68QhZA4ovSNvO62br7sDaT0WwcGBQNkKiKHgSLFz3GVoc6rDO+bUPY6S
         x2YoLwbfzejzti8E9wMIh2BPGnLMh9/Ar97hCKBDdpMvwQ/XRhFTsH+1+toTGbpBYS
         FiRmk6veIuS3Q==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] kconfig: remove const qualifier from str_get()
Date:   Sun, 13 Nov 2022 19:59:42 +0900
Message-Id: <20221113105943.3753945-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221113105943.3753945-1-masahiroy@kernel.org>
References: <20221113105943.3753945-1-masahiroy@kernel.org>
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

update_text() apparently edits the buffer returned by str_get().
(and there is no reason why it shouldn't)

Remove 'const' quailifier and casting.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/kconfig/lkc.h   | 2 +-
 scripts/kconfig/mconf.c | 4 ++--
 scripts/kconfig/util.c  | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/scripts/kconfig/lkc.h b/scripts/kconfig/lkc.h
index 6ac2eabe109d..e7118d62a45f 100644
--- a/scripts/kconfig/lkc.h
+++ b/scripts/kconfig/lkc.h
@@ -76,7 +76,7 @@ struct gstr str_new(void);
 void str_free(struct gstr *gs);
 void str_append(struct gstr *gs, const char *s);
 void str_printf(struct gstr *gs, const char *fmt, ...);
-const char *str_get(struct gstr *gs);
+char *str_get(struct gstr *gs);
 
 /* menu.c */
 void _menu_init(void);
diff --git a/scripts/kconfig/mconf.c b/scripts/kconfig/mconf.c
index 9d3cf510562f..d7f7e1bf7dd4 100644
--- a/scripts/kconfig/mconf.c
+++ b/scripts/kconfig/mconf.c
@@ -440,8 +440,8 @@ static void search_conf(void)
 
 		res = get_relations_str(sym_arr, &head);
 		set_subtitle();
-		dres = show_textbox_ext("Search Results", (char *)
-					str_get(&res), 0, 0, keys, &vscroll,
+		dres = show_textbox_ext("Search Results", str_get(&res), 0, 0,
+					keys, &vscroll,
 					&hscroll, &update_text, (void *)
 					&data);
 		again = false;
diff --git a/scripts/kconfig/util.c b/scripts/kconfig/util.c
index 29585394df71..b78f114ad48c 100644
--- a/scripts/kconfig/util.c
+++ b/scripts/kconfig/util.c
@@ -74,7 +74,7 @@ void str_printf(struct gstr *gs, const char *fmt, ...)
 }
 
 /* Retrieve value of growable string */
-const char *str_get(struct gstr *gs)
+char *str_get(struct gstr *gs)
 {
 	return gs->s;
 }
-- 
2.34.1

