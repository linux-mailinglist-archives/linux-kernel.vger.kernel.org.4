Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 407636D32F6
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 19:48:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbjDARsM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 13:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjDARsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 13:48:10 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E474CDE2
        for <linux-kernel@vger.kernel.org>; Sat,  1 Apr 2023 10:48:09 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id ew6so101904841edb.7
        for <linux-kernel@vger.kernel.org>; Sat, 01 Apr 2023 10:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680371288;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uUk473gkjGgeA+vrTjspm7ZOU1tv85Lj1DyviVq1tIM=;
        b=V15yo1agiL/f/jCBH1vAnC4upO7VVXPn1t4xtCG0U3fuURPgscayNelI9XTdr17e+U
         5X7TdYnFqA0U/9T2md+S+SNi6p/jdy3kpe+AX28cxaoCYtbkQ+XJYcbja8qDHwZXFz/o
         /O7/7wW6zZbsrjTm9poE9ME/JpJuHvsCnDq5qEYxaVo+ane08jlS9RhZtBl4WN0kJGXu
         l+LRyz1gZ3sWpwwQyfbsu0xdamENwsqA9LqtzBGf2VI0Mff8LuuDaM3igZ4v24GodUSM
         unJAd6i/9kdld9DWnWp9dSaq8VQWZeXYf5PSsc0ls834hMb5vylKQYSVVI3dSfxZiPFB
         KdKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680371288;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uUk473gkjGgeA+vrTjspm7ZOU1tv85Lj1DyviVq1tIM=;
        b=OMCRMsSQJr7f55nW2mW5jJhHqLJWHFKw34DBA2BOeZuaxkdOjgb3AbjvgBeu33EhhE
         CeyKcA/+RyF3cklEBkhzy1/OPfDee9sNXmhGEDmtZrvVIlpDXukVtnez77+HOKrmlFAo
         3PtMoJQXrYYlWisa2YC07q+BLjxtrNLqtTFJPslBQsSxJtEM0ippdz8hvnkH1kmLkX5K
         pe6wv07zzwOZouFt6Zs36kLLM2WMZrbVPsmS1XrCCKfbCgSdtmzNPsE4u7BVs3kSfA5x
         qp51rMAkHudlDW6CwqhI2U8u7oVFYPGXe+p3jxDzw+GG+aeXks/QhiON1BfAspg+DCNP
         z3cg==
X-Gm-Message-State: AAQBX9eOOmK1hm+CHkC2nTI7aTlj3fzBuFpqIpiaNRXOiTxLTJzm2yu7
        femFqVZrmMW5xP4mAmkh+LLSo1yzvg==
X-Google-Smtp-Source: AKy350blbxvhNnaPoMGCuFxzwUe22wFmfxCtujnaSfY2ap36H3Lf0LjChdJ5DCFmIbc20B7OSjLeRw==
X-Received: by 2002:a17:906:2759:b0:931:ad32:79ed with SMTP id a25-20020a170906275900b00931ad3279edmr28497694ejd.12.1680371287742;
        Sat, 01 Apr 2023 10:48:07 -0700 (PDT)
Received: from p183 ([46.53.251.40])
        by smtp.gmail.com with ESMTPSA id gx20-20020a1709068a5400b00931faf03db0sm2316217ejc.27.2023.04.01.10.48.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Apr 2023 10:48:07 -0700 (PDT)
Date:   Sat, 1 Apr 2023 20:48:05 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] string: implement streq()
Message-ID: <4b595ab9-238c-43a5-aba0-be5d6afc0f87@p183>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most of the time strcmp() is being used, strings are checked for equality.
Add wrapper to relay such intent (it is shorter to type, too).

Use
	if (streq(s, "s")) {
	}
or
	if (!streq(s, "s")) {
	}

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 drivers/clk/socfpga/clk-gate-a10.c |    2 --
 drivers/clk/socfpga/clk.h          |    1 -
 include/linux/string.h             |    6 ++++++
 scripts/dtc/dtc.h                  |    6 +++++-
 4 files changed, 11 insertions(+), 4 deletions(-)

--- a/drivers/clk/socfpga/clk-gate-a10.c
+++ b/drivers/clk/socfpga/clk-gate-a10.c
@@ -11,8 +11,6 @@
 
 #include "clk.h"
 
-#define streq(a, b) (strcmp((a), (b)) == 0)
-
 #define to_socfpga_gate_clk(p) container_of(p, struct socfpga_gate_clk, hw.hw)
 
 /* SDMMC Group for System Manager defines */
--- a/drivers/clk/socfpga/clk.h
+++ b/drivers/clk/socfpga/clk.h
@@ -19,7 +19,6 @@
 
 #define SOCFPGA_MAX_PARENTS		5
 
-#define streq(a, b) (strcmp((a), (b)) == 0)
 #define SYSMGR_SDMMC_CTRL_SET(smplsel, drvsel) \
 	((((smplsel) & 0x7) << 3) | (((drvsel) & 0x7) << 0))
 
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -47,6 +47,12 @@ extern size_t strlcat(char *, const char *, __kernel_size_t);
 #ifndef __HAVE_ARCH_STRCMP
 extern int strcmp(const char *,const char *);
 #endif
+
+static inline bool streq(const char *a, const char *b)
+{
+	return strcmp(a, b) == 0;
+}
+
 #ifndef __HAVE_ARCH_STRNCMP
 extern int strncmp(const char *,const char *,__kernel_size_t);
 #endif
--- a/scripts/dtc/dtc.h
+++ b/scripts/dtc/dtc.h
@@ -88,7 +88,11 @@ static inline uint64_t dtb_ld64(const void *p)
 		| bp[7];
 }
 
-#define streq(a, b)	(strcmp((a), (b)) == 0)
+static inline bool streq(const char *a, const char *b)
+{
+	return strcmp(a, b) == 0;
+}
+
 #define strstarts(s, prefix)	(strncmp((s), (prefix), strlen(prefix)) == 0)
 #define strprefixeq(a, n, b)	(strlen(b) == (n) && (memcmp(a, b, n) == 0))
 static inline bool strends(const char *str, const char *suffix)
