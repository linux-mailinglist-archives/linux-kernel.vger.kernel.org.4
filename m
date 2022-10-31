Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45143613B9C
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 17:46:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231501AbiJaQqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 12:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbiJaQqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 12:46:07 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 242071182B;
        Mon, 31 Oct 2022 09:46:06 -0700 (PDT)
Received: from W11-BEAU-MD.localdomain (unknown [76.135.50.127])
        by linux.microsoft.com (Postfix) with ESMTPSA id 8944120B929F;
        Mon, 31 Oct 2022 09:46:05 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8944120B929F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1667234765;
        bh=nUof/meKu6oBnnf2OhPd3CRLta0VqYWxYJHb9SqWoyw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pNoZGwVU1vBBBs46vUkhFcf/mgI+qdXI5D/I8kpXVGgGsRFDZXAyPqI7WGJDP3x5N
         Pg/W669OBJSJ7PfsfxT13kvYKPDMSkR6QqK3ml2tbmIvWaPyRpkAUswUoCmPIAZ/9v
         QC+5LpOHNVVtpt9bGMN9DTgBHb6esopGIdcQzJ/k=
Date:   Mon, 31 Oct 2022 09:46:03 -0700
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        dcook@linux.microsoft.com, alanau@linux.microsoft.com,
        linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] tracing/user_events: Use remote writes for event
 enablement
Message-ID: <20221031164603.GB69@W11-BEAU-MD.localdomain>
References: <20221027224011.2075-1-beaub@linux.microsoft.com>
 <20221027224011.2075-2-beaub@linux.microsoft.com>
 <20221031234703.e275650899728e64cd3fb6c3@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221031234703.e275650899728e64cd3fb6c3@kernel.org>
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 31, 2022 at 11:47:03PM +0900, Masami Hiramatsu wrote:
> Hi,
> 
> I have some comments.
> 
> On Thu, 27 Oct 2022 15:40:10 -0700
> Beau Belgrave <beaub@linux.microsoft.com> wrote:
> 
> [...]
> > @@ -1570,11 +1610,12 @@ static long user_reg_get(struct user_reg __user *ureg, struct user_reg *kreg)
> >   * Registers a user_event on behalf of a user process.
> >   */
> >  static long user_events_ioctl_reg(struct user_event_file_info *info,
> > -				  unsigned long uarg)
> > +				  struct file *file, unsigned long uarg)
> >  {
> >  	struct user_reg __user *ureg = (struct user_reg __user *)uarg;
> >  	struct user_reg reg;
> >  	struct user_event *user;
> > +	struct user_event_enabler *enabler;
> >  	char *name;
> >  	long ret;
> >  
> > @@ -1607,8 +1648,12 @@ static long user_events_ioctl_reg(struct user_event_file_info *info,
> >  	if (ret < 0)
> >  		return ret;
> >  
> > +	enabler = user_event_enabler_create(file, &reg, user);
> > +
> > +	if (!enabler)
> 
> Shouldn't we free the user_event if needed here?
> (I found the similar memory leak pattern in the above failure case
>  of the user_events_ref_add().)
> 

user_events are shared across the entire group. They cannot be cleaned
up until all references are gone. This is true both in this case and the
in the user_events_ref_add() case.

The pattern is to register events in the group's hashtable, then add
them to the local file ref array that is RCU protected. If the file ref
cannot be allocated, etc. the refcount on user is decremented. If we
cannot create an enabler, the refcount is still held until file release.

If the event has already been added to the local file ref array, it is
returned to prevent another reference.

> > +		return -ENOMEM;
> > +
> >  	put_user((u32)ret, &ureg->write_index);
> > -	put_user(user->index, &ureg->status_bit);
> >  
> >  	return 0;
> >  }
> [...]
> > @@ -1849,7 +1863,6 @@ static int user_status_open(struct inode *node, struct file *file)
> >  
> >  static const struct file_operations user_status_fops = {
> >  	.open = user_status_open,
> > -	.mmap = user_status_mmap,
> 
> So, if this drops the mmap operation, can we drop the writable flag from
> the status tracefs file?
> 

Good catch, yes I'll remove this.

> static int create_user_tracefs(void)
> {
> [...]
>         /* mmap with MAP_SHARED requires writable fd */
>         emmap = tracefs_create_file("user_events_status", TRACE_MODE_WRITE,
>                                     NULL, NULL, &user_status_fops);
> 
> Thank you,
> 
> -- 
> Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks,
-Beau
