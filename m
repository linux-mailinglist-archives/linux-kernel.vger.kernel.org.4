Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D21B72B17A
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jun 2023 12:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233414AbjFKKyg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 06:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbjFKKyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 06:54:33 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25E9F10A;
        Sun, 11 Jun 2023 03:54:31 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-5149390b20aso5838883a12.3;
        Sun, 11 Jun 2023 03:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1686480869; x=1689072869;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oS+p5K9ZPN0t2dIaNX3pw7GDSatTHt0gmgbi2hdXeic=;
        b=VuZu2nQm1xyCRJsyaNE76XLoEb+0FMA2dFnTMH+wMewpClKYGhLUqZOsEByPbG00pf
         23netPh0fTJT/hg4OY+PgIoE0JHZh+KsVauzuxvBMjMx8w12dz8v1zFIiccM3dprmw5f
         C5izVu6nH7HxwlmcPI5DTvMw8CLwIP/qXdOBAVc/Ob5prHKaDmcYnkCs6zJzDw4ySRaz
         klH2YtGFRPEAjPlCd9yhNxC3SKB//sbxZz9vHLwAu4Tm/Wtl+q5MGddIM7SSCxvFuNq6
         gGS1fgFUdWswRoQut9faNrUrnjdVig2Yn8ENQer9k2PBTgD7i5xCBGf7TMGJULCleYAL
         9Wag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686480869; x=1689072869;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oS+p5K9ZPN0t2dIaNX3pw7GDSatTHt0gmgbi2hdXeic=;
        b=C4Z004DgTvZ4LgtZ9HuzB2uvKE1N6VdJOdZshDDVDG5pxUI0kbeYWKB33iwCVEvqcA
         Fzp/qyglqqV25aESDkKeZG9NMmgIOtAK9pUFzFXETeVGXipVpJTjLE7LgDA2kyl7SvVe
         H5xNLRUpoZnwCOkV518I7uZ3m/cqn2+Hjtpk/CgkGQZ5PT5nHuc54ba0qjwXixVpf7Tq
         mcszloBnUQ8wB//BIjjHEjQDxiYhQYjILhGzRuYoSKpKFFLo87Y9fx2jnV7BuVe7Go51
         yDu7JA0/u20I6jKk8pRsCxgd0StjC5x9uPSTdh5HiJPf/TO1WXUjo19iEwU/VPWpFi6a
         2IQQ==
X-Gm-Message-State: AC+VfDwbKeJgdVPhcPHdhg+LidiC7lHq/+m9SvdeoRseWDDu+eRFZ0ty
        XQPJBd6fpZNOoBFoGk1csV4=
X-Google-Smtp-Source: ACHHUZ6Rpaj4bofgZjbkn++4EsplD+KBgHKEoAj+vFUa042xtPz0Qg+q4mpy7vkE90YaU5vTbI/Tvw==
X-Received: by 2002:a50:ef17:0:b0:516:4394:244f with SMTP id m23-20020a50ef17000000b005164394244fmr2840554eds.12.1686480869372;
        Sun, 11 Jun 2023 03:54:29 -0700 (PDT)
Received: from localhost.localdomain ([2a02:810a:9640:26a8:84b0:69e6:a31a:4535])
        by smtp.gmail.com with ESMTPSA id u13-20020a50eacd000000b005149b6ec1bdsm3795051edp.29.2023.06.11.03.54.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 11 Jun 2023 03:54:28 -0700 (PDT)
From:   Franziska Naepelt <franziska.naepelt@googlemail.com>
X-Google-Original-From: Franziska Naepelt <franziska.naepelt@gmail.com>
To:     franziska.naepelt@googlemail.com
Cc:     davem@davemloft.net, franziska.naepelt@gmail.com,
        herbert@gondor.apana.org.au, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, bagasdotme@gmail.com
Subject: [PATCH v2] crypto: fcrypt: Fix block comment
Date:   Sun, 11 Jun 2023 12:53:31 +0200
Message-Id: <20230611105331.16570-1-franziska.naepelt@gmail.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20230606111042.96855-1-franziska.naepelt@gmail.com>
References: <20230606111042.96855-1-franziska.naepelt@gmail.com>
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

Fix the following checkpatch issue:
- WARNING: Block comments use a trailing */ on a separate line

Signed-off-by: Franziska Naepelt <franziska.naepelt@gmail.com>
---
v2:
 - Revert SPDX change to address only one logical change
---
 crypto/fcrypt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/crypto/fcrypt.c b/crypto/fcrypt.c
index 95a16e88899b..e9e119bab784 100644
--- a/crypto/fcrypt.c
+++ b/crypto/fcrypt.c
@@ -303,7 +303,8 @@ static int fcrypt_setkey(struct crypto_tfm *tfm, const u8 *key, unsigned int key
 
 #if BITS_PER_LONG == 64  /* the 64-bit version can also be used for 32-bit
 			  * kernels - it seems to be faster but the code is
-			  * larger */
+			  * larger
+			  */
 
 	u64 k;	/* k holds all 56 non-parity bits */
 

base-commit: 9561de3a55bed6bdd44a12820ba81ec416e705a7
-- 
2.39.2 (Apple Git-143)

