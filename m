Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F14C7069E0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 15:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231727AbjEQNcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 09:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbjEQNcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 09:32:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEBE013A
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 06:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684330278;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=qLttclHj7hHhcC/wb0vN9cazD/0VuMDK2HeUMirb6Q8=;
        b=iSLxKgd+Daa4yCx0zB7me3ptdDTgtUZOAS9LfHvaUNBNzV7L1hZNQ6BCib5kL6yBDPO6kS
        ytISPaiKrfLp0S5NBYYXIEACTVmB9ZFFtok7D06WEP7LABZeBagb1kW/mkigOhuRBkC6/m
        BO14BCjJwp0l+p0jvqSM8HLuBK4Y13c=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-321-rGvEYjJANrG9tp9toPoIUg-1; Wed, 17 May 2023 09:31:16 -0400
X-MC-Unique: rGvEYjJANrG9tp9toPoIUg-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-61acaf012f0so4580946d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 06:31:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684330276; x=1686922276;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qLttclHj7hHhcC/wb0vN9cazD/0VuMDK2HeUMirb6Q8=;
        b=AQkximUjd4zNaCC7kMsVpTucII1IAu+r+MXLyNN68AR5YB2/8q/HXXxkftm5TBdNv5
         WG8axe8v5wIbunETnKO7gxFrxLLLznQ12WOZ88KIHnE5KIIPl3dlfga2j88yikmxX2T4
         AS5apjomKdcT2hX2k+2oPrCKjb8AIKaYPbbjviyX9yMsRlNqeX07cbv4jhMBkk+hQbxb
         qV+yB4vFEJr4NxZIYSmCjJD39zJa2bko3TtK8dnmgcunBNC8SFY2GVU9KH8lOSVlIL8w
         rv3M4PXUfYYFgrXIT24Imqa6x0PY9DLemf9Pq38XfzgNfUq9qaoq79qMd0PWPvfWD/qf
         XIsw==
X-Gm-Message-State: AC+VfDx1+NQpy3XiedV6HO2W86dOnA+4wtU2bySyOYvPlgemh8f0YBXA
        CefUVVjwxUCEDISRpXyWTapDAWBEiURbTLU3ir7eL6Tugf8FEtMBOJlqVVSVUMe7jaFTI04rkdD
        Wply6pIU8s4sq7P7Plr/HnjUc
X-Received: by 2002:ad4:5cce:0:b0:5ef:8c35:296c with SMTP id iu14-20020ad45cce000000b005ef8c35296cmr59457578qvb.44.1684330276112;
        Wed, 17 May 2023 06:31:16 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7pTwMVj9jWn4rorpVRcw8fHanBa08ioE8BoJ41Rc+agDBnPWOfYwP+DUBx0MafDcOonzskyw==
X-Received: by 2002:ad4:5cce:0:b0:5ef:8c35:296c with SMTP id iu14-20020ad45cce000000b005ef8c35296cmr59457545qvb.44.1684330275723;
        Wed, 17 May 2023 06:31:15 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id v13-20020a0cdd8d000000b006215e9d0503sm4691777qvk.21.2023.05.17.06.31.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 06:31:15 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     bskeggs@redhat.com, kherbst@redhat.com, lyude@redhat.com,
        airlied@gmail.com, daniel@ffwll.ch, gsamaiya@nvidia.com
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] drm/nouveau/acr/ga102: set variable ga102_gsps storage-class-specifier to static
Date:   Wed, 17 May 2023 09:31:12 -0400
Message-Id: <20230517133112.873856-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

smatch reports
drivers/gpu/drm/nouveau/nvkm/subdev/gsp/ga102.c:49:1: warning: symbol
  'ga102_gsps' was not declared. Should it be static?

This variable is only used in its defining file, so it should be static

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/ga102.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/ga102.c b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/ga102.c
index 525267412c3e..a3996ceca995 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/ga102.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/ga102.c
@@ -45,7 +45,7 @@ ga102_gsp_nofw(struct nvkm_gsp *gsp, int ver, const struct nvkm_gsp_fwif *fwif)
 	return 0;
 }
 
-struct nvkm_gsp_fwif
+static struct nvkm_gsp_fwif
 ga102_gsps[] = {
 	{ -1, ga102_gsp_nofw, &ga102_gsp },
 	{}
-- 
2.27.0

