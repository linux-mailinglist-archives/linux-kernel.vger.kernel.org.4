Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C174F750378
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 11:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232346AbjGLJoh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 05:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231523AbjGLJof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 05:44:35 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD00DE75;
        Wed, 12 Jul 2023 02:44:31 -0700 (PDT)
Received: from localhost (89-26-75-29.dyn.cablelink.at [89.26.75.29])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sebastianfricke)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 4C90C6606FD8;
        Wed, 12 Jul 2023 10:44:30 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1689155070;
        bh=NeqBf93eW9H7R921kEMeAmkXYgrw5+cwFAwuLbxUDA0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E5AvITnQH9TmZAEcZsKVbC2jO2tNGDj+E5qSvQZdoTBM95a0KadYqAu9mMQK1Rz4q
         j0XICNYdY1Oifsnr3GshNz7I7nCmrHyRIqkFGYzeZkvYAyk5gh7/02tTlmcVhHyjWT
         WGVDYcHzleOx8bKLIbpH2L4ecr1kl5btQn5jPHX0HetLr2T7oSjrYub0IG2HR82Nla
         sGQo3tjcPKp+1LmQfxjQmZfp/1gsv/gr1QHGoEWu22qEqFx27JLnWHcdREOQzPCONb
         93OcuxoHSpSy+0Fp5SN9biUfjWak9nNZ/eBs2biHc3GkI1U05baYicGUoxdeEsycwA
         Ic4CFX9PgSX7Q==
Date:   Wed, 12 Jul 2023 11:44:26 +0200
From:   Sebastian Fricke <sebastian.fricke@collabora.com>
To:     Tomasz Figa <tfiga@chromium.org>
Cc:     Nicolas Dufresne <nicolas@ndufresne.ca>,
        Hsia-Jun Li <randy.li@synaptics.com>,
        linux-media@vger.kernel.org, ayaka@soulik.info,
        hans.verkuil@cisco.com, mchehab@kernel.org,
        laurent.pinchart@ideasonboard.com, hiroh@chromium.org,
        hverkuil@xs4all.nl, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] [RESEND] media: v4l2-mem2mem: allow device run
 without buf
Message-ID: <20230712094426.iot6f4rarlrtouvf@basti-XPS-13-9310>
References: <20230704040044.681850-1-randy.li@synaptics.com>
 <20230704040044.681850-2-randy.li@synaptics.com>
 <20452e233a9a4b39b58139081d818d3b1454105a.camel@ndufresne.ca>
 <20230712093129.pdcbvlxd5zphwr5m@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230712093129.pdcbvlxd5zphwr5m@chromium.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Tomasz,

On 12.07.2023 09:31, Tomasz Figa wrote:
>On Fri, Jul 07, 2023 at 03:14:23PM -0400, Nicolas Dufresne wrote:
>> Hi Randy,
>>
>> Le mardi 04 juillet 2023 à 12:00 +0800, Hsia-Jun Li a écrit :
>> > From: Randy Li <ayaka@soulik.info>
>> >
>> > For the decoder supports Dynamic Resolution Change,
>> > we don't need to allocate any CAPTURE or graphics buffer
>> > for them at inital CAPTURE setup step.
>> >
>> > We need to make the device run or we can't get those
>> > metadata.
>> >
>> > Signed-off-by: Randy Li <ayaka@soulik.info>
>> > ---
>> >  drivers/media/v4l2-core/v4l2-mem2mem.c | 5 +++--
>> >  1 file changed, 3 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/drivers/media/v4l2-core/v4l2-mem2mem.c b/drivers/media/v4l2-core/v4l2-mem2mem.c
>> > index 0cc30397fbad..c771aba42015 100644
>> > --- a/drivers/media/v4l2-core/v4l2-mem2mem.c
>> > +++ b/drivers/media/v4l2-core/v4l2-mem2mem.c
>> > @@ -301,8 +301,9 @@ static void __v4l2_m2m_try_queue(struct v4l2_m2m_dev *m2m_dev,
>> >
>> >  	dprintk("Trying to schedule a job for m2m_ctx: %p\n", m2m_ctx);
>> >
>> > -	if (!m2m_ctx->out_q_ctx.q.streaming
>> > -	    || !m2m_ctx->cap_q_ctx.q.streaming) {
>> > +	if (!(m2m_ctx->out_q_ctx.q.streaming || m2m_ctx->out_q_ctx.buffered)
>> > +	    || !(m2m_ctx->cap_q_ctx.q.streaming
>> > +		 || m2m_ctx->cap_q_ctx.buffered)) {
>>
>> I have a two atches with similar goals in my wave5 tree. It will be easier to
>> upstream with an actual user, though, I'm probably a month or two away from
>> submitting this driver again.
>>
>> https://gitlab.collabora.com/chipsnmedia/kernel/-/commit/ac59eafd5076c4deb3bfe1fb85b3b776586ef3eb
>> https://gitlab.collabora.com/chipsnmedia/kernel/-/commit/5de4fbe0abb20b8e8d862b654f93e3efeb1ef251
>>
>
>While I'm not going to NAK this series or those 2 patches if you send
>them, I'm not really convinced that adding more and more complexity to
>the mem2mem helpers is a good idea, especially since all of those seem
>to be only needed by stateful video decoders.
>
>The mem2mem framework started as a set of helpers to eliminate boiler
>plate from simple drivers that always get 1 CAPTURE and 1 OUTPUT buffer,
>run 1 processing job on them and then return both of the to the userspace
>and I think it should stay like this.
>
>I think we're strongly in need of a stateful video decoder framework that
>would actually address the exact problems that those have rather than
>bending something that wasn't designed with them in mind to work around the
>differences.

Thanks for the feedback.

I have recently discussed how we could approach creating a framework for
the codecs side, with Hans Verkuil and Nicolas Dufresne.

The first step we would have to do is come up with a list of
requirements for that framework and expected future needs, maybe we can
start a public discussion on the mailing list to generate a list like
that.
But all in all this endeavor will probably require quite a bit of time
and effort, do you think we could modify M2M a bit for our use case and
then when we are in the process of creating the new framework, we could
maybe think about simplifying the M2M framework again?

>
>Best regards,
>Tomasz

Greetings,
Sebastian

>
>> Sebastien and I authored this without giving it much thought, but we believe
>> this massively simplify our handling of DRC (dynamic resolution change).
>>
>> The main difference, is that we added ignore_streaming to the ctx, so that
>> drivers can opt-in the mode of operation. Thinking it would avoid any potential
>> side effects in drivers that aren't prepared to that. We didn't want to tied it
>> up to buffered, this is open to discussion of course, we do use buffered on both
>> queues and use a slightly more advance job_ready function, that take into
>> account our driver state.
>>
>> In short, Sebastien and I agree this small change is the right direction, we
>> simply have a different implementation. I can send it as RFC if one believe its
>> would be useful now (even without a user).
>>
>> >  		dprintk("Streaming needs to be on for both queues\n");
>> >  		return;
>> >  	}
>>
