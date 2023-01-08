Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32EC86612FB
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 03:13:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232419AbjAHCMj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 21:12:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232110AbjAHCMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 21:12:31 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 215CD15F23
        for <linux-kernel@vger.kernel.org>; Sat,  7 Jan 2023 18:12:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=42bzLWQ9Dix8/b44YinH/9gzk5jrFAX5viJfVtORb7Y=; b=jJrXn4kE9TI4GVxUa7eqxiMmz6
        G/GXEhFLJO8k+FBDCWYjSdclONjxKcCP8INsWjMTfN49ZfgX4hcNWKdTPNF4znASCLcnxQ1TBEECc
        8ch0a5JOYD+vIxg55Q2mnr51mvDe+UCKnjvQqDMIba4FVWh9kFyCwL82ztHGkS1F0TVYM/i2jSUzX
        FzuTzr9lm+wXFHusbYCraVPhKDrXOVrtqGSwu2S0ETm8C8UBkZeyDi6MAHoBwi1cv/Q8ewXGo97C8
        WqcxT0UIln4140QFUw2JiVpQmUO5Y1YJ14IO4dgeV31ufV9fY/XpthhhdOItNPQXEdoAjC0V1wTPj
        jEypnIlg==;
Received: from [2601:1c2:d80:3110::a2e7] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pELAj-00Aq3x-Hr; Sun, 08 Jan 2023 02:12:29 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>
Subject: [PATCH] seccomp: fix kernel-doc function name warning
Date:   Sat,  7 Jan 2023 18:12:28 -0800
Message-Id: <20230108021228.15975-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the ACTION_ONLY() macro so that it is not between the kernel-doc
notation and the function definition for seccomp_run_filters(),
eliminating a kernel-doc warning:

kernel/seccomp.c:400: warning: expecting prototype for seccomp_run_filters(). Prototype was for ACTION_ONLY() instead

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Will Drewry <wad@chromium.org>
---
 kernel/seccomp.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -- a/kernel/seccomp.c b/kernel/seccomp.c
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -388,6 +388,7 @@ static inline bool seccomp_cache_check_a
 }
 #endif /* SECCOMP_ARCH_NATIVE */
 
+#define ACTION_ONLY(ret) ((s32)((ret) & (SECCOMP_RET_ACTION_FULL)))
 /**
  * seccomp_run_filters - evaluates all seccomp filters against @sd
  * @sd: optional seccomp data to be passed to filters
@@ -397,7 +398,6 @@ static inline bool seccomp_cache_check_a
  *
  * Returns valid seccomp BPF response codes.
  */
-#define ACTION_ONLY(ret) ((s32)((ret) & (SECCOMP_RET_ACTION_FULL)))
 static u32 seccomp_run_filters(const struct seccomp_data *sd,
 			       struct seccomp_filter **match)
 {
