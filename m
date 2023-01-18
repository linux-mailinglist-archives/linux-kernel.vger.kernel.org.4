Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D43446710C9
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 03:07:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbjARCHE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 21:07:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbjARCGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 21:06:42 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F24193F288
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 18:06:40 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id vm8so79803662ejc.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 18:06:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9IfmhJrvRWfUC5D3CUUdjzAYNIM2kHYmHQdiJOf/ROU=;
        b=w+hu4Qm0z16ldHxczDe00Y41K5vtZ5PXlGgBghOUz39DYC3gQXuhYTQMJtrhxq4Ymh
         v5Iu6CtQOcG3rwF+TgXUS0WlRQYlVUIt74WRrxFJa9823+suIoEXfCtsRAfW2+SMYQuu
         9FX+G5SdU+w/i2o9m64FKiirxOs1wH+bBRrp1JBsGaez3cfNdcLDB3pWIm+EKpFKUpBa
         4vV7ODiSSU/nl1AykN8/j9cSHczY25RjC5WOlnqjJ879l9vn94uWxpnjOVLdjiTft2Op
         iw3j+L9MLlVpGfRUHUPEdtkwk6wY5ho84aAK2smpCp5psKsftaESNXY8DBeooNovG96t
         Kx0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9IfmhJrvRWfUC5D3CUUdjzAYNIM2kHYmHQdiJOf/ROU=;
        b=dOmPqhzzlcdSgeg4xFNLXLBbGH57c4x9WT1kmQ8D15bz6KTEV9IctYY37oPNXMPp+o
         yewNOpxkn2SOLSRbRwCmA4x9d3xHvwD3exFL9nr0W2wVLR3viSDW7vajtnnWtPQyQ0XK
         Hg/XbMEDfVqurgVgq9Kor4XIvIkJh9A0HGUri+HkOh1BHp0XQk7VfeBKc5aZ5k5Hl0Gh
         9a8hGcUhMlsGTTSGEUl4zHewDZQWHKS21l4cXD4tDK+yghNTw8VeM1JCEPdEjywzDa82
         WLuR+DV4msHm+/oL+FZu/uoWF6PHpvnfFXbdWpq4QnRPYTajDluXezcFDdV3UKiQzRtG
         oRnA==
X-Gm-Message-State: AFqh2krDyGidqFbfaaBuds13QpFAgbqjsWok5Skgnu5UMRVG+T1BQ/Rh
        778W5NechKkIb13kbn/xc4p5dQ==
X-Google-Smtp-Source: AMrXdXt2C1AYGJI145oWUugmSjbdf9sJ5mLy1O8PkJlJX/SIy9mMUJKSJDO7UiobV+oiMqKQ2wLIcA==
X-Received: by 2002:a17:906:eb0e:b0:871:be7:c984 with SMTP id mb14-20020a170906eb0e00b008710be7c984mr5085808ejb.34.1674007599352;
        Tue, 17 Jan 2023 18:06:39 -0800 (PST)
Received: from eriador.lan (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id kx1-20020a170907774100b0084d368b1628sm12702694ejc.40.2023.01.17.18.06.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 18:06:38 -0800 (PST)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     phone-devel@vger.kernel.org,
        Marijn Suijten <marijn.suijten@somainline.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Stephen Boyd <swboyd@chromium.org>,
        Vinod Koul <vkoul@kernel.org>,
        Drew Davenport <ddavenport@chromium.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] drm/msm/dpu: Disallow unallocated resources to be returned
Date:   Wed, 18 Jan 2023 04:06:19 +0200
Message-Id: <167400670542.1683873.15043456378376951686.b4-ty@linaro.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230109231556.344977-1-marijn.suijten@somainline.org>
References: <20230109231556.344977-1-marijn.suijten@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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


On Tue, 10 Jan 2023 00:15:55 +0100, Marijn Suijten wrote:
> In the event that the topology requests resources that have not been
> created by the system (because they are typically not represented in
> dpu_mdss_cfg ^1), the resource(s) in global_state (in this case DSC
> blocks, until their allocation/assignment is being sanity-checked in
> "drm/msm/dpu: Reject topologies for which no DSC blocks are available")
> remain NULL but will still be returned out of
> dpu_rm_get_assigned_resources, where the caller expects to get an array
> containing num_blks valid pointers (but instead gets these NULLs).
> 
> [...]

Applied, thanks!

[1/1] drm/msm/dpu: Disallow unallocated resources to be returned
      https://gitlab.freedesktop.org/lumag/msm/-/commit/abc40122d9a6

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
