Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CBFF65F4F2
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 21:06:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235469AbjAEUGp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 15:06:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235300AbjAEUGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 15:06:38 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A7A13C3B5
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 12:06:38 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id 18so13966702pfx.7
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 12:06:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R1UmV/Y1385rf9LJ5udvE9w+XYrMR94cuZsoW7lCQrQ=;
        b=fKnSudAHcIWFJe3xx/NOIvyYXIvou/ivwLqtHwmnbQGBpeqGsYuWSqKr2GKRJnRQgj
         P0GyOgQ0qtuUiVACISmqImpVS9wHPOdnjhvv1UWlrdlczyxbSIOIUlc+lD+HilYcfBHH
         Aw8lCxOhIYIIc/9NQY5qH+jWvH3chsTopNHwS4TrUuC79uaFaZC5JXFMuFf1AR19Z7ND
         f/5+gT+EIdDvWIBhm3oOa8fy/DeCICx59NSjfq9Q3h1LE1DtX/FcloAtrwABoBdcfw++
         dGB66CiPIlvBETOo/aOjnBivISZmShBvPDv+OwN96u9WpOmIisxZ2Iphks6x93XCHiE7
         XuIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R1UmV/Y1385rf9LJ5udvE9w+XYrMR94cuZsoW7lCQrQ=;
        b=L6Sdw7H1LVG0v5UjHfTHx3xJVYL58py1/7WE27A560AWkXSe8/Zps9WQoCEYW8GfiH
         IOrgF/VD8c+D5wz9sKWjL2TB1eT9EqVRc3Cj963IbmoYm/WVhzLCi64QPOFz7P7iXu9h
         S8ey0srCOvGLRt1IHWEc1aw4R0heOX8nfyroU18Dm4dwTM20vXaRRAmwiOG2v1q5MRMs
         G4CSkpaUszudkwcewkaLUqGFcH1xLyFPEc0qoil7euwCda5Gay+sxQHSz83Gr+il+rg1
         la6D89RBqC8gpQ06GRQKtBL97iUY03ye5adYM4D0pbdeV2xWK1wJSVwusZGQrqJ5C/6e
         8UtA==
X-Gm-Message-State: AFqh2kocbOVnbTs5dCmqKQi9DhQzqvo1q5fLPS6RamYj6+YzpzrDUNHl
        v3Lu/+ptuKwqWgpQXdZaFeXUFXJ/LCndbQ==
X-Google-Smtp-Source: AMrXdXtpls15inLvXB/UT52dck/wR0L+SCHNnj2mGr7hyh/TI5LFLmOklE0QqhLpyh50lvMaV0H9Aw==
X-Received: by 2002:aa7:8f30:0:b0:580:9131:7dbb with SMTP id y16-20020aa78f30000000b0058091317dbbmr54484271pfr.26.1672949197395;
        Thu, 05 Jan 2023 12:06:37 -0800 (PST)
Received: from localhost.localdomain ([223.79.193.10])
        by smtp.gmail.com with ESMTPSA id s5-20020aa78bc5000000b00581e0b5ad8dsm13442024pfd.107.2023.01.05.12.06.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 12:06:36 -0800 (PST)
From:   John Sanpe <sanpeqf@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     John Sanpe <sanpeqf@gmail.com>
Subject: [PATCH] lib/ts_kmp: Remove duplicate logic to improve performance
Date:   Fri,  6 Jan 2023 04:06:03 +0800
Message-Id: <20230105200603.51113-1-sanpeqf@gmail.com>
X-Mailer: git-send-email 2.39.0
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

Replace the kmp_init processing sequence, first perform case
conversion and then perform compute_prefix_tbl, this can
reduce a meaningless conversions.

Signed-off-by: John Sanpe <sanpeqf@gmail.com>
---
 lib/ts_kmp.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/lib/ts_kmp.c b/lib/ts_kmp.c
index c77a3d537f24..9f83f9ee352c 100644
--- a/lib/ts_kmp.c
+++ b/lib/ts_kmp.c
@@ -72,17 +72,14 @@ static unsigned int kmp_find(struct ts_config *conf, struct ts_state *state)
 }
 
 static inline void compute_prefix_tbl(const u8 *pattern, unsigned int len,
-				      unsigned int *prefix_tbl, int flags)
+				      unsigned int *prefix_tbl)
 {
 	unsigned int k, q;
-	const u8 icase = flags & TS_IGNORECASE;
 
 	for (k = 0, q = 1; q < len; q++) {
-		while (k > 0 && (icase ? toupper(pattern[k]) : pattern[k])
-		    != (icase ? toupper(pattern[q]) : pattern[q]))
+		while (k > 0 && pattern[k] != pattern[q])
 			k = prefix_tbl[k-1];
-		if ((icase ? toupper(pattern[k]) : pattern[k])
-		    == (icase ? toupper(pattern[q]) : pattern[q]))
+		if (pattern[k] == pattern[q])
 			k++;
 		prefix_tbl[q] = k;
 	}
@@ -104,13 +101,13 @@ static struct ts_config *kmp_init(const void *pattern, unsigned int len,
 	conf->flags = flags;
 	kmp = ts_config_priv(conf);
 	kmp->pattern_len = len;
-	compute_prefix_tbl(pattern, len, kmp->prefix_tbl, flags);
 	kmp->pattern = (u8 *) kmp->prefix_tbl + prefix_tbl_len;
 	if (flags & TS_IGNORECASE)
 		for (i = 0; i < len; i++)
 			kmp->pattern[i] = toupper(((u8 *)pattern)[i]);
 	else
 		memcpy(kmp->pattern, pattern, len);
+	compute_prefix_tbl(kmp->pattern, len, kmp->prefix_tbl);
 
 	return conf;
 }
-- 
2.38.1

