Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6890A65144A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 21:47:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232853AbiLSUrT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 15:47:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232381AbiLSUqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 15:46:40 -0500
Received: from mail-io1-xd49.google.com (mail-io1-xd49.google.com [IPv6:2607:f8b0:4864:20::d49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBF4612D1C
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 12:46:30 -0800 (PST)
Received: by mail-io1-xd49.google.com with SMTP id e15-20020a056602158f00b006e01d8fa493so4614388iow.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 12:46:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ict2nAybZst9hd7blb/mqnDuFXGRQOU9mJnqBemEDUs=;
        b=s2ZrfNQOjBrSWOSByiZCQfYB433BmyIy/j3ly5GPI7q7DQSKjQaGWpR8OpY5yqR4up
         s/oCDPMg27vjwGrwVakCjp4cMNI3bT10VqVyYGG/KXoVAvy3X5gux1hPs+vi4/BDBB3M
         KwDWb6Jhedtm3NReW57ZGysB4WVkkexx2NoF17pNoEVKe1gWeqybIlgRLnARmU/966fe
         bfborkGMEPeQtjsE7fqcXAEvOEBGXFtMu9wq8FhFmfhYwwf529//Ho3A8hM019D3duWx
         jJCLpW3SvyBXZJdHFHUrepQKdzkQiRs1ZiPGq9+tWAKvGfkZODfY5IapcpB2YfBsy2iC
         GbYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ict2nAybZst9hd7blb/mqnDuFXGRQOU9mJnqBemEDUs=;
        b=maIH3A+7P16Q1aAC/LQhNS7tJWwmwlAjh64M+AJPGK/OaPNzTi+mCaMpwr8eAksB0U
         N4v5CVm9PJ+hB6DduRrR6ptY7/MflqCwZ+HZTgZmtfRB0d31byI2o0WXZgLGSKuTAFNJ
         nZsdNCfN66jb4IghzbU+fKb6QlucUVbFhGb7Mau4lsN6jsYnKIKsyfXKF1Ex8MaK483H
         r6YZ6QgJVl1rM/baZHecA/8a2F5TRxSxnn+EKhlamRVhvpqtWMDgRd671tly0+ktDtlk
         kQ0j3eAhZY6iCUBViG6XpRJJAcgp4LhIcuxOIpIUNCw630HIxkmhaR9wTheMOm0l1MMk
         OwVw==
X-Gm-Message-State: ANoB5pkIhbWyr00yPXoll1zJwADwuFXFtyvVHjgBxpsEVGO7MAoC+T0c
        KfxCZgBKjVpOSUnlKOMXkc4sS0yc4S/g3DM=
X-Google-Smtp-Source: AA0mqf4Vg7sPZKoxjDlHwlE7TekSeJ2HLUzyD0Y5TnfKfKOKbyyhiPH5BhZs8OQobjXMnrVrn44Buga/nbkrqDk=
X-Received: from allenwebb.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:12e8])
 (user=allenwebb job=sendgmr) by 2002:a05:6e02:c08:b0:303:4e51:e5b2 with SMTP
 id d8-20020a056e020c0800b003034e51e5b2mr11864457ile.285.1671482790594; Mon,
 19 Dec 2022 12:46:30 -0800 (PST)
Date:   Mon, 19 Dec 2022 14:46:16 -0600
In-Reply-To: <20221219204619.2205248-1-allenwebb@google.com>
Mime-Version: 1.0
References: <20221219191855.2010466-1-allenwebb@google.com> <20221219204619.2205248-1-allenwebb@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20221219204619.2205248-9-allenwebb@google.com>
Subject: [PATCH v9 08/10] file2alias.c: Implement builtin.alias generation
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
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
index e41ff8de7a87..e840cb51281a 100644
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

