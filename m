Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2993611958
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 19:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbiJ1Ree (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 13:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiJ1Re2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 13:34:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B4F92AD2;
        Fri, 28 Oct 2022 10:34:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 07ACFB82BCE;
        Fri, 28 Oct 2022 17:34:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DF40C433D6;
        Fri, 28 Oct 2022 17:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666978464;
        bh=I6B85KF2fhTK4YqhEUVgUCk2ZIfhY6KRSlr4vCUGeAU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YXBJZWaEcPvtfxGFPa8JlF51fGecUnrXOd0/0vc5+RnEtTbyP14AZnpk5uKrPJuOy
         jD+gyt5pMdr8zoqrDRxus4kY9FRLiQT3T//r3CldiPblgDUG9KE8D36Iqke2eEZNyj
         61qspavHy6zjA0NIYlpiET8wmXz3RzV+RVcg3vp/K6aIcrgiuRG9JHdCTPnhCjPRzN
         5KyTkFQ4ZtTnmrt0DO2HrRQuH5uJIxWENXKTk76chCJXLSgPqwehfXi7dha26p8V/C
         0FIf68/kg3KezqwoT2a2MVEtJQdneDIi6moL/QwvvHR9y0AuXQH/8HDCdP+N+3wwGi
         QwMWDfxPMb+JA==
Date:   Fri, 28 Oct 2022 23:04:17 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Qiang Yu <quic_qianyu@quicinc.com>
Cc:     loic.poulain@linaro.org, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_cang@quicinc.com, mrana@quicinc.com
Subject: Re: [PATCH v2] bus: mhi: host: Fix race between channel preparation
 and M0 event
Message-ID: <20221028173417.GG13880@thinkpad>
References: <1665889532-13634-1-git-send-email-quic_qianyu@quicinc.com>
 <20221028165401.GA13880@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221028165401.GA13880@thinkpad>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2022 at 10:24:01PM +0530, Manivannan Sadhasivam wrote:
> On Sun, Oct 16, 2022 at 11:05:32AM +0800, Qiang Yu wrote:
> > There is a race condition where mhi_prepare_channel() updates the
> > read and write pointers as the base address and in parallel, if
> > an M0 transition occurs, the tasklet goes ahead and rings
> > doorbells for all channels with a delta in TRE rings assuming
> > they are already enabled. This causes a null pointer access. Fix
> > it by adding a channel enabled check before ringing channel
> > doorbells.
> > 
> > Fixes: a6e2e3522f29 "bus: mhi: core: Add support for PM state transitions"
> > Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
> 
> Can you also CC stable list for backporting?
> 

Nvm, I added stable list and applied the patch to mhi-next! Because of the
addition of MHI EP support, this patch can be backported without modifications
till 5.19 only. If you want to backport to older kernels, please send them to
stable list once this got merged.

Thanks,
Mani

> Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
> 
> Thanks,
> Mani
> 
> > ---
> > v1->v2: add Fixes tags
> > 
> >  drivers/bus/mhi/host/pm.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/bus/mhi/host/pm.c b/drivers/bus/mhi/host/pm.c
> > index 4a42186..0834590 100644
> > --- a/drivers/bus/mhi/host/pm.c
> > +++ b/drivers/bus/mhi/host/pm.c
> > @@ -301,7 +301,8 @@ int mhi_pm_m0_transition(struct mhi_controller *mhi_cntrl)
> >  		read_lock_irq(&mhi_chan->lock);
> >  
> >  		/* Only ring DB if ring is not empty */
> > -		if (tre_ring->base && tre_ring->wp  != tre_ring->rp)
> > +		if (tre_ring->base && tre_ring->wp  != tre_ring->rp &&
> > +		    mhi_chan->ch_state == MHI_CH_STATE_ENABLED)
> >  			mhi_ring_chan_db(mhi_cntrl, mhi_chan);
> >  		read_unlock_irq(&mhi_chan->lock);
> >  	}
> > -- 
> > 2.7.4
> > 
> > 
> 
> -- 
> மணிவண்ணன் சதாசிவம்
> 

-- 
மணிவண்ணன் சதாசிவம்
