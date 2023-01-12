Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2E59667263
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 13:40:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbjALMkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 07:40:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231140AbjALMjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 07:39:54 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93773496CE
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 04:39:52 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id k22-20020a05600c1c9600b003d1ee3a6289so14926540wms.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 04:39:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nvh72pnq+35pgvvJPMgZ8nog2n55QNfKwj25JYsdjLk=;
        b=femgMvhvRMHoBUQrdPDL69x3b05v3v15o093QGsG9jpjlB/Y5S0Sbx7BNVz8opBVue
         UMKh3NQPtcCvjVsWeKoobMleZZDAAvnXaXc/xbzXjsgiBc+98105RM4/FmmvgKnQmP6P
         gjYsVUBDvBxet9J50eSjKCFWGrAE/CMkiripO4FUXf8PmN+rp6AKLKaLaObV6XI9pQ2Y
         LXLPmEAQsMCVfHDL5LiYmtFQF/iFYp9M/J75j6s9qtF61YjFCqrG696W1vTyUCV+XqX1
         X2qVSpi4MPYCrStXilHNMDWJ6UEZy5s4SjqHObQWaHhwB5fCwBMuN4963ydfh2mBXDLJ
         4ySg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nvh72pnq+35pgvvJPMgZ8nog2n55QNfKwj25JYsdjLk=;
        b=XpqBtRV0q7cJwJgEPIzCq1qcQK7ZRYiEPmSPOhgFTaaWgaBoXFwFxIROCIJAL8sc5d
         WGhGoehK3Wk0HHzZxinS4IXomrHc/913naD1gjo7jt6uMC4QuYtcr3poCP5ovPGTLMhS
         AgFosIFnzxBIN0/aAciwjoOoQTQvK+QWHJMmpTGZ1Gx4JX6Jk51gD0+FbtoprzjGUaG4
         N94fdCdRHFn5YEgsAIEC5xyJCEf0pWT08TnR83SkB8vDruWs8jLWSeLy7nEkR2tviQML
         3Pqf8WeK1bpdfIbXMMUQ2yVj82y1Dj3qydNqWTo/HK7Vt1LflupX3pR+LYjhQjUlbMTQ
         3Hvg==
X-Gm-Message-State: AFqh2krfKpZwIe6pCEHlcIvMzGX8QjSBC4vtWt35YbfXgeip/wSs3vw5
        yrGZrhVi0YHCmkHTs/nR1tQ=
X-Google-Smtp-Source: AMrXdXuGOz2E/RV2D78ewdf/hmN+LCFTJ4pM5Bqwd3jJgiH1XouRa68EHum8smPs9741PGl+3Oyf1A==
X-Received: by 2002:a05:600c:5008:b0:3cf:6f4d:c25d with SMTP id n8-20020a05600c500800b003cf6f4dc25dmr54909137wmr.21.1673527190866;
        Thu, 12 Jan 2023 04:39:50 -0800 (PST)
Received: from lucifer.home (host86-164-169-89.range86-164.btcentralplus.com. [86.164.169.89])
        by smtp.googlemail.com with ESMTPSA id q1-20020a1ce901000000b003b3307fb98fsm20890797wmc.24.2023.01.12.04.39.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 04:39:50 -0800 (PST)
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Liam Howlett <liam.howlett@oracle.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Christian Brauner <brauner@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mike Rapoport <rppt@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>
Subject: [PATCH v4 1/5] mm: pagevec: add folio_batch_reinit()
Date:   Thu, 12 Jan 2023 12:39:28 +0000
Message-Id: <9018cecacb39e34c883540f997f9be8281153613.1673526881.git.lstoakes@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <cover.1673526881.git.lstoakes@gmail.com>
References: <cover.1673526881.git.lstoakes@gmail.com>
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

This performs the same task as pagevec_reinit(), only modifying a folio
batch rather than a pagevec.

Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 include/linux/pagevec.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/pagevec.h b/include/linux/pagevec.h
index 215eb6c3bdc9..2a6f61a0c10a 100644
--- a/include/linux/pagevec.h
+++ b/include/linux/pagevec.h
@@ -103,6 +103,11 @@ static inline void folio_batch_init(struct folio_batch *fbatch)
 	fbatch->percpu_pvec_drained = false;
 }
 
+static inline void folio_batch_reinit(struct folio_batch *fbatch)
+{
+	fbatch->nr = 0;
+}
+
 static inline unsigned int folio_batch_count(struct folio_batch *fbatch)
 {
 	return fbatch->nr;
-- 
2.39.0

