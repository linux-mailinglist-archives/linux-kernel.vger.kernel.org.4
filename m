Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD9370BB55
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 13:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233222AbjEVLOk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 07:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232442AbjEVLN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 07:13:56 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49A3340E8
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 04:08:55 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-96f7377c86aso590975466b.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 04:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684753733; x=1687345733;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AqE7n0km0cT3SoKgXn9+9ffSGk68u7ZexKpVeyjeuP0=;
        b=UI0Yt0lWDXh9ljMMkPAajAGV57h0505ib1ttO6nC+S6/ox2EoI9VGZd7+i0KyUT3Iz
         UrOeQv6HeCqlYMLmrO9xLceNit+eAAhp+ayorSX9GWMqWetCfy65fNLgsBYIBMUhhJ2L
         U75zeNwLejw8wEtPfmFV0nYxaTwgfXdcMVWerdFeHWF2BfssxPxEikaABdcefX8aVmFB
         OzcafrJAiZhR3U1i8vQurAWGDU7VgmaPUGDQ2nyXctKGB+RLSHtg6lFIAG/yBViPwShe
         HnTgtWcZBRbZXXW3R63z1IHpNcsR0E7wzcXRYrATiECZ/KAKp4PAjxmjbmz2ChABim6V
         aqqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684753733; x=1687345733;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AqE7n0km0cT3SoKgXn9+9ffSGk68u7ZexKpVeyjeuP0=;
        b=FmKUQSv/MjcYtCNoiHTuepGu3R8lTdL7NCEDNARzsccux8cUpsUKUO0gGbw2xAM2VG
         EnJskQzntNvpghe1aFBIUnPymWi9pM44dTNPg3qRJqMxPLrOdIuUm+oPaa++Rfrj7DK2
         6Bsqw9C6dX4tOdt7oFJfL+pZZKgzsYdKtL7m+fBh4JjHu94i/lDyiLOGrW/Uc3bmXgaD
         sLp1bUga3EHITkbwgtfiiPLvtmBbPbIL00dYMj3yhAgQM/0sXLzItYxt70GHzADwKZSk
         95JLoi8AO3NYYMt66t3oxRO/lnruNWNvv36e9uxfs0Z6J4sDnEhw37qFs7RMvbAGQC/o
         cHtQ==
X-Gm-Message-State: AC+VfDz/REzDP87GihVnDMULruGiFuQLcEbc+obyOMGVJhnMQHMlsXD/
        C+dYwoiSwCahUgCCTEebcbc=
X-Google-Smtp-Source: ACHHUZ6msUCypNMoSNhIQMunC9pTKnBPX5E3jFgX9C4tJ4LV2wmznUsQq48JjiudHWKxzuBo6hrzCQ==
X-Received: by 2002:a17:907:2d23:b0:96a:928c:d382 with SMTP id gs35-20020a1709072d2300b0096a928cd382mr10346599ejc.48.1684753733572;
        Mon, 22 May 2023 04:08:53 -0700 (PDT)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id lx19-20020a170906af1300b0094f07545d40sm2949453ejb.220.2023.05.22.04.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 04:08:53 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Baoquan He <bhe@redhat.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Dave Chinner <david@fromorbit.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: [PATCH 2/9] mm: vmalloc: Rename adjust_va_to_fit_type() function
Date:   Mon, 22 May 2023 13:08:42 +0200
Message-Id: <20230522110849.2921-3-urezki@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230522110849.2921-1-urezki@gmail.com>
References: <20230522110849.2921-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch renames the adjust_va_to_fit_type() function
to a shorter variant and more expressive. A new name is
va_clip().

There is no a functional change as a result of this patch.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 mm/vmalloc.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 409285b68a67..5f900efec6a9 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -1383,9 +1383,9 @@ classify_va_fit_type(struct vmap_area *va,
 }
 
 static __always_inline int
-adjust_va_to_fit_type(struct rb_root *root, struct list_head *head,
-		      struct vmap_area *va, unsigned long nva_start_addr,
-		      unsigned long size)
+va_clip(struct rb_root *root, struct list_head *head,
+	struct vmap_area *va, unsigned long nva_start_addr,
+	unsigned long size)
 {
 	struct vmap_area *lva = NULL;
 	enum fit_type type = classify_va_fit_type(va, nva_start_addr, size);
@@ -1501,7 +1501,7 @@ va_alloc(struct vmap_area *va,
 		return vend;
 
 	/* Update the free vmap_area. */
-	ret = adjust_va_to_fit_type(root, head, va, nva_start_addr, size);
+	ret = va_clip(root, head, va, nva_start_addr, size);
 	if (WARN_ON_ONCE(ret))
 		return vend;
 
@@ -3979,9 +3979,8 @@ struct vm_struct **pcpu_get_vm_areas(const unsigned long *offsets,
 			/* It is a BUG(), but trigger recovery instead. */
 			goto recovery;
 
-		ret = adjust_va_to_fit_type(&free_vmap_area_root,
-					    &free_vmap_area_list,
-					    va, start, size);
+		ret = va_clip(&free_vmap_area_root,
+			&free_vmap_area_list, va, start, size);
 		if (WARN_ON_ONCE(unlikely(ret)))
 			/* It is a BUG(), but trigger recovery instead. */
 			goto recovery;
-- 
2.30.2

