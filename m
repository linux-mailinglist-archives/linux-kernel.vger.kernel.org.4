Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEFDD6C2055
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 19:51:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbjCTSvD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 14:51:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231829AbjCTSu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 14:50:28 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B401F24BDB
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 11:43:54 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id t83so7186043pgb.11
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 11:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679337834;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RgmNLjr3I8OPOH6tQ35q/VFjCbXwlCYLA+AOAf0ZDi4=;
        b=fKff6hTt8n32EfN8bedX2UgaiXCP1uIZOWEecNxcz7LVGtq4gxM7Df5B5UIBaWG7DY
         Mwa3Nuz3Uo0vYMc6j/cVgaPpb0aqUjb0MqqXA/CAT43/LAyHDhNYEBXMYB3aGV7PlNaK
         SDWJU9cmaqGfxgmOh6dRzFw0qxjPdAOZOc7Dp8YB5o6la3J1zl66mcoIloIWxsmh4DNg
         fl1kDgfBZs3aIsGL0KRNPTcwAk/4GlaDSt9os7nzdyXj62UP88DUAEWbK2OeqHT2jTNJ
         1SzpVSLJ9XLcPDggizWQzWPkeSyD2SadZ41/gPwa2Z2IqWeCtYW9cJ/C82JA+wX7seeb
         fY1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679337834;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RgmNLjr3I8OPOH6tQ35q/VFjCbXwlCYLA+AOAf0ZDi4=;
        b=1xMTEgmvktkrFAPySdB7EgqSY02dB7Z8JxFZ7/ldDVLmGuGOHuCFClxaXlGu/osHVN
         COskubA9dyJiSNYp8UJCzCJJzrt9rSdjSeaoSdGu+PcM/hKplxwPOF3bOzA1xrXyPpdF
         GXpzr9iKBfMzYjw/Zbe7Ub1xtbEP1C6wuzLaCt5KRoHfCLa9XUZSms/2RlyKmbfB02bt
         wISYfT6rgpZ1E/rsUsJw1v+DLZten1Z/750DZBlG4WBqbJ53MSHzSbaUAp6UiXrHqtu/
         r3mrYBw53kcTE90ooM8CAhnxel481g/kOMv22UJEJWqtpPBVlw+FTEtkTWotwyALoLb2
         dvuA==
X-Gm-Message-State: AO0yUKWwH0U6PlT0fqNhQSCrxPTsJAWavJKAhwfGFBjo/MuiHqcJ8cSH
        DhYWEPLtUs+TMig0JHPjweTZ+/jt0T+Thg==
X-Google-Smtp-Source: AK7set8OB/kh0nyfBll2IAvSxHJEOhv09GxalZZoeJBPk7Zg1iOcQOB4UIGOxDo4bGnUfRbRS1uklg==
X-Received: by 2002:a62:58c3:0:b0:627:ff1d:db6d with SMTP id m186-20020a6258c3000000b00627ff1ddb6dmr2695186pfb.21.1679337833793;
        Mon, 20 Mar 2023 11:43:53 -0700 (PDT)
Received: from f37.eng.vmware.com ([66.170.99.1])
        by smtp.googlemail.com with ESMTPSA id bn10-20020a056a00324a00b005a84ef49c63sm6671755pfb.214.2023.03.20.11.43.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 11:43:53 -0700 (PDT)
From:   Shreenidhi Shedi <yesshedi@gmail.com>
X-Google-Original-From: Shreenidhi Shedi <sshedi@vmware.com>
To:     gregkh@linuxfoundation.org, dhowells@redhat.com,
        dwmw2@infradead.org
Cc:     yesshedi@gmail.com, linux-kernel@vger.kernel.org, sshedi@vmware.com
Subject: [PATCH v5 3/7] sign-file: refactor argument parsing logic - 3
Date:   Tue, 21 Mar 2023 00:13:41 +0530
Message-Id: <20230320184345.80166-4-sshedi@vmware.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230320184345.80166-1-sshedi@vmware.com>
References: <20230320184345.80166-1-sshedi@vmware.com>
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

Move file signing logic to its own function
Keep the main function bare minimal and do less in main function.

This patch is pre-work for bulk module signing support.

Signed-off-by: Shreenidhi Shedi <yesshedi@gmail.com>
---
 scripts/sign-file.c | 115 +++++++++++++++++++++-----------------------
 1 file changed, 54 insertions(+), 61 deletions(-)

