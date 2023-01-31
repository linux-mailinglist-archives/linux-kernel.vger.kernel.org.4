Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90FA4683155
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 16:21:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233247AbjAaPVO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 10:21:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232828AbjAaPUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 10:20:43 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 525AF589A3;
        Tue, 31 Jan 2023 07:18:35 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id q8so10575032wmo.5;
        Tue, 31 Jan 2023 07:18:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oje2X12UqN3hFAptDZ/80EkF8Fd5akHgh1yM49ZX7sI=;
        b=qDYj2LrT6Ak6dKZ1tobe/lJRGSirc3zbzWWt7vWbDrgrRqUMwzUJgHn1y+o7ksZwH6
         8IubtJkhGTi9+cotasj3KIpQNuNk5R9ODlngRYnuM1APSr462lhbRd23jGJSxcaI04Rf
         77qHQ0wxkmrCxvERRpS5Aqvf4pq2MrGFwasiTYGsqyFNoEUKiwkgGko7GtL9qxWq/Tww
         rpTd1RMqwwGc5Xo7d+m8P1tPpr4hNHjlBcou+uu6uwwp2418YnwIV0/BkSw6EUymI19M
         cvCqRlDhwfE3YGR18WLtAczZAziKnEjRWmRDcrSAqhlMEhddew40yTM2wSpf1Q1X5MCq
         D7UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oje2X12UqN3hFAptDZ/80EkF8Fd5akHgh1yM49ZX7sI=;
        b=SATrndbHHuEC+SdnWbGC5J0aPk/8S9AbwkR6qQTOZHDNQXOOaaa7GKzWsdjUXxHbPL
         T0TvQ6kQUmuqEcTXPWMCIG6g83qslLHQdh23muU6//GCAhnk9RdDr7q0dr+SsvVC4NuY
         sDGp6yCidAASTw5HAT1jLmoTGk+Pu4F6dU9lwwPxJhTkPkNyXoQmszknWdKTO0Uhgd96
         pPI4MyLIIE8IVyl1IOU4NqlgczA6TqoevSeJfYgRm37q/EU74/mAidzbiH/LsIw67DFy
         bZDVAEgHbqS/SoKQb1zZ5XeQv5ZzbADczUgBmpUkRsZFfngtixK1d8Pbt8cWQ9yUWMeY
         G9HQ==
X-Gm-Message-State: AFqh2krLSrOFSuf0258G8JUsw6Z1+ThavZg4BAjoo/5CkfJ27Sm96jRy
        KTIxuvfP9wwT2SSKz1zwukk=
X-Google-Smtp-Source: AMrXdXu6q1r07Mhk9IvC6Qghagx78uVacKRSM8kVyAvklx9a3sbnah+20FtAfO3N0fjqFnEoYYPPzg==
X-Received: by 2002:a05:600c:22c6:b0:3da:fc30:bfc5 with SMTP id 6-20020a05600c22c600b003dafc30bfc5mr55192039wmg.13.1675178313585;
        Tue, 31 Jan 2023 07:18:33 -0800 (PST)
Received: from localhost.localdomain (93-34-88-241.ip49.fastwebnet.it. [93.34.88.241])
        by smtp.googlemail.com with ESMTPSA id x9-20020a05600c21c900b003dc434b39c7sm2854861wmj.0.2023.01.31.07.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 07:18:33 -0800 (PST)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Ilia Lin <ilia.lin@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v5 3/3] dt-bindings: opp: opp-v2-kryo-cpu: enlarge opp-supported-hw maximum
Date:   Tue, 31 Jan 2023 16:18:19 +0100
Message-Id: <20230131151819.16612-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230131151819.16612-1-ansuelsmth@gmail.com>
References: <20230131151819.16612-1-ansuelsmth@gmail.com>
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

Enlarge opp-supported-hw maximum value. In recent SoC we started
matching more bit and we currently match mask of 112. The old maximum of
7 was good for old SoC that didn't had complex id, but now this is
limiting and we need to enlarge it to support more variants.

Document all the various mask that can be used and limit them to only
reasonable values instead of using a generic maximum limit.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
Changes v5:
- No change
Changes v4:
- Add review tag from Krzysztof
Changes v3:
- Fix dt_binding_check for missing 0x5 and 0x6 value
Changes v2:
- Document additional bit format

 .../devicetree/bindings/opp/opp-v2-kryo-cpu.yaml | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml b/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml
index b4947b326773..bbbad31ae4ca 100644
--- a/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml
+++ b/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml
@@ -50,12 +50,22 @@ patternProperties:
       opp-supported-hw:
         description: |
           A single 32 bit bitmap value, representing compatible HW.
-          Bitmap:
+          Bitmap for MSM8996 format:
           0:  MSM8996, speedbin 0
           1:  MSM8996, speedbin 1
           2:  MSM8996, speedbin 2
-          3-31:  unused
-        maximum: 0x7
+          3:  MSM8996, speedbin 3
+          4-31:  unused
+
+          Bitmap for MSM8996SG format (speedbin shifted of 4 left):
+          0-3:  unused
+          4:  MSM8996SG, speedbin 0
+          5:  MSM8996SG, speedbin 1
+          6:  MSM8996SG, speedbin 2
+          7-31:  unused
+        enum: [0x1, 0x2, 0x3, 0x4, 0x5, 0x6, 0x7,
+               0x9, 0xd, 0xe, 0xf,
+               0x10, 0x20, 0x30, 0x70]
 
       clock-latency-ns: true
 
-- 
2.38.1

