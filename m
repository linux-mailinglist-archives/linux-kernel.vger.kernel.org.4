Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E6646048DB
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 16:12:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbiJSOMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 10:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231899AbiJSOLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 10:11:54 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDDA41AC1FB;
        Wed, 19 Oct 2022 06:54:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 0049DCE2241;
        Wed, 19 Oct 2022 13:51:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02F4FC433C1;
        Wed, 19 Oct 2022 13:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666187501;
        bh=jrTe3eMGW5ffNFtDxkHTlei5AgA/Ul8ndLjqKSldIso=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pyi9TrqIWBfDG8wOv1p0sfjY/8fUV82A51FEx8fgY7z1jjdXnqBj6gUtvN0ZeglC1
         Gmjtp1uoz/bFzZweXV99Y/82hK0HWoxzY8nH2j2QZ6xThw160k1P2WGTJlTfe5By2R
         WpQGE4MXa5UtcdWK7bU1jj7/ZX4a/gV3WchLmQvOpPVlnb0DWgRS+BEU5ZMpegHyRX
         ti1vX4DKlOVGQucE20mVjMj2zf9/k8GSi05iWTkV5ce39r4A1COk5uCxq3HdUijNXC
         tOAv6DLGnvy5s133JuuG4Qs1497XHlQqv8p09/hOCRjJ1I17DFsf9jcI0EJEbOPoSW
         1r+nD/20LJUFw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1ol9Tk-0006YN-GW; Wed, 19 Oct 2022 15:51:29 +0200
Date:   Wed, 19 Oct 2022 15:51:28 +0200
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
Subject: Re: [PATCH v2 08/15] phy: qcom-qmp-pcie: add register init helper
Message-ID: <Y1AA4ISrWQbOoaju@hovoldconsulting.com>
References: <20221019113552.22353-1-johan+linaro@kernel.org>
 <20221019113552.22353-9-johan+linaro@kernel.org>
 <0f1fff20-772f-c4d1-f803-f1824ef23780@linaro.org>
 <Y0/63eH82t2zXFi5@hovoldconsulting.com>
 <0b0c752c-1f3d-bf5a-ade7-e2f8acac92a4@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b0c752c-1f3d-bf5a-ade7-e2f8acac92a4@linaro.org>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2022 at 04:44:33PM +0300, Dmitry Baryshkov wrote:
> On 19/10/2022 16:25, Johan Hovold wrote:
> > On Wed, Oct 19, 2022 at 04:12:02PM +0300, Dmitry Baryshkov wrote:
> >> On 19/10/2022 14:35, Johan Hovold wrote:
> >>> Generalise the serdes initialisation helper so that it can be used to
> >>> initialise all the PHY registers (e.g. serdes, tx, rx, pcs).
> >>>
> >>> Note that this defers the ungating of the PIPE clock somewhat, which is
> >>> fine as it isn't needed until starting the PHY.
> >>>
> >>> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> >>> ---
> >>>    drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 51 +++++++-----------------
> >>>    1 file changed, 15 insertions(+), 36 deletions(-)
> >>>

> >>> -static void qmp_pcie_pcs_init(struct qmp_pcie *qmp, const struct qmp_phy_cfg_tables *tables)
> >>> -{
> >>> -	void __iomem *pcs = qmp->pcs;
> >>> -	void __iomem *pcs_misc = qmp->pcs_misc;
> >>> -
> >>> -	if (!tables)
> >>> -		return;
> >>>    
> >>> -	qmp_pcie_configure(pcs, tables->pcs, tables->pcs_num);
> >>> -	qmp_pcie_configure(pcs_misc, tables->pcs_misc, tables->pcs_misc_num);
> >>> +	qmp_pcie_configure(pcs, tbls->pcs, tbls->pcs_num);
> >>> +	qmp_pcie_configure(pcs_misc, tbls->pcs_misc, tbls->pcs_misc_num);
> >>
> >> Nit: could we please keep it as `tables'?
> > 
> > I considered that but found that the longer identifier hurt
> > readability so I prefer to use "tbls" here.

> I'd say, it's up to Vinod. I'd prefer the second version.

Ultimately yes, but as the author of these patches I do have a say here.

Johan
