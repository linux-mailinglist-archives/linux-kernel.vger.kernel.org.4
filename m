Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DF84650BD4
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 13:38:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231474AbiLSMiA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 07:38:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbiLSMh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 07:37:57 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEF6BB78
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 04:37:56 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id ay2-20020a05600c1e0200b003d22e3e796dso6323062wmb.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 04:37:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=g6Me+DBgXsfmWJ38qvhXvaW8D2IHQSt5hD0RyNkeY+E=;
        b=NAh2XJlSv77ASCxFYGMJtxLIjwpUTn1YC0CArWVi7rFEVXnd6kNFdZy5ilWTWxa86i
         WjkLVgey4kBBhYRhwJ7hq79WfifO+tTOWBCcjxZdMRLTzeu4gVpZQY3xFWTvZxPExcLy
         Gg31Ec9XhEmunxVVD4sYo/nc4/aJFmn5cKc412djPFcnsHS5m2CYgZqGK9JsL7exqqUp
         CylW3oiyTdlQYKAc1v79ZYICGsSo6Af5efCs8HcFETdvxB59WcLPxz1eKipHcRZXrJls
         k+IRJFfe+JzBKCKyPToDq0PbNzlJBS/EzdEGgBq4+xvpxjOU7cjikl1EH5h/Ir597TJD
         NBsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g6Me+DBgXsfmWJ38qvhXvaW8D2IHQSt5hD0RyNkeY+E=;
        b=hYzaVnmg6vOW12PyAcCJN1ECPIkgIZcPi2zPkofjfbcfPM/af+ChRP1IDSUey7npVV
         V1a6ifI53WIkoCsDTiEb5ZG3Zab23Ks8rPlfzmBtlyRjv7yhHVU1zSb1mR1TA6kEUpcQ
         z3kPOW1BSJ4FL9gSHn0dB0cfuOWc/WHR+hwK5ErctTagx4H755ix9BUpv8jQ/KAMSnpq
         T0YgNbp7qAl8X/5qJdwT9BCMu1jEe+Ewc0GedvkUXjDoprFrMnOaC4WNAybnhEHuuBRs
         htww0kW5QQNQlNCUfsInVST6aluFc7cK+eEDwcKE7t89rhO0gKKGH3IUAJIvEHqf4y4h
         HYpg==
X-Gm-Message-State: ANoB5pmYEDVTDXIjBeaFxuW6wnt/pd75oMtp2OMH5PoiXoECdShLO4tA
        feiM8tWEIqV5zoGIemhpp8s=
X-Google-Smtp-Source: AA0mqf6vMOah2sbZeg/1NiD8YhY9MhtmRUuiQH47Q6PH9S1K2RoxJihHwKH0XUJ+kL73L1RK3y+kJQ==
X-Received: by 2002:a7b:c053:0:b0:3cf:7385:677f with SMTP id u19-20020a7bc053000000b003cf7385677fmr32578116wmc.35.1671453475410;
        Mon, 19 Dec 2022 04:37:55 -0800 (PST)
Received: from lucifer.home ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.googlemail.com with ESMTPSA id j41-20020a05600c1c2900b003b4ff30e566sm36554330wms.3.2022.12.19.04.37.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 04:37:54 -0800 (PST)
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org
Cc:     Matthew Wilcox <willy@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Baoquan He <bhe@redhat.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>
Subject: [PATCH v2] mm: vmalloc: correct use of __GFP_NOWARN mask in __vmalloc_area_node()
Date:   Mon, 19 Dec 2022 12:36:59 +0000
Message-Id: <20221219123659.90614-1-lstoakes@gmail.com>
X-Mailer: git-send-email 2.39.0
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

This function sets __GFP_NOWARN in the gfp_mask rendering the warn_alloc()
invocations no-ops. Remove this and instead rely on this flag being set
only for the vm_area_alloc_pages() function, ensuring it is cleared for
each of the warn_alloc() calls.

Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
---
 mm/vmalloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index ca71de7c9d77..10fe83c24436 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3031,7 +3031,7 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
 	int ret;

 	array_size = (unsigned long)nr_small_pages * sizeof(struct page *);
-	gfp_mask |= __GFP_NOWARN;
+
 	if (!(gfp_mask & (GFP_DMA | GFP_DMA32)))
 		gfp_mask |= __GFP_HIGHMEM;

--
2.39.0
