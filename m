Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E7566D9754
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 14:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236387AbjDFMvx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 08:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbjDFMvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 08:51:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BCD111C
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 05:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680785468;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=a8vJf32VjBTqhSXC4UaNWwEC2++PydY9gb3nY7Y6vs4=;
        b=b4sMLHzmMVK7g8LdIS6W1Z4HEMNgYIvsau1uGg1uYRF66/dBu49kwmltEWNF0N1dVfckwQ
        0Mi+BelRPA8jKCaJzexNWGOdDTGgbf204Ghi33eflG6kPC1gbhzMKhpWj9JIb9ykOMp62i
        Fy87gqJWME9bQ9iSO6WegjspHre0JMg=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-177-IQjF4ksjNCWek6j9_AsWDw-1; Thu, 06 Apr 2023 08:51:07 -0400
X-MC-Unique: IQjF4ksjNCWek6j9_AsWDw-1
Received: by mail-qk1-f198.google.com with SMTP id p63-20020a374242000000b007468eaf866aso8199257qka.17
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 05:51:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680785467;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a8vJf32VjBTqhSXC4UaNWwEC2++PydY9gb3nY7Y6vs4=;
        b=pRuxH7PumLJ6QPobDT24/1R0JmtcBy4ofAS59KIQtyaEYoR9sXW6oF31EX1CGcDbPW
         La4ypLteYhkF08tkUfPq3VhvUA54Bv82ERDKFzNqLlRWx/CDgWp6dffxzMQsGTFGxpAW
         tAFE1Cv28hcFLCknh/pU6unYWLj7vMfE6AlIVEEJXteMbBG1veVPKBKE3nGsPa4ji4Qn
         vYtbZM4knvZWtnmQCD1HaqlBfo6t8qes0dqsrK3jRjM39wbE9UPx/hAL/jcLNJrOhNNd
         Z0hmhJKU3+YaZ1CECDbhTxbx0nanzZi2o3Vxhp5xpElexkK1Xxx/CSnhWTsJuvlAyEAr
         da7Q==
X-Gm-Message-State: AAQBX9cze4BakS/c9c0RmePb2wFH25HuUB8hVbhpvj1vBfGweqFNeT48
        lbIRU2gwyqNQ7DpaTq7IsuTV6xG3OaCix84BzSsCQi56w4YaCbR+n49CbrFOaxb4RzDSzrs1Mg/
        b2cJoZk73a3go3i87PQ1XX6CHdw4vVnFz
X-Received: by 2002:ad4:5ca6:0:b0:5df:450b:8002 with SMTP id q6-20020ad45ca6000000b005df450b8002mr4830661qvh.31.1680785467007;
        Thu, 06 Apr 2023 05:51:07 -0700 (PDT)
X-Google-Smtp-Source: AKy350YSPMv3nhVaAKMIwGcpzI1WXbVj1KNben3bHvDLvNgWUG5IbK0u6ODiRzBeHNfaFX4xk75FiA==
X-Received: by 2002:ad4:5ca6:0:b0:5df:450b:8002 with SMTP id q6-20020ad45ca6000000b005df450b8002mr4830628qvh.31.1680785466773;
        Thu, 06 Apr 2023 05:51:06 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id de11-20020ad4584b000000b005dd8b93457csm489252qvb.20.2023.04.06.05.51.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 05:51:06 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     bskeggs@redhat.com, kherbst@redhat.com, lyude@redhat.com,
        airlied@gmail.com, daniel@ffwll.ch, gsamaiya@nvidia.com
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] drm/nouveau/gr/tu102: remove unused tu102_gr_load function
Date:   Thu,  6 Apr 2023 08:51:02 -0400
Message-Id: <20230406125102.1952202-1-trix@redhat.com>
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

smatch reports
drivers/gpu/drm/nouveau/nvkm/engine/gr/tu102.c:210:1: warning: symbol
  'tu102_gr_load' was not declared. Should it be static?

This function is not used so remove it.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/gpu/drm/nouveau/nvkm/engine/gr/tu102.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/gr/tu102.c b/drivers/gpu/drm/nouveau/nvkm/engine/gr/tu102.c
index 3b6c8100a242..a7775aa18541 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/gr/tu102.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/gr/tu102.c
@@ -206,19 +206,6 @@ tu102_gr_av_to_init_veid(struct nvkm_blob *blob, struct gf100_gr_pack **ppack)
 	return gk20a_gr_av_to_init_(blob, 64, 0x00100000, ppack);
 }
 
-int
-tu102_gr_load(struct gf100_gr *gr, int ver, const struct gf100_gr_fwif *fwif)
-{
-	int ret;
-
-	ret = gm200_gr_load(gr, ver, fwif);
-	if (ret)
-		return ret;
-
-	return gk20a_gr_load_net(gr, "gr/", "sw_veid_bundle_init", ver, tu102_gr_av_to_init_veid,
-				 &gr->bundle_veid);
-}
-
 static const struct gf100_gr_fwif
 tu102_gr_fwif[] = {
 	{  0, gm200_gr_load, &tu102_gr, &gp108_gr_fecs_acr, &gp108_gr_gpccs_acr },
-- 
2.27.0

