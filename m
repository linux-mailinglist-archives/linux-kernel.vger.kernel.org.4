Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A084A65227F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 15:26:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233949AbiLTO0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 09:26:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233900AbiLTO0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 09:26:24 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E42912DCE
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 06:26:21 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id gv5-20020a17090b11c500b00223f01c73c3so1026631pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 06:26:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HfWc+IW6nWXzRkOrGK/ueRRgIPCILPfnnkeIVCLq74U=;
        b=TeiDgLuoaSaSiPApyjb1Fhhm8t8VMCYNyiEN2ze8FJFk51Mtz/3aIwxLVxe36XME88
         9/VdFQRiAhx7U3kvtv9zhNzvh1ZgS2aVflH9tgYbbX6yu9mg5ncoIieDsyKcUO0ChG94
         YnpzKSksKjSCgfWOlsN3dP3ICB/Ju6jFGVF8+G2+EIpVEuPoyccstZnwmxS0x9I1QNPW
         sr3jMBSkUEWlzMGmWg/vCqaCKPyevnVxGOod6RSHQUg4t+eAOlzEmBXudIE5LHBIZqJZ
         AEJ0jGQKJWUuTLYCl95DGIV0oExq+QIiXNkHKPVto+PV3gtyX+zdtCSi97svN8f/Skmw
         J5Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HfWc+IW6nWXzRkOrGK/ueRRgIPCILPfnnkeIVCLq74U=;
        b=T89Q0uZF8voyhXMnBnLRvgkph/CkVXsatZKMd3wygdB/17jN1PcfwJa7fhosKkWVTP
         in1Qr4D5U0qxt/iQ42uZsjg2020Ex9pWGt7NkDNT5mfwzCLoNEcQT9hbih4FAKY2tN7k
         0XTKjn/Lv7QuAG8S53SOD9XeOx4ZAVDr0o/hv+92dYrvSkmTf9KE7ysWsyFcVQlORdKl
         8hkqpKl7N5wBUc9m2r2xuTsuEGMCfWKam2tY+IQp2Uxi5RCIrU2C2tvJ1vM0hdLcaSHn
         0dwk9Ax99ICAjnP5BLbqYjQGYYmbLKgG97E2v0ZPvcUf2KOSvlz5pNIvH51Kyou+wySB
         mbjw==
X-Gm-Message-State: ANoB5pkjzQYp5Ot5h/3eFd3MGyogeMUdwYOB4CpkHP1xplkV31JdbeJR
        /Z5JHwwCNHH8LcXdftjhgQY=
X-Google-Smtp-Source: AA0mqf4Jzoj3nYSEHFPpblQQJKZafsl2JD5FJFN8mWm1RMCGOXRAgrRwgUPRpJ5e+ZAnh8d8mn6GqQ==
X-Received: by 2002:a17:902:ce10:b0:189:e577:c842 with SMTP id k16-20020a170902ce1000b00189e577c842mr50431735plg.45.1671546381492;
        Tue, 20 Dec 2022 06:26:21 -0800 (PST)
Received: from vernon-pc.. ([114.231.52.81])
        by smtp.gmail.com with ESMTPSA id ik11-20020a170902ab0b00b001897bfc9800sm9383398plb.53.2022.12.20.06.26.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 06:26:21 -0800 (PST)
From:   Vernon Yang <vernon2gm@gmail.com>
To:     Liam.Howlett@oracle.com, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Vernon Yang <vernon2gm@gmail.com>
Subject: [PATCH 2/8] maple_tree: remove extra return statement
Date:   Tue, 20 Dec 2022 22:26:00 +0800
Message-Id: <20221220142606.1698836-3-vernon2gm@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221220142606.1698836-2-vernon2gm@gmail.com>
References: <20221220142606.1698836-2-vernon2gm@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For functions with a return type of void, it is unnecessary to
add a reurn statement at the end of the function, so drop it.

Signed-off-by: Vernon Yang <vernon2gm@gmail.com>
---
 lib/maple_tree.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 8ace65a5eea5..34aa93c85d6e 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -1276,7 +1276,6 @@ static inline void mas_alloc_nodes(struct ma_state *mas, gfp_t gfp)
 	if (mas->alloc && !(((unsigned long)mas->alloc & 0x1)))
 		mas->alloc->total = success;
 	mas_set_err(mas, -ENOMEM);
-	return;
 }
 
 /*
@@ -4710,8 +4709,6 @@ static inline void mas_rewalk(struct ma_state *mas, unsigned long index)
 	mas_state_walk(mas);
 	if (mas_is_start(mas))
 		goto retry;
-
-	return;
 }
 
 /*
-- 
2.34.1

