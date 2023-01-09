Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA0D466350F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 00:17:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237976AbjAIXQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 18:16:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237778AbjAIXQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 18:16:21 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C609BE7A;
        Mon,  9 Jan 2023 15:16:19 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id f21so6201842ljc.7;
        Mon, 09 Jan 2023 15:16:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pymBsysiRj4PWzpdrYvrGh6WCe9aRMDyVw4Cchu5q1Q=;
        b=oBjSl446gX8Wvv8tqNz7s0ruSNsj4f1Kl4m2hgWyKIb4Kzh/wCyAVc68HCWWCFs/vP
         Sv3jFQr6bhzohzSt0O2RA3c5Xo+H9itHusV1dz6c33pXSfRsMxNX/eQMUhCUo3q/lWXN
         YhMqG/LQ3ybq69MEwAOut3zb+vNOGvH0/qY8B1EbK4K3e7B+TtBYpbU+OMfDIqZimirM
         dBtCWIjGzVTeUFb/CTMRCHeIEjwsvpl4pKbsY/jfvWxtSJEAq8BT6PDMFDoaVPx9OXrD
         jyQlkTJMIcC/511AAENai/8lg4O9RdY1YMpF5VDiEmTFZBuzQCJAkxpqvboT8eZBqgl2
         UuYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pymBsysiRj4PWzpdrYvrGh6WCe9aRMDyVw4Cchu5q1Q=;
        b=Jh6JlcwnrKBxrOLXAgRzKZ8uMBoHzKpv4wHDZDwBKaDQnzGZxbkAsBsdxqzWlDcNZn
         zVDpW+F9a9FZHGSA/klJgcwPY1kpkQqR2Jcdjd3Vz6AtGDZG9AwtJ40wNEHmLB6FEf1H
         dWRfsPutzmYkLLeqL4Eh11pMCvitrlVby3znZRwEAyrmT6Sqi5efhWWeoD5duafQaBUf
         wOztDZPrlCW6PFqV6LpHnTxlBNmVrMUbEvO3Xd3zL3oE6ck0/TGBNS0ZcXv1jX7P6vig
         70DGe0Tm1hZOO2OdE1ZRDEzCaH82CySviQwlWHelRDhIQoAjgbpODYTEZu5Xy4b1TsX/
         UPYw==
X-Gm-Message-State: AFqh2kptJ9EhncJFBuF0DceC2hgZqRKcMZvIWQDsTp7adui5QFBUJasY
        efjWJCzdXydj3W0b8JorUNM=
X-Google-Smtp-Source: AMrXdXvi9TwYn3DHh44maaSHdojbkWYXp5Sbtq2hKe0+o0eVBCV/tiwi3CGkaKZOwy25UDOuwJzAmw==
X-Received: by 2002:a05:651c:198b:b0:27f:cd6a:db02 with SMTP id bx11-20020a05651c198b00b0027fcd6adb02mr19801959ljb.20.1673306177939;
        Mon, 09 Jan 2023 15:16:17 -0800 (PST)
Received: from localhost (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id q16-20020a2eb4b0000000b002862cc92061sm315979ljm.76.2023.01.09.15.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 15:16:17 -0800 (PST)
From:   Dmitry Baryshkov <dbaryshkov@gmail.com>
X-Google-Original-From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Del Regno <angelogioacchino.delregno@somainline.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221225115925.55337-1-krzysztof.kozlowski@linaro.org>
References: <20221225115925.55337-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH 1/2] dt-bindings: display: msm: drop redundant part of title
Message-Id: <167330408778.609993.10640569681810813503.b4-ty@linaro.org>
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


On Sun, 25 Dec 2022 12:59:24 +0100, Krzysztof Kozlowski wrote:
> The Devicetree bindings document does not have to say in the title that
> contains "DT properties", but instead just describe the hardware.
> 
> 

Applied, thanks!

[1/2] dt-bindings: display: msm: drop redundant part of title
      https://gitlab.freedesktop.org/lumag/msm/-/commit/e90c380ea283
[2/2] dt-bindings: display: msm: drop unneeded list for single compatible
      https://gitlab.freedesktop.org/lumag/msm/-/commit/7ad6586652fa

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
