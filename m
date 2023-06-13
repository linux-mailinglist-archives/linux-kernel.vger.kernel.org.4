Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD7CF72ECC2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 22:19:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239868AbjFMUTJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 16:19:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240833AbjFMUSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 16:18:52 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BE2326A5
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 13:18:33 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-56cf6f4211aso42796507b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 13:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686687513; x=1689279513;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j2ucc+f0rqtwOxEosVf02SFuSdHsKj1rPS4dOdWYv3M=;
        b=NnMuaE5fk1vnz0fpTjn9UjrZgJHsXMRl+F9w4UFv+tzg5DBYIlhgiytt2snvQ9zSe7
         gVKwKEZKKxzSBrmp0fKKFerObVTJVP6JNF5MBYHkHNmOlwnYVV8DyqjmhkTNlKzmNpbs
         pDD7gCQVreZak+djhqexShCA06em1AFUDv5Y9/+1SgxJYtl5YPM6NiWsRxJG+6xI9Etq
         KEH+EPITLv3sh/bc+uNUz3LHDQcDdC1dboyu86Fxj8dHSj0tvP9++JRCGcc29XEzPgX9
         WPQeLh1tPySTTLmcvLYz3Q242bF+SGdNkd9csYATCx8q/D9Q9DmnHHKYh/besnCgghXg
         FHnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686687513; x=1689279513;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j2ucc+f0rqtwOxEosVf02SFuSdHsKj1rPS4dOdWYv3M=;
        b=AGoFpTu80GKtQrQnyZ8eX2KNmYrqZHdqleebgP1cV08xKsjb/5rXp8bbg4wTPxnLnp
         O5p1fauyyXlfla6cRq/MhLG8doKIg0gdZzrn6F7UDertqYXEmbqSg7CvtHmTQmTTJ61g
         Vdf95hm0Fwte/Z1SlNDrrUxwA1iIg5/99jviIIGsKkZP2H4SjG0cLzFoB4fdgvIunDC6
         EjaJ0IkvZaZNo0a/4l+D4OzQjsCUNSLVHDXW3YLytiPaFAYMgqfVQqsG70JfuMgLwiPf
         N+1J/W/wD2y49bSd9m501AsfTAUZM63zG4ZwPMveMhuFMB6q9Ba4IuTunw4I5ImsLP9S
         LGNw==
X-Gm-Message-State: AC+VfDz6LdjOeHeuFlFiA5Omjm2egE6wIn+wV4yO2qkMbsFR2jC/7y50
        AAJYgmx2P8SzRfunSprkjtbmdtJlVTIATg==
X-Google-Smtp-Source: ACHHUZ7BtSiOTdO259Gu+Xg44N7I234cO4JeJar8mQalYc93mB5jKsBmGo1fJk1nVX5c4Ua6Ry7GwQ==
X-Received: by 2002:a81:b406:0:b0:56d:495d:d3f6 with SMTP id h6-20020a81b406000000b0056d495dd3f6mr2888725ywi.29.1686687512728;
        Tue, 13 Jun 2023 13:18:32 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::e])
        by smtp.googlemail.com with ESMTPSA id b72-20020a0dd94b000000b0056cea0480c6sm2509985ywe.2.2023.06.13.13.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 13:18:32 -0700 (PDT)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH 1/5] mmzone: Introduce folio_is_zone_movable()
Date:   Tue, 13 Jun 2023 13:18:23 -0700
Message-Id: <20230613201827.9441-2-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230613201827.9441-1-vishal.moola@gmail.com>
References: <20230613201827.9441-1-vishal.moola@gmail.com>
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

Introduce folio_is_zone_movable() to act as a folio equivalent for
is_zone_movable_page(). This is to assist in later folio conversions.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 include/linux/mmzone.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index a4889c9d4055..744bf32e48a8 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -1116,6 +1116,11 @@ static inline bool is_zone_movable_page(const struct page *page)
 {
 	return page_zonenum(page) == ZONE_MOVABLE;
 }
+
+static inline bool folio_is_zone_movable(const struct folio *folio)
+{
+	return folio_zonenum(folio) == ZONE_MOVABLE;
+}
 #endif
 
 /*
-- 
2.40.1

