Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F3076D837E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 18:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231580AbjDEQTo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 12:19:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230335AbjDEQTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 12:19:38 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EB3C10D1
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 09:19:13 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-23b2fe6c4f9so120294a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 09:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1680711552; x=1683303552;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hIf6WOekKcX5cYk5n6UfHyTuwolCuQ5aOTxYYMf+HPA=;
        b=GyF6XruEcbEScRnuqs6RQtdnVAffeAwDNhR2YCAmw+Qc8S0WRFoL3Sxb4xjqjwQnQq
         OJ8Jiu9y2bolJdZp3mVpP2NSYELRJRHnJhmmEf704erywyOH/2UMAWbPe1zUpU1HuWGv
         VSOVAZddOLhrbspdDkzCd879KiYIXO2SObxHTSB/0VdvDjNYdSg/GRsAtG8hhds2RC8i
         0YQxpgt1eQwUExDD4y4em5xkDQ4Ja2RDE4QesV1V72RAvOfmTpQ6TgOhMRmSY1LBV0Jw
         Y3K4AtG7RcIN10tIjIywe0UgWQ8Pfvq8uXWnf35XFo8HTAEdN8X6iyZOXwZycLtwVXuD
         6flw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680711552; x=1683303552;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hIf6WOekKcX5cYk5n6UfHyTuwolCuQ5aOTxYYMf+HPA=;
        b=xKD0lQ788K8sheYee8YrIRiweT4DYkdmXk5ulTYLBj3E6QiFAkw1hF//otLfo5MSvI
         gse17g+wa2sSbhI7qfGJn/IPxqXbz18ViHa82JmZhBDE+YGpmJtVU640u7VCmfoO9DV/
         q7yYwIhdVsQEN2LZrAp06TaU9m33HEadDRJNLcPnoexhj7dBNPOWHOAEB3FUxFlnWhto
         q0vO5CH5Gbcmvu5fTt6eme6tKOYCQ1Z+y2/ApgoqAXLZQWEb8LusdtRn7J/2kh7VYCud
         D+bCsQVqc/G5T4RFbDPe6YCHaAP9KrTQPjow4gIzb4awvqSciv7BrEQQPqijge/bUNzA
         +lnQ==
X-Gm-Message-State: AAQBX9dgE7eJMWtdijOiW1zBYN9is4g9zoZk6SIJ4WgKCwWfagWYMCpe
        NyNbrYfWTuxdG6n/KyaRXMrmCw==
X-Google-Smtp-Source: AKy350YuR4SzIqLhfXjHdCg5Q5TcgtTe9L4cP8UXNGekibda/wa7NCXzFPTK0foK5aYzgJ9lqM59Vw==
X-Received: by 2002:a05:6a00:139d:b0:62d:e32a:8b5a with SMTP id t29-20020a056a00139d00b0062de32a8b5amr2835918pfg.2.1680711552583;
        Wed, 05 Apr 2023 09:19:12 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id x24-20020a62fb18000000b00582f222f088sm10878011pfm.47.2023.04.05.09.19.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 09:19:12 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, willy@infradead.org, lstoakes@gmail.com
Cc:     mgorman@suse.de, vbabka@suse.cz, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v2 2/2] mm: mlock: use folios_put() in mlock_folio_batch()
Date:   Thu,  6 Apr 2023 00:18:54 +0800
Message-Id: <20230405161854.6931-2-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230405161854.6931-1-zhengqi.arch@bytedance.com>
References: <20230405161854.6931-1-zhengqi.arch@bytedance.com>
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

