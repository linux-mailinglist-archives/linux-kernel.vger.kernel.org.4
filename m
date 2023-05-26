Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AFC9711BAF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 02:51:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236275AbjEZAvD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 20:51:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236055AbjEZAu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 20:50:59 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 70A4F1B4
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 17:50:54 -0700 (PDT)
Received: (qmail 276368 invoked by uid 1000); 25 May 2023 20:50:53 -0400
Date:   Thu, 25 May 2023 20:50:53 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Roy Luo <royluo@google.com>
Cc:     raychi@google.com, badhri@google.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        Bastien Nocera <hadess@hadess.net>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Flavio Suligoi <f.suligoi@asem.it>,
        Douglas Anderson <dianders@chromium.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [RFC PATCH v1] usb: core: add sysfs entry for usb device state
Message-ID: <dfaa91d3-1169-4381-a2ef-83443ee3e4ce@rowland.harvard.edu>
References: <20230525173818.219633-1-royluo@google.com>
 <408575c0-2967-4cdb-92c7-1b2845038d20@rowland.harvard.edu>
 <CA+zupgwz8Mbd8=7ep7t0OU-34bbwsc9fMK4dHip0rgqD7FSd2A@mail.gmail.com>
 <89cf2c61-a55e-4c35-93b2-35fa7ab0266b@rowland.harvard.edu>
 <CA+zupgyErTsDEZYerfAeEyVF073x+aTW6HiWZRA+2Y=a7U4XVg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+zupgyErTsDEZYerfAeEyVF073x+aTW6HiWZRA+2Y=a7U4XVg@mail.gmail.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 25, 2023 at 01:31:17PM -0700, Roy Luo wrote:
> On Thu, May 25, 2023 at 12:10 PM Alan Stern <stern@rowland.harvard.edu> wrote:
> >
> > On Thu, May 25, 2023 at 11:46:23AM -0700, Roy Luo wrote:
> > > Alan, thanks for the quick response!
> > > Yes, port_dev->state is indeed the same as port_dev->child->state. However,
> > > I still add port_dev->state because port_dev->child won't be assigned until
> > > the corresponding usb_device is in ADDRESS state.
> > > I wish I can assign get port_dev->child assigned earlier, but I think
> > > the current design - assign port_dev->child and device_add() after ADDRESS
> > > state - also makes sense because there are many ways that the enumeration
> > > could fail in the early stage. By adding port_dev->state, I can link
> > > usb_device->state to usb_port as soon as the usb_device is created to get
> > > around the limitation of port_dev->child.
> > > I would be very happy to hear other ideas.
> >
> > Is there any real reason not to set port_dev->child as soon as the
> > usb_device structure is created?  If enumeration fails, the pointer can
> > be cleared.
> >
> > Alan Stern
> 
> Currently the usb core assumes the usb_device that port_dev->child points
> to is enumerated and port_dev->child->dev is registered when
> port_dev->child is present. Setting port_dev->child early would break this
> fundamental assumption, hence I'm a bit reluctant to go this way.

Well, you could remove that assumption by adding a "child_is_registered" 
flag and explicitly checking it.

Alan Stern
