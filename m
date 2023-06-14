Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22D48730B40
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 01:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236873AbjFNXMC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 19:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235582AbjFNXLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 19:11:16 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09A902704
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 16:10:42 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3f8cc04c2adso12893965e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 16:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1686784222; x=1689376222;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZLVT1IFfFWBb7QbzW7DDE2SW1anaahsXLzNb90TUU+4=;
        b=McNAMR/RyUb8zZTperIBwOYHNkmX+sFEWEbsaTcTyEoneJHKA9IjmSxYn7L4n1Afj2
         Il1bxZ5SNHrD2IiNrWAc0pEZT5ewrRfkfgsJIJxYRw701JNf9FQxB/3bOGBx6gY8mzG9
         4GTCneYgA17JpPHeleUUIIx1912c53Dhua+8KZmx3sT2GgdpdmXUaMb8oh5eitpRiEh6
         eyI/zbuHBfFcvdMPgFDFnhHdHvr6z9gd2QiCLT0ER3gs1EaugR7Ybkbig/Fga6PecCN7
         pNX2Ycymb0vBlEL5dKos/LycD5h6j6WZZtsrouo1uFMvxpMr6Db/f8nBmMK86v3ZPB83
         midA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686784222; x=1689376222;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZLVT1IFfFWBb7QbzW7DDE2SW1anaahsXLzNb90TUU+4=;
        b=KmWaPbgIuvfDMccqZPRM5AGxNRdGOldWqW1eRyOxyppsZ/s2N7TU7CEkOI9xnz9s+Y
         1aE/8mA/JH0uhaduIP2nHi057H7nJA+m+OsdMr50LclEPdeifaEqJJoji+e1nKgz5vXS
         cfZvF7Gqy4Klb6dnY0dkSvi1e/QQL1L2CA/5jGobDSjgupS4LvvsVKk60PAWYhKL7vxh
         hA04I6/rQn1lSCYhoNltadoUFhrj+r9dnBogW+p6P2jADNcjqykcj52/p69x5zVBFPzC
         o+OB+rLBDzEoc67lY/9+2MAFYRvOP+VmIytUT41Z+cSOl2awqftmZ9LaOkuYpFFjZZ/T
         YeJg==
X-Gm-Message-State: AC+VfDybJOi9gstHaY9ac3m5vPB8E4XTHa2fDu52pfxdGF5QZVSJFyzE
        aVZzcgPVjLu3MEYdYLgzYtO6ZA==
X-Google-Smtp-Source: ACHHUZ4JRxKIUcBjqZJRuuYBiBjp//rWcq2ZiN9dnYXccbegZyvd2FHuCgZlYl4bPMwzinNC83mVxA==
X-Received: by 2002:a7b:c8d3:0:b0:3f7:f584:5792 with SMTP id f19-20020a7bc8d3000000b003f7f5845792mr14535709wml.0.1686784222009;
        Wed, 14 Jun 2023 16:10:22 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id s12-20020a7bc38c000000b003f7ba52eeccsm18725261wmj.7.2023.06.14.16.10.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 16:10:21 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     David Ahern <dsahern@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Cc:     linux-kernel@vger.kernel.org, Dmitry Safonov <dima@arista.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Ard Biesheuvel <ardb@kernel.org>,
        Bob Gilligan <gilligan@arista.com>,
        Dan Carpenter <error27@gmail.com>,
        David Laight <David.Laight@aculab.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Donald Cassidy <dcassidy@redhat.com>,
        Eric Biggers <ebiggers@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Francesco Ruggeri <fruggeri05@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Ivan Delalande <colona@arista.com>,
        Leonard Crestez <cdleonard@gmail.com>,
        Salam Noureddine <noureddine@arista.com>,
        netdev@vger.kernel.org
Subject: [PATCH v7 17/22] net/tcp: Add option for TCP-AO to (not) hash header
Date:   Thu, 15 Jun 2023 00:09:42 +0100
Message-Id: <20230614230947.3954084-18-dima@arista.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230614230947.3954084-1-dima@arista.com>
References: <20230614230947.3954084-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide setsockopt() key flag that makes TCP-AO exclude hashing TCP
header for peers that match the key. This is needed for interraction
with middleboxes that may change TCP options, see RFC5925 (9.2).

Co-developed-by: Francesco Ruggeri <fruggeri@arista.com>
Signed-off-by: Francesco Ruggeri <fruggeri@arista.com>
Co-developed-by: Salam Noureddine <noureddine@arista.com>
Signed-off-by: Salam Noureddine <noureddine@arista.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 include/uapi/linux/tcp.h | 5 +++++
 net/ipv4/tcp_ao.c        | 8 +++++---
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/include/uapi/linux/tcp.h b/include/uapi/linux/tcp.h
index ca7ed18ce67b..3275ade3293a 100644
--- a/include/uapi/linux/tcp.h
+++ b/include/uapi/linux/tcp.h
@@ -354,6 +354,11 @@ struct tcp_diag_md5sig {
 #define TCP_AO_MAXKEYLEN	80
 
 #define TCP_AO_KEYF_IFINDEX	(1 << 0)	/* L3 ifindex for VRF */
+#define TCP_AO_KEYF_EXCLUDE_OPT	(1 << 1)	/* "Indicates whether TCP
+						 *  options other than TCP-AO
+						 *  are included in the MAC
+						 *  calculation"
+						 */
 
 struct tcp_ao_add { /* setsockopt(TCP_AO_ADD_KEY) */
 	struct __kernel_sockaddr_storage addr;	/* peer's address for the key */
diff --git a/net/ipv4/tcp_ao.c b/net/ipv4/tcp_ao.c
index af4934cb23a5..1a5a6b38b3b4 100644
--- a/net/ipv4/tcp_ao.c
+++ b/net/ipv4/tcp_ao.c
@@ -566,7 +566,8 @@ int tcp_ao_hash_hdr(unsigned short int family, char *ao_hash,
 		WARN_ON_ONCE(1);
 		goto clear_hash;
 	}
-	if (tcp_ao_hash_header(&hp, th, false,
+	if (tcp_ao_hash_header(&hp, th,
+			       !!(key->keyflags & TCP_AO_KEYF_EXCLUDE_OPT),
 			       ao_hash, hash_offset, tcp_ao_maclen(key)))
 		goto clear_hash;
 	ahash_request_set_crypt(hp.req, NULL, tmp_hash, 0);
@@ -609,7 +610,8 @@ int tcp_ao_hash_skb(unsigned short int family,
 		goto clear_hash;
 	if (tcp_ao_hash_pseudoheader(family, sk, skb, &hp, skb->len))
 		goto clear_hash;
-	if (tcp_ao_hash_header(&hp, th, false,
+	if (tcp_ao_hash_header(&hp, th,
+			       !!(key->keyflags & TCP_AO_KEYF_EXCLUDE_OPT),
 			       ao_hash, hash_offset, tcp_ao_maclen(key)))
 		goto clear_hash;
 	if (tcp_sigpool_hash_skb_data(&hp, skb, th->doff << 2))
@@ -1418,7 +1420,7 @@ static struct tcp_ao_info *setsockopt_ao_info(struct sock *sk)
 	return ERR_PTR(-ESOCKTNOSUPPORT);
 }
 
-#define TCP_AO_KEYF_ALL		(0)
+#define TCP_AO_KEYF_ALL		(TCP_AO_KEYF_EXCLUDE_OPT)
 
 static int tcp_ao_add_cmd(struct sock *sk, unsigned short int family,
 			  sockptr_t optval, int optlen)
-- 
2.40.0

