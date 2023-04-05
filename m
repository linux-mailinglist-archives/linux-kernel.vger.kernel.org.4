Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E458A6D81F2
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 17:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238895AbjDEPbZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 11:31:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238792AbjDEPbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 11:31:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E2D861A7;
        Wed,  5 Apr 2023 08:31:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B767262683;
        Wed,  5 Apr 2023 15:31:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A24FCC433EF;
        Wed,  5 Apr 2023 15:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680708665;
        bh=80OFxTucSgBKv9VMdpqjm/H8GCwtE82hTyDcQYuU5os=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XyhYaDFiA02tJMCxgk9o5n0ao96IWcba7wgfk89ejmAdF+z4rHOG5hjscaZBQnYbt
         9cgIM9A1xwnJQljcTzqCyW+esq9wqeX+yyYVap5lfY+tt8MCo+AzzY9MVUJM7NFhav
         5XWRmSzbgJ2VIBE3mhj9t2q9tI9lT6rHCzB0yDGsquE5NjTTfAS3o2hmI25RI2OAwW
         wT3mrARcMNIiBDcU3Mb7R9d2bex5Z7bs0b6lmDj/BGRBKHjEGc1p1OIWfcN71GPP4L
         2H0B3S5KyzdlxMNwqn3BsY6rbnRsgSmffWHXcerCHYvtWtla+YiN0mQzRj78xvtdBL
         BZoTi1/x+feow==
Date:   Wed, 5 Apr 2023 16:30:59 +0100
From:   Lee Jones <lee@kernel.org>
To:     Benjamin Bara <bbara93@gmail.com>
Cc:     Support Opensource <support.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Steve Twiss <stwiss.opensource@diasemi.com>,
        DLG-Adam.Thomson.Opensource@dm.renesas.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Benjamin Bara <benjamin.bara@skidata.com>
Subject: Re: [PATCH v2 0/3] regulator: da9063: disable unused voltage monitors
Message-ID: <20230405153059.GR8371@google.com>
References: <20230403-da9063-disable-unused-v2-0-2f1bd2a2434a@skidata.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230403-da9063-disable-unused-v2-0-2f1bd2a2434a@skidata.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 05 Apr 2023, Benjamin Bara wrote:

> Hi!
>
> Follow-up for my last patch regarding the disabling of unrequired
> voltage monitors. We use the PWR_OK functionality, which asserts GP_FB2
> if every monitored voltage is in range. This patch should provide the
> possibility to deactivate a voltage monitor from the DT if the regulator
> might be disabled during run time. For this purpose, the regulator
> notification support is used:
> https://lore.kernel.org/all/cover.1622628333.git.matti.vaittinen@fi.rohmeurope.com/
>
> v1: https://lore.kernel.org/all/20220713124958.3094505-1-bbara93@gmail.com/
>
> v2:
> - reworked solution, based on Adam Thomson's feedback
>
> ---
> Benjamin Bara (3):
>       regulator: da9063: add voltage monitoring registers
>       regulator: da9063: implement basic XVP setter
>       dt-bindings: mfd: dlg,da9063: document XVP
>
>  .../devicetree/bindings/mfd/dlg,da9063.yaml        |  16 ++-
>  drivers/regulator/da9063-regulator.c               | 129 ++++++++++++++++-----
>  include/linux/mfd/da9063/registers.h               |  23 ++++
>  3 files changed, 138 insertions(+), 30 deletions(-)

I'll handle this set once Mark is happy.

> ---
> base-commit: 7e364e56293bb98cae1b55fd835f5991c4e96e7d
> change-id: 20230403-da9063-disable-unused-15836e2f4539
>
> Best regards,
> --
> Benjamin Bara <benjamin.bara@skidata.com>
>

--
Lee Jones [李琼斯]
