Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A8D06C7FCD
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 15:23:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231834AbjCXOXM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 10:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbjCXOXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 10:23:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD10227BB;
        Fri, 24 Mar 2023 07:23:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6563662AD2;
        Fri, 24 Mar 2023 14:23:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05C8EC433D2;
        Fri, 24 Mar 2023 14:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679667787;
        bh=ByUS8ixdKw9ZOUXU671IFgLj5lR9S0HYOJEGGrPdIBk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s9Zv+2ZlLctru7hz2kVhdsiAvX+YYpdRGP5PLecwt17Z2m9yR/0WPRMrgXInzH7Dl
         rujAt6ladQADe+s5rrzxZb3DktzXItf/vN955TBu14onwZsxHig1SXb9GExUilKMvl
         HlWJ2SDi4ByhXCHIeCConJjino6Zk8GzctIAF+c71HN8oGb93qoRJzInD8FJxKqWMF
         W/OLOtumeU+vPbVuyCadxySEURGItTF6C/gHXRjQtL/QxXLZisg2sOy9Q6BctnuU8f
         iwP8RONf2yR535vViKnoYt/NaAB5CwoVP5MPvNlAzYNx8VAKzU2+b8QZPuGLelw9Ta
         UoeTD9lE8KxpQ==
Date:   Fri, 24 Mar 2023 19:52:55 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Jeffrey Hugo <quic_jhugo@quicinc.com>
Cc:     mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bus: mhi: host: Range check CHDBOFF and ERDBOFF
Message-ID: <20230324142255.GD4259@thinkpad>
References: <1679066059-8399-1-git-send-email-quic_jhugo@quicinc.com>
 <20230324103452.GC4259@thinkpad>
 <11ea2552-27e1-3665-869c-4594de1782a5@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <11ea2552-27e1-3665-869c-4594de1782a5@quicinc.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2023 at 07:50:01AM -0600, Jeffrey Hugo wrote:
> On 3/24/2023 4:34 AM, Manivannan Sadhasivam wrote:
> > On Fri, Mar 17, 2023 at 09:14:19AM -0600, Jeffrey Hugo wrote:
> > > If the value read from the CHDBOFF and ERDBOFF registers is outside the
> > > range of the MHI register space then an invalid address might be computed
> > > which later causes a kernel panic.  Range check the read value to prevent
> > > a crash due to bad data from the device.
> > > 
> > > Fixes: 6cd330ae76ff ("bus: mhi: core: Add support for ringing channel/event ring doorbells")
> > 
> > Please CC stable list.
> 
> The stable folks have been automatically picking up everything with a fixes
> tag for years.  CCing the stable list does not seem to do anything unless
> the patch needs specific backporting adjustments.
> 
> Do you still want an explicit CC?
> 

That was the impression I had but Greg wanted us to explicitly CC stable list
and add a hint about how deep the patch needs to be applied.

> > 
> > > Signed-off-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
> > > Reviewed-by: Pranjal Ramajor Asha Kanojiya <quic_pkanojiy@quicinc.com>
> > > ---
> > >   drivers/bus/mhi/host/init.c | 12 ++++++++++++
> > >   1 file changed, 12 insertions(+)
> > > 
> > > diff --git a/drivers/bus/mhi/host/init.c b/drivers/bus/mhi/host/init.c
> > > index 3d779ee..ae8ebcfb 100644
> > > --- a/drivers/bus/mhi/host/init.c
> > > +++ b/drivers/bus/mhi/host/init.c
> > > @@ -516,6 +516,12 @@ int mhi_init_mmio(struct mhi_controller *mhi_cntrl)
> > >   		return -EIO;
> > >   	}
> > > +	if (val >= mhi_cntrl->reg_len - (8 * MHI_DEV_WAKE_DB)) {
> > > +		dev_err(dev, "CHDB offset: 0x%x is out of range: 0x%zx\n",
> > > +			val, mhi_cntrl->reg_len - (8 * MHI_DEV_WAKE_DB));
> > > +		return -EINVAL;
> > 
> > Isn't -ERANGE a better errno here and also in other places of the driver?
> 
> I suppose that could work.  This was modeled after the existing BHI (eg
> BHIOFF) range checks.  You want those updated in the same change or a
> separate one?
> 

That can go into a separate change.

Thanks,
Mani

> > Thanks,
> > Mani
> > 
> > > +	}
> > > +
> > >   	/* Setup wake db */
> > >   	mhi_cntrl->wake_db = base + val + (8 * MHI_DEV_WAKE_DB);
> > >   	mhi_cntrl->wake_set = false;
> > > @@ -532,6 +538,12 @@ int mhi_init_mmio(struct mhi_controller *mhi_cntrl)
> > >   		return -EIO;
> > >   	}
> > > +	if (val >= mhi_cntrl->reg_len - (8 * mhi_cntrl->total_ev_rings)) {
> > > +		dev_err(dev, "ERDB offset: 0x%x is out of range: 0x%zx\n",
> > > +			val, mhi_cntrl->reg_len - (8 * mhi_cntrl->total_ev_rings));
> > > +		return -EINVAL;
> > > +	}
> > > +
> > >   	/* Setup event db address for each ev_ring */
> > >   	mhi_event = mhi_cntrl->mhi_event;
> > >   	for (i = 0; i < mhi_cntrl->total_ev_rings; i++, val += 8, mhi_event++) {
> > > -- 
> > > 2.7.4
> > > 
> > > 
> > 
> 

-- 
மணிவண்ணன் சதாசிவம்
