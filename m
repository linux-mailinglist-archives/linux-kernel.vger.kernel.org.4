Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E95C62EE29
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 08:19:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241056AbiKRHS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 02:18:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiKRHS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 02:18:56 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD84172098
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 23:18:55 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id j15so7225310wrq.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 23:18:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KUOY4nIS+EPdm5b8Vs0He3SW90+YwQyay5PCgjl6fNQ=;
        b=NhCBoaaFAGjIcjypiwHh6dFfOC00sazPIPE9Yb+GqeKx4XxPy4uBkiyRW84HLKh/HM
         1LQSOKyCbYHASM1zpustxdMf3xTQ+mW6ToVAs6kRbKcXlUOAJJHqYi+pwu2jchJeUeVY
         AndnsUFUkecvCUjCOCgap0keY70racw/SUXYHzjBO3BidmK7xtyJsGeuCQs0XW0IBkTa
         cDJXwj1kqgjnXbhkNK0u+546hXejgAcoJIwm+w0G3D2yQBxPP5IP/KTJ7fweDlDW+b73
         vXn03Bsvfj24kVsDeKurPTEuf5e8ldvG2xKjAdZM+mZwzO+KwZa39DMlrGoee+S3s0tI
         43qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KUOY4nIS+EPdm5b8Vs0He3SW90+YwQyay5PCgjl6fNQ=;
        b=IbroZI78R2ZwgJwNeh2glSF6Y71gU332kpBD8oVpdrbGQRMS6N1pPGOAxvoS/iBuwv
         n7m1Q9ifwVMTBRIFs7/3YBMRou4iXZg+Wjzd4ThdKApt0JRQNvXJ6omRRaXJEp3rUH4m
         DhaGZO8yDIGoOqBsO9azuVeLzakc7KxdTgo/F3+PEZwUvKV6xeYrBIzsIsNjtWGDqKsx
         L2KDAgf+4ooDroUu9Jk7rIG5XEcqX/Jsj/jhkkJBDa644GGFIBxJ1PTrUEQzsb8PCnn/
         k9VFFAq84uy3nSpXmuDP5/N47svdO4zxdh20LSsFYw6sADfvb2iO/MvWq9luB/oJa2L8
         tfVg==
X-Gm-Message-State: ANoB5pkLmq82d0UxFIvlSthpmpHs6h2xZ6b/0wokqpO7JQ4hAo4EI/JE
        7UVnUSM3NLAEqYnwuu8pj9nKNA==
X-Google-Smtp-Source: AA0mqf4tJJ/aCkkczRMd8JCBaBzvq8aqeQFCciORAez9qokL4gjxye7DEB5zL8xkfk/VUWMi1ygHTQ==
X-Received: by 2002:a5d:4538:0:b0:236:5270:8f17 with SMTP id j24-20020a5d4538000000b0023652708f17mr3700494wra.358.1668755934296;
        Thu, 17 Nov 2022 23:18:54 -0800 (PST)
Received: from localhost.localdomain ([167.98.215.174])
        by smtp.gmail.com with ESMTPSA id j16-20020adff010000000b002302dc43d77sm2754349wro.115.2022.11.17.23.18.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 23:18:53 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 0/2] ASoC: codec: lpass-va: add npl clock support
Date:   Fri, 18 Nov 2022 07:18:47 +0000
Message-Id: <20221118071849.25506-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

New versions of VA Macro has soundwire integrated, so handle the soundwire npl
clock correctly in the codec driver and add related bindings.

Changes since v1:
	- updated bindings as per Kryz comments.
	- added error handling during npl and mclk enable.

Srinivas Kandagatla (2):
  ASoC: dt-bindings: lpass-va: add npl clock for new VA macro
  ASoC: codecs: va-macro: add npl clk

 .../bindings/sound/qcom,lpass-va-macro.yaml   | 63 ++++++++++++++++---
 sound/soc/codecs/lpass-va-macro.c             | 46 ++++++++++++++
 2 files changed, 101 insertions(+), 8 deletions(-)

-- 
2.25.1

