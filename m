Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F0CA6FF72E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 18:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238786AbjEKQ2V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 12:28:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238622AbjEKQ2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 12:28:15 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA36DDB
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 09:28:14 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-64395e2a715so8842074b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 09:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683822494; x=1686414494;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cYUQ/sbS5BNXuWwYtA0OFOi5FtbBLLDp9GCw4ToyJYc=;
        b=Aerdg1N0dhqRu+PmwXkkNKQ4voSERlx4iSL4Lj1JFqkjTbQT2h1iI8FBVsmCH6ImbY
         tbaq77pw8xYQ9iBbLfwczmwhg/aU9fWppolHlMhI4lyImYhuZ0rYsu8QhIQ4Bh6HhFsI
         zM6KwGgvEg5B1ViKfEWxEVACWjSidF7RmrSBO5Rjt5g8t0dSG1vXWFJUcQSPL65Lcp9r
         Uacdp83O/aOaghn5WnF/gC3bkXziQUTW81Hz8HSfxEXBiZf5CxvhR0Ym0M+onscL07M9
         4BidliruBNbGp6oGEjFD3gsoLGmzkIaclWjeIsRw8JLg2ltZs7YWM62kxZVVcX0irUBM
         jE/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683822494; x=1686414494;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cYUQ/sbS5BNXuWwYtA0OFOi5FtbBLLDp9GCw4ToyJYc=;
        b=ANMDc03hif2TXLEguBPWW/Z0v3cKcPqFJnDZigVH0CuP86zCK5xxNihFR8jtn8zNv+
         +yQ8TKJgz/yfzC4A3GUnUz1Z+vGrb70005ACWELVHuUk1Lq56Sk9J4+ePPtocj5ViEW7
         KtAJXj6tCLc6BTGT30ffSGXfpNDn53pLJiEA9JAhr9oNsjy7WgZj8hDaOJjvJxE/eh6M
         S+rhPMSZiyZN4jC8X0XWckdot7SQDq8DWok/TO1bJcM7IOPdh5ds3asaKekWrZf5tHGp
         Ms6EXLQaPJ0dAwVrOtmfHXc+Xw7OXOIJUIy2gYPz/iPU2t/U3VuosQ0IblRxCfLjGcxF
         EYCA==
X-Gm-Message-State: AC+VfDwafhMDjta+OkkLT23xzp5iSmvdP5gbUdk6Sw8+O2Pxdv2mtdWh
        mxJ9AZ9KBtqBRXXXygicn1xsm7KLYUwaMw1O
X-Google-Smtp-Source: ACHHUZ45m/WKhqSHubiW+6BgPXaOpfvDNtN4NUNW7bh6JQe6lqWICbzDUsWFkUwxlJCE4ofFknUI6A==
X-Received: by 2002:a05:6a20:1581:b0:101:530a:1d12 with SMTP id h1-20020a056a20158100b00101530a1d12mr12088868pzj.44.1683822493621;
        Thu, 11 May 2023 09:28:13 -0700 (PDT)
Received: from localhost.localdomain ([117.28.251.188])
        by smtp.gmail.com with ESMTPSA id i8-20020aa787c8000000b006413e6e7578sm5522640pfo.5.2023.05.11.09.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 09:28:13 -0700 (PDT)
From:   Lingxiang Zheng <lxzheng@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, Lingxiang Zheng <lxzheng@gmail.com>
Subject: [PATCH] iomem: Adjust address width for 64-bit addresses
Date:   Fri, 12 May 2023 00:27:21 +0800
Message-Id: <20230511162721.12385-1-lxzheng@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modify the address width determination in /proc/iomem output to better
handle 64-bit addresses. The previous implementation did not correctly
account for 64-bit address space, as it would limit the address width to 8
hexadecimal characters. This change adjusts the address width according to
the following conditions:

1. If the resource's end address is less than 0x10000, set the width to 4.
2. If the resource's end address is greater than 0xFFFFFFFF, set the width to 16.
3. For other cases, set the width to 8.

Signed-off-by: Lingxiang Zheng <lxzheng@gmail.com>
---
 kernel/resource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/resource.c b/kernel/resource.c
index b1763b2fd7ef..d8f977d628f5 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -110,7 +110,7 @@ static int r_show(struct seq_file *m, void *v)
 	struct resource *root = pde_data(file_inode(m->file));
 	struct resource *r = v, *p;
 	unsigned long long start, end;
-	int width = root->end < 0x10000 ? 4 : 8;
+	int width = root->end < 0x10000 ? 4 : root->end > 0xFFFFFFFF ? 16 : 8;
 	int depth;
 
 	for (depth = 0, p = r; depth < MAX_IORES_LEVEL; depth++, p = p->parent)
-- 
2.17.1

