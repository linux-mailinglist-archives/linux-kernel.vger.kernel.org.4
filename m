Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B992616166
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 12:06:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbiKBLGW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 07:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230302AbiKBLGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 07:06:19 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23B8024945
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 04:06:19 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id e8-20020a5b0cc8000000b006bca0fa3ab6so15973019ybr.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 04:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GIr2ezHJZytLhlXMK2PvYo8WU5NrIng/zb7hVbc1Lzg=;
        b=TDR2QbrpbPk39MbEBp7QE2/LtaTl168eHDcSKXsTbYFm0J2N6gc1e1BbPZoiCjB8hU
         9BaU4/mFK6rylWjr8RlezKIdwfyx6JEn4Xt+BuDRJzDqLGWxoSxMOuJisNk//4LKYqeo
         WmCgmQMbYt7wUV/ki7tYTWroZrWVcyodZ+cDyMos90rvZPUsmiKOw50wZWI3K4Yz2ekN
         hRPo9sFMvHxlZqZXXNZ4ZZ+etmzaSVqT7KWQmtgp0Yv1Qupyjg8fsdntbz4+2XCc848s
         GerrC3sXiYTqxNqrYQXvh3xr+wMLrxLHYxahoFSishfnQJ7qiPsqJNWKC1iXHXj2CqAF
         HCaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GIr2ezHJZytLhlXMK2PvYo8WU5NrIng/zb7hVbc1Lzg=;
        b=lvsNQwGNPpk0vQx28FEdeJZ+WldRaVfaRIdEWMnGtpN0eSLtS+YxQHMFXAbiT7AHUx
         /iE6XyKMYiQIWNwfK2vAz9Nscp16oyBSjG55erXSsLgNy9MVIGJcidLTrcK4UgiAJk8z
         1CBGnT6h5VpvukmZcx2vquUyKNpWg/BkYiSz3n78B4SeDyQzHIdXzEhlEctxW7+YkahF
         NhAroIBAnr+uRMxoXdjLRvv1epZMM4VYUxTtedjUaxn/KKwOYbirRNU1aSn+R/C5y+5J
         0ICnChvtZUz7qAS+wtQnd5LJEXF80RwZUzyFZh4a+FT0IGuVo63RYewVpzJa+BCwDzI7
         m1ZA==
X-Gm-Message-State: ACrzQf3a2ySV7Wt1Fn9e2DgB2m9jggyzneeLXSGRqYurl+2OBJj8qOcy
        X1vGHMnCj1OYCY5nShBKfb1a6+SUGxA=
X-Google-Smtp-Source: AMsMyM46EzUNxA/tJ+HneP2x8faa5lSnGZX9YuhwEIjs8mzU+29Tq9Wklfbi16zLxPqq+zIolz1gsMz28xE=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:7f41:af20:8:a96d])
 (user=glider job=sendgmr) by 2002:a81:a0d5:0:b0:370:1a06:1b4a with SMTP id
 x204-20020a81a0d5000000b003701a061b4amr178816ywg.206.1667387178012; Wed, 02
 Nov 2022 04:06:18 -0700 (PDT)
Date:   Wed,  2 Nov 2022 12:06:08 +0100
In-Reply-To: <20221102110611.1085175-1-glider@google.com>
Mime-Version: 1.0
References: <20221102110611.1085175-1-glider@google.com>
X-Mailer: git-send-email 2.38.1.273.g43a17bfeac-goog
Message-ID: <20221102110611.1085175-2-glider@google.com>
Subject: [PATCH 2/5] x86/uaccess: instrument copy_from_user_nmi()
From:   Alexander Potapenko <glider@google.com>
To:     glider@google.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make sure usercopy hooks from linux/instrumented.h are invoked for
copy_from_user_nmi().
This fixes KMSAN false positives reported when dumping opcodes for a
stack trace.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: x86@kernel.org
Signed-off-by: Alexander Potapenko <glider@google.com>
---
 arch/x86/lib/usercopy.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/lib/usercopy.c b/arch/x86/lib/usercopy.c
index f1bb186171562..24b48af274173 100644
--- a/arch/x86/lib/usercopy.c
+++ b/arch/x86/lib/usercopy.c
@@ -6,6 +6,7 @@
 
 #include <linux/uaccess.h>
 #include <linux/export.h>
+#include <linux/instrumented.h>
 
 #include <asm/tlbflush.h>
 
@@ -44,7 +45,9 @@ copy_from_user_nmi(void *to, const void __user *from, unsigned long n)
 	 * called from other contexts.
 	 */
 	pagefault_disable();
+	instrument_copy_from_user_before(to, from, n);
 	ret = raw_copy_from_user(to, from, n);
+	instrument_copy_from_user_after(to, from, n, ret);
 	pagefault_enable();
 
 	return ret;
-- 
2.38.1.273.g43a17bfeac-goog

