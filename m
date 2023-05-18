Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DB5A7078D7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 06:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbjEREP3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 00:15:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbjEREPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 00:15:25 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D51CC35B6;
        Wed, 17 May 2023 21:15:23 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id ca18e2360f4ac-76c5c806fc5so40733839f.1;
        Wed, 17 May 2023 21:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684383323; x=1686975323;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=spLvCUUdmWNpc0v6hAWkoP4Hs9NQAnjDoSHRo34PPBc=;
        b=M+fgGI1KsN4uxP7OFN5eldgj9qwPE5yLctGM212bnqZJ66tHDWbnX0VABmANJefd7r
         jWXEPdNsBtufCxE7OGcj7xNl+cG3qvHM1E5dVYx+jiX0Fgsp8npUOd0YXNeE2cLm4XG2
         XglIIIA8l7GJuIrrU3pAsQVl9CAJxSrVlogZSQxABj39yx3syuUPlw+Q6A3TomcU1Bzc
         o24ZOhvNIIEp+oZ/qqK1SKcy6Ip+BTgN55FXWXOrPIOUK0M4T8WF2UxsCHaq5Ns/+DST
         EOsVNb1kuq4FFmj+JWhXZILXkLcyFHhPJuyRldk9yEPMWd9gM4szHuxWuddeXhStcjDO
         /CPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684383323; x=1686975323;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=spLvCUUdmWNpc0v6hAWkoP4Hs9NQAnjDoSHRo34PPBc=;
        b=leTxfcdL0RWxxgaqSb9OaD5AIEPKxmISfFUSTv1cOiIYb2MroDEQSP+k1NHb3ORPpl
         KjeLYh/NI17Ff5/FbhGRXlxRW98/JHd1pSYcZ1kSOivOKScWKMku86XKL/21WWBTWEvc
         I7b6V04++kuKB3q0h8R6oHBga2mZUwGltPgSDPYCUNJc3vLln5YRZQ4wPYvlQYjDB41u
         snSZtUsVJrxb0bDAMhJDTZE2IpNrlmZsAnCaqblPs2r+tbAkGPR4IGgxyj61uwnjAGWL
         dnGw/feOQqGns08fceObK94cf5q0iAJZf4NFUL4UNoCInvooG2JM+CeFfuRfM/DrmHpj
         3JeA==
X-Gm-Message-State: AC+VfDxrVQxRuULO7AyyP7km+mRHlGwF9WBztZX445upsknqoUTmJyrz
        P5SnNt805jlCUI3OXABGI8M2Hl3+sFsywQ==
X-Google-Smtp-Source: ACHHUZ683AatBk2T4OWvGqlk312/OLg7GFAvJQQB5cy7mmf4aNJgDdnr+/se0OezGfs/M1idcGe3Fg==
X-Received: by 2002:a05:6602:cb:b0:760:b591:e651 with SMTP id z11-20020a05660200cb00b00760b591e651mr5738160ioe.13.1684383322979;
        Wed, 17 May 2023 21:15:22 -0700 (PDT)
Received: from azeems-kspp.c.googlers.com.com (54.70.188.35.bc.googleusercontent.com. [35.188.70.54])
        by smtp.gmail.com with ESMTPSA id o9-20020a5eda49000000b0076350d7c4b6sm158948iop.36.2023.05.17.21.15.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 21:15:22 -0700 (PDT)
From:   Azeem Shaikh <azeemshaikh38@gmail.com>
To:     David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>
Cc:     linux-hardening@vger.kernel.org,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org
Subject: [PATCH] KEYS: Replace all non-returning strlcpy with strscpy
Date:   Thu, 18 May 2023 04:15:13 +0000
Message-ID: <20230518041513.1669386-1-azeemshaikh38@gmail.com>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

strlcpy() reads the entire source buffer first.
This read may exceed the destination size limit.
This is both inefficient and can lead to linear read
overflows if a source string is not NUL-terminated [1].
In an effort to remove strlcpy() completely [2], replace
strlcpy() here with strscpy().
No return values were used, so direct replacement is safe.

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
[2] https://github.com/KSPP/linux/issues/89

Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
---
 security/keys/request_key_auth.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/keys/request_key_auth.c b/security/keys/request_key_auth.c
index 41e9735006d0..8f33cd170e42 100644
--- a/security/keys/request_key_auth.c
+++ b/security/keys/request_key_auth.c
@@ -178,7 +178,7 @@ struct key *request_key_auth_new(struct key *target, const char *op,
 	if (!rka->callout_info)
 		goto error_free_rka;
 	rka->callout_len = callout_len;
-	strlcpy(rka->op, op, sizeof(rka->op));
+	strscpy(rka->op, op, sizeof(rka->op));
 
 	/* see if the calling process is already servicing the key request of
 	 * another process */

