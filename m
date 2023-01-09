Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A579A6633C7
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 23:17:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237705AbjAIWQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 17:16:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235601AbjAIWQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 17:16:34 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77EC911C31
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 14:16:33 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id a4-20020a5b0004000000b006fdc6aaec4fso10614428ybp.20
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 14:16:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UAY7ziXR1pDWT8yIaOxG4IQsxtcRX6+lmyo9rcOBFQI=;
        b=UEui1WQccphNYJS2B2rBldr80G72ZMsvoPivgTxDn/fxNbkP3rl2cZegNrl31wiaJT
         YWRA3jP5BrD3xglYqWwZOfFl/74UQK2ntqKI8UxjMlnvXsrObTXRacBD1jvkt9U0pv0N
         Rz6yX12fdD0UTvmPzwtyRL69HEjoWr6xF72eVcgjMKIwVTabZpr1OKMy01LQRmUelK34
         uoJL9SNCI4SOmZf1qKQGaD9pPn6QfObQYClE7Mk4i0jKselSNB1MRU7B3RGPs/M3WYXA
         PmQuYNpgcql7zAPOU+xV8XEM/v8in/FSMDrsPu9J1WTG35YD3VEUUbyMXCfFe8PA+/hf
         OYug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UAY7ziXR1pDWT8yIaOxG4IQsxtcRX6+lmyo9rcOBFQI=;
        b=INMcW7FK04OWuY1c6vpZkScvtheQAaYdplAMdFpCfhnCStLdDvf56f6u7wikwZmzu8
         UcAhRJgdwH5wi8awXLERXqp//Hn4Hsl8GII77JTpSIWrs3AKNwklNjlgaxO3fB7gADbc
         XEIIN1NakT9DjOG75uqe5adz2kw6wyz7Dl7UhYCdBEAwLk6bDy/5XEFNoaD1YBm5yzAQ
         77eftesPpGpJ5Po3IE08m2wQYAZ0sQqQDGdx0E2PfN+lq+569KUtfcGiZxwxhRRuENlj
         6u6ELqeez1//9LLkCvdqecFwwZVhNChEDfr4G/I0D3fuAcfvogHrMd819h5bgZtNaYeU
         8sBQ==
X-Gm-Message-State: AFqh2kq6j2/oGoEJgcbxjCIdahkSv3MVDgSOBf/S0GSK5yDwyvIE1L7G
        7c1gtidT2rQOimxgD68QBZjIkmUZDGWGKA/b4d/Ccg==
X-Google-Smtp-Source: AMrXdXsf7/34OOYlD8ImdQqEPY+KiIDRkgSsEo2WjPbDVqBrR8MswUATMamEBK1Wv6pIN7qPxVRK/kO82VgT8MFNA9fdcA==
X-Received: from isaacmanjarres.irv.corp.google.com ([2620:15c:2d:3:3990:5e50:b0f8:bcdd])
 (user=isaacmanjarres job=sendgmr) by 2002:a0d:d944:0:b0:46a:a08b:b5c9 with
 SMTP id b65-20020a0dd944000000b0046aa08bb5c9mr712139ywe.431.1673302592743;
 Mon, 09 Jan 2023 14:16:32 -0800 (PST)
Date:   Mon,  9 Jan 2023 14:16:22 -0800
In-Reply-To: <20230109221624.592315-1-isaacmanjarres@google.com>
Mime-Version: 1.0
References: <20230109221624.592315-1-isaacmanjarres@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230109221624.592315-2-isaacmanjarres@google.com>
Subject: [PATCH v1 1/2] mm/cma.c: Make kmemleak aware of all CMA regions
From:   "Isaac J. Manjarres" <isaacmanjarres@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Saravana Kannan <saravanak@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        "Isaac J. Manjarres" <isaacmanjarres@google.com>,
        kernel-team@android.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, kmemleak tracks CMA regions that are specified through the
devicetree. However, if the global CMA region is specified through
the commandline, kmemleak will be unaware of the CMA region because
kmemleak_alloc_phys() is not invoked after memblock_reserve(). Add
the missing call to kmemleak_alloc_phys() so that all CMA regions are
tracked by kmemleak before they are freed to the page allocator in
cma_activate_area().

Cc: stable@vger.kernel.org
Signed-off-by: Isaac J. Manjarres <isaacmanjarres@google.com>
---
 mm/cma.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/cma.c b/mm/cma.c
index 4a978e09547a..674b7fdd563e 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -318,6 +318,8 @@ int __init cma_declare_contiguous_nid(phys_addr_t base,
 			ret = -EBUSY;
 			goto err;
 		}
+
+		kmemleak_alloc_phys(base, size, 0);
 	} else {
 		phys_addr_t addr = 0;
 
-- 
2.39.0.314.g84b9a713c41-goog

