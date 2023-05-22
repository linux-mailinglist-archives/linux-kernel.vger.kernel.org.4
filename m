Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DBC970C2BC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 17:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234561AbjEVPwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 11:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234588AbjEVPwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 11:52:32 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 269679E;
        Mon, 22 May 2023 08:52:32 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id e9e14a558f8ab-33823abc8a4so15375255ab.3;
        Mon, 22 May 2023 08:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684770751; x=1687362751;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FGZB0BLWCtOoXyFqMRziafXS39k9XZRqjcukX9G4FJY=;
        b=FaHtcdzkdup+GumaJ45Fo02SZy1fX3GJRn633/fLcAmnpNi5q6NOU3nSUZSdnnA03n
         2CMLwJoMaosxKnGgH/agh0HqXPkdeIgCSrXBYuOUCFPzv07teBhZ3zTzDOn4+6fzO7uH
         bpkkPs2OGkn6ZEm6/nRQe0FDxmwzyEBDf9ve9CT8aYHPHApi9NxH0QxpfImEfkdGALwF
         ajUs/tM/rExv3923dLsNLbfbbx/SkAzcxDoqT9j+StG5sMK5OOZCMkGJyMISGX4h0Yvd
         2m/nNqhPiUTt3Rv7Pk4ohNaBqOVlzwktKa8GH5tmC+3ApFxo/1aRNIU7oInSObuLoJi1
         d4Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684770751; x=1687362751;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FGZB0BLWCtOoXyFqMRziafXS39k9XZRqjcukX9G4FJY=;
        b=OCTTvXnqqUQrc6ZMN0qsiqZbAd9eSNvUuLDWYUXOFFhr23ntu+CqiYjsj7CELYonrm
         BWTBl5JZuXwl/fTRicGo0Ru0+QYgnX2lOdjUKDjbCCeWCrolrn4bOvWT7NBKdlvLQLEe
         njJTeqNx/uQ1GBdPqcizp8yP8yLSBVIt4YIBuNbc3Q69Q78M0JUeaP0UVqG662rLM0eC
         7miDtCy0TJzj7k+gpmy5TM3RcrODBJwkBRKPaFKv8e0mOChrmf5dB1P/8LskU20v+rbC
         ePx5hdJjFWeAgIC4JGzgyL9htA2MnoLQEJautR1MJ7Fnav4uPoJYJXWuga8icLSKnNcv
         3BPw==
X-Gm-Message-State: AC+VfDzrIgdpV9MESaVna5baa9DstsjE0c0z6oWPR8yn4+S+bg0bgHqV
        HXHskCuhZyKuIJYfI6vPxZg=
X-Google-Smtp-Source: ACHHUZ7G3O5lakPrrnpKk0CJuz9qBmBLohQbjDmp+MjXW8RFKkaDO1ZAw0Er7zfh0B+IPVnZl2wqCA==
X-Received: by 2002:a92:603:0:b0:32e:41ce:e521 with SMTP id x3-20020a920603000000b0032e41cee521mr7113138ilg.8.1684770751296;
        Mon, 22 May 2023 08:52:31 -0700 (PDT)
Received: from azeems-kspp.c.googlers.com.com (54.70.188.35.bc.googleusercontent.com. [35.188.70.54])
        by smtp.gmail.com with ESMTPSA id p23-20020a02b397000000b00411bc1340c0sm1799779jan.8.2023.05.22.08.52.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 08:52:30 -0700 (PDT)
From:   Azeem Shaikh <azeemshaikh38@gmail.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Cc:     linux-hardening@vger.kernel.org,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        John Harrison <John.C.Harrison@Intel.com>,
        Matthew Brost <matthew.brost@intel.com>,
        Ashutosh Dixit <ashutosh.dixit@intel.com>,
        Lionel Landwerlin <lionel.g.landwerlin@intel.com>,
        Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/i915: Replace all non-returning strlcpy with strscpy
Date:   Mon, 22 May 2023 15:52:28 +0000
Message-ID: <20230522155228.2336755-1-azeemshaikh38@gmail.com>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

strlcpy() reads the entire source buffer first.
This read may exceed the destination size limit.
This is both inefficient and can lead to linear read
overflows if a source string is not NUL-terminated [1].
In an effort to remove strlcpy() completely [2], replace
strlcpy() here with strscpy().
No return values were used, so direct replacement is safe.

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
[2] https://github.com/KSPP/linux/issues/89

Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
---
 drivers/gpu/drm/i915/selftests/i915_perf.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/selftests/i915_perf.c b/drivers/gpu/drm/i915/selftests/i915_perf.c
index 24dde5531423..d4608b220123 100644
--- a/drivers/gpu/drm/i915/selftests/i915_perf.c
+++ b/drivers/gpu/drm/i915/selftests/i915_perf.c
@@ -28,7 +28,7 @@ alloc_empty_config(struct i915_perf *perf)
 	oa_config->perf = perf;
 	kref_init(&oa_config->ref);
 
-	strlcpy(oa_config->uuid, TEST_OA_CONFIG_UUID, sizeof(oa_config->uuid));
+	strscpy(oa_config->uuid, TEST_OA_CONFIG_UUID, sizeof(oa_config->uuid));
 
 	mutex_lock(&perf->metrics_lock);
 