diff --git a/scripts/sign-file.c b/scripts/sign-file.c
index b0f340ea629b..64d5e00f08e2 100644
--- a/scripts/sign-file.c
+++ b/scripts/sign-file.c
@@ -313,10 +313,10 @@ static void parse_args(int argc, char **argv, struct cmd_opts *opts)
 	} while (opt != -1);
 }
 
-int main(int argc, char **argv)
+static int sign_single_file(struct cmd_opts *opts)
 {
 	struct module_signature sig_info = { .id_type = PKEY_ID_PKCS7 };
-	unsigned char buf[4096];
+	unsigned char buf[4096] = {};
 	unsigned long module_size, sig_size;
 	unsigned int use_signed_attrs;
 	const EVP_MD *digest_algo;
@@ -329,11 +329,6 @@ int main(int argc, char **argv)
 	X509 *x509;
 	BIO *bd, *bm;
 	int n;
-	struct cmd_opts opts = {};
-
-	OpenSSL_add_all_algorithms();
-	ERR_load_crypto_strings();
-	ERR_clear_error();
 
 	key_pass = getenv("KBUILD_SIGN_PIN");
 
@@ -342,34 +337,6 @@ int main(int argc, char **argv)
 #else
 	use_signed_attrs = PKCS7_NOATTR;
 #endif
-	parse_args(argc, argv, &opts);
-	argc -= optind;
-	argv += optind;
-
-	const char *raw_sig_name = opts.raw_sig_name;
-	const char *hash_algo = opts.hash_algo;
-	const char *private_key_name = opts.private_key_name;
-	const char *x509_name = opts.x509_name;
-	const char *module_name = opts.module_name;
-	const bool save_sig = opts.save_sig;
-	const bool raw_sig = opts.raw_sig;
-	const bool sign_only = opts.sign_only;
-	bool replace_orig = opts.replace_orig;
-	char *dest_name = opts.dest_name;
-#ifndef USE_PKCS7
-	const unsigned int use_keyid = opts.use_keyid;
-#endif
-
-	if (!argv[0] || argc != 1)
-		format();
-
-	if (dest_name && strcmp(argv[0], dest_name)) {
-		replace_orig = false;
-	} else {
-		ERR(asprintf(&dest_name, "%s.~signed~", module_name) < 0,
-				"asprintf");
-		replace_orig = true;
-	}
 
 #ifdef USE_PKCS7
 	if (strcmp(hash_algo, "sha1") != 0) {
@@ -380,20 +347,20 @@ int main(int argc, char **argv)
 #endif
 
 	/* Open the module file */
-	bm = BIO_new_file(module_name, "rb");
-	ERR(!bm, "%s", module_name);
+	bm = BIO_new_file(opts->module_name, "rb");
+	ERR(!bm, "%s", opts->module_name);
 
-	if (!raw_sig) {
+	if (!opts->raw_sig) {
 		/* Read the private key and the X.509 cert the PKCS#7 message
 		 * will point to.
 		 */
-		private_key = read_private_key(private_key_name);
-		x509 = read_x509(x509_name);
+		private_key = read_private_key(opts->private_key_name);
+		x509 = read_x509(opts->x509_name);
 
 		/* Digest the module data. */
 		OpenSSL_add_all_digests();
 		display_openssl_errors(__LINE__);
-		digest_algo = EVP_get_digestbyname(hash_algo);
+		digest_algo = EVP_get_digestbyname(opts->hash_algo);
 		ERR(!digest_algo, "EVP_get_digestbyname");
 
 #ifndef USE_PKCS7
@@ -405,7 +372,7 @@ int main(int argc, char **argv)
 
 		ERR(!CMS_add1_signer(cms, x509, private_key, digest_algo,
 				     CMS_NOCERTS | CMS_BINARY |
-				     CMS_NOSMIMECAP | use_keyid |
+				     CMS_NOSMIMECAP | opts->use_keyid |
 				     use_signed_attrs),
 		    "CMS_add1_signer");
 		ERR(CMS_final(cms, bm, NULL, CMS_NOCERTS | CMS_BINARY) < 0,
@@ -418,11 +385,11 @@ int main(int argc, char **argv)
 		ERR(!pkcs7, "PKCS7_sign");
 #endif
 
-		if (save_sig) {
+		if (opts->save_sig) {
 			char *sig_file_name;
 			BIO *b;
 
-			ERR(asprintf(&sig_file_name, "%s.p7s", module_name) < 0,
+			ERR(asprintf(&sig_file_name, "%s.p7s", opts->module_name) < 0,
 			    "asprintf");
 			b = BIO_new_file(sig_file_name, "wb");
 			ERR(!b, "%s", sig_file_name);
@@ -436,7 +403,7 @@ int main(int argc, char **argv)
 			BIO_free(b);
 		}
 
-		if (sign_only) {
+		if (opts->sign_only) {
 			BIO_free(bm);
 			return 0;
 		}
@@ -445,24 +412,24 @@ int main(int argc, char **argv)
 	/* Open the destination file now so that we can shovel the module data
 	 * across as we read it.
 	 */
-	bd = BIO_new_file(dest_name, "wb");
-	ERR(!bd, "%s", dest_name);
+	bd = BIO_new_file(opts->dest_name, "wb");
+	ERR(!bd, "%s", opts->dest_name);
 
 	/* Append the marker and the PKCS#7 message to the destination file */
-	ERR(BIO_reset(bm) < 0, "%s", module_name);
+	ERR(BIO_reset(bm) < 0, "%s", opts->module_name);
 	while ((n = BIO_read(bm, buf, sizeof(buf))),
 	       n > 0) {
-		ERR(BIO_write(bd, buf, n) < 0, "%s", dest_name);
+		ERR(BIO_write(bd, buf, n) < 0, "%s", opts->dest_name);
 	}
 	BIO_free(bm);
-	ERR(n < 0, "%s", module_name);
+	ERR(n < 0, "%s", opts->module_name);
 	module_size = BIO_number_written(bd);
 
-	if (!raw_sig) {
+	if (!opts->raw_sig) {
 #ifndef USE_PKCS7
-		ERR(i2d_CMS_bio_stream(bd, cms, NULL, 0) < 0, "%s", dest_name);
+		ERR(i2d_CMS_bio_stream(bd, cms, NULL, 0) < 0, "%s", opts->dest_name);
 #else
-		ERR(i2d_PKCS7_bio(bd, pkcs7) < 0, "%s", dest_name);
+		ERR(i2d_PKCS7_bio(bd, pkcs7) < 0, "%s", opts->dest_name);
 #endif
 	} else {
 		BIO *b;
@@ -470,23 +437,49 @@ int main(int argc, char **argv)
 		/* Read the raw signature file and write the data to the
 		 * destination file
 		 */
-		b = BIO_new_file(raw_sig_name, "rb");
-		ERR(!b, "%s", raw_sig_name);
+		b = BIO_new_file(opts->raw_sig_name, "rb");
+		ERR(!b, "%s", opts->raw_sig_name);
 		while ((n = BIO_read(b, buf, sizeof(buf))), n > 0)
-			ERR(BIO_write(bd, buf, n) < 0, "%s", dest_name);
+			ERR(BIO_write(bd, buf, n) < 0, "%s", opts->dest_name);
 		BIO_free(b);
 	}
 
 	sig_size = BIO_number_written(bd) - module_size;
 	sig_info.sig_len = htonl(sig_size);
-	ERR(BIO_write(bd, &sig_info, sizeof(sig_info)) < 0, "%s", dest_name);
-	ERR(BIO_write(bd, magic_number, sizeof(magic_number) - 1) < 0, "%s", dest_name);
+	ERR(BIO_write(bd, &sig_info, sizeof(sig_info)) < 0, "%s", opts->dest_name);
+	ERR(BIO_write(bd, magic_number, sizeof(magic_number) - 1) < 0, "%s", opts->dest_name);
 
-	ERR(BIO_free(bd) < 0, "%s", dest_name);
+	ERR(BIO_free(bd) < 0, "%s", opts->dest_name);
 
 	/* Finally, if we're signing in place, replace the original. */
-	if (replace_orig)
-		ERR(rename(dest_name, module_name) < 0, "%s", dest_name);
+	if (opts->replace_orig)
+		ERR(rename(opts->dest_name, opts->module_name) < 0, "%s", opts->dest_name);
 
 	return 0;
 }
+
+int main(int argc, char **argv)
+{
+	struct cmd_opts opts = {};
+
+	parse_args(argc, argv, &opts);
+	argc -= optind;
+	argv += optind;
+
+	if (!argv[0] || argc != 1)
+		format();
+
+	if (opts.dest_name && strcmp(argv[0], opts.dest_name)) {
+		opts.replace_orig = false;
+	} else {
+		ERR(asprintf(&opts.dest_name, "%s.~signed~", opts.module_name) < 0,
+				"asprintf");
+		opts.replace_orig = true;
+	}
+
+	OpenSSL_add_all_algorithms();
+	ERR_load_crypto_strings();
+	ERR_clear_error();
+
+	return sign_single_file(&opts);
+}
-- 
2.39.2

