Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6994861A05B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 19:55:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbiKDSy7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 14:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbiKDSyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 14:54:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCF9C51C3C;
        Fri,  4 Nov 2022 11:54:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 746BA622FF;
        Fri,  4 Nov 2022 18:54:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CF9DC433D6;
        Fri,  4 Nov 2022 18:54:52 +0000 (UTC)
Date:   Fri, 4 Nov 2022 14:54:50 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-nilfs@vger.kernel.org
Subject: Re: [RFC][PATCH v3 28/33] timers: fs/nilfs2: Use
 timer_shutdown_sync() before freeing timer
Message-ID: <20221104145450.7944d825@rorschach.local.home>
In-Reply-To: <CAKFNMomoVn3Zj5xaH6hjXHO+KXj983yZEue5Jx4wH+_m5NiJjA@mail.gmail.com>
References: <20221104054053.431922658@goodmis.org>
        <20221104054917.009383303@goodmis.org>
        <CAKFNMomoVn3Zj5xaH6hjXHO+KXj983yZEue5Jx4wH+_m5NiJjA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Nov 2022 15:57:04 +0900
Ryusuke Konishi <konishi.ryusuke@gmail.com> wrote:

> On Fri, Nov 4, 2022 at 2:48 PM Steven Rostedt wrote:
> >
> > From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> >
> > Before a timer is freed, timer_shutdown_sync() must be called.
> >
> > Link: https://lore.kernel.org/all/20220407161745.7d6754b3@gandalf.local.home/
> >
> > Cc: Ryusuke Konishi <konishi.ryusuke@gmail.com>
> > Cc: linux-nilfs@vger.kernel.org
> > Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> > ---
> >  fs/nilfs2/segment.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/fs/nilfs2/segment.c b/fs/nilfs2/segment.c
> > index b4cebad21b48..c50dc377da26 100644
> > --- a/fs/nilfs2/segment.c
> > +++ b/fs/nilfs2/segment.c
> > @@ -2752,7 +2752,7 @@ static void nilfs_segctor_destroy(struct nilfs_sc_info *sci)
> >
> >         down_write(&nilfs->ns_segctor_sem);
> >
> > -       del_timer_sync(&sci->sc_timer);
> > +       timer_shutdown_sync(&sci->sc_timer);
> >         kfree(sci);
> >  }
> >
> > --
> > 2.35.1  
> 
> Acked-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
> 
> This is the second time, but my Ack is not tagged, so I'll reply again
> just in case.
>

Thanks. I might have missed it, but I also changed the name, and wanted
to make sure everyone saw that ;-)

-- Steve
