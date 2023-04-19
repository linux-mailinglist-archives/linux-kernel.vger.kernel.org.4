Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 139366E82C9
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 22:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbjDSUeH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 16:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbjDSUeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 16:34:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 772A2C6;
        Wed, 19 Apr 2023 13:34:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 06CF463841;
        Wed, 19 Apr 2023 20:34:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4CCCC433EF;
        Wed, 19 Apr 2023 20:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681936442;
        bh=ix0y76lYGKzaW7u59USygYREAB96p5dnukcmGiYHcuQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EBTc7KE50r3e8zjLCjcSwnI441VXVJJ6EsqpdR5chXeHP50xob+PNFPW4lvgYig1X
         kMP/2nQM9a2LNLe717Jdf5oGkuRCQSMv5wwA6Kaee9q+PZ2FZCyEAeuvGZW2tlNXnZ
         Mi67sy1T0ZYC8DO4PHP9UYfayMtC5szg4q8kvzzM0GR3/qsOh4GS0vDY1GJuMwu5ff
         4S8UrC2cqZAW0ssWs9tBntm3g2Zb/khns6y80/ye23xS6Qmawuyh/Dhd2Dah58Nt0+
         uWsqjbpaZkeGTqIMPvyu+UbunSEJRNYQPylP7CZfJ9LZBjUpCHXRRDGsrSWwvFh+jP
         MvEdvdb7V2jjg==
Date:   Wed, 19 Apr 2023 13:37:32 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
Cc:     Sarannya S <quic_sarannya@quicinc.com>, quic_bjorande@quicinc.com,
        swboyd@chromium.org, quic_clew@quicinc.com,
        mathieu.poirier@linaro.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        Deepak Kumar Singh <quic_deesin@quicinc.com>
Subject: Re: [PATCH V5 1/3] rpmsg: core: Add signal API support
Message-ID: <20230419203732.nbu6jmbtzlstrzwd@ripper>
References: <1681807721-32343-1-git-send-email-quic_sarannya@quicinc.com>
 <1681807721-32343-2-git-send-email-quic_sarannya@quicinc.com>
 <0543735a-5f0c-bdf4-2a89-e94841bd4a68@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0543735a-5f0c-bdf4-2a89-e94841bd4a68@foss.st.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 19, 2023 at 11:53:49AM +0200, Arnaud POULIQUEN wrote:
> Hi,
> 
> 
> On 4/18/23 10:48, Sarannya S wrote:
> > From: Deepak Kumar Singh <quic_deesin@quicinc.com>
> > 
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
> >  2 files changed, 22 insertions(+)
> > 
> > diff --git a/drivers/rpmsg/rpmsg_core.c b/drivers/rpmsg/rpmsg_core.c
> > index a2207c0..86b4912 100644
> > --- a/drivers/rpmsg/rpmsg_core.c
> > +++ b/drivers/rpmsg/rpmsg_core.c
> > @@ -331,6 +331,24 @@ int rpmsg_trysend_offchannel(struct rpmsg_endpoint *ept, u32 src, u32 dst,
> >  EXPORT_SYMBOL(rpmsg_trysend_offchannel);
> >  
> >  /**
> > + * rpmsg_set_flow_control() - sets/clears serial flow control signals
> > + * @ept:	the rpmsg endpoint
> > + * @enable:	pause/resume incoming data flow
> > + *
> > + * Return: 0 on success and an appropriate error value on failure.
> > + */
> > +int rpmsg_set_flow_control(struct rpmsg_endpoint *ept, bool enable)
> 
> 
> Regression since V4[1]
> 
> In V4 version the function was:
> 
> int rpmsg_set_flow_control(struct rpmsg_endpoint *ept, bool enable, u32 dst)
> 
> Following comments on V3 [2]
> 
> Without dst parameter it is not compatible with the rpmsg_virtio backend
> 

You're right, and I missed that this was gone again. Thanks for pointing
it out. I've backed this series out of rpmsg-next again.

v6 seems to carry the correct argument again...

Regards,
Bjorn

> 
> [1]https://lkml.org/lkml/2022/12/7/506
> [2]https://www.spinics.net/lists/kernel/msg4573082.html
> 
> Regards
> Arnaud
> 
> > +{
> > +	if (WARN_ON(!ept))
> > +		return -EINVAL;
> > +	if (!ept->ops->set_flow_control)
> > +		return -ENXIO;
> > +
> > +	return ept->ops->set_flow_control(ept, enable);
> > +}
> > +EXPORT_SYMBOL(rpmsg_set_flow_control);
> > +
> > +/**
> >   * rpmsg_get_mtu() - get maximum transmission buffer size for sending message.
> >   * @ept: the rpmsg endpoint
> >   *
> > @@ -539,6 +557,8 @@ static int rpmsg_dev_probe(struct device *dev)
> >  
> >  		rpdev->ept = ept;
> >  		rpdev->src = ept->addr;
> > +
> > +		ept->flow_cb = rpdrv->flowcontrol;
> >  	}
> >  
> >  	err = rpdrv->probe(rpdev);
> > diff --git a/drivers/rpmsg/rpmsg_internal.h b/drivers/rpmsg/rpmsg_internal.h
> > index 39b646d..4fea45a 100644
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
> > +	int (*set_flow_control)(struct rpmsg_endpoint *ept, bool enable);
> >  	ssize_t (*get_mtu)(struct rpmsg_endpoint *ept);
> >  };
> >  
