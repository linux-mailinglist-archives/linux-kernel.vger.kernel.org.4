Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9B1A74A37F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 19:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbjGFR6V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 13:58:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232163AbjGFR6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 13:58:18 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44CB91BEC;
        Thu,  6 Jul 2023 10:58:16 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id ca18e2360f4ac-7835bad99fbso35990739f.1;
        Thu, 06 Jul 2023 10:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688666295; x=1691258295;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JxZ6vfHvXf39QbafRxcNDYjeiJshVCIJaiyxL7XtpQA=;
        b=OWnTn31nuWCSI4rU2SYwsjX+Om77s/G6+5jLKR2h/bHP1HEeXMy0wlsg/GMmh3ZtJU
         rnuuz6LKJnu3BErQc6QkZUnPbi2G5p2EaXFVRa2XUoq8oRN3BWsbyhM8c/wUxM4KK/N9
         65DQLGILGfvKFi6Z1/+V7LYc/9bgwXS4W+rnXc7pQLdPduqKQFsEU+YlZNeFXp5Rb/dA
         sQ/iNsuYlgrldPQe0tWe31Bjl6pP/ulALdEqK/71IFGEm8HXiCsks4XR/05WTZc9Ftz+
         sVyiQxhhx67Fruy6ppOeUIXcsrnTrK+nlLxJaHXIs53Fi3s3u8CkNPwiRaMl/qBqihQ6
         9NbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688666295; x=1691258295;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JxZ6vfHvXf39QbafRxcNDYjeiJshVCIJaiyxL7XtpQA=;
        b=IRKEZ9XnGJ55aoF0/k57s2aGhWX7w29pxXpdDpBs9AQ9QMQbHPOyJI4KcA+iFPhlxQ
         vTVnE0pteLPfUeUPRsUapq9BhSdTMHhANLXVMyERlOvqNed83CIv3OZRh/bNxXm/bBMH
         0hEUvSKe4xvaOfYS8yZzuoB7WIlx5xBSfsA/cCKS7pVMsbrAKIgEI3oJbyovUmqlkrmw
         z0XOIdskaS4vwPB3jn/9g1pHIzrqjP9IsQe9inBG2JviQM2xH2UVuxxa3BS44ncNnuN9
         KWIS8+NgTxSvM/nQLHZbTXiqBgmw0bcmOfVSuwHYK4jqHCnk3ve3YmBmJgeg9zjoGW/Y
         yJOA==
X-Gm-Message-State: ABy/qLYLi5mDegWEPuBzXGNiTmlK0f5V5OgmnxAKboKIkEPlDHfKVYqe
        6NF5f8//S3aQ3TYUxVbXihQ=
X-Google-Smtp-Source: APBJJlHg8HsoyIl8oK8bHyAx8asRYDBps+i8gOope6rvLtEddzu1qCT9IPPHraJFmnKu0jHfpwl6/A==
X-Received: by 2002:a5d:9bd0:0:b0:786:cd9b:1ccd with SMTP id d16-20020a5d9bd0000000b00786cd9b1ccdmr3168930ion.0.1688666295453;
        Thu, 06 Jul 2023 10:58:15 -0700 (PDT)
Received: from azeems-kspp.c.googlers.com.com (54.70.188.35.bc.googleusercontent.com. [35.188.70.54])
        by smtp.gmail.com with ESMTPSA id s24-20020a02ad18000000b004249d9e81besm633683jan.131.2023.07.06.10.58.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 10:58:14 -0700 (PDT)
From:   Azeem Shaikh <azeemshaikh38@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-hardening@vger.kernel.org,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH] EISA: Replace all non-returning strlcpy with strscpy
Date:   Thu,  6 Jul 2023 17:58:04 +0000
Message-ID: <20230706175804.2249018-1-azeemshaikh38@gmail.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

strlcpy() reads the entire source buffer first.
This read may exceed the destination size limit.
This is both inefficient and can lead to linear read
overflows if a source string is not NUL-terminated [1].
In an effort to remove strlcpy() completely [2], replace
strlcpy() here with strscpy().
No return values were used, so direct replacement is safe.

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
[2] https://github.com/KSPP/linux/issues/89

Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
---
 drivers/eisa/eisa-bus.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/eisa/eisa-bus.c b/drivers/eisa/eisa-bus.c
index 713582cc27d1..33f0ba11c6ad 100644
--- a/drivers/eisa/eisa-bus.c
+++ b/drivers/eisa/eisa-bus.c
@@ -60,7 +60,7 @@ static void __init eisa_name_device(struct eisa_device *edev)
 	int i;
 	for (i = 0; i < EISA_INFOS; i++) {
 		if (!strcmp(edev->id.sig, eisa_table[i].id.sig)) {
-			strlcpy(edev->pretty_name,
+			strscpy(edev->pretty_name,
 				eisa_table[i].name,
 				sizeof(edev->pretty_name));
 			return;
-- 
2.41.0.255.g8b1d071c50-goog


