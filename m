Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22CB460495B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 16:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbiJSOgL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 10:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbiJSOfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 10:35:47 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8498010CFBD
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 07:19:52 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id v1so128169wrt.11
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 07:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=A41cmwk6vsfiz18uL26ZksSgKHfvB8mOhlbn7RWroYI=;
        b=BUGjpY4dFx+tjDzcbqisTqhazVC3FPj/37XmkDVOCQooeKNHql7fJDqPBnfXWy0KZB
         pvWPDQWEIrkzAdErpRcUPyVTNdC1inAoh8G6LmWvUyZjtIQjbTZ89YajEDu+YUxze9Kq
         TyIOLsZzmAp5XCHwbw+U5NkhiG26chITfQM3kErJ9qGIhIaI0y+8lzf59ScSiB8hlNjp
         mQODSfGqWKj8ai+74pMSY+6k4S9qyHyAIOHphWaSGMpW9I8VlgdbH/IIst3OSpj6f0Bv
         QQW1L4n9snVB/NmmaBVvgSCiDLbIbYOuVDeG0ugdNefybxadBtjOFK7mufwjHLY1Eig2
         h/+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A41cmwk6vsfiz18uL26ZksSgKHfvB8mOhlbn7RWroYI=;
        b=I4xp1ym7cW69+FK9sBtbRG+FIsZBgDXs+ILu0gqv8gXogRhmA+AcZzPPYk4Gki6gzJ
         7FGfpC39J0jSqoF8rUAuh4XqlTGrXBP5fiKji4we7r25KknGk8gMk8qwHNQU+7u+MaqG
         7hPk8/ULZO2B/Sc+JXZyhqt4cPXNX70XZRLLu3QqPUkLlCcRaR05eaJXOCYlk4mst4IO
         yRj7d+xInMNKG1FzY+HRWHkLi+hJFGX6vBsl9F7hniJIJndD068ZUjOvxJ/ZyVp+r/w0
         meAKBySHoPl4DVk6PbgLXqzHuckxaAPjC9CGreKmuUEt7kebWGJlnd88ucytaMBmfVBJ
         68Hg==
X-Gm-Message-State: ACrzQf2qS9pdDuYHqAoFYHN9LIrUrhlxaXBKyZMyFum47bk1UBqD80fi
        39LwpWeLwqtGydzom2GicoReWmbNMNBxvA==
X-Google-Smtp-Source: AMsMyM7MyOY4LhwNZXVFDl1sEPdPr+4X15+CS/5kCISrrzEweb7zSBeI2+n/jVXlk3DmY7QlTFrcfw==
X-Received: by 2002:a17:907:6d08:b0:78e:e87:5c06 with SMTP id sa8-20020a1709076d0800b0078e0e875c06mr6683796ejc.511.1666188553676;
        Wed, 19 Oct 2022 07:09:13 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id c21-20020a17090603d500b00764a76d5888sm8899287eja.27.2022.10.19.07.09.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 07:09:13 -0700 (PDT)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Jason Baron <jbaron@akamai.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH] jump_label: use atomic_try_cmpxchg in static_key_slow_inc_cpuslocked
Date:   Wed, 19 Oct 2022 16:08:50 +0200
Message-Id: <20221019140850.3395-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.37.3
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

Use atomic_try_cmpxchg instead of atomic_cmpxchg (*ptr, old, new) == old
in static_key_slow_inc_cpuslocked.  x86 CMPXCHG instruction returns success
in ZF flag, so this change saves a compare after cmpxchg (and related move
instruction in front of cmpxchg).

Also, atomic_try_cmpxchg implicitly assigns old *ptr value to "old" when
cmpxchg fails, enabling further code simplifications.

No functional change intended.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Jason Baron <jbaron@akamai.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
---
 kernel/jump_label.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/kernel/jump_label.c b/kernel/jump_label.c
index 714ac4c3b556..4d6c6f5f60db 100644
--- a/kernel/jump_label.c
+++ b/kernel/jump_label.c
@@ -115,8 +115,6 @@ EXPORT_SYMBOL_GPL(static_key_count);
 
 void static_key_slow_inc_cpuslocked(struct static_key *key)
 {
-	int v, v1;
-
 	STATIC_KEY_CHECK_USE(key);
 	lockdep_assert_cpus_held();
 
@@ -132,11 +130,9 @@ void static_key_slow_inc_cpuslocked(struct static_key *key)
 	 * so it counts as "enabled" in jump_label_update().  Note that
 	 * atomic_inc_unless_negative() checks >= 0, so roll our own.
 	 */
-	for (v = atomic_read(&key->enabled); v > 0; v = v1) {
-		v1 = atomic_cmpxchg(&key->enabled, v, v + 1);
-		if (likely(v1 == v))
+	for (int v = atomic_read(&key->enabled); v > 0; )
+		if (likely(atomic_try_cmpxchg(&key->enabled, &v, v + 1)))
 			return;
-	}
 
 	jump_label_lock();
 	if (atomic_read(&key->enabled) == 0) {
-- 
2.37.3

