Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00EA064F791
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 05:45:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbiLQEo4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 23:44:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbiLQEou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 23:44:50 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C41B130562
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 20:44:48 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id 84-20020a630257000000b00477f88d334eso2582894pgc.11
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 20:44:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=oCkOLeUT8z9uWy5v5k8t9XGXY+OZQL+wMiMJpjklfMk=;
        b=NkQAhros/6X1C1DqT6opfUL3F1fT6++iMSU6wymnZhCK5ti0wioHiihwyt8oVKB0Nu
         MgUxlCztzY3GF0CsapECuOVpjQzsA/HfxIxj+HUz4spuCfAnTFk1I3TqTawO2XpqG6UU
         56J6gfM57ah6xKmO6caUJfUfZx3tNLKF2KhkvRLvfNvFqMBBsEhHyB3A7TvYLarcLN6P
         fKVvVrpvUkOfhUDpOOzx2dUl5F1s46Ffosa6phFHdnfhYsFDpD/qgpTwV2UOy/FRNJvl
         OQIDtS8w7AaUhUhw5rDfSJQ6xtVHReyzqm5xpHermfANmJjYUhaP8hnhRxrFGiuGYe1a
         ancQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oCkOLeUT8z9uWy5v5k8t9XGXY+OZQL+wMiMJpjklfMk=;
        b=LzMPZngVpw93w2GDKKyuoXSI4hjd/t/F6JL7RGSLKDxdyzvxWLvUTrHeJXXGRNLpZk
         dd1hlbRZnOZJ0f1Y81zLRlv+j4EWiNFidsCM9QIpnB8W8IvYRWrw8IFksle2/nsiCvtj
         eWouwgELE3qDoLczwQ9xYe+g5BbZ6ZJokksnoC/Z4Cze2I0uZIQ8pWCQVpLgt5W+GDYH
         8dbNI3hoiwnUeS2dKvk54G0R04iPpSsX+HwZDwTDt+QxEtQaITvL5Sce5J4lf1kxtzEy
         JOfyWYa4niGecTf/xF8qiKtAhSpD5TBx3JZLQ1hgE6WJjV3dig4iyp9e31FNbcRUYyeg
         KDBA==
X-Gm-Message-State: ANoB5pnbg6giizovbaUHm+YpUUCuA7U/mbaFpDJPdYUk9TTPLRfVrb3s
        d5PcWi8uHVcL5dWHdUKHvv+1zxt9FBrzEg==
X-Google-Smtp-Source: AA0mqf5WvCHE4FnTVtZCQe/4IUCPwpqYVRfZ0jHUmlZpfPT/x7sGQmkzk8ex0J4cnMv1HrvC8Eo90rNa2kROmQ==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a62:8342:0:b0:577:8eba:c019 with SMTP id
 h63-20020a628342000000b005778ebac019mr7776687pfe.35.1671252288299; Fri, 16
 Dec 2022 20:44:48 -0800 (PST)
Date:   Sat, 17 Dec 2022 12:44:34 +0800
In-Reply-To: <20221217044436.4138642-1-davidgow@google.com>
Mime-Version: 1.0
References: <20221217044436.4138642-1-davidgow@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20221217044436.4138642-2-davidgow@google.com>
Subject: [PATCH 1/3] rust: arch/um: Use 'pie' relocation mode under UML
From:   David Gow <davidgow@google.com>
To:     Miguel Ojeda <ojeda@kernel.org>,
        "=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     David Gow <davidgow@google.com>, rust-for-linux@vger.kernel.org,
        linux-um@lists.infradead.org, llvm@lists.linux.dev,
        linux-doc@vger.kernel.org, kunit-dev@googlegroups.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Daniel Latypov <dlatypov@google.com>,
        Jonathan Corbet <corbet@lwn.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UML expects a position independent executable for some reason, so tell
rustc to generate pie objects. Otherwise we get a bunch of relocations
we can't deal with in libcore.

Signed-off-by: David Gow <davidgow@google.com>
---
 arch/um/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/um/Makefile b/arch/um/Makefile
index f1d4d67157be..ae321282dc6f 100644
--- a/arch/um/Makefile
+++ b/arch/um/Makefile
@@ -68,6 +68,8 @@ KBUILD_CFLAGS += $(CFLAGS) $(CFLAGS-y) -D__arch_um__ \
 	-Din6addr_loopback=kernel_in6addr_loopback \
 	-Din6addr_any=kernel_in6addr_any -Dstrrchr=kernel_strrchr
 
+KBUILD_RUSTFLAGS += -Crelocation-model=pie
+
 KBUILD_AFLAGS += $(ARCH_INCLUDE)
 
 USER_CFLAGS = $(patsubst $(KERNEL_DEFINES),,$(patsubst -I%,,$(KBUILD_CFLAGS))) \
-- 
2.39.0.314.g84b9a713c41-goog

