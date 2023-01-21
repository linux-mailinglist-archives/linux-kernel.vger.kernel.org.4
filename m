Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDA8F6761D8
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 01:02:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbjAUACC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 19:02:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbjAUAB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 19:01:57 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C91138B753;
        Fri, 20 Jan 2023 16:01:56 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id q10-20020a1cf30a000000b003db0edfdb74so1639315wmq.1;
        Fri, 20 Jan 2023 16:01:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0ogL/1lSUlkuM5blt1CF8xgQb3CjQ2KzCvYZsa2SRR4=;
        b=evrm8fT/Kwu45Vp+aemRE5zqqp7ggtVo8Ps1wtNglPyWMeHF63ePTlgrUZQ9viVblW
         GTGge4PNNEC9bRo1l4jpE/eJc/jGolUTAZ4oiQWSP5d9D8CN1/zXoDrY//Fcc3RE+AXy
         YZFTM0OXU6Y6y8YTLuOCF166yVzqay+8/Ae+dQ0AFviC2MXKRD0UY47etrQL3xqdenjX
         VAPUzJnaK/xlXx/ybEUKOX7zmW1shQ/WbIeuY1BGRH5JYJ8iJNueWZlU+oynSkr2RLuA
         T8JUUQXbGfZXM+4icMDk69Lc7dDoMXGrIorMkg69QgDkDbePRNxwLynqlfPt93FRyVSm
         rkgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0ogL/1lSUlkuM5blt1CF8xgQb3CjQ2KzCvYZsa2SRR4=;
        b=InaKtcafF2yO1w/LiRnPCuhGPtv0q35NM+dNT86C6UymeAFCdDCG2WpwaMYpF499ML
         cmXhsLM8nxRgsLVSXXiNHQ8+VVR9TuX8s9R6Y4kZwF/6lleMeiv4STx32b97lMMlMrF2
         SmNgda6U2zsq/TrzxPY2cuqFq46cvoF1M/cXgE4UgRVhoC7nIcEY3qZ1Wx/jQjei+QQC
         Ogu9Iqn/IxG6HHiGVIWgdaxseP6ROtVl3tHWhLcUIEjPcbzfaw2EwAhnZ1vx96c33oaD
         NqIA29BKzoMAmwSXW5SjXBTeljOIVwE4+FlnH389LQnRszZzXvdHIMh356rstsaTELmm
         XX3A==
X-Gm-Message-State: AFqh2kry7XaQhc7FEmp44gZgUYIETcQno19gmenOBVkkI6sKMcDfh2RW
        ZR0+eDrw0njLRci72lhqeWM=
X-Google-Smtp-Source: AMrXdXskIekwssjYf6UOlU07IJ2OwDZ/ncq/l6EMFJqKhTAczBKb+Q/Rw+oKkR5Sxac9CGOc724cuQ==
X-Received: by 2002:a05:600c:ad0:b0:3d9:ebab:ccff with SMTP id c16-20020a05600c0ad000b003d9ebabccffmr24307431wmr.33.1674259315287;
        Fri, 20 Jan 2023 16:01:55 -0800 (PST)
Received: from localhost.localdomain (93-34-92-88.ip49.fastwebnet.it. [93.34.92.88])
        by smtp.googlemail.com with ESMTPSA id h11-20020a05600c314b00b003db2e3f2c7csm5284292wmo.0.2023.01.20.16.01.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 16:01:54 -0800 (PST)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Ilia Lin <ilia.lin@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH 3/3] dt-bindings: opp: opp-v2-kryo-cpu: enlarge opp-supported-hw maximum
Date:   Sat, 21 Jan 2023 01:01:46 +0100
Message-Id: <20230121000146.7809-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230121000146.7809-1-ansuelsmth@gmail.com>
References: <20230121000146.7809-1-ansuelsmth@gmail.com>
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

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml b/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml
index cea932339faf..b4ebaf68b43e 100644
--- a/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml
+++ b/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml
@@ -55,7 +55,7 @@ patternProperties:
           1:  MSM8996, speedbin 1
           2:  MSM8996, speedbin 2
           3-31:  unused
-        maximum: 0x7
+        maximum: 0xff
 
       clock-latency-ns: true
 
-- 
2.38.1

