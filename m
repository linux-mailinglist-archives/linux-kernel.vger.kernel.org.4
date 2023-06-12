Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8B1A72BD08
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 11:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233860AbjFLJt0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 05:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230408AbjFLJsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 05:48:31 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64EAB30DD
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 02:34:50 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-5183101690cso3110336a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 02:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686562405; x=1689154405;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FtoVIAYvvaeJCmzX3NdwvnzpTltebMwdZEZnlmKhDLQ=;
        b=wdB5yrjrAs3jXnvkq4geD39hwuQE7x052nP4+T90RSSxrtqz8SvhypaMhV43pqDOU9
         4JjfufjNGjSBpG22gBTRdm9u8PRCBSLOBFgbiKvg8cIjYT8KKUMx0f1HzpSvkMBTeeNg
         +EEWF8QrVUIHz8MD8qmZa4v2YUhymK4IuJXiYSjsEEocta+bM5Kke8wX/9S5ETOYg5Rh
         FOYMNSH3koOTvSWW+bJMgDjmW+FdVYmxvyYsaQcbiZLon2ytryAy4DfBb5XRbO9ygIOS
         r3cDulPWDJxu/dvQFy9/KIGQDztK9AUHfjS5YKaXp0y7q+9LHX/KZuPnWAO/Ts28puZI
         O5+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686562405; x=1689154405;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FtoVIAYvvaeJCmzX3NdwvnzpTltebMwdZEZnlmKhDLQ=;
        b=HwR4QEX5TzdFXBvWOt+ugPoK4WELH3mqieA+zb7nXSxgf8JZQ0v/p7hzUZ8JXvPqxN
         Sk00tftP+3jGuSMZmaSKrVeJy3/POoFJAoamRcnPXTsI/aCqJiZq3qfbQzThWTbLEwd4
         LAdJvFLEJL61RkdVUMDTH5Ra6zIubyTFvQYHrNmpdBgLaHJrDQqXGPhWbXZ7IjCP+sm6
         2AsQROQGDKYjUy2vI2ZhGKoqKMXwQVu74mY5AJPUus1ua39LZIPydoHVojasO1mz1KnQ
         oRU6Edt6PYYzU/6CWFTwu9jrhiqn6ah140dkZImRFzFWDALAXmSFJpbJuL9I0Z0SUJkd
         w+uw==
X-Gm-Message-State: AC+VfDzzyspdVrSQZkc4eqvyof409L0yB7IZLoCLWOFgJTwtj0d0lJ2a
        NhciPtHWRrt18Kx+y/9MpGMTkQ==
X-Google-Smtp-Source: ACHHUZ6lI2jsO4Sm/86nevBsOTQv1TSTrEMT4rYq4dBh62a/5xR7uH8uhY9mKOjHGynVFTFxfsAgKQ==
X-Received: by 2002:a17:907:969e:b0:968:892b:1902 with SMTP id hd30-20020a170907969e00b00968892b1902mr8936027ejc.6.1686562405173;
        Mon, 12 Jun 2023 02:33:25 -0700 (PDT)
Received: from hackbox.lan ([86.121.163.20])
        by smtp.gmail.com with ESMTPSA id gj13-20020a170906e10d00b00965a56f82absm4908151ejb.212.2023.06.12.02.33.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 02:33:24 -0700 (PDT)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Yuxing Liu <lyx2022@hust.edu.cn>
Cc:     hust-os-kernel-patches@googlegroups.com,
        Dongliang Mu <dzm91@hust.edu.cn>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: imx: clk-imx8mp: improve error handling in imx8mp_clocks_probe()
Date:   Mon, 12 Jun 2023 12:32:38 +0300
Message-Id: <168656228140.662397.3944524571382952191.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230503070607.2462-1-lyx2022@hust.edu.cn>
References: <20230503070607.2462-1-lyx2022@hust.edu.cn>
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


On Wed, 03 May 2023 07:06:07 +0000, Yuxing Liu wrote:
> Replace of_iomap() and kzalloc() with devm_of_iomap() and devm_kzalloc()
> which can automatically release the related memory when the device
> or driver is removed or unloaded to avoid potential memory leak.
> 
> In this case, iounmap(anatop_base) in line 427,433 are removed
> as manual release is not required.
> 
> [...]

Applied, thanks!

[1/1] clk: imx: clk-imx8mp: improve error handling in imx8mp_clocks_probe()
      commit: 878b02d5f3b56cb090dbe2c70c89273be144087f

Best regards,
-- 
Abel Vesa <abel.vesa@linaro.org>
