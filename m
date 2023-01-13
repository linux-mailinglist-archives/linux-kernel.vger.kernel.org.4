Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E1DE66A0F1
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 18:45:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbjAMRpE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 12:45:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbjAMRoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 12:44:37 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F059801E9
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 09:31:55 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id dw9so21660535pjb.5
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 09:31:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:message-id:date
         :subject:from:to:cc:subject:date:message-id:reply-to;
        bh=0Ajo4CWXsqrUX3ohXlBgBJ+26DhK51lKwOhdTubtp1w=;
        b=Y1oOYqzI0RHDiNGu/mAaa4CrQgYa0yjxlmFCX7cKtOZFCdtQXEHoUM39Pt8wsk4NOT
         tZWt8fmmpjLzGI5OGAhKKwByKjmS/aEplehloP/sREnFbbWDTkd4da5fc3OfELLfunN3
         Nzvt2QYmMpcds5Wt7ZBK7k0vPoTYQ/2u8mgCQFn+7iw/OB8/9XXKgZOhFaWTDuxkiOK0
         59GIxncoACFjSq4biZhJNNG8QHYhTPttvOeI0bYOn1TQ/yjdq0hEOWYXOgAM3sGx9QHR
         AcKFmnKDpQGDtrLkE7aKStuMwf/VqvTRgkoLz1oQJ0bgPFh2N9Zpx/7uacJYInhHEY3z
         H7fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:message-id:date
         :subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0Ajo4CWXsqrUX3ohXlBgBJ+26DhK51lKwOhdTubtp1w=;
        b=6cZRd0SNgKM/NtmbFGZstrsNLHFRHJwYsk1KGtOrdx9cwjcvfGPu4rQpaI7TTsFNz0
         ZluPhLKW25OKBD4AlX0xMYdUCPC7g6kO5NImcjLFDwAoG3apU/2Fk8Rm7Qc4IlKA+5qR
         ZriECUOizvWraR90mUyFfEY8Zk3KOmdVW/f02MPvTih4sD3rQ8ZQVU+FEltVcvqz+RC5
         jBIAVjUufqnF0fi0RqD3A9TXEGl0tyVKe7JfPDaDjaIysCNbClsNqEC7y6zXrrOppGtv
         OTg+9A4X2/STS9BqCwYLzuFN8gzwDTZW5x57FRpsrEkiXOzapoMComj+S2BjdiwIxRqm
         +Iaw==
X-Gm-Message-State: AFqh2kortgphGu2oKAOxsBSaCsvkeaZJxJxatwLsjaqr2oy177p48SOw
        z9r0mbaOEi/YVFMDbMHRDXQ/yPfdaFPiFTvp
X-Google-Smtp-Source: AMrXdXtq0KqJCC/8WUZ4V8rO6nzK5QxkOTH+IcmgHZYLtCiymWG6fGBh5hTBAc4cR0Bq5k5ctok6RA==
X-Received: by 2002:a17:902:ebca:b0:191:117a:414f with SMTP id p10-20020a170902ebca00b00191117a414fmr94043643plg.27.1673631115023;
        Fri, 13 Jan 2023 09:31:55 -0800 (PST)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id d17-20020a170902ced100b00168dadc7354sm14466494plg.78.2023.01.13.09.31.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 09:31:54 -0800 (PST)
Subject: [PATCH] gcc-plugins: Fix build for upcoming GCC release
Date:   Fri, 13 Jan 2023 09:30:33 -0800
Message-Id: <20230113173033.4380-1-palmer@rivosinc.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux@rivosinc.com, Palmer Dabbelt <palmer@rivosinc.com>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     keescook@chromium.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Palmer Dabbelt <palmer@rivosinc.com>

The upcoming GCC release has refactored the gimple plugin interface a
bit and unless gimple-iterator.h is included before gimple-fold.h I end
up with a bunch of missing declarations when building the stack
protector plugin.

Link: https://inbox.sourceware.org/gcc-patches/CAFiYyc2q%2Bc-0uZb-zAskmR_U%2BM%2BxQfp-W00ZbLErfjx=j5qHGg@mail.gmail.com/
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
 scripts/gcc-plugins/gcc-common.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/gcc-plugins/gcc-common.h b/scripts/gcc-plugins/gcc-common.h
index 9a1895747b15..2c3a3079128a 100644
--- a/scripts/gcc-plugins/gcc-common.h
+++ b/scripts/gcc-plugins/gcc-common.h
@@ -72,6 +72,7 @@
 #include "stor-layout.h"
 #include "internal-fn.h"
 #include "gimple-expr.h"
+#include "gimple-iterator.h"
 #include "gimple-fold.h"
 #include "context.h"
 #include "tree-ssa-alias.h"
@@ -88,7 +89,6 @@
 #include "gimple.h"
 #include "tree-phinodes.h"
 #include "tree-cfg.h"
-#include "gimple-iterator.h"
 #include "gimple-ssa.h"
 #include "ssa-iterators.h"
 
-- 
2.39.0

