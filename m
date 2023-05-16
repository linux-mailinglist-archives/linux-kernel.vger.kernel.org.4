Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3A80704D9B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 14:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233206AbjEPMRe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 08:17:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231888AbjEPMRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 08:17:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6438D4698;
        Tue, 16 May 2023 05:17:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EAA5460F5A;
        Tue, 16 May 2023 12:17:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BE48C433EF;
        Tue, 16 May 2023 12:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684239451;
        bh=FUya8l0e9W9RYjyU+HM+cs83+DOnaPciCuvV7VzRtTY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PC2dFqdc1Z/sdXZ5oYa4dBdtDdnVirjaldQ/c52s9XJSgc+dL6PzDhDqFcp2t3h8s
         zYfoMkYN/25F07KizBYjudULLyvUqwGH4yudmVo1ypcJJouV1/5+Mg4MeS5B8lMkD0
         hQFQoQIq+YgyjIykKOhLxfIocaQC41WOqBWGXbhiVLWe6fe28VCP3WdVWmpSQCjDGZ
         4aUtJ+q5C2ZDupcuSwaDldLY/u4MQlQ0TzGZBRKjwKENXZiV02g38rH23LqSunEk2C
         ZcPR/87t5GlnvCLL0uv1alI+o744JmEyXHD56IECx3oXhz5KtTzRNFnXlUcJFOS1/L
         +dh0MXsyQXSYg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pytcR-0008TQ-5q; Tue, 16 May 2023 14:17:31 +0200
Date:   Tue, 16 May 2023 14:17:31 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Krishna Kurapati <quic_kriskura@quicinc.com>
Cc:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, quic_pkondeti@quicinc.com,
        quic_ppratap@quicinc.com, quic_wcheng@quicinc.com,
        quic_jackp@quicinc.com, quic_harshq@quicinc.com,
        ahalaney@redhat.com
Subject: Re: [PATCH v8 4/9] usb: dwc3: core: Skip setting event buffers for
 host only controllers
Message-ID: <ZGN0W0YbIjzmQnH1@hovoldconsulting.com>
References: <20230514054917.21318-1-quic_kriskura@quicinc.com>
 <20230514054917.21318-5-quic_kriskura@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230514054917.21318-5-quic_kriskura@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 14, 2023 at 11:19:12AM +0530, Krishna Kurapati wrote:
> On some SoC's like SA8295P where the tertiary controller is host-only
> capable, GEVTADDRHI/LO, GEVTSIZ, GEVTCOUNT registers are not accessible.
> Trying to setup them up during core_init leads to a crash.
> 
> For DRD/Peripheral supported controllers, event buffer setup is done
> again in gadget_pullup. Skip setup or cleanup of event buffers if
> controller is host-only capable.
> 
> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> ---
>  drivers/usb/dwc3/core.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index e983aef1fb93..46192d08d1b6 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -505,6 +505,11 @@ static int dwc3_alloc_event_buffers(struct dwc3 *dwc, unsigned int length)
>  int dwc3_event_buffers_setup(struct dwc3 *dwc)
>  {
>  	struct dwc3_event_buffer	*evt;
> +	unsigned int			hw_mode;
> +
> +	hw_mode = DWC3_GHWPARAMS0_MODE(dwc->hwparams.hwparams0);
> +	if (hw_mode == DWC3_GHWPARAMS0_MODE_HOST)
> +		return 0;
>  
>  	evt = dwc->ev_buf;

How about adding this check to dwc3_alloc_event_buffers() instead as
there should be no need to allocate buffer that you never use?

Then you can just check dwc->ev_buf here and elsewhere.

Johan
