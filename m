Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 394E3633644
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 08:49:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232590AbiKVHtV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 02:49:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232552AbiKVHtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 02:49:15 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78FE9326E3;
        Mon, 21 Nov 2022 23:49:15 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id q1so13368095pgl.11;
        Mon, 21 Nov 2022 23:49:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MSSoozAZzRH9A1wAx3O1UtGKYxpTu5VxtCoRrtwK2vs=;
        b=B/dBYyTTnKT7UAez0oRgLP+5AYwNFEkcu8aKlEgvqpvRqqb4fueqo2RyXLOpy6ZhCY
         UYdSzoMPTd7EEtiwosfh2XIhTLqQXLyY2rRdbIXYIFHecdA/0rXnFJq9NkM5xiJ2sDGb
         njNRp9Jt4CAUic8/SCiSTsKXCV191YK5Mp1H4od3csFZByMS0OLUU6OJLu5U5A+4HUQN
         ddUFN1yyptOldI5pc88s7DbGRvStFtHKiOH2mK9ZeVu25xruId53Sdipgk43gJeqwjbe
         p2JtNKs5R/pJ3XhrezhQ6TeVffl0OkIs+MyIpl46/DlLD+V7jvqn5KimqkNv55CVbVIi
         E8Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MSSoozAZzRH9A1wAx3O1UtGKYxpTu5VxtCoRrtwK2vs=;
        b=xDYRF1GMxOqbChmn7O4fIyKRBfV36rV0a2UvXS3lh6AtGo/lt72Qh5bZGZtIM7FyE9
         deB25d+ZOZH6fXi6EC+elE+N6cmKYu+kl7+rSClD7FlHZZr8XkzSHHJhJl5dvCvy7AXx
         Cm3+ad77a5JsUePqpxlOCK7gcIKTJ9A4/A6j89NwnNWI+5BO/dlmlRJbZ87EZhI60i09
         LMvAdX+ltqHLcu6GDECh/PGpzDR1v9tr7rgcFWqk5i650+B4TlWwo0DYU/kgPQkniK/i
         HZ0sepgVfMtaXjBpHVIYLtOvLsqkR2E+HzWPpLSzNA8L8obZUxVBoBd0G0SAoeGrz02e
         Jmbw==
X-Gm-Message-State: ANoB5pkRIdLGeQ7apPC7P4XCNJJwxDJ032f/s1lrciipfp/dnsMnuFf0
        89tWiUtK31eqQcv15aEn0A4=
X-Google-Smtp-Source: AA0mqf7yNMD10vwqp/eRaFaidwpSoecHkLL8zdMZ858lpRpHirXrNA19mcKEfOLKeXUrwgGvM6Edzg==
X-Received: by 2002:aa7:9635:0:b0:56b:6936:ddf6 with SMTP id r21-20020aa79635000000b0056b6936ddf6mr2588811pfg.84.1669103354867;
        Mon, 21 Nov 2022 23:49:14 -0800 (PST)
Received: from localhost.localdomain ([43.132.141.3])
        by smtp.gmail.com with ESMTPSA id mv13-20020a17090b198d00b0021896fa945asm5951141pjb.15.2022.11.21.23.49.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 23:49:14 -0800 (PST)
From:   zys.zljxml@gmail.com
To:     bbrezillon@kernel.org, arno@natisbad.org, schalla@marvell.com,
        herbert@gondor.apana.org.au, davem@davemloft.net
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yushan Zhou <katrinzhou@tencent.com>
Subject: [PATCH] crypto: marvell/octeontx - remove redundant NULL check
Date:   Tue, 22 Nov 2022 15:49:00 +0800
Message-Id: <20221122074900.3660531-1-zys.zljxml@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yushan Zhou <katrinzhou@tencent.com>

release_firmware() checks whether firmware pointer is NULL. Remove the redundant NULL check in release_tar_archive().

Signed-off-by: Yushan Zhou <katrinzhou@tencent.com>
---
 drivers/crypto/marvell/octeontx/otx_cptpf_ucode.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/crypto/marvell/octeontx/otx_cptpf_ucode.c b/drivers/crypto/marvell/octeontx/otx_cptpf_ucode.c
index df9c2b8747e6..c4250e5fcf8f 100644
--- a/drivers/crypto/marvell/octeontx/otx_cptpf_ucode.c
+++ b/drivers/crypto/marvell/octeontx/otx_cptpf_ucode.c
@@ -345,8 +345,7 @@ static void release_tar_archive(struct tar_arch_info_t *tar_arch)
 		kfree(curr);
 	}
 
-	if (tar_arch->fw)
-		release_firmware(tar_arch->fw);
+	release_firmware(tar_arch->fw);
 	kfree(tar_arch);
 }
 
-- 
2.27.0

