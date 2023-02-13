Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44D78694FC9
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 19:50:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbjBMSus (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 13:50:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbjBMSuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 13:50:44 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 871C620D0A
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 10:50:27 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id f16-20020a17090a9b1000b0023058bbd7b2so13183231pjp.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 10:50:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6lltnqRTRNoEuVBC2frXraT3uoYPn9Hgk54L2yQV9Zs=;
        b=HPjVNKjie2Ne8id2IJb5s600oVO3rK9YarwM/JanyPegDSpPi3WJIy4a0CVaU2hnE2
         AAl+1IKmHToNaDkegK8MFzM7sIlY06fO5Sf0K3ZfCqeVvtn4vSd6zEYmqhKqjpGyZgN6
         91bMNDduJW9raHORVOmMQdrN0Y/Kn+q6TAP3JSTVSsMgaVR2XCGsjY11nVDUphgY1HRD
         JVpqSf1cxdVtEH9rBfg+onVg15AsxL2be7Ehb2K9yxaeeozMm0A5Oz+zgZmfuW4oLhXb
         REEbtLEvcsGN2xE9YriV0L9ymqqLu5HjaTXzQqh15AVV6Ccny8J+GFhr4d7WN/Q6bFti
         z1tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6lltnqRTRNoEuVBC2frXraT3uoYPn9Hgk54L2yQV9Zs=;
        b=sMbM7GAVr+PLy5k53Iw2I/kvv/UPOohW2QPJankcxBjmWKlP0fEVfbllptV/my+jxp
         kYXXGmLml08zteMFVAiBay0wHW1NPcGaT/asLLnC8LtmzhFIiX4ZKV3FJVhxPNcyQCXW
         wpK3j4St6jw6ThmZeman1PdhAC7nzJ0vJIvaHhfbaCfsSZSq8Vf6U738k/IkcCa0IVcL
         plDdZlk5Hf78T1lTBBr1fIt6eTRvBHWbW1YaMBqF26bsVdyu/2Stttn2uLYziQKIcr1d
         GcFWnf12Qh9eVr7p7hV2jU5P53L4oerWJkjN0XHXm2FTkLA2VJCQjSKhT6ujcIJmJaUd
         6rng==
X-Gm-Message-State: AO0yUKX9da+nVC5uFUNsB8+y8KfZZuF7ogk/Q4p/OrkJDiw9n8NiC1dl
        nlL8/oxsRyrZLm4EH0PJgKs=
X-Google-Smtp-Source: AK7set9JXL58xLmo684rZLycRCsjl+qPbAouzuJ2Uail+P7W/tGXgkDKNzx9OSelpSsAnyHKmKG71Q==
X-Received: by 2002:a17:903:1c2:b0:196:63d0:a674 with SMTP id e2-20020a17090301c200b0019663d0a674mr31697395plh.9.1676314227056;
        Mon, 13 Feb 2023 10:50:27 -0800 (PST)
Received: from f37.eng.vmware.com ([66.170.99.1])
        by smtp.googlemail.com with ESMTPSA id p14-20020a170902a40e00b00198f256a192sm8535036plq.171.2023.02.13.10.50.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 10:50:26 -0800 (PST)
From:   Shreenidhi Shedi <yesshedi@gmail.com>
X-Google-Original-From: Shreenidhi Shedi <sshedi@vmware.com>
To:     dhowells@redhat.com, dwmw2@infradead.org,
        gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Shreenidhi Shedi <sshedi@vmware.com>
Subject: [PATCH v2 3/6] sign-file: add support sign modules in bulk
Date:   Tue, 14 Feb 2023 00:20:15 +0530
Message-Id: <20230213185019.56902-3-sshedi@vmware.com>
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

