Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4291865D9D8
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 17:30:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239936AbjADQaX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 11:30:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235307AbjADQaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 11:30:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE52233D74;
        Wed,  4 Jan 2023 08:30:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 768CA617A2;
        Wed,  4 Jan 2023 16:30:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 196D8C433D2;
        Wed,  4 Jan 2023 16:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672849802;
        bh=xnOCzG4x3mzE/Q5tiZn6gSjOTpXMSm3tByuio0JtZsQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WNw4LQFd8WODdQn37Z8ntM7xcTSztBu7D4rr9xbvK4N/4XXK87+jb7PER2jOHzBGd
         VCAPhkGMeRAqQ35G7yMm8xZX+Sgv1ebang2vEWPICgNJ/jepYfYlq8qAJ3SElKU0Eq
         l4HXDp/mutw/NHVkf64r9FMP/n6P7rMANFIz1ffQ3Yjb/xqHzMADz4mlLYpnxp6sdN
         o1fOiJEBkRKX/PxUVphN0joraHnl6mta9fBzo8WyPS/Tj9kMC+2POlKncBeAXYvcVq
         w39nDfdlW8YVRiRHfoH1sQOhYRuJ04RhsV+nUc3MVPtN2smwMc0SJB93mOaLj1P89n
         3sXKWUh33Z5rA==
Date:   Wed, 4 Jan 2023 10:30:00 -0600
From:   Bjorn Andersson <andersson@kernel.org>
To:     Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
Cc:     Sarannya S <quic_sarannya@quicinc.com>, quic_bjorande@quicinc.com,
        swboyd@chromium.org, quic_clew@quicinc.com,
        mathieu.poirier@linaro.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        Deepak Kumar Singh <quic_deesin@quicinc.com>
Subject: Re: [PATCH V4 1/3] rpmsg: core: Add signal API support
Message-ID: <20230104163000.hi6zehbbxpubeqfe@builder.lan>
References: <1670418258-11502-1-git-send-email-quic_sarannya@quicinc.com>
 <1670418258-11502-2-git-send-email-quic_sarannya@quicinc.com>
 <6ba10328-bc48-c953-49e7-29e079fb6406@foss.st.com>
 <20221227153252.ufenietw5wgsk7kj@builder.lan>
 <1cbcd57c-ba6d-390f-a28c-fa651d1d7262@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1cbcd57c-ba6d-390f-a28c-fa651d1d7262@foss.st.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 03, 2023 at 02:50:13PM +0100, Arnaud POULIQUEN wrote:
