Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA1F60B482
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 19:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232752AbiJXRsr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 13:48:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232560AbiJXRs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 13:48:28 -0400
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22F8FBEAFF
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 09:25:10 -0700 (PDT)
Received: by mail-pg1-f172.google.com with SMTP id 78so9047785pgb.13
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 09:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NPUA49DxSROeuVXUf5+5dYRiCRYwBmJzY7QehiBfLmI=;
        b=EV/G2vlr9ho5Ulkc8sroUJ+aLbRJoO3MY36vm4QL6xhuYyNjpL7Ar87vrlrAZ5Svm8
         rbhIxyNU/WCYSM4dKZqJeI1a0HC2RhQzSx8q4R8RoowxZFSpPbFNOdbB5yGxYkkko3BM
         jE8lRkc7rPtLERNeVljXsu9Q7FuZGB/Z+DT7o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NPUA49DxSROeuVXUf5+5dYRiCRYwBmJzY7QehiBfLmI=;
        b=iGx6WnWYTmJljeqBa7FtZhIdSKl3+4KYJwgxEo9LBJBaAvtwSKpktkK6d67XRIXOOG
         XkxFJEsbbZOG/Nu2CQgHwauoCrKvNfPDWi3L9M4/Cf08VjKQHSHwFgvolY+sJ14QxmqS
         vmSmSc4kQLCnj3hlCgHKuy4N2fBoSO14ZuiVS25VbNuhjavVt9OSMIUgOBXpz64fGRkv
         KRmjTeD7nKr8An560JQWmDTjwpc7fqq5N/6ufm/PYsQ4ZICNW6dr/fDJJf1VPu/NaJul
         mH78Qan2enI/diQlJ77pqIP1PHFatjherp2BnL7oQF70lZooLFbjxRVOBLCPcEU+06xU
         65iA==
X-Gm-Message-State: ACrzQf1VQwf5+mgqxcpB/El5NJdlIyWl+qGk6IYOyFmZqDLOhsXMt4TC
        tW/PI7EwjTuZCvUXDp8c90vP+K5VbnuqJg==
X-Google-Smtp-Source: AMsMyM5EFonOvy9fopvLRpCC4i2nP0zFo2rQ8ji+mKGlGBkOOwBqhOvFwJ26jDpavxcsyKnsulMEAg==
X-Received: by 2002:a63:7304:0:b0:46a:faa5:700f with SMTP id o4-20020a637304000000b0046afaa5700fmr29794719pgc.253.1666627958807;
        Mon, 24 Oct 2022 09:12:38 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:5f9c:c5bc:902f:3da4])
        by smtp.gmail.com with ESMTPSA id u70-20020a627949000000b0056b8726d2d3sm5162pfc.157.2022.10.24.09.12.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 09:12:38 -0700 (PDT)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>
Cc:     Nitin Gupta <ngupta@vflare.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH 5/6] zsmalloc: break out of loop when found perfect zspage order
Date:   Tue, 25 Oct 2022 01:12:12 +0900
Message-Id: <20221024161213.3221725-6-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
In-Reply-To: <20221024161213.3221725-1-senozhatsky@chromium.org>
References: <20221024161213.3221725-1-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
index fa55e0c66f8d..40a09b1f63b5 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -790,6 +790,9 @@ static int get_pages_per_zspage(struct zs_pool *pool, int class_size)
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

