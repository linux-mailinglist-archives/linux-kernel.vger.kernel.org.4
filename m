Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E971A73BAD5
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 16:55:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231896AbjFWOyf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 10:54:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232180AbjFWOyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 10:54:12 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5389A2129
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 07:54:09 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-54f87d5f1abso496672a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 07:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687532049; x=1690124049;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sshxUFVbctBDVN/rzug39I/npfxRGzCIXVTdlhheim4=;
        b=aV+w+QdnTMPEgtAxSnEPVBrowL4sCzj1zxLUTgcS/D3soEeeHLg5znUfS4Mun8ImYO
         Enyuw7T3zgEU0qGqhgcGivcSLBebSuCF2G9tbU/rbfa3hzPH3iTpiCWVPkhLE7nFFW1N
         HclXKwAql3+PC7DKPKQfkSaZfl/J65Q2eUfMvS0KlnoMTZnQZDYlr3xzk7QMffuI8nRA
         Jc5v2izQrD1m/05z+UahiwLXGNqBBib27Kpe4ybEUzOgCjhVIHjhkHe8K0FwQ+roGCB3
         XQZ4IfjXYCZWI6AKxYBXadGbkICVmj07lvUFtoV5A1VLrAzHDVWofhDwoCYYqWWNQaR9
         626A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687532049; x=1690124049;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sshxUFVbctBDVN/rzug39I/npfxRGzCIXVTdlhheim4=;
        b=dSmEAIbvUyZ56QpeGIKzpC9lHHrn4iMsymrAacVSSfSapcswIegDTw12opac9fYrGl
         GX/WP0T9b+7Zl4xC2GjkYq7H084Ey/UlkqXX6JyjKlB+YOay8AECSZl6Nig1kJpc8zn2
         b9vcLhetVUmYMvr1veQRC8iL5n4zvM4pom22n4Kj7vBrUzyo0g1du9pYV/URIaFHZmxV
         i90naVIpLM+1gCdWfnJgaQMqK4OfMPfWaIlXC2rhcRG8HWYjgY4DQHMBRYuUFGiadxPx
         h6EHw5d/C76GbK6ChYDr9kxIK/zdlpPtxiTCBOzhtHdCJ5qupzFrr13cfC4ZcM6O5+Tr
         qfKw==
X-Gm-Message-State: AC+VfDwBYZTFTB+csUfMsjD7TEtT6h+nGZhgL6P+gqaD27483xcT2gfA
        uw4k0UcKG478RtNsgkR0tFQ=
X-Google-Smtp-Source: ACHHUZ42QZiOQDKqsN2Odlmo/rivKXoxShiB4PnboHNtFikVHzo6x2vGUlC+45ih93U0OluT4RnQjg==
X-Received: by 2002:a17:90b:30c9:b0:25b:bff5:5310 with SMTP id hi9-20020a17090b30c900b0025bbff55310mr13762092pjb.14.1687532048696;
        Fri, 23 Jun 2023 07:54:08 -0700 (PDT)
Received: from f38.eng.vmware.com ([66.170.99.1])
        by smtp.googlemail.com with ESMTPSA id fa17-20020a17090af0d100b002565cd237cdsm3359624pjb.3.2023.06.23.07.54.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 07:54:08 -0700 (PDT)
From:   Shreenidhi Shedi <yesshedi@gmail.com>
To:     dhowells@redhat.com, dwmw2@infradead.org,
        gregkh@linuxfoundation.org, masahiroy@kernel.org,
        nathan@kernel.org, ndesaulniers@google.com, nicolas@fjasle.eu
Cc:     yesshedi@gmail.com, linux-kernel@vger.kernel.org, sshedi@vmware.com
Subject: [PATCH v7 1/8] sign-file: use getopt_long_only for parsing input args
Date:   Fri, 23 Jun 2023 20:23:51 +0530
Message-ID: <20230623145358.568971-2-yesshedi@gmail.com>
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

- getopt_long_only gives an option to use long names for options, so
  using it here to make the app usage easier.

- Use more easy to remember command line argument names

- Introduce cmd_opts structure to ease the handling of command line args

Signed-off-by: Shreenidhi Shedi <yesshedi@gmail.com>
---
 scripts/sign-file.c | 97 ++++++++++++++++++++++++++++++++++++---------
 1 file changed, 78 insertions(+), 19 deletions(-)

