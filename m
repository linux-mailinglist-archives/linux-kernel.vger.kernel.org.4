Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62F8D61076A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 03:48:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235854AbiJ1Bst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 21:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235104AbiJ1Bsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 21:48:41 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F2C9AC389
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 18:48:40 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id f22so2714957qto.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 18:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RIvfGYehnMa6vIHYYKC8CbCIUzksWXHKOuTYYTC6QyE=;
        b=cyuxwjjEgSIb7u4uJQfNUyKZwsoP4ZsECrSTZJxHowpz5sUFI0h/S9O4Ph0F9CDeqb
         jutAHfg4no8JzCg10FjaZYUzxlwcHExfUskHnAe8C0w7obuj/p2pm3pSDTxAvFGxbqnu
         yrUJqXbZm9hDpwcQb1W1JzZmk3zmw4x7XFBRC9d8bO8zGC6mfQexAGA0isj9MTuor3AS
         wC832jU/H95L7x120ZV+eS974IF3w3XLlnolJJTP1FQNlW8uXw7hxVsbvvLLl/M+MElh
         3BKaac7yFMqAgU0QL8o+e0VQfVU+VwYnlW+yOb94BwBtgSr0APLU8zLlCKn2MIhjNHr0
         HpXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RIvfGYehnMa6vIHYYKC8CbCIUzksWXHKOuTYYTC6QyE=;
        b=bAj94sxcQQ1lBkysj08tZCUOAaHgO+xisM9eH9GkjNflYXGQvDq/vFMzhnSO3fJRe/
         39b94cigrUFxfRK1w7Ge9474rzGS2mpZeLfvf27l1CGHk7hFeIviJeWRu+ifrZxSAnfI
         c4MQL7TbUle4hDd45vsDyCvsITlEupWE8FttvA/GOg7ONnOvPW3pGJYpT9BWO3dvlQF+
         yFVPRpdBcHhiVaSydxcGt/v2L9A6+kAOk0mYAKAANdzHBmY+p7AjACWwldOXIaYcSDCa
         QanwUsuJymMoN+11YaqyvrxY6qFx2co4ek5NjhRbZ+OR1fwlWFxnbNFaTj6w2bhJoLP5
         H7Ig==
X-Gm-Message-State: ACrzQf0OiPvodID+9flS0PKAMKzoa25QMIu9o9dLpk+8PCW7FxwXQSGh
        SYMyt8UpaYq1cnq/4yzMMyjCzvVqWNI=
X-Google-Smtp-Source: AMsMyM6pvtfauL443znH2AFXFJIteBfX5dL1uOhAcoRBRHR9NFqJR6y16I1Tmis8U83AH3Vg7jHwpA==
X-Received: by 2002:a05:622a:19a0:b0:39c:ba70:e475 with SMTP id u32-20020a05622a19a000b0039cba70e475mr43122367qtc.50.1666921719131;
        Thu, 27 Oct 2022 18:48:39 -0700 (PDT)
Received: from localhost ([2601:589:4102:4c7c:d8d0:78d7:ad97:2651])
        by smtp.gmail.com with ESMTPSA id o8-20020ac841c8000000b0039cd508f1d3sm1704079qtm.75.2022.10.27.18.48.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 18:48:38 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Yury Norov <yury.norov@gmail.com>
Subject: [PATCH 1/6] bitmap: add bitmap_empty_from()
Date:   Thu, 27 Oct 2022 18:48:29 -0700
Message-Id: <20221028014834.572819-2-yury.norov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221028014834.572819-1-yury.norov@gmail.com>
References: <20221028014834.572819-1-yury.norov@gmail.com>
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

New function checks if a bitmap is empty starting from a specific bit.
In the following patch, it's used to replace _reg_op(REG_OP_ISFREE).

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 include/linux/bitmap.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
index 40e53a2ecc0d..f84553805c9c 100644
--- a/include/linux/bitmap.h
+++ b/include/linux/bitmap.h
@@ -49,6 +49,7 @@ struct device;
  *  bitmap_intersects(src1, src2, nbits)        Do *src1 and *src2 overlap?
  *  bitmap_subset(src1, src2, nbits)            Is *src1 a subset of *src2?
  *  bitmap_empty(src, nbits)                    Are all bits zero in *src?
+ *  bitmap_empty_from(src, start, nbits)        Are all bits zero in *src starting from @start?
  *  bitmap_full(src, nbits)                     Are all bits set in *src?
  *  bitmap_weight(src, nbits)                   Hamming Weight: number set bits
  *  bitmap_weight_and(src1, src2, nbits)        Hamming Weight of and'ed bitmap
@@ -433,6 +434,16 @@ static __always_inline bool bitmap_full(const unsigned long *src, unsigned int n
 	return find_first_zero_bit(src, nbits) == nbits;
 }
 
+static __always_inline
+bool bitmap_empty_from(const unsigned long *src, unsigned int start, unsigned int nbits)
+{
+	if (small_const_nbits_off(nbits, start))
+		return !(src[start/BITS_PER_LONG] &
+			 GENMASK((nbits - 1) % BITS_PER_LONG, start % BITS_PER_LONG));
+
+	return find_next_bit(src, nbits, start) == nbits;
+}
+
 static __always_inline
 unsigned int bitmap_weight(const unsigned long *src, unsigned int nbits)
 {
-- 
2.34.1

