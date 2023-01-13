Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EC0F6689E5
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 04:04:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239769AbjAMDEe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 22:04:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231822AbjAMDEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 22:04:31 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA6EA102D;
        Thu, 12 Jan 2023 19:04:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 61C14621F9;
        Fri, 13 Jan 2023 03:04:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3329C433EF;
        Fri, 13 Jan 2023 03:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673579069;
        bh=2FqrReueY7f1vbj8dUug6omLgxcQFYoVcKvt8e3fbb4=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=hlfdA753RrtMcdO882nT4gQBOQAm753StRI4TJLuMj6FRC/J/6LNZytMu8B0WpmK4
         /sxPcf6A66BrSU9VnbVfpwbXnaGUWqk/0qvLlAneD8KQN3sKAxXsCXNbq0WtrcOHRC
         KhQEhjZjR9dhDNog0r0qzReMKopsiP97WBCoVVZKT+P3ElreMNpk3pMDjeKoIRQIYM
         8zAum4U/Ydw8Fey+C8w03IP2X/zxZ13zpJvnsCm0KkmNsVNcCIlnuGYRQs5ZZz3Xdv
         h32XnzatjpsehbsvfCKp4hclwWLfDIPJs+RCI0TyJEeoN5CEJmrN8ZvUoP971nvQ6S
         Aay29zX7xyHug==
Message-ID: <64fa5fec507f422a7046d267ca17d73f.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230111191453.2509468-5-dmitry.baryshkov@linaro.org>
References: <20230111191453.2509468-1-dmitry.baryshkov@linaro.org> <20230111191453.2509468-5-dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH 4/4] clk: qcom: add the driver for the MSM8996 APCS clocks
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>
Date:   Thu, 12 Jan 2023 19:04:27 -0800
User-Agent: alot/0.10
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Dmitry Baryshkov (2023-01-11 11:14:53)
> diff --git a/drivers/clk/qcom/apcs-msm8996.c b/drivers/clk/qcom/apcs-msm8=
996.c
> new file mode 100644
> index 000000000000..2e9959974ed9
> --- /dev/null
> +++ b/drivers/clk/qcom/apcs-msm8996.c
> @@ -0,0 +1,77 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Qualcomm APCS clock controller driver
> + *
> + * Copyright (c) 2022, Linaro Limited
> + * Author: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> + */
> +
> +#include <linux/bits.h>
> +#include <linux/clk.h>

Remove this include please. It indicates that this is a clk consumer,
when this driver is only a clk provider.

> +#include <linux/clk-provider.h>
> +#include <linux/delay.h>
> +#include <linux/module.h>
