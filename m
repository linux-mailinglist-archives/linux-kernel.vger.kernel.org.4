Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04E096BB4FA
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 14:44:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232727AbjCONoP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 09:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232502AbjCONnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 09:43:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A28079C9A0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 06:43:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 888EB61D94
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 13:43:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51756C433D2;
        Wed, 15 Mar 2023 13:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678887794;
        bh=avbS2XLbaT2Ze2SWcGU+uxKZhUw+cN+JCgvYHiUVGl0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KT+cilCTP1wAcIJ8HjEaSpmXvNPOjdVgjtZZTPHtYjFqFMyKfWC4GFT80ZC0ElIrZ
         +MsVrKqQFYAqkWxLG2tqJT6UqpD28qe2eFzTnhrfyBXCVnUR8Izl7M1dcwi37RzgdX
         e1DtR0AhuZOZTAI8tsCuyufuNKT2lEz1aLmIXE4cEtC0WFUj0q1QPPIGpOwqyvaKcj
         2D9xBXXYxX51ibEjzduZX2jgvQq/pmPM/ClgyT3osn7Wp6c06YLds3a3k13232I0T5
         NlChccnngghMeZv/RLDK9hrC6o3zQKdR8uWDcn7QZNwDygc3lw2A7yE6ttvugkhS1U
         z2vpXUQ2oaFkg==
Date:   Wed, 15 Mar 2023 19:13:10 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        yung-chuan.liao@linux.intel.com, sanyog.r.kale@intel.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: Re: [PATCH 1/2] soundwire: bus: Prevent infinite loop in
 sdw_ch_mask_to_ch()
Message-ID: <ZBHLbksMqwnewtMC@matsya>
References: <20230202154212.1098736-1-rf@opensource.cirrus.com>
 <20230202154212.1098736-2-rf@opensource.cirrus.com>
 <0b49c924-5994-c1cd-a174-4a2e2cfaf0d2@linux.intel.com>
 <2d1f1bc1-afaa-b1f4-1a93-df1bfa00405b@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d1f1bc1-afaa-b1f4-1a93-df1bfa00405b@opensource.cirrus.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03-02-23, 16:18, Richard Fitzgerald wrote:
> On 03/02/2023 14:35, Pierre-Louis Bossart wrote:
> > 
> > 
> > On 2/2/23 09:42, Richard Fitzgerald wrote:
> > > Define the ch_mask argument of sdw_ch_mask_to_ch() as an unsigned
> > > so that the shift right is guaranteed to eventually make the
> > > value of ch_mask==0.
> > > 
> > > Previously ch_mask was defined as a signed int, but a right
> > > shift of a signed value preserves the sign bit. So if the sign
> > > bit was 1, ch_mask would never become 0 and the for loop would
> > > be infinite.
> > > Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> > > ---
> > >   drivers/soundwire/bus.h | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/soundwire/bus.h b/drivers/soundwire/bus.h
> > > index 7631ef5e71fb..28bedc919b78 100644
> > > --- a/drivers/soundwire/bus.h
> > > +++ b/drivers/soundwire/bus.h
> > > @@ -160,7 +160,7 @@ int sdw_fill_msg(struct sdw_msg *msg, struct sdw_slave *slave,
> > >   		 u32 addr, size_t count, u16 dev_num, u8 flags, u8 *buf);
> > >   /* Retrieve and return channel count from channel mask */
> > > -static inline int sdw_ch_mask_to_ch(int ch_mask)
> > > +static inline int sdw_ch_mask_to_ch(unsigned int ch_mask)
> > >   {
> > >   	int c = 0;
> > 
> > This patch1 is fine, but you remove this function in patch2, so is this
> > patch needed at all?
> > 
> > -/* Retrieve and return channel count from channel mask */
> > -static inline int sdw_ch_mask_to_ch(unsigned int ch_mask)
> > -{
> > -	int c = 0;
> > -
> > -	for (c = 0; ch_mask; ch_mask >>= 1)
> > -		c += ch_mask & 1;
> > -
> > -	return c;
> > -}
> > -
> 
> I'm happy to squash them, I did it in two steps so it didn't get
> overlooked that there's a bugfix happening.

I think this case is fine to squash and send as a single patch while
documenting that we are fixing the bug in the log

Thanks
-- 
~Vinod
