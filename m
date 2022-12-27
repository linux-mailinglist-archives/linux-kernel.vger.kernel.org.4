Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F8C0656C8F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 16:33:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbiL0PdK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 10:33:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiL0PdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 10:33:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB21E1145;
        Tue, 27 Dec 2022 07:32:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6010EB80E8C;
        Tue, 27 Dec 2022 15:32:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60393C433EF;
        Tue, 27 Dec 2022 15:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672155175;
        bh=GdfI/dQPksQtroVHatnB3fKUKa3tqu+G4L1ZVgykvRQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PNeC7dCbThs/50J9lFfihjVvVH4mIdXs+K2DhiDo8nxsHUVjbyTvpSMmfuaDNxHwF
         xHBH9fC0x4iwZ+1uNStDQWdmICrNSokDhMY8Ce78eeoo70qf2tRhYLLZ1QHR/2Mj1A
         Q0r4gKJV5OTFMMBsgQItC2JkOuNdXkvBcm4dF/bm8RMEw3fsxjZW2jYtRO6cpAmf5q
         sSyIMWHEXbAifHlwO7KEHjAKZe6YgJmlD7BnqWrybEdZkIGnerBzYtnVJtqnIBtLGG
         R7JO0X8m9NJrrRaeVNTUl1yiljzP7s6KLr+GDYWDhoJnNMyegk57i/cx+HFuM+XOe2
         x2RBjQZRatjSg==
Date:   Tue, 27 Dec 2022 09:32:52 -0600
From:   Bjorn Andersson <andersson@kernel.org>
To:     Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
Cc:     Sarannya S <quic_sarannya@quicinc.com>, quic_bjorande@quicinc.com,
        swboyd@chromium.org, quic_clew@quicinc.com,
        mathieu.poirier@linaro.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        Deepak Kumar Singh <quic_deesin@quicinc.com>
Subject: Re: [PATCH V4 1/3] rpmsg: core: Add signal API support
Message-ID: <20221227153252.ufenietw5wgsk7kj@builder.lan>
References: <1670418258-11502-1-git-send-email-quic_sarannya@quicinc.com>
 <1670418258-11502-2-git-send-email-quic_sarannya@quicinc.com>
 <6ba10328-bc48-c953-49e7-29e079fb6406@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ba10328-bc48-c953-49e7-29e079fb6406@foss.st.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 21, 2022 at 05:12:22PM +0100, Arnaud POULIQUEN wrote:
