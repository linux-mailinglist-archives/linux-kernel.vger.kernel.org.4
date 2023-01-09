Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76C6B663511
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 00:17:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238046AbjAIXRG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 18:17:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237792AbjAIXQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 18:16:23 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AC21BC84;
        Mon,  9 Jan 2023 15:16:20 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id bq39so15580310lfb.0;
        Mon, 09 Jan 2023 15:16:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kpASIlrn94h2kw47h1c03X9cqh5FWCX9FeHma7sBwdI=;
        b=OddwY0fZ5A3JB6m4rY6uFid0LFESPpUOayVuoldTW73tVR7xTvqwzsKsMlBAhppa2K
         3JIAQSrlK7QcSTSSpLzEXa6XGmlpAE0sbMKqsRkEnEmQpZv4NYNdrq97WlLhg1zYr0KC
         nXQkvyhSFtFD+HabUcSL3soa36aQ32GdOgAwZtFn/ZxQR4TOdvdSxTGGIyBXYWXQbYO2
         vOAKxQmlxVRjoWwbBMnGfTQhS1rkdWoZDGYAo6uclgM+IoSSQZlw4m0HPXciDTgtsh/X
         hDJhhe5MLSujIH3UFLGqmd3JrPU0F9cAqDCZd/ojQPnn4rEu4eWr9DFv900duiOUwfnx
         oWqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kpASIlrn94h2kw47h1c03X9cqh5FWCX9FeHma7sBwdI=;
        b=Ok/K2di+9xjRcoJhIC2myiVenHOZ6J7Lk6fBiyzpE+qTLQSUWEMB//NMl062MS2FV8
         4L3Wwf3GDdYAfyhSMDlMHXFZuEwrevE4bTkGCHC63oitTfbwe2qjJ1fFkpVpvLB/MHVh
         YavVmXncS/R2yZN6XT4SFsHH9MxOGAT8lR7aIEoWNykqUhTn9Hc9LYyQskWnH2cr1/Sm
         KCisMTLO/O/f7NcXFl4QuERITSk+UJMSTuehImuXvh3zv6dix7IbLJi0LcUTLMT/b9Ki
         Ypqxqkh9xmcCF/XuOdSDMniO66s/oWlFq46k4wDGTmo3VnHfSnZztITe9/l4kek2SYHK
         3Grw==
X-Gm-Message-State: AFqh2kr4Ucehlb1G78l/y8DG28mmOi+4SVszfbfULtC1zvWvWnIlNSg/
        R2ReRxayYyMoRpG2Wv35zTVEfGuShYCj8w==
X-Google-Smtp-Source: AMrXdXu5ikj2pAGUB/brE8c1ApXc5qFSMTIK3z7H9KCdu4bmAuUGQkMHt4a6xrXKgb5sLMG4R/alPA==
X-Received: by 2002:a05:6512:e82:b0:4be:a3c8:dc5 with SMTP id bi2-20020a0565120e8200b004bea3c80dc5mr18607851lfb.22.1673306179533;
        Mon, 09 Jan 2023 15:16:19 -0800 (PST)
Received: from localhost (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id s6-20020a056512214600b004aa255e2e66sm1823097lfr.241.2023.01.09.15.16.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 15:16:18 -0800 (PST)
From:   Dmitry Baryshkov <dbaryshkov@gmail.com>
X-Google-Original-From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     phone-devel@vger.kernel.org,
        Marijn Suijten <marijn.suijten@somainline.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Stephen Boyd <swboyd@chromium.org>,
        Vinod Koul <vkoul@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Vinod Polimera <quic_vpolimer@quicinc.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
In-Reply-To: <20221121222456.437815-1-marijn.suijten@somainline.org>
References: <20221121222456.437815-1-marijn.suijten@somainline.org>
Subject: Re: [PATCH] drm/msm/dpu: Print interrupt index in addition to the mask
Message-Id: <167330408782.609993.3753799611578677856.b4-ty@linaro.org>
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


On Mon, 21 Nov 2022 23:24:55 +0100, Marijn Suijten wrote:
> The mask only describes the `irq_idx % 32` part, making it generally
> impossible to deduce what interrupt is being enabled/disabled.  Since
> `debug/core_irq` in debugfs (and other prints) also include the full
> `DPU_IRQ_IDX()` value, print the same full value here for easier
> correlation instead of only adding the `irq_idx / 32` part.
> 
> Furthermore, make the dbgstr messages more consistent.
> 
> [...]

Applied, thanks!

[1/1] drm/msm/dpu: Print interrupt index in addition to the mask
      https://gitlab.freedesktop.org/lumag/msm/-/commit/d45e5744ab39

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
