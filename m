Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6159D6F6D1E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 15:44:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbjEDNov (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 09:44:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230500AbjEDNot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 09:44:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E5467D93;
        Thu,  4 May 2023 06:44:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A6967633EA;
        Thu,  4 May 2023 13:44:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 116E2C433EF;
        Thu,  4 May 2023 13:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683207886;
        bh=cxXZ0Mv9fZe8AzkErEvTVxOOrlIoataPJcnAJ93nNR4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O315kDjLiPUAsQ6xGpos4WTKEs50qI7zNpaj3f5JBpT11niVq2Dd4d0nT4K+WWtC6
         bihPy/onuSp3833LpgoGH3e1AeRuCL3oBwHcyGEzQ/5zvencqvm51XpP7wCIulpwsG
         T/rIndpoISt6pzekCOJk/PuT/VFxrsK0UMfKL+OFYDqQif6XoSP7jPd7ekerDuLNw6
         WoXACFIqNAA2xC9mPvNVqYkqvayWczEmfyy0OJFQwZoAObGqcUWWAtZS3jiyBaWsAp
         Ywse2+V3+hjXG/wFqwGAs4foDgViBq2TSYTgsj4CsDelqYDKwNMBRYhlGNsDcGOJJp
         CVgaKL/iiCKjw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1puZGP-00078W-RV; Thu, 04 May 2023 15:44:54 +0200
Date:   Thu, 4 May 2023 15:44:53 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Bjorn Andersson <quic_bjorande@quicinc.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/7] phy: qcom-qmp-combo: Introduce orientation variable
Message-ID: <ZFO21fLWSNc7orpb@hovoldconsulting.com>
References: <20230425034010.3789376-1-quic_bjorande@quicinc.com>
 <20230425034010.3789376-4-quic_bjorande@quicinc.com>
 <ZFD4gM9dUQwBmSUe@hovoldconsulting.com>
 <20230504032907.GF870858@hu-bjorande-lv.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230504032907.GF870858@hu-bjorande-lv.qualcomm.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 03, 2023 at 08:29:07PM -0700, Bjorn Andersson wrote:
> On Tue, May 02, 2023 at 01:48:16PM +0200, Johan Hovold wrote:
> > On Mon, Apr 24, 2023 at 08:40:06PM -0700, Bjorn Andersson wrote:

> > >  static void qmp_v3_dp_aux_init(struct qmp_combo *qmp);
> > > @@ -1955,29 +1962,23 @@ static void qmp_v3_configure_dp_tx(struct qmp_combo *qmp)
> > >  static bool qmp_combo_configure_dp_mode(struct qmp_combo *qmp)
> > >  {
> > >  	u32 val;
> > > -	bool reverse = false;
> > > +	bool reverse = qmp->orientation == TYPEC_ORIENTATION_REVERSE;

> > It also looks like these callbacks end up being called without holding
> > the qmp->phy_mutex via phy->power_on(). Perhaps there is no risk for a
> > concurrent switch notification and dp phy power-on but it's not that
> > obvious.

> It seems we're arriving here from hpd_event_thread(), while
> phy_power_on() and phy_power_off() will be called in some other context.
> I've not been able to convince myself if DP driver ensures ordering, or
> if we have an existing race here...

> Unless you insist, I would prefer to follow up with an additional patch
> once we've landed this series. The fix will depend on the phy_mutex
> shuffling patch anyways...

Sure.

But perhaps you can just move the orientation == qmp->orientation check
under the mutex in qmp_combo_typec_switch_set() for now (in case I
forgot to point that out earlier).

Johan
