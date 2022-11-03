Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20DA3617B41
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 12:02:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231378AbiKCLBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 07:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231406AbiKCLBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 07:01:32 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECF1111469
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 04:01:31 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id y13so1247703pfp.7
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 04:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E6BayU7+whKMo3/qWo30Lf+/AWFHgaDluxjQcRS3B+I=;
        b=zBFjYYnEhLeXIdKyW1HwYfCDZkwamdYAyCaULgx22W6EDH2VciVt6JBdjuhARELL7Z
         B6TRmjSnBhSjw1uHc1PgyjAgbZqRJCo/5A1nWb5bHfG6WOF/WuQVA4HTv7b0a2xLswx1
         HYopKypv+/vT4/DxU0fHpK1pQNpu1pB7+3PElCF168ELSPW39BWfKleEHxSU9J0Fy7KB
         YvV1ZlHt3T1RcAuYWKU57QZY6hn+uM3jd72mlvRAKS7NYweoyk951Iy2kJIO03mAzs65
         VNKwiTb/seEZcw+57WkozNYEn0gMa3GDAhUC+tFjhSNTyu07QiIx4cWUWLhKftY/l7dd
         FQfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E6BayU7+whKMo3/qWo30Lf+/AWFHgaDluxjQcRS3B+I=;
        b=vh17+ZasM9fXhXWO6jQWcz1mn7SnJYUcyY6vLDqkdDIE0EYTjzAXzvUOYp5LjtoZbd
         PISif2w/8PJPCZEYl+J0HUgOnbckGgCZuuyIjZd3wehFsL1FiIhXoN8qSXaDPRT+65zO
         sQ9I7K6UvoD4HgqcT+3x0MDhmtZQ2hESWNb8Bq2kCheNNus5swjSJNLzC+VhjDS2oOrw
         OU7rnMOl4yxCEYomTqvzqsLca58amWlw7wa6Xd4LOW9gKawcvNemktKRw7eEX639p2W5
         cjR+jI3pK8ymSMzcnRYEwHPjr0miOK02n/GSffug0KusF7zoUEDgHO9/Yav1phmqWb02
         IAfg==
X-Gm-Message-State: ACrzQf1qm4pVgsEPtqtovPFyXRuyhIfkWUmNHGW/29a38nidmEblf6L+
        QzzHCh+cz4KxPObyYX40XHmuWw==
X-Google-Smtp-Source: AMsMyM4HjVW6bkRyhyG5xTtXGuUSaciInOBhBw7kerR3KeoO2GrpLemNgw+shfbnxFL628VqHpEE9g==
X-Received: by 2002:a63:3347:0:b0:470:1a94:4bf with SMTP id z68-20020a633347000000b004701a9404bfmr3864142pgz.374.1667473291406;
        Thu, 03 Nov 2022 04:01:31 -0700 (PDT)
Received: from localhost ([122.172.84.80])
        by smtp.gmail.com with ESMTPSA id f3-20020a170902f38300b0016c50179b1esm355601ple.152.2022.11.03.04.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 04:01:30 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     James Calligeros <jcalligeros99@gmail.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] dt-bindings: opp: Fix named microwatt property
Date:   Thu,  3 Nov 2022 16:31:05 +0530
Message-Id: <52bfa57ae698da9881e8a9302473e87f5757d5b6.1667473008.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1667473008.git.viresh.kumar@linaro.org>
References: <cover.1667473008.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The named microwatt-<name> property should look exactly like microvolt
and microamp properties. There were some differences, fix them.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 Documentation/devicetree/bindings/opp/opp-v2-base.yaml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/opp/opp-v2-base.yaml b/Documentation/devicetree/bindings/opp/opp-v2-base.yaml
index cb025b0a346d..cf9c2f7bddc2 100644
--- a/Documentation/devicetree/bindings/opp/opp-v2-base.yaml
+++ b/Documentation/devicetree/bindings/opp/opp-v2-base.yaml
@@ -230,9 +230,9 @@ select: false
         minItems: 1
         maxItems: 8   # Should be enough regulators
 
-      '^opp-microwatt':
+      '^opp-microwatt-':
         description:
-          Named opp-microwatt property. Similar to opp-microamp property,
+          Named opp-microwatt property. Similar to opp-microamp-<name> property,
           but for microwatt instead.
         $ref: /schemas/types.yaml#/definitions/uint32-array
         minItems: 1
-- 
2.31.1.272.g89b43f80a514

