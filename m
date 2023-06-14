Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52294730398
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 17:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343726AbjFNPVR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 11:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343705AbjFNPVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 11:21:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41C29C5;
        Wed, 14 Jun 2023 08:21:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CACFD63A36;
        Wed, 14 Jun 2023 15:21:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BAC5C433C8;
        Wed, 14 Jun 2023 15:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686756073;
        bh=8YsXKUXaEWCUoIrtqUUwU4kG3YB5yIZs9T+odfm5bLo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qqSdCzUlAis9bugdmCSIkRmGN7RIr/2eCjqEZWMss/YKvu0k1/oQ4ZzV93bCYnVCq
         YzDEDO+2CjU4Jp+T2mPkRlL4G6i2GSRsfIZCB6fUmgkgL+hL8PIWjaqpLglX5/MmYn
         11B+t2kYm0V8tNMvuDgA15hoa/c7oSTTi16j54Y97HbRgILCSr4It3u07B5TRrGsjv
         B0pNIVKTs/ZMOfkC7HPhbdhvwh7Moa58yciHSaVUp2jPg960zAXLdnvuQwzMVO1YSy
         ZJ9ZMHMK8RfoPFHwibI4jwtEwdJYvCim0loenTx9C+jW+LiiePJO/WhKZrpalthcYN
         Firh4obe83YTg==
Date:   Wed, 14 Jun 2023 08:24:35 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
Cc:     Sarannya S <quic_sarannya@quicinc.com>, quic_bjorande@quicinc.com,
        swboyd@chromium.org, quic_clew@quicinc.com,
        mathieu.poirier@linaro.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        Deepak Kumar Singh <quic_deesin@quicinc.com>
Subject: Re: [PATCH V7 1/3] rpmsg: core: Add signal API support
Message-ID: <20230614152435.2quoctx6ouvw4ous@ripper>
References: <1682160127-18103-1-git-send-email-quic_sarannya@quicinc.com>
 <1682160127-18103-2-git-send-email-quic_sarannya@quicinc.com>
 <c44d8942-83e5-01ec-491b-bac1fb27de99@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c44d8942-83e5-01ec-491b-bac1fb27de99@foss.st.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 24, 2023 at 02:49:29PM +0200, Arnaud POULIQUEN wrote:
> Hello,
> 
> On 4/22/23 12:42, Sarannya S wrote:
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
> >  drivers/rpmsg/rpmsg_core.c     | 21 +++++++++++++++++++++
> >  drivers/rpmsg/rpmsg_internal.h |  2 ++
> >  include/linux/rpmsg.h          | 15 +++++++++++++++
> >  3 files changed, 38 insertions(+)
> > 
> > diff --git a/drivers/rpmsg/rpmsg_core.c b/drivers/rpmsg/rpmsg_core.c
> > index a2207c0..e8bbe05 100644
> > --- a/drivers/rpmsg/rpmsg_core.c
> > +++ b/drivers/rpmsg/rpmsg_core.c
> > @@ -331,6 +331,25 @@ int rpmsg_trysend_offchannel(struct rpmsg_endpoint *ept, u32 src, u32 dst,
> >  EXPORT_SYMBOL(rpmsg_trysend_offchannel);
> >  
> >  /**
> > + * rpmsg_set_flow_control() - sets/clears serial flow control signals
> > + * @ept:	the rpmsg endpoint
> > + * @enable:	pause/resume incoming data flow	
> > + * @dst:	destination address of the endpoint
> > + *
> > + * Return: 0 on success and an appropriate error value on failure.
> > + */
> > +int rpmsg_set_flow_control(struct rpmsg_endpoint *ept, bool enable, u32 dst)
> > +{
> > +	if (WARN_ON(!ept))
> > +		return -EINVAL;
> > +	if (!ept->ops->set_flow_control)
> > +		return -ENXIO;
> 
> Here we return an error if the backend does not implement the ops.
> But the set_flow_control ops is optional.
> Should we return 0 instead with a debug message?
> 

It seems reasonable to allow the software to react to the absence of
flow control support, so a debug message wouldn't help.

But advertising that more explicitly by returning something like
EOPNOTSUPP seems better.

Regards,
Bjorn
