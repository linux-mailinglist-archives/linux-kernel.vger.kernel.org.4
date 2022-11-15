Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A7EF62A40D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 22:26:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbiKOV0R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 16:26:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbiKOV0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 16:26:02 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E1F26169
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 13:26:00 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id b21so14446322plc.9
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 13:26:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x00a1e9-dev.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5crKBJk5pAZYUIKM6y7Y1WfvEopprUvgi5Bt8JeCxg8=;
        b=oCrbN/XwA+N17HuCDVu3PdusMxtiNhMj/egsHBwCL/VeGA3VvuQEDmMEQ6byFzNprw
         ZZ2B2xg4AYUeyxFTK0ar3uEccZUOr02xp5biAzA0J/y0PhsGlSY2ubkUSBDS3yl2bFkK
         FlJA52RjwHdVbcN0QijmjBP0KEF+3hjcwO6Z5NolFPlWHiuSKNSgXRsuFbc/6rDtHLBN
         IqfDzhgt1DNpNXBM1aj3eE0P22CiYyXFP+LYR7sulqSs8ENjUF+O6mSqBU+2uEj8Rhuq
         WKFinLvf0bM+/qzuvJSBmhRy2/x1obbi3lqug23xxYbAzRbqQxpiUmyWZ6KuUYCHffUy
         jIHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5crKBJk5pAZYUIKM6y7Y1WfvEopprUvgi5Bt8JeCxg8=;
        b=n9FvmJqNFLBSO2IERdqt212Uq3+uJhCGx0RcHKQgLViBS507zw5d9nw02KwcZVXlH5
         WuDLMj9HUrzwlME16VmCXjHhiR84bgxhzLxletvbG1PwFJ01Ir2PLXFNsDqzyn8aMdhF
         tvqnYciKdrJrysnasdD4fmPa1GGBhD7l6x6+nFAO6yPLNgBiqbufkwg3htDtJq3EwBJ4
         Oz8OciLLukOeiWRpdlqxV+qhW7BQfzXbrGFuWCneeuZtshlV4j23pw05TomvZ9pzlFs1
         WHFSPDRGDdnvVHzS6VSXn9ddjPlmFmAadXs5XyuC2V2KC81saQpDmMj6fMaF3LxZdddZ
         JefQ==
X-Gm-Message-State: ANoB5pnqXo6c61HwIPR4NkHicbPTb0ZgzWuouQucLf5US8cyvOFrRuLa
        B+WHnIN9UJ1Y3QxR6MxTDJdczObnNtpErPBq
X-Google-Smtp-Source: AA0mqf5QkbKmRMem+pbMp3v9ZxGMG0p/kDdVTIGpML2F3n6cWg8sg9G3145QigoFS52gjdY7sLKibQ==
X-Received: by 2002:a17:903:1109:b0:17d:839:5a17 with SMTP id n9-20020a170903110900b0017d08395a17mr5957015plh.62.1668547559878;
        Tue, 15 Nov 2022 13:25:59 -0800 (PST)
Received: from 0x00a1e9.dev ([2001:200:0:8802:ff5b:df6b:bf6c:21ba])
        by smtp.gmail.com with ESMTPSA id q7-20020aa78427000000b0056baca45977sm9245389pfn.21.2022.11.15.13.25.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 13:25:59 -0800 (PST)
From:   Yuma Ueda <cyan@0x00a1e9.dev>
To:     linux-kernel@vger.kernel.org
Cc:     keescook@chromium.org, gregkh@linuxfoundation.org,
        ojeda@kernel.org, boqun.feng@gmail.com, masahiroy@kernel.org,
        samitolvanen@google.com, ytcoode@gmail.com,
        Yuma Ueda <cyan@0x00a1e9.dev>
Subject: [PATCH v2] scripts/kallsyms.c Make the comment up-to-date with current implementation
Date:   Wed, 16 Nov 2022 06:25:46 +0900
Message-Id: <20221115212546.7154-1-cyan@0x00a1e9.dev>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The comment in scripts/kallsyms.c describing the usage of
scripts/kallsyms does not reflect the latest implementation.
Fix the comment to be up-to-date with the current implementation.

Changes from V1:
- Fix typo

Signed-off-by: Yuma Ueda <cyan@0x00a1e9.dev>
---
 scripts/kallsyms.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
index 03fa07ad45d9..05c99ca3847b 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -5,7 +5,8 @@
  * This software may be used and distributed according to the terms
  * of the GNU General Public License, incorporated herein by reference.
  *
- * Usage: nm -n vmlinux | scripts/kallsyms [--all-symbols] > symbols.S
+ * Usage: scripts/kallsyms [--all-symbols] [--absolute-percpu]
+ * 			[--base-relative] in.map > out.S
  *
  *      Table compression uses all the unused char codes on the symbols and
  *  maps these to the most used substrings (tokens). For instance, it might
-- 
2.17.1

