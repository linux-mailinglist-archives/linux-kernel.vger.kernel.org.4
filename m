Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26CD06765A3
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 11:18:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbjAUKSo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 05:18:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjAUKSi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 05:18:38 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBD4CC142
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jan 2023 02:18:32 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id cf42so11465284lfb.1
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jan 2023 02:18:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IhxX7/UwQW8UUFDvL4khisA5BoVLy2kIVZOLa5OOWmE=;
        b=HK9CZn8vUaj7wtN5p9d9u0jinRiwaXYcycnv4zmdIHhP4TnYD6w/r0u+5nU5KWfOEY
         4CMDMtzw8EplixxbfzL6PhMDf5BwXkrIshoiR+rzqVZonp8K0+TL/Bb45gTwuwLB+kee
         1vslT+Ypxlj1ADlVGj/0S8m8FJckfkAX+bM/N4rBQSXvekae9U8BmkB9vD0OGibO22Mt
         8wLXAVIL4IuwY/5GytRONAVL8snYmrhozsFaEMuLhUJyXRHmhjVSETAg3P9FIBJE2Cor
         4k21VQIz4gf12fB4Cvtdjs/e/vN+c70bmNm8PwF4//NUa09djhraiXKl6YYBr1qQvPzr
         5FfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IhxX7/UwQW8UUFDvL4khisA5BoVLy2kIVZOLa5OOWmE=;
        b=0WfmVEmkEK13ZuZPVxfm5FAFPouG3QMur48T9rxvUb0AyEo7oAO+ZqTNMI1FVp290+
         Fay+s6FIU9tcj8CHynCowsqIkJpqzDpex2+cFgE0sxwTSvvhKWysCt1lUIFwyQN+j5pr
         EYMeqo4cXwIqATOXj8K/JldbHFtPEZfmIZVaxliy2e1WdlyNtwCpCWzzE00aSaU+543C
         6LkHLpxIHGCx5EcIJ1GqzyVwaaXVeDkA8rLdEzufn+tDHrKj7U0oLsEix5harwbP7dO1
         LfruY9u7ED8Vk3cjgqs6k7jDvJvAWpslLw5+BK4tLDs4XPHqKVHvuCRQhAD69uN33662
         2Log==
X-Gm-Message-State: AFqh2kpr9MPQOOVNPTAOKxYHi5ZPiQwAWl5TStkGrIBQQ6hbS06Tz8Bs
        yey0ctouGWfyUyyDlpCxeqZ4IA==
X-Google-Smtp-Source: AMrXdXvz8nBNsz7o5ZBwtfuhMuDRBOhphFcv9Rf4dn9bTjdoTg1m0a2W8lMTp68UgR66SJIZFxdWSw==
X-Received: by 2002:a19:a418:0:b0:4cc:6f42:a086 with SMTP id q24-20020a19a418000000b004cc6f42a086mr4512527lfc.64.1674296311281;
        Sat, 21 Jan 2023 02:18:31 -0800 (PST)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id u10-20020a05651220ca00b004cb10c151fasm6252975lfr.88.2023.01.21.02.18.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Jan 2023 02:18:30 -0800 (PST)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     marijn.suijten@somainline.org, Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Douglas Anderson <dianders@chromium.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Rajeev Nandan <quic_rajeevny@quicinc.com>,
        Stephen Boyd <swboyd@chromium.org>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/8] drm/msm/dsi: Allow 2 CTRLs on v2.5.0
Date:   Sat, 21 Jan 2023 12:18:30 +0200
Message-Id: <167429629506.2742089.6139689256773382900.b4-ty@linaro.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230120210101.2146852-1-konrad.dybcio@linaro.org>
References: <20230120210101.2146852-1-konrad.dybcio@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 20 Jan 2023 22:00:53 +0100, Konrad Dybcio wrote:
> v2.5.0 support was originally added for SC7280, but this hw is also
> present on SM8350, which has one more DSI host. Bump up the dsi count
> and fill in the register of the secondary host to allow it to probe.
> 
> This should not have any adverse effects on SC7280, as the secondary
> CTRL will only be touched if it's defined, anyway.
> 
> [...]

Applied, thanks!

[1/8] drm/msm/dsi: Allow 2 CTRLs on v2.5.0
      https://gitlab.freedesktop.org/lumag/msm/-/commit/1fe5158e7894

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
