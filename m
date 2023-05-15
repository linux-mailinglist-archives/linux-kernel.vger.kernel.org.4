Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91E79703F74
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 23:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245467AbjEOVPk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 17:15:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245308AbjEOVPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 17:15:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50AD8A27C;
        Mon, 15 May 2023 14:15:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D96A6621BA;
        Mon, 15 May 2023 21:15:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F193FC433EF;
        Mon, 15 May 2023 21:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684185336;
        bh=enJwNWaLT/meCbucP4lqULVPUm7Z2anbwiRCF5jSvnM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H3zjzNo6kWA6B9UFM9EqS17kkmQTU5sYbi9N6m1jY7ALNqKsyxrcVmkMM9xGvwNdW
         8t9TDkZDXpLshYYxrnACwUAqmfzaqSWi6xOGE///W8CnbmsoIconzPKo1uMAeMdn0a
         RM9P44Tr0g3plnCh8jE4vclyEnauJ34MkGPeVtlz9M1NU0KSRGk0BkjQ3tm2KdEMua
         XDKqoRao70IL3M2fbp6ldjniomCdKteN79SiTDM3dIlbkbTTkmppbNrriSXL5Hm7hr
         qUyIu9NbpHHZTrIim5JxeKGtVZ86Lh0sgA68Sjc5NOJRa3klD7F6wYyPC3A+4wmcVG
         xTzyYGSrtyoNg==
Date:   Mon, 15 May 2023 14:19:27 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Krishna Kurapati <quic_kriskura@quicinc.com>
Cc:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
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
Subject: Re: [PATCH v8 4/9] usb: dwc3: core: Skip setting event buffers for
 host only controllers
Message-ID: <20230515211927.bcartfqerpcgmp5w@ripper>
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

Please add "Qualcomm" before SA8295P.

> capable, GEVTADDRHI/LO, GEVTSIZ, GEVTCOUNT registers are not accessible.
> Trying to setup them up during core_init leads to a crash.

s/setup/access/ (or "write to"?) and presumably this is a problem beyond
core_init, so I would suggest dropping "up during core_init" from the
sentence.

> 
> For DRD/Peripheral supported controllers, event buffer setup is done
> again in gadget_pullup. Skip setup or cleanup of event buffers if
> controller is host-only capable.
> 

With that, this looks reasonable to me.

Reviewed-by: Bjorn Andersson <andersson@kernel.org>

Regards,
Bjorn

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
>  	evt->lpos = 0;
> @@ -522,6 +527,11 @@ int dwc3_event_buffers_setup(struct dwc3 *dwc)
>  void dwc3_event_buffers_cleanup(struct dwc3 *dwc)
>  {
>  	struct dwc3_event_buffer	*evt;
> +	unsigned int			hw_mode;
> +
> +	hw_mode = DWC3_GHWPARAMS0_MODE(dwc->hwparams.hwparams0);
> +	if (hw_mode == DWC3_GHWPARAMS0_MODE_HOST)
> +		return;
>  
>  	evt = dwc->ev_buf;
>  
> -- 
> 2.40.0
> 
