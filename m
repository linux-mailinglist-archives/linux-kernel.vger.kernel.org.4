Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 357E760D6EA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 00:18:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232572AbiJYWSG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 18:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232518AbiJYWSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 18:18:02 -0400
Received: from mail-ej1-x64a.google.com (mail-ej1-x64a.google.com [IPv6:2a00:1450:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0CE5C58
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 15:18:01 -0700 (PDT)
Received: by mail-ej1-x64a.google.com with SMTP id qk31-20020a1709077f9f00b00791a3e02c80so3522391ejc.21
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 15:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZQGssT3M/U7b4XMGY/asVcg61n5AcupNDo7Gu+AvRuY=;
        b=GZzG9I3EC4BdTG42DnBMyd1ivXSjjTelzZgMfx5pqBuLbH+hAXxGKOtyb79pJSdisX
         /cpLkpV914ei9LOOwDEcu7sTj/B25/nINBuG35/Tk8G54bHHoc+ny2ycz1Wam8uSNmGd
         tY/cb0kPSQi17ZqKRk4v3fjjk3EuSGaByehhMseFU4VSIV3fseJw2rBBP+T7eVNHsmf0
         tVDy8K7dQhxLyCes+qB6UaAS/ALtPRdJJfJCqOT8iExcL/IzM25Ullu5r3UeNdoSZqBy
         KYA/w+Zg554ckMQspY6Vt30Ly/d4YYC5g2WsdbKbuwghxsCBeOYps6smx3sA2/cHwrxs
         r7qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZQGssT3M/U7b4XMGY/asVcg61n5AcupNDo7Gu+AvRuY=;
        b=BN+l2Zz8BhMwTjL4epUgCAn25AWTWFwo1xkRkgaIbITCHSQOziXlqHrzR3nUkGxD0S
         bdbuKj9hLRJu+zS/TopaF7pM5N5alQr7MV41RyBJhUQF2Urfg09NJYlGJet2S592S6ag
         /otSS4MIx24j7TxMwJSEJt9lLrmXuarp0ZQjZ7ulAHQ3/EKwU3Km6zchxo/Hl9v7tRZj
         QoM5tIjLdx2LExjMl52vb23wH5RPU9EFVat2/nkvv1fKwKNPPsyqwdR+r8JR+SavavQU
         rNzBNQHjt53sEGWyVDOyXpwbC9Ya6cvzlDPWEA+tKDxWnOn6m745pvWHev/ApBf64wcb
         q+Wg==
X-Gm-Message-State: ACrzQf2V6GrH1p1IVkzBO5s14c4z6fslM0INL8VSj5GQ5qsgogMgXHeE
        ZoeiUj9JERMrEE9kGmnSGsHEn3yfwps=
X-Google-Smtp-Source: AMsMyM6wWRQeoGnTklgT6+h+msVouxh/KVCK+QWxO1G7zXpVRcKJfnF95EwBt0uYbBEf2yxO5HMusq31MdQ=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:2e8:4dec:7a62:7bda])
 (user=glider job=sendgmr) by 2002:a05:6402:b2f:b0:461:701e:877a with SMTP id
 bo15-20020a0564020b2f00b00461701e877amr18471401edb.82.1666736280249; Tue, 25
 Oct 2022 15:18:00 -0700 (PDT)
Date:   Wed, 26 Oct 2022 00:17:55 +0200
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
Message-ID: <20221025221755.3810809-1-glider@google.com>
Subject: [PATCH] x86/uaccess: instrument copy_from_user_nmi()
From:   Alexander Potapenko <glider@google.com>
To:     glider@google.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Kees Cook <keescook@chromium.org>, x86@kernel.org
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
2.38.0.135.g90850a2211-goog

