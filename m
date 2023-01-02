Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E474765B2E9
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 14:52:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbjABNwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 08:52:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjABNwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 08:52:14 -0500
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC56764D0;
        Mon,  2 Jan 2023 05:52:13 -0800 (PST)
Received: by mail-ej1-f54.google.com with SMTP id vm8so59790201ejc.2;
        Mon, 02 Jan 2023 05:52:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R3W4+ksuOVHUCy1L+lhRp/DeX8Vdu8Jq70C3FaXeug8=;
        b=NI0bfNXXcEDv6d4qzR61+G93n7EHTma0EkyKAZTK4a/WH5Mr1AMUXGYHvdLwAbS6ID
         81WoKFaWqOMjGVZ/+Z55GuMxE8ZqtdooMnxvkoAaIwehrA1Z1jpvGPQOV2innqLZXbtl
         DsjLYsr3rENj9dUgTkFwksf9F+3KHAU5+acAxBVPksP+gSgppvtOboc0J+Qt2Svlj+gQ
         /vEQNbWqHwW6k2GZwnlWsxALNVXf0aoPqjwgm3NJ7KRc+v4dXnzPa2vVYnwY87Na6cys
         faTohqGdRfSbDiYx5wsxafRmT5wZe9G+7B+4kqAm6hyHVJRG6PxsBIRhgoInu+PHc26X
         +mIA==
X-Gm-Message-State: AFqh2kq9BseAMOtuL8+RhbFP+3gfiyvMJBJVflaxQb/Cz01BtLXbRmhM
        xgMQinG7reLosg3Fko1uDSeG8UkPD+tBGyo//wc=
X-Google-Smtp-Source: AMrXdXti9vVzhdz/YtR3PSNgmrerBqIbE0uHmN7mGNhLzAsA7ZYjRMQRfyLHyc9MLTwQNpTEVlHesw5iwmqBt638Up8=
X-Received: by 2002:a17:906:bce8:b0:7c4:fe2d:afd3 with SMTP id
 op8-20020a170906bce800b007c4fe2dafd3mr2556869ejb.390.1672667532437; Mon, 02
 Jan 2023 05:52:12 -0800 (PST)
MIME-Version: 1.0
References: <20221227063335.61474-1-zh.nvgt@gmail.com> <CAJZ5v0jmOMHHXvRnDcetDbh+0CySh5ddZJx1g3xTXPzCHokZRg@mail.gmail.com>
 <c052bf9dd21df44dfa3161bb94544559a41ab17e.camel@intel.com>
In-Reply-To: <c052bf9dd21df44dfa3161bb94544559a41ab17e.camel@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 2 Jan 2023 14:51:56 +0100
Message-ID: <CAJZ5v0g8Kd7DNUQ4xdx8h2DgxX09tU_o6tpEgiPT9ogM1QOgLg@mail.gmail.com>
Subject: Re: [PATCH] ACPI: custom_method: fix potential use-after-free issues
To:     "Zhang, Rui" <rui.zhang@intel.com>
Cc:     "zh.nvgt@gmail.com" <zh.nvgt@gmail.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 2, 2023 at 2:42 PM Zhang, Rui <rui.zhang@intel.com> wrote:
>
> On Fri, 2022-12-30 at 19:31 +0100, Rafael J. Wysocki wrote:
> > On Tue, Dec 27, 2022 at 7:34 AM Hang Zhang <zh.nvgt@gmail.com> wrote:
> > > cm_write() is the .write callback of the custom_method debugfs
> > > interface, it operates on a global pointer "buf" (e.g.,
> > > dereference,
> > > allocate, free, and nullification), the problem is that cm_write()
> > > is not protected by any locks, so concurrent invocations of it
> > > may cause use-after-free issues for "buf", e.g., one invocation
> > > may have just freed "buf" while being preempted before nullifying
> > > the pointer, then another invocation can dereference the now
> > > dangling
> > > "buf" pointer.
> > >
> > > Fix the issue by protecting the "buf" operations in cm_write() with
> > > the inode write lock. Note that the .llseek callback of the debugfs
> > > interface has been protected by the same lock, this patch basically
> > > introduces it to the .write callback as well.
> >
> > The problem is there, but the whole state is not protected from
> > concurrent use and the fix doesn't look sufficient to me (for
> > example,
> > a different writer may start writing into the file before the
> > previous
> > one has finished and the result will still be broken AFAICS).
> >
> > It looks like the file should be prevented from being opened by more
> > than one writer at a time.
> >
> > Or maybe it's time to drop this interface from the kernel altogether.
> >
> I still use this interface for debugging AML issues occasionally. Say,
> dumping the value of some key objects to see the AML code path.
>
> I'm not sure if there is any alternative way to do this, especially in
> remote debug case. (This can be done via DSDT override, but not all
> users have the knowledge of building a customized kernel)
>
> If this is not a problem, then I think it is safe to remove this
> interface because I suspect I am the only user of this interface.
> Because there are some special tricks I got from Erik, to make it fully
> work after some certain ACPICA release. And this is not documented in
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/firmware-guide/acpi/method-customizing.rst#n58
> Say, to generate the AML code of the method, we need to
> 1. compile the table with external declarations.
> 2. If step 1 compiles successfully, remove the external declarations
> from the table and compile with -f.

Interesting.

This basically means that ACPICA broke backwards compatibility with
this interface at one point and it's been necessary to work around
that manually since then and nobody cared to update the documentation.

Oh well.

Let me send a patch to remove it then and we'll see what happens.
