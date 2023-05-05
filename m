Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDC706F8C77
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 00:39:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233505AbjEEWjf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 18:39:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233501AbjEEWjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 18:39:23 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 125835FE4;
        Fri,  5 May 2023 15:39:22 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-965c3f9af2aso317952766b.0;
        Fri, 05 May 2023 15:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683326360; x=1685918360;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jt099z2QMJcxc7Q+biY7Y79PMQomakQC7INI8LnvLJ8=;
        b=NYiYTCRU3YD6QhKlE6q0yojg8/gSj0qhx6mrN5Ad4oFYRFoVYTk/Lbk+lMysGbXMm7
         NO0NqEKLrM33ZHgprpUVLjWD0MoEe9UWkyuB/wNRdHluXgcWBmX4iUZSqWaDP/E5vXZq
         sXOK5a+L9J1FXZoMLkuiQC2IyUbkIffNQvvK8pUbY4bDsyi9HKefbpUHBFECVZ6XO5Z5
         z4u6iNyzbns+diH9/0+8tORNBAA+SEjvDc+WoomRy/VwSh8HfSy896QPcdPSvKL755fy
         x6MqE8YM2bCIVqJbxyZuyOCRVf8gGFWJViqMYD4nvlkZzTwPhH7CJezMUIUtEVe2NqS0
         tNDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683326360; x=1685918360;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jt099z2QMJcxc7Q+biY7Y79PMQomakQC7INI8LnvLJ8=;
        b=E6pKG0AHn8/rvv0NabVzMcDOLMBgZJaLLov3ze+c7SkCXVtsOvCP9borKvJFQP/qo5
         efHzPlKJ+XlY8qsw3PmSyGzbYkPDFQuMoKya9jkoyaOUtcW8e4fxOyQGMtoedmgpIUGA
         RAlnWTzhz3qkfwu5pug3meeTgjPUkLpCVx7lXGFSpZg40RKGpppjXa/z08DtZxk4R6AV
         9zqGhs6hAPJteTrSg0Byfzwqtp87qJpqAtFcpjLSJWEdtjY8SL6vt6UcWh2aiJsfkS71
         /EKZI99XRN45zEFS1iD5N8VwW81YWFfB1AGUzLgBt0yWjDJG/fQIgvxOGItvfA0ULQRV
         w1YQ==
X-Gm-Message-State: AC+VfDzouivhIU8b7KZ2cIUY6H8RxCXJ3dJ2b37bw5VaThxa15Fvi2iD
        4OKChAbovUnaQeOuKKMuHKU=
X-Google-Smtp-Source: ACHHUZ6E32pgWuQFXc0VVJd+m1ZUe7uD3fHBny+wFxkhGjxN3a64ihm7hkYU2AtQlCC1JEzh3zLpSQ==
X-Received: by 2002:a17:907:2d12:b0:965:cf39:ed87 with SMTP id gs18-20020a1709072d1200b00965cf39ed87mr2910650ejc.6.1683326360134;
        Fri, 05 May 2023 15:39:20 -0700 (PDT)
Received: from felia.fritz.box ([2a02:810d:7e40:14b0:cc49:1b8b:99c2:aef7])
        by smtp.gmail.com with ESMTPSA id hf27-20020a1709072c5b00b00965ddf2e221sm1411650ejc.93.2023.05.05.15.39.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 15:39:19 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] s390: remove the unneeded select GCC12_NO_ARRAY_BOUNDS
Date:   Sat,  6 May 2023 00:39:09 +0200
Message-Id: <20230505223909.29150-1-lukas.bulwahn@gmail.com>
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

Commit 0da6e5fd6c37 ("gcc: disable '-Warray-bounds' for gcc-13 too") makes
config GCC11_NO_ARRAY_BOUNDS to be for disabling -Warray-bounds in any gcc
version 11 and upwards, and with that, removes the GCC12_NO_ARRAY_BOUNDS
config as it is now covered by the semantics of GCC11_NO_ARRAY_BOUNDS.

As GCC11_NO_ARRAY_BOUNDS is yes by default, there is no need for the s390
architecture to explicitly select GCC11_NO_ARRAY_BOUNDS. Hence, the select
GCC12_NO_ARRAY_BOUNDS in arch/s390/Kconfig can simply be dropped.

Remove the unneeded "select GCC12_NO_ARRAY_BOUNDS".

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
Linus, as this is just a quick clean-up improvement to your commit
"gcc: disable '-Warray-bounds' for gcc-13 too", this can probably just
go directly to your tree.

 arch/s390/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index beb62f744c61..db20c1589a98 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -133,7 +133,6 @@ config S390
 	select DYNAMIC_FTRACE if FUNCTION_TRACER
 	select FUNCTION_ALIGNMENT_8B if CC_IS_GCC
 	select FUNCTION_ALIGNMENT_16B if !CC_IS_GCC
-	select GCC12_NO_ARRAY_BOUNDS
 	select GENERIC_ALLOCATOR
 	select GENERIC_CPU_AUTOPROBE
 	select GENERIC_CPU_VULNERABILITIES
-- 
2.17.1

