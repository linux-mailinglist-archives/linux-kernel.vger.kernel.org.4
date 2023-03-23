Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2954D6C7362
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 23:53:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231153AbjCWWxb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 18:53:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231218AbjCWWxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 18:53:10 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50B052724
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 15:52:56 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id o44so576257qvo.4
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 15:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679611972;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GCZYT2cNLzni/MmHCTcd86AI98olp+OkXmyLjl/vs3k=;
        b=S9UAeHXPPmCRszZhwiLqXJ2cCymcsBe99XMAVaxvVjteVMhlPZiLcnuMx6PFjKkHEy
         Tc2Ef3C31XbOZSPPwDwlDWdsXhxgZHAzQLczUxIPPq41Hx/Aoum/VQHVRHGWLMwYzPvn
         uBAf4xSSWbeukbGfJqwa7XwVW6aOM0kEvqoB6is7bAO5PHuZTBkwoy/NBc91hg83/I5K
         Irwr9y2YzvH6Ma/1KV+96V/9r3esTo+YOzIxbDK1pt1yBhAt5VYGrBYfJmJuSqRclk5t
         F60paXFnuYpGlQAqojcD1RrcGLnNJ6JVWIuQuPb6HkR0Z5ZcNarOibcUXTlayBZecQuN
         NtBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679611972;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GCZYT2cNLzni/MmHCTcd86AI98olp+OkXmyLjl/vs3k=;
        b=SachCx3TEcoeXpyrI3PdGjCpcX14Ix4ICF3k66Wfi3Dih+yQYnlNgK7hB/I/lbrJpL
         CQYGp+maAT5eRmCHFgoEYoibCgXrvnyQsBAAHGuuYrAFN9D/Y9ttbc8uQhYdem+I2zG2
         /XMeNA9zKBcFmCVt1/QSAsS9MNz57HhnINi+7bSj2YFsjUvHKtt9sg0ZvLyKy/hyZHBx
         ObqzV/lROwBRl0yFBCF44CXMZZlThzI2gC6kwVHgar4MzB6SdZg4d5lXVMG6eBOI0Ysr
         x87oY/Ml2GMWvBNKbcgLmW66AoKMV615MgkriYa8qzAqb+DivVZMBDD4MTE8+rrep1Qb
         N2yg==
X-Gm-Message-State: AAQBX9cwBBBGJpIIQPDDLQ38XNfWFB801D90vSQtT6+xuJrguuo1WbK0
        JdZ0fUcoCi0FLcv0/uKxNJHaHVairDc=
X-Google-Smtp-Source: AKy350abDKi+nWG3HCvouGE4Qe2gaxuM22In94XRtyDqGRU9eTfwsAt/b+BYVgxzb4eYksZYo1o+VA==
X-Received: by 2002:a05:6214:2aa6:b0:5c5:1a25:edf0 with SMTP id js6-20020a0562142aa600b005c51a25edf0mr722529qvb.26.1679611972315;
        Thu, 23 Mar 2023 15:52:52 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id ne19-20020a056214425300b005dd8b9345a1sm213384qvb.57.2023.03.23.15.52.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 15:52:51 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Kieran Bingham <kbingham@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Leonard Crestez <leonard.crestez@nxp.com>
Subject: [PATCH] scripts/gdb: Bail early if there are no clocks
Date:   Thu, 23 Mar 2023 15:52:45 -0700
Message-Id: <20230323225246.3302977-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid generating an exception if there are no clocks registered:

(gdb) lx-clk-summary
                                 enable  prepare  protect
   clock                          count    count    count        rate
------------------------------------------------------------------------
Python Exception <class 'gdb.error'>: No symbol "clk_root_list" in
current context.
Error occurred in Python: No symbol "clk_root_list" in current context.

Fixes: d1e9710b63d8 ("scripts/gdb: initial clk support: lx-clk-summary")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 scripts/gdb/linux/clk.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/scripts/gdb/linux/clk.py b/scripts/gdb/linux/clk.py
index 061aecfa294e..7a01fdc3e844 100644
--- a/scripts/gdb/linux/clk.py
+++ b/scripts/gdb/linux/clk.py
@@ -41,6 +41,8 @@ are cached and potentially out of date"""
             self.show_subtree(child, level + 1)
 
     def invoke(self, arg, from_tty):
+        if utils.gdb_eval_or_none("clk_root_list") is None:
+            raise gdb.GdbError("No clocks registered")
         gdb.write("                                 enable  prepare  protect               \n")
         gdb.write("   clock                          count    count    count        rate   \n")
         gdb.write("------------------------------------------------------------------------\n")
-- 
2.34.1

