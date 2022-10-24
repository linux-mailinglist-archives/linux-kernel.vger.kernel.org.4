Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 936356099A2
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 07:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbiJXFHj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 01:07:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbiJXFHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 01:07:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3471E696C4
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 22:07:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D80FDB80E25
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 05:07:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2858FC433D6;
        Mon, 24 Oct 2022 05:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666588053;
        bh=E9gsmaix32fRhlDsYD3bZbwKOSx691rFhwaVWGAoDKc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YF8PguP4yT5kNWPIrTp4OawuxpJcbjxagVI0d7xVBF64POMoUhm6KhkcGVvJspWUb
         qb5n71mVswsmsyU/Fbc6hUjv6pDv1NN8bfEvpfK5cDM6JwenUsHFWDxWInwfE+z/kv
         rLGHAfAIHw9Sz5EKJmKiX1eZp3Iew02h5xbd7gnZFq38XfZ5XjYlfX056oPXjQWU0Z
         mXKf/oixeU1NsyxzsPFlaOnvuDLNaJZhiqOQqXxATlXSBtgM1LoFaIM1s+k3Oaw9Ga
         7X+7F6vAUYd+6LpgoOD11uwtcNDFKwYTX0b8f2c0/IFT5547+w3nkIkjQHdAAkghii
         rTheq6xIBoKDg==
Date:   Mon, 24 Oct 2022 14:07:30 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Pavan Kondeti <quic_pkondeti@quicinc.com>
Cc:     Mukesh Ojha <quic_mojha@quicinc.com>, <jaegeuk@kernel.org>,
        <chao@kernel.org>, <mhiramat@kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] f2fs: fix the assign logic of iocb
Message-Id: <20221024140730.904089a5736f9fe3d6893ccc@kernel.org>
In-Reply-To: <20221021050046.GA31858@hu-pkondeti-hyd.qualcomm.com>
References: <1666196277-27014-1-git-send-email-quic_mojha@quicinc.com>
        <20221021050046.GA31858@hu-pkondeti-hyd.qualcomm.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Oct 2022 10:30:46 +0530
Pavan Kondeti <quic_pkondeti@quicinc.com> wrote:

> Hi Mukesh,
> 
> On Wed, Oct 19, 2022 at 09:47:57PM +0530, Mukesh Ojha wrote:
> > commit 18ae8d12991b ("f2fs: show more DIO information in tracepoint")
> > introduces iocb field in 'f2fs_direct_IO_enter' trace event
> > And it only assigns the pointer and later it accesses its field
> > in trace print log.
> > 
> > Fix it by correcting data type and memcpy the content of iocb.
> > 
> > Fixes: 18ae8d12991b ("f2fs: show more DIO information in tracepoint")
> > Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
> > ---
> >  include/trace/events/f2fs.h | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> > 
> > diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
> > index c6b3724..7727ec9 100644
> > --- a/include/trace/events/f2fs.h
> > +++ b/include/trace/events/f2fs.h
> > @@ -940,7 +940,7 @@ TRACE_EVENT(f2fs_direct_IO_enter,
> >  	TP_STRUCT__entry(
> >  		__field(dev_t,	dev)
> >  		__field(ino_t,	ino)
> > -		__field(struct kiocb *,	iocb)
> > +		__field_struct(struct kiocb,	iocb)
> >  		__field(unsigned long,	len)
> >  		__field(int,	rw)
> >  	),
> > @@ -948,17 +948,17 @@ TRACE_EVENT(f2fs_direct_IO_enter,
> >  	TP_fast_assign(
> >  		__entry->dev	= inode->i_sb->s_dev;
> >  		__entry->ino	= inode->i_ino;
> > -		__entry->iocb	= iocb;
> > +		 memcpy(&__entry->iocb, iocb, sizeof(*iocb));
> >  		__entry->len	= len;
> >  		__entry->rw	= rw;
> >  	),
> >  
> 
> Why copy the whole structure (48 bytes)? cache the three members you
> need.

+1. If this only prints ki_pos, ki_flags and ki_ioprio, I recommend you
to save those 3 fields to the entry. It should not expose in-kernel
data structure because it can be changed.

Thank you,

> 
> Thanks,
> Pavan


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
