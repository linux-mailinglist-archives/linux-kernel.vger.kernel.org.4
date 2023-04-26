Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C79976EF005
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 10:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240079AbjDZIPB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 04:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240097AbjDZIOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 04:14:47 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9511010F8;
        Wed, 26 Apr 2023 01:14:46 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-504eb1155d3so50844008a12.1;
        Wed, 26 Apr 2023 01:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682496884; x=1685088884;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hPHglsVUSyVNHBx390LARMYYSXfZEHD/f4PadDVbYcU=;
        b=EeoNuAEcf2hhG/SwOGenpr6F1p5OHWgy1xltdtaneBsVTMX+a69xyKUj/BkIkN/j37
         bJcSROx816NyF5j8gM3zeRgjm3NSgs3cyBmeBJPwHqz+BiJfb/xOg6/8L873+0s9fD62
         ihgbvXTeI6vK1bnPLH1hcscIzf8/bo8N3alkHh/vdugZDo5DCYlSp9+XFmhbHwagND/R
         fXX7/stY8rRicHX3qWPCXqcTGxB0L4vWk5mPZidUXNzpJr5bK8+6wJ74r4J/daCqKfbE
         6R0Ij8duEQcpUAIpRV5bYHCQ9rXqQzYyuoldDVpm7ZEzdrms4NFhTsKsq5I1pTz+wz8W
         3FhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682496884; x=1685088884;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hPHglsVUSyVNHBx390LARMYYSXfZEHD/f4PadDVbYcU=;
        b=JGxZBzbEegIGQ320xJr8ryydVmcSuB1b2yWWd12GNdi76xvw7wlHZP8hBMrxV+A6ue
         zY3MNwsefsS4H3cViZzZSpdbPtNOVDV6JvwlkxmLLr5rE7u3L+MThTOXi03Q/nHDiTJr
         Z26T6hLSNSmXe4PpQvu+/kKkf00NX75vgM01DkO8ovY6d5/AVxVcLAvTyrxwR5uKg3r0
         2LyGsFEQOdHhAQuDEYnAwdvjvzLw5DK86DR9/QabQl9wesVocKpaAB8W2UMPO6ruYf5U
         bvxTRXsRu5Cx7e8Uq/DsoYUV7BB6fshqs/RN7t9A9FosffTlsHsCBxS3GEJoZZ3mQMi/
         sMwA==
X-Gm-Message-State: AC+VfDzTOEc+HBisyi4B9PjN/GCoNQDcRGdXPE+4kUEkegEVqXofPNVC
        WBUCZN5ArRrkkI1Ytc+LyGUDMp7s0VrAMkR+
X-Google-Smtp-Source: ACHHUZ5ifaUF9TCr2CIibnbLYrCjMciYkU+k8zKlZavuwFG1FgAA3/ED3ElVlVsWDW3+HPfbxfIA2A==
X-Received: by 2002:a17:906:198:b0:94e:cfd0:ed9f with SMTP id 24-20020a170906019800b0094ecfd0ed9fmr1409547ejb.26.1682496884403;
        Wed, 26 Apr 2023 01:14:44 -0700 (PDT)
Received: from archlinux-cisco.cisco.com ([2001:420:c0c0:1004::3c7])
        by smtp.gmail.com with ESMTPSA id h13-20020a170906718d00b0095386574c81sm7872609ejk.51.2023.04.26.01.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Apr 2023 01:14:43 -0700 (PDT)
From:   Ariel Miculas <ariel.miculas@gmail.com>
X-Google-Original-From: Ariel Miculas <amiculas@cisco.com>
To:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com,
        boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
        benno.lossin@proton.me
Cc:     Ariel Miculas <amiculas@cisco.com>
Subject: [PATCH] rust: Sort rust/helpers.c's #include directives
Date:   Wed, 26 Apr 2023 11:13:54 +0300
Message-Id: <20230426081354.38922-1-amiculas@cisco.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <CANiq72kXa-SgRiVhvjU7X4fa8XSJB4po9xf_V4L6Gn2o+t6T+Q@mail.gmail.com>
References: <CANiq72kXa-SgRiVhvjU7X4fa8XSJB4po9xf_V4L6Gn2o+t6T+Q@mail.gmail.com>
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

Sort the #include directives of rust/helpers.c alphabetically and add a
comment specifying this.

Suggested-by: Miguel Ojeda <ojeda@kernel.org>
Link: https://github.com/Rust-for-Linux/linux/issues/1003
Signed-off-by: Ariel Miculas <amiculas@cisco.com>
---
 rust/helpers.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/rust/helpers.c b/rust/helpers.c
index 81e80261d597..73c01db0c828 100644
--- a/rust/helpers.c
+++ b/rust/helpers.c
@@ -16,15 +16,17 @@
  *
  * All symbols are exported as GPL-only to guarantee no GPL-only feature is
  * accidentally exposed.
+ *
+ * Sorted alphabetically.
  */
 
 #include <linux/bug.h>
 #include <linux/build_bug.h>
 #include <linux/err.h>
-#include <linux/refcount.h>
 #include <linux/mutex.h>
-#include <linux/spinlock.h>
+#include <linux/refcount.h>
 #include <linux/sched/signal.h>
+#include <linux/spinlock.h>
 #include <linux/wait.h>
 
 __noreturn void rust_helper_BUG(void)
-- 
2.40.0

