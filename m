Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6996A6C9430
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 14:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231929AbjCZMYS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 08:24:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbjCZMYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 08:24:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E53E2707
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 05:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679833408;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Yc3tSWFy8F/Ma/k22PF1PgCvVFqwDef49qSBC1AuUS8=;
        b=cS/LZbKLJhxx7KLkCD51M+s+EYHFSzM9Cnjqv/wnMB/rVMgjqEz3JKH87hA3in8+Xxo4r6
        x/twSfCcEeOgcEh2gMttzeC+UgINLoc78iUaz1yDK66ch48sDthz6TMoiBoyyv/0XBFpbB
        pVj+thGYKDWmCW/wgkl5dWPKFjZGlxE=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-qW6a1Ry0Nre3YO6N8x_cvA-1; Sun, 26 Mar 2023 08:23:27 -0400
X-MC-Unique: qW6a1Ry0Nre3YO6N8x_cvA-1
Received: by mail-qt1-f199.google.com with SMTP id f36-20020a05622a1a2400b003deb2fa544bso4218020qtb.0
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 05:23:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679833406;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yc3tSWFy8F/Ma/k22PF1PgCvVFqwDef49qSBC1AuUS8=;
        b=eRP3jSsIIuVCyzk24/AV30/YOcAclxYV2+ffZrd4eTfY/sxZ2SunpCxBZUCrQzH/SY
         vhA5y9wvMgnQeWDeoIJunvGCwxlYuyFF85yk2jUMLSluMevT9xuZ5j5Fa9v1mcuEk8G6
         73B5VgzryuM1wLEYjkZ9YFWVBVnGMgq9dIMA13Zk324OrhwJzXz0Gq67WU6eD5Qapw8E
         zOn63mwwpwLsuoHgSflsaW4OzmtqTrEf1ObYCT5GoKG/+G+ncRxZBbMN0tYBsuZ8YnyA
         w4DPJOK/t0FTsGT3YrEi85xtadTRq6ivFwQKzXVcxuNDwW5GKOpnpcRwICDx0krCtatK
         Gpcw==
X-Gm-Message-State: AO0yUKVGkQVZbifCbI8HPG0hizbQGfhw9DaA2Vk6g21zxzvGVO3IWxko
        KKMqf+iMkoWD6Gy6FcnDR5aa8g4qMK/hT+rogwsgSc9z3qn3DdSUWK0G1I1EaG5AsJs3Pu1GB1/
        NPPob/kXCui6yaC55kNVr0QqB
X-Received: by 2002:a05:622a:1d5:b0:3d5:cf4e:bd0 with SMTP id t21-20020a05622a01d500b003d5cf4e0bd0mr13788990qtw.63.1679833406665;
        Sun, 26 Mar 2023 05:23:26 -0700 (PDT)
X-Google-Smtp-Source: AK7set/SjWVqj/O4lGKRqnZTZTusLMliKY76/cDdrQiWz7osrH7ryyoxsJgBtD86j4cTIA4gTy+woQ==
X-Received: by 2002:a05:622a:1d5:b0:3d5:cf4e:bd0 with SMTP id t21-20020a05622a01d500b003d5cf4e0bd0mr13788968qtw.63.1679833406450;
        Sun, 26 Mar 2023 05:23:26 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id w9-20020ac843c9000000b003d8f78b82besm6518765qtn.70.2023.03.26.05.23.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Mar 2023 05:23:26 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     gregkh@linuxfoundation.org, nathan@kernel.org,
        ndesaulniers@google.com, artur.bujdoso@gmail.com, namcaov@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Tom Rix <trix@redhat.com>
Subject: [PATCH] staging: rtl8723bs: remove unused pHalData variable
Date:   Sun, 26 Mar 2023 08:23:21 -0400
Message-Id: <20230326122321.1352337-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clang with W=1 reports
drivers/staging/rtl8723bs/hal/hal_btcoex.c:1182:23: error: variable
  'pHalData' set but not used [-Werror,-Wunused-but-set-variable]
        struct hal_com_data *pHalData;
                             ^
This variable is not used so remove it.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/staging/rtl8723bs/hal/hal_btcoex.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/hal_btcoex.c b/drivers/staging/rtl8723bs/hal/hal_btcoex.c
index e36f8c369a04..0cb2adcc1f78 100644
--- a/drivers/staging/rtl8723bs/hal/hal_btcoex.c
+++ b/drivers/staging/rtl8723bs/hal/hal_btcoex.c
@@ -1179,10 +1179,6 @@ bool hal_btcoex_IsBtDisabled(struct adapter *padapter)
 
 void hal_btcoex_SetChipType(struct adapter *padapter, u8 chipType)
 {
-	struct hal_com_data *pHalData;
-
-
-	pHalData = GET_HAL_DATA(padapter);
 }
 
 void hal_btcoex_SetPgAntNum(struct adapter *padapter, u8 antNum)
-- 
2.27.0

