Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 185066B8DCF
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 09:51:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbjCNIvb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 04:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbjCNIvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 04:51:19 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5426B54CB4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 01:51:05 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id b20so9216908pfo.6
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 01:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20210112.gappssmtp.com; s=20210112; t=1678783865;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xQPhsRPwIBJSw8lw9/twam5VTJIrUkvEv5SN14Y29N4=;
        b=6B84mYPTC1ctAxlQ/eWFnqMKDh5XbHqHG2MgCjXBK9diGVC4E9G9CLVUlrPgpt1jk2
         20sTZ7k+76uAGEkxkMudOPUVilOdjmwYbVCoBdG8WlWH9IcA2pRnMrForTVG1Ua0XHNH
         2v9UdKK8LAVPvOySJVcRzL3LWNIUMmBIztBQ6I4Kmf/fs/tHMuIvqzFxSU7avFwTYZD6
         Kw3yf0io7oC20hhq5Fxhm9p5eCBUdLQFQj/MQv1DRuuCq+oBWMf+0Dk3KT8N81jw6STB
         IQHEW9LgRaBAZ8inqnbZNrkU+wo3G+qqwpGqVXsJtVB9HiISnJqbKS8P8YneDdjDBV9R
         a+zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678783865;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xQPhsRPwIBJSw8lw9/twam5VTJIrUkvEv5SN14Y29N4=;
        b=ogyC0RhweNpgxiwlILkzGbMQfnSTF7caQgYtHLsGMt9dZ9LF6VZuZOpCZh+T3IQh+B
         DvStjDoNmUA6WjYxphfFkfgKqzOg/agdI8pOOfWVT7cTLyf+I2FLjLNP+4QlwOtMBKbM
         BJ5R6JTFeOHt6Kp40YXBuu/JL90lI9p7Eq6e7e15jek556mBJYicm5ezPCANSJ7YyAtF
         Uqcyz/jtP1ATAOdtOTxHL6lNJXUlY5U+xOXc9c89RS/hpr8wLCsqrKEf1rFvP+mwGCjU
         9RqTOlyuRLN+Kkq5oWPt4ZjE87iAXqTIVik05LdV0/I5U8wmgopckPyKY6Qwad1wF9qI
         2GYA==
X-Gm-Message-State: AO0yUKVeO02yQXR/gHGqUMROdENeqV17Ac+QMQaKjs5OEC0vasD4MJo9
        ak6tHI3vrKNi4o2kyPLl4yxUsvigwW3IrA/KegU=
X-Google-Smtp-Source: AK7set/msSKdiefdhGB9noxU+oedCQ6Qiq/waQhXwIqseVPcRRTkC/MtnzcJu4d4Nf+an3yT0p/tfQ==
X-Received: by 2002:aa7:9835:0:b0:624:b4f3:398f with SMTP id q21-20020aa79835000000b00624b4f3398fmr4481754pfl.0.1678783864739;
        Tue, 14 Mar 2023 01:51:04 -0700 (PDT)
Received: from chromeos.huaqin.com ([101.78.151.214])
        by smtp.gmail.com with ESMTPSA id f3-20020a63f103000000b004eecc3080f8sm1080637pgi.29.2023.03.14.01.51.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 01:51:04 -0700 (PDT)
From:   Ruihai Zhou <zhouruihai@huaqin.corp-partner.google.com>
To:     neil.armstrong@linaro.org, sam@ravnborg.org, airlied@gmail.com,
        daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, thierry.reding@gmail.com
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Ruihai Zhou <zhouruihai@huaqin.corp-partner.google.com>
Subject: [PATCH 1/2] dt-bindings: display: panel: Add compatible for Starry 2081101QFH032011-53G
Date:   Tue, 14 Mar 2023 16:50:34 +0800
Message-Id: <20230314085034.6380-1-zhouruihai@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The STARRY 2081101QFH032011-53G is a 10.1" WUXGA TFT LCD panel,
which fits in nicely with the existing panel-boe-tv101wum-nl6
driver. Hence, we add a new compatible with panel specific config.

Signed-off-by: Ruihai Zhou <zhouruihai@huaqin.corp-partner.google.com>
---
 .../devicetree/bindings/display/panel/boe,tv101wum-nl6.yaml     | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/boe,tv101wum-nl6.yaml b/Documentation/devicetree/bindings/display/panel/boe,tv101wum-nl6.yaml
index a2384bd74cf2..f98ed588c750 100644
--- a/Documentation/devicetree/bindings/display/panel/boe,tv101wum-nl6.yaml
+++ b/Documentation/devicetree/bindings/display/panel/boe,tv101wum-nl6.yaml
@@ -30,6 +30,8 @@ properties:
       - boe,tv110c9m-ll3
         # INX HJ110IZ-01A 10.95" WUXGA TFT LCD panel
       - innolux,hj110iz-01a
+        # STARRY 2081101QFH032011-53G 10.1" WUXGA TFT LCD panel
+      - starry,2081101qfh032011-53g
 
   reg:
     description: the virtual channel number of a DSI peripheral
-- 
2.17.1

