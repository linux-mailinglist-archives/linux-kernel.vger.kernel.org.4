Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4A66614200
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 00:55:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbiJaXzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 19:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbiJaXzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 19:55:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08DB6120A7;
        Mon, 31 Oct 2022 16:55:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9BDAF614F6;
        Mon, 31 Oct 2022 23:55:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6A73C433B5;
        Mon, 31 Oct 2022 23:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667260505;
        bh=HPgNN1zmJTmeIiVEP7njqfVDkUvRcG88oE73X4TTkmM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LLJYee2ZUICFXcFrnth5y9tCuofh2vLIAwu5qlWwlVVgA61FkGkgTF1a2CkQx26Av
         7ruZwlD6BAN+OYYPiR64vdge4yUyf/DkeDgRiGorzdunZe73zlyzn7kgzIbBGzgrWz
         o/pSdqbUL8HsAQcTZUi2EkFuT91VRCLtfvBVD49CukRisxuzsXt89jbK1JNnKlLuji
         pwAcd8maGhudhFYdjs+SRAlGKjH+NlDkZT0YDtkWdIKWHYJyuAbPX1WrLnO8ayJJAK
         QqDavwg12dUV/YhSTl8zMDW2+vjvikuWvThBJLtK698tmAOcK3S+smycCcp08TE4tv
         VPuvP+GX23wVQ==
Date:   Tue, 1 Nov 2022 08:55:01 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Beau Belgrave <beaub@linux.microsoft.com>
Cc:     rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        dcook@linux.microsoft.com, alanau@linux.microsoft.com,
        linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] tracing/user_events: Use remote writes for
 event enablement
Message-Id: <20221101085501.443f2ac77bfb0803b91517c2@kernel.org>
In-Reply-To: <20221031164603.GB69@W11-BEAU-MD.localdomain>
References: <20221027224011.2075-1-beaub@linux.microsoft.com>
        <20221027224011.2075-2-beaub@linux.microsoft.com>
        <20221031234703.e275650899728e64cd3fb6c3@kernel.org>
        <20221031164603.GB69@W11-BEAU-MD.localdomain>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Oct 2022 09:46:03 -0700
Beau Belgrave <beaub@linux.microsoft.com> wrote:

> On Mon, Oct 31, 2022 at 11:47:03PM +0900, Masami Hiramatsu wrote:
> > Hi,
> > 
> > I have some comments.
> > 
> > On Thu, 27 Oct 2022 15:40:10 -0700
> > Beau Belgrave <beaub@linux.microsoft.com> wrote:
> > 
> > [...]
> > > @@ -1570,11 +1610,12 @@ static long user_reg_get(struct user_reg __user *ureg, struct user_reg *kreg)
> > >   * Registers a user_event on behalf of a user process.
> > >   */
> > >  static long user_events_ioctl_reg(struct user_event_file_info *info,
> > > -				  unsigned long uarg)
> > > +				  struct file *file, unsigned long uarg)
> > >  {
> > >  	struct user_reg __user *ureg = (struct user_reg __user *)uarg;
> > >  	struct user_reg reg;
> > >  	struct user_event *user;
> > > +	struct user_event_enabler *enabler;
> > >  	char *name;
> > >  	long ret;
> > >  
> > > @@ -1607,8 +1648,12 @@ static long user_events_ioctl_reg(struct user_event_file_info *info,
> > >  	if (ret < 0)
> > >  		return ret;
> > >  
> > > +	enabler = user_event_enabler_create(file, &reg, user);
> > > +
> > > +	if (!enabler)
> > 
> > Shouldn't we free the user_event if needed here?
> > (I found the similar memory leak pattern in the above failure case
> >  of the user_events_ref_add().)
> > 
> 
> user_events are shared across the entire group. They cannot be cleaned
> up until all references are gone. This is true both in this case and the
> in the user_events_ref_add() case.
> 
> The pattern is to register events in the group's hashtable, then add
> them to the local file ref array that is RCU protected. If the file ref
> cannot be allocated, etc. the refcount on user is decremented. If we
> cannot create an enabler, the refcount is still held until file release.

OK, when the ioctl returns, there should be 3 cases;

- Return success, a new(existing) user_event added.
- Return error, no new user_event added.
- Return error, a new user_event added but enabler is not initialized.

And in the last case, the new user_event will be released when user
closes the file. Could you comment it here?

> 
> If the event has already been added to the local file ref array, it is
> returned to prevent another reference.

I'm not sure this point. Did you mean returning an error to prevent
registering the same event again?


> 
> > > +		return -ENOMEM;
> > > +
> > >  	put_user((u32)ret, &ureg->write_index);
> > > -	put_user(user->index, &ureg->status_bit);
> > >  
> > >  	return 0;
> > >  }
> > [...]
> > > @@ -1849,7 +1863,6 @@ static int user_status_open(struct inode *node, struct file *file)
> > >  
> > >  static const struct file_operations user_status_fops = {
> > >  	.open = user_status_open,
> > > -	.mmap = user_status_mmap,
> > 
> > So, if this drops the mmap operation, can we drop the writable flag from
> > the status tracefs file?
> > 
> 
> Good catch, yes I'll remove this.

Thanks!

> 
> > static int create_user_tracefs(void)
> > {
> > [...]
> >         /* mmap with MAP_SHARED requires writable fd */
> >         emmap = tracefs_create_file("user_events_status", TRACE_MODE_WRITE,
> >                                     NULL, NULL, &user_status_fops);
> > 
> > Thank you,
> > 
> > -- 
> > Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Thanks,
> -Beau


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
