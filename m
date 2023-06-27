Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF1FE73FB28
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 13:33:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231522AbjF0LdC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 07:33:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231438AbjF0Lc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 07:32:58 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67C2326B8;
        Tue, 27 Jun 2023 04:32:57 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2b69a48368fso40301541fa.0;
        Tue, 27 Jun 2023 04:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687865575; x=1690457575;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=latEXESOogZnUPOdUSC1WbprrLaf0ZKBvwN2Fizyc0w=;
        b=SVXDWSDmBzVoIu4D2vclVwhFmmc6g4IsDJlpskbMT9qU4+qYosbHhFmFJydwkLbol+
         RykW0MvYUyQf4xD/X3hWvkAYKmUHqQ61pqu7IBpYvuImZB7j+/wdvVhi/nAJxqhKMo3y
         ZEw/DEhiGCQJTsfjR6O+7kLo+2A5us3qkp4OKDLpzeZcgALr0gJcCvaUrGFhjE6xL5b7
         alHUUHavuGQRs0HgelnEkBUZQFFekVrkG0Hpa+rUTp3UOoQbYTZ2iZMexMRA3a1hlo2D
         CXeGXUoUXHuN9Gug694Ev0pMoLj3/T0XTlYie3CGC+pw7Sj10FjBb9xXBaimwkgy6Txv
         5r4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687865575; x=1690457575;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=latEXESOogZnUPOdUSC1WbprrLaf0ZKBvwN2Fizyc0w=;
        b=MMcW1ZDVCDhZIWutzlJ1PKDSpFXbBsY5BBsmQ7mdOiPrL4bYDQ/4MjGWH4ZFyv9gM+
         Rus/mGXjYDqEUpe/PYTv+5Vw4LG461+c5WluK04EWnCbS6LW6t2xFRfCUtRyDtCA/Ki+
         ZteaXgosLrSSvD844IFWKhiWUuCrzHsE2pYR/mGKv0P95FRbevbnWRsMecUB2yjbaFVB
         R4ZJGwImoIAeg7V07fUbXHtlQ8DbginEA8M8Dp4xrMnwRNsGJJc5tDR9lQcVOqBFkd0x
         LehmSH6cLzHJ9dECgx/KM+b9A3a6FJJ50f34OrMKNApH/OTMtAWpisy1n1YzSgXWlv3b
         q9CQ==
X-Gm-Message-State: AC+VfDyShe/TdA6/3e6fIi33bDIdX3EcMD7pRuwYRw3nvezIBX90rc2T
        pCB5aSjvmYO38xbqe1DeKkE=
X-Google-Smtp-Source: ACHHUZ4+fT4OuXpoIilYTnkrqDKpDJyrPtrc9BdzgajLJRgmaHKRTRVwrIPAKVjVZJaxUcf9rhkRxQ==
X-Received: by 2002:a19:6d0c:0:b0:4f8:4245:ed57 with SMTP id i12-20020a196d0c000000b004f84245ed57mr19871536lfc.35.1687865575347;
        Tue, 27 Jun 2023 04:32:55 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id f10-20020a7bcd0a000000b003fa99969e61sm4868605wmj.45.2023.06.27.04.32.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 04:32:54 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Clemens Ladisch <clemens@ladisch.de>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] ALSA: oxfw: make read-only const array models static
Date:   Tue, 27 Jun 2023 12:32:53 +0100
Message-Id: <20230627113253.700065-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't populate the const array on the stack, instead make it static.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 sound/firewire/oxfw/oxfw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/firewire/oxfw/oxfw.c b/sound/firewire/oxfw/oxfw.c
index 9523479fa94a..63d40f1a914f 100644
--- a/sound/firewire/oxfw/oxfw.c
+++ b/sound/firewire/oxfw/oxfw.c
@@ -44,7 +44,7 @@ struct compat_info {
 
 static bool detect_loud_models(struct fw_unit *unit)
 {
-	const char *const models[] = {
+	static const char *const models[] = {
 		"Onyxi",
 		"Onyx-i",
 		"Onyx 1640i",
-- 
2.39.2

