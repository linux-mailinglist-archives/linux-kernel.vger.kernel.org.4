Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4DE760609D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 14:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbiJTMw6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 08:52:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbiJTMwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 08:52:54 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FD3617F288
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 05:52:53 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id d26so47138543ejc.8
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 05:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WK/n/LhkGr1JoySFzksopsOUgF3OVJuEP860WPQR98E=;
        b=kAMuBLNSHzFOG1rV1RUFKfDOOX5Ru/a9QO5AhLydiQs8qIxh0zsEaGi9QAGiazj4Ri
         hi0Sr10ni0diYSRpKVxkYOBIbU7en+cwv1Ay01iXWJF2duMc5wQrwUCqAOrxotEUBe7u
         o0VD4iU+y+qsJ25Z8mCtmsWX5Bh1oXIsdJl7tnfppDRdZGfktVLEuUfc1FozFOeFDEJD
         MDzsfwBuC9XDa2OEbQAKVaKGNZMScjEsuy81Ok5EvdUWvudLb1lgopiiNY/3dAxVZhfG
         /CR0D9Vk5iBQvtgHwBHZEHqeb32RUw7ZslsXOIJZ+JDrulV53Wadap2idbrF3zqQS/sb
         Fnow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WK/n/LhkGr1JoySFzksopsOUgF3OVJuEP860WPQR98E=;
        b=wswxNXOpA2eGjd9RgCCxoqQh3jjvZmPqLf3AgwQLbr72p/S0kJ23lTk88Db1Jd4wSt
         H3uIh68+ljU14Qu3JfiiMlyNkxbHSxZTDY6mjQ66PSZ5il1CWD/0kUCvqGQP6LWoT357
         2wXcpY3evwI/DrdO5dABGRq5LWmzgfQvY+/ZVrRVGul2y9KlQX2OYSZpudZl7aff6pOj
         JV7dgpuE58AsIEF5NEZ7v91PNm+htr+Lwlxx2mul5otD2dFdiVYN6VJ/JREMWR/oz5ri
         7YIP/ZmrPHZJUklleLSw0qGj/6WyxPxpPaYWojwiGR/RfnNcL5ZfVw2YBYbwYPvMfeRf
         KFCg==
X-Gm-Message-State: ACrzQf0jftqgHL1uFViXsXxsKsToq9AoDhWcUOU6xRzRnA26S8F/3UY4
        rXU3N4rTS8zC65krVJWPBko=
X-Google-Smtp-Source: AMsMyM5LlHFaCljG+RAp/54cLl1ecwNq+01Y4j296DN3CdV4vyLKNt/rAy/kauNoo+SfXPKCIyRO2A==
X-Received: by 2002:a17:907:80d:b0:73d:a576:dfbd with SMTP id wv13-20020a170907080d00b0073da576dfbdmr10866596ejb.402.1666270371786;
        Thu, 20 Oct 2022 05:52:51 -0700 (PDT)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id cs2-20020a0564020c4200b004585eba4baesm12107456edb.80.2022.10.20.05.52.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 05:52:50 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: [PATCH 1/1] mm: vmalloc: Simplify return boolean expression
Date:   Thu, 20 Oct 2022 14:52:47 +0200
Message-Id: <20221020125247.5053-1-urezki@gmail.com>
X-Mailer: git-send-email 2.30.2
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

A return expression of the __purge_vmap_area_lazy() function can
be simplified. Basically a boolean expression anyway is converted
to boolean values either to true or false.

Suggested-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 mm/vmalloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index bd56f68bedf0..0685b477c71b 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -1787,7 +1787,7 @@ static bool __purge_vmap_area_lazy(unsigned long start, unsigned long end)
 
 out:
 	trace_purge_vmap_area_lazy(start, end, num_purged_areas);
-	return num_purged_areas > 0 ? true:false;
+	return num_purged_areas > 0;
 }
 
 /*
-- 
2.30.2

