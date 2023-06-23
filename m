Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97F1D73BAD4
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 16:55:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231682AbjFWOzA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 10:55:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232376AbjFWOyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 10:54:18 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFA1F2723
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 07:54:13 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-25e92536fb6so409879a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 07:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687532053; x=1690124053;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p+Vc8KF36dvoTsxw7COLho0+o4ramvtbWDluJ7MN6HU=;
        b=a2/PkYg2smpuvS3byQch/ksrLNsrJqMuVqBJr3hijvm0eMfaHdQYnqIIbkBLCMGqmp
         TqQvFbPdT8IDAb+/Tcrao6iV9QVjC6wMhlh5bxxgj5DH4HMHN4Jy4VuwZrTPkLk9070o
         wLt8c9hRjbn+R3WQ7E0xhSxpnw2XoUUDvr942YqXOTJh1TVfAKpl2gQeXGRX37ThSzKG
         kenX6nE7luJ4xrsS/zLR0lQ+5Tgqr1FbM6WfikbDWWX3uTX+dV6vcp53awIcLhw1IP28
         tLXaIsm+jhdm4tWvcI9nrzU9nkKk9Sipjk/Y3D1QDyZUbpIGcTNorBH/P2grmVk+EZdk
         rvvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687532053; x=1690124053;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p+Vc8KF36dvoTsxw7COLho0+o4ramvtbWDluJ7MN6HU=;
        b=Vem8K0/FH9tkcDNMa9IXw4pp4CBNILTmQ5l8yXwkVh1pOEWelprG4/8RK3lSTrU9Mq
         fPtlIHWnaYbzWkMj2VNuvaD3sGCnLsIq+17tBnM4WkaExmt6MOAuwt+SLPeNuzC73Yeo
         9MVdGsTjOIN3m13alu5YBYbWafXclWVFY3d84dPfC4Z63ey93XRw7NiacnBTJPi80/Jd
         NkcoUcJKS6Thxi4uAv4ySVl8JPAlgwZ4pSf9swBQNeVloHcftg4+kg8rSlkHgwn3Uk9C
         FEEdXm4CsgrLhiWwkAuKsWT0S5eaFtZ5Vi71TrOE6urhfQZ/4/hnLyQN/ADJbzKVdY5P
         YO6g==
X-Gm-Message-State: AC+VfDygH7MsWD2rtMReduCcIVq5Bae7Lkt2NmICrwW1iVT22qY/E8Ih
        /+wWD2MqR6NMeCXlwZt0edE=
X-Google-Smtp-Source: ACHHUZ4fCUPxK65+dqJSRB560mG3xPQTWDOdWRcHpetVNtMn8byUGFD0iqxlheV/qY734BPZTbPgAQ==
X-Received: by 2002:a17:90a:1f82:b0:250:6c76:fd9b with SMTP id x2-20020a17090a1f8200b002506c76fd9bmr14594353pja.38.1687532053335;
        Fri, 23 Jun 2023 07:54:13 -0700 (PDT)
Received: from f38.eng.vmware.com ([66.170.99.1])
        by smtp.googlemail.com with ESMTPSA id fa17-20020a17090af0d100b002565cd237cdsm3359624pjb.3.2023.06.23.07.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 07:54:13 -0700 (PDT)
From:   Shreenidhi Shedi <yesshedi@gmail.com>
To:     dhowells@redhat.com, dwmw2@infradead.org,
        gregkh@linuxfoundation.org, masahiroy@kernel.org,
        nathan@kernel.org, ndesaulniers@google.com, nicolas@fjasle.eu
Cc:     yesshedi@gmail.com, linux-kernel@vger.kernel.org, sshedi@vmware.com
Subject: [PATCH v7 4/8] sign-file: add support to sign modules in bulk
Date:   Fri, 23 Jun 2023 20:23:54 +0530
Message-ID: <20230623145358.568971-5-yesshedi@gmail.com>
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
2.41.0

