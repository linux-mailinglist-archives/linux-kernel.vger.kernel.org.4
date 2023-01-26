Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 035AD67D4FA
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 20:01:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232410AbjAZTB4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 14:01:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232375AbjAZTBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 14:01:47 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1080F6A711
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 11:01:34 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id b7so2778966wrt.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 11:01:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8vGWHx37zinCDKu9NC9wgR73rrVcUbMz6uogy6JTfQQ=;
        b=g3cA3KzWngJBTIKkh8Tchnm74ND1daBcbl93/SnsDa4+ZO9RBTjUIL8auE/xvQhSfV
         1ZtGisCGGvsWchTLKEc5QWYq7a4ge3bWvhoP89nqSiYuXh8saouCG5hZXMyMfJ5QGzvA
         0sArQcwKMzUefdCFBqnxv4xUXB/hcD75TQsPkm3r+TnGzbDQFAsRF+BZzUtKKZZsRTKN
         q7lDMoEDBLyB3q5U9X+cIarzHE2iJ1YiWi/4mgY3Ubc0hLe0AYbXYacMZ027VBi9aKV3
         iRxstRlH/2Hw06DrFGax8WD6GOieakSAk+yzHlzq14FxuoP34bxBskU+MenAh/6ZvEjk
         GREA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8vGWHx37zinCDKu9NC9wgR73rrVcUbMz6uogy6JTfQQ=;
        b=tFkybulLwJoInuXDBo5FXJ0duae54dy467F+KHjjn8Pyql+STKkcWnLqA4vX1ysDef
         cdwrFACCBe1dMSdRctChgrNbR167px6Q+A63CUcLIrVLvRvH63NAo7ND6e3Y5yR+U5i1
         pzKt6Fd7QzjWxEqpS4InQix09Hh52fokvgqUrGNmdcVX5xxdCcs4y9ufoSnVJC7hBuKk
         W7Q+ks/BG3p5SHJvgCGWjEmsi5QAwd7dbJZ2gWCG+qKxqQyTo59/t4IWjT5VUyN8mwEn
         AxQ4iousdoivRvMe/9WwUaRLGQ+h6UmAoMrU3b8NYk05pZJZXwxlq7qUKLCpD5BEKhQS
         6Eaw==
X-Gm-Message-State: AO0yUKUSYHEMkQrXecoZA2X/weRE5mqh2frubsCbZkwPBqE2sFa4/fjU
        3JAzoTbK3Sltc0RUwurFuwcv1/MM104cLn/N
X-Google-Smtp-Source: AMrXdXsub2bhIciA9sIaWr1SDq7Xp+VsKNNpw01yUOHvFW+tAfdJi89lnPxipV/wux8vqehGY34kjw==
X-Received: by 2002:a17:907:6e2a:b0:871:e9a0:eba7 with SMTP id sd42-20020a1709076e2a00b00871e9a0eba7mr114189013ejc.57.1674759683172;
        Thu, 26 Jan 2023 11:01:23 -0800 (PST)
Received: from eriador.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id o25-20020a1709061b1900b0084d4e9a13cbsm974982ejg.221.2023.01.26.11.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 11:01:22 -0800 (PST)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     phone-devel@vger.kernel.org,
        Marijn Suijten <marijn.suijten@somainline.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Stephen Boyd <swboyd@chromium.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Vinod Polimera <quic_vpolimer@quicinc.com>,
        Liu Shixin <liushixin2@huawei.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm/msm/dpu: Add DSC hardware blocks to register snapshot
Date:   Thu, 26 Jan 2023 21:01:05 +0200
Message-Id: <167475959089.3954305.3603655147941540549.b4-ty@linaro.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230125101412.216924-1-marijn.suijten@somainline.org>
References: <20230125101412.216924-1-marijn.suijten@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 25 Jan 2023 11:14:11 +0100, Marijn Suijten wrote:
> Add missing DSC hardware block register ranges to the snapshot utility
> to include them in dmesg (on MSM_DISP_SNAPSHOT_DUMP_IN_CONSOLE) and the
> kms debugfs file.
> 
> 

Applied, thanks!

[1/1] drm/msm/dpu: Add DSC hardware blocks to register snapshot
      https://gitlab.freedesktop.org/lumag/msm/-/commit/a7efe60e36b9

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
