Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E88D72BCF8
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 11:47:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235019AbjFLJrq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 05:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231137AbjFLJrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 05:47:08 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 261E75261
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 02:34:11 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-973bf581759so731800066b.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 02:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686562382; x=1689154382;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wsfv8tU8typbArcFFZ3RmodVuhSCsV+o3+M2ATwIwoQ=;
        b=TUVRaQrj978yj3MbisxqkjQ+TD0JBBm+EutSEaAHeOCuts1Q0j2OuxULpIx2+Bsi15
         ltrB5Na0agI4WZIIGzJAK7rc6fkrTgH3/y+DbfbT7KocetCj2XbBDy8QAae/kCI03fcV
         qqb5R0jk/XnngPe6DCxaj7C2MBSVu7X4Sf2Lbyc3+h624qAUhkiURnZDcXbFrOMcI8Go
         OVnmbrHSlbfViKCQXu3P8DpOOaekybyyjRU7ezTIAYuQczHEHfthZeWLR0Nld+mrVTxZ
         +9dWL+Vn5v8E4pBCcKXcmRdNfkln8Dycfdu6ib76K8yO27yfeZVCqD1kFtV+CUf5pmqW
         wOIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686562382; x=1689154382;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wsfv8tU8typbArcFFZ3RmodVuhSCsV+o3+M2ATwIwoQ=;
        b=fOlPl9/Qs/BeWIjdXMf7EkKXOjs/l+cpZ0QDZu2U6xBawdVmJgm7QzR68SFzVtcMrR
         8PbBUigg1rhwi2HJAgfJzNmFxwRbFWOyKVE8trIfM4/E+ZoFXKyp6dgc+WVeTZIgD1cb
         ojDI4rSfS0NZ12Us/+2sZjyj1oQka8YcclXlp782sQRANknDayTW+0+wjYLvqFJB0xOp
         UU0CW7Uf+yN8XTwQGU1zcdgUAHSVXXSisW8oWQcF+0tXdp92+bm7X8kf4deL4I6UZbAp
         uN8oVw+QhxXlfyD+Rb6Af0l8MRjVT+4OMiJ6bvPYpPChzZ+3hR8wiFoBMIfqlEs4/rwM
         4wYA==
X-Gm-Message-State: AC+VfDxXbaECy+Qe7zLvq44ekTYCfVYYBBdtEVTX9dmgqWIPxWZTjQWw
        H38MZoC4cLqzSS7f6LNS3onh8A==
X-Google-Smtp-Source: ACHHUZ4FRCeN8jvFzEJ3tb+8GoTw8KH3QdvMi+2BF4JcQt89B9Ozs9bBPixR/raWCid1tZtHQT9T4Q==
X-Received: by 2002:a17:906:4796:b0:973:fd02:a41f with SMTP id cw22-20020a170906479600b00973fd02a41fmr10476799ejc.40.1686562382087;
        Mon, 12 Jun 2023 02:33:02 -0700 (PDT)
Received: from hackbox.lan ([86.121.163.20])
        by smtp.gmail.com with ESMTPSA id gj13-20020a170906e10d00b00965a56f82absm4908151ejb.212.2023.06.12.02.33.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 02:33:01 -0700 (PDT)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     linux-clk@vger.kernel.org, Adam Ford <aford173@gmail.com>
Cc:     aford@beaconembedded.com, Abel Vesa <abelvesa@kernel.org>,
        Peng Fan <peng.fan@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: imx: composite-8m: Add imx8m_divider_determine_rate
Date:   Mon, 12 Jun 2023 12:32:35 +0300
Message-Id: <168656228135.662397.14806433100721864469.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230506195325.876871-1-aford173@gmail.com>
References: <20230506195325.876871-1-aford173@gmail.com>
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


On Sat, 06 May 2023 14:53:25 -0500, Adam Ford wrote:
> Currently, certain clocks are derrived as a divider from their
> parent clock.  For some clocks, even when CLK_SET_RATE_PARENT
> is set, the parent clock is not properly set which can lead
> to some relatively inaccurate clock values.
> 
> Unlike imx/clk-composite-93 and imx/clk-divider-gate, it
> cannot rely on calling a standard determine_rate function,
> because the 8m composite clocks have a pre-divider and
> post-divider. Because of this, a custom determine_rate
> function is necessary to determine the maximum clock
> division which is equivalent to pre-divider * the
> post-divider.
> 
> [...]

Applied, thanks!

[1/1] clk: imx: composite-8m: Add imx8m_divider_determine_rate
      commit: 8208181fe536bba3b411508f81c4426fc9c71d9a

Best regards,
-- 
Abel Vesa <abel.vesa@linaro.org>
