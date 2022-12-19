Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E6096512C6
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 20:19:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232744AbiLSTTl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 14:19:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232386AbiLSTTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 14:19:09 -0500
Received: from mail-io1-xd4a.google.com (mail-io1-xd4a.google.com [IPv6:2607:f8b0:4864:20::d4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 276F511C0C
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 11:19:08 -0800 (PST)
Received: by mail-io1-xd4a.google.com with SMTP id n10-20020a6b590a000000b006e03471b3eeso4473869iob.11
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 11:19:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cjGe6fxSS7cTt3mra7vAbJD0wH3tbfNYD/FCvl4NRMk=;
        b=FwO+EN0GRH6yMNy3i+aRaQi4k6ltrzQBDq0j2HgKcM4M/i0+GG/Tmh4ilo2ihykEDy
         Z3DOBVb7Hmq/tEN1Fv7roWQ+ePXHhHxxxbUSha5Tue3vGD0YSCIw5CdxZJ10vUa7j4sz
         /DDGenrw2NvJi/Pse/FoKztr5v6NXg/S7iy9zlEKswHs50EeHpMw/wCmWIvNVAAl/sJQ
         nVcs8jSLbqOYsGA7sZaPExqgzl0/OLlwn7nJM5YDweKk2lSBKB2VNh6AdN/9jDCPPRDt
         k8HINHwwMp2JVSAhC7XTE1zZqkTsd+OcFG5w7tdcU20hhKaWWMZrWhIcKMp2nvsSChQ9
         4WzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cjGe6fxSS7cTt3mra7vAbJD0wH3tbfNYD/FCvl4NRMk=;
        b=wlfurP+ETf7jho14DmPMb7DWSoDJJJTIG3/CYT75pRShF9OTphsOsz3BHhZJ+nTeZZ
         nkJS4Ki01AO/xSHHL/UVJp2aeFbn7AmoKt8ZAiBsw4irpIXTpAH4NyN8tTPV1jPjq9J8
         Sktfi+jcot4YXyOVc2oa4YysqO/yswEKX2x8EdcNYNw0DQ0hy92wr/cFO5gOOFXm0FaX
         1X+sH4F9b+CsDG7q2JbXFhHCSSt7N1D77XMH6tYGOVBNf1mzCiXtm7IhBjDdiZblYgHm
         o7H74EyCJ3LKGN/Z9+woTDlEqqrdlQdZAue0QIxXjasJFfKgAofGjqElu0LUiusHqVS+
         P5HA==
X-Gm-Message-State: AFqh2kpiMjPPmsX1wsqrz7bA9F8exKNWioOAdhzK8ya8ZxEOvog86zYu
        KJ/GDbW6h2ujLgXi1Dm8rgAjj9DgEMm5vxc=
X-Google-Smtp-Source: AMrXdXtEWFR5m+TguTy7DMteh2YUscW21cjm7GoJQqd4O805GlSojiqfl7ZGAJOibTR3VFOZRn9mfAPK7+rMVYU=
X-Received: from allenwebb.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:12e8])
 (user=allenwebb job=sendgmr) by 2002:a05:6e02:2207:b0:30b:c336:8a83 with SMTP
 id j7-20020a056e02220700b0030bc3368a83mr61889ilf.92.1671477547452; Mon, 19
 Dec 2022 11:19:07 -0800 (PST)
Date:   Mon, 19 Dec 2022 13:18:54 -0600
In-Reply-To: <20221219191855.2010466-1-allenwebb@google.com>
Mime-Version: 1.0
References: <20221216221703.294683-1-allenwebb@google.com> <20221219191855.2010466-1-allenwebb@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20221219191855.2010466-9-allenwebb@google.com>
Subject: [PATCH v8 8/9] file2alias.c: Implement builtin.alias generation
From:   Allen Webb <allenwebb@google.com>
To:     "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Allen Webb <allenwebb@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This populates the mod->modalias_buf with aliases for built-in modules
when modpost is run against vmlinuz.o.

Signed-off-by: Allen Webb <allenwebb@google.com>
---
 scripts/mod/file2alias.c | 55 +++++++++++++++++++++++++++-------------
 1 file changed, 38 insertions(+), 17 deletions(-)

diff --git a/scripts/mod/file2alias.c b/scripts/mod/file2alias.c
index e41ff8de7a876..e840cb51281a4 100644
--- a/scripts/mod/file2alias.c
+++ b/scripts/mod/file2alias.c
@@ -232,6 +232,8 @@ static void do_usb_entry(void *symval,
 	add_wildcard(alias);
 	buf_printf(&mod->dev_table_buf,
 		   "MODULE_ALIAS(\"%s\");\n", alias);
+	if (mod->builtin_name)
+		buf_printf(&mod->modalias_buf, "alias %s %s\n", alias, mod->builtin_name);
 }
 
 /* Handles increment/decrement of BCD formatted integers */
