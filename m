Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4F3A74F1FF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 16:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233562AbjGKOWu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 10:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232621AbjGKOWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 10:22:31 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F213710E7
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 07:22:07 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4fb77f21c63so9197841e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 07:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689085319; x=1691677319;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jIVN6C53juP0Q5iDUT1F1HeifUyBCNpXBYhLUGADz7A=;
        b=F2KzE1D9nWBzFgZ6+NFkRYupZLL5otNkqPs5j74tUMqGFtIH/k6+yxbz3wsFhHgEma
         UQOyUHR7EBb2QRfNeZY9n0/dYZXteFQ5jyBuou0afKMNm9jxtPAzTTXd94dolct3VKAE
         lQ+L1XYD9v4zr4K009AUW/5tNT978pAwwexQH4Y7Rxx2OluCPLu0NUfeORF//HxYhVIZ
         gYnF03fI1nfRck5C2qZ7MAOTTjs5SXcFvC9iTi3ayiSKU5pPavZHgHPoKfE2vNQRhJ5U
         eICAIEnmrI1lyHGmYp6yq1tLnBscBgNxRz4KM0hceuKH8WR64Qj/b5baDRaM5petQucG
         HBgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689085319; x=1691677319;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jIVN6C53juP0Q5iDUT1F1HeifUyBCNpXBYhLUGADz7A=;
        b=Z6nmlnXQcd5iuc1hIFup9VR0ljIQuHjOr3xTDZEG2tF/FC+G+IPdh2t/Pg+cQg82Ay
         uDgut6YB2KPTs9Lg/UF65fSuzHkktgjKEFiDTMskt9bhzXWqvSLyPbForWq9Ds5qXIWq
         vjEjq8AYPnQ7b2JLEZiHHYyG+iGl7JW8zBxRzB6/b2K/jjeFvonTXLkCghczsJGEVQrL
         4xHDqAN7DfSMLf/NGqhXudcChzRL8XzQdrI1t2yE+DA6k4H5nAA24TwXruwLoThpbyCN
         7vgFXlRewRNqnzv+LyhyafAtF3R66WWAQRQX17A4PKq9alogvNSgOgf/FpRGPXji6Bs8
         FFnA==
X-Gm-Message-State: ABy/qLahmld7usENSTgWbxGHF++kKI5gGQWbmBiOiE+p5tR6IVpEmqOT
        aNNPG+kTyOHUe7m4RvGXkpsu8w==
X-Google-Smtp-Source: APBJJlEnEc2yw26sZg7r3jOg61IenC2emKJQYboIRLUpgluHvcSybr2bOGCJPNanGdpVVqAUd96rxQ==
X-Received: by 2002:a2e:a170:0:b0:2b6:e958:d03 with SMTP id u16-20020a2ea170000000b002b6e9580d03mr12795430ljl.30.1689085319029;
        Tue, 11 Jul 2023 07:21:59 -0700 (PDT)
Received: from eriador.lan (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id v9-20020a2e87c9000000b002b6b4424a28sm487934ljj.13.2023.07.11.07.21.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 07:21:58 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] DSIPHY RPM
Date:   Tue, 11 Jul 2023 17:21:48 +0300
Message-Id: <168908465045.1869384.1893558597710112842.b4-ty@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230620-topic-dsiphy_rpm-v2-0-a11a751f34f0@linaro.org>
References: <20230620-topic-dsiphy_rpm-v2-0-a11a751f34f0@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 20 Jun 2023 13:43:19 +0200, Konrad Dybcio wrote:
> Some recent SoCs use power rails that we model as GENPDs to power the
> DSIPHY. This series attempts to make such configurations suspendable.
> 
> Tested on SM6375.
> 
> 

Applied, thanks!

[1/2] drm/msm/dsi: Use pm_runtime_resume_and_get to prevent refcnt leaks
      https://gitlab.freedesktop.org/lumag/msm/-/commit/a402e0e61b75
[2/2] drm/msm/dsi: Enable runtime PM
      https://gitlab.freedesktop.org/lumag/msm/-/commit/4e905c2acc9d

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
