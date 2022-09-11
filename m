Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB595B4D21
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 12:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbiIKKAC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 06:00:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbiIKJ7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 05:59:39 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B8E51150
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 02:59:30 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id cb8so4364451qtb.0
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 02:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date;
        bh=OPh2SoeDJ39bM1Jn5fFI8VsUd8dRA2153uVq4iTm5YA=;
        b=Cm/iwBj9qSxR6hNh4WkGnlY2rIhzISZ52M2GqSDfU7xNlfLTD1kDBK3GW4JyIWLpbF
         vFCNPAJLgXJtsglJR9PAeKY44F6cjvaw6tuS4MXxA20nHmxmD/wqzebHgdbHMGmAD61N
         ZV4Tr5DVsNuioBerAQQDoJ4+a5mniKGiZRxoUQiZlNMllJ4sclh03nAFz08cVB8ODhMT
         Skx+FX/f8czauTMll515ktdu7gVSZJA1f7251v/yIj0BzYslEFQQtKX5F2MkHK/8CwmU
         Hx7spxOmVfuUwec09wkdbVsfFyOD1wVjfc69FUWeWsnCvU5bgK+iVzVBPk9GSB7Lao7h
         VxvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=OPh2SoeDJ39bM1Jn5fFI8VsUd8dRA2153uVq4iTm5YA=;
        b=kC7ZbpmxzSc7NBivbB4Pp3TUXZ0x12aLS2aiDKrdyhgSiTnXCpDGOGTLSUrwB45POq
         zG6c7LtN3X9itGrgloqs7VcUDml25/HhmlewPnOratRK5SivcFieOrIqSZ5YgKJJlTy5
         GDC1LwlDReZx3ESrBjKMkeFsUyVnAO+eDOTWQv3CbBrPloDDUAY6xy6dNYa4rpceEGK1
         AxZkx0SsrEzKrHrnL0RGlxoUlPaLMVcwZtV1cUz+JRAKK1KX0HlNVIh6oBtFloNz1yFP
         30TzUAtWxE1O0p/YrMNI5hIiKTStsAoZyv1QIX1QaBaJsJ32VtmpzuCNn3KAwvJ8hPAF
         EU4A==
X-Gm-Message-State: ACgBeo1zkHN1GR84iF2ClWsHScOPB4TQ1w5XVLMnlUIiqlqDNT/PDZiP
        dXEHIkxf8E6UIYqAxkm5dVtm1w==
X-Google-Smtp-Source: AA6agR5J3Cn9HvOjdYaL72tcgWTBN3wcKIFFTOLz4o2e2o7b+hMrlixH3K7CPiJSXhwkuBn1HYdkSA==
X-Received: by 2002:a05:622a:609:b0:35b:acd0:21ff with SMTP id z9-20020a05622a060900b0035bacd021ffmr3764909qta.321.1662890369441;
        Sun, 11 Sep 2022 02:59:29 -0700 (PDT)
Received: from soleen.c.googlers.com.com (240.157.150.34.bc.googleusercontent.com. [34.150.157.240])
        by smtp.gmail.com with ESMTPSA id y29-20020a37f61d000000b006cbd60c14c9sm4625233qkj.35.2022.09.11.02.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Sep 2022 02:59:28 -0700 (PDT)
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, akpm@linux-foundation.org,
        corbet@lwn.net, linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, rick.p.edgecombe@intel.com
Subject: [PATCH 1/3] mm/page_table_check: Check writable zero page in page table check
Date:   Sun, 11 Sep 2022 09:59:21 +0000
Message-Id: <20220911095923.3614387-2-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
In-Reply-To: <20220911095923.3614387-1-pasha.tatashin@soleen.com>
References: <20220911095923.3614387-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rick Edgecombe <rick.p.edgecombe@intel.com>

The zero page should remain all zero, so that it can be mapped as
read-only for read faults of memory that should be zeroed. If it is ever
mapped writable to userspace, it could become non-zero and so other apps
would unexpectedly get non-zero data. So the zero page should never be
mapped writable to userspace. Check for this condition in
page_table_check_set().

Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 mm/page_table_check.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/page_table_check.c b/mm/page_table_check.c
index e2062748791a..665ece0d55d4 100644
--- a/mm/page_table_check.c
+++ b/mm/page_table_check.c
@@ -102,6 +102,8 @@ static void page_table_check_set(struct mm_struct *mm, unsigned long addr,
 	if (!pfn_valid(pfn))
 		return;
 
+	BUG_ON(is_zero_pfn(pfn) && rw);
+
 	page = pfn_to_page(pfn);
 	page_ext = lookup_page_ext(page);
 	anon = PageAnon(page);
-- 
2.37.2.789.g6183377224-goog

