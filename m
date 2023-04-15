Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65A8E6E30DB
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 12:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbjDOKsM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Apr 2023 06:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbjDOKsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Apr 2023 06:48:04 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C7AC7D8A;
        Sat, 15 Apr 2023 03:47:35 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id qb20so51462141ejc.6;
        Sat, 15 Apr 2023 03:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681555623; x=1684147623;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ICwYyWWnryvHm9RgRWeq29kRBlsUBNW7tslN8BXiwmU=;
        b=BQaKk6QpiVmZPeB/smhkVOuNZTbb+v8ly+PlkeCAAUt25cyNgPCVm9EHDY1zU5H9ZJ
         GVarHQ5Bc6ZcGPe6Bwfk8vERzbJADby9E/E4YAXf9GrGff/klt/bFP/Lm3NC4VKujCGF
         vHOa1yCSPHf70VHMBwULihW2kIzTwHzKKADr3KbFPA53nKl5Xb6wT9FbFoZv8LTZ/mH5
         hTjRz4qA8W12+1+3cOV2vzKvjJMUW0G5cSRcoXl0bdyEgPAPNH3nS2aL9/6bZcLTxOI3
         hPzl/BZxx9dUBa0lM+AOa+Ts1Dh7s6E2VR25Q7p8TuWCo5L7ZgLE4cxSLqulgNyQgrIz
         MzVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681555623; x=1684147623;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ICwYyWWnryvHm9RgRWeq29kRBlsUBNW7tslN8BXiwmU=;
        b=Toj0hslV3eSu4GkIKYe0GOYsuMlI8f0w5GpYbaHjxeXkFlxjZN587UEfnEt3eD/ZLk
         h/eaq7bvcSDdflXXoIxyJ8lC9VNqHCZbgBNoJ7W7QaMVFnNqV7n5614yfYc0pikDhdJb
         Ng9vQ3l7DIviECTVBheIonMR62b07JmF2iT6oL8pPyFfYCf2AuBtxwjJeKR3oXqt9dzX
         omrdjbvTQcohSIMCNp06hXDIVcFUHGQxvz0zy8tV09WOv8gHHB+1UU45sMPqfod5vXay
         5T/1ZeaSbvcTDb6A2uv3VGcdzW4NS4ijXIom7AIjXmGJNStdZIXH1Ze/GTVWJmLGEVGI
         8WWw==
X-Gm-Message-State: AAQBX9dxQJs5OrbhhSBo+QxdolF61wWj18xGWpaVZF3iWUyJdYegc03y
        ISSWcQWZk/kKM0AtSC/Putw=
X-Google-Smtp-Source: AKy350ZlZmmQo025rfm2e2tAa9xyZl6HKwCyENZ72HZZ0DvAjQTuASLgS7n6KD8a24YZf10jRtRI2A==
X-Received: by 2002:a17:907:2087:b0:94e:fe0f:b2be with SMTP id pv7-20020a170907208700b0094efe0fb2bemr1577373ejb.14.1681555622742;
        Sat, 15 Apr 2023 03:47:02 -0700 (PDT)
Received: from localhost.localdomain (82-149-1-233.dynamic.telemach.net. [82.149.1.233])
        by smtp.gmail.com with ESMTPSA id m15-20020a170906720f00b00947ab65d932sm3607034ejk.83.2023.04.15.03.47.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Apr 2023 03:47:02 -0700 (PDT)
From:   Jernej Skrabec <jernej.skrabec@gmail.com>
To:     andrzej.hajda@intel.com, neil.armstrong@linaro.org,
        rfoss@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, wens@csie.org,
        samuel@sholland.org
Cc:     Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        airlied@gmail.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-media@vger.kernel.org,
        hverkuil-cisco@xs4all.nl, Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH 0/3] drm/bridge: dw_hdmi: allow to disable CEC from DT
Date:   Sat, 15 Apr 2023 12:46:10 +0200
Message-Id: <20230415104613.61224-1-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Boards can have perfectly working DW HDMI CEC implementation but they
may prefer to use bit banged implementation instead. This is the
situation on Beelink X2.

Add DW HDMI DT property for disabling CEC. This prevents confusion on
userspace side by not exposing unused CEC interface.

Best regards,
Jernej

Jernej Skrabec (3):
  dt-bindings: display: synopsys,dw-hdmi: Add property for disabling CEC
  drm/bridge: dw_hdmi: Handle snps,disable-cec property
  ARM: dts: sun8i: h3: beelink-x2: Disable DW-HDMI CEC

 .../devicetree/bindings/display/bridge/synopsys,dw-hdmi.yaml | 5 +++++
 arch/arm/boot/dts/sun8i-h3-beelink-x2.dts                    | 1 +
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c                    | 4 +++-
 3 files changed, 9 insertions(+), 1 deletion(-)

-- 
2.40.0

