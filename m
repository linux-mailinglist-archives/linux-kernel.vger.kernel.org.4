Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECF0C622C65
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 14:31:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbiKINbG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 08:31:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbiKINbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 08:31:03 -0500
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [IPv6:2a02:1800:120:4::f00:13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 402B72019B
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 05:31:01 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed10:410d:c657:be54:f60b])
        by baptiste.telenet-ops.be with bizsmtp
        id iDWy2800547WmLZ01DWyVa; Wed, 09 Nov 2022 14:30:58 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1oslAP-0006eV-NE; Wed, 09 Nov 2022 14:30:57 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1oslAP-001cAv-3O; Wed, 09 Nov 2022 14:30:57 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] modpost: Join broken long printed messages
Date:   Wed,  9 Nov 2022 14:30:55 +0100
Message-Id: <d7365c44c13b563e9576cf23bd68d64e5ea57f6f.1668000538.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Breaking long printed messages in multiple lines makes it very hard to
look up where they originated from.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 scripts/mod/file2alias.c | 18 +++++++-----------
 scripts/mod/modpost.c    |  8 +++-----
 2 files changed, 10 insertions(+), 16 deletions(-)

diff --git a/scripts/mod/file2alias.c b/scripts/mod/file2alias.c
index 80d973144fded3b1..7df23905fdf1cb36 100644
--- a/scripts/mod/file2alias.c
+++ b/scripts/mod/file2alias.c
@@ -140,25 +140,22 @@ static void device_id_check(const char *modname, const char *device_id,
 	int i;
 
 	if (size % id_size || size < id_size) {
-		fatal("%s: sizeof(struct %s_device_id)=%lu is not a modulo "
-		      "of the size of "
-		      "section __mod_%s__<identifier>_device_table=%lu.\n"
-		      "Fix definition of struct %s_device_id "
-		      "in mod_devicetable.h\n",
+		fatal("%s: sizeof(struct %s_device_id)=%lu is not a modulo of the size of section __mod_%s__<identifier>_device_table=%lu.\n"
+		      "Fix definition of struct %s_device_id in mod_devicetable.h\n",
 		      modname, device_id, id_size, device_id, size, device_id);
 	}
 	/* Verify last one is a terminator */
 	for (i = 0; i < id_size; i++ ) {
 		if (*(uint8_t*)(symval+size-id_size+i)) {
-			fprintf(stderr,"%s: struct %s_device_id is %lu bytes.  "
-				"The last of %lu is:\n",
+			fprintf(stderr,
+				"%s: struct %s_device_id is %lu bytes.  The last of %lu is:\n",
 				modname, device_id, id_size, size / id_size);
 			for (i = 0; i < id_size; i++ )
 				fprintf(stderr,"0x%02x ",
 					*(uint8_t*)(symval+size-id_size+i) );
 			fprintf(stderr,"\n");
-			fatal("%s: struct %s_device_id is not terminated "
-				"with a NULL entry!\n", modname, device_id);
+			fatal("%s: struct %s_device_id is not terminated with a NULL entry!\n",
+			      modname, device_id);
 		}
 	}
 }
@@ -1154,8 +1151,7 @@ static int do_amba_entry(const char *filename,
 	DEF_FIELD(symval, amba_id, mask);
 
 	if ((id & mask) != id)
-		fatal("%s: Masked-off bit(s) of AMBA device ID are non-zero: "
-		      "id=0x%08X, mask=0x%08X.  Please fix this driver.\n",
+		fatal("%s: Masked-off bit(s) of AMBA device ID are non-zero: id=0x%08X, mask=0x%08X.  Please fix this driver.\n",
 		      filename, id, mask);
 
 	p += sprintf(alias, "amba:d");
diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 2c80da0220c326ef..56d856f2e5115150 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -519,9 +519,8 @@ static int parse_elf(struct elf_info *info, const char *filename)
 		int nobits = sechdrs[i].sh_type == SHT_NOBITS;
 
 		if (!nobits && sechdrs[i].sh_offset > info->size) {
-			fatal("%s is truncated. sechdrs[i].sh_offset=%lu > "
-			      "sizeof(*hrd)=%zu\n", filename,
-			      (unsigned long)sechdrs[i].sh_offset,
+			fatal("%s is truncated. sechdrs[i].sh_offset=%lu > sizeof(*hrd)=%zu\n",
+			      filename, (unsigned long)sechdrs[i].sh_offset,
 			      sizeof(*hdr));
 			return 0;
 		}
@@ -1355,8 +1354,7 @@ static void report_extable_warnings(const char* modname, struct elf_info* elf,
 	get_pretty_name(is_function(tosym),
 			&to_pretty_name, &to_pretty_name_p);
 
-	warn("%s(%s+0x%lx): Section mismatch in reference"
-	     " from the %s %s%s to the %s %s:%s%s\n",
+	warn("%s(%s+0x%lx): Section mismatch in reference from the %s %s%s to the %s %s:%s%s\n",
 	     modname, fromsec, (long)r->r_offset, from_pretty_name,
 	     fromsym_name, from_pretty_name_p,
 	     to_pretty_name, tosec, tosym_name, to_pretty_name_p);
-- 
2.25.1

