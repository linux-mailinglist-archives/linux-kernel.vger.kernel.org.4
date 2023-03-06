Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB7F66AB93B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 10:05:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbjCFJFI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 04:05:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjCFJFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 04:05:06 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFEE315893;
        Mon,  6 Mar 2023 01:05:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7E811B80C82;
        Mon,  6 Mar 2023 09:05:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89621C4339E;
        Mon,  6 Mar 2023 09:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678093501;
        bh=yBz3gepLbwedgniVR7u8nl2nQvxTL0ay1+6CySTGteE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NH2MI0tBSpN1ITuovfjyeY0P2aeNECg0ranryAE72CAgljq+H3g9st2swl6Hq6VPP
         KxqdgA5rgugzmpyzgJIEDRT+eKis3uEOr5b10WQ2DTYxWJMXxmYTyT/e7RmIcLYotk
         fzU+luCmU0qd/E3IP3uFNZ+J5PXFebkE3GEe4O4HVotGTcLHlqRh8E/MuSDh+nJLLv
         VPPIG3yTmYz8DdBczNRLD1gQoIqjUmpb4l5BIRifNZ4sZ0YYOftAzSqbaW5lm+fadW
         EP9+UPeZJdoK34rySjFHrwfrMuU+1dv0aHeRkrbm0dXALgWyAouUIqpaIEVkjdj8LF
         RNv8Z/ebvIp8g==
Date:   Mon, 6 Mar 2023 09:04:56 +0000
From:   Lee Jones <lee@kernel.org>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     Florian Eckert <fe@dev.tdt.de>, u.kleine-koenig@pengutronix.de,
        gregkh@linuxfoundation.org, pavel@ucw.cz,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        Eckert.Florian@googlemail.com
Subject: Re: [PATCH v7 2/2] trigger: ledtrig-tty: add additional modes
Message-ID: <20230306090456.GA9667@google.com>
References: <20230222083335.847655-1-fe@dev.tdt.de>
 <20230222083335.847655-3-fe@dev.tdt.de>
 <20230303141139.GP2420672@google.com>
 <be7c90cf-4c65-1cf0-3001-8706415c3d34@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <be7c90cf-4c65-1cf0-3001-8706415c3d34@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 06 Mar 2023, Jiri Slaby wrote:

> On 03. 03. 23, 15:11, Lee Jones wrote:
> > On Wed, 22 Feb 2023, Florian Eckert wrote:
> > > @@ -113,21 +207,38 @@ static void ledtrig_tty_work(struct work_struct *work)
> > >   		trigger_data->tty = tty;
> > >   	}
> > > -	ret = tty_get_icount(trigger_data->tty, &icount);
> > > -	if (ret) {
> > > -		dev_info(trigger_data->tty->dev, "Failed to get icount, stopped polling\n");
> > > -		mutex_unlock(&trigger_data->mutex);
> > > -		return;
> > > -	}
> > > -
> > > -	if (icount.rx != trigger_data->rx ||
> > > -	    icount.tx != trigger_data->tx) {
> > > -		led_set_brightness_sync(trigger_data->led_cdev, LED_ON);
> > > -
> > > -		trigger_data->rx = icount.rx;
> > > -		trigger_data->tx = icount.tx;
> > > -	} else {
> > > -		led_set_brightness_sync(trigger_data->led_cdev, LED_OFF);
> > > +	switch (trigger_data->mode) {
> > > +	case TTY_LED_CTS:
> > > +		ledtrig_tty_flags(trigger_data, TIOCM_CTS);
> > > +		break;
> > > +	case TTY_LED_DSR:
> > > +		ledtrig_tty_flags(trigger_data, TIOCM_DSR);
> > > +		break;
> > > +	case TTY_LED_CAR:
> > > +		ledtrig_tty_flags(trigger_data, TIOCM_CAR);
> > > +		break;
> > > +	case TTY_LED_RNG:
> > > +		ledtrig_tty_flags(trigger_data, TIOCM_RNG);
> > > +		break;
> > > +	case TTY_LED_CNT:
> > 
> > I believe this requires a 'fall-through' statement.
> 
> I don't think this is the case. Isn't fallthrough required only in cases
> when there is at least one statement, i.e. a block?

There's no mention of this caveat in the document.

To my untrained eyes, the rule looks fairly explicit, starting with "All".

"
  All switch/case blocks must end in one of:

  * break;
  * fallthrough;
  * continue;
  * goto <label>;
  * return [expression];
"

If you're aware of something I'm not, please consider updating the doc.

> > Documentation/process/deprecated.rst
> > 
> > > +	default:
> > > +		ret = tty_get_icount(trigger_data->tty, &icount);
> > > +		if (ret) {
> > > +			dev_info(trigger_data->tty->dev, "Failed to get icount, stopped polling\n");
> > > +			mutex_unlock(&trigger_data->mutex);
> > > +			return;
> > > +		}
> > > +

-- 
Lee Jones [李琼斯]
