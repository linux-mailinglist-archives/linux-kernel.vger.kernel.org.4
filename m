Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1148D708424
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 16:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231716AbjEROoe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 10:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230448AbjEROob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 10:44:31 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A635EDB
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 07:44:30 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-3093a778089so1438881f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 07:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684421069; x=1687013069;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s4ZpmaXHltYze/tda0999X9vCLU/m+/R6VVx4wy1BLQ=;
        b=niYRvEQd9ba3VJ75a8EW9xcwaGlc2xA9ZRZps5WdQx6HuR7UAP37BItNiQ+IfZ6vNt
         dNZ/fxM71IVxtvsiJmh1Py/bsAl1phIHJHToO9mz8FfTpQ15CWmB9H0sxPlR/1pGZkNg
         NIlfBqF9NhQTXdVr7ItJCi5+Ye0WUmcw0j+RbqkqmLWloJHsXrOiEccWvcIjqa7Ul11S
         qR8v3ZVLC0gXbd9WWht5gjc9mePoig8WFfOhqCj8lH2xrvTo7VojT7Al7mlBs+n8DrFk
         SHHq2zY2ycngAI6NsI0EZbeKjpSjIO5xAY8V0nVS6dpYGLgZ2BcmCZDsJSx487mEDR1W
         r64A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684421069; x=1687013069;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s4ZpmaXHltYze/tda0999X9vCLU/m+/R6VVx4wy1BLQ=;
        b=SpQc7AW20JdO/2RPWYnp6IY0vRChXsD1IZY9+BH6hmdkJ+SR9g8UFqS45FPIDLuh18
         fhaCmb/fnA8sSpRvCsES6afwv1mNipY2TzKxD5/wQg5GmjRX/1ardOyoE8TITR6xWRSW
         VF8vDOcoMezCzYORbrSA5kNiceeEXtUaPbPZCO0hYfyIvWSzv0xTKdEojUovz4NsBy6c
         UwrGPibZtmfHvLTfoBvIX1HgSyTKkIHjhNsgB7BkcDlN2dD/ltStK57D8oC1Zbqs5x8C
         PZxScX2g4k4LhOa5U53qEAzy6EUFbnACfxOnedMvv+FnMlIv2WaWfeAwppfj4F+6UdSb
         W7ew==
X-Gm-Message-State: AC+VfDybDvwF2981sgxBb6g+9caoE6oycMGK3f6jB6inl9epn2G6018P
        LdPgzL7kYqConU4cNlIJL8nH/Q==
X-Google-Smtp-Source: ACHHUZ6X/HrDmzHif0p1Tigy5zsQlElGdzGKBGwaXz1EhaWbru41LcMCDcHji00NT4wS0Ax7RcE+8g==
X-Received: by 2002:adf:f0cc:0:b0:306:2e48:6ded with SMTP id x12-20020adff0cc000000b003062e486dedmr1791903wro.13.1684421069168;
        Thu, 18 May 2023 07:44:29 -0700 (PDT)
Received: from hackbox.lan ([86.121.163.20])
        by smtp.gmail.com with ESMTPSA id i14-20020adff30e000000b002fb60c7995esm2448600wro.8.2023.05.18.07.44.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 07:44:28 -0700 (PDT)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     abelvesa@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     linux-imx@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH] clk: imx: drop imx_unregister_clocks
Date:   Thu, 18 May 2023 17:44:14 +0300
Message-Id: <168442103976.3235434.11482255749033267131.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230506090856.3599035-1-peng.fan@oss.nxp.com>
References: <20230506090856.3599035-1-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 06 May 2023 17:08:56 +0800, Peng Fan (OSS) wrote:
> There is no user using imx_unregister_clocks, so drop it.
> 
> 

Applied, thanks!

[1/1] clk: imx: drop imx_unregister_clocks
      commit: 6077af232cf58bfa4203c2364f99e0218aac7667

Best regards,
-- 
Abel Vesa <abel.vesa@linaro.org>
