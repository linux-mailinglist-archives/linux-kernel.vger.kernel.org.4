Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7E60661CC4
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 04:40:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234683AbjAIDjl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 22:39:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234338AbjAIDjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 22:39:20 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C73B09FC8
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 19:39:19 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id w4-20020a17090ac98400b002186f5d7a4cso11506278pjt.0
        for <linux-kernel@vger.kernel.org>; Sun, 08 Jan 2023 19:39:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dlWwNcLaCNMrFJn+GAHPbY9EaslTtgv1WCZYoXPvAgg=;
        b=c2tPZUtnfZYWUQEK/A+qra/pRjcTxBywGXUW2sLZfBlvY/CSVfMlKyEq0F6U6KfncB
         0CBatdDY9OYDgJn4SGVqfFjg16m/HYXm5u1TpVVTtCVDKD+2spct3OLBo9tX8exo6E3a
         qmYUYHmT+f49hii4ylUIELFNoVNOomwoXRtSI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dlWwNcLaCNMrFJn+GAHPbY9EaslTtgv1WCZYoXPvAgg=;
        b=TzorzDJ8yMy9DSct5yI2lW/Ca3A8X2aMrycyrfk1yQ83gDn4ljzZm/uSE20lj4XeLC
         R15OaGGiuBPzR6bY7amkk8p6AVD2c4/yWb8qdmR43/wsbObMSxG4TTXmnS0dDz11bSia
         GMz8xcnphsQyEfy/IlsEydFsnWB3hmjBF8g9EXaYLt/ZM6kLxKAuQUL48chhpLGusoIf
         uzvUoOH9v1I9+3AW6PGRR9DJTjLmwIdwthtyUbFk8DncJO/oahG/xakyVxFwa9/b/Ddr
         qsbt5RNptV3kHp5ucudmpm+rNf1ym/vhZVfx/wjjo8CbbySaCGQxuGDUCBxlszFm2C30
         /5fg==
X-Gm-Message-State: AFqh2krg/o0APY3WRa9xOq3w2PRbpGFJmcCZU/wgfUtrNj7Y/q3hdrEF
        7rX6J7yAtWvx48HFElwGF5nMgg==
X-Google-Smtp-Source: AMrXdXur0oxpjEODUUF9GTMwdIwC4g2lAGrc6cfHN0+4pkbqW99KdO9dMuvuer5o6Azo6AL3Yo2pYw==
X-Received: by 2002:a05:6a21:6da8:b0:af:d295:e2f0 with SMTP id wl40-20020a056a216da800b000afd295e2f0mr120307008pzb.27.1673235559303;
        Sun, 08 Jan 2023 19:39:19 -0800 (PST)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:5ec1:f8d2:ce47:7ddc])
        by smtp.gmail.com with ESMTPSA id u5-20020a170902e80500b00189529ed580sm4896685plg.60.2023.01.08.19.39.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jan 2023 19:39:18 -0800 (PST)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv2 4/4] zsmalloc: set default zspage chain size to 8
Date:   Mon,  9 Jan 2023 12:38:38 +0900
Message-Id: <20230109033838.2779902-5-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
In-Reply-To: <20230109033838.2779902-1-senozhatsky@chromium.org>
References: <20230109033838.2779902-1-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This changes key characteristics (pages per-zspage and objects
per-zspage) of a number of size classes which in results in
different pool configuration. With zspage chain size of 8 we
have more size clases clusters (123) and higher huge size class
watermark (3632 bytes).

Please read zsmalloc documentation for more details.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 mm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/Kconfig b/mm/Kconfig
index 5b2863de4be5..d854a421821b 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -193,7 +193,7 @@ config ZSMALLOC_STAT
 
 config ZSMALLOC_CHAIN_SIZE
 	int "Maximum number of physical pages per-zspage"
-	default 4
+	default 8
 	range 1 16
 	depends on ZSMALLOC
 	help
-- 
2.39.0.314.g84b9a713c41-goog

