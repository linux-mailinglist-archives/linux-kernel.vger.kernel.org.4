Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 058F15EEA71
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 02:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232511AbiI2AOV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 20:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbiI2AOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 20:14:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8010118B32;
        Wed, 28 Sep 2022 17:14:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1C62B61378;
        Thu, 29 Sep 2022 00:14:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F090C433D6;
        Thu, 29 Sep 2022 00:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664410456;
        bh=pFrDc82PUcu6ZPY8HSHIRNq0ZZmlZK5rdqcHF9KCIRs=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=HXUQwLN6HSTkS2OPDf2SSMwcH0BG9EdoLN3Qje470oR3ZIqWh9uyQo5a3pB6M8+A+
         XyAZB3qu/5dpNDciATDM40sFmETyKRGOJvIePmZKrGaBEMJAn/h/ydELUjqY7SDSgH
         64yp2Iw0eTiFCB97RIR6v++d1gmCLh3eFCESgP4r25Pr3RdxhWQ28hSbRa3dts2Mij
         LG/70fQ+d6LJqVeGDYEsXzA/0Jrotl3nhOnm77yIkOS+s4iIZ+qCnFb0p4/Zo7Hc9F
         AjNgB3wGTtwsvlECbKM2Ro9bQ9TlBVRCCkUqg9leQiEL+ZYoHiqpa9nV6EfXBeD7Nr
         GBEg191PsdhqA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <4c56443ecd9041f102681ebf36b6854090ab82e3.1663827071.git.rtanwar@maxlinear.com>
References: <cover.1663827071.git.rtanwar@maxlinear.com> <4c56443ecd9041f102681ebf36b6854090ab82e3.1663827071.git.rtanwar@maxlinear.com>
Subject: Re: [PATCH RESEND v2 1/5] clk: mxl: Switch from direct readl/writel based IO to regmap based IO
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-lgm-soc@maxlinear.com,
        Rahul Tanwar <rtanwar@maxlinear.com>
To:     Rahul Tanwar <rtanwar@maxlinear.com>, linux-clk@vger.kernel.org,
        mturquette@baylibre.com
Date:   Wed, 28 Sep 2022 17:14:13 -0700
User-Agent: alot/0.10
Message-Id: <20220929001416.6F090C433D6@smtp.kernel.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rahul Tanwar (2022-09-21 23:24:24)
> diff --git a/drivers/clk/x86/clk-cgu-pll.c b/drivers/clk/x86/clk-cgu-pll.c
> index 3179557b5f78..c83083affe88 100644
> --- a/drivers/clk/x86/clk-cgu-pll.c
> +++ b/drivers/clk/x86/clk-cgu-pll.c
> @@ -1,8 +1,9 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /*
> + * Copyright (C) 2020-2022 MaxLinear, Inc.
>   * Copyright (C) 2020 Intel Corporation.
> - * Zhu YiXin <yixin.zhu@intel.com>
> - * Rahul Tanwar <rahul.tanwar@intel.com>
> + * Zhu Yixin <yzhu@maxlinear.com>

Does Zhu Yixin approve? They're not Cced on this patch.

> + * Rahul Tanwar <rtanwar@maxlinear.com>
>   */
> =20
>  #include <linux/clk-provider.h>
