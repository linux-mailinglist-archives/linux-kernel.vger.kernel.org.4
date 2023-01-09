Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BE606635B2
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 00:44:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238065AbjAIXoi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 18:44:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237817AbjAIXoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 18:44:14 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0BA93FC98
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 15:44:07 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id b3so15632884lfv.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 15:44:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P2ILC0s/EAU+DV83P6Wz26LirhdaLi4CEI3lPCyUm7s=;
        b=SCvtPla8vRT2nzGbX8bZCBvG1/UsYY6j9CccyXHnWODwEmM4R7Il8lt74yhlbfkrFG
         oaeywk7xMz+UgkLoze5huZ2nPADrqG2AUryZw6EYQbf3j2R70rcFEG79ScrU1l2pJaZp
         Go/A5XPGLC1ILp4uSUvnk9wVIEW3Xd0/1ywVmIj1n5FD99iYBPu6l/hrhlqiBExA/14z
         W09j4PcO2onTqvbwDbtwL57MeHQXC2sRPgA6QYBdMMOq1f/8ciVAeIOMiV7jAPUnxO7x
         mu32t23lrNmAaTY4t5G41BfpBW713q2CCAMkdWAT0dW8QdpG796/juAp7bUwsWLmOHt5
         OLTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P2ILC0s/EAU+DV83P6Wz26LirhdaLi4CEI3lPCyUm7s=;
        b=hx53OpxvhaJ1gv/Bl3YsCWfk2FhmeBc+E2k3ZRUMKohlxaAfBEPh/IEy2A1k41vIhi
         Ha5gon/X6vLw+KQ0A3gAhPzkZQbH7g0+EzqUUL6Uh8R/MBfxGetD8i6QYW3EobJpE8bX
         OdWmSR3bMnKw81i4DewanlZeT9ydbXED+uwpC7gMgyevSNgI7zLBsChyp1oF0cNzunZt
         6ds2ZS/69tFpvW46B+i59nFUyUf8pk+z6SdiunA9WNj0FqTC+nbbZvromLOvRwrSa+n1
         L+Uf+G64veAwFUQ0OPahGE7E7K4wV9z7U1cWpoqQbo5d5MQ3ciOq2C5KGLxm/wSPEHSM
         l4+A==
X-Gm-Message-State: AFqh2kon1y9i4fUjZ3k0A75UCO6HVH3vTmRCaDAxFvlpTNaSy0CMMLTX
        NH/wjy00xWO/hhffmbLmYaR8gQ==
X-Google-Smtp-Source: AMrXdXu/IjK8CLIFRBP/OvhD+9PARQuHtXgB6Wi4ihe7XAQpCf5o/DB+lyKbwXvdNcwzJVJp1EZOlg==
X-Received: by 2002:a05:6512:2591:b0:4b5:5bc1:678c with SMTP id bf17-20020a056512259100b004b55bc1678cmr18912405lfb.21.1673307846247;
        Mon, 09 Jan 2023 15:44:06 -0800 (PST)
Received: from eriador.lan (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id s9-20020a056512214900b004b5a4cf69dfsm1835255lfr.261.2023.01.09.15.44.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 15:44:05 -0800 (PST)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     marijn.suijten@somainline.org, Rob Herring <robh@kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: display/msm: Add SM8150 MDSS & DPU
Date:   Tue, 10 Jan 2023 01:43:50 +0200
Message-Id: <167330408777.609993.10625838053126899594.b4-ty@linaro.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221229100511.979972-1-konrad.dybcio@linaro.org>
References: <20221229100511.979972-1-konrad.dybcio@linaro.org>
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


On Thu, 29 Dec 2022 11:05:08 +0100, Konrad Dybcio wrote:
> Add bindings for the display hardware on SM8150.
> 
> 

Applied, thanks!

[1/3] dt-bindings: display/msm: Add SM8150 MDSS & DPU
      https://gitlab.freedesktop.org/lumag/msm/-/commit/9ffbefc1553c

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