@@ -376,9 +378,13 @@ static void do_of_entry_multi(void *symval, struct module *mod)
 			*tmp = '_';
 
 	buf_printf(&mod->dev_table_buf, "MODULE_ALIAS(\"%s\");\n", alias);
+	if (mod->builtin_name)
+		buf_printf(&mod->modalias_buf, "alias %s %s\n", alias, mod->builtin_name);
 	strcat(alias, "C");
 	add_wildcard(alias);
 	buf_printf(&mod->dev_table_buf, "MODULE_ALIAS(\"%s\");\n", alias);
+	if (mod->builtin_name)
+		buf_printf(&mod->modalias_buf, "alias %s %s\n", alias, mod->builtin_name);
 }
 
 static void do_of_table(void *symval, unsigned long size,
@@ -610,12 +616,18 @@ static void do_pnp_device_entry(void *symval, unsigned long size,
 
 		buf_printf(&mod->dev_table_buf,
 			   "MODULE_ALIAS(\"pnp:d%s*\");\n", *id);
+		if (mod->builtin_name)
+			buf_printf(&mod->modalias_buf, "alias pnp:d%s* %s\n",
+				   *id, mod->builtin_name);
 
 		/* fix broken pnp bus lowercasing */
 		for (j = 0; j < sizeof(acpi_id); j++)
 			acpi_id[j] = toupper((*id)[j]);
 		buf_printf(&mod->dev_table_buf,
 			   "MODULE_ALIAS(\"acpi*:%s:*\");\n", acpi_id);
+		if (mod->builtin_name)
+			buf_printf(&mod->modalias_buf, "alias acpi*:%s:* %s\n",
+				   acpi_id, mod->builtin_name);
 	}
 }
 
@@ -637,6 +649,8 @@ static void do_pnp_card_entries(void *symval, unsigned long size,
 			const char *id = (char *)(*devs)[j].id;
 			int i2, j2;
 			int dup = 0;
+			char acpi_id[PNP_ID_LEN];
+			int k;
 
 			if (!id[0])
 				break;
@@ -662,19 +676,23 @@ static void do_pnp_card_entries(void *symval, unsigned long size,
 			}
 
 			/* add an individual alias for every device entry */
-			if (!dup) {
-				char acpi_id[PNP_ID_LEN];
-				int k;
-
-				buf_printf(&mod->dev_table_buf,
-					   "MODULE_ALIAS(\"pnp:d%s*\");\n", id);
-
-				/* fix broken pnp bus lowercasing */
-				for (k = 0; k < sizeof(acpi_id); k++)
-					acpi_id[k] = toupper(id[k]);
-				buf_printf(&mod->dev_table_buf,
-					   "MODULE_ALIAS(\"acpi*:%s:*\");\n", acpi_id);
-			}
+			if (dup)
+				continue;
+
+			buf_printf(&mod->dev_table_buf,
+				   "MODULE_ALIAS(\"pnp:d%s*\");\n", id);
+			if (mod->builtin_name)
+				buf_printf(&mod->modalias_buf, "alias pnp:d%s* %s\n",
+					   id, mod->builtin_name);
+
+			/* fix broken pnp bus lowercasing */
+			for (k = 0; k < sizeof(acpi_id); k++)
+				acpi_id[k] = toupper(id[k]);
+			buf_printf(&mod->dev_table_buf,
+				   "MODULE_ALIAS(\"acpi*:%s:*\");\n", acpi_id);
+			if (mod->builtin_name)
+				buf_printf(&mod->modalias_buf, "alias acpi*:%s:* %s\n",
+					   acpi_id, mod->builtin_name);
 		}
 	}
 }
@@ -1476,10 +1494,13 @@ static void do_table(void *symval, unsigned long size,
 	size -= id_size;
 
 	for (i = 0; i < size; i += id_size) {
-		if (do_entry(mod->name, symval+i, alias)) {
-			buf_printf(&mod->dev_table_buf,
-				   "MODULE_ALIAS(\"%s\");\n", alias);
-		}
+		if (!do_entry(mod->name, symval + i, alias))
+			continue;
+		buf_printf(&mod->dev_table_buf, "MODULE_ALIAS(\"%s\");\n", alias);
+		if (!mod->builtin_name)
+			continue;
+		buf_printf(&mod->modalias_buf, "alias %s %s\n", alias,
+			   mod->builtin_name);
 	}
 }
 
-- 
2.37.3

