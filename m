Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5547A5E8351
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 22:17:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232628AbiIWUQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 16:16:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232726AbiIWUOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 16:14:51 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1458E1332CD
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 13:14:01 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id e18so884564wmq.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 13:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=omPcANhkDYXsttu7V77o+0m0rXNlEJe+soEVPioXIls=;
        b=Ei83+E3Bo/lfnAf2JZHG135FT1408OrZaa5LGAwc1l1gPGgn+DOXN1fTW38UctZZeA
         LS+y7/IO0G6uCWhT9c92n2kPo2pfo9JUkTeSia+IxXbKoNAkQVzwMrvMUu/Dg9BiDFA4
         ETCv0zGkgAas6tDAENVh/RbL55Ig25s0zAXsoorF6UXUtuO4TrNcP9/PWmX7fJqyrBmH
         cX7VVf5S0ve+eovBtkNSfrDPnOByBJOs8fakLhNC05l/TGxLmU4uGu7397KI6TZYErMP
         XStOqPD3LCc4+Tp7FjVDDxJqAsmrSYuWsWII/8zZCRiC6xK7chxyXEDKIdCpRCVDl3So
         y9jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=omPcANhkDYXsttu7V77o+0m0rXNlEJe+soEVPioXIls=;
        b=ks//reN+RT7vv+3JUVdf/edio59oAeGjDEsM5ftdx5kNaS3CiPT0nuB7MPageaPhLD
         7Jpx4nqMGoHDezWgIY3RkXOGp585bBz+FFgsv6RBsJISOr2ywbcCrZHRGLnFaGCLUEQR
         nx83TOj4qHzRhg8XBa6xxkoHBxWXJ2RXX5U6iGRpxLAg+6wz5U1qzxXV1kdXWZtAWWLz
         5ra45GvVL0YA7Du/KQakKAuOp0hGKNKK7yxDzaoEUZIskRbg6vnUZk3Ij+KNZl/OGt61
         t0NkCw4PSIzcIMwtF7HaLn7ZEY2pSRuuOI/gWc7QeT8Gt7ghfyVUQzTqpOKEAUWhCsaV
         N1tw==
X-Gm-Message-State: ACrzQf2zjiw80pq9E4/lR6gFls707JT819iKbitfsNK81xa2jWPV9Ovn
        Flm9QYnYSDvUPaztO1m1doVqMH9Bqcaf+A==
X-Google-Smtp-Source: AMsMyM4PzLZlgPZllGkVVSpdzD1WLuyWXIG/xOOZ+PlpdGRlnS/041SJjh16WKg+s41XUWtyoMSong==
X-Received: by 2002:a05:600c:4f06:b0:3b4:b67c:68bb with SMTP id l6-20020a05600c4f0600b003b4b67c68bbmr14280763wmq.36.1663964041204;
        Fri, 23 Sep 2022 13:14:01 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id k11-20020a05600c0b4b00b003b492753826sm3281056wmr.43.2022.09.23.13.13.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 13:14:00 -0700 (PDT)
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
Subject: [PATCH v2 22/35] net/tcp: Add option for TCP-AO to (not) hash header
Date:   Fri, 23 Sep 2022 21:13:06 +0100
Message-Id: <20220923201319.493208-23-dima@arista.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220923201319.493208-1-dima@arista.com>
References: <20220923201319.493208-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
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
 include/uapi/linux/tcp.h | 2 ++
 net/ipv4/tcp_ao.c        | 8 +++++---
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/include/uapi/linux/tcp.h b/include/uapi/linux/tcp.h
index 508bedbc6ad8..b60933ee2a27 100644
--- a/include/uapi/linux/tcp.h
+++ b/include/uapi/linux/tcp.h
@@ -347,6 +347,8 @@ struct tcp_diag_md5sig {
 
 #define TCP_AO_MAXKEYLEN	80
 
+#define TCP_AO_KEYF_EXCLUDE_OPT	(1 << 0)
+
 #define TCP_AO_CMDF_CURR	(1 << 0)	/* Only checks field sndid */
 #define TCP_AO_CMDF_NEXT	(1 << 1)	/* Only checks field rcvid */
 #define TCP_AO_CMDF_ACCEPT_ICMP	(1 << 2)	/* Accept incoming ICMPs */
diff --git a/net/ipv4/tcp_ao.c b/net/ipv4/tcp_ao.c
index 5fb36863810d..f5489b73fae0 100644
--- a/net/ipv4/tcp_ao.c
+++ b/net/ipv4/tcp_ao.c
@@ -603,7 +603,8 @@ int tcp_ao_hash_hdr(unsigned short int family, char *ao_hash,
 		WARN_ON_ONCE(1);
 		goto clear_hash;
 	}
-	if (tcp_ao_hash_header(&hp, th, false,
+	if (tcp_ao_hash_header(&hp, th,
+			       !!(key->keyflags & TCP_AO_KEYF_EXCLUDE_OPT),
 			       ao_hash, hash_offset, tcp_ao_maclen(key)))
 		goto clear_hash;
 	ahash_request_set_crypt(hp.req, NULL, ao_hash, 0);
@@ -645,7 +646,8 @@ int tcp_ao_hash_skb(unsigned short int family,
 		goto clear_hash;
 	if (tcp_ao_hash_pseudoheader(family, sk, skb, &hp, skb->len))
 		goto clear_hash;
-	if (tcp_ao_hash_header(&hp, th, false,
+	if (tcp_ao_hash_header(&hp, th,
+			       !!(key->keyflags & TCP_AO_KEYF_EXCLUDE_OPT),
 			       ao_hash, hash_offset, tcp_ao_maclen(key)))
 		goto clear_hash;
 	if (tcp_ao_hash_skb_data(&hp, skb, th->doff << 2))
@@ -1455,7 +1457,7 @@ static inline bool tcp_ao_mkt_overlap_v6(struct tcp_ao *cmd,
 }
 #endif
 
-#define TCP_AO_KEYF_ALL		(0)
+#define TCP_AO_KEYF_ALL		(TCP_AO_KEYF_EXCLUDE_OPT)
 #define TCP_AO_CMDF_ADDMOD_VALID					\
 	(TCP_AO_CMDF_CURR | TCP_AO_CMDF_NEXT | TCP_AO_CMDF_ACCEPT_ICMP)
 #define TCP_AO_CMDF_DEL_VALID						\
-- 
2.37.2

