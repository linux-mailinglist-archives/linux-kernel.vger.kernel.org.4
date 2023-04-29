Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4A456F2267
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 04:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347165AbjD2C04 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 22:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbjD2C0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 22:26:53 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6D0E2139
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 19:26:52 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-517bfdf55c3so253073a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 19:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682735212; x=1685327212;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HvZBb3zDkCNBninlkvm1QhcuDNTotPdtO/fg1RpYlr4=;
        b=JaEqXs1cBubSFOUHzVMLv39JOMv2/647RCSvQz9Pp+onIkgw/wVUFCIhj4QMaQ/1a3
         C7HoJ36Y4rWGtUvcVQkDQn/G1j80GIhpApfUknOA0UT+FM6RQpd4NlU0j24XIVAyUUmt
         nHA4cVttQjv9iiM4eKDjXpm2EOputAJ0B552uqHV2o1Mxar+LkMy3J8QNyk/M6QKfRH7
         KSyDgKE71FAb1MzbEcybJaHWJS4w0isWsDT0TC2Rzhfz/8Hc+3KVhpkTilGsTYOuW1t7
         OIIh6+dWMTsGHsX2LHZ5eH2DwRnaPywjY0MOtdAYx7vRrINZNxvBlAPX/eMSDGYVm8Rx
         w2Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682735212; x=1685327212;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HvZBb3zDkCNBninlkvm1QhcuDNTotPdtO/fg1RpYlr4=;
        b=NUzxCgY0Nt2V2DJbsMbYZi1NgkjMTNAahKZDVYAN3c6iPvPxfZU6cW7CqOHRrgY4Df
         nUWMeP/mQAFpDk/cjFHMEduOlRrdraxnaisMRrLTKK9lLeprnr+aJu29nrDOUFrFHVsZ
         OibXDzDTFV0xtvTiSrEJWu6HD6OjP2OGVTRAiMtzcsYpB5zYa6vcKkD8A3qh/nY/TFX9
         76tyNIzT3g+cfdbKvEVSXuUuWQUyX4NhIHNUTuTRHId0WdGdVJu8FUQjoA34X88keKI4
         RsagvwdSutPF/8DI9nbh50tzLbXJA+FrhOkrpaPPYm4sc/BV85tbEVB+xS4kEqWAXU8E
         vZYA==
X-Gm-Message-State: AC+VfDySTgtN2m0ck9YjGFEWwRKndgjXY2aaNgDn4AK/ifDvDRf+0sOp
        N2RniEnZJBynHzT64OqeCrQhv/MjXSw=
X-Google-Smtp-Source: ACHHUZ5dNmDxgF4RnJi/Ms+PmRMtT62ARcQq2IWKnXo29oKnyv/jHRviDaAT8Lkmart5ccG1IRr8GA==
X-Received: by 2002:a17:90b:4b01:b0:23d:10f2:bda2 with SMTP id lx1-20020a17090b4b0100b0023d10f2bda2mr7443831pjb.30.1682735212160;
        Fri, 28 Apr 2023 19:26:52 -0700 (PDT)
Received: from trent-reznor ([2607:fb91:60f:60ef:dc01:5197:5d6b:1b5c])
        by smtp.gmail.com with ESMTPSA id u11-20020a655c0b000000b00528cd045e31sm256112pgr.78.2023.04.28.19.26.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Apr 2023 19:26:51 -0700 (PDT)
Date:   Fri, 28 Apr 2023 19:26:48 -0700
From:   Daniel Watson <ozzloy@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8723bs: use tabs for indentation
Message-ID: <ZEyAaC0riuuBJO14@trent-reznor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use tabs for indentation to conform to styleguide.

Signed-off-by: Daniel Watson <ozzloy@gmail.com>
---
 drivers/staging/rtl8723bs/include/sta_info.h | 26 ++++++++++----------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/sta_info.h b/drivers/staging/rtl8723bs/include/sta_info.h
index 69c377eeeaf08..1ea3fe22b99a3 100644
--- a/drivers/staging/rtl8723bs/include/sta_info.h
+++ b/drivers/staging/rtl8723bs/include/sta_info.h
@@ -16,9 +16,9 @@
 /* if mode == 0, then the sta is allowed once the addr is hit. */
 /* if mode == 1, then the sta is rejected once the addr is non-hit. */
 struct rtw_wlan_acl_node {
-        struct list_head		        list;
-        u8       addr[ETH_ALEN];
-        u8       valid;
+	struct list_head list;
+	u8		 addr[ETH_ALEN];
+	u8		 valid;
 };
 
 /* mode = 0, disable */
@@ -340,19 +340,19 @@ struct	sta_priv {
 
 static inline u32 wifi_mac_hash(u8 *mac)
 {
-        u32 x;
+	u32 x;
 
-        x = mac[0];
-        x = (x << 2) ^ mac[1];
-        x = (x << 2) ^ mac[2];
-        x = (x << 2) ^ mac[3];
-        x = (x << 2) ^ mac[4];
-        x = (x << 2) ^ mac[5];
+	x = mac[0];
+	x = (x << 2) ^ mac[1];
+	x = (x << 2) ^ mac[2];
+	x = (x << 2) ^ mac[3];
+	x = (x << 2) ^ mac[4];
+	x = (x << 2) ^ mac[5];
 
-        x ^= x >> 8;
-        x  = x & (NUM_STA - 1);
+	x ^= x >> 8;
+	x  = x & (NUM_STA - 1);
 
-        return x;
+	return x;
 }
 
 
-- 
2.34.1

