Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 953246DC053
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Apr 2023 16:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbjDIOXx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Apr 2023 10:23:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjDIOXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Apr 2023 10:23:52 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3074830F6
        for <linux-kernel@vger.kernel.org>; Sun,  9 Apr 2023 07:23:51 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id ga37so7458278ejc.0
        for <linux-kernel@vger.kernel.org>; Sun, 09 Apr 2023 07:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681050229; x=1683642229;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DqPIoCoomA8L5JHEupP23UKlPUUpxbHXM1MBt47mfVA=;
        b=tH5WcKj+aaHTBuDK/67EeNCeK65LCw6GYg7tfwzO1r/Q79SyUzPGRNH/SYLdX0Tqj0
         9tOFKektqXJgFituzqtrlGQIMkkvu+2TgJSK1AAxg1SlLGtOq3/wY93+1oIcInTJFQLx
         b2VjJkM0LKnYiuRY/9nh0WlaWKL0LuYvtHycNEEqHfCO5vQYKnW7BzDr0AIWMAXur2Ux
         3YSZCyiN6geDpzlqJqfh0JBaBsrawEyHxPf9N9wnHic3n4fVI5JepL2STv0Id+4qE08L
         l1jE0fhRdc28zRTHH4YMvhYiF6YzeKULPMRXAEygXz/YimwokXImr7jYLVo2eZbaS5Cl
         pcfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681050229; x=1683642229;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DqPIoCoomA8L5JHEupP23UKlPUUpxbHXM1MBt47mfVA=;
        b=fh0dYgsCkQf0lCraKTb68z1/eukQ4OEGvB0m51tIa0qtD/onzxM9iUBd27qhsarM2+
         WKsRT1EMooiId+RShuJye7FwENm5hvaA2MXJ/eo5iKlU8hp3tX9XKFp0CYOXM5Vq81Sl
         SymrfklA6DqVwgBw+mYcfHv/w1R4U2IQMdtLnRK/J0Tl9+PieVY4iD+a206ZBJoJcPnW
         8f6v7k/FaJrLeed7HnxfJ0xAtFsXHotpQpOlTHDxNQbWkLyPTEVH+ucIh4SrDtSkBerx
         GzwIwUReEDKKD2a5NXHumHSVB4WBZU3QsjWOzwjd0c9T7XirggQ4Pn3zAl4vREpRbkg8
         rHXQ==
X-Gm-Message-State: AAQBX9cUPP/RT+7UMsCMz3MDZw6E/GEjQgUeSexwAgNWwcbzcG8ueiZg
        GnpKFUG/grn2DI0SMnHFR4Fu0w==
X-Google-Smtp-Source: AKy350Yht3t9LxfH+UKLHjrMHGP0rxyrwkDuwaYMWoEPtkSZjcWRQ5qDzTfr4ULMMeuModC00vjPwg==
X-Received: by 2002:a17:906:848a:b0:947:eaed:1f87 with SMTP id m10-20020a170906848a00b00947eaed1f87mr3919452ejx.19.1681050229721;
        Sun, 09 Apr 2023 07:23:49 -0700 (PDT)
Received: from localhost.localdomain ([188.25.26.161])
        by smtp.gmail.com with ESMTPSA id j6-20020a170906278600b0093e39b921c8sm4100378ejc.164.2023.04.09.07.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Apr 2023 07:23:49 -0700 (PDT)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     abelvesa@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     linux-imx@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 0/5] clk: imx: imx8ulp: clk fix and update
Date:   Sun,  9 Apr 2023 17:23:28 +0300
Message-Id: <168105020032.1580154.18370162698683107532.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230331063814.2462059-1-peng.fan@oss.nxp.com>
References: <20230331063814.2462059-1-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 31 Mar 2023 14:38:09 +0800, Peng Fan (OSS) wrote:
> Patch 1 is a fix to get correct clk rate
> Patch 2-5 is to support accurate clk rate, enable MU and TPM clk for
>           low power, update flag for system clk freq change
> 
> Jacky Bai (4):
>   clk: imx: imx8ulp: Add divider closest support to get more accurate
>     clock rate
>   clk: imx: imx8ulp: keep MU0_B clock enabled always
>   clk: imx: imx8ulp: Add tpm5 clock as critical gate clock
>   clk: imx: imx8ulp: update clk flag for system critical clock
> 
> [...]

Applied, thanks!

[1/5] clk: imx: imx8ulp: Fix XBAR_DIVBUS and AD_SLOW clock parents
      commit: d608c18018c897b88d66f1340fe274b7181817fa
[2/5] clk: imx: imx8ulp: Add divider closest support to get more accurate clock rate
      commit: 335aee51ffc72149ddf99755ba629f981f20e6b6
[3/5] clk: imx: imx8ulp: keep MU0_B clock enabled always
      commit: 4883200d8c0b20cc3bf90fcd3b837a344a31ac66
[4/5] clk: imx: imx8ulp: Add tpm5 clock as critical gate clock
      commit: 66d72c62d20eb571b7ab624813b1b98b626ab493
[5/5] clk: imx: imx8ulp: update clk flag for system critical clock
      commit: 8a05f5cccdbe851265bf513643ada48c26b1267f

Best regards,
-- 
Abel Vesa <abel.vesa@linaro.org>
