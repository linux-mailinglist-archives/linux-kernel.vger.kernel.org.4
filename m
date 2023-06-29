Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 967E0743110
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 01:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbjF2XZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 19:25:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231522AbjF2XZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 19:25:08 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A61AE1FDF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 16:25:06 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-1a1fa977667so1111640fac.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 16:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1688081106; x=1690673106;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8XkUN0EizrcPJdxYDyml9MD9K5nwnJEgupZt44caww4=;
        b=DIOrkzvu8itXrRDVqrYwNUO8RR/O0uEKATtMBGoLT7ZDMAULfOV2+XLpRMwb4lSo1H
         o8f4vm7uBwP6nRhUwyvViY15Yn73fB6S5rSl+En04NKl9NuKOjDAks0aqXtGB6itZkTx
         hFE5wR4rTEM4DrLYzlMegMS5O2+oAyJQsqHkE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688081106; x=1690673106;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8XkUN0EizrcPJdxYDyml9MD9K5nwnJEgupZt44caww4=;
        b=P0Q1dPwbZZdZPpvuVWcEkqlA1qzOfv7DFdnkKQ7SZxL+PosaF/3CCUESgJWPHsphfP
         cXXz2anqEP6jCNUwLAc58TC2DmQcfLbvp76xaLXi7+vzouinEcJHSGZgd2b/1E7KDxQI
         CVyMYZlEFdNso+2qNf6gGuLEaeF771xBUp0wirLWSLqd1V7gnv1mecLr5I24kBLLJ39T
         6553y8qshCMGJUL2QEfKHK4j00YYnVl4ePkgR29QXSP26nkVkwS2NRTOtWO4iEF6+N5g
         3FEK9NYOu3bM0JvpjXARJPnfeXtKmcBY/QVaW13a3Mvd5LtE1aWu1gSkcLI8DIQA69sH
         VBoQ==
X-Gm-Message-State: AC+VfDwq3JRclVFm6ZX8y2j13pCkubFRFqROF7iN70E60/H19xLkRYte
        IfLuxTO84jj8R/I2CVaOamJdI1cIBfKMjohDs5M=
X-Google-Smtp-Source: APBJJlGFQhB9pXlX/BZEhpArHhanMF0PsxvAgS8Ray5hkbYflejU/wjfaf/Ywe+hLWqeUIiTbaazMw==
X-Received: by 2002:a05:6870:3c8c:b0:1aa:9eb6:974d with SMTP id gl12-20020a0568703c8c00b001aa9eb6974dmr1593876oab.41.1688081105835;
        Thu, 29 Jun 2023 16:25:05 -0700 (PDT)
Received: from localhost (183.43.230.35.bc.googleusercontent.com. [35.230.43.183])
        by smtp.gmail.com with UTF8SMTPSA id g15-20020a17090ace8f00b002636e5c224asm573038pju.56.2023.06.29.16.25.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jun 2023 16:25:05 -0700 (PDT)
From:   jeffxu@chromium.org
To:     skhan@linuxfoundation.org, keescook@chromium.org
Cc:     akpm@linux-foundation.org, dmitry.torokhov@gmail.com,
        dverkamp@chromium.org, hughd@google.com, jeffxu@google.com,
        jorgelo@chromium.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        jannh@google.com, linux-hardening@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Dominique Martinet <asmadeus@codewreck.org>
Subject: [PATCH] Documentation: mm/memfd: vm.memfd_noexec
Date:   Thu, 29 Jun 2023 23:25:01 +0000
Message-ID: <20230629232501.4157671-1-jeffxu@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeff Xu <jeffxu@google.com>

Add documentation for sysctl vm.memfd_noexec

Link:https://lore.kernel.org/linux-mm/CABi2SkXUX_QqTQ10Yx9bBUGpN1wByOi_=gZU6WEy5a8MaQY3Jw@mail.gmail.com/T/
Reported-by: Dominique Martinet <asmadeus@codewreck.org>
Signed-off-by: Jeff Xu <jeffxu@google.com>
---
 Documentation/admin-guide/sysctl/vm.rst | 29 +++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/Documentation/admin-guide/sysctl/vm.rst b/Documentation/admin-guide/sysctl/vm.rst
index 45ba1f4dc004..71923c3d7044 100644
--- a/Documentation/admin-guide/sysctl/vm.rst
+++ b/Documentation/admin-guide/sysctl/vm.rst
@@ -424,6 +424,35 @@ e.g., up to one or two maps per allocation.
 
 The default value is 65530.
 
+memfd_noexec:
+=============
+This pid namespaced sysctl controls memfd_create().
+
+The new MFD_NOEXEC_SEAL and MFD_EXEC flags of memfd_create() allows
+application to set executable bit at creation time.
+
+When MFD_NOEXEC_SEAL is set, memfd is created without executable bit
+(mode:0666), and sealed with F_SEAL_EXEC, so it can't be chmod to
+be executable (mode: 0777) after creation.
+
+when MFD_EXEC flag is set, memfd is created with executable bit
+(mode:0777), this is the same as the old behavior of memfd_create.
+
+The new pid namespaced sysctl vm.memfd_noexec has 3 values:
+0: memfd_create() without MFD_EXEC nor MFD_NOEXEC_SEAL acts like
+        MFD_EXEC was set.
+1: memfd_create() without MFD_EXEC nor MFD_NOEXEC_SEAL acts like
+        MFD_NOEXEC_SEAL was set.
+2: memfd_create() without MFD_NOEXEC_SEAL will be rejected.
+
+The default value is 0.
+
+Once set, it can't be downgraded at runtime, i.e. 2=>1, 1=>0
+are denied.
+
+This is pid namespaced sysctl, child processes inherit the parent
+process's pid at the time of fork. Changes to the parent process
+after fork are not automatically propagated to the child process.
 
 memory_failure_early_kill:
 ==========================
-- 
2.41.0.255.g8b1d071c50-goog

