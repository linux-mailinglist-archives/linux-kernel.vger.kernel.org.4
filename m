Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9217772F27C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 04:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242154AbjFNCOa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 22:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242132AbjFNCOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 22:14:25 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D15119B6
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 19:14:25 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-5700401acbeso2308967b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 19:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686708864; x=1689300864;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gIoFapX6nAbUleBYK2wE51yt/hsIHhUn+0PFfQGQ1N8=;
        b=OG0iNJ5GmEjZhXWO61u1AwU/idx/nazyQ7HP0I52znlouGZuNuyCp8x/YKDMNgE4TF
         FU/F4boFM8HzpQ/NYUPs6dBRfUqsDByWHFzr2KXzyKgbmBw6GKmPXJ7Cu/uWiikyv6gm
         GYjp2nEXcgLHMOQD6H3b3vuZiYRTJXs3N9sJB9GJ/BgnptFuN9WEMkcygTfvJyoXntc3
         vHZBUztIkK9vRCdJJtya4e9pPE36OVtzPLhh748IQlh88xPZqc6gQBvcbEiDkhruCSoJ
         xue2DFFhxZdEW1Zhwmy3hRvDCHpd775F7lLi55NrX3Vk4O0E1d6pwWwZyjkeLm4B8i5u
         /3vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686708864; x=1689300864;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gIoFapX6nAbUleBYK2wE51yt/hsIHhUn+0PFfQGQ1N8=;
        b=dduzOM8NH/4dUyEUvje6SE8cXaL0bahS24NWdQsAIZ/X4ARcESe6pQa81Or7iX/twE
         qZVb75nHpOBj4KS5gXxsu0RrvfDlgRJ4unCptmfhU5lXGtsxARQs6NBWcPSENI60ngsy
         RU04FN72h6XPzd/2k5FxeDkfk9YyE+e1X1Sj6ff/sGmL7FQTeMmvXFeZyOXUXWrgGiTl
         ZINnC76BYYLXAKTul+rNQsJ71DyXLTIhScSEfThoqVbOaP75ikqY+KS7HgYgzThZkv2N
         bezpUEU+SB3rSuLjYije1STvANSkvSUcnC3QwRI4XzuBhIkQCPcyWuolVzauDIDcl66F
         1DKw==
X-Gm-Message-State: AC+VfDxlKSdI71ABR2aZNqRQTja2W/VVbLzwAQYusK4kR2w9tfc9Les5
        HVROfM0wePghLeO9C+PA+3I=
X-Google-Smtp-Source: ACHHUZ4YSMJp3iF8wUHpYsSVNC2ramcdJy4Qkj6dvEyjhe8CY4rDVrJOLr8FWGbCxucf/XIz1bWsiQ==
X-Received: by 2002:a81:484c:0:b0:56d:770:c315 with SMTP id v73-20020a81484c000000b0056d0770c315mr512357ywa.49.1686708864338;
        Tue, 13 Jun 2023 19:14:24 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::e])
        by smtp.googlemail.com with ESMTPSA id p3-20020a817403000000b0056d30f1b508sm1463931ywc.107.2023.06.13.19.14.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 19:14:23 -0700 (PDT)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v2 1/5] mmzone: Introduce folio_is_zone_movable()
Date:   Tue, 13 Jun 2023 19:13:08 -0700
Message-Id: <20230614021312.34085-2-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230614021312.34085-1-vishal.moola@gmail.com>
References: <20230614021312.34085-1-vishal.moola@gmail.com>
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
Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
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

