Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1620681D0D
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 22:44:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbjA3VoE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 16:44:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbjA3Vn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 16:43:58 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD9981732
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 13:43:56 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id nn18-20020a17090b38d200b0022bfb584987so12489499pjb.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 13:43:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ediNP9jmTx5MiZXyPNx7A5RKRq6cvf2YdQqsm1ekQJg=;
        b=PBaFoOSG+jh+Xjk4yu5k0mclCq95zVowkLwfwnozwaJGsZ7dJuUO+HAwSj2CnMiWu2
         04OjiWdzrsGfsiNhiAN8aI91IRKA+6362I3k3iKQYr21do8lFKqzPXLqL6iPOJSxvDm8
         ESs/tnac1+S84ztkx0YgGN0x3NIN3ai8D6zq2CVxcbmdeK2SmbKzjLD3nVv4XyHiLp3z
         BA+QOsuRp7JdeNdp8HrY1T1o3fGUajdyiy9WJdxE66pg9lzEfEmcADYX3qVB7MkJcotn
         TkujXEQLlM/xDXB9oy/BbqiTPHEbCAbrHMBDu37iilqmoWmBkMcRcAOTM5RKP4Qzejlk
         Q9zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ediNP9jmTx5MiZXyPNx7A5RKRq6cvf2YdQqsm1ekQJg=;
        b=jwAkguSsA5fTpOvquE5iRay7J3d34TjzHf72sa17/ugcaAiMIP0pS6dO9ibpp+LVEv
         I519s7kXhxFacM20pr0bXEQV0iQhCELMefmCsPMb8PFKcbi99p/hp1JXHEDLHT9HArQS
         lkTJ1MGIBulzC8ZjCWxwxsSPeaf2FgQaAqY2jq/I5Or2XQxkTDCodK4Zn3WrnLcAcz+r
         1XmhuWVwie9sWkaB/QRR31q/DwbmWcX6WfztdcBOV6FivrSryk1PNgYFDF5/a/O+EUoD
         YduU9M1MFFXcgMMlvQ4gPsPCYdKtXNm2fjbbD6L8TLGlHXXFsaDlGuC3y5HQ7nqqi80E
         aTeQ==
X-Gm-Message-State: AO0yUKXhg8Xoj9qs9Ne4B2Vk5AS/G8VIfn/APFHV6dR7cA3gM4UGYF86
        6SYOYcdwhyTrgwL0gfyNQeWTvDLF08E=
X-Google-Smtp-Source: AK7set+vv9jj+URyyrDpX/kMFZKfmRfYhOWM9Dd+Bv8gep0RDdihfzO4kLqoGfEgi8XlOrozIiYlmw==
X-Received: by 2002:a17:90b:1a92:b0:22c:d57:519f with SMTP id ng18-20020a17090b1a9200b0022c0d57519fmr10945094pjb.34.1675115036137;
        Mon, 30 Jan 2023 13:43:56 -0800 (PST)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:937f:7f20::a8cd])
        by smtp.googlemail.com with ESMTPSA id d5-20020a17090a628500b0022bbad75af6sm25156403pjj.1.2023.01.30.13.43.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 13:43:55 -0800 (PST)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, willy@infradead.org,
        linux-kernel@vger.kernel.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH mm-unstable v2 1/4] mm: Add folio_get_nontail_page()
Date:   Mon, 30 Jan 2023 13:43:49 -0800
Message-Id: <20230130214352.40538-2-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230130214352.40538-1-vishal.moola@gmail.com>
References: <20230130214352.40538-1-vishal.moola@gmail.com>
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

folio_get_nontail_page() returns the folio associated with a head
page. This is necessary for folio conversions where the behavior of that
function differs between head pages and tail pages.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 include/linux/mm.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index dd295c020e85..5da260346406 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -879,6 +879,13 @@ static inline bool get_page_unless_zero(struct page *page)
 	return page_ref_add_unless(page, 1, 0);
 }
 
+static inline struct folio *folio_get_nontail_page(struct page *page)
+{
+	if (unlikely(!get_page_unless_zero(page)))
+		return NULL;
+	return (struct folio *)page;
+}
+
 extern int page_is_ram(unsigned long pfn);
 
 enum {
-- 
2.38.1

