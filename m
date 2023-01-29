Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA84680058
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 17:58:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233855AbjA2Q6W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 11:58:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbjA2Q6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 11:58:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99C4113DE7
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 08:58:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 29ECD60DE2
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 16:58:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E32BFC433EF;
        Sun, 29 Jan 2023 16:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675011498;
        bh=PvOzuQdTiGHZYzJ1kOLz5im5OphPSnCnWyZy5WkZVWw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aFs+9kA4AUiXBvfdajkL0q66NdENae4SEJTdZ7Mi6EWfxVyHc7QjU2p1GOQBDjwX+
         vt4LlEla2ZriqRuyum53LHJIgFtgsMvoCgQpdKNN1vVxHTt1YGcT+IuVGFWJ4k6Cn7
         QhlB5VcYRoPLVO8T6TpikYyG9r40SCCFdvf3c1GPjLY+OtPKbX+szRwUuGWNL9EhmS
         Y/yumwtmc3XOjXkcyC2b+FL6nSmBTb4Jwpi9/grhk+tz/GR4PCGwjvnQum4bscK97M
         6C3zl2I6T9+b0TD6dKwu4gZK/ZC36xFLGQ+yeWmzeolxO4pixZVL6q50EqqaP63bWu
         paap28owpJUaQ==
Date:   Sun, 29 Jan 2023 17:58:12 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Colin Walters <walters@verbum.org>
Cc:     Giuseppe Scrivano <gscrivan@redhat.com>,
        Aleksa Sarai <cyphar@cyphar.com>, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>, bristot@redhat.com,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Alexander Larsson <alexl@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, bmasney@redhat.com
Subject: Re: [PATCH v3 1/2] exec: add PR_HIDE_SELF_EXE prctl
Message-ID: <20230129165812.sqypj6nzam7o33lf@wittgenstein>
References: <20230120102512.3195094-1-gscrivan@redhat.com>
 <20230124015348.6rvic5g6ymsfvj4e@senku>
 <87h6wgcrv6.fsf@redhat.com>
 <20230125152847.wr443tggzb3no6mg@senku>
 <871qnibmqa.fsf@redhat.com>
 <ceac106b-ddac-4ee6-bfdf-1505cc699eaa@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ceac106b-ddac-4ee6-bfdf-1505cc699eaa@app.fastmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 29, 2023 at 08:59:32AM -0500, Colin Walters wrote:
> 
> 
> On Wed, Jan 25, 2023, at 11:30 AM, Giuseppe Scrivano wrote:
> > 
> > After reading some comments on the LWN.net article, I wonder if
> > PR_HIDE_SELF_EXE should apply to CAP_SYS_ADMIN in the initial user
> > namespace or if in this case root should keep the privilege to inspect
> > the binary of a process.  If a container runs with that many privileges
> > then it has already other ways to damage the host anyway.
> 
> Right, that's what I was trying to express with the "make it work the same as map_files".  Hiding the entry entirely even for initial-namespace-root (real root) seems like it's going to potentially confuse profiling/tracing/debugging tools for no good reason.

If this can be circumvented via CAP_SYS_ADMIN then this mitigation
becomes immediately way less interesting because the userspace
mitigation we came up with protects against CAP_SYS_ADMIN as well
without any regression risk. At which point this is only useful for some
privileged sandboxes at what point this isn't worth it.

I'm still looking at userspace codebases to ensure that this is a change
we can risk in general as this has the potential to prevent criu from
dumping such processes. I'll talk to them tomorrow anyway.
