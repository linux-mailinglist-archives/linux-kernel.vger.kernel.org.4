Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68E546EEA4E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 00:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236402AbjDYWZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 18:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236370AbjDYWY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 18:24:59 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 135555FF1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 15:24:59 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id e9e14a558f8ab-32933a4af12so53202195ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 15:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682461497; x=1685053497;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jG/BDMHjgp3Q/HYzobpU+Hf19DrO0mL4F7UMWoWu2Oo=;
        b=XHPOtqYEtkGUjozmoPSo3Xc/K1hM/UIrcAJOhoUdMcmRih9e+CrQwSBdyz5+uk4giS
         PhZMhIyQxVcFDe44aZHvMwhdltHKrHat0LnNOiy/J3OuH8SiXpd43EW0v3znmK4uGpgY
         CnXKLLTkJMbqErUqw6G2/LuUYABi3l/yz0Vs252PE6PKlUdxWq038717JEpZfZxbM+/R
         yMvneeIJ6mTETaffHRt6/ysgwNkFM0BNxagFZWFLxBye/2Dy5/TUmBBX0bb+rQ8Mnz0g
         O37rQ1jE+ei/S9K1Jtt40XTa0vUtQAbCcRxWyxxGy7urxLt51SH4X0+3FHiKqW0JDTtj
         /ZHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682461497; x=1685053497;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jG/BDMHjgp3Q/HYzobpU+Hf19DrO0mL4F7UMWoWu2Oo=;
        b=loclrCmkfLWTvb48f918meFSElZpE4dNTtZ2pIqxngcqI5OG/hQ/mKyrNj67Utk+nr
         ifg+4HlxiyBLaBm0hdGv2hEUwEt5JUwCiyYP2Y6dvY7f4Rw477IG52RLB89St68BvOM/
         vzUDO7gnQxqNaai9YKsAQNDKc/gsBJiaZ7lbS1MpbZSpLY1YUlMozCEkfJj/O3z1g5hW
         J+NkgETHVlR4adhtkPxQ2wDWDJu/6EgetVtQmQwLtiJUlvPzorjlUXm1sjWkMHZH03wm
         dnpYFX8Zp23UfbEdTKJTmHZaleCnZAeGHKBKzhWop4oEa3mQdI77iZkesWQqn3vStjdM
         tlYw==
X-Gm-Message-State: AAQBX9dUXXYMFZ36xfy3DNgkMKOWCO/Pbv8mizmd49pgzapJ6B4npoZX
        TRWkSyoCDrNeMSW5mm7bgfI=
X-Google-Smtp-Source: AKy350Zg9B4rDTGuFbqRnS/vnyxu8oWDs4MPw2HnEPWD50fEQ1lkrUGykTcNnYVhQ7niOp+1DbpuXA==
X-Received: by 2002:a92:d986:0:b0:32b:399a:afa0 with SMTP id r6-20020a92d986000000b0032b399aafa0mr9245504iln.31.1682461497534;
        Tue, 25 Apr 2023 15:24:57 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id 13-20020a92180d000000b003244d7f2292sm3833008ily.32.2023.04.25.15.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Apr 2023 15:24:56 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     catalin.marinas@arm.com, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 2/3] kmemleak: add checksum to backtrace report
Date:   Tue, 25 Apr 2023 16:24:45 -0600
Message-Id: <20230425222446.170486-3-jim.cromie@gmail.com>
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

change kmemleak report format:

from: "  backtrace:"
to:   "  backtrace (ck <cksum>):"

The <cksum> allows a user to see recurring backtraces without
detailed/careful reading of multiline backtraces.  So after cycling
kmemleak-test a few times, I know some leaks are repeating.

  bash-5.2# grep backtrace /sys/kernel/debug/kmemleak | wc
     62     186    1792
  bash-5.2# grep backtrace /sys/kernel/debug/kmemleak | sort -u | wc
     37     111    1067

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 mm/kmemleak.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index f025c7bc845b..2d1dfed4293d 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -362,7 +362,7 @@ static void print_unreferenced(struct seq_file *seq,
 	warn_or_seq_printf(seq, "  comm \"%s\", pid %d, jiffies %lu\n",
 			   object->comm, object->pid, object->jiffies);
 	hex_dump_object(seq, object);
-	warn_or_seq_printf(seq, "  backtrace:\n");
+	warn_or_seq_printf(seq, "  backtrace (ck %u):\n", object->checksum);
 
 	for (i = 0; i < nr_entries; i++) {
 		void *ptr = (void *)entries[i];
-- 
2.40.0

