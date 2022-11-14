Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15601627CE2
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 12:49:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236940AbiKNLtT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 06:49:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236807AbiKNLsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 06:48:45 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0FE926ACF
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 03:45:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 85743B80E73
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 11:45:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E18D3C433B5;
        Mon, 14 Nov 2022 11:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668426347;
        bh=Vp8sXRjsUE/N3VsCm0HTjAxgxp+yKdf3km9PrguLdDQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EFbgopP7Xnz3OCxeyZ9dcO7w77PdM+IjWJR+aVFwRb07CIksjaoVGfWRstf783N3H
         E9KmA6woJ2FGqfK90S6TJFAAg5qqUMfIZnpNnD41beNsjEwz7rSxXUrO/OrMHRPSV3
         kDGkTCXO58rfI0ilFhyev9a6eZAWQ4x6BDFE2vqHEpHf0eHS/AIvBpS/g2iCLWeQCw
         tuPzy3sFNcoiPdUxzbGfFS2cjgRdxlor4gHE27/K7pGeaQwOwKcjJnL6WF/8Y/rjRI
         BS2gkGyi1GVd1B+Xzolmhmm9kcReS83I2v/sHxf4/uIXfQZgFX5WQhRWeZYl4WEm3q
         I0gUgpxAvcQJw==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Martin Liska <mliska@suse.cz>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 45/46] kasan, lto: remove extra BUILD_BUG() in memory_is_poisoned
Date:   Mon, 14 Nov 2022 12:43:43 +0100
Message-Id: <20221114114344.18650-46-jirislaby@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221114114344.18650-1-jirislaby@kernel.org>
References: <20221114114344.18650-1-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Liska <mliska@suse.cz>

The function memory_is_poisoned() can handle any size which can be
propagated by LTO later on. So we can end up with a constant that is not
handled in the switch. Thus just break and call memory_is_poisoned_n()
which handles arbitrary size to avoid build errors with gcc LTO.

Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: Alexander Potapenko <glider@google.com>
Cc: Andrey Konovalov <andreyknvl@gmail.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: kasan-dev@googlegroups.com
Cc: linux-mm@kvack.org
Signed-off-by: Martin Liska <mliska@suse.cz>
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 mm/kasan/generic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
index d8b5590f9484..d261f83c6687 100644
--- a/mm/kasan/generic.c
+++ b/mm/kasan/generic.c
@@ -152,7 +152,7 @@ static __always_inline bool memory_is_poisoned(unsigned long addr, size_t size)
 		case 16:
 			return memory_is_poisoned_16(addr);
 		default:
-			BUILD_BUG();
+			break;
 		}
 	}
 
-- 
2.38.1

