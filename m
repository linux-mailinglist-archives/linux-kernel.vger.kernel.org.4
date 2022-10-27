Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A5BA610356
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 22:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236947AbiJ0UuQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 16:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237079AbiJ0Uso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 16:48:44 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8514913E3D
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 13:44:47 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id v130-20020a1cac88000000b003bcde03bd44so5031831wme.5
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 13:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+hdisk2huNybtWVXbtT77JtWTDX9XIc08M/YyYNQqQA=;
        b=MM8otwdC1LN6OlvEG3BsuhkUbKyfXU0Gw9ltqT8j5DlmSOuwH3akRiMcBkqr1LxZwv
         WVkTGPBIPKvb9LLxgN5dpr3kAxslA7vmqoVRPfb6BYsG3k+xHpVlqtEJ96EPIkbZ7obO
         aaang8AdmLd0ddkxrre13QxJyh97ceo38siZ6S4NNk/BSva1bMi/PwXklRVNOAHva9Ob
         FCJD5ODwXDWGUJuF3rNTCeWGDx4+yhI3cD6eN2cpsFBT6ZuxRYUQI54faEnwKvHgGr17
         j5f+8d0Jti2Vga93K4Q1CrOXVrtZro8+lNuJ0oD+pUHZWrWuQ7Ty03k5B3yR+DOOiVS2
         2IMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+hdisk2huNybtWVXbtT77JtWTDX9XIc08M/YyYNQqQA=;
        b=cd7UdTJlj4WDURtRECnYIvTSlA6iOt3JS5MiIb8ieJEMTswVXL1bW8Odmtcu0Z6lVH
         2gckw+PnlS79rd9VK3t0WniIw75dQo4Bwr/VyrkQYGB7m0yii4zJfw/s0erDCMw17Re9
         yK7KvPiWrcqWtIyhaczTzi8DEBELdFpDYU3Ta7ehDz92F2HiEvkM2ND+9PrA7sLsyFR7
         IYcwqSdANvPgV4p1Mbbmvf4Izt1hjF0gaXnn4TC6epQ9932u1EnjRNdtwlBA6Xistncf
         jqVxKp1svdsJDI+q2cYjPBdfMVpqAIBYPYLty85CH8MK7vgSGE+EYAzrxT1Bj9gq3sOT
         xSjQ==
X-Gm-Message-State: ACrzQf1s/5wpzAHGk0XIDU5KCJ5bT/EfOUfEaA7CR25pVb8rYslvnQfL
        CzxnJDesdMf2tiR9cnVrPZnqXdK12tx9fS1c
X-Google-Smtp-Source: AMsMyM5SF49nP77j8TfEXrfOKQS7xRflyPat+mSDDrloLi2E6Ob4dMgZY72Rt5v2+BW3WzIkv7/s6g==
X-Received: by 2002:a05:600c:19d2:b0:3c6:fbb9:ca9a with SMTP id u18-20020a05600c19d200b003c6fbb9ca9amr7330350wmq.110.1666903486720;
        Thu, 27 Oct 2022 13:44:46 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id n3-20020a5d6b83000000b00236644228besm1968739wrx.40.2022.10.27.13.44.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 13:44:46 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org, David Ahern <dsahern@kernel.org>,
        Eric Dumazet <edumazet@google.com>
Cc:     Dmitry Safonov <dima@arista.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Ard Biesheuvel <ardb@kernel.org>,
        Bob Gilligan <gilligan@arista.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        "David S. Miller" <davem@davemloft.net>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Eric Biggers <ebiggers@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Francesco Ruggeri <fruggeri@arista.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Ivan Delalande <colona@arista.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Leonard Crestez <cdleonard@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Salam Noureddine <noureddine@arista.com>,
        Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
        linux-crypto@vger.kernel.org
