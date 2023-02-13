Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8846C694FCA
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 19:50:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbjBMSuv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 13:50:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbjBMSuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 13:50:44 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52E1B1CAED
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 10:50:26 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id m2so14475230plg.4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 10:50:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q/t9LlyJD83PxACwoCyRWisOksB2z36WEKEAt4NGMyU=;
        b=RNf1Q8xXBtbuVmMWZszNIm5ITFHd0q2x0WlV1Tbu6zyUBxWLWyBQqz3jhr5EbiwUGr
         L/rNzSQ28+NQKSfrgsyLhVPqXH6XXOdrg0MKyXPAFVT+FfXx+yFFOpl7HIDNwGVUb1yt
         QwrKYuw2XhoiZD1tJzNpbgz5c0KpIkviJDcvAPJKhyE1oPKpKVfzYLRvkwZ5/9rt4+G8
         BWeO3jY3OFnu3g8sHSZ2irqBuQ0RHB5CCsN2ZrUSch5NIYb9pf/2WL/pP6kC/cpdEbTR
         Y9ooEYgELIrZQ0Yl76U+1PrY5ky1ZDlhl+Z/dMa+yzsx4nkki/1UAp1ICpxgFq0E0078
         Yngg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q/t9LlyJD83PxACwoCyRWisOksB2z36WEKEAt4NGMyU=;
        b=muuiY0yjZDYdaob7vjZq42nLh8zn0caXcpsZkSPO9+YAhc9rhd9zyjzZ3CnP4rXPmE
         KnNg1hbBnig2o6/+eHKdUkpWUwS8JrP5jvdS2BK9Z18Tdc2gfAI6LRtdu5sdtCtUoQST
         9g4UeUKshs4w6jWGRoT9S92068ISycwDgL+SaR9qM1wUiVSOX0O5p4weYeRfL20Ii/Xf
         yxrokbeASRZ22snL0WLJPPTKXHwFbEfYsk+XXoFUEM3r9y3D9m2rIZkWYqtW8eDbjk+b
         tcAoOA+lignxOhKhIC/Id5QaaV6pkmF5A9+k/r+wo0Du0C2GK7sct304sUx18XTkHXGA
         5/zA==
X-Gm-Message-State: AO0yUKXk4E+rKS5ds64TfSo8XH2UJzPrkJEUmn5DjWmb3p8tTFbFyzPj
        DCkFJ8iVtiANGJzcH5AW/i23tXSwXg4=
X-Google-Smtp-Source: AK7set8iEq/5xAU/7lm8kg4QkzRgCNAv6/yDan7kbw2BGMBYPf2vunFMPEc1xAQHyUeovFDSpvJ2rg==
X-Received: by 2002:a17:903:22c1:b0:199:2a4f:be84 with SMTP id y1-20020a17090322c100b001992a4fbe84mr26941639plg.58.1676314225803;
        Mon, 13 Feb 2023 10:50:25 -0800 (PST)
Received: from f37.eng.vmware.com ([66.170.99.1])
        by smtp.googlemail.com with ESMTPSA id p14-20020a170902a40e00b00198f256a192sm8535036plq.171.2023.02.13.10.50.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 10:50:25 -0800 (PST)
From:   Shreenidhi Shedi <yesshedi@gmail.com>
X-Google-Original-From: Shreenidhi Shedi <sshedi@vmware.com>
To:     dhowells@redhat.com, dwmw2@infradead.org,
        gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Shreenidhi Shedi <sshedi@vmware.com>
Subject: [PATCH v2 2/6] sign-file: move file signing logic to its own function
Date:   Tue, 14 Feb 2023 00:20:14 +0530
Message-Id: <20230213185019.56902-2-sshedi@vmware.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230213185019.56902-1-sshedi@vmware.com>
References: <20230213185019.56902-1-sshedi@vmware.com>
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

