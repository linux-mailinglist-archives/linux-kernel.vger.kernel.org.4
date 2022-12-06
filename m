Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24FB1643A3A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 01:36:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232266AbiLFAgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 19:36:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233171AbiLFAgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 19:36:00 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E93A1EC61
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 16:35:18 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id d123so3305909iof.6
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 16:35:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6+UDrWNXMMGhk9HzOMZBwbh5zjmulDfm2DaVnY/OUhI=;
        b=eLeE2dj14exQeQIr1ko9hCDJKvzZBxL31dknUIIIFaYlxA20UJuCHiOsbgVMQoo33m
         2qhDf9Fm5NpvMorwLHW2iBCbaXEhs0Ck79a3jMQjJmVaDNi4k9/rhuIC3/1Gyvv0GbR+
         yKtYcRWC+dnl+PUbTvH1i7/GSpRDrUAGqM4zlpfzTJeAvZ4iqQmZ+sVffIQCD0emjCs5
         5jm7Evqqm3oba1alb0augbhYBWWBxnrTQhdwTAknsh9m5ifR2ccK3kKdNe2ZYDfzsEMf
         OIoI0aUK+FFtI09eRSWSEtHRzDt3Cgyic2eQc+OWFGf93/+6XibjSm98FxmBkViMUuO4
         H9AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6+UDrWNXMMGhk9HzOMZBwbh5zjmulDfm2DaVnY/OUhI=;
        b=eG4T9hG6wQZLj1uev8B91btrhxj22tGirHYZGWarFIMY7/w/rDQ3bi4e48uZm5RMrC
         YnvuLy9ypItPDZ4sPrSZI50RmzW8LZaTagSUdUYTTx6iEBZpXenbO3r7L16Hi1WkMskR
         5mNjjyhNxkzqAMmSR6etQ44wW+c/2WzMkPuOyuHc7N/LR7XQvh8Dm6t6ITq35iNrVwZx
         l2I93Gro/SQfT8RPQlv8U9OTO4UWMU8xXQJzLwbB2uHm7rRY60iGLiaD6CFgZJbdTx5G
         2a5ACo3lLmUSv0jY9ytAQ8So87VT/03kt4rpzQanjLbBT/O5tvqIzLB/AD0Pbsv8RGDB
         9Uyw==
X-Gm-Message-State: ANoB5pmNPa83o2NiA6zHzzecGeD9MgOCMoC/4yctVnRxQEFsXsIa+j73
        sGfKtKQq24LWokR1h3SqAw8cGtFWUy8GBQ==
X-Google-Smtp-Source: AA0mqf7S5bHLlbhVAzPpHg9sCL9n3qLeloz+E671RFH4nKtb1ybTIO5QlE+Jm2CCx5RS1oF/exUDcw==
X-Received: by 2002:a02:23ca:0:b0:372:59cb:f242 with SMTP id u193-20020a0223ca000000b0037259cbf242mr39977560jau.135.1670286917295;
        Mon, 05 Dec 2022 16:35:17 -0800 (PST)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id x3-20020a056602160300b006bba42f7822sm6408213iow.52.2022.12.05.16.35.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 16:35:16 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     jani.nikula@intel.com, ville.syrjala@linux.intel.com,
        daniel.vetter@ffwll.ch, seanpaul@chromium.org, robdclark@gmail.com,
        jbaron@akamai.com, gregkh@linuxfoundation.org,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [RFC PATCH 17/17] dyndbg: miss-on HACK
Date:   Mon,  5 Dec 2022 17:34:24 -0700
Message-Id: <20221206003424.592078-18-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221206003424.592078-1-jim.cromie@gmail.com>
References: <20221206003424.592078-1-jim.cromie@gmail.com>
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

dont break the loop, to see multiple clients.  the 3 client records
are differently wrong.
---
 lib/dynamic_debug.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 3ef1c0a1f0cd..a26eaa348731 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -629,6 +629,7 @@ static int ddebug_apply_class_bitmap(const struct ddebug_class_param *dcp,
 		v2pr_info("bit_%d: %d matches on class: %s -> 0x%lx\n", bi,
 			  ct, map->class_names[bi], *new_bits);
 	}
+	v2pr_info("applied bitmap: 0x%lx to: 0x%lx\n", *new_bits, *old_bits);
 	return matches;
 }
 
@@ -1321,8 +1322,8 @@ static void ddebug_attach_client_module_classes(struct ddebug_table *dt, struct
 			 */
 			v2pr_info("break on %d/%d\n", i, di->num_class_refs);
 			dt->num_class_refs = 1;
-			break;
-		}
+		} else
+			v2pr_info("miss on %d/%d\n", i, di->num_class_refs);
 	}
 }
 
-- 
2.38.1

