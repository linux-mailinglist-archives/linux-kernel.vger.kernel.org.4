Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E792C72F27D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 04:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242176AbjFNCOd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 22:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242140AbjFNCO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 22:14:27 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9B0119B6
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 19:14:26 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-56ce96063bcso2569007b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 19:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686708865; x=1689300865;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gm8RCzO5kq5zZdBwoalxKcPrbyd/4JyQrIpAj2PmnKw=;
        b=JF+8NNIBzGX1b2qFl1Jx5pRAVPswMcC79XRisd5GVibmPivKhdXQEHc8d7/naDK+Up
         gOMZkzClZyEGSeqowDIclhILZeAtC2CVfFdBwWcF72qAW2JTytgWt2OQV3y8I8RctUcx
         rD6KgJEg8oUdHwdiguEbWPj746c0VQZU0McaRD4kt+DEq6GIX/MNy1JMHSsOA3yFYFsC
         sHAg4yl8apB5t961Pr7CxwWzQlGHdj90B056A9+csCHCbRFN/NaFi5TKCTMArvGdCO+F
         b6N2BalFlcr/9l9jpyRKLKuba5H+KeeEYg2dX7MvukOZKS8aw4C9SYq3KCCoGkWnNaHm
         3bTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686708865; x=1689300865;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gm8RCzO5kq5zZdBwoalxKcPrbyd/4JyQrIpAj2PmnKw=;
        b=V+vwJGC7MV2TZwUpAZ/zMt5UudMjQ7W78QsLYE8/E9po4Gezn82XFNfN5SIihEeKYL
         +cVEQHx+SY8ZpdoxXBajTfHnG0mA0qsVrNK359R+/XT8lYPWEGB9ZG46maFuOEf2MHpN
         ch76at0Hy+A5qMUGOawUrVo5pwtzyFPzmlJ4g9qCyPF7yS8dG/M22vsuVD+8vHzwFkmS
         1qBSLwP/vCLklQrkRFwTCWVf1aaWsS/vjl2BrC2M5EliEgDYr3bZl2q87rUiH7Eooa+u
         FEgXVqR2+6+GX6h27eqrRAC4tEaF6FuuHZAW2ksJtBq0zbp839d9iKpeU/a6/ZIkgiUn
         WbXw==
X-Gm-Message-State: AC+VfDyBtLx25SFAHcJEN5Sj3eV8WNBUX5GK+ys5VGTSkMMvtBSnqrpO
        2sa6zSHRb1R4tWaDlW0uryf9jM6ECIY=
X-Google-Smtp-Source: ACHHUZ6/DNbpBrJKVXMNBdlaoO0AvEwN+Ng+T489V7u9cl6KqrcMtLNf5K/XiLAGr+3x3Kr65Pz04g==
X-Received: by 2002:a0d:e6d0:0:b0:561:b53d:d1f1 with SMTP id p199-20020a0de6d0000000b00561b53dd1f1mr160456ywe.19.1686708865329;
        Tue, 13 Jun 2023 19:14:25 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::e])
        by smtp.googlemail.com with ESMTPSA id p3-20020a817403000000b0056d30f1b508sm1463931ywc.107.2023.06.13.19.14.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 19:14:25 -0700 (PDT)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v2 2/5] mmzone: Introduce folio_migratetype()
Date:   Tue, 13 Jun 2023 19:13:09 -0700
Message-Id: <20230614021312.34085-3-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230614021312.34085-1-vishal.moola@gmail.com>
References: <20230614021312.34085-1-vishal.moola@gmail.com>
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

Introduce folio_migratetype() as a folio equivalent for
get_pageblock_migratetype(). This function intends to return the
migratetype the folio is located in, hence the name choice.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/mmzone.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 744bf32e48a8..b58c76e68ac7 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -105,6 +105,9 @@ extern int page_group_by_mobility_disabled;
 #define get_pageblock_migratetype(page)					\
 	get_pfnblock_flags_mask(page, page_to_pfn(page), MIGRATETYPE_MASK)
 
+#define folio_migratetype(folio)				\
+	get_pfnblock_flags_mask(&folio->page, folio_pfn(folio),		\
+			MIGRATETYPE_MASK)
 struct free_area {
 	struct list_head	free_list[MIGRATE_TYPES];
 	unsigned long		nr_free;
-- 
2.40.1

