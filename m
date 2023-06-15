Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99A9C731E07
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 18:42:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234969AbjFOQmT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 12:42:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234795AbjFOQls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 12:41:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC49126B6;
        Thu, 15 Jun 2023 09:41:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 512D561F13;
        Thu, 15 Jun 2023 16:41:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0243CC433C0;
        Thu, 15 Jun 2023 16:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686847306;
        bh=zpqZV7qKWaYVN1SN8K2/7XS2tI9XhoNZ6+FwQdXJYeQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nyUl+wQN394xAOxbMzIIggaasbVy6GEeHTeBXYY5JtdtuNTyET8h/4lnMT1rITN8A
         tppk0O8ic4w10FXqNjf1s3+j2NrS0GerHgqqyq43fgJQxPyscLqswRdIFNb7IAEqbj
         /CbJooEWJGZhwOkDamnMXqaw7jqPBZGO+qs+kYThK/sWynhyirHFPBbauDyuHKN/qz
         iHw884Opy6BFi0Iz+CMXiqjLdBC7FBkZlXFRCTdmLi0FhEFfWOp9xyvraUl3PHQfj5
         i8NSkMU+aL4TeG81/flLI+RzxPJF0CXfI6SPA4fHtanqj3NriAtbVBvpihAf8E+6YO
         eeS5f3A4yJAxA==
Date:   Thu, 15 Jun 2023 09:45:07 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
Cc:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Sarannya S <quic_sarannya@quicinc.com>, swboyd@chromium.org,
        quic_clew@quicinc.com, mathieu.poirier@linaro.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org,
        Deepak Kumar Singh <quic_deesin@quicinc.com>
Subject: Re: [PATCH V7 1/3] rpmsg: core: Add signal API support
Message-ID: <20230615164507.mu7fd22poamjth7p@ripper>
References: <1682160127-18103-1-git-send-email-quic_sarannya@quicinc.com>
 <1682160127-18103-2-git-send-email-quic_sarannya@quicinc.com>
 <20230614155453.dywcrntfjddxojfv@ripper>
 <6e51d6d8-cd3a-b0f2-c044-6282749aae89@foss.st.com>
 <20230615145039.GA3256591@hu-bjorande-lv.qualcomm.com>
 <4d89950d-0376-e355-c70b-d054776e83d4@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d89950d-0376-e355-c70b-d054776e83d4@foss.st.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 15, 2023 at 06:19:37PM +0200, Arnaud POULIQUEN wrote:
> 
> 
> On 6/15/23 16:50, Bjorn Andersson wrote:
> > On Thu, Jun 15, 2023 at 11:01:14AM +0200, Arnaud POULIQUEN wrote:
> >>
> >>
> >> On 6/14/23 17:54, Bjorn Andersson wrote:
> >>> On Sat, Apr 22, 2023 at 04:12:05PM +0530, Sarannya S wrote:
> >>>> From: Deepak Kumar Singh <quic_deesin@quicinc.com>
> >>>>
> >>>> Some transports like Glink support the state notifications between
> >>>> clients using flow control signals similar to serial protocol signals.
> >>>> Local glink client drivers can send and receive flow control status
> >>>> to glink clients running on remote processors.
> >>>>
> >>>> Add APIs to support sending and receiving of flow control status by
> >>>> rpmsg clients.
> >>>>
> >>>> Signed-off-by: Deepak Kumar Singh <quic_deesin@quicinc.com>
> >>>> Signed-off-by: Sarannya S <quic_sarannya@quicinc.com>
> >>>> ---
> >>>>  drivers/rpmsg/rpmsg_core.c     | 21 +++++++++++++++++++++
> >>>>  drivers/rpmsg/rpmsg_internal.h |  2 ++
> >>>>  include/linux/rpmsg.h          | 15 +++++++++++++++
> >>>>  3 files changed, 38 insertions(+)
> >>>>
> >>>> diff --git a/drivers/rpmsg/rpmsg_core.c b/drivers/rpmsg/rpmsg_core.c
> >>>> index a2207c0..e8bbe05 100644
> >>>> --- a/drivers/rpmsg/rpmsg_core.c
> >>>> +++ b/drivers/rpmsg/rpmsg_core.c
> >>>> @@ -331,6 +331,25 @@ int rpmsg_trysend_offchannel(struct rpmsg_endpoint *ept, u32 src, u32 dst,
> >>>>  EXPORT_SYMBOL(rpmsg_trysend_offchannel);
> >>>>  
> >>>>  /**
> >>>> + * rpmsg_set_flow_control() - sets/clears serial flow control signals
> >>>> + * @ept:	the rpmsg endpoint
> >>>> + * @enable:	pause/resume incoming data flow	
> >>>
> >>> As shown in the discussion, it's still not clear what true/false means.
> >>> Also, let's try to clarify that it's a request for the other side to do
> >>> something:
> >>>
> >>> * rpmsg_set_flow_control() - request remote to pause/resume transmission
> >>> * ...
> >>> * @enable: flow restricted
> >>> * ...
> >>>
> >>>
> >>> PS. There's a stray space at the end of the line.
> >>
> >> The notion of flow restricted seems to me also ambiguous. It does
> >> not specify if the stream is limited in term of bandwidth or stopped.
> >>
> >> What about using XON/XOFF as specified in software flow control[1]
> >>
> >> XOFF	Pause transmission
> >> XON	Resume transmission
> >>
> >> or simply pause/resume definitions
> >>
> > 
> > I agree, that's still ambiguous.
> > 
> > I was concerned about expressing it such that the reader would assume
> > that calling this means there will be no more data coming, but there
> > might be things in the queues etc. Expressing it in terms of the state
> > of transmission is clearer.
> > 
> > 
> > /*
> >  * rpmsg_set_flow_control() - request remote to pause/resume transmission
> >  ...
> >  * @enable: Pause transmission
> >  ...
> >  */
> > 
> > Does that sound okay and clear to you?
> 
> Much better! I still have a nitpicking point :)
> What about replacing @enable variable by @pause to align the variable with the
> usage?
>  /*
>   * rpmsg_set_flow_control() - request remote to pause/resume transmission
>   ...
>   * @pause: set to 1 to pause transmission, to 0 to resume the transmission

It's a boolean, so I think with your name change suggestion, together
with the function description, it should be clear enough what the two
states (true/false) means.

* @pause: Pause transmission

Thanks,
Bjorn
