Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0D566D7214
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 03:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235302AbjDEBgA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 21:36:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236449AbjDEBf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 21:35:56 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2DAC19A6
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 18:35:54 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id h11so37703021lfu.8
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 18:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680658553;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tulV5ogKne61CvTx3N1p8N7DixxtemOMi19lt5kisEM=;
        b=oBWXa8quJmIhbfFcgTMTnWLgS3FQpza4p/q/HkajSsbK7khXQJTGyyMK2xKzZVlZ2h
         jbGnMmEuyLGY30SLn4T9dXyGQPiwKbFp6O6vDO3FmGKOqznCbZndNWDVtdmDbI9DwU22
         FhtTCl0ESlvLOjc+nEnNFe4VwKt1ohLDxvrCzQsNUZaNxghNkflAQEuToZn6vCTOH7eJ
         giL5JhsJi33xTKsAjkqzB9DspIfFGRrs5A0POHilsD1VfXdKJJtLRRg4+kvv0wQKgCAT
         +h4weL2I8PN7ieo7z66Rd7cL04IVD54haZZA4AmHrVEvDdsEakL461bkC02cu7rB2oXj
         WAHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680658553;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tulV5ogKne61CvTx3N1p8N7DixxtemOMi19lt5kisEM=;
        b=3t0Ytgt9qPA5jzD9AyaTHPYoh9pKo1Bv7nURO6L12kQ+UFXVGIayYSBpD7+TnRHxXI
         O3J9LyB+Fus3IvCsZPekBySzg35x2lmAkAyHlchtDIyTOHBR5C1xGnOQsQOAsG8c7/dk
         PPT4KtMKo61j6U902h6PDKGGrlxO0aggjW7L8TljziZDdHqHDhCmVf1PSsjoBehI8iTz
         3xZ9+5s6Z2mbX0LUO13alFU9eRX8dzrUJulpsylCXrh9MInOb8u7OIMcd/QnN53eOO2v
         JbRJ8rJ5E4R+LyPmEkHkoFOCesMJ3mesdID0tX//UQgLut4O6JX0CCoNLiPEdVKChJIh
         DNUQ==
X-Gm-Message-State: AAQBX9dVKqnvnRL1AgLOtvnJ3+01xCHZmtkHlR2fmvzOJ0DS2ebkRWWP
        p3TXrGVK4Yc3aInsH67sDAPryg==
X-Google-Smtp-Source: AKy350YXg+Yy8O1YhBnYb7hKyKfe7DS5UdKpd65XaMLUwi+nGhiD9izKwxXwL3jLlSo5OQdV8gn3xg==
X-Received: by 2002:a19:7603:0:b0:4dd:9da1:aa82 with SMTP id c3-20020a197603000000b004dd9da1aa82mr1022262lff.29.1680658553130;
        Tue, 04 Apr 2023 18:35:53 -0700 (PDT)
Received: from eriador.lan (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id v26-20020ac2561a000000b004cb8de497ffsm2572326lfd.154.2023.04.04.18.35.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 18:35:52 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        Kalyan Thota <quic_kalyant@quicinc.com>
Cc:     linux-kernel@vger.kernel.org, robdclark@chromium.org,
        dianders@chromium.org, swboyd@chromium.org,
        quic_vpolimer@quicinc.com, quic_abhinavk@quicinc.com,
        marijn.suijten@somainline.org
Subject: Re: [PATCH v4 0/4] Reserve DSPPs based on user request
Date:   Wed,  5 Apr 2023 04:35:49 +0300
Message-Id: <168065850334.1260361.1390147834885277965.b4-ty@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <1676286704-818-1-git-send-email-quic_kalyant@quicinc.com>
References: <1676286704-818-1-git-send-email-quic_kalyant@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 13 Feb 2023 03:11:40 -0800, Kalyan Thota wrote:
> This series will enable color features on sc7280 target which has
> primary panel as eDP
> 
> The series removes DSPP allocation based on encoder type and allows
> the DSPP reservation based on user request via CTM.
> 
> The series will release/reserve the dpu resources whenever there is
> a CTM enable/disable change so that DSPPs are allocated appropriately.
> 
> [...]

Applied, thanks!

[2/4] drm/msm/dpu: add DSPPs into reservation upon a CTM request
      https://gitlab.freedesktop.org/lumag/msm/-/commit/1a9c3512fbd4
[3/4] drm/msm/dpu: avoid unnecessary check in DPU reservations
      https://gitlab.freedesktop.org/lumag/msm/-/commit/8b1ed0088e21
[4/4] drm/msm/dpu: manage DPU resources if CTM is requested
      https://gitlab.freedesktop.org/lumag/msm/-/commit/34c74e76a6a5

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
