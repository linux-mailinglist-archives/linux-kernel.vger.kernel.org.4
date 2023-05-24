Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E36F970EFC3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 09:45:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240022AbjEXHpP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 03:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240071AbjEXHpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 03:45:09 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 257CF9D
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 00:45:08 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-64d2e8a842cso428564b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 00:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20221208.gappssmtp.com; s=20221208; t=1684914307; x=1687506307;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XcvZIGJdFMrCWPf6vbR4FP3VGTx+Sg81oee61Qyy4FY=;
        b=a6ymZgcQ68mWVErWlm3JSIwEUV4yrM9n4Oyt1TNQHZZXikodQmdoIC/fYxMWFYI9ti
         Sc50MNeIbHjvX/Tsy8AZe1RXOILO+LAYIkT6oQIaRmIGwtQaZTQUGSiphIQpetl68tGZ
         1F3T0zntb+BQ6FE82KoNFDZdG0OMoweo9xHit/m28dnmQbVJ21Go03e5GWTXspGSVhCG
         WfwgHWV3uBuYj8/B8Cl1Utb99LHBc3/QO3iHBPyXUfCbUCX2Vmrj+XPb8zwWYu/5WLFS
         e7UJEJytrpvxLYInjo7ddZpvRGdDiGALfniwkszUIM/fR+T5Rw+Elk2GEIhcCRisu9n2
         p5vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684914307; x=1687506307;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XcvZIGJdFMrCWPf6vbR4FP3VGTx+Sg81oee61Qyy4FY=;
        b=P+pLB7cQ1s0TEu2Y7gDMTI8fB1GOB7qutPrcgQgcEfQneTS9wUUyNzlKCFhL8QgziN
         bnge87i2e0FBmdwMg+m6umhWk9V7PRAaOZvZ6pRopmSBE6zgNI9G7kkpMywLHGjkBqE0
         pDN0CNKkkyUtrvmpqIZcMhFv87qlww0K3aJ6evH310Dfeiz7e0sYQ5rtI6GvC73yxuX8
         FceLy9MkG0dX0sCg0FAu6TGZjveS3qVKZ4aZ3I5w5Zl5fPZ8DdScSP+W6eCjq1la91Nf
         iPf2/nsvH40x6C86oWFQAHW0skeVuz3aW9Phuo2phZbPpMw/86KMSSJhnSwMYR6fLEKD
         YJwQ==
X-Gm-Message-State: AC+VfDyCzBKs51rNoP8fnZCtTTW0zbeQsMbzKgQqGfaJE2whCMIbhNmn
        /qm/vSG+Ed5Ly0Se5wXNSGrLnA==
X-Google-Smtp-Source: ACHHUZ6k+sUhyKEZAV3qBA7O7TPMGVoC2tx9dOmF1yFyZ9sAvW1pFXnSidJsHEO5fgbQBrlW/ZP9yg==
X-Received: by 2002:a05:6a21:329a:b0:10b:4f58:3fef with SMTP id yt26-20020a056a21329a00b0010b4f583fefmr11847954pzb.2.1684914307412;
        Wed, 24 May 2023 00:45:07 -0700 (PDT)
Received: from yc.huaqin.com ([101.78.151.214])
        by smtp.gmail.com with ESMTPSA id j6-20020a62e906000000b0063d29df1589sm6801336pfh.136.2023.05.24.00.45.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 00:45:06 -0700 (PDT)
From:   Cong Yang <yangcong5@huaqin.corp-partner.google.com>
To:     dianders@google.com, daniel@ffwll.ch, neil.armstrong@linaro.org,
        sam@ravnborg.org, airlied@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, hsinyi@google.com,
        conor+dt@kernel.org
Cc:     devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Cong Yang <yangcong5@huaqin.corp-partner.google.com>
Subject: [v2 2/4] dt-bindings: display: panel: Add compatible for Starry himax83102-j02
Date:   Wed, 24 May 2023 15:44:53 +0800
Message-Id: <20230524074455.1172064-1-yangcong5@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CAD=FV=WRecTWsFM96k81YAx1=jJT0vpS4EPP0ZfWFUGHNFx9Tw@mail.gmail.com>
References: <CAD=FV=WRecTWsFM96k81YAx1=jJT0vpS4EPP0ZfWFUGHNFx9Tw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The STARRY himax83102-j02 is a 10.51" WUXGA TFT LCD panel,
which fits in nicely with the existing panel-boe-tv101wum-nl6
driver. Hence, we add a new compatible with panel specific config.

Signed-off-by: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
---
 .../devicetree/bindings/display/panel/boe,tv101wum-nl6.yaml     | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/boe,tv101wum-nl6.yaml b/Documentation/devicetree/bindings/display/panel/boe,tv101wum-nl6.yaml
index aed55608ebf6..28a7beeb8f92 100644
--- a/Documentation/devicetree/bindings/display/panel/boe,tv101wum-nl6.yaml
+++ b/Documentation/devicetree/bindings/display/panel/boe,tv101wum-nl6.yaml
@@ -32,6 +32,8 @@ properties:
       - innolux,hj110iz-01a
         # STARRY 2081101QFH032011-53G 10.1" WUXGA TFT LCD panel
       - starry,2081101qfh032011-53g
+        # STARRY himax83102-j02 10.51" WUXGA TFT LCD panel
+      - starry,himax83102-j02
 
   reg:
     description: the virtual channel number of a DSI peripheral
-- 
2.25.1

