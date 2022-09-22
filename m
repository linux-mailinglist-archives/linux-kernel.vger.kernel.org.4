Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05E6C5E5FBE
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 12:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231459AbiIVKVs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 06:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbiIVKVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 06:21:44 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F59CDCCDE;
        Thu, 22 Sep 2022 03:21:43 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id j6-20020a17090a694600b00200bba67dadso1633883pjm.5;
        Thu, 22 Sep 2022 03:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=o6xu+yl0sAoM0tROMdtxNdIeDGHcI2f+bbEErZwZj5k=;
        b=IiRY7xBSerH4oG2/5gl5RfurmRCkG7EozhwqshvaukwjvvbrwxgaBAEUwyO8gCac20
         fMcgiPTNDbDAaaVo9+D/XCG+hKjWFS8uvhIuj44xOPc6hoU3xM7ayAUJ7GFuWpyUEzQP
         BaI4l8ApTqqJlrCxcNnf30RIkNuVPZRos6uWrHqYk6UuuHeV+h+emt0qtxkNCGTWz074
         bzCl4pUrEemi2jDZxwuFdtp3TJrzwLTY4s+JHH/zwHpXClh3OswlWn/RPbuia/Gu0DUp
         fL3Ko8rqt/xOr6DCvY/ccBioOTngiqhezWIASvtjQHeZSvhUvpgr4XOee0bQRVfXQ+2V
         xffw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=o6xu+yl0sAoM0tROMdtxNdIeDGHcI2f+bbEErZwZj5k=;
        b=ISMeZoqhwADSo8+L6wBXkGaJb6WC0Enuv+6EotsgM6ASpsBYLLftqTJplycsiTHVj+
         m5454vk4t+xn4LwoQmMCzV9Cg4OAnBXXyegqifndyPGUueNX+Gaigqc7KQgyyXHTt4Up
         nL16Mt/htztJiYtzVBcdhj5xOdrCxnmdojzFpaZdAjedexOJC91jERnAHrfybOt4RLX0
         Q9hiw4DmOufLZt3mH6jJDv2mhQoj/CHUJBOCDN1lT1B0LHjkHoL3cEOKwFD6SiibqSMs
         7qZnEgv8PfRj6/HUTLP2JuLpXudkQ+nSWO6rOK6gJmtQiafwcEdAf8kRMkElzrNsdcg6
         MvwA==
X-Gm-Message-State: ACrzQf0Uhr3FJx/5vqQO4pkNa/QE9pueQHBMaKtCy2rd5CaLyBzCmQBL
        GN3T7hmLpfYOi/L37DgQnw2qSp9ymO0=
X-Google-Smtp-Source: AMsMyM4o+BLOAYQBRVwflYZ5fZDO+TfbqJJEUkDC+pp5usm36ZmOecq199mq6USlbpFvNiLVpq47Hw==
X-Received: by 2002:a17:902:7fc8:b0:176:8bc0:3809 with SMTP id t8-20020a1709027fc800b001768bc03809mr2560652plb.21.1663842102422;
        Thu, 22 Sep 2022 03:21:42 -0700 (PDT)
Received: from localhost.localdomain ([103.104.171.43])
        by smtp.gmail.com with ESMTPSA id v16-20020a63f210000000b0042a713dd68csm3422050pgh.53.2022.09.22.03.21.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 03:21:41 -0700 (PDT)
From:   Yunlong Jia <ecs.beijing2022@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Yunlong Jia <yunlong.jia@ecs.com.tw>,
        Henry Sun <henrysun@google.com>,
        Bob Moragues <moragues@chromium.org>,
        Yunlong Jia <ecs.beijing2022@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH v4 1/4] dt-bindings: arm: qcom: Document additional skus for  sc7180 pazquel360
Date:   Thu, 22 Sep 2022 10:21:17 +0000
Message-Id: <20220922101813.v4.1.I3aa360986c0e7377ea5e96c116f014ff1ab8c968@changeid>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pazquel360 is an extension project based on pazquel.
We create 3 sku on pazquel360:
   sku 20 for LTE with physical SIM _and_ eSIM and WiFi
   sku 21 for WiFi only
   sku 22 for LTE with only a physical SIM
 Both sku20 and sku22 are LTE SKUs.
 One has the eSIM stuffed and one doesn't.
 There is a single shared device tree for the two.

Signed-off-by: Yunlong Jia <ecs.beijing2022@gmail.com>
Reviewed-by: Douglas Anderson <dianders@chromium.org>

---

Changes in v4:
 1. Adjust the 'Signed-off-by'.

Changes in v3:
 1. Adjust the format of the changelog.

 Documentation/devicetree/bindings/arm/qcom.yaml | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 944b364bed12a..8060c35d003b4 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -390,6 +390,17 @@ properties:
           - const: google,pazquel-sku2
           - const: qcom,sc7180
 
+      - description: Google Pazquel360 with LTE (newest rev)
+        items:
+          - const: google,pazquel-sku22
+          - const: google,pazquel-sku20
+          - const: qcom,sc7180
+
+      - description: Google Pazquel360 with WiFi (newest rev)
+        items:
+          - const: google,pazquel-sku21
+          - const: qcom,sc7180
+
       - description: Sharp Dynabook Chromebook C1 (rev1)
         items:
           - const: google,pompom-rev1
-- 
2.17.1

