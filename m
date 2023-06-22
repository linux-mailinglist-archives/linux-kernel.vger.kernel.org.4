Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D99F0739E8C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 12:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbjFVK1n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 06:27:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjFVK1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 06:27:40 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F21F5D3;
        Thu, 22 Jun 2023 03:27:39 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3f9c532f9e3so15950755e9.1;
        Thu, 22 Jun 2023 03:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687429658; x=1690021658;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HNBLuqw9En2G21h+WbiEp4rYwK/zPxLAjR8JVifNIMU=;
        b=Gm9kFmFGSjUIWl+mD1+q9YGb2KNmJsxCR97+KEn+BXYSYhNLLHcK8INUrfhmHfH3Rg
         tLboBrH00ryT8rMmIrLFgCL8u8mPN8yvpb5yK2rE+BS/D3HDa10flbU7V0hMadCuz+LY
         86hfggpQ7CofYNlniE3OEaDQ13txw8rqII71kvNN+EQl5ewAVeX1xiDLLAQ6DKfeMcYX
         cG8q7305iU9EzNby0MHEdDIKX+rglW+nQlbQzjcaa3LJQ0oj2C2TRAvXjntk3X0Z+F4R
         M9qvfeKXdYsdBUCWccJ4Emfhnw1RjmZkfJRXxrA4I4/AW6KDyI2Gh5D6f9AenFlwQrsI
         XZEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687429658; x=1690021658;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HNBLuqw9En2G21h+WbiEp4rYwK/zPxLAjR8JVifNIMU=;
        b=cocVO/oB/NfRy5Y0m9gldHyI18KCoNM960S/XZG3WZw//AqecIt9Nk0ftdwhN7ioxA
         d/EvjzYkqWTEZ9sku/K1CrVVqcQ4IuIJ7LKIAEHySp8MVCrBE0+n2/fMVnmcPCydk4Ve
         R9ENRx+BqcMC2vn4TyOuqPhfyPH3gkuqJ7G+L+5aYY5hz3cgtD3/LQkQyhTK2FnCFlAO
         gzyc3csRlXgOLduaiQkC4NMsEJhTr33daBKvSRUfe1l/3xM6mTYEoVTGphWyKFJCljj4
         EIFVq9ImPdJzw62/i0vz4+7aqBHtPbpszH8oCEmD8/4XmsCpfzlWUbHOTV9eY8jyD+o0
         99xA==
X-Gm-Message-State: AC+VfDw8RVSXO6BPazs42xgtExBGE4b38ksP+HTBeibrOPn1dGGyvapv
        vh+Kzv7ZvTpgS+FullhgJVM=
X-Google-Smtp-Source: ACHHUZ6WOZ9956VMYMFA7ZWmAzrRmUqxfnLfKFFLp8sK1aAZazFPzHyA/4NZFbclQzz8mZoSS/0DDg==
X-Received: by 2002:a05:600c:3794:b0:3f9:b30f:455f with SMTP id o20-20020a05600c379400b003f9b30f455fmr7658754wmr.9.1687429658218;
        Thu, 22 Jun 2023 03:27:38 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id l17-20020a05600012d100b002c71b4d476asm6640003wrx.106.2023.06.22.03.27.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 03:27:37 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        ocfs2-devel@oss.oracle.com
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] ocfs2: remove redundant assignment to variable bit_off
Date:   Thu, 22 Jun 2023 11:27:36 +0100
Message-Id: <20230622102736.2831126-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Variable bit_off is being assigned a value that is never read, it is
being re-assigned a new value in the following while loop. Remove the
assignment. Cleans up clang scan build warning:

fs/ocfs2/localalloc.c:976:18: warning: Although the value stored to
'bit_off' is used in the enclosing expression, the value is never
actually read from 'bit_off' [deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 fs/ocfs2/localalloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ocfs2/localalloc.c b/fs/ocfs2/localalloc.c
index c4426d12a2ad..c803c10dd97e 100644
--- a/fs/ocfs2/localalloc.c
+++ b/fs/ocfs2/localalloc.c
@@ -973,7 +973,7 @@ static int ocfs2_sync_local_to_main(struct ocfs2_super *osb,
 	la_start_blk = ocfs2_clusters_to_blocks(osb->sb,
 						le32_to_cpu(la->la_bm_off));
 	bitmap = la->la_bitmap;
-	start = count = bit_off = 0;
+	start = count = 0;
 	left = le32_to_cpu(alloc->id1.bitmap1.i_total);
 
 	while ((bit_off = ocfs2_find_next_zero_bit(bitmap, left, start))
-- 
2.39.2

