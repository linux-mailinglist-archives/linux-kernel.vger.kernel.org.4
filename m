Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D07A16CCD5C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 00:38:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbjC1WiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 18:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjC1WiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 18:38:10 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D92CA272A
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 15:38:04 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id h9so14191219ljq.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 15:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680043083;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g+xu6yRIN/bJys1fehbCkZUGMmMxxtuBrshP7xCnxko=;
        b=Al5TIrR6q1JFc/h2LqAur7BsT/df2/oRMpHQNhGfUfvJhr/iaz9FKUsFhPkWaT3hOt
         yVpY84Q7BPB60YlgRDkwLpmt2C3Le2UnwOYOgfVR5ssUJBz9F3bsjXsm5DgdaoBXZ+B/
         xMJgOtXE7ibCa6/xgLZBYf9AQII0Dn4ai/pYB1zcS7SyWW7yTrFw74GX0r84tHZYt4RQ
         zCFRo2RgvbiSzMPd2L3NsY+PWsBVI34IbOBv8trP1AyN+mH/GXOcX4F7Pp9ssRJPG+tj
         meIfT1pFYHHPbH24cjii+Pqkb04i5IYJwa+Aht37Nkxie43zOQdzp14VRJwJozETYAKb
         vLDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680043083;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g+xu6yRIN/bJys1fehbCkZUGMmMxxtuBrshP7xCnxko=;
        b=RUgS2ZGIcBtasfirlj0NiE0U94m/0wkr7Jjvrq30KtqXTYnMrTsqPpfEta+4uLLvpo
         eMegb1ieu9HOYRX8nzRQbNCcDe/tMQbbmcef6Fnr6C049h6MOHHAL3Pe1QwHNadpL6md
         dpdMqmEr6y19+1WHpbRBxNiSkNh8uNYyZ7+DI1xrDkdVOorbXETXf6aYZFfDU+08o5uA
         6A/CgQP2sTx2duFBS6qFSNYZuw/sjdxdG6EYgBLnfNxhzubHXduI2zo1zExC68ymVMxJ
         Y2QpM42ZEz79KiaxaMBvZYVao7TjJnsLOZ2kAELh9nRPkgf9dSaaygXOjd6uRwOhIZkY
         4kSQ==
X-Gm-Message-State: AAQBX9caI6amN8/i5QUWalmSFy5+4JRcHIQ2gh0vvacmwxpN3j/uIBcz
        XCvLhiiMEmYe0XhZtB660PokNA==
X-Google-Smtp-Source: AKy350bgyH8LOJ1ATAPftjuIwEIjk5RupKEXKKKMV/7TLrATqUiGPabaR9kv1V0d2QYXK9XVLWYPbg==
X-Received: by 2002:a05:651c:22e:b0:2a1:2cb4:5f81 with SMTP id z14-20020a05651c022e00b002a12cb45f81mr5018981ljn.36.1680043083113;
        Tue, 28 Mar 2023 15:38:03 -0700 (PDT)
Received: from eriador.lan (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id t22-20020a2e9d16000000b002934d555783sm5199522lji.6.2023.03.28.15.38.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 15:38:02 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        Colin Ian King <colin.i.king@gmail.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] drm/msm/dp: Fix spelling mistake "Capabiity" -> "Capability"
Date:   Wed, 29 Mar 2023 01:37:46 +0300
Message-Id: <168004255462.1060915.681238407755431464.b4-ty@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230314082050.26331-1-colin.i.king@gmail.com>
References: <20230314082050.26331-1-colin.i.king@gmail.com>
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


On Tue, 14 Mar 2023 08:20:50 +0000, Colin Ian King wrote:
> There is a spelling mistake in a drm_dbg_dp message. Fix it.
> 
> 

Applied, thanks!

[1/1] drm/msm/dp: Fix spelling mistake "Capabiity" -> "Capability"
      https://gitlab.freedesktop.org/lumag/msm/-/commit/6ee9666a4f4c

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
