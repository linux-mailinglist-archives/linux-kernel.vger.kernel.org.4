Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3C376104E7
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 23:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237029AbiJ0V5V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 17:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236639AbiJ0V5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 17:57:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18E63915DC;
        Thu, 27 Oct 2022 14:57:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CA767B826AC;
        Thu, 27 Oct 2022 21:57:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77250C433D6;
        Thu, 27 Oct 2022 21:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666907836;
        bh=pMcZ3lkUN+LKNn4Gtp1ga/opwaCEMemcT9ZPw3DrnXs=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Avu+f+kbJ2KSLy0gElbOxcWnteIUIwNVcCxLq9JRw2j2mfAgaYdRKwMaB607eGxQu
         3Oz/7rKtot3X9iC0lMjPysHWSgdZy+2Dh2OXhzO3YFd00SkuCmp7QVL5MG4F64eNiD
         mmZerD7i65IeXCKqYrU5Pj3YSUJrMHcJmPDms6qqjs6TSMzx9z0RNwy1TXAaLw0Ojp
         7CIOTAi3rqMDPFWg+jJWnfynRNDWBMyeuyBhT5eWXDL1Jc0Ntby1ZGVeXgPiRzDbUG
         5DQfazsJTKaDInpnjybshajEvyzhzcvJkCh2qiFaif9yOPqTBeal8pR63FGpmWJF79
         H7Ug50hGjllcg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20221027192024.484320-4-lis8215@gmail.com>
References: <20221027192024.484320-1-lis8215@gmail.com> <20221027192024.484320-4-lis8215@gmail.com>
Subject: Re: [PATCH v6 3/3] clk: Add Ingenic JZ4755 CGU driver
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Siarhei Volkau <lis8215@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org
To:     Siarhei Volkau <lis8215@gmail.com>
Date:   Thu, 27 Oct 2022 14:57:14 -0700
User-Agent: alot/0.10
Message-Id: <20221027215716.77250C433D6@smtp.kernel.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Siarhei Volkau (2022-10-27 12:20:23)
> diff --git a/drivers/clk/ingenic/jz4755-cgu.c b/drivers/clk/ingenic/jz475=
5-cgu.c
> new file mode 100644
> index 000000000..d2eb3ae0c
> --- /dev/null
> +++ b/drivers/clk/ingenic/jz4755-cgu.c
> @@ -0,0 +1,346 @@
[...]
> +static void __init jz4755_cgu_init(struct device_node *np)
> +{
> +       int retval;
> +
> +       cgu =3D ingenic_cgu_new(jz4755_cgu_clocks,
> +                             ARRAY_SIZE(jz4755_cgu_clocks), np);
> +       if (!cgu) {
> +               pr_err("%s: failed to initialise CGU\n", __func__);
> +               return;
> +       }
> +
> +       retval =3D ingenic_cgu_register_clocks(cgu);
> +       if (retval)
> +               pr_err("%s: failed to register CGU Clocks\n", __func__);
> +
> +       ingenic_cgu_register_syscore_ops(cgu);
> +}
> +CLK_OF_DECLARE_DRIVER(jz4755_cgu, "ingenic,jz4755-cgu", jz4755_cgu_init);

Is there another driver that probes this device? CLK_OF_DECLARE_DRIVER()
is for the situation where we want to probe this device again with
another platform driver. Please add a comment indicating what that other
driver is.
