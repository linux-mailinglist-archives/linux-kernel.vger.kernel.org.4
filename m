Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D3CE6CCC2C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 23:37:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbjC1Vhu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 17:37:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbjC1Vhs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 17:37:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C67292709;
        Tue, 28 Mar 2023 14:37:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5A08661987;
        Tue, 28 Mar 2023 21:37:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5671CC433D2;
        Tue, 28 Mar 2023 21:37:42 +0000 (UTC)
Date:   Tue, 28 Mar 2023 17:37:40 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Beau Belgrave <beaub@linux.microsoft.com>
Cc:     mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
        dcook@linux.microsoft.com, alanau@linux.microsoft.com,
        brauner@kernel.org, akpm@linux-foundation.org,
        ebiederm@xmission.com, keescook@chromium.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v9 05/11] tracing/user_events: Add ioctl for disabling
 addresses
Message-ID: <20230328173740.0595c953@gandalf.local.home>
In-Reply-To: <20230328173200.22ac45dc@gandalf.local.home>
References: <20230324223028.172-1-beaub@linux.microsoft.com>
        <20230324223028.172-6-beaub@linux.microsoft.com>
        <20230328173200.22ac45dc@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Mar 2023 17:32:00 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> > +static long user_events_ioctl_unreg(unsigned long uarg)
> > +{
> > +	struct user_unreg __user *ureg = (struct user_unreg __user *)uarg;
> > +	struct user_event_mm *mm = current->user_event_mm;
> > +	struct user_event_enabler *enabler, *next;
> > +	struct user_unreg reg;
> > +	long ret;
> > +
> > +	ret = user_unreg_get(ureg, &reg);
> > +
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (!mm)
> > +		return -ENOENT;
> > +
> > +	ret = -ENOENT;  
> 
> Probably should add:
> 
> 	if (reg.__reserved || reg.__reserved2)
> 		return -EINVAL;
> 
> here.

I finished my review.

Can to send a v10 out with this update, and also update all the structs to
have the fields tabbed out for easier reading.

Thanks!

-- Steve
