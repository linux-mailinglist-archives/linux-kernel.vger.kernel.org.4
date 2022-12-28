Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85B246576D1
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 14:11:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232614AbiL1NLS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 08:11:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiL1NLP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 08:11:15 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 373C01180E
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 05:11:14 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id r26so17565780edc.5
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 05:11:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F6wwrS7RcdUciPublS8eDzKLlrNTuJCUJ8yWm395dEU=;
        b=HQID7UlXuGYljA8lWzj1CBVUHd9+8294st7MpCGh2yB+noGxikCM/UEtjIr+GXSLlI
         UMh4Puq91qpnhMLj9Ota6dO4XoHI0ASsotTZ2vxxSGiZ5wXZR8ruJXKeIheSjJwAWFOj
         j5MPzCX4xL6NTi/ZnZmTLOzDA4yJ9Pnw+mCF/92PFZ27HdnNmxHWWdhe3yXvIWYpZfDD
         EGnQ4Uvd8jHsLMGSR7LI1ZxSW7/eOHH3+wst5JG1N2q4p32Abi+NHg/2/v0/rg0TyyEn
         JAhYV4rSq/7p125wk5oMCOLhTZKPALdn02lg53eCe1+8vHS3APpdKDZQYAO0t4N3la1f
         F1pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F6wwrS7RcdUciPublS8eDzKLlrNTuJCUJ8yWm395dEU=;
        b=PnxeF2CTu1c67Gmv6cIsU50Tky3aPUKOy8FWoCbHWrb9Kp7QOw5jiwe/YnRVvNtdRO
         ZBJqD300YdfGvNUY+NpLzNyVJnNcwVhQQwNUvs+jpEpe3d/uH3+OC2YZ4THUuJUtt3BV
         otyM8JRdviENmwb9a+DWKdBeb9nPItGeUL4paK3KVpdrasNbx2lN0bcVaEPbIv2TJPFw
         4OVlJB/pCQzIhGlVX5Pg4i7KOq6XJgbUX2U8cs/tIdbloqZpI8AZsFLaxVFoieCn8VtC
         Xj0EdTDAuKAKjHY5pmvOAJg8zAr/UeHkyRinzs9rPL6IVJC7yurD/beIvfbEfnpUOelr
         RIbA==
X-Gm-Message-State: AFqh2kotlLegsbtKb+GRldMmnn+qrc9naM9aGAjPWNUqYpH73g0XnRAA
        ufv5RwCqEghYnD5ZbdzAVkXBAA==
X-Google-Smtp-Source: AMrXdXvCEIaQ/+rAZCjHFzbt62dc75UuPXrtdkwyrRSmtxO55O1twdfpHfhj6AE0hBMtXuZXr06Y7g==
X-Received: by 2002:a05:6402:528e:b0:481:420e:206d with SMTP id en14-20020a056402528e00b00481420e206dmr15879206edb.42.1672233072828;
        Wed, 28 Dec 2022 05:11:12 -0800 (PST)
Received: from planet9.chello.ie (2001-1c06-2302-5600-85f6-04b5-1651-3b6c.cable.dynamic.v6.ziggo.nl. [2001:1c06:2302:5600:85f6:4b5:1651:3b6c])
        by smtp.gmail.com with ESMTPSA id g11-20020a056402180b00b0046bb7503d9asm7099545edy.24.2022.12.28.05.11.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Dec 2022 05:11:12 -0800 (PST)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     robdclark@gmail.com, quic_abhinavk@quicinc.com,
        dmitry.baryshkov@linaro.org, sean@poorly.run, airlied@gmail.com,
        daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     quic_mkrishn@quicinc.com, andersson@kernel.org,
        swboyd@chromium.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bryan.odonoghue@linaro.org
Subject: [PATCH v2 0/1] Fixup documentation for dsi-phy-28nm
Date:   Wed, 28 Dec 2022 13:11:09 +0000
Message-Id: <20221228131110.213116-1-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the one remaining patch I had from a previous series for
mdss-dsi-ctrl and the dsi-phy. The mdss-dsi-ctrl set became a bigger so I
split out the 28nm phy fixes.

I'm resubmitting with Dmitry's RB as a standalone.

Old: https://lore.kernel.org/all/20220630120845.3356144-1-bryan.odonoghue@linaro.org/

Bryan O'Donoghue (1):
  dt-bindings: msm: dsi-phy-28nm: Add missing
    qcom,dsi-phy-regulator-ldo-mode

 .../devicetree/bindings/display/msm/dsi-phy-28nm.yaml         | 4 ++++
 1 file changed, 4 insertions(+)

-- 
2.34.1

