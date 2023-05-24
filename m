Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3B7370EC05
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 05:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239351AbjEXDpY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 23:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239335AbjEXDpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 23:45:18 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38DF4C1
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 20:45:16 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-64d5b4c400fso366006b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 20:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684899915; x=1687491915;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0ynAa7x9o82bh71ClmeyjXXrZJrP7PlGAXE4hWpq/+Q=;
        b=KvLMYd02H/jW6tjlV8NoTqU4pYbvpat83NrsuNc3YgzZq3DDElxACzaVQSRh3twWDb
         CrKE4tFWnxzp2Fs/XWRNHJiY6Qf49eRaPSF2YsQcYiTR6vHJs9Nj+eO9SYJ0srunNdwF
         pSTslBDyq73t+QYu8PRMSH+gpscB5Vxsto2Mk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684899915; x=1687491915;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0ynAa7x9o82bh71ClmeyjXXrZJrP7PlGAXE4hWpq/+Q=;
        b=Ms4+6F7fg2on9YvDPHPiMz1lQgCT381tWjkSLLZL087fklix033d7HFmTxBC8+qbpK
         02EERpFeMHnrCDHYrV1hVBzrBpLHw1F4zSxAlP7RDuAi2aYYDbb8F0bIzXoF8ojEWFTw
         x5VNKucfxySVxYCxiYzsYqjB76afn+c14UJrmag54lnjhKx+hUwiPdG791JJjFjIqvl7
         S8+4ZLN9rOyT52ojKHqtZVspTg3/0Sx+VOz9t2LCMpFh4tz/YSPkvKNVoiuomfwkXVDj
         8iKSlrQ5IC/xtQHeSTzVwbWyNZAy+9FoPhGZjE9q6A/aa3JE2uVemAb6oKxfqfpXFAyJ
         K51g==
X-Gm-Message-State: AC+VfDwXTcVm0MPb1w1aAfzZQxrzKKoBDeZmLBEfuh4DgJAweXcXAc89
        WFJO5aTKv5ZYCa3CHxKDsfbNnA==
X-Google-Smtp-Source: ACHHUZ6FmsJRXxQpJff/TvMGJX03UiNyLftE56b7BjDYgHZnuGgyNrJT+QFH+jWJzdgkGZhEC1c99w==
X-Received: by 2002:a05:6a00:23c8:b0:62a:d752:acc5 with SMTP id g8-20020a056a0023c800b0062ad752acc5mr1573806pfc.32.1684899915747;
        Tue, 23 May 2023 20:45:15 -0700 (PDT)
Received: from fshao-p620.tpe.corp.google.com ([2401:fa00:1:10:3b18:4c0c:a178:5536])
        by smtp.gmail.com with ESMTPSA id d3-20020aa78683000000b0064cb1fe7e44sm6357616pfo.219.2023.05.23.20.45.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 20:45:15 -0700 (PDT)
From:   Fei Shao <fshao@chromium.org>
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jeff LaBundy <jeff@labundy.com>,
        Douglas Anderson <dianders@chromium.org>,
        Fei Shao <fshao@chromium.org>, Rob Herring <robh@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH RESEND v4 1/2] dt-bindings: input: goodix: Add "goodix,no-reset-during-suspend" property
Date:   Wed, 24 May 2023 11:42:36 +0800
Message-ID: <20230524114233.RESEND.v4.1.Idaa807e609fb3c322b96209c50f71d260917c7be@changeid>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
In-Reply-To: <20230524114233.RESEND.v4.2.I424e840ae6de3cdbd67394cf4efd24534f6434ba@changeid>
References: <20230524114233.RESEND.v4.2.I424e840ae6de3cdbd67394cf4efd24534f6434ba@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We observed that on Chromebook device Steelix, if Goodix GT7375P
touchscreen is powered in suspend (because, for example, it connects to
an always-on regulator) and with the reset GPIO asserted, it will
introduce about 14mW power leakage.

To address that, we add this property to skip reset during suspend.
If it's set, the driver will stop asserting the reset GPIO during
power-down. Refer to the comments in the driver for details.

Signed-off-by: Fei Shao <fshao@chromium.org>
Suggested-by: Jeff LaBundy <jeff@labundy.com>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
Reviewed-by: Jeff LaBundy <jeff@labundy.com>
Acked-by: Rob Herring <robh@kernel.org>


---

Changes in v4:
- Rebase on top of next-20230523
- Collect the review tags

Changes in v2:
- Use a more accurate property name and with "goodix," prefix

 .../devicetree/bindings/input/goodix,gt7375p.yaml        | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/goodix,gt7375p.yaml b/Documentation/devicetree/bindings/input/goodix,gt7375p.yaml
index ce18d7dadae2..1edad1da1196 100644
--- a/Documentation/devicetree/bindings/input/goodix,gt7375p.yaml
+++ b/Documentation/devicetree/bindings/input/goodix,gt7375p.yaml
@@ -43,6 +43,15 @@ properties:
       itself as long as it allows the main board to make signals compatible
       with what the touchscreen is expecting for its IO rails.
 
+  goodix,no-reset-during-suspend:
+    description:
+      Set this to true to enforce the driver to not assert the reset GPIO
+      during suspend.
+      Due to potential touchscreen hardware flaw, back-powering could happen in
+      suspend if the power supply is on and with active-low reset GPIO asserted.
+      This property is used to avoid the back-powering issue.
+    type: boolean
+
 required:
   - compatible
   - reg
-- 
2.40.1.698.g37aff9b760-goog

