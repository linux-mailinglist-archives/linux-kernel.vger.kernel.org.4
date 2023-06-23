Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F27473BADB
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 16:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbjFWOzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 10:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232399AbjFWOyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 10:54:21 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBCA72941
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 07:54:15 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id 46e09a7af769-6b2e1023f30so662427a34.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 07:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687532055; x=1690124055;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ig5W7IVmZukpubm43ufz7bJD8pT18xKkNxAjQ1Pkr0Y=;
        b=mWNYBsOVNReTLch69z2CEumPZRT6UcZtF/BD8Ozj7w2ycCpL13Kh0uK39RyCi6IfLJ
         pi3f3Le30fYMbrTAoVY8JOBhHwbuNA5q4+m/qna86/2OgXn8oBzKz41ou4ohtjwBy+nK
         kc8D8dE/Wzywwu31EsoebSy6nek6bCqb6Xg0UVnTVvbuUEmlEKz9ajrY44jgudhGeb+L
         p+N3qalRdRjQOgYaUHZnaTe8MA1p+BomL3fgdGU2LFqwKTpcYLQH2eD7GfJWAtPfnbHm
         c6gJIsfgLBxFccDBRp3Babnm0mFiDKENpTnPqNeWDzddLci68mDkFa/xWuxHUZJxTE6c
         P6dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687532055; x=1690124055;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ig5W7IVmZukpubm43ufz7bJD8pT18xKkNxAjQ1Pkr0Y=;
        b=WSn5wl5ry3yHegV48ws6EpAXVn7HBJAYBXv1RB+dxPCqP63brTvO3SWHbsSw0xkGVJ
         P2Ti2W02QeQ6I4lIekuYngHIjhfbzOSUOQNcki3PUbnMC/G8v2wI2FKEUoQgQ7WE5fwy
         CO22bMllir7cCnrl4GoXuKpNgcpv7rQQ6P2MLR3r3nTUpo68DIecFKqmsTRtstoLMXGi
         /ZBNtjU3AcL1/aqxxzDhXEI2NXKH0atTsFbcSMHaAZs1rHljKsVB1pRe7keT5NeLMMFv
         Bl2fKlDeATi7hVVSLkPer8T4IZuAULNUjbVBNSvrZEQkViludNS7dXJ9ao7SF8NoCVPm
         nokQ==
X-Gm-Message-State: AC+VfDyE2DatsJOVXLZ8V+6GVzx/o7PEhw4EYL02Ebu4GAG1qpmmfgMN
        YORVrDn9vDbNWPG1QE+J6dk=
X-Google-Smtp-Source: ACHHUZ4TcEJe8yA2NMia0Jt0nUkh2/+lV9ASzPHBu3Zj3nwOilvAdy7Hna++SjZeGGEJsN33I3NX1Q==
X-Received: by 2002:a05:6808:8ef:b0:3a0:57d5:c0de with SMTP id d15-20020a05680808ef00b003a057d5c0demr5726095oic.31.1687532054920;
        Fri, 23 Jun 2023 07:54:14 -0700 (PDT)
Received: from f38.eng.vmware.com ([66.170.99.1])
        by smtp.googlemail.com with ESMTPSA id fa17-20020a17090af0d100b002565cd237cdsm3359624pjb.3.2023.06.23.07.54.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 07:54:14 -0700 (PDT)
From:   Shreenidhi Shedi <yesshedi@gmail.com>
To:     dhowells@redhat.com, dwmw2@infradead.org,
        gregkh@linuxfoundation.org, masahiroy@kernel.org,
        nathan@kernel.org, ndesaulniers@google.com, nicolas@fjasle.eu
Cc:     yesshedi@gmail.com, linux-kernel@vger.kernel.org, sshedi@vmware.com
Subject: [PATCH v7 5/8] sign-file: improve help message
Date:   Fri, 23 Jun 2023 20:23:55 +0530
Message-ID: <20230623145358.568971-6-yesshedi@gmail.com>
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
2.41.0

