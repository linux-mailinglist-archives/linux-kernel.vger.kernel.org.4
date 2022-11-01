Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4622F6149DF
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 12:50:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbiKALuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 07:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231493AbiKALtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 07:49:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFDFF625D;
        Tue,  1 Nov 2022 04:46:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8CCC260B2C;
        Tue,  1 Nov 2022 11:46:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E161DC433D6;
        Tue,  1 Nov 2022 11:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667303165;
        bh=a8xt1T5Uay9NpOBwXLmpdOHdQGFiCZzWC7ujs3LyI4E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qURshmvKeB8E2t/oIPTGsnh0Udh6UOT3w52nnQGF6gaemKL14K8svBmxsqAcHsCqb
         wel1ZZUlgIAJWu65ghln+yTwCahK0ucC77KLV2T5LNIhh8ZWgCRirrEqXGMvGj3XZq
         Q/ftj0KKcY3hWSfikw2xk51LQAMSrvZpExcoIMDq5dX9EpJMSEKxh+Rnda9mImDiOS
         jv6h6umxXe9JepBzvutst+9/Yqtwx8qUWLtirN/DDEx/HBEVJvvoRKMCCD9I1bpVvc
         9s9G17/W+SEtPmEIH32kl9fonlJfUSVxsCwwsawWx0b0vZzu0MDk95RIR/SIVwoDKC
         dbkcWj+GqBtyQ==
Date:   Tue, 1 Nov 2022 17:15:54 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Qiang Yu <quic_qianyu@quicinc.com>
Cc:     quic_hemantk@quicinc.com, loic.poulain@linaro.org,
        mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_cang@quicinc.com,
        mrana@quicinc.com
Subject: Re: [PATCH] bus: mhi: host: Add session ID to MHI controller
Message-ID: <20221101114554.GD54667@thinkpad>
References: <1665376870-60668-1-git-send-email-quic_qianyu@quicinc.com>
 <20221028172022.GC13880@thinkpad>
 <7dc5b87a-1413-f7cb-4fdc-93828252c4f1@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7dc5b87a-1413-f7cb-4fdc-93828252c4f1@quicinc.com>
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 31, 2022 at 04:54:55PM +0800, Qiang Yu wrote:
> 
> On 10/29/2022 1:20 AM, Manivannan Sadhasivam wrote:
> > On Mon, Oct 10, 2022 at 12:41:10PM +0800, Qiang Yu wrote:
> > > Session ID to be used during BHI transfers to recognize a
> > > particular session are currently not being stored in the MHI
> > > controller structure. Store them to allow for tracking and other
> > > future usage.
> > > 
> > > Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
> > Who/what is going to use this session id?
> Sometimes, we may find some error logs and want to see what happens on
> device when host is printing these error logs.
> Session id can help us find the logs we want.

Okay. Please add this info to the commit message.

Thanks,
Mani

> > 
> > Thanks,
> > Mani
> > 
> > > ---
> > >   drivers/bus/mhi/host/boot.c | 8 ++++----
> > >   include/linux/mhi.h         | 1 +
> > >   2 files changed, 5 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/drivers/bus/mhi/host/boot.c b/drivers/bus/mhi/host/boot.c
> > > index 26d0edd..5bed8b51 100644
> > > --- a/drivers/bus/mhi/host/boot.c
> > > +++ b/drivers/bus/mhi/host/boot.c
> > > @@ -231,7 +231,7 @@ static int mhi_fw_load_bhi(struct mhi_controller *mhi_cntrl,
> > >   			   dma_addr_t dma_addr,
> > >   			   size_t size)
> > >   {
> > > -	u32 tx_status, val, session_id;
> > > +	u32 tx_status, val;
> > >   	int i, ret;
> > >   	void __iomem *base = mhi_cntrl->bhi;
> > >   	rwlock_t *pm_lock = &mhi_cntrl->pm_lock;
> > > @@ -253,16 +253,16 @@ static int mhi_fw_load_bhi(struct mhi_controller *mhi_cntrl,
> > >   		goto invalid_pm_state;
> > >   	}
> > > -	session_id = MHI_RANDOM_U32_NONZERO(BHI_TXDB_SEQNUM_BMSK);
> > > +	mhi_cntrl->session_id = MHI_RANDOM_U32_NONZERO(BHI_TXDB_SEQNUM_BMSK);
> > >   	dev_dbg(dev, "Starting image download via BHI. Session ID: %u\n",
> > > -		session_id);
> > > +		mhi_cntrl->session_id);
> > >   	mhi_write_reg(mhi_cntrl, base, BHI_STATUS, 0);
> > >   	mhi_write_reg(mhi_cntrl, base, BHI_IMGADDR_HIGH,
> > >   		      upper_32_bits(dma_addr));
> > >   	mhi_write_reg(mhi_cntrl, base, BHI_IMGADDR_LOW,
> > >   		      lower_32_bits(dma_addr));
> > >   	mhi_write_reg(mhi_cntrl, base, BHI_IMGSIZE, size);
> > > -	mhi_write_reg(mhi_cntrl, base, BHI_IMGTXDB, session_id);
> > > +	mhi_write_reg(mhi_cntrl, base, BHI_IMGTXDB, mhi_cntrl->session_id);
> > >   	read_unlock_bh(pm_lock);
> > >   	/* Wait for the image download to complete */
> > > diff --git a/include/linux/mhi.h b/include/linux/mhi.h
> > > index a5441ad..8b3c934 100644
> > > --- a/include/linux/mhi.h
> > > +++ b/include/linux/mhi.h
> > > @@ -405,6 +405,7 @@ struct mhi_controller {
> > >   	u32 minor_version;
> > >   	u32 serial_number;
> > >   	u32 oem_pk_hash[MHI_MAX_OEM_PK_HASH_SEGMENTS];
> > > +	u32 session_id;
> > >   	struct mhi_event *mhi_event;
> > >   	struct mhi_cmd *mhi_cmd;
> > > -- 
> > > The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> > > a Linux Foundation Collaborative Project
> > > 
> > > 
> 

-- 
மணிவண்ணன் சதாசிவம்