> Hello,
> 
> On 12/27/22 16:32, Bjorn Andersson wrote:
> > On Wed, Dec 21, 2022 at 05:12:22PM +0100, Arnaud POULIQUEN wrote:
> >> Hello,
> >>
> >> On 12/7/22 14:04, Sarannya S wrote:
> >>> Some transports like Glink support the state notifications between
> >>> clients using flow control signals similar to serial protocol signals.
> >>> Local glink client drivers can send and receive flow control status
> >>> to glink clients running on remote processors.
> >>>
> >>> Add APIs to support sending and receiving of flow control status by
> >>> rpmsg clients.
> >>>
> >>> Signed-off-by: Deepak Kumar Singh <quic_deesin@quicinc.com>
> >>> Signed-off-by: Sarannya S <quic_sarannya@quicinc.com>
> >>> ---
> >>>  drivers/rpmsg/rpmsg_core.c     | 21 +++++++++++++++++++++
> >>>  drivers/rpmsg/rpmsg_internal.h |  2 ++
> >>>  include/linux/rpmsg.h          | 15 +++++++++++++++
> >>>  3 files changed, 38 insertions(+)
> >>>
> >>> diff --git a/drivers/rpmsg/rpmsg_core.c b/drivers/rpmsg/rpmsg_core.c
> >>> index d6dde00e..77aeba0 100644
> >>> --- a/drivers/rpmsg/rpmsg_core.c
> >>> +++ b/drivers/rpmsg/rpmsg_core.c
> >>> @@ -331,6 +331,25 @@ int rpmsg_trysend_offchannel(struct rpmsg_endpoint *ept, u32 src, u32 dst,
> >>>  EXPORT_SYMBOL(rpmsg_trysend_offchannel);
> >>>  
> >>>  /**
> >>> + * rpmsg_set_flow_control() - sets/clears serial flow control signals
> >>> + * @ept:	the rpmsg endpoint
> >>> + * @enable:	enable or disable serial flow control
> >>
> >> What does it mean "enable and disable serial flow control"?
> >> Do you speak about the flow control feature or the data flow itself?
> >>
> > 
> > Good point, the purpose of the boolean is to "request throttling of the
> > incoming data flow".
> > 
> >> I guess it is the activation/deactivation of the data stream
> >> regarding Bjorn's comment in V1:
> >>
> >> "I therefore asked Deepak to change it so the rpmsg api would contain a
> >> single "pause incoming data"/"resume incoming data" - given that this is
> >> a wish that we've seen in a number of discussions."
> >>
> >> For me this is the software flow control:
> >> https://en.wikipedia.org/wiki/Software_flow_control
> >>
> >> I would suggest not limiting the control only to activation/deactivation but to
> >> offer more flexibility in terms of services. replace the boolean by a bitmap
> >> would allow to extend it later.
> >>
> >> For instance by introducing 2 definitions:
> >>
> >> /* RPMSG pause transmission request:
> >>  * sent to the remote endpoint to request to suspend its transmission */
> >>  */
> >> #define RPMSG_FC_PT_REQ  (1 << 0)
> > 
> > enable = true
> > 
> >>
> >> /* RPMSG resume transmission request
> >>  * sent to the remote endpoint to allow to resume its transmission
> >>  */
> >> #define RPMSG_FC_RT_REQ  (1 << 1)
> >>
> > 
> > enable = false
> 
> Do you mean that it should be only one definition? If yes you are right
> only one definition is sufficient for the pause/resume
> 

Yes, I envision this being used for cases such as rpmsg_char being able
to send a "I already have 1MB of data in my sk_buf_head queue, please
don't send me any more data for now".

> > 
> >> Then we could add (in a next step) some other flow controls such as
> >> /* RPMSG pause transmission information
> >>  * Sent to the remote endpoint to inform that no more data will be sent
> >>  * until the reception of RPMSG_FC_RT_INFO
> >>  */
> >> #define RPMSG_FC_PT_INFO  (1 << 16)
> >> #define RPMSG_FC_RT_INFO  (1 << 16)
> >>
> > 
> > I presume you're looking for a usage pattern where the client would send
> > this to the remote and then the flow control mechanism would be used for
> > the remote end to request more data.
> > 
> > I find Deepak's (adjusted) proposal to be generic and to the point, and
> > your proposal builds unnecessary "flexibility" into this same mechanism.
> > 
> > If you have a rpmsg protocol where the client is expected to sit
> > waiting, and upon a request from the remote side send another piece of
> > data, why don't you just build this into the application protocol?  That
> > way your application would work over both transports with and without
> > flow control...
> > 
> > 
> > Perhaps I'm misunderstanding what you're asking for?
> 
> With the RPMSG_FC_PT_INFO example I had in mind the possibility to implement PM
> runtime.
> 

Which device/part are you going to runtime PM suspend using this?

> But my main point here is to allow to extend the flow control in future.
> or instance an comment in OpenAMP PR part [1] was:
> 
> "ON/OFF info isn't enough in the advanced flow control since the additional info
> is required(e.g. the slide window, round trip delay, congestion etc..)."
> 
> [1]https://github.com/OpenAMP/open-amp/pull/394#discussion_r878363627

We don't have a way to apply back pressure today, so I have a hard time
imagining the use cases and the implementation of such advanced flow
control.

Reading your proposal again, I don't think that's flow control, that's a
mechanism for requesting notifications. Either way, the mechanism seems
orthogonal to rpmsg_set_flow_control() - even if they were implemented
using the same mechanism in the underlying transport.

> 
> Using a @enable boolean would imply to create new ops if someone want to extend
> the flow control (to keep legacy compatibility). Using a bit map for the
> parameter could ease a future extension.
> 

This is a kernel-internal API, a boolean "flow or now flow" is
sufficient for what Qualcomm is asking and the ioctl is the only new
external mechanism introduced.

I have no concerns extending or altering this as the use cases appear.

Regards,
Bjorn
