Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FA00615518
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 23:34:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231321AbiKAWeU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 18:34:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbiKAWd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 18:33:28 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D2AC2192
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 15:33:25 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id 130so14775170pfu.8
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 15:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gzM6J7UGnorFDlDysY0MD6P7BjaP+6EbrbAqldiRrKE=;
        b=OKuDa6YSbANP/NsNkIWjApa9dbOPZfAN/KtOhEl7y//1+lLuJ6c0t6cE9j/ifht6Vy
         10XhU7TJYo8HMJE/VscMRVZgUI2flZNTZY+0daayeJydtHb94FxLwQJGgZ0qCpAcBHPl
         7eIkUxKRPJyW+uxeOKrY9C5oPis/Bie6gRUZA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gzM6J7UGnorFDlDysY0MD6P7BjaP+6EbrbAqldiRrKE=;
        b=aDfK9/yZTMH2AB8kyDYCYVkBXxC7ji49JXL8MK5npJqmZMEWw2w4MjMpUJg7q+c/ZG
         ER8Cs+esxnwckAgeTvTdUGioAbhH7p3bArimJ3Vj2DLGpUcQJMN+zdGKuas67lV8jgF+
         5+jzEMc/GlfsXW+UfGwX0Z98B2TcUioZrX2+5k2n/XagJa61TTL2QL2m01pj/twsdt7V
         p54UdV6zcxUoTSAj9ZJM6dfnueNbgYKzwa4FHOi2JbY8MFWul5yy8stxe65Pwse9HWC0
         18JWa2cki9atAGihpTBDtt0lWjXBUZ5Gaep+89+BoMqWYI7INS/0xssNcxmPWWTUjvo3
         85KA==
X-Gm-Message-State: ACrzQf2u1/zncORSGazEAmVJALxIlkDLok77VS6o9NX5KpWWaSTAeEIX
        TkcB9+ycSNnVJZIjAnGcALMgSA==
X-Google-Smtp-Source: AMsMyM5/UJCRTY42PEpY1Y0wufzzSsIn6sCjMrikkeh+nFyBBYr8szUuO8piqBRMJ8AUIXH3cwv2yA==
X-Received: by 2002:a63:950d:0:b0:46e:d655:b377 with SMTP id p13-20020a63950d000000b0046ed655b377mr19259111pgd.191.1667342004776;
        Tue, 01 Nov 2022 15:33:24 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s7-20020a170902988700b001811a197797sm6778934plp.194.2022.11.01.15.33.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 15:33:24 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Nishanth Menon <nm@ti.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Won Chung <wonchung@google.com>,
        David Gow <davidgow@google.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-hardening@vger.kernel.org,
        llvm@lists.linux.dev
Subject: [PATCH 5/6] driver core: Add __alloc_size hint to devm allocators
Date:   Tue,  1 Nov 2022 15:33:13 -0700
Message-Id: <20221101223321.1326815-5-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221101222520.never.109-kees@kernel.org>
References: <20221101222520.never.109-kees@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2391; h=from:subject; bh=aUB9QFgSGPW6FN3jHA0HE05KQ7SqHyl2yIuilOndYc8=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjYZ6qr8iT9TeVIzVavaub9kYVPpos80os4w71z521 I5fSEqiJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY2GeqgAKCRCJcvTf3G3AJsI+EA CCoCqTQVECoE72alYcrcqBPY9Z20kQHjcfMq2clHkeoyFdKB7/Ud8kY1NoGi9q0m7Xda+lbswp0Jlt WBofqN/HFcFfrXp3FK8cKt+E6z83q0MQ0tPoIJ8VrbX4/wOJvdwTMD01BGiRQ0CbVNKJ7r2fSpRHS8 6wR/YVw5UWOYYryexrUjU3p7shnbVQ78CHVuSyCWWBAbvDwjqN1kQqmGB/xhqF30AtrLCJZeaXlMHI 6OlrqKUn+Izi77UJ7rrqoS6x931kwNHbO1+ZBj/lU9O5yZ7ff8PbhX3q5SJhLRKIVdaADnYGIqt296 LRbxLOfFTiDPd8DdumdGCzmXLZaUhS5Ef1GlGQJ9Ofz+SqZK6WjgYaw/RpelAbMhqf3Pa7NAUSRQ/T 0UZSTeVpU8AwIRrAhLh5s2zUneuHm2F3vZUdRjgBPdXjFW3Q8FsuKiDApeD5UShVJ5L64NL7K2I83F thVgiY7h7bGlpRRORua5rQEQLSEg4vsYiKvvUMbRLIuiacpWqT9b0zk2fLyBRESTF5/gChxZkF3d2S w2P/b+Zmj4VAqX324oLiSUkdASYfidRxN3jN1y+7w1rLl9h/VDvCFRZbbLicPvvMiNK9V6KClVIOZs yZWijWPTj3w0TMU+Cpgdq8ksSrwHICryAxiyTeUEHR3ni/aE+UAIMm7je+Vw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Link: https://lore.kernel.org/r/20221029074734.gonna.276-kees@kernel.org
---
This is already in -next, but I'm including it here again to avoid any
confusion about this series landing (or being tested) via another tree.
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

