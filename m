Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7D636D5FCD
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 14:01:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234553AbjDDMBe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 08:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234530AbjDDMBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 08:01:30 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C374335BD
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 05:01:29 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id gp15-20020a17090adf0f00b0023d1bbd9f9eso35910225pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 05:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1680609689;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BXv1GcIP0b01WCB0dxAHE5qtL4a0jd48WmxV6aMJGEI=;
        b=GhUPSo9sh6Zwwfo4h+KoyiwNBesV7G+G8J1L0pQX0JIU2wZv09kHmO7svPlTwq7tWY
         W0Wc6i0y6qoBqfdiEgvioqzZqSn479UQH0LZb+QYhGBOawXvCQgAYwZy+crfeg95NXWc
         /4gHmZ1MbS8u0pbiY4snCi0+AH22BTnSmnjRM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680609689;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BXv1GcIP0b01WCB0dxAHE5qtL4a0jd48WmxV6aMJGEI=;
        b=0f1tej/pgTWeO228olyOCajS/CUl4dCVzmlxRTz0MCGomPNF+F0h3S3By41HYaS5Sx
         Zp0HLaSk3mmszvNEwpsT6x865eGeLayoVm8VhipmpyWU/WKBPRT0xjvhOyAg4yt5eNLU
         wl29EbLki7y/sArY0WyfZdMoEVcOfN/aq7bwTKXXnLcIcxCGWZ77YXNs+tyTlTmALKKI
         wEVtrGchhhaaDv4+23y2o3sR/7ZpuRjtgWupRFoDpzMY5o94EsNWdI17olcW4/eYMe5K
         +D/bWTp+bXvCFntNWXsNGohMjTuTeOLJzNkBhALsPnEPef/HdSz8xnst/Pz8P8dr19NT
         nGlw==
X-Gm-Message-State: AAQBX9dVhtuCjkscNNl1cbAxgxLGpZpSpIgOtm3ACB6wYMn+N92n4jJw
        Yf5JhOcVbix/bHPBqFdId5zJcQ==
X-Google-Smtp-Source: AKy350asjKP3U0+twDNYb29W50NssXzM9KfQVg707hZ1pElnupMPu2X9cFoRAu3bB4exQZa/RnwHDg==
X-Received: by 2002:a17:903:32c2:b0:1a2:98b1:1ee2 with SMTP id i2-20020a17090332c200b001a298b11ee2mr3128683plr.15.1680609689270;
        Tue, 04 Apr 2023 05:01:29 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:959b:21ea:166b:c273])
        by smtp.gmail.com with UTF8SMTPSA id l2-20020a17090aec0200b0022335f1dae2sm7834214pjy.22.2023.04.04.05.01.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Apr 2023 05:01:28 -0700 (PDT)
From:   David Stevens <stevensd@chromium.org>
X-Google-Original-From: David Stevens <stevensd@google.com>
To:     linux-mm@kvack.org, Peter Xu <peterx@redhat.com>,
        Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Yang Shi <shy828301@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Jiaqi Yan <jiaqiyan@google.com>, linux-kernel@vger.kernel.org,
        David Stevens <stevensd@chromium.org>
Subject: [PATCH v6 1/4] mm/khugepaged: drain lru after swapping in shmem
Date:   Tue,  4 Apr 2023 21:01:14 +0900
Message-Id: <20230404120117.2562166-2-stevensd@google.com>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
In-Reply-To: <20230404120117.2562166-1-stevensd@google.com>
References: <20230404120117.2562166-1-stevensd@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Stevens <stevensd@chromium.org>

Call lru_add_drain after swapping in shmem pages so that
isolate_lru_page is more likely to succeed.

Signed-off-by: David Stevens <stevensd@chromium.org>
---
 mm/khugepaged.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 666d2c4e38dd..90577247cfaf 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1963,6 +1963,8 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
 					result = SCAN_FAIL;
 					goto xa_unlocked;
 				}
+				/* drain pagevecs to help isolate_lru_page() */
+				lru_add_drain();
 				page = folio_file_page(folio, index);
 			} else if (trylock_page(page)) {
 				get_page(page);
-- 
2.40.0.348.gf938b09366-goog

