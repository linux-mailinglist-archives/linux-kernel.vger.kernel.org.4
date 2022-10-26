Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17F3E60DF96
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 13:31:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233551AbiJZLbF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 07:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233382AbiJZLaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 07:30:39 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B64E3ED5D
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 04:30:33 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id m14-20020a17090a3f8e00b00212dab39bcdso2187671pjc.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 04:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7FNBg/Bhf+QH0mnqszhtlK9l4+LQ4+hxFffFVTQHkLU=;
        b=G7cnezaP4xPJIUUd/O3Oge2fK4g5d2+XQaCibffMFdi3ViJL2Y/s4f/nt9Hi4MDfPA
         pkE8Fdr1ScJKMJtAGzAm5Zx0PolERV0WGyH0N0ZVXkHRf0QVan3J7XhuR/878qNg1c3w
         4chxtFk7f9fmJpYo6ZXU3un+1cKdxt4nyor0w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7FNBg/Bhf+QH0mnqszhtlK9l4+LQ4+hxFffFVTQHkLU=;
        b=A0wolcgMkDihQNkeODK/QLAJcUvi02TcT9IoEQwZKpGkGudxydIDrjXyDHIhP76fPj
         6SHUEqLDl+i9yFQonx7qUQDwntxVmuEuovGR1mipkG1JbYvWsU7UE+JapEbXik07K+fu
         GAENt/WKZbY6Ub+fx/BbU3Tkt7pCqIqqh0zMbLAo8sMxiUEoVHtX0sWlESMOvjHOJqmJ
         fMJav9N9B8EICaIKGOmmSP/OABDX2z9DSG3t/8vDr4dA0/HMr46iLCePOTj6ZxM2yoV4
         6fjMhSkSLwL5IYILrPstz43xVAWhecnA6rl7oKrfe8sHcLtyBn1m4fr3M9NI+tVS4utJ
         2UDg==
X-Gm-Message-State: ACrzQf3DjegTMva0c46DJDyog4F7I1nODpMIVv3j639lnbohkL0/bbkH
        ksTHEqkyjalHuLBp+z00JsNQrw==
X-Google-Smtp-Source: AMsMyM5+2bxdyjFQ1ABaYGtesEDrenS0XByOAFjq+hrScq9SvP3QJs84qZgmiyZgCQXJCKYavG1+qg==
X-Received: by 2002:a17:90b:4d08:b0:20a:6861:352c with SMTP id mw8-20020a17090b4d0800b0020a6861352cmr3698168pjb.225.1666783833085;
        Wed, 26 Oct 2022 04:30:33 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:749c:f7f5:1a8e:d0be])
        by smtp.gmail.com with ESMTPSA id x127-20020a626385000000b005627868e27esm2814919pfb.127.2022.10.26.04.30.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 04:30:32 -0700 (PDT)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>
Cc:     Nitin Gupta <ngupta@vflare.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv2 9/9] zsmalloc: break out of loop when found perfect zspage order
Date:   Wed, 26 Oct 2022 20:29:33 +0900
Message-Id: <20221026112933.4122957-10-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
In-Reply-To: <20221026112933.4122957-1-senozhatsky@chromium.org>
References: <20221026112933.4122957-1-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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