diff --git a/scripts/sign-file.c b/scripts/sign-file.c
index 598ef5465f82..94228865b6cc 100644
--- a/scripts/sign-file.c
+++ b/scripts/sign-file.c
@@ -213,15 +213,77 @@ static X509 *read_x509(const char *x509_name)
 	return x509;
 }
 
+struct cmd_opts {
+	char *raw_sig_name;
+	bool save_sig;
+	bool replace_orig;
+	bool raw_sig;
+	bool sign_only;
+#ifndef USE_PKCS7
+	unsigned int use_keyid;
+#endif
+};
+
+static void parse_args(int argc, char **argv, struct cmd_opts *opts)
+{
+	struct option cmd_options[] = {
+		{"rawsig",	required_argument,  0,	's'},
+		{"savesig",	no_argument,	    0,	'p'},
+		{"signonly",	no_argument,	    0,	'd'},
+#ifndef USE_PKCS7
+		{"usekeyid",	no_argument,	    0,	'k'},
+#endif
+		{0, 0, 0, 0}
+	};
+
+	int opt;
+	int opt_index = 0;
+
+	do {
+#ifndef USE_PKCS7
+		opt = getopt_long_only(argc, argv, "pds:",
+				cmd_options, &opt_index);
+#else
+		opt = getopt_long_only(argc, argv, "pdks:",
+				cmd_options, &opt_index);
+#endif
+		switch (opt) {
+		case 's':
+			opts->raw_sig = true;
+			opts->raw_sig_name = optarg;
+			break;
+
+		case 'p':
+			opts->save_sig = true;
+			break;
+
+		case 'd':
+			opts->sign_only = true;
+			opts->save_sig = true;
+			break;
+
+#ifndef USE_PKCS7
+		case 'k':
+			opts->use_keyid = CMS_USE_KEYID;
+			break;
+#endif
+
+		case -1:
+			break;
+
+		default:
+			format();
+			break;
+		}
+	} while (opt != -1);
+}
+
 int main(int argc, char **argv)
 {
 	struct module_signature sig_info = { .id_type = PKEY_ID_PKCS7 };
 	char *hash_algo = NULL;
-	char *private_key_name = NULL, *raw_sig_name = NULL;
+	char *private_key_name = NULL;
 	char *x509_name, *module_name, *dest_name;
-	bool save_sig = false, replace_orig;
-	bool sign_only = false;
-	bool raw_sig = false;
 	unsigned char buf[4096];
 	unsigned long module_size, sig_size;
 	unsigned int use_signed_attrs;
@@ -229,13 +291,14 @@ int main(int argc, char **argv)
 	EVP_PKEY *private_key;
 #ifndef USE_PKCS7
 	CMS_ContentInfo *cms = NULL;
-	unsigned int use_keyid = 0;
 #else
 	PKCS7 *pkcs7 = NULL;
 #endif
 	X509 *x509;
 	BIO *bd, *bm;
-	int opt, n;
+	int n;
+	struct cmd_opts opts = {};
+
 	OpenSSL_add_all_algorithms();
 	ERR_load_crypto_strings();
 	ERR_clear_error();
@@ -247,23 +310,19 @@ int main(int argc, char **argv)
 #else
 	use_signed_attrs = PKCS7_NOATTR;
 #endif
+	parse_args(argc, argv, &opts);
+	argc -= optind;
+	argv += optind;
 
-	do {
-		opt = getopt(argc, argv, "sdpk");
-		switch (opt) {
-		case 's': raw_sig = true; break;
-		case 'p': save_sig = true; break;
-		case 'd': sign_only = true; save_sig = true; break;
+	const char *raw_sig_name = opts.raw_sig_name;
+	const bool save_sig = opts.save_sig;
+	const bool raw_sig = opts.raw_sig;
+	const bool sign_only = opts.sign_only;
+	bool replace_orig = opts.replace_orig;
 #ifndef USE_PKCS7
-		case 'k': use_keyid = CMS_USE_KEYID; break;
+	const unsigned int use_keyid = opts.use_keyid;
 #endif
-		case -1: break;
-		default: format();
-		}
-	} while (opt != -1);
 
-	argc -= optind;
-	argv += optind;
 	if (argc < 4 || argc > 5)
 		format();
 
-- 
2.41.0

