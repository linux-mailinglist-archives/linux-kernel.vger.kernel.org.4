Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 779D066351A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 00:18:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237907AbjAIXRa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 18:17:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237841AbjAIXQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 18:16:33 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEE2F1DDD0;
        Mon,  9 Jan 2023 15:16:31 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id bt23so15494875lfb.5;
        Mon, 09 Jan 2023 15:16:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fcv1oFN64qJbUFhacrhJqgn8l/kgjLzAdWsUtFoBwMI=;
        b=nBdqaJGPr/nRqiCZKqfaB1HQdy85AAh1ZQqHWisT9yDwtkhoPZXkKF7qRcING1Gzup
         Uwwla3Pj8/L696BkpNLVsLz7x6fei2MZy2fzk1P0wvqBSVqvT5sYt4feMLxjjjmLVEpJ
         e13sfdL4Yg7pkuIDOQsGNRn4d0RLWivD8Y2vHOSAb02bJyq12Naag37tHw56u7SlphtW
         vG8BhN0CmrFdC7wiB6Jijei+yfRFNGaMVHH/Hy5Bso8hQjsoT1Ezxgc4VA1wJh/avvIO
         R8Qp6sw54FQBsCc9HJmLB8BNumhP/pcVSKefZUQ+AEWAMFhwKcGIV2kUxyNZ6WyT5k/r
         1eug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fcv1oFN64qJbUFhacrhJqgn8l/kgjLzAdWsUtFoBwMI=;
        b=jTUmwdwJPRv8WFkqr0/umi+t/rn2ODlfOmDphKB9dvCkudOC1rWInZNd6l3svlDG3R
         LKty6nBWQ1rqZX9g5w/AyhA04+9KSv8ErzfwFc1J+8O1RATtPesec4HHtHWi83O9ZKd/
         6JMbyeptG2ApQwY5XQ22+CCD2Z+NRE1svno2Mah4wAtVgeWoJixplr5a/eDtZWIrhPeN
         ZSJtuOS3bStQXpvVI4cxK2KpbEHJIX6Nkuo9p3N6vSPwdgfoLxi5CjT2jhKDRJw311+i
         Sb6FAgopWwI9r4WETo9aGazltxRnxecYzRSvePTKef9rov/okWHhIxMExJwRRILQyNcZ
         i4Fw==
X-Gm-Message-State: AFqh2kqsWwGI0AxpVtuhFgVdE28cWbql75WqB3MUI1nce2bHJma8++bc
        ojHbHrWUT+RN8E8jVh9LPkU=
X-Google-Smtp-Source: AMrXdXtXMWbO88qPnq745Od9/2z5JfHQSbibEexSfpksdpgkjdwJBwliMQal1f7GVguXLEPln76qHQ==
X-Received: by 2002:ac2:52ba:0:b0:4cb:445c:dc7d with SMTP id r26-20020ac252ba000000b004cb445cdc7dmr5998193lfm.26.1673306191279;
        Mon, 09 Jan 2023 15:16:31 -0800 (PST)
Received: from localhost (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id br11-20020a056512400b00b0048a934168c0sm1831364lfb.35.2023.01.09.15.16.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 15:16:30 -0800 (PST)
From:   Dmitry Baryshkov <dbaryshkov@gmail.com>
X-Google-Original-From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     robdclark@gmail.com, quic_abhinavk@quicinc.com, sean@poorly.run,
        airlied@gmail.com, daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@somainline.org,
        quic_jesszhan@quicinc.com,
        angelogioacchino.delregno@somainline.org, loic.poulain@linaro.org,
        vkoul@kernel.org, a39.skl@gmail.com, quic_khsieh@quicinc.com,
        quic_vpolimer@quicinc.com, swboyd@chromium.org,
        dianders@chromium.org, liushixin2@huawei.com,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jonathan Marek <jonathan@marek.ca>,
        vinod.koul@linaro.org, Robert Foss <robert.foss@linaro.org>
In-Reply-To: <20221230153554.105856-1-robert.foss@linaro.org>
References: <20221230153554.105856-1-robert.foss@linaro.org>
Subject: Re: [PATCH v4 00/11] Enable Display for SM8350
Message-Id: <167330408775.609993.7646803775858639381.b4-ty@linaro.org>
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


On Fri, 30 Dec 2022 16:35:43 +0100, Robert Foss wrote:
> Dependencies:
> https://lore.kernel.org/all/20221102231309.583587-1-dmitry.baryshkov@linaro.org/
> https://lore.kernel.org/all/20221024164225.3236654-1-dmitry.baryshkov@linaro.org/
> https://lore.kernel.org/all/20221104130324.1024242-5-dmitry.baryshkov@linaro.org/
> 
> Branch:
> https://git.linaro.org/people/robert.foss/linux.git/log/?h=sm8350_dsi_v4
> 
> [...]

Applied, thanks!

[01/11] dt-bindings: display: msm: Add qcom,sm8350-dpu binding
        https://gitlab.freedesktop.org/lumag/msm/-/commit/7a0c3d0025de
[02/11] dt-bindings: display: msm: Add qcom,sm8350-mdss binding
        https://gitlab.freedesktop.org/lumag/msm/-/commit/ddcf30003b92
[03/11] drm/msm/dpu: Add SM8350 to hw catalog
        https://gitlab.freedesktop.org/lumag/msm/-/commit/0a72f23f6ef8
[04/11] drm/msm/dpu: Add support for SM8350
        https://gitlab.freedesktop.org/lumag/msm/-/commit/a596a6078586
[05/11] drm/msm: Add support for SM8350
        https://gitlab.freedesktop.org/lumag/msm/-/commit/3d6287e64cbd

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
