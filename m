Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2CB16277E9
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 09:39:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236575AbiKNIjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 03:39:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235546AbiKNIjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 03:39:03 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F5425585;
        Mon, 14 Nov 2022 00:39:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3BD30B80D3D;
        Mon, 14 Nov 2022 08:39:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF878C433D6;
        Mon, 14 Nov 2022 08:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668415139;
        bh=Muy39ws2qzc9C9z89cBDyoYv7kOVNo/ouftCUsXVhXg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A6H7Fhbsie/ismyskZlBI/ASWRbTcwOB70b2kLJo+M8s+hCMor3qoHIlY8w6f9lQP
         dpXygTlIFkrdMB1rlMO+gcv5A4BPurMKgA8GqFfH4fpk3KCN3nfUIuaFvfRz0Obo/E
         FbDQPmswsV5K5OvBLG9I6dii9g1SYYjCi7i/aHI/ud+mkdK2zhmOZk1Ng8M6IiA+EV
         9JBG+DU3fsQcEEjxiVwvbg19g8Snn4YS9mdWvykeDbRB5dvja1hBORltap8l90LgfH
         QjJn5ODZbXR4Qc8+dECudIGACwtIqakQUdEju006SR0hgLaM+fUJpAwXvuVN5Fjqmt
         KB8uB4TpTrsoA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1ouUz4-0001na-QH; Mon, 14 Nov 2022 09:38:27 +0100
Date:   Mon, 14 Nov 2022 09:38:26 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 16/22] phy: qcom-qmp-combo: add DP configuration tables
Message-ID: <Y3H+gpKZsOH05RET@hovoldconsulting.com>
References: <20221111085643.9478-1-johan+linaro@kernel.org>
 <20221111085643.9478-17-johan+linaro@kernel.org>
 <56752623-d865-2848-3132-4df769a31d39@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56752623-d865-2848-3132-4df769a31d39@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 12, 2022 at 10:39:12AM +0300, Dmitry Baryshkov wrote:
> On 11/11/2022 11:56, Johan Hovold wrote:
> > In preparation for merging the USB and DP configurations, add dedicated
> > pointers for the DP serdes and tx tables to the configurations.
> > 
> > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> > ---
> >   drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 45 ++++++++++++-----------
> >   1 file changed, 24 insertions(+), 21 deletions(-)
> > 
> > diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
> > index 499368e19e00..b27d1821116c 100644
> > --- a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
> > +++ b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
> > @@ -816,6 +816,11 @@ struct qmp_phy_cfg {
> >   	const struct qmp_phy_init_tbl *pcs_usb_tbl;
> >   	int pcs_usb_tbl_num;
> >   
> > +	const struct qmp_phy_init_tbl *dp_serdes_tbl;
> > +	int dp_serdes_tbl_num;
> > +	const struct qmp_phy_init_tbl *dp_tx_tbl;
> > +	int dp_tx_tbl_num;
> > +
> 
> I'd prefer to have DP-specific instance of struct qmp_phy_cfg_tbls here 
> instead of having separate dp-specific fields. WDYT?

No, I don't see any good reason for doing so currently.

You may be able to share a few pointers between some of the SoCs but
only until it turns out they need to override certain sequences anyway
(e.g. sc8280xp which mixes v4 and v5 tables currently).

You'd also need dedicated aggregate table structs for USB and DP and it
seems all of this would just make things more opaque for little gain.

Johan
