Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C1B26C3E39
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 00:03:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbjCUXDF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 19:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjCUXDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 19:03:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA48A868A;
        Tue, 21 Mar 2023 16:03:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 76497B819B4;
        Tue, 21 Mar 2023 23:03:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C06BC433D2;
        Tue, 21 Mar 2023 23:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679439780;
        bh=hF+7oizPUp8RWtNGYoQedMsKxaf5/loQxwgRprc63SU=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=b4tYJlmQYIPbhEYbnIwAV3lE1loXMpQO/bG1b435klX7pXKMSIPv8EteQ9NnWq7wt
         YwvWNPSK34vEUk4o+bZHwvNL6o8aydRf6IMtXNlRgs9l+uKJtWmWOwygB41ib9rVJd
         C0aGZe9uywhzBbLpU3NyYV0aKQozul2pwThyhTAaXLFw5bibPGZrBLsloyY32RH0UC
         Qq4l51zZXaAEkbaBBFY8/3EYEwns3YVvx7DaOAoR1BftSLIgsEfDQAWuXmu7bWlOIT
         L4qfRb2SrwpP8pDtq1LlPc4q9y4IXCtk5IadzOXI560KLVfNawz9pWOgleLZzYq6jV
         T7fr+NE1eaXSA==
Message-ID: <7cf6f6063943a57c1ef6bc45ea4d2cca.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230321200031.1812026-4-mmyangfl@gmail.com>
References: <20230321200031.1812026-1-mmyangfl@gmail.com> <20230321200031.1812026-4-mmyangfl@gmail.com>
Subject: Re: [PATCH v6 3/6] clk: hisilicon: Migrate devm APIs
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     David Yang <mmyangfl@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
To:     David Yang <mmyangfl@gmail.com>
Date:   Tue, 21 Mar 2023 16:02:57 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting David Yang (2023-03-21 13:00:24)
> diff --git a/drivers/clk/hisilicon/clk-hi3620.c b/drivers/clk/hisilicon/c=
lk-hi3620.c
> index a3d04c7c3..d6307a8cd 100644
> --- a/drivers/clk/hisilicon/clk-hi3620.c
> +++ b/drivers/clk/hisilicon/clk-hi3620.c
> @@ -194,23 +194,25 @@ static struct hisi_gate_clock hi3620_separated_gate=
_clks[] __initdata =3D {
> =20
>  static void __init hi3620_clk_init(struct device_node *np)
>  {
> +       struct platform_device *pdev =3D of_find_device_by_node(np);

This looks costly and sometimes incorrect. The use of devm_ APIs means
that a driver is bound to the device. When the driver is unbound the
devm APIs cleanup and remove resources allocated. If you're simply
finding the device associated with a device node you can't tell if the
device is bound to a driver or not. So you should stop passing a
device_node pointer to these functions and switch them to a struct
device, or keep the device_node because you don't have a struct device
that's bound to a driver in the caller, in which case you can't use devm
APIs.
