Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBDF0616169
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 12:06:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbiKBLGh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 07:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbiKBLGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 07:06:33 -0400
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2826529C83
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 04:06:25 -0700 (PDT)
Received: by mail-wr1-x44a.google.com with SMTP id d23-20020adfa417000000b002364a31b7c9so4682909wra.15
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 04:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WrClR7h0c/XU2pAfJHOZckEycFJJtsgVk0eEUZJfByQ=;
        b=p8C9AfvzfTHb4amAZyR7Huo6iTM2OmZ596wuVutv4RMIjPVHhzGcRhijW0Wdzbgz/4
         mg8h+O0U7SL3esE9xQvb/5kztONm+5qgbpw+tJlE//0bLZKuFkjRAzzQj+0wx1PDrFL6
         Gauls6F4ST7RPiHkY++x7dd+3pFWOzDJv/RKpYF7ClI+YHFIqhcGVGIZOl7rqs/xFadg
         JoL4S1a87PsVKKh6JjnOfr+h9u34ulSYmsJAwMO91rHcN2Iy4iWb7e3lSQdY6fNFQ1ky
         oJ0NvFIbyshMi4t2Q/NN65+FNBXzM8tc6cSwn+oFCnYObruLNwf8GKhvRyngWCXgMNCu
         nieA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WrClR7h0c/XU2pAfJHOZckEycFJJtsgVk0eEUZJfByQ=;
        b=Fkj0wGbRuEOzGfSMKkuwKKydff6CpzFQgzN+ABOsco+lsN+/OBObvfeE/pQVFWvRm4
         5y4Lhw0/ItsNDIHDyQNaW8MHSV6tEjgWhrhKjtjRfDGhFZjGyTFnvB5VeaUEfVrv+D4p
         5QmPyO8NucyM61/YSccjz/RNvxCn8pWywjUAgBzygJycqxHysH5ukGgGG9W/EWrA5Kzy
         8iUIARPwoKBLu1YmPhkhl4pM6+eXOVmAcgd6AWoVcxvzMTPxEcApc4vp0SghGeWMBY94
         FzP1GxPtJaxXuxCU2HArjkqkq7vif0hrQDg9X9WcHl3SpWBLjASbdj935PeAHs69AAqh
         9ufg==
X-Gm-Message-State: ACrzQf1L0yr2EGljHpuQwcsMlyfb7UEpVyBGqZJ2EaG08L6Z/TK4HRQJ
        +cpdUGfYE/AdNKOpAtIv3lvFYwZtG7A=
X-Google-Smtp-Source: AMsMyM74mWMhrgnaynccgvDcG2odp7kJoqQH6hJmlTrNDoPthPuQMBlGWcgbtLnfVHNrarTgP4wSHzfbzMc=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:7f41:af20:8:a96d])
 (user=glider job=sendgmr) by 2002:adf:dd91:0:b0:236:a261:6930 with SMTP id
 x17-20020adfdd91000000b00236a2616930mr14444934wrl.551.1667387183641; Wed, 02
 Nov 2022 04:06:23 -0700 (PDT)
Date:   Wed,  2 Nov 2022 12:06:10 +0100
In-Reply-To: <20221102110611.1085175-1-glider@google.com>
Mime-Version: 1.0
References: <20221102110611.1085175-1-glider@google.com>
X-Mailer: git-send-email 2.38.1.273.g43a17bfeac-goog
Message-ID: <20221102110611.1085175-4-glider@google.com>
Subject: [PATCH 4/5] kmsan: make sure PREEMPT_RT is off
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

As pointed out by Peter Zijlstra, __msan_poison_alloca() does not play
well with IRQ code when PREEMPT_RT is on, because in that mode even
GFP_ATOMIC allocations cannot be performed.

Fixing this would require making stackdepot completely lockless, which
is quite challenging and may be excessive for the time being.

Instead, make sure KMSAN is incompatible with PREEMPT_RT, like other
debug configs are.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Marco Elver <elver@google.com>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/lkml/20221025221755.3810809-1-glider@google.com/
Signed-off-by: Alexander Potapenko <glider@google.com>
---
 lib/Kconfig.kmsan | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/Kconfig.kmsan b/lib/Kconfig.kmsan
index b2489dd6503fa..ef2c8f256c57d 100644
--- a/lib/Kconfig.kmsan
+++ b/lib/Kconfig.kmsan
@@ -12,6 +12,7 @@ config KMSAN
 	bool "KMSAN: detector of uninitialized values use"
 	depends on HAVE_ARCH_KMSAN && HAVE_KMSAN_COMPILER
 	depends on SLUB && DEBUG_KERNEL && !KASAN && !KCSAN
+	depends on !PREEMPT_RT
 	select STACKDEPOT
 	select STACKDEPOT_ALWAYS_INIT
 	help
-- 
2.38.1.273.g43a17bfeac-goog

