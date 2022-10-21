Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76802606EE5
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 06:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbiJUEaM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 00:30:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiJUEaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 00:30:10 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44D99DFB5A
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 21:30:07 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id y4so1285090plb.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 21:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qeN7Lfsxe0BMdjuGOQPGjmwdPp+aU9MLz7UnO7jPyRU=;
        b=qgHLvR1Bi7cL80x1vMVhgNSiJUpfvR3qDqBa0aq98QWxlHBA3e1ocHwD5cgEUpyl8e
         fL/I3NruFEmXmFlhafWuYoS4XufTdEckStGFH7FB2fcO/yf02eKEmdGr/r0GBIaSHCJq
         PwFWilokdWwkh5pdvoEU4+7JQNMYhEDINRClRM6/AeD77zehvS2ZGmOLZ/o4hyjmX33d
         UZNeiS7wTxZUshzfOqcnH3lBEslAWWg1trLwJ4W66GvQdo3kwEgG7RBMs23dqJrnhOX8
         y3GAfB2+BLYPp7iuZsHZ6M2MoRyXZYdH1wsdNfKy6x9usN3IPA6i4Y3dD0qMu6gHEiPV
         5E8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qeN7Lfsxe0BMdjuGOQPGjmwdPp+aU9MLz7UnO7jPyRU=;
        b=cC0ODuBdEQakiXV0pvppOBnkkyLwISA/WXCOfcJKHNs5vhnIw0sP8ixRF13DrGIGvw
         +F1K67BBbzBk1LsRDdcXagQuYsRIDtIX6z7TshjKB8qkW7lhDkbf66QWR57YM3SLqGnj
         HkM9gk9LqV65nUfSCgtJo5XtYeJqRJZ8VLQ4UeTc2lWCL8P9AGweT7+dP7dw7Cr6trt3
         Sb26oKTnfFdxPHc6hp6JGbs/BJorY3lkb42PpHMDE1k8jISZL9VBhZqS0TyME4I9/gM4
         Nr7992G01T1wmJmOYe42d6HPomvARIef7qkV8VVxPxhrACVqzfsJLUcV3+epBZx2c1l0
         YLcQ==
X-Gm-Message-State: ACrzQf3Gpj1iJAzOJCfd+cKJfbu7H5+fGiDujdd6cmBNkuExj9mntvto
        RpFZWoS/OQWrrCoEu+PNass=
X-Google-Smtp-Source: AMsMyM7F1MabmfmF5DGzQwLpkh8LE+a/mIA1L1/aVyZobk6y/YxAImGth19ODSnHzDvuj+F0e8DI4w==
X-Received: by 2002:a17:90b:48c1:b0:20c:8edd:59a3 with SMTP id li1-20020a17090b48c100b0020c8edd59a3mr19677873pjb.222.1666326606447;
        Thu, 20 Oct 2022 21:30:06 -0700 (PDT)
Received: from gmail.com ([2601:600:8500:5f14:d627:c51e:516e:a105])
        by smtp.gmail.com with ESMTPSA id b30-20020aa78ede000000b0053e6eae9665sm14689443pfr.140.2022.10.20.21.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 21:30:05 -0700 (PDT)
Date:   Thu, 20 Oct 2022 21:30:03 -0700
From:   Andrei Vagin <avagin@gmail.com>
To:     Kees Cook <kees@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Christian Brauner <brauner@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Oskolkov <posk@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tycho Andersen <tycho@tycho.pizza>,
        Will Drewry <wad@chromium.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH 1/5] seccomp: don't use semaphore and wait_queue together
Message-ID: <Y1IgS3w/M1vnEC8D@gmail.com>
References: <20221020011048.156415-1-avagin@gmail.com>
 <20221020011048.156415-2-avagin@gmail.com>
 <F4707F74-22D4-402B-8FC6-992AEADDFD33@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <F4707F74-22D4-402B-8FC6-992AEADDFD33@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2022 at 10:10:44PM -0700, Kees Cook wrote:
> On October 19, 2022 6:10:44 PM PDT, Andrei Vagin <avagin@gmail.com> wrote:
> >Here is no reason to use two different primitives that do similar things.
> >
> >Signed-off-by: Andrei Vagin <avagin@gmail.com>
> >---
> > kernel/seccomp.c | 41 ++++++++++++++++++++++++++++++++++++-----
> > 1 file changed, 36 insertions(+), 5 deletions(-)
> 
> The commit log does not justify adding 29 lines to "do similar
> things". :) Can you describe the rationale and benefits here a bit
> more? I assume this to use the the future new wake_up helper?

The main reason is to use new wake_up helpers, but there are a few
other reasons:

* if we use two different ways, we always need to call them both. This
  patch fixes seccomp_notify_recv where we forgot to call wake_up_poll
  in the error path.

* If we use one primitive, we can control how many waiters are woken up
  for each request. Our goal is to wake up just one that will handle a
  request. Right now, wake_up_poll may wake up one waiter and
  up(&match->notif->request) may wake up one more.

I will update the commit message. Thanks!

> 
> 
> -- 
> Kees Cook
