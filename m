Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E18ED617AA7
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 11:11:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231260AbiKCKLe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 06:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiKCKLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 06:11:31 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4C2E10F;
        Thu,  3 Nov 2022 03:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667470290; x=1699006290;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=zoRxbT7gH06wem0h6gHGOg636SfhzReDK31jhRkTDrg=;
  b=lH3j9Rxpik9UIJUE0MirkZoDXEFAPb0q9lC2CuCGFgL5lIf7OCyw0lKq
   izoS9HAeb3awwWXSoPgQpXhpp9W1e/As3fU28pr6qWFS6F76XlY/DmMov
   S7uYGcpoXWoPdwOL6hYwDT5PHhoJZpN3yksLbqx7cW4I7ET5WbM2cr0Wj
   9qXXakQpC8H7P34HZtvtK2bHnVAPDehFGE/NApWoaDmXZiSy6SfOY72sd
   Z70CC2FStZZ7SQ6FgfiXexkqw3nnGrhZ4xqYCTV5GKJIS1WHR2xNuQg5J
   S1m/RANhV9SQyltzaItJ3g7jeUI7dOs8KZxRtHuZPmDEfC55SafX2J827
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10519"; a="371742755"
X-IronPort-AV: E=Sophos;i="5.95,235,1661842800"; 
   d="scan'208";a="371742755"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2022 03:11:30 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10519"; a="963878894"
X-IronPort-AV: E=Sophos;i="5.95,235,1661842800"; 
   d="scan'208";a="963878894"
Received: from jsentis-mobl.ger.corp.intel.com ([10.251.215.225])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2022 03:11:28 -0700
Date:   Thu, 3 Nov 2022 12:11:26 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Greg KH <gregkh@linuxfoundation.org>
cc:     linux-serial <linux-serial@vger.kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] tty: Convert tty_buffer flags to bool
In-Reply-To: <Y2Mtricfx/HxiEHc@kroah.com>
Message-ID: <b9162bab-41aa-e24c-825-ec1a974b65e6@linux.intel.com>
References: <20221019105504.16800-1-ilpo.jarvinen@linux.intel.com> <Y2Mtricfx/HxiEHc@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1759914694-1667465065=:1757"
Content-ID: <7c284166-a236-ea2-1c1d-57c98c6bdec3@linux.intel.com>
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1759914694-1667465065=:1757
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <9310fe7a-df7d-df5d-5b8d-b02f6237282@linux.intel.com>

On Thu, 3 Nov 2022, Greg KH wrote:

> On Wed, Oct 19, 2022 at 01:55:03PM +0300, Ilpo Järvinen wrote:
> > The struct tty_buffer has flags which is only used for storing TTYB_NORMAL.
> > There is also a few quite confusing operations for checking the presense
> > of TTYB_NORMAL. Simplify things by converting flags to bool.
> > 
> > Despite the name remaining the same, the meaning of "flags" is altered
> > slightly by this change. Previously it referred to flags of the buffer
> > (only TTYB_NORMAL being used as a flag). After this change, flags tell
> > whether the buffer contains/should be allocated with flags array along
> > with character data array. It is much more suitable name that
> > TTYB_NORMAL was for this purpose, thus the name remains.
> > 
> > Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > ---
> > 
> > v2:
> > - Make it more obvious why flags is not renamed (both in kerneldoc
> >   comment and commit message).
> > 
> >  drivers/tty/tty_buffer.c   | 28 ++++++++++++++--------------
> >  include/linux/tty_buffer.h |  5 +----
> >  include/linux/tty_flip.h   |  4 ++--
> >  3 files changed, 17 insertions(+), 20 deletions(-)
> > 
> > diff --git a/drivers/tty/tty_buffer.c b/drivers/tty/tty_buffer.c
> > index 5e287dedce01..b408d830fcbc 100644
> > --- a/drivers/tty/tty_buffer.c
> > +++ b/drivers/tty/tty_buffer.c
> > @@ -107,7 +107,7 @@ static void tty_buffer_reset(struct tty_buffer *p, size_t size)
> >  	p->commit = 0;
> >  	p->lookahead = 0;
> >  	p->read = 0;
> > -	p->flags = 0;
> > +	p->flags = true;
> >  }
> >  
> >  /**
> > @@ -249,7 +249,7 @@ void tty_buffer_flush(struct tty_struct *tty, struct tty_ldisc *ld)
> >   * __tty_buffer_request_room	-	grow tty buffer if needed
> >   * @port: tty port
> >   * @size: size desired
> > - * @flags: buffer flags if new buffer allocated (default = 0)
> > + * @flags: buffer has to store flags along character data
> >   *
> >   * Make at least @size bytes of linear space available for the tty buffer.
> >   *
> > @@ -260,19 +260,19 @@ void tty_buffer_flush(struct tty_struct *tty, struct tty_ldisc *ld)
> >   * Returns: the size we managed to find.
> >   */
> >  static int __tty_buffer_request_room(struct tty_port *port, size_t size,
> > -				     int flags)
> > +				     bool flags)
> >  {
> >  	struct tty_bufhead *buf = &port->buf;
> >  	struct tty_buffer *b, *n;
> >  	int left, change;
> >  
> >  	b = buf->tail;
> > -	if (b->flags & TTYB_NORMAL)
> > +	if (!b->flags)
> >  		left = 2 * b->size - b->used;
> >  	else
> >  		left = b->size - b->used;
> >  
> > -	change = (b->flags & TTYB_NORMAL) && (~flags & TTYB_NORMAL);
> > +	change = !b->flags && flags;
> >  	if (change || left < size) {
> >  		/* This is the slow path - looking for new buffers to use */
> >  		n = tty_buffer_alloc(port, size);
> > @@ -300,7 +300,7 @@ static int __tty_buffer_request_room(struct tty_port *port, size_t size,
> >  
> >  int tty_buffer_request_room(struct tty_port *port, size_t size)
> >  {
> > -	return __tty_buffer_request_room(port, size, 0);
> > +	return __tty_buffer_request_room(port, size, true);
> 
> Did this logic just get inverted?
>
> Maybe it's the jet-lag, but this feels like it's not correct anymore.

As you can see, the old way is sooo confusing :-). I'll admit I stumbled 
myself with this same default thing first. It's even more confusing than 
the other places.

This check is true when flag bytes are present / required to be present:
	(~flags & TTYB_NORMAL)
It's very very confusing way to check such condition due to layered 
reverse logic.

With old code, the per character flag bytes won't be there in the buffer 
if TTYB_NORMAL is present. Thus, the old default of 0 means 
__tty_buffer_request_room will allocate room for those flag bytes.

If you think about it carefully, the old code passed 0. Therefore, ~0 & 
TTYB_NORMAL is going to be true. After my change true is passed and true 
matches to the original code.

So the logic was not inverted. I just cleared those layered reverse logic 
traps the original had which makes my patch look it's inverting things.

I really appreciate you took your time to find out this little detail
from it! This is far from a simple change because of how trappy the old
way of doing things is.

> Maybe a commet up above where you calculate "left" would make more sense
> as to what is going on?

Do you mean you want me to add a comment there? I don't see any 
pre-existing comments that you could be pointing me to.


Should I resubmit it since you probably dropped the patch?


While doing this cleanup, I realized there would likely be room for 
some improvements which would avoid allocing a new tty_buffer. I'll 
probably look into those at some point.


-- 
 i.
--8323329-1759914694-1667465065=:1757--
