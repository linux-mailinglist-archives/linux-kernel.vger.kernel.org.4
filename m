Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A540C62EAD5
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 02:22:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235086AbiKRBWM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 20:22:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231194AbiKRBWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 20:22:10 -0500
Received: from sonata.ens-lyon.org (sonata.ens-lyon.org [140.77.166.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22B566BDF9
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 17:22:09 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by sonata.ens-lyon.org (Postfix) with ESMTP id A624A2012C;
        Fri, 18 Nov 2022 02:22:07 +0100 (CET)
Received: from sonata.ens-lyon.org ([127.0.0.1])
        by localhost (sonata.ens-lyon.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 1NwpyYRF_7Nn; Fri, 18 Nov 2022 02:22:07 +0100 (CET)
Received: from begin (lfbn-bor-1-376-208.w109-215.abo.wanadoo.fr [109.215.91.208])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by sonata.ens-lyon.org (Postfix) with ESMTPSA id 020D62011C;
        Fri, 18 Nov 2022 02:22:06 +0100 (CET)
Received: from samy by begin with local (Exim 4.96)
        (envelope-from <samuel.thibault@ens-lyon.org>)
        id 1ovq50-005R3b-1q;
        Fri, 18 Nov 2022 02:22:06 +0100
Date:   Fri, 18 Nov 2022 02:22:06 +0100
From:   Samuel Thibault <samuel.thibault@ens-lyon.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, speakup@linux-speakup.org
Subject: [PATCH] speakup: Fix building as extmod
Message-ID: <20221118012206.j6hq6b6nfx2jhqg6@begin>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        speakup@linux-speakup.org
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: NeoMutt/20170609 (1.8.3)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

spk_priv_keyinfo.h should be opened from the speakup directory. When
building as extmod we should thus open it from the module directory
rather than the main Linux source.

Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>

---
 drivers/accessibility/speakup/Makefile      |    4 +++-
 drivers/accessibility/speakup/makemapdata.c |    7 +++++--
 2 files changed, 8 insertions(+), 3 deletions(-)

--- a/drivers/accessibility/speakup/Makefile
+++ b/drivers/accessibility/speakup/Makefile
@@ -40,7 +40,9 @@ hostprogs += makemapdata
 makemapdata-objs := makemapdata.o
 
 quiet_cmd_mkmap = MKMAP   $@
-      cmd_mkmap = TOPDIR=$(srctree) $(obj)/makemapdata > $@
+      cmd_mkmap = TOPDIR=$(srctree) \
+		  SPKDIR=$(if $(KBUILD_EXTMOD),$(KBUILD_EXTMOD),$(srctree)/drivers/accessibility/speakup) \
+		  $(obj)/makemapdata > $@
 
 $(obj)/mapdata.h: $(obj)/makemapdata
 	$(call cmd,mkmap)
--- a/drivers/accessibility/speakup/makemapdata.c
+++ b/drivers/accessibility/speakup/makemapdata.c
@@ -51,12 +51,15 @@ main(int argc, char *argv[])
 {
 	int value, i;
 	struct st_key *this;
-	const char *dir_name;
+	const char *dir_name, *spk_dir_name;
 	char *cp;
 
 	dir_name = getenv("TOPDIR");
 	if (!dir_name)
 		dir_name = ".";
+	spk_dir_name = getenv("SPKDIR");
+	if (!spk_dir_name)
+		spk_dir_name = "drivers/accessibility/speakup";
 	bzero(key_table, sizeof(key_table));
 	add_key("shift",	1, is_shift);
 	add_key("altgr",	2, is_shift);
@@ -83,7 +86,7 @@ main(int argc, char *argv[])
 			add_key(def_name, value, is_input);
 	}
 
-	open_input(dir_name, "drivers/accessibility/speakup/spk_priv_keyinfo.h");
+	open_input(spk_dir_name, "spk_priv_keyinfo.h");
 	while (get_define()) {
 		if (strlen(def_val) > 5) {
 			//if (def_val[0] == '(')
