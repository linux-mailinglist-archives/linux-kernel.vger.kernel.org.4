Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A9C46AE970
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 18:24:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbjCGRYG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 12:24:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231435AbjCGRXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 12:23:41 -0500
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2E7EA0299
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 09:19:16 -0800 (PST)
Received: by mail-qt1-f174.google.com with SMTP id w23so15143661qtn.6
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 09:19:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678209556;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RWHxUkEMEjHfC5KMMRGPfYeHzW2mx9sYMRHJAK5eIog=;
        b=DVUAgsdwAPX6S2MeUlBzKwbYv0EKDveVW4OfOZygcXEaXdSa6FdWc8ZUYlphry8Z+D
         GSkbfSwEGwuWIUJB7Yd4aInSkLZTQvfbtrloqJzcDyqSrKck1BkL/J7oNbdyIvWepzcV
         unf3nJ1lWY+6XpFeQY4EwqgYJL+kGHAZ7uRMyx9q4CioOonLLRwpJDRi6E0ioMJqPxc6
         n1UUCbSiwWUKNK4GKw8hJw32XKYmcxXjoUyFd2QEowWRbhg/wYUCrBSAPlnUJGWtpcOy
         uAQhAPJWiSqaNN35qYR9/1zcwrkv7smO/kPOp4UrqthBVOk68mfIbro4sAbbEqayxkBA
         jwrw==
X-Gm-Message-State: AO0yUKXe5A5gys/06SI6XqwPjP0OvudW5ZRKUr+bFOff2lj8AL6OOY0l
        ru9pJNdL2pWP/ln57uDiHTY=
X-Google-Smtp-Source: AK7set/nIYEud6YdpwGeSbEm2RMY2Mcre8airJ+8nBEM47kdQm+1bgR4sjSzmn849TqVuwxU7aPkYw==
X-Received: by 2002:ac8:5d8a:0:b0:3bf:a1f0:4bf with SMTP id d10-20020ac85d8a000000b003bfa1f004bfmr25505792qtx.56.1678209555773;
        Tue, 07 Mar 2023 09:19:15 -0800 (PST)
Received: from maniforge ([2620:10d:c091:480::1:2c8e])
        by smtp.gmail.com with ESMTPSA id az31-20020a05620a171f00b007426ec97253sm9801144qkb.111.2023.03.07.09.19.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 09:19:15 -0800 (PST)
Date:   Tue, 7 Mar 2023 11:19:13 -0600
From:   David Vernet <void@manifault.com>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, rostedt@goodmis.org,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        vschneid@redhat.com, kernel-team@meta.com,
        torvalds@linux-foundation.org, ebiederm@xmission.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tasks: Extract rcu_users out of union
Message-ID: <20230307171913.GA4387@maniforge>
References: <20230215233033.889644-1-void@manifault.com>
 <20230216080459.GA5200@redhat.com>
 <Y+54c0YvXcMIFva4@maniforge>
 <20230217102521.GA27682@redhat.com>
 <Y/zWPoCjQ6gLSNGU@maniforge>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/zWPoCjQ6gLSNGU@maniforge>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 27, 2023 at 10:11:42AM -0600, David Vernet wrote:
> On Fri, Feb 17, 2023 at 11:25:21AM +0100, Oleg Nesterov wrote:
> > On 02/16, David Vernet wrote:
> > >
> > > On Thu, Feb 16, 2023 at 09:04:59AM +0100, Oleg Nesterov wrote:
> > > >
> > > > >    a task that's successfully looked
> > > > >    up in e.g. the pid_list with find_task_by_pid_ns(), can always have a
> > > > >    'usage' reference acquired on them, as it's guaranteed to be >
> > > > >    0 until after the next gp.
> > > >
> > > > Yes. So it seems you need another key-to-task_struct map with rcu-safe
> > > > lookup/get and thus the add() method needs inc_not_zero(task->rcu_users) ?
> > >
> > > Yes, exactly.
> > 
> > OK, in this case I agree, inc_not_zero(rcu_users) makes sense and thus we need
> > this patch.
> 
> Thanks again for taking a look.
> 
> > 
> > Just I was confused by the previous part of the changelog due to my bad English.
> 
> No worries at all -- the commit summary definitely could have been more
> clear.
> 
> Does anyone else have any thoughts? Is there anything else we need to do
> for this patch to land?

Sending a friendly ping on this now that the merge window has closed and
things have settled down a bit.

Thanks,
David
