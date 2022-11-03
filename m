Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E397D617963
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 10:08:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbiKCJI2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 05:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbiKCJIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 05:08:25 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6447D96;
        Thu,  3 Nov 2022 02:08:22 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id m29-20020a05600c3b1d00b003c6bf423c71so2864901wms.0;
        Thu, 03 Nov 2022 02:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Xjl/DU04P6q7G02OgRrWsampoe2D2++cGahG5bY6dJA=;
        b=ODsNAPxplqCRezAY2Pto6fEFW4mgu0km9812R6nDRFXfYLxdW2lMA6g92F6J5lqIWj
         0lUxjMUIU2kF0AudZHDfFZLqWaxORkHDG7Lg68Javy6q/J5U9H7kmC9d/0v0rq/zLWDO
         QYfUOgXCajmEgOK6UQOIGtzp1oxrdKHb2mh57SBYuoMy/CleWwDtte0SEnaglfYhYWEM
         qkvmbZT/J8IJXCZMjh3B8lMwHci3vSorCb9pkEBqWwQPkUkhw8W3ktbCw5SglJf3zJy5
         U3Q53g93VHGZt9bUoVN0e/5ky+uApC8gXDlPnitb3nqnxx1EMeEinoyPJVcS8+FE9pQw
         K9lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xjl/DU04P6q7G02OgRrWsampoe2D2++cGahG5bY6dJA=;
        b=iu0qduLVxyO3J+c1lWVUO3g7n4hb/OmTa+jiiK8W0pGbO8tK/egNDwEkjSmSJPuAd8
         MgEiMyIpXOrtVVc+hl4CowIqd9nZfAUWnZjoLlm0H7e9Zg33y0X4LX+U1Ci3+va7z3II
         Rp6BVGwZv3XOBpWFs2tcis98cbHYm6nujnBDVCOUBMSe2ZtDpO9o7Wl+GXhi7k0P2oU6
         uJ50SO48eb4JmxRln0bdG8YotXRjGF6V6DvGt18Nw534RL4h/XmKKtFg0xLFeiI4SXRW
         Y8vp0Rbms5E32TaKNqG45buGPjdSOXX9Lim9qOsVhbP1LK0zVlg2IF/0qttJEKljpDU+
         m9aw==
X-Gm-Message-State: ACrzQf3sP0rN8nFnZxHtYA9e6f7v9YkbREBw35RD4jJ+uPw4JkKWhjbS
        NXTGi29wsN/wwezJw0zuNNk=
X-Google-Smtp-Source: AMsMyM4oBeOtjDog0815cYHA2sID6hH62IdItMx8gC152AkzJUqT0hh+9RdQCSvhT/rVSZs5ZCsKAA==
X-Received: by 2002:a05:600c:1e8b:b0:3c6:f6e5:c41d with SMTP id be11-20020a05600c1e8b00b003c6f6e5c41dmr29027173wmb.12.1667466500983;
        Thu, 03 Nov 2022 02:08:20 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id d12-20020a5d4f8c000000b0022cdeba3f83sm274529wru.84.2022.11.03.02.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 02:08:20 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] x86/tdx: fix spelling mistake "attibute" -> "attribute"
Date:   Thu,  3 Nov 2022 09:08:19 +0000
Message-Id: <20221103090819.9335-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

There is a spelling mistake in a kernel panic message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 arch/x86/coco/tdx/tdx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index b8998cf0508a..63e588718c94 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -132,7 +132,7 @@ static void tdx_parse_tdinfo(u64 *cc_mask)
 	 */
 	td_attr = out.rdx;
 	if (!(td_attr & ATTR_SEPT_VE_DISABLE))
-		panic("TD misconfiguration: SEPT_VE_DISABLE attibute must be set.\n");
+		panic("TD misconfiguration: SEPT_VE_DISABLE attribute must be set.\n");
 }
 
 /*
-- 
2.37.3

