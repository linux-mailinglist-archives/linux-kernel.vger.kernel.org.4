Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9C9E616165
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 12:06:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbiKBLGT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 07:06:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiKBLGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 07:06:16 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3188824945
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 04:06:16 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 204-20020a2510d5000000b006be7970889cso16185960ybq.21
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 04:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZbeyMEB1N3HnW3KuOlIdq7/dvvJzr15HTa/zFi9USr4=;
        b=Zys9RxGxneSiAkiaMSLp0fMMah4Q4Z9cQekcJkJNg09vNC8uJQw/eYHIdshUK8sloS
         ooGakxYdVsGGFtO0vf+eL1zU+0H2llK4TNEmcMhroLHzQrTPZfBWQDBojDOhblkUEr4Y
         VlVIHNHQhO38wMiB66DPLA3LFQdtHMrbm5ZhgUQeygogmoqNQKhuvL5oPo0DAC2/5AVe
         qCxhIyoFmRsOF+cCGGErqjcW2MS+JPt+pV98fCT/Hsinr2F1udxrRJ8ikXkJHQoEIYa3
         nXngezqkGCOS882wdt6JuoQoJ6omP88TBbF3foaf3Ou/PIbwm73m0hBRCxKUIYBtx6df
         B0dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZbeyMEB1N3HnW3KuOlIdq7/dvvJzr15HTa/zFi9USr4=;
        b=aeaVomlXtA/VenbrXTONU+mIhkhBODY+4e6BfFjvk4Avk4/CN+GgGc81DV4W9Q/dHT
         yzRLydT6CJbrshE3tLJ18x3W77otuMCUHN0SnRjTfGsCdkhrhXaywyd+FPAMLFVRWxlD
         NMmbX9ySsQ4za8RTG7BB6KUy2k9LyP0viC5eq1njpqOtDZkbECo5Y/hDnZs7pao9HyDq
         4fI9RySfj7zdJwp6+FKqV44Xv+zD2KtXzXyU30bSE4D3LQJxnVBcaBAjIhd6F7bWPXPi
         QKAfAeLZ3jzyS/FJwA4jYFxsKvE2glLcIhR0vXTSdAV6gv81V4djRvp7WnucusJMfFGs
         SJhA==
X-Gm-Message-State: ACrzQf1hkDPLOla0UJmcpRomsbJpTvaG7m1MskjRubLkunbrv7xu5She
        02SbipwjNx0mH7zHckLczHWaHcTHekU=
X-Google-Smtp-Source: AMsMyM4hS7slDYBeV5u3u/VgJ5G2C644lj/pYCkRoBPNBgg3H29Xs+iNPOC5zuesvbC6tPeF8YMpu8KFAb4=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:7f41:af20:8:a96d])
 (user=glider job=sendgmr) by 2002:a25:2187:0:b0:6b0:1abc:2027 with SMTP id
 h129-20020a252187000000b006b01abc2027mr22399213ybh.348.1667387175509; Wed, 02
 Nov 2022 04:06:15 -0700 (PDT)
Date:   Wed,  2 Nov 2022 12:06:07 +0100
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.1.273.g43a17bfeac-goog
Message-ID: <20221102110611.1085175-1-glider@google.com>
Subject: [PATCH 1/5] kmsan: core: kmsan_in_runtime() should return true in NMI context
From:   Alexander Potapenko <glider@google.com>
To:     glider@google.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Marco Elver <elver@google.com>,
        Peter Zijlstra <peterz@infradead.org>
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

Without that, every call to __msan_poison_alloca() in NMI may end up
allocating memory, which is NMI-unsafe.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Marco Elver <elver@google.com>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/lkml/20221025221755.3810809-1-glider@google.com/
Signed-off-by: Alexander Potapenko <glider@google.com>
---
 mm/kmsan/kmsan.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/kmsan/kmsan.h b/mm/kmsan/kmsan.h
index 961eb658020aa..3cd2050a33e6a 100644
--- a/mm/kmsan/kmsan.h
+++ b/mm/kmsan/kmsan.h
@@ -125,6 +125,8 @@ static __always_inline bool kmsan_in_runtime(void)
 {
 	if ((hardirq_count() >> HARDIRQ_SHIFT) > 1)
 		return true;
+	if (in_nmi())
+		return true;
 	return kmsan_get_context()->kmsan_in_runtime;
 }
 
-- 
2.38.1.273.g43a17bfeac-goog

