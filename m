Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C3CD69E58C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 18:08:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234412AbjBURIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 12:08:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234820AbjBURIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 12:08:14 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 550208A71
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 09:08:13 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id e5so6823118plg.8
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 09:08:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=erTQoskMHY6Qv8GTlfRTQWXotpzxDsNN/To+RyW6q60=;
        b=ggwte4Rbo3R1ZpbSADNO92k1U/KdULgHElpxfOGfex8EqSQFJ9HEACMO57iqvZ6k7P
         vCKRreeoGoCtgoiszzfnS9lQOJFnWedkcyJXnSNIwQheAR6ImEIMIr/zNKX3ZUiyrDQj
         NyGBbHINKLE2+oS+rql6ncSU+o7b6VWb3XVPDB19f/b8HHpcIJKg5mCHJIK8OTik9dEy
         af3e8jJSyPTXMdE20sxExXgao3Px+JOK2ckPQNDzVLbQ+tYGrI+dOCpgEBQM02VL/6+9
         pKrNVhrnM1N7OZNcznHFsqOp3Ml9ppVC1HkEFtq1tm1nDV/I+WAvGPhRwMOyV+01KLcZ
         Gdpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=erTQoskMHY6Qv8GTlfRTQWXotpzxDsNN/To+RyW6q60=;
        b=eegymgjiTMTnWyMMT8BCecsXlm59c+4R6FX4z7cpeeYweQxuvOio2uNBmOxSYPLQQC
         FsIc95Lc3r2mEiW/HSSK3M8XmP3crUWPdDsXGlMiwUoKwvTrfD3plavcikn05n6aspxZ
         nz/RHBfayRJ1hwwUPRvpgxPyvQWEg1v7w3ocQQjMJedx6hcBCzb7ZoFl/stUVxU7nysx
         I/C/jYeipLuVx2ZCflpTfJNN/hJpXrY+ne9VfR7Lq0kCJKa1FgWh6mVE1bDFs0IzCm29
         ZkX2ZFjmQ/OfNAC1U8w7EMZ79f4BQ/TazhBRDsXv6eU9UjW+QpJrANNZprKMzdQiQuuO
         aKDA==
X-Gm-Message-State: AO0yUKXQ8H7vV+95y6aEihIBaRRLIHVxJRlHSSTJJnA1U/zbWRnneafE
        A7nJitAjeH7oqhQpf/zpdR0=
X-Google-Smtp-Source: AK7set8gpp1FMxDOzaQ/+ZqvdFFiDS2ZlaLeGFA0iEdZ/3LNEv9HV5fj7bDJdpaRZ/Oh6smm/CyKhQ==
X-Received: by 2002:a17:90b:4f8a:b0:233:bc78:b48f with SMTP id qe10-20020a17090b4f8a00b00233bc78b48fmr6845440pjb.3.1676999292831;
        Tue, 21 Feb 2023 09:08:12 -0800 (PST)
Received: from f37.eng.vmware.com ([66.170.99.1])
        by smtp.googlemail.com with ESMTPSA id 15-20020a17090a01cf00b0020b21019086sm4522572pjd.3.2023.02.21.09.08.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 09:08:12 -0800 (PST)
From:   Shreenidhi Shedi <yesshedi@gmail.com>
X-Google-Original-From: Shreenidhi Shedi <sshedi@vmware.com>
To:     yesshedi@gmail.com, dhowells@redhat.com, dwmw2@infradead.org,
        gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, sshedi@vmware.com
Subject: [ PATCH v4 3/6] sign-file: add support sign modules in bulk
Date:   Tue, 21 Feb 2023 22:38:01 +0530
Message-Id: <20230221170804.3267242-3-sshedi@vmware.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230221170804.3267242-1-sshedi@vmware.com>
References: <20230221170804.3267242-1-sshedi@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shreenidhi Shedi <yesshedi@gmail.com>

In the existing system, we need to invoke sign-file binary for every
module we want to sign. This patch adds support to give modules in bulk
and it will sign them all one by one.

Signed-off-by: Shreenidhi Shedi <yesshedi@gmail.com>
---
 scripts/sign-file.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/scripts/sign-file.c b/scripts/sign-file.c
index 3e6d776d126c..97a2aaf8e323 100644
--- a/scripts/sign-file.c
+++ b/scripts/sign-file.c
@@ -224,6 +224,7 @@ struct cmd_opts {
 	bool replace_orig;
 	bool raw_sig;
 	bool sign_only;
+	bool bulk_sign;
 
 #ifndef USE_PKCS7
 	unsigned int use_keyid;
@@ -237,6 +238,7 @@ static void parse_args(int argc, char **argv, struct cmd_opts *opts)
 		{"help", no_argument, 0, 'h'},
 		{"savesig", no_argument, 0, 's'},
 		{"signonly", no_argument, 0, 'o'},
+		{"bulksign", no_argument, 0, 'b'},
 #ifndef USE_PKCS7
 		{"usekeyid", no_argument, 0, 'k'},
 #endif
@@ -305,6 +307,10 @@ static void parse_args(int argc, char **argv, struct cmd_opts *opts)
 			opts->replace_orig = true;
 			break;
 
+		case 'b':
+			opts->bulk_sign = true;
+			break;
+
 		case -1:
 			break;
 
@@ -330,7 +336,7 @@ static int sign_file(int argc, char **argv, struct cmd_opts *opts)
 #endif
 	X509 *x509;
 	BIO *bd, *bm;
-	int n;
+	int i, n;
 
 	char *hash_algo = opts->hash_algo;
 	char *dest_name = opts->dest_name;
@@ -342,12 +348,13 @@ static int sign_file(int argc, char **argv, struct cmd_opts *opts)
 	bool replace_orig = opts->replace_orig;
 	bool raw_sig = opts->raw_sig;
 	bool sign_only = opts->sign_only;
+	bool bulk_sign = opts->bulk_sign;
 
 #ifndef USE_PKCS7
 	unsigned int use_keyid = opts->use_keyid;
 #endif
 
-	if (!argv[0] || argc != 1)
+	if ((bulk_sign && dest_name) || (!bulk_sign && argc != 1))
 		format();
 
 	if (dest_name && strcmp(argv[0], dest_name)) {
@@ -378,6 +385,16 @@ static int sign_file(int argc, char **argv, struct cmd_opts *opts)
 	use_signed_attrs = PKCS7_NOATTR;
 #endif
 
+	for (i = 0; i < argc; i++) {
+		module_name = argv[i];
+
+		if (bulk_sign) {
+			ERR(asprintf(&dest_name, "%s.~signed~", module_name) < 0,
+					"asprintf");
+			if (!replace_orig)
+				replace_orig = true;
+		}
+
 	/* Open the module file */
 	bm = BIO_new_file(module_name, "rb");
 	ERR(!bm, "%s", module_name);
@@ -486,6 +503,7 @@ static int sign_file(int argc, char **argv, struct cmd_opts *opts)
 	/* Finally, if we're signing in place, replace the original. */
 	if (replace_orig)
 		ERR(rename(dest_name, module_name) < 0, "%s", dest_name);
+	}
 
 	return 0;
 }
-- 
2.39.1

