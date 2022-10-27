Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F58460EF05
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 06:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234400AbiJ0E1r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 00:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234276AbiJ0E1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 00:27:19 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFEAE149DC5
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 21:27:18 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id 4so263618pli.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 21:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7FNBg/Bhf+QH0mnqszhtlK9l4+LQ4+hxFffFVTQHkLU=;
        b=VTCt4sWyUlHu3XwJaayi2bF65TY7ie/rwhOYEU+57lhIbz1GKvZDHXuccXF5EjAfuh
         7FEovYIidq2NDbGQrRakQxt/e+Tutl18/H0f3yoDqHk33zKQwnxEA5P5ubClFTnmp49x
         vtWfyu4sNUmcuiCa3BE8lSE4BNmsluANiBs5g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7FNBg/Bhf+QH0mnqszhtlK9l4+LQ4+hxFffFVTQHkLU=;
        b=aLXYsQBcGa0QNEdLKPsOxRgHd1VoTXBNtomZNfVuj8JPIyflNe6wHiw2oD+IY/9KwU
         t77KQIwoBxiyXYiXuOPGjy7/WT837qCGMgke8SGWO1vTF657msTKdST5739k71rexpe4
         Qcy+FdLdO5OTraAfQMQUTHVZx96qqnjkA5CPJjJxBCId2oKadX27etkuYDrsw5r2V1s8
         PwT1u1/zHy+txpBACyqVAetTs2VnwQOrDRTlb+3DkYicUc3jic1IkS64iZufTg+dV7w+
         L1c72GJYhhpZAv8FqjHlUY+97ut5Zp0SsS6OZjBbLAahW4X74Kmirh2809hoo3wDh62a
         56YQ==
X-Gm-Message-State: ACrzQf0yOeVxP0nBXfy4yDuFR4L/VkqDBQMXJ1eI/WxortaDjVUMmTzr
        L1xHuDLXZZ+3ika9W62oH0rLrg==
X-Google-Smtp-Source: AMsMyM6mLY1dGQXaB9/3tNuXFNI8esnOKI319xKEiHu48v+dy2FaSTPUqy9QaGZSM24wlt0gt5x2eA==
X-Received: by 2002:a17:90a:1b44:b0:213:1035:f913 with SMTP id q62-20020a17090a1b4400b002131035f913mr7776402pjq.133.1666844838446;
        Wed, 26 Oct 2022 21:27:18 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:30f2:4501:65fa:df12])
        by smtp.gmail.com with ESMTPSA id w23-20020aa79557000000b00565c8634e55sm203140pfq.135.2022.10.26.21.27.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 21:27:18 -0700 (PDT)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>
Cc:     Nitin Gupta <ngupta@vflare.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv3 9/9] zsmalloc: break out of loop when found perfect zspage order
Date:   Thu, 27 Oct 2022 13:26:51 +0900
Message-Id: <20221027042651.234524-10-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
In-Reply-To: <20221027042651.234524-1-senozhatsky@chromium.org>
References: <20221027042651.234524-1-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we found zspage configuration that gives us perfect
100% used percentage (zero wasted space) then there is
no point it trying any other configuration

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 mm/zsmalloc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 7465a45495bf..0bc9ed1f1a5d 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -787,6 +787,9 @@ static int get_pages_per_zspage(u32 class_size, u32 max_pages_per_zspage)
 			max_usedpc = usedpc;
 			max_usedpc_order = i;
 		}
+
+		if (usedpc == 100)
+			break;
 	}
 
 	return max_usedpc_order;
-- 
2.38.0.135.g90850a2211-goog

