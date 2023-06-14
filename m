Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3C51730646
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 19:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236151AbjFNRrT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 13:47:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239175AbjFNRq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 13:46:56 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED6141BF0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 10:46:55 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-30fbf253dc7so3018986f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 10:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1686764814; x=1689356814;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FnQy3LIARieYREiW9Ccv3J1qltaXMlHsSeiVItoMb4w=;
        b=LRJDEUf43vD8BUpN2Fp0vlm+aErjd9CjmJlwiQ/YjQy6BKRuPVNQIgSNQi1+YuB+vO
         pgOyDjXLIF6vIpolxt5KmQyvKUenboC+4M2q9t6WWIoImIzBnQ8i7DwLWicSDGP+qOOy
         Fpy8n42VosWUf40ZI/JujL4mhgQTTKdwBl9m0XzkhWLfhZvgD9F/SRMB5yjGADiXhkJM
         uF1BuELXWyUsXeV/FscPUwT5Y4jfiMbLxD5exUVQFnfOj3nut/MMWqWUGXcStxT1OvJo
         BeIe1bbJf8Veu5s77lEciJ1NAMlx+dmRbZArR5Y+GL8ZMLUOlvuT+jACPNznVNIs2EQJ
         AyYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686764814; x=1689356814;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FnQy3LIARieYREiW9Ccv3J1qltaXMlHsSeiVItoMb4w=;
        b=lq4h4hM6arLFQusAMSgcc0UY/O3J8glJgRE/C3tD1q0Wvj17g8crQ32GmY2fNXoCel
         21KT6CJYcUdrFlfOdvFEdp0Op5GDKYGb66W0oR5o/JLf0aIQYRs3HfYlbNgTtP/aaB/P
         oTIPUaGZOPX4e3Sv5IEkUeDqVx0GBxPaOKdgugC+FHTw7gvNK4R0HzpXwFXTNtPWY3K1
         cVouKjRbmsTdftyFvj9OhBJxNn4+MLHlTbIR/HEmecnYSbw9ogWcYcl6mlWrWKHA2quQ
         zqS/1OF5lgdw8d8BvHDHWr20mz+4JgJEhROVumbYfUn7LpZpD11CrzGGy87Oqo5Sa63K
         b4lw==
X-Gm-Message-State: AC+VfDxrOBWNlUdoMTZAVF+ui1IUR6qTnQbtBc83s6IeazyZLYCXZQMi
        Vxo3yhQzPi7R1odt2bwtmM1Jmw==
X-Google-Smtp-Source: ACHHUZ5hDdZj30AnmiktJ9+d4NQK64QDazLJ4dt8FLdh1wyoKyGo22bd6EhVI1V13Jo8Pt88JTpvXQ==
X-Received: by 2002:a5d:440c:0:b0:30f:c56c:b5a8 with SMTP id z12-20020a5d440c000000b0030fc56cb5a8mr2262496wrq.2.1686764814527;
        Wed, 14 Jun 2023 10:46:54 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id m4-20020a056000180400b0030633152664sm18738740wrh.87.2023.06.14.10.46.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 10:46:54 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <dima@arista.com>,
        Bob Gilligan <gilligan@arista.com>,
        David Ahern <dsahern@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Francesco Ruggeri <fruggeri05@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Salam Noureddine <noureddine@arista.com>,
        linux-crypto@vger.kernel.org
Subject: [PATCH-next 3/3] crypto: cipher - On clone do crypto_mod_get()
Date:   Wed, 14 Jun 2023 18:46:43 +0100
Message-Id: <20230614174643.3836590-4-dima@arista.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230614174643.3836590-1-dima@arista.com>
References: <20230614174643.3836590-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The refcounter of underlying algorithm should be incremented, otherwise
it'll be destroyed with the cloned cipher, wrecking the original cipher.

Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 crypto/cipher.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/crypto/cipher.c b/crypto/cipher.c
index 184188339a4a..b53bf3cda826 100644
--- a/crypto/cipher.c
+++ b/crypto/cipher.c
@@ -101,10 +101,15 @@ struct crypto_cipher *crypto_clone_cipher(struct crypto_cipher *cipher)
 	if (alg->cra_init)
 		return ERR_PTR(-ENOSYS);
 
+	if (unlikely(!crypto_mod_get(alg)))
+		return ERR_PTR(-ESTALE);
+
 	ntfm = __crypto_alloc_tfm(alg, CRYPTO_ALG_TYPE_CIPHER,
 				  CRYPTO_ALG_TYPE_MASK, GFP_ATOMIC);
-	if (IS_ERR(ntfm))
+	if (IS_ERR(ntfm)) {
+		crypto_mod_put(alg);
 		return ERR_CAST(ntfm);
+	}
 
 	ntfm->crt_flags = tfm->crt_flags;
 
-- 
2.40.0

