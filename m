Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4031F67E49C
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 13:06:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231593AbjA0MF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 07:05:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232427AbjA0MFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 07:05:19 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D63C780152
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 03:59:45 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id b10so4413237pjo.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 03:59:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SJQyMP8KtEdsdoG1W/rDTY2sHvstU2onoiuLNZSdqRA=;
        b=PwU/MxFfxjI7rblgdodb3z+Ia427ZsfwVdOF5RDiO/To4doDp3lZnreegyJfPEUcfL
         eMYGGqaiTVYl2nj9mjtC2cRdIuJMHr9zsy/cqlzL1LLDupBEagQYpzOg9MF5k7wwDVO6
         +uRNVvqRI45PPuMAJE27a2lKwMNPX+QPvK6S0mW4poSVFW30+k1M2I5JQSCLTotDkXos
         PfyeHOKKSe8VN/rVEQwedqsC8mvy9wQLEtnBo1BQBkQlNifURH7ZR3Pd5O+NvakkPWiT
         CstnuWhVJKO5XDJcqPRnF2KyAZiN9LqFVF9UT53wpNdYXX8UIHuY+fpn/+Zvw9ptPolF
         Z4IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SJQyMP8KtEdsdoG1W/rDTY2sHvstU2onoiuLNZSdqRA=;
        b=m4HMmo2+vDR/esydID9uFXajR7JDB3cokuBtKmv8fwKCRxmKalQHqYzqm7ASreHU8/
         s6sZYp/bABurcVN0gfl0LiyeGmJeyMSH+GtJzmkvnJSCTQHLOZ2aARwyoF98XfXFI/bS
         8SaWfALGdnE74WUnbgdnoTa66zJ6ejbvjuzG87t4Re1lLr1d1K8KwJDGvLQfaLj/lHoi
         h79oZ5+P0sFDifq25aMG705Hp0tPKySCl27Z7h5i+jEBDE+ZoNS5xSk74jmysuifGv2O
         cNPLvX1Nj6LbCYwCbk84TEVznCNhFndTfT29GpQoe0LLyy8NCg9xodJm6Ui2lH7YO1Ji
         qvKA==
X-Gm-Message-State: AFqh2kpulDryqa5QpwpFcOdHpSy6J6B88VUQDj4HDXJOBbdLU+efwkEj
        5C8yhNxWhkYJWQKLU2tPGbI=
X-Google-Smtp-Source: AMrXdXs5qdqdD1dcu7VPXFaAEJULrNvcKAOlo7ycLqi1WJSgPC7qNCKHNlSBkhnd9pymGsdCaOPEjQ==
X-Received: by 2002:a05:6a21:3a82:b0:b8:7d48:2860 with SMTP id zv2-20020a056a213a8200b000b87d482860mr44988169pzb.4.1674820729118;
        Fri, 27 Jan 2023 03:58:49 -0800 (PST)
Received: from min-iamroot ([210.91.70.133])
        by smtp.gmail.com with ESMTPSA id y191-20020a638ac8000000b004d182686e08sm2324994pgd.39.2023.01.27.03.58.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 03:58:48 -0800 (PST)
Date:   Fri, 27 Jan 2023 20:58:44 +0900
From:   Hyunmin Lee <hn.min.lee@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Christoph Hellwig <hch@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH] replace BUG_ON to WARN_ON
Message-ID: <20230127115844.GA1124261@min-iamroot>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace unnacessary BUG_ON to WARN_ON. These BUG_ONs verify aruguments of a function. Thus, the WARN_ONs return an EINVAL error when their condition is true.

Co-Developed-by: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
Co-Developed-by: Jeungwoo Yoo <casionwoo@gmail.com>
Co-Developed-by: Sangyun Kim <sangyun.kim@snu.ac.kr>
Signed-off-by: Hyunmin Lee <hn.min.lee@gmail.com>
Signed-off-by: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
Signed-off-by: Jeungwoo Yoo <casionwoo@gmail.com>
Signed-off-by: Sangyun Kim <sangyun.kim@snu.ac.kr>
Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>
---
 mm/vmalloc.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 74afa2208558..9f9dba3132c5 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -1587,9 +1587,14 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
 	int purged = 0;
 	int ret;
 
-	BUG_ON(!size);
-	BUG_ON(offset_in_page(size));
-	BUG_ON(!is_power_of_2(align));
+	if (WARN_ON(!size))
+		return ERR_PTR(-EINVAL);
+
+	if (WARN_ON(offset_in_page(size)))
+		return ERR_PTR(-EINVAL);
+
+	if (WARN_ON(!is_power_of_2(align)))
+		return ERR_PTR(-EINVAL);
 
 	if (unlikely(!vmap_initialized))
 		return ERR_PTR(-EBUSY);
-- 
2.25.1

