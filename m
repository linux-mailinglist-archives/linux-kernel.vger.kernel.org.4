Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E0C7712CCD
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 20:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243066AbjEZSsf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 14:48:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbjEZSsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 14:48:31 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 415ACAD
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 11:48:30 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-ba802c775caso2358564276.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 11:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685126909; x=1687718909;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pr0CfxQy0sGUiXzLTyaj373l3U9KzezGvaWkoYzA3QE=;
        b=qgAB1W5NVq0jFTTBMjUg8Hw2q2NCZNUP+DbQz09KcF8PA6oV1ga9KYZU8oGCp5XDsc
         YuYYUi7x1xKpvEXZD59MCmcTwYmJgER8UKA56ZeiLEvH0lZVfq4r1Q9FJDx3hSqHFfVV
         cdF+xUutRZlK83XxrwxlR165AcmV3ycZH9lKCDkInV021tXS/6QItALaayAdaf0KPxGd
         kku0H6olSVdfFiUq01Lly+my+AaSOkIJJ51Xm6s1jzONF6tNwuNpUzyBwNDE1K/uj1qD
         knBzoTTVOEDEj3TfmEZ30cInDdSnw7Nue2SYcVHnEd6dIBDcEItqUUZc/FsuTXX1GKPk
         d8OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685126909; x=1687718909;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pr0CfxQy0sGUiXzLTyaj373l3U9KzezGvaWkoYzA3QE=;
        b=SB9/lFrqcSGOTjnFf+PS8fcMM/G9zVaJa/+wxCkEk0vwDCH9LBKig/ssFJoajcO8ne
         g6ZRUq0s7jYtlxfH/P8rt4JEwOEU2A3d/F8t6XBkpej/Y2Yg5z7PbV/LnsMv86Wtq5tR
         aZy0DxThpUFOUzlVG9hTG2mIKLseYgy8OLIX6IqRCvxF17mceIAwvI7rFpXSIFFMTiFV
         NkdakyOkhlqqMw76WlZEwPdrtdo+wWuW4THj3TfjRzFxodapBfYbu+dfUdFWkyNoD1oQ
         uFaBAUXPV0APxCMjcrAWZG2vNyOFOdQaDRFLocAQcoe4FMl0O4kTrgksncAdbk9TmyBB
         7gGw==
X-Gm-Message-State: AC+VfDwn4vU9ApHl/5nEJwAesIe5u+HvHyN3z4qoi3NkEwQjF6CTA25Z
        +IsgFAMRzRlWH//dTFgTZj/3aRWlupEeq3pz
X-Google-Smtp-Source: ACHHUZ6077spJQTaPUlSVLjSqG56tK6rDRYM2ZgXdtOqglWP3smaalqlaryzjjW08qQlk4ow1hxNRPpHBCuDcQbo
X-Received: from ericchancf.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:4139])
 (user=ericchancf job=sendgmr) by 2002:a05:6902:1826:b0:bac:bae6:b363 with
 SMTP id cf38-20020a056902182600b00bacbae6b363mr1450617ybb.3.1685126909551;
 Fri, 26 May 2023 11:48:29 -0700 (PDT)
Date:   Fri, 26 May 2023 18:48:23 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Message-ID: <20230526184823.1230974-1-ericchancf@google.com>
Subject: [PATCH] arm64: Fix 'lock held when returning to user space' lockdep warning
From:   Eric Chan <ericchancf@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Mukesh Ojha <quic_mojha@quicinc.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Eric Chan <ericchancf@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The arm64 architecture lacks support for CONFIG_GENERIC_ENTRY, resulting
in the failure to report the lockdep warning
"lock held when returning to user space" when lockdep is enabled.

Rename the function to align with exit_to_user_mode_prepare in
kernel/entry/common.c to improve readability.

Signed-off-by: Eric Chan <ericchancf@google.com>
---
 arch/arm64/kernel/entry-common.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
index 3af3c01c93a6..9d6827201b6c 100644
--- a/arch/arm64/kernel/entry-common.c
+++ b/arch/arm64/kernel/entry-common.c
@@ -126,7 +126,7 @@ static __always_inline void __exit_to_user_mode(void)
 	lockdep_hardirqs_on(CALLER_ADDR0);
 }
 
-static __always_inline void prepare_exit_to_user_mode(struct pt_regs *regs)
+static __always_inline void exit_to_user_mode_prepare(struct pt_regs *regs)
 {
 	unsigned long flags;
 
@@ -135,11 +135,13 @@ static __always_inline void prepare_exit_to_user_mode(struct pt_regs *regs)
 	flags = read_thread_flags();
 	if (unlikely(flags & _TIF_WORK_MASK))
 		do_notify_resume(regs, flags);
+
+	lockdep_sys_exit();
 }
 
 static __always_inline void exit_to_user_mode(struct pt_regs *regs)
 {
-	prepare_exit_to_user_mode(regs);
+	exit_to_user_mode_prepare(regs);
 	mte_check_tfsr_exit();
 	__exit_to_user_mode();
 }
-- 
2.41.0.rc0.172.g3f132b7071-goog

