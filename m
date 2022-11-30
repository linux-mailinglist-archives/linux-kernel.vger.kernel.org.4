Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2176663DD20
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 19:24:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbiK3SYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 13:24:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbiK3SXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 13:23:51 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07A735EFBB
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 10:23:17 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id q21so12879144iod.4
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 10:23:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ONDnEc4ZIyy7Wu5ujEkS7Ktw1ahOUILUSTWpMfcxxQQ=;
        b=pwrErNWmob268zUOg+YwENLcK/qom0yQVqn8oY2WFSUEuf2Jr3URR0IWp2whEwJZkk
         5KZ4CEXzcxKpQjjjf/42ZDHqhN2no+ZYAkxQwSHqM9OQpTpo0oeCqJUiXNUh8ZJ61q8B
         eOidCFbsMG+aDhsPVK7+EuXZmSZ6UhEqPUhvGwG1FoDTV5ZmFQH+uAQR/iSF6knFx4Pj
         DExeZMpQpwV7deRWrycCjFLhsM0Ln5JILhRhBLQEJu19B40QANz5U3ApN3wgjQX5mUKl
         ZySiWygLU5ipXYFBX0Z6JX2Dl/D3V5jygajJaDvlrwd2DvywMpnfV0qaUp/9rwQQSsDF
         RL7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ONDnEc4ZIyy7Wu5ujEkS7Ktw1ahOUILUSTWpMfcxxQQ=;
        b=VZLHAoSukxeg4QsPRlhiMNvjG27Q86k80qRxFqQgGkfXjRO9qOXjss2l0lvFybjMZA
         XFjUgz7SRk1j7xea2/wQM+18gxfAYcRKYmltVFVfpQ3xczA9WKUskAaw4Pxn7/sd5xVX
         P+JygGPfB+nlD9dnf7zRguNelmb31E0diZfYZPRiuezav4Qp/3AhZLz1UYjgIOUh/6gG
         ezGRZtHhLVDaMaFIOfteOy605ct1RnowhLNMMwBOx0XxiywnCNr3gpn6waas5HTzqqsz
         IwTwVUGq6u1/+tkreGcHBU8FuRQdh4fV19/PsXzzk+y7jOzPxHfzAP9+fLWRKoXrayMM
         /gLQ==
X-Gm-Message-State: ANoB5pn+Uw24yVB2kfg6sQBjnT/ALe78fnrSjsYbHOP2e8+tDvNEDjhP
        TjO0d6HGQGJFEF/Bnk69oojRm2GLHzp044Qap5yOzMEhEaE=
X-Google-Smtp-Source: AA0mqf7P++wySGdQaSQLLnxnCcRG9+GZr61mVqsW+x7n6y+OZ20z6BFaJRCgtGj/vM5qP9xeSP1Kf2O90kWJDUuL2fw=
X-Received: by 2002:a02:c905:0:b0:374:e77e:d3d8 with SMTP id
 t5-20020a02c905000000b00374e77ed3d8mr29319867jao.103.1669832596394; Wed, 30
 Nov 2022 10:23:16 -0800 (PST)
MIME-Version: 1.0
References: <1669658575-21993-1-git-send-email-quic_sarannya@quicinc.com>
 <1669658575-21993-2-git-send-email-quic_sarannya@quicinc.com> <71e3425b-e598-a2ff-b684-dbf2f43bfa60@foss.st.com>
In-Reply-To: <71e3425b-e598-a2ff-b684-dbf2f43bfa60@foss.st.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Wed, 30 Nov 2022 11:23:05 -0700
Message-ID: <CANLsYkwX03vUpBN2MKOdtTHZbgV=7j1XSDv-e1hN8R_f=Ac0=w@mail.gmail.com>
Subject: Re: [PATCH V4 1/3] rpmsg: core: Add signal API support
To:     Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
Cc:     Sarannya S <quic_sarannya@quicinc.com>, quic_bjorande@quicinc.com,
        swboyd@chromium.org, quic_clew@quicinc.com,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org,
        Deepak Kumar Singh <quic_deesin@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Nov 2022 at 02:29, Arnaud POULIQUEN
