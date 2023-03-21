Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E184D6C3ABA
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 20:35:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbjCUTfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 15:35:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbjCUTez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 15:34:55 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1C8D57D17
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 12:34:22 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id h31so9247669pgl.6
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 12:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679427231;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yt1FiyCAq19UTY6Dgky638GY7WS05mpX7yYj+tKdXNE=;
        b=G4DGe8D49ZyzRrUhrQQPanlfHBcdpW5j9vA12O4p5GFkxEj8KfOPNduDd8eJDDmi4R
         /Y0CLxN44hQgnYW6d5krQNwnoMuICMjIL4YfI/VhQo7zUjkUoF7Xq7PwdgtSkp0ullne
         pNiy1gFBn4bJZ3T5Jzs54jqpYLJyeUIr/0HcCsdr6KNwTx++OlSa3kgg99Ziat8HpkdZ
         nzj163HyhmTE/B8FuXw83S5U7UQ7fXGIMeqXRy18MZkfzIjcp6eXAOLvJN40IYcT9aU9
         9x7XYA+BMCrVGu0bFtpzJefsURaLx0LsbUYeXCwu9QMJC9ZPsvwuv3NnO1c9zpuFfxnT
         eenA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679427231;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yt1FiyCAq19UTY6Dgky638GY7WS05mpX7yYj+tKdXNE=;
        b=hRMU1A0Va/f/cF3tGsO0pROp3W0oX5N70f/i4mF218WiBE8GK0I0b16/UMuH0kZkZa
         Zf3Ad1MCRRCF7YsPQB3sDQtkDwzXN/GJPKwfEgMjbfpbaA866FZC+CvvhZ2Q/ygr5trf
         LuLUnu966xv4tgxICs25uOBO5Yt+luTJw3oYO3QbAwxJ+v5kdaXGuvq/Shqf8zh8DvM9
         9sVbHXsAeBMfJbDdtH0VDLGNu0HNLtEHizMISAczF+HOWfyt/0AVm2i8MW7HiHa1tdrS
         KBHN376g7A/pcqKrDGLwlxC9ymRH5D/oGfEsiGzMvA3CWO9298NEwNHRXch/on7f34rW
         PkUg==
X-Gm-Message-State: AO0yUKXuLeFwdcF0FJWYJvMiz5kbC+gIf3LOx7zNep7lluGxSxsv1gOQ
        DaQlenQyKbwDvdBZms6/rsM=
X-Google-Smtp-Source: AK7set97hMjW3d32KCMpBcN+FBysPgtZHd/LBwqEusd8tRW8cRVK+BxeW3s5Nhi9cycbhhpO2MPr1A==
X-Received: by 2002:a62:38d0:0:b0:625:e192:1c7f with SMTP id f199-20020a6238d0000000b00625e1921c7fmr932785pfa.18.1679427231248;
        Tue, 21 Mar 2023 12:33:51 -0700 (PDT)
Received: from f37.eng.vmware.com ([66.170.99.1])
        by smtp.googlemail.com with ESMTPSA id k23-20020aa790d7000000b006247123adf1sm8843044pfk.143.2023.03.21.12.33.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 12:33:50 -0700 (PDT)
From:   Shreenidhi Shedi <yesshedi@gmail.com>
X-Google-Original-From: Shreenidhi Shedi <sshedi@vmware.com>
To:     gregkh@linuxfoundation.org, dhowells@redhat.com,
        dwmw2@infradead.org
Cc:     linux-kernel@vger.kernel.org, sshedi@vmware.com, yesshedi@gmail.com
Subject: [PATCH v6 5/7] sign-file: improve help message
Date:   Wed, 22 Mar 2023 01:03:39 +0530
Message-Id: <20230321193341.87997-6-sshedi@vmware.com>
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

Add a proper help message with examples on how to use this tool.

Signed-off-by: Shreenidhi Shedi <yesshedi@gmail.com>
---
 scripts/sign-file.c | 48 ++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 41 insertions(+), 7 deletions(-)

diff --git a/scripts/sign-file.c b/scripts/sign-file.c
index 0a275256ca16..d3abc5721a7e 100644
--- a/scripts/sign-file.c
+++ b/scripts/sign-file.c
@@ -74,12 +74,43 @@ struct module_signature {
 static char magic_number[] = "~Module signature appended~\n";
 
 static __attribute__((noreturn))
-void format(void)
+void print_usage(void)
 {
-	fprintf(stderr,
-		"Usage: scripts/sign-file [-dp] <hash algo> <key> <x509> <module> [<dest>]\n");
-	fprintf(stderr,
-		"       scripts/sign-file -s <raw sig> <hash algo> <x509> <module> [<dest>]\n");
+	fprintf(stderr, "Usage: scripts/sign-file [OPTIONS]... [MODULE]...\n");
+	fprintf(stderr, "Available options:\n");
+	fprintf(stderr, "-h, --help             Print this help message and exit\n");
+
+	fprintf(stderr, "\nOptional args:\n");
+	fprintf(stderr, "-s, --rawsig <sig>     Raw signature\n");
+	fprintf(stderr, "-p, --savesig          Save signature\n");
+	fprintf(stderr, "-d, --signonly         Sign only\n");
+#ifndef USE_PKCS7
+	fprintf(stderr, "-k, --usekeyid         Use key ID\n");
+#endif
+	fprintf(stderr, "-b, --bulksign         Sign modules in bulk\n");
+	fprintf(stderr, "-r, --replaceorig      Replace original\n");
+	fprintf(stderr, "-t, --dest <dest>      Destination path ");
+	fprintf(stderr, "(Exclusive with bulk option)\n");
+
+	fprintf(stderr, "\nMandatory args:\n");
+	fprintf(stderr, "-i, --privkey <key>    Private key\n");
+	fprintf(stderr, "-a, --hashalgo <alg>   Hash algorithm\n");
+	fprintf(stderr, "-x, --x509 <x509>      X509\n");
+
+	fprintf(stderr, "\nExamples:\n");
+
+	fprintf(stderr, "\n    Regular signing:\n");
+	fprintf(stderr, "     scripts/sign-file -a sha512 -i certs/signing_key.pem ");
+	fprintf(stderr, "-x certs/signing_key.x509 <module>\n");
+
+	fprintf(stderr, "\n    Signing with destination path:\n");
+	fprintf(stderr, "     scripts/sign-file -a sha512 -i certs/signing_key.pem ");
+	fprintf(stderr, "-x certs/signing_key.x509 <module> -t <path>\n");
+
+	fprintf(stderr, "\n    Signing modules in bulk:\n");
+	fprintf(stderr, "     scripts/sign-file -a sha512 -i certs/signing_key.pem ");
+	fprintf(stderr, "-x certs/signing_key.x509 -b <module1> <module2> ...\n");
+
 	exit(2);
 }
 
@@ -281,7 +312,7 @@ static void parse_args(int argc, char **argv, struct cmd_opts *opts)
 #endif
 
 		case 'h':
-			format();
+			print_usage();
 			break;
 
 		case 'i':
@@ -312,7 +343,7 @@ static void parse_args(int argc, char **argv, struct cmd_opts *opts)
 			break;
 
 		default:
-			format();
+			print_usage();
 			break;
 		}
 	} while (opt != -1);
@@ -472,6 +503,9 @@ int main(int argc, char **argv)
 	argc -= optind;
 	argv += optind;
 
+	if ((opts.bulk_sign && opts.dest_name) || (!opts.bulk_sign && argc != 1))
+		print_usage();
+
 	OpenSSL_add_all_algorithms();
 	ERR_load_crypto_strings();
 	ERR_clear_error();
-- 
2.39.2

