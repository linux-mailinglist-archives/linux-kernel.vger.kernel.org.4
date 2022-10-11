Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CADEE5FAABC
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 04:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbiJKCsl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 22:48:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiJKCsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 22:48:38 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCD218304A
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 19:48:37 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id 67so12273545pfz.12
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 19:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=g5ZAeOU29ASuLEzMkvQnKWfVg4sMd2t7fUMu1orwx8o=;
        b=LV39s2kxcJjEcL7z4uZu7vYeNHwwfikFHBtGULtOgM1giuAWLkYFCqKtrZdv5y/AZb
         09Mxd9ysVB4B6Dnzch1o5mZedcB9ElOo+GqHFctnqjtnQfGjfLxFv5+cwudB84PRL0Cs
         FEeaaxNB4Ivnx3Wa6tp/Sl4pQYNglkZ3js7iTE+LxFPQDbVkwj7CxJEw2RBIQvuDKVMA
         O4AylRm0Ev5tOVAUVVOm+OxYj9f9GE7yFBu8GDhD9HZxaS2/j5H/2rJZ2nEVqo1lxOdu
         mfyKkouSmXZfCGJe/mIGAyMURtdBbbWKKjgVcG694yXSL5+ZvyHwghtKSpXb6Bb5kieo
         w3Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g5ZAeOU29ASuLEzMkvQnKWfVg4sMd2t7fUMu1orwx8o=;
        b=nvvEEwsm5DZwL9DaK4k0ug+MxaztFliubLZNG3wpbo4DwvXpLKYymLzDMczi6abyxq
         ryi9IEhFaBz1uLPB43Oph0LG5u4it5C+0+Au0RTqlhcyimTa4PZ4cpImxT0kaVuaxvUa
         qIfApX6keUjfKuxMXsMJ5SYoGDp5xBFNpKZfB0auiOvlHgtJzf5XJudlLAQCe9vtArgW
         r1inb7vm79lNzDZ7tqijW16m1kg1RKXc7RAGrTP0t26lv1lAvcfr+COtAOi0+6+idyAe
         OJynYXVPLdDJNLQJaXz6yPIOJwmSklIuTtKMdVEVZDDXT4ul10irVnujzDB90XixFxCP
         dpRg==
X-Gm-Message-State: ACrzQf3S7coRx5NQMSazNBnQ3akMK3QkeLiJmoRaHynS1eSJOs02pzit
        FveaE6GBm1DsJIJ531lKLvc=
X-Google-Smtp-Source: AMsMyM5VybewswCAhrhvGHPpuPAc3Sg9ew6RZYQZUnPVOhf0TnQVodqqJ+4faDPwol/QwSADcggr9A==
X-Received: by 2002:a63:5519:0:b0:457:dced:8ba1 with SMTP id j25-20020a635519000000b00457dced8ba1mr18901984pgb.163.1665456517177;
        Mon, 10 Oct 2022 19:48:37 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id j5-20020a170902c3c500b0017c3776634dsm7407169plj.32.2022.10.10.19.48.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 19:48:36 -0700 (PDT)
From:   yexingchen116@gmail.com
X-Google-Original-From: ye.xingchen@zte.com.cn
To:     pmladek@suse.com
Cc:     rostedt@goodmis.org, senozhatsky@chromium.org,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        linux-kernel@vger.kernel.org, ye xingchen <ye.xingchen@zte.com.cn>
Subject: [PATCH linux-next] vsprintf: replace in_irq() with in_hardirq()
Date:   Tue, 11 Oct 2022 02:48:31 +0000
Message-Id: <20221011024831.322799-1-ye.xingchen@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ye xingchen <ye.xingchen@zte.com.cn>

Replace the obsolete and ambiguos macro in_irq() with new
macro in_hardirq().

Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 lib/vsprintf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 24f37bab8bc1..5b0611c00956 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -866,7 +866,7 @@ char *restricted_pointer(char *buf, char *end, const void *ptr,
 		 * kptr_restrict==1 cannot be used in IRQ context
 		 * because its test for CAP_SYSLOG would be meaningless.
 		 */
-		if (in_irq() || in_serving_softirq() || in_nmi()) {
+		if (in_hardirq() || in_serving_softirq() || in_nmi()) {
 			if (spec.field_width == -1)
 				spec.field_width = 2 * sizeof(ptr);
 			return error_string(buf, end, "pK-error", spec);
-- 
2.25.1

