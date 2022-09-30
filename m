Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2472F5F01D1
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 02:33:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbiI3AdA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 20:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbiI3Acy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 20:32:54 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0EDB201921;
        Thu, 29 Sep 2022 17:32:53 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id g1-20020a17090a708100b00203c1c66ae3so2828935pjk.2;
        Thu, 29 Sep 2022 17:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date;
        bh=Y/iCyfWFwhCJ4Po4MNahnRsYUPJNWeLTv8S5cjtqVfo=;
        b=aY+v6T5hJznVm7FOLTz9HbMJqJDnOpJYqZayqH8h1yLXl1712z7CRbbcI/UTry5X3u
         dGAgXsLiIUXbWHjtI/y0GwSgmyql0ejVC429NhFuyK1DW5jrSmd5a41X6vBlEosEWUFY
         UoVWSo7WJTEGXnPlOeEiGt1Vfi0WzoY8TfjLkqMFD5KexP78BURJVAyYw7kThq34CTRQ
         TqUVn6vyW77gb2C76UYWSXS0wJcTjERUHKCNVs5BMAxq1byUv47kUy21kJPf+MotasL6
         oldB5fGmDGfYmL3P1iAYxNVKhil75QPAoPx8TEwyDmwFul1r3OVMBmU8O0xD1+Ew5ODU
         JsfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=Y/iCyfWFwhCJ4Po4MNahnRsYUPJNWeLTv8S5cjtqVfo=;
        b=Wrzr5uZUPRIm/DMtb6vfVOXl8+uVORmjXcwP6+WvaRazS1kbVVDkiZZzASCKEMkY2z
         cLAyyQjw2o5YO+NAFWLpIAcJ/aY/ISt7Icg7Q8fWj5UkMFaSjlIbzUjosbm907CanZA3
         jdxzjTXwJPa+4atyc2PK35fh2mvvPkoJNJe+iNsJzzyzE9xzLLsf0kQwHLMogDO2OrLG
         4c3RpxGWUT256B3VM3PoiWUau++lzPpWP3W02HYTuTbMUywWO42GGGyQz317uAHnPI9+
         Up2MlRIzC9HpicGPQENfD3yq9faklZtGcXsWTSKCDvS+dnlJNqwM1Quo9yd338NQm7lS
         lEDw==
X-Gm-Message-State: ACrzQf00CqDLckJDESvEVzzXOauDdp0R3ctdlKaD4prnh4+8z1NO5/MK
        yGP62+q7H5Fj4mfFaalv1HI=
X-Google-Smtp-Source: AMsMyM6qd+Sb9lsLmN5TkPEPUFLR5DhXt9hyPXc4tAkLZaMzpTaya/gjP0ClkDseoUM451FagseJtQ==
X-Received: by 2002:a17:90a:d14a:b0:203:7b4b:6010 with SMTP id t10-20020a17090ad14a00b002037b4b6010mr19266373pjw.237.1664497972891;
        Thu, 29 Sep 2022 17:32:52 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:d016:f5be:4ff2:43f])
        by smtp.gmail.com with ESMTPSA id nb7-20020a17090b35c700b002032bda9a5dsm357146pjb.41.2022.09.29.17.32.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 17:32:52 -0700 (PDT)
Date:   Thu, 29 Sep 2022 17:32:49 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] of: base: make of_device_compatible_match() accept const
 device node
Message-ID: <YzY5MaU5N4A2st5R@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_device_is_compatible() accepts const device node pointer, there is
no reason why of_device_compatible_match() can't do the same.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/of/base.c  | 2 +-
 include/linux/of.h | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index 8e96862d312e..b7be15e85952 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -561,7 +561,7 @@ EXPORT_SYMBOL(of_device_is_compatible);
  *  a NULL terminated array of strings. Returns the best match
  *  score or 0.
  */
-int of_device_compatible_match(struct device_node *device,
+int of_device_compatible_match(const struct device_node *device,
 			       const char *const *compat)
 {
 	unsigned int tmp, score = 0;
diff --git a/include/linux/of.h b/include/linux/of.h
index 766d002bddb9..6b79ef9a6541 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -342,7 +342,7 @@ extern int of_property_read_string_helper(const struct device_node *np,
 					      const char **out_strs, size_t sz, int index);
 extern int of_device_is_compatible(const struct device_node *device,
 				   const char *);
-extern int of_device_compatible_match(struct device_node *device,
+extern int of_device_compatible_match(const struct device_node *device,
 				      const char *const *compat);
 extern bool of_device_is_available(const struct device_node *device);
 extern bool of_device_is_big_endian(const struct device_node *device);
@@ -562,7 +562,7 @@ static inline int of_device_is_compatible(const struct device_node *device,
 	return 0;
 }
 
-static inline  int of_device_compatible_match(struct device_node *device,
+static inline  int of_device_compatible_match(const struct device_node *device,
 					      const char *const *compat)
 {
 	return 0;
-- 
2.38.0.rc1.362.ged0d419d3c-goog


-- 
Dmitry
