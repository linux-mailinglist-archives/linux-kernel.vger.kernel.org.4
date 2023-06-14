Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54DE6730647
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 19:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231613AbjFNRrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 13:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237525AbjFNRqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 13:46:54 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E5751FC4
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 10:46:53 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-30fceb009faso1580631f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 10:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1686764812; x=1689356812;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jpKktw2GOMmJzC6I0CuPo4dMIuJ2XtzOWEy+kYSxtr4=;
        b=Dyad7FZhMwfiAfRmBkixVnagPSVRz8eheSxTFkov/8nLIhmyyvSvWPizdtZw2nA6Zc
         7tpNRwPGmkfEvVsbvUwBdcmN+zSoRgfuxQ58Td9Agwejb2VIMPYeZhtQXmUERcUMJ1Jt
         yhF4MIPwGbij+iXf0/vYCmc33Kqiao8OKcfmFjWIBLixqdHLN4NZaPv45x4EQlbqzeck
         1LsiN5o8hMlVAk6WHV8GKI+JFZT/P+37GsAWAt3BBs9z94mX6BDO1bPQOi1oE88jhJoD
         9th/ZbrjOEsiIPXnJ1MrZQ/P8zsx6FUlFzHduq0Xlh+rfpVcP2kQjVAiOk3QNzOOlhWJ
         l7pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686764812; x=1689356812;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jpKktw2GOMmJzC6I0CuPo4dMIuJ2XtzOWEy+kYSxtr4=;
        b=DMsBpYByCv3H+TJFqVbAOi5OjCGsLw5aCoIhjK7cspJmqU0d7tjPmn5Mzl2YLOul+U
         7oEoDo6sHQYAQs5a07ZzWwR2B3evTB1DHYNdHtBMdwf+xkCeARzrI5LJ3D8K90tnEsJ6
         KQoB5cyejywIO7my+TPN3iWVAHsnaHBsQ3+/ku2+DZeR/UaSYXz+sWwSpzZlRZniOL0o
         CWVbU18qK4FS3BpKPEMN0K/lm4McjEuBOIcl19bjq3RSETVTbxsIkIlnu5lSihxujw7F
         HA9H2FVlF6oNhbO/fxPcN7D90FSPhYteC97e+r7eeqSBLJViCFHLuCNoReGThY0A8gFq
         nmaw==
X-Gm-Message-State: AC+VfDzulHeyNGil/u6F/ieGBFb1qCWvuLI9Io6bzLfL9JM7GLKFEndy
        teSEtSM4ZwWhW+HZJgiehXa2eg==
X-Google-Smtp-Source: ACHHUZ4tY7VFK/WQ07OvcIDpYAn/ug8h5uEtmcneDLElzLV6ReMtEengirK7m3oS4agXI0TCC3AT0Q==
X-Received: by 2002:a5d:4846:0:b0:30f:bde3:aa6 with SMTP id n6-20020a5d4846000000b0030fbde30aa6mr1889121wrs.15.1686764812023;
        Wed, 14 Jun 2023 10:46:52 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id m4-20020a056000180400b0030633152664sm18738740wrh.87.2023.06.14.10.46.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 10:46:51 -0700 (PDT)
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
Subject: [PATCH-next 1/3] crypto: api - Remove crypto_init_ops()
Date:   Wed, 14 Jun 2023 18:46:41 +0100
Message-Id: <20230614174643.3836590-2-dima@arista.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230614174643.3836590-1-dima@arista.com>
References: <20230614174643.3836590-1-dima@arista.com>
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

Purge crypto_type::init() as well.
The last user seems to be gone with commit d63007eb954e ("crypto:
ablkcipher - remove deprecated and unused ablkcipher support").

Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 crypto/api.c            | 14 --------------
 include/crypto/algapi.h |  1 -
 2 files changed, 15 deletions(-)

diff --git a/crypto/api.c b/crypto/api.c
index d375e8cd770d..a94bd0695719 100644
--- a/crypto/api.c
+++ b/crypto/api.c
@@ -345,15 +345,6 @@ struct crypto_alg *crypto_alg_mod_lookup(const char *name, u32 type, u32 mask)
 }
 EXPORT_SYMBOL_GPL(crypto_alg_mod_lookup);
 
-static int crypto_init_ops(struct crypto_tfm *tfm, u32 type, u32 mask)
-{
-	const struct crypto_type *type_obj = tfm->__crt_alg->cra_type;
-
-	if (type_obj)
-		return type_obj->init(tfm, type, mask);
-	return 0;
-}
-
 static void crypto_exit_ops(struct crypto_tfm *tfm)
 {
 	const struct crypto_type *type = tfm->__crt_alg->cra_type;
@@ -410,10 +401,6 @@ struct crypto_tfm *__crypto_alloc_tfm(struct crypto_alg *alg, u32 type,
 	tfm->__crt_alg = alg;
 	refcount_set(&tfm->refcnt, 1);
 
-	err = crypto_init_ops(tfm, type, mask);
-	if (err)
-		goto out_free_tfm;
-
 	if (!tfm->exit && alg->cra_init && (err = alg->cra_init(tfm)))
 		goto cra_init_failed;
 
@@ -421,7 +408,6 @@ struct crypto_tfm *__crypto_alloc_tfm(struct crypto_alg *alg, u32 type,
 
 cra_init_failed:
 	crypto_exit_ops(tfm);
-out_free_tfm:
 	if (err == -EAGAIN)
 		crypto_shoot_alg(alg);
 	kfree(tfm);
diff --git a/include/crypto/algapi.h b/include/crypto/algapi.h
index 016d5a302b84..6156161b181f 100644
--- a/include/crypto/algapi.h
+++ b/include/crypto/algapi.h
@@ -56,7 +56,6 @@ struct sk_buff;
 struct crypto_type {
 	unsigned int (*ctxsize)(struct crypto_alg *alg, u32 type, u32 mask);
 	unsigned int (*extsize)(struct crypto_alg *alg);
-	int (*init)(struct crypto_tfm *tfm, u32 type, u32 mask);
 	int (*init_tfm)(struct crypto_tfm *tfm);
 	void (*show)(struct seq_file *m, struct crypto_alg *alg);
 	int (*report)(struct sk_buff *skb, struct crypto_alg *alg);
-- 
2.40.0

