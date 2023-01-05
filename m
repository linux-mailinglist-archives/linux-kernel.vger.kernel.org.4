Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66F4F65E526
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 06:36:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbjAEFgB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 00:36:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbjAEFfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 00:35:44 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A278637240
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 21:35:43 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id x26so18331564pfq.10
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 21:35:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u3RcO+ukEEU2tRMGKkuSA42+1jjoCDn3FvnF70ujYWI=;
        b=fU3ZxfwS35G2sd1ofLS0XH6rgua1/Y1Q81HU7Kz9UP7+pJN4hKAikLBBHWCqGEhwNJ
         6sKba61QIGyVO9mZeRIBc6WKZ39X1PvO+i5DuWQQI9UZWlRkhNIcN9zzZhUCawyqxwCS
         Yasvmb2ntqX0rHqa/Jzqhid2eBOHoCUxCpZgY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u3RcO+ukEEU2tRMGKkuSA42+1jjoCDn3FvnF70ujYWI=;
        b=CTkQHKPxgqShuxOKklAgKpU84mKpVEeU3xMG6njgR1X9gC+nabWmETzcRtIpC3cc2g
         lvfZunghVtICY75WXaCD0krsrmvBTYu1YdR+S9tkJe8fCtgZyF8xL+GX2aY5uRrDiLW2
         kzj2Xyr3LbHRFDi2Z8am92/E0OoZWe88n+zh7I60o+r+I2cO0MnDyN4duC1e52fV5c/8
         Cp4JJuXEcyP/XuNQltsTBaLGO3mKMPdVdFrENBcjN4yERochmr21jl/3GlMVZ+jJjHHs
         NNqHVebQX2Fa8Dou/3EjVOeDLKpPBus5T/CWwbz/RC0WW4EEqX3Qi0UgLg1SJ9P34pER
         Lv6w==
X-Gm-Message-State: AFqh2ko7hZNYFJ0tV55YNYXG8AjHIdaHXThu0hZ6zmKJK5LM5C4j9TV5
        uMXGfUXBB1nUld0AfBc4uHRkUR36389ekfPM
X-Google-Smtp-Source: AMrXdXsLJCXHNR4z3LOOHq/EWKiZHaAIInb3wQ5+cuJXqsQVsZ3H0KlsmcXXMWSqiEVtXBS5uFTQMA==
X-Received: by 2002:a05:6a00:450a:b0:56e:664f:a5f5 with SMTP id cw10-20020a056a00450a00b0056e664fa5f5mr61013213pfb.8.1672896943236;
        Wed, 04 Jan 2023 21:35:43 -0800 (PST)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:da84:4bce:bb29:7dea])
        by smtp.gmail.com with ESMTPSA id v27-20020aa799db000000b00577c5915138sm2036855pfi.128.2023.01.04.21.35.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 21:35:42 -0800 (PST)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH 4/4] zsmalloc: set default zspage chain size to 8
Date:   Thu,  5 Jan 2023 14:35:10 +0900
Message-Id: <20230105053510.1819862-5-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
In-Reply-To: <20230105053510.1819862-1-senozhatsky@chromium.org>
References: <20230105053510.1819862-1-senozhatsky@chromium.org>
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
index 995a7c4083c2..9ab5c1996a04 100644
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

