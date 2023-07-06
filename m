Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6372D749D85
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 15:24:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232404AbjGFNYu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 09:24:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232066AbjGFNYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 09:24:25 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11D301996;
        Thu,  6 Jul 2023 06:24:03 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-991ef0b464cso360890266b.0;
        Thu, 06 Jul 2023 06:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1688649842; x=1691241842;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+OeRMJNgQLsyF5aimQ/whtrHbhuHPfZmQfqR8CylHYA=;
        b=hFBEQezXTbHbSD+BN5ywIiq8h4XUw3ruQvxqxfvg6CreyrFM9hC/RYycBwHgQDegmh
         Ux4JImroUl+lxsB5pQFJ4xmBc7XRQjicyTAoDfSPC+MQc6+tdDUtLdpmKKk6OURtSxLp
         vkJqThRHzNcvdSw671k8xDg/6BKCEhyLj4P/0+63n+RHvH3SqvWsMk9aR7gxSzkQQuIz
         DqiezFA2r7xayiU0nql8Fni+Bt/1uXLHdcMWzazTsK9vojpa7Mq29ctoIfaJAJESCycb
         9sRAUtMTQ2PJDv/tkygfdvlhkM9IgVB7StGDxrDFSAUiEd3IBhzVKM5hwW9GFc2Z8uVc
         MGeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688649842; x=1691241842;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+OeRMJNgQLsyF5aimQ/whtrHbhuHPfZmQfqR8CylHYA=;
        b=In7aU2o3r/u3EpZ0tobJ8w790Pseouk3d8GN/aMgco+16pnb+/6aFNrWWJ7xg7wT0R
         amBrDCi6Dlq9kHrW7dY72JzrQBEUtbam0gM8fYGD/ay60QgF8DYQ/cbC5tDVCjut/TVA
         2QMpOrb5LOqXguyDJwyPfnF7VofHaOkEnJC9pxALn7VawWtK7fbgF/lSWEnyibhOjvl+
         tEY28AbXAVJZBklbBbcIrZE+E+1OE9NWD9Pior66MPp4+EGzRaJV5EUeuuZWVC5/cgJK
         jM87Sbonb6i+B3uSVcIuQa7VcJMTO1nwxxJRm3QECN5c8V4VHDefKH7NplO2ukZNFrY0
         7Y+Q==
X-Gm-Message-State: ABy/qLZf3u1Yp1oF2ybmVVelQ2GEDUkhzwP4lMZqoK2+R+DsqQKMENZs
        Nq4VYHb2+AjsRUYnEi63Hfd0cE2EANlMJ2P/
X-Google-Smtp-Source: APBJJlEH7MLcr9wupFkHo2GwM7QB2cL22YDjFv3yD1HXDKEevol4qEEv8Ekf8Yj6z9B2lhHP/TfFvw==
X-Received: by 2002:a17:906:29c:b0:977:d660:c5aa with SMTP id 28-20020a170906029c00b00977d660c5aamr2193565ejf.31.1688649842213;
        Thu, 06 Jul 2023 06:24:02 -0700 (PDT)
Received: from debian_development.DebianHome (dynamic-077-008-088-179.77.8.pool.telefonica.de. [77.8.88.179])
        by smtp.gmail.com with ESMTPSA id r2-20020a170906364200b00988dbbd1f7esm808024ejb.213.2023.07.06.06.24.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 06:24:01 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Cc:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 18/20] selinux: nlmsgtab: implicit conversion
Date:   Thu,  6 Jul 2023 15:23:33 +0200
Message-Id: <20230706132337.15924-18-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230706132337.15924-1-cgzones@googlemail.com>
References: <20230706132337.15924-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Use an unsigned type as loop iterator.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 security/selinux/nlmsgtab.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/selinux/nlmsgtab.c b/security/selinux/nlmsgtab.c
index 2ee7b4ed43ef..b36623d5cf11 100644
--- a/security/selinux/nlmsgtab.c
+++ b/security/selinux/nlmsgtab.c
@@ -153,9 +153,9 @@ static const struct nlmsg_perm nlmsg_audit_perms[] = {
 
 static int nlmsg_perm(u16 nlmsg_type, u32 *perm, const struct nlmsg_perm *tab, size_t tabsize)
 {
-	int i, err = -EINVAL;
+	int err = -EINVAL;
 
-	for (i = 0; i < tabsize/sizeof(struct nlmsg_perm); i++)
+	for (u32 i = 0; i < tabsize/sizeof(struct nlmsg_perm); i++)
 		if (nlmsg_type == tab[i].nlmsg_type) {
 			*perm = tab[i].perm;
 			err = 0;
-- 
2.40.1

