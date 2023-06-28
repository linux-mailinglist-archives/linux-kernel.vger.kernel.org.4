Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94F24740DD7
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 12:03:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233672AbjF1Jym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 05:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232367AbjF1Ju1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 05:50:27 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E99812943
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 02:48:38 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3fa8ce2307dso48664805e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 02:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1687945717; x=1690537717;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q0Ycx9rqV3D/zA7/T+TxIq8v+2HMo/m8p4cd8mt3s7E=;
        b=QWjxAtXeNyxUEr3HqyMhBAli7xZgz1k4UcSW1H9UcZerboU0lSU8IGFC6XyeWGQ9JR
         U7VBsYZbTjMejj7KA5MSKN10jSwf62ZuNt3bFw83lanp/XfY2K+koZEVyevzvAG7fbC3
         a+YSOOXJCPGX4ENL0Q30+xCdmUG0xm7dXBvWYrqzVxBUnNd2yXkFLl4DCc5qFsUezakr
         zAXrWsGL1gLMjj72NRUqzd/FldkOu6bW/7dibagnwl9jBTMPPm1kMJ/fq2/HDJuvfqc8
         ZkAwOUYyegU9R3OoDxoVkv2QlL+YRZVzy0eU5M1jPZ72EX7y1yckk3aQPm5q2yZB3mkD
         zxAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687945717; x=1690537717;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q0Ycx9rqV3D/zA7/T+TxIq8v+2HMo/m8p4cd8mt3s7E=;
        b=UK+g2P7Ckfg7Dv5rQYM+9L8SRjVIlrKahRldMQn+sI33eJd2ev+zEnfAzAdKV6Y3H0
         eK9Vn0lXWtVPt/OBThD1E30yT1aIHB7lDSvUzYsPO2i5EPZ8sj98R5k9Lp/awI7ZkGd3
         XfxeeQ5YL85uiwhPjzLQWmZMalggw5y0bY1erDN9FLetaV7yi6Jq9/ComSUk08T1cDHf
         g48u1ziQsw3rOyBomN4i7qVrrg+FexyHWpoiAbjS2xOI8e0foy8pDHLBcMIftPbp/54/
         yb7QSwsmXG8NOMvo1xk3kCoHn5KTiuht1KkTZ2tp1iJcn8oXBpsMGqMhGOcE2UcJsC9L
         KJ/A==
X-Gm-Message-State: AC+VfDxJbznapXBX920m2fdlU2UJ6u84oST4Kt6B44IcJFhyzE+KK6SJ
        a+w140rUoDpnBNPuU5yE4CwbVQ==
X-Google-Smtp-Source: ACHHUZ5IGzACiYjzObSRQVwyoJgzXYQReA2O8yPefYLwoaO1JQB0+XETZLjXXBWR2k6AwfGSPIB2GQ==
X-Received: by 2002:a7b:c393:0:b0:3fb:b005:99d6 with SMTP id s19-20020a7bc393000000b003fbb00599d6mr2104686wmj.2.1687945717263;
        Wed, 28 Jun 2023 02:48:37 -0700 (PDT)
Received: from [192.168.1.193] (f.c.7.0.0.0.0.0.0.0.0.0.0.0.0.0.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff::7cf])
        by smtp.gmail.com with ESMTPSA id k26-20020a7bc41a000000b003fbb1a9586esm1187613wmi.15.2023.06.28.02.48.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 02:48:37 -0700 (PDT)
From:   Lorenz Bauer <lmb@isovalent.com>
Date:   Wed, 28 Jun 2023 10:48:16 +0100
Subject: [PATCH bpf-next v4 1/7] udp: re-score reuseport groups when
 connected sockets are present
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230613-so-reuseport-v4-1-4ece76708bba@isovalent.com>
References: <20230613-so-reuseport-v4-0-4ece76708bba@isovalent.com>
In-Reply-To: <20230613-so-reuseport-v4-0-4ece76708bba@isovalent.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        David Ahern <dsahern@kernel.org>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Joe Stringer <joe@wand.net.nz>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        Kuniyuki Iwashima <kuniyu@amazon.com>
Cc:     Hemanth Malla <hemanthmalla@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Lorenz Bauer <lmb@isovalent.com>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Contrary to TCP, UDP reuseport groups can contain TCP_ESTABLISHED
sockets. To support these properly we remember whether a group has
a connected socket and skip the fast reuseport early-return. In
effect we continue scoring all reuseport sockets and then choose the
one with the highest score.

The current code fails to re-calculate the score for the result of
lookup_reuseport. According to Kuniyuki Iwashima:

    1) SO_INCOMING_CPU is set
       -> selected sk might have +1 score

    2) BPF prog returns ESTABLISHED and/or SO_INCOMING_CPU sk
       -> selected sk will have more than 8

  Using the old score could trigger more lookups depending on the
  order that sockets are created.

    sk -> sk (SO_INCOMING_CPU) -> sk (ESTABLISHED)
    |     |
    `-> select the next SO_INCOMING_CPU sk
          |
          `-> select itself (We should save this lookup)

Fixes: efc6b6f6c311 ("udp: Improve load balancing for SO_REUSEPORT.")
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Signed-off-by: Lorenz Bauer <lmb@isovalent.com>
---
 net/ipv4/udp.c | 20 +++++++++++++++-----
 net/ipv6/udp.c | 19 ++++++++++++++-----
 2 files changed, 29 insertions(+), 10 deletions(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index fd3dae081f3a..5ef478d2c408 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -450,14 +450,24 @@ static struct sock *udp4_lib_lookup2(struct net *net,
 		score = compute_score(sk, net, saddr, sport,
 				      daddr, hnum, dif, sdif);
 		if (score > badness) {
-			result = lookup_reuseport(net, sk, skb,
-						  saddr, sport, daddr, hnum);
+			badness = score;
+			result = lookup_reuseport(net, sk, skb, saddr, sport, daddr, hnum);
+			if (!result) {
+				result = sk;
+				continue;
+			}
+
 			/* Fall back to scoring if group has connections */
-			if (result && !reuseport_has_conns(sk))
+			if (!reuseport_has_conns(sk))
 				return result;
 
-			result = result ? : sk;
-			badness = score;
+			/* Reuseport logic returned an error, keep original score. */
+			if (IS_ERR(result))
+				continue;
+
+			badness = compute_score(result, net, saddr, sport,
+						daddr, hnum, dif, sdif);
+
 		}
 	}
 	return result;
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index e5a337e6b970..8b3cb1d7da7c 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -193,14 +193,23 @@ static struct sock *udp6_lib_lookup2(struct net *net,
 		score = compute_score(sk, net, saddr, sport,
 				      daddr, hnum, dif, sdif);
 		if (score > badness) {
-			result = lookup_reuseport(net, sk, skb,
-						  saddr, sport, daddr, hnum);
+			badness = score;
+			result = lookup_reuseport(net, sk, skb, saddr, sport, daddr, hnum);
+			if (!result) {
+				result = sk;
+				continue;
+			}
+
 			/* Fall back to scoring if group has connections */
-			if (result && !reuseport_has_conns(sk))
+			if (!reuseport_has_conns(sk))
 				return result;
 
-			result = result ? : sk;
-			badness = score;
+			/* Reuseport logic returned an error, keep original score. */
+			if (IS_ERR(result))
+				continue;
+
+			badness = compute_score(sk, net, saddr, sport,
+						daddr, hnum, dif, sdif);
 		}
 	}
 	return result;

-- 
2.40.1

