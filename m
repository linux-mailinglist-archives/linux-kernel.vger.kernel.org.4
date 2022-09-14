Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B8C15B81CE
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 09:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbiINHLH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 03:11:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbiINHLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 03:11:01 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDF916173C
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 00:11:00 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id v1so14225940plo.9
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 00:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=AU4dxVt2EZAwAafSPDdpJ60cBcN1PRUQqw+/acHisPM=;
        b=ik+MeS4ugOup3HBtZTVSS5/0wdLMPXxMvOk2AgInP8jvjMAeU3zysTsW6v4FjAlcko
         MBsFiQj1RPbj8SCNpCZsAuYveLCJMJ2IUhs4GQdddwY5HuDk0mafoLIrOqrrHb8uft4w
         h1uC/TpbMe/2iMuxa508eRbW1d/IaloCrgzg6e+Y4Ht7H5bBKGZsyKOc93muJkcPGrHy
         55/I8Nwdvv5yX/XAjKfWLxOwtdZuWkU/7Uo0eLbN9vK26Um8Rr7YSQwNv1wbt8ExQPPN
         kgfVr8MG9xHFtiho2G589cprKn0xZmBd3R25OZtIiWXLCMSdDDUDwr5Ef3+619/wTkHg
         KwZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=AU4dxVt2EZAwAafSPDdpJ60cBcN1PRUQqw+/acHisPM=;
        b=Xhxs25mc+OjeGTAt+QRvgM6j8DOKVGcXpfLPByGeLv5A3hEiaLkTsQ7y1BFhZqdhrD
         Hk0xoIFO4tAFoqaveJT3VxhzqUp50FwT0oTShmMSJWEla2AKzd7Sg+KrBdWU78JQr7+n
         pCiSJK4gGGz37rhUNPM4gHTv/IvZXFAuEdKsLAI5USAWl+eayKTT5BrEKtQOxq66mOCy
         Gs/wLSBodInnVJiBjQeYQUVGkfBgWV+BIUP9Vj1aXq2dPaYzp8VZ76Yr4Mz3l/oAakaY
         ivgi9NSV3xvMdryed1oIrlY/avAav8Ogd24JHoL6fTkC62LRlLJ/fZ44kSlSO4R+XUvR
         l1bg==
X-Gm-Message-State: ACrzQf3K81q0695DNIKj615BCvfgk40xlyCoNeIoXfEjz4gcrAeiq+sK
        +HoA3vRF9GO7X+Goi/z3ndk=
X-Google-Smtp-Source: AMsMyM4/hZ0xpGlMz6cxwGj5nfP51rRTcZW+ZUMZXe4Q/71GdlLYxy+VH14c7/MMVh32/oK797/6JQ==
X-Received: by 2002:a17:90a:e586:b0:1fa:d28b:ab9b with SMTP id g6-20020a17090ae58600b001fad28bab9bmr3357604pjz.47.1663139460468;
        Wed, 14 Sep 2022 00:11:00 -0700 (PDT)
Received: from hbh25y.. ([129.227.150.140])
        by smtp.gmail.com with ESMTPSA id w37-20020a631625000000b0041bfa382dfesm8837396pgl.67.2022.09.14.00.10.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 00:11:00 -0700 (PDT)
From:   Hangyu Hua <hbh25y@gmail.com>
To:     bskeggs@redhat.com, kherbst@redhat.com, lyude@redhat.com,
        airlied@linux.ie, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Hangyu Hua <hbh25y@gmail.com>
Subject: [PATCH] drm: nouveau: move bounds checking to the front in nouveau_svm_fault_buffer_dtor()
Date:   Wed, 14 Sep 2022 15:10:50 +0800
Message-Id: <20220914071050.21823-1-hbh25y@gmail.com>
X-Mailer: git-send-email 2.34.1
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

It is better to check i before use it in array to avoid potential out of
bound access.

Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
---
 drivers/gpu/drm/nouveau/nouveau_svm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_svm.c b/drivers/gpu/drm/nouveau/nouveau_svm.c
index 31a5b81ee9fc..5c49a8eaf593 100644
--- a/drivers/gpu/drm/nouveau/nouveau_svm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_svm.c
@@ -957,7 +957,7 @@ nouveau_svm_fault_buffer_dtor(struct nouveau_svm *svm, int id)
 	int i;
 
 	if (buffer->fault) {
-		for (i = 0; buffer->fault[i] && i < buffer->entries; i++)
+		for (i = 0; i < buffer->entries && buffer->fault[i]; i++)
 			kfree(buffer->fault[i]);
 		kvfree(buffer->fault);
 	}
-- 
2.34.1

