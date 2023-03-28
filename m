Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B81D6CCC4D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 23:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbjC1Vxd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 17:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbjC1VxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 17:53:23 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7C59F2D54;
        Tue, 28 Mar 2023 14:53:22 -0700 (PDT)
Received: from W11-BEAU-MD.localdomain (unknown [76.135.27.212])
        by linux.microsoft.com (Postfix) with ESMTPSA id AB41220FDA92;
        Tue, 28 Mar 2023 14:53:21 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AB41220FDA92
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1680040401;
        bh=vEFB1z2QmcpHdHshSNcrN3p3s6kuh7H1QAAI42oT64U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U/RSAlulI4icbxrgBDeo+f/RSQbJtLtwI8T/AZ5uVvMsIPsQgysULDRy2l5h5IUr1
         ySZOm2wZc1lkwmuLkwVJv/P8542h2ykT9HDwxLUzuavcC5aa/ik+GzllUAJstDgXJZ
         8YRydOh/hsDz357idecBIBjOv6jYZaiZvb93kaIE=
Date:   Tue, 28 Mar 2023 14:53:15 -0700
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
        dcook@linux.microsoft.com, alanau@linux.microsoft.com,
        brauner@kernel.org, akpm@linux-foundation.org,
        ebiederm@xmission.com, keescook@chromium.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v9 05/11] tracing/user_events: Add ioctl for disabling
 addresses
Message-ID: <20230328215315.GA143@W11-BEAU-MD.localdomain>
References: <20230324223028.172-1-beaub@linux.microsoft.com>
 <20230324223028.172-6-beaub@linux.microsoft.com>
 <20230328173200.22ac45dc@gandalf.local.home>
 <20230328173740.0595c953@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230328173740.0595c953@gandalf.local.home>
X-Spam-Status: No, score=-17.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2023 at 05:37:40PM -0400, Steven Rostedt wrote:
> On Tue, 28 Mar 2023 17:32:00 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > > +static long user_events_ioctl_unreg(unsigned long uarg)
> > > +{
> > > +	struct user_unreg __user *ureg = (struct user_unreg __user *)uarg;
> > > +	struct user_event_mm *mm = current->user_event_mm;
> > > +	struct user_event_enabler *enabler, *next;
> > > +	struct user_unreg reg;
> > > +	long ret;
> > > +
> > > +	ret = user_unreg_get(ureg, &reg);
> > > +
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	if (!mm)
> > > +		return -ENOENT;
> > > +
> > > +	ret = -ENOENT;  
> > 
> > Probably should add:
> > 
> > 	if (reg.__reserved || reg.__reserved2)
> > 		return -EINVAL;
> > 
> > here.

Nice catch! Yes I'll add this.

> 
> I finished my review.
> 
> Can to send a v10 out with this update, and also update all the structs to
> have the fields tabbed out for easier reading.
> 

Yep will do, I will have the tabbed out changes in a isolated patch in
the v10 series.

Thanks,
-Beau

> Thanks!
> 
> -- Steve
