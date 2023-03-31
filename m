Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B24A6D1D97
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 12:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231450AbjCaKGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 06:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231630AbjCaKFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 06:05:14 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9963E22EBC
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 02:59:42 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id p13-20020a17090a284d00b0023d2e945aebso8347625pjf.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 02:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1680256749; x=1682848749;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hIf6WOekKcX5cYk5n6UfHyTuwolCuQ5aOTxYYMf+HPA=;
        b=PtPhmg2aC8P+Z4aYfe2wqtWdqq0d75n9RQ8QZGKaFFSoQGsEsznX0levtSQfAUQpyE
         QmaoqKMHKyq6/wvyKOuqug7BvzKHuy4Wq+9cGKRvRDRb4uK9pl9/MXwxtOCMDeixkWFO
         AJGsLyamMKz79eF4DHPffk3B6A05IsXirDqFUCjz9sluWrOphcBmob3JkKsqaWS2K3tR
         v7NK4C5XZcOGpXL7F3qVduMlRWL01WXawCXVPBgKjDM9YShB7nXYjAN8JsGRuOWlnUGm
         H9jD1lHNXyeTKCkKqzVPnjKjuBnCgFRhOSEUPVHDgAFduxFDLbw5XIMdnWymcdxc3M3x
         O4ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680256749; x=1682848749;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hIf6WOekKcX5cYk5n6UfHyTuwolCuQ5aOTxYYMf+HPA=;
        b=Kbhz050uh+sTiffr4wH/4pKuimCto0d7QYr8x3PV7kttmGpcAvCn9bYxEjpE55wzbt
         NvG+GyOjdzwvm9XJ2CEa+lSU+ADC9mvOGxCPakW9PlZxJXmt+8TF9yIC+Eodeb7gSYJI
         bTdJk89LzlyPOJpeTIq2w4NqQGhvLlyx5ub4XbS+kBOjWSsR4zyZxNa4mLryjcXYM5Ok
         HBsHd3wuc8sYS+Dcver+1SHVW9PcceKdtJ8CTtOb0Po9XuADA11OGNDjNrbguPYH0q+d
         fFvQgqZ3CkvId0dqAf6uQsTge121ZbZVkClX3bTaq8oTzKn3UDgM3I0XDUbB06QFRcCA
         R5iw==
X-Gm-Message-State: AAQBX9fXz11rqglcK7VYL+Hbqd7xvK+QDvEm9i2i8qbiyugbP5ia99nz
        FfmsZ27S0QgU0u0IAdMUn/5irg==
X-Google-Smtp-Source: AKy350bQYsmvZCOvPIdQYw8Q5eFd+Wh2raKdTzdYDwVhc3Nb0vtD/ATqqq41Bz/ZUdCmYm+HG/JQRQ==
X-Received: by 2002:a17:90a:d195:b0:236:7144:669f with SMTP id fu21-20020a17090ad19500b002367144669fmr22262989pjb.2.1680256749585;
        Fri, 31 Mar 2023 02:59:09 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.229])
        by smtp.gmail.com with ESMTPSA id oo5-20020a17090b1c8500b0023b3179f0fcsm4687782pjb.6.2023.03.31.02.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 02:59:09 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, willy@infradead.org, lstoakes@gmail.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH 2/2] mm: mlock: use folios_put() in mlock_folio_batch()
Date:   Fri, 31 Mar 2023 17:58:58 +0800
Message-Id: <20230331095858.51810-2-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230331095858.51810-1-zhengqi.arch@bytedance.com>
References: <20230331095858.51810-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since we have updated mlock to use folios, it's better
to call folios_put() instead of calling release_pages()
directly.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 mm/mlock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/mlock.c b/mm/mlock.c
index 617469fce96d..40b43f8740df 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -206,7 +206,7 @@ static void mlock_folio_batch(struct folio_batch *fbatch)
 
 	if (lruvec)
 		unlock_page_lruvec_irq(lruvec);
-	release_pages(fbatch->folios, fbatch->nr);
+	folios_put(fbatch->folios, folio_batch_count(fbatch));
 	folio_batch_reinit(fbatch);
 }
 
-- 
2.20.1

