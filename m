Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78F2F6C3ABB
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 20:35:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230378AbjCUTfK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 15:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbjCUTez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 15:34:55 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABBF0574E4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 12:34:22 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id x37so9252474pga.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 12:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679427230;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W3N8NUnKA3HwSL7nYHdw0w+EtU7IHilem2dLWFayh5k=;
        b=RbOrVHhg3QC92FG4M8NH1A9CHpBOxwgCfNcSU0r1ajVz1O3USM2vHkVvh3wqmGVdQz
         w+f/QA/GaY66tCL85qKkr2zlcANyXc2wW+koDAQuRRR8AffIlsQj4ELcBLyjUCct73MN
         r8mmWwVNQSFouKAV6BFpVTxmKN038rmDRdRBJmu2rKin58MgWUuyodQ/B407fFtmzDQG
         0nvD+H0HSr05VEAFjLsqsCgalo3CQCMaGmenpXLGoVfhM7W57CZ5wTGuEhmkgDtVKiuP
         q8TYytBLOhwsMtSeZC9Bwhby6mxn/xq7iBHHeg0ixpFCLPlivaoNXpX+i6VniUsfOuMZ
         I2ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679427230;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W3N8NUnKA3HwSL7nYHdw0w+EtU7IHilem2dLWFayh5k=;
        b=g4s/ZyQ/1ALhzTHYzmB7h8kehNWjIcxJ5Ojdm5wVAgGeXwzB+Q3qKQkn3nnXTNxkMy
         sw3e2JCJftXwB3OKpaV2HIdK4cFQresPfcmBWXadt3YhEpM5i9zK6J6qReWHd4Y9Qx/I
         pXhG+DM6FYNjOp3YvdT1xKBMFfs18hh8eau3NyHii+97RjKYOKOjF1D2TbbgqK30S9Tv
         6cyyx8zAqzKJbfyWkKswHFsMA1eKx6nqlLF7Jt4WZDod1ZycU5YOUCo3JajylNV/bGyf
         /tLwFZZ+45BfxRc2f0LMn6YqVHmkE2gNmYXsB37e7xLEUERt3H0kFjtbTcs97ftYgT9l
         3waw==
X-Gm-Message-State: AO0yUKXGmJxp0ueBo0TGd8A2Zvmxyj1RZr5cAyQxa+P19Z7qhCVN0C3E
        cfalQ/NOWfCxOy480BYgSEM=
X-Google-Smtp-Source: AK7set/Ca0O1fsLGwZB7jf/8/I6Zv7j9dJPZ3P31DwNOkJJ1pej1yb0uGNi/OJ4DXJ3ADX3x/04Yyg==
X-Received: by 2002:a62:7b8a:0:b0:625:83a1:78e8 with SMTP id w132-20020a627b8a000000b0062583a178e8mr855909pfc.19.1679427230059;
        Tue, 21 Mar 2023 12:33:50 -0700 (PDT)
Received: from f37.eng.vmware.com ([66.170.99.1])
        by smtp.googlemail.com with ESMTPSA id k23-20020aa790d7000000b006247123adf1sm8843044pfk.143.2023.03.21.12.33.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 12:33:49 -0700 (PDT)
From:   Shreenidhi Shedi <yesshedi@gmail.com>
X-Google-Original-From: Shreenidhi Shedi <sshedi@vmware.com>
To:     gregkh@linuxfoundation.org, dhowells@redhat.com,
        dwmw2@infradead.org
Cc:     linux-kernel@vger.kernel.org, sshedi@vmware.com, yesshedi@gmail.com
Subject: [PATCH v6 4/7] sign-file: add support to sign modules in bulk
Date:   Wed, 22 Mar 2023 01:03:38 +0530
Message-Id: <20230321193341.87997-5-sshedi@vmware.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230321193341.87997-1-sshedi@vmware.com>
References: <20230321193341.87997-1-sshedi@vmware.com>
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

