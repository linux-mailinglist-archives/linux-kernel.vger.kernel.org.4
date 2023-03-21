Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE5AA6C3AB7
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 20:35:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbjCUTey (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 15:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbjCUTeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 15:34:46 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 127EC570B5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 12:34:09 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id fd25so9747574pfb.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 12:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679427226;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JfE1Pm3xCC/xMjfmbV6dg9bDdIIYNa99PYfAs69HM0w=;
        b=lg/FcqI+lffJF0M/bbmFlheKKJUVTXCS5F8jAhnrBAvXyA2IqG/9hmNjzvsDp5ngKk
         SDO3W2J+fE6lLOj/TSKcsSfKiFb6PBXyAUEVycnCvhNuN9U4QO10ihmPCnwMX6t+okTd
         V7073khKaNF0l7HH0sODuuxEBuR26SC2Sfr3Ejf/A3DwrerYutz/aKdNC06BGtcx9VTd
         jOqI5hf/s5xGB8YKp8zGdbn0XnRG5QE7Io2dLaEw2EDU6RVp+0sQBepgBPbMNnM1vGVC
         w2gtIizlYIO1WyZAXij+vlqgRARBPm42MVPHtG3mEBeVhkuHvcJl9KuzowBZXUqqcm+P
         ELjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679427226;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JfE1Pm3xCC/xMjfmbV6dg9bDdIIYNa99PYfAs69HM0w=;
        b=EycJZurnMRKaNtbX9dO0lkGbc2874R1xwH37vsERv4GSiRcqjNFXyQNcKfdgoQCLir
         C9Y2TX/5Z1RO8h9Q4jLrVKwd4ET+uxWuartUjIxLWn54dRlyT0iQErQ9D1D9u7WlFcL+
         Rzb54LhQ8OsPRnq5EL6pWlV9kwz1f+vRdhGSLzr9Yh9SgcdmfC795gVip2Q4AqoJtPy5
         qyUK9YLjRALEsrfQ6Dv5qa1YHZgJI0pvT5JGj+mG4ivQA8GohclChNDilLqL4bWjrmMJ
         Tsh3y/gU2tvHVzFFclSnR5aLMeyq/YJ0TeQIY2kfY55La4dcKa/vN4zoInzMJtGSauaD
         0AyQ==
X-Gm-Message-State: AO0yUKXAn7Kq+WcFipmZkubkO6+9cgkbmRpOdXeWo0Ec3Ybm6KP4x9H4
        jmstKnTCBbBo/srwNR0LEHc=
X-Google-Smtp-Source: AK7set+AIpPB2wg+jmk+XWvuY7jaNO6CT8aybg2knfYtPhrLXe9DgrH3ebZsJ6n8B4fdOysRGySkBA==
X-Received: by 2002:a05:6a00:2e1e:b0:626:2bb0:30d4 with SMTP id fc30-20020a056a002e1e00b006262bb030d4mr1076267pfb.8.1679427226423;
        Tue, 21 Mar 2023 12:33:46 -0700 (PDT)
Received: from f37.eng.vmware.com ([66.170.99.1])
        by smtp.googlemail.com with ESMTPSA id k23-20020aa790d7000000b006247123adf1sm8843044pfk.143.2023.03.21.12.33.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 12:33:46 -0700 (PDT)
From:   Shreenidhi Shedi <yesshedi@gmail.com>
X-Google-Original-From: Shreenidhi Shedi <sshedi@vmware.com>
To:     gregkh@linuxfoundation.org, dhowells@redhat.com,
        dwmw2@infradead.org
Cc:     linux-kernel@vger.kernel.org, sshedi@vmware.com, yesshedi@gmail.com
Subject: [PATCH v6 1/7] sign-file: use getopt_long_only for parsing input args
Date:   Wed, 22 Mar 2023 01:03:35 +0530
Message-Id: <20230321193341.87997-2-sshedi@vmware.com>
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
2.39.2

