Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA8873BAD3
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 16:55:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232307AbjFWOyi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 10:54:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232290AbjFWOyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 10:54:13 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C896C269F
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 07:54:10 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-25edd424306so387041a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 07:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687532050; x=1690124050;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HqI+jXiAb0jcxHpq4/ZvjHZIHoyoVWwys0Is6IBVtM4=;
        b=c7bVD2YqKdyMzSGPhz4TOny1+Qb4TwaWbuHNvVVPsXGymU8PBpSBB7YXd6tmnlwOdH
         Ot34B6rVYlN8bEl+XI2Kdl8/koz1Hhja4newfYKNa24/X8r9iTmMf3tdS5ifIr+lRJCy
         fqAAykiSbEpNft+YNWOsA49i1/QH2Qh79IYWqYqLgszH2z8nDaH5scSw+7mHb/jgmUyh
         1w8c3H/KHOaff8WHW5WTYVV+uxNjJJ9pI5cOLwAf2C9lEV9khVjjhHc0A2s+X9HSsHjo
         4i8vv8rhRmyTTsNlhzyM/ENwx3RriiiMXsqqwQonObg8hxzcLZAocmzMa1kPcmXfaViJ
         5kPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687532050; x=1690124050;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HqI+jXiAb0jcxHpq4/ZvjHZIHoyoVWwys0Is6IBVtM4=;
        b=lkZ2ZI/alMLYlKf79dRypZRYZdi7nb+4TGdlzJjn+pPd2vuJD1p6WBMk7rkyECc525
         D4auiWDP4CZJCQb5x4ueF7w44+oJOEn9am0oMon3YPuMmGTgKI4i3lTUBcphQdrLG++3
         02WMzcukPSE/tOP9g1uo8NJdxZoy8FQIH46Yjyy0LllPpj9ex26+pJ6nUWh50Rd2hjGY
         77CR0f4w3Z5eAQPeLKKnubJVwf0fLLMfvdpQBZypJI1UULaZY2bvNkXLljCYI1+N16Tp
         xCHAIy0t4CWDZVX4Ef2RJtGvtxgbd05xSPcruByb/yrgP1m+/UCCx+ptIVYbw2Mf1Vtm
         +f0Q==
X-Gm-Message-State: AC+VfDzRwPVHzn3ez+vYQA9Lt93DeL6xYYPBvRmVKCaATyDofD3QOXPd
        G/CmI4MSf9455kC1dO75y1tHrfejhVK4bQ==
X-Google-Smtp-Source: ACHHUZ4A7csCluvi7r2otQ1nc0UzpHldVSx2HeNZ1vMkd4tjGszPf85LyWA6hf+czRvanEClC6t/zg==
X-Received: by 2002:a17:90a:6f02:b0:25b:c528:8456 with SMTP id d2-20020a17090a6f0200b0025bc5288456mr10924793pjk.25.1687532050234;
        Fri, 23 Jun 2023 07:54:10 -0700 (PDT)
Received: from f38.eng.vmware.com ([66.170.99.1])
        by smtp.googlemail.com with ESMTPSA id fa17-20020a17090af0d100b002565cd237cdsm3359624pjb.3.2023.06.23.07.54.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 07:54:09 -0700 (PDT)
From:   Shreenidhi Shedi <yesshedi@gmail.com>
To:     dhowells@redhat.com, dwmw2@infradead.org,
        gregkh@linuxfoundation.org, masahiroy@kernel.org,
        nathan@kernel.org, ndesaulniers@google.com, nicolas@fjasle.eu
Cc:     yesshedi@gmail.com, linux-kernel@vger.kernel.org, sshedi@vmware.com
Subject: [PATCH v7 2/8] sign-file: inntroduce few new flags to make argument processing easy.
Date:   Fri, 23 Jun 2023 20:23:52 +0530
Message-ID: <20230623145358.568971-3-yesshedi@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230623145358.568971-1-yesshedi@gmail.com>
References: <20230623145358.568971-1-yesshedi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- Add some more options like help, x509, hashalgo to command line args
- This makes it easy to handle and use command line args wherever needed

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
2.41.0

