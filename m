Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4BC4614F9F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 17:45:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbiKAQpm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 12:45:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbiKAQpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 12:45:38 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D301112A95;
        Tue,  1 Nov 2022 09:45:37 -0700 (PDT)
Received: from W11-BEAU-MD.localdomain (unknown [76.135.50.127])
        by linux.microsoft.com (Postfix) with ESMTPSA id 68D12205D3B7;
        Tue,  1 Nov 2022 09:45:37 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 68D12205D3B7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1667321137;
        bh=kZWPYfnjDKLxLTWrdqr9Ds1M/AA0Z2lq4cu8QG2GB3o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RU24pTU2zsUN6TCS6VUIxTURDOQkq00rL9zClZNHLplDmNxxirt0yEtZrMevsGfsg
         YbO1IUWOtmnHOptL1Edurn34xNYI6DV4K5l6vKNobd4y+ptGcdTPtqw93+3Yw1iyI9
         RggyvSY1IkAfVjOBCjWZ6PoBgkj951WthMs+0y64=
Date:   Tue, 1 Nov 2022 09:45:30 -0700
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        dcook@linux.microsoft.com, alanau@linux.microsoft.com,
        linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] tracing/user_events: Use remote writes for event
 enablement
Message-ID: <20221101164530.GA69@W11-BEAU-MD.localdomain>
References: <20221027224011.2075-1-beaub@linux.microsoft.com>
 <20221027224011.2075-2-beaub@linux.microsoft.com>
 <20221031234703.e275650899728e64cd3fb6c3@kernel.org>
 <20221031164603.GB69@W11-BEAU-MD.localdomain>
 <20221101085501.443f2ac77bfb0803b91517c2@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221101085501.443f2ac77bfb0803b91517c2@kernel.org>
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 01, 2022 at 08:55:01AM +0900, Masami Hiramatsu wrote:
> On Mon, 31 Oct 2022 09:46:03 -0700
> Beau Belgrave <beaub@linux.microsoft.com> wrote:
> 
> > On Mon, Oct 31, 2022 at 11:47:03PM +0900, Masami Hiramatsu wrote:
> > > Hi,
> > > 
> > > I have some comments.
> > > 
> > > On Thu, 27 Oct 2022 15:40:10 -0700
> > > Beau Belgrave <beaub@linux.microsoft.com> wrote:
> > > 
> > > [...]
> > > > @@ -1570,11 +1610,12 @@ static long user_reg_get(struct user_reg __user *ureg, struct user_reg *kreg)
> > > >   * Registers a user_event on behalf of a user process.
> > > >   */
> > > >  static long user_events_ioctl_reg(struct user_event_file_info *info,
> > > > -				  unsigned long uarg)
> > > > +				  struct file *file, unsigned long uarg)
> > > >  {
> > > >  	struct user_reg __user *ureg = (struct user_reg __user *)uarg;
> > > >  	struct user_reg reg;
> > > >  	struct user_event *user;
> > > > +	struct user_event_enabler *enabler;
> > > >  	char *name;
> > > >  	long ret;
> > > >  
> > > > @@ -1607,8 +1648,12 @@ static long user_events_ioctl_reg(struct user_event_file_info *info,
> > > >  	if (ret < 0)
> > > >  		return ret;
> > > >  
> > > > +	enabler = user_event_enabler_create(file, &reg, user);
> > > > +
> > > > +	if (!enabler)
> > > 
> > > Shouldn't we free the user_event if needed here?
> > > (I found the similar memory leak pattern in the above failure case
> > >  of the user_events_ref_add().)
> > > 
> > 
> > user_events are shared across the entire group. They cannot be cleaned
> > up until all references are gone. This is true both in this case and the
> > in the user_events_ref_add() case.
> > 
> > The pattern is to register events in the group's hashtable, then add
> > them to the local file ref array that is RCU protected. If the file ref
> > cannot be allocated, etc. the refcount on user is decremented. If we
> > cannot create an enabler, the refcount is still held until file release.
> 
> OK, when the ioctl returns, there should be 3 cases;
> 
> - Return success, a new(existing) user_event added.
> - Return error, no new user_event added.
> - Return error, a new user_event added but enabler is not initialized.
> 
> And in the last case, the new user_event will be released when user
> closes the file. Could you comment it here?
> 

Sure thing, I'll add it.

> > 
> > If the event has already been added to the local file ref array, it is
> > returned to prevent another reference.
> 
> I'm not sure this point. Did you mean returning an error to prevent
> registering the same event again?
> 

If a process uses the same fd and registers the same event multiple
times, then only 1 index is returned to the caller. If someone either
purposely or accidentally does this, the appropriate index will be
returned and we won't just keep allocating user_event objects.

However, in a threaded application, there may be situations where thread
A registers event E, and thread B registers event E as well. However,
they may pass different enable address locations. In this case you will
get 2 enablers for the single event. Right now the code does this all
the time, it does not do it only if the enable address differs.

I'm not sure how common this scenario is, but I think I should likely
check if the address is different or not before creating another enabler
in this case.

Thoughts?

> 
> > 
> > > > +		return -ENOMEM;
> > > > +
> > > >  	put_user((u32)ret, &ureg->write_index);
> > > > -	put_user(user->index, &ureg->status_bit);
> > > >  
> > > >  	return 0;
> > > >  }
> > > [...]
> > > > @@ -1849,7 +1863,6 @@ static int user_status_open(struct inode *node, struct file *file)
> > > >  
> > > >  static const struct file_operations user_status_fops = {
> > > >  	.open = user_status_open,
> > > > -	.mmap = user_status_mmap,
> > > 
> > > So, if this drops the mmap operation, can we drop the writable flag from
> > > the status tracefs file?
> > > 
> > 
> > Good catch, yes I'll remove this.
> 
> Thanks!
> 
> > 
> > > static int create_user_tracefs(void)
> > > {
> > > [...]
> > >         /* mmap with MAP_SHARED requires writable fd */
> > >         emmap = tracefs_create_file("user_events_status", TRACE_MODE_WRITE,
> > >                                     NULL, NULL, &user_status_fops);
> > > 
> > > Thank you,
> > > 
> > > -- 
> > > Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > Thanks,
> > -Beau
> 
> 
> -- 
> Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks,
-Beau
