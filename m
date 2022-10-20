Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85A03605E2C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 12:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbiJTKto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 06:49:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbiJTKtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 06:49:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C84A193FE;
        Thu, 20 Oct 2022 03:49:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5FAB2B82703;
        Thu, 20 Oct 2022 10:49:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F26F6C433C1;
        Thu, 20 Oct 2022 10:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666262975;
        bh=6KPTvy+J6w0Z1UUTzZ1Zf+/lhxrtVWfefrzE1t3fxmE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sRIF6UndSpcjnUsWH+RdWi4ByH8QiLokAyMTzGWQ731ypPJSzf2QGpQ8l0B+aM49g
         mZO/C3niqAq/RjrwYn8k4JLP0x4n+2fS1/rcmzDdN9Sma1KcKFDdmcU3lLHCZsk0vs
         9ZjHAW9s5sWuMxSS4QpYfiFGPCzK5PLty3HaWrgqJJiq9IfKQzj7Y5jTNaGMtQO2Vx
         UgcD/qz3R+2wxYP+bPAmdLhFL5VxXFlhg0Qb+B2K34zQvRM0xVLGW2vqS37Oa1ZAuv
         woWIAx6BUcTffBOzaGdBD7rERR/KSRV9A6S/ETvcFDBzSTqjxsqo6f5sSsnAoscYTK
         9/CO681LB5pcA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1olT72-0002C5-Oj; Thu, 20 Oct 2022 12:49:21 +0200
Date:   Thu, 20 Oct 2022 12:49:20 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 13/15] phy: qcom-qmp-pcie: add support for pipediv2
 clock
Message-ID: <Y1EnsKMhoWo+cIWo@hovoldconsulting.com>
References: <20221019113552.22353-1-johan+linaro@kernel.org>
 <20221019113552.22353-14-johan+linaro@kernel.org>
 <325d6c7b-ca96-df73-a792-4d156a710267@linaro.org>
 <Y1EPZBinv0tyZVqW@hovoldconsulting.com>
 <7eb3fb9a-ce4a-eee0-b6bc-cee6aa6bf37b@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7eb3fb9a-ce4a-eee0-b6bc-cee6aa6bf37b@linaro.org>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 20, 2022 at 12:28:14PM +0300, Dmitry Baryshkov wrote:
> On 20/10/2022 12:05, Johan Hovold wrote:

> > Here's your example diff inline:

> > @@ -2206,12 +2207,17 @@ static int qmp_pcie_parse_dt_legacy(struct qmp_pcie *qmp, struct device_node *np
> >   		}
> >   	}
> >   
> > -	qmp->pipe_clk = devm_get_clk_from_child(dev, np, NULL);
> > -	if (IS_ERR(qmp->pipe_clk)) {
> > -		return dev_err_probe(dev, PTR_ERR(qmp->pipe_clk),
> > +	clk = devm_get_clk_from_child(dev, np, NULL);
> > +	if (IS_ERR(clk)) {
> > +		return dev_err_probe(dev, PTR_ERR(clk),
> >   				     "failed to get pipe clock\n");
> >   	}
> >   
> > +	qmp->num_pipe_clks = 1;
> > +	qmp->pipe_clks = devm_kcalloc(dev, qmp->num_pipe_clks,
> > +				      sizeof(*qmp->pipe_clks), GFP_KERNEL);
> > +	qmp->pipe_clks[0].clk = clk;
> > 
> > So here you're poking at bulk API internals and forgot to set the id
> > string, which the implementation uses.
> 
> I didn't forget, I just skipped setting it. Hmm. I thought that it is 
> used only for clk_bulk_get. But after checking, it seems it's also used 
> for error messages. Mea culpa.
> 
> But it's not that I was poking into the internals. These items are in 
> the public header.

My point is that you're not using the bulk API as it was intended (e.g.
with clk_bulk_get()) and you risk running into issues like the above.

And looking up the actual clock name for this is overkill, even in the
case were it is provided, so we'd need to set it unconditionally to
"pipe" (which is fine).

> > For reasons like this, and the fact that will likely never have a third
> > pipe clock, I'm reluctant to using the bulk API.
> 
> Let's resort to the maintainer opinion then.

I'll take another look at it too.

Johan
