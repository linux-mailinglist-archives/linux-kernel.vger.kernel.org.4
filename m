Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31E3C73FDD7
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 16:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbjF0ObS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 10:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbjF0ObR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 10:31:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C73BE30D6;
        Tue, 27 Jun 2023 07:31:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 43375611C1;
        Tue, 27 Jun 2023 14:31:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9814BC433C8;
        Tue, 27 Jun 2023 14:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687876273;
        bh=Tv5bdvTp98Slh58NqzNDcrBENt2BZK2HF11TCLnAYmw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J58rLPr2Kl0fWazg0t0YTLkYNUCalo21RmILidXzsRWuWiG/ewL1YY3QT2FvFrVnK
         3TQhuT0LMJETf+Qr9mAMAWrMVj8ZOBkrmDKu4ScKTyAjSWB8oEjU9CTndNa7j7ShKV
         r5dVWpdMFABIVEOYrUUbFQxWMhU5+fCXSokGXiCRrosFdslCVhyHoTIYq+ngDSZcxm
         vi6y8LRe3g1elS5UX0vUYLs/jrPka6mtNyddA8OpcLSEumuBr/h/0Ssg+S0nmKzMkg
         cDC+vjGkUZUZsGskIKPKEcfxCQHvWrElNtBNO6VVo6ii4xHV0n8dnVNG6P4Zbnk8c7
         hobfFELLuscTg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1qE9io-0003oI-DP; Tue, 27 Jun 2023 16:31:11 +0200
Date:   Tue, 27 Jun 2023 16:31:10 +0200
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
Message-ID: <ZJryrhuUrL5APh4o@hovoldconsulting.com>
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

Please use a more descriptive summary and commit message; "read" is to
vague. You're looking up interrupts from the devicetree. Also this
should not just be about SA8295.

> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> ---
>  drivers/usb/dwc3/dwc3-qcom.c | 108 +++++++++++++++++++++++++++++------
>  1 file changed, 91 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
> index 3de43df6bbe8..3ab48a6925fe 100644
> --- a/drivers/usb/dwc3/dwc3-qcom.c
> +++ b/drivers/usb/dwc3/dwc3-qcom.c
> @@ -74,9 +74,9 @@ struct dwc3_qcom {
>  	struct reset_control	*resets;
>  
>  	int			hs_phy_irq;
> -	int			dp_hs_phy_irq;
> -	int			dm_hs_phy_irq;
> -	int			ss_phy_irq;
> +	int			dp_hs_phy_irq[4];
> +	int			dm_hs_phy_irq[4];
> +	int			ss_phy_irq[2];

As has already been pointed out, you should use a define for these. And
you already have DWC3_MAX_PORTS.

The driver should not be hardcoding the fact that there are only two SS
ports on this particular SoC that you're interested in.

>  	enum usb_device_speed	usb2_speed;
>  
>  	struct extcon_dev	*edev;

> @@ -535,6 +535,80 @@ static int dwc3_qcom_get_irq(struct platform_device *pdev,
>  	return ret;
>  }
>  
> +static int dwc3_qcom_setup_mp_irq(struct platform_device *pdev)
> +{
> +	struct dwc3_qcom *qcom = platform_get_drvdata(pdev);
> +	char irq_name[15];
> +	int irq;
> +	int ret;
> +	int i;
> +
> +	for (i = 0; i < 4; i++) {

DWC3_MAX_PORTS here too and similar below.

> +		if (qcom->dp_hs_phy_irq[i])
> +			continue;

This is not very nice. You should try to integrate the current lookup
code as I told you to do with the PHY lookups. That is, use a single
loop for all HS/SS IRQs, and pick the legacy name if the number of ports
is 1.

Of course, you added the xhci capability parsing to the core driver so
that information is not yet available, but you need it in the glue
driver also...

As I mentioned earlier, you can infer the number of ports from the
interrupt names. Alternatively, you can infer it from the compatible
string. In any case, you should not need to ways to determine the same
information in the glue driver, then in the core part, and then yet
again in the xhci driver...

> +
> +		sprintf(irq_name, "dp%d_hs_phy_irq", i+1);

Spaces around binary operators. Does not checkpatch warn about that?

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
> +
> +	for (i = 0; i < 4; i++) {
> +		if (qcom->dm_hs_phy_irq[i])
> +			continue;
> +
> +		sprintf(irq_name, "dm%d_hs_phy_irq", i+1);
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
> +		qcom->dm_hs_phy_irq[i] = irq;
> +	}
> +
> +	for (i = 0; i < 2; i++) {
> +		if (qcom->ss_phy_irq[i])
> +			continue;
> +
> +		sprintf(irq_name, "ss%d_phy_irq", i+1);
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
> +		qcom->ss_phy_irq[i] = irq;
> +	}

So the above should all be merged in either a single helper looking up
all the interrupts for a port and resused for the non-MP case.

> +
> +	return 0;
> +}
> +
>  static int dwc3_qcom_setup_irq(struct platform_device *pdev)
>  {
>  	struct dwc3_qcom *qcom = platform_get_drvdata(pdev);
> @@ -570,7 +644,7 @@ static int dwc3_qcom_setup_irq(struct platform_device *pdev)
>  			dev_err(qcom->dev, "dp_hs_phy_irq failed: %d\n", ret);
>  			return ret;
>  		}
> -		qcom->dp_hs_phy_irq = irq;
> +		qcom->dp_hs_phy_irq[0] = irq;
>  	}
>  
>  	irq = dwc3_qcom_get_irq(pdev, "dm_hs_phy_irq",
> @@ -585,7 +659,7 @@ static int dwc3_qcom_setup_irq(struct platform_device *pdev)
>  			dev_err(qcom->dev, "dm_hs_phy_irq failed: %d\n", ret);
>  			return ret;
>  		}
> -		qcom->dm_hs_phy_irq = irq;
> +		qcom->dm_hs_phy_irq[0] = irq;
>  	}
>  
>  	irq = dwc3_qcom_get_irq(pdev, "ss_phy_irq",
> @@ -600,10 +674,10 @@ static int dwc3_qcom_setup_irq(struct platform_device *pdev)
>  			dev_err(qcom->dev, "ss_phy_irq failed: %d\n", ret);
>  			return ret;
>  		}
> -		qcom->ss_phy_irq = irq;
> +		qcom->ss_phy_irq[0] = irq;
>  	}
>  
> -	return 0;
> +	return dwc3_qcom_setup_mp_irq(pdev);;

Stray ;

>  }
>  
>  static int dwc3_qcom_clk_init(struct dwc3_qcom *qcom, int count)

Johan
