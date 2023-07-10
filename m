Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6970874CFE1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 10:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbjGJIZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 04:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbjGJIZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 04:25:33 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FC84E5;
        Mon, 10 Jul 2023 01:25:29 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-262e839647eso3228431a91.2;
        Mon, 10 Jul 2023 01:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688977529; x=1691569529;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=euAD73FxrqgX4gYf9cb8DIHf1pvqA0RRBkCOGjGePjQ=;
        b=Vvxqw74ZcgEcC16phKaNK/uLFlHjNdq2y9f7JLmGab9CnmUhfpookk5dHI0pE0bIxO
         LRjZVinIwcdgNCL3Eg5KFMQQeBlHXAcxgI7wDfU+xIzFDTrWosJguAD2K1i/sXOQGhMI
         kqE6Mk108f4C+yiNBLK+riGUZnbmcDQVZvEFqyTw1J6s0udPI/tMD7z9fGo7apbKnER8
         EyImHSwQJPPW4+kQ7iNmOi3BIfzj5fHj9B+jVFjrA5gw/7YlrKsr3Rb1tKI724ELnr4n
         tqN3QtjuxYDcBKXk8wKq7F/bX9+Wve62viQ/T1RLig49WWhzwRtbszEcju/lV+llsqAg
         adKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688977529; x=1691569529;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=euAD73FxrqgX4gYf9cb8DIHf1pvqA0RRBkCOGjGePjQ=;
        b=gEjxIdKsLKvTDBP8kXSkhY3TffBfMJXwJWgnxzTfq5PnKP32M3Er5ARWK0M4zLb03t
         W3Tw4eH/jrcpGVZ9gvr4hDM680re0DfIELgWY6f+NjcGx98EzLqMnjdPdqmhFJnIVctP
         Csp6peFu9K1WVL6ulP90BXc3G5GOFyXAEmT16B9FgLhvlc2hZCvVzwfxBqdIj8ssYcFO
         rr4o1kj5/S2jBrINEIVMK/Eh92WKKTd93ohZEp/lOs7Nq5i9QJJID+i5/5zV/uGtKBDA
         iPKJ0IWMjTbeRbgsAwKqWV53PwsBKcxPnu9Ns1AMFbdIil7V+kAhg7djV+Fq4DYwsNYx
         LMWA==
X-Gm-Message-State: ABy/qLa5+PdueXnf+VbpCQ+9mkvbaP2Vsb5Re1kkGJRTffptGsdJMmyj
        QH540kuHMSo4VpzmCqw9BRqkAK5gKh07wPuSc4c=
X-Google-Smtp-Source: APBJJlHRvaqlWVjz/Y1IZSUcs+XH5s6zsw1pngI0Hmn9h0OcD2FE53c9uFMHy8Jqx2frb22rfUBEOw==
X-Received: by 2002:a17:90a:1f8f:b0:262:f8b8:dba2 with SMTP id x15-20020a17090a1f8f00b00262f8b8dba2mr11733398pja.35.1688977528849;
        Mon, 10 Jul 2023 01:25:28 -0700 (PDT)
Received: from sandbox.. ([115.178.65.130])
        by smtp.googlemail.com with ESMTPSA id l7-20020a17090aaa8700b00264044cca0fsm11081679pjq.1.2023.07.10.01.25.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 01:25:28 -0700 (PDT)
Sender: Leesoo Ahn <yisooan.dev@gmail.com>
From:   Leesoo Ahn <lsahn@ooseel.net>
X-Google-Original-From: Leesoo Ahn <lsahn@wewakecorp.com>
To:     lsahn@wewakecorp.com
Cc:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] selinux: optimize major part with a kernel config in selinux_mmap_addr()
Date:   Mon, 10 Jul 2023 17:25:00 +0900
Message-Id: <20230710082500.1838896-1-lsahn@wewakecorp.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The major part, the conditional branch in selinux_mmap_addr() is always to be
false so long as CONFIG_LSM_MMAP_MIN_ADDR is set to zero at compile time.

This usually happens in some linux distros, for instance Ubuntu, which
the config is set to zero in release version. Therefore it could be a bit
optimized with '#if <expr>' at compile time.

Signed-off-by: Leesoo Ahn <lsahn@wewakecorp.com>
---
 security/selinux/hooks.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index d06e350fedee..a049aab6524b 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3723,11 +3723,13 @@ static int selinux_mmap_addr(unsigned long addr)
 {
 	int rc = 0;
 
+#if CONFIG_LSM_MMAP_MIN_ADDR > 0
 	if (addr < CONFIG_LSM_MMAP_MIN_ADDR) {
 		u32 sid = current_sid();
 		rc = avc_has_perm(sid, sid, SECCLASS_MEMPROTECT,
 				  MEMPROTECT__MMAP_ZERO, NULL);
 	}
+#endif
 
 	return rc;
 }
-- 
2.34.1

