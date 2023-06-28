Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD6557410D4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 14:18:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbjF1MSU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 08:18:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjF1MSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 08:18:17 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C4F51BC3;
        Wed, 28 Jun 2023 05:18:16 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4fb7dc16ff0so3694058e87.2;
        Wed, 28 Jun 2023 05:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687954694; x=1690546694;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4FYIxAMkhkhiAjDiPN+KI7EBsu/xU4FGXFKUcyj7bx8=;
        b=FAdfpsuuwPtBqoIZEb1jLfLqbuc1jj3PzETRwPGNdTzsgFQ9fRpf08qU+QwLMi1Ia9
         ZHWbThZFG6j5GKkkFG2szDHhcseNgS62ZmR5lZuF04vmJdo40ubsfXOkg8hbqMCHQdWa
         GMnAPYcm3jO23oDxSY59hnhlNMk1FFu5dsnWZ8umoBeaZ+NbPCfRUyyD3FCnLzvFUw87
         UsU0b5mCW0VMuhgHLcyMJQdH6ShdR/B2uOG2OF1sBkKyuMhC3zurMkUT/EFOVf5WIWYE
         USBfFi6TkYQDIncrfH2f84H4t0fvZmjtep+hUZVmS3uEvYIyABrB6ePZx1JarEsZMVTX
         pLwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687954694; x=1690546694;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4FYIxAMkhkhiAjDiPN+KI7EBsu/xU4FGXFKUcyj7bx8=;
        b=Cuf2TDwzm0YKpJ8Ho9x7BOHBT8loLWntFk9YiWO2BtRyfm+MKFc1/XWOlkzuIasWWV
         ILA27fIhJ36XK1GGkk1EIU8uh3UB/vHk9/+ZfJ+1ex9RgGl5DzTISInmG+w1KTVb+EeN
         D2gPD+7VrIiI1gpsgrnZ4Ojl+sbeWGiMh6gSIz/Fr+oy4DvoNiPYDiWMPjOkQdTSjUgd
         Tv6rUMaRevoKwfFKMmW6YdbBBFZsDC8UF/Wdpg/suY6ZzeYyLcRaAkJDuf6nKFA8pfeU
         8UWErkmlHw0AOVATdOl71DYh/lF6/gYFGgtXT+9hmObwUNF5DEXNVV4MBPmiNwQrVG2Q
         ep1A==
X-Gm-Message-State: AC+VfDwKJJz3xUKi7eA71IlD8y8TYdTkJGbc6lPL4AEsxBhq4Cb+DtM1
        Vd9W7phFIM6qs+zNLSRm4mI=
X-Google-Smtp-Source: ACHHUZ7OXOQxRsAX0aD4U5RT8WOW8kqx2K3fjQ47nANcHQbcQoZbPLldxuOr9IJ+f8EpU3/bBSPrZw==
X-Received: by 2002:ac2:4f0f:0:b0:4fb:8c2a:d43f with SMTP id k15-20020ac24f0f000000b004fb8c2ad43fmr2809030lfr.7.1687954693971;
        Wed, 28 Jun 2023 05:18:13 -0700 (PDT)
Received: from oberon.zico.biz (77-85-190-39.ip.btc-net.bg. [77.85.190.39])
        by smtp.gmail.com with ESMTPSA id g11-20020a7bc4cb000000b003fbab76165asm2978672wmk.48.2023.06.28.05.18.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 05:18:13 -0700 (PDT)
From:   "Tzvetomir Stoyanov (VMware)" <tz.stoyanov@gmail.com>
To:     rostedt@goodmis.org
Cc:     mhiramat@kernel.org, dan.carpenter@linaro.org,
        linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] kernel/trace: Fix cleanup logic of enable_trace_eprobe
Date:   Wed, 28 Jun 2023 15:18:11 +0300
Message-ID: <20230628121811.338655-1-tz.stoyanov@gmail.com>
X-Mailer: git-send-email 2.41.0
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

The enable_trace_eprobe() function enables all event probes, attached
to given trace probe. If an error occurs in enabling one of the event
probes, all others should be roll backed. There is a bug in that roll
back logic - instead of all event probes, only the failed one is
disabled.

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Fixes: 7491e2c44278 ("tracing: Add a probe that attaches to trace events")
Signed-off-by: Tzvetomir Stoyanov (VMware) <tz.stoyanov@gmail.com>
---
 kernel/trace/trace_eprobe.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
index 67e854979d53..ba9a28bc773f 100644
--- a/kernel/trace/trace_eprobe.c
+++ b/kernel/trace/trace_eprobe.c
@@ -702,8 +702,12 @@ static int enable_trace_eprobe(struct trace_event_call *call,
 
 	if (ret) {
 		/* Failed to enable one of them. Roll back all */
-		if (enabled)
-			disable_eprobe(ep, file->tr);
+		if (enabled) {
+			list_for_each_entry(pos, trace_probe_probe_list(tp), list) {
+				ep = container_of(pos, struct trace_eprobe, tp);
+				disable_eprobe(ep, file->tr);
+			}
+		}
 		if (file)
 			trace_probe_remove_file(tp, file);
 		else
-- 
2.41.0

