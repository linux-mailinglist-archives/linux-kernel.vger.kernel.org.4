Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 582B2633DF5
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 14:43:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233795AbiKVNnX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 08:43:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232384AbiKVNnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 08:43:14 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AA3117AA2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 05:43:13 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id i12so20910436wrb.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 05:43:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oz/x0hYzIKEhbV26HZwpXUkevVwyn0i3SBVcDpOX/FE=;
        b=PKJAOS7uyhQ4o6WULep7fOMCwPNev5tDMobcqb9XpkwRRaJ7PGELHvJLP+rH5JjuW5
         Y0dUKeO48GiX7GSJrO0t61xtMV7JoebKt2ibAOeZvfqoy8Y6f+8QSzbanceeMO6t5JQ7
         flG9zUAMWUCpUJDrsORvC1GFErL04yHK9KLbYcdkaaxa2h+iEGLZqxbT6ZuVAqtaC7DS
         ZdmSBH4NJP7JOa5Y0jOD6YfTeayHMYFY0pVR/mBUofyPNmV1QHbYcg/Xb96m041D3VDx
         QtmENcDGrWtvvCqIn3EWzXLoSO328nrTEGpsMSnFQTHUA3UoskAOMp3ANYaR0nCTuRxn
         KFnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Oz/x0hYzIKEhbV26HZwpXUkevVwyn0i3SBVcDpOX/FE=;
        b=OObzoZJsLp7RT6u6NAAM8nIdYvjCVQy5+VRrPIWAqq17veDJH9D42h1qwQgkkW41w0
         friS10ByyzvFm9A0R/dJl2MoiW5dMM4mAxeDCniZuAY/WIhQhoYd3rLzL+rjcBQE3oV/
         fCfHsxWZwRy3oRJafvT2+jb+ifn49PiIQtIpmgAa2TV/V6adfqu2VIpJQef4YXgyDX7s
         uFr4748SdW3T4junDNDlADrA22lxTytMNhkSWwVJC5TcZ7Wndb5A2KAoEaM79P1pn0R2
         g1oldOAnZbzKgWygeRV7vGVVhpEKkCeyptmi0b1QmA2SJwJt0GhystsvRHxHhTTsfyEL
         FBUA==
X-Gm-Message-State: ANoB5pmWlCSnE1rXq0uu/ZZ4ZFp2TxGkySH77pWdS1xGnJw49cDc4v6j
        PAprntbemm+tvurzfVXf8E2SEw==
X-Google-Smtp-Source: AA0mqf52OT5aMHWy12Kp09rQzNaWHG6VQv7zvokqwmjcWjtp7942E/1T21C+ydQ8dKtB57WirCl49w==
X-Received: by 2002:a5d:56d2:0:b0:236:cdf8:1e3f with SMTP id m18-20020a5d56d2000000b00236cdf81e3fmr7149354wrw.80.1669124593252;
        Tue, 22 Nov 2022 05:43:13 -0800 (PST)
Received: from localhost.localdomain (h082218028181.host.wavenet.at. [82.218.28.181])
        by smtp.gmail.com with ESMTPSA id p6-20020a1c5446000000b003b47e75b401sm21437729wmi.37.2022.11.22.05.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 05:43:12 -0800 (PST)
From:   =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     drbd-dev@lists.linbit.com, linux-kernel@vger.kernel.org,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        linux-block@vger.kernel.org,
        =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
Subject: [PATCH 2/4] lru_cache: remove compiled out code
Date:   Tue, 22 Nov 2022 14:42:59 +0100
Message-Id: <20221122134301.69258-3-christoph.boehmwalder@linbit.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221122134301.69258-1-christoph.boehmwalder@linbit.com>
References: <20221122134301.69258-1-christoph.boehmwalder@linbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
---
 lib/lru_cache.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/lib/lru_cache.c b/lib/lru_cache.c
index fec899386238..5dd5e4c00a23 100644
--- a/lib/lru_cache.c
+++ b/lib/lru_cache.c
@@ -60,17 +60,6 @@ int lc_try_lock(struct lru_cache *lc)
 	} while (unlikely (val == LC_PARANOIA));
 	/* Spin until no-one is inside a PARANOIA_ENTRY()/RETURN() section. */
 	return 0 == val;
-#if 0
-	/* Alternative approach, spin in case someone enters or leaves a
-	 * PARANOIA_ENTRY()/RETURN() section. */
-	unsigned long old, new, val;
-	do {
-		old = lc->flags & LC_PARANOIA;
-		new = old | LC_LOCKED;
-		val = cmpxchg(&lc->flags, old, new);
-	} while (unlikely (val == (old ^ LC_PARANOIA)));
-	return old == val;
-#endif
 }
 
 /**
-- 
2.38.1

