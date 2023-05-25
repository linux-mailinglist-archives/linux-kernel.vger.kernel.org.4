Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 468207112BA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 19:44:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240709AbjEYRop (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 13:44:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235065AbjEYRok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 13:44:40 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D449FE47
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 10:44:05 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id ca18e2360f4ac-77493b3d18cso168155739f.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 10:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685036644; x=1687628644;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IF5KlPvZ3QkxhsNhcL5v5OvfHHuGbTugqg2l5EV6fIo=;
        b=JCRbn+P864KdKm8u2FM6ZbKkD5iM5qMtSvm4oIaSuhE6g6g3Lh/wAZ6M58YTvidbd8
         YtW3spNmcei+kA5NJWkRiTe30YvNTVfwlnfgmk1KQi9xVhPTj3iApXgvuUN9lTsBS5eM
         Z6cT5hYmtnLR73Hk1SKpZvcUToGSYFh7JuPKIR5igGUiMEWDsSiupAOcHT6BXfyOj6hH
         oB6L0xBImdFML8nGkUzItRVzdkZcW/iGX5CsXBTXeQ21RvrK1rHnV0KHRuz/qbln3c3m
         FFrguON5V+pOi8cwYFEdCd5Ew20xEErNsQEr34vE9ovNG98vkBbA4HyRw+OtTPoG4Nuc
         TYyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685036644; x=1687628644;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IF5KlPvZ3QkxhsNhcL5v5OvfHHuGbTugqg2l5EV6fIo=;
        b=i0Y6Gg0bEue8qtGhozhNwnwfGvwgYgwwf2UOL2A8xK1dObhPYIE2DdhcwlUKlwKFvA
         ZFC/FyjJLJJCkxGMdRpFd3j6BbePuzGkJbmAT/d8hyAX7Sh7d8usj7UO5gtOJba3/BCu
         vG6+mth7nKl38pTmGCKG2SJHq3G3OTT4jf/d3blFhYBGcYGl1j4dqI5mafnzxtGgtPev
         jr+rXArYEnPkrGph7uJni6dPr4Z5sWqpQVL82EO9VA6wlsxSpP6oAVZ9B8M8AKuuOBvE
         ZrDCOnzBzNY6yyrWbJyCk3ztVXD415UrundTowuHx0NHq7b0hZLs3UZ7sSj5xVMJTSos
         Wt4A==
X-Gm-Message-State: AC+VfDxNkttai/BpzX9W3cjALzynLpmkFEu4fJQ2W/PNAAyO/Hd41cC3
        hn7fzQL8DPeN85S+btS1yj36Og4/1Mw=
X-Google-Smtp-Source: ACHHUZ7u+kLo95OwKzX9gBTL/pAm1XcEf2dEI0/U0F1ZUzo/7us2ZHEBJSt/FRVCQrKOvYIrnffjHQ==
X-Received: by 2002:a6b:7214:0:b0:774:7cee:3803 with SMTP id n20-20020a6b7214000000b007747cee3803mr283107ioc.13.1685036644390;
        Thu, 25 May 2023 10:44:04 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id e38-20020a028629000000b004141e72be1asm547841jai.175.2023.05.25.10.44.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 10:44:04 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     catalin.marinas@arm.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH] kmemleak-test: drop __init to get better backtrace
Date:   Thu, 25 May 2023 11:43:56 -0600
Message-Id: <20230525174356.69711-1-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.40.1
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
  backtrace:
    [<00000000fabad728>] kmalloc_trace+0x26/0x90
    [<00000000ef738764>] 0xffffffffc02350a2
    [<00000000004e5795>] do_one_initcall+0x43/0x210
    [<00000000d768905e>] do_init_module+0x4a/0x210
    [<0000000087135ab5>] __do_sys_finit_module+0x93/0xf0
    [<000000004fcb1fa2>] do_syscall_64+0x34/0x80
    [<00000000c73c8d9d>] entry_SYSCALL_64_after_hwframe+0x46/0xb0

with __init gone, that trace entry renders like:

    [<00000000ef738764>] kmemleak_test_init+<offset>/<size>

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
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
2.40.1

