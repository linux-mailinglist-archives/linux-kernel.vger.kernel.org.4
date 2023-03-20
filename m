Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A20546C1EF3
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 19:04:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbjCTSER (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 14:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbjCTSDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 14:03:51 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8C511EFC7
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 10:57:58 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id y2so13008524pjg.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 10:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679335058;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VoVIua9utDq11xAPsz5lSfVj7QXIQk5YJj7MGTjSPUg=;
        b=ATT8mFncJNeD+xyFycVf9P6cOOF+7iJfO01my1xykjrhmEhKd1tf1stK9l6OGoG0/x
         /O2NptnKqwemx3PRVHzKzGI0+Wa4d1wVrU4A+erSKJaB9k99LkvPnEunBMHgw6qDQhfl
         LPsWCh+fX2SZIuFC3Vjtyw3bO4l6YBBP3vRd1kUKz/d1+/ISH8m13KZAGROnE0vEPRT5
         4xscsB8LGhxurhk8Fry8ADPJaodnj+OG6pmNIDwuZ4ZbYMULUYBZ+ExY4Mg+1cQZnnVG
         k//LWAfG9CQx5uDo7rBZi3j+C75dCiFJaDuicntAQCe84UMawoTBLS3gwcqLTL3FW3V8
         GCgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679335058;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VoVIua9utDq11xAPsz5lSfVj7QXIQk5YJj7MGTjSPUg=;
        b=nfm0Oz+B68dk7NuytsqZxbo7CsJ6zOtma4bxKqHzR4kk08bFiztxvxmmrzJEBTiJAd
         c3qjhVMPyPJpvb9Grx5puqNaq7gZPEHW7CDnhF2lMCrwidHNqCTq0VK9MmwIgz3e3oMN
         HrIjOZVYLJ05szRvZu0xn+mPeCM+Pta18PPau315ARjw3P0/IQ2QgA56rsGb1SBLfw8N
         gabD+cXqgn803nZoRVp9Uk/T1NQZTfko86sHJDktZlKQqCIySBi080LDtYzuP5Dj00qT
         M7dRSpu+7MWx+d7wC/KDPT6UUhJ8SSYgdtLMrfwlIXDRTmhjgNKfMWSAa4/a8NgdYqb2
         oDNQ==
X-Gm-Message-State: AO0yUKXg8sz4Qss5rQz+JV0bNjzwcrFP64CFjFCerfhLbtzHf497C4/f
        atgBNu5h7uEyrf29b/lk7mk=
X-Google-Smtp-Source: AK7set/Vz+k6hbes1Hmjn6l9KAHdOqp7nkutnHqC5TUiJQK/MWINRbSNDNBgCRh/jq68AEuvA4G8XQ==
X-Received: by 2002:a17:902:e852:b0:1a0:549d:399e with SMTP id t18-20020a170902e85200b001a0549d399emr20699843plg.21.1679335058234;
        Mon, 20 Mar 2023 10:57:38 -0700 (PDT)
Received: from f37.eng.vmware.com ([66.170.99.1])
        by smtp.googlemail.com with ESMTPSA id q2-20020a170902edc200b001a1a18a678csm7040042plk.148.2023.03.20.10.57.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 10:57:37 -0700 (PDT)
From:   Shreenidhi Shedi <yesshedi@gmail.com>
X-Google-Original-From: Shreenidhi Shedi <sshedi@vmware.com>
To:     gregkh@linuxfoundation.org, dhowells@redhat.com,
        dwmw2@infradead.org
Cc:     yesshedi@gmail.com, linux-kernel@vger.kernel.org, sshedi@vmware.com
Subject: [PATCH v5 2/7] sign-file: refactor argument parsing logic - 2
Date:   Mon, 20 Mar 2023 23:27:26 +0530
Message-Id: <20230320175731.79709-2-sshedi@vmware.com>
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

Introduce few new flags to make argument processing easy.
Also makes it easy to remember the options.

Signed-off-by: Shreenidhi Shedi <yesshedi@gmail.com>
---
 scripts/sign-file.c | 63 ++++++++++++++++++++++++++++++++-------------
 1 file changed, 45 insertions(+), 18 deletions(-)

diff --git a/scripts/sign-file.c b/scripts/sign-file.c
index 94228865b6cc..b0f340ea629b 100644
--- a/scripts/sign-file.c
+++ b/scripts/sign-file.c
@@ -215,6 +215,11 @@ static X509 *read_x509(const char *x509_name)
 
 struct cmd_opts {
 	char *raw_sig_name;
+	char *hash_algo;
+	char *dest_name;
+	char *private_key_name;
+	char *x509_name;
+	char *module_name;
 	bool save_sig;
 	bool replace_orig;
 	bool raw_sig;
@@ -233,6 +238,12 @@ static void parse_args(int argc, char **argv, struct cmd_opts *opts)
 #ifndef USE_PKCS7
 		{"usekeyid",	no_argument,	    0,	'k'},
 #endif
+		{"help",	no_argument,	    0,	'h'},
+		{"privkey",	required_argument,  0,	'i'},
+		{"hashalgo",	required_argument,  0,	'a'},
+		{"x509",	required_argument,  0,	'x'},
+		{"dest",	required_argument,  0,	'd'},
+		{"replaceorig",	required_argument,  0,	'r'},
 		{0, 0, 0, 0}
 	};
 
@@ -241,10 +252,10 @@ static void parse_args(int argc, char **argv, struct cmd_opts *opts)
 
 	do {
 #ifndef USE_PKCS7
-		opt = getopt_long_only(argc, argv, "pds:",
+		opt = getopt_long_only(argc, argv, "hpds:i:a:x:t:r:",
 				cmd_options, &opt_index);
 #else
-		opt = getopt_long_only(argc, argv, "pdks:",
+		opt = getopt_long_only(argc, argv, "hpdks:i:a:x:t:r:",
 				cmd_options, &opt_index);
 #endif
 		switch (opt) {
@@ -268,6 +279,30 @@ static void parse_args(int argc, char **argv, struct cmd_opts *opts)
 			break;
 #endif
 
+		case 'h':
+			format();
+			break;
+
+		case 'i':
+			opts->private_key_name = optarg;
+			break;
+
+		case 'a':
+			opts->hash_algo = optarg;
+			break;
+
+		case 'x':
+			opts->x509_name = optarg;
+			break;
+
+		case 't':
+			opts->dest_name = optarg;
+			break;
+
+		case 'r':
+			opts->replace_orig = true;
+			break;
+
 		case -1:
 			break;
 
@@ -281,9 +316,6 @@ static void parse_args(int argc, char **argv, struct cmd_opts *opts)
 int main(int argc, char **argv)
 {
 	struct module_signature sig_info = { .id_type = PKEY_ID_PKCS7 };
-	char *hash_algo = NULL;
-	char *private_key_name = NULL;
-	char *x509_name, *module_name, *dest_name;
 	unsigned char buf[4096];
 	unsigned long module_size, sig_size;
 	unsigned int use_signed_attrs;
@@ -315,32 +347,27 @@ int main(int argc, char **argv)
 	argv += optind;
 
 	const char *raw_sig_name = opts.raw_sig_name;
+	const char *hash_algo = opts.hash_algo;
+	const char *private_key_name = opts.private_key_name;
+	const char *x509_name = opts.x509_name;
+	const char *module_name = opts.module_name;
 	const bool save_sig = opts.save_sig;
 	const bool raw_sig = opts.raw_sig;
 	const bool sign_only = opts.sign_only;
 	bool replace_orig = opts.replace_orig;
+	char *dest_name = opts.dest_name;
 #ifndef USE_PKCS7
 	const unsigned int use_keyid = opts.use_keyid;
 #endif
 
-	if (argc < 4 || argc > 5)
+	if (!argv[0] || argc != 1)
 		format();
 
-	if (raw_sig) {
-		raw_sig_name = argv[0];
-		hash_algo = argv[1];
-	} else {
-		hash_algo = argv[0];
-		private_key_name = argv[1];
-	}
-	x509_name = argv[2];
-	module_name = argv[3];
-	if (argc == 5 && strcmp(argv[3], argv[4]) != 0) {
-		dest_name = argv[4];
+	if (dest_name && strcmp(argv[0], dest_name)) {
 		replace_orig = false;
 	} else {
 		ERR(asprintf(&dest_name, "%s.~signed~", module_name) < 0,
-		    "asprintf");
+				"asprintf");
 		replace_orig = true;
 	}
 
-- 
2.39.2
