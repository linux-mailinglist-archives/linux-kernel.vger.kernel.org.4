Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F384B6EEA4F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 00:25:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236412AbjDYWZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 18:25:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236383AbjDYWZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 18:25:00 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F2931444E
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 15:24:59 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id e9e14a558f8ab-32b482bbc26so50603775ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 15:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682461498; x=1685053498;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TXOb1MmhlAoVWm22dO7Ned0kntNJ0+QdEkvlYiRO8xA=;
        b=RSolNWsDX05r6oRrt5+eJqmWdrVwAmNRi9zxyf653BaUcu+Zh+gZUpq+hE1wmXauy9
         0BufCSc7LVvut6niFuxMZH4XcR92id++1QaUSppYAndIdoDfhyXGCK1zJtSEgi/DjBDN
         I5LoRZEna6SzLRyfTrYjDvGuljaTEeGaYSZL/6yCnvBsZ9h9426h+rXIXm5UC+Ob4cdk
         vYXkM7jwJm5Q+1iZRfjqhNm1rPv/OvHwOiEXtscTLyzP3YRNJ9V1XrlxsEoXoI4tgp+7
         R/lUPIPBXMIUL7As62iCcoFHA4fakx+A917kIXClKosrPGCNlQzgbtKMFAirVmc3TMOo
         tRDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682461498; x=1685053498;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TXOb1MmhlAoVWm22dO7Ned0kntNJ0+QdEkvlYiRO8xA=;
        b=f0ks97wrrb32fWW6PFWlRN20MOJ0pGCWxowNI4ma4jHHF4jCbdEFHZitS9/sX94FlG
         3MgVaH5wwoj5FsPD3q0EutHlmKRvg2CVtATISCnu3pTPHGfS8Q8nVdKjplbcqcvaJcKh
         HtAdZ/Rnd5ZIr2PGc1K+aE5havLmkzcMYN/RGKzEfukmlPib7zUGnSCdzgP5lb/I1kTJ
         pcz72oVc4/z+jx9BXNBa6X5aVR0AaOrGR7AgUDYRDxI3Tz7vAOKjhsnH1EMEwzHglZN5
         eCj+LY76u18XpV9Hk/E8GNvM+1OtF1bTAyneFLT6Nf+K3AWA2JT75ITpAhG2SEuhuiaD
         aNFg==
X-Gm-Message-State: AAQBX9dRuRgm14LQ4FDE5KwEr6tNjuvxgkaX9n3UzFdeY54D/MPxMf50
        zWKA3AzaqrOrjkZyPVmasGQ=
X-Google-Smtp-Source: AKy350bNDxVaIAbb5KoO8K8L1Tr0hSOZa7eWM9p0+82r/RyyxUO8IyY1rAUQbZ4knS5NwuOaugKxXg==
X-Received: by 2002:a92:cf43:0:b0:325:b15b:88a3 with SMTP id c3-20020a92cf43000000b00325b15b88a3mr9277786ilr.13.1682461498466;
        Tue, 25 Apr 2023 15:24:58 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id 13-20020a92180d000000b003244d7f2292sm3833008ily.32.2023.04.25.15.24.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Apr 2023 15:24:57 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     catalin.marinas@arm.com, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 3/3] kmemleak-test: drop __init to get better backtrace
Date:   Tue, 25 Apr 2023 16:24:46 -0600
Message-Id: <20230425222446.170486-4-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230425222446.170486-1-jim.cromie@gmail.com>
References: <20230425222446.170486-1-jim.cromie@gmail.com>
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

Drop the __init on kmemleak_test_init().  With it, the storage is
reclaimed, but then the symbol isn't available for "%pS" rendering,
and the backtrace gets a bare pointer where the actual leak happened.

unreferenced object 0xffff88800a2b0800 (size 1024):
  comm "modprobe", pid 413, jiffies 4294953430
  hex dump (first 32 bytes):
    73 02 00 00 75 01 00 68 02 00 00 01 00 00 00 04  s...u..h........
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (ck 603070071):
    [<00000000fabad728>] kmalloc_trace+0x26/0x90
    [<00000000ef738764>] 0xffffffffc02350a2
    [<00000000004e5795>] do_one_initcall+0x43/0x210
    [<00000000d768905e>] do_init_module+0x4a/0x210
    [<0000000087135ab5>] __do_sys_finit_module+0x93/0xf0
    [<000000004fcb1fa2>] do_syscall_64+0x34/0x80
    [<00000000c73c8d9d>] entry_SYSCALL_64_after_hwframe+0x46/0xb0

with __init gone, that trace entry renders like:

    [<00000000ef738764>] kmemleak_test_init+<offset>/<size>
---
 samples/kmemleak/kmemleak-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/samples/kmemleak/kmemleak-test.c b/samples/kmemleak/kmemleak-test.c
index 7b476eb8285f..6ced5ddd99d4 100644
--- a/samples/kmemleak/kmemleak-test.c
+++ b/samples/kmemleak/kmemleak-test.c
@@ -32,7 +32,7 @@ static DEFINE_PER_CPU(void *, kmemleak_test_pointer);
  * Some very simple testing. This function needs to be extended for
  * proper testing.
  */
-static int __init kmemleak_test_init(void)
+static int kmemleak_test_init(void)
 {
 	struct test_node *elem;
 	int i;
-- 
2.40.0

