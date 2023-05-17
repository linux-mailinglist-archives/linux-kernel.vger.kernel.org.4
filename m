Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63925705D12
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 04:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231921AbjEQCVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 22:21:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231899AbjEQCV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 22:21:29 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A4E940EF
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 19:21:28 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-ba8337a578dso151746276.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 19:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684290087; x=1686882087;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DmZ7qJu2QJbmubDEgRMJhswdry7Qhukww11ZPOJRgvs=;
        b=pXVJppsksfHh4I2n3d8xVcufhKZZlJjnCny+rmQ4mjQKI0AW/cCK2hASK83KfSiYpL
         SwH5TVvYpvNqffEsNvDPgC+nhgLYFM3KaqHCuYbPaIFzls2lqfx0JYU50+6NVWzrME9W
         1mfRz5hwNYEvKHUFnlT4dknNheNNzedfdZLSkBZlu7QlWmiIOdq/l+RcVRDobfHZBP0c
         7otPYVh11OT4odfN5rNmMB6Xfe/sUmOnKNfozY8i+NNWwTSKo6jWbGtluyHsGeqrt/Um
         gaSjHg7Sh7LXhrO/UUQMLAjulMUlLvxOhNHHmrBn6+ZKABwqhlZs4QhdwbdE4TaSFaoL
         o8HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684290087; x=1686882087;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DmZ7qJu2QJbmubDEgRMJhswdry7Qhukww11ZPOJRgvs=;
        b=e0ftyAVCqq0vRIdKMF0bGZLpGogtMPzjlg4t1U0bEifTF8sPW2g/m4qPHPP7hMcoo2
         Pw3wqQPyLXdsPHy5t7tVwmHuimJMpbduAZBxm1XNiS/CSDtbfCU2cCcTMpFjQ6g5DGWq
         NgZh7X7IR6cx1lt4u4MgvXVIz6vshHRyI1hCkigYH0rjgOPm5feIhvuDt64bZUqzjmxe
         8OFsdRQSyoJAxlzcPH/Zq2wpqe/iIj3fgijCHnHP/gZutFL0tRWyp8U5WmLVlEpF9mf8
         H8QqRJgcqsEAor9HDI5iDURQMQTv/x6BKAnbBiLGayDNd5GHzsp+CfspiTyLoXiiVBoI
         L7zQ==
X-Gm-Message-State: AC+VfDyZec4nQXNQQ17UaFIPhwAiiuj4uoQACgfBnb8W1MAacB3XvOuf
        Q/7w9KbMD/FFTW4ppXUh63AHn+o=
X-Google-Smtp-Source: ACHHUZ5CS7mk6mAM2fYvrtpJa+GCdOe26eXVwKAHAWQiAcvcFXtzYZLVtM0rm9Ojto/ISeUmGRcWqts=
X-Received: from pcc-desktop.svl.corp.google.com ([2620:15c:2d3:205:b3a7:7c59:b96b:adaa])
 (user=pcc job=sendgmr) by 2002:a25:8407:0:b0:ba8:4b22:4e8a with SMTP id
 u7-20020a258407000000b00ba84b224e8amr1065312ybk.0.1684290087741; Tue, 16 May
 2023 19:21:27 -0700 (PDT)
Date:   Tue, 16 May 2023 19:21:12 -0700
In-Reply-To: <20230517022115.3033604-1-pcc@google.com>
Message-Id: <20230517022115.3033604-3-pcc@google.com>
Mime-Version: 1.0
References: <20230517022115.3033604-1-pcc@google.com>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
Subject: [PATCH v3 2/3] mm: Call arch_swap_restore() from unuse_pte()
From:   Peter Collingbourne <pcc@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Peter Collingbourne <pcc@google.com>,
        "=?UTF-8?q?Qun-wei=20Lin=20=28=E6=9E=97=E7=BE=A4=E5=B4=B4=29?=" 
        <Qun-wei.Lin@mediatek.com>, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "surenb@google.com" <surenb@google.com>,
        "david@redhat.com" <david@redhat.com>,
        "=?UTF-8?q?Chinwen=20Chang=20=28=E5=BC=B5=E9=8C=A6=E6=96=87=29?=" 
        <chinwen.chang@mediatek.com>,
        "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>,
        "=?UTF-8?q?Kuan-Ying=20Lee=20=28=E6=9D=8E=E5=86=A0=E7=A9=8E=29?=" 
        <Kuan-Ying.Lee@mediatek.com>,
        "=?UTF-8?q?Casper=20Li=20=28=E6=9D=8E=E4=B8=AD=E6=A6=AE=29?=" 
        <casper.li@mediatek.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        vincenzo.frascino@arm.com,
        Alexandru Elisei <alexandru.elisei@arm.com>, will@kernel.org,
        eugenis@google.com, Steven Price <steven.price@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We would like to move away from requiring architectures to restore
metadata from swap in the set_pte_at() implementation, as this is not only
error-prone but adds complexity to the arch-specific code. This requires
us to call arch_swap_restore() before calling swap_free() whenever pages
are restored from swap. We are currently doing so everywhere except in
unuse_pte(); do so there as well.

Signed-off-by: Peter Collingbourne <pcc@google.com>
Link: https://linux-review.googlesource.com/id/I68276653e612d64cde271ce1b5a99ae05d6bbc4f
---
 mm/swapfile.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 274bbf797480..e9843fadecd6 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1794,6 +1794,13 @@ static int unuse_pte(struct vm_area_struct *vma, pmd_t *pmd,
 		goto setpte;
 	}
 
+	/*
+	 * Some architectures may have to restore extra metadata to the page
+	 * when reading from swap. This metadata may be indexed by swap entry
+	 * so this must be called before swap_free().
+	 */
+	arch_swap_restore(entry, page_folio(page));
+
 	/* See do_swap_page() */
 	BUG_ON(!PageAnon(page) && PageMappedToDisk(page));
 	BUG_ON(PageAnon(page) && PageAnonExclusive(page));
-- 
2.40.1.606.ga4b1b128d6-goog

