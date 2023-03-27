Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A5A46CAE5E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 21:15:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbjC0TPu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 15:15:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbjC0TPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 15:15:47 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 416F3114
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 12:15:46 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id y85so4331831iof.13
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 12:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679944545;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sYePwSpMOlW9JU918gQssPhNKde1XD+sdXMbzV8LEpc=;
        b=hK2HDdGjuk8VvHQEGy3DAfN6UrL8tyyhPNMkIqVGZDg2NjhZfI2L4OFwLuDoCrf/HI
         67Qe/0VEYYCpSEgStxKgmU6HX30FYFC4WqYxq/C6F56gLsK1SWiS/rpCon7tBXcowKxU
         O9i3KdU3jAzRyeyKGbA7gRqKo9W63L3Fp7DEZpOuBQqGp/fblKAr8fRW7KSi6InU6fu5
         bnMj+MdO9Rz80/bQQ64oQy43pY04kkIX/AA8SF25mZbPNsQ8V6MmpshllyP2mvcOPixu
         Ov4blG/kcpICl5D6Cd3j043pVXhAsfYjyI98D5/xOHcMF0X3b2PTsJI+f+7cnBzuyrh6
         Y2UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679944545;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sYePwSpMOlW9JU918gQssPhNKde1XD+sdXMbzV8LEpc=;
        b=WGDyy/DgIgccWSJODWufCVC7SFGhrqKEdCEs4jH2v8ViWNbE7mu5BAmNF6u0UqKY/K
         UIw05LtqDLApJUt5c1tFmxDtXc1+uf/Qn+BJLvophncEOlqlILHt/JeWxIM+jyyHwR8O
         ZYUCr2xXyawx3+ecNZTaA+dZMbsEuMaxSsEiXlNwmrBJ+NdScBHOMZy6KEHorrfkUlJq
         AD5T4qkbgCpAXNjwKtv6UIU35isYOJZBFq0UiQSUOuJ+3KXu2Q17dO4jeOrxQkAD3KXt
         Ooj1xeRx8fY4Oz+4HSp41n+8N/Ev7nKHb37ibcH40mL0T/7nEKp44YXzcKoHNg/HjBdv
         shhQ==
X-Gm-Message-State: AO0yUKUa8Pv15fZO9YnNSiIBdr0O9ziCYerirXF0CHe/rEX1LvAi+aPT
        /GWA0SUayWPkXATVMa3CQrlMbw==
X-Google-Smtp-Source: AK7set9IQxnK3fjpDOFGQWO8VzObSo5WdbE1/skSHSh7NQgQMmd0rJg4+Wg3P0olNFYS4NB0eWfjog==
X-Received: by 2002:a5d:984b:0:b0:753:7ab7:7d44 with SMTP id p11-20020a5d984b000000b007537ab77d44mr9531724ios.0.1679944545559;
        Mon, 27 Mar 2023 12:15:45 -0700 (PDT)
Received: from localhost.localdomain ([98.61.227.136])
        by smtp.gmail.com with ESMTPSA id n13-20020a5e8c0d000000b0074555814e73sm3460548ioj.32.2023.03.27.12.15.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 12:15:45 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        andersson@kernel.org, agross@kernel.org, konrad.dybcio@linaro.org
Cc:     quic_rohiagar@quicinc.com, caleb.connolly@linaro.org,
        mka@chromium.org, evgreen@chromium.org, quic_cpratapa@quicinc.com,
        quic_avuyyuru@quicinc.com, quic_jponduru@quicinc.com,
        quic_subashab@quicinc.com, elder@kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] ARM: dts: qcom: sdx65: support IPA
Date:   Mon, 27 Mar 2023 14:15:40 -0500
Message-Id: <20230327191542.2765834-1-elder@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The upstream IPA driver now supports IPA v5.0 for SDX65.  Add
IPA-related nodes and definitions to "sdx65.dtsi", and enable IPA
in "sdx65-mtp.dts".

Having touched these files, Konrad advised I should update them to
move the "status" property to the end of nodes where it is used.

Version 2 of this series addresses comments made by Krzysztof and
Konrad, and adds their reviewed-by tags.

					-Alex

Alex Elder (2):
  ARM: dts: qcom: sdx65: add IPA information
  ARM: dts: qcom-sdx65: move status properties to end of nodes

 arch/arm/boot/dts/qcom-sdx65-mtp.dts | 11 +++++--
 arch/arm/boot/dts/qcom-sdx65.dtsi    | 47 ++++++++++++++++++++++++++--
 2 files changed, 52 insertions(+), 6 deletions(-)

-- 
2.34.1

