Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03F0462E3B3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 19:02:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240311AbiKQSCj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 13:02:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240392AbiKQSCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 13:02:31 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80B517FF07
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 10:02:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 27FE9621F1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 18:02:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5464C433D6;
        Thu, 17 Nov 2022 18:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1668708147;
        bh=TRjm0WT33DZOnm4zQ5Af86jucgIaP3z093GvYTORYYs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mTbXHZNNdEIy33+Uk8+Oq9oCmUpdng8aTdMFnD1OG+4HLFcapT9PyeYQ6P8DKydRT
         9UNFybcWRDzgvRltMBWtwR8utLTYsLBVPsFNQyquckIKoXAefKdNhGhsDMtDTlEPRK
         nu3CDMx6eoIgfv4foyowbh8LnaW96W3NM2qLxPmM=
Date:   Thu, 17 Nov 2022 19:02:10 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Umang Jain <umang.jain@ideasonboard.com>
Cc:     Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Dan Carpenter <error27@gmail.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Ray Jui <rjui@broadcom.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH 1/3] Revert "staging: mmal-vchiq: Avoid use of bool in
 structures"
Message-ID: <Y3Z3Is8u4wGZfKU5@kroah.com>
References: <20221117160015.344528-1-umang.jain@ideasonboard.com>
 <20221117160015.344528-2-umang.jain@ideasonboard.com>
 <166870135963.50677.14827688186331561108@Monstersaurus>
 <c718624a-bb6f-5474-5cc3-4319b1fdb282@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c718624a-bb6f-5474-5cc3-4319b1fdb282@ideasonboard.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022 at 11:25:48PM +0530, Umang Jain wrote:
> Hi Kieran,
> 
> On 11/17/22 9:39 PM, Kieran Bingham wrote:
> > Quoting Umang Jain (2022-11-17 16:00:13)
> > > This reverts commit 640e77466e69d9c28de227bc76881f5501f532ca.
> > > 
> > > In commit 7967656ffbfa ("coding-style: Clarify the expectations around
> > > bool") the check to dis-allow bool structure members was removed from
> > > checkpatch.pl. It promotes bool structure members to store boolean
> > > values. This enhances code readability.
> > > 
> > > Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
> > > ---
> > >   .../staging/vc04_services/vchiq-mmal/mmal-vchiq.c    | 12 ++++++------
> > >   .../staging/vc04_services/vchiq-mmal/mmal-vchiq.h    |  4 ++--
> > >   2 files changed, 8 insertions(+), 8 deletions(-)
> > > 
> > > diff --git a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
> > > index cb921c94996a..4abb6178cb9f 100644
> > > --- a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
> > > +++ b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
> > > @@ -863,9 +863,9 @@ static int port_info_get(struct vchiq_mmal_instance *instance,
> > >                  goto release_msg;
> > >          if (rmsg->u.port_info_get_reply.port.is_enabled == 0)
> > > -               port->enabled = 0;
> > > +               port->enabled = false;
> > >          else
> > > -               port->enabled = 1;
> > > +               port->enabled = true;
> > >          /* copy the values out of the message */
> > >          port->handle = rmsg->u.port_info_get_reply.port_handle;
> > > @@ -1304,7 +1304,7 @@ static int port_disable(struct vchiq_mmal_instance *instance,
> > >          if (!port->enabled)
> > >                  return 0;
> > > -       port->enabled = 0;
> > > +       port->enabled = false;
> > >          ret = port_action_port(instance, port,
> > >                                 MMAL_MSG_PORT_ACTION_TYPE_DISABLE);
> > > @@ -1359,7 +1359,7 @@ static int port_enable(struct vchiq_mmal_instance *instance,
> > >          if (ret)
> > >                  goto done;
> > > -       port->enabled = 1;
> > > +       port->enabled = true;
> > >          if (port->buffer_cb) {
> > >                  /* send buffer headers to videocore */
> > > @@ -1531,7 +1531,7 @@ int vchiq_mmal_port_connect_tunnel(struct vchiq_mmal_instance *instance,
> > >                          pr_err("failed disconnecting src port\n");
> > >                          goto release_unlock;
> > >                  }
> > > -               src->connected->enabled = 0;
> > > +               src->connected->enabled = false;
> > >                  src->connected = NULL;
> > >          }
> > > @@ -1799,7 +1799,7 @@ int vchiq_mmal_component_disable(struct vchiq_mmal_instance *instance,
> > >          ret = disable_component(instance, component);
> > >          if (ret == 0)
> > > -               component->enabled = 0;
> > > +               component->enabled = false;
> > >          mutex_unlock(&instance->vchiq_mutex);
> > > diff --git a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.h b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.h
> > > index 6006e29232b3..70eda6cac1c6 100644
> > > --- a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.h
> > > +++ b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.h
> > > @@ -48,7 +48,7 @@ typedef void (*vchiq_mmal_buffer_cb)(
> > >                  int status, struct mmal_buffer *buffer);
> > >   struct vchiq_mmal_port {
> > > -       u32 enabled:1;
> > > +       bool enabled:1;
> > Is this a direct revert with 'git revert' ?
> 
> 
> No. It had conflicts plus I added the ':1' initialization to keep the logic
> same (in case 'enabled' gets used directly). Similar pattern come up with:
>     ($) git grep 'bool' -- '*.[h]' | grep '\:1'
> 
> So it shouldn't be an issue.

Please don't do that "bool foo:1" makes no sense.  Drop the ":1"
please.

thanks,

greg k-h