Subject: [PATCH v3 34/36] selftest/nettest: Rename md5_prefix* => auth_prefix*
Date:   Thu, 27 Oct 2022 21:43:45 +0100
Message-Id: <20221027204347.529913-35-dima@arista.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221027204347.529913-1-dima@arista.com>
References: <20221027204347.529913-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now it's going to be used for TCP-AO testing too.

Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 tools/testing/selftests/net/nettest.c | 28 +++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/net/nettest.c b/tools/testing/selftests/net/nettest.c
index b9e600899cf6..3499d6aff9e4 100644
--- a/tools/testing/selftests/net/nettest.c
+++ b/tools/testing/selftests/net/nettest.c
@@ -97,11 +97,11 @@ struct sock_args {
 
 	const char *password;
 	/* prefix for MD5 password */
-	const char *md5_prefix_str;
+	const char *auth_prefix_str;
 	union {
 		struct sockaddr_in v4;
 		struct sockaddr_in6 v6;
-	} md5_prefix;
+	} auth_prefix;
 	unsigned int prefix_len;
 	/* 0: default, -1: force off, +1: force on */
 	int bind_key_ifindex;
@@ -274,7 +274,7 @@ static int tcp_md5sig(int sd, void *addr, socklen_t alen, struct sock_args *args
 		md5sig.tcpm_flags |= TCP_MD5SIG_FLAG_PREFIX;
 
 		md5sig.tcpm_prefixlen = args->prefix_len;
-		addr = &args->md5_prefix;
+		addr = &args->auth_prefix;
 	}
 	memcpy(&md5sig.tcpm_addr, addr, alen);
 
@@ -314,13 +314,13 @@ static int tcp_md5_remote(int sd, struct sock_args *args)
 	switch (args->version) {
 	case AF_INET:
 		sin.sin_port = htons(args->port);
-		sin.sin_addr = args->md5_prefix.v4.sin_addr;
+		sin.sin_addr = args->auth_prefix.v4.sin_addr;
 		addr = &sin;
 		alen = sizeof(sin);
 		break;
 	case AF_INET6:
 		sin6.sin6_port = htons(args->port);
-		sin6.sin6_addr = args->md5_prefix.v6.sin6_addr;
+		sin6.sin6_addr = args->auth_prefix.v6.sin6_addr;
 		addr = &sin6;
 		alen = sizeof(sin6);
 		break;
@@ -753,11 +753,11 @@ static int convert_addr(struct sock_args *args, const char *_str,
 	case ADDR_TYPE_MD5_PREFIX:
 		desc = "md5 prefix";
 		if (family == AF_INET) {
-			args->md5_prefix.v4.sin_family = AF_INET;
-			addr = &args->md5_prefix.v4.sin_addr;
+			args->auth_prefix.v4.sin_family = AF_INET;
+			addr = &args->auth_prefix.v4.sin_addr;
 		} else if (family == AF_INET6) {
-			args->md5_prefix.v6.sin6_family = AF_INET6;
-			addr = &args->md5_prefix.v6.sin6_addr;
+			args->auth_prefix.v6.sin6_family = AF_INET6;
+			addr = &args->auth_prefix.v6.sin6_addr;
 		} else
 			return 1;
 
@@ -840,8 +840,8 @@ static int validate_addresses(struct sock_args *args)
 	    convert_addr(args, args->remote_addr_str, ADDR_TYPE_REMOTE) < 0)
 		return 1;
 
-	if (args->md5_prefix_str &&
-	    convert_addr(args, args->md5_prefix_str,
+	if (args->auth_prefix_str &&
+	    convert_addr(args, args->auth_prefix_str,
 			 ADDR_TYPE_MD5_PREFIX) < 0)
 		return 1;
 
@@ -2029,7 +2029,7 @@ int main(int argc, char *argv[])
 			args.password = optarg;
 			break;
 		case 'm':
-			args.md5_prefix_str = optarg;
+			args.auth_prefix_str = optarg;
 			break;
 		case 'S':
 			args.use_setsockopt = 1;
@@ -2091,13 +2091,13 @@ int main(int argc, char *argv[])
 	}
 
 	if (args.password && (!args.use_md5 ||
-	      (!args.has_remote_ip && !args.md5_prefix_str) ||
+	      (!args.has_remote_ip && !args.auth_prefix_str) ||
 	      args.type != SOCK_STREAM)) {
 		log_error("MD5 passwords apply to TCP only and require a remote ip for the password\n");
 		return 1;
 	}
 
-	if ((args.md5_prefix_str || args.use_md5) && !args.password) {
+	if ((args.auth_prefix_str || args.use_md5) && !args.password) {
 		log_error("Prefix range for MD5 protection specified without a password\n");
 		return 1;
 	}
-- 
2.38.1

