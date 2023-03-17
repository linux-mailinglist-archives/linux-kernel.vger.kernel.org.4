Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCC296BEA36
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 14:37:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbjCQNh1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 09:37:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbjCQNhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 09:37:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 877C1C2D8B
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 06:37:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3D651B82586
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 13:37:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 600D6C4339C;
        Fri, 17 Mar 2023 13:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679060239;
        bh=YWIDLuEFnRBwfpxQtDoAidrvlww69eJAsTQKccqkZNQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c7OwB4PmkZxRr85XcBZkS7xesvAoFtE+21ae1YpfA6yECiRs5ooSxph+4VEvCFFbf
         fTQN0tH4hMuDzK+7yV67K1JvIcKYfEQs8ndoocY4hb+uWl3yqi5Y9oRlTaCTj8n/Ky
         hjqkrmHfxZJi7R+lDxSIHhQRfRQ2qJ64qrfcbdpTXI4z86g5GG3jWyL1P/Dn6rigg2
         ScoLvCGLyRkZJj2whKtOtxzRQT0TsBCGusONDoWO3+6dRgq0PTbwQC/RcBhwk8KapP
         Bfx933INbNwHJUs3Iw0sOHY2a93fuaYl35lRv7sNnwvRzZhFb3dca4Bgc2QsUoJOA1
         Cp0VnFXdAt/pw==
Date:   Fri, 17 Mar 2023 19:07:15 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Bard Liao <yung-chuan.liao@linux.intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        bard.liao@intel.com
Subject: Re: [PATCH] soundwire: stream: uniquify dev_err() logs
Message-ID: <ZBRtCwtmFsQQ+Oo0@matsya>
References: <20230309054905.21507-1-yung-chuan.liao@linux.intel.com>
 <ZBGZR2ACa8AbNmvy@matsya>
 <c40192e9-6207-3204-819f-abbabc320c38@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c40192e9-6207-3204-819f-abbabc320c38@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15-03-23, 09:38, Pierre-Louis Bossart wrote:
> 
> 
> On 3/15/23 05:09, Vinod Koul wrote:
> > On 09-03-23, 13:49, Bard Liao wrote:
> >> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> >>
> >> There are a couple of duplicate logs which makes harder than needed to
> >> follow the error flows. Add __func__ or make the log unique.
> >>
> >> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> >> Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
> >> Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
> >> ---
> >>  drivers/soundwire/stream.c | 18 ++++++++++--------
> >>  1 file changed, 10 insertions(+), 8 deletions(-)
> >>
> >> diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
> >> index 2e39587ed1de..dd09855caac9 100644
> >> --- a/drivers/soundwire/stream.c
> >> +++ b/drivers/soundwire/stream.c
> >> @@ -1389,7 +1389,7 @@ static int _sdw_prepare_stream(struct sdw_stream_runtime *stream,
> >>  
> >>  	ret = do_bank_switch(stream);
> >>  	if (ret < 0) {
> >> -		dev_err(bus->dev, "Bank switch failed: %d\n", ret);
> >> +		pr_err("%s: do_bank_switch failed: %d\n", __func__, ret);
> > 
> > why make it pr_ and loose the dev name? There is a trick to emit
> > function for dev_err too using dynamic debug
> 
> a stream can be cased on multiple managers/buses.
> 
> It's incorrect to use bus->dev in this case, see all other error cases
> in stream.c, they all use pr_err already for the same reason. bus->dev
> is only valid when dealing with a single bus, typically in loops in that
> file.
> 
> That said we could have split the two changes where dev_err() is changed
> as pr_err() for clarity.

Thanks, that would be better way

-- 
~Vinod
