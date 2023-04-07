Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 757A56DAC68
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 13:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239715AbjDGL4q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 07:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231758AbjDGL4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 07:56:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E1FE49CE
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 04:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680868558;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=n4yjwe4G2G9/env2LGiwcE/Ce2F1TWlNc2OcCX0hL4A=;
        b=a5engY+r6qnupqwzHEPKsiXwj+2L5t8UaMdtpT3SRBTZJqlwyu0L8Upm9nrLtCSEYh60Io
        jldgCuISSf/67zAig1nRazklabmbGpmkuu0VS0akHsMMN2n6QBHMtT+S51ZAtdHCsQBRyz
        1+p1ddNM6GHOChSDpgcgYtvaUFIsPYE=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-140-GzVVEtp-PrC71oXPTBSlMA-1; Fri, 07 Apr 2023 07:55:57 -0400
X-MC-Unique: GzVVEtp-PrC71oXPTBSlMA-1
Received: by mail-qt1-f200.google.com with SMTP id a19-20020a05622a02d300b003e4ecb5f613so23212605qtx.21
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 04:55:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680868557;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n4yjwe4G2G9/env2LGiwcE/Ce2F1TWlNc2OcCX0hL4A=;
        b=IoILu1cFcs6eDMOs4lPVsAZBTX/aOohRdpXYET68JziJZ5jgesIGL8WMDZpQebw8GR
         S4JHGif0aqWP7SVgTp5jc/ExwkUAZutMt3D113hgKssUgOy8+CMppXRBAgLaUVw1BIBC
         zIdmrcn0OOtsTcEV0+MSLheittM7jtCP0WlSooxOuP5bWFANCh4XSet3rK35OePYpRV8
         IHkupo1Ch6wdRX/HOMFnD3+No9bQF6aWYciWG9a87DswqRjoU5oFVoRskPSAUbsLr2qp
         ADwtNvimJPy6tjJF3MXO/yabizZXh6/mukIffl+h4WjxepxXBjOJE1OYMPtfKKE2nhSL
         4ozw==
X-Gm-Message-State: AAQBX9dARkV++Jj76O3tWXylNnO5U54vV/TXFOCfYjYNwS7GYVExIkAr
        GOt81+d1Jg9STJVenuH5A/d2YhcGq2FwQcB+d8hpcHliwslVO7xb3NpiF79LEfp0VZl+3XpfMfy
        4nBj0DiPA/MM/cYpsT5hATBeM
X-Received: by 2002:a05:622a:1646:b0:3bf:b70b:7804 with SMTP id y6-20020a05622a164600b003bfb70b7804mr3553525qtj.25.1680868556851;
        Fri, 07 Apr 2023 04:55:56 -0700 (PDT)
X-Google-Smtp-Source: AKy350bl0Z3EzCJjIcLXRO1sAvzdukxxqrzrxNB4Iggt9a8A/nFDAbH/D/tViLjUBbsmcHprRWWaUQ==
X-Received: by 2002:a05:622a:1646:b0:3bf:b70b:7804 with SMTP id y6-20020a05622a164600b003bfb70b7804mr3553498qtj.25.1680868556613;
        Fri, 07 Apr 2023 04:55:56 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id t186-20020a3746c3000000b00746ae84ea6csm1256321qka.3.2023.04.07.04.55.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 04:55:56 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, colin.i.king@gmail.com,
        fshao@chromium.org, jiaxin.yu@mediatek.com,
        allen-kh.cheng@mediatek.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] ASoC: mediatek: mt8186: set variable aud_pinctrl to static
Date:   Fri,  7 Apr 2023 07:55:53 -0400
Message-Id: <20230407115553.1968111-1-trix@redhat.com>
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
sound/soc/mediatek/mt8186/mt8186-afe-gpio.c:14:16: warning: symbol
  'aud_pinctrl' was not declared. Should it be static?

This variable is only used in one file so should be static.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 sound/soc/mediatek/mt8186/mt8186-afe-gpio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/mediatek/mt8186/mt8186-afe-gpio.c b/sound/soc/mediatek/mt8186/mt8186-afe-gpio.c
index 20b9f5d810ec..f12e91cc4fcf 100644
--- a/sound/soc/mediatek/mt8186/mt8186-afe-gpio.c
+++ b/sound/soc/mediatek/mt8186/mt8186-afe-gpio.c
@@ -11,7 +11,7 @@
 #include "mt8186-afe-common.h"
 #include "mt8186-afe-gpio.h"
 
-struct pinctrl *aud_pinctrl;
+static struct pinctrl *aud_pinctrl;
 
 enum mt8186_afe_gpio {
 	MT8186_AFE_GPIO_CLK_MOSI_OFF,
-- 
2.27.0

