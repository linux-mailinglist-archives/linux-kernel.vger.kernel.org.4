Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 126ED72208F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 10:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbjFEIIU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 04:08:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjFEIIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 04:08:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58508A1
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 01:08:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DD121611E6
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 08:08:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 453B1C433EF;
        Mon,  5 Jun 2023 08:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685952497;
        bh=TpPjlkIU5EWObdMV+nSZFG8cwg9HbzjckLadCVt3k1I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OkBB8p7aQFZz1fRe9MXHNxHv4DKDVy3UOSy0DG9k3ykbAtkiudIIntqqEcOGyNmQJ
         BiSk+A07iKDwgupsiINQ96xNs6ro1W8hoL99J37uXiHxPhiUKALpIX4lvxEYBBWl2x
         CNcp2/kCEJBWkdSit/+vwSBet9u8mGtC+oV/eyY4TVSwgm04vO8M4EGVrBW4cgIr+5
         AID8/GwHIQowmhK9TosI6J5U9VcrtIm6KEqojJ4muD48HDkENeesGUqPUPShBFzczD
         1eGlXMiV+iEw/lgjWphpRxYVj0Kayd9Yg7h8+He4bpzJ4qSwu7Unzch1ONJSsMG3u8
         bJb1KFkr9xmDA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1q65GU-00081o-Cn; Mon, 05 Jun 2023 10:08:34 +0200
Date:   Mon, 5 Jun 2023 10:08:34 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        perex@perex.cz, tiwai@suse.com, lgirdwood@gmail.com,
        ckeepax@opensource.cirrus.com, kuninori.morimoto.gx@renesas.com,
        linux-kernel@vger.kernel.org, pierre-louis.bossart@linux.intel.com,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH 1/2] ASoC: codecs: wsa883x: do not set can_multi_write
 flag
Message-ID: <ZH2YAmBY-GNKABSB@hovoldconsulting.com>
References: <20230523154605.4284-1-srinivas.kandagatla@linaro.org>
 <168492769030.49784.4719862081052299023.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <168492769030.49784.4719862081052299023.b4-ty@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 24, 2023 at 12:28:10PM +0100, Mark Brown wrote:
> On Tue, 23 May 2023 16:46:04 +0100, Srinivas Kandagatla wrote:
> > regmap-sdw does not support multi register writes, so there is
> > no point in setting this flag. This also leads to incorrect
> > programming of WSA codecs with regmap_multi_reg_write() call.
> > 
> > This invalid configuration should have been rejected by regmap-sdw.
> > 
> > 
> > [...]
> 
> Applied to
> 
>    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
> 
> Thanks!
> 
> [1/2] ASoC: codecs: wsa883x: do not set can_multi_write flag
>       commit: 40ba0411074485e2cf1bf8ee0f3db27bdff88394
> [2/2] ASoC: codecs: wsa881x: do not set can_multi_write flag
>       commit: 6e7a6d4797ef521c0762914610ed682e102b9d36

These were merged for 6.5 but the corresponding sanity check for regmap
has now been included in 6.4-rc5 which consequently breaks these codecs
(similar for wcd938x-sdw):

[   11.443485] wsa883x-codec sdw:0:0217:0202:00:1: error -ENOTSUPP: regmap_init failed
[   11.443525] wsa883x-codec sdw:0:0217:0202:00:1: Probe of wsa883x-codec failed: -524
[   11.443554] wsa883x-codec: probe of sdw:0:0217:0202:00:1 failed with error -52

Is it possible to get also these fixes into 6.4 final?

Johan
