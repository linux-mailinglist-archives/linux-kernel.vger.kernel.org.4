Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 866C4700665
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 13:11:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241035AbjELLLL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 07:11:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241037AbjELLK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 07:10:57 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D047912E92
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 04:10:37 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-3078c092056so4813122f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 04:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683889836; x=1686481836;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y+KMJ/AizzmjvBDK75pfKIoc8C4iUMG5GzBQw5S3Y2M=;
        b=To5ik1sgCmInqKXB4yESoh9/JmeHZvBWQH71Auy6YaptnepzOFlI4JBQAfvyX4SyGj
         mm//7gMKmNi+3Jj2rp/Ip1dWRSJCnjgC/TjUT/O2aYtCfBAzu0D+/zYprvSTvC/ecZUg
         HvrA/QjIo0BQE7hoLZgZywdAwXnM3Gm/0rVVkvyHzeHp6m7USOd6TF0mIRsu8Jua/rul
         jzqknHbBMghUjYQasJYknqevf61bHs8hT/RkIclnljhMvqPvgO59aekaRusb/xChPBxA
         913UVIBXWKtluXmK2G++P2onRnMXrczvu9BFDQPfVZ2Fb3ArtoXlXhft7FBKTMhQV3gh
         nCsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683889836; x=1686481836;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y+KMJ/AizzmjvBDK75pfKIoc8C4iUMG5GzBQw5S3Y2M=;
        b=D5TxAq8i4fubOUb9CREp9YdCi4ufs3F59K3AvwDG0iJOjp1HVK9BCclLKjHkRxomvE
         CsPbZg3jLDnWprpj2Qsv9z5m7a6KxjTrYgF8uxAj+p0K55Pk+fuXOoAPfetj+gi/GXH8
         I5V/biPat3IT1iP4zeGyWViufmVHSETRPcWjuIJv/JPPyBz8eJ2JKIn/QZUF8OPFLsWA
         INAmCph+FCC7KGId6aMxLC+XY1JZBhShB65tryCU+zQVdJgsSpDgy3l/FtNkeYv2pgco
         6odWrCOshcdi/yPkBrmZVpTq4oEbMR60N/vn7kqtQUR1vM/jXEq2T1XnILRFqosGAVzv
         LsVA==
X-Gm-Message-State: AC+VfDyMCpKThwRNZNyWMkpZKY0cUwEBga4A6SmNrkIUP8O/f1qLyC3P
        aIvT1cmB9ZvpUTSNcAtGjGaGCw==
X-Google-Smtp-Source: ACHHUZ6BySf4RTOA+DCTnNPHluussWs1MosyuGdp8wA/aRAU7GBrsacrdRgCwVTXFnSsCvVg9uzYJA==
X-Received: by 2002:adf:ee0c:0:b0:306:2c16:8359 with SMTP id y12-20020adfee0c000000b003062c168359mr18084867wrn.39.1683889836235;
        Fri, 12 May 2023 04:10:36 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id p8-20020a056000018800b002f28de9f73bsm23471755wrx.55.2023.05.12.04.10.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 04:10:35 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Kever Yang <kever.yang@rock-chips.com>,
        Finley Xiao <finley.xiao@rock-chips.com>,
        Vincent Legoll <vincent.legoll@gmail.com>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
In-Reply-To: <20230504200648.1119866-1-cristian.ciocaltea@collabora.com>
References: <20230504200648.1119866-1-cristian.ciocaltea@collabora.com>
Subject: Re: (subset) [PATCH v2 0/8] Add RK3588 OTP memory support
Message-Id: <168388983496.54762.17098900405456249991.b4-ty@linaro.org>
Date:   Fri, 12 May 2023 12:10:34 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 04 May 2023 23:06:40 +0300, Cristian Ciocaltea wrote:
> This patch series adds OTP memory support for Rockchip RK3588 SoC,
> while also providing a few improvements to the existing rockchip-otp
> driver, in addition to converting the bindings to dt-schema.
> 
> Changes in v2:
>  - Renamed rockchip-otp.yaml to rockchip,otp.yaml and removed clock's minItems
>    in PATCH 1/8, according to the review from Krzysztof
>  - Updated commit message in PATCH 2/8, per Heiko's suggestion
>  - Renamed rockchip_data's clocks to clks in PATCH 3/8, per Heiko's review
>  - Preserved clocks order/names from older SoC variants in PATCH 2/8, according
>    to Krzysztof's review; updated accordingly patches 7/8 and 8/8
>  - Added Tested-by tags from Vincent
>  - Added Reviewed-by tags from Heiko
>  - v1: https://lore.kernel.org/lkml/20230501084401.765169-1-cristian.ciocaltea@collabora.com/
> 
> [...]

Applied, thanks!

[1/8] dt-bindings: nvmem: Convert rockchip-otp.txt to dt-schema
      commit: 5dede99d255a14e4819e74ee0e8710b96a354b99
[2/8] dt-bindings: nvmem: rockchip,otp: Add compatible for RK3588
      commit: cdaa055cdc739c5c38b7e1ede59718e8d817c2fb
[3/8] nvmem: rockchip-otp: Add clks and reg_read to rockchip_data
      commit: 71f1b0883907d4f3604a169e8b8750138b8ae302
[4/8] nvmem: rockchip-otp: Generalize rockchip_otp_wait_status()
      commit: da5c9b4fcf324f57b045e9eb5dd1df95784a8609
[5/8] nvmem: rockchip-otp: Use devm_reset_control_array_get_exclusive()
      commit: e86fba9eb891e375e1f7c9d935fa2687cba9b4c8
[6/8] nvmem: rockchip-otp: Improve probe error handling
      commit: 17baab60780b6801bc94f50c5fb12b9c3c262ceb
[7/8] nvmem: rockchip-otp: Add support for RK3588
      commit: 3a0134e21d90ab0389359a1908a3ea21dd01d661

Best regards,
-- 
Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

