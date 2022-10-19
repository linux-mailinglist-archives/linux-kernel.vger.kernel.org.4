Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE134604CAF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 18:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbiJSQDs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 12:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbiJSQDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 12:03:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E78C415DB00
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 09:02:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B648961920
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 16:02:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6E2CC433D6
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 16:02:07 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="myrTXW/w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1666195326;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6H1wSHFGixXZH3xTM90S+PR85eEHKCs/O3DG2gkkP2s=;
        b=myrTXW/wUhth4KVHcVBn0UJP12pMzbYxFkulRANyp43qbbsAHc9rb0lH9g03WWU3kVystC
        TB74c+4yMMsHCrGJVPyWYT4chfKwXWV98QuztBJuy7FFg4rQrc3v5gJpahHvIUYK1EbAGJ
        S8BRuBhQsGGWibc+RvePy/Ta7Manrwk=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 4628ea59 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Wed, 19 Oct 2022 16:02:06 +0000 (UTC)
Received: by mail-ua1-f45.google.com with SMTP id f4so7492049uav.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 09:02:06 -0700 (PDT)
X-Gm-Message-State: ACrzQf0Hr0eyAvMxU/MSU3SMOi9GkgHjhNsIUYRKK9mjDx2QxNidztVJ
        bHZo/v/cWXszAVrph+umUnX4I7IEdkcP91NAiVM=
X-Google-Smtp-Source: AMsMyM7csx0cGEXMFscT4GgJB+Xq/gT1iHmNwZWMR+PTZXYCFulqIRiAvE/ubr2ZOrODsYYlz7A35TwbQy/457wGNPs=
X-Received: by 2002:ab0:5483:0:b0:3dc:40aa:84cf with SMTP id
 p3-20020ab05483000000b003dc40aa84cfmr2185549uaa.102.1666195325370; Wed, 19
 Oct 2022 09:02:05 -0700 (PDT)
MIME-Version: 1.0
References: <0029af41-bf24-9972-10ac-f52e1bdcbf08@linux.intel.com> <CAHmME9o25v0kZUV-7qEY=6XXAyOA7q0sG8gpQfxHgr3sSVdsWw@mail.gmail.com>
In-Reply-To: <CAHmME9o25v0kZUV-7qEY=6XXAyOA7q0sG8gpQfxHgr3sSVdsWw@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Wed, 19 Oct 2022 10:01:53 -0600
X-Gmail-Original-Message-ID: <CAHmME9oy8BWkt-ryWMgwaVCY7BUEhzYgttQ6DKTaMpjyBjuzkQ@mail.gmail.com>
Message-ID: <CAHmME9oy8BWkt-ryWMgwaVCY7BUEhzYgttQ6DKTaMpjyBjuzkQ@mail.gmail.com>
Subject: Re: signal: break out of wait loops on kthread_stop()
To:     Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org,
        "Intel-gfx@lists.freedesktop.org" <Intel-gfx@lists.freedesktop.org>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2022 at 10:00 AM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> On Wed, Oct 19, 2022 at 7:31 AM Tvrtko Ursulin
> <tvrtko.ursulin@linux.intel.com> wrote:
> >
> >
> > Hi,
> >
> > A question regarding a7c01fa93aeb ("signal: break out of wait loops on
> > kthread_stop()") if I may.
> >
> > We have a bunch code in i915, possibly limited to self tests (ie debug
> > builds) but still important for our flows, which spawn kernel threads
> > and exercises parts of the driver.
> >
> > Problem we are hitting with this patch is that code did not really need
> > to be signal aware until now. Well to say that more accurately - we were
> > able to test the code which is normally executed from userspace, so is
> > signal aware, but not worry about -ERESTARTSYS or -EINTR within the test
> > cases itself.
> >
> > For example threads which exercise an internal API for a while until the
> > parent calls kthread_stop. Now those tests can hit unexpected errors.
> >
> > Question is how to best approach working around this change. It is of
> > course technically possible to rework our code in more than one way,
> > although with some cost and impact already felt due reduced pass rates
> > in our automated test suites.
> >
> > Maybe an opt out kthread flag from this new behavior? Would that be
> > acceptable as a quick fix? Or any other comments?
>
> You can opt out by running `clear_tsk_thread_flag(current,
> TIF_NOTIFY_SIGNAL);` at the top of your kthread. But you should really
> fix your code instead. Were I your reviewer, I wouldn't merge code
> that took the lazy path like that. However, that should work, if you
> do opt for the quick fix.

Oh my, I haven't had my coffee yet and sent that too fast without
thinking straight. That certainly won't work as intended. Sorry for
the noise.

Jason
