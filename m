Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B8D4725D7D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 13:44:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240399AbjFGLoK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 07:44:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234932AbjFGLoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 07:44:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A34419BD;
        Wed,  7 Jun 2023 04:44:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9F35B63DEC;
        Wed,  7 Jun 2023 11:44:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E24B6C4339B;
        Wed,  7 Jun 2023 11:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686138247;
        bh=MwyhiYcJENevj1dluDqPre/wvn9RYsMbpU1n3B8UBGc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XP5fEfMWhR1k6iKYyVbghg7Zpf0snzMJyW2y9bOGK3IxsQ5pf82vV4ZhdQCoV9604
         CW25JEqmDKX69xEOQDDVte4q8yZeGdJ9tGVPh5z2Ufa0B0mP/OeLHEwmfLDpv2O2e/
         +7z64XYje57uCu3pJ/t0E0jutzfBuqx/GYjHgQO8JqXff3p/LE9OKS6O0FlPubA7Fp
         a150cXzUyFoo+zxAQaqLuwbZElgTfJ72pXnKMQs0YT60BFpBQ8R5fxY5jLM8uXw71X
         6IxHLMjGc+JN0Z0b2zcOf7ms1vYhFf1RQhTok5XNwOpiIjS1ARgRiYuA6vwowFrzmY
         TR+KUDe32WlVA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1q6raW-0008Uw-VQ; Wed, 07 Jun 2023 13:44:29 +0200
Date:   Wed, 7 Jun 2023 13:44:28 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, quic_pkondeti@quicinc.com,
        quic_ppratap@quicinc.com, quic_wcheng@quicinc.com,
        quic_jackp@quicinc.com, quic_harshq@quicinc.com,
        ahalaney@redhat.com
Subject: Re: [PATCH v8 6/9] usb: dwc3: qcom: Add multiport controller support
 for qcom wrapper
Message-ID: <ZIBtnPp0oV6_GFFk@hovoldconsulting.com>
References: <20230514054917.21318-1-quic_kriskura@quicinc.com>
 <20230514054917.21318-7-quic_kriskura@quicinc.com>
 <20230515222730.7snn2i33gkg6ctd2@ripper>
 <20230526025554.ni527gsr2bqxadl3@ripper>
 <37fd026e-ecb1-3584-19f3-f8c1e5a9d20a@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37fd026e-ecb1-3584-19f3-f8c1e5a9d20a@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 26, 2023 at 08:55:22PM +0530, Krishna Kurapati PSSNV wrote:
> On 5/26/2023 8:25 AM, Bjorn Andersson wrote:

> > We need to fix the dwc3 glue design, so that the glue and the core can
> > cooperate - and we have a few other use cases where this is needed (e.g.
> > usb_role_switch propagation to the glue code).

>    Thanks for the comments on this patch. I had some suggestions come in 
> from the team internally:
> 
> 1. To use the notifier call available in drivers/usb/core/notify.c and 
> make sure that host mode is enabled. That way we can access dwc or xhci 
> without any issue.

I don't think this is a good idea and instead the callbacks should be
dedicated for the xhci and dwc3 drivers. A struct with callbacks can be
passed down to the child devices, which call back into the drivers of
their parents for notifications and when they need services from them
(e.g. during suspend or on role changes).

> 2. For this particular case where we are trying to get info on number of 
> ports present (dwc->num_usb2_ports), we can add compatible data for 
> sc8280-mp and provide input to driver telling num ports is 4.

That may also work as a way to avoid parsing the xhci registers, but I'm
still not sure why simply counting the PHYs in DT would not work.

Johan
