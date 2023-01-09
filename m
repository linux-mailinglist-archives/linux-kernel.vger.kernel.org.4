Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEE826635C0
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 00:45:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238021AbjAIXpG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 18:45:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237985AbjAIXoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 18:44:15 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F4393FCAE
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 15:44:11 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id bq39so15664151lfb.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 15:44:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t/mDgzPnUXxALwSc77P9Iyw1b4SZpp1LqX9N2wGlWLw=;
        b=CYaufEjN+FQO8Ij0Vpc2EDA67qNJ5J4okXNCkY+RWe41dxiaS7/Vs7dZurAKEbLHPH
         jiy5IQqVZ6nENLhobd8CsNo+CJQ76i4qyoOGGrTW3ExgwvCFE7/kbnILtY1zWQUteCy9
         ma+m5CTTawzykxmuDbDIGlpyBBh8YJFwQEFJmNfaz80iGxh48ApazuVni6MzYh+v8ohu
         vw57vgPKJCTClhjDMfne707H9OB4iQy9vcIV8EZ1e1bQngDw+5hkGoXBxhogpz2o6sOT
         ICC62oQvWFEJzpXcrNFQRtB4yLV5rR+bspK6zHPw1ST72Bj8Qv99Z0pUiSpv3v+Ml3Dj
         eJxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t/mDgzPnUXxALwSc77P9Iyw1b4SZpp1LqX9N2wGlWLw=;
        b=FBrcQuSSgy4CfP2H6RvQKKlj3DUQuPtlklG03/nL7Kdc2q1V2jwyVLLV1R+0vdrpdi
         fx1lL4w7h9yNy2EyWF0I0J8LfxFvKCYHkvtRlaTnl6rseCbmCyzM884bW+kdi9hcoR9n
         SzvyxqFKE3Uf071LhtpdK9FfjLI3WHCE83vGeczaJO0cn15eoXShL/Q2yxKvQkeOZ5rh
         HQD3fJGoXwUbr/2EAmC/whMLktzIi49GxbmGu5LowcJ0CV1JaCMSBXyFgUE5VS7q4LF1
         k/zNPaX+vPCXusQ+Ze3tLaHAVVI65VhFuZ8B3UxFE4jFnAGCRfXtTuc5JMPhjuU5ZG7V
         FEMw==
X-Gm-Message-State: AFqh2krfCCM4bsL7Uox6zTugzCqaw9Jd5fmhKl8sqy17n2eapmCBQe9l
        8hzsEb8WktNgLS88PySmblA3VA==
X-Google-Smtp-Source: AMrXdXuFEjJWeYruo91f+vSduDBZf3rVjH8VWxe3VFEYuc3GkvajLlaBvU0owcPnRbMCo6wP6qXaVQ==
X-Received: by 2002:a05:6512:2591:b0:4b5:5bc1:678c with SMTP id bf17-20020a056512259100b004b55bc1678cmr18912454lfb.21.1673307851241;
        Mon, 09 Jan 2023 15:44:11 -0800 (PST)
Received: from eriador.lan (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id s9-20020a056512214900b004b5a4cf69dfsm1835255lfr.261.2023.01.09.15.44.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 15:44:10 -0800 (PST)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        Kalyan Thota <quic_kalyant@quicinc.com>
Cc:     linux-kernel@vger.kernel.org, robdclark@chromium.org,
        dianders@chromium.org, swboyd@chromium.org,
        quic_vpolimer@quicinc.com, quic_abhinavk@quicinc.com
Subject: Re: [PATCH v4 0/3] add color management support for the crtc
Date:   Tue, 10 Jan 2023 01:43:56 +0200
Message-Id: <167330408778.609993.9217470869804308069.b4-ty@linaro.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <1669021695-4397-1-git-send-email-quic_kalyant@quicinc.com>
References: <1669021695-4397-1-git-send-email-quic_kalyant@quicinc.com>
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


On Mon, 21 Nov 2022 01:08:12 -0800, Kalyan Thota wrote:
> Add color management support for the crtc provided there are
> enough dspps that can be allocated from the catalog
> 
> Kalyan Thota (3):
>   drm/msm/disp/dpu1: pin 1 crtc to 1 encoder
>   drm/msm/disp/dpu1: add helper to know if display is builtin
>   drm/msm/disp/dpu1: add color management support for the crtc
> 
> [...]

Applied, thanks!

[1/3] drm/msm/disp/dpu1: pin 1 crtc to 1 encoder
      https://gitlab.freedesktop.org/lumag/msm/-/commit/a4d6f8253645
[2/3] drm/msm/disp/dpu1: add helper to know if display is builtin
      https://gitlab.freedesktop.org/lumag/msm/-/commit/4cb6b1eebb92
[3/3] drm/msm/disp/dpu1: add color management support for the crtc
      https://gitlab.freedesktop.org/lumag/msm/-/commit/c48c475bd75a

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
