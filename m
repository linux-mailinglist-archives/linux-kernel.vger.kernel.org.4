Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3D067C2DD
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 03:35:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234613AbjAZCfV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 21:35:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjAZCfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 21:35:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D39BF611EF;
        Wed, 25 Jan 2023 18:35:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 60AB6616FD;
        Thu, 26 Jan 2023 02:35:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0317C433EF;
        Thu, 26 Jan 2023 02:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674700517;
        bh=DkPTy3Ua5+WLPbmmRUi4CQa8iXqKdBmFuS11vog8WMg=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=IU6M6kNTG/ygSSnW6SkBbKWWrKHCjuZrhGbDVcT9wk8cWJNdjqjn78H5FgU62kFqe
         +csMUpY1zjOQ/rBGWJfwxhxiTfdi+dudaa3BBADmu8ZniQRzAYGrzemG03K5VtjJRr
         z9rFvFPdsp9ufwsj4VPOwbq6FaZH3ESrB8uUkQIjoThegt9yfBf1gTqSIQkuMGIcHb
         6pXXQLrCTuCgv2Si128Gm2xvXIN8hu/3raBE0N41MuDSHiFnhpO2YkgjNpGowso0MG
         uo472P7CFQz3NmjBj7UUa9Zv5Xx3HWBiAPEk4PshIdv/PYjNgIl7dJlbhSht9LT5w3
         tBMzf2b7vL4Xw==
Message-ID: <eb37200702b27d239b2689daefc85ffa.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230120024445.244345-7-xingyu.wu@starfivetech.com>
References: <20230120024445.244345-1-xingyu.wu@starfivetech.com> <20230120024445.244345-7-xingyu.wu@starfivetech.com>
Subject: Re: [PATCH v1 06/11] clk: starfive: Add StarFive JH7110 Image-Signal-Process clock driver
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Conor Dooley <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Hal Feng <hal.feng@starfivetech.com>,
        Xingyu Wu <xingyu.wu@starfivetech.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
To:     Emil Renner Berthing <kernel@esmil.dk>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Xingyu Wu <xingyu.wu@starfivetech.com>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org
Date:   Wed, 25 Jan 2023 18:35:15 -0800
User-Agent: alot/0.10
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Xingyu Wu (2023-01-19 18:44:40)
> diff --git a/drivers/clk/starfive/clk-starfive-jh7110-isp.c b/drivers/clk=
/starfive/clk-starfive-jh7110-isp.c
> new file mode 100644
> index 000000000000..f9fc94b4c6f8
> --- /dev/null
> +++ b/drivers/clk/starfive/clk-starfive-jh7110-isp.c
> @@ -0,0 +1,218 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * StarFive JH7110 Image-Signal-Process Clock Driver
> + *
> + * Copyright (C) 2022 StarFive Technology Co., Ltd.
> + */
> +
> +#include <linux/clk.h>

Same include comment. This signals this is a clk consumer, which it
isn't?
