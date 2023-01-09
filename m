Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D98DA6635B1
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 00:44:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238025AbjAIXoe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 18:44:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237952AbjAIXoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 18:44:13 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ABEE3FC8E
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 15:44:07 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id bq39so15663864lfb.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 15:44:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CRAyi2n2FSarDTatQAHom6gbymd5CATd4MjDLdYU+WQ=;
        b=MQzN3h12iMrKRadC8OJ8xKFWWFDqhZ/VJPnhx0N+qFKFMuJTFkY+2buIGksW5nhlVc
         BaLPtbSVm5vjNuvnq9VSum+ZU1LmJqsgdRfXyACEsmc+qpCSq0x6DJh6NeA40u4oiasn
         K+oFiSO2TjyRJ5pv1ulJeT12NBUAFu+0fUF6XQ3hHZrFXRT6T9/BLS11UxJVy77Xwc33
         euIymblv8olgl74LAY/zxpyQag3XrkJ4jNkh/1u17PIhraMzvImFGsTMMyODenYyn8NY
         0DLe99eSp9PSGya/qKknZoVRIhT1gOd2s7IwxWjwrPfUJId7k2aO6nMRr3OaDqCfuFnC
         1NZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CRAyi2n2FSarDTatQAHom6gbymd5CATd4MjDLdYU+WQ=;
        b=dRkhNGhwdjA7+wo6HJ0XCn4L8VqRFFNY/LDWln0FS70SK5iDd7NhVdcOLJCZJ1C7cs
         29OesoZV/D0rT97/EI+j+J5WKeTVA0XE5PvoTLctrmH/yVEVwbidXc4F66m2wTcMLadk
         wS+XLT4/DTs8Pdh+Tz5UwlezsKu2CfGuK2PAETnkvK/P+Ao3V72A+yXVFWmY5YzjKTsJ
         SVTqFsk34NPrNj2qpIY1mW1kEY+NC5x8l0j84CwNQpuqvbN2gIBJaD8qGbHCq5jdYMIw
         yy8ou/Ihp1WVHTbp+gKDyEYWYnQ27e63j5BIPWSFYl/hIujbs+uCagGxZugARFNb9K5m
         tUWw==
X-Gm-Message-State: AFqh2krZANpQUTEJbhykWEEE/dqYmzhuatjVve9wYCSp6dPFyPhzf1et
        YhCWEezXsxnMy+zItp2L3KF8oA==
X-Google-Smtp-Source: AMrXdXsoKpIWafS1JOF+h5zLFP43e0o0/Y8wmmadCp+bqzM9xbLffF2r6pd2BmKCKjH/6gjBJd2Zag==
X-Received: by 2002:a05:6512:3a91:b0:4b5:799b:6c8b with SMTP id q17-20020a0565123a9100b004b5799b6c8bmr19998411lfu.56.1673307845475;
        Mon, 09 Jan 2023 15:44:05 -0800 (PST)
Received: from eriador.lan (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id s9-20020a056512214900b004b5a4cf69dfsm1835255lfr.261.2023.01.09.15.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 15:44:04 -0800 (PST)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     patches@linaro.org, Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Kalyan Thota <quic_kalyant@quicinc.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/msm/dpu1: Remove INTF4 IRQ from SDM845 IRQ mask
Date:   Tue, 10 Jan 2023 01:43:49 +0200
Message-Id: <167330408784.609993.15717302243167908042.b4-ty@linaro.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221107103739.8993-1-konrad.dybcio@linaro.org>
References: <20221107103739.8993-1-konrad.dybcio@linaro.org>
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


On Mon, 07 Nov 2022 11:37:36 +0100, Konrad Dybcio wrote:
> SDM845 only has INTF0-3 and has no business caring about the INTF4 irq.
> 
> 

Applied, thanks!

[1/1] drm/msm/dpu1: Remove INTF4 IRQ from SDM845 IRQ mask
      https://gitlab.freedesktop.org/lumag/msm/-/commit/a685d27f2201

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
