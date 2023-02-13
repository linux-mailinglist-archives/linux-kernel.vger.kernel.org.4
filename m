Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC1269502C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 20:01:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbjBMTB0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 14:01:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230412AbjBMTBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 14:01:05 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A4E2227B0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 11:00:42 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id m2so14505857plg.4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 11:00:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6lltnqRTRNoEuVBC2frXraT3uoYPn9Hgk54L2yQV9Zs=;
        b=VsseMH3/0V49Azp3Ku8rIMLAeS7+vWykvNy/bbridzvpgTKun2ebkho5vY56fmCcxQ
         sVlA7FtaQD7M8VfGF9/nMN17v1wn2JTPOZkPdJHVM7Wli1asqLKMsHytYWUAWXvZrdp+
         xfowSwGYbZM1klim/Z5AC+ks8xPw5Su+aJqdPTWU33RUtcaLmFv2FsiFf+XFv/9ywvtp
         fyFElqVEUCMWvcKtqsYB4RaO7QcH2UDGJ5Csx1AjDlvnvbdzczhyGI/GeH1I5II8JRLF
         Fi9md1X6cJQVBduizADDPEKZ3yUytEG6ay7yJfRa4EXYqYoqagLa8xvLxVWFc6HuctFQ
         3A9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6lltnqRTRNoEuVBC2frXraT3uoYPn9Hgk54L2yQV9Zs=;
        b=ufoDhxqg/LNqwzCgOB73SrrciMvnk8uTDyLq8wf7N32clB67yQhUQgWJlHa2e0C4t6
         /zV2inzUqUeoS8i+BYqqLvIL8qws6Vx+r1ONJdHrUQeQK2+CMhnHRbihSMwKsQTxlxUv
         HJH8b2EZtItNMLHWg3Es6tvLr9nZKXjC2Ig+/i9R49fiw30cHer9y8U2LcDaiBuZlrEq
         OL5Unkub8srLSCKJ3gXAMdqGxt4DQp4PKP+rYf9IcgemLLbAkaJVxQSfX0v51NoWBYVB
         Lup0l6E4cEGNaeXnlRsOPhSuxRvEIeq+y8O2WwJccL4AbEA9FB3yl+sYQyCrE5x84Bk6
         pnRA==
X-Gm-Message-State: AO0yUKVMb66AJfhuf4ETZrhv/R3f8i/bYCNn3y9S0WqLx94m35XV4wEi
        5eyQXa/4h6x3XV3nBX1YeE8=
X-Google-Smtp-Source: AK7set8mNOuxGQNKsuscWyKJC0oeAj1XEMyg9ORqKLYri78oZfgmr2TKUl95kK7ncqPRNqOfn9pDdw==
X-Received: by 2002:a05:6a20:1d62:b0:bc:b98c:a8b3 with SMTP id cs34-20020a056a201d6200b000bcb98ca8b3mr18972337pzb.32.1676314841774;
        Mon, 13 Feb 2023 11:00:41 -0800 (PST)
Received: from f37.eng.vmware.com ([66.170.99.1])
        by smtp.googlemail.com with ESMTPSA id c25-20020a62e819000000b0056bc5ad4862sm2032452pfi.28.2023.02.13.11.00.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 11:00:41 -0800 (PST)
From:   Shreenidhi Shedi <yesshedi@gmail.com>
X-Google-Original-From: Shreenidhi Shedi <sshedi@vmware.com>
To:     dhowells@redhat.com, dwmw2@infradead.org,
        gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Shreenidhi Shedi <sshedi@vmware.com>
Subject: [PATCH v3 3/6] sign-file: add support sign modules in bulk
Date:   Tue, 14 Feb 2023 00:30:31 +0530
Message-Id: <20230213190034.57097-3-sshedi@vmware.com>
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

In the existing system, we need to invoke sign-file binary for every
module we want to sign. This patch adds support to give modules in bulk
and it will sign them all one by one.

Signed-off-by: Shreenidhi Shedi <sshedi@vmware.com>
---
 scripts/sign-file.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/scripts/sign-file.c b/scripts/sign-file.c
index 4732201feb96..7ad330b47d64 100644
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
 
@@ -342,12 +348,13 @@ int sign_file(int argc, char **argv, struct cmd_opts *opts)
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
@@ -378,6 +385,16 @@ int sign_file(int argc, char **argv, struct cmd_opts *opts)
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
@@ -486,6 +503,7 @@ int sign_file(int argc, char **argv, struct cmd_opts *opts)
 	/* Finally, if we're signing in place, replace the original. */
 	if (replace_orig)
 		ERR(rename(dest_name, module_name) < 0, "%s", dest_name);
+	}
 
 	return 0;
 }
-- 
2.39.1

