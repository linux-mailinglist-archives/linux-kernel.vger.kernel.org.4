Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 366C1741ACF
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 23:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231956AbjF1VZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 17:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232046AbjF1VZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 17:25:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA1D03594
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 14:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687987374;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=35yLjXwmK+JFwMD6kxYKyYPiJnk3z5/P0tWTo/VOF6w=;
        b=PKTypB0lBsQVrdUzhWUoF+dkoCEO2BzPf/UQMvRysEPil+tVX26hxRrMv8ls+9NNIKt7HA
        Rhq4ApuZIL5OibGIo3CMhiUCMtEBuxowPRY7GeMNPyJPX3aMFDzI6MmioAVuYpaFZ40tcL
        zcrRxRtTqEWIRRQtqFEbjLMB84PPyP4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-85-rd0iF64UP1mqwEEYmHCMjw-1; Wed, 28 Jun 2023 17:22:52 -0400
X-MC-Unique: rd0iF64UP1mqwEEYmHCMjw-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-313ecc94e23so688f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 14:22:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687987370; x=1690579370;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=35yLjXwmK+JFwMD6kxYKyYPiJnk3z5/P0tWTo/VOF6w=;
        b=YNuSwgn6eHzPbjB0tjC2u/ImJeeH6v7A3l3HVLAPw8bDkTAkCWVYf1PDIp1p5qsqpW
         TDSiyjPD+or5C2qbFTksCFzHRzEG24Bqf9UP44y4oWWcrZ2miJje4Md0AkmeZlpTKzeg
         bz7u4JI7LKi3x0YZJQ+9UqhjUsVz60oIPEGsfFvQODlQzDSMtZlSNx04tmvowx/exatm
         zWT8ZdhyZ5nQFKAfTcqRvLneyKFr8rRNiKp8UUdE4wAwSaz1nQsleMrT8z7ucyKJ5Dmm
         ctTyzKyP80C5TK8++XStE0g7xomE5DxIDLCCa/AdYeLRv1IS3/zH0pVVZLEIPfWm/rHM
         UhwA==
X-Gm-Message-State: AC+VfDzR5yjrFHhDj3Wdn4jVsWUvayvnF4J9ZpiAxihqASuJxWUFc1Od
        v6yJglRjjFrLUITxd5WyCzOwcDagrO5IINVwGCNTH/73kezk+ak1wHrihVvckwxJWvJ4Lv+ki1a
        cHMdKBeyAcFkTlrBMXVRaALXaycKgYT2/AIZH8zagS/rwPyYm4PKquzbWg4L+jZUmDU186AmPOS
        rIs9R+oRk=
X-Received: by 2002:a5d:688c:0:b0:313:e8fb:b00f with SMTP id h12-20020a5d688c000000b00313e8fbb00fmr12064954wru.6.1687987370501;
        Wed, 28 Jun 2023 14:22:50 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4etKwVYGUIIKgW4+xNP19noBx/4crXKmYa7hOdvnL0JSt90wwvxFWoR/KRdnfuAOGnZNBW/g==
X-Received: by 2002:a5d:688c:0:b0:313:e8fb:b00f with SMTP id h12-20020a5d688c000000b00313e8fbb00fmr12064938wru.6.1687987370225;
        Wed, 28 Jun 2023 14:22:50 -0700 (PDT)
Received: from kherbst.pingu ([95.90.48.30])
        by smtp.gmail.com with ESMTPSA id r3-20020adfda43000000b0030ae3a6be4asm14294323wrl.72.2023.06.28.14.22.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 14:22:49 -0700 (PDT)
From:   Karol Herbst <kherbst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        Karol Herbst <kherbst@redhat.com>,
        Ben Skeggs <bskeggs@redhat.com>, Lyude Paul <lyude@redhat.com>
Subject: [PATCH 1/3] drm/nouveau/disp: fix HDMI on gt215+
Date:   Wed, 28 Jun 2023 23:22:46 +0200
Message-ID: <20230628212248.3798605-1-kherbst@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cc: Ben Skeggs <bskeggs@redhat.com>
Cc: Lyude Paul <lyude@redhat.com>
Fixes: f530bc60a30b ("drm/nouveau/disp: move HDMI config into acquire + infoframe methods")
Signed-off-by: Karol Herbst <kherbst@redhat.com>
---
 drivers/gpu/drm/nouveau/nvkm/engine/disp/gt215.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/gt215.c b/drivers/gpu/drm/nouveau/nvkm/engine/disp/gt215.c
index a2c7c6f83dcd..506ffbe7b842 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/gt215.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/gt215.c
@@ -125,7 +125,7 @@ gt215_sor_hdmi_infoframe_avi(struct nvkm_ior *ior, int head, void *data, u32 siz
 	pack_hdmi_infoframe(&avi, data, size);
 
 	nvkm_mask(device, 0x61c520 + soff, 0x00000001, 0x00000000);
-	if (size)
+	if (!size)
 		return;
 
 	nvkm_wr32(device, 0x61c528 + soff, avi.header);
-- 
2.41.0

