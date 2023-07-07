Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E845574B1EA
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 15:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbjGGNjz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 09:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjGGNjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 09:39:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86DE0211C
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 06:39:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BA245619A9
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 13:39:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 164CBC433C7;
        Fri,  7 Jul 2023 13:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688737190;
        bh=RkKzFOUEhHW/HMpZ7Ymv688mRe9O2wgN5OPVgtprUAk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s0XdTK3XaYhQguQGBnbS9SdxK/oLktNR6qjug2zA8f14BK4PFnIlaAaa6qQvd9j+C
         xW8AGbL9i4R0sIrWvYFkmLxEVT9W7ygazjdS7+aHicAZs8BAKp9hc+vvLVh5VL+48a
         fQO5LWs2Pr72Mlqd23ZyMlYDErDBbWs5XyGrSHtGFZi4lWpT8AaDeeQSp9/S9Iey6o
         wyvUQjM1CM6gtDpmnWVc0axliBb27mZIV7qLmEDJMHmMsVU0YOKz6haCvS1DK2vjCR
         TL+G8kkpmvUmgWtzlFW7n4u/Pl94jeVU2+JdtOyxFE5WdYXCplG7asG4O8DlZmKFCx
         MLSKkG3EXOagw==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan@kernel.org>)
        id 1qHlh1-0007z5-2p;
        Fri, 07 Jul 2023 15:40:16 +0200
Date:   Fri, 7 Jul 2023 15:40:15 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        lgirdwood@gmail.com, ckeepax@opensource.cirrus.com,
        kuninori.morimoto.gx@renesas.com, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org
Subject: Re: [PATCH] ASoC: codecs: wcd938x: fix dB range for HPHL and HPHR
Message-ID: <ZKgVv-G6y16rPdcN@hovoldconsulting.com>
References: <20230705125723.40464-1-srinivas.kandagatla@linaro.org>
 <ZKfAUOOcGoBanHHu@hovoldconsulting.com>
 <efaf5960-bcc5-6d52-5552-e1505a13b635@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <efaf5960-bcc5-6d52-5552-e1505a13b635@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 07, 2023 at 01:54:31PM +0100, Srinivas Kandagatla wrote:
> On 07/07/2023 08:35, Johan Hovold wrote:
> > On Wed, Jul 05, 2023 at 01:57:23PM +0100, Srinivas Kandagatla wrote:
  
> >>   static const SNDRV_CTL_TLVD_DECLARE_DB_MINMAX(ear_pa_gain, 600, -1800);
> >> -static const SNDRV_CTL_TLVD_DECLARE_DB_MINMAX(line_gain, 600, -3000);
> >> +static const DECLARE_TLV_DB_SCALE(line_gain, -3000, 150, -3000);
> > 
> > This looks wrong, and indeed that forth argument appears to be a mute
> > flag. I guess that one should have been 0 (false) here?
> 
> yes, this should be true instead of a mute dB value.

Ok, so mute is supported. Then that argument can just be changed to "1"
as a cleanup to follow the current convention.

> > Headphone output also appears to be way too loud by default with this
> > patch (alone) applied. Perhaps it's just the default mixer settings need
> > to be updated to match?
> > 
> > It looks like you're inverting the scale above. Perhaps that's intended,
> 
> yes, the highest value corresponds to lowest dB which is why its inverted.

Got it, thanks.

> > but some more details in the commit message as to what was wrong and
> > what you intended to do would have been good.
> 
> HPHR/HPHL Volume control is broken on this codec.
> current UCM uses digital volume control for x13s which needs to be moved 
> to Analog volume control.
> I have this change https://termbin.com/mpp9 in UCM which I plan to send 
> out once I test and fix other paths as well.

With those UCM changes the headphone volume appears to be restored even
if pavucontrol now sets the "base" marker at 80% rather than 20% volume
on the X13s (which is much too loud here).

Audio quality seem fine and I'm not hearing any distortion at 20%
volume as some people were complaining about (even if I haven't really
used the headphones myself before).

Sounds like you had a similar fix for the speaker distortion coming soon
too, looking forward to that one.

Johan