> Hello,
> 
> On 12/7/22 14:04, Sarannya S wrote:
> > Some transports like Glink support the state notifications between
> > clients using flow control signals similar to serial protocol signals.
> > Local glink client drivers can send and receive flow control status
> > to glink clients running on remote processors.
> > 
> > Add APIs to support sending and receiving of flow control status by
> > rpmsg clients.
> > 
> > Signed-off-by: Deepak Kumar Singh <quic_deesin@quicinc.com>
> > Signed-off-by: Sarannya S <quic_sarannya@quicinc.com>
> > ---
> >  drivers/rpmsg/rpmsg_core.c     | 21 +++++++++++++++++++++
> >  drivers/rpmsg/rpmsg_internal.h |  2 ++
> >  include/linux/rpmsg.h          | 15 +++++++++++++++
> >  3 files changed, 38 insertions(+)
> > 
> > diff --git a/drivers/rpmsg/rpmsg_core.c b/drivers/rpmsg/rpmsg_core.c
> > index d6dde00e..77aeba0 100644
> > --- a/drivers/rpmsg/rpmsg_core.c
> > +++ b/drivers/rpmsg/rpmsg_core.c
> > @@ -331,6 +331,25 @@ int rpmsg_trysend_offchannel(struct rpmsg_endpoint *ept, u32 src, u32 dst,
> >  EXPORT_SYMBOL(rpmsg_trysend_offchannel);
> >  
> >  /**
> > + * rpmsg_set_flow_control() - sets/clears serial flow control signals
> > + * @ept:	the rpmsg endpoint
> > + * @enable:	enable or disable serial flow control
> 
> What does it mean "enable and disable serial flow control"?
> Do you speak about the flow control feature or the data flow itself?
> 

Good point, the purpose of the boolean is to "request throttling of the
incoming data flow".

> I guess it is the activation/deactivation of the data stream
> regarding Bjorn's comment in V1:
> 
> "I therefore asked Deepak to change it so the rpmsg api would contain a
> single "pause incoming data"/"resume incoming data" - given that this is
> a wish that we've seen in a number of discussions."
> 
> For me this is the software flow control:
> https://en.wikipedia.org/wiki/Software_flow_control
> 
> I would suggest not limiting the control only to activation/deactivation but to
> offer more flexibility in terms of services. replace the boolean by a bitmap
> would allow to extend it later.
> 
> For instance by introducing 2 definitions:
> 
> /* RPMSG pause transmission request:
>  * sent to the remote endpoint to request to suspend its transmission */
>  */
> #define RPMSG_FC_PT_REQ  (1 << 0)

enable = true

> 
> /* RPMSG resume transmission request
>  * sent to the remote endpoint to allow to resume its transmission
>  */
> #define RPMSG_FC_RT_REQ  (1 << 1)
> 

enable = false

> Then we could add (in a next step) some other flow controls such as
> /* RPMSG pause transmission information
>  * Sent to the remote endpoint to inform that no more data will be sent
>  * until the reception of RPMSG_FC_RT_INFO
>  */
> #define RPMSG_FC_PT_INFO  (1 << 16)
> #define RPMSG_FC_RT_INFO  (1 << 16)
> 

I presume you're looking for a usage pattern where the client would send
this to the remote and then the flow control mechanism would be used for
the remote end to request more data.

I find Deepak's (adjusted) proposal to be generic and to the point, and
your proposal builds unnecessary "flexibility" into this same mechanism.

If you have a rpmsg protocol where the client is expected to sit
waiting, and upon a request from the remote side send another piece of
data, why don't you just build this into the application protocol?  That
way your application would work over both transports with and without
flow control...


Perhaps I'm misunderstanding what you're asking for?

Regards,
Bjorn

> > + * @dst:	destination address of the endpoint
> 
> Thanks to have integrated this in your patch!
> 
> Regards,
> Arnaud
> 
> > + *
> > + * Return: 0 on success and an appropriate error value on failure.
> > + */
> > +int rpmsg_set_flow_control(struct rpmsg_endpoint *ept, bool enable, u32 dst)
> > +{
> > +	if (WARN_ON(!ept))
> > +		return -EINVAL;
> > +	if (!ept->ops->set_flow_control)
> > +		return -ENXIO;
> > +
> > +	return ept->ops->set_flow_control(ept, enable, dst);
> > +}
> > +EXPORT_SYMBOL(rpmsg_set_flow_control);
> > +
> > +/**
> >   * rpmsg_get_mtu() - get maximum transmission buffer size for sending message.
> >   * @ept: the rpmsg endpoint
> >   *
> > @@ -539,6 +558,8 @@ static int rpmsg_dev_probe(struct device *dev)
> >  
> >  		rpdev->ept = ept;
> >  		rpdev->src = ept->addr;
> > +
> > +		ept->flow_cb = rpdrv->flowcontrol;
> >  	}
> >  
> >  	err = rpdrv->probe(rpdev);
> > diff --git a/drivers/rpmsg/rpmsg_internal.h b/drivers/rpmsg/rpmsg_internal.h
> > index 39b646d..b6efd3e 100644
> > --- a/drivers/rpmsg/rpmsg_internal.h
> > +++ b/drivers/rpmsg/rpmsg_internal.h
> > @@ -55,6 +55,7 @@ struct rpmsg_device_ops {
> >   * @trysendto:		see @rpmsg_trysendto(), optional
> >   * @trysend_offchannel:	see @rpmsg_trysend_offchannel(), optional
> >   * @poll:		see @rpmsg_poll(), optional
> > + * @set_flow_control:	see @rpmsg_set_flow_control(), optional
> >   * @get_mtu:		see @rpmsg_get_mtu(), optional
> >   *
> >   * Indirection table for the operations that a rpmsg backend should implement.
> > @@ -75,6 +76,7 @@ struct rpmsg_endpoint_ops {
> >  			     void *data, int len);
> >  	__poll_t (*poll)(struct rpmsg_endpoint *ept, struct file *filp,
> >  			     poll_table *wait);
> > +	int (*set_flow_control)(struct rpmsg_endpoint *ept, bool enable, u32 dst);
> >  	ssize_t (*get_mtu)(struct rpmsg_endpoint *ept);
> >  };
> >  
> > diff --git a/include/linux/rpmsg.h b/include/linux/rpmsg.h
> > index 523c98b..a0e9d38 100644
> > --- a/include/linux/rpmsg.h
> > +++ b/include/linux/rpmsg.h
> > @@ -64,12 +64,14 @@ struct rpmsg_device {
> >  };
> >  
> >  typedef int (*rpmsg_rx_cb_t)(struct rpmsg_device *, void *, int, void *, u32);
> > +typedef int (*rpmsg_flowcontrol_cb_t)(struct rpmsg_device *, void *, bool);
> >  
> >  /**
> >   * struct rpmsg_endpoint - binds a local rpmsg address to its user
> >   * @rpdev: rpmsg channel device
> >   * @refcount: when this drops to zero, the ept is deallocated
> >   * @cb: rx callback handler
> > + * @flow_cb: remote flow control callback handler
> >   * @cb_lock: must be taken before accessing/changing @cb
> >   * @addr: local rpmsg address
> >   * @priv: private data for the driver's use
> > @@ -92,6 +94,7 @@ struct rpmsg_endpoint {
> >  	struct rpmsg_device *rpdev;
> >  	struct kref refcount;
> >  	rpmsg_rx_cb_t cb;
> > +	rpmsg_flowcontrol_cb_t flow_cb;
> >  	struct mutex cb_lock;
> >  	u32 addr;
> >  	void *priv;
> > @@ -106,6 +109,7 @@ struct rpmsg_endpoint {
> >   * @probe: invoked when a matching rpmsg channel (i.e. device) is found
> >   * @remove: invoked when the rpmsg channel is removed
> >   * @callback: invoked when an inbound message is received on the channel
> > + * @flowcontrol: invoked when remote side flow control status is received
> >   */
> >  struct rpmsg_driver {
> >  	struct device_driver drv;
> > @@ -113,6 +117,7 @@ struct rpmsg_driver {
> >  	int (*probe)(struct rpmsg_device *dev);
> >  	void (*remove)(struct rpmsg_device *dev);
> >  	int (*callback)(struct rpmsg_device *, void *, int, void *, u32);
> > +	int (*flowcontrol)(struct rpmsg_device *, void *, bool);
> >  };
> >  
> >  static inline u16 rpmsg16_to_cpu(struct rpmsg_device *rpdev, __rpmsg16 val)
> > @@ -192,6 +197,8 @@ __poll_t rpmsg_poll(struct rpmsg_endpoint *ept, struct file *filp,
> >  
> >  ssize_t rpmsg_get_mtu(struct rpmsg_endpoint *ept);
> >  
> > +int rpmsg_set_flow_control(struct rpmsg_endpoint *ept, bool enable, u32 dst);
> > +
> >  #else
> >  
> >  static inline int rpmsg_register_device_override(struct rpmsg_device *rpdev,
> > @@ -316,6 +323,14 @@ static inline ssize_t rpmsg_get_mtu(struct rpmsg_endpoint *ept)
> >  	return -ENXIO;
> >  }
> >  
> > +static inline int rpmsg_set_flow_control(struct rpmsg_endpoint *ept, bool enable, u32 dst)
> > +{
> > +	/* This shouldn't be possible */
> > +	WARN_ON(1);
> > +
> > +	return -ENXIO;
> > +}
> > +
> >  #endif /* IS_ENABLED(CONFIG_RPMSG) */
> >  
> >  /* use a macro to avoid include chaining to get THIS_MODULE */
