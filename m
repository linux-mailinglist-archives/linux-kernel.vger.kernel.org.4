Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09B8F72145D
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 05:02:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbjFDDCL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jun 2023 23:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbjFDDBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jun 2023 23:01:50 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E16DC196
        for <linux-kernel@vger.kernel.org>; Sat,  3 Jun 2023 20:01:48 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4f3a9ad31dbso4626418e87.0
        for <linux-kernel@vger.kernel.org>; Sat, 03 Jun 2023 20:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685847707; x=1688439707;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3vqZu2+86qpa6J8c7UM7f5JxWOqtwBHGUvC7S2Jahgg=;
        b=wE1Eof7zF8xvSTaAmXBiCImMSapv9vqPAUp/CxkJoJ5W8/eIDT2+EDFP6oB9Ej6TZz
         NBWHFEKTZdh2Vy9XiQyED5G6qwqPWIlXIauRN1MRjdLfAzu6Fsa+thLDspwcx+UNHQhm
         +nypntpxt3rC9qU8CtOVgLs2+WhjrBPwfikdpRCFWJ/azuQkPgeSeyu78ywZogpdiDCQ
         p3Y7O+qtuwwX0Z1OiVzdBaJd9kmvg3maXiqpLX/FYRvR6dOYJ7NBzyAhgatxzgWQEj2Y
         e4CE70kNkGDR3FqieS2IpetyjxLR9bf40IaNs2oCCYNLHk57yXnvv73bA9+ao2oO70ce
         xEsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685847707; x=1688439707;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3vqZu2+86qpa6J8c7UM7f5JxWOqtwBHGUvC7S2Jahgg=;
        b=DD82YsZoqhkXOQPmVmpEHg6CVETy20wE6nUaM76ojk2p7MrJc8Rev/YNaIXM1gf6nv
         e25c0Ns9Hq00Fr9ES1gRgiDKU3hQBFTeRL8cKPfIToXIxmUVcpdeXwNd2Axup7O1m068
         MEDbmSU8dNvENIVPX/6GzV6L9QWGzJG1pin65RnDvg7nprUdn7Hh5JUn+FmMO0MY9hbn
         L4IKDVB4nBB+7e3oeJTZd3mqAINISEIn/avwTLFIXCee18RkT4tJyrb4RBbjTIpL9Dlu
         HgDZhJg1EwOpGv6XQfaXqYKfXrB1T2ft1ih+fdt6OlYLKUDyBH9wxzQFWMN2pVtlCbN8
         BARg==
X-Gm-Message-State: AC+VfDyqjCv6o8qfvR2m5YOctFcRTaEb9WdE41n686OK24Vnj+eEUguU
        ptTkxZhup8Dq+nhcISbvEuZJ3g==
X-Google-Smtp-Source: ACHHUZ5QqEPp8PdFbvNEcYJYgWNC3qc6Y4rgEoQ9eHDJtqkpog+9yv6rCX+GH0t1E7CVkNOHqnJI5Q==
X-Received: by 2002:ac2:491e:0:b0:4eb:1527:e2a7 with SMTP id n30-20020ac2491e000000b004eb1527e2a7mr3228957lfi.45.1685847706977;
        Sat, 03 Jun 2023 20:01:46 -0700 (PDT)
Received: from eriador.lan (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id d15-20020ac24c8f000000b004eb4357122bsm653181lfl.259.2023.06.03.20.01.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Jun 2023 20:01:46 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Bjorn Andersson <quic_bjorande@quicinc.com>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Polimera <quic_vpolimer@quicinc.com>,
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org
Subject: Re: [PATCH 1/3] drm/msm/dp: Drop now unused dp_hpd module
Date:   Sun,  4 Jun 2023 06:01:35 +0300
Message-Id: <168584750426.890410.4013288321469753930.b4-ty@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230515030256.300104-1-quic_bjorande@quicinc.com>
References: <20230515030256.300104-1-quic_bjorande@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 14 May 2023 20:02:54 -0700, Bjorn Andersson wrote:
> The dp_hpd module is a remnant from the downstream design and is now
> completely unused. Drop it and all references to it.
> 
> 

Applied, thanks!

[2/3] drm/msm/dp: Clean up logs dp_power module
      https://gitlab.freedesktop.org/lumag/msm/-/commit/9f93258549db
[3/3] drm/msm/dp: Clean up pdev/dev duplication in dp_power
      https://gitlab.freedesktop.org/lumag/msm/-/commit/9edac2eec47c

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
