Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A3BA612118
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 09:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbiJ2Hro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 03:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiJ2Hri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 03:47:38 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 307F8BE507
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 00:47:38 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id r61-20020a17090a43c300b00212f4e9cccdso11788025pjg.5
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 00:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iET1MgkbhbQrIxry/f1xQYIkFRrGZlUGPdYAoIr26co=;
        b=mZ3+TLyyf+YAKB6grPKR4XJ64ryv/j+QR/P6vbHxeyyDqxta8DzxJBAT0AaWaRcsxN
         nzKNfDzZQD3pOYizxknWM7Oc2ip1Ate6WKBBLygfgNdP6vxdJ1fhIB39b3y0VafFUmri
         O4rrz8qlJ3p0Y7v2a8Jj6ZXoFXIjk3cJCQqac=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iET1MgkbhbQrIxry/f1xQYIkFRrGZlUGPdYAoIr26co=;
        b=YHpS9mv2JJTdCbJs4BFxr8c5ZgXdeaqz8BEJ6iKMTBH8dvv1Y7nNl6zOvHNOl3MHak
         Jd9mFi0pQrnNVieOIHcHd0Gl9xmbhhAeN3VwDcAe8CCALf76FDVnqyFac+mqEq8fF09W
         2EDrV94tvbcDVXn28ngL4CRFQGyxncU2xnW92jYX2kugqPZdbmOxpHfarf+9fgccYedt
         JX/uz2oXOz9aNrUkL1cZkj0ITcLoCLkj1srnKu/iVxbD/YjIyyC8tepalXNe2TgR0PDQ
         NWqsRpPc63vuaJVDStpcnXK16YaTigUgIp6OGQ/qmPgaUwYx0LbeTgiXAbgG2rdVZLTd
         k/Og==
X-Gm-Message-State: ACrzQf0yRR584kGDb1SmfJHmwujuQVEPaWHaELOKJXyb3EIELexJShDx
        ++4XAhwzxEELZ98uv1A5b7xWHXfG6tOhsg==
X-Google-Smtp-Source: AMsMyM6EQFHolbOhV4RL/gqEjO0/bGgmWqy0y9idJlsq+LxGSpsMRetUiPmZAXkaNByP2MTtjVUYog==
X-Received: by 2002:a17:90b:38d2:b0:20d:8f2a:c4ba with SMTP id nn18-20020a17090b38d200b0020d8f2ac4bamr3487572pjb.209.1667029657664;
        Sat, 29 Oct 2022 00:47:37 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f19-20020aa79693000000b0056c003f9169sm622842pfk.196.2022.10.29.00.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Oct 2022 00:47:37 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Nishanth Menon <nm@ti.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Won Chung <wonchung@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH v2] driver core: Add __alloc_size hint to devm allocators
Date:   Sat, 29 Oct 2022 00:47:34 -0700
Message-Id: <20221029074734.gonna.276-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2343; h=from:subject:message-id; bh=bl4eK7ug971gaAZ+iCba/RVpEILgA2NDbUfm+iHo2MU=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjXNqWRHPJAx2S72TjRZFwkW12qVeTilB6z4pIHrNa c/9Aig2JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY1zalgAKCRCJcvTf3G3AJlwLD/ 0Y6tYgGRaOz6Lukqw+GWNHimgdpRgR4fATDqodCPbi6IY5H8g6UW5BNhVD3q2vuACKCPD8w6LANjvM pTRi3hZMQ1UV+USbzrVVM//6gq0A0t2wy56J5gM3tSu4FvPSdXS9URKPyciGhZmi02k0fOc4OZ8QjK sAJD8M5AiKkiKAQPBuYR6f7tkz8SoXqn3NKVoLiroDdFYdeC/HZMzNNVcku1xi8WA90FoZvUedLsxa 8ajzgWmyIxN3Kqw/5J6I4Lo+wJ/yyrG/wnZCHVYOgD9B+LPe/TlY+4yASZ+ceNJbxL0ffP/69QSRlR vv65snxCu2GVhUVENXo8/psgXq0xFs2Z+GWJS3t5s1+5qebWRSgCy/UofykafWYWcwyRVXLHfSxQtd LpjzN8FTXLQ20gE2+dk5jWtoz2WTCIJh5t6u/LJfPotnL3XEyzTdFfaBMOtMgAGnxFHJlqGYZ6qrsS Dqh1U1Ou03qiNw1PYwawc0W5zfRKs3fJPC7IatsrANWKhRKreEiyOWAnG4DLiW2lyewq5sU6wofRNs GjjH+WNE2ueP2aB25LRTCd/IER775Vq+1Ez5N4NkjiVfrQd/aHsCL6ND49qHGlvSyzEhirTfMponQv BdMn73gkuVKNWTCxfhP7/JC9MZTNoBfHbI5Co81CvaGs8Ts0ohYrrFZ38lZA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark the devm_*alloc()-family of allocations with appropriate
__alloc_size()/__realloc_size() hints so the compiler can attempt to
reason about buffer lengths from allocations.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Nishanth Menon <nm@ti.com>
Cc: Michael Kelley <mikelley@microsoft.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Won Chung <wonchung@google.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
I'm hoping to carry this via the hardening tree so I can add a
KUnit test that depends on it...
v2: use __realloc_size instead of __alloc_size
v1: https://lore.kernel.org/linux-hardening/20221018073430.never.551-kees@kernel.org/
---
 include/linux/device.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/linux/device.h b/include/linux/device.h
index 424b55df0272..5e4cd857e74f 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -197,9 +197,9 @@ void devres_remove_group(struct device *dev, void *id);
 int devres_release_group(struct device *dev, void *id);
 
 /* managed devm_k.alloc/kfree for device drivers */
-void *devm_kmalloc(struct device *dev, size_t size, gfp_t gfp) __malloc;
+void *devm_kmalloc(struct device *dev, size_t size, gfp_t gfp) __alloc_size(2);
 void *devm_krealloc(struct device *dev, void *ptr, size_t size,
-		    gfp_t gfp) __must_check;
+		    gfp_t gfp) __must_check __realloc_size(3);
 __printf(3, 0) char *devm_kvasprintf(struct device *dev, gfp_t gfp,
 				     const char *fmt, va_list ap) __malloc;
 __printf(3, 4) char *devm_kasprintf(struct device *dev, gfp_t gfp,
@@ -226,7 +226,8 @@ static inline void *devm_kcalloc(struct device *dev,
 void devm_kfree(struct device *dev, const void *p);
 char *devm_kstrdup(struct device *dev, const char *s, gfp_t gfp) __malloc;
 const char *devm_kstrdup_const(struct device *dev, const char *s, gfp_t gfp);
-void *devm_kmemdup(struct device *dev, const void *src, size_t len, gfp_t gfp);
+void *devm_kmemdup(struct device *dev, const void *src, size_t len, gfp_t gfp)
+	__realloc_size(3);
 
 unsigned long devm_get_free_pages(struct device *dev,
 				  gfp_t gfp_mask, unsigned int order);
-- 
2.34.1

