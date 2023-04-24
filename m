Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECF816EC346
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 02:29:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbjDXA3m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 20:29:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbjDXA3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 20:29:40 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1293F10F9;
        Sun, 23 Apr 2023 17:29:40 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1a920d484bdso32648585ad.1;
        Sun, 23 Apr 2023 17:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682296179; x=1684888179;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oeCWAVpzUlJENHWgzzWvjGxllx4bMHHuluovnvNmeI8=;
        b=pOifgzaZkQGFdRfYtPluK6fpoGzUUcKWgl/jLW1k0aoy5da3TAQivph8S09dNSeH/1
         FNFO3GlDeD5fzZevt83hSennlHtl4K+opjmYNhO/uc3Fy7FTwstAdKZFzS7VQM+FVDMg
         yl9kAkFuYayDB1vnd8QXMmNndx7rzd42u/dQp1giaFeAHCGOOHbb+L4y+JFadEfQ1JVg
         G03x9WeITYQYrXmMrlDV42H6aawNl7CBzTRbgdOeUXU6W0cCfF7+UUp1ru2PnvPs3Y7V
         ScS+DZEjI6/5lpGy+UOa3KxfAhdLhz2fwdA3CsC3/UyNWS+c27C/NSAFUECf8GaObtYm
         xswQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682296179; x=1684888179;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oeCWAVpzUlJENHWgzzWvjGxllx4bMHHuluovnvNmeI8=;
        b=G8Vc4xzwUgSyMsSmP6964bH31hE+u6rjDwVF7X1jpw7seIIjfodCeXr5XfjmfwLH8T
         wb9d3ik6eANc9IhUY+U3OCs7MYwHN4pGpcOc5ELpV8w5c0cciLjD+kYs9LQU+WApkaWC
         nicm72rTZKYWYqNuNBHKJfan7sSIQ5HXlVxhrGtyLXbPY2HUAhYtoENWRZhfykdCFArn
         RJGhQu1YqwWQbxqC8kCDzmfx5xY9x+fU3P//t1+48Ia+Cpbz2F+j4R4xOM4SaXNeDj0B
         Bd/wsLo/OyTBiW/9l9D7nabjhvkIHdgjEsKmA+iGucFLhlO4sgt2g5akX40+BRF8X+wF
         n32Q==
X-Gm-Message-State: AAQBX9c0p4d0hSmgfeunTAuE8iL1mxc1HYF47BPYSlYqLOskU0mJZgxe
        DkpgAFn0e9lQdVCFEnWhFPYOdaQBZfsngL4D
X-Google-Smtp-Source: AKy350ZdpKltLt9kzHE3o9pOo2G6n4EUTIdv8tOCpeCWYXPq5ADvPr/6tDjKToTUVvb+w6dV3NYq9A==
X-Received: by 2002:a17:903:228d:b0:1a8:1d1e:407b with SMTP id b13-20020a170903228d00b001a81d1e407bmr15543230plh.64.1682296179029;
        Sun, 23 Apr 2023 17:29:39 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([104.28.213.199])
        by smtp.gmail.com with ESMTPSA id z2-20020a170902708200b001a19196af48sm5499577plk.64.2023.04.23.17.29.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Apr 2023 17:29:38 -0700 (PDT)
From:   David Yang <mmyangfl@gmail.com>
To:     linux-crypto@vger.kernel.org
Cc:     David Yang <mmyangfl@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] crypto: engine - Fix struct crypto_engine_op doc
Date:   Mon, 24 Apr 2023 08:29:24 +0800
Message-Id: <20230424002925.2740296-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.39.2
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

Remove redundant underscore and fix some grammar in prepare_request doc.

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Link: https://lore.kernel.org/r/b58dc77c-c975-46cf-581c-368d9a87ae64@infradead.org
Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 include/crypto/engine.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/crypto/engine.h b/include/crypto/engine.h
index ae133e98d813..2038764b30c2 100644
--- a/include/crypto/engine.h
+++ b/include/crypto/engine.h
@@ -78,7 +78,7 @@ struct crypto_engine {
 
 /*
  * struct crypto_engine_op - crypto hardware engine operations
- * @prepare__request: do some prepare if need before handle the current request
+ * @prepare_request: do some preparation if needed before handling the current request
  * @unprepare_request: undo any work done by prepare_request()
  * @do_one_request: do encryption for current request
  */
-- 
2.39.2

