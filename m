Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 411FF712C54
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 20:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236811AbjEZSRb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 14:17:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242209AbjEZSR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 14:17:28 -0400
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA80C1B3;
        Fri, 26 May 2023 11:17:26 -0700 (PDT)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-561b50c1856so16258927b3.0;
        Fri, 26 May 2023 11:17:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685125046; x=1687717046;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HHy+mHaZfWd/b8HPsmKokkSTajHOg8KJX+wNzl/xSqE=;
        b=FRhFp4uk2tv4CvdlUSHx5+wwS+qGGamshFQ/1n5Wvltl1wFDxZAxECzsNnrR/WunPD
         93UBm+oO59xVYNutTlgEOW7/iU2FfZARoZKosiYeKRTYj0P+S297pmur9ZTl38yw95CR
         3chc86c4976i0e/+GGl6IBqoBa6vj2q4GFwLNGZuvYIF24ZimN/bqE7zhpiTiMbnzzar
         mIJTOvgtg7ynONo6G1mvMbOJAv2jBRhQ99lzeg5T34uHhg+3Y2Bicrde1CQxp01gL+6c
         GBGlpl7uZSHaEENLRfU5SFoEr/mDLoqu5muL0pbHgLA/o8+3xvcKQ13BRaf+ItETg5lX
         4QUg==
X-Gm-Message-State: AC+VfDyaJvuvOB4sCF5eFoQeD9PH3Yo4D2/StjB4Z9ZK3+5H5lnstnyB
        3oPk05bDW160GmTc4GvI9tY=
X-Google-Smtp-Source: ACHHUZ61F3PuTg1MKogFgXO2FSGFp+kxuuybw7ISD/Gk+vw/LKRjhTCU9ir0od+jnG28BX/g9kcTiA==
X-Received: by 2002:a81:5407:0:b0:55a:9b89:4eff with SMTP id i7-20020a815407000000b0055a9b894effmr2925252ywb.13.1685125045742;
        Fri, 26 May 2023 11:17:25 -0700 (PDT)
Received: from tofu.cs.purdue.edu ([128.210.0.165])
        by smtp.gmail.com with ESMTPSA id a130-20020a0dd888000000b0054fbadd96c4sm332628ywe.126.2023.05.26.11.17.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 11:17:25 -0700 (PDT)
From:   Sungwoo Kim <iam@sung-woo.kim>
To:     iam@sung-woo.kim
Cc:     benquike@gmail.com, davem@davemloft.net, daveti@purdue.edu,
        edumazet@google.com, happiness.sung.woo@gmail.com,
        johan.hedberg@gmail.com, kuba@kernel.org,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        luiz.dentz@gmail.com, marcel@holtmann.org, netdev@vger.kernel.org,
        pabeni@redhat.com, wuruoyu@me.com
Subject: [PATCH] Bluetooth: L2CAP: Fix use-after-free in l2cap_sock_ready_cb
Date:   Fri, 26 May 2023 14:16:48 -0400
Message-Id: <20230526181647.3074391-1-iam@sung-woo.kim>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230202120902.2827191-1-iam@sung-woo.kim>
References: <20230202120902.2827191-1-iam@sung-woo.kim>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>    net/bluetooth/l2cap_sock.c: In function 'l2cap_sock_release':
> >> net/bluetooth/l2cap_sock.c:1418:9: error: implicit declaration of function 'l2cap_sock_cleanup_listen'; did you mean 'l2cap_sock_listen'? [-Werror=implicit-function-declaration]

Fix this error

>     1418 |         l2cap_sock_cleanup_listen(sk);
>          |         ^~~~~~~~~~~~~~~~~~~~~~~~~
>          |         l2cap_sock_listen
>    net/bluetooth/l2cap_sock.c: At top level:
> >> net/bluetooth/l2cap_sock.c:1436:13: warning: conflicting types for 'l2cap_sock_cleanup_listen'; have 'void(struct sock *)'
>     1436 | static void l2cap_sock_cleanup_listen(struct sock *parent)
>          |             ^~~~~~~~~~~~~~~~~~~~~~~~~
> >> net/bluetooth/l2cap_sock.c:1436:13: error: static declaration of 'l2cap_sock_cleanup_listen' follows non-static declaration
>    net/bluetooth/l2cap_sock.c:1418:9: note: previous implicit declaration of 'l2cap_sock_cleanup_listen' with type 'void(struct sock *)'
>     1418 |         l2cap_sock_cleanup_listen(sk);
>          |         ^~~~~~~~~~~~~~~~~~~~~~~~~
>    cc1: some warnings being treated as errors

Signed-off-by: Sungwoo Kim <iam@sung-woo.kim>
---
 net/bluetooth/l2cap_sock.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index eebe25610..3818e11a8 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -46,6 +46,7 @@ static const struct proto_ops l2cap_sock_ops;
 static void l2cap_sock_init(struct sock *sk, struct sock *parent);
 static struct sock *l2cap_sock_alloc(struct net *net, struct socket *sock,
 				     int proto, gfp_t prio, int kern);
+static void l2cap_sock_cleanup_listen(struct sock *parent);
 
 bool l2cap_is_socket(struct socket *sock)
 {
@@ -1414,7 +1415,8 @@ static int l2cap_sock_release(struct socket *sock)
 
 	if (!sk)
 		return 0;
-
+		
+	l2cap_sock_cleanup_listen(sk);
 	bt_sock_unlink(&l2cap_sk_list, sk);
 
 	err = l2cap_sock_shutdown(sock, SHUT_RDWR);
-- 
2.34.1

