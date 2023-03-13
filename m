Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E05336B7084
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 08:55:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbjCMHzt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 03:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbjCMHzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 03:55:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D720532A4;
        Mon, 13 Mar 2023 00:53:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 93CEA6102C;
        Mon, 13 Mar 2023 07:53:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A00A9C433D2;
        Mon, 13 Mar 2023 07:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1678694027;
        bh=qXpORCVC22q6WFkUkgrUTCWoKOTFuIICXiYOXV4iEj0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1ijGgz6YsPWKhJ0K9J5eGnkTqlVfLHOKSchxUPLzAiosv7VccmQMVK/4BtFAlBio3
         NWwI//kQ1geBcgLF52Cn6s/wYQqDqlG3T1ri3A2ZzaiK0m7mJ11nJ3addojqCcwqCU
         P4jToqBMfPe0N4nPoLHFg4EzmZa/zm27FaCxGhJ4=
Date:   Mon, 13 Mar 2023 08:53:43 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jarkko Sonninen <kasper@iki.fi>
Cc:     Johan Hovold <johan@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: serial: xr: Add TIOCGRS485 and TIOCSRS485 ioctls
Message-ID: <ZA7Wh2Z/DdKOsOYr@kroah.com>
References: <20230313010416.845252-1-kasper@iki.fi>
 <ZA7KIs2jA/acpN9n@kroah.com>
 <a1ba59be-30aa-08e9-65e7-2c458cc164f9@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a1ba59be-30aa-08e9-65e7-2c458cc164f9@iki.fi>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 13, 2023 at 09:49:26AM +0200, Jarkko Sonninen wrote:
> > > +{
> > > +	void __user *argp = (void __user *)arg;
> > > +
> > > +	switch (cmd) {
> > > +	case TIOCGRS485:
> > > +		return xr_get_rs485_config(tty, argp);
> > > +	case TIOCSRS485:
> > > +		return xr_set_rs485_config(tty, argp);
> > > +	}
> > > +	return -ENOIOCTLCMD;
> > Wrong ioctl return value :(
> 
> What is the correct ioctl error return value ?
> ENOIOCTLCMD was used in most places in usb serial as an error return.

ENOTTY is the correct one for when an ioctl is not handled by the ioctl
call.

thanks,

greg k-h
