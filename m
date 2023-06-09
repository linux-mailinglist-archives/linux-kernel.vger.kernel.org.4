Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1764072A6D1
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 01:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbjFIXoz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 19:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjFIXot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 19:44:49 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C94973583
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 16:44:48 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5618857518dso32602637b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 16:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686354288; x=1688946288;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Vquh/FHEiTi4dfmwC93Zb1HN75IHvU0zO7o9cBuEMsA=;
        b=FCP0fOyzN9/3Ga8MAUupyeO/SBcmgO+H3658UtCYXVKdPWWl8DD5eqYsRehY2WKGf+
         AXBmBbUYWO2XvyYtM366DaHsG8JhaRe7LePLo3G06uvsAXLvJ0tUm+IWfyoNxin/VZ/X
         w6/1984Hd54rpFawN2H6XGIYUwMA38ZElwNNKPqd5hxVlqLajaHoK4xewnINgAySx/wY
         mP4GqdGEzRTqqrLK64yKC0vJwG6iLnLd3TJQhzKumTuSg5SWnFo7YDVmJDRN1anzpfzK
         8NYiQQiz5PCqhobM1uRPdg+gdm54Q1fnuOsqNRieBNINyoaZ23N1tcsff1MxS9XaETCk
         p5Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686354288; x=1688946288;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Vquh/FHEiTi4dfmwC93Zb1HN75IHvU0zO7o9cBuEMsA=;
        b=aZj06bECPR++pKRgrq9j92ev6+HpPkKdXkU60y58Vx/pFrjZocn+4V8d/d7TukWaqb
         9B6nAoksrJoeYb4myfekgRs/XJsjuYG/vE6LSJYZYHzf9Xox3HIgs9YWlmOX8ibnutYn
         ll5sNW6cd6N06loc7Nt38va2+7zoQBmUxqxqnKYONfkuhAxJps7UfCk+cTReqBqgPXvc
         b8hPe5zyHbwLeMtIPblff9QcDEAY7EwA30XFIv70dnonCY+zCuReJyRwmj+PjFRBIQTB
         yH19U/2MrJR4hwI7XeSjf3mxh1QTnHMcZhWDWcLR/P/1H6kt6Ahnni2ZAGOftZ+V5EdR
         naHQ==
X-Gm-Message-State: AC+VfDxJ3GlsWemdSNSN2Uz9eGBxZd8ov3WO5V38WmTrj2WVyh1evtXB
        dvE0KhvdsKveeLk3xMLaWyUPhFYsGlLHdcNc6V8=
X-Google-Smtp-Source: ACHHUZ5pDeP3eqZoDjQhSM9IDzK2EOAvUdHuzW7pPGye9KkHXA+NIDnSXfQQMQTdo2fACqri4pujW9SgulIHDBOG1d4=
X-Received: from ndesaulniers-desktop.svl.corp.google.com ([2620:15c:2d1:203:1bbc:33a1:472f:b279])
 (user=ndesaulniers job=sendgmr) by 2002:a81:ef0a:0:b0:56c:e0c5:de88 with SMTP
 id o10-20020a81ef0a000000b0056ce0c5de88mr507827ywm.1.1686354288039; Fri, 09
 Jun 2023 16:44:48 -0700 (PDT)
Date:   Fri, 09 Jun 2023 16:44:45 -0700
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAGy5g2QC/x2NQQrCQBAEvxLm7MKYFTV+RTzMxjY7iGuYUQmE/
 D0bj0V10TM5TOF0aWYy/NT1XSrsdw31WcqAoPfK1HIb+chdeObvgFGq4A4SD5zi6Qyq+ySOkEx Kn7fiJf6BbWI0PHT6n1xvy7IC0ZCYtnQAAAA=
X-Developer-Key: i=ndesaulniers@google.com; a=ed25519; pk=UIrHvErwpgNbhCkRZAYSX0CFd/XFEwqX3D0xqtqjNug=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1686354286; l=960;
 i=ndesaulniers@google.com; s=20220923; h=from:subject:message-id;
 bh=jjBejqM3KHdCEAqZe3eEIdjesYfxVlFu8f+bbwqWVDI=; b=6LwADhRYgxCHpTWgXm6Vbi4BQlrA1hf/HNYYJW3SMkt3KXdweCywwNx5/pdRD/qfEksCXWAAT
 G5iOr9EpETGAv/i6LNd+BY7ZrE9IrbFBKWN19Q46iqvYeTEpOpzOY1f
X-Mailer: b4 0.12.0
Message-ID: <20230609-khugepage-v1-1-dad4e8382298@google.com>
Subject: [PATCH] mm/khugepaged: use DEFINE_READ_MOSTLY_HASHTABLE macro
From:   ndesaulniers@google.com
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These are equivalent, but DEFINE_READ_MOSTLY_HASHTABLE exists to define
a hashtable in the .data..read_mostly section.

Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 mm/khugepaged.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 6b9d39d65b73..e7dc49214413 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -88,7 +88,7 @@ static unsigned int khugepaged_max_ptes_swap __read_mostly;
 static unsigned int khugepaged_max_ptes_shared __read_mostly;
 
 #define MM_SLOTS_HASH_BITS 10
-static __read_mostly DEFINE_HASHTABLE(mm_slots_hash, MM_SLOTS_HASH_BITS);
+static DEFINE_READ_MOSTLY_HASHTABLE(mm_slots_hash, MM_SLOTS_HASH_BITS);
 
 static struct kmem_cache *mm_slot_cache __read_mostly;
 

---
base-commit: 64569520920a3ca5d456ddd9f4f95fc6ea9b8b45
change-id: 20230609-khugepage-09ea340b378e

Best regards,
-- 
Nick Desaulniers <ndesaulniers@google.com>

