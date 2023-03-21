Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83EAC6C3B86
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 21:16:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbjCUUQh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 16:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbjCUUQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 16:16:25 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2BEB18B1D;
        Tue, 21 Mar 2023 13:15:53 -0700 (PDT)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 92EF0FF802;
        Tue, 21 Mar 2023 20:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1679429750;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cc+qNEZ1EzSB9IZt8CHtV76yUlh0JjmYuBy/GWO2DUs=;
        b=OJi5weJFGQioSkJQd5/SUYbolA50WhSTiYvD06XBP9RW5a91sWOLAirktoEIQNx2l7cojo
        4PLPVb/XYsSgRt+EtykaDwuJjFNaUjBMP1w6iD6DkyZVq4heLOklu6kqWyu2mh67Dci6w7
        rSKinPXvCKraO8/H6s8XlSLRWUsJ/yhDDqysEG4YQY6kMvg4dIo9n7HgZdsK9U7UViQlNV
        rWSguoyaBBHahzLRyHmY1dMQ9QHZ8LAi3yojE0biQ0l0/2qoxdYvQnMR2pNf2PAoXzCC7A
        19Fld+FXsCIflcXr+eLbhPcR/syNggMCz4SB6g7hPxCOVu/RlINPPEm06xn8Ug==
Date:   Tue, 21 Mar 2023 21:15:49 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org, linux-amlogic@lists.infradead.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 RFC] rtc: meson-vrtc: Use ktime_get_real_ts64() to get
 the current time
Message-ID: <167942973227.681565.15801130800253450098.b4-ty@bootlin.com>
References: <20230320212142.2355062-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230320212142.2355062-1-martin.blumenstingl@googlemail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 20 Mar 2023 22:21:42 +0100, Martin Blumenstingl wrote:
> The VRTC alarm register can be programmed with an amount of seconds
> after which the SoC will be woken up by the VRTC timer again. We are
> already converting the alarm time from meson_vrtc_set_alarm() to
> "seconds since 1970". This means we also need to use "seconds since
> 1970" for the current time.
> 
> This fixes a problem where setting the alarm to one minute in the future
> results in the firmware (which handles wakeup) to output (on the serial
> console) that the system will be woken up in billions of seconds.
> ktime_get_raw_ts64() returns the time since boot, not since 1970. Switch
> to ktime_get_real_ts64() to fix the calculation of the alarm time and to
> make the SoC wake up at the specified date/time. Also the firmware
> (which manages suspend) now prints either 59 or 60 seconds until wakeup
> (depending on how long it takes for the system to enter suspend).
> 
> [...]

Applied, thanks!

[1/1] rtc: meson-vrtc: Use ktime_get_real_ts64() to get the current time
      commit: 0e6255fa3f649170da6bd1a544680589cfae1131

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