<arnaud.pouliquen@foss.st.com> wrote:
>
> Hi Sarannya,
>
> On 11/28/22 19:02, Sarannya S wrote:
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
> >  drivers/rpmsg/rpmsg_core.c     | 20 ++++++++++++++++++++
> >  drivers/rpmsg/rpmsg_internal.h |  2 ++
> >  include/linux/rpmsg.h          | 15 +++++++++++++++
> >  3 files changed, 37 insertions(+)
> >
> > diff --git a/drivers/rpmsg/rpmsg_core.c b/drivers/rpmsg/rpmsg_core.c
> > index d6dde00e..0c5bf67 100644
> > --- a/drivers/rpmsg/rpmsg_core.c
> > +++ b/drivers/rpmsg/rpmsg_core.c
> > @@ -331,6 +331,24 @@ int rpmsg_trysend_offchannel(struct rpmsg_endpoint *ept, u32 src, u32 dst,
> >  EXPORT_SYMBOL(rpmsg_trysend_offchannel);
> >
> >  /**
> > + * rpmsg_set_flow_control() - sets/clears serial flow control signals
> > + * @ept:     the rpmsg endpoint
> > + * @enable:  enable or disable serial flow control
> > + *
> > + * Return: 0 on success and an appropriate error value on failure.
> > + */
> > +int rpmsg_set_flow_control(struct rpmsg_endpoint *ept, bool enable)
>
> Seems that you did not take into account comment in your V3 asking you to
> add the destination address of the endpoint as parameter

I will not review this patchset until Arnaud's comment is addressed or
a reason for the omission is provided.

>
> Regards,
> Arnaud
>
> > +{
> > +     if (WARN_ON(!ept))
> > +             return -EINVAL;
> > +     if (!ept->ops->set_flow_control)
> > +             return -ENXIO;
> > +
> > +     return ept->ops->set_flow_control(ept, enable);
> > +}
> > +EXPORT_SYMBOL(rpmsg_set_flow_control);
> > +
> > +/**
> >   * rpmsg_get_mtu() - get maximum transmission buffer size for sending message.
> >   * @ept: the rpmsg endpoint
> >   *
> > @@ -539,6 +557,8 @@ static int rpmsg_dev_probe(struct device *dev)
> >
> >               rpdev->ept = ept;
> >               rpdev->src = ept->addr;
> > +
> > +             ept->flow_cb = rpdrv->flowcontrol;
> >       }
> >
> >       err = rpdrv->probe(rpdev);
> > diff --git a/drivers/rpmsg/rpmsg_internal.h b/drivers/rpmsg/rpmsg_internal.h
> > index 39b646d..4fea45a 100644
> > --- a/drivers/rpmsg/rpmsg_internal.h
> > +++ b/drivers/rpmsg/rpmsg_internal.h
> > @@ -55,6 +55,7 @@ struct rpmsg_device_ops {
> >   * @trysendto:               see @rpmsg_trysendto(), optional
> >   * @trysend_offchannel:      see @rpmsg_trysend_offchannel(), optional
> >   * @poll:            see @rpmsg_poll(), optional
> > + * @set_flow_control:        see @rpmsg_set_flow_control(), optional
> >   * @get_mtu:         see @rpmsg_get_mtu(), optional
> >   *
> >   * Indirection table for the operations that a rpmsg backend should implement.
> > @@ -75,6 +76,7 @@ struct rpmsg_endpoint_ops {
> >                            void *data, int len);
> >       __poll_t (*poll)(struct rpmsg_endpoint *ept, struct file *filp,
> >                            poll_table *wait);
> > +     int (*set_flow_control)(struct rpmsg_endpoint *ept, bool enable);
> >       ssize_t (*get_mtu)(struct rpmsg_endpoint *ept);
> >  };
> >
> > diff --git a/include/linux/rpmsg.h b/include/linux/rpmsg.h
> > index 523c98b..cc7a917 100644
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
> >       struct rpmsg_device *rpdev;
> >       struct kref refcount;
> >       rpmsg_rx_cb_t cb;
> > +     rpmsg_flowcontrol_cb_t flow_cb;
> >       struct mutex cb_lock;
> >       u32 addr;
> >       void *priv;
> > @@ -106,6 +109,7 @@ struct rpmsg_endpoint {
> >   * @probe: invoked when a matching rpmsg channel (i.e. device) is found
> >   * @remove: invoked when the rpmsg channel is removed
> >   * @callback: invoked when an inbound message is received on the channel
> > + * @flowcontrol: invoked when remote side flow control status is received
> >   */
> >  struct rpmsg_driver {
> >       struct device_driver drv;
> > @@ -113,6 +117,7 @@ struct rpmsg_driver {
> >       int (*probe)(struct rpmsg_device *dev);
> >       void (*remove)(struct rpmsg_device *dev);
> >       int (*callback)(struct rpmsg_device *, void *, int, void *, u32);
> > +     int (*flowcontrol)(struct rpmsg_device *, void *, bool);
> >  };
> >
> >  static inline u16 rpmsg16_to_cpu(struct rpmsg_device *rpdev, __rpmsg16 val)
> > @@ -192,6 +197,8 @@ __poll_t rpmsg_poll(struct rpmsg_endpoint *ept, struct file *filp,
> >
> >  ssize_t rpmsg_get_mtu(struct rpmsg_endpoint *ept);
> >
> > +int rpmsg_set_flow_control(struct rpmsg_endpoint *ept, bool enable);
> > +
> >  #else
> >
> >  static inline int rpmsg_register_device_override(struct rpmsg_device *rpdev,
> > @@ -316,6 +323,14 @@ static inline ssize_t rpmsg_get_mtu(struct rpmsg_endpoint *ept)
> >       return -ENXIO;
> >  }
> >
> > +static inline int rpmsg_set_flow_control(struct rpmsg_endpoint *ept, bool enable)
> > +{
> > +     /* This shouldn't be possible */
> > +     WARN_ON(1);
> > +
> > +     return -ENXIO;
> > +}
> > +
> >  #endif /* IS_ENABLED(CONFIG_RPMSG) */
> >
> >  /* use a macro to avoid include chaining to get THIS_MODULE */
