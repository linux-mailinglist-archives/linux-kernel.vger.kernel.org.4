Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9798F6C2059
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 19:51:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbjCTSvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 14:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbjCTSud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 14:50:33 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A5513867A
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 11:43:54 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id z19so3103667plo.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 11:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679337832;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VoVIua9utDq11xAPsz5lSfVj7QXIQk5YJj7MGTjSPUg=;
        b=S7lLpFUtP2nHQ4E9fU47Ou5G1TRLBMNz5zrzIZ76O/iHBPRboArsj4HxwHT0k1my+W
         +lRbp0V5h2uxN3bjcxH5ImzETELMwRisT3NjXv4vbNAmEyNtiahLhjshccIPfN+Lj24L
         iWw+1z1TH5vR1Q5pqgEjZZXRgAYT8s5KwXXAFk+gq+hDXZZcCUtdrZYO3STiOvoiODxA
         qpsIrd/btUAzvq95RIpDUEqSVn02USALrK3fvjFxGKYNFwL4Ng/kKNgdWyvsgl7GooIr
         mCaRDTl28biQsJt32YWQ5pXhwN3/G/zeq0+9CRtXbmQ57glb0JfNSqvO9gy2FCiCmrBE
         kF+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679337832;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VoVIua9utDq11xAPsz5lSfVj7QXIQk5YJj7MGTjSPUg=;
        b=yvd/3CbbFXkZ4vKeu4smRAkb9hfRQZchvZkDc7eA1bqcESmM3qXMPcHTF3rADB6fTG
         mWdaZy674PYpcWWOFLoQXNjF2W3i15dqc0LGSop+02UPrXGcu2DaMGvNzzmKTCDlaVHO
         DEWo/MjkUCGXGIZuoW8/8/MuGoFo+q2TolWnk+Vwr5/I3zJIl4W+OusLhjGUir+kxeYC
         Rl9ARm9uBk7vEV373fUdFSxpy804EAgZYVsMCDaUs7Rrw9U6Xc2UvB4LmkcdzO3kHx8u
         Mtu8ltQq80UdTG2k8cvL2IelMk0KAIccIosyeiWtEmgpRxyjx4l7/Up/ObDp0m0PZe3a
         qnwA==
X-Gm-Message-State: AO0yUKW1qDU+xzqWR2hSsuvN/P6kA3brtRmTvTM41MkWIL2+AjZvUT9t
        Yzz9NYQthhRBu+emqueLSaI=
X-Google-Smtp-Source: AK7set8cQg4tyRhWGXoyflSi8jTlBcl2YHmpCbCOYlNvcIly9AJTLTqzCikfsKQS7TVDExTk/HFifA==
X-Received: by 2002:a05:6a20:2098:b0:d9:dd69:47e3 with SMTP id b24-20020a056a20209800b000d9dd6947e3mr2385516pza.23.1679337832331;
        Mon, 20 Mar 2023 11:43:52 -0700 (PDT)
Received: from f37.eng.vmware.com ([66.170.99.1])
        by smtp.googlemail.com with ESMTPSA id bn10-20020a056a00324a00b005a84ef49c63sm6671755pfb.214.2023.03.20.11.43.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 11:43:52 -0700 (PDT)
From:   Shreenidhi Shedi <yesshedi@gmail.com>
X-Google-Original-From: Shreenidhi Shedi <sshedi@vmware.com>
To:     gregkh@linuxfoundation.org, dhowells@redhat.com,
        dwmw2@infradead.org
Cc:     yesshedi@gmail.com, linux-kernel@vger.kernel.org, sshedi@vmware.com
Subject: [PATCH v5 2/7] sign-file: refactor argument parsing logic - 2
Date:   Tue, 21 Mar 2023 00:13:40 +0530
Message-Id: <20230320184345.80166-3-sshedi@vmware.com>
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

