Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E78AE708548
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 17:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231858AbjERPrR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 11:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231823AbjERPrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 11:47:08 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B335107
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 08:47:07 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3f41dceb9c9so15403055e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 08:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684424825; x=1687016825;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=so5X8y31ofqFetru35U19iFwUd1BghZyykXgxlSS3XI=;
        b=J/N8V1K/EyUdwPwES+/9W2+knfmKs15zW1K3QFlNaxk7o8OfH2CMgRqWEmVTR86Nvi
         D7RWxgUfYI7L+UgY8CS+8cFna10iomGLogtTix/9wfpmgkNp2QZwP61h3p3/q0tQBlRs
         bLqQk7fr2RESycDsyWGoNKPa54KF123R17jZw6yDtBs3BuoB7eLeo0mqeNflwgIMzq7q
         bpmqGvwVWnSyd7GZqqm9/WIGmW4i4Z3/WdKjBP6pP6hHmjFGWuofQx+jx01ILN7KzCUK
         bKKFbFw5b0Ezit3vrucpxqvPyi0ZPC48uLozrMdn5EnLZR6XvVcfcUaDqzgevhUmEaIJ
         jq+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684424825; x=1687016825;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=so5X8y31ofqFetru35U19iFwUd1BghZyykXgxlSS3XI=;
        b=WYreTBY42hvvM0B7pcya/5c3T2Poriy7fIfks+8qLRKGykQH01+M3olBW9lZQXNBvh
         3KhMcsBu8vV8fVRrB9wFoA0gCnn2jv2X6sf5PQiZiLC+fTzNMduh549n+c46+yyG/vhh
         E+HGEcLQp+pxpsB344tFO70rVOnSbJ9SkBwoVjnPr9WsKxtXpM7X5gZtpFbpas+YA96w
         S7tG3Ots3ap9WFEpCiCqL2ImlE1n+hrrTI1ICanqSBeRMgjX4ZuU9sZe7H+QxzwDpO2v
         WAfd+LOApc5lpAAmK+hsN8fuOYR3mWboTx3ck3SKh2P5j5MARZnYKWizlss8Iw6PKtXS
         F9sg==
X-Gm-Message-State: AC+VfDz3PiGnoeUM8K68R/SZcugO9+mCyjbs21e5lhwk4SVTD9vU+lle
        A0jFAcByWjrXNcuUGsSH7A==
X-Google-Smtp-Source: ACHHUZ4ECulihCYunK7ytveYNHAiGupDz3PecaKXIXsgwPUSejS/aG7bIyVQXxgzNoghOniLZlXgYg==
X-Received: by 2002:a05:600c:2186:b0:3f4:294d:8524 with SMTP id e6-20020a05600c218600b003f4294d8524mr1748975wme.22.1684424825423;
        Thu, 18 May 2023 08:47:05 -0700 (PDT)
Received: from p183.Dlink ([46.53.250.37])
        by smtp.gmail.com with ESMTPSA id h2-20020a1ccc02000000b003f421979398sm5671769wmb.26.2023.05.18.08.47.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 08:47:05 -0700 (PDT)
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, adobriyan@gmail.com
Subject: [PATCH 5/8] auto: promote DIV64_U64_ROUND_CLOSEST macro to function
Date:   Thu, 18 May 2023 18:46:46 +0300
Message-Id: <20230518154648.581643-5-adobriyan@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230518154648.581643-1-adobriyan@gmail.com>
References: <20230518154648.581643-1-adobriyan@gmail.com>
MIME-Version: 1.0
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

Same explanation as for DIV64_U64_ROUND_UP: div64_u64() wants "u64" in
the first argument so using anything wider in calculations before that
doesn't matter.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---
 include/linux/math64.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/linux/math64.h b/include/linux/math64.h
index 7e0e2625dc35..d8770c8a9cff 100644
--- a/include/linux/math64.h
+++ b/include/linux/math64.h
@@ -313,8 +313,10 @@ static inline u64 DIV64_U64_ROUND_UP(u64 ll, u64 d)
  *
  * Return: dividend / divisor rounded to nearest integer
  */
-#define DIV64_U64_ROUND_CLOSEST(dividend, divisor)	\
-	({ u64 _tmp = (divisor); div64_u64((dividend) + _tmp / 2, _tmp); })
+static inline u64 DIV64_U64_ROUND_CLOSEST(u64 dividend, u64 divisor)
+{
+	return div64_u64(dividend + divisor / 2, divisor);
+}
 
 /**
  * DIV_U64_ROUND_CLOSEST - unsigned 64bit divide with 32bit divisor rounded to nearest integer
-- 
2.40.1

