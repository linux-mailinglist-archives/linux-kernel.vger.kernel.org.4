Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3E39657587
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 11:58:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232675AbiL1K6t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 05:58:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiL1K6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 05:58:46 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBE1321A4;
        Wed, 28 Dec 2022 02:58:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5B05B6146B;
        Wed, 28 Dec 2022 10:58:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFA36C433EF;
        Wed, 28 Dec 2022 10:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672225124;
        bh=T0C4xkF9Fh07C/j92Rbl0JH6oQ5sn/u8/fIOu7dNH9g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ik/sVIcZOGwffEkYYPkdyX5AR0xgMAgixZGNT7rzznszonHRtBB1kt+w3jO5dHDAs
         x0WQ0zb+RnJLMsgHd80EbVX6aopWrnOKSQKj85qu0nBBUXK2LVzISgWD8bBcKowsvB
         4u9VvwAU1bRuiJSRceMPMVbv8Z/A6T6ztD7j7RuHe4Ee8l1pXhyKkj9vLmLqwMIRWK
         z3RlnweiHie8Cgt2VSMKDDqcz/Bh39aeba/jNnKwWzWA9gJesLrBq86/h7fqo/cbL7
         TJl0xglyKd2DpdalgAOztM89RAp28JZ0FwNXIFTO8OOG15E4pnf8P+9zrDUJl7CYpA
         ngnRLX5p7NEdw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pAU91-00064B-5M; Wed, 28 Dec 2022 11:58:47 +0100
Date:   Wed, 28 Dec 2022 11:58:47 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andrew Halaney <ahalaney@redhat.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@somainline.org,
        lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        dianders@chromium.org, Johan Hovold <johan+kernel@kernel.org>
Subject: Re: [PATCH v3] regulator: dt-bindings: qcom,rpmh: Indicate
 regulator-allow-set-load dependencies
Message-ID: <Y6whZ50Lz07xG/R1@hovoldconsulting.com>
References: <20220907204924.173030-1-ahalaney@redhat.com>
 <14b0237d-6511-4a1f-3bda-e0e72b442a56@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14b0237d-6511-4a1f-3bda-e0e72b442a56@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 28, 2022 at 11:37:06AM +0100, Krzysztof Kozlowski wrote:
> On 07/09/2022 22:49, Andrew Halaney wrote:
> > For RPMH regulators it doesn't make sense to indicate
> > regulator-allow-set-load without saying what modes you can switch to,
> > so be sure to indicate a dependency on regulator-allowed-modes.
> > 
> > In general this is true for any regulators that are setting modes
> > instead of setting a load directly, for example RPMH regulators. A
> > counter example would be RPM based regulators, which set a load
> > change directly instead of a mode change. In the RPM case
> > regulator-allow-set-load alone is sufficient to describe the regulator
> > (the regulator can change its output current, here's the new load),
> > but in the RPMH case what valid operating modes exist must also be
> > stated to properly describe the regulator (the new load is this, what
> > is the optimum mode for this regulator with that load, let's change to
> > that mode now).
> > 
> > With this in place devicetree validation can catch issues like this:
> > 
> >     /mnt/extrassd/git/linux-next/arch/arm64/boot/dts/qcom/sm8350-hdk.dtb: pm8350-rpmh-regulators: ldo5: 'regulator-allowed-modes' is a dependency of 'regulator-allow-set-load'
> >             From schema: /mnt/extrassd/git/linux-next/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml
> 
> Andrew,
> 
> This patch was merged therefore we started seeing such warnings. Any
> plans to actually fix them?

Didn't Doug already do that?

	https://lore.kernel.org/all/20220829164952.2672848-1-dianders@chromium.org/

Johan
