Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAC2674865D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 16:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231546AbjGEOal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 10:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231984AbjGEOaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 10:30:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58330CF;
        Wed,  5 Jul 2023 07:30:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E8E5861578;
        Wed,  5 Jul 2023 14:30:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 530FCC433C7;
        Wed,  5 Jul 2023 14:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688567437;
        bh=mioA+NwZpkg7KB16O0oCsl2L7Ti3kUkbc08ZUpiE4dQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tHyEobZ4yZ6Rf5P4cpd7HdExbDFfbfwjSd9AOkAamID+KUpZLK3UX1Ssiu3WEZob9
         k/S/wpYG3g5A+k/Zd9q4qO9qNtok2xT0r1VnWKJ8ffAo5OtFxZBdnxjW8HqTlznM2k
         dy6Ih2YDHHoWWcJeC74ZCp68RRIXR969V9jXPKOOTAwZevqQlW8Jfa21AJxEKzD6Ie
         I9kSC7ozj89z0APRO985AwxivYx5Jejt3rEuv87AeietuvgV7417+qJkqGMp8AgF8q
         CBK/6Ksld10CgpxWIHyvxj/5lgIZHaWqVBIAjZV9MzAqTPgYowu7FKAEnBTwJ6jQ1F
         YgNkRGtArbf7A==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan@kernel.org>)
        id 1qH3Wz-0000g3-1S;
        Wed, 05 Jul 2023 16:30:58 +0200
Date:   Wed, 5 Jul 2023 16:30:57 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Mark Brown <broonie@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Rander Wang <rander.wang@linux.intel.com>
Subject: Re: [PATCH 1/8] soundwire: fix enumeration completion
Message-ID: <ZKV-oXAWzRXnjXus@hovoldconsulting.com>
References: <20230705123018.30903-1-johan+linaro@kernel.org>
 <20230705123018.30903-2-johan+linaro@kernel.org>
 <907ad7a3-3384-c0c4-90a9-5beab4cc45e0@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <907ad7a3-3384-c0c4-90a9-5beab4cc45e0@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 05, 2023 at 02:53:17PM +0200, Pierre-Louis Bossart wrote:
> On 7/5/23 14:30, Johan Hovold wrote:
> > The soundwire subsystem uses two completion structures that allow
> > drivers to wait for soundwire device to become enumerated on the bus and
> > initialised by their drivers, respectively.
> > 
> > The code implementing the signalling is currently broken as it does not
> > signal all current and future waiters and also uses the wrong
> > reinitialisation function, which can potentially lead to memory
> > corruption if there are still waiters on the queue.
> 
> That change sounds good, but I am not following the two paragraphs below.
> 
> > Not signalling future waiters specifically breaks sound card probe
> > deferrals as codec drivers can not tell that the soundwire device is
> > already attached when being reprobed. 
> 
> What makes you say that? There is a test in the probe and the codec
> driver will absolutely be notified, see bus_type.c
> 
> 	if (drv->ops && drv->ops->update_status) {
> 		ret = drv->ops->update_status(slave, slave->status);
> 		if (ret < 0)
> 			dev_warn(dev, "%s: update_status failed with status %d\n", __func__,
> ret);
> 	}

I'm talking about signalling the codec driver using the soundwire device
via the completion structs. Unless the underling device is detached and
reattached, trying to wait for completion a second time will currently
timeout instead of returning immediately.

This affects codecs like rt5682, which wait for completion in component
probe (see rt5682_probe()).

> > Some codec runtime PM
> > implementations suffer from similar problems as waiting for enumeration
> > during resume can also timeout despite the device already having been
> > enumerated.
> 
> I am not following this either. Are you saying the wait_for_completion()
> times out because of the init_completion/reinit_completion confusion, or
> something else.

It times out because the completion counter is not saturated unless you
use complete_all().

Drivers that wait unconditionally in resume, will time out the second
time they are runtime resumed unless the underlying device has been
detached and reattached in the meantime (e.g. wsa881x_runtime_resume()).

Johan
