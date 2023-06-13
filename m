Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A4F872DD43
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 11:06:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241373AbjFMJGp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 05:06:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240695AbjFMJGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 05:06:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37053E47;
        Tue, 13 Jun 2023 02:06:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B8B4C63104;
        Tue, 13 Jun 2023 09:06:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D9C0C433EF;
        Tue, 13 Jun 2023 09:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686647198;
        bh=6aJi1HDMyG+diAQWNGWHz3BblRyOIZNRXnIuek9cous=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MX8ZMzudQWLK1qvvM0UCkrYvkBHgmRLrvV92A8pE3igmIBM/l+hsjiwVFD+74sNda
         XRT8o3iTPprimPc5GGE1Qs2yziwkHlKpd406VssrXN8PulNiasK7HtRXgvICMdH6wK
         ruZv3p5UTCafY8VMVc4ATrfXk4Zn5UriT7jw/siI=
Date:   Tue, 13 Jun 2023 11:06:35 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Roy Luo <royluo@google.com>
Cc:     raychi@google.com, badhri@google.com,
        Alan Stern <stern@rowland.harvard.edu>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        Bastien Nocera <hadess@hadess.net>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Flavio Suligoi <f.suligoi@asem.it>,
        Douglas Anderson <dianders@chromium.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH v3] usb: core: add sysfs entry for usb device state
Message-ID: <2023061307-oversized-wife-1f69@gregkh>
References: <20230605215529.195045-1-royluo@google.com>
 <2023060734-survey-shady-f025@gregkh>
 <CA+zupgy1WCh8Z6cKo1No5k4PcsFFpEDBXW-rTZVih7bfASAZDA@mail.gmail.com>
 <CA+zupgymZusMgecUyD8f2-AnoT3OR_O_wjy6uTxjZgSv9BLHLw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+zupgymZusMgecUyD8f2-AnoT3OR_O_wjy6uTxjZgSv9BLHLw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 07, 2023 at 06:58:08PM -0700, Roy Luo wrote:
> > > @@ -160,6 +160,16 @@ static ssize_t connect_type_show(struct device *dev,
> > >  }
> > >  static DEVICE_ATTR_RO(connect_type);
> > >
> > > +static ssize_t state_show(struct device *dev,
> > > +                       struct device_attribute *attr, char *buf)
> > > +{
> > > +     struct usb_port *port_dev = to_usb_port(dev);
> > > +     enum usb_device_state state = READ_ONCE(port_dev->state);
> > > +
> > > +     return sprintf(buf, "%s\n", usb_state_string(state));
> >
> > I thought checkpatch would warn you that you should be using
> > sysfs_emit() here, wonder why it didn't.
> >
> > thanks,
> >
> > greg k-h
> 
> I was using sprintf() instead of sysfs_emit() because I randomly referred
> to one of the nearby attributes. Looks like there are still many attributes in
> port.c that uses sprintf(), any reason why we didn't replace them?
> If not, I'm happy to do a clean-up so that others don't make the same mistake
> as I did :D

Doing whole-scale replacements across the kernel for stuff like this
isn't needed, just for new stuff, using the new apis is a good idea.

thanks,

greg k-h
