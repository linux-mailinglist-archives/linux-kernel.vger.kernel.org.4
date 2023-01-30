Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C06FD681B36
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 21:18:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbjA3USu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 15:18:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjA3USn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 15:18:43 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57EE7474F1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 12:18:42 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id z1so5698620pfg.12
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 12:18:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j/4S2TO195EZhvaFVO5pP2w+KNwU4ZdXZTJQBP7AkLA=;
        b=hKmaa5zWwzaA/eQzJXW/p3AbrjuCU1hJ1WqkvmCe5OjsEJy/zfYO3gyiHtXR/Nmicc
         QZYQqjBrrsHy42KLOqyKPLFiE5ljyx3lwnU1LSjg+iAeh/HHn2CxRLuBmV3I3qMAz3Cs
         Ne58gJfHTpr0l9umv4lK3maRT5u4n0kTDHo9ZkK8oU0BjWL11GtJTad04BQMCWmHBz73
         nH6tcsBm9sz+Ea1dWSlI9Fiy3dis8DFNKppIY2bXLHu8vR2JqgBcaxoficz3AoWBJM+Z
         2TO/3iaXYb46sgGXjY60MgE+Ka+7Z3DLxW15j0perrbJldV7bVy5hroX5c6xfkxUhZlH
         EkRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j/4S2TO195EZhvaFVO5pP2w+KNwU4ZdXZTJQBP7AkLA=;
        b=NWvJOy3O+hWsOxBHT/m/OzqsCd2mJQDbxn5SP2MLB/CYWtkqOi1Y3BTakINeK6gXBP
         beI1aBdF+i5WPbi24ndhcqihTmZB3DSA9xcyHb07CDVA2D8nRaL8s09aquNDkX5ZroDb
         oYX0sq2BRSY3QfnE5o+soWAMSsK8DvwrUvoSZ4Wmw5tqOhCnmMHAVuOHaHAT4UVYAdl5
         jieob5F45bfBpebEOVO+DNP0qJvWTJHUtzINWl0McdaNdTwZxKrZg9EaNmj7mzpiJ6Jj
         1TZ05knY89+RetTo32OWsZZJ1ah12N/Kgc2ORZBHMIcG/9ByLGQceBpjnU2S/4EUBM+2
         e9Tw==
X-Gm-Message-State: AO0yUKUT0ZRT+LZuLPPic5ag7oyUG7Xx3ocYEyLM/z6N5H7UcobJ9Umb
        FA7QLaJd/8qDbBXMZ3sXyzI=
X-Google-Smtp-Source: AK7set8Ihsg+3xvIHWQXAyP08XWpzy8TCdCFoKOEqxjzQ3NsmeF6Ie0PReDCSFAdVbc4D07D2h75hA==
X-Received: by 2002:aa7:8c54:0:b0:593:93db:5f63 with SMTP id e20-20020aa78c54000000b0059393db5f63mr8994693pfd.23.1675109921811;
        Mon, 30 Jan 2023 12:18:41 -0800 (PST)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:937f:7f20::a8cd])
        by smtp.googlemail.com with ESMTPSA id g9-20020a056a000b8900b0058d9730ede0sm113262pfj.210.2023.01.30.12.18.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 12:18:41 -0800 (PST)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH mm-unstable v4 1/6] mm: add folio_estimated_sharers()
Date:   Mon, 30 Jan 2023 12:18:28 -0800
Message-Id: <20230130201833.27042-2-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230130201833.27042-1-vishal.moola@gmail.com>
References: <20230130201833.27042-1-vishal.moola@gmail.com>
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

folio_estimated_sharers() takes in a folio and returns the precise
number of times the first subpage of the folio is mapped.

This function aims to provide an estimate for the number of sharers of a
folio. This is necessary for folio conversions where we care
about the number of processes that share a folio, but don't necessarily
want to check every single page within that folio.

This is in contrast to folio_mapcount() which calculates the total
number of the times a folio and all its subpages are mapped.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 include/linux/mm.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 27b34f7730e7..c91bf9cdb3d0 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1905,6 +1905,24 @@ static inline size_t folio_size(struct folio *folio)
 	return PAGE_SIZE << folio_order(folio);
 }
 
+/**
+ * folio_estimated_sharers - Estimate the number of sharers of a folio.
+ * @folio: The folio.
+ *
+ * folio_estimated_sharers() aims to serve as a function to efficiently
+ * estimate the number of processes sharing a folio. This is done by
+ * looking at the precise mapcount of the first subpage in the folio, and
+ * assuming the other subpages are the same. This may not be true for large
+ * folios. If you want exact mapcounts for exact calculations, look at
+ * page_mapcount() or folio_total_mapcount().
+ *
+ * Return: The estimated number of processes sharing a folio.
+ */
+static inline int folio_estimated_sharers(struct folio *folio)
+{
+	return page_mapcount(folio_page(folio, 0));
+}
+
 #ifndef HAVE_ARCH_MAKE_PAGE_ACCESSIBLE
 static inline int arch_make_page_accessible(struct page *page)
 {
-- 
2.38.1

