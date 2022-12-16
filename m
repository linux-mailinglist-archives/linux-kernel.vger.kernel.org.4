Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E8F764F3E0
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 23:17:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbiLPWRn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 17:17:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbiLPWRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 17:17:25 -0500
Received: from mail-io1-xd4a.google.com (mail-io1-xd4a.google.com [IPv6:2607:f8b0:4864:20::d4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60B402A95F
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 14:17:24 -0800 (PST)
Received: by mail-io1-xd4a.google.com with SMTP id n10-20020a6b590a000000b006e03471b3eeso2016733iob.11
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 14:17:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=H+RvplB5wkPH74MUb1wifMfzO8M5nZWLX+/SXGO5TdI=;
        b=q0b1jj9NvHbp3f43Na/217O79cCxnY5MMJB+tmd2m4a9KAMjYiB8BlpdORdqG+ungW
         8rKFadTJM54bK/kumgRMVr1Yguw7JF71Hv3soXH7RaMR95ECsBNUxxq3e1WOSa+u2OI1
         1Y6ix2z7qAGh4XvWq0HnpSOSARb3/Zy5jlbl3nwZp6nIH3KtoMlRZXkF8EBLJGK7iYWk
         6niD7L0/pqfwMKn3UasRrTUGL8l+xEQJlvmdC1bwnoLHzUAGDpruXScii9m9DKrMoHDk
         /aWSB5puTi6SOEntsCfF2g/caz7oOkEyWLgRdcovsvqwpdvh1ZMq8KbdiMvYVh3WCVC5
         RcdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H+RvplB5wkPH74MUb1wifMfzO8M5nZWLX+/SXGO5TdI=;
        b=zMSa/gwC3ub2Upy36e7IPjXm0IU0g6Q5O4fs3jzrb2/zT52ZdR7DBer7VbHBsfSF+y
         x4mPnKHPtaIqMGXR2vJ/s1AfU9sUcDUk+4T1g4S1LdG5A72zjOgKKwsLpnAsgHIF+IUL
         VFGwzTlv2DR2odvkoZsbiVyYkTrKzfrtghGLEd+F21TzRq7TDTmRNArmkbDnbjCyTzhw
         J/nMtiM6FMY+OeAtoVkSIZ08TrYWRCTZnA9I1AEncMxUBu0kCt8oOmNhr6e7nHLCtmxa
         5t1/eH4mFeETQmB1hn8BrHRsjKg3mzeSIfquT6bDunoi1mXGC4CXFKT2FomHqLa90xZM
         x7Ig==
X-Gm-Message-State: AFqh2krf2WY7bJ4muvopHOsxuTakRvBWj9T88NUPnNekG7VW9mtA1Iqu
        TgWY95Xadt0rQcgKtRnC/ym7M4BxR6eHm2g=
X-Google-Smtp-Source: AMrXdXu/b3LbN3BaGO2amr3yvcbAu+UGbScQX6evGCe9lTPh9LFkZJroFCZzUk59lwh7ey7DgjWZfjQ4rBqCa6A=
X-Received: from allenwebb.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:12e8])
 (user=allenwebb job=sendgmr) by 2002:a6b:4415:0:b0:6e6:279:2e74 with SMTP id
 r21-20020a6b4415000000b006e602792e74mr235776ioa.10.1671229043653; Fri, 16 Dec
 2022 14:17:23 -0800 (PST)
Date:   Fri, 16 Dec 2022 16:17:01 -0600
In-Reply-To: <20221216221703.294683-1-allenwebb@google.com>
Mime-Version: 1.0
References: <Y5IA2NYE5IaAzNby@kroah.com> <20221216221703.294683-1-allenwebb@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20221216221703.294683-4-allenwebb@google.com>
Subject: [PATCH v7 3/5] modpost: Add -b option for emitting built-in aliases
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
index 2c80da0220c32..845f157d69ebc 100644
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
+	list_for_each_entry(mod, &modules, list) {
+		buf_write(&buf, mod->modalias_buf.p, mod->modalias_buf.pos);
+	}
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

