Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8863969502D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 20:01:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbjBMTBa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 14:01:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230487AbjBMTBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 14:01:05 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A0EC5B80
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 11:00:42 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id z1so14494282plg.6
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 11:00:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q/t9LlyJD83PxACwoCyRWisOksB2z36WEKEAt4NGMyU=;
        b=OXXZBwNZ5aydc2IUqm4CjGSa63G1fF99QMNlDSpXn5pOGxb5wzcun56O2kXLv6UE+/
         hPnzDSAjiGH5xLo3vWzgD9o2uLtmGZkSWHR8XDPS08pK8HzcYp7wX1tf0a8lRq22Tcrd
         vm4T6pHO/uTAnfeNp5xfHA4q2csI/8a/sgRNlEstQOMv1g85Q+ovlgGXutj6Cxg1tp4y
         cyCSoZORk4h6Se9/0huiMmqIxDPBXsisvnpPjlhrRtjh6FuRJvwiH4CPaTAg52SNlQv5
         u8J8Hl7Ce4imbr1G2ZX3CNgXMOoI/CT8gKv1ywoE/94ErNKoY93GTTdmy274A2g28ylc
         YTdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q/t9LlyJD83PxACwoCyRWisOksB2z36WEKEAt4NGMyU=;
        b=Nmw6SMpEExGnlLJhCasgaZAQN1J5SjMaoC/za2xKGn3dwa3lRtTWRDNxOh//ak6o4c
         8UxmlwORGgTJUJ3EuqVxyNEcQWNVDN7ivhTS5nbldXXvQx9yAUhjCq4VmXD14KvA5ekI
         eAKFjNksIAhHvFu/t6YsZt1pWp7WJg1Rf/h33ISaDBNjqwWKBw3Za1fkNhgIaktovt3K
         OhDzZWMbqAIzR8RQgOobN1MxUbAoCc3ulcUzmeH4dwbDooij2r+aiIDMz4uK7unq1C0e
         pgWd2bn1F7JJa7faAuWzGdlkCJsiaNOq6v32riHLNXDSbsYvbWlNtBSY4jMjpg/gdPO+
         bsTw==
X-Gm-Message-State: AO0yUKVL59v5bId6mtrigTXWVT8PfQLOnaqNpYCm+IwWbUiBrvJvZGe7
        NPBdPnqHCtgr8eZK+K0caLE1vA86owkBwA==
X-Google-Smtp-Source: AK7set8V+mwTF/7UyxS788WMjW94MQyjFpCUA0y5Va7i72ejyr74xpGrsTdNAid1kHn2fuaO33uCAQ==
X-Received: by 2002:a05:6a20:6f47:b0:be:fa43:9476 with SMTP id gu7-20020a056a206f4700b000befa439476mr21996510pzb.35.1676314840507;
        Mon, 13 Feb 2023 11:00:40 -0800 (PST)
Received: from f37.eng.vmware.com ([66.170.99.1])
        by smtp.googlemail.com with ESMTPSA id c25-20020a62e819000000b0056bc5ad4862sm2032452pfi.28.2023.02.13.11.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 11:00:39 -0800 (PST)
From:   Shreenidhi Shedi <yesshedi@gmail.com>
X-Google-Original-From: Shreenidhi Shedi <sshedi@vmware.com>
To:     dhowells@redhat.com, dwmw2@infradead.org,
        gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Shreenidhi Shedi <sshedi@vmware.com>
Subject: [PATCH v3 2/6] sign-file: move file signing logic to its own function
Date:   Tue, 14 Feb 2023 00:30:30 +0530
Message-Id: <20230213190034.57097-2-sshedi@vmware.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230213190034.57097-1-sshedi@vmware.com>
References: <20230213190034.57097-1-sshedi@vmware.com>
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

Keep the main function bare minimal and do less in main function.

Signed-off-by: Shreenidhi Shedi <sshedi@vmware.com>
---
 scripts/sign-file.c | 69 +++++++++++++++++++++++++--------------------
 1 file changed, 39 insertions(+), 30 deletions(-)

