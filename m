Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B53E6C1EF6
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 19:04:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbjCTSEa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 14:04:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbjCTSDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 14:03:55 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6F3512CC7
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 10:58:02 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id h12-20020a17090aea8c00b0023d1311fab3so13322177pjz.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 10:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679335062;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yt1FiyCAq19UTY6Dgky638GY7WS05mpX7yYj+tKdXNE=;
        b=JhNz86edd2wSP2Dbug5Exwrik/eVP1fp2D/rR7T09pMJm4Hle/drrMkl/yu91l3Sz1
         exC0fsB6tuAOqjMii62WHKW3lRYZE5HViisHPmnfOV0uT4s02RntfH/xG5nvfUDSU44q
         DIVrpDgWXyQD/ZDNgF/on4aKOn2a7F1J1KTLI7crlHO2PutgvRTK6PN63Pl5EqCV7szp
         uL251qELjConE4xoFC0Kyoysv3tRR24ptwhfvwKcqGhM2U6KTYDeqGLuF44jTBaEP0oj
         FgBjl4iwS0ae99jMX4GPvPKDx/oOctvWSyDZDsNx6iuwZM+X8ehcGZQ43BG45SK+2vPK
         /7rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679335062;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yt1FiyCAq19UTY6Dgky638GY7WS05mpX7yYj+tKdXNE=;
        b=MZuY4PVK9S05PtdyOy2Tr3FnJAoWdzyWlEmVTqEqKgVdscmmlosRjPRYI34Tkb5iR3
         Ped9041plLUF8kUFwhhsNSJ36zs/sooDbKupJDDmofoky2jqWcxU8UHy9CEzITX48zCt
         60HbkRH47Jni+tXnKal+fAtGXTJDqmogPLUQoNlruJHg7xin0iASz9IHC1mBAkiMqJ5W
         yLXC7UtUocB6Y9+tpjBUsBSQ8SLAQrej9QDnLl/1KjeKNp51HJw3wIkCchsWFA58vubQ
         I6FhrnA/rkQhQfcdR/kMYPI6xG/aFOAh+8qLsa5JLpo+9toD7IJ6R2rybx76b9+8HtpL
         zbhw==
X-Gm-Message-State: AO0yUKWDDz3q9hRwKPOGjfB7QG9N/cvynRR3KUK+t6ohMG/NUyAIeVPs
        N7Wt3VeiLHn4xRdq4AZxHTU=
X-Google-Smtp-Source: AK7set8Xa+kdeHnddnIIlE6PXfhXrxcws0eohzeBCLtYHCx2zlj2PdPrnGRa1kmijojx938cRxcpjA==
X-Received: by 2002:a17:902:e883:b0:1a1:8007:d370 with SMTP id w3-20020a170902e88300b001a18007d370mr259065plg.33.1679335062332;
        Mon, 20 Mar 2023 10:57:42 -0700 (PDT)
Received: from f37.eng.vmware.com ([66.170.99.1])
        by smtp.googlemail.com with ESMTPSA id q2-20020a170902edc200b001a1a18a678csm7040042plk.148.2023.03.20.10.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 10:57:42 -0700 (PDT)
From:   Shreenidhi Shedi <yesshedi@gmail.com>
X-Google-Original-From: Shreenidhi Shedi <sshedi@vmware.com>
To:     gregkh@linuxfoundation.org, dhowells@redhat.com,
        dwmw2@infradead.org
Cc:     yesshedi@gmail.com, linux-kernel@vger.kernel.org, sshedi@vmware.com
Subject: [PATCH v5 5/7] sign-file: improve help message
Date:   Mon, 20 Mar 2023 23:27:29 +0530
Message-Id: <20230320175731.79709-5-sshedi@vmware.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230320175731.79709-1-sshedi@vmware.com>
References: <20230320175731.79709-1-sshedi@vmware.com>
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
