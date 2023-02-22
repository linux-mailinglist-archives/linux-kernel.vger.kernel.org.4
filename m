Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E48169F201
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 10:42:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbjBVJmA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 04:42:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232221AbjBVJlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 04:41:39 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54C7438B61
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 01:38:41 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id d1-20020a17090a3b0100b00229ca6a4636so8257472pjc.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 01:38:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wTFoYDHyDNw2PubV9IEzg7rOSljDE2ce7yhJPe+zOrE=;
        b=i+tTMlzh1EU79Pqqv2bPjoY1DWvpU3lBwHjaX+1HgszI7jIpoZnz+as19+HqI6Ssd/
         00MJ9FL2+u3dNkbe2baGzgMfTvpVqSKf/zYSdJzf8j/8voNpzJhM7GJEOevub/dqPxCS
         OS2cr1b51EMu5vf48JwuobZ9+99kl/DpgvTWytEuYDBvLjItW88YgtroWDAsNmYeBRPf
         j4ON1KBdAP1eN+J5I4ha5Szl8yoSVNufa5DLIQHLsdNb4Q3BMZK216AZJ3WLk/sF47zl
         xeKPyHL8zOYjmRFLif58eIh/ctkmIMkFP7W/SOq+WexKkBlxeXrk1p4Nwcp/jKuzv1Gu
         WSSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wTFoYDHyDNw2PubV9IEzg7rOSljDE2ce7yhJPe+zOrE=;
        b=Dnxmlk6MvV4lkLeg0zd3thquBBR+DKiMqLphz+TiJvo0A0BpRxl+4d3JOwQ8F1fmzV
         hZtfDpAh7wia1Hve86M6aaP/H665Xnk2ycLojqp8NYD9saZqX8aWYHwzSTyPtb7eSDex
         m+bH/qJp90m69X1zyt7hDYmEwdkI/ZAYSbR4DA/iluF9B9iK21nnhEQEanHgypDxEggX
         K4jE4VnoFWX1nDL+2HxH3MykjX8wCcPoWpR8+BBX2x/t9d/F0RH54L7VUfLAer4L+jbA
         BxuEz5y6YEl+gw6nE+ovadPvErZR1nsLST0Dmi3qiLGBjHSvnTv7UJrsoJax8hGdeD20
         wTGA==
X-Gm-Message-State: AO0yUKXGNe8dI7rXSZXF8L8ACqwyGsAuKNc+vDsF09wsF+fxodCyB/FA
        azQyHlN82ppvXtR6CrT2Fhc=
X-Google-Smtp-Source: AK7set/zea5eRmdKsCVVfCdtE5UNQ45wvZCr5NCgSAoah754/nDo4qVpKKDH2zCTrjRQ8peV8gD0oQ==
X-Received: by 2002:a17:902:e883:b0:19a:a810:542 with SMTP id w3-20020a170902e88300b0019aa8100542mr8932659plg.61.1677058657889;
        Wed, 22 Feb 2023 01:37:37 -0800 (PST)
Received: from localhost.localdomain ([221.226.144.218])
        by smtp.gmail.com with ESMTPSA id h6-20020a170902eec600b0017a032d7ae4sm2392324plb.104.2023.02.22.01.37.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 01:37:37 -0800 (PST)
From:   Song Shuai <suagrfillet@gmail.com>
To:     jan.kiszka@siemens.com, kbingham@kernel.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Song Shuai <suagrfillet@gmail.com>
Subject: [PATCH RESEND] scripts/gdb: add lx_current support for riscv
Date:   Wed, 22 Feb 2023 17:37:30 +0800
Message-Id: <20230222093730.1826523-1-suagrfillet@gmail.com>
X-Mailer: git-send-email 2.20.1
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

RISC-V uses the tp register to save the current task_struct address
as its current() defines. So lx_current() of riscv just returns the
dereference of the address cast via task_ptr_type.

Signed-off-by: Song Shuai <suagrfillet@gmail.com>
---
 scripts/gdb/linux/cpus.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/scripts/gdb/linux/cpus.py b/scripts/gdb/linux/cpus.py
index 15fc4626d236..6825a9834394 100644
--- a/scripts/gdb/linux/cpus.py
+++ b/scripts/gdb/linux/cpus.py
@@ -173,6 +173,9 @@ def get_current_task(cpu):
          else:
              raise gdb.GdbError("Sorry, obtaining the current task is not allowed "
                                 "while running in userspace(EL0)")
+    elif utils.is_target_arch("riscv"):
+         current_task_addr = gdb.parse_and_eval("$tp")
+         return current_task_addr.cast(task_ptr_type).dereference()
     else:
         raise gdb.GdbError("Sorry, obtaining the current task is not yet "
                            "supported with this arch")
-- 
2.20.1

