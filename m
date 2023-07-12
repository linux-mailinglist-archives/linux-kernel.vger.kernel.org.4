Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E28FA7507D0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 14:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232289AbjGLMMg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 08:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231488AbjGLMMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 08:12:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B5F7E65;
        Wed, 12 Jul 2023 05:12:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9C5A5617A4;
        Wed, 12 Jul 2023 12:12:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAF63C433C8;
        Wed, 12 Jul 2023 12:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689163952;
        bh=9Vrfyl+qNlhjUuYQ+DzG4/zZwn6xt7e/Cc1IJTbESnE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oSvkq3tqbXDLMRHAppG6fxYvOgma2Nw98ZLx5gO+HrZQArhxjxHK/Xlq37JNxEzyx
         tRA502ufSiNAfgUGKOOwAqi9D/hNkVOATfE6wsCmkJxQ32gR3+ejocFOcVqncpsFVY
         TAibI8d/hNOZCz99pK+oVTZzrn8sVuc5lYo8tfoN6cb80MfWziZF8mm+S5YcFoDn0r
         u3uOhy1zo7nsF1jdCoGE6qlfIuDCjfvUlZDGbKyqbs7em2nmxoa5/8qiqv5dVyoyA7
         hxcb2ftuH1r04yO31m6lGwRULaElhMnhJFK+MEvwBqEkVf3+webOjYxU7Is1ShgxfO
         Q44nnk8GlLs+w==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan@kernel.org>)
        id 1qJYho-0005to-1X;
        Wed, 12 Jul 2023 14:12:29 +0200
Date:   Wed, 12 Jul 2023 14:12:28 +0200
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
        Felipe Balbi <balbi@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        quic_pkondeti@quicinc.com, quic_ppratap@quicinc.com,
        quic_jackp@quicinc.com, quic_harshq@quicinc.com,
        ahalaney@redhat.com, quic_shazhuss@quicinc.com
Subject: Re: [PATCH v9 06/10] usb: dwc3: qcom: Add support to read IRQ's
 related to multiport
Message-ID: <ZK6YrLMn9r39zEeB@hovoldconsulting.com>
References: <20230621043628.21485-1-quic_kriskura@quicinc.com>
 <20230621043628.21485-7-quic_kriskura@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230621043628.21485-7-quic_kriskura@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2023 at 10:06:24AM +0530, Krishna Kurapati wrote:
> Add support to read Multiport IRQ's related to quad port controller
> of SA8295 Device.
> 
> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> ---
>  drivers/usb/dwc3/dwc3-qcom.c | 108 +++++++++++++++++++++++++++++------
>  1 file changed, 91 insertions(+), 17 deletions(-)

> +static int dwc3_qcom_setup_mp_irq(struct platform_device *pdev)
> +{
> +	struct dwc3_qcom *qcom = platform_get_drvdata(pdev);
> +	char irq_name[15];

The interrupt device-name string can not be allocated on the stack or
reused as it is stored directly in each irqaction structure.

This can otherwise lead to random crashes when accessing
/proc/interrupts:

	https://lore.kernel.org/lkml/ZK6IV_jJPICX5r53@hovoldconsulting.com/

> +	int irq;
> +	int ret;
> +	int i;
> +
> +	for (i = 0; i < 4; i++) {
> +		if (qcom->dp_hs_phy_irq[i])
> +			continue;
> +
> +		sprintf(irq_name, "dp%d_hs_phy_irq", i+1);
> +		irq = dwc3_qcom_get_irq(pdev, irq_name, -1);
> +		if (irq > 0) {
> +			irq_set_status_flags(irq, IRQ_NOAUTOEN);
> +			ret = devm_request_threaded_irq(qcom->dev, irq, NULL,
> +					qcom_dwc3_resume_irq,
> +					IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
> +					irq_name, qcom);
> +			if (ret) {
> +				dev_err(qcom->dev, "%s failed: %d\n", irq_name, ret);
> +				return ret;
> +			}
> +		}
> +
> +		qcom->dp_hs_phy_irq[i] = irq;
> +	}

Johan
