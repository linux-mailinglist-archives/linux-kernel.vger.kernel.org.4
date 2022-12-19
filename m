Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F14A0651458
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 21:47:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232757AbiLSUrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 15:47:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231726AbiLSUqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 15:46:40 -0500
Received: from mail-il1-x14a.google.com (mail-il1-x14a.google.com [IPv6:2607:f8b0:4864:20::14a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B2C21276F
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 12:46:30 -0800 (PST)
Received: by mail-il1-x14a.google.com with SMTP id j3-20020a056e02154300b00304bc968ef1so7171962ilu.4
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 12:46:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RHzej/1PRqREjwzL8yy+/gC2rwJnW9I5Nh9PS4uQu5Q=;
        b=qF7j3UMvzJCUsQLLBjLgzSlmOXfqeEaNvw3PLXzeRWDcyY3bD8OOA38EQdGqqCZrSa
         iZncq8o51eeujFRZtBj6GVXss1cKEXggq6R/z5mdQ5oGh7e4OTlkwSEut6Vgt5ailuuP
         Ed8N28NG0EMmlAF45ESity6Pkkw741SVRjm2mDeGj1255GePszv1dQ+FkisGc7bA9Zi+
         PxalhtbeDVQuKtLNXx40YFKl4kZTz7hZ9GB7/D2GRe8u5St+PZ3YIZZ29RK+RgepiQRB
         Zd9kHw0ZtKBVgwDl7AT/HspdSRo1e7RQggsVmuqHRJipm5Guv5SA6HoxE4OVIO2cVfY1
         Ztbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RHzej/1PRqREjwzL8yy+/gC2rwJnW9I5Nh9PS4uQu5Q=;
        b=yZEXx5zI4tw+CwOWp2hwvZGdXjdlLSPwwj89Jk3D6TwsHcKQGGqKwDKHGsaWPJLXo7
         cW9WVrT0sj14BpaOPqPcb1uezKdpeaeuA2BWrFzHLar2pE4tm6IOCEOWAueQ02b84Oxh
         mihp/AWNfSQm8IH2hEu3YQ2BSSk+U+UrVV0RCbjXy7Kd+t9TTdGbOtzigITw/7izVpry
         CBiB6Yi0lQ3f5HrWFRGG7kSxyh9ZgDYoMbvSu34QW1xhO5V+PYe/91xNyUVVZ33jj99G
         4SBA0CAWS+P0y7HXoLm9e/ZGzyUe0/CjVEp2IAvh13/QtA3MVYtdvdoqh1ezUURjbEVH
         YXoA==
X-Gm-Message-State: ANoB5pnWNml4qZywNi49JXiW7gELyfK6G3ZXxGpOwQkkUqieJSOro+CV
        adN0lQJQ2Vb8dY18kTNLfDPBRht2pSVqkv4=
X-Google-Smtp-Source: AA0mqf6P0aFwhaiO/Hq5T9Jzwbu4P/V1ES2mCZhd8CSbA9Dg3bOw2kpuFSOzPqyC1YM4SB2aGePgn2HQQq3dYk8=
X-Received: from allenwebb.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:12e8])
 (user=allenwebb job=sendgmr) by 2002:a92:cd83:0:b0:300:56a5:ae19 with SMTP id
 r3-20020a92cd83000000b0030056a5ae19mr43568707ilb.72.1671482789512; Mon, 19
 Dec 2022 12:46:29 -0800 (PST)
Date:   Mon, 19 Dec 2022 14:46:15 -0600
In-Reply-To: <20221219204619.2205248-1-allenwebb@google.com>
Mime-Version: 1.0
References: <20221219191855.2010466-1-allenwebb@google.com> <20221219204619.2205248-1-allenwebb@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20221219204619.2205248-8-allenwebb@google.com>
Subject: [PATCH v9 07/10] modpost: Add -b option for emitting built-in aliases
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

This adds an unimplemented command line flag for writing the built-in
aliases to a file.

Signed-off-by: Allen Webb <allenwebb@google.com>
---
 scripts/mod/modpost.c | 23 +++++++++++++++++++++--
 scripts/mod/modpost.h |  1 +
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 2c80da0220c3..e38d6b2ceea4 100644
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
index 34fe5fc0b02c..c55a6aeb46bf 100644
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

