Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E181C7240F9
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 13:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236370AbjFFLeS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 07:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236387AbjFFLeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 07:34:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D69DF4;
        Tue,  6 Jun 2023 04:34:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C554D626E6;
        Tue,  6 Jun 2023 11:34:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3267FC433D2;
        Tue,  6 Jun 2023 11:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686051254;
        bh=9M8xhZ+ixdmXS57U7MdJ1ZWhnbtY3orihPjl0VkHNy8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ponqGETuSCaM74hQCdufE61DKKDGkx1G+wMiS0GmWtoerMlmATDLSw9EseA1dxwXn
         Wq4M5X25OexUcV9SY30rZUegEqFiwCwewCUe2nuRFyXLT5HdR+dGxVu5GoWDZLzFCJ
         UBlQLPsC1oNK7GRKyP6bzCu+U3B68tlIno+kIQdtcoxVQskYe2AlckgePT04AoKjwc
         x+DFGJ4Y1ZxAWLKl8kgLwZznXYYPt7FGC4FUHNpWm6HQiAmxK0j5JUZ4SOiNvFGVE4
         329nKRLmfwwHb/aVy0+7WyXCm5zmvR1YZnBLo8MzgU4n+emg/iCaO52/dtcbOLiHef
         b4guYPeBEF0Qw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1q6UxO-00067b-D0; Tue, 06 Jun 2023 13:34:34 +0200
Date:   Tue, 6 Jun 2023 13:34:34 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Oliver Neukum <oneukum@suse.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Corey Minyard <minyard@acm.org>
Subject: Re: [PATCH v2 1/3] USB: serial: return errors from break handling
Message-ID: <ZH8ZyjG_D1HiNay5@hovoldconsulting.com>
References: <20230604123505.4661-1-johan@kernel.org>
 <20230604123505.4661-2-johan@kernel.org>
 <88472624-cc92-31a7-f35d-a212e61ab959@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88472624-cc92-31a7-f35d-a212e61ab959@suse.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oliver,

On Tue, Jun 06, 2023 at 01:13:30PM +0200, Oliver Neukum wrote:
> On 04.06.23 14:35, Johan Hovold wrote:
> > @@ -1077,15 +1077,19 @@ static void pl2303_set_break(struct usb_serial_port *port, bool enable)
> >   	result = usb_control_msg(serial->dev, usb_sndctrlpipe(serial->dev, 0),
> >   				 BREAK_REQUEST, BREAK_REQUEST_TYPE, state,
> >   				 0, NULL, 0, 100);
> > -	if (result)
> > +	if (result) {
> >   		dev_err(&port->dev, "error sending break = %d\n", result);
> > +		return result;
> > +	}
> > +
> > +	return 0;
> >   }

And thanks for taking a look.

> this code was always fishy, but I am afraid it worked by accident albeit
> spamming the logs.
> If I may quote from the kerneldoc of usb_control_msg():
> 
>   * usb_control_msg - Builds a control urb, sends it off and waits for completion
> 
> [..]
> 
>   * Return: If successful, the number of bytes transferred. Otherwise, a negative
>   * error number.
>   */
> 
> You need to test for < 0, not != 0

No, the current code is just fine as there is no data stage so
usb_control_msg() returns 0 or negative errno.

Johan
