Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF33F66350C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 00:17:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237932AbjAIXQx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 18:16:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237772AbjAIXQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 18:16:19 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5EA62DFE;
        Mon,  9 Jan 2023 15:16:18 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id bq39so15580164lfb.0;
        Mon, 09 Jan 2023 15:16:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P2ILC0s/EAU+DV83P6Wz26LirhdaLi4CEI3lPCyUm7s=;
        b=R5hdRClHSsFgrLu08jbXwr8RDUQz8uRVSgPGqGd/Q0bf3I7UMc/Bpq8489et9duwNv
         fvhSTkvbyLzrCFCNmecmO3KYjH9BVN1mhlyGsfzZG5LxAvxkg/5OmW/uTwaGltlQxG79
         XMQmP4QwHF+1dJbVzz+b/wvhWyA70LkTnjhdEB8Yi0Unxm74OtIXM8pkk62IxTQ2UGWF
         CC9C8djPLnL5uBe2OXkqiBtYtW2qg5vsMwJu0u8GgqQsKHHeJFm4ebhcLL5GYtAfPghq
         outVRhhrISh85kgdJ50lxP3uze/PJnhbmCTuNILAODeel+M5f2UkZIGkjl59Idxwqkg5
         IUTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P2ILC0s/EAU+DV83P6Wz26LirhdaLi4CEI3lPCyUm7s=;
        b=Dt/OCL1YRVzzCXLMVdFAtl8//nsWUtTdjZOqELYdqs2F0wc+7cqDXJ+jzttaSZWdJG
         E8rHdRyCqWlfuFJYyH9j82xbZkco/GRL2/cxbMDdYlwoDp9LVq7qDKQw2up0k3TYw5tB
         OVEWfjqUDemGT/fmARkaS+qxhVgpY0wqbrOn4BLPwaBDGk5AzsxFGOaefWp5ytaapVrL
         lEcl68205ONFniVmWjuFWQ8os7DMYUtVCQnCkByWrel9V2E750r7ABNIGhbDaJSSD+Gx
         LOwsuWacQ4SBgQKMisYcLEGGycaz6BD++nB8OwNyd/KaW9p+zWm/00e63FK+Drw6nkzI
         1e+Q==
X-Gm-Message-State: AFqh2kp3j8QyTBZx34W7+LbUsvqfmExmfc3WHD/uIP2Qc/X4+vu2aJGT
        Ox2f21NGjJh82S+gFLDYi0Igm+ceO6SA7w==
X-Google-Smtp-Source: AMrXdXt+4HvEAapKTb53PbhYPGBm9J7HGYKBL4awae8GqqtQDzoGqThLIPrGSJ+EzVWhuzLjCrkZHA==
X-Received: by 2002:a05:6512:2a8e:b0:4b6:e4b3:d82d with SMTP id dt14-20020a0565122a8e00b004b6e4b3d82dmr17401516lfb.7.1673306176410;
        Mon, 09 Jan 2023 15:16:16 -0800 (PST)
Received: from localhost (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id t18-20020a192d52000000b004cc66d4419asm1846562lft.39.2023.01.09.15.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 15:16:15 -0800 (PST)
From:   Dmitry Baryshkov <dbaryshkov@gmail.com>
X-Google-Original-From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     marijn.suijten@somainline.org, Rob Herring <robh@kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20221229100511.979972-1-konrad.dybcio@linaro.org>
References: <20221229100511.979972-1-konrad.dybcio@linaro.org>
Subject: Re: [PATCH v2 1/3] dt-bindings: display/msm: Add SM8150 MDSS & DPU
Message-Id: <167330408777.609993.10625838053126899594.b4-ty@linaro.org>
Date:   Tue, 10 Jan 2023 00:41:27 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 29 Dec 2022 11:05:08 +0100, Konrad Dybcio wrote:
> Add bindings for the display hardware on SM8150.
> 
> 

Applied, thanks!

[1/3] dt-bindings: display/msm: Add SM8150 MDSS & DPU
      https://gitlab.freedesktop.org/lumag/msm/-/commit/9ffbefc1553c

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
