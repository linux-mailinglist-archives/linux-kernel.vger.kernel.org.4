Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EEC76635C1
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 00:45:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237988AbjAIXo4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 18:44:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235432AbjAIXoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 18:44:14 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 723B33752E
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 15:44:10 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id f34so15577613lfv.10
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 15:44:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oUSIRNZZE79nkyMU9G9AqBIuhvo2pozCegvf/Srh544=;
        b=uJ5zkAXcPizQidJBAs/mQpb6fWttL+vM7ap+xLWfv4mHkzsnUY2SIk3ZL+Ks2/9mZS
         CPiNW2BlpphCd3ikKwzLVN93Tq2CQ5G3BdKWbDeerxtNAY0tJpbXdVfKhYPnl/u4kfqk
         DMhhtpZpwT7ExztXEodx/Hc/WdSZrpkqgq+qoUTsZoyzc4SJai1vZhMw7r2Vrpzm2CpL
         f6aSCnMdeQf81xHBjNUC5fMcRvJWkXTg1x10jUye/qG/z7i3iZ0HnNLQzAdft/2IV9vH
         63k12N6Q4HecofVPXg2mj8CCEIE8TyAAkTAo3JPi85MSU3EdDS/kJIbUc+Pb80YW1fpm
         u0Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oUSIRNZZE79nkyMU9G9AqBIuhvo2pozCegvf/Srh544=;
        b=0WFjYO3HhghomeOrWszIY5n3R93CI4tkOTtoLRWtgel+Kl+dfgNeK8yGwNJ9WGowMo
         mlrMjLTH8wOnvzvZ8j4L/Qn9UUEm3h69Bi2GhYaYrGM6vSUqfrpeQUIabhJP2IE2Wiz4
         Bj1ecs1kanz0+r6USFdHH/H5gdfNAboK2BRQAJpAwLUETWNEpuPl6SoKZeKbfMcV6UUQ
         VjaHOgQRBmXwAewme13Fx1G7yvrKHCaFAJ1BPzRQjh6LTxFIcuwjCT7eUaibsW/9NZwc
         TsGNg8Oiw6LP09uHX/vkNjvUP0Ozo7ww7S9XcGxAsFoAXiIYMucZRl0fQP3PMLBYimca
         41aw==
X-Gm-Message-State: AFqh2kqfTy9ArND8oFKkn9cD4tS6m4tzayY5DsofEfzFqzqsCncR1LfQ
        Hdhc2gWqALyb/C5T72rsg6CbJQ==
X-Google-Smtp-Source: AMrXdXt5Lb1JdORz9wFKniYzT1NTeV6oyiJCRsJrJzp3Srm/OE2t1T4PW6ihA06QLlT0hzAYtUMKzA==
X-Received: by 2002:a05:6512:368a:b0:4b5:b90a:829d with SMTP id d10-20020a056512368a00b004b5b90a829dmr16791324lfs.66.1673307848857;
        Mon, 09 Jan 2023 15:44:08 -0800 (PST)
Received: from eriador.lan (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id s9-20020a056512214900b004b5a4cf69dfsm1835255lfr.261.2023.01.09.15.44.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 15:44:08 -0800 (PST)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     phone-devel@vger.kernel.org, Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Vinod Koul <vkoul@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Stephen Boyd <swboyd@chromium.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Jani Nikula <jani.nikula@intel.com>,
        sunliming <sunliming@kylinos.cn>,
        Sam Ravnborg <sam@ravnborg.org>,
        Haowen Bai <baihaowen@meizu.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Vinod Polimera <quic_vpolimer@quicinc.com>,
        Douglas Anderson <dianders@chromium.org>,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/8] drm/msm: DSC Electric Boogaloo for sm8[12]50
Date:   Tue, 10 Jan 2023 01:43:53 +0200
Message-Id: <167330408773.609993.1753222329751720759.b4-ty@linaro.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221221231943.1961117-1-marijn.suijten@somainline.org>
References: <20221221231943.1961117-1-marijn.suijten@somainline.org>
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


On Thu, 22 Dec 2022 00:19:35 +0100, Marijn Suijten wrote:
> This preliminary Display Stream Compression support package for
> (initially tested on) sm8[12]50 is based on comparing DSC behaviour
> between downstream and mainline.  Some new callbacks are added (for
> binding blocks on active CTLs), logic bugs are corrected, zeroed struct
> members are now assigned proper values, and RM allocation and hw block
> retrieval now hand out (or not) DSC blocks without causing null-pointer
> dereferences.
> 
> [...]

Applied, thanks!

[1/8] drm/msm/dpu: Wire up DSC mask for active CTL configuration
      https://gitlab.freedesktop.org/lumag/msm/-/commit/c2d2c62da1fc
[2/8] drm/msm/dsi: Use DSC slice(s) packet size to compute word count
      https://gitlab.freedesktop.org/lumag/msm/-/commit/bbd1bccdcf4e
[3/8] drm/msm/dsi: Flip greater-than check for slice_count and slice_per_intf
      https://gitlab.freedesktop.org/lumag/msm/-/commit/85b5a40991dd
[5/8] drm/msm/dpu: Reject topologies for which no DSC blocks are available
      https://gitlab.freedesktop.org/lumag/msm/-/commit/f52b965c9434
[6/8] drm/msm/dpu: Remove num_enc from topology struct in favour of num_dsc
      https://gitlab.freedesktop.org/lumag/msm/-/commit/9ce765395f41
[7/8] drm/msm/dpu: Implement DSC binding to PP block for CTL V1
      https://gitlab.freedesktop.org/lumag/msm/-/commit/086116ae1410
[8/8] drm/msm/dpu: Add DSC configuration for SM8150 and SM8250
      https://gitlab.freedesktop.org/lumag/msm/-/commit/8cc4c9de15f4

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
