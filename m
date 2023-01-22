Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABD0B677052
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 16:47:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbjAVPrO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 10:47:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbjAVPrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 10:47:12 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFF9D5B96
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jan 2023 07:46:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674402383;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=E6jYgjX2bdUMfo7qC2knF1fy2KORUnKc0O3IR4qBP1I=;
        b=Eywi6BWOgXN6meW7mNv66wMEjX0QzUiRpiRXV2Jbu1SiUu18px0A1Hu+hGO0AZ0Nlp5J4G
        SwZl3Ywj6S+uoWXVnsj3XM0RB+7f3ItdZqW/MWxwpktWC0YULOhy6352QPR2x4lqV7VjpF
        gRSqRQJl1WkeN8VUsU64qey4Ahke3UI=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-515-J3V3a1bpP-yoGixNZ-WLwQ-1; Sun, 22 Jan 2023 10:46:22 -0500
X-MC-Unique: J3V3a1bpP-yoGixNZ-WLwQ-1
Received: by mail-qk1-f198.google.com with SMTP id bq15-20020a05620a468f00b00706ae242abcso7249218qkb.7
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jan 2023 07:46:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E6jYgjX2bdUMfo7qC2knF1fy2KORUnKc0O3IR4qBP1I=;
        b=7JvjHcvp3QK2J0gyn7NMXSF0gS38Uc4eHMMW3WZyVHbJtWHAOYEr4yXpLndF+xPeVS
         7D3jLKxBrkA7dPhA0T675zovUPyotqJTFpbK7zKmWCn4RNt9tzIMU1fCz5OyeRheQYFT
         h7C6XmPqkL5ROYNyj2PsaMyZxvysX78tv1YTKc8lCC44wa6mi1WXi0PgWmbffUSqhale
         32NZkgykvbTMahzOVJ5PJTSLiAxibFhl9GRSQ4vWseoyOhqQI1rqfbXj1fajV9PDPcr4
         ZDrYGrwXqngObVP2x+xNmGSUtr4swgVRzynM4xwU6209J2MH5VzMLphKtdddsScAg4nj
         PKoQ==
X-Gm-Message-State: AFqh2kp4UnASsvZKFRuiJSsBzwIU3E2sri4OUT5AiLdNFJhNhKrKYzPa
        eY435DA6CgOD81YM3ZIKV8jXB8h/blh9Q7DgTSDh2mDdVytenEGoj8WCR7ueJ9kCcu6KnSQCc86
        3r1ocSyraEMV5WoICr/jUue6Z
X-Received: by 2002:a05:6214:350e:b0:535:b22:d8dd with SMTP id nk14-20020a056214350e00b005350b22d8ddmr31727125qvb.5.1674402382070;
        Sun, 22 Jan 2023 07:46:22 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvzKqhaSc8ThZothYAnzF5/kTMB4L4BWs63as8xoBUPLzodub1dl0JsOxTCxYNPbqC2WLN7Cg==
X-Received: by 2002:a05:6214:350e:b0:535:b22:d8dd with SMTP id nk14-20020a056214350e00b005350b22d8ddmr31727112qvb.5.1674402381836;
        Sun, 22 Jan 2023 07:46:21 -0800 (PST)
Received: from localhost.localdomain.com (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id h8-20020a05620a284800b006fa7b5ea2d1sm29929090qkp.125.2023.01.22.07.46.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Jan 2023 07:46:21 -0800 (PST)
From:   Tom Rix <trix@redhat.com>
To:     neal_liu@aspeedtech.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, joel@jms.id.au, andrew@aj.id.au
Cc:     linux-aspeed@lists.ozlabs.org, linux-crypto@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] crypto: change aspeed_acry_akcipher_algs storage-class-specifier to static
Date:   Sun, 22 Jan 2023 07:46:11 -0800
Message-Id: <20230122154611.504808-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

smatch reports
drivers/crypto/aspeed/aspeed-acry.c:606:24: warning: symbol 'aspeed_acry_akcipher_algs'
  was not declared. Should it be static?

aspeed_acry_akcipher_algs is only used in aspeed-acry.c,
so it should be static.

Fixes: 2f1cf4e50c95 ("crypto: aspeed - Add ACRY RSA driver")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/crypto/aspeed/aspeed-acry.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/aspeed/aspeed-acry.c b/drivers/crypto/aspeed/aspeed-acry.c
index 6d3790583f8b..164c524015f0 100644
--- a/drivers/crypto/aspeed/aspeed-acry.c
+++ b/drivers/crypto/aspeed/aspeed-acry.c
@@ -603,7 +603,7 @@ static void aspeed_acry_rsa_exit_tfm(struct crypto_akcipher *tfm)
 	crypto_free_akcipher(ctx->fallback_tfm);
 }
 
-struct aspeed_acry_alg aspeed_acry_akcipher_algs[] = {
+static struct aspeed_acry_alg aspeed_acry_akcipher_algs[] = {
 	{
 		.akcipher = {
 			.encrypt = aspeed_acry_rsa_enc,
-- 
2.26.3

