Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3F6B61DA9C
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 14:31:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbiKENbC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 09:31:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbiKENbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 09:31:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6F56DFFF;
        Sat,  5 Nov 2022 06:30:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 92561B80025;
        Sat,  5 Nov 2022 13:30:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B146AC433D7;
        Sat,  5 Nov 2022 13:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667655057;
        bh=Exmb2YbVuJv8xgD75Jwx6M3P7AfHe0lCKRLcDlEsnKw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pPyd7d6NY3uFHHKCarHevBVmkEnP1IGtnPPCPiV186twVOs262fob0X4/QyuS0LEV
         5v9DGoZDnSHBAE2P1j15ptsg7OrKX+3eu2Ri/xXnp4LZpt2mvsLGlrtkKUXtSsHyUL
         xSg5L5xrFE0G3AyEdPGaIkrKdsG3kt250uDEGNqmVMwPv1snB4D5/SWGXIHdFxX076
         UAkbh6eMnw4DY8ID9cPitTEoJXQLnlZum+UNSUCA7AsHTyE+2oJGLKTICTNZf5CB7c
         2AXvTdXCuuvrIeJETIDtM+0KlK5TM7QKZN5ZjIehR8iYFDqwcbcaYOpG3BiJs5rASu
         nyBMQZiEo6KFQ==
Date:   Sat, 5 Nov 2022 19:00:52 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 09/16] phy: qcom-qmp-pcie: add register init helper
Message-ID: <Y2ZljEGAdg9zehE7@matsya>
References: <20221028133603.18470-1-johan+linaro@kernel.org>
 <20221028133603.18470-10-johan+linaro@kernel.org>
 <Y2ZSVooZDBDnsKD3@matsya>
 <Y2ZiTWk+dJj/XNu/@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2ZiTWk+dJj/XNu/@hovoldconsulting.com>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05-11-22, 14:17, Johan Hovold wrote:
> On Sat, Nov 05, 2022 at 05:38:54PM +0530, Vinod Koul wrote:
> > On 28-10-22, 15:35, Johan Hovold wrote:

> > > +	qmp_pcie_configure(serdes, tbls->serdes, tbls->serdes_num);
> > 
> > We are tbls
> 
> Yeah, it's a separate function.
> 
> Note that qmp_pcie_configure_lane() above use 'tbl' too.
> 
> > > +
> > >  	qmp_pcie_configure_lane(tx, tbls->tx, tbls->tx_num, 1);
> > >  	qmp_pcie_configure_lane(rx, tbls->rx, tbls->rx_num, 1);
> > >  
> > > @@ -1848,15 +1843,6 @@ static void qmp_pcie_lanes_init(struct qmp_pcie *qmp, const struct qmp_phy_cfg_t
> > >  		qmp_pcie_configure_lane(tx2, tbls->tx, tbls->tx_num, 2);
> > >  		qmp_pcie_configure_lane(rx2, tbls->rx, tbls->rx_num, 2);
> > >  	}
> > > -}
> > > -
> > > -static void qmp_pcie_pcs_init(struct qmp_pcie *qmp, const struct qmp_phy_cfg_tables *tbls)
> > > -{
> > > -	void __iomem *pcs = qmp->pcs;
> > > -	void __iomem *pcs_misc = qmp->pcs_misc;
> > > -
> > > -	if (!tbls)
> > > -		return;
> > >  
> > >  	qmp_pcie_configure(pcs, tbls->pcs, tbls->pcs_num);
> > >  	qmp_pcie_configure(pcs_misc, tbls->pcs_misc, tbls->pcs_misc_num);
> > > @@ -1932,8 +1918,8 @@ static int qmp_pcie_power_on(struct phy *phy)
> > >  	else
> > >  		mode_tables = cfg->tables_ep;
> > >  
> > > -	qmp_pcie_serdes_init(qmp, &cfg->tables);
> > > -	qmp_pcie_serdes_init(qmp, mode_tables);
> > > +	qmp_pcie_init_registers(qmp, &cfg->tables);
> > > +	qmp_pcie_init_registers(qmp, mode_tables);
> > 
> > but here tables :(
> > 
> > Lets stick with either please, or if we have differentiation lets make
> > it real obvious
> 
> It's not uncommon to use shorter local identifiers and a more descriptive
> name in structures, but since the driver already used 'tbl' consistently
> before the recent addition of the aggregate tables structure, I can
> rename also those pointers so that we use 'tbl' and 'tbls' consistently
> throughout the driver.

Thanks that would be great. Lets stick to one convention throughout the
driver

-- 
~Vinod
