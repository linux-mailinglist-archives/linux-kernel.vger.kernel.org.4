Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47505670F4C
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 02:03:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbjARBDT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 20:03:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbjARBCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 20:02:14 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 106994900E
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 16:52:33 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id s13-20020a17090a6e4d00b0022900843652so695243pjm.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 16:52:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EsTMdrrDLcqpHJRbM6PDDky4/t4qR5IEdsq7S2Y6nHw=;
        b=Fz8NyEIRMQqp+I4ZCxQepR1p8/ydkvg2hf1HWGJ8u/aCQ9zbwbo77E3dYl7YNtJc4i
         BUn0gxOOa7Ai0hZJHABejQtg+WfubPi/k0+hJgmX2tztw22xre3y8cf3ZlgKFEFs+OLF
         +bW3L/RBjQHekHwrqA7plGbudq0By7lrRWw8o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EsTMdrrDLcqpHJRbM6PDDky4/t4qR5IEdsq7S2Y6nHw=;
        b=KAalYOr28s1hD19EoV5IbAPI+tiqAtKi/E/+NRjINvYDFJZ8y3bxu0Ixf6Cu9Pv47X
         6KR6f1vZ7a9SXTu1XUjLYuK60BqIaYYd63odGh3IKcvPYycd3gaZG+6K0Ebg2NeMY2Or
         mUCPmu5phmux/6zu2juEKWttDkfNg8YLi9DEVB4HBS0uZmVSfAbW9Q0sNIYQODoE/qLW
         p/4VnecEMCKiPDoGudxZOFYnRlp5rEdMN6dABqBTg1V8qDm7OlZElqktCd0+HCPMgs+r
         vgmVK+FUXLH+PKXpHaq2I1MM+kG9SzmuZS04sjdbUPh3zYq5n81UEBz49KkdNK8dvJFj
         DAxQ==
X-Gm-Message-State: AFqh2kr7koyD6PiS+n+FF3RBZtHDVseZk+s6MjxaxM/yw4TRKeZ0sHLK
        8JVtRNtRulyVm2NVi5VlD20gwg==
X-Google-Smtp-Source: AMrXdXsdNKdUiGRGfP8RIbqx3A82w0/9Ni8LqjvhCZZQjbuQ2HELZUicdwQGq1iTQV8GzoNc5bTcWQ==
X-Received: by 2002:a17:902:8208:b0:193:f76:aed4 with SMTP id x8-20020a170902820800b001930f76aed4mr5345353pln.1.1674003152775;
        Tue, 17 Jan 2023 16:52:32 -0800 (PST)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:10f3:73a5:7e44:adbf])
        by smtp.gmail.com with ESMTPSA id u10-20020a17090341ca00b00192f4fbdeb5sm8351461ple.102.2023.01.17.16.52.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 16:52:31 -0800 (PST)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv3 4/4] zsmalloc: set default zspage chain size to 8
Date:   Wed, 18 Jan 2023 09:52:10 +0900
Message-Id: <20230118005210.2814763-5-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
In-Reply-To: <20230118005210.2814763-1-senozhatsky@chromium.org>
References: <20230118005210.2814763-1-senozhatsky@chromium.org>
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
Acked-by: Minchan Kim <minchan@kernel.org>
---
 mm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/Kconfig b/mm/Kconfig
index 1cfc0ec4e35e..ebfe5796adf8 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -193,7 +193,7 @@ config ZSMALLOC_STAT
 
 config ZSMALLOC_CHAIN_SIZE
 	int "Maximum number of physical pages per-zspage"
-	default 4
+	default 8
 	range 4 16
 	depends on ZSMALLOC
 	help
-- 
2.39.0.314.g84b9a713c41-goog

