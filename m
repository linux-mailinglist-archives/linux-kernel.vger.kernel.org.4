Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDF1374F209
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 16:24:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233548AbjGKOXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 10:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233160AbjGKOWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 10:22:34 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59DDB19B9
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 07:22:12 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2b6f943383eso91879821fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 07:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689085320; x=1691677320;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1DWVqty+49hJ6Ou5ZV1VCQ2wZFRYyEKX7786q3fgS8Y=;
        b=enn5A4LCsWyyvv2Jvz5C5NnQgsez56YVRG9VDJW+buVqdx2vuJhxjcAJUsWjRbwZtC
         2thZL55bvtxhhZNxpEesVyzWdwTWDTSvQ+KQnDdRPq64RZKbmXuX461+sVqUZMJz/+Wp
         KdwakIG/cO6e9wUtvEswrwU0NDSwoVGD7BnoNW9CS2rCXa3xeskoX6jAR/goObIPry4c
         EOL7cqrqr8QFcikdi9FdYFImPcNE7iI6PoeyHxCqZIf1ujuHz0BV6kmj0MPjEYJxOgPI
         m60R4qzPpsJaLGvx15SUf1zaT2eBp71sstXrXzqZsTUtyYl1ykkvbKgbD7iyV9ItA6ql
         JpqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689085320; x=1691677320;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1DWVqty+49hJ6Ou5ZV1VCQ2wZFRYyEKX7786q3fgS8Y=;
        b=VXcWDrhN2yNo2SQedVV36zKyiC/SEzLEVASQN4ENmAdWbQGpM0rMRM7zeIZpu7m4C7
         edaUcNFdMoh5HNT0LD5lWOMYbQaXB9DxJHmimeuSjsz8lle39N/3C2iWBA2j56LegtHf
         s+YfiB/m1dNWJ4Vmnn3VD8hL1t5c3rqjqG180Y0qBr2YPbDtc3n4BRjulJKkClPL8WzU
         anQ3xl53V5DZhxEbI1lWFBCiM6tS6y2I29tW723YzBWYhj4r5nqbRIKwhXRM31o8s3og
         UeXpg+dcDCSHUU3Zb2aFXoA5EMcTDdD0xs6ohhNxj6CKSEYA2Q/x93MfrLtVwVrf9cT+
         u+TQ==
X-Gm-Message-State: ABy/qLa1HiMwnD0T4TMOWCqY7sCCsg2qkJZNTu4FO65Vz0yJXDAt84Ph
        cewW/QaLkS2JdarI5/QrThiUqg==
X-Google-Smtp-Source: APBJJlGYIzCN54UshyQrjtzhpBdQPyx5aDjWikjVPne5sfVc51vjKTFMuCDQLmyuUUgVbJqPjHqFEA==
X-Received: by 2002:a2e:7a16:0:b0:2b6:ee6d:b647 with SMTP id v22-20020a2e7a16000000b002b6ee6db647mr13761996ljc.28.1689085319994;
        Tue, 11 Jul 2023 07:21:59 -0700 (PDT)
Received: from eriador.lan (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id v9-20020a2e87c9000000b002b6b4424a28sm487934ljj.13.2023.07.11.07.21.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 07:21:59 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 0/4] Qualcomm REFGEN regulator
Date:   Tue, 11 Jul 2023 17:21:49 +0300
Message-Id: <168908465044.1869384.14451201608832170606.b4-ty@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230628-topic-refgen-v3-0-9fbf0e605d23@linaro.org>
References: <20230628-topic-refgen-v3-0-9fbf0e605d23@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 03 Jul 2023 20:15:53 +0200, Konrad Dybcio wrote:
> Recent Qualcomm SoCs have a REFGEN (reference voltage generator) regulator
> responsible for providing a reference voltage to some on-SoC IPs (like DSI
> or PHYs). It can be turned off when unused to save power.
> 
> This series introduces the driver for it and lets the DSI driver
> consume it.
> 
> [...]

Applied, thanks!

[3/4] dt-bindings: display/msm: dsi-controller-main: Allow refgen-supply
      https://gitlab.freedesktop.org/lumag/msm/-/commit/f5cedc432fdf
[4/4] drm/msm/dsi: Hook up refgen regulator
      https://gitlab.freedesktop.org/lumag/msm/-/commit/4bc71795761b

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
