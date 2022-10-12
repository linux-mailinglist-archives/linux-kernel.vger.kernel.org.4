Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 071B65FCB1F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 20:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbiJLSyy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 14:54:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbiJLSy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 14:54:27 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBE54FF250;
        Wed, 12 Oct 2022 11:54:18 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id s30so25750176eds.1;
        Wed, 12 Oct 2022 11:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XuM0asiay0q79ayybowJJZuVWbLZ0HhKbex1LkU3+rE=;
        b=K5Ru8YszgGbbGCKYJMpUE0UhMbn494oEmR+WP9M0p9/uYRItHbZCEnpJXSnQmA9rsz
         ioHyKhQ39Y0jJPnTQ6adtlnTjQ41Laoi6MzFX3iBgPu18Mq0zezkt0D1nTWRNUus/TPw
         48F4I28UzK1zF71wPL/WgSo1kcI1tMOOHaQ9eNKGACWZpgpkzSCxWUEwL7zDW5fpRjxY
         s8iO5ueqyQuvoFVwoCYkTArXUTUIgMFxeMcW2LHg5Yc02sFh4jEfHeYo5cE1gfVvC9S+
         Q7DS9eNyTEHsDwskY0Lrv82lvgznfgrK3erU5vSeMTju6+go4vvBcbJsGNJ+xjBXGvCu
         o4+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XuM0asiay0q79ayybowJJZuVWbLZ0HhKbex1LkU3+rE=;
        b=dEaYkDmbJNJbIOHQhpfz8G21R9gm0X7ZjQNnJ0i93TU8mtoe/yxLsfH29KRSgYjx1Q
         v9aqVeQI+DAzsuflY1P3+IgC0YG94JaNmWYEpvo2EwSjV6USEik51vI6c3KBWsFLBh+M
         rEOVSnX5D9gkZqX12ASkM2jEqbWAX0cGxQfCaOy5zBm+nUc4u4JfCLlgzL7rqngSssY4
         rIOYdS7twcPbkKfSkYmW1cdWxlu602bJ3nSrO0zxD08s2HR5hMhy3PCTrqohcVgkF4KY
         JKaa2+ag7wBAk0Kos+irhoC5fC1tQNxpsvDCOQ8q1e0S8ILPaEdhjLVfFBDqqvPHTyw+
         JCXA==
X-Gm-Message-State: ACrzQf216J0B16cX1A25ukSHbc5yu/tgrrHtTO9HzKQFW55nRmiC9zoP
        m5S17aED/iIUibehAVSlE9zqxdt5X7w=
X-Google-Smtp-Source: AMsMyM53NuH0CFSn+P/Bwc9nEi3xBlSk2Ei6QJbzCJ4eEgC/2FqbMioLin+zZcraphXa+7QyK3RBcw==
X-Received: by 2002:a50:ed86:0:b0:458:e1da:af2 with SMTP id h6-20020a50ed86000000b00458e1da0af2mr28134446edr.364.1665600856999;
        Wed, 12 Oct 2022 11:54:16 -0700 (PDT)
Received: from localhost.localdomain ([46.216.9.29])
        by smtp.googlemail.com with ESMTPSA id ay8-20020a170906d28800b00788c622fa2csm1668235ejb.135.2022.10.12.11.54.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 11:54:16 -0700 (PDT)
From:   Dzmitry Sankouski <dsankouski@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dzmitry Sankouski <dsankouski@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org (open list:ARM/QUALCOMM SUPPORT),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS)
Subject: [PATCH v3 1/2] dt-bindings: arm: add samsung,starqltechn board based on sdm845 chip
Date:   Wed, 12 Oct 2022 21:54:10 +0300
Message-Id: <20221012185411.1282838-2-dsankouski@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221012185411.1282838-1-dsankouski@gmail.com>
References: <20221012185411.1282838-1-dsankouski@gmail.com>
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

Add samsung,starqltechn board (Samsung Galaxy S9) binding.

Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
---
Changes for v2,v3: none

 Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index fb1d00bcc847..f728b527d4cf 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -661,6 +661,7 @@ properties:
               - oneplus,fajita
               - qcom,sdm845-mtp
               - shift,axolotl
+              - samsung,starqltechn
               - samsung,w737
               - sony,akari-row
               - sony,akatsuki-row
-- 
2.30.2

