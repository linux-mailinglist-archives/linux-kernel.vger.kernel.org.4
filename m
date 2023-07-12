Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4654750320
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 11:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232443AbjGLJbg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 05:31:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233159AbjGLJbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 05:31:34 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79B3310CF
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 02:31:33 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1b8ad8383faso49646685ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 02:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1689154293; x=1691746293;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bQnl72R0spsZYcBoI4wCFzcXmEugK/BYxGs2uCdUKEk=;
        b=jmuQENJe+eL4GRUs6ocxCP5//2NiNoeXLcpRr+rdANFE3W/FMFVXeGBj/mQUViFiut
         NpH6Km2WNEowdr78Y3Fq0hFNAjlxdjlbZFhnU2sRxjqKg5oSNJkzJ/PtptCHubDfCEor
         gh4gPqiYmD/B/Pn/qnnIfAfwjSyFYYYdjMpSY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689154293; x=1691746293;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bQnl72R0spsZYcBoI4wCFzcXmEugK/BYxGs2uCdUKEk=;
        b=SFqrACz1vBfkL4x5eJN/DWG00/KD5PIhJ6HBaIiHi5xyVSQKZU8LCROmeOZfIGOAAl
         yZQ2FYkjJPxcyLGtkW1+zQ42/c/wVE9Omm3BIG2Ax2leWBTdSmJHxqEY57VS05n2oG1t
         CsNq1HZFWMilKhvhKdSroly5MwLYtotjBgkVmouMG+JMxZcuZ88j32geZmQz3zC9TYJz
         QquCczS7+RFE4xUVBIFaO/8b8i0c5/NBmNykN9ipeDYN8uPenr8TkDKUQ4BJyfbpMXlL
         ix4W4UFHYeKWGJEK+Lny0BRRamO/Vx2gUixk6Y9jPg0pWgOOwGJXwrQPHZsHfY+HrXcy
         5hDQ==
X-Gm-Message-State: ABy/qLbJBXv6NhQ1BYD6czpp1E1gUSFgm9GTrtzTraMK1ETMi1UAEPBo
        NIzQ/3YfCxDBcZLg/LooWAtTFA==
X-Google-Smtp-Source: APBJJlGQEPSQ6x++5zBEdx2u4t29KGDmk7exY4cofJfXSbp3xcJjqBiDnyC/tLbze6OW/U/pGrFfzg==
X-Received: by 2002:a17:902:b110:b0:1b6:76ee:190b with SMTP id q16-20020a170902b11000b001b676ee190bmr16031494plr.35.1689154292849;
        Wed, 12 Jul 2023 02:31:32 -0700 (PDT)
Received: from chromium.org (0.223.81.34.bc.googleusercontent.com. [34.81.223.0])
        by smtp.gmail.com with ESMTPSA id b14-20020a170902b60e00b001ac591b0500sm3478696pls.134.2023.07.12.02.31.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 02:31:32 -0700 (PDT)
Date:   Wed, 12 Jul 2023 09:31:29 +0000
From:   Tomasz Figa <tfiga@chromium.org>
To:     Nicolas Dufresne <nicolas@ndufresne.ca>
Cc:     Hsia-Jun Li <randy.li@synaptics.com>, linux-media@vger.kernel.org,
        ayaka@soulik.info, hans.verkuil@cisco.com, mchehab@kernel.org,
        laurent.pinchart@ideasonboard.com, hiroh@chromium.org,
        hverkuil@xs4all.nl, linux-kernel@vger.kernel.org,
        Sebastian Fricke <sebastian.fricke@collabora.com>
Subject: Re: [PATCH 1/2] [RESEND] media: v4l2-mem2mem: allow device run
 without buf
Message-ID: <20230712093129.pdcbvlxd5zphwr5m@chromium.org>
References: <20230704040044.681850-1-randy.li@synaptics.com>
 <20230704040044.681850-2-randy.li@synaptics.com>
 <20452e233a9a4b39b58139081d818d3b1454105a.camel@ndufresne.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20452e233a9a4b39b58139081d818d3b1454105a.camel@ndufresne.ca>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 07, 2023 at 03:14:23PM -0400, Nicolas Dufresne wrote:
> Hi Randy,
> 
> Le mardi 04 juillet 2023 à 12:00 +0800, Hsia-Jun Li a écrit :
> > From: Randy Li <ayaka@soulik.info>
> > 
> > For the decoder supports Dynamic Resolution Change,
> > we don't need to allocate any CAPTURE or graphics buffer
> > for them at inital CAPTURE setup step.
> > 
> > We need to make the device run or we can't get those
> > metadata.
> > 
> > Signed-off-by: Randy Li <ayaka@soulik.info>
> > ---
> >  drivers/media/v4l2-core/v4l2-mem2mem.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/media/v4l2-core/v4l2-mem2mem.c b/drivers/media/v4l2-core/v4l2-mem2mem.c
> > index 0cc30397fbad..c771aba42015 100644
> > --- a/drivers/media/v4l2-core/v4l2-mem2mem.c
> > +++ b/drivers/media/v4l2-core/v4l2-mem2mem.c
> > @@ -301,8 +301,9 @@ static void __v4l2_m2m_try_queue(struct v4l2_m2m_dev *m2m_dev,
> >  
> >  	dprintk("Trying to schedule a job for m2m_ctx: %p\n", m2m_ctx);
> >  
> > -	if (!m2m_ctx->out_q_ctx.q.streaming
> > -	    || !m2m_ctx->cap_q_ctx.q.streaming) {
> > +	if (!(m2m_ctx->out_q_ctx.q.streaming || m2m_ctx->out_q_ctx.buffered)
> > +	    || !(m2m_ctx->cap_q_ctx.q.streaming
> > +		 || m2m_ctx->cap_q_ctx.buffered)) {
> 
> I have a two atches with similar goals in my wave5 tree. It will be easier to
> upstream with an actual user, though, I'm probably a month or two away from
> submitting this driver again.
> 
> https://gitlab.collabora.com/chipsnmedia/kernel/-/commit/ac59eafd5076c4deb3bfe1fb85b3b776586ef3eb
> https://gitlab.collabora.com/chipsnmedia/kernel/-/commit/5de4fbe0abb20b8e8d862b654f93e3efeb1ef251
> 

While I'm not going to NAK this series or those 2 patches if you send
them, I'm not really convinced that adding more and more complexity to
the mem2mem helpers is a good idea, especially since all of those seem
to be only needed by stateful video decoders.

The mem2mem framework started as a set of helpers to eliminate boiler
plate from simple drivers that always get 1 CAPTURE and 1 OUTPUT buffer,
run 1 processing job on them and then return both of the to the userspace
and I think it should stay like this.

I think we're strongly in need of a stateful video decoder framework that
would actually address the exact problems that those have rather than
bending something that wasn't designed with them in mind to work around the
differences.

Best regards,
Tomasz

> Sebastien and I authored this without giving it much thought, but we believe
> this massively simplify our handling of DRC (dynamic resolution change).
> 
> The main difference, is that we added ignore_streaming to the ctx, so that
> drivers can opt-in the mode of operation. Thinking it would avoid any potential
> side effects in drivers that aren't prepared to that. We didn't want to tied it
> up to buffered, this is open to discussion of course, we do use buffered on both
> queues and use a slightly more advance job_ready function, that take into
> account our driver state.
> 
> In short, Sebastien and I agree this small change is the right direction, we
> simply have a different implementation. I can send it as RFC if one believe its
> would be useful now (even without a user).
> 
> >  		dprintk("Streaming needs to be on for both queues\n");
> >  		return;
> >  	}
> 
