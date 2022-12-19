Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C97D96512C7
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 20:19:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232752AbiLSTTs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 14:19:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232531AbiLSTTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 14:19:07 -0500
Received: from mail-il1-x149.google.com (mail-il1-x149.google.com [IPv6:2607:f8b0:4864:20::149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC3A912D20
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 11:19:06 -0800 (PST)
Received: by mail-il1-x149.google.com with SMTP id l13-20020a056e021c0d00b003034e24b866so7210765ilh.22
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 11:19:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=s1QcpBS4B8OCRMlI6Nk9ugzJN1lhkA3oxgxR2mhdmU8=;
        b=aZSbLaOZ+GBeKFR5sV7mPGP78KGpvjTZ3MVNmDTTr3vK2vxqlTxaSwFQJjSYRriUaB
         hBXx8NVlBOEdWV0XBakPDChmJfeYXq/KDIQtSrKNqPloEIfLgX2nHAG7k6X+lB1tnjYM
         0mFrrmAZ7Mmm3N+9dFxfanyG1qvWdmzDesSLvdrE11LszZWtyNsUREiJyWszo93d8/8s
         HkCNzmvjGCBnKWb9Mx+udAyuhWBHsxVW94Qy+oRRLOnen7JvimnimXhXLv1EQ45OwmKM
         bKoLNuibpikmWKZ2I7QHTSn0jSdnhlhqur/sdZeXpjlm3604hHGT//rcrgKdKoByq94H
         dY9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s1QcpBS4B8OCRMlI6Nk9ugzJN1lhkA3oxgxR2mhdmU8=;
        b=wf7fhBoPDXZHH5DxzUoQwOEB16PCgkRrOhCC6teAiD9F5o6BdaqKhpLWLitK984QeY
         kWyip3B+Vgu7NkLXR67773R1G0xr5RQW9i67OZub/dR3c8koOiJYUsv3JcYvlh0IezgB
         ZN64vsmBa5Ncl31t/7SkyI3S19KO/oMBJ/9G93+tim/DUEh+MyYgYc7ZLPs/Er8nkRC/
         yfsSKYKiM7NtRno9q/kd3h22uFGI1e42G3e14hv3vgKV6FGsESQHyena9F1NDuhkO3b2
         2GSrizGXUkixwRvCoSFKgNSnhQPsbmKntxNy+SsVeAvFtYDMpzGBdfLZl2V1pOKnX0Ii
         olSQ==
X-Gm-Message-State: ANoB5pmDp59MjwLybE7x7C5aUp+LdvY06JEePAJK1T8kku9dYBUIKiW9
        eR0TCQOsvkA0rWu/y9IzjMruqVBV4o/c2uU=
X-Google-Smtp-Source: AA0mqf76MaacOi4aEpvJ1Isi5klDCra6Jw1gbQxSu25hAbLCWIci9uOG76PMh89gkoiPFeNvKRhu/nk8686ayas=
X-Received: from allenwebb.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:12e8])
 (user=allenwebb job=sendgmr) by 2002:a02:c6a5:0:b0:38a:7bae:6a60 with SMTP id
 o5-20020a02c6a5000000b0038a7bae6a60mr5324846jan.37.1671477546412; Mon, 19 Dec
 2022 11:19:06 -0800 (PST)
Date:   Mon, 19 Dec 2022 13:18:53 -0600
In-Reply-To: <20221219191855.2010466-1-allenwebb@google.com>
Mime-Version: 1.0
References: <20221216221703.294683-1-allenwebb@google.com> <20221219191855.2010466-1-allenwebb@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20221219191855.2010466-8-allenwebb@google.com>
Subject: [PATCH v8 7/9] modpost: Add -b option for emitting built-in aliases
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

This adds an unimplemented command line flag for writing the built-in
aliases to a file.

Signed-off-by: Allen Webb <allenwebb@google.com>
---
 scripts/mod/modpost.c | 23 +++++++++++++++++++++--
 scripts/mod/modpost.h |  1 +
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 2c80da0220c32..e38d6b2ceea40 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -2165,6 +2165,19 @@ static void write_if_changed(struct buffer *b, const char *fname)
 	write_buf(b, fname);
 }
 
+/* Write the builtin aliases to the specified file. */
+static void write_builtin(const char *fname)
+{
+	struct buffer buf = { };
+	struct module *mod;
+
+	list_for_each_entry(mod, &modules, list)
+		buf_write(&buf, mod->modalias_buf.p, mod->modalias_buf.pos);
+
+	write_if_changed(&buf, fname);
+	free(buf.p);
+}
+
 static void write_vmlinux_export_c_file(struct module *mod)
 {
 	struct buffer buf = { };
@@ -2321,13 +2334,16 @@ int main(int argc, char **argv)
 {
 	struct module *mod;
 	char *missing_namespace_deps = NULL;
-	char *dump_write = NULL, *files_source = NULL;
+	char *builtin_write = NULL, *dump_write = NULL, *files_source = NULL;
 	int opt;
 	LIST_HEAD(dump_lists);
 	struct dump_list *dl, *dl2;
 
-	while ((opt = getopt(argc, argv, "ei:mnT:o:awENd:")) != -1) {
+	while ((opt = getopt(argc, argv, "b:ei:mnT:o:awENd:")) != -1) {
 		switch (opt) {
+		case 'b':
+			builtin_write = optarg;
+			break;
 		case 'e':
 			external_module = true;
 			break;
@@ -2390,6 +2406,9 @@ int main(int argc, char **argv)
 			write_mod_c_file(mod);
 	}
 
+	if (builtin_write)
+		write_builtin(builtin_write);
+
 	if (missing_namespace_deps)
 		write_namespace_deps_files(missing_namespace_deps);
 
diff --git a/scripts/mod/modpost.h b/scripts/mod/modpost.h
index 34fe5fc0b02cb..c55a6aeb46bfd 100644
--- a/scripts/mod/modpost.h
+++ b/scripts/mod/modpost.h
@@ -123,6 +123,7 @@ struct module {
 	bool has_init;
 	bool has_cleanup;
 	struct buffer dev_table_buf;
+	struct buffer modalias_buf;
 	char	     srcversion[25];
 	// Missing namespace dependencies
 	struct list_head missing_namespaces;
-- 
2.37.3