diff --git a/scripts/sign-file.c b/scripts/sign-file.c
index cf3acbb13013..4732201feb96 100644
--- a/scripts/sign-file.c
+++ b/scripts/sign-file.c
@@ -230,7 +230,7 @@ struct cmd_opts {
 #endif
 };
 
-void parse_args(int argc, char **argv, struct cmd_opts *opts)
+static void parse_args(int argc, char **argv, struct cmd_opts *opts)
 {
 	struct option cmd_options[] = {
 		/* These options set a flag. */
@@ -315,10 +315,10 @@ void parse_args(int argc, char **argv, struct cmd_opts *opts)
 	} while (opt != -1);
 }
 
-int main(int argc, char **argv)
+int sign_file(int argc, char **argv, struct cmd_opts *opts)
 {
 	struct module_signature sig_info = { .id_type = PKEY_ID_PKCS7 };
-	unsigned char buf[4096];
+	unsigned char buf[4096] = {0};
 	unsigned long module_size, sig_size;
 	unsigned int use_signed_attrs;
 	const EVP_MD *digest_algo;
@@ -331,36 +331,20 @@ int main(int argc, char **argv)
 	X509 *x509;
 	BIO *bd, *bm;
 	int i, n;
-	struct cmd_opts opts = {0};
 
-	OpenSSL_add_all_algorithms();
-	ERR_load_crypto_strings();
-	ERR_clear_error();
-
-	key_pass = getenv("KBUILD_SIGN_PIN");
+	char *hash_algo = opts->hash_algo;
+	char *dest_name = opts->dest_name;
+	char *private_key_name = opts->private_key_name;
+	char *raw_sig_name = opts->raw_sig_name;
+	char *x509_name = opts->x509_name;
+	char *module_name = opts->module_name;
+	bool save_sig = opts->save_sig;
+	bool replace_orig = opts->replace_orig;
+	bool raw_sig = opts->raw_sig;
+	bool sign_only = opts->sign_only;
 
 #ifndef USE_PKCS7
-	use_signed_attrs = CMS_NOATTR;
-#else
-	use_signed_attrs = PKCS7_NOATTR;
-#endif
-	parse_args(argc, argv, &opts);
-	argc -= optind;
-	argv += optind;
-
-	char *hash_algo = opts.hash_algo;
-	char *dest_name = opts.dest_name;
-	char *private_key_name = opts.private_key_name;
-	char *raw_sig_name = opts.raw_sig_name;
-	char *x509_name = opts.x509_name;
-	char *module_name = opts.module_name;
-	bool save_sig = opts.save_sig;
-	bool replace_orig = opts.replace_orig;
-	bool raw_sig = opts.raw_sig;
-	bool sign_only = opts.sign_only;
-
-#ifndef USE_PKCS7
-	unsigned int use_keyid = opts.use_keyid;
+	unsigned int use_keyid = opts->use_keyid;
 #endif
 
 	if (!argv[0] || argc != 1)
@@ -381,6 +365,19 @@ int main(int argc, char **argv)
 		exit(3);
 	}
 #endif
+
+	OpenSSL_add_all_algorithms();
+	ERR_load_crypto_strings();
+	ERR_clear_error();
+
+	key_pass = getenv("KBUILD_SIGN_PIN");
+
+#ifndef USE_PKCS7
+	use_signed_attrs = CMS_NOATTR;
+#else
+	use_signed_attrs = PKCS7_NOATTR;
+#endif
+
 	/* Open the module file */
 	bm = BIO_new_file(module_name, "rb");
 	ERR(!bm, "%s", module_name);
@@ -492,3 +489,15 @@ int main(int argc, char **argv)
 
 	return 0;
 }
+
+int main(int argc, char **argv)
+{
+	struct cmd_opts opts = {0};
+
+	parse_args(argc, argv, &opts);
+
+	argc -= optind;
+	argv += optind;
+
+	return sign_file(argc, argv, &opts);
+}
-- 
2.39.1

