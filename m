Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 713DB6CEC2D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 16:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbjC2Owi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 10:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbjC2Owg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 10:52:36 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB682CA
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 07:52:34 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id w9so64493813edc.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 07:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112; t=1680101553;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=l8Mqvm0nKUvf+W++zPjp5WnzzCK3tCnipop5FneNhZo=;
        b=IZrsd/EeSRA/8xG07wwhIk5QDqYCo2hkZ6V6YXWiKJhFkN+veTM2lYH2srjQ1t4Pqu
         guBPE8IQadmmW9YGskAXG0ekZqD94jF6lVL/45fHa6gpNpsKFR2i4IzXwJd2BE4VvlTS
         FfgMgdPow39X+yuC3ylw/5eO//h7xOjuAjcH9IkPFfJt1ml0dX7ZPB0k6tEtb8acPCBH
         N4BRh30oaIdgMHXnJj9GWFYjOejU8fHSlyIBo+3I2qT6I6tXtuqDnuK2x2Mw+/Y8W9zX
         K3enTh942dzMf729kx41+mDbAzjZ9X8sEfvvXdKbH7IPwNJZzQUn7pdF8e3az0LRXPaY
         sOaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680101553;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l8Mqvm0nKUvf+W++zPjp5WnzzCK3tCnipop5FneNhZo=;
        b=iCMh6LcpGt9FwFU81ml2yGt2dt8sfB6wxct9YyRx9ZJQyQAfNlXmS78q2V5ZbMqM+K
         5vh39tG26oA86e5KOo/xit0LvxXBEwpr2iTOB8ZN/s8/ERzxHmW6pOoyp3nm9hEdBuxQ
         rVgA3jv7RpG6x2ib3uULkL8e2x6T8ogU5orQxYKPQF6H/Xi+7LLtIK9o3cjVAgBFwHjU
         Z4ymMWEbQ0ny1l5z8FHpJwifMHmtP2hwrKLwVeRNn7vT5dFzPoeWNfYDK/eH3L6MXT19
         +JD/Glc+DBItizmAPUZ5zExwcyTO+DTROK3DZwAuEG8J2w8UV3XxOEXLOvf+LpUvPyg8
         VZZg==
X-Gm-Message-State: AAQBX9dS0PgNdxnNOou7QhoFr8MljL3S3TzA3QCg3CREbNZ3qHeIrkU/
        Uxgw2/9AOXq5QUbwSghAi7+58w==
X-Google-Smtp-Source: AKy350YvW30FqsEIh5FpPPH2tKfkVMNHSheu2oVTZjOlmUYRgzCUVnZBpr2qm/uznvLeDKmlfPJJQw==
X-Received: by 2002:a17:906:3118:b0:930:e495:b1cb with SMTP id 24-20020a170906311800b00930e495b1cbmr21614765ejx.75.1680101553341;
        Wed, 29 Mar 2023 07:52:33 -0700 (PDT)
Received: from localhost ([2620:10d:c092:400::5:e994])
        by smtp.gmail.com with ESMTPSA id x21-20020a50d615000000b004bb810e0b87sm17236293edi.39.2023.03.29.07.52.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 07:52:33 -0700 (PDT)
Date:   Wed, 29 Mar 2023 10:52:32 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Christian Brauner <brauner@kernel.org>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, gscrivan@redhat.com
Subject: Re: CLONE_INTO_CGROUP probably needs to call controller attach
 handlers
Message-ID: <ZCRQsAoe1lN1qCiB@cmpxchg.org>
References: <20230328153943.op62j3sw7qaixdsq@wittgenstein>
 <c3d9cf24-1c3a-cda4-5063-6b7d27e9116f@redhat.com>
 <5937b51b-164a-b6b3-532d-43b46f2d49a2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5937b51b-164a-b6b3-532d-43b46f2d49a2@redhat.com>
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2023 at 10:48:49PM -0400, Waiman Long wrote:
> On 3/28/23 21:30, Waiman Long wrote:
> > On 3/28/23 11:39, Christian Brauner wrote:
> > > Hey,
> > > 
> > > Giuseppe reported that the the affinity mask isn't updated when a
> > > process is spawned directly into the target cgroup via
> > > CLONE_INTO_CGROUP. However, migrating a process will cause the affinity
> > > mask to be updated (see the repro at [1].
> > > 
> > > I took a quick look and the issue seems to be that we don't call the
> > > various attach handlers during CLONE_INTO_CGROUP whereas we do for
> > > migration. So the solution seems to roughly be that we need to call the
> > > various attach handlers during CLONE_INTO_CGROUP as well when the
> > > parent's cgroups is different from the child cgroup. I think we need to
> > > call all of them, can, cancel and attach.
> > > 
> > > The plumbing here might be a bit intricate since the arguments that the
> > > fork handlers take are different from the attach handlers.
> > > 
> > > Christian
> > > 
> > > [1]: https://paste.centos.org/view/f434fa1a
> > > 
> > I saw that the current cgroup code already have the can_fork, fork and
> > cancel_fork callbacks. Unfortunately such callbacks are not defined for
> > cpuset yet. That is why the cpu affinity isn't correctly updated. I can
> > post a patch to add those callback functions to cpuset which should then
> > able to correctly address this issue.
> 
> Looking further into this issue, I am thinking that forking into a cgroup
> should be equivalent to write the child pid into the "cgroup.threads" file
> of the target cgroup. By taking this route, all the existing can_attach,
> attach and cancel_attach methods can be used. I believe the original fork
> method is for the limited use case of forking into the same cgroup. So right
> now, only the pids controller has the fork methods. Otherwise, we will have
> to modify a number of different controllers to add the necessary fork
> methods. They will be somewhat similar to the existing attach methods and so
> it will be a lot of duplication. What do you think about this idea?

That's what I thought at first too, but then I had some doubts.

The callback is called 'attach', but it's historically implemented
when moving an established task between two cgroups. Many controllers
use it to move state between groups (memcg, pids, cpuset). So in
practice it isn't the natural fit that its name would suggest, and it
would require reworking those controllers to handle both scenarios:
moving tasks between groups, and new tasks attaching to a cgroup.

Now I'm thinking it probably makes more sense to keep using attach for
moving between groups, and fork for being born into a cgroup. That's
what the pid controller does, and it handles CLONE_INTO_CGROUP fine.

There is naturally some overlap between the two operations. But it
seems cleaner to me to use common helpers for that, as opposed to
having both attach and fork callbacks handling forks.
