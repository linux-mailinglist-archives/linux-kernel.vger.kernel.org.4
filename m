Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6E4D5F7E58
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 21:53:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbiJGTxv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 15:53:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiJGTxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 15:53:49 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F922108DDA;
        Fri,  7 Oct 2022 12:53:48 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id n40-20020a05600c3ba800b003b49aefc35fso3150758wms.5;
        Fri, 07 Oct 2022 12:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=z8rAF2O4yeCpXpnecitKEaHx4FvdtHm+sRpB2Z22bUo=;
        b=StHGyKvomVuKHeS4JcqqnrXu6vz7Gl8mGv7UkKkDtOsQAALjpB0Ib6Yti3tNPmwr2l
         YQahqqornyZQT6Vw7l+X8PPmRq963saK0sLOtLxPiw1rQI8emHl3NbCgOrgoXsPuwzqB
         5QeaDh5I8qzl0sm7IdXmkE5H7h4JOUDfo7WNYGHk1Tb/PSyUfBJIGItknYanTWduWI8s
         sHQbATmjMCy/CU5B9czznffV52+0Pk00Eu3Bq99TYLdgfY2B2Qyjrb4BnmNaZWKB6tp9
         0L2+VYb5LdXe+AeGgLuOqOWfm5mv/NZkgWb4KLJ7sdAR2m9fY/XRztwc5/8XuA7cBb+K
         T/MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z8rAF2O4yeCpXpnecitKEaHx4FvdtHm+sRpB2Z22bUo=;
        b=areIVKwa3Mfar0m6RoMLyUTnvAqHVbW/l1F73kKAFqwdKEdGilG93qL27LInh06IM8
         AeeE4FJzpEOF4vJaCFHGJjK+W5PWe29V0A+lU+1Xd6sw9XNyZ/xnv5erM86TTLWwV7MK
         i4Cow88Bq8H17XdOcJ7otmuN6ZWGQb0i0hnN6+cfmcvj7cboQdLW9opsBIgjvl+rwItC
         7yZNSKMyYwvBE3iEolX0tI87WX47iDPouuL/LWa/JmrHXyOKaYTrjHWZYFheGkD4TaQP
         pELf44PvgCTagaS0OZw4aF6WbWcB5Pae7tXuXL5e1zKvOpcTzmOTCkOlrFZwiY892j0j
         BIcg==
X-Gm-Message-State: ACrzQf0S/XYD0qkOpvWOEwwqvfqH6TdFassUmUeD7TulA73Ojh/jCcSv
        LcJJt9r/C+8shjG4YHxyR0U=
X-Google-Smtp-Source: AMsMyM7alIwgvl0Zu7M5vCk5X5x6zVQWzj6M6XZlvvnQJWIo43xPeL2gkcOIO8gVIElZyk8Sbqx4/g==
X-Received: by 2002:a05:600c:3d05:b0:3b4:9a42:10d0 with SMTP id bh5-20020a05600c3d0500b003b49a4210d0mr4488015wmb.135.1665172426779;
        Fri, 07 Oct 2022 12:53:46 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id l15-20020adfe58f000000b0022ac119fcc5sm2687448wrm.60.2022.10.07.12.53.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Oct 2022 12:53:46 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/i915/perf: remove redundant variable 'taken'
Date:   Fri,  7 Oct 2022 20:53:45 +0100
Message-Id: <20221007195345.2749911-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

The assignment to variable taken is redundant and so it can be
removed as well as the variable too.

Cleans up clang-scan build warnings:
warning: Although the value stored to 'taken' is used in the enclosing
expression, the value is never actually read from 'taken'
[deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/gpu/drm/i915/i915_perf.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_perf.c b/drivers/gpu/drm/i915/i915_perf.c
index 0defbb43ceea..15816df916c7 100644
--- a/drivers/gpu/drm/i915/i915_perf.c
+++ b/drivers/gpu/drm/i915/i915_perf.c
@@ -656,7 +656,6 @@ static int gen8_append_oa_reports(struct i915_perf_stream *stream,
 	size_t start_offset = *offset;
 	unsigned long flags;
 	u32 head, tail;
-	u32 taken;
 	int ret = 0;
 
 	if (drm_WARN_ON(&uncore->i915->drm, !stream->enabled))
@@ -692,7 +691,7 @@ static int gen8_append_oa_reports(struct i915_perf_stream *stream,
 
 
 	for (/* none */;
-	     (taken = OA_TAKEN(tail, head));
+	     OA_TAKEN(tail, head);
 	     head = (head + report_size) & mask) {
 		u8 *report = oa_buf_base + head;
 		u32 *report32 = (void *)report;
@@ -950,7 +949,6 @@ static int gen7_append_oa_reports(struct i915_perf_stream *stream,
 	size_t start_offset = *offset;
 	unsigned long flags;
 	u32 head, tail;
-	u32 taken;
 	int ret = 0;
 
 	if (drm_WARN_ON(&uncore->i915->drm, !stream->enabled))
@@ -984,7 +982,7 @@ static int gen7_append_oa_reports(struct i915_perf_stream *stream,
 
 
 	for (/* none */;
-	     (taken = OA_TAKEN(tail, head));
+	     OA_TAKEN(tail, head);
 	     head = (head + report_size) & mask) {
 		u8 *report = oa_buf_base + head;
 		u32 *report32 = (void *)report;
-- 
2.37.3

