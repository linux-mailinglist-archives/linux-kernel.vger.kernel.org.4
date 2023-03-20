Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF2086C1EF5
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 19:04:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbjCTSE0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 14:04:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjCTSDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 14:03:54 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07E19D537
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 10:58:02 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id ix20so13356453plb.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 10:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679335061;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W3N8NUnKA3HwSL7nYHdw0w+EtU7IHilem2dLWFayh5k=;
        b=okW7mklBqfYH/cFk1A3p3USRhYJrHSwQ5O3SgnAgGa9NVsJM13BxqZ6hNNi+CuM5pC
         91g1EtMeTieRd72SqLbjFBLI5OK/mtDV3clTpgzLQu6qABujRTWafjovt6AWKDssKQrk
         3Mk7oLbA0vb1wnF8VSYi4QcbMzYDT3FF2a/rU2EzV/xp0rCZ4iSdtP92JNKMksakGtPS
         PAwQ+BniuFZRSQXRLVNKhEzqGohVYlY0DkYI/x8jNsgOvkX0+ubTrkleqcKAtcRr0MJu
         F699zdzN0wXxWggrx4eQ02ev9j14FMh78FEXgGmF5H84Rwcqp5OA6pe6iHhTQ7IdfaG3
         7b1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679335061;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W3N8NUnKA3HwSL7nYHdw0w+EtU7IHilem2dLWFayh5k=;
        b=EO6059hnbelqOPyB8ntrMss5cL9aOjn6bWiyVjJzehZI4ZVwSANB5nohgoxjBSRq2S
         xW3T7+4koW6HgXZuLv78XXpek4xltP26TBaX8unUbvbKtmerPgfRGbqmB2tSZULMgNOP
         fif4MUdCQYHWwZvyxkofUVIl0lk79p+xSVut5FQB03OfLn/FHprERbNj1EUB2F2hUysc
         +i1xpXM9FlHABQ8fZNqaEBLRt/kmmRGSuPALHsc/EpotRrUu5AvP0k2tXH0Q0hD+jRbE
         NywxS0bj9yu7b+XWar1T5nIpUKKj+XhSn5Y9eI7MF919qNTeSha/I3ImcebKeCK8DbYQ
         6O7g==
X-Gm-Message-State: AO0yUKWLNasen/aJypfj7y84IgJp656/Y/WaXW6d2HiKGLbjbU0uwAhu
        naazhsSDMeImZmHsiC6g5S8=
X-Google-Smtp-Source: AK7set+WR03lqXSj6CEF7ma+jAFqUlBiS0DDQKMN3aGZssJy7gk1oflmGRTLtiYGXTHJCygovxzdSw==
X-Received: by 2002:a17:902:f68f:b0:19f:367a:1d78 with SMTP id l15-20020a170902f68f00b0019f367a1d78mr22178188plg.29.1679335060867;
        Mon, 20 Mar 2023 10:57:40 -0700 (PDT)
Received: from f37.eng.vmware.com ([66.170.99.1])
        by smtp.googlemail.com with ESMTPSA id q2-20020a170902edc200b001a1a18a678csm7040042plk.148.2023.03.20.10.57.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 10:57:40 -0700 (PDT)
From:   Shreenidhi Shedi <yesshedi@gmail.com>
X-Google-Original-From: Shreenidhi Shedi <sshedi@vmware.com>
To:     gregkh@linuxfoundation.org, dhowells@redhat.com,
        dwmw2@infradead.org
Cc:     yesshedi@gmail.com, linux-kernel@vger.kernel.org, sshedi@vmware.com
Subject: [PATCH v5 4/7] sign-file: add support to sign modules in bulk
Date:   Mon, 20 Mar 2023 23:27:28 +0530
Message-Id: <20230320175731.79709-4-sshedi@vmware.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230320175731.79709-1-sshedi@vmware.com>
References: <20230320175731.79709-1-sshedi@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shreenidhi Shedi <yesshedi@gmail.com>

In the existing system, we need to invoke sign-file binary for every
module we want to sign. This patch adds support to give modules list
in bulk and it will sign them all one by one.

Signed-off-by: Shreenidhi Shedi <yesshedi@gmail.com>
---
 scripts/sign-file.c | 41 +++++++++++++++++++++++++++--------------
 1 file changed, 27 insertions(+), 14 deletions(-)

diff --git a/scripts/sign-file.c b/scripts/sign-file.c
index 64d5e00f08e2..0a275256ca16 100644
--- a/scripts/sign-file.c
+++ b/scripts/sign-file.c
@@ -224,6 +224,7 @@ struct cmd_opts {
 	bool replace_orig;
 	bool raw_sig;
 	bool sign_only;
+	bool bulk_sign;
 #ifndef USE_PKCS7
 	unsigned int use_keyid;
 #endif
@@ -252,10 +253,10 @@ static void parse_args(int argc, char **argv, struct cmd_opts *opts)
 
 	do {
 #ifndef USE_PKCS7
-		opt = getopt_long_only(argc, argv, "hpds:i:a:x:t:r:",
+		opt = getopt_long_only(argc, argv, "hpdbs:i:a:x:t:r:",
 				cmd_options, &opt_index);
 #else
-		opt = getopt_long_only(argc, argv, "hpdks:i:a:x:t:r:",
+		opt = getopt_long_only(argc, argv, "hpdkbs:i:a:x:t:r:",
 				cmd_options, &opt_index);
 #endif
 		switch (opt) {
@@ -303,6 +304,10 @@ static void parse_args(int argc, char **argv, struct cmd_opts *opts)
 			opts->replace_orig = true;
 			break;
 
+		case 'b':
+			opts->bulk_sign = true;
+			break;
+
 		case -1:
 			break;
 
@@ -460,26 +465,34 @@ static int sign_single_file(struct cmd_opts *opts)
 
 int main(int argc, char **argv)
 {
+	int i;
 	struct cmd_opts opts = {};
 
 	parse_args(argc, argv, &opts);
 	argc -= optind;
 	argv += optind;
 
-	if (!argv[0] || argc != 1)
-		format();
-
-	if (opts.dest_name && strcmp(argv[0], opts.dest_name)) {
-		opts.replace_orig = false;
-	} else {
-		ERR(asprintf(&opts.dest_name, "%s.~signed~", opts.module_name) < 0,
-				"asprintf");
-		opts.replace_orig = true;
-	}
-
 	OpenSSL_add_all_algorithms();
 	ERR_load_crypto_strings();
 	ERR_clear_error();
 
-	return sign_single_file(&opts);
+	for (i = 0; i < argc; ++i) {
+		opts.module_name = argv[i];
+
+		if (!opts.bulk_sign && opts.dest_name && strcmp(argv[i], opts.dest_name)) {
+			opts.replace_orig = false;
+		} else {
+			ERR(asprintf(&opts.dest_name, "%s.~signed~", opts.module_name) < 0,
+				     "asprintf");
+			if (!opts.replace_orig)
+				opts.replace_orig = true;
+		}
+
+		if (sign_single_file(&opts)) {
+			fprintf(stderr, "Failed to sign: %s module\n", opts.module_name);
+			return -1;
+		}
+	}
+
+	return 0;
 }
-- 
2.39.2
