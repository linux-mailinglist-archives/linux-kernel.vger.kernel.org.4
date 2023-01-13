Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3162266A35B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 20:32:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230500AbjAMTcU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 14:32:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbjAMTaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 14:30:52 -0500
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2063287F24
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 11:30:52 -0800 (PST)
Received: by mail-il1-x135.google.com with SMTP id u8so11259341ilg.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 11:30:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+F9kl44jma+M7h1pP8h2A8ZnugnYlmyHf4a+VRYvO4M=;
        b=nFsCAxBqzc8DAkq7Y0KR8/rtL94U2RDxMfUQBOss23pmYoJOp7id0p4gkP3JNRidrJ
         t9i08P+3SiU8MspP5AFQVH3ZNwImZO+f4rGsZBF6YGkyhk9IlaXq6aE7D4aTOdoOmpz8
         aAO+uzg+XjIcaGOLdEBy7s3XAI24dXhJb0FC/T3jr2K7Xa4EhCPhXsSwC4MzFSL3LLBT
         olAbPIIL2DzDALUCW5asOYZP0JE7apBNs+hciXcYwtxkpgl3oJa2kjSm5FHnWp9IZoS1
         OZGqDReT1Wh/D56NQ8dbol0ZsMm6XTl1nRNRGFpMc0YLoyxKs3kMttcI5CYcPP6U7VwV
         c9Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+F9kl44jma+M7h1pP8h2A8ZnugnYlmyHf4a+VRYvO4M=;
        b=ePgUXtSCheE4X9qGipQtF+0tUlUiYJQ31srNPyoTYhcRRhFPOIaiNt7bytJ3kE6f3x
         olaY5Czbu2lgoSZ/mJOIvhtGNbpqLzGzCGapQ9sOC4TeSUEMcCCG+8U7TTGortDbqvVN
         e/f20uBhNlXME9crNhRq12e2SQh6DJyi+V0JmqRryBsuKCCnCvZghqqZW27cZU8MzDss
         RP2Ep/ZYnXuBKx8NtnrDvMElFakSvuTfR+4Ju5/grLpn88aZ6ir92eTC+1Yziw3nslMy
         IVaKUga1rOiislZDGxm3ONvFddn3KXzaEdVMyJw9KCzeU+wMOXr6CYUZrHwf1953HYmB
         lXpQ==
X-Gm-Message-State: AFqh2kpUCvvvlobLrJY8Bs4CaVmayIhAPkmr6frF5MmGuKD/Q+sG3UZs
        YuOC+2v5ooEfce9pIf3t5CVY65cmPSRA+w==
X-Google-Smtp-Source: AMrXdXsdczYM5PwWfO4hwAbHHjf0U0cvqxRknpww2NlHevVo41RRx9YbsfFXEX5Txlr07b+gR8gCVQ==
X-Received: by 2002:a92:ac06:0:b0:30c:2ed2:f8c4 with SMTP id r6-20020a92ac06000000b0030c2ed2f8c4mr32991854ilh.2.1673638251495;
        Fri, 13 Jan 2023 11:30:51 -0800 (PST)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id e32-20020a026d60000000b0039e583abceasm6497289jaf.68.2023.01.13.11.30.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 11:30:51 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     jani.nikula@intel.com, ville.syrjala@linux.intel.com,
        daniel.vetter@ffwll.ch, seanpaul@chromium.org, robdclark@gmail.com,
        jbaron@akamai.com, gregkh@linuxfoundation.org,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v2 09/20] dyndbg: constify ddebug_apply_class_bitmap args
Date:   Fri, 13 Jan 2023 12:30:05 -0700
Message-Id: <20230113193016.749791-10-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230113193016.749791-1-jim.cromie@gmail.com>
References: <20230113193016.749791-1-jim.cromie@gmail.com>
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

ddebug_apply_class_bitmap() does not alter its 2 bitmap args, make
this guarantee in the interface.

NOTE: the bitmap is also available in the dcp arg, but the 2 vars
serve a 2nd purpose; the CLASS_TYPE callers use them to translate
levels into their underlying disjoint representation.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 10c29bc19901..b51f4bde6198 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -592,7 +592,7 @@ static int ddebug_exec_queries(char *query, const char *modname)
 
 /* apply a new bitmap to the sys-knob's current bit-state */
 static int ddebug_apply_class_bitmap(const struct ddebug_class_param *dcp,
-				     unsigned long *new_bits, unsigned long *old_bits,
+				     const unsigned long *new_bits, const unsigned long *old_bits,
 				     const char *query_modname)
 {
 #define QUERY_SIZE 128
-- 
2.39.0

