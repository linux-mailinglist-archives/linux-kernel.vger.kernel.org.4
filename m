Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 863D773FFA2
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 17:27:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232362AbjF0P1w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 11:27:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232354AbjF0P1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 11:27:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 685842976;
        Tue, 27 Jun 2023 08:27:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D4353611D6;
        Tue, 27 Jun 2023 15:27:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CF45C433C8;
        Tue, 27 Jun 2023 15:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687879655;
        bh=QJEP2hAFIWiHYLlxATb8rBMxuDVIppvzTaGsfqkN9pI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o8TxVYYJLovhn1bYP0bppqdQn35EJcczSduqWL6V4NiEenm/hQ8kIh3AiOkKfIyE9
         ZcFiowMHLIhaiWWlDrknRk7hpxGIU4PDsMNbBdlTvvn+HMpL+EM9QBbfuucUWqA6xA
         nN62mouD8cp6b3EHgFVpuXPOBAddLd8REsd9aY+Y4EmIMbMFeGfWqNcEimf86GBdST
         S6Mgo/yXbYesJv9jT2LYGohrHMpl9JP5jpUQM1zFCP9idUSDZG0twMt81IJ6yoxkr/
         ITGiOU6M7xAeO8VYhBQ/Im1F5M1NwewE1skeamSeqWILVyw6A0aTGI15mn9Llkg82H
         rJ0F1lT0DQagw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1qEAbM-00049C-FM; Tue, 27 Jun 2023 17:27:33 +0200
Date:   Tue, 27 Jun 2023 17:27:32 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Patrick Wildt <patrick@blueri.se>
Subject: Re: [PATCH] arm64: dts: qcom: sc8280xp-pmics: add explicit rtc
 interrupt parent
Message-ID: <ZJr_5JIqWSGq-E-T@hovoldconsulting.com>
References: <20230627085306.6033-1-johan+linaro@kernel.org>
 <20230627132406.GA5490@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230627132406.GA5490@thinkpad>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27, 2023 at 06:54:06PM +0530, Manivannan Sadhasivam wrote:
> On Tue, Jun 27, 2023 at 10:53:06AM +0200, Johan Hovold wrote:
> > Unless explicitly specified the interrupt-parent property is inherited
> > from the parent node on Linux even though this may not be in full
> > compliance with the devicetree specification.
> > 
> > Following commit 2d5cab9232ba ("arm64: dts: qcom: sc8280xp-pmics:
> > Specify interrupt parent explicitly"), add an explicit interrupt parent
> > also for the PMIC RTC node for the benefit of other operating systems
> > which may be confused by this omission.
> > 
> > Note that any such OS must still implement a fallback to the root
> > interrupt domain as most devicetrees are written under the assumption
> > that the interrupt parent is inherited.
> > 
> > Reported-by: Patrick Wildt <patrick@blueri.se>
> > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> 
> It is good to encode this in the binding and fix other such instances.

Not sure about that. Perhaps the spec should be updated to match reality
instead... We have many more instances like this, even for this very
SoC, but apparently OpenBSD or whatever OS needs this falls back to the
root domain then.

Changing this for the rtc node for consistency after you changed the
others is a no-brainer, but not sure about trying to do this tree-wide.
We already have too many of these one-line DT cleanups...

Johan
